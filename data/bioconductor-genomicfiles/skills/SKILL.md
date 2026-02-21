---
name: bioconductor-genomicfiles
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicFiles.html
---

# bioconductor-genomicfiles

name: bioconductor-genomicfiles
description: Expert guidance for using the Bioconductor package GenomicFiles for distributed computing across genomic files. Use this skill when you need to perform parallel data extraction, manipulation, and reduction across multiple files (BAM, BigWig, etc.) or genomic ranges. It is ideal for tasks like computing pileups, coverage, or junction counts across large datasets where memory management and parallel processing are required.

# bioconductor-genomicfiles

## Overview

The `GenomicFiles` package provides a framework for parallel "Map-Reduce" operations over genomic files. It allows you to distribute tasks across workers by either splitting the problem by **Range** (comparing the same genomic region across multiple files) or by **File** (processing multiple regions within a single file). It integrates with `BiocParallel` for backend management and `SummarizedExperiment` for structured data output.

## Core Workflows

### 1. The GenomicFiles Class
The `GenomicFiles` object acts as a matrix where rows are `GRanges` and columns are files (e.g., `BamFile`, `BigWigFile`).

```r
library(GenomicFiles)
gf <- GenomicFiles(rowRanges = my_granges, files = my_files)
# Subset like a matrix: gf[1:5, 1:2]
```

### 2. Queries Across Files (reduceByRange)
Use this when you want to compare or combine data from the same range across multiple files.

*   **MAP**: Function with arguments `range` and `file`.
*   **REDUCE**: Function to combine results from different files for a single range.
*   **Workflow**:
    ```r
    MAP <- function(range, file, ...) {
        # Extract data (e.g., pileup or coverage)
        Rsamtools::pileup(file, scanBamParam=ScanBamParam(which=range))
    }
    REDUCE <- function(mapped, ...) {
        # Combine list of results from MAP
        do.call(rbind, mapped)
    }
    results <- reduceByRange(gr, fls, MAP, REDUCE, iterate = FALSE)
    ```

### 3. Queries Within Files (reduceByFile)
Use this when you want to process multiple ranges within a single file, often to keep memory usage low.

*   **Workflow**:
    ```r
    # summarize=TRUE returns a RangedSummarizedExperiment
    se <- reduceByFile(gf, MAP = my_map_fun, summarize = TRUE)
    ```

### 4. Streaming Large Files (reduceByYield)
For files too large to fit in memory, use `reduceByYield` to iterate through records in chunks.

*   **YIELD**: Function that returns the next chunk of data (e.g., `readGAlignments`).
*   **DONE**: Function that returns `TRUE` when the file is exhausted.
    ```r
    bf <- BamFile(file_path, yieldSize=100000)
    res <- reduceByYield(bf, YIELD = readGAlignments, MAP = my_map, REDUCE = `+`, DONE = function(x) length(x) == 0)
    ```

## Key Functions

| Function | Primary Split | Use Case |
| :--- | :--- | :--- |
| `reduceByRange` | By Range | Comparing specific loci across many samples. |
| `reduceRanges` | By Range | Similar to `reduceByRange` but applies REDUCE to all MAP calls. |
| `reduceByFile` | By File | Processing one sample at a time across many ranges. |
| `reduceFiles` | By File | Treating ranges as a group for a single file operation. |
| `reduceByYield` | By Record | Streaming through a single file in chunks. |

## Best Practices

*   **Namespace Safety**: Inside MAP functions, use `requireNamespace("pkg")` or `pkg::function()` because the code runs on isolated workers.
*   **Memory Management**: Use `iterate = TRUE` in `reduceByFile` to apply the REDUCE step after each MAP, preventing the accumulation of large intermediate objects on workers.
*   **Chunking**: If you have thousands of small ranges, group them into a `GRangesList` before passing to `reduceByFile` or `reduceByRange` to reduce parallelization overhead.
*   **Summarization**: Set `summarize = TRUE` in `reduceByFile` to automatically wrap results into a `SummarizedExperiment`, provided no REDUCE step collapses the dimensions.

## Reference documentation

- [Introduction to GenomicFiles](./references/GenomicFiles.md)