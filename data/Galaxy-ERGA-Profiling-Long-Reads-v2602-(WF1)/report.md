# ERGA Profiling Long Reads v2602 (WF1) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.erga-biodiversity.eu/
- **Package**: https://workflowhub.eu/workflows/603
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/603/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 1.2K
- **Last updated**: 2026-02-11
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ERGA_Profiling_Long_Reads_v2602_(WF1).ga` (Main Workflow)
- **Project**: ERGA Assembly
- **Views**: 8211
- **Creators**: Diego De Panis
- **Discussion / source**: https://github.com/ERGA-consortium/pipelines/discussions

## Description

The workflow takes a (trimmed) Long reads collection, runs Meryl to create a K-mer database, Genomescope2 to estimate genome properties and Smudgeplot to estimate ploidy (optional). The main results are K-mer database and genome profiling plots, tables, and values useful for downstream analysis. Default K-mer length and ploidy for Genomescope are 31 and 2, respectively.
