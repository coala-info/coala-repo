# ERGA Long Reads PriAlt Purge+QC v2505 (WF3) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.erga-biodiversity.eu/
- **Package**: https://workflowhub.eu/workflows/1163
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1163/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 767
- **Last updated**: 2025-06-01
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ERGA_Long_Reads_PriAlt_Purge_QC_v2505_(WF3).ga` (Main Workflow)
- **Project**: ERGA Assembly
- **Views**: 4758
- **Creators**: Diego De Panis
- **Discussion / source**: https://github.com/ERGA-consortium/pipelines/discussions

## Description

The workflow takes a Long Reads collection, Pri/Alt contigs, and the values for transition parameter and max coverage depth (calculated from WF1) to run Purge_Dups. It produces purged Pri and Alt contigs assemblies, and runs all the QC analysis (gfastats, BUSCO, and Merqury).
