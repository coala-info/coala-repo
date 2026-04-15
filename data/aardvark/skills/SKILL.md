---
name: aardvark
description: Aardvark is a high-performance tool that compares and merges genomic variant call sets by constructing haplotype sequences for basepair-level accuracy. Use when user asks to compare a query VCF against a truth set, benchmark variant callers, or merge multiple VCF files into a harmonized output.
homepage: https://github.com/PacificBiosciences/aardvark
metadata:
  docker_image: "quay.io/biocontainers/aardvark:0.10.4--h4349ce8_0"
---

# aardvark

## Overview

Aardvark is a high-performance tool designed for the sophisticated comparison of genomic variant call sets. Unlike traditional tools that rely on exact coordinate and string matching, Aardvark constructs haplotype sequences to perform basepair-level comparisons. This approach allows it to correctly identify equivalent variants even when they are represented differently in different VCF files (e.g., different positioning of indels). It is particularly useful for benchmarking new variant callers against "truth" sets like GIAB or for merging multiple call sets into a harmonized output.

## Core Workflows

### Benchmarking (Compare Mode)
Use `compare` to evaluate a query VCF against a gold-standard truth set.

```bash
aardvark compare \
  --truth truth.vcf.gz \
  --query query.vcf.gz \
  --reference ref.fasta \
  --regions confidence_regions.bed \
  --output-dir results/
```

**Key Parameters:**
- `--regions`: (Formerly `--confidence-regions`) Limits analysis to specific genomic areas.
- `--stratifications`: Provide a BED file to generate summary statistics broken down by specific genomic features (e.g., low complexity regions).
- `--comparison`: Set to `GT` for strict genotype matching or `BASEPAIR` for sequence-only matching.

### Merging Call Sets (Merge Mode)
Use `merge` to combine multiple VCFs into a single harmonized file.

```bash
aardvark merge \
  --inputs sample1.vcf.gz sample2.vcf.gz sample3.vcf.gz \
  --reference ref.fasta \
  --output merged.vcf.gz \
  --strategy majority
```

**Merge Strategies:**
- `union`: Includes any variant found in at least one input.
- `intersection`: Includes only variants found in all inputs.
- `majority`: Includes variants found in more than half of the inputs.

## Expert Tips and Best Practices

- **Metric Selection**: For most users, `GT` (Genotype) and `BASEPAIR` metrics are recommended. Secondary metrics like `HAP` and `WEIGHTED_HAP` are disabled by default to save context; enable them with `--enable-haplotype-metrics` if specific sequence-weighting analysis is required.
- **Handling Large Variants**: Aardvark supports variants up to 10 kbp (including `SvDeletion`, `SvInsertion`, and Tandem Repeats). Note that including these larger variants increases compute costs.
- **Performance Tuning**: 
    - Use `--max-branch-factor` to control the heuristic search space. Increasing this value can improve accuracy in complex regions at the cost of runtime.
    - Aardvark utilizes parallelization for loading and writing; ensure your environment has sufficient threads for large VCFs.
- **Variant Trimming**: By default, Aardvark trims identical tail basepair sequences to resolve conflicts. If you need to maintain the exact original VCF representations, use `--disable-variant-trimming`.
- **Genotype Errors**: Check the `truth_fn_gt` and `query_fp_gt` columns in summary outputs. These identify "Genotype Mismatches"—cases where the sequence was correct but the zygosity (e.g., 0/1 vs 1/1) was wrong.



## Subcommands

| Command | Description |
|---------|-------------|
| aardvark compare | Core function for measuring a query VCF relative to a truth VCF |
| aardvark merge | Compares and merges variants from different VCF files |

## Reference documentation
- [Aardvark README](./references/github_com_PacificBiosciences_aardvark_blob_main_README.md)
- [User Guide](./references/github_com_PacificBiosciences_aardvark_blob_main_docs_user_guide.md)
- [Comparison Methods](./references/github_com_PacificBiosciences_aardvark_blob_main_docs_methods.md)
- [Changelog and Version History](./references/github_com_PacificBiosciences_aardvark_blob_main_CHANGELOG.md)