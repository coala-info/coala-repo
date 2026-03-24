# VGP-meryldb-creation/main CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/366
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/366/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 8.1K
- **Last updated**: 2026-01-25
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 6097

## Description

# VGP Workflow #1

This workflow produces a Meryl database and Genomescope outputs that will be used to determine parameters for following workflows, and assess the quality of genome assemblies. Specifically, it provides information about the genomic complexity, such as the genome size and levels of heterozygosity and repeat content, as well about the data quality.

### Inputs

-   Collection of Hifi long reads in FASTQ format

### Outputs

-   Meryl Database of kmer counts
-   GenomeScope
    -   Linear plot
    -   Log plot
    -   Transformed linear plot
    -   Transformed log plot
    -   Summary
    -   Model
    -   Model parameteres
