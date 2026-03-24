# Galaxy Workflow - ARC2OMERO CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://git.nfdi4plants.org/natural-variation-and-evolution/microscopy_collection/map-by-seq_clsm-stacks/-/tree/main?ref_type=heads
- **Package**: https://workflowhub.eu/workflows/2116
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/2116/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 3
- **Last updated**: 2026-03-23
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ARC2OMERO.ga` (Main Workflow)
- **Project**: BioImage Informatics and Analysis Workflows
- **Views**: 45
- **Creators**: Riccardo Massei

## Description

## Workflow Overview
This Galaxy workflow allows transferring ARC imaging data stored as .ZIP file to a target OMERO instance by 1) keeping the ARC structure and 2) automatize the metadata annotation of the assay.

### How does it works
The workflow extract all the **./assays/experiment/dataset/** file path and create an OMERO dataset containing the images. The **"isa.assay.xlsx"** file is used to add key-value pairs to the dataset.

### Workflow Inputs
The workflow as three different data inputs:
1) **ARC .ZIP file:** A zip file with the whole ARC. Can be downloaded from the DataPLANT ARC repo
2) **Image File Extension:** Image formats (e.g. TIFF, PNG, JPEG) to upload into OMERO
3) **Target OMERO instance:** OMERO instance where to upload the data
4) **Depth of the ARC dataset folder:** How depth after **./assays/experiment/dataset/** images are stored. As example if images are **assays/CLSM-stacks_oryzalin/dataset/treated** the depth need to be set to 1. If **assays/CLSM-stacks_oryzalin/dataset** the depth need to be set to 0

### Test Dataset
https://git.nfdi4plants.org/natural-variation-and-evolution/microscopy_collection/map-by-seq_clsm-stacks/-/tree/main?ref_type=heads
