# ERGA DataQC Illumina v2601 (WF0) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.erga-biodiversity.eu/
- **Package**: https://workflowhub.eu/workflows/601
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/601/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 1.1K
- **Last updated**: 2026-01-20
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ERGA_DataQC_Illumina_v2601_(WF0).ga` (Main Workflow)
- **Project**: ERGA Assembly
- **Views**: 8355
- **Creators**: Diego De Panis
- **Discussion / source**: https://github.com/ERGA-consortium/pipelines/discussions

## Description

The workflow takes a paired-reads collection (like illumina WGS or HiC), runs FastQC and SeqKit, trims with Fastp, and creates a MultiQC report. The main outputs are a paired collection of trimmed reads, a report with raw and trimmed reads stats, and a table with raw reads stats.
