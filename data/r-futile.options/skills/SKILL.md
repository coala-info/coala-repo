---
name: r-futile.options
description: The r-futile.options package provides a scoped options management framework for R to create self-contained namespaces for package-specific configurations. Use when user asks to initialize an options manager, set or retrieve package-specific options, or reset configuration values to their defaults.
homepage: https://cloud.r-project.org/web/packages/futile.options/index.html
---

# r-futile.options

name: r-futile.options
description: Scoped options management for R packages and applications. Use when you need to create a custom options system that avoids name collisions with global R options or other packages. Ideal for package developers who want to provide a user-configurable interface with default values.

# r-futile.options

## Overview
The `futile.options` package provides a scoped options management framework for R. Unlike the global `options()` function in base R, `futile.options` allows developers to create self-contained "namespaces" for options. This prevents variable name collisions between different packages and provides a clean mechanism for setting, retrieving, and resetting package-specific configuration.

## Installation
To install the package from CRAN:
```R
install.packages("futile.options")
```

## Core Workflow

### 1. Initialize an Options Manager
Create a bespoke options manager for your package or application. You can define default values during initialization.

```R
library(futile.options)

# Create a manager named 'my.configs' with default values
my.configs <- OptionsManager('my.configs', default=list(api_key=NA, timeout=30, verbose=FALSE))
```

### 2. Set Options
Use the generated manager function to set new values or update existing ones.

```R
# Set single or multiple options
my.configs(api_key='12345', verbose=TRUE)

# Add a new option not in the original defaults
my.configs(log_path='/var/log/app.log')
```

### 3. Retrieve Options
Access values by passing the option name as a string or a character vector for multiple values.

```R
# Get a single value
val <- my.configs('api_key')

# Get multiple values
vals <- my.configs(c('timeout', 'verbose'))
```

### 4. Reset Options
Revert all options back to the default values defined during the `OptionsManager` creation.

```R
reset.options(my.configs)
```

## Usage Tips
- **Scoping**: Always use a unique name for the `OptionsManager` (typically your package name) to ensure the options are properly namespaced.
- **Package Integration**: Define the `OptionsManager` within your package's `.onLoad` function or as a non-exported object to manage internal state.
- **Global Access**: If you want users to configure your package, export the function created by `OptionsManager`.

## Reference documentation
- [README](./references/README.html.md)
- [Home Page](./references/home_page.md)