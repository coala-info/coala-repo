[ ]
[ ]

[Skip to content](#generate-callable-loci)

clam

Generate Callable Loci

Initializing search

[GitHub](https://github.com/cademirch/clam "Go to repository")

clam

[GitHub](https://github.com/cademirch/clam "Go to repository")

* [ ]

  clam

  clam
  + [Home](../..)
  + [Why clam?](../../explanation/why-clam/)
  + [Core Concepts](../../explanation/concepts/)
* [ ]

  Tutorial

  Tutorial
  + [Getting Started](../../tutorial/01_overview/)
* [x]

  How-to Guides

  How-to Guides
  + [ ]

    Generate Callable Loci

    [Generate Callable Loci](./)

    Table of contents
    - [Prerequisites](#prerequisites)
    - [Input Formats](#input-formats)

      * [D4 Files](#d4-files)
      * [GVCF Files](#gvcf-files)
    - [Basic Usage](#basic-usage)
    - [Setting Depth Thresholds](#setting-depth-thresholds)

      * [Per-Sample Thresholds](#per-sample-thresholds)
      * [Site-Level Thresholds](#site-level-thresholds)
      * [Per-Chromosome Thresholds](#per-chromosome-thresholds)
    - [Specifying Populations](#specifying-populations)

      * [Using Populations from a Zarr Store](#using-populations-from-a-zarr-store)
    - [Filtering Chromosomes](#filtering-chromosomes)

      * [Exclude Specific Chromosomes](#exclude-specific-chromosomes)
      * [Include Only Specific Chromosomes](#include-only-specific-chromosomes)
    - [Output Options](#output-options)

      * [Per-Sample Masks](#per-sample-masks)
    - [Using GVCF Input](#using-gvcf-input)
    - [Performance](#performance)
    - [Complete Example](#complete-example)
    - [Next Steps](#next-steps)
  + [Calculate Statistics](../calculate-statistics/)
  + [Collect Depth Data](../collect-depth-data/)
* [ ]

  Reference

  Reference
  + [CLI Reference](../../reference/cli/)
  + [Input Formats](../../reference/input-formats/)
  + [Output Formats](../../reference/output-formats/)

Table of contents

* [Prerequisites](#prerequisites)
* [Input Formats](#input-formats)

  + [D4 Files](#d4-files)
  + [GVCF Files](#gvcf-files)
* [Basic Usage](#basic-usage)
* [Setting Depth Thresholds](#setting-depth-thresholds)

  + [Per-Sample Thresholds](#per-sample-thresholds)
  + [Site-Level Thresholds](#site-level-thresholds)
  + [Per-Chromosome Thresholds](#per-chromosome-thresholds)
* [Specifying Populations](#specifying-populations)

  + [Using Populations from a Zarr Store](#using-populations-from-a-zarr-store)
* [Filtering Chromosomes](#filtering-chromosomes)

  + [Exclude Specific Chromosomes](#exclude-specific-chromosomes)
  + [Include Only Specific Chromosomes](#include-only-specific-chromosomes)
* [Output Options](#output-options)

  + [Per-Sample Masks](#per-sample-masks)
* [Using GVCF Input](#using-gvcf-input)
* [Performance](#performance)
* [Complete Example](#complete-example)
* [Next Steps](#next-steps)

# Generate Callable Loci

This guide covers how to use `clam loci` to identify genomic regions with sufficient sequencing depth to be considered callable.

## Prerequisites

* Depth files in one of the supported formats:
  + Per-sample D4 files (uncompressed or bgzipped with index)
  + Merged D4 files (uncompressed only)
  + GVCF files (bgzipped and tabix indexed)
  + A Zarr store from `clam collect`
* Optional: population file or `--samples` TSV if analyzing multiple populations (not needed if the Zarr input already contains population metadata)

## Input Formats

### D4 Files

D4 files contain per-base depth estimates. You can generate them from BAM files using [mosdepth](https://github.com/brentp/mosdepth):

```
# Generate D4 from BAM
mosdepth --d4 sample sample.bam

# Compress and index (required by clam)
bgzip sample.per-base.d4
bgzip --index sample.per-base.d4.gz
```

### GVCF Files

GVCF files must be bgzipped and tabix indexed:

```
bgzip sample.g.vcf
tabix -p vcf sample.g.vcf.gz
```

## Basic Usage

```
clam loci -o callable.zarr -m 10 sample1.d4.gz sample2.d4.gz sample3.d4.gz
```

This identifies sites where each sample has at least 10x depth.

## Setting Depth Thresholds

### Per-Sample Thresholds

Control which sites are callable at the individual sample level:

`-m, --min-depth`
:   Minimum depth required. Sites below this are not callable.

`-M, --max-depth`
:   Maximum depth allowed. Sites above this are not callable (often repetitive regions).

```
# Require 10-100x depth per sample
clam loci -o callable.zarr -m 10 -M 100 *.d4.gz
```

### Site-Level Thresholds

Apply filters across all samples at each site:

`-d, --min-proportion`
:   Fraction of samples that must pass thresholds (0.0-1.0).

`--min-mean-depth`
:   Minimum mean depth across samples.

`--max-mean-depth`
:   Maximum mean depth across samples.

```
# Require 80% of samples to be callable at each site
clam loci -o callable.zarr -m 10 -d 0.8 *.d4.gz
```

### Per-Chromosome Thresholds

For sex chromosomes or organellar genomes, use a thresholds file:

```
# thresholds.tsv
chr1    10  100
chr2    10  100
chrX    5   50
chrY    5   50
chrM    100 10000
```

```
clam loci -o callable.zarr --thresholds-file thresholds.tsv *.d4.gz
```

See [Input Formats](../../reference/input-formats/#per-chromosome-thresholds-file) for file format details.

## Specifying Populations

To calculate per-population callable counts (required for dxy and FST downstream):

```
clam loci -o callable.zarr -m 10 -p populations.tsv *.d4.gz
```

The population file maps samples to populations:

```
sample1 PopA
sample2 PopA
sample3 PopB
sample4 PopB
```

Sample Names

Sample names must exactly match the identifiers in your input files. For D4 files, this is typically the filename prefix (e.g., `sample1` for `sample1.d4.gz`).

See [Input Formats](../../reference/input-formats/#population-file) for details.

### Using Populations from a Zarr Store

When your input is a Zarr store from `clam collect` (or a previous `clam loci` run) that already has population metadata, those populations are used automatically -- no `-p` or `--samples` flag needed:

```
# Populations stored in depths.zarr are used automatically
clam loci -o callable.zarr -m 10 depths.zarr
```

To override the stored populations with different assignments, use `--samples`:

```
# Override populations from zarr with a new samples file
clam loci -o callable.zarr -m 10 depths.zarr --samples samples.tsv
```

When using `--samples` with a Zarr input, the `file_path` column is not required -- only `sample_name` and `population` are needed:

```
sample_name population
sample1 NewPopA
sample2 NewPopA
sample3 NewPopB
sample4 NewPopB
```

Note

If no populations are stored in the Zarr metadata and no `--samples` or `-p` flag is given, all samples are grouped into a single "default" population.

## Filtering Chromosomes

### Exclude Specific Chromosomes

```
# Inline
clam loci -o callable.zarr -m 10 -x chrM,chrY *.d4.gz

# From file
clam loci -o callable.zarr -m 10 --exclude-file exclude.txt *.d4.gz
```

### Include Only Specific Chromosomes

```
# Inline
clam loci -o callable.zarr -m 10 -i chr1,chr2,chr3 *.d4.gz

# From file
clam loci -o callable.zarr -m 10 --include-file autosomes.txt *.d4.gz
```

## Output Options

### Per-Sample Masks

By default, `clam loci` outputs callable counts per population. To output per-sample boolean masks instead:

```
clam loci -o callable.zarr -m 10 --per-sample *.d4.gz
```

This is useful when you need sample-level callability information for other analyses.

## Using GVCF Input

For GVCF files, you can filter by genotype quality (GQ):

```
clam loci -o callable.zarr -m 10 --min-gq 20 *.g.vcf.gz
```

## Performance

Use multiple threads for faster processing:

```
clam loci -o callable.zarr -m 10 -t 16 *.d4.gz
```

Adjust chunk size if needed (default 1Mb):

```
clam loci -o callable.zarr -m 10 --chunk-size 500000 *.d4.gz
```

## Complete Example

```
# Process 50 samples with populations, excluding sex chromosomes
clam loci \
  -o callable.zarr \
  -m 10 \
  -M 100 \
  -d 0.8 \
  -p populations.tsv \
  -x chrX,chrY,chrM \
  -t 16 \
  *.d4.gz
```

## Next Steps

Use the output with `clam stat` to calculate population genetic statistics:

```
clam stat -o results/ -w 10000 -c callable.zarr variants.vcf.gz
```

See [Calculate Statistics](../calculate-statistics/) for details.

[Previous

Getting Started](../../tutorial/01_overview/)
[Next

Calculate Statistics](../calculate-statistics/)

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)