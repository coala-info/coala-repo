---
name: bioconductor-ragene11stprobeset.db
description: This Bioconductor package provides annotation data for the Affymetrix Rat Gene 1.1 ST Array probeset-level identifiers. Use when user asks to map probe IDs to gene symbols, retrieve Entrez IDs, find chromosomal locations, or access functional annotations like GO terms and KEGG pathways for rat genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ragene11stprobeset.db.html
---


# bioconductor-ragene11stprobeset.db

## Overview

The `ragene11stprobeset.db` package is a Bioconductor annotation data package for the Affymetrix Rat Gene 1.1 ST Array, specifically for the probeset-level identifiers. It is built upon the `AnnotationDbi` framework, allowing for efficient querying of genomic metadata. The primary organism is *Rattus norvegicus*.

## Core Workflows

### Loading the Package
```R
library(ragene11stprobeset.db)
```

### Using the select() Interface
The preferred method for interacting with this package is the `select()` function from `AnnotationDbi`.

1.  **Check available columns and keytypes:**
    ```R
    columns(ragene11stprobeset.db)
    keytypes(ragene11stprobeset.db)
    ```
2.  **Perform a lookup:**
    ```R
    # Map probe IDs to Gene Symbols and Entrez IDs
    probes <- c("10700001", "10700003")
    select(ragene11stprobeset.db, 
           keys = probes, 
           columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
           keytype = "PROBEID")
    ```

### Using the Bimap Interface (Legacy)
While `select()` is preferred, specific mappings can be accessed via Bimap objects.

*   **Map Probes to Symbols:** `ragene11stprobesetSYMBOL`
*   **Map Probes to Entrez IDs:** `ragene11stprobesetENTREZID`
*   **Map Probes to GO Terms:** `ragene11stprobesetGO`
*   **Map Symbols to Probes:** `ragene11stprobesetALIAS2PROBE`

Example of Bimap usage:
```R
# Convert a mapping to a list
symbol_list <- as.list(ragene11stprobesetSYMBOL[1:5])
```

### Chromosomal Information
You can retrieve chromosome locations and lengths:
```R
# Chromosome for each probe
chr_map <- as.list(ragene11stprobesetCHR)

# Starting position of the gene
loc_map <- as.list(ragene11stprobesetCHRLOC)

# Length of chromosomes
ragene11stprobesetCHRLENGTHS
```

### Pathway and Functional Annotation
*   **KEGG Pathways:** Use `ragene11stprobesetPATH` to find pathway IDs associated with probes.
*   **Enzyme Commission (EC) Numbers:** Use `ragene11stprobesetENZYME`.
*   **PubMed IDs:** Use `ragene11stprobesetPMID` to find literature references for specific probes.

## Tips
*   **Multiple Mappings:** Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping (potentially resulting in more rows than input keys).
*   **Reverse Mappings:** Most Bimaps have a reverse counterpart (e.g., `ragene11stprobesetSYMBOL2PROBE` is the reverse of `ragene11stprobesetSYMBOL`).
*   **Database Connection:** You can access the underlying SQLite database directly using `ragene11stprobeset_dbconn()`.

## Reference documentation
- [ragene11stprobeset.db Reference Manual](./references/reference_manual.md)