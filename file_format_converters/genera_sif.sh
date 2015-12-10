#! /bin/bash

# This script take all .adj files for the output of parallel ARACNe and generate an sif file ready for Cytoscape for example
# Original idea from Aldo Josué Huerta Verde https://github.com/ajosuehv

# Usage:
# sh genera_sif.sh nombre.sif

# in this step tail reads the last line of each .adj (without comments) and save it in a variable
tail -q -n 1 *.adj > $1_all.adj

# AWK finish the work taking the first gene symbol and the corresponding target and mi value for make the sif file
awk '{for(i=2;i<=NF;i+=2) print $1"\t"$(i+1)"\t"$i}' $1_all.adj > $1_all.sif
