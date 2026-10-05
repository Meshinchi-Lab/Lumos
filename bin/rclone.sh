#!/bin/bash


set -euo pipefail

source ~/Documents/quintarelli_c/.bash_profile

#OUTPUT=/data/network/172.16.125.32-Storage-P24/quintarelli_c/benini_f/T-ALL/2026-03-05_WGS_Nanopore_T-ALL_Lumos
INPUTS=${1}
OUTDIR=${2}
DESTINATION=$OUTDIR


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

