---
name: bioconductor-lola
description: bioconductor-lola performs functional enrichment analysis for genomic ranges by comparing user-provided coordinates against databases of regulatory elements and transcription factor binding sites. Use when user asks to identify enriched genomic features, perform locus overlap analysis, or test for enrichment of regulatory regions within specific genomic coordinates.
homepage: https://bioconductor.org/packages/release/bioc/html/LOLA.html
---


# bioconductor-lola

## Overview
LOLA (Locus Overlap Analysis) is a Bioconductor package designed to provide functional enrichment analysis for genomic ranges. Unlike gene-set enrichment, LOLA works directly with genomic coordinates, allowing users to identify enriched regulatory elements, transcription factor binding sites, or other genomic features within their data. It uses a Fisher's Exact Test to compare "user sets" against a "region database" relative to a defined "universe" (background).

## Core Workflow

### 1. Load the Region Database
LOLA requires a structured database of genomic regions. You can load a local database using `loadRegionDB()`.
```r
library(LOLA)
# Path to a folder containing collection subfolders (e.g., hg19)
dbPath = "path/to/LOLACore/hg19"
regionDB = loadRegionDB(dbPath)
```

### 2. Prepare Input Data
You need your regions of interest (userSets) and a background set (userUniverse). Both must be `GRanges` objects.
```r
# Load regions from BED files
userSetA = readBed("setA.bed")
userSetB = readBed("setB.bed")

# Combine multiple sets into a GRangesList
userSets = GRangesList(setA = userSetA, setB = userSetB)

# Load or define the universe (background)
userUniverse = readBed("universe.bed")
```

### 3. Run Enrichment Analysis
The `runLOLA` function performs the statistical tests.
```r
locResults = runLOLA(userSets, userUniverse, regionDB, cores = 1)
```

### 4. Explore and Export Results
Results are returned as a `data.table`.
```r
# View top results ranked by p-value or composite rank
head(locResults[order(maxRnk, decreasing = FALSE)])

# Extract specific overlaps for a result row
oneResult = locResults[1, ]
overlaps = extractEnrichmentOverlaps(oneResult, userSets, regionDB)

# Write results to disk
writeCombinedEnrichment(locResults, outFolder = "lolaResults", includeSplits = TRUE)
```

## Choosing a Universe
The "universe" is the set of all regions that *could* have been included in your user set.
- **Broad Universe:** Use a union of all known active elements (e.g., all DNase hypersensitive sites) to ask what your regions overlap among any known regulatory elements.
- **Restricted Universe:** Use the union of all tested regions (e.g., all peaks in an experiment, not just the differential ones) to ask what makes the differential subset unique relative to the experiment's background.

## Key Functions
- `loadRegionDB(path)`: Loads a database of genomic region sets.
- `readBed(file)`: Quickly reads a BED file into a `GRanges` object.
- `runLOLA(userSets, userUniverse, regionDB)`: Main enrichment calculation.
- `getRegionSet(regionDB, collections, filenames)`: Extracts specific sets from the database.
- `writeCombinedEnrichment(results, outFolder)`: Exports results to TSV files.

## Reference documentation
- [Choosing a LOLA Universe](./references/choosingUniverse.md)
- [Getting Started with LOLA](./references/gettingStarted.md)
- [Using LOLA Core](./references/usingLOLACore.md)