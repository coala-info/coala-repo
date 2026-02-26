---
name: bioconductor-alabaster.base
description: This tool saves and loads Bioconductor objects to and from file artifacts using a language-agnostic framework. Use when user asks to save R objects to disk, load objects from file artifacts, serialize data into JSON or HDF5 formats, or validate the integrity of saved object directories.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.base.html
---


# bioconductor-alabaster.base

name: bioconductor-alabaster.base
description: Save and load Bioconductor objects (DataFrame, etc.) to and from file artifacts using the alabaster framework. Use this skill when you need to serialize R objects into stable, language-agnostic formats (JSON, HDF5) or reconstruct objects from such artifacts.

## Overview

The `alabaster.base` package provides a robust alternative to RDS serialization for Bioconductor objects. It decomposes complex objects into multiple file artifacts (JSON for metadata, HDF5 for data) within a directory. This approach ensures long-term stability against class definition changes and enables interoperability with other languages like Python (via `dolomite-base`).

## Core Workflows

### Saving and Loading Objects

The primary interface consists of `saveObject()` and `readObject()`.

```r
library(alabaster.base)
library(S4Vectors)

# Create a sample object
df <- DataFrame(X=1:10, Y=letters[1:10])

# Save to a directory
tmp <- tempfile()
saveObject(df, tmp)

# Read back into R
df_restored <- readObject(tmp)
```

### Validation

To ensure an on-disk representation follows the required specifications (e.g., **takane**), use `validateObject()`. Note that `saveObject()` calls this automatically.

```r
validateObject(tmp)
```

### Working with Nested Objects

`alabaster.base` handles nested structures by creating subdirectories. You can load specific components by pointing `readObject()` to a subdirectory.

```r
# Example: Loading a specific column from a saved DataFrame
# If 'tmp' contains a DataFrame with nested columns:
list.files(tmp, recursive=TRUE)
readObject(file.path(tmp, "other_columns/1"))
```

## Extending to New Classes

To support a custom class, you must implement and register three components:

1.  **Save Method**: Define a `saveObject` method that creates a directory, writes data files, and creates an `OBJECT` file using `saveObjectFile(path, type)`.
2.  **Read Function**: A function that reconstructs the object from the directory. Register it with `registerReadObjectFunction(type, fun)`.
3.  **Validation Function**: A function that checks directory integrity. Register it with `registerValidateObjectFunction(type, fun)`.

```r
# Example registration
registerReadObjectFunction("my_custom_type", function(path, metadata, ...) {
    # ... logic to read files from path ...
})
```

## Creating Custom Applications

Applications can add extra metadata (e.g., author info) by overriding the saving/reading process using "alternative" functions.

*   **Saving**: Use `altSaveObjectFunction()` to set a custom generic, then call `altSaveObject()`.
*   **Reading**: Use `altReadObjectFunction()` to set a custom reader, then call `altReadObject()`.

```r
# Temporary override for a specific operation
old <- altSaveObjectFunction(myAppSaveGeneric)
on.exit(altSaveObjectFunction(old))
altSaveObject(x, path)
```

## Tips and Best Practices

*   **Portability**: You can move, rename, or zip the entire directory created by `saveObject()`. `readObject()` will still work as long as the internal structure is preserved.
*   **Avoid Manual Edits**: Do not manually modify files inside the artifact directory, as this often breaks the validation and reading logic.
*   **Application Metadata**: Files with leading underscores (e.g., `_metadata.json`) are reserved for application-specific use and won't be overwritten by standard `alabaster` operations.

## Reference documentation

- [Saving objects to artifacts and back again (Rmd)](./references/userguide.Rmd)
- [Saving objects to artifacts and back again (Markdown)](./references/userguide.md)