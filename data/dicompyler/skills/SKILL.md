---
name: dicompyler
description: dicompyler is an extensible radiation therapy research platform and DICOM RT viewer used to visualize dose distributions and calculate dose-volume histogram parameters. Use when user asks to view DICOM RT data, analyze dose-volume histograms, visualize dose distributions over anatomical structures, or anonymize patient data for research.
homepage: https://github.com/bastula/dicompyler
---


# dicompyler

## Overview
dicompyler is an extensible, open-source radiation therapy research platform and DICOM RT viewer. It provides a specialized environment for oncological data analysis, allowing researchers to visualize dose distributions over anatomical structures and calculate critical DVH parameters. It is particularly useful for cross-platform DICOM RT visualization and as a base for developing custom radiation therapy research plugins.

## Execution and Loading Data
dicompyler can be launched via the command line, which supports direct loading of patient data folders.

- **Launch from package**: Run `dicompyler` directly from your terminal.
- **Launch from source**: Execute `python dicompyler_app.py` from the root directory.
- **Direct Data Loading**: Pass a directory path as an argument to open it immediately:
  ```bash
  dicompyler /path/to/dicom/patient_data
  ```
- **Drag and Drop**: On Windows, you can drag a folder containing DICOM files onto the dicompyler icon to initiate the import.

## Core Workflows and Best Practices

### Efficient Data Importing
- **Dependency Tree**: When the "Open Patient" dialog appears, selecting a high-level item (like an RT Structure Set) will automatically highlight and import all dependent items (like the associated CT series).
- **Selective Import**: If you only require specific data (e.g., just the structures without the dose), manually highlight only those items in the import tree to save memory and processing time.
- **Prescription Dose**: If the RT Dose file lacks a prescription dose in its metadata, ensure you enter the value in the provided box during import to ensure accurate DVH normalization.

### Radiation Therapy Analysis
- **DVH Analysis**: Use the Dose Volume Histogram viewer to analyze specific parameters. The tool allows for the calculation of volume at dose (Vx) and dose at volume (Dx) metrics.
- **2D Image Viewer**: Use the overlay feature to visualize RT Dose distributions and RT Structure Set contours directly on CT, PET, or MRI slices.
- **Data Inspection**: Use the DICOM Data Tree viewer to inspect raw tags and metadata within the DICOM files for troubleshooting or research verification.

### Patient Privacy
- **Anonymization**: Before sharing data for research, use the built-in Patient Anonymizer plugin. This tool strips Protected Health Information (PHI) from the DICOM tags while preserving the geometric and dosimetric data necessary for analysis.

## Expert Tips
- **Plugin Extensibility**: If the core functionality is insufficient, check the `dicompyler-plugins` repository for 3rd-party tools or use the Plugin Development Guide to write custom Python hooks.
- **Archival Status**: Note that dicompyler is archived. For modern production environments, it is often used as a reference for the ONCurate platform or maintained in specific Python 2.7/3.x legacy environments.
- **Memory Management**: When working with large PET or high-resolution CT datasets, import only the necessary series to maintain UI responsiveness.

## Reference documentation
- [dicompyler Wiki](./references/github_com_bastula_dicompyler_wiki.md)
- [dicompyler Main README](./references/github_com_bastula_dicompyler.md)