---
name: biowdl-input-converter
description: "biowdl-input-converter converts sample lists into JSON structs for BioWDL pipelines while validating file presence and integrity. Use when user asks to convert a samplesheet to JSON, validate sequencing file paths, or check MD5 checksums before running a BioWDL workflow."
homepage: https://github.com/biowdl/biowdl-input-converter
---


# biowdl-input-converter

## Overview

The `biowdl-input-converter` is a utility designed to streamline the preparation of input data for BioWDL-based genomic pipelines. It transforms simple, human-editable sample lists into complex WDL "structs" in JSON format. Beyond simple conversion, the tool acts as a pre-flight validation layer, ensuring that all referenced sequencing files are present and uncorrupted, which prevents pipeline failures deep into execution.

## Installation

The tool is available via Bioconda. It is recommended to install it within a dedicated Conda environment:

```bash
conda install -c bioconda biowdl-input-converter
```

## Common CLI Patterns

### Basic Conversion
To convert a standard CSV samplesheet to a JSON file for use as a WDL input:

```bash
biowdl-input-converter input_samples.csv > samples.json
```

### Validation and Integrity Checking
One of the most powerful features is the ability to verify the physical presence of files and their integrity:

```bash
biowdl-input-converter --validate input_samples.csv > samples.json
```
*   **File Presence**: Checks if every path defined in the samplesheet exists.
*   **MD5 Verification**: If MD5 columns (e.g., `R1_md5`) are present in the input, the tool calculates the checksum of the local files and compares them to ensure data hasn't been corrupted.

### Explicit Format Specification
If your input file does not have a standard `.csv` extension, or if you want to force a specific parser:

```bash
biowdl-input-converter --fileformat csv input_samples.txt > samples.json
```

### Skipping Duplication Checks
By default, the tool prevents errors caused by copy-pasting rows by checking for duplicate file paths. If your specific workflow requires the same file to be processed multiple times under different sample headers, you may need to look for the skip-check options in the help menu:

```bash
biowdl-input-converter --help
```

## Expert Tips

*   **Pre-Pipeline Validation**: Always run with the `--validate` flag on a head node or login node before submitting a large-scale BioWDL job to a cluster. This catches "File Not Found" errors immediately rather than hours into a pipeline run.
*   **Standardized Columns**: For CSV inputs, ensure your headers align with BioWDL expectations (e.g., `sample`, `library`, `readgroup`, `R1`, `R2`).
*   **Handling Optional Fields**: In version 0.2.0 and later, empty fields in CSV samplesheets are correctly handled as `None` (null) in the resulting JSON, rather than empty strings, ensuring compatibility with WDL optional types.
*   **Python Compatibility**: The tool is tested against Python 3.8 and 3.9; ensure your environment uses a supported version to avoid unexpected parsing behavior.

## Reference documentation
- [BioWDL Input Converter Overview](./references/anaconda_org_channels_bioconda_packages_biowdl-input-converter_overview.md)
- [GitHub Repository and README](./references/github_com_biowdl_biowdl-input-converter.md)
- [Version Tags and Changelog](./references/github_com_biowdl_biowdl-input-converter_tags.md)