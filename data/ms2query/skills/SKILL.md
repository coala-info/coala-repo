---
name: ms2query
description: MS2Query identifies metabolites by using machine learning to perform analogue searching and predict the reliability of MS/MS library matches. Use when user asks to identify metabolites, perform analogue searching, search MS/MS spectra against a library, or predict match quality scores.
homepage: https://github.com/iomega/ms2query
metadata:
  docker_image: "quay.io/biocontainers/ms2query:1.5.4--pyhdfd78af_0"
---

# ms2query

## Overview
MS2Query is a specialized tool for metabolite identification that leverages machine learning to improve the reliability of MS/MS library matching. It excels at "analogue searching"—finding compounds structurally similar to the query even when an exact match is missing from the library. It replaces traditional cosine similarity scores with a multi-feature Random Forest model that predicts a reliability score between 0 and 1, providing a more robust measure of match quality than standard spectral similarity.

## Installation and Setup
Install the tool using pip:
`pip install ms2query`

Before the first run, you must download the pretrained library and models for your specific ionization mode:
`ms2query --library ./library_folder --download --ionmode positive`

## Common CLI Patterns

### Basic Search
Run MS2Query on a single spectrum file. Supported formats include .mgf, .mzML, .json, .msp, .mzxml, and .usi:
`ms2query --spectra ./my_spectra.mgf --library ./library_folder --ionmode positive`

### Batch Processing
If a directory is provided to the spectra argument, all compatible files within that folder will be processed sequentially:
`ms2query --spectra ./spectra_directory/ --library ./library_folder --ionmode negative`

### Advanced Execution Flags
- **Custom Results Folder**: Specify a specific output directory for the generated CSV files.
  `--results ./output_directory`
- **Ion Mode Filtering**: Use this to skip spectra that do not match the specified ionization mode.
  `--filter_ionmode`
- **Additional Metadata**: Include specific metadata fields from the input spectra in the final results CSV.
  `--additional_metadata retention_time feature_id`

## Best Practices and Expert Tips
- **Data Preprocessing**: MS2Query does not perform peak picking or spectral clustering. For complex datasets with multiple scans per feature, it is highly recommended to preprocess data using MZMine (FBMN workflow) to generate a representative MGF file.
- **Interpreting Results**: The primary metric is the `ms2query_model_prediction` column. This score (0 to 1) indicates the likelihood of a high-quality match. Users should establish a threshold (typically > 0.6 or 0.7) to filter out low-confidence analogues.
- **Memory and Performance**: MS2Query uses pre-computed embeddings to enable fast full-library comparisons. Ensure you have sufficient disk space in the library folder for these embeddings and the SQLite database.
- **Library Maintenance**: Use the `--download` flag periodically to ensure you are using the most up-to-date GNPS-based library and model weights.

## Reference documentation
- [MS2Query GitHub Repository](./references/github_com_iomega_ms2query.md)