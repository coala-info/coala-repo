# hic-hicup-cooler/hic-fastq-to-cool-hicup-cooler CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/420
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/420/ro_crate?version=3
- **Conda**: N/A
- **Total Downloads**: 23.4K
- **Last updated**: 2026-03-14
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 3
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `hic-fastq-to-cool-hicup-cooler.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 8194
- **Creators**: Lucille Delisle

## Description

This workflow take as input a collection of paired fastq. It uses HiCUP to go from fastq to validPair file. The pairs are filtered for MAPQ and sorted by cooler to generate a tabix dataset. Cooler is used to generate a balanced cool file to the desired resolution.
