---
name: r-rlist
description: "Provides a set of functions for data manipulation with     list objects, including mapping, filtering, grouping, sorting,     updating, searching, and other useful functions. Most functions     are designed to be pipeline friendly so that data processing with     lists can be chained.</p>"
homepage: https://cloud.r-project.org/web/packages/rlist/index.html
---

# r-rlist

name: r-rlist
description: Expert guidance for the rlist R package to manipulate non-tabular data (nested lists). Use this skill when you need to map, filter, group, sort, update, or search complex R list objects using pipeline-friendly functional programming patterns.

## Overview

The `rlist` package provides a comprehensive toolbox for non-tabular data manipulation in R. It allows for a "dplyr-like" experience when working with nested lists, JSON-like structures, and hierarchical data. Most functions support lambda expressions and are designed to be used with the pipe operator (`%>%`).

## Installation

```R
install.packages("rlist")
library(rlist)
```

## Core Workflows

### 1. Mapping and Selection
Transform or extract specific fields from list elements.
- `list.map(.data, expr)`: Evaluate an expression for each element.
- `list.mapv(.data, expr)`: Map and return a vector (like `sapply`).
- `list.select(.data, ...)`: Create a new list with only specified fields.
- `list.extract(.data, index)`: Extract a specific element.

### 2. Filtering and Searching
Subset lists based on logical conditions.
- `list.filter(.data, ...)`: Keep elements satisfying all conditions.
- `list.find(.data, cond, n)`: Find the first `n` elements satisfying a condition.
- `list.search(.data, expr)`: Recursively search a list for values matching an expression.
- `list.exclude(.data, cond)`: Remove elements satisfying a condition.

### 3. Grouping and Sorting
Organize and order hierarchical data.
- `list.group(.data, ...)`: Divide elements into exclusive groups.
- `list.sort(.data, ...)`: Sort the list by one or more expressions. Use `()` around an expression for descending order.
- `list.order(.data, ...)`: Return the integer order of elements.
- `list.class(.data, ...)`: Classify elements into non-exclusive cases.

### 4. Joining and Merging
Combine multiple lists.
- `list.join(x, y, xkey, ykey)`: Join two lists by keys.
- `list.merge(...)`: Merge multiple named lists sequentially (later values override earlier ones).
- `list.zip(...)`: Combine multiple lists element-wise.

### 5. Conversion and Stacking
Move between lists and tabular formats.
- `list.stack(.data)`: Stack list elements into a `data.frame` or `data.table`.
- `list.parse(x)`: Convert a `data.frame`, `matrix`, or JSON/YAML string into a list.
- `list.flatten(x)`: Flatten a nested list to a single level.

### 6. I/O Operations
- `list.load(file)`: Load data from JSON, YAML, RDS, or RData.
- `list.save(x, file)`: Save a list to various formats based on file extension.

## Lambda Expressions
In `rlist` functions, you can use:
- `.` to represent the current element.
- `.i` to represent the current index.
- `.name` to represent the current element name.
- Direct field names if the list elements are named (e.g., `list.filter(x, age >= 20)`).

## Tips for Success
- **Chaining**: Use `List(x)` to wrap a list in an environment where functions can be called as methods (e.g., `List(x)$filter(age > 20)$map(name)[]`).
- **Cleaning**: Use `list.clean(x, recursive = TRUE)` to remove `NULL` or empty elements from a messy nested list.
- **Logic**: Use `list.all()` and `list.any()` for logical checks across the entire list.

## Reference documentation
- [rlist Reference Manual](./references/reference_manual.md)