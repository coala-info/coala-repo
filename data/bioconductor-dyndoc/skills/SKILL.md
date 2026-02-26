---
name: bioconductor-dyndoc
description: This tool manages and interacts with dynamic documents and Bioconductor vignettes by programmatically extracting, editing, and evaluating code chunks. Use when user asks to extract code from .Rnw or .Snw files, manage vignette metadata, or evaluate specific code chunks in controlled environments.
homepage: https://bioconductor.org/packages/release/bioc/html/DynDoc.html
---


# bioconductor-dyndoc

name: bioconductor-dyndoc
description: Tools for managing and interacting with dynamic documents and Bioconductor vignettes. Use this skill to programmatically extract code chunks from .Rnw or .Snw files, evaluate vignette code in controlled environments, and manage vignette metadata.

## Overview

The `DynDoc` package provides infrastructure for handling dynamic documents (vignettes) within the Bioconductor ecosystem. It allows users to treat vignettes as R objects, enabling the extraction of code chunks, manipulation of metadata (like dependencies and keywords), and execution of embedded code without manually running Sweave/Stangle.

## Core Workflows

### Extracting Code from Vignettes
The primary use case is retrieving R code from a vignette file using the `tangleToR` driver.

```r
library(DynDoc)
library(utils)

# Get path to a vignette file
vig_path <- system.file("doc", "vignette.Rnw", package = "DynDoc")

# Method 1: Using Stangle with tangleToR driver
# Returns a 'chunkList' object
chunks <- Stangle(vig_path, driver = tangleToR())

# Method 2: Using the helper function
# Returns a 'vignetteCode' object
vig_code <- getVignetteCode(vig_path)
```

### Managing Code Chunks
Once code is extracted into a `chunkList` or `vignetteCode` object, you can inspect and modify it.

```r
# Count chunks
numChunks(vig_code)

# Retrieve a specific chunk (e.g., the first one)
chunk1 <- getChunk(vig_code, 1)
chunk_text <- chunk(chunk1)

# Edit a chunk's code
vig_code <- editVignetteCode(vig_code, pos = 1, code = "print('New Code')")

# Get all code as a single block
all_code <- getAllCodeChunks(chunkList(vig_code))
```

### Evaluating Vignette Code
`DynDoc` allows for the evaluation of specific chunks within a dedicated environment.

```r
# Evaluate a specific chunk in the object's environment
evalChunk(vig_code, pos = 1)

# Access the evaluation environment
env <- evalEnv(vig_code)
```

### Working with Vignette Metadata
You can extract header information (lines starting with `%\Vignette`) without parsing the entire document.

```r
# Get all metadata for a package's vignettes
pkg_path <- system.file(package = "DynDoc")
vig_list <- getPkgVigList(pkg_path)

# Get specific header fields
title <- getVignetteHeader(vig_path, "VignetteIndexEntry")
has_depends <- hasVigHeaderField(vig_path, "VignetteDepends")
```

### High-Level Vignette Objects
For a complete representation of a vignette (metadata + code), use the `Vignette` class.

```r
# Create a Vignette object
vignette_obj <- getVignette(vig_path, eval = FALSE)

# Access slots
path(vignette_obj)
getDepends(vignette_obj)
codeChunks(vignette_obj)
```

## Tips
- **Drivers**: `tangleToR()` is a specialized driver for `Stangle` that returns R objects instead of writing files to disk.
- **Classes**: 
  - `codeChunk`: Individual code block and its Sweave options.
  - `chunkList`: A collection of `codeChunk` objects.
  - `vignetteCode`: A `chunkList` plus file path and evaluation environment.
  - `DynDoc`/`Vignette`: Full document representation including PDF paths and dependencies.

## Reference documentation
- [DynDoc Reference Manual](./references/reference_manual.md)