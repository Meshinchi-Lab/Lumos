#!/bin/bash

set -euo pipefail

source venv/bin/activate
PROJ_BASE=$HOME/Documents/quintarelli_c && source $PROJ_BASE/.bash_profile


# define input dataset path
PROJ_DIR="${PROJ_DIR:-$HOME/Documents/quintarelli_c/benini_f/Lumos}"
DATA_DIR="${DATA_DIR:-$PROJ_DIR/data/wgs_pod5_bam/bare_metal}"
OUTDIR="${OUTDIR:-/data/quintarelli_c/lumos/lumos_out}"
LOGDIR="${LOGDIR:-$PROJ_DIR/logs}"
mkdir -p "$LOGDIR"

# BAMS=$(find -L "$DATA_DIR" -name "*.aligned.bam")
BAMS=$(find -L "$DATA_DIR" -follow -name "bam_pass")

# Run one pipeline at a time. Each per-sample Nextflow workflow already requests
# up to 28 cpus / 128 GB for individual processes (see processes/processes.nf),
echo "$BAMS" | while IFS= read -r BAM
do
	[[ -z "$BAM" ]] && continue
	# ID=$(basename "$BAM" | sed -E "s/.aligned.bam//")
	ID=$(basename $(dirname $BAM ))


	LOG="$LOGDIR/${ID}_main_run.log"
	echo "processing $ID -> $LOG"
	# `|| true` so one sample's failure doesn't abort the whole batch under set -e.
	"$PROJ_DIR/bin/main_run.sh" "$ID" "$BAM" "$OUTDIR" >"$LOG" 2>&1 \
		|| echo "  $ID FAILED, see $LOG"
done

echo "completed"



