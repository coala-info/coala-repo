---
name: pybedgraph
description: pybedgraph is a performance-oriented tool designed to efficiently query and calculate statistics from genomic signal tracks. Use when user asks to calculate signal metrics like mean or coverage from bedGraph or bigWig files, query genomic intervals at high speed, or perform bulk statistical analysis on chromosome data.
homepage: https://github.com/TheJacksonLaboratory/pyBedGraph
---


# pybedgraph

## Overview

pybedgraph is a performance-oriented tool, partially written in Cython, designed to query genomic signal tracks with extreme efficiency. It can process approximately one million regions in under a second on standard hardware. This skill provides the procedural knowledge to initialize the tool, manage memory by loading specific chromosomes, and execute various statistical queries on genomic intervals. It is particularly useful when working with sorted bedGraph files or bigWig files to extract signal metrics for downstream analysis.

## Installation and Setup

Install pybedgraph via conda or pip. Note that `pyBigWig` is required for bigWig support.

```bash
# Using Conda
conda install -c bioconda pyBedGraph

# Using Pip
pip install pyBedGraph
```

## Core Usage Patterns

### 1. Initializing the BedGraph Object
The tool requires a chromosome sizes file and the signal file (bedGraph or bigWig).

```python
from pyBedGraph import BedGraph

# Load specific chromosome to save memory
bg = BedGraph('genome.sizes', 'signal.bedGraph', 'chr1')

# Load entire file (high memory usage)
bg = BedGraph('genome.sizes', 'signal.bedGraph')

# Include missing base pairs in calculations (default is to ignore)
bg_inclusive = BedGraph('genome.sizes', 'signal.bedGraph', ignore_missing_bp=False)
```

### 2. Loading Data into Memory
Before querying, you must explicitly load the chromosome data.

```python
# Load signal data for a chromosome
bg.load_chrom_data('chr1')

# For approximate mean calculations, load bins (bin_size affects accuracy/speed)
bg.load_chrom_bins('chr1', bin_size=3)
```

### 3. Executing Statistical Queries
Supported statistics: `'mean'`, `'approx_mean'`, `'max'`, `'min'`, `'coverage'`, `'std'`, `'sum'`.

**Option A: Using a list of intervals**
```python
intervals = [['chr1', 100, 200], ['chr1', 300, 400]]
results = bg.stats(stat='mean', intervals=intervals)
```

**Option B: Using Numpy arrays (Fastest for bulk processing)**
```python
import numpy as np
starts = np.array([100, 300], dtype=np.int32)
ends = np.array([200, 400], dtype=np.int32)
results = bg.stats(stat='max', start_list=starts, end_list=ends, chrom_name='chr1')
```

**Option C: Processing from a file**
```python
# Returns a dictionary keyed by chromosome name
results_dict = bg.stats_from_file('intervals.txt', stat='mean', output_to_file=False)
```

## Expert Tips and Best Practices

- **Memory Management**: pybedgraph loads data into RAM (16 bytes per bedGraph line + 4 bytes per base pair). Always load only the chromosomes you are currently querying using `load_chrom_data()` and `load_chrom_bins()` to avoid OOM (Out of Memory) errors.
- **File Requirements**: Input bedGraph files **must** be sorted. Use `sort -k1,1 -k2,2n` if your file is unsorted.
- **Approximate Mean**: Use `approx_mean` for massive datasets where a <5% error rate is acceptable. Adjust the `bin_size` in `load_chrom_bins` to balance speed and accuracy (smaller bins = more accurate).
- **Missing Data**: By default, the tool ignores base pairs not present in the bedGraph file. If you want missing regions to count as 0 (e.g., for calculating a true mean across an interval), set `ignore_missing_bp=False` during initialization.
- **BigWig Support**: While named "pybedgraph", the tool handles bigWig files seamlessly if `pyBigWig` is installed.

## Reference documentation
- [pyBedGraph GitHub README](./references/github_com_TheJacksonLaboratory_pyBedGraph.md)
- [Bioconda pybedgraph Overview](./references/anaconda_org_channels_bioconda_packages_pybedgraph_overview.md)