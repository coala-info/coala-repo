---
name: plastimatch
description: Plastimatch is a specialized toolset built on the Insight Toolkit (ITK) designed for high-performance medical image manipulation.
homepage: https://github.com/ImagingDataCommons/pyplastimatch
---

# plastimatch

## Overview
Plastimatch is a specialized toolset built on the Insight Toolkit (ITK) designed for high-performance medical image manipulation. It is primarily used to bridge the gap between clinical DICOM data and research-oriented volumetric formats. This skill provides the procedural knowledge to execute common image processing tasks, such as format conversion and quantitative evaluation of segmentations, using the native command-line interface.

## Common CLI Patterns

### Image Format Conversion
The most frequent use case is converting a DICOM directory into a single volume file (NRRD or NIfTI).

```bash
# Convert a DICOM series directory to an NRRD volume
plastimatch convert --input /path/to/dicom_dir --output-img output_volume.nrrd

# Convert between research formats (e.g., NRRD to NIfTI)
plastimatch convert --input input.nrrd --output-img output.nii.gz
```

### Quantitative Evaluation
Plastimatch is the standard for comparing two volumes (typically a reference segmentation and a test segmentation).

```bash
# Calculate Dice Coefficient
plastimatch dice --reference ref_mask.nrrd --test test_mask.nrrd

# Calculate Hausdorff Distance
plastimatch hausdorff --reference ref_mask.nrrd --test test_mask.nrrd
```

### Image Comparison
To check differences between two images:

```bash
plastimatch compare image1.nrrd image2.nrrd
```

## Expert Tips and Best Practices

- **DICOM Input**: When using `--input` for DICOM, ensure the directory contains only one series. If multiple series exist in one folder, Plastimatch may merge them or fail depending on the version.
- **Metadata Preservation**: The `convert` command is highly effective at preserving spatial orientation (origin, spacing, and direction cosines) which is critical for medical imaging integrity.
- **Output Formats**: 
    - Use `.nrrd` for general research as it handles metadata headers cleanly.
    - Use `.nii.gz` (compressed NIfTI) for neuroimaging or deep learning pipelines.
- **Environment Setup**: On Ubuntu 22.04+, if the system package is unavailable, use the `pyplastimatch` utility to install precompiled binaries:
  `python3 -c 'from pyplastimatch.utils.install import install_precompiled_binaries; install_precompiled_binaries()'`
- **Integration with dcmqi**: For advanced DICOM SEG (Segmentation) or SR (Structured Reporting) tasks, ensure `dcmqi` is installed alongside Plastimatch, as they are often used in tandem for standardized medical AI pipelines.

## Reference documentation
- [PyPlastimatch Main Repository](./references/github_com_ImagingDataCommons_pyplastimatch.md)