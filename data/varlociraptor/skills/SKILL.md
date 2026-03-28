---
name: varlociraptor
description: Varlociraptor is a genomic variant caller that uses a latent variable model to calculate the posterior probability of variants across various biological events. Use when user asks to call single nucleotide or structural variants, preprocess sequencing observations, filter calls based on false discovery rate, or estimate mutational burden.
homepage: https://varlociraptor.github.io
---


# varlociraptor

## Overview

Varlociraptor is a genomic variant caller that utilizes a unified latent variable model to account for uncertainties and biases in sequencing data. Unlike traditional callers that rely on hard-coded filters or heuristic scores, Varlociraptor calculates the posterior probability of variants belonging to user-defined biological events. It supports a wide range of variant types—from single nucleotide variants to large-scale structural alterations—and provides a statistically sound method for filtering calls based on desired False Discovery Rate (FDR) thresholds.

## Common CLI Patterns and Workflows

### 1. Preprocessing Observations
Before calling, you must preprocess your BAM files to characterize alignment properties (e.g., insert size distribution, soft-clipping, and read position biases).

```bash
varlociraptor preprocess reference.fa --bam sample.bam > sample.observations.bcf
```

### 2. Variant Calling
Varlociraptor supports two primary calling modes: `tumor-normal` for standard oncology pairs and `generic` for complex scenarios defined by a grammar.

**Tumor-Normal Calling:**
```bash
varlociraptor call tumor-normal --purity 0.8 --tumor tumor.observations.bcf --normal normal.observations.bcf > calls.bcf
```

**Generic Calling:**
Requires a scenario configuration file. Use this for pedigrees or multi-sample tumor evolution.
```bash
varlociraptor call generic --scenario scenario.yaml --obs sample1=s1.obs.bcf sample2=s2.obs.bcf > calls.bcf
```

### 3. FDR-Based Filtration
This is the critical final step. Instead of filtering by "Quality," filter by the probability of the event of interest (e.g., "SOMATIC_TUMOR").

```bash
varlociraptor filter-fdr calls.bcf --fdr 0.05 --events SOMATIC_TUMOR --local > filtered.bcf
```
*   `--fdr`: Sets the global false discovery rate threshold.
*   `--local`: Controls the local FDR (useful for high-precision requirements).

### 4. Estimating Mutational Burden
Varlociraptor can estimate the mutational burden (e.g., TMB) directly from the posterior probabilities.

```bash
varlociraptor estimate mutational-burden --tsv calls.bcf > burden.tsv
```

## Expert Tips and Best Practices

*   **Smart Artifact Retention**: When using FDR control, use the `--smart-retain-artifacts` flag (available in v8.7.0+) if you need to distinguish between "absent" calls and technical artifacts rather than treating them identically.
*   **MAPQ Bias Detection**: Varlociraptor can detect systematic associations of low Mapping Quality (MAPQ) with the ALT allele even if the aligner does not provide alternative mappings. This is a powerful internal check for false positives in repetitive regions.
*   **Methylation Calling**: For long-read data, use the `methylation` subcommand to call methylated sites using the same uncertainty-aware framework.
*   **Memory Management**: For large cohorts or complex scenarios, Varlociraptor utilizes `jemalloc` for efficient memory allocation. Ensure your environment allows for high memory overhead during the `call` phase.
*   **Output Interpretation**: Always look for the `AFD` (Allele Frequency Distribution) field in the output BCF. Varlociraptor provides maximum likelihood estimates that are more robust than simple read-count ratios.



## Subcommands

| Command | Description |
|---------|-------------|
| varlociraptor | varlociraptor |
| varlociraptor call | Call variants. |
| varlociraptor decode-phred | Decode PHRED-scaled values to human readable probabilities. |
| varlociraptor estimate | Perform estimations. |
| varlociraptor filter-calls | Filter calls by either controlling the false discovery rate (FDR) at given level, or by posterior odds against the given events. |
| varlociraptor plot | Create plots |
| varlociraptor preprocess | Preprocess variants |
| varlociraptor-methylation-candidates | Generate BCF with methylation candidates |

## Reference documentation
- [Varlociraptor README](./references/github_com_varlociraptor_varlociraptor_blob_master_README.md)
- [Varlociraptor Changelog](./references/github_com_varlociraptor_varlociraptor_blob_master_CHANGELOG.md)
- [Varlociraptor Homepage](./references/varlociraptor_github_io_landing.md)