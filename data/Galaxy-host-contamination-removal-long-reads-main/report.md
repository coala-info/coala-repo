# host-contamination-removal-long-reads/main CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/2027
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/2027/ro_crate?version=3
- **Conda**: N/A
- **Total Downloads**: 2.5K
- **Last updated**: 2026-01-25
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 3
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `host-or-contamination-removal-on-long-reads.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 791
- **Creators**: Paul Zierep, Bérénice Batut

## Description

This workflow takes Nanopore fastq(.gz) files and runs Minimap2 to map the reads against a reference genome (human, by default). It filters the output to keep only the unmapped reads and generates mapping statistics that are aggregated into a MultiQC report.
