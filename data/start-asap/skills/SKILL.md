---
name: start-asap
description: The start-asap tool automates the creation of structured project directories and configuration files for the ASA³P bacterial genomics pipeline. Use when user asks to initialize an ASA³P project, generate a config.xls file from raw sequencing reads, or set up a structured directory for genomic analysis.
homepage: http://github.com/quadram-institute-bioscience/start-asap/
metadata:
  docker_image: "quay.io/biocontainers/start-asap:1.3.0--0"
---

# start-asap

## Overview

The `start-asap` tool is a specialized pre-processing utility for the ASA³P (Automated Scalable Assembly, Annotation and Phenotyping) pipeline. Its primary function is to convert a directory of raw sequencing reads and reference files into a structured project directory ready for analysis. By automating the generation of the mandatory `config.xls` file, it removes the need for manual data entry in Excel, which is often a bottleneck in high-throughput bacterial genomics workflows.

## Usage Patterns

### Basic Initialization
To set up a project using command-line arguments for taxonomy:
```bash
start-asap -i /path/to/reads -r reference.gbk -o ./output_dir -g GenusName -s speciesName
```

### Metadata-Driven Initialization
For more complex projects or to ensure reproducibility, use a JSON metadata file:
```bash
start-asap -i /path/to/reads -r reference.gbk -o ./output_dir -p metadata.json
```

### Overriding Metadata
Command-line flags take precedence over values defined in a JSON file. This is useful for using a template JSON while changing the genus or species for a specific run:
```bash
start-asap -i /path/to/reads -r reference.gbk -o ./output_dir -p template.json -g Salmonella
```

## Best Practices and Tips

- **Input Formats**: Ensure your sequencing reads are in FASTQ format (`.fq` or `.fastq`), preferably gzipped (`.gz`).
- **Reference Selection**: While multiple formats may be supported, `.gbk` (GenBank) files are highly recommended for the reference input to ensure the pipeline has access to existing annotations.
- **Directory Organization**: The tool can optionally copy input files into the correct `./data` subdirectory within the output path, creating a self-contained project folder.
- **Excel Output**: The generated `config.xls` contains two specific workbooks: "Project" and "Strains". If you need to make manual adjustments after initialization, ensure you maintain this structure.
- **Taxonomy Strings**: When using `-g` (genus) and `-s` (species), ensure they match NCBI nomenclature to avoid downstream issues in the ASA³P pipeline.

## Reference documentation
- [start-asap - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_start-asap_overview.md)
- [GitHub - quadram-institute-bioscience/start-asap: Initialize an ASA³P configuration file](./references/github_com_quadram-institute-bioscience_start-asap.md)