---
name: grz-pydantic-models
description: This library provides the official Pydantic implementation of the GRZ metadata schema for validating and parsing genomic data submissions. Use when user asks to validate GRZ metadata, check supported schema versions, or generate JSON schemas for genomic reporting.
homepage: https://github.com/BfArM-MVH/grz-pydantic-models
metadata:
  docker_image: "quay.io/biocontainers/grz-pydantic-models:2.5.0--pyh0648b3f_0"
---

# grz-pydantic-models

## Overview

The `grz-pydantic-models` library provides the official Pydantic implementation of the GRZ metadata schema. It is used to ensure that genomic data submissions and associated reports conform to the structural and validation requirements of the GRZ ecosystem. Use this skill to programmatically handle GRZ metadata, check for schema version compatibility, and generate JSON schemas for validation in external tools.

## Installation

Install the package via Conda from the Bioconda channel:

```bash
conda install bioconda::grz-pydantic-models
```

## Core Usage Patterns

### Validating and Parsing Metadata
The library is primarily used to parse JSON metadata into structured Python objects.

```python
from grz_pydantic_models.v1_1_4.submission import SubmissionMetadata

# Load and validate data
data = {
    "donorPseudonym": "patient_01",
    # ... other GRZ fields
}
metadata = SubmissionMetadata(**data)

# Access validated fields
print(metadata.donorPseudonym)
```

### Checking Supported Schema Versions
The library provides an API to determine which versions of the GRZ schema are supported by the current installation.

```python
from grz_pydantic_models import get_supported_versions

versions = get_supported_versions()
print(f"Supported GRZ versions: {versions}")
```

### Generating JSON Schemas
You can export the underlying JSON schema from the Pydantic models to use for validation in other environments.

```python
import json
from grz_pydantic_models.v1_1_4.submission import SubmissionMetadata

# Generate the JSON schema
schema = SubmissionMetadata.model_json_schema()
print(json.dumps(schema, indent=2))
```

## Best Practices

- **Version Matching**: Always ensure the model version you import (e.g., `v1_1_4`) matches the `$schema` URL in your metadata files.
- **Long-Read Submissions**: For long-read sequencing data (`*_lr`), the models allow for BAM sequencing files which might be restricted in standard short-read models.
- **Prüfbericht Handling**: Use the specific `Prüfbericht` model for test reports to ensure compliance with the latest reporting standards.
- **Threshold Consistency**: When performing quality control, ensure your local thresholds match the keys defined in the model's `thresholds.json` logic to avoid validation errors.

## Expert Tips

- **Handling donorPseudonym**: Be aware of specific string constraints or reserved patterns (like "tanG") when populating donor pseudonyms, as these are subject to specific GRZ validation logic.
- **Schema URL Warnings**: If the library prints warnings about "Unknown schema URL," verify that you are using a "known good" URL that matches the supported versions returned by `get_supported_versions()`.
- **Strict Mode**: Use Pydantic's validation features to catch type mismatches early, especially for complex nested objects in the submission metadata.

## Reference documentation
- [Anaconda Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_grz-pydantic-models_overview.md)
- [GitHub Repository Main](./references/github_com_BfArM-MVH_grz-pydantic-models.md)
- [GitHub Issues and Feature Requests](./references/github_com_BfArM-MVH_grz-pydantic-models_issues.md)