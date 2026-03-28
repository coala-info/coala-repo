---
name: ngsplotdb-ngsplotdb-hg19
description: This tool integrates the hg19 human genome database into the ngsplot framework for mapping sequencing reads to genomic elements. Use when user asks to install the hg19 database, manage hg19 extension packages, or visualize sequencing data using hg19 annotations.
homepage: https://github.com/shenlab-sinai/ngsplot
---

# ngsplotdb-ngsplotdb-hg19

## Overview
The ngsplotdb-ngsplotdb-hg19 skill provides the procedural knowledge required to integrate the hg19 human genome database into the ngsplot visualization framework. ngsplot relies on these pre-compiled database packages to efficiently map sequencing reads to functional genomic elements (such as TSS, gene bodies, or exons) without requiring the user to provide heavy annotation files for every run. This skill covers the installation of the hg19 basic package and the "extension" packages which include enhancers and DHS regions.

## Installation and Management
The primary utility for managing these databases is `ngsplotdb.py`.

### Setting the Environment
Before interacting with the database, ensure the `NGSPLOT` environment variable is set to your ngsplot installation directory:
```bash
export NGSPLOT=/path/to/ngsplot
```

### Installing the hg19 Database
To install a downloaded hg19 database package (basic or extension):
```bash
ngsplotdb.py install hg19_basic.tar.gz
```

### Handling Extension Packages
The basic hg19 package contains standard annotations (genebody, CGI, exon). If you require specialized regions:
1. Download the hg19 extension package (containing enhancers or DHS).
2. Install it using the same `ngsplotdb.py install` command.
3. This allows the use of these regions in the main `ngs.plot.r` command via the `-R` (region) argument.

## Usage Best Practices
- **Version Compatibility**: Ensure your hg19 database version matches your ngsplot version. Database files in the 3.0+ series require ngsplot v2.41 or higher.
- **Verification**: After installation, you can verify the available genomes and regions by running `ngs.plot.r` without arguments to see the help summary or by checking the `database` directory within your `NGSPLOT` path.
- **Custom Regions**: While hg19 provides many built-in regions, you can still use custom BED files with the hg19 database by specifying `-G hg19 -R bed -E your_region.bed`.

## Common CLI Patterns
- **Standard Plotting with hg19**:
  `ngs.plot.r -G hg19 -R tss -C config_file -O output_name`
- **Using hg19 Extensions (e.g., Enhancers)**:
  `ngs.plot.r -G hg19 -R enhancer -C bam_file -O output_name`



## Subcommands

| Command | Description |
|---------|-------------|
| ngs.plot.r | ngs.plot.r is a tool for generating various plots related to genomic data, including coverage profiles and heatmaps. It supports multiple genomes and regions, and offers extensive customization options for data processing and visualization. |
| ngsplotdb.py | Manipulate ngs.plot's annotation database |

## Reference documentation
- [ngsplot Main Documentation](./references/github_com_shenlab-sinai_ngsplot.md)
- [Supported Genomes Guide](./references/github_com_shenlab-sinai_ngsplot_wiki_SupportedGenomes.md)
- [Program Arguments 101](./references/github_com_shenlab-sinai_ngsplot_wiki_ProgramArguments101.md)