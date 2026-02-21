---
name: r-globals
description: "Identifies global (\"unknown\" or \"free\") objects in R expressions     by code inspection using various strategies (ordered, liberal,     conservative, or deep-first search). The objective of this package is to     make it as simple as possible to identify global objects for the purpose     of exporting them in parallel, distributed compute environments.</p>"
homepage: https://cloud.r-project.org/web/packages/globals/index.html
---

# r-globals

name: r-globals
description: Identify global (free) objects and functions in R expressions. Use this skill when you need to determine which variables, functions, and packages must be exported to external R workers (e.g., in parallel or distributed computing) to ensure an expression can be evaluated successfully in a different environment.

## Overview

The `globals` package provides a robust way to identify global objects in R expressions by performing static code analysis. It is a core dependency for the `future` framework but can be used independently to audit code for "unknown" symbols. It supports different search strategies (conservative vs. liberal) and can automatically resolve the values of identified globals.

## Installation

```r
install.packages("globals")
```

## Core Functions

### Identifying Globals
The primary function is `globalsOf()`, which identifies and retrieves the values of global objects.

```r
library(globals)

# Define some objects in the global environment
a <- 1
f <- function(x) x + a

# Identify globals in an expression
expr <- quote(f(10) + b)
globals <- globalsOf(expr, envir = parent.frame())

# View identified names
names(globals)
# [1] "f" "a" "+"

# Note: 'b' is not found if it doesn't exist in the environment, 
# but it is identified as a global.
```

### Finding Global Names
If you only need the names of the globals without their values, use `findGlobals()`:

```r
# Returns a character vector of names
names <- findGlobals(expr, method = "ordered")
```

### Cleanup and Export
`cleanup()` can be used to remove globals that are part of standard R packages to keep the export list lean.

```r
globals <- globalsOf(expr)
globals <- cleanup(globals)
```

## Search Strategies

The `method` argument (in `findGlobals`) or `dotdotdot` argument (in `globalsOf`) controls how aggressively the package searches for globals:

- **ordered**: (Default) A full-search strategy that follows the order of the code.
- **conservative**: Only identifies objects that are clearly used as globals; less likely to pick up false positives in complex formulas.
- **liberal**: More aggressive; identifies anything that might be a global.
- **deep-first search**: Recursively explores functions within the expression.

## Workflows

### Preparing for Parallel Execution
When manually setting up a cluster or a parallel socket, use `globalsOf` to ensure the worker has everything it needs.

```r
library(globals)

# 1. Identify all globals needed for a function
my_task <- function(x) {
  res <- some_external_val * x
  return(helper_func(res))
}

globals <- globalsOf(my_task, recursive = TRUE)

# 2. Filter out base R functions to save memory
globals <- cleanup(globals)

# 3. The resulting 'globals' object is a named list 
# that can be exported to workers via parallel::clusterExport()
# or used to verify environment completeness.
```

### Handling Closures
If a function depends on variables in its lexical scope (enclosing environment), set `recursive = TRUE` to ensure those "hidden" globals are captured.

## Tips
- **Missing Objects**: If `globalsOf()` cannot find an object in the provided `envir`, it will still list the name but won't include a value unless `mustExist = FALSE` is set.
- **Formula Objects**: R formulas (`~ x + y`) often hide globals. `globals` is specifically designed to handle these better than `codetools::findGlobals`.
- **Packages**: Use `attr(globals, "packages")` to see which R packages need to be loaded on the worker side to support the identified globals.

## Reference documentation
- [globals: Identify Global Objects in R Expressions](./references/README.md)