---
name: genodsp
description: genodsp is a specialized workbench for processing and transforming genomic signals using a pipeline of operators. Use when user asks to calculate coverage depth, smooth genomic signals, perform statistical thresholding, or identify significant genomic features.
homepage: https://github.com/rsharris/genodsp
---


# genodsp

## Overview
`genodsp` is a specialized workbench for processing genomic signals. It treats genomic data as a vector of values (typically double-precision floats) across chromosomes. By chaining operators in a pipeline, users can transform raw interval data into refined signals, perform statistical thresholding, and identify significant genomic features. It is highly efficient for signal manipulation but requires significant memory, as it loads entire chromosomal vectors into RAM.

## Core Usage Patterns

### Mandatory Chromosome Definition
Every `genodsp` command requires a chromosome lengths file. This file defines the coordinate space and the output order of data.
- **Format**: Two-column, whitespace-separated (Name, Length).
- **Flag**: `--chromosomes=my_genome.chroms`
- **Tip**: Ensure the order of chromosomes in this file matches your desired output sorting.

### Pipeline Syntax
`genodsp` uses the `=` character to separate stages in a processing pipeline. Each stage modifies the current signal state.
```bash
genodsp --chromosomes=hg38.chroms \
  = smooth --window=101 \
  = localmax --neighborhood=11 \
  > peaks.dat
```

### Calculating Coverage Depth
To convert a list of genomic intervals into a coverage signal, use the `--novalue` flag. This treats every interval as having a value of 1 and sums them at overlapping positions.
```bash
cat intervals.bed | genodsp --chromosomes=hg38.chroms --novalue > depth.dat
```

### Named Variables and Dynamic Thresholding
Some operators (like `percentile`) generate named variables that subsequent operators can reference. This is useful for binarizing data based on statistical properties of the signal itself.
```bash
genodsp --chromosomes=hg38.chroms \
  = input signal.dat \
  = percentile 99 --window=100 --min=1/inf \
  = input signal.dat --destroy \
  = binarize --threshold=percentile99 \
  > high_signal.dat
```
*Note: Use the `input` operator with `--destroy` to restore the original signal after a destructive operation like `percentile` without keeping multiple copies in memory.*

## Operator Best Practices

- **Smoothing**: Use `sum --window=N --denom=N` for a simple moving average.
- **Morphology**: Use `dilate` and `erode` to bridge gaps in signals or remove small noise spikes.
- **Memory Management**: For the human genome, `genodsp` requires approximately 24GB of RAM. Ensure the execution environment has sufficient memory for the double-precision vectors.
- **Output Formatting**: By default, `genodsp` collapses runs of identical values and rounds to the nearest whole number. Use command-line parameters (visible via `genodsp --help`) to preserve precision or output every position.
- **Help**: For detailed parameters of a specific operator, use `genodsp --help=[operator_name]`.

## Reference documentation
- [genodsp README](./references/github_com_rsharris_genodsp.md)
- [genodsp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_genodsp_overview.md)