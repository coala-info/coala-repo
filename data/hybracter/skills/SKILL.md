---
name: hybracter
description: hybracter is a Snakemake-based pipeline for the automated long-read and hybrid assembly of bacterial genomes. Use when user asks to perform long-read only assembly, conduct hybrid assembly using Nanopore and Illumina data, or automate bacterial genome polishing and reorientation.
homepage: https://github.com/gbouras13/hybracter
---


# hybracter

## Overview

hybracter is a specialized bioinformatic pipeline designed for the "long-read first" assembly of bacterial genomes. Built on Snakemake, it automates the complex workflow of quality control, assembly (using Flye), polishing (using Medaka and Polypolish), and genomic reorientation (using dnaapler). It is specifically optimized to handle the high-throughput requirements of modern genomic labs, providing a scalable way to move from raw FASTQ files to finished, high-quality reference genomes.

## Installation and Setup

Before running assemblies, you must initialize the environment and download necessary databases.

```bash
# Install the tool via conda
conda create -n hybracter -c bioconda -c conda-forge hybracter
conda activate hybracter

# Install databases and dependencies
hybracter install -d /path/to/database_dir

# Pre-download environments for offline/HPC use
hybracter test-hybrid --threads 8
```

## Core Workflows

### 1. Long-Read Only Assembly
Use this when you only have Oxford Nanopore data.

```bash
# Single sample
hybracter long-single -i reads.fastq.gz -s SampleName -c 5000000 -o output_dir

# Batch mode using a CSV (Sample,LongReadPath,ChrSize)
hybracter long --input samples.csv --outdir output_dir
```

### 2. Hybrid Assembly
Use this to leverage the structural accuracy of long reads and the base-pair precision of short reads.

```bash
# Single sample
hybracter hybrid-single -l long.fastq.gz -1 R1.fastq.gz -2 R2.fastq.gz -s SampleName -c 5000000 -o output_dir

# Batch mode using a CSV (Sample,LongReadPath,R1Path,R2Path,ChrSize)
hybracter hybrid --input samples.csv --outdir output_dir
```

## Expert Tips and Best Practices

*   **Automatic Size Estimation**: Use the `--auto` flag to let hybracter estimate the chromosome size using `lrge`. This removes the need to provide a chromosome size in your input CSV or command line.
    *   *Note*: Only use `--auto` for high-quality reads (Q15+). For older R9 or low-quality data, manually specifying the size is safer to avoid overestimation.
*   **Path Management**: Use the `--datadir` flag to specify the directory containing your FASTQ files. This allows you to use just the filenames in your input CSV rather than absolute paths.
    *   Example: `hybracter hybrid --input samples.csv --datadir "/data/reads/long,/data/reads/short"`
*   **MacOS Compatibility**: If running on a Mac, always include the `--mac` flag. This forces the use of Medaka v1.8, as Medaka v2 is not natively supported on MacOS bioconda.
*   **HPC Execution**: For Slurm-based clusters, hybracter includes a built-in profile. Use `--profile slurm` to manage job submissions automatically.
*   **Medaka Models**: By default, hybracter uses the `--bacteria` option in Medaka v2 for improved methylation error correction. If you need to use a specific model for older data, use `--medakaModel <model>` in conjunction with the `--medaka_override` flag.
*   **Contaminant Removal**: Use the `--contaminants` flag followed by a FASTA file (e.g., Lambda phage or human genome) to filter out unwanted reads during the QC stage.

## Main Output Files

The results are organized in the specified output directory:
*   `FINAL_OUTPUT/`: Contains the final polished and reoriented assemblies.
*   `hybracter_summary.tsv`: A comprehensive report of assembly statistics, including circularity, length, and coverage for every sample.
*   `statistics/`: Detailed QC metrics from fastp and NanoPlot.



## Subcommands

| Command | Description |
|---------|-------------|
| hybracter hybrid-single | Run hybracter hybrid on 1 isolate |
| hybracter_config | Copy the system default config file |
| hybrid | Run hybracter with hybrid long and paired end short reads |
| long | Run hybracter with only long reads |
| long-single | Run hybracter long on 1 isolate |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |

## Reference documentation
- [Hybracter GitHub Repository](./references/github_com_gbouras13_hybracter_blob_main_README.md)
- [Version History and Updates](./references/github_com_gbouras13_hybracter_blob_main_HISTORY.md)