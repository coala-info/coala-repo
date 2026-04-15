---
name: msoma
description: msoma detects somatic mutations by applying a betabinomial null model to sequencing data from multiple tissues of the same individual. Use when user asks to generate base counts from BAM files, merge count files across tissues, or perform maximum likelihood estimation to identify somatic variants.
homepage: https://github.com/AkeyLab/mSOMA
metadata:
  docker_image: "quay.io/biocontainers/msoma:0.1.2--pyhdfd78af_0"
---

# msoma

## Overview

mSOMA is a specialized bioinformatics tool designed for detecting somatic mutations by leveraging data across multiple tissues from the same individual. It addresses the challenge of distinguishing true somatic variants from sequencing noise and low-frequency germline variants by employing a betabinomial null model. The workflow typically involves generating base counts from alignment files (BAM), merging these counts across tissues, and then performing Maximum Likelihood Estimation (MLE) to calculate p-values for potential somatic sites.

## Installation and Environment Setup

mSOMA is primarily distributed via Bioconda and requires a specific environment due to its dependencies on R and specialized tools like `bamutil`.

```bash
# Create and activate the environment
conda create --name msoma_env -c bioconda -c conda-forge msoma
conda activate msoma_env

# Verify all external and R dependencies are present
msoma check-dependencies
```

## Core Workflow

### 1. Generating Counts
The `count` command processes a BAM file to produce a site-specific count file. This step is resource-intensive and requires a reference FASTA and a BED file defining callable regions.

```bash
msoma count INPUT.bam \
  --fasta reference.fasta \
  --bed regions.bed \
  --seq-length 150 \
  --output sample.counts
```

**Expert Tips for Counting:**
*   **Filtering**: Use `-q` (min mapping quality) and `-b` (min base quality) to reduce noise. Defaults are usually sensible, but high-sensitivity projects may require tuning.
*   **Trimming**: Use `-n` to trim ends of reads if you suspect end-of-read artifacts.
*   **Indel Control**: Use `-I` to limit the number of indel bases allowed in a read to ensure alignment stability.

### 2. Merging Tissues
If you have multiple tissues for a single individual, merge their count files before statistical analysis.

```bash
msoma merge-counts -o merged.counts tissue1.counts tissue2.counts tissue3.counts
```

### 3. Statistical Analysis (MLE)
The `mle` command performs the actual mutation calling by fitting the betabinomial model. It generates p-values (`.pval`) and parameter estimates (`.abs`).

```bash
msoma mle merged.counts \
  --output results.pval \
  --ab parameters.abs \
  --min-depth 10
```

**Best Practices for MLE:**
*   **Depth Threshold**: The `-d` (min-depth) parameter is critical. Setting it too low introduces noise from poorly covered regions; setting it too high may miss valid somatic mutations in low-coverage tissues.
*   **Output Interpretation**: The `.pval` file contains the significance of each site being a somatic mutation. The `.abs` file provides the alpha and beta parameters of the betabinomial fit, which are useful for quality control of the model fit.

## Troubleshooting

*   **R Path Issues**: If mSOMA fails during the MLE step, ensure that your R environment is not picking up local/personal R libraries that conflict with the conda-installed versions.
*   **Architecture**: Ensure you are running on `linux` or `mac amd64`. The underlying `bamutil` dependency does not support ARM64 (Apple Silicon) natively without translation.



## Subcommands

| Command | Description |
|---------|-------------|
| msoma count | Count somatic mutations |
| msoma merge-counts | Merge count files into a single count file |
| msoma_mle | Calculate p-values for each locus using maximum likelihood estimation from counts file |

## Reference documentation
- [mSOMA GitHub Repository](./references/github_com_AkeyLab_mSOMA.md)
- [mSOMA README](./references/github_com_AkeyLab_mSOMA_blob_main_README.md)