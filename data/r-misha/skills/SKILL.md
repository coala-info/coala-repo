---
name: r-misha
description: "A toolkit for analysis of genomic data. The 'misha' package     implements an efficient data structure for storing genomic data, and     provides a set of functions for data extraction, manipulation and     analysis."
homepage: https://cran.r-project.org/web/packages/misha/index.html
---

# r-misha

name: r-misha
description: Expert guidance for the 'misha' R package (Toolkit for Analysis of Genomic Data). Use this skill when you need to create, manipulate, or analyze genomic databases, tracks (1D/2D), and interval sets. It covers database initialization, track expressions, virtual tracks, and efficient data extraction for large-scale genomic analysis.

# r-misha

## Overview
The `misha` package provides an efficient data structure for storing genomic data and a comprehensive set of functions for data extraction, manipulation, and analysis. It is designed to handle large-scale genomic datasets (like ChIP-seq, RNA-seq, and Hi-C) by using a specialized database format that supports both 1D and 2D genomic coordinates.

## Installation
To install the package from CRAN:
```r
install.packages("misha")
library(misha)
```

## Core Workflows

### 1. Database Management
A `misha` database (GDB) requires a root directory containing `chrom_sizes.txt`.

*   **Create/Initialize:**
    ```r
    # Create from UCSC
    gdb.create_genome("hg38", path = "./hg38_db")
    gsetroot("./hg38_db")

    # Create from custom FASTA
    gdb.create("custom_db", "/path/to/genome.fa")
    ```
*   **Format Migration:** Use the "indexed" format for better performance with many contigs.
    ```r
    gdb.info()$format # Check format
    gdb.convert_to_indexed() # Migrate legacy to indexed
    ```

### 2. Working with Intervals
Intervals are data frames with `chrom`, `start`, and `end` (1D) or `chrom1`, `start1`, `end1`, `chrom2`, `start2`, `end2` (2D). Coordinates are 0-based.

*   **Basic Operations:**
    ```r
    # Create intervals
    intervs <- gintervals("chr1", 0, 1000)
    
    # Save to database
    gintervals.save("my_intervals", intervs)
    
    # Set operations
    intersected <- gintervals.intersect("set1", "set2")
    unified <- gintervals.unify("my_intervals")
    ```

### 3. Track Expressions and Extraction
Track expressions allow R-like math on genomic tracks.

*   **Data Extraction:**
    ```r
    # Extract average signal from 'mytrack' at specific intervals
    res <- gextract("mytrack", gintervals("chr1", 0, 10000), iterator = 100)
    
    # Complex expressions
    res <- gextract("log2(track1 / track2 + 1)", gintervals.all())
    ```
*   **Iterators:** The `iterator` argument defines the bins for evaluation (e.g., a fixed numeric bin size or an interval set).

### 4. Virtual Tracks (vtracks)
Virtual tracks define on-the-fly transformations without creating new physical tracks.

*   **Creation:**
    ```r
    # Create a vtrack for the 90th percentile
    gvtrack.create("v_top", "mytrack", "global.percentile")
    
    # Shift coordinates (e.g., look at promoter region)
    gvtrack.iterator("v_promoter", sshift = -1000, eshift = 0)
    ```

### 5. Multi-Database Support (Dataset API)
Combine shared reference databases with local project tracks.

```r
gsetroot("/project/working_db")
gdataset.load("/shared/hg38_reference")

# List tracks from all sources
gtrack.ls()

# Identify source of a track
gtrack.dataset("some_track")
```

## Tips for Efficiency
*   **Vectorization:** Ensure track expressions work on vectors (use `pmin`/`pmax` instead of `min`/`max`).
*   **Multitasking:** `misha` auto-configures `gmax.processes`. Use `options(gmultitasking = FALSE)` to disable if memory is limited.
*   **Buffer Size:** `gbuf.size` (default 1000) controls the number of intervals processed per R evaluation.
*   **2D Analysis:** Use `band` in `gextract` to limit 2D analysis to specific distance ranges from the diagonal.

## Reference documentation
- [Database Formats and Multi-Contig Support](./references/Database-Formats.Rmd)
- [Genomes](./references/Genomes.Rmd)
- [Package 'misha' - User Manual](./references/Manual.Rmd)