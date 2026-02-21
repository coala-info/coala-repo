---
name: r-yaml
description: Implements the 'libyaml' 'YAML' 1.
homepage: https://cloud.r-project.org/web/packages/yaml/index.html
---

# r-yaml

## Overview
The `yaml` package provides a high-performance interface to the 'libyaml' library. It allows for seamless conversion between R's data structures (lists, vectors, data frames) and YAML (YAML Ain't Markup Language). It is the standard tool in the R ecosystem for handling `.yaml` or `.yml` files, often used in package development, CI/CD configurations, and application settings.

## Installation
Install the package from CRAN:
```r
install.packages("yaml")
```

## Core Functions

### Parsing YAML (Input)
*   `yaml.load(string, ...)`: Convers a YAML string into an R object.
*   `read_yaml(file, ...)`: Reads a YAML file and converts it to an R object.
*   `yaml.load_file(file, ...)`: An alias for `read_yaml`.

### Emitting YAML (Output)
*   `as.yaml(x, ...)`: Converts an R object into a YAML-formatted string.
*   `write_yaml(x, file, ...)`: Converts an R object and writes it directly to a file.

## Common Workflows

### Reading Configuration
YAML maps are converted to named lists by default.
```r
# Load a config string
config <- yaml.load("
default:
  threads: 4
  verbose: true
")
config$default$threads # 4
```

### Writing Data Frames
Control how data frames are represented using the `column.major` argument.
```r
df <- data.frame(id = 1:2, val = c("a", "b"))

# Column-major (Default): Good for R-centric data
as.yaml(df, column.major = TRUE)

# Row-major: Often preferred for web APIs or cross-language lists
as.yaml(df, column.major = FALSE)
```

### Customizing Output Formatting
*   **Indentation**: Use `indent = n` (default is 2).
*   **Sequence Indentation**: Use `indent.mapping.sequence = TRUE` to indent dashes under their keys.
*   **Forcing Quotes**: Set `attr(x, "quoted") <- TRUE` on a character vector to ensure it is quoted in the output.
*   **Verbatim Strings**: Set `class(x) <- "verbatim"` to prevent quoting of strings that look like other types (e.g., "true").

### Using Handlers
Handlers allow you to intercept specific YAML types during loading or R classes during emission.
```r
# Custom loader: Add 100 to all integers found in YAML
yaml.load("count: 5", handlers = list(int = function(x) x + 100))

# Custom emitter: Format dates specifically
as.yaml(Sys.Date(), handlers = list(Date = function(x) format(x, "%Y/%m/%d")))
```

## Tips for AI Agents
*   **Type Safety**: YAML sequences of uniform types (e.g., all integers) are automatically simplified to R vectors. If you require a list, wrap the result or use a handler.
*   **Map Keys**: R list names must be strings. If the YAML contains non-string keys (like integers or booleans as keys), use `as.named.list = FALSE` in `yaml.load()` to preserve them in a `keys` attribute.
*   **Large Files**: For very large YAML files, `read_yaml` is optimized for file-system streaming.

## Reference documentation
- [Introduction to yaml](./references/yaml.Rmd)