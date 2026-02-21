---
name: reago
description: REAGO (REconstructing 16S ribosomal RNA Genes from metagenomic reads) is a specialized assembly tool designed to recover 16S rRNA sequences from metagenomic datasets.
homepage: https://github.com/chengyuan/reago-1.1
---

# reago

## Overview

REAGO (REconstructing 16S ribosomal RNA Genes from metagenomic reads) is a specialized assembly tool designed to recover 16S rRNA sequences from metagenomic datasets. Standard assemblers often struggle with 16S genes due to high sequence conservation across different species and high coverage depth. REAGO addresses this by first filtering reads using Covariance Models (CMs) and then performing a targeted assembly optimized for the structural properties of ribosomal RNA.

## Workflow and CLI Usage

The REAGO pipeline consists of two primary stages: read identification (filtering) and gene assembly.

### 1. Identify 16S Reads
The first step uses `filter_input.py` to extract reads that match 16S rRNA profiles. This requires the Infernal software suite and a directory of Covariance Models.

**Command Pattern:**
```bash
python filter_input.py <read_1.fasta> <read_2.fasta> <output_dir> <cm_dir> <cm_to_use> <cpus>
```

**Parameters:**
- `read_1.fasta` / `read_2.fasta`: Paired-end metagenomic reads.
- `output_dir`: Directory where filtered reads will be stored.
- `cm_dir`: Path to the directory containing Infernal Covariance Models.
- `cm_to_use`: The specific model type (e.g., `ba` for bacteria).
- `cpus`: Number of CPU cores for parallel processing.

**Example:**
```bash
python filter_input.py sample_1.fasta sample_2.fasta filter_out ./cm ba 10
```

### 2. Assemble 16S Genes
Once reads are filtered, use `reago.py` to reconstruct the genes. This step requires the Readjoiner tool.

**Command Pattern:**
```bash
python reago.py <filtered_fasta> <output_dir> -l <read_length> [options]
```

**Required Parameters:**
- `filtered_fasta`: The `filtered.fasta` file generated in Step 1.
- `output_dir`: Directory for the final assembly results.
- `-l`: The length of the input sequencing reads (e.g., 101, 150, 250).

**Optional Parameters:**
- `-o`: Overlap threshold (default: 0.7). Increase this to improve assembly stringency.
- `-e`: Error correction threshold (default: 0.05).
- `-t`: Tip size for graph cleaning (default: 30).
- `-b`: Path finding parameter (default: 10).

**Example:**
```bash
python reago.py filter_out/filtered.fasta assembly_out -l 101 -o 0.8
```

## Best Practices and Constraints

- **Read Naming Convention**: REAGO requires a specific naming format for paired-end reads. Pairs must share the same prefix and end with `.1` and `.2` (e.g., `READ_001.1` and `READ_001.2`). The tool identifies pairs based on the last character of the sequence name.
- **Input Format**: Ensure input files are in FASTA format. If your data is in FASTQ, convert it to FASTA before starting the pipeline.
- **Dependencies**: Ensure `infernal` and `gt` (GenomeTools/Readjoiner) are in your system PATH.
- **Python Version**: While the tool is written in Python, some users have reported the need for Python 2.7 compatibility or specific print statement adjustments for Python 3 environments. If you encounter `TypeError` or `NameError`, verify the environment's Python version.
- **Memory Management**: For large metagenomes, the filtering step is computationally intensive. Allocate sufficient CPUs and monitor memory usage during the Infernal search phase.

## Reference documentation
- [REAGO Main Documentation](./references/github_com_chengyuan_reago-1.1.md)
- [Known Issues and Troubleshooting](./references/github_com_chengyuan_reago-1.1_issues.md)