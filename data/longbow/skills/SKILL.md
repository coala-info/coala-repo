---
name: longbow
description: Longbow identifies the basecalling environment and flowcell type of Oxford Nanopore sequencing data by analyzing quality value patterns in FASTQ files. Use when user asks to predict basecaller versions, identify flowcell types, or analyze quality value distributions in nanopore datasets.
homepage: https://github.com/JMencius/longbow
---


# longbow

## Overview
Longbow is a diagnostic tool for Oxford Nanopore sequencing data. It analyzes the quality value (QV) patterns within FASTQ files to predict the original basecalling environment. This is particularly useful for public datasets where flowcell types (R9 vs R10) or basecaller versions (Guppy vs Dorado) were not documented, as using the wrong model in downstream tools can significantly degrade results.

## Usage Instructions

### Basic Identification
To quickly identify the configuration of a FASTQ file and see the results in the terminal:
```bash
longbow -i reads.fastq.gz --stdout
```

### Standard Analysis Workflow
For production use, save the predictions to a JSON file for programmatic parsing:
```bash
longbow -i input.fastq.gz -o prediction.json
```

### Performance Optimization
Longbow is highly parallelizable. On modern systems, increase the thread count to speed up processing of large datasets:
```bash
longbow -i large_dataset.fastq.gz -o results.json -t 32
```

### Advanced Configuration and Quality Control
- **Detailed Output**: Use the `-b` flag to include intermediate QV data, autocorrelation results, and experimental confidence scores in the JSON output.
- **Quality Filtering**: If the dataset contains many low-quality reads that might skew prediction, set a minimum quality score threshold:
  ```bash
  longbow -i reads.fastq -q 7 -o filtered_results.json
  ```
- **Mode Prediction**: The `-a` (autocorrelation) parameter defaults to `fhs` (FAST/HAC/SUP). If you know the data is only HAC or SUP, use `-a hs` for potentially more accurate mode correction.

## Best Practices
- **Input Formats**: Longbow supports both raw `.fastq` and compressed `.fastq.gz` files.
- **Resource Estimation**: The tool can process approximately 10,000 reads in seconds. For massive datasets (10^7 reads), expect processing times of around one hour with 32 threads.
- **Version Sensitivity**: Note that early versions of Guppy 3 (e.g., 3.0.3) may occasionally be classified as Guppy 2, though the impact on downstream analysis is usually minimal.
- **Environment**: Ensure a Python 3.7+ environment is active. If installing via pip, use the package name `epg-longbow` to avoid naming conflicts.

## Reference documentation
- [GitHub - JMencius/LongBow](./references/github_com_JMencius_LongBow.md)
- [bioconda / longbow](./references/anaconda_org_channels_bioconda_packages_longbow_overview.md)