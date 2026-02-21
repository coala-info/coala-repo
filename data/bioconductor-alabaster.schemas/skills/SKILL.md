---
name: bioconductor-alabaster.schemas
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.schemas.html
---

# bioconductor-alabaster.schemas

name: bioconductor-alabaster.schemas
description: Access and manage JSON metadata schemas for Bioconductor objects within the alabaster framework. Use this skill when you need to locate, list, or utilize schemas for validating and serializing objects like SummarizedExperiment, SingleCellExperiment, and DelayedArray for the ArtifactDB ecosystem.

## Overview

The `alabaster.schemas` package provides a local repository of JSON schemas used by the `alabaster` framework (e.g., `alabaster.base`) to represent Bioconductor objects on disk. These schemas ensure that serialized metadata is consistent, versioned, and compatible with the ArtifactDB specification. While primarily used internally by other `alabaster` packages, it is essential for developers creating new object representations or users debugging metadata validation issues.

## Basic Usage

### Listing Available Schemas

To see all schemas currently bundled with the package, use the `listSchemas()` function. This returns a character vector of schema names (e.g., "summarized_experiment/v1.json").

```r
library(alabaster.schemas)
all_schemas <- listSchemas()
head(all_schemas)
```

### Locating a Schema File

To get the absolute path to a specific schema file for use in validation or inspection, use `getSchemaPath()`.

```r
# Get path for a specific object type
schema_path <- getSchemaPath("summarized_experiment/v1.json")
print(schema_path)

# Read the schema (requires a JSON parser like jsonlite)
schema_content <- jsonlite::fromJSON(schema_path)
```

## Typical Workflows

### Validating Metadata

When manually constructing metadata for a Bioconductor object to be saved in the `alabaster` format, you can use these schemas to validate your JSON structure before writing to disk.

```r
library(alabaster.schemas)
library(jsonlite)
library(jsonvalidate)

# 1. Identify the schema
s_path <- getSchemaPath("bioconductor/v1.json")

# 2. Your metadata object
my_metadata <- list(
    bioconductor_version = "3.17",
    package_version = "1.0.0",
    ...
)

# 3. Validate
v <- jsonvalidate::json_validator(s_path)
is_valid <- v(jsonlite::toJSON(my_metadata, auto_unbox = TRUE))

if (!is_valid) {
    print(attr(is_valid, "errors"))
}
```

### Extending the Framework

If you are developing a new `alabaster` extension for a custom Bioconductor class, you use `alabaster.schemas` as a reference to ensure your new schema inherits correctly from base schemas (like `base/v1.json`).

## Tips

- **Schema Versions**: Always check the version suffix (e.g., `v1.json`) in the schema name. The `alabaster` framework relies on these versions to maintain backward compatibility.
- **Human-Readable Docs**: For a more detailed look at the properties required by each schema without reading raw JSON, refer to the ArtifactDB BiocObjectSchemas documentation online.
- **Internal Use**: Most users will interact with these schemas indirectly through functions like `alabaster.base::saveObject()`. Direct use of `alabaster.schemas` is typically reserved for low-level metadata manipulation or framework development.

## Reference documentation

- [Metadata schemas for Bioconductor objects](./references/userguide.md)