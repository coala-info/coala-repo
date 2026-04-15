---
name: bioconductor-annaffy
description: This tool provides an interface for annotating Affymetrix microarray data and linking results to biological databases. Use when user asks to generate annotated HTML reports, link probe IDs to online databases like GenBank or KEGG, and search Bioconductor metadata for specific biological criteria.
homepage: https://bioconductor.org/packages/release/bioc/html/annaffy.html
---

# bioconductor-annaffy

name: bioconductor-annaffy
description: Interface between Affymetrix analysis results and web-based databases. Use this skill to generate annotated HTML reports, link probe IDs to online databases (GenBank, Entrez, PubMed, KEGG, GO), and search Bioconductor metadata for specific biological criteria.

# bioconductor-annaffy

## Overview

The `annaffy` package provides a high-level interface for annotating Affymetrix microarray data. It transforms raw probe identifiers into rich, interactive HTML reports or tab-delimited text files. It leverages Bioconductor annotation data packages (SQLForge-based) to provide links to major biological databases and allows for complex metadata searching.

## Core Workflow

### 1. Loading Annotation Data

Annotation data is handled via specific classes (e.g., `aafSymbol`, `aafGO`). Constructor functions take a vector of probe IDs and the chip-specific metadata package name.

```r
library(annaffy)
library(hgu95av2.db) # Example metadata package

# Load probe IDs (e.g., from an ExpressionSet)
data(aafExpr)
probeids <- featureNames(aafExpr)

# Extract specific annotation types
symbols <- aafSymbol(probeids, "hgu95av2.db")
gos <- aafGO(probeids, "hgu95av2.db")
```

### 2. Accessing Data and URLs

Most `annaffy` objects support `getText()` for simple strings and `getURL()` for database links.

- **Textual representation**: `getText(symbols[1:5])`
- **Database Links**:
    - `aafGenBank`: Links to NCBI Nucleotide.
    - `aafLocusLink`: Links to Entrez Gene.
    - `aafCytoband`: Links to NCBI Genome Viewer.
    - `aafPubMed`: Links to PubMed abstracts.
    - `aafPathway`: Links to KEGG pathway schematics.

```r
gbs <- aafGenBank(probeids, "hgu95av2.db")
urls <- getURL(gbs[[1]])
# browseURL(urls[1]) # To open in browser
```

### 3. Building Annotated Reports

The primary use case is generating HTML reports that combine statistical results with biological annotation.

```r
# 1. Select columns to include
# Use aaf.handler() to see available types
anncols <- aaf.handler()[c(1:3, 8:9, 11:13)] 

# 2. Create the annotation table
anntable <- aafTableAnn(probeids[1:50], "hgu95av2.db", anncols)

# 3. Add statistical data (e.g., t-statistics)
testtable <- aafTable("t-statistic" = my_t_stats, signed = TRUE)
combined_table <- merge(anntable, testtable)

# 4. Add expression data (intensities)
exprtable <- aafTableInt(aafExpr, probeids = probeids[1:50])
final_table <- merge(combined_table, exprtable)

# 5. Save output
saveHTML(final_table, "report.html", title = "Microarray Analysis")
saveText(final_table, "report.txt")
```

## Searching Metadata

`annaffy` allows searching for probe IDs based on metadata content.

### Text Search
Search for keywords in specific metadata columns. Terms are treated as Perl-compatible regular expressions.

```r
# Find all kinases in the Description column
kinases <- aafSearchText("hgu95av2.db", "Description", "kinase")

# Search multiple terms with AND logic
probes <- aafSearchText("hgu95av2.db", "Description", 
                       c("DNA", "polymerase"), logic = "AND")
```

### Gene Ontology (GO) Search
Map GO identifiers to probe IDs.

```r
# Search for specific GO IDs
# Supports numeric or character IDs, with or without "GO:" prefix
go_probes <- aafSearchGO("hgu95av2.db", c("GO:0000002", "GO:0000008"))
```

## Tips and Best Practices

- **Memory Management**: HTML reports can become very large. Limit reports to the top 50-200 probes of interest (e.g., by p-value or fold change).
- **Subsetting**: Single brackets `[]` on `aafList` objects return an `aafList`. Double brackets `[[]]` return the individual annotation object.
- **Data Packages**: Ensure the correct `.db` package for your specific Affymetrix chip is installed (e.g., `hgu133plus2.db`).
- **Interactive Selection**: Use `aafTableAnn(..., widget = TRUE)` to select annotation columns via a graphical interface (requires X11/TclTk).

## Reference documentation

- [Textual Description of annaffy](./references/annaffy.md)