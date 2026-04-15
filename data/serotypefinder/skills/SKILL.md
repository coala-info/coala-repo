---
name: serotypefinder
description: SerotypeFinder identifies the serotype of *Escherichia coli* isolates by searching genomic assemblies or raw reads against a database of O and H antigen genes. Use when user asks to identify E. coli serotypes, characterize O-antigen and H-antigen genes, or classify E. coli strains from sequencing data.
homepage: https://bitbucket.org/genomicepidemiology/serotypefinder
metadata:
  docker_image: "quay.io/biocontainers/serotypefinder:2.0.2--py312hdfd78af_1"
---

# serotypefinder

## Overview
SerotypeFinder is a specialized bioinformatic tool designed to identify the serotype of *Escherichia coli* isolates. It works by searching genomic assemblies or raw reads against a curated database of O-antigen processing genes and H-antigen flagellin genes. This tool is essential for characterizing E. coli strains, as serotyping is the standard method for classifying these bacteria into specific groups associated with different clinical outcomes and environmental niches.

## Usage Guidelines

### Input Requirements
- **Format**: Accepts FASTA files (assembled contigs) or FASTQ files (raw reads).
- **Species**: Specifically optimized for *Escherichia coli*. Using it on other species will not yield valid results.

### Basic Command Line Pattern
The standard execution requires specifying the input file, an output directory, and the path to the SerotypeFinder database.

```bash
serotypefinder.py -i <input_file> -o <output_directory> -p <path_to_database> [options]
```

### Key Parameters
- `-i`: Path to the input FASTA or FASTQ file.
- `-o`: Path to the directory where results will be stored.
- `-p`: Path to the SerotypeFinder database (ensure the database is downloaded and indexed).
- `-s`: Species (default is "escherichia_coli").
- `-mp`: Minimum percentage identity (default is 85%).
- `-l`: Minimum length coverage (default is 60%).
- `-x`: Extended output (includes alignment details).

### Best Practices
- **Assembly vs. Reads**: While the tool supports raw reads, using high-quality assemblies (contigs) generally provides more reliable and faster results for serotype identification.
- **Threshold Adjustment**: For highly divergent strains or low-quality sequencing data, consider lowering the identity (`-mp`) or coverage (`-l`) thresholds, but interpret these results with caution as they may represent novel or hybrid serotypes.
- **Database Updates**: Always ensure you are using the most recent version of the SerotypeFinder database to capture newly characterized O and H antigens.
- **Interpretation**: If only an O or H antigen is found, the result is reported as "partial." If multiple genes for the same antigen type are found, it may indicate a mixed sample or a complex genomic rearrangement.

## Reference documentation
- [SerotypeFinder Overview](./references/anaconda_org_channels_bioconda_packages_serotypefinder_overview.md)
- [SerotypeFinder Repository and Documentation](./references/bitbucket_org_genomicepidemiology_serotypefinder.md)