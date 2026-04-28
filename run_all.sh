#!/bin/bash

set -eu

source venv/bin/activate
PROJ_DIR=$HOME/Documents/quintarelli_c && source $PROJ_DIR/.bash_profile

# define input dataset path
BASE="$HOME/Documents/quintarelli_c/benini_f/Lumos"
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
		echo "processing $ID"
 		$BASE/bin/main_run.sh "$ID" "$BAM" "$OUTDIR"
		echo "completed $ID"
	fi
done

echo "completed"



