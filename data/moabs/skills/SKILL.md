---
name: moabs
description: MOABS is an integrated suite for processing large-scale bisulfite sequencing data to identify methylation metrics and differentially methylated regions. Use when user asks to process raw sequencing reads, call methylation from BAM files, or identify differentially methylated regions between groups.
homepage: https://github.com/sunnyisgalaxy/moabs
---


# moabs

## Overview
MOABS (Model-based Analysis of Bisulfite Sequencing data) is an integrated suite designed for the efficient processing of large-scale methylation datasets. It provides a streamlined workflow that transitions from raw sequencing reads to the identification of hypomethylated regions or differentially methylated regions (DMRs). The tool is specifically optimized for accuracy at base-pair resolution and includes statistical models to account for biological variance when replicates are provided.

## CLI Usage and Best Practices

### Core Pipeline Execution
The simplest way to run the full MOABS pipeline is by providing input fastq files directly.

```bash
# Basic pipeline execution for two conditions
moabs -i wt_r1.fq -i wt_r2.fq -i ko_r1.fq -i ko_r2.fq
```

For more complex projects, use a configuration file to define parameters:
```bash
moabs --cf project_settings.cfg
```

### Differential Methylation with mcomp
The `mcomp` module is used for comparing methylation levels between groups. It is highly recommended to use the `--withVariance 1` flag when biological replicates are available to ensure statistical rigor.

**Common Pattern:**
```bash
mcomp -r sample1_rep1.bed,sample1_rep2.bed -r sample2_rep1.bed,sample2_rep2.bed \
      -m label1 -m label2 \
      -c output_comparison.txt \
      --withVariance 1 \
      -p 8
```
*   `-r`: Comma-separated list of replicate files for a group.
*   `-m`: Label for the group.
*   `-c`: Output filename.
*   `-p`: Number of threads/processors.

### Methylation Calling with mcall
`mcall` extracts methylation metrics from BAM files. In version 1.3.9.6 and later, `mcall` utilizes BAM indices for significant speed improvements. Ensure your BAM files are sorted and indexed (`samtools index`) before running.

### Expert Tips and Troubleshooting
*   **Path Priority**: There is a common system utility also named `mcomp`. Always ensure the MOABS `bin` directory is at the very beginning of your `$PATH` environment variable to prevent execution errors.
*   **Module Integrity**: Do not move the `mcomp` binary to a different directory. It relies on relative paths to access internal database files located in the same folder.
*   **Dependencies**: The main `moabs` pipeline script requires the Perl module `Config::Simple`. If running individual modules like `mcall` or `mcomp` directly, this dependency is not required.
*   **Memory Management**: For large-scale datasets, ensure the system has sufficient overhead as MOABS is optimized for speed through efficient memory usage, but base-resolution analysis of the whole genome is resource-intensive.

## Reference documentation
- [MOABS GitHub Repository](./references/github_com_sunnyisgalaxy_moabs.md)
- [MOABS Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_moabs_overview.md)