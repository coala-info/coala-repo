---
name: clam
description: Clam identifies callable genomic regions from sequencing depth to provide accurate denominators for population genetic diversity and divergence calculations. Use when user asks to identify callable loci, calculate windowed population genetic statistics, or generate genomic masks from depth files.
homepage: https://github.com/cademirch/clam
metadata:
  docker_image: "quay.io/biocontainers/clam:1.1.3--h79ce301_0"
---

# clam

## Overview

`clam` is a specialized toolkit designed to solve the "denominator problem" in population genetics. Standard VCF files often omit invariant sites, making it difficult to distinguish between a site that matches the reference and a site with no data. `clam` uses sequencing depth (from D4 or GVCF files) to identify "callable" regions, providing an accurate denominator for diversity calculations. This allows for high-precision estimates of nucleotide diversity and divergence while maintaining the storage efficiency of variants-only VCFs.

## Core Workflow

The standard `clam` pipeline consists of two primary stages, with an optional pre-processing step for large-scale exploration.

### 1. Generate Callable Loci (`clam loci`)
Identify which genomic positions have sufficient depth to be considered "genotype-able."

*   **Basic Usage**: `clam loci -o callable.zarr -m 10 *.d4.gz`
*   **Population-Aware**: To calculate $d_{xy}$ or $F_{ST}$ later, you must define populations here:
    `clam loci -o callable.zarr -m 10 --samples samples.tsv`
*   **Thresholding**:
    *   `-m, --min-depth`: Minimum depth (e.g., 10).
    *   `-M, --max-depth`: Maximum depth to exclude repetitive regions (e.g., 2-3x mean depth).
    *   `-d, --min-proportion`: Fraction of samples (0.0-1.0) that must be callable for the site to be included.

### 2. Calculate Statistics (`clam stat`)
Combine the callable mask with your variants to produce windowed statistics.

*   **Basic Usage**: `clam stat -o results/ -w 10000 -c callable.zarr variants.vcf.gz`
*   **Custom Regions**: Use a BED file instead of fixed windows:
    `clam stat -o results/ --regions-file genes.bed -c callable.zarr variants.vcf.gz`
*   **ROH Masking**: Exclude Runs of Homozygosity to estimate non-inbred heterozygosity:
    `clam stat -o results/ -w 10000 -c callable.zarr -r roh.bed.gz variants.vcf.gz`

### 3. Optional: Depth Collection (`clam collect`)
If you plan to experiment with multiple depth thresholds, pre-process raw depth into Zarr format first. This is significantly faster than re-reading D4/GVCF files multiple times.

*   `clam collect -o depths.zarr *.d4.gz`
*   `clam loci -o callable_strict.zarr -m 15 depths.zarr`

## Expert Tips & Best Practices

*   **Sample Naming**: Ensure sample names in your depth files (or `--samples` TSV) exactly match the VCF header. For D4 files, `clam` defaults to the filename prefix (everything before the first `.`).
*   **Sex Chromosomes**: Use `--thresholds-file` to set lower depth requirements for hemizygous chromosomes (e.g., X/Y in males) to avoid losing data in those regions.
*   **Performance**: Always use the `-t` flag to specify threads. `clam` is highly parallelizable.
*   **Zarr Storage**: `clam` uses the Zarr format for intermediate files. You can inspect these in Python using the `zarr` library to check metadata or raw depth distributions before running `stat`.
*   **VCF Requirements**: Input VCFs must be bgzipped and tabix indexed (`.tbi`).



## Subcommands

| Command | Description |
|---------|-------------|
| clam collect | Collect depth from multiple files into a Zarr store |
| clam loci | Calculate callable sites from depth statistics |
| clam stat | Calculate population genetic statistics from VCF |

## Reference documentation

- [Core Concepts](./references/cademirch_github_io_clam_explanation_concepts.md)
- [CLI Reference](./references/cademirch_github_io_clam_reference_cli.md)
- [Input Formats](./references/cademirch_github_io_clam_reference_input-formats.md)
- [Output Formats](./references/cademirch_github_io_clam_reference_output-formats.md)
- [How-to: Calculate Statistics](./references/cademirch_github_io_clam_how-to_calculate-statistics.md)