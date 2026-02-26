---
name: ms2rescore
description: ms2rescore is a post-processing tool that increases peptide identification confidence by recalculating search engine scores using machine learning and predicted spectral features. Use when user asks to rescore peptide-spectrum matches, improve identification rates using MS2PIP or DeepLC, or integrate predicted fragment intensities and retention times into mass spectrometry analysis.
homepage: https://compomics.github.io/projects/ms2rescore/
---


# ms2rescore

## Overview
ms2rescore is a post-processing tool designed to increase the number of confident peptide identifications from mass spectrometry data. It functions by recalculating scores for search engine outputs (like MaxQuant, Mascot, or Tandem) using machine learning. By comparing observed spectra and retention times against AI-predicted values, it provides better separation between true and false identifications than traditional search engine scores alone.

## Command Line Usage
The primary interface for ms2rescore is the command line. It typically requires an identification file and the corresponding raw MS data.

### Basic Execution
To run a standard rescoring pipeline:
```bash
ms2rescore --psm_file <identifications.mzid> --spectrum_path <spectra.mgf>
```

### Common Arguments
- `-p, --psm_file`: Path to the peptide-spectrum matches file (supports .mzid, .pin, .csv, or MaxQuant msms.txt).
- `-s, --spectrum_path`: Path to the directory or file containing the MS2 spectra (.mgf, .mzML).
- `-c, --config_file`: Path to a JSON configuration file to customize the rescoring behavior.
- `-o, --output_path`: Base name for the output files.

### Feature Generators
ms2rescore leverages specific engines to generate additional features:
- **MS2PIP**: Predicts fragment ion intensities to calculate correlation features.
- **DeepLC**: Predicts retention times to calculate RT error features.

## Best Practices
- **Input Validation**: Ensure that the modifications in your search engine output match the naming conventions expected by MS2PIP (e.g., Unimod accessions).
- **Decoy Strategy**: Ensure your input file contains decoy hits, as ms2rescore relies on a target-decoy approach for Percolator or Mokapot integration.
- **Resource Management**: For large datasets, ensure sufficient memory is available, as predicting intensities for millions of peptides can be computationally intensive.

## Reference documentation
- [ms2rescore Overview](./references/anaconda_org_channels_bioconda_packages_ms2rescore_overview.md)