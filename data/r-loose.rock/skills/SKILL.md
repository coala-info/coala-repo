---
name: r-loose.rock
description: This R package provides tools for enhancing workflow productivity through result caching, balanced data partitioning, and string manipulation. Use when user asks to cache function results, split datasets into balanced training and testing sets, or format strings and manage project directories.
homepage: https://cran.r-project.org/web/packages/loose.rock/index.html
---


# r-loose.rock

name: r-loose.rock
description: A toolbox for enhancing R workflow productivity, specifically for result caching, balanced data splitting, and string manipulation. Use this skill when you need to optimize repetitive computations, manage project directories, or prepare datasets for machine learning with balanced classes.

# r-loose.rock

## Overview
The `loose.rock` package provides a collection of functions to improve R programming productivity. Its primary strengths lie in its simple caching mechanism for long-running tasks, utilities for data partitioning in machine learning, and various helper functions for string and file management.

## Installation
To install the package from CRAN:
```R
install.packages("loose.rock")
```

## Core Functions and Workflows

### 1. Caching Results
The `run.cache` function is the centerpiece of the package. It wraps a function call and saves the result to disk. If the function is called again with the same arguments, it loads the result from the cache instead of re-computing.

```R
library(loose.rock)

# Define an expensive function
expensive_func <- function(x) {
  Sys.sleep(2)
  return(x ^ 2)
}

# First run: executes and saves to 'cache' folder
result <- run.cache(expensive_func, 10)

# Second run: loads from disk instantly
result <- run.cache(expensive_func, 10)
```

### 2. Balanced Data Splitting
When preparing data for machine learning, `balanced.train.test` ensures that the training and testing sets have a proportional representation of classes.

```R
# Example with a target vector y
y <- c(rep("A", 20), rep("B", 80))

# Create indices for a 70% training set
indices <- balanced.train.test(y, train.size = 0.7)

train_data <- data[indices$train, ]
test_data <- data[indices$test, ]
```

### 3. String and Formatting Utilities
`loose.rock` includes simple helpers for common text tasks:

- `proper()`: Converts strings to Title Case.
- `cat.n()`: A wrapper for `cat()` that appends a newline.

```R
proper("hello world") 
# [1] "Hello World"

cat.n("Processing step 1...")
```

### 4. Directory Management
Manage project paths effectively using `base.dir`. This is useful for ensuring scripts work across different environments by setting a consistent root.

```R
# Set the base directory for the project
base.dir("/path/to/project")

# Generate a path relative to the base
data_path <- prefix.dir("data/raw_data.csv")
```

## Tips for Efficient Usage
- **Cache Location**: By default, `run.cache` creates a `cache` directory in your working directory. You can change this globally using `options("loose.rock.cache" = "/new/path")`.
- **Force Re-run**: If you need to bypass the cache and force a re-computation, delete the specific file in the cache directory or clear the directory.
- **Bioinformatics**: The package is often used in genomic workflows (e.g., with the `MMA` or `multiGSEA` packages) to handle coding directions of genes.

## Reference documentation
None