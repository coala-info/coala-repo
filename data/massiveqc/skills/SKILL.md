---
name: massiveqc
description: MassiveQC is a specialized Python-based pipeline designed to handle the computational challenges of processing thousands of RNA-seq samples simultaneously.
homepage: https://github.com/shimw6828/MassiveQC
---

# massiveqc

## Overview

MassiveQC is a specialized Python-based pipeline designed to handle the computational challenges of processing thousands of RNA-seq samples simultaneously. It streamlines the workflow from raw data acquisition to quality assessment by integrating trimming (Atropos), multi-genome screening (FastQ Screen), alignment (HISAT2), and quantification (featureCounts). A key feature is its use of Isolation Forests to identify outlier samples based on extracted features, ensuring data integrity in massive transcriptomic studies.

## CLI Usage Patterns

### Parallel Processing (Local)
Use `MultiQC` for automated parallel processing on a single machine.

```bash
MultiQC -i input.txt \
        -f fastq_screen.conf \
        -g genes.gtf \
        -x hisat2_index_prefix \
        -p picard.jar \
        -r genes.refFlat \
        -o ./results \
        -w 4 -t 8
```

### Single Sample Processing (Cluster)
Use `SingleQC` when submitting jobs to a cluster (PBS/Slurm) to process samples individually.

```bash
SingleQC -s SRR1234567 \
         -f fastq_screen.conf \
         -g genes.gtf \
         -x hisat2_index_prefix \
         -p picard.jar \
         -r genes.refFlat \
         -o ./results
```

## Essential Reference Preparation

MassiveQC requires specific reference formats that may need to be generated manually:

1.  **refFlat File**: Generate this from your GTF using `gtfToGenePred` (from UCSC tools):
    ```bash
    gtfToGenePred -genePredExt input.gtf -ignoreGroupsWithoutExons /dev/stdout | \
    awk 'BEGIN { OFS="\t"} {print $12, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}' > output.refflat
    ```
2.  **FastQ Screen Config**: Obtain the standard configuration using `fastq_screen --get_genomes`.
3.  **Input File**: For `MultiQC`, provide a two-column tab-delimited file containing `srx` and `srr` identifiers.

## Expert Tips and Best Practices

*   **Resource Allocation**: In `MultiQC`, the `-w` (workers) flag controls simultaneous tasks, while `-t` (threads) controls threads per task (e.g., for HISAT2). Ensure `workers * threads` does not exceed your system's total CPU cores.
*   **Storage Management**: RNA-seq processing generates massive intermediate files. Use `--remove_fastq` and `--remove_bam` to delete intermediate files after feature extraction to save disk space.
*   **Download Control**: If you already have the sequencing files, use `--skip_download` and point to them with `-d`. Conversely, use `--only_download` to stage data before starting the heavy compute phase.
*   **Configuration Files**: Instead of long CLI strings, use `-c config.txt` to pass parameters. The config file should follow a simple `key: value` format.
*   **Outlier Detection**: After running the QC pipeline, use the `IsoDetect` module (if available in your installation) to perform the Isolation Forest analysis on the generated feature tables.

## Reference documentation
- [MassiveQC GitHub Repository](./references/github_com_shimw6828_MassiveQC.md)
- [MassiveQC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_massiveqc_overview.md)