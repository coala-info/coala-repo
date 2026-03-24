# Differential peak analysis with SnapATAC2 CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.eu
- **Package**: https://workflowhub.eu/workflows/1089
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1089/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 524
- **Last updated**: 2024-08-02
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Differential_peak_analysis_with_SnapATAC2.ga` (Main Workflow)
- **Project**: usegalaxy-eu
- **Views**: 4985
- **Creators**: Timon Schlegel

## Description

This workflow takes a cell-type-annotated AnnData object (processed with SnapATAC2) and performs peak calling with MACS3 on the cell types. Next, a cell-by-peak matrix is constructed and differential accessibility tests are performed for comparison of either two cell types or one cell type with a background of all other cells. 
Lastly, differentially accessible marker regions for each cell type are identified.
