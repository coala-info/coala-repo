---
name: surpyvor
description: "surpyvor is a Python wrapper for SURVIVOR used to merge, evaluate, and visualize structural variant VCF files. Use when user asks to merge structural variant callsets, benchmark variants against a truth set, calculate precision and recall, or create UpSet and Venn diagrams for VCF overlaps."
homepage: https://github.com/wdecoster/surpyvor
---


# surpyvor

## Overview

surpyvor is a Python wrapper for SURVIVOR designed to simplify the evaluation, merging, and plotting of structural variant (SV) VCF files. It provides a streamlined interface for benchmarking SV callers against truth sets and consolidating callsets from different algorithms to improve variant discovery confidence.

## Command Line Usage

### Core Sub-commands
- `merge`: Combine multiple SV VCF files.
- `highsens`: Generate the union of multiple SV VCFs.
- `highconf`: Generate the intersection of multiple SV VCFs.
- `prf`: Calculate precision, recall, and F-measure.
- `upset`: Create an UpSet plot for multiple VCF files.
- `venn`: Create a Venn diagram for 2 or 3 VCF files.
- `fixvcf`: Clean and reformat VCF files to resolve common compatibility issues.

### Common Arguments
- `-o`, `--output`: Path for the output VCF (default: stdout).
- `--plotout`: Filename for generated plots.
- `-d`, `--distance`: Maximum pairwise distance between coordinates to consider variants concordant (default: 500).
- `-l`, `--minlength`: Minimum SV length to include in analysis (default: 50).
- `--variants`: List of VCF files to process.

### Common CLI Patterns

**Merging Callsets**
```bash
surpyvor merge --variants caller1.vcf caller2.vcf caller3.vcf -d 500 -o merged_calls.vcf
```

**Benchmarking against a Truth Set**
```bash
surpyvor prf --variants truth.vcf query.vcf --bar --matrix --ignore_chroms chrM,chrEBV
```

**Visualizing Callset Overlap**
```bash
surpyvor upset --variants f1.vcf f2.vcf f3.vcf --plotout sv_upset_plot.png
```

## Expert Tips and Best Practices

- **Distance Tuning**: The default distance of 500bp is a standard heuristic. For high-accuracy long-read data (e.g., PacBio HiFi), consider reducing this to 100-200bp to minimize false concordances.
- **VCF Pre-processing**: If encountering errors with third-party SV callers, use the `fixvcf` subcommand. It handles issues like incorrect reference nucleotides, SVLEN formatting, and chromosome filtering (e.g., removing chrM).
- **SNV Mode**: For specific workflows requiring merging of single nucleotide variants via bcftools logic within the surpyvor wrapper, use the `--snv` flag during merging.
- **Chromosome Filtering**: Use `--ignore_chroms` in the `prf` command to exclude decoy sequences or mitochondria which often contain noisy SV calls that skew precision/recall metrics.
- **Environment Requirements**: Ensure `bcftools`, `bgzip`, `tabix`, and `SURVIVOR` are in your `$PATH`, as surpyvor relies on these external binaries for core processing.

## Reference documentation
- [surpyvor GitHub Repository](./references/github_com_wdecoster_surpyvor.md)
- [surpyvor Commit History](./references/github_com_wdecoster_surpyvor_commits_master.md)