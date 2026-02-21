---
name: parallel-virfinder
description: parallel-virfinder is a performance-optimized wrapper for the VirFinder tool, which uses k-mer signatures to distinguish viral contigs from bacterial ones in metagenomic data.
homepage: https://github.com/quadram-institute-bioscience/parallel-virfinder
---

# parallel-virfinder

## Overview
parallel-virfinder is a performance-optimized wrapper for the VirFinder tool, which uses k-mer signatures to distinguish viral contigs from bacterial ones in metagenomic data. This skill enables the efficient processing of large datasets by splitting input files into chunks and executing VirFinder across multiple CPU cores. It is particularly useful for bioinformaticians needing to filter viral candidates from complex assemblies while maintaining control over statistical thresholds like p-values and prediction scores.

## Installation
The tool is available via Bioconda. It is recommended to install it in a dedicated environment to manage the R and Python dependencies:
```bash
conda install -c bioconda -c conda-forge parallel-virfinder
```

## Common CLI Patterns

### Basic Parallel Execution
To run the tool with default settings (4 parallel processes) and generate a CSV report:
```bash
parallel-virfinder.py -i input.fasta -o output.csv
```

### High-Performance Configuration
For large assemblies, increase the number of parallel processes and specify a custom temporary directory (ideally on a fast SSD) to handle intermediate chunks:
```bash
parallel-virfinder.py -i assembly.fasta -o results.csv -n 16 -t /path/to/fast/tmp
```

### Filtering and Extracting Viral Sequences
To simultaneously identify viral contigs and save the sequences that meet specific thresholds into a new FASTA file:
```bash
parallel-virfinder.py -i input.fasta -o results.csv -f viral_hits.fasta -s 0.95 -p 0.01
```

## Parameter Tuning and Best Practices

### Statistical Thresholds
*   **Score (`-s`, `--min-score`)**: The default is 0.9. Higher scores increase confidence but may reduce sensitivity. For discovery of novel viruses, you might lower this, while for high-confidence annotation, 0.95+ is preferred.
*   **P-value (`-p`, `--max-p-value`)**: The default is 0.05. Use a more stringent value (e.g., 0.01) to minimize false positives in large datasets.

### Resource Management
*   **Parallelism (`-n`)**: Match this to the number of available physical CPU cores. Note that each process will load an instance of the VirFinder R model, so ensure the system has sufficient RAM (approx. 1-2GB per process depending on chunk size).
*   **Dependency Checks**: If running in a stable production environment where dependencies are pre-verified, use `--no-check` to speed up the startup time.

### Troubleshooting
*   **Verbose Output**: Use `-v` or `-d` (debug) if the tool fails during the splitting or merging phases. Debug mode (`-d`) is particularly useful as it preserves the temporary chunk files for inspection.
*   **Input Validation**: Ensure the input FASTA headers do not contain complex special characters that might interfere with the R processing scripts or CSV generation.

## Reference documentation
- [parallel-virfinder GitHub Repository](./references/github_com_quadram-institute-bioscience_parallel-virfinder.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_parallel-virfinder_overview.md)