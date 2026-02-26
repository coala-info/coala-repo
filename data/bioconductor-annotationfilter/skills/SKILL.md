---
name: bioconductor-annotationfilter
description: The AnnotationFilter package provides a standardized framework for creating formal filter objects to query Bioconductor annotation resources. Use when user asks to create individual filters for genomic features, combine multiple query criteria using logical operators, or define spatial filters using genomic coordinates.
homepage: https://bioconductor.org/packages/release/bioc/html/AnnotationFilter.html
---


# bioconductor-annotationfilter

## Overview

The `AnnotationFilter` package provides a standardized framework for filtering Bioconductor annotation resources. Instead of writing raw SQL or complex subsetting code, it allows you to create formal filter objects that represent specific query criteria (e.g., "find all genes on Chromosome 1" or "find transcripts for gene BCL2"). These filters are used by other high-level annotation packages to perform efficient data extraction.

## Core Workflows

### 1. Creating Individual Filters
Filters are created using specific constructor functions. Each filter typically takes a value and an optional condition.

```r
library(AnnotationFilter)

# Basic equality filter (default condition is "==")
flt <- SymbolFilter("BCL2")

# Filter with specific conditions (startsWith, endsWith, ==, !=, >, <, >=, <=)
flt_start <- SymbolFilter("BCL2", condition = "startsWith")
flt_range <- GeneStartFilter(1000000, condition = ">")
```

### 2. Using Formula Syntax
A more intuitive way to create filters is using R formulas (starting with `~`). The `AnnotationFilter()` function translates these into the appropriate filter classes.

```r
# Equivalent to SymbolFilter("BCL2")
flt <- AnnotationFilter(~ symbol == "BCL2")

# Multiple values (translated to an "in" type query)
flt_multi <- AnnotationFilter(~ symbol %in% c("BCL2", "BCL2L11"))
```

### 3. Combining Filters (AnnotationFilterList)
You can combine multiple filters using logical operators (`&` for AND, `|` for OR).

```r
# Simple combination using formula
flt_list <- AnnotationFilter(~ symbol == "BCL2" & tx_biotype == "protein_coding")

# Manual nesting for complex logic: (A & B) | (C & D)
afl1 <- AnnotationFilterList(SymbolFilter("BCL2L11"), TxBiotypeFilter("nonsense_mediated_decay"))
afl2 <- AnnotationFilterList(SymbolFilter("BCL2"), TxBiotypeFilter("protein_coding"))
afl_combined <- AnnotationFilterList(afl1, afl2, logicOp = "|")
```

### 4. GRangesFilter
A special filter for spatial queries. It retrieves entries overlapping a specific genomic region.

```r
library(GenomicRanges)
gr <- GRanges("1:1-1000000")
gr_flt <- GRangesFilter(gr, type = "any") # types: any, start, end, within, equal
```

## Available Filter Types

Use `supportedFilters()` to see all available classes and their associated database fields. Common ones include:
- **Identifiers**: `GeneIdFilter`, `SymbolFilter`, `EntrezFilter`, `UniprotFilter`.
- **Coordinates**: `GeneStartFilter`, `GeneEndFilter`, `SeqNameFilter`, `SeqStrandFilter`.
- **Transcript/Exon**: `TxIdFilter`, `TxBiotypeFilter`, `ExonIdFilter`.

## Implementation Tips

- **Read-Only**: Filter objects are designed to be read-only. If you need to change a value, create a new filter object.
- **Field Mapping**: If a database uses a non-standard column name (e.g., `hgnc_symbol` instead of `symbol`), you can access the target field using `field(filter_object)`.
- **Integration**: This package provides the *definitions* for filters. To actually get data, you must pass these filters to functions in packages like `ensembldb` (e.g., `genes(edb, filter = flt)`).

## Reference documentation

- [Facilities for Filtering Bioconductor Annotation Resources](./references/AnnotationFilter.md)