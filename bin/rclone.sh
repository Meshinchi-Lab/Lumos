#!/bin/bash


set -eou pipefail

source ~/Documents/quintarelli_c/.bash_profile


INPUTS=${1}
OUTDIR=${2}
DESTINATION=$OUTDIR

# prom@PCA100514
# jennysmith@sp-alphafold-ws:
# DEST="/data/network/172.16.125.32-Storage-P24/quintarelli_c/benini_f/T-ALL/2025-09-29_WGS_Nanopore_basecalls_T-ALL"
# INPUT="/home/prom/Documents/quintarelli_c/benini_f/2025-09-29_WGS_Nanopore_basecalls_T-ALL"
# /data/network/172.16.125.32-Storage-P24/quintarelli_c/benini_f/T-ALL/
# DEFAULT="/mnt/network_drives/storage-promethion/quintarelli_c/benini_f"


echo "Syncing results from: $INPUTS"
echo "Writing to: $DESTINATION"

HOST=$(hostname)
if [[ $HOST == "PCA100514" ]]
then
    FILTER_LIST='bin/rclone_filter-list.txt'
else
    FILTER_LIST='/mnt/dell_extra/bioinformatics_resources/rclone_filter-list.txt'
fi

rclone copy \
    --filter-from $FILTER_LIST \
    --copy-links \
    --local-no-set-modtime \
    -cv \
    --exclude-if-present './git' \
    --progress \
    $INPUTS $DESTINATION/

