---
name: massiveqc
description: MassiveQC is a Python-based pipeline that automates RNA-seq quality control, alignment, and outlier detection for large-scale transcriptomic datasets. Use when user asks to download SRA data, perform parallel read alignment and quantification, or identify outlier samples using Isolation Forests.
homepage: https://github.com/shimw6828/MassiveQC
---

# massiveqc

## Overview

MassiveQC is a specialized Python-based pipeline designed to handle the heavy lifting of RNA-seq quality control. It streamlines the transition from raw SRA identifiers to analyzed sample features. The tool is particularly effective for researchers working with hundreds or thousands of samples, providing automated workflows for data retrieval via Aspera, read trimming with Atropos, multi-genome screening, HISAT2 alignment, and feature quantification. Its standout feature is the use of Isolation Forests to statistically identify outlier samples that may compromise downstream biological meta-analyses.

## Core Workflows

### Parallel Local Processing (MultiQC)

Use `MultiQC` for automated, parallel execution on a single powerful workstation.

**Required Input Format:**
A two-column text file containing `srx` and `srr` identifiers.

**Common CLI Pattern:**
```bash
MultiQC -i input.txt \
        -a ~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
        -f fastq_screen.conf \
        -g genome.gtf \
        -x hisat2_index_prefix \
        -p picard.jar \
        -r genome.refflat \
        -o ./results \
        -w 4 -t 8
```

### Cluster-Based Processing (SingleQC)

For HPC environments (Slurm/PBS), use `SingleQC` to process individual samples within batch scripts.

```bash
SingleQC -s SRR1234567 \
         -f fastq_screen.conf \
         -g genome.gtf \
         -x hisat2_index_prefix \
         -p picard.jar \
         -r genome.refflat \
         -o ./output_dir
```

### Outlier Detection (IsoDetect)

After processing, use `IsoDetect` to identify problematic samples using machine learning. This tool applies an Isolation Forest to the features extracted during the alignment and quantification phases.

## Expert Tips and Best Practices

*   **Resource Management**: Use the `--remove_fastq` and `--remove_bam` flags to save significant disk space when processing "massive" data, as these intermediate files are often the primary bottleneck.
*   **Configuration Files**: Instead of long CLI strings, use the `-c` flag to point to a configuration file containing your paths to reference genomes and tool binaries.
*   **Reference Preparation**: MassiveQC requires a `.refflat` file. If you only have a GTF, generate it using `gtfToGenePred`:
    ```bash
    gtfToGenePred -genePredExt input.gtf /dev/stdout | awk 'BEGIN { OFS="\t"} {print $12, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}' > output.refflat
    ```
*   **Download Only**: If you only need to retrieve the data without running the full pipeline, use the `--only_download` flag. Conversely, use `--skip_download` if you already have the fastq files locally.
*   **Aspera Speed**: Ensure the Aspera key (`-a`) is correctly pointed to your local installation to maximize download speeds from NCBI/EBI.



## Subcommands

| Command | Description |
|---------|-------------|
| MultiQC | MultiQC is a modular tool to run multiple                       bioinformatics tools and aggregate their                       results into a single, interactive HTML report. |
| SingleQC | Single-cell RNA-seq quality control tool |
| fastq_screen | FastQ Screen is intended to be used as part of a QC pipeline. It allows you to take a sequence dataset and search it against a set of bowtie databases. It will then generate both a text and a graphical summary of the results to see if the sequence dataset contains the kind of sequences you expect. |

## Reference documentation
- [MassiveQC README](./references/github_com_shimw6828_MassiveQC_blob_main_README.md)
- [MassiveQC Setup and Entry Points](./references/github_com_shimw6828_MassiveQC_blob_main_setup.py.md)