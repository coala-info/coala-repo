---
name: bioconductor-vtpnet
description: Bioconductor-vtpnet constructs and analyzes Variant-Transcription Factor-Phenotype networks by intersecting GWAS variants with transcription factor binding sites. Use when user asks to build bipartite graphs linking phenotypes to transcription factors, identify overlaps between GWAS hits and genomic motifs, or visualize relationships between diseases and regulatory elements.
homepage: https://bioconductor.org/packages/release/bioc/html/vtpnet.html
---

# bioconductor-vtpnet

name: bioconductor-vtpnet
description: Tools for constructing and analyzing Variant-Transcription Factor-Phenotype (VTP) networks. Use this skill to investigate the relationship between GWAS variants, transcription factor (TF) binding motifs, and disease phenotypes, including bipartite graph construction and motif matching.

## Overview

The `vtpnet` package facilitates the creation of bipartite graphs where one set of nodes represents phenotypes (e.g., autoimmune disorders) and the other represents transcription factors. An edge is formed when a SNP associated with a phenotype falls within a genomic region containing a transcription factor binding site (TFBS). This allows researchers to visualize and statistically interpret "common networks for common diseases."

## Core Workflows

### 1. Loading Data Resources
The package provides curated GWAS data and example TF binding site data.

```r
library(vtpnet)

# Load Maurano et al. GWAS data (hg19)
data(maurGWAS) 

# Load example TF binding site data (e.g., PAX4)
data(pax4)      # FIMO-based matches
data(pax4_85)   # 85% match threshold
data(pax4_75)   # 75% match threshold
```

### 2. Building a VTP Network
To find links between a specific TF and phenotypes, intersect the GWAS variants with the TFBS ranges.

```r
# Find GWAS variants that overlap with PAX4 binding sites
vp_pax4 = maurGWAS[overlapsAny(maurGWAS, pax4)]

# Extract unique phenotypes linked to this TF
linked_phenotypes = unique(vp_pax4$disease_trait)
```

### 3. Filtering and Mapping
Use `filterGWASbyMap` and `getOneHits` to refine networks based on specific disease classes or higher-confidence matches.

```r
library(gwascat)
data(cancerMap)
# Load legacy GWAS catalog if needed
load(system.file("legacy/gwrngs19.rda", package="gwascat"))

# Filter catalog for cancer-related traits
cangw = filterGWASbyMap(gwrngs19, cancerMap)

# Get specific hits for a TF (e.g., pax4) against the filtered catalog
hits = getOneHits(pax4, cangw, "fimo")
```

### 4. Visualizing Bipartite Graphs
Use the `graph` and `Rgraphviz` packages to visualize the relationships.

```r
library(graph)
library(Rgraphviz)

# Create an adjacency matrix (Diseases x TFs)
# 1 indicates a link exists based on overlap analysis
adjm = matrix(1, nrow=length(diseaseTags), ncol=length(TFtags))
dimnames(adjm) = list(diseaseTags, TFtags)

# Convert to a bipartite graph object
cvtp = ugraph(aM2bpG(adjm))

# Plot a subgraph
sub = subGraph(nodes(cvtp)[1:10], cvtp)
plot(sub, attrs=list(node=list(shape="box", fixedsize=FALSE)))
```

## Generating Custom Motif Matches
If pre-computed data is unavailable, use `matchPWM` from `Biostrings` to scan the genome.

```r
library(MotifDb)
library(BSgenome.Hsapiens.UCSC.hg19)

# Query a motif
pax4_motif = query(MotifDb, "pax4")[[1]]

# Match against a chromosome (e.g., chr1)
subj = Hsapiens[["chr1"]]
matches = matchPWM(pax4_motif, subj, min.score="75%")

# Convert to GRanges for use with vtpnet
pax4_gr = GRanges("chr1", as(matches, "IRanges"))
```

## Tips
- **Genome Versions**: Ensure your GWAS data and TFBS data use the same coordinate system (typically hg19 for the provided `maurGWAS` data).
- **Sensitivity**: The number of TP links is highly sensitive to the motif matching threshold (e.g., 75% vs 85% vs FIMO p-values).
- **SNP Injection**: For high-precision work, consider injecting SNPs into the reference genome (ALT-injection) to see if variants create or destroy binding sites, rather than just relying on the reference genome.

## Reference documentation
- [vtpnet: variant-transcription factor-phenotype networks](./references/vtpnet.md)