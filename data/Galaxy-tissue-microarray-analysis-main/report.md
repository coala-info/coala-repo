# tissue-microarray-analysis/main CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/1337
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1337/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 7.6K
- **Last updated**: 2025-12-12
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `tissue-micro-array-analysis.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 2778
- **Creators**: Cameron Watson

## Description

Complete multiplex tissue image (MTI) analysis pipeline for tissue microarray (TMA) data imaged using cyclic immunofluorescence: Performs illumination correction, stitching and registration, and tissue microarray segmentation. Tissue-segmented images undergo nuclear segmentation, cell/nuclei feature quantification (mean marker intensities, cell coordinates, and morphological features), and cell phenotyping. Produces outputs that are compatible with downstream single-cell/spatial analysis and interactive image viewers including: Pyramidal OME-TIFF images, nuclear segmentation masks (TIFF), quantified feature tables (CSV, h5ad) with cell type annotations, and an interactive Vitessce dashboard that combines image viewing with linked single-cell data visualizations.
