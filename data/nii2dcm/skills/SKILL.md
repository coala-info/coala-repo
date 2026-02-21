---
name: nii2dcm
description: nii2dcm is a Python-based utility that bridges the gap between research-friendly NIfTI files and the clinical DICOM standard.
homepage: https://github.com/tomaroberts/nii2dcm
---

# nii2dcm

## Overview
nii2dcm is a Python-based utility that bridges the gap between research-friendly NIfTI files and the clinical DICOM standard. While tools like dcm2niix are common for converting DICOM to NIfTI, the reverse process is often more complex due to the extensive metadata requirements of the DICOM standard. nii2dcm simplifies this by generating single-frame DICOM series from NIfTI volumes in a single command, with specific support for MRI modalities.

## Installation
The tool can be installed via pip or conda:
- **Pip**: `pip install nii2dcm`
- **Conda**: `conda install bioconda::nii2dcm`

## Command Line Usage

### Basic Conversion
To convert a NIfTI file to a generic DICOM dataset:
```bash
nii2dcm input_file.nii.gz output_directory/
```

### Specifying Modality
It is highly recommended to specify the DICOM modality using the `-d` or `--dicom-type` flag to ensure the output contains the correct imaging metadata.

- **MRI (2D multi-slice)**:
  ```bash
  nii2dcm input.nii.gz output_dir/ -d MR
  ```
- **MRI (3D SVR)**:
  ```bash
  nii2dcm input.nii.gz output_dir/ -d SVR
  ```

### Metadata Transfer
To maintain consistency with an existing clinical study, use a reference DICOM file to transfer patient and study attributes (e.g., Patient Name, ID, Study Instance UID) to the new series:
```bash
nii2dcm input.nii.gz output_dir/ -d MR -r reference_file.dcm
```

## Expert Tips and Best Practices
- **Reference DICOMs**: Always use the `-r` flag when the converted data needs to be stored alongside the original clinical study. This ensures that the generated DICOMs "link" correctly to the patient's existing records in a PACS.
- **Output Directories**: Ensure the output directory exists or is specified correctly; nii2dcm will populate this folder with a series of `.dcm` files, typically one per slice.
- **Docker Usage**: If you prefer not to manage a Python environment, use the official Docker container:
  ```bash
  docker run ghcr.io/tomaroberts/nii2dcm:latest input.nii.gz output_dir/ -d MR
  ```
- **Research Limitation**: This tool is intended for research purposes only and should not be used as a clinical tool for primary diagnosis.

## Reference documentation
- [nii2dcm GitHub Repository](./references/github_com_tomaroberts_nii2dcm.md)
- [nii2dcm Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nii2dcm_overview.md)