---
name: troika-tb
description: troika-tb is a specialized bioinformatics pipeline designed to streamline the identification of drug resistance in *Mycobacterium tuberculosis*.
homepage: https://github.com/kristyhoran/troika
---

# troika-tb

## Overview
troika-tb is a specialized bioinformatics pipeline designed to streamline the identification of drug resistance in *Mycobacterium tuberculosis*. It acts as a wrapper and batch processor for TB-Profiler, allowing users to move from raw sequencing data to comprehensive resistance reports efficiently. It is particularly useful for high-throughput environments where consistent, automated reporting of AMR markers is required for clinical or epidemiological surveillance.

## Usage Guidelines

### Installation
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the necessary channels:
```bash
conda install -c bioconda troika-tb
```

### Core Execution Patterns
The pipeline is designed for batch processing. While specific subcommands may vary by version, the general execution flow involves pointing the tool at a directory of sequencing reads (FastQ files).

**Basic Batch Run:**
```bash
troika --input /path/to/fastqs --output /path/to/results
```

### Best Practices
- **Input Organization**: Ensure FastQ files are named consistently (e.g., using `_R1` and `_R2` suffixes) to allow the pipeline to correctly pair reads for analysis.
- **Resource Allocation**: TB-Profiler can be computationally intensive. When running troika-tb on large batches, ensure sufficient CPU threads and memory are available to the underlying alignment and variant calling steps.
- **Result Interpretation**: The output typically includes standardized reports detailing identified mutations and their associated drug resistance levels. Always verify high-confidence calls against established TB resistance databases if anomalies appear.

## Reference documentation
- [troika-tb Overview](./references/anaconda_org_channels_bioconda_packages_troika-tb_overview.md)