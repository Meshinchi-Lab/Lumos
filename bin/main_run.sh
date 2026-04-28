#!/bin/bash

set -eou pipefail 

PROJ_DIR=$HOME/Documents/quintarelli_c && source $PROJ_DIR/.bash_profile
source venv/bin/activate 

ID=$1
BAM=$2
OUTDIR=$3
# ID="2F_PBG06049"
# BAM="/home/prom/Documents/quintarelli_c/benini_f/2025-07-24_WGS_Nanopore_T-ALL/data/wgs_pod5_bam/bare_metal/20250806_1519_2F_PBG06049_61cbeb5f.aligned.bam"
# /data/quintarelli_c/lumos/lumos_out/$ID

# Clair3 model path
MODEL_PATH="/data/reference/CLAIR3"
MODEL_NAME=r1041_e82_400bps_sup_v520

### Tumor-Only Run
nextflow run tumorOnlyONT.nf \
    -output-dir "$OUTDIR/$ID" \
    --aligned_input true \
    --aligned_tumor $BAM \
    --aligned_tumor_bai $BAM.csi \
    --reference /data/reference/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna  \
    --vntr annot/human_GRCh38_no_alt_analysis_set.trf.bed   \
    --sv_pon annot/PoN_1000G_hg38_extended.tsv.gz   \
    --clair3_model ${MODEL_PATH}/models/${MODEL_NAME}  \
    --cpgs annot/hg38_cpg_cleaned.bed \
    -resume \
    -cache TRUE


    

