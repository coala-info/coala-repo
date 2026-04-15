---
name: genodsp
description: GenoDSP is a high-performance workbench that treats genomic data as digital signals to perform complex vector-based processing and transformations. Use when user asks to calculate genomic coverage, smooth signals, identify local maxima, or apply statistical thresholding to interval data.
homepage: https://github.com/rsharris/genodsp
metadata:
  docker_image: "quay.io/biocontainers/genodsp:0.0.10--h7b50bb2_1"
---

# genodsp

## Overview

GenoDSP (Genomic Digital Signal Processing) is a high-performance workbench designed to treat genomic data as a series of vectors—one per chromosome. It allows you to perform complex signal processing pipelines by chaining operators together using a unique "=" syntax. The tool is particularly effective for transforming raw interval data into continuous signals, calculating coverage, and identifying regions of interest (clumps) based on statistical thresholds. Because it loads the entire genome signal into memory as double-precision floats, it requires significant RAM (approximately 8 bytes per base pair).

## Core CLI Usage

The basic syntax for genodsp involves specifying a chromosome length file followed by a sequence of operators:

```bash
genodsp --chromosomes=my_genome.chroms [global_options] \
  = operator1 [options] \
  = operator2 [options] \
  > output.dat
```

### Mandatory Chromosome File
The `--chromosomes` flag is required to allocate memory. The file must be a two-column, whitespace-separated text file:
- Column 1: Chromosome name (e.g., chr1)
- Column 2: Length in base pairs
- **Note**: The order of chromosomes in this file determines the output sort order.

### Signal Input and Output
- **Default Input**: Reads from `stdin`. Overlapping intervals in the input are automatically summed.
- **Coverage Depth**: Use `--novalue` to ignore input values and treat every interval as a value of 1, effectively creating a coverage map.
- **Default Output**: Four-column format (chrom, start, end, value). Adjacent positions with the same value are collapsed into single intervals. Zeros are omitted by default.

## Common Operators and Patterns

### Smoothing and Peak Finding
To identify peaks in a signal, a common pipeline involves smoothing followed by local maxima detection:
- `smooth --window=101`: Applies a moving average over a 101bp window.
- `localmax --neighborhood=11`: Identifies positions that are the maximum within an 11bp radius.

### Statistical Thresholding
- `sum --window=100 --denom=100`: Calculates the average value over 100bp windows.
- `percentile 99.5`: Calculates the 99.5th percentile value of the current signal.
- `binarize --threshold=X`: Converts all values above X to 1 and all others to 0.

### Named Variables
GenoDSP allows you to use the output of one operator as a variable in another. For example, you can calculate a percentile and then use it as a threshold:
```bash
genodsp --chromosomes=hg38.chroms \
  = percentile 99 --window=100 --quiet \
  = binarize --threshold=percentile99
```

### Managing Pipeline State
Some operators are "destructive" (they modify the signal in a way that makes it unusable for subsequent steps). Use `input` and `output` operators to save and restore state:
- `output temp.save`: Saves the current signal state to a file.
- `input temp.save --destroy`: Restores the signal from the file and deletes the temporary file.

## Expert Tips

- **Memory Calculation**: For the human genome (~3 billion bp), genodsp requires ~24GB of RAM. Ensure your environment has sufficient overhead.
- **Rounding**: By default, output values are rounded to the nearest whole number. Use global flags to adjust precision if floating-point detail is required.
- **Help System**: Use `genodsp --help=` followed by an operator name (e.g., `genodsp --help=smooth`) to get detailed documentation for specific functions.
- **Efficiency**: Rereading a signal from a file using the `input` operator is often faster than performing complex mathematical restorations if the signal has been heavily modified.



## Subcommands

| Command | Description |
|---------|-------------|
| genodsp_clump | Clumps regions based on proximity. Requires chromosome lengths or explicit start/end coordinates. |
| genodsp_cumulativesum | Calculates the cumulative sum of values across a genome, potentially considering chromosome lengths and regions. |
| genodsp_slidingsum | Calculates the sum of values within sliding windows along a genome. |
| genodsp_smooth | Smooths genomic data, but requires chromosome length information. |
| genodsp_sum | Summate genotype data across specified regions. |

## Reference documentation
- [General workbench for processing signals along genomic intervals](./references/github_com_rsharris_genodsp.md)