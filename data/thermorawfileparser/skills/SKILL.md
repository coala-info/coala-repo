---
name: thermorawfileparser
description: ThermoRawFileParser converts proprietary Thermo Fisher Scientific mass spectrometry RAW files into open-source formats like mzML, MGF, and Parquet. Use when user asks to convert RAW files to mzML or MGF, extract metadata, generate extracted ion chromatograms, or query scan information.
homepage: https://github.com/compomics/ThermoRawFileParser
---

# thermorawfileparser

## Overview

ThermoRawFileParser is a specialized utility designed to bridge the gap between proprietary Thermo RAW data and open-source bioinformatics pipelines. It enables the conversion of mass spectrometry data into formats like mzML (indexed or plain), MGF, and Parquet without requiring a Windows-only environment (via .NET 8 or Mono). Beyond simple conversion, it provides subcommands for targeted data retrieval, such as PROXI-compliant spectra queries and Extracted Ion Chromatogram (XIC) generation, making it a versatile tool for both large-scale data conversion and specific data mining tasks.

## Command Line Usage

The tool is executed via `ThermoRawFileParser.exe` (on Windows/Mono) or `dotnet ThermoRawFileParser.dll` (framework-based).

### Basic Conversion Patterns

*   **Convert a single file to indexed mzML (Default):**
    `ThermoRawFileParser -i=/path/to/data.raw -o=/path/to/output/`
*   **Convert a directory of files to MGF:**
    `ThermoRawFileParser -d=/input/dir -o=/output/dir -f=0`
*   **Convert to Gzipped mzML:**
    `ThermoRawFileParser -i=data.raw -g -f=1`
*   **Extract Metadata only (JSON format):**
    `ThermoRawFileParser -i=data.raw -m=0 -f=4`

### Advanced Filtering and Processing

*   **Filter by MS Level:**
    Use `-L` to specify levels (e.g., only MS1 and MS2):
    `ThermoRawFileParser -i=data.raw -L=1,2`
*   **Disable Native Peak Picking:**
    Use `-p` to output profile data instead of centroided peaks:
    `ThermoRawFileParser -i=data.raw -p`
*   **Include Noise and Charge Data:**
    For high-resolution data in mzML:
    `ThermoRawFileParser -i=data.raw -N -C`
*   **Standard Output (STDOUT):**
    Useful for piping to other tools (implies silent logging):
    `ThermoRawFileParser -i=data.raw -s -f=1`

#

## Expert Tips and Best Practices

*   **Format Selection:** Use `indexed mzML` (`-f=2`) for large files to allow downstream software to access spectra randomly without reading the entire file.
*   **Performance:** When processing files where only specific MS levels are needed, using the `-L` flag significantly speeds up execution in versions 1.4.4+.
*   **Memory/Environment:** On Linux/macOS, ensure the .NET 8 runtime is installed. For older versions (<2.0.0), `mono-complete` is required.
*   **Error Handling:** Use `-w` (warningsAreErrors) in automated pipelines to ensure that any data inconsistencies result in a non-zero exit code.
*   **S3 Integration:** The tool supports direct upload to S3 buckets using the `-u`, `-k`, `-t`, and `-n` flags, which is ideal for cloud-based processing workflows.



## Subcommands

| Command | Description |
|---------|-------------|
| thermorawfileparser_query | Parses Thermo raw files and queries scan information. |
| thermorawfileparser_xic | Parses Thermo Fisher Scientific raw files to extract XIC data. |

## Reference documentation

- [ThermoRawFileParser Main Documentation](./references/github_com_compomics_ThermoRawFileParser.md)
- [ThermoRawFileParser Release Notes](./references/github_com_compomics_ThermoRawFileParser_wiki_ReleaseNotes.md)