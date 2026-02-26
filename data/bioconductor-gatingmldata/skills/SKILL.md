---
name: bioconductor-gatingmldata
description: This package provides Gating-ML test data and XML files for validating flow cytometry gating compliance. Use when user asks to access Gating-ML compliance suites, test flowCore or flowUtils standards, or retrieve reference XML and FCS files for flow cytometry data analysis.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/gatingMLData.html
---


# bioconductor-gatingmldata

name: bioconductor-gatingmldata
description: Specialized skill for using the Bioconductor package gatingMLData. Use this skill when you need to access Gating-ML (1.5 and 2.0) test data, XML files, and compliance suites for flow cytometry data analysis, specifically for testing flowUtils and flowCore compliance.

# bioconductor-gatingmldata

## Overview
The `gatingMLData` package is a specialized Bioconductor ExperimentData package. It provides the necessary XML files and flow cytometry data (FCS) required to test the compliance of R packages (primarily `flowUtils` and `flowCore`) with Gating-ML standards. It is essential for developers and researchers who need to validate that their gating logic and XML transformations adhere to version 1.5 or 2.0 of the Gating-ML specification.

## Loading the Package and Data
To use the resources provided by this package, load it into the R environment:

```R
library(gatingMLData)
```

The package primarily serves as a data repository. The files are stored within the package installation directory. To locate the test files, use `system.file`:

```R
# List files in the package to see available test suites
list.files(system.file("extdata", package = "gatingMLData"))

# Access specific Gating-ML 2.0 files
gating_xml_path <- system.file("extdata/Gating-MLFiles", package = "gatingMLData")
```

## Typical Workflow: Compliance Testing
The most common use case for `gatingMLData` is in conjunction with the `flowUtils` package to run compliance tests.

1. **Load the libraries**:
   ```R
   library(gatingMLData)
   library(flowUtils)
   ```

2. **Run Compliance Tests**:
   The `testGatingMLCompliance` function in `flowUtils` automatically looks for data provided by `gatingMLData`.
   ```R
   # This function typically requires gatingMLData to be installed
   # to validate flowCore/flowUtils against Gating-ML standards
   testGatingMLCompliance()
   ```

## Key Components
- **XML Files**: Located in `extdata/Gating-MLFiles`, these contain the formal definitions of gates (rectangular, polygon, quadrant, etc.) as defined by the ISAC standard.
- **FCS Files**: Corresponding flow cytometry data files used to verify that the gates defined in the XML produce the expected statistical results (cell counts/indices).

## Tips
- This package is an "Experiment Data" package; it contains data rather than complex analytical functions.
- If you are developing a new gating algorithm and want to ensure it is Gating-ML compliant, use these files as your "Gold Standard" reference.
- Always check the version of Gating-ML you are targeting (1.5 vs 2.0), as the XML schema and supported gate types differ significantly.

## Reference documentation
- [gatingMLData Reference Manual](./references/reference_manual.md)