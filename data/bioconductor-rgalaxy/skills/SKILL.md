---
name: bioconductor-rgalaxy
description: This tool automates the creation of Galaxy tool wrappers from R functions. Use when user asks to expose R functions as Galaxy tools, define Galaxy-compatible parameters, or generate XML configuration files for Galaxy integration.
homepage: https://bioconductor.org/packages/3.14/bioc/html/RGalaxy.html
---

# bioconductor-rgalaxy

name: bioconductor-rgalaxy
description: Automating the creation of Galaxy tool wrappers from R functions. Use this skill when you need to expose R functions as Galaxy tools, define Galaxy-compatible parameters (GalaxyNumericParam, GalaxyCharacterParam, etc.), or generate the required XML configuration files for Galaxy integration.

# bioconductor-rgalaxy

## Overview

The `RGalaxy` package simplifies the process of making R functions available within the Galaxy web-based platform. Instead of manually writing complex XML tool wrappers, `RGalaxy` extracts metadata directly from R function signatures and their associated documentation (man pages). It supports various parameter types, functional testing, and performance optimization via Rserve.

## Core Workflow

### 1. Define a Galaxy-Compatible Function
Functions must specify parameter types using `RGalaxy` classes and define outputs as function arguments.

```r
library(RGalaxy)

my_tool_function <- function(
    input_num = GalaxyNumericParam(required=TRUE, testValues=10),
    input_text = GalaxyCharacterParam(required=TRUE, testValues="sample"),
    output_file = GalaxyOutput("result", "txt")
) {
    # Logic: Write results to the output_file path
    result <- paste("Processed:", input_num, input_text)
    cat(result, file = output_file)
}
```

### 2. Document the Function
A standard R manual page (.Rd file) is required. `RGalaxy` uses the `title`, `description`, and `arguments` sections to populate the Galaxy UI.
- **Required sections**: `name`, `alias`, `title`, `description`, `usage`, `arguments`.
- **Recommended**: `details` (provides the help text in Galaxy).

### 3. Generate the Galaxy Tool
Use the `galaxy()` function to create the XML wrapper and register the tool.

```r
# Define configuration
config <- GalaxyConfig(
    galaxyHome = "/path/to/galaxy-dist", 
    toolDir = "my_tools", 
    sectionName = "R Tools", 
    sectionId = "r_tools_id"
)

# Generate tool
galaxy("my_tool_function", galaxyConfig = config)
```

## Parameter Types
Use these classes in the function signature to enforce Galaxy UI behavior:
- `GalaxyNumericParam()`: For integers or doubles.
- `GalaxyCharacterParam()`: For text input.
- `GalaxyLogicalParam()`: For checkboxes/boolean.
- `GalaxyIntegerParam()`: Specifically for integers.
- `GalaxyOutput(basename, format)`: Defines the output file name and extension (e.g., "txt", "csv", "pdf").

## Functional Testing
To automate testing, provide `testValues` in the parameter definitions and create an expected output file in the package directory `inst/functionalTests/functionName/outputName`.

```r
# Run test within R
runFunctionalTest(my_tool_function)
```

## Best Practices
- **Error Handling**: Use `gstop("message")` to pass error messages to the Galaxy interface. Use `gwarning()` for non-fatal alerts.
- **Dependencies**: Load required libraries inside the function body using `library()` or `requireNamespace()`.
- **Performance**: For tools with heavy package dependencies, use `RserveConnection()` within the `galaxy()` call to keep an R session warm, reducing tool startup time.
- **Package Structure**: While functions can be standalone, it is highly recommended to keep them within a formal R package for better metadata extraction.

## Reference documentation
- [RGalaxy](./references/RGalaxy-vignette.md)