---
name: eval
description: The `eval` package is a specialized suite for the quantitative assessment of genome annotations.
homepage: http://mblab.wustl.edu/software.html
---

# eval

## Overview
The `eval` package is a specialized suite for the quantitative assessment of genome annotations. It allows you to compare predicted gene structures against known "standard" annotations to determine accuracy at the nucleotide, exon, and gene levels. It is particularly useful for benchmarking gene finders, filtering pseudogenes, and ensuring GTF files adhere to required formatting standards.

## Core CLI Patterns

### Annotation Comparison
The primary use of `eval` is comparing a prediction set against a reference set.
- **Standard Evaluation**: Use `evaluate_gtf.pl` to compare a prediction GTF against a reference GTF.
  ```bash
  evaluate_gtf.pl reference.gtf prediction.gtf
  ```
- **Statistics Provided**: The tool generates reports on Sensitivity (Sn) and Specificity (Sp) for:
  - Nucleotides (coding vs. non-coding)
  - Splice sites (donor/acceptor accuracy)
  - Exons (exact boundary matches)
  - Genes (complete structure matches)

### GTF Validation and Cleaning
Before analysis, ensure your files are compatible with the `eval` suite.
- **Validation**: Use `validate_gtf.pl` to check for common errors such as overlapping features, incorrect strand assignments, or missing required attributes.
- **Filtering**: Use `filter_gtf.pl` to extract specific subsets of annotations (e.g., only multi-exon genes) before running an evaluation.

### Distribution Analysis
To understand the characteristics of an annotation set (regardless of accuracy):
- Use `get_distribution.pl` to generate statistics on feature lengths (introns, exons, intergenic regions) and exon counts.
- This is useful for identifying biases in gene prediction software (e.g., a tendency to predict unusually short introns).

## Expert Tips
- **GTF Compatibility**: `eval` expects standard GTF format. Ensure your 9th column (attributes) contains `gene_id` and `transcript_id`.
- **Coordinate Systems**: Always verify that your reference and prediction files use the same chromosome naming convention (e.g., "chr1" vs "1") to avoid zero-match results.
- **Pseudogene Handling**: If your predictions include many false positives, consider using the companion `PPFINDER` logic to identify and mask processed pseudogenes which often confound gene-structure evaluators.

## Reference documentation
- [Eval Software Overview](./references/mblab_wustl_edu_software.html.md)
- [Bioconda Eval Package](./references/anaconda_org_channels_bioconda_packages_eval_overview.md)