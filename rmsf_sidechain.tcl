###################################################################
###                 RMSF sidechain script analysis              ###
###################################################################
###      usage: vmd -dispdev text -e rmsf_sidechain.tcl         ###
###################################################################

#set the files names
set topfile "prot_noh.psf"
set trjfile "all_prot_noh.dcd"

#Upload the system
mol new $topfile type psf waitfor all
mol addfile $trjfile type dcd waitfor all

###################################################################
###                       RMSF analysis                         ###
###################################################################

#Set output file name
set outfile [open rmsf_prot_sidechain.dat w];

#Set all atoms, reference and selection of protein
set all [atomselect top "all"]
set reference [atomselect top "protein and backbone" frame 0]
set sel [atomselect top "protein and backbone"]

#Get the number of frames
set N [molinfo top get numframes]

#Do the alignment
for {set i 0} {$i < $N} {incr i} {
   #get the correct frame
   $sel frame $i
   $all frame $i
   set M [measure fit $sel $reference]
   #do the alignment
   $all move $M
}

#Set sidechain selection
set sc [atomselect top "protein and sidechain"]

# Atoms, resids and resnames
set atomlist [$sc list]
set residlist [$sc get resid]
set resnamelist [$sc get resname]

# Mapping residues atoms
array set resmap {}
array set resname_map {}
for {set i 0} {$i < [llength $atomlist]} {incr i} {
    set atomid [lindex $atomlist $i]
    set resid [lindex $residlist $i]
    set resname [lindex $resnamelist $i]
    lappend resmap($resid) $atomid
    set resname_map($resid) $resname
}

#Compute RMSF by atom index
array set rmsf_atom {}
foreach atomid $atomlist {
    set temp [atomselect top "index $atomid"]
    set rmsf [measure rmsf $temp first 0 last -1 step 1]
    set rmsf_atom($atomid) $rmsf
}

#output file title
puts $outfile "Resid Resname RMSF"

# Compute sidechain RMSF by averagin atom in residues
foreach resid [lsort -integer [array names resmap]] {
    set total 0.0
    set count 0
    foreach atomid $resmap($resid) {
        if {[info exists rmsf_atom($atomid)]} {
            set total [expr {$total + $rmsf_atom($atomid)}]
            incr count
        }
    }
    if {$count > 0} {
        set avg_rmsf [expr {$total / double($count)}]
        puts $outfile "$resid $resname_map($resid) $avg_rmsf"
    }
}

close $outfile

#exit
quit

###################################################################
###               contact:    jorgec@fq.edu.uy                  ###
###################################################################
