---
name: searchgui
description: SearchGUI is a unified interface that streamlines the configuration and execution of multiple proteomics search and de novo engines. Use when user asks to configure search parameters, execute protein identification searches across multiple algorithms, or generate decoy sequences for FASTA databases.
homepage: https://github.com/CompOmics/searchgui
---


# searchgui

## Overview
SearchGUI is a unified, open-source interface designed to streamline the configuration and execution of multiple proteomics search and de novo engines, including X! Tandem, MS-GF+, Comet, and MS Amanda. It acts as a wrapper that standardizes inputs and outputs across different algorithms, making it easier to perform simultaneous searches. This skill focuses on the command-line tools (SearchCLI) necessary for integrating SearchGUI into automated bioinformatics pipelines and high-throughput workflows.

## Command Line Interface (CLI) Usage
SearchGUI provides several specialized CLI tools. When installed via Bioconda or Easybuild, these are typically available as direct aliases.

### 1. IdentificationParametersCLI
Use this to create or edit the `.par` file which contains all search settings (modifications, tolerances, enzyme, etc.).
- **Purpose**: Generates the configuration file required by SearchCLI.
- **Key Arguments**:
  - `-out`: Path to the output `.par` file.
  - `-db`: Path to the FASTA database.
  - `-prec_tol`: Precursor ion mass tolerance.
  - `-frag_tol`: Fragment ion mass tolerance.
  - `-enzyme`: Protease used (e.g., "Trypsin").
  - `-fixed_mods`: Comma-separated list of fixed modifications.
  - `-variable_mods`: Comma-separated list of variable modifications.

### 2. SearchCLI
The primary tool for executing the search engines.
- **Basic Pattern**:
  ```bash
  SearchCLI -spectrum <spectrum_files> -fasta <fasta_file> -id_params <parameter_file> -output_folder <folder>
  ```
- **Engine Selection**: Enable specific engines using flags like `-xtandem 1`, `-msgf 1`, `-comet 1`, or `-omssa 1`.
- **Input Formats**: Supports `.mgf` and `.mzML` directly. For Thermo `.raw` files, SearchGUI includes `ThermoRawFileParser` for automatic conversion.

### 3. FastaCLI
Use this for database maintenance and decoy sequence generation.
- **Purpose**: Prepares FASTA files for searching, ensuring they are correctly formatted and indexed for the supported engines.

### 4. PathSettingsCLI
Use this to define where SearchGUI stores temporary files and configuration data.
- **Tip**: Useful in HPC or Docker environments where the default home directory might have restricted write access or limited space.

## Best Practices and Expert Tips
- **Memory Management**: Since SearchGUI runs on Java, ensure the JVM has enough heap space for large datasets by using `-Xmx` flags (e.g., `java -Xmx8G -jar SearchGUI.jar ...`).
- **Docker Integration**: When using the Biocontainers image, always map your local data volumes using `-v`.
  - *Example*: `docker run -v /local/path:/data quay.io/biocontainers/searchgui:X.Y.Z--1 searchgui SearchCLI -spectrum /data/input.mgf ...`
- **Search Engine Verification**: If a search fails, verify the engine's standalone executable works outside of SearchGUI to rule out environment-specific binary issues.
- **Result Analysis**: SearchGUI outputs are designed for seamless import into **PeptideShaker** for visualization and downstream statistical processing.
- **Special Characters**: Avoid spaces or special characters (e.g., `[`, `%`, `æ`) in file paths, especially on Linux systems, as these can cause Java exceptions or search engine failures.

## Reference documentation
- [SearchGUI Introduction](./references/github_com_CompOmics_searchgui.md)
- [SearchGUI Wiki Pages](./references/github_com_CompOmics_searchgui_wiki.md)