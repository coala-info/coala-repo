---
name: perl-bio-rna-barmap
description: This tool processes BarMap output files to analyze the coarse-grained energy landscape of RNA molecules. Use when user asks to parse BarMap files, map RNA secondary structures to basins, or analyze energy barriers and saddle points between macrostates.
homepage: https://metacpan.org/pod/Bio::RNA::BarMap
---


# perl-bio-rna-barmap

## Overview
This skill enables the processing of BarMap output files, which represent the coarse-grained energy landscape of RNA molecules. It is used to navigate the relationship between RNA secondary structures, their energy barriers, and the basins of attraction. Use this tool to programmatically query which structures belong to specific macrostates or to analyze the transitions between states defined by BarMap.

## Usage Patterns

### Parsing BarMap Files
The primary use case involves reading the `.barmap` file format. This file typically contains the mapping of individual secondary structures to their representative local minima (basins).

- **Loading a Map**: Initialize the parser to read the mapping between configurations and their corresponding macrostates.
- **Querying Basins**: Identify which basin a specific RNA secondary structure (in dot-bracket notation) belongs to.
- **Saddle Point Analysis**: Extract the energy and structure of saddle points that connect different basins in the landscape.

### Common Tasks
- **Structure Mapping**: Given a set of RNA structures, determine their distribution across the energy landscape.
- **Landscape Summarization**: Generate summaries of the number of basins and the occupancy of each basin based on the BarMap data.
- **Integration with RNAsubopt**: Often used in conjunction with `RNAsubopt` (from ViennaRNA) to map a Boltzmann-weighted ensemble of structures to a coarse-grained landscape.

## Best Practices
- **Consistent Notation**: Ensure that the RNA sequence used to generate the BarMap file matches the sequence of any structures you are querying.
- **Energy Units**: BarMap typically uses kcal/mol; verify that any external energy calculations are converted to match the BarMap scale for accurate comparisons.
- **File Integrity**: BarMap files are sensitive to whitespace; ensure the input files are not truncated or reformatted by text editors.

## Reference documentation
- [Bio::RNA::BarMap Documentation](./references/metacpan_org_pod_Bio__RNA__BarMap.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-rna-barmap_overview.md)