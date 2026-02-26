---
name: msoma
description: "mSOMA identifies somatic mutations by analyzing sequencing data across multiple tissues using a betabinomial null model. Use when user asks to extract allele counts from BAM files, merge multi-tissue count data, or perform statistical inference to call somatic variants."
homepage: https://github.com/AkeyLab/mSOMA
---


# msoma

## Overview

mSOMA is a specialized bioinformatics tool designed to identify somatic mutations by analyzing sequencing data across multiple tissues from the same individual. It utilizes a betabinomial null model to account for the overdispersion often found in high-throughput sequencing data, providing a more accurate statistical basis for variant calling than standard binomial models. The tool follows a two-stage workflow: first, extracting allele counts from BAM files, and second, applying maximum likelihood estimation (MLE) to calculate p-values for potential somatic sites.

## Installation and Environment Setup

The recommended installation method is via Bioconda. mSOMA requires several external dependencies, including `samtools`, `bamutil`, and specific R libraries (e.g., `bbmle`, `VGAM`, `survcomp`).

```bash
# Create and activate environment
conda create --name msoma_env -c bioconda -c conda-forge msoma
conda activate msoma_env

# Verify all Python, R, and binary dependencies are present
msoma check-dependencies
```

## Core Workflow

### 1. Generating Allele Counts
The `count` command processes a BAM file to produce a counts file. This step requires a reference FASTA, a BED file defining callable regions, and the read length.

```bash
msoma count [INPUT_BAM] \
  --fasta [REFERENCE_FASTA] \
  --bed [CALLABLE_REGIONS_BED] \
  --seq-length [READ_LENGTH] \
  --output [OUTPUT_COUNTS_FILE]
```

**Expert Tips for Counting:**
- **Quality Filtering:** Use `-q` (Minimum Mapping Quality) and `-b` (Minimum Base Quality) to filter out low-confidence alignments.
- **Read Trimming:** Use `-n` to trim bases from both ends of reads if you suspect end-of-read sequencing errors.
- **Artifact Reduction:** Adjust `--max-indel` and `--mismatch-frac` to exclude reads with high numbers of differences from the reference, which often represent mapping artifacts.

### 2. Merging Counts (Multi-tissue)
If you have generated count files for multiple tissues separately, merge them before running the statistical model.

```bash
msoma merge-counts [COUNT_FILE_1] [COUNT_FILE_2] ... -o [MERGED_COUNTS_FILE]
```

### 3. Statistical Inference (MLE)
The `mle` command performs the actual somatic variant calling by calculating p-values based on the betabinomial model.

```bash
msoma mle [INPUT_COUNTS] \
  --output [OUTPUT_PVAL_FILE] \
  --min-depth [MIN_DEPTH] \
  --ab [ALPHA_BETA_ESTIMATES_FILE]
```

**Best Practices for MLE:**
- **Depth Threshold:** Set `--min-depth` (e.g., 10 or 20) to ensure there is enough data at a locus to make a reliable statistical inference.
- **Parameter Inspection:** The `--ab` flag generates a file containing alpha and beta parameter estimates. Review these to understand the overdispersion characteristics of your specific dataset.

## Troubleshooting Common Issues

- **Architecture Constraints:** mSOMA depends on `bamutil`, which currently limits its native execution to Linux and Mac AMD64 architectures.
- **R Path Conflicts:** If mSOMA fails to find R libraries despite a correct installation, ensure the Conda environment is fully activated. mSOMA makes subprocess calls to `Rscript`, and local user R libraries can sometimes interfere with the environment-specific versions.
- **Dependency Failures:** If `check-dependencies` reports missing R libraries, you may need to manually install them within the environment using `conda install r-[library-name]`.

## Reference documentation
- [mSOMA GitHub Repository](./references/github_com_AkeyLab_mSOMA.md)
- [mSOMA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_msoma_overview.md)