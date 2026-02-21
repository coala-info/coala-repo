---
name: hapflk
description: The hapflk toolset is designed to identify genomic regions under selection by analyzing haplotype differentiation across multiple populations.
homepage: https://github.com/BertrandServin/hapflk
---

# hapflk

## Overview
The hapflk toolset is designed to identify genomic regions under selection by analyzing haplotype differentiation across multiple populations. It accounts for the hierarchical structure of populations using a kinship matrix (FLK) and extends this to haplotype information (hapFLK) to increase power. This skill provides the necessary command-line patterns for processing genotype frequencies, pool-seq data, and population trees.

## Common CLI Patterns

### Core FLK Analysis
To compute the FLK statistic from population frequency files, use the `flkfreq` utility. This is typically the first step when working with allele frequency data rather than raw genotypes.

```bash
flkfreq --freq [frequency_file] --kinship [kinship_matrix]
```

### Pool-seq Selection Detection
For data derived from pooled sequencing (Pool-seq), use `poolflkadapt`. This tool handles the specific sampling variance associated with pooling.

- **Basic Pool-seq FLK**:
  ```bash
  poolflkadapt --sync [input.sync] --k [kinship_file]
  ```
- **Quantitative Covariates**: To include environmental or quantitative variables in the selection test:
  ```bash
  poolflkadapt --sync [input.sync] --k [kinship_file] --covar [covariates.txt]
  ```

### Population Tree Construction
Before running selection tests, you often need to model the neutral evolution of the populations.
```bash
flkpoptree --freq [frequency_file] --out [tree_prefix]
```

### Haplotype Analysis (Viterbi)
To implement the Viterbi algorithm for the fastPHASE model within the hapFLK framework:
```bash
hapviterbi --genotypes [genotype_file] --model [fastphase_model]
```

## Expert Tips
- **Kinship Matrix**: The accuracy of both FLK and hapFLK depends heavily on a well-estimated kinship matrix. Ensure your neutral sites (used to build the matrix) are truly independent and not under selection.
- **Pool-seq Data**: When using `poolflkadapt`, ensure your input allele frequencies are raw (unscaled) as the tool is optimized to compute the adaptation internally.
- **Annotation**: Use `poolflkannot` to add functional annotations to your selection scan results, which helps in prioritizing candidate genes in significant peaks.

## Reference documentation
- [Main Repository Overview](./references/github_com_BertrandServin_hapflk.md)
- [Commit History and Feature Implementation](./references/github_com_BertrandServin_hapflk_commits_current.md)