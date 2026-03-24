# host-contamination-removal-short-reads/main CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/2026
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/2026/ro_crate?version=3
- **Conda**: N/A
- **Total Downloads**: 2.5K
- **Last updated**: 2026-01-25
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 3
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `host-or-contamination-removal-on-short-reads.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 856
- **Creators**: Paul Zierep, Bérénice Batut

## Description

This workflow takes paired-end Illumina fastq(.gz) files and runs Bowtie to map the reads against a reference genome (human, by default) and keep only the reads that do not align. MultiQC is used to aggregate the mapping reports.
