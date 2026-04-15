---
name: varfish-cli
description: The varfish-cli tool automates the upload of genomic variant data and the management of projects on a VarFish server instance. Use when user asks to import cases, list projects, convert DRAGEN QC metrics, or interact with the VarFish API.
homepage: https://github.com/bihealth/varfish-cli
metadata:
  docker_image: "quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0"
---

# varfish-cli

## Overview

The `varfish-cli` tool is the primary bridge between local genomic data and a VarFish server instance. It allows bioinformaticians to automate the upload of variant calls (SNVs and SVs), manage project structures, and perform administrative tasks without using the web interface. This skill provides the necessary patterns for configuring the tool and executing common workflows like case importation and project navigation.

## Configuration

Before using the tool, ensure a configuration file exists at `~/.varfishrc.toml`.

```toml
[global]
varfish_server_url = "https://varfish.example.com/"
varfish_api_token = "your-secret-api-token"
```

## Common CLI Patterns

### Project Management
To see which projects are available for data upload or analysis:
- `varfish-cli projects project-list`

### Case Importation
Importing a case typically requires a pedigree file (.ped) and variant files.
- **Basic Import**: `varfish-cli importer case-import --project-uuid <UUID> --path-ped <FILE.ped> --path-vcf <FILE.vcf.gz>`
- **Including Structural Variants**: Add `--path-sv-vcf <SV_FILE.vcf.gz>` to the command.
- **Genome Build**: Specify the build if not GRCh37 using `--genome-build GRCh38`.
- **Indexing**: Use the `--index` option during import to trigger database indexing immediately after upload.

### Data Conversion
The tool includes utilities to convert vendor-specific outputs (like Illumina DRAGEN) into VarFish-compatible formats:
- `varfish-cli dragen-to-bam-qc` (Converts DRAGEN QC metrics to legacy VarFish format).

## Expert Tips

- **SSL Verification**: If working with a local server using self-signed certificates, you can bypass SSL checks using the `--no-verify-ssl` flag, though this is not recommended for production environments.
- **Automation**: Use the `project-list` command to programmatically retrieve UUIDs for use in automated upload pipelines.
- **Validation**: Always ensure your VCF files are background-zipped and indexed (.tbi) before attempting an import to prevent transfer errors.



## Subcommands

| Command | Description |
|---------|-------------|
| varfish-cli | varfish-cli |
| varfish-cli | Varfish CLI importer |
| varfish-cli | Varfish CLI tool for managing projects and data. |
| varfish-cli | Varfish CLI tool for interacting with the Varfish API. |
| varfish-cli | varfish-cli |
| varfish-cli | varfish-cli |

## Reference documentation

- [VarFish CLI README](./references/github_com_varfish-org_varfish-cli_blob_main_README.md)
- [Changelog and Version History](./references/github_com_varfish-org_varfish-cli_blob_main_CHANGELOG.md)
- [Configuration Example](./references/github_com_varfish-org_varfish-cli_blob_main_varfishrc.toml.example.md)