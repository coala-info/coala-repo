# OMERO Nuclei Cell Counting, Image Import, Annotation and Region of Interests (ROIs) Workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://zenodo.org/records/14205500
- **Package**: https://workflowhub.eu/workflows/1259
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1259/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 408
- **Last updated**: 2025-03-03
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-2024_Nuclei_counting_w_OMERO_upload.ga` (Main Workflow)
- **Project**: UFZ - Image Data Management and Processing Workflows
- **Views**: 3425
- **Creators**: Riccardo Massei

## Description

Workflow to perform nuclei cell counting on High Content Screening (HCS) Data and upload result into OMERO

In this workflow, cell images are first uploaded to both Galaxy and OMERO using the  “OMERO Image Import” tool. 
Concurrently, image processing is performed. After thresholding and binarization, key features of nuclei, such as area, label number, and perimeter, are computed from the processed images and saved as a CSV file. 
The result file is then attached to each image stored in OMERO using the “OMERO Metadata Import” tool. 
The “Label Extraction” tool generates ROI coordinates from the binary image, which are subsequently uploaded into OMERO using the “OMERO ROI Import” tool. 

A dataset for testing can be found at: https://zenodo.org/records/14205500

**Important Security Note:** It is crucial to be aware that storing credentials as variables can pose security risks, particularly if accessed by administrators. Therefore, it is essential to handle user credentials securely and in accordance with best practices.
