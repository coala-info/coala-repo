---
name: opentargets-validator
description: The opentargets-validator verifies that data files conform to the official structural requirements and schemas of the Open Targets Platform. Use when user asks to validate evidence strings, check JSONL files against Open Targets schemas, or verify data formatting before platform ingestion.
homepage: https://github.com/opentargets/validator
metadata:
  docker_image: "quay.io/biocontainers/opentargets-validator:1.0.0--pyhdfd78af_0"
---

# opentargets-validator

## Overview
The `opentargets-validator` is a specialized utility used to verify that data files intended for the Open Targets Platform conform to official structural requirements. It is a critical tool for bioinformatics data providers, ensuring that evidence strings are correctly formatted before they enter the platform's ingestion pipeline. The tool is optimized for JSON-line (JSONL) files, where each line contains a single, independent JSON object, allowing for efficient processing of large-scale datasets.

## Installation
The tool can be installed using standard Python or Bioconda package managers:
- **Pip**: `pip install --upgrade opentargets-validator`
- **Conda**: `conda install bioconda::opentargets-validator`

## Core Usage
The primary command is `opentargets_validator`. It requires two main inputs: a schema file and the data to be validated.

### Basic Validation
To validate a local JSONL file against a local schema:
`opentargets_validator --schema schema.json evidence.json`

### Remote Schema Validation
You can validate local data against the latest official Open Targets schemas hosted on GitHub without downloading them first:
`opentargets_validator --schema https://raw.githubusercontent.com/opentargets/json_schema/master/schemas/disease_target_evidence.json evidence.json`

### Compressed Data Support
The validator natively handles GZIP-compressed files, which is the standard format for large biological datasets:
`opentargets_validator --schema schema.json evidence.json.gz`

## Expert Patterns and Best Practices

### Stream Processing and Sampling
For very large files, it is often more efficient to validate a sample of the data first. Use the `-` character to represent STDIN:
`zcat evidence.json.gz | head -n 100 | opentargets_validator --schema schema.json -`

### Input Requirements
- **One Object Per Line**: Ensure your input file contains exactly one complete JSON object per line. The validator will fail if an object spans multiple lines or if multiple objects are on the same line.
- **Schema Versioning**: When using remote URLs for schemas, prefer specific tags or release versions over the `master` branch to ensure reproducibility in your data pipelines.
- **Flexible Sources**: Both the `--schema` and the data argument accept local paths, uncompressed remote URLs (`https://...`), and GZIP-compressed local files.

### Troubleshooting
- If the validator reports errors, it will typically provide the line number and the specific JSON schema constraint that was violated (e.g., missing required fields or type mismatches).
- Ensure your environment uses Python 3.8 or higher, as older versions are not supported by the current validator (v1.0.0+).

## Reference documentation
- [Open Targets Validator GitHub](./references/github_com_opentargets_validator.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_opentargets-validator_overview.md)