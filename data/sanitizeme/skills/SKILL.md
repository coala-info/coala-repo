---
name: sanitizeme
description: SanitizeMe automates the removal of host contaminant reads from sequencing datasets by aligning them to a reference genome. Use when user asks to remove host DNA, filter out contaminant reads, or sanitize FASTQ files for pathogen detection.
homepage: https://github.com/jiangweiyao/SanitizeMe
---


# sanitizeme

## Overview
SanitizeMe is a bioinformatics utility that automates the removal of contaminant reads from sequencing datasets. It leverages Minimap2 for alignment and Samtools for filtering, providing a streamlined workflow to extract reads that do not map to a specified host reference. This is essential for downstream analysis of non-host DNA, such as in pathogen detection or microbiome studies.

## Installation and Setup
The tool is best managed via Conda to ensure all dependencies (Minimap2, Samtools, Python modules) are correctly configured.

```bash
# Create and activate the environment
conda create -n SanitizeMe sanitizeme -y
conda activate SanitizeMe
```

## Common CLI Patterns

### Single-End Reads
Use `SanitizeMe_CLI.py` for processing single-end FASTQ files.
```bash
SanitizeMe_CLI.py -i /path/to/input_dir/ -r /path/to/reference.fasta.gz -o /path/to/output_dir/
```

### Paired-End Reads
Use `SanitizeMePaired_CLI.py` for processing paired-end data.
```bash
SanitizeMePaired_CLI.py -i /path/to/input_dir/ -r /path/to/reference.fasta.gz -o /path/to/output_dir/
```

## Expert Tips and Best Practices

### Handling Large Genomes
By default, the tool is optimized for genomes under 4 gigabases (like the human genome, ~3 Gb). If you are mapping against a larger reference, you must use the specific flag to avoid mapping errors:
- **Flag**: `--LargeReference`
- **Requirement**: This typically requires more than 8GB of system memory.

### Reference Selection
While the tool supports any FASTA or FASTA.gz file, the `human_g1k_v37` reference is the standard for removing human contaminants.
- **Download command**: `wget ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/technical/reference/human_g1k_v37.fasta.gz`

### Input Directory Structure
The tool expects a directory path for the `-i` argument rather than individual file paths. It will process all FASTQ files found within that directory. Ensure your input directory only contains the samples you intend to sanitize to avoid unnecessary processing.

### Performance Tuning
You can adjust the computational resources used by the underlying Minimap2 process. Increasing threads can significantly speed up the alignment phase if your hardware supports it.

### Verification
After execution, check the `cmd.log` file located in the results directory. This log contains the exact commands executed by the tool, which is useful for reproducibility and troubleshooting alignment parameters.

## Reference documentation
- [SanitizeMe GitHub Repository](./references/github_com_jiangweiyao_SanitizeMe.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sanitizeme_overview.md)