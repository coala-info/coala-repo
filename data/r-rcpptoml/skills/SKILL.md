---
name: r-rcpptoml
description: The r-rcpptoml package provides R bindings for the C++11 cpptoml parser to read and parse TOML configuration files into R lists. Use when user asks to parse TOML files, read configuration data into R, or convert TOML strings to R objects.
homepage: https://cran.r-project.org/web/packages/rcpptoml/index.html
---


# r-rcpptoml

## Overview
The `rcpptoml` package provides R bindings for the C++11 `cpptoml` parser. It allows R users to read TOML configuration files, which are designed to be more human-readable than JSON and more strongly typed than YAML. It supports TOML v0.5.0 features, including nested tables, arrays of tables, and first-class datetime objects.

## Installation
To install the package from CRAN:
```r
install.packages("rcpptoml")
```

## Core Functions

### Parsing TOML Files
The primary function is `parseTOML()`. It reads a file or a character string and returns a nested R list.

```r
library(rcpptoml)

# Parse a file
config <- parseTOML("config.toml")

# Parse a character string directly
toml_string <- '
title = "Analysis Params"
[params]
threshold = 0.05
iterations = 1000
'
config_list <- parseTOML(toml_string, fromFile = FALSE)
```

## Data Mapping
`rcpptoml` maps TOML types to R types as follows:
- **Integer**: `integer`
- **Float**: `numeric` (double)
- **String**: `character`
- **Boolean**: `logical`
- **Datetime**: `POSIXct`
- **Array**: `vector` (if homogeneous) or `list`
- **Table**: `list` (named)

## Workflows

### Accessing Configuration Data
Since the output is a standard R list, use standard list subsetting:
```r
# Accessing a nested value [database] server = "127.0.0.1"
db_host <- config$database$server

# Accessing an array
ports <- config$database$ports # Returns an integer vector
```

### Handling Datetimes
TOML datetimes are automatically converted to R `POSIXct` objects, making them immediately available for time-series analysis or logging without manual string parsing.

### Validation
To verify the package installation and its parsing capabilities on your system:
```r
tinytest::test_package("rcpptoml")
```

## Tips
- **Comments**: TOML uses `#` for comments. These are ignored by the parser.
- **Indentation**: Indentation is optional in TOML but recommended for readability in nested tables.
- **Unicode**: Note that while most TOML features are supported, there may be limitations regarding specific unicode escape characters in strings depending on the underlying C++ parser version.
- **Multi-line Strings**: Supports triple-quotes `"""` for multi-line strings, which are returned as a single character string in R.

## Reference documentation
- [rcpptoml Home Page](./references/home_page.md)