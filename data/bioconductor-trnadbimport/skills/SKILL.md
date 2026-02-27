---
name: bioconductor-trnadbimport
description: The tRNAdbImport package retrieves tRNA sequences, genomic coordinates, and structural information from the tRNAdb and mitotRNAdb databases into R. Use when user asks to import tRNA data by organism or amino acid, fetch specific tRNAdb entries by ID, search sequences using BLAST, or handle modified RNA sequences as GRanges objects.
homepage: https://bioconductor.org/packages/release/bioc/html/tRNAdbImport.html
---


# bioconductor-trnadbimport

## Overview

The `tRNAdbImport` package provides an interface to the tRNAdb and mitotRNAdb databases. It allows users to retrieve tRNA sequences, genomic coordinates, and structural information directly into R. The data is returned as `GRanges` objects, which are compatible with the wider Bioconductor ecosystem (e.g., `GenomicRanges`, `Biostrings`, `rtracklayer`). A key feature is the support for `ModRNAStringSet` from the `Modstrings` package, which preserves information about modified nucleotides when importing RNA sequences.

## Core Workflows

### 1. Importing tRNA Data
You can search for tRNAs by organism and amino acid specificity.

```r
library(tRNAdbImport)

# Import DNA sequences for specific amino acids from a species
gr <- import.tRNAdb(organism = "Saccharomyces cerevisiae",
                    aminoacids = c("Phe", "Ala"))

# Import mitochondrial tRNAs
gr_mito <- import.mttRNAdb(organism = "Bos taurus",
                           aminoacids = "Ala")
```

### 2. Specific Retrieval Methods
If you have specific IDs or sequences, use these targeted functions:
*   `import.tRNAdb.id(tdbID)`: Fetch a specific entry by its tRNAdb ID.
*   `import.tRNAdb.blast(blastSeq)`: Search the database using a sequence query.

### 3. Handling Modified RNA Sequences
To retrieve sequences with modification information, set the `database` argument to "RNA".

```r
# Import as RNA to include modifications
gr_rna <- import.tRNAdb(organism = "Saccharomyces cerevisiae",
                        aminoacids = "Phe",
                        database = "RNA")

# The tRNA_seq column will be a ModRNAStringSet
# Use Modstrings to see modification details
library(Modstrings)
separate(gr_rna$tRNA_seq)
```

### 4. Data Validation and Conversion
*   **Validation**: Use `istRNAdbGRanges(gr)` to verify if a `GRanges` object contains the mandatory metadata columns required by the package.
*   **Exporting**: Use `tRNAdb2GFF(gr)` to convert the database-specific metadata into a format compatible with GFF3 specifications for saving via `rtracklayer::export.gff3()`.

## Usage Tips
*   **Server Availability**: The tRNAdb server can occasionally be offline. If functions return a "Server not available" warning, the web service is likely down.
*   **Sequence Sanitization**: When importing RNA, modification characters are automatically mapped to a unified dictionary defined in the `Modstrings` package.
*   **Downstream Analysis**: The output `GRanges` objects are designed to work seamlessly with the `tRNA` package for visualization and further structural analysis.

## Reference documentation

- [tRNAdbImport](./references/tRNAdbImport.md)