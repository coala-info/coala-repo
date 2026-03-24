# scanpy-clustering/main CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/1256
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1256/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 7.2K
- **Last updated**: 2025-11-27
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Preprocessing-and-Clustering-of-single-cell-RNA-seq-data-with-Scanpy.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 3013
- **Creators**: Pavankumar Videm, Hans-Rudolf Hotz, Mehmet Tekman, Bérénice Batut

## Description

Single-cell RNA-seq workflow with Scanpy and Anndata. Based on the 3k PBMC clustering tutorial from Scanpy. It takes count matrix, barcodes and feature files as input and creates an Anndata object out of them. It then performs QC and filters for lowly expressed genes and cells. Then the data is normalized and scaled. Then PCs are computed to further cluster using louvain algorithm. It also generated various plots of clustering colored with highly ranked genes.
