---
name: bioconductor-redseq
description: Bioconductor-redseq analyzes Restriction Enzyme Digestion sequencing data to differentiate genomic accessibility across the genome. Use when user asks to build genome-wide restriction enzyme cut site maps, assign mapped sequence tags to restriction enzyme sites, visualize cut frequency distributions, or identify differentially enriched sites across experimental conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/REDseq.html
---


# bioconductor-redseq

name: bioconductor-redseq
description: Analysis of Restriction Enzyme Digestion sequencing (REDseq) data to differentiate genomic accessibility. Use when analyzing high-throughput sequencing data from RE digestion to: (1) Build genome-wide restriction enzyme cut site (RECS) maps, (2) Assign mapped sequence tags to RE sites using various partitioning strategies, (3) Visualize cut frequency and tag-to-site distances, or (4) Identify differentially enriched/depleted RE sites across experimental conditions.

## Overview

REDseq enables genome-wide differentiation of highly accessible and inaccessible regions by analyzing restriction enzyme (RE) digestion patterns. The `REDseq` package provides a complete workflow for building genomic RE maps, associating sequencing tags with those sites, and performing statistical tests to identify significant or differential digestion levels.

## Core Workflow

### 1. Building a Restriction Enzyme Map
Use `buildREmap` to identify all potential cut sites in a genome based on a specific RE recognition sequence.

```r
library(REDseq)
library(BSgenome.Celegans.UCSC.ce2) # Example genome

# Path to a fasta file containing the RE recognition site (e.g., "CCNGG")
REpatternFilePath <- system.file("extdata", "examplePattern.fa", package="REDseq")

myMap <- buildREmap(REpatternFilePath, BSgenomeName=Celegans, outfile="REmap.txt")
```

### 2. Assigning Sequence Tags to RE Sites
The `assignSeq2REsite` function associates mapped reads (as `GRanges`) with the RE map.

```r
# partitionMultipleRE strategies: "unique", "average", "estimate", "best", "random"
assignedTags <- assignSeq2REsite(
  query.gr = example.REDseq, 
  subject.gr = example.map, 
  cut.offset = 1,           # Offset for sticky end repair
  seq.length = 36, 
  allowed.offset = 5, 
  min.FragmentLength = 60, 
  max.FragmentLength = 300, 
  partitionMultipleRE = "estimate"
)
```

**Note for Paired-End Data:**
Call `assignSeq2REsite` twice (once for starts, once for ends). Set `min.FragmentLength = 0`, `max.FragmentLength = 1`, and `seq.length = 1` for both calls.

### 3. Visualization
Visualize the quality and distribution of the digestion.

```r
# Plot cut frequency in a specific region
plotCutDistribution(assignedTags, example.map, chr="2", xlim=c(3012000, 3020000))

# Plot distance distribution of tags relative to RE sites
distanceHistSeq2RE(assignedTags, ylim=c(0, 25))
```

### 4. Statistical Analysis
Generate count tables and perform enrichment tests.

```r
# Generate count table
REsummary <- summarizeByRE(assignedTags, by="Weight")

# Case A: Single experimental condition (Binomial test)
significantSites <- binom.test.REDseq(REsummary)

# Case B: Two conditions without replicates (Fisher's Exact Test)
# Input 'x' is a matrix/dataframe with columns: REid, control_counts, treated_counts
diffSites <- compareREDseq(x)

# Case C: Multiple conditions with replicates
# Use summarizeByRE output as input for DESeq or edgeR
```

## Key Functions and Parameters

- `buildREmap`: Requires a `BSgenome` object.
- `assignSeq2REsite`: 
    - `cut.offset`: Distance from the start of the RE recognition site to the actual cut position.
    - `allowed.offset`: Tolerance for imperfect repair or sequencing.
    - `partitionMultipleRE`: Determines how to handle reads that could belong to multiple RE sites. "estimate" is often preferred for probabilistic assignment.
- `summarizeByRE`: Aggregates assigned tags. Use `by="Weight"` if using partitioning strategies that assign fractional reads.

## Reference documentation

- [REDseq](./references/REDseq.md)