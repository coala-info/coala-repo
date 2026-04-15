---
name: r-matlab
description: The r-matlab package provides R functions that emulate the syntax and behavior of MATLAB for matrix generation, array manipulation, and visualization. Use when user asks to create matrices using MATLAB-style constructors, reshape arrays, find non-zero indices, or generate linear and logarithmic spacing.
homepage: https://cloud.r-project.org/web/packages/matlab/index.html
---

# r-matlab

## Overview
The `matlab` package provides R users with a set of functions that emulate the behavior and syntax of MATLAB. It is particularly useful for researchers and developers transitioning from MATLAB to R, or for those who need to implement algorithms originally written in MATLAB without performing a full manual translation of every utility function.

## Installation
Install the package from CRAN:
```R
install.packages("matlab")
```

## Core Workflows

### Matrix Generation
Create matrices using MATLAB-style constructors:
```R
library(matlab)

# Create a 3x3 matrix of zeros
z <- zeros(3)

# Create a 2x4 matrix of ones
o <- ones(2, 4)

# Create a 5x5 identity matrix
i <- eye(5)

# Create a 3x3 magic square
m <- magic(3)
```

### Array Manipulation and Information
Functions that mimic MATLAB's array handling:
```R
# Get dimensions (returns a vector like MATLAB)
s <- size(matrix(1:6, 2, 3)) # Returns c(2, 3)

# Reshape arrays
a <- 1:12
b <- reshape(a, 3, 4)

# Repeat copies of an array
m <- matrix(1:4, 2, 2)
rep_m <- repmat(m, 2, 3) # Tile the matrix 2x3 times
```

### Mathematical and Utility Functions
Common MATLAB utilities ported to R:
```R
# Linear spacing
v <- linspace(0, 10, 5)

# Logarithmic spacing
lv <- logspace(1, 3, 3) # 10, 100, 1000

# Find indices of non-zero elements
idx <- find(c(1, 0, 5, 0, 3) > 2)
```

### Visualization Emulation
The package provides wrappers to make R plotting feel more like MATLAB:
```R
# Display a matrix as an image
imagesc(magic(5))

# Create a color map
jet_colors <- jet.colors(100)
```

## Tips for AI Agents
- **Indexing**: Remember that while this package emulates function names, R still uses 1-based indexing and `[` brackets for subsetting.
- **Data Types**: The package maps MATLAB "doubles" to R "numerics".
- **Namespace**: Some function names might conflict with other packages (like `reshape2` or `Matrix`). Use `matlab::function_name()` if conflicts occur.
- **Logical Finding**: Use `find()` when you need the specific indices of TRUE values in a logical vector, similar to MATLAB's behavior.

## Reference documentation
- [matlab: MATLAB Emulation Package](./references/home_page.md)