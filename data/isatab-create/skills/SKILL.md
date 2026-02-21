---
name: isatab-create
description: The `isatab-create` tool is a containerized implementation of the `isatools.create.models` module from the ISA-API.
homepage: https://github.com/phnmnl/container-isatab-create
---

# isatab-create

## Overview
The `isatab-create` tool is a containerized implementation of the `isatools.create.models` module from the ISA-API. It automates the generation of ISA-Tab datasets, which are the standard format for describing experimental metadata in the life sciences. This skill helps you configure and run the tool to produce valid metadata bundles from experimental design specifications, facilitating data deposition into repositories like MetaboLights.

## CLI Usage and Patterns

The tool is primarily executed via Docker. The core requirement is a JSON file containing the experimental design parameters.

### Basic Command
```bash
docker run docker-registry.phenomenal-h2020.eu/phnmnl/isatab-create \
  --galaxy_parameters_file <path_to_json_parameters>
```

### Input Parameter Requirements
The tool expects a JSON file (often referred to as a Galaxy parameters file) that defines the study structure. Key components to include in your input logic:
- **Study Design**: Define the type of study (e.g., intervention, comparative).
- **Factors**: List experimental variables such as dose, time point, or genotype.
- **Assays**: Specify the technology used (MS or NMR) and the measurement type.
- **Samples**: Define the number of samples and their relationship to experimental factors.

## Best Practices and Expert Tips

### 1. Data Type Specificity
Ensure that the assay type is explicitly defined as either `MS` or `NMR`. The underlying ISA-API models use different validation rules and metadata fields for these two technologies.

### 2. Volume Mounting
When running via Docker, always mount your local directory to the container to ensure the input JSON is accessible and the generated ISA-Tab files are persisted to your host machine.
```bash
docker run -v $(pwd):/data \
  docker-registry.phenomenal-h2020.eu/phnmnl/isatab-create \
  --galaxy_parameters_file /data/params.json
```

### 3. Validation Pre-flight
Since this tool is a wrapper for the ISA-API, ensure your experimental design objects are complete. Missing factor values or undefined protocols in the input JSON will result in incomplete `i_investigation.txt` files.

### 4. Metabolomics Focus
While the ISA-API is general-purpose, this specific container is optimized for metabolomics. Use it to generate the specific columns required for metabolomics assays, such as "Metabolite Assignment File" references.

## Reference documentation
- [isatab-create: ISA Create tool for Metabolomics](./references/github_com_phnmnl_container-isatab-create_blob_master_README.md)