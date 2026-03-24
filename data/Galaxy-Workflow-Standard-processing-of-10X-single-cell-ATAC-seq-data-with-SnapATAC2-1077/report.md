# Workflow - Standard processing of 10X single cell ATAC-seq data with SnapATAC2 CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.eu
- **Package**: https://workflowhub.eu/workflows/1077
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1077/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 535
- **Last updated**: 2024-08-30
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Standard_processing_of_single_cell_ATAC-seq_data_with_SnapATAC2.ga` (Main Workflow)
- **Project**: usegalaxy-eu
- **Views**: 5426
- **Creators**: Timon Schlegel

## Description

Workflow for Single-cell ATAC-seq standard processing with SnapATAC2.
This workflow takes a fragment file as input and performs the standard steps of scATAC-seq analysis: filtering, dimension reduction, embedding and visualization of marker genes with SnapATAC2. Finally, the clusters are manually annotated with the help of marker genes. 
In an alternative step, the fragment file can also be generated from a BAM file. 
* newer Version: Updated SnapATAC2 version from 2.5.3 to 2.6.4
