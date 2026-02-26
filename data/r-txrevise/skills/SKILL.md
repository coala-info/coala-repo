---
name: r-txrevise
description: The txrevise package decomposes complex transcript models into independent alternative transcription events categorized by promoter usage, internal splicing, and poly-adenylation. Use when user asks to decompose transcript models, construct alternative transcription events, or prepare gene annotations for event-level quantification.
homepage: https://cran.r-project.org/web/packages/txrevise/index.html
---


# r-txrevise

## Overview
The `txrevise` package provides utilities to decompose complex transcript models into independent alternative transcription events. It categorizes these events into three types:
- **Upstream**: Alternative promoter usage.
- **Contained**: Alternative splicing (internal exons).
- **Downstream**: Alternative poly-adenylation (3' end usage).

By splitting transcripts into these components, researchers can distinguish between different molecular mechanisms and improve the resolution of transcript usage analysis.

## Installation
Install the package from GitHub using `devtools`:

```R
# install.packages("devtools")
devtools::install_github("kauralasoo/txrevise")
```

## Core Workflow

### 1. Prepare Annotations
Before constructing events, convert a GTF file into a processed format. This step requires a transcript tags file (usually generated via the `extractTranscriptTags.py` script provided in the package) to handle truncated protein-coding transcripts.

```R
library(txrevise)

# Load GTF and tags to create a txdb-like object or rds
# Typically handled via the prepareAnnotations.R script logic:
# 1. Import GTF using rtracklayer
# 2. Extend truncated transcripts using tags
# 3. Save as an RDS for efficient processing
```

### 2. Construct Events
The primary function of the package is to take a set of transcripts for a gene and identify shared exons to use as "anchors" for event construction.

```R
# Example of the logic used in constructEvents.R
# Load prepared annotations
annotations <- readRDS("annotations.rds")

# Construct events for a specific gene
# grp_1 and grp_2 represent different sets of shared exons
# fill = TRUE fills truncated transcripts to the start/end of the gene
events <- txrevise::constructEvents(
  transcripts, 
  shared_exons, 
  fill = TRUE
)
```

### 3. Event Groups
`txrevise` generates two groups of events based on the choice of shared exons:
- **Group 1 (grp_1)**: Uses the most common shared exons as anchors.
- **Group 2 (grp_2)**: Uses a more restrictive set of shared exons, often resulting in shorter but more comparable event models across transcripts.

### 4. Exporting for Quantification
Events are exported as GFF3 files. These must be converted to FASTA format for use with Salmon or kallisto.

```R
# Use system tools like gffread to convert the output
# gffread -w output.fa -g genome.fa input.gff3
```

## Key Usage Tips
- **Independent Quantification**: Always quantify the six event types (grp_1/2 x upstream/contained/downstream) independently. Because they share exons, quantifying them together in a single index will lead to incorrect abundance estimates.
- **Parallelization**: Processing a full Ensembl GTF is computationally expensive. Split genes into batches (e.g., 1 to 2000) to process in parallel on a cluster.
- **Masking**: By default, `txrevise` masks alternative internal exons in promoter and 3' end events to ensure that "upstream" and "downstream" changes are not confounded by internal splicing.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)