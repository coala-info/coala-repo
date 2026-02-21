---
name: r-params
description: "An interface to simplify organizing parameters used in a package,     using external configuration files. This attempts to provide a cleaner     alternative to options().</p>"
homepage: https://cloud.r-project.org/web/packages/params/index.html
---

# r-params

## Overview
The `params` package provides a cleaner alternative to the base R `options()` system. It allows for the creation of isolated environments for parameter storage, supports loading configurations from external files, and enables dynamic parameter nesting using mustache-style logic-less templating.

## Installation
```R
install.packages("params")
```

## Core Workflow

### 1. Basic Parameter Management
Use `set_opts()` and `get_opts()` to manage parameters in the default `params` environment.

```R
library(params)

# Set multiple options
set_opts(
  name = "John Doe",
  verbose = TRUE,
  my_dir = "~/project"
)

# Retrieve all options as a data frame
get_opts()

# Retrieve a specific option
get_opts("name")
```

### 2. Loading from Configuration Files
`params` can read parameters from tab-delimited or comma-delimited files. 
- **Validation**: Options ending in `path`, `exe`, or `dir` are automatically checked for existence via `file.exists()`.

```R
# Load from a file
load_opts("config.conf")
```

**Example Configuration File Format (`config.conf`):**
```text
my_path    ~/data
my_tool_exe    /usr/bin/ls
my_dir    path/to/folder
default_regex    (.*)
```

### 3. Nested Parameters (Templating)
You can define parameters that reference other parameters using `{{{key}}}` syntax. This is powered by the `whisker` package.

```R
set_opts(
  first = "John", 
  last = "Doe",
  full = "{{{first}}} {{{last}}}"
)

get_opts("full")
# [1] "John Doe"
```

### 4. Using params in Your Own Package
To prevent cluttering the global options space, create a dedicated options manager for your package.

```R
# Define this in your package (e.g., in zzz.R or a global script)
my_pkg_opts = new_opts()

# Use the object-specific methods
my_pkg_opts$set(version = "1.0.0", author = "Dev")
my_pkg_opts$get("version")
my_pkg_opts$load("inst/conf/pkg.conf")
```

## Main Functions
- `new_opts()`: Creates a new options manager (environment + accessor functions).
- `set_opts(...)`: Set one or more options.
- `get_opts(name)`: Retrieve options. Returns a data frame if `name` is missing.
- `load_opts(file)`: Load options from a configuration file.
- `print.opts()`: Automatically formats `get_opts()` output into a pretty table.

## Reference documentation
- [params: Simplify Parameters](./references/README.md)