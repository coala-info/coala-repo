---
name: maxentpy
description: `maxentpy` is a Python wrapper for the MaxEntScan algorithm, which models the distribution of short sequence motifs to score splice sites.
homepage: https://github.com/kepbod/maxentpy
---

# maxentpy

## Overview
`maxentpy` is a Python wrapper for the MaxEntScan algorithm, which models the distribution of short sequence motifs to score splice sites. It provides a programmatic interface to quantify how well a specific DNA or RNA sequence matches the consensus for human splice sites. This tool is particularly useful for researchers needing to evaluate the functional impact of mutations near splice junctions or to scan sequences for potential splicing signals.

## Installation
The package is available via Bioconda:
```bash
conda install bioconda::maxentpy
```

## Core Functions
The library provides two primary scoring functions based on the Maximum Entropy Model:
- `score5(sequence)`: Scores 5' (donor) splice sites.
- `score3(sequence)`: Scores 3' (acceptor) splice sites.

## Usage Patterns

### Basic Scoring
Standard usage involves passing a sequence of a specific length to the scoring functions.
```python
from maxentpy import maxent

# 5' splice site: Requires exactly 9 bases (3 in exon, 6 in intron)
# Example: 'cag' (exon) + 'GTAAGT' (intron)
score_5 = maxent.score5('cagGTAAGT')

# 3' splice site: Requires exactly 23 bases (20 in intron, 3 in exon)
# Example: 'ttccaaacgaacttttgtAG' (intron) + 'gga' (exon)
score_3 = maxent.score3('ttccaaacgaacttttgtAGgga')
```

### Optimized Performance (Matrix Preloading)
For batch processing or high-throughput analysis, preloading the scoring matrices is critical to avoid the overhead of reloading data for every call.
```python
from maxentpy import maxent
from maxentpy.maxent import load_matrix5, load_matrix3

# Load matrices once
matrix5 = load_matrix5()
matrix3 = load_matrix3()

# Pass the matrix as an argument for significantly faster scoring
for seq in list_of_5ss_sequences:
    score = maxent.score5(seq, matrix=matrix5)
```

### High-Performance Scoring (maxent_fast)
For the highest performance, use the `maxent_fast` module, which is optimized for speed.
```python
from maxentpy import maxent_fast
from maxentpy.maxent_fast import load_matrix

# Preload matrices (use 5 for 5' sites and 3 for 3' sites)
m5 = load_matrix(5)
m3 = load_matrix(3)

fast_score5 = maxent_fast.score5('cagGTAAGT', matrix=m5)
fast_score3 = maxent_fast.score3('ttccaaacgaacttttgtAGgga', matrix=m3)
```

## Expert Tips and Best Practices
- **Strict Sequence Lengths**: `maxentpy` is sensitive to input length. 5' sites must be 9bp; 3' sites must be 23bp. Ensure your sequence extraction logic accounts for these exact offsets relative to the splice junction.
- **Module Selection**: Use `maxentpy.maxent` for standard tasks and `maxentpy.maxent_fast` for large-scale genomic scans where execution time is a bottleneck.
- **Memory Efficiency**: When working in a multi-processing environment, load the matrices in the main process and pass them to worker functions to ensure efficient memory usage and performance.
- **Sequence Orientation**: Always provide sequences in the 5' to 3' direction as they appear on the sense strand relative to the splicing event.

## Reference documentation
- [maxentpy Overview](./references/anaconda_org_channels_bioconda_packages_maxentpy_overview.md)
- [maxentpy GitHub Repository](./references/github_com_kepbod_maxentpy.md)