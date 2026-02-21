---
name: beacon2-ri-tools
description: The `beacon2-ri-tools` suite is the reference implementation for Beacon v2 data ingestion.
homepage: https://github.com/EGA-archive/beacon2-ri-tools/tree/main
---

# beacon2-ri-tools

## Overview
The `beacon2-ri-tools` suite is the reference implementation for Beacon v2 data ingestion. It streamlines the complex process of annotating genomic variations and converting them into queryable JSON structures that follow official Beacon v2 specifications. This skill helps users navigate the transformation pipeline, from raw VCF files to a fully populated MongoDB instance ready for the Beacon API.

## Core CLI Usage
The primary tool is the `beacon` script, which manages the data lifecycle through three operational modes.

### Operational Modes
- **vcf**: Converts VCF data into annotated BFF (Beacon Friendly Format) JSON files.
- **mongodb**: Handles the ingestion of pre-existing BFF JSON files into the database.
- **full**: Performs both the VCF transformation and the MongoDB ingestion in a single workflow.

### Common Command Patterns
Transform a VCF file using a specific parameters file:
`beacon vcf -i data.vcf.gz -p params.in`

Execute the full pipeline (transform and load) using multiple CPU cores:
`beacon full -i data.vcf.gz -p params.in -n 4`

Load data into MongoDB using a custom configuration file:
`beacon mongodb -c custom_config.yaml`

## Key Arguments and Options
- `-i | --input`: Path to the input file (typically a compressed VCF).
- `-p | --parameters`: Path to a parameters file defining project-specific variables like `projectdir`.
- `-c | --config`: Path to the YAML configuration file containing paths to external tools (SnpEff, bcftools) and database credentials.
- `-n`: Number of CPUs/threads to allocate for parallel processing.
- `-debug [1-5]`: Enables debugging output; level 5 provides maximum verbosity.
- `-verbose`: Enables standard verbosity for progress tracking.

## Expert Tips and Best Practices
- **Pre-Ingestion Validation**: Before loading data into a production database, use the `bff-validator` utility located in the `utils/` directory. This ensures your JSON files strictly adhere to the Beacon v2 schema.
- **Docker Volume Mapping**: When using the containerized version, always mount your local data directory to the container using the `-v` flag (e.g., `docker run -v /path/to/data:/data`). This allows the `beacon` tool to access your files and write outputs back to your host machine.
- **Parameter Management**: Use the `projectdir` parameter in your parameters file to keep outputs organized. The tool generates several intermediate files (like `genomicVariationsVcf.json.gz`) that are easier to manage in dedicated directories.
- **External Tool Dependencies**: If running outside of Docker, ensure that `bcftools` and `SnpEff` are in your system path or explicitly defined in your configuration file, as the `vcf` mode relies on them for functional annotation.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_EGA-archive_beacon2-ri-tools_tree_main.md)
- [BFF Validator README](./references/github_com_EGA-archive_beacon2-ri-tools_blob_main_utils_bff_validator_README.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_beacon2-ri-tools_overview.md)