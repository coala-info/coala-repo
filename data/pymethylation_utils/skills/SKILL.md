---
name: pymethylation_utils
description: pymethylation_utils scores DNA methylation at specific motifs across a genome using a high-performance Rust backend. Use when user asks to score DNA methylation, process methylation pileups against a reference genome, or identify motif-specific modifications.
homepage: https://github.com/SebastianDall/pymethylation_utils
---


# pymethylation_utils

## Overview
pymethylation_utils is a Python wrapper for the high-performance Rust binary `epimetheus`. It is designed for bioinformaticians and researchers who need to score DNA methylation at specific motifs across a genome. The tool automates the management of the underlying binary and provides a streamlined interface to process large-scale methylation data with multi-threaded support and memory-efficient batching.

## Usage Guidance

### Core Functionality
The primary entry point is the `run_methylation_utils` function. It processes a methylation pileup against a reference genome to produce a scored TSV file.

```python
from pymethylation_utils.utils import run_methylation_utils

run_methylation_utils(
    pileup="input.bed",
    assembly="reference.fasta",
    motifs=["GATC_a_1", "CCWGG_m_2"],
    threads=8,
    min_valid_read_coverage=3,
    output="results.tsv",
    batch_size=1000
)
```

### Motif Specification Format
Motifs must follow a strict string format: `<sequence>_<modification_type>_<position>`.
- **Sequence**: The DNA sequence (e.g., `GATC`, `RGATCY`).
- **Modification Type**: Typically `a` for Adenine or `m` for Cytosine methylation.
- **Position**: The 0-indexed or 1-indexed position within the motif (refer to your specific sequencing chemistry).

### Performance and Memory Optimization
- **Threads**: Increase the `threads` parameter to match your CPU core count for faster processing.
- **Batch Size**: The `batch_size` parameter controls how many contigs are loaded into memory at once. 
    - Use `0` for no batching (fastest if RAM is abundant).
    - Use a value like `1000` for large, fragmented assemblies to prevent Out-Of-Memory (OOM) errors.
- **Coverage Filter**: Use `min_valid_read_coverage` to filter out low-confidence sites early in the process, reducing the size of the output file.

### Input Requirements
- **Pileup**: Must be in BED format.
- **Assembly**: Must be a standard FASTA file.
- **Output**: The tool generates a TSV file named `motifs-scored-read-methylation.tsv` within the directory specified in the `output` parameter.

## Reference documentation
- [pymethylation_utils GitHub Repository](./references/github_com_SebastianDall_pymethylation_utils.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pymethylation_utils_overview.md)