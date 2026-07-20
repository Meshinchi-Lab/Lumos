#!/bin/bash

set -euo pipefail

# PROJ_BASE=$HOME/Documents/quintarelli_c && source $PROJ_BASE/.bash_profile
# source venv/bin/activate
PROJ_DIR="$HOME/Documents/quintarelli_c/benini_f/Lumos"

ID=$1
BAM=$2
OUTDIR=$3
REF="/data/reference/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna"

# Clair3 model path
MODEL_PATH="/data/reference/CLAIR3"
MODEL_NAME=r1041_e82_400bps_sup_v520

# limit the Nextflow launcher JVM. 
export NXF_OPTS="${NXF_OPTS:--Xms500m -Xmx2g}"

# Define workflow execution directory
NXF_DIR="/data/quintarelli_c/nxf_tmp/lumos/${ID}"
mkdir -p "$NXF_DIR"
cd "$NXF_DIR"

echo "Running pipeline in Nextflow directory $NXF_DIR"

### Tumor-Only Run
nextflow \
    -log "$PROJ_DIR/reports/${ID}_lumos_nextflow.log" \
    run Meshinchi-Lab/Lumos \
    -r tall \
    -work-dir "$NXF_DIR/work" \
    -output-dir "$OUTDIR/$ID" \
    --aligned_input true \
    --aligned_tumor "$BAM" \
    --aligned_tumor_bai "$BAM.csi" \
    --reference "$REF" \
    --vntr "$PROJ_DIR/annot/human_GRCh38_no_alt_analysis_set.trf.bed"   \
    --sv_pon "$PROJ_DIR/annot/PoN_1000G_hg38_extended.tsv.gz"   \
    --clair3_model "${MODEL_PATH}/models/${MODEL_NAME}"  \
    --cpgs "$PROJ_DIR/annot/hg38_cpg_cleaned.bed" \
    -with-report "$PROJ_DIR/reports/${ID}_lumos_report.html" \
    -with-trace "$PROJ_DIR/reports/${ID}_lumos_trace.txt" \
    -with-timeline "$PROJ_DIR/reports/${ID}_lumos_timeline.html" \
    -resume \
    -latest

echo "completed $ID"

    

