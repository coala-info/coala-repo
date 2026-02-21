---
name: bioconductor-genominator
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/3.5/bioc/html/Genominator.html
---

# bioconductor-genominator

name: bioconductor-genominator
description: Specialized workflow for the Genominator R package to store, retrieve, and summarize genomic data using SQLite backends. Use when needing to perform fast summarization of high-throughput sequencing data (like RNA-Seq) over large genomic regions, managing datasets that exceed memory limits, or performing region-based statistical analyses (Goodness of Fit, Coverage).

## Overview

Genominator is a Bioconductor package designed for the efficient analysis of genomic data by leveraging an SQLite database backend. It is particularly suited for high-throughput sequencing data where reads need to be summarized over genomic regions (e.g., counting reads in exons). By storing data on disk, it allows for the analysis of massive datasets (hundreds of millions of reads) on machines with limited RAM.

## Core Data Objects

- **ExpData**: A pointer to a specific table in an SQLite database. It contains genomic coordinates (`chr`, `location`, `strand`) and numeric data columns (e.g., `counts`).
- **Annotation**: A standard R `data.frame` containing `chr` (integer), `strand` (-1, 0, 1), `start`, and `end`.

## Essential Workflows

### 1. Data Import and Initialization

Import raw data from a data frame or aligned files (like Bowtie output) into the SQLite backend.

```R
library(Genominator)

# From a data frame
eDataRaw <- importToExpData(df, dbFilename = "project.db", tablename = "raw_data", overwrite = TRUE)

# From AlignedRead objects (ShortRead package)
# chrMap must map chromosome names to integers
chrMap <- paste("chr", 1:22, sep = "") 
eData <- importFromAlignedReads(files, chrMap = chrMap, dbFilename = "project.db", tablename = "raw")
```

### 2. Aggregation and Merging

Raw reads often contain multiple entries for the same location. Aggregation collapses these into unique locations with a count column.

```R
# Aggregate reads to unique locations
eData <- aggregateExpData(eDataRaw, tablename = "counts_tbl")

# Join multiple experiments into one table
eDataJoin <- joinExpData(list(eData1, eData2), 
                         fields = list(exp1 = c(counts = "lane1"), exp2 = c(counts = "lane2")),
                         tablename = "combined")
```

### 3. Summarization by Annotation

The primary use case is counting features across the genome.

```R
# Summarize counts per annotated region
counts <- summarizeByAnnotation(eData, annoData, what = "counts", fxs = c("TOTAL"))

# Group by gene ID (e.g., summing multiple exons)
geneCounts <- summarizeByAnnotation(eData, annoData, fxs = c("TOTAL"), groupBy = "gene_id")

# Split data into a list of matrices for R-based processing
dataList <- splitByAnnotation(eData, annoData)
```

### 4. Statistical Tools

- **Coverage**: Assess sequencing depth relative to effort.
- **Goodness of Fit**: Test if replicates follow a Poisson distribution.

```R
# Coverage analysis
cvg <- computeCoverage(eData, annoData, effort = seq(100, 1000, by = 100))
plot(cvg)

# Poisson Goodness of Fit
gof <- regionGoodnessOfFit(eDataJoin, annoData)
plot(gof)
```

## Tips for Efficient Usage

- **Read vs Write Mode**: Use `ExpData(dbFilename, tablename, mode = "r")` for analysis to prevent accidental database modification.
- **Memory Management**: `summarizeByAnnotation` is memory efficient as it performs calculations in SQL. `splitByAnnotation` loads data into R and can be memory-intensive.
- **Strand Handling**: Use `ignoreStrand = TRUE` in `summarizeByAnnotation` if the sequencing protocol was not strand-specific.
- **SQLite Functions**: The `fxs` argument accepts standard SQLite aggregate functions like `TOTAL`, `COUNT`, `MIN`, `MAX`, and `AVG`. Note that `TOTAL` returns 0 for empty sets, while `SUM` returns `NA`.

## Reference documentation

- [The Genominator User Guide](./references/Genominator.md)
- [Plotting using Genominator and GenomeGraphs](./references/plotting.md)
- [Working with the ShortRead Package](./references/withShortRead.md)