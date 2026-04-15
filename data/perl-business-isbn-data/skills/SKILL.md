---
name: perl-business-isbn-data
description: This tool provides the publisher prefix and range data required for parsing and validating ISBNs in Perl. Use when user asks to install ISBN data packs, update ISBN range messages, or synchronize dependencies for ISBN processing.
homepage: https://github.com/briandfoy/business-isbn-data
metadata:
  docker_image: "quay.io/biocontainers/perl-business-isbn-data:20210112.006--pl5321hdfd78af_0"
---

# perl-business-isbn-data

## Overview

This skill manages the data backbone for ISBN processing in Perl. While the `Business::ISBN` module handles the logic for parsing and checksum validation, `Business::ISBN::Data` provides the frequently updated range messages and publisher prefix data. It is essential for ensuring that new ISBN assignments are correctly recognized, partitioned, and formatted. Use this skill to handle installation, data verification, and dependency synchronization for ISBN-related tasks.

## Installation and Setup

The data pack is available via multiple package managers. Choose the one matching your environment:

- **Conda (Bioconda):**
  ```bash
  conda install bioconda::perl-business-isbn-data
  ```
- **CPAN/CPANM:**
  ```bash
  cpan Business::ISBN::Data
  # OR
  cpanm Business::ISBN::Data
  ```
- **Manual Build:**
  ```bash
  perl Makefile.PL
  make
  make test
  make install
  ```

## Critical Dependency Management

The internal data structure of this module changed significantly in version 20191107. 

- **Version Requirement:** You must have `Business::ISBN` version **3.005** or higher to use the current data structure.
- **Syncing:** If you update `Business::ISBN::Data` manually, ensure you also update the main `Business::ISBN` module to prevent parsing errors.
- **Verification:** To check your current installed version and documentation:
  ```bash
  perldoc Business::ISBN::Data
  ```

## Data Verification and Security

For versions starting with `v20240716.001`, the maintainer provides GitHub Attestations to verify the integrity of the distribution.

1. **Login to GitHub CLI:**
   ```bash
   gh auth login
   ```
2. **Verify the Archive:**
   ```bash
   gh attestation verify Business-ISBN-Data-[VERSION].tar.gz --owner briandfoy
   ```

## Expert Tips

- **Independent Updates:** ISBN range data (the `RangeMessage.xml` source) changes more frequently than the Perl code logic. You can often fix "Unknown ISBN" errors simply by updating this data package without changing your application code.
- **Testing Environment:** If you are troubleshooting specific ISBN ranges, run the included test suite in the distribution directory (`make test`) to ensure the local data pack correctly identifies current valid ranges.
- **Data Inspection:** If you need to see the raw data structure being used by the module, you can inspect the `lib/Business/ISBN/Data.pm` file or use `perldoc -m Business::ISBN::Data`.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-business-isbn-data_overview.md)
- [Business::ISBN::Data GitHub Repository](./references/github_com_briandfoy_business-isbn-data.md)
- [Security Policy and Attestations](./references/github_com_briandfoy_business-isbn-data_security.md)