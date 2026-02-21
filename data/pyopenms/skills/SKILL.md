---
name: pyopenms
description: pyOpenMS provides Python bindings for the OpenMS C++ library, a comprehensive framework for mass spectrometry data processing.
homepage: https://github.com/OpenMS/OpenMS
---

# pyopenms

## Overview
pyOpenMS provides Python bindings for the OpenMS C++ library, a comprehensive framework for mass spectrometry data processing. This skill enables the programmatic management of LC-MS data, allowing for the creation of custom algorithms and automated pipelines. It is particularly useful for researchers needing to handle large-scale proteomics or metabolomics datasets, perform identification via database searches, or execute complex quantification protocols.

## Installation and Setup
The preferred method for installing pyOpenMS is via the bioconda channel to ensure all C++ dependencies are correctly managed.

```bash
conda install bioconda::pyopenms
```

## Core Data Management
pyOpenMS revolves around several key data structures and handlers for MS data.

### File Handling
The `FileHandler` class is the universal entry point for reading and writing various MS formats (mzML, mzXML, mzIdentML, etc.).
- **Remote Access**: Recent versions support loading XML files directly from remote locations including S3, HTTP, and FTP.
- **Format Support**: Handles both raw data (spectra/chromatograms) and identification results.

### Primary Data Structures
- **MSExperiment**: The central container for a complete LC-MS/MS run, holding a collection of `MSSpectrum` and `MSChromatogram` objects.
- **MSSpectrum**: Represents a single mass spectrum (m/z and intensity pairs).
- **FeatureMap**: Stores detected features (peaks in LC-MS space), typically produced by feature finding algorithms.
- **ConsensusMap**: Used for linking features across multiple maps/runs.

## Common Workflows and Tools

### Metabolomics (Feature Finding)
- **FeatureFinderMetabo**: Use for untargeted metabolomics feature detection. Recent updates include support for **Ion Mobility** data.
- **AccurateMassSearchEngine**: For identifying metabolites based on exact mass. When searching, you can optimize performance by providing specific adducts to the iteration engine.

### Proteomics and Quantification
- **ProteomicsLFQ**: The primary tool for label-free quantification. It supports various normalization methods, including **iBAQ**.
- **Identification**: Supports integration with search engines like Comet and Sage. Use `IDMassAccuracy` to evaluate the mass accuracy of identifications.
- **Filtering**: Use `SpectrumRangeManager` and its `byMSLevel()` method to efficiently filter spectra by their MS level (e.g., isolating MS2 spectra for identification).

### Data Extraction and Transformation
- **extractXICs**: Use this for extracting Extracted Ion Chromatograms (XICs). It now supports filtering by ion mobility and precursor attributes.
- **DataFrame Integration**: Many algorithms (like `FeatureFinderAlgorithmMetaboIdent`) now include helper methods to export results directly to Pandas DataFrames for easier downstream analysis.

## Expert Tips
- **Memory Management**: When working with very large mzML files, consider using the `OnDiskMSExperiment` to avoid loading the entire dataset into RAM.
- **Progress Logging**: Use the built-in progress loggers when running long-lived algorithms to monitor execution state.
- **Adduct Handling**: In metabolomics workflows, explicitly defining expected adducts in the `AccurateMassSearchEngine` significantly reduces the search space and improves speed.

## Reference documentation
- [pyopenms Overview](./references/anaconda_org_channels_bioconda_packages_pyopenms_overview.md)
- [OpenMS Main Repository](./references/github_com_OpenMS_OpenMS.md)
- [OpenMS Wiki and Documentation Links](./references/github_com_OpenMS_OpenMS_wiki.md)
- [Recent Feature Additions (Pull Requests)](./references/github_com_OpenMS_OpenMS_pulls.md)