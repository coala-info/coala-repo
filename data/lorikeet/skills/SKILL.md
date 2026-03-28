---
name: lorikeet
description: Lorikeet performs digital spoligotyping of Mycobacterium tuberculosis using Illumina sequencing data. Use when user asks to generate spoligotype patterns, classify strains, fix lineages, or merge spoligotype files.
homepage: https://github.com/AbeelLab/lorikeet
---

# lorikeet

## Overview
Lorikeet is a Java-based bioinformatics tool designed for the digital spoligotyping of Mycobacterium tuberculosis. It processes Illumina read data to generate spoligotype patterns, which are critical for strain classification and epidemiological tracking. By abstracting sequence input, it allows for consistent typing across various file formats, including raw reads and genomic alignments.

## Command Line Usage

### Basic Execution
The primary entry point for the tool is the `spoligotype` command. Ensure a recent version of Java is installed in your environment.

```bash
java -jar lorikeet-<version>.jar spoligotype
```

### Input Formats
Lorikeet supports the following sequence data formats:
- **FASTQ**: Raw sequencing reads (including compressed `.fastq.gz` files).
- **BAM**: Binary Alignment Map files.
- **SAM**: Sequence Alignment Map files.

### Customizing Sensitivity
You can adjust the sensitivity of the typing process by utilizing the threshold parameter. This is particularly useful when dealing with low-coverage data or when specific stringency is required for strain calls.

## Best Practices and Tips
- **Compressed Inputs**: To save disk space and I/O time, provide `.fastq.gz` files directly; the tool includes native support for compressed sequence iterators.
- **Interactive Mode**: When running the `spoligotype` command, the tool provides on-screen prompts to guide the user through specific parameter selection.
- **Environment Setup**: Since the tool is distributed as a JAR file, ensure your `JAVA_HOME` is correctly set to a version compatible with Scala 2.11.8 (the library version used for compilation).
- **Strain Evolution Analysis**: Lorikeet is optimized for analyzing the evolution of drug-resistant strains, such as XDR-TB, by providing high-resolution digital spoligotypes from whole-genome sequencing (WGS) data.



## Subcommands

| Command | Description |
|---------|-------------|
| java -jar lorikeet.jar fix-lineages | Fixes lineages based on input lineage information, phylogenetic tree, and SNP matrix. |
| java -jar lorikeet.jar merge-spoligotypes | Merges spoligotype files from input directories. |
| java -jar lorikeet.jar multi-typing | Performs multi-typing analysis using spoligotype files. |

## Reference documentation
- [AbeelLab/lorikeet README](./references/github_com_AbeelLab_lorikeet.md)
- [Lorikeet Commit History](./references/github_com_AbeelLab_lorikeet_commits_master.md)