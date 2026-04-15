---
name: dia_umpire
description: DIA-Umpire is a computational framework for processing DIA mass spectrometry data by extracting pseudo-MS/MS spectra for protein identification and quantification. Use when user asks to extract pseudo-MS/MS spectra from DIA signals, perform untargeted proteomics, or quantify proteins from mass spectrometry data.
homepage: https://github.com/Nesvilab/DIA-Umpire
metadata:
  docker_image: "biocontainers/dia-umpire:v2.1.2_cv4"
---

# dia_umpire

## Overview
DIA-Umpire is a Java-based computational framework for the processing of DIA mass spectrometry data. It enables researchers to perform untargeted proteomics by extracting pseudo-MS/MS spectra from complex DIA signals, which can then be searched using traditional database search engines. The tool also supports targeted extraction to improve quantification consistency and provides modules for protein-level quantification.

## Execution Patterns

### Signal Extraction (Pseudo-MS/MS Generation)
The primary entry point for DIA-Umpire is the Signal Extraction (SE) module. This converts raw DIA files into searchable pseudo-MS/MS spectra.

```bash
java -jar -Xmx8G DIA_Umpire_SE.jar <input_file.mzXML> <params_file.se_params>
```

### Memory Management
DIA-Umpire is memory-intensive. Follow these RAM allocation guidelines based on your input file size:
- **64-bit mzXML**: Allocate RAM equal to the file size (e.g., 16GB RAM for a 16GB file).
- **32-bit mzXML (no zlib compression)**: Allocate RAM at least double the file size.
- Use the `-Xmx` flag to specify the maximum heap size (e.g., `-Xmx32G`).

### Workflow Scenarios
Depending on the research goal, combine modules as follows:
1. **Identification Only**: Run `DIA_Umpire_SE` followed by a database search engine.
2. **Small Scale ID & Quant**: Run `DIA_Umpire_SE` -> Database Search -> `DIA_Umpire_Quant`.
3. **Complete Analysis**: Run the full pipeline including targeted extraction to minimize missing values.

## Best Practices and Tips
- **Input Formats**: While mzXML is the primary format, the tool also supports mzML via the underlying `SpectrumParser`.
- **Parameter Files**: Ensure your `.se_params` file is correctly configured for your instrument's isolation window settings and mass accuracy.
- **DDA Quantification**: For DDA (Data Dependent Acquisition) data, use the `MS1Quant` module for feature-detection-based quantification.
- **Java Version**: Ensure Java 7 or higher is installed in the environment.
- **Output**: The SE module generates several files, including `_Q1.mzXML`, `_Q2.mzXML`, and `_Q3.mzXML`, representing different precursor charge states or window segments.

## Reference documentation
- [DIA-Umpire GitHub Repository](./references/github_com_Nesvilab_DIA-Umpire.md)
- [DIA-Umpire Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dia_umpire_overview.md)