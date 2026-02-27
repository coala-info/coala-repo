---
name: bioconductor-rgmqllib
description: This package provides the Java and Scala libraries required to support the Genomic Management Query Language engine within the RGMQL ecosystem. Use when user asks to locate GMQL engine components, troubleshoot RGMQL dependencies, or manually resolve paths to the underlying Java libraries.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RGMQLlib.html
---


# bioconductor-rgmqllib

name: bioconductor-rgmqllib
description: Provides the necessary Java and Scala libraries (JAR files) to support the RGMQL package. Use this skill when you need to locate the GMQL engine components or when troubleshooting dependencies for Genomic Management Query Language (GMQL) operations in R.

# bioconductor-rgmqllib

## Overview

RGMQLlib is a specialized data package that acts as a container for compiled Java and Scala libraries. These libraries provide the underlying engine for the RGMQL package, enabling high-level genomic data management and querying. While users rarely call functions directly from this package, it is a critical dependency for the GMQL ecosystem in Bioconductor.

## Locating Java Libraries

The primary use of this package is to provide the file system path to the GMQL Scala API JAR files.

To locate the directory containing the Java libraries:

```r
library(RGMQLlib)
java_path <- system.file("extdata", "java", package = "RGMQLlib")
list.files(java_path)
```

## Typical Workflow

1. **Dependency Management**: Ensure RGMQLlib is installed alongside RGMQL.
2. **Initialization**: The RGMQL package typically handles the loading of these JARs automatically during its initialization phase.
3. **Manual Path Resolution**: If you are developing extensions or need to manually point a Java Virtual Machine (JVM) to the GMQL libraries, use the `system.file` command shown above.

## Troubleshooting

If RGMQL fails to initialize the GMQL engine:
- Verify that RGMQLlib is correctly installed.
- Check that the `extdata/java` directory exists and contains the expected `.jar` files.
- Ensure your R session has the appropriate permissions to access the package installation directory.

## Reference documentation

- [RGMQLlib](./references/RGMQLlib.md)