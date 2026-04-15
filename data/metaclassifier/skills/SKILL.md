---
name: metaclassifier
description: MetaClassifier automates the classification and quantification of DNA metabarcoding data to produce taxonomic lineage information and abundance metrics. Use when user asks to classify DNA metabarcoding reads, quantify taxonomic abundance, or search sequences against marker databases.
homepage: https://github.com/ewafula/MetaClassifier
metadata:
  docker_image: "quay.io/biocontainers/metaclassifier:v1.0.1--py_0"
---

# metaclassifier

## Overview
MetaClassifier is an integrated bioinformatics pipeline that automates the classification and quantification of DNA metabarcoding data. It streamlines the process of taking raw sequencing reads and searching them against marker databases to produce taxonomic lineage information and abundance metrics. By leveraging established tools like VSEARCH, PEAR, and seqtk, it provides a robust workflow for researchers studying biodiversity, species interactions, and environmental DNA.

## Installation and Environment
For the most reliable performance, install MetaClassifier via Bioconda. This ensures that all external dependencies (PEAR, seqtk, and VSEARCH) and specific Python library versions (such as pandas >= 1.2.2) are correctly resolved.

```bash
conda create -n metaclassifier -c bioconda metaclassifier
conda activate metaclassifier
```

## Command Line Usage
The primary execution pattern for MetaClassifier requires three positional arguments:

```bash
metaclassifier [options] <SAMPLE_FILE> <DB_DIR> <CONFIG_FILE>
```

### Argument Details
- **SAMPLE_FILE**: A file containing the list of samples to be processed.
- **DB_DIR**: The directory path where the reference marker database and corresponding taxonomic lineage information are stored.
- **CONFIG_FILE**: A configuration file specifying the parameters for the pipeline execution.

## Expert Tips and Best Practices
- **Database Compatibility**: MetaClassifier is designed to work with MetaCurator-formatted reference databases. Ensure your marker sequences include the required taxonomic lineage headers before starting the pipeline.
- **Read Merging**: The pipeline uses PEAR for merging overlapping paired-end (PE) reads. If your library preparation results in non-overlapping reads, you may need to adjust your preprocessing steps or configuration.
- **Resource Management**: Since the pipeline utilizes VSEARCH for high-throughput sequence searching, ensure your environment has sufficient memory and CPU cores allocated, especially when working with large metagenomic datasets.
- **Data Format**: MetaClassifier uses seqtk to handle the conversion from FASTQ to FASTA. Ensure your input files are in standard FASTQ format to avoid processing errors.

## Reference documentation
- [MetaClassifier Overview](./references/anaconda_org_channels_bioconda_packages_metaclassifier_overview.md)
- [MetaClassifier GitHub Repository](./references/github_com_ewafula_MetaClassifier.md)