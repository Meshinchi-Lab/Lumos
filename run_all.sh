#!/bin/bash

set -eu

# define input dataset path
BASE="$HOME/Documents/quintarelli_c/benini_f/2025-07-24_WGS_Nanopore_T-ALL"
DATA_DIR="$BASE/data/wgs_pod5_bam/bare_metal"
OUTDIR="/data/quintarelli_c/lumos/lumos_out"

BAMS=$(find -L $DATA_DIR -name "*.aligned.bam")


echo "$BAMS" | while read BAM
do    
	echo "processing $(basename $BAM)" 
	ID=$(basename $BAM | sed -E "s/.aligned.bam//")
	echo $ID
	if [[ ! -e $OUTDIR/$ID ]]
	then
 		$BASE/bin/main_run.sh "$ID" "$BAM" "$OUTDIR"
	fi
done


