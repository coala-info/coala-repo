# pseudobulk-worflow-decoupler-edger/main CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/1207
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1207/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 7.6K
- **Last updated**: 2026-03-24
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `pseudo-bulk_edgeR.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 4341
- **Creators**: Diana Chiang Jurado, Pavankumar Videm, Pablo Moreno

## Description

This workflow uses the decoupler tool in Galaxy to generate pseudobulk counts from an annotated AnnData file obtained from scRNA-seq analysis. Following the pseudobulk step, differential expression genes (DEG) are calculated using the edgeR tool. The workflow also includes data sanitation steps to ensure smooth operation of edgeR and minimizing potential issues. Additionally, a Volcano plot tool is used to visualize the results after the DEG analysis.
