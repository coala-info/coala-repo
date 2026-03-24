# ERGA HiFi Hap1Hap2 Purge+QC v2309 (WF3) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.erga-biodiversity.eu/
- **Package**: https://workflowhub.eu/workflows/606
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/606/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 679
- **Last updated**: 2024-03-13
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ERGA_HiFi_Hap1Hap2_Purge_QC_v2310_(WF3).ga` (Main Workflow)
- **Project**: ERGA Assembly
- **Views**: 7126
- **Creators**: Diego De Panis
- **Discussion / source**: https://github.com/ERGA-consortium/pipelines/discussions

## Description

The workflow takes a trimmed HiFi reads collection, Hap1/Hap2 contigs, and the values for transition parameter and max coverage depth (calculated from WF1) to run Purge_Dups. It produces purged Hap1 and Hap2 contigs assemblies, and runs all the QC analysis (gfastats, BUSCO, and Merqury).
