---
name: isajson-validator
description: The isajson-validator audits ISA-JSON files to identify syntactic errors and metadata inconsistencies against the ISA-JSON schema. Use when user asks to validate ISA-JSON files, check experimental metadata for compliance, or generate validation reports for metabolomics data.
homepage: https://github.com/phnmnl/container-isajson-validator
---


# isajson-validator

## Overview

The `isajson-validator` is a specialized utility that audits ISA-JSON files to identify syntactic errors and metadata inconsistencies. It leverages the ISA-API to produce a comprehensive validation report containing warnings and errors. This tool is primarily used in metabolomics and other life science domains to ensure that experimental metadata is interoperable and adheres to the ISA-JSON schema.

## Command Line Usage

The validator is primarily distributed as a Docker container. To use it effectively, you must mount your local data directory into the container so the tool can access the JSON files.

### Basic Validation
Run the validator against a specific ISA-JSON file:

```bash
docker run --rm -v $(pwd):/data \
  docker-registry.phenomenal-h2020.eu/phnmnl/isajson-validator \
  /data/your_isa_file.json
```

### Expert Tips and Best Practices

*   **Volume Mounting**: Always use absolute paths or the `$(pwd)` variable when mounting volumes to ensure the container correctly maps your local ISA-JSON files to the internal `/data` path.
*   **Interpreting Reports**: The tool distinguishes between "Errors" (which indicate non-compliance with the ISA-JSON schema) and "Warnings" (which suggest missing recommended metadata or potential logical inconsistencies). A successful validation should ideally result in zero errors.
*   **Version Consistency**: This specific implementation is based on ISA-API version 0.9.4. Ensure your ISA-JSON files are exported from a compatible version of the ISA-API to avoid false positives during validation.
*   **Automation**: For batch processing, you can wrap the Docker command in a shell loop to validate multiple files in a directory:
    ```bash
    for f in *.json; do 
      docker run --rm -v $(pwd):/data docker-registry.phenomenal-h2020.eu/phnmnl/isajson-validator "/data/$f"; 
    done
    ```

## Reference documentation

- [ISA-JSON Validator README](./references/github_com_phnmnl_container-isajson-validator.md)