---
name: dia-umpire
description: DIA-Umpire is a computational framework that extracts pseudo-DDA spectra from DIA mass spectrometry data for untargeted proteomics analysis. Use when user asks to extract signals from mzXML files, generate pseudo-MS/MS spectra, perform library searches, or quantify proteins and peptides.
homepage: https://github.com/cctsou/DIA-Umpire
metadata:
  docker_image: "biocontainers/dia-umpire:v2.1.2_cv4"
---

# dia-umpire

## Overview
DIA-Umpire is a Java-based computational framework designed for the untargeted analysis of DIA mass spectrometry proteomics data. It enables the extraction of precursor-fragment groups to generate pseudo-DDA (Data-Dependent Acquisition) spectra, which can then be searched using standard database search engines. This skill provides the command-line patterns required to navigate the multi-step pipeline from raw signal extraction to final protein quantification.

## Core Workflow and CLI Patterns

The DIA-Umpire pipeline consists of several discrete modules. Most modules require a specific parameter file (`.params`) and a Java heap space allocation (typically 8GB-10GB).

### 1. Signal Extraction (SE)
The first step converts DIA files into pseudo-MS/MS spectra.
- **Command**: `java -jar -Xmx8G DIA_Umpire_SE.jar <mzXML_file> <diaumpire.se_params>`
- **Input**: mzXML or mzML file.
- **Output**: Pseudo MS/MS spectra files.

### 2. Untargeted Identification (LCMSIDGen)
Generates untargeted peptide IDs using pepXML files resulting from database searches of the pseudo-spectra.
- **Command**: `java -jar -Xmx10G DIA_Umpire_LCMSIDGen.jar <diaumpire.module_params>`
- **Output**: `.LCMSID` file (required for subsequent library searches).

### 3. Library Searching
DIA-Umpire supports both internal and external library searches to refine identifications. These processes update the existing `.LCMSID` file.

- **Internal Library Search**:
  `java -jar -Xmx10G DIA_Umpire_IntLibSearch.jar <diaumpire.module_params>`
- **External Library Search**:
  `java -jar -Xmx10G DIA_Umpire_ExtLibSearch.jar <diaumpire.module_params>`

### 4. Protein Quantification (ProtQuant)
The final module for quantifying proteins, peptides, and fragments.
- **Command**: `java -jar -Xmx10G DIA_Umpire_ProtQuant.jar <diaumpire.module_params>`
- **Output**: Quantification results in `.csv` format.

### 5. Skyline Integration
To generate raw-intensity pseudo MS/MS spectra without intensity adjustments for use in Skyline:
- **Module**: `DIA-Umpire_To_Skyline`

## Best Practices
- **Memory Management**: Ensure the `-Xmx` flag is set appropriately for your dataset size. 8GB is the minimum for signal extraction, while 10GB+ is recommended for quantification and library searches.
- **Parameter Files**: Maintain separate parameter files for Signal Extraction (`.se_params`) and the downstream modules (`.module_params`).
- **File Formats**: Ensure input files are in `mzXML` or `mzML` format. If using DDA-based MS1 quantification, use the `MS1Quant` tool included in the package.
- **Sequence Processing**: When preparing FASTA files, ensure they do not contain "*" characters, as these can cause errors in the sequence digestion components.

## Reference documentation
- [DIA-Umpire Main README](./references/github_com_cctsou_DIA-Umpire.md)