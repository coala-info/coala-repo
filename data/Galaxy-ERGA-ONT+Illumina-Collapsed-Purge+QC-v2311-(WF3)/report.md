# ERGA ONT+Illumina Collapsed Purge+QC v2311 (WF3) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.erga-biodiversity.eu/
- **Package**: https://workflowhub.eu/workflows/701
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/701/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 662
- **Last updated**: 2024-01-09
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ERGA_Illumina_Collapsed_Purge_QC_v2311_(WF3).ga` (Main Workflow)
- **Project**: ERGA Assembly
- **Views**: 5801
- **Creators**: Diego De Panis

## Description

The workflow takes a trimmed Illumina WGS paired-end reads collection, Collapsed contigs, and the values for transition parameter and max coverage depth (calculated from WF1) to run Purge_Dups. It produces purged Collapsed contigs assemblies, and runs all the QC analysis (gfastats, BUSCO, and Merqury).
