# Prostate cancer classification workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://workflowhub.eu/workflows/1329
- **Package**: https://workflowhub.eu/workflows/1329
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1329/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 414
- **Last updated**: 2025-04-02
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `pca_classification_workflow.cwl` (Main Workflow)
- **Project**: CDPP
- **Views**: 1474
- **Creators**: Mauro Del Rio

## Description

# Prostate cancer classification workflow

This workflow segments tissue regions and classifies prostate cancer on H&E whole slide images, using AI. It consists of three steps:

1. low-resolution tissue segmentation to select areas for further processing;

2. high-resolution tissue segmentation to refine borders - it uses step 1 as input;

3. high-resolution normal/cancer classification - it uses step 1 as input.
