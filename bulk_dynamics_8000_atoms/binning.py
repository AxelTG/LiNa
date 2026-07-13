import pickle
import os
from ase.io import read, write
import numpy as np
from collections import defaultdict
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde

def compute_na_fraction(traj_file, bins=(10, 10, 10)):
    trajectory = read(traj_file, index='10::', format='lammps-dump-text')
    results = []

    for frame in trajectory:
        cell = frame.get_cell()
        positions_frac = frame.get_scaled_positions(wrap=True)
        symbols = frame.get_chemical_symbols()

        x_bins = np.linspace(0, 1, bins[0] + 1)
        y_bins = np.linspace(0, 1, bins[1] + 1)
        z_bins = np.linspace(0, 1, bins[2] + 1)

        bin_counts = defaultdict(lambda: {'Na': 0, 'Li': 0})

        for pos_frac, symbol in zip(positions_frac, symbols):
            x, y, z = pos_frac
            ix = np.searchsorted(x_bins, x, side='right') - 1
            iy = np.searchsorted(y_bins, y, side='right') - 1
            iz = np.searchsorted(z_bins, z, side='right') - 1

            if 0 <= ix < bins[0] and 0 <= iy < bins[1] and 0 <= iz < bins[2]:
                if symbol in ('Na', 'Li'):
                    bin_counts[(ix, iy, iz)][symbol] += 1

        frame_data = []
        for (ix, iy, iz), counts in bin_counts.items():
            center_frac = np.array([
                (x_bins[ix] + x_bins[ix + 1]) / 2,
                (y_bins[iy] + y_bins[iy + 1]) / 2,
                (z_bins[iz] + z_bins[iz + 1]) / 2
            ])
            center_cart = center_frac @ cell

            na = counts['Na']
            li = counts['Li']
            total = na + li

            if total > 0:
                fraction_na = na / total
            else:
                #print(total)
                fraction_na = 0

            frame_data.append((center_cart.tolist(), fraction_na))

        results.append(frame_data)

    return results


for T in [400,420,440,460,480,500,520,540,560,580,600,700,800,900]:
    results = compute_na_fraction(f"{T}/traj.lammps", bins=(6, 6, 6))
    with open(f'{T}/results.pkl', 'wb') as f:
        pickle.dump(results, f)
    all_fractions = [fraction_na for frame_data in results for _, fraction_na in frame_data]
    kde = gaussian_kde(all_fractions)
    x_vals = np.linspace(0, 1, 100)
    kde_vals = kde(x_vals)
    kde_vals /= np.max(kde_vals)
    plt.plot(x_vals, kde_vals, label=f"T = {T} K")

plt.xlabel("Na molar fraction")
plt.ylabel("Density")
plt.legend()
plt.vlines(0.36, 0, 1, colors='k', linestyles='--')
plt.tight_layout()
#plt.show()
plt.savefig("molar_fraction.png", dpi=300)
