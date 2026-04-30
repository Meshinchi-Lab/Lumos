#!/bin/bash

set -eu pipefail

source venv/bin/activate
PROJ_BASE=$HOME/Documents/quintarelli_c && source $PROJ_BASE/.bash_profile


# define input dataset path
PROJ_DIR="$HOME/Documents/quintarelli_c/benini_f/Lumos"
DATA_DIR="$PROJ_DIR/data/wgs_pod5_bam/bare_metal"
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
 		# tmux new -s $ID bash -c "$PROJ_DIR/bin/main_run.sh $ID $BAM $OUTDIR"
		bash -c "$PROJ_DIR/bin/main_run.sh $ID $BAM $OUTDIR" &
	fi
done

echo "completed"



