#!/bin/bash -l
#
#SBATCH --job-name="nh3form_li"
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --account=XXX # <- modify with your project name
#SBATCH --partition boost_usr_prod
#========================================
# load modules and run simulation
module purge
module load profile/chem-phys
#module load deepmd/2.2.6
#module load autoload lammps/20220623--openmpi--4.1.4--gcc--11.3.0-cuda-11.8
module load gmp/6.2.1 mpfr/4.1.0 mpc/1.2.1 gcc/11.3.0 cuda/11.8 deepmd/2.2.6 zlib/1.2.13--gcc--11.3.0 openmpi/4.1.4--gcc--11.3.0-cuda-11.8
module load lammps/2aug2023

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export NO_STOP_MESSAGE=1
export CRAY_CUDA_MPS=1
ulimit -s unlimited

mpath=/path/to/models
temp=600
seed1=$RANDOM
seed2=$RANDOM
# submitting file for deepmd simulation with lammps
mpirun lmp_gpu -in input.lammps \
	-v mpath $mpath \
	-v temp $temp \
	-v seed1 $seed1 \
	-v seed2 $seed2 1>> model_devi.log 2>> model_devi.log
