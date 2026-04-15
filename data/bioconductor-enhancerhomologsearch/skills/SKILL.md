---
name: bioconductor-enhancerhomologsearch
description: This tool identifies orthologous regulatory elements across species by comparing histone marks and transcription factor binding pattern similarity. Use when user asks to identify enhancer homologs, search for orthologous regulatory elements using ENCODE data, or calculate transcription factor binding pattern similarity between species.
homepage: https://bioconductor.org/packages/release/bioc/html/enhancerHomologSearch.html
---

# bioconductor-enhancerhomologsearch

name: bioconductor-enhancerhomologsearch
description: Identification of putative mammalian orthologs to enhancers in species lacking whole-genome comparison data (e.g., zebrafish to human/mouse). Use this skill to search for enhancer homologs using ENCODE histone marks (H3K4me1) and Transcription Factor Binding Pattern Similarity (TFBPS).

# bioconductor-enhancerhomologsearch

## Overview

The `enhancerHomologSearch` package identifies orthologous regulatory elements (enhancers/silencers) across species. Unlike traditional methods that rely on sequence conservation (which often fails in distal regulatory regions), this package uses a functional approach. It identifies candidate regions in target species (Human/Mouse) using ENCODE histone marks and ranks them based on Transcription Factor Binding Pattern Similarity (TFBPS) compared to a query enhancer.

## Core Workflow

### 1. Prepare Query Enhancer
Extract the DNA sequence of the known enhancer from the source species (e.g., Zebrafish).

```r
library(BSgenome.Drerio.UCSC.danRer10)
library(GenomicRanges)

# Define coordinates and extract sequence
query_coords <- GRanges("chr4", IRanges(19050041, 19051709))
query_seq <- getSeq(BSgenome.Drerio.UCSC.danRer10, query_coords)
```

### 2. Retrieve ENCODE Candidate Regions
Download functional regions from ENCODE for the target species (Human/Mouse), typically filtered by tissue type.

```r
library(enhancerHomologSearch)
library(BSgenome.Hsapiens.UCSC.hg38)

# Get H3K4me1 peaks for heart tissue in human
hs_candidates <- getENCODEdata(genome = Hsapiens, 
                               partialMatch = c(biosample_summary = "heart"))
```

### 3. Calculate Binding Pattern Similarity (TFBPS)
This is the core step. It compares the motif binding patterns of the query sequence against all candidates.

```r
# Load provided motif clusters
data(motifs)
PWMs <- motifs[["dist60"]]

# Search for similarity (use maximalShuffleEnhancers for P-value accuracy)
aln_hs <- searchTFBPS(query_seq, hs_candidates, 
                      PWMs = PWMs, 
                      queryGenome = Drerio,
                      maximalShuffleEnhancers = 100)
```

### 4. Filter and Refine Results
Filter candidates based on P-value and genomic distance from the target gene's Transcription Start Site (TSS).

```r
# Example: Filter for candidates within 100kb of target gene but >5kb from TSS
# distance(aln_hs) <- distance(peaks(aln_hs), target_gene_range)
aln_hs_filtered <- subset(aln_hs, pval < 0.1 & distance > 5000)
```

### 5. Comparative Alignment
Perform multiple sequence alignment between the query enhancer and the identified homologs from different species.

```r
aln_list <- list(human = aln_hs_filtered, mouse = aln_mm_filtered)
al <- alignment(query_seq, aln_list, method = "ClustalW")

# Export results
saveAlignments(al, output_folder = "results", format = "html")
```

## Key Functions

- `getENCODEdata()`: Fetches candidate regulatory regions from ENCODE based on histone markers.
- `searchTFBPS()`: Calculates similarity scores based on TF binding patterns rather than direct sequence alignment.
- `alignment()`: Creates a `DNAMultipleAlignment` object combining the query and identified homologs.
- `conservedMotifs()`: Identifies specific TF motifs that are preserved across the orthologous regions.

## Tips for Success

- **Species-Specific Packages**: Ensure you have the correct `BSgenome`, `TxDb`, and `org.db` packages installed for all species involved in the search.
- **Computational Cost**: `searchTFBPS` is resource-intensive. When testing, subset your candidate regions to a 1MB window around the target homolog gene.
- **Motif Selection**: The package provides `motifs` data. Using clustered motifs (e.g., `dist60`) reduces redundancy and improves TFBPS calculation speed.
- **P-values**: Increase `maximalShuffleEnhancers` (default 1000) in `searchTFBPS` for more robust statistical significance, though this increases runtime.

## Reference documentation
- [enhancerHomologSearch Guide](./references/enhancerHomologSearch.md)