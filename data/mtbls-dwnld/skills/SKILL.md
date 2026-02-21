---
name: mtbls-dwnld
description: The `mtbls-dwnld` tool is a specialized utility for fetching and preparing metabolomics datasets from the MetaboLights database.
homepage: https://github.com/workflow4metabolomics/mtbls-dwnld
---

# mtbls-dwnld

## Overview
The `mtbls-dwnld` tool is a specialized utility for fetching and preparing metabolomics datasets from the MetaboLights database. It streamlines the process of downloading large-scale study data, including raw files (mzML/mzData) and metadata. Beyond simple downloading, it integrates with `isatools` to convert ISA-Tab metadata into the specific formats required by the Workflow4Metabolomics platform, making it an essential first step in metabolomics data processing pipelines.

## Core Functionalities
The tool operates based on several key parameters that define the scope and method of the data retrieval:

- **Download Protocols**: Supports standard `wget` for general use and `ascp` (Aspera Secure Copy) for high-speed transfers of large datasets.
- **Access Control**: Handles both public repository data and private studies (typically requiring a security token).
- **Data Extraction**: Capable of downloading specific assays or entire studies, with automatic unzipping of compressed archives.
- **W4M Integration**: Automatically converts ISA-Tab metadata files into W4M-compatible formats during the download process.

## Usage Best Practices

### Environment Requirements
Ensure the following dependencies are available in the execution environment:
- **Python**: Version 3.8 or higher.
- **Libraries**: `isatools` (version 0.10.3 or greater).
- **System Tools**: `unzip`, `wget`, and `ascp` (version 3.7.4+ for Aspera transfers).

### Protocol Selection
- Use **Aspera (`ascp`)** for large studies or when working with raw mass spectrometry files (mzML/mzData) to significantly reduce transfer times.
- Use **Wget** for smaller metadata-only downloads or in environments where Aspera ports are restricted.

### Handling Study Types
- **Public Studies**: Can be downloaded directly using the MetaboLights ID (e.g., MTBLS29).
- **Private Studies**: Ensure you have the appropriate authorization. The tool requires explicit confirmation of the study's private status to handle authentication headers correctly.

### Data Organization
- When downloading mzML or mzData files, the tool can organize them into collections, which is the preferred structure for downstream Galaxy/W4M workflows.
- Use the assay selection feature to limit downloads to specific experimental subsets, saving bandwidth and storage when only a portion of a large study is relevant.

## Common Workflow Patterns
1. **Full Study Retrieval**: Download all assays and raw data, followed by an automatic conversion to W4M format for immediate analysis.
2. **Metadata Slicing**: Retrieve study metadata and slice it based on specific factor values (e.g., treatment vs. control) to prepare subset-specific workflows.
3. **Collection Building**: Download raw data files directly into a structured collection format compatible with metabolomics processing tools.

## Reference documentation
- [Metabolights Downloader README](./references/github_com_workflow4metabolomics_mtbls-dwnld.md)