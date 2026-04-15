---
name: perl-atlas-modules
description: The perl-atlas-modules package provides a suite of Perl classes and functions for processing transcriptomics data within the EMBL-EBI Expression Atlas production pipeline. Use when user asks to parse MAGE-TAB files, interface with Atlas databases, validate experiment types, or configure the Atlas metadata environment.
homepage: https://github.com/ebi-gene-expression-group/perl-atlas-modules
metadata:
  docker_image: "quay.io/biocontainers/perl-atlas-modules:0.3.1--pl5262hdbdd923_5"
---

# perl-atlas-modules

## Overview
The `perl-atlas-modules` package is a specialized suite of Perl classes and functions that form the backbone of the EMBL-EBI Expression Atlas data production pipeline. It is designed to handle the complex workflows required to process transcriptomics studies, from metadata curation to final data export. This skill helps in configuring the module environment, interfacing with the Atlas databases (including PostgreSQL for Single Cell data), and utilizing the internal logic for validating and transforming study data.

## Installation and Setup
The package is primarily distributed via Bioconda.

```bash
conda install -c bioconda perl-atlas-modules
```

### Configuration Environment
The modules require access to configuration files to function correctly.
- **ATLAS_META_CONFIG**: Set this environment variable to point to your custom configuration directory.
- **Default Behavior**: If the environment variable is not set, the modules will default to the `supporting_files` directory installed with the package.
- **Defaults**: Use the provided `.default` files within the configuration directory to initialize site-specific settings.

## Core Functional Areas
The library is organized into modules that handle specific stages of the Atlas pipeline:

### Metadata and MAGE-TAB Handling
The modules provide logic for parsing and validating MAGE-TAB (IDF and SDRF) files. This includes:
- Handling curated vs. merged IDF files.
- Validating experiment types (e.g., ensuring spatial transcriptomics or proteomics experiments are correctly identified).

### Database Interactions
The package includes specific modules for database connectivity:
- **Database.pm**: General database interface for Atlas production.
- **pgSCXA.pm**: Specialized module for connecting to and updating the PostgreSQL Single Cell Expression Atlas database.

### Analysis and Mapping
- **Baseline/Differential Analysis**: Internal functions for processing different study types.
- **Zooma Mappings**: Logic for handling ontology mappings used in the Atlas.

## Expert Tips and Best Practices
- **Environment Isolation**: When running production pipelines, always explicitly set the `ATLAS_META_CONFIG` variable to ensure the pipeline uses the intended database credentials and metadata schemas rather than the package defaults.
- **Experiment Type Validation**: The library maintains an internal list of allowed ArrayExpress experiment types. If a study fails to process, check if the experiment type (e.g., `proteomics_differential`) is supported in the current version of the modules.
- **Configuration Overrides**: You can override default behaviors by placing modified configuration files in the directory pointed to by `ATLAS_META_CONFIG`. This is the preferred way to handle site-specific paths or database connection strings.

## Reference documentation
- [Atlas in-house perl modules](./references/github_com_ebi-gene-expression-group_perl-atlas-modules.md)
- [perl-atlas-modules Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-atlas-modules_overview.md)