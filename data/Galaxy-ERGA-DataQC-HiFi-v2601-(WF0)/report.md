# ERGA DataQC HiFi v2601 (WF0) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.erga-biodiversity.eu/
- **Package**: https://workflowhub.eu/workflows/602
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/602/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 1.1K
- **Last updated**: 2026-01-20
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ERGA_DataQC_HiFi_v2601_(WF0).ga` (Main Workflow)
- **Project**: ERGA Assembly
- **Views**: 8314
- **Creators**: Diego De Panis
- **Discussion / source**: https://github.com/ERGA-consortium/pipelines/discussions

## Description

The workflow takes a HiFi reads collection, runs FastQC and SeqKit, filters with Cutadapt, and creates a MultiQC report. The main outputs are a collection of filtred reads, a report with raw and filtered reads stats, and a table with raw reads stats.
