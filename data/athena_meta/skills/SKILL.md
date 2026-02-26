---
name: athena_meta
description: Athena is a de novo assembler that uses barcoded read cloud data to produce highly contiguous metagenomic assemblies from draft seed contigs. Use when user asks to perform metagenomic assembly using read clouds, generate seed contigs, align barcoded reads to a draft assembly, or configure the Athena pipeline.
homepage: https://github.com/abishara/athena_meta/
---


# athena_meta

## Overview

Athena is a specialized de novo assembler designed to leverage the long-range information provided by barcoded "read cloud" technologies to produce highly contiguous metagenomic assemblies. It functions by using a draft assembly (seed contigs) as a scaffold and then performing local sub-assemblies of barcoded reads that map to those seeds. Use this skill to navigate the complex pre-processing requirements, including specific FASTQ tagging, alignment parameters, and configuration of the Athena pipeline.

## Installation and Environment

*   **Python Version**: Athena requires Python 2.7. It is not compatible with Python 3.x.
*   **Conda**: Install via bioconda using `conda install bioconda::athena_meta`. It is recommended to create a fresh environment to manage the Python 2.7 dependency.
*   **Dependencies**: Ensure the following are in your `$PATH`:
    *   `idba_ud` (specifically the modified version for read clouds)
    *   `samtools` and `htslib` (v1.3+)
    *   `bwa`
    *   `flye` (v2.3.1)

## Input Data Requirements

Athena requires uncompressed paired-end interleaved FASTQ files.
*   **Barcode Tags**: Each read must have a `BC:Z:` or `BX:Z:` tag in the query name line.
*   **Sample Identifier**: Barcodes must end with a dash and an integer (e.g., `GCCAATTCAAGTTT-1`).
*   **Sorting**: The input FASTQ must be barcode-sorted so that all reads with the same barcode are in a contiguous block.
*   **Delimiters**: Tags in the query name line must be tab-delimited to ensure compatibility with `bwa mem -C`.

## Assembly Workflow

### 1. Generate Seed Contigs
Generate an initial draft assembly using a standard short-read assembler.
*   **metaSPAdes**: `metaspades.py --12 /path/to/reads -o /path/to/metaspades/out`
*   **IDBA-UD**: Use the standard out-of-the-box execution.

### 2. Align Reads to Seeds
Align the barcoded reads back to the draft assembly. You must pass the barcode tags through to the BAM file.
```bash
# Index the seeds
bwa index seeds.fasta

# Align with -C to pass tags and -p for interleaved reads
bwa mem -C -p seeds.fasta /path/to/reads.fastq | samtools sort -o aligned_reads.bam -
samtools index aligned_reads.bam
```

### 3. Configure Athena
Create a `config.json` file. This is the primary input for the assembler.
```json
{
  "input_fqs": "/path/to/barcode_sorted_reads.fastq",
  "ctgfasta_path": "/path/to/seeds.fasta",
  "reads_ctg_bam_path": "/path/to/aligned_reads.bam"
}
```

### 4. Execute Assembly
*   **Check Environment**: `athena-meta --check_prereqs`
*   **Run Assembly**: `athena-meta --config config.json --threads <N>`
*   **Resource Management**: Each thread requires approximately 4GB of RAM during the subassembly phase. Adjust `--threads` based on available system memory.

## Cluster Integration

If using a high-performance computing (HPC) cluster, add a `cluster_settings` block to your `config.json`. Athena supports SLURM, SGE, Torque, and LSF via `ipython-cluster-helper`.

```json
"cluster_settings": {
  "cluster_type": "IPCluster",
  "processes": 128,
  "cluster_options": {
    "scheduler": "slurm",
    "queue": "normal",
    "extra_params": { "mem": 16 }
  }
}
```

## Troubleshooting and Best Practices

*   **BAM Indexing**: Athena will fail if the input BAM is not position-sorted and indexed.
*   **Memory Errors**: If you encounter "Cannot allocate memory" errors, reduce the thread count. The subassembly step is memory-intensive.
*   **Output Location**: Results are typically found in a subdirectory of the configuration file's location, specifically under `results/olc/athena.asm.fa`.
*   **Logging**: Check the `logs/` subdirectory for step-specific debugging information if the pipeline halts.

## Reference documentation
- [Athena GitHub Repository](./references/github_com_abishara_athena_meta.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_athena_meta_overview.md)