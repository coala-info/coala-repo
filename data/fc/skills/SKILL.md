---
name: fc
description: The fc tool is a specialized genome assembly algorithm designed to generate high-fidelity, full-length consensus sequences for viral quasispecies. Use when user asks to perform viral genome assembly, generate a consensus sequence from paired-end reads, or assemble viral quasispecies data.
homepage: https://github.com/qdu-bioinfo/fc-virus
metadata:
  docker_image: "quay.io/biocontainers/fc:1.0.1--h5ca1c30_1"
---

# fc

## Overview
The `fc` (or `fc-virus`) tool is a specialized genome assembly algorithm tailored for the complexities of viral quasispecies. Unlike general-purpose assemblers, it focuses on generating a high-fidelity, full-length consensus sequence. This is particularly useful in virology research where capturing the dominant viral strain in a single, continuous sequence is preferred over managing multiple overlapping contigs.

## Installation and Setup
The most reliable way to install the tool is via Bioconda:
```bash
conda install bioconda::fc
```
If using the source version from GitHub, ensure the `bin` directory is added to your `PATH` and that the Boost libraries are correctly configured in your `LD_LIBRARY_PATH`.

## Command Line Usage
The primary executable is typically named `fc-virus`. It requires paired-end reads and an output directory specification.

### Basic Assembly
To run a standard assembly using paired-end FASTQ files:
```bash
fc-virus -t fq --left forward.fastq --right reverse.fastq -o ./output_dir/
```

### Parameter Reference
- `-t <type>`: Specifies the input file format (e.g., `fq` for FASTQ).
- `--left <file>`: Path to the forward/left reads.
- `--right <file>`: Path to the reverse/right reads.
- `-o <directory>`: Path to the directory where assembly results will be stored.

## Best Practices
- **Input Quality**: Ensure your FASTQ files have undergone adapter trimming and quality filtering before running `fc-virus`, as viral quasispecies assembly is sensitive to sequencing artifacts.
- **Output Management**: The tool creates an output directory. Ensure the parent directory exists and you have write permissions before execution.
- **Resource Allocation**: While the tool is efficient, ensure your environment has sufficient memory for K-mer hashing, especially when dealing with high-depth viral datasets.

## Reference documentation
- [GitHub Repository - qdu-bioinfo/fc-virus](./references/github_com_qdu-bioinfo_fc-virus.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fc_overview.md)