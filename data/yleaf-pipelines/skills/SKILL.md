---
name: yleaf-pipelines
description: The `yleaf-pipelines` tool is a specialized version of Yleaf optimized for integration into automated bioinformatics workflows.
homepage: https://github.com/trianglegrrl/Yleaf-pipelines
---

# yleaf-pipelines

## Overview

The `yleaf-pipelines` tool is a specialized version of Yleaf optimized for integration into automated bioinformatics workflows. It predicts human Y-chromosome haplogroups from raw or aligned sequencing data. Unlike the original version, this fork provides enhanced command-line control over reference genome paths, making it more suitable for reproducible pipelines where specific genome versions or local file paths are required.

## Core CLI Usage

### Basic Inference
The tool automatically handles different input formats. You must specify the reference genome version (`hg19` or `hg38`) to ensure correct coordinate mapping.

*   **From FASTQ (Raw Reads):**
    `Yleaf -fastq raw_reads.fastq -o output_dir --reference_genome hg38`

*   **From BAM/CRAM (Aligned Reads):**
    `Yleaf -bam sample.bam -o output_dir --reference_genome hg19`
    `Yleaf -cram sample.cram -o output_dir --reference_genome hg38`

### Pipeline Optimization: Custom References
The primary advantage of `yleaf-pipelines` is the ability to bypass automatic downloads and use local reference files, which is critical for air-gapped systems or specific pipeline requirements.

*   **Using Local Fasta Files:**
    `Yleaf -bam sample.bam -o output_dir -rg hg19 -fg /path/to/full_genome.fa -yr /path/to/chrY.fa`

### Visualization and Detailed Analysis
To generate graphical representations of the haplogroup placement and identify non-standard mutations:

*   **Draw Tree and Show Private Mutations:**
    `Yleaf -bam sample.bam -o output_dir --reference_genome hg19 -dh -p`
    *   `-dh`: Draws the predicted haplogroups in a tree structure.
    *   `-p`: Reports all private mutations found in the sample.

## Utility Tools

### Extracting Y-Chromosome
If your pipeline uses a full genome reference but you need a standalone Y-chromosome FASTA for Yleaf, use the built-in extraction module:

`python -m yleaf.extract_y_chromosome -i /path/to/full_genome.fa -o /path/to/output_chrY.fa`

## Expert Tips and Best Practices

*   **Tree Versioning:** As of version 3.0, the tool uses the YFull (v10.01) tree structure. Be aware that results may differ from older versions of Yleaf using different tree versions.
*   **First-Run Behavior:** By default, Yleaf attempts to download reference data on its first execution. In a pipeline environment, it is best practice to pre-configure these using the `-fg` and `-yr` flags to avoid network-related failures during execution.
*   **OS Constraints:** This tool is strictly compatible with Linux environments.
*   **Storage Requirements:** Ensure the execution environment has at least 8 GB of available storage for the reference genomes and intermediate processing files.
*   **Config Customization:** You can modify `yleaf/config.txt` to set permanent paths for reference files, preventing the need to pass them as arguments in every command.

## Reference documentation
- [Yleaf-pipelines Overview](./references/anaconda_org_channels_bioconda_packages_yleaf-pipelines_overview.md)
- [Yleaf-pipelines GitHub Repository](./references/github_com_trianglegrrl_Yleaf-pipelines.md)