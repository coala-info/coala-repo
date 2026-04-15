---
name: r-globaloptions
description: This tool creates and manages custom global options functions in R with built-in validation, filtering, and access control. Use when user asks to generate package-specific option functions, enforce data types for global settings, or implement local scoping for configuration values.
homepage: https://cloud.r-project.org/web/packages/GlobalOptions/index.html
---

# r-globaloptions

name: r-globaloptions
description: Create and manage custom global options functions in R with validation, filtering, and access control. Use this skill when you need to generate a package-specific options() function that supports read-only settings, private options, or input value normalization.

# r-globaloptions

## Overview
The `GlobalOptions` package allows R developers to generate powerful, customizable global option management functions (similar to `options()` or `par()`). Unlike standard R options, these generated functions can enforce data types, validate values, filter inputs, and handle local scoping.

## Installation
```R
install.packages("GlobalOptions")
library(GlobalOptions)
```

## Core Workflow

### 1. Basic Option Generation
Use `set_opt()` to create an option function.
```R
# Create the option function
opt = set_opt(
    a = 1,
    b = "text"
)

# Get values
opt$a
opt("b")

# Set values
opt$a = 10
opt(b = "new string")

# Reset to defaults
opt(RESET = TRUE)
```

### 2. Advanced Configuration
To add validation or metadata, pass a list starting with a dot `.` for configuration fields.
```R
opt = set_opt(
    # Enforce class and length
    size = list(.value = 10, 
                .class = "numeric", 
                .length = 1),
    
    # Read-only option
    version = list(.value = "1.0.0", 
                   .read.only = TRUE),
    
    # Custom validation with error message
    prob = list(.value = 0.5,
                .validate = function(x) x >= 0 && x <= 1,
                .failed_msg = "prob must be between 0 and 1"),
                
    # Description for printing
    label = list(.value = "default",
                 .description = "The plot label")
)
```

### 3. Filtering and Normalization
Use `.filter` to transform user input into a standard format instead of throwing an error.
```R
opt = set_opt(
    margin = list(
        .value = c(1, 1, 1, 1),
        .filter = function(x) {
            if(length(x) == 1) return(rep(x, 4))
            return(x)
        }
    )
)
opt(margin = 5) # Automatically becomes c(5, 5, 5, 5)
```

### 4. Inter-option Dependencies
Use `.v()` to access the current value of other options within validation or filter functions.
```R
opt = set_opt(
    min_val = 0,
    max_val = list(.value = 10,
                   .validate = function(x) x > .v$min_val)
)
```

### 5. Local Scoping
You can temporarily change options within a specific scope (like a function) without affecting the global state permanently.
```R
opt = set_opt(a = 1)

f = function() {
    opt(LOCAL = TRUE) # Start local mode
    opt(a = 5)
    print(opt$a)      # Prints 5
}

f()
print(opt$a)          # Prints 1 (restored automatically)
```

## Tips and Best Practices
- **Adding Options Later**: Use `opt(new_var = 1, ADD = TRUE)` to add options after the initial function creation.
- **Visibility**: Set `.visible = FALSE` to hide internal settings from the summary printout.
- **Private Options**: Set `.private = TRUE` to ensure an option can only be modified by code within your package's namespace.
- **Dynamic Values**: If an option value is a function (and `.class` is not "function"), it will be executed every time the option is queried.
- **Printing**: Simply typing the name of the option function (e.g., `opt`) prints a formatted table of all current settings and descriptions.

## Reference documentation
- [Generate Global Options](./references/GlobalOptions.Rmd)