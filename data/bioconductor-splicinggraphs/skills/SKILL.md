---
name: bioconductor-splicinggraphs
description: This tool creates, manipulates, and visualizes splicing graphs from gene models to identify and quantify alternative splicing events. Use when user asks to construct splicing graphs from TxDb objects, identify alternative splicing bubbles, assign RNA-seq reads to graph edges, or visualize gene models and splice graphs.
homepage: https://bioconductor.org/packages/release/bioc/html/SplicingGraphs.html
---

# bioconductor-splicinggraphs

name: bioconductor-splicinggraphs
description: Create, manipulate, and visualize splicing graphs from gene models (TxDb or GRangesList). Use this skill to identify alternative splicing (AS) events, compute "bubbles" (complete AS events), assign RNA-seq reads to graph edges, and count reads for isoform quantification.

## Overview
The `SplicingGraphs` package represents the exon-intron structure of genes as directed acyclic graphs (DAGs). Nodes represent splice sites (acceptors, donors, TSS, TES), and edges represent exons or introns. This representation allows for the formal identification of alternative splicing patterns (bubbles) and the assignment of RNA-seq reads to specific splicing features.

## Core Workflow

### 1. Creating a SplicingGraphs Object
Splicing graphs are built from a `TxDb` object or a `GRangesList`.
```R
library(SplicingGraphs)
library(TxDb.Hsapiens.UCSC.hg19.refGene)

txdb <- TxDb.Hsapiens.UCSC.hg19.refGene
# Optional: Restrict to specific chromosomes for performance
isActiveSeq(txdb)[-match("chr14", names(isActiveSeq(txdb)))] <- FALSE

# Construct the SplicingGraphs object
sg <- SplicingGraphs(txdb, min.ntx=2)
```

### 2. Basic Manipulation and Inspection
The `SplicingGraphs` object is list-like, indexed by gene IDs.
- `names(sg)`: Get gene IDs.
- `sg[[gene_id]]`: Extract transcripts for a gene as a `GRangesList`.
- `txpath(sg[[gene_id]])`: Get the sequence of splice site IDs for each transcript.
- `sgedges(sg["gene_id"])`: Extract a DataFrame of all edges (from, to, type, supporting transcripts).
- `sgnodes(sg["gene_id"])`: Extract node IDs and types.

### 3. Identifying Alternative Splicing (Bubbles)
A "bubble" is a complete AS event between a source and sink node with multiple valid paths.
```R
# Compute bubbles for a specific gene
gene_bubbles <- bubbles(sg["3183"])

# Inspect AS codes and descriptions
# ASCODE2DESC provides English descriptions for common patterns
descriptions <- ASCODE2DESC[gene_bubbles$AScode]
```

### 4. Assigning and Counting RNA-seq Reads
Assign aligned reads (BAM files) to graph edges to quantify splicing.
```R
library(GenomicAlignments)

# Load paired-end reads
param <- ScanBamParam(flag=scanBamFlag(isSecondaryAlignment=FALSE))
gapairs <- readGAlignmentPairs("path/to/file.bam", use.names=TRUE, param=param)

# Assign reads to the graph
sg <- assignReads(sg, gapairs, sample.name="Sample1")

# Count reads per edge
counts_df <- countReads(sg)
```

### 5. Visualization
- `plotTranscripts(sg[[gene_id]])`: Plot the transcript models.
- `plot(sg["gene_id"])`: Plot the splicing graph.
- `plot(sgraph(sg["gene_id"], tx_id.as.edge.label=TRUE))`: Plot graph with transcript labels on edges.

## Tips and Best Practices
- **Uninformative Nodes**: By default, the package simplifies graphs by removing nodes with in-degree and out-degree of 1 that do not contribute to alternative splicing.
- **Strand Specificity**: Splicing graphs are only defined for genes where all exons are on the same chromosome and strand. Trans-splicing is not supported.
- **Memory Management**: Creating graphs for an entire genome is memory-intensive. Use `isActiveSeq()` on the `TxDb` object to process one chromosome at a time.
- **Read Compatibility**: `assignReads` identifies "compatible" reads. A junction read is assigned to an intron edge and its flanking exon edges if the junction coordinates match the graph structure exactly.

## Reference documentation
- [SplicingGraphs and RNA-seq data](./references/SplicingGraphs.md)