---
name: bioconductor-rfpred
description: This tool calculates functional meta-scores for human missense variants by integrating multiple prediction algorithms using a random forest model. Use when user asks to calculate rfPred scores, prioritize pathogenic variants from NGS data, or predict the functional impact of non-synonymous SNPs.
homepage: https://bioconductor.org/packages/release/bioc/html/rfPred.html
---


# bioconductor-rfpred

name: bioconductor-rfpred
description: Use this skill to calculate rfPred functional meta-scores for human missense variants. It integrates SIFT, Polyphen2, LRT, PhyloP, and MutationTaster scores using a random forest model. Use when you need to prioritize pathogenic variants from NGS data (hg19) provided as data frames, VCF files, or GRanges objects.

## Overview

The `rfPred` package provides a functional meta-score for missense variants. It uses pre-calculated scores for all possible non-synonymous SNPs in the human exome. The core functionality revolves around the `rfPred_scores()` function, which queries a Tabix-indexed database to retrieve scores based on genomic coordinates (hg19) and alleles.

## Core Workflow

### 1. Load the Package
```R
library(rfPred)
```

### 2. Prepare Variant Input
The input `variant_list` can be a `data.frame`, a path to a `.vcf` file, or a `GRanges` object.
A `data.frame` must contain columns in this specific order:
1. **chr**: Chromosome (e.g., "Y")
2. **pos**: HG19 position
3. **ref**: Reference nucleotide
4. **alt**: Alternative nucleotide
5. **uniprot** (Optional): Uniprot protein accession number.

### 3. Calculate Scores
Use `rfPred_scores()`. You must provide the path to the pre-calculated data file and its index.

```R
# Example using package example data
data(variant_list_Y)

# Calculate scores
results <- rfPred_scores(
  variant_list = variant_list_Y,
  data = "/path/to/all_chromosomes_rfPred.txtz",
  index = "/path/to/all_chromosomes_rfPred.txtz.tbi"
)
```

### 4. Export Results
To save results directly to a CSV file, use the `file.export` argument:
```R
results <- rfPred_scores(
  variant_list = variant_list_Y,
  data = data_path,
  index = index_path,
  file.export = "my_results.csv"
)
```

## Key Parameters and Optimization

- **Protein Specificity**: If the `uniprot` column is omitted, the function returns scores for all known proteins at that genomic position, which may result in more rows than the input list.
- **Parallel Processing**: For large datasets, use the `n.cores` argument to speed up computation.
  ```R
  results <- rfPred_scores(variant_list = large_list, n.cores = 4, ...)
  ```
- **Data Requirements**: The full database (~3.3 GB) must be downloaded from Zenodo (https://doi.org/10.5281/zenodo.7127736) for genome-wide analysis.

## Interpreting Results
The output contains the original scores from the five constituent algorithms (SIFT, MutationTaster, Polyphen2, PhyloP, LRT) and the final `rfPred_score`. A higher `rfPred_score` indicates a higher probability that the variant is deleterious.

## Reference documentation

- [Calculating rfPred scores with package rfPred](./references/vignette.md)