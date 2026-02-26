---
name: atlas-metadata-validator
description: This tool validates MAGE-TAB files for compatibility with EBI Gene Expression Group analysis pipelines. Use when user asks to verify IDF and SDRF files, check metadata for experiment types like single-cell or microarray, or validate Human Cell Atlas imports.
homepage: https://github.com/ebi-gene-expression-group/atlas-metadata-validator
---


# atlas-metadata-validator

## Overview

The `atlas-metadata-validator` is a specialized Python tool designed to verify that MAGE-TAB files are compatible with the analysis pipelines used by the EBI Gene Expression Group. It parses Investigation Description Format (IDF) and Sample and Data Relationship Format (SDRF) files to identify errors before they cause failures in downstream processing. The tool automatically detects experiment types—such as bulk sequencing, microarray, or single-cell—and applies the relevant validation rules, including specific checks for Single Cell Expression Atlas (SCXA) and Human Cell Atlas (HCA) imports.

## Installation and Setup

The tool can be installed via Conda or pip:

```bash
# Via Conda
conda install bioconda::atlas-metadata-validator

# Via pip
pip install atlas-metadata-validator
```

### Configuration Environment Variables
The validator relies on external configuration for controlled vocabulary. You can override the defaults using these variables:
- `VALIDATION_CONFIG_REPO`: URL of the configuration repository.
- `VALIDATION_CONFIG_FILE`: Name of the JSON config file (default: `atlas_validation_config.json`).
- `VALIDATION_CONFIG_LOCAL_PATH`: Local directory to store downloaded config files.

## Command Line Usage

The primary entry point is the `atlas_validation.py` script. It typically expects the path to an IDF file.

### Basic Validation
By default, the script assumes the SDRF file is in the same directory as the IDF file.
```bash
atlas_validation.py path/to/experiment.idf.txt
```

### Specifying Data Locations
If your SDRF or associated data files are located elsewhere, use the `-d` flag:
```bash
atlas_validation.py path/to/experiment.idf.txt -d /path/to/metadata_folder/
```

### Forcing Experiment Types
While the tool attempts to guess the experiment type, you can manually specify it to ensure the correct rule set is applied:
- `-sc`: Single-cell RNA-seq
- `-seq`: Bulk sequencing
- `-ma`: Microarray

```bash
atlas_validation.py path/to/experiment.idf.txt -sc
```

### Performance and Verbosity
- **Skip URI Checks**: Validation of external URIs can be slow. Use `-x` to skip these checks during rapid iteration.
- **Verbose Mode**: Use `-v` to see detailed logging of the validation process.

```bash
atlas_validation.py path/to/experiment.idf.txt -x -v
```

### HCA Validation
For experiments imported from the Human Cell Atlas, use the `-hca` flag to trigger specific validation logic:
```bash
atlas_validation.py path/to/experiment.idf.txt -hca
```

## Expert Tips

- **Log Files**: The validator generates a log file in the same directory as the input IDF file. Always check this log for a detailed breakdown of failed validation rules.
- **Controlled Vocabulary**: If validation fails due to "unknown terms," ensure your environment has internet access to fetch the latest `atlas_validation_config.json` or point `VALIDATION_CONFIG_LOCAL_PATH` to a pre-downloaded version.
- **SDRF Fields**: For single-cell experiments, the tool specifically checks for fields required by the SCXA workflow, such as `FASTQ_URI` or `SRA_URI`. Ensure at least one download field is present if the experiment is not an AnnData ingestion.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_ebi-gene-expression-group_atlas-metadata-validator.md)
- [Anaconda Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_atlas-metadata-validator_overview.md)