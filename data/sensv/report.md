# sensv CWL Generation Report

## sensv

### Tool Description
SENSV - Structural Variant caller

### Metadata
- **Docker Image**: quay.io/biocontainers/sensv:1.0.4--h43eeafb_2
- **Homepage**: https://github.com/HKU-BAL/SENSV
- **Package**: https://anaconda.org/channels/bioconda/packages/sensv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sensv/overview
- **Total Downloads**: 12.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HKU-BAL/SENSV
- **Stars**: N/A
### Original Help Text
```text
usage: sensv [-h] -sample_name SAMPLE_NAME -fastq FASTQ_FILE -output_prefix
             OUTPUT_PREFIX [-min_sv_size MIN_SV_SIZE]
             [-max_sv_size MAX_SV_SIZE] [-disable_dp_filter DISABLE_DP_FILTER]
             [-disable_gen_altref_bam DISABLE_GEN_ALTREF_BAM]
             [-target_sv_type TARGET_SV_TYPE] [-ref_ver REF_VER] -ref REF
             [-nprocs NPROCS]

SENSV

optional arguments:
  -h, --help            show this help message and exit
  -sample_name SAMPLE_NAME, --sample_name SAMPLE_NAME
                        sample name
  -fastq FASTQ_FILE, --fastq_file FASTQ_FILE
                        fastq file
  -output_prefix OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        output prefix
  -min_sv_size MIN_SV_SIZE, --min_sv_size MIN_SV_SIZE
                        min Sv Size
  -max_sv_size MAX_SV_SIZE, --max_sv_size MAX_SV_SIZE
                        max Sv Size
  -disable_dp_filter DISABLE_DP_FILTER, --disable_dp_filter DISABLE_DP_FILTER
                        disable DP filter
  -disable_gen_altref_bam DISABLE_GEN_ALTREF_BAM, --disable_gen_altref_bam DISABLE_GEN_ALTREF_BAM
                        disable gen altref bam
  -target_sv_type TARGET_SV_TYPE, --target_sv_type TARGET_SV_TYPE
                        target sv type
  -ref_ver REF_VER, --ref_ver REF_VER
                        reference version (default 37)
  -ref REF, --ref REF   reference fasta file absolute path
  -nprocs NPROCS, --nprocs NPROCS
                        max # of processes to run sensv
```

