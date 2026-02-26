---
name: container-mtbls-dwnld
description: This tool downloads MetaboLights study data and transforms it into simplified tabular files for metabolomics analysis. Use when user asks to download MetaboLights datasets, convert ISA-Tab files to tabular formats, or prepare metabolomics data for Workflow4Metabolomics.
homepage: https://github.com/phnmnl/container-mtbls-dwnld
---


# container-mtbls-dwnld

## Overview
The container-mtbls-dwnld tool is a specialized downloader designed to bridge the gap between the MetaboLights public repository and the Workflow4Metabolomics (W4M) analytical environment. It automates the retrieval of study data and performs a critical transformation step, turning complex ISA-Tab metadata and experimental results into three simplified tabular files: a sample metadata file, a variable metadata file, and a sample-by-variable data matrix. This tool supports both targeted and untargeted metabolomics approaches across Mass Spectrometry (MS) and Nuclear Magnetic Resonance (NMR) data types.

## Execution and CLI Usage

The tool is primarily distributed as a Docker container. Use the following patterns for execution:

### Basic Command Structure
To view available options and arguments:
```bash
docker run container-registry.phenomenal-h2020.eu/phnmnl/mtbls-dwnld -h
```

### Networking and Performance Optimization
The tool supports two download methods: Aspera (high-speed) and wget (fallback).

*   **Aspera (Recommended):** For significantly faster downloads, ensure your network environment allows UDP connections.
    *   **Requirement:** Open UDP port 33001 (source port) to the container.
    *   **Compatibility:** Most major cloud providers (AWS, GCP) support this by default, but local firewalls may require manual configuration.
*   **Wget Fallback:** If UDP port 33001 is blocked, the tool will automatically fall back to standard HTTP/HTTPS download via wget.

## Best Practices
*   **Output Verification:** Always ensure the tool generates all three required files (Sample metadata, Variable metadata, and the Matrix) before proceeding to downstream W4M modules.
*   **Study IDs:** Ensure you have the correct MetaboLights accession number (e.g., MTBLS1) before initiating the download.
*   **Container Registry:** Use the official PhenoMeNal container registry for the most stable versions: `container-registry.phenomenal-h2020.eu/phnmnl/mtbls-dwnld`.

## Reference documentation
- [W4M Metabolights Downloader README](./references/github_com_phnmnl_container-mtbls-dwnld.md)
- [Tool Dockerfile](./references/github_com_phnmnl_container-mtbls-dwnld_blob_master_Dockerfile.md)