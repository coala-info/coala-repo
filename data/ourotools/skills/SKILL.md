---
name: ourotools
description: Ouro-Tools is a computational pipeline designed for processing and normalizing single-cell long-read RNA-sequencing data. Use when user asks to filter raw reads, normalize size distributions, analyze 5' mRNA cap sites, or generate strand-specific coverage files.
homepage: https://github.com/ahs2202/ouro-tools
---


# ourotools

## Overview
Ouro-Tools is a specialized computational pipeline for single-cell long-read RNA-sequencing (scLRR). It addresses common challenges in long-read data, such as non-biological size biases and the need for precise transcript characterization. The toolkit provides modules for raw read filtering, barcode extraction, and UMI-aware size distribution normalization, enabling researchers to integrate multi-modal datasets and accurately quantify full-length isoforms at single-cell resolution.

## Installation and Setup
Ouro-Tools can be installed via multiple package managers. For most environments, Bioconda is recommended to handle dependencies.

```bash
# Bioconda (Recommended)
conda install bioconda::ourotools

# PyPI
pip install ourotools
```

## Command Line Usage
The toolkit follows a modular structure. You can access help for any specific module using the `-h` flag.

```bash
# General usage pattern
ourotools <Module> [options]

# Example: Checking help for the pre-processing module
ourotools LongFilterNSplit -h
```

### Core Modules and Workflows
1. **Pre-processing (`LongFilterNSplit`)**: Filters raw reads and removes unwanted sequences (e.g., ribosomal or mitochondrial DNA).
2. **Size Distribution Normalization**:
   - `LongSummarizeSizeDistributions`: Summarizes UMI-deduplicated distributions from BAM files.
   - `LongCreateReferenceSizeDistribution`: Generates a smoothed reference distribution using Gaussian algorithms.
3. **5' Site Analysis**:
   - `LongSurvey5pSiteFromBAM`: Surveys 5' sites to identify mRNA caps.
   - `LongClassify5pSiteProfiles`: Classifies profiles to distinguish between capped and uncapped molecules.
4. **BAM Manipulation (`SplitBAM`)**: Exports strand-specific, size-normalized coverage files (BigWig) or extracts TSS/TES coverage.

## Expert Tips and Best Practices
- **WSL Usage**: If running on Windows Subsystem for Linux (WSL), set `ourotools.bk.int_max_num_batches_in_a_queue_for_each_worker = 1` in Python scripts to prevent inter-process communication (IPC) deadlocks.
- **Parallelization**: Ouro-Tools uses filesystem-based locks. This allows you to scale processing by running multiple samples across different machines or instances simultaneously without manual coordination.
- **Memory Management**: For large datasets, adjust the number of workers and threads per worker based on available RAM, as long-read alignment and filtering can be memory-intensive.
- **Index Preparation**: Ensure you have pre-built indices for your reference genome (minimap2) and "unwanted" sequences (rRNA/MT) before starting the pipeline to save compute time.

## Reference documentation
- [Ouro-Tools GitHub Repository](./references/github_com_ahs2202_ouro-tools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ourotools_overview.md)