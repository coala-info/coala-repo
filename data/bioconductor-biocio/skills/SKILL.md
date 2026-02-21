---
name: bioconductor-biocio
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocIO.html
---

# bioconductor-biocio

name: bioconductor-biocio
description: Standardized input/output (IO) operations for Bioconductor objects. Use this skill when you need to import or export data using the BiocIO framework, define new file-backed classes (BiocFile), or handle compressed file formats (GZ, BZ2, XZ) within the Bioconductor ecosystem.

# bioconductor-biocio

## Overview

`BiocIO` provides the foundational abstract classes and generics for data import and export across Bioconductor. It defines the `import()` and `export()` generics and the `BiocFile` class hierarchy, which standardizes how R objects are mapped to external files. It is the modern successor to the IO functionality previously found in `rtracklayer`.

## Core Workflows

### Standard Import and Export
Use the high-level generics to move data between R and disk. The specific behavior depends on the class of the `con` (connection) or the `format` argument.

```r
library(BiocIO)

# Import data from a file
# con can be a path, URL, connection, or BiocFile object
data <- import(con = "path/to/file.csv", format = "csv")

# Export an object to a file
export(object = my_data_frame, con = "output.csv", format = "csv")
```

### Working with BiocFile Objects
`BiocFile` objects wrap a file resource (path or connection) and associate it with a specific format, allowing for method dispatch.

```r
# Create a file reference
my_file <- CSVFile("data.csv")

# Import using the object (dispatches to the CSVFile method)
df <- import(my_file)

# Access the underlying path/connection
path <- resource(my_file)
```

### Handling Compressed Files
`BiocIO` provides specialized classes for compressed formats that extend `CompressedFile`.

- `GZFile`: Gzip compression.
- `BGZFile`: Blocked Gzip (extends `GZFile`).
- `BZ2File`: Bzip2 compression.
- `XZFile`: XZ compression.

```r
# Define a compressed resource
gz_ref <- GZFile("data.csv.gz")
# Methods defined for GZFile or its format will be used
```

## Developer Patterns

### Defining New File Classes
To implement IO for a new format, extend the `BiocFile` class.

```r
# 1. Define the class
.MyFormatFile <- setClass("MyFormatFile", contains = "BiocFile")

# 2. Create a constructor
MyFormatFile <- function(resource) .MyFormatFile(resource = resource)

# 3. Define import method
setMethod("import", "MyFormatFile", function(con, format, text, ...) {
    # Use resource(con) to get the path/connection
    # Implementation logic here...
})

# 4. Define export method
setMethod("export", c("data.frame", "MyFormatFile"), 
    function(object, con, format, ...) {
        # Implementation logic here...
    }
)
```

### Migrating from rtracklayer
If updating older code that uses `RTLFile`:
- Replace `contains = "RTLFile"` with `contains = "BiocFile"`.
- Use `BiocIO::resource()` instead of `rtracklayer::resource()`.

## Reference documentation

- [An Overview of the BiocIO package](./references/BiocIO.md)