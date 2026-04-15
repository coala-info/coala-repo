---
name: r-metadig
description: The r-metadig package provides tools to author, test, and run metadata quality checks in R that are compatible with the MetaDIG quality engine. Use when user asks to create metadata quality metrics, validate metadata documents like EML, or test XML-defined quality checks against metadata files.
homepage: https://cran.r-project.org/web/packages/metadig/index.html
---

# r-metadig

## Overview
The `metadig` R package is a client-side tool for the Metadata Improvement and Guidance (MetaDIG) project. it allows developers to author, test, and run metadata quality checks in R that are compatible with the Java-based MetaDIG quality engine. It is primarily used to ensure metadata documents (like EML) conform to specific quality metrics and standards.

## Installation
Install the package from GitHub using the `remotes` package:

```R
# install.packages("remotes")
remotes::install_github("NCEAS/metadig-r")
```

## Core Functions

### Status Reporting
Use these functions to define the outcome of a metadata check. Once a status is set to `FAILURE`, it cannot be reverted to `SUCCESS` within the same check execution.

- `success(message)`: Sets the check status to SUCCESS and attaches an optional descriptive message.
- `failure(message)`: Sets the check status to FAILURE and attaches an optional descriptive message.

### Automated Presence Checks
- `check_presence(name)`: A helper function that checks if a specific metadata element (passed as `name`) is non-NULL. It automatically sets the status to SUCCESS or FAILURE and generates a standard output message (e.g., "Object 'title' was present and was of length 10").

### Testing Engine Checks
To test an XML-defined quality check (the format used by the Java engine) against a metadata file within R:

```R
library(metadig)
library(xml2)

# Path to the check definition (XML containing R source)
checkFile <- system.file("extdata/dataset_title_length-check.xml", package = "metadig")

# Path to the metadata file to be validated
metadataFile <- system.file("extdata/example_EML.xml", package = "metadig")

# Execute the check
results <- runCheck(checkFile, metadataFile)

# results contains $status (SUCCESS, FAILURE, SKIP) and $output
```

## Workflow for Authoring Checks
1. **Identify the Element**: Determine the XPath or metadata element to be tested.
2. **Write Logic**: Use standard R logic to evaluate the element.
3. **Set Status**: Use `success()` or `failure()` based on your logic.
4. **Wrap for Engine**: If the check is intended for the production MetaDIG engine, wrap the R code in the required MetaDIG XML schema.
5. **Validate**: Use `runCheck()` to ensure the R code behaves correctly when triggered by the engine's XML wrapper.

## Reference documentation
- [MetaDIG R Client README](./references/README.md)
- [GitHub Articles](./references/articles.md)
- [Project Home Page](./references/home_page.md)