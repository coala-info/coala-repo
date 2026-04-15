---
name: pyteomics
description: Pyteomics is a Python framework for parsing proteomics data and calculating physico-chemical properties of polypeptides. Use when user asks to parse mass spectrometry files, calculate peptide masses or isoelectric points, simulate protein digestion, or manage FASTA databases.
homepage: https://github.com/levitsky/pyteomics
metadata:
  docker_image: "quay.io/biocontainers/pyteomics:4.7.5--pyh7e72e81_0"
---

# pyteomics

## Overview
Pyteomics is a comprehensive Python framework designed to streamline the handling of proteomics data. It provides a programmatic interface for common tasks that would otherwise require complex custom parsing or manual calculation. Use this skill to automate the extraction of information from mass spectrometry data files, calculate theoretical properties of polypeptides, and manage protein sequence databases. It is particularly effective for building reproducible bioinformatics pipelines and rapid prototyping of proteomics software.

## Core Functionality and Usage

### Installation
Install the library via bioconda for the most stable environment:
```bash
conda install bioconda::pyteomics
```

### Calculating Physico-chemical Properties
Use the `mass` and `electrochem` modules to derive theoretical values from sequences.
*   **Mass Calculation**: Calculate the exact mass of a peptide sequence.
*   **Isoelectric Point (pI)**: Estimate the pI and charge at specific pH levels.
*   **Isotopic Distribution**: Generate theoretical isotopic patterns for given compositions.

### Parsing Proteomics Data Formats
Pyteomics provides specialized modules for reading common file types. Always use the `read` function within a context manager or as an iterator to manage memory efficiently.

*   **Spectra (MGF, mzML)**: Access peak lists and metadata.
    *   `pyteomics.mgf.read(file)`: Returns an iterator over spectra dictionaries.
    *   `pyteomics.mzml.read(file)`: Provides access to mzML data, including chromatograms.
*   **Databases (FASTA)**: Iterate through protein entries.
    *   `pyteomics.fasta.read(file)`: Yields tuples of (description, sequence).
*   **Search Results (mzIdentML, pepXML)**: Parse identification results from various search engines.

### Sequence Manipulation
The `parser` module is essential for handling modified peptides.
*   **Cleavage**: Simulate protein digestion (e.g., trypsin) using `parser.cleave`.
*   **Modifications**: Parse sequences with modifications in various formats (e.g., ProForma).
*   **Composition**: Convert a sequence string into a chemical composition dictionary using `parser.fast_composition`.

## Best Practices and Expert Tips
*   **Memory Management**: For large LC-MS/MS datasets (mzML), use `indexed=True` in the reader to allow random access to spectra by ID without loading the entire file into RAM.
*   **Modification Handling**: When calculating mass for modified peptides, provide a `aa_mass` dictionary to the `mass.calculate_mass` function to account for specific mass shifts.
*   **Standard Ion Types**: Use the library's built-in definitions for standard ion types (a, b, y, etc.) when annotating spectra to ensure consistency with community standards.
*   **Data Access**: Use `get_by_id()` when working with indexed mzML or MGF files to quickly retrieve specific scans by their native ID or index.

## Reference documentation
- [What is Pyteomics?](./references/github_com_levitsky_pyteomics.md)
- [Pyteomics Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyteomics_overview.md)