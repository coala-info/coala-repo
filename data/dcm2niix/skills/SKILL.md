---
name: dcm2niix
description: dcm2niix is a specialized command-line utility designed to bridge the gap between complex medical imaging storage (DICOM) and scientific analysis formats (NIfTI).
homepage: https://github.com/rordenlab/dcm2niix
---

# dcm2niix

## Overview
dcm2niix is a specialized command-line utility designed to bridge the gap between complex medical imaging storage (DICOM) and scientific analysis formats (NIfTI). While DICOM is the standard for clinical hardware, its complexity and vendor-specific implementations make it difficult for direct research use. dcm2niix handles these nuances—such as equidistant slice requirements and diffusion gradient extraction—while simultaneously generating human-readable JSON sidecars that follow Brain Imaging Data Structure (BIDS) standards.

## Common CLI Patterns

### Basic Conversion
To convert all DICOM files in a folder using default settings:
```bash
dcm2niix /path/to/dicom/folder
```

### Standard Research Workflow
For most research pipelines, you should specify an output directory, enable compression, and define a clear naming convention:
```bash
dcm2niix -o /path/to/output -z y -f %p_%s_%t /path/to/dicom/folder
```

### Flag Reference
- `-o`: Output directory (folder must exist).
- `-z`: Compression level. `y` (yes, via pigz), `i` (internal), `n` (no), `3` (uncompressed).
- `-f`: Filename format (see Naming Placeholders below).
- `-b`: Generate BIDS JSON sidecar (`y`/`n`, default is `y`).
- `-ba`: BIDS anonymization (`y`/`n`, default is `y`).
- `-r`: Search nested subfolders recursively (`y`/`n`).

## Naming Placeholders
Use these tokens with the `-f` flag to automate file organization:
- `%p`: Protocol Name
- `%s`: Series Number
- `%t`: Acquisition Time
- `%d`: Series Description
- `%n`: Patient Name
- `%m`: Manufacturer
- `%v`: Vendor
- `%a`: Antenna (Coil) Name
- `%e`: Echo Number

## Expert Tips and Best Practices

### Performance Optimization
If you are processing large datasets, ensure `pigz` (Parallel Implementation of GZip) is installed on your system. dcm2niix will automatically detect and use it to significantly speed up the compression of `.nii.gz` files.

### BIDS Compliance
dcm2niix is the primary tool for creating BIDS-compliant datasets. It automatically extracts metadata like Repetition Time (TR), Echo Time (TE), and Flip Angle into the `.json` sidecar. For Diffusion Weighted Imaging (DWI), it also extracts `.bvec` and `.bval` files required for tractography.

### Handling Multiple Echoes
For multi-echo sequences, use `%e` in your filename format (`-f %p_%s_%e`) to prevent files from overwriting each other and to clearly distinguish between different echo times in the output folder.

### Anonymization
By default, dcm2niix anonymizes the BIDS JSON sidecar (removing Patient Name, Birth Date, etc.). If you require this information for internal tracking, use `-ba n`, but be cautious regarding HIPAA/GDPR compliance when sharing these files.

## Reference documentation
- [dcm2niix Main Repository](./references/github_com_rordenlab_dcm2niix.md)