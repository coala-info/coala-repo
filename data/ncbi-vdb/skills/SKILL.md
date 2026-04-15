---
name: ncbi-vdb
description: The ncbi-vdb tool provides the core columnar database engine and libraries required for accessing and managing large-scale genomic sequence data from the NCBI SRA. Use when user asks to install the VDB engine, configure HTTPS data access, troubleshoot SRA database connection errors, or set up the technical environment for SRA Toolkit libraries.
homepage: https://github.com/ncbi/ncbi-vdb
metadata:
  docker_image: "quay.io/biocontainers/ncbi-vdb:3.3.0--h9948957_0"
---

# ncbi-vdb

## Overview
The ncbi-vdb skill provides guidance on managing the core database engine used by the NCBI SRA Toolkit. VDB is a specialized columnar database system designed specifically for storing and accessing large-scale genomic sequence data. While the high-level tools for data extraction (like fastq-dump) reside in the sra-tools package, ncbi-vdb provides the essential libraries and low-level engine required for those tools to function. This skill focuses on the technical environment, installation, and configuration requirements necessary to maintain a functional SRA data access layer.

## Installation and Environment Setup
The VDB engine is most easily managed through the Bioconda channel.

- **Conda Installation**:
  ```bash
  conda install bioconda::ncbi-vdb
  ```
- **Build System**: For developers building from source, the project uses **CMake** (as of version 3.0.0). This is required for cross-platform builds and replaces the legacy Makefile system.
- **Architecture**: Note that as of the 3.0.0 release, NGS (Next Generation Sequencing) libraries and dependencies have been consolidated. Libraries providing access to VDB data via the NGS API are now primarily maintained within the `sra-tools` repository.

## Configuration and Best Practices
- **HTTPS Requirement**: All VDB data access must use HTTPS. Ensure that your environment and any local configuration files are updated to support secure connections, as standard HTTP is no longer supported by NCBI servers.
- **Proxy Configuration**: Using VDB behind a corporate or institutional proxy requires specific configuration due to the transition to HTTPS. If connection errors occur, verify that your environment variables (e.g., `https_proxy`) are correctly exported and that the VDB configuration allows for secure tunneling.
- **Memory Management**: VDB is a columnar system. When reading SRA records, memory consumption can scale with the complexity of the records. If encountering memory issues, ensure you are using the latest version (3.3.0+) which includes various fixes for string handling and memory usage.
- **Verification**: When downloading binaries, always verify MD5 checksums to avoid false positives from anti-virus tools (such as Windows Defender), which have historically flagged components like `test-sra.exe`.

## Troubleshooting
- **Compiler Warnings**: If building from source and encountering errors related to `pshufb` or SSE2, ensure your compiler flags include `-msse2` for systems requiring explicit SIMD support.
- **Path Resolution**: If the VDB manager returns `kptNotFound`, check the integrity of the SRA object path and ensure the environment has appropriate permissions to access the local or remote VDB repository.

## Reference documentation
- [NCBI-VDB Overview](./references/anaconda_org_channels_bioconda_packages_ncbi-vdb_overview.md)
- [NCBI-VDB GitHub Repository](./references/github_com_ncbi_ncbi-vdb.md)
- [NCBI-VDB Wiki](./references/github_com_ncbi_ncbi-vdb_wiki.md)