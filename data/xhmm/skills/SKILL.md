---
name: xhmm
description: XHMM detects rare de novo or inherited copy number variations from targeted sequencing data. Use when user asks to filter sequencing data, normalize read depth, discover copy number variations, or genotype copy number variations.
homepage: http://atgu.mgh.harvard.edu/xhmm/index.shtml
metadata:
  docker_image: "quay.io/biocontainers/xhmm:0.0.0.2016_01_04.cc14e52--hedee03e_3"
---

# xhmm

## Overview
XHMM (eXome-Hidden Markov Model) is a specialized toolset designed to detect rare de novo or inherited copy number variations from targeted sequencing data. It is particularly effective at filtering out technical artifacts common in exome capture by using Principal Component Analysis (PCA) to normalize read depth across samples and targets before applying a Hidden Markov Model for discovery.

## Core Workflow and CLI Patterns

### 1. Data Preparation and Filtering
Before normalization, filter out extreme targets and samples to ensure PCA stability.
```bash
xhmm --filter \
  --extremeGC --minTargetSize 10 \
  --maxTargetSize 10000 --minMeanTargetRD 10 \
  --maxMeanTargetRD 500 \
  -G ./targets.interval_list \
  -R ./merged_GATK_depths.txt \
  --excludeTargets ./extreme_gc_targets.txt \
  --excludeSamples ./low_quality_samples.txt \
  --outDir ./pre_norm_filter/
```

### 2. PCA Normalization
Normalize the filtered read-depth matrix to remove systematic biases.
```bash
# Run PCA on the filtered matrix
xhmm --PCA -R ./pre_norm_filter/filtered.RD.txt --outDir ./pca_results/

# Normalize data using PCA components
xhmm --normalize -R ./pre_norm_filter/filtered.RD.txt \
  --PCAfiles ./pca_results/ \
  --normalizeOutput ./normalized.RD.txt \
  --PCAnormalizeMaxVarianceProp 0.7
```

### 3. CNV Discovery and Genotyping
Apply the HMM to the normalized data to call CNVs and then genotype those calls across the cohort.
```bash
# Discover CNVs
xhmm --discover -R ./normalized.RD.txt \
  -p ./params.txt \
  -G ./targets.interval_list \
  -v ./xcnv_calls.xcnv

# Genotype discovered CNVs to get quality scores
xhmm --genotype -R ./normalized.RD.txt \
  -v ./xcnv_calls.xcnv \
  -p ./params.txt \
  -G ./targets.interval_list \
  -o ./genotyped_calls.vcf
```

## Expert Tips
- **Parameter Tuning**: The `-p params.txt` file is critical. It defines the transition and emission probabilities for the HMM (e.g., the expected rate of CNVs). Ensure these match your specific population expectations.
- **Target Intervals**: Always use the same interval list (`-G`) that was used during the GATK DepthOfCoverage step to maintain coordinate consistency.
- **PCA Components**: If the data remains noisy, adjust `--PCAnormalizeMaxVarianceProp`. Typically, removing components that explain the top 70-90% of variance helps isolate biological signals from capture-related noise.
- **Visual Validation**: Always cross-reference high-quality XHMM calls (SQ > 60) against the normalized read depth plots to verify the deletion or duplication signal.



## Subcommands

| Command | Description |
|---------|-------------|
| xhmm | Uses principal component analysis (PCA) normalization and a hidden Markov model (HMM) to detect and genotype copy number variation (CNV) from normalized read-depth data from targeted sequencing experiments. |
| xhmm | Uses principal component analysis (PCA) normalization and a hidden Markov model (HMM) to detect and genotype copy number variation (CNV) from normalized read-depth data from targeted sequencing experiments. |
| xhmm | Uses principal component analysis (PCA) normalization and a hidden Markov model (HMM) to detect and genotype copy number variation (CNV) from normalized read-depth data from targeted sequencing experiments. |

## Reference documentation
- [XHMM Overview](./references/anaconda_org_channels_bioconda_packages_xhmm_overview.md)