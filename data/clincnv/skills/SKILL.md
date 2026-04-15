---
name: clincnv
description: ClinCNV identifies copy number changes and somatic copy number alterations across germline, somatic, and trio clinical sequencing contexts. Use when user asks to call germline CNVs, detect somatic CNAs in tumor-normal pairs, or perform trio-based CNV analysis.
homepage: https://github.com/imgag/ClinCNV
metadata:
  docker_image: "quay.io/biocontainers/clincnv:1.19.1--hdfd78af_0"
---

# clincnv

## Overview
ClinCNV is a specialized tool for identifying copy number changes across various clinical sequencing contexts. It operates most effectively on cohorts of samples (recommended >40) sequenced with the same enrichment kit and depth, as it leverages the cohort to estimate variances. The tool processes coverage matrices and BED files to produce CNV calls and optional IGV visualization tracks. It supports human reference genomes hg19 (default) and hg38.

## Execution Patterns

### 1. Germline CNV Calling
For germline analysis, ClinCNV requires a coverage matrix of normal samples and an annotated BED file.
```bash
Rscript clinCNV.R \
  --bed /path/to/annotated_bed_file.bed \
  --normal /path/to/coverages_normal.cov \
  --out /path/to/output_folder \
  --folderWithScript $PWD
```

### 2. Somatic CNA Calling (Tumor-Normal Pairs)
Somatic detection requires both normal and tumor coverage matrices, plus a file defining the pairs.
```bash
Rscript clinCNV.R \
  --normal normal.cov \
  --tumor tumor.cov \
  --pair fileWithPairs.txt \
  --bed annotatedBedFile.bed \
  --out /path/to/output_folder \
  --folderWithScript $PWD
```
*Note: It is highly recommended to provide B-allele frequency (.tsv) files for somatic analysis to improve accuracy.*

### 3. Trio Calling
To analyze family trios, use the `--triosFile` parameter.
```bash
Rscript clinCNV.R \
  --bed annotatedBedFile.bed \
  --normal normal.cov \
  --triosFile trios_definition.txt \
  --out /path/to/output_folder \
  --folderWithScript $PWD
```
*The trios file should contain sample names for child, mother, and father, separated by commas.*

## Expert Tips and Best Practices

### Input Preparation
*   **BED Annotation**: The BED file must be annotated with GC-content (values 0 to 1) in the 4th column. ClinCNV cannot perform accurate GC-correction without this.
*   **Cohort Size**: While the tool runs with 10+ samples, 40+ samples are recommended for stable variance estimation.
*   **Pathing**: Always use absolute paths for `--bed`, `--normal`, and `--out` to avoid execution errors.

### Performance Optimization
*   **IGV Visualization**: Writing visualization tracks for IGV is computationally expensive and is the primary cause of high execution times. If you only need the calls, disable it:
    `--visulizationIGV` (Set to FALSE or omit if the version allows).
*   **Rcpp**: Ensure the `Rcpp` package is installed in the R environment to significantly speed up calculations.

### Genomic Contexts
*   **hg38 Support**: ClinCNV defaults to hg19. For hg38 data, you **must** include the `--hg38` flag.
*   **Non-Human Genomes**: For mouse or other diploid organisms, you must manually replace the `cytobands.txt` file with the appropriate species-specific file.

### Containerized Execution
If using the Apptainer/Singularity container:
```bash
apptainer exec -B /data_path:/mnt ClinCNV_v1.19.1.sif clinCNV.R [parameters]
```

## Reference documentation
- [ClinCNV GitHub Repository](./references/github_com_imgag_ClinCNV.md)
- [ClinCNV Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_clincnv_overview.md)