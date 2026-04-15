---
name: gaas
description: GAAS is a suite of utilities designed to standardize genome project management and extract quality metrics from genomic sequences. Use when user asks to initialize a structured genome annotation project, calculate assembly statistics such as N50 and GC content, or manage project directory hierarchies.
homepage: https://github.com/NBISweden/GAAS
metadata:
  docker_image: "quay.io/biocontainers/gaas:1.2.0--pl5321r42hdfd78af_1"
---

# gaas

## Overview
The GAAS (Genome Assembly Annotation Service) suite is a collection of specialized utilities developed by the National Bioinformatics Infrastructure Sweden (NBIS). It is designed to standardize the management of genome projects, particularly during the assembly and pre-annotation phases. The toolset is primarily used to initialize structured project environments and extract critical quality metrics from genomic sequences.

## Installation
The most reliable way to deploy GAAS and its Perl dependencies (such as BioPerl and Moose) is through Conda.

```bash
conda install -c bioconda gaas
```

## Core CLI Tools and Usage
GAAS utilities are Perl-based. You can access help for any specific tool using the `-h` flag.

### Project Initialization
To maintain compatibility with NBIS-standard pipelines, use the project creation script to set up your directory hierarchy.

```bash
gaas_create_annotation_project.pl --output <project_directory_name>
```
This creates a standardized structure including folders for assembly, annotation, and raw data.

### FASTA Sequence Analysis
Use `gaas_fasta_statistics.pl` to analyze assembly quality. It calculates metrics such as N50, L50, sequence counts, and GC content.

```bash
gaas_fasta_statistics.pl -f input.fasta
```
*Note: The output is typically formatted as a Markdown table, making it ideal for direct inclusion in project documentation or GitHub README files.*

### Environment Management
If you are working with a source installation or need to update the executable links in your environment:

```bash
gaas_refresh_bin.sh
```

## Expert Tips and Best Practices
- **Tool Migration**: Be aware that many GFF-specific manipulation tools previously found in GAAS have been moved to the **AGAT** (Another GFF Analysis Toolkit) suite. Use AGAT for complex GFF3 transformations.
- **Workflow Standardization**: Always initialize new service tasks using `gaas_create_annotation_project.pl`. This ensures that file paths remain predictable for automated scripts and collaborators.
- **Assembly Validation**: Run `gaas_fasta_statistics.pl` both before and after assembly filtering (e.g., removing short contigs) to document the impact on assembly continuity metrics.
- **Dependency Check**: If running from source, use `perl Makefile.PL` to verify that all required Perl modules (like `Graph::Directed` and `Bio::DB::EUtilities`) are present in your environment.



## Subcommands

| Command | Description |
|---------|-------------|
| gaas_fasta_statistics.pl | Get some basic statistics about a nucleotide fasta file. e.g Number of     sequence, Number of nucleotide, N50, GC-content, etc. It can also create     R plots about contig size distribution. The plots are performed only if     an output is given. This script is not designed for AA/Protein     sequences. |
| perl /usr/local/bin/gaas_create_annotation_project.pl | A fasta file for genome assembly must be provided (-g) |

## Reference documentation
- [GAAS GitHub Repository](./references/github_com_NBISweden_GAAS.md)
- [Bioconda GAAS Overview](./references/anaconda_org_channels_bioconda_packages_gaas_overview.md)
- [GAAS Issues and Tool Updates](./references/github_com_NBISweden_GAAS_issues.md)