---
name: bioconductor-streamer
description: This tool facilitates streaming data processing in R using a producer-consumer architecture to handle large genomic datasets that exceed memory limits. Use when user asks to process data in chunks, stream large BAM files, or implement iterative data transformation pipelines.
homepage: https://bioconductor.org/packages/release/bioc/html/Streamer.html
---


# bioconductor-streamer

name: bioconductor-streamer
description: Facilitates streaming data processing in R using the Streamer package. Use this skill when handling large genomic datasets (like BAM files) that exceed memory limits, requiring a Producer-Consumer-Stream architecture for iterative, chunk-based processing, sampling, or transformation.

# bioconductor-streamer

## Overview

The `Streamer` package implements a framework for "streaming" data in R, which is essential for processing large biological datasets that cannot fit entirely into memory. It uses a Reference Class (RC) system to define three core components:
1.  **Producers**: Sources of data (e.g., file readers).
2.  **Consumers**: Processors of data (e.g., counters, filters, or transformers).
3.  **Streams**: Pipelines that connect Producers to one or more Consumers.

## Core Workflow

### 1. Defining Components
To use the streaming framework, you typically instantiate or define classes that inherit from `Producer` or `Consumer`.

*   **Producer**: Must implement a `yield()` method that returns the next chunk of data.
*   **Consumer**: Must implement a `yield()` method that retrieves data from the previous node in the stream (via `callSuper()`) and processes it.

### 2. Creating a Stream
Connect components using the `Stream()` function.
```r
library(Streamer)
# Assuming 'prod' is a Producer and 'cons' is a Consumer
s <- Stream(prod, cons)
```

### 3. Iterating
Data is processed by repeatedly calling `yield()` on the `Stream` object until the Producer is exhausted (usually indicated by returning an empty object).
```r
result <- yield(s)
```

## Example: Genomic Overlap Streaming
A common pattern is streaming through a BAM file by chromosome or genomic range to count overlaps.

### Implementing a BAM Producer
```r
setRefClass("BamInput", 
    contains="Producer",
    fields=list(file="character", ranges="GRanges", .seqNames="character"),
    methods=list(
        yield=function() {
            if(length(.self$.seqNames)) {
                seq <- .self$.seqNames[1]
                .self$.seqNames <- .self$.seqNames[-1]
                idx <- as.character(seqnames(.self$ranges)) == seq
                param <- ScanBamParam(which=.self$ranges[idx])
                aln <- readGAlignments(.self$file, param=param)
                return(list(aln))
            } else {
                return(list(GAlignments()))
            }
        }
    )
)
```

### Implementing a Count Consumer
```r
setRefClass("CountGOverlap",
    contains="Consumer",
    fields=list(ranges="GRanges", mode="character"),
    methods=list(
        yield=function() {
            aln <- callSuper()[[1]] # Get data from Producer
            if(length(aln)) {
                # Perform summarizeOverlaps on the chunk
                olap <- summarizeOverlaps(.self$ranges, aln, mode=.self$mode)
                return(assays(olap)[[1]])
            }
            return(numeric(0))
        }
    )
)
```

## Tips for Efficient Streaming
*   **Memory Management**: Streaming is only effective if the `yield()` method of the Producer returns chunks small enough to fit in RAM.
*   **Verbose Logging**: Use `msg()` within methods to track stream progress if the process is long-running.
*   **State Persistence**: Because these are Reference Classes, they maintain state (like the current file pointer or remaining sequence names) across multiple `yield()` calls.
*   **Collation**: Since `yield()` returns results for one chunk at a time, use `do.call(rbind, ...)` or similar functions to aggregate results after the stream finishes.

## Reference documentation
- [Using the Streamer classes to count genomic overlaps with summarizeOverlaps](./references/Streamer.md)