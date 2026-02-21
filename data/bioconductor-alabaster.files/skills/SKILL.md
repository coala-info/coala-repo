---
name: bioconductor-alabaster.files
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.files.html
---

# bioconductor-alabaster.files

name: bioconductor-alabaster.files
description: Save and load common bioinformatics file formats (BAM, BigWig, BigBed, BCF, VCF) within the alabaster framework. Use this skill when you need to incorporate external file references into Bioconductor data structures (like DataFrames) for staging, versioning, or remote storage using the alabaster ecosystem.

# bioconductor-alabaster.files

## Overview

The `alabaster.files` package provides a standardized way to include common bioinformatics file formats (like BAM or BigWig) in the `alabaster` staging framework. Instead of managing these files separately, you wrap them in "Reference" classes. This allows them to be saved, loaded, and embedded within other Bioconductor objects (like `DataFrames` or `SummarizedExperiment` metadata) while maintaining their integrity during project migration or upload to remote stores.

## Core Workflow

### 1. Wrapping a File
To manage a file, wrap its path in the appropriate reference class. If the format requires an index (like BAM), provide the index path as well.

```r
library(alabaster.files)

# Example: Wrapping a BAM file
bam.path <- "path/to/sample.bam"
bam.index <- "path/to/sample.bam.bai"
wrapped.bam <- BamFileReference(bam.path, index=bam.index)

# Example: Wrapping a BigWig file
wrapped.bw <- BigWigFileReference("path/to/sample.bw")
```

### 2. Saving and Loading
Use the standard `alabaster.base` generics to stage the files.

```r
tmp <- tempfile()
# Save the wrapped object to a directory
saveObject(wrapped.bam, tmp)

# Load it back
loaded <- readObject(tmp)
# 'loaded' is a BamFileReference object containing the new staged paths
```

### 3. Integration with DataFrames
The primary power of `alabaster.files` is embedding files into complex metadata structures.

```r
library(S4Vectors)

df <- DataFrame(
    SampleID = c("S1", "S2"),
    Data = list(
        BamFileReference("s1.bam", index="s1.bam.bai"),
        BigWigFileReference("s2.bw")
    )
)

# Saving the entire DataFrame stages all referenced files automatically
project.dir <- tempfile()
saveObject(df, project.dir)
```

## Supported Reference Classes

| Format | Class |
| :--- | :--- |
| BAM | `BamFileReference(path, index)` |
| BigWig | `BigWigFileReference(path)` |
| BigBed | `BigBedFileReference(path)` |
| BCF | `BcfFileReference(path, index)` |
| GFF | `GffFileReference(path)` |

## Important Considerations

- **Validation**: The package performs "cursory" validation (e.g., checking BAM headers). It does not perform exhaustive file integrity checks to ensure high performance during staging.
- **Path Management**: When `saveObject` is called, the files are copied into the destination directory. When `readObject` is called, the returned object points to the paths within that staged directory.
- **Remote Storage**: Because these files are part of the `alabaster` object tree, tools that upload `alabaster` projects to remote stores (like `gypsum`) will automatically include these files.

## Reference documentation

- [Saving common bioinformatics file formats](./references/userguide.md)