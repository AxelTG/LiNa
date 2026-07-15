#adattato da: 

#https://github.com/harmsm/md-analysis-tools/blob/master/radial-distribution/radial-distribution.tcl
#https://www.ks.uiuc.edu/Research/vmd/mailing_list/vmd-l/att-8012/gofr-script.tcl

# usage: vmd -dispdev text -e gr.tcl

package require pbctools

# === Parametri ===
set traj_file "traj.lammps"
set traj_type "lammpstrj"

set outfile_name "rdf_lili.dat"

#set box_a 24.311008976374087
#set box_b 24.311008976374087
#set box_c 24.311008976374087

set sel1 "name Li"
set sel2 "name Li"

set first 0
set last -1        
set step 1
set rmax 24.0
set dr 0.1

# === load traj e crea le selezioni ===
mol new $traj_file type $traj_type waitfor all
set molID 0
pbc set [list $box_a $box_b $box_c] -allframes

set sel1_obj [atomselect $molID $sel1]
set sel2_obj [atomselect $molID $sel2]

# === Calcolo RDF ===
set gr [measure gofr $sel1_obj $sel2_obj first $first last $last step $step rmax $rmax delta $dr usepbc TRUE]

set outfile [open $outfile_name w]
puts $outfile "# r  g(r)  [error]"

set r_vals   [lindex $gr 0]
set g_vals   [lindex $gr 1]
set has_error [expr {[llength $gr] > 2}]
if {$has_error} {
    set err_vals [lindex $gr 2]
}

set n [llength $r_vals]
for {set i 0} {$i < $n} {incr i} {
    set r [lindex $r_vals $i]
    set g [lindex $g_vals $i]
    if {$has_error} {
        set err [lindex $err_vals $i]
        puts $outfile [format "%.8f %.8f %.8f" $r $g $err]
    } else {
        puts $outfile [format "%.8f %.8f" $r $g]
    }
}
close $outfile


set outfile_name "rdf_lina.dat"

set sel1 "name Li"
set sel2 "name Na"

set first 0
set last -1        
set step 1
set rmax 24.0
set dr 0.1

# === load traj e crea le selezioni ===
mol new $traj_file type $traj_type waitfor all
set molID 0
pbc set [list $box_a $box_b $box_c] -allframes

set sel1_obj [atomselect $molID $sel1]
set sel2_obj [atomselect $molID $sel2]

# === Calcolo RDF ===
set gr [measure gofr $sel1_obj $sel2_obj first $first last $last step $step rmax $rmax delta $dr usepbc TRUE]

set outfile [open $outfile_name w]
puts $outfile "# r  g(r)  [error]"

set r_vals   [lindex $gr 0]
set g_vals   [lindex $gr 1]
set has_error [expr {[llength $gr] > 2}]
if {$has_error} {
    set err_vals [lindex $gr 2]
}

set n [llength $r_vals]
for {set i 0} {$i < $n} {incr i} {
    set r [lindex $r_vals $i]
    set g [lindex $g_vals $i]
    if {$has_error} {
        set err [lindex $err_vals $i]
        puts $outfile [format "%.8f %.8f %.8f" $r $g $err]
    } else {
        puts $outfile [format "%.8f %.8f" $r $g]
    }
}
close $outfile


set outfile_name "rdf_nana.dat"

set sel1 "name Na"
set sel2 "name Na"

set first 0
set last -1        
set step 1
set rmax 24.0
set dr 0.1

# === load traj e crea le selezioni ===
mol new $traj_file type $traj_type waitfor all
set molID 0
pbc set [list $box_a $box_b $box_c] -allframes

set sel1_obj [atomselect $molID $sel1]
set sel2_obj [atomselect $molID $sel2]

# === Calcolo RDF ===
set gr [measure gofr $sel1_obj $sel2_obj first $first last $last step $step rmax $rmax delta $dr usepbc TRUE]

set outfile [open $outfile_name w]
puts $outfile "# r  g(r)  [error]"

set r_vals   [lindex $gr 0]
set g_vals   [lindex $gr 1]
set has_error [expr {[llength $gr] > 2}]
if {$has_error} {
    set err_vals [lindex $gr 2]
}

set n [llength $r_vals]
for {set i 0} {$i < $n} {incr i} {
    set r [lindex $r_vals $i]
    set g [lindex $g_vals $i]
    if {$has_error} {
        set err [lindex $err_vals $i]
        puts $outfile [format "%.8f %.8f %.8f" $r $g $err]
    } else {
        puts $outfile [format "%.8f %.8f" $r $g]
    }
}
close $outfile

set outfile_name "rdf_hna.dat"

set sel1 "name H"
set sel2 "name Na"

set first 0
set last -1        
set step 1
set rmax 24.0
set dr 0.1

# === load traj e crea le selezioni ===
mol new $traj_file type $traj_type waitfor all
set molID 0
pbc set [list $box_a $box_b $box_c] -allframes

set sel1_obj [atomselect $molID $sel1]
set sel2_obj [atomselect $molID $sel2]

# === Calcolo RDF ===
set gr [measure gofr $sel1_obj $sel2_obj first $first last $last step $step rmax $rmax delta $dr usepbc TRUE]

set outfile [open $outfile_name w]
puts $outfile "# r  g(r)  [error]"

set r_vals   [lindex $gr 0]
set g_vals   [lindex $gr 1]
set has_error [expr {[llength $gr] > 2}]
if {$has_error} {
    set err_vals [lindex $gr 2]
}

set n [llength $r_vals]
for {set i 0} {$i < $n} {incr i} {
    set r [lindex $r_vals $i]
    set g [lindex $g_vals $i]
    if {$has_error} {
        set err [lindex $err_vals $i]
        puts $outfile [format "%.8f %.8f %.8f" $r $g $err]
    } else {
        puts $outfile [format "%.8f %.8f" $r $g]
    }
}
close $outfile

set outfile_name "rdf_hli.dat"

set sel1 "name H"
set sel2 "name Li"

set first 0
set last -1        
set step 1
set rmax 24.0
set dr 0.1

# === load traj e crea le selezioni ===
mol new $traj_file type $traj_type waitfor all
set molID 0
pbc set [list $box_a $box_b $box_c] -allframes

set sel1_obj [atomselect $molID $sel1]
set sel2_obj [atomselect $molID $sel2]

# === Calcolo RDF ===
set gr [measure gofr $sel1_obj $sel2_obj first $first last $last step $step rmax $rmax delta $dr usepbc TRUE]

set outfile [open $outfile_name w]
puts $outfile "# r  g(r)  [error]"

set r_vals   [lindex $gr 0]
set g_vals   [lindex $gr 1]
set has_error [expr {[llength $gr] > 2}]
if {$has_error} {
    set err_vals [lindex $gr 2]
}

set n [llength $r_vals]
for {set i 0} {$i < $n} {incr i} {
    set r [lindex $r_vals $i]
    set g [lindex $g_vals $i]
    if {$has_error} {
        set err [lindex $err_vals $i]
        puts $outfile [format "%.8f %.8f %.8f" $r $g $err]
    } else {
        puts $outfile [format "%.8f %.8f" $r $g]
    }
}
close $outfile

#exit vmd
quit

