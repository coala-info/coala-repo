---
name: bioconductor-scanmirapp
description: The bioconductor-scanmirapp package provides a Shiny-based interface and utility functions for predicting, managing, and visualizing miRNA binding sites using the scanMiR ecosystem. Use when user asks to launch an interactive miRNA analysis app, manage large genomic datasets with IndexedFst, create ScanMiRAnno objects, or perform full-transcriptome miRNA scans.
homepage: https://bioconductor.org/packages/release/bioc/html/scanMiRApp.html
---


# bioconductor-scanmirapp

## Overview

The `scanMiRApp` package provides a Shiny-based interface and a suite of convenience functions for the `scanMiR` ecosystem. It simplifies miRNA binding site prediction by wrapping genomic annotations (BSgenome, Ensembldb) into `ScanMiRAnno` objects. A key feature is the `IndexedFst` class, which allows for high-performance, on-disk storage and indexed retrieval of large data frames or GRanges (such as whole-genome scans) without exhausting system memory.

## Core Workflows

### 1. Managing Large Data with IndexedFst
Use `IndexedFst` to handle massive binding site collections. It creates a pair of files (`.fst` for data and `.idx.rds` for the index).

```r
library(scanMiRApp)

# Save a data.frame or GRanges with an index column
saveIndexedFst(my_data, index.by="category", file.prefix="path/to/my_file")

# Load the indexed object (memory-efficient)
idx_obj <- loadIndexedFst("path/to/my_file")

# Access specific subsets by index name
subset_data <- idx_obj$CategoryName
```

### 2. Working with ScanMiRAnno Objects
`ScanMiRAnno` objects are the central containers for species-specific genomic data and miRNA models.

```r
# Load standard annotations (e.g., "GRCh38", "GRCm38", "Rnor_6")
anno <- ScanMiRAnno("GRCh38")

# Custom annotations require a BSgenome and an ensembldb object
# anno <- ScanMiRAnno(genome=my_bsgenome, ensdb=my_ensdb)

# Attach pre-compiled scans to the object for faster app performance
anno$scan <- loadIndexedFst("path/to/scans")
```

### 3. Transcript Analysis and Visualization
Retrieve sequences and visualize predicted binding sites for specific miRNA-target pairs.

```r
# Get UTR sequence for a transcript
seq <- getTranscriptSequence("ENST00000...", anno)

# Plot binding sites on a UTR
plotSitesOnUTR(tx="ENST00000...", annotation=anno, miRNA="hsa-miR-155-5p")
```

### 4. Full-Transcriptome Scanning
Perform comprehensive scans for all miRNAs across all protein-coding transcripts.

```r
# Run a full scan (use ncores for speed)
full_scan <- runFullScan(anno, ncores=4)

# Identify enriched miRNA-target pairs (potential sponges/cargo)
enriched_pairs <- enrichedMirTxPairs(full_scan)
```

### 5. Launching the Shiny App
The app provides interactive visualization for both transcript-centered and miRNA-centered analysis.

```r
# Launch with a list of annotations
scanMiRApp(list(Human=anno_human, Mouse=anno_mouse))

# Enable multithreading in the app
scanMiRApp(list(Human=anno), BP=BiocParallel::MulticoreParam(4))
```

## Tips for Efficiency
- **Multithreading**: Always use the `nthreads` argument in `loadIndexedFst`/`saveIndexedFst` and the `ncores` argument in `runFullScan` for large datasets.
- **Memory Management**: Use `IndexedFst` for any dataset that exceeds a few hundred megabytes to keep the R session responsive.
- **Caching**: The Shiny app uses a default 10MB cache per user; adjust `maxCacheSize` in `scanMiRApp()` if working with very large custom sequences.

## Reference documentation
- [The IndexedFst class](./references/IndexedFST.md)
- [scanMiRApp: shiny app and related convenience functions](./references/scanMiRApp.md)