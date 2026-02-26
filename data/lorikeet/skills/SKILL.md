---
name: lorikeet
description: Lorikeet performs digital spoligotyping of Mycobacterium tuberculosis strains using Illumina sequencing data. Use when user asks to reconstruct spoligotypes from read data, detect spacer sequences in the Direct Repeat region, or perform strain typing of tuberculosis isolates.
homepage: https://github.com/AbeelLab/lorikeet
---


# lorikeet

## Overview
Lorikeet is a specialized bioinformatics tool designed for the digital reconstruction of spoligotypes from MTB Illumina read data. It automates the detection of the 43 spacer sequences in the Direct Repeat (DR) region, replacing traditional membrane-based laboratory methods with a computational approach. It is particularly useful for strain typing and evolutionary analysis of tuberculosis isolates.

## Installation and Setup
The tool can be installed via Bioconda or run as a standalone Java application.

- **Conda installation**: `conda install -c bioconda lorikeet`
- **Manual execution**: Requires a recent version of Java. Run the JAR file directly: `java -jar lorikeet-<version>.jar`

## Command Line Usage
The primary functional module of Lorikeet is the `spoligotype` command.

### Basic Execution
Run the typing workflow by specifying the subcommand and following the interactive prompts or providing arguments:
```bash
lorikeet spoligotype
```

### Input Data Requirements
Lorikeet is flexible with input formats, allowing users to skip pre-processing steps like alignment if necessary:
- **Raw Reads**: Supports `.fastq` and compressed `.fastq.gz` files.
- **Aligned Data**: Supports `.bam` and `.sam` files.

### Customizing Sensitivity
For samples with low coverage or potential contamination, adjust the typing threshold to control sensitivity:
- Use the threshold parameter (introduced in later versions) to define the stringency for calling a spacer present or absent. This is critical for maintaining accuracy in complex genomic datasets.

## Best Practices
- **Input Selection**: While BAM/SAM files are supported, using raw FASTQ files is often faster as it avoids the overhead of full genome alignment when only the DR region is of interest.
- **Environment**: Ensure the Java Runtime Environment (JRE) is correctly configured in your PATH if running the JAR file manually.
- **Citation**: When using this tool for publication, cite Cohen et al. (2015) regarding the evolution of XDR-TB.

## Reference documentation
- [lorikeet - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_lorikeet_overview.md)
- [AbeelLab/lorikeet: Digital spoligotyping of MTB strains from Illumina read data](./references/github_com_AbeelLab_lorikeet.md)
- [Commits · AbeelLab/lorikeet](./references/github_com_AbeelLab_lorikeet_commits_master.md)