---
name: r-bigmemory.sri
description: This tool provides a shared resource interface for managing and describing shared memory objects across different R sessions. Use when user asks to describe shared resources, attach to shared memory objects, or manage metadata for parallel computing in R.
homepage: https://cloud.r-project.org/web/packages/bigmemory.sri/index.html
---


# r-bigmemory.sri

name: r-bigmemory.sri
description: Provides a shared resource interface for the bigmemory and synchronicity R packages. Use this skill when working with shared memory objects in R, specifically for describing and attaching to shared resources across different R sessions or processes to enable efficient parallel computing and memory management.

# r-bigmemory.sri

## Overview
The `bigmemory.sri` (Shared Resource Interface) package provides a unified interface for managing shared resources in the Bigmemory Project ecosystem. It defines a common framework that allows packages like `bigmemory` and `synchronicity` to share objects across different R processes. Its primary role is to provide the `describe` generic function, which allows users to create a "description" of a shared object that can be passed to other processes and "attached" to recreate the object access.

## Installation
To install the package from CRAN:
```R
install.packages("bigmemory.sri")
```

## Core Concepts
The package is built around the concept of a **Shared Resource**. This is an object that exists in memory (often outside the standard R heap) and can be accessed by multiple R sessions simultaneously.

### The `describe` Method
The `describe` function is the core of this package. It extracts the necessary metadata (such as memory pointers or file paths) from a shared object.
- **Input**: A shared resource object (e.g., a `big.matrix` from the `bigmemory` package).
- **Output**: A description object that is typically small and can be easily serialized or passed to parallel workers (via `foreach`, `parallel`, etc.).

### The `attach` Method
While `bigmemory.sri` defines the interface, the `attach` method (often implemented as `attach.resource` or specific versions like `attach.big.matrix`) uses the description object to map the shared resource into the current R session's address space.

## Workflow Example
This package is rarely used in isolation; it is typically used in conjunction with `bigmemory`.

```R
library(bigmemory)
library(bigmemory.sri)

# 1. Create a shared resource (big.matrix)
x <- big.matrix(nrow=100, ncol=10, type="double", init=0)

# 2. Create a description of the resource
# This description is a lightweight object
x_desc <- describe(x)

# 3. In a separate process or parallel worker:
# You would pass 'x_desc' to the worker, then:
# x_attached <- attach.resource(x_desc) 
# (Note: attach.resource is the common wrapper provided by bigmemory)
```

## Usage Tips
- **Parallel Computing**: Use `describe()` before calling parallel functions (like `mclapply` or `foreach`). Pass the description object rather than the large data object itself to avoid massive memory overhead and serialization errors.
- **Synchronization**: When using shared resources across processes, use the `synchronicity` package (which also utilizes this SRI) to manage mutexes and prevent race conditions.
- **Compatibility**: Ensure that all R sessions accessing the shared resource are using compatible versions of the `bigmemory` suite.

## Reference documentation
- [bigmemory.sri: A Shared Resource Interface for Bigmemory Project Packages](./references/home_page.md)