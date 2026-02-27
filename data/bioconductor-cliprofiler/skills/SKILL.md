---
name: bioconductor-cliprofiler
description: "cliProfiler visualizes and analyzes the distribution of CLIP-seq peaks and RNA modification sites across various genomic features. Use when user asks to profile protein-RNA interactions across transcript regions, visualize peak enrichment around splice sites, or analyze sequence motif distributions."
homepage: https://bioconductor.org/packages/release/bioc/html/cliProfiler.html
---


# bioconductor-cliprofiler

## Overview
The `cliProfiler` package facilitates the visualization and analysis of CLIP-seq data (iCLIP, eCLIP) and RNA modification sites (e.g., m6A). It transforms peak calling results (GRanges) into informative profile plots that reveal the distribution of protein-RNA interactions across various genomic features like UTRs, CDS, introns, and splice sites.

## Core Workflow

1. **Data Preparation**: Load peak data into a `GRanges` object.
2. **Annotation**: Provide a Gencode GFF3 annotation file (required for most functions).
3. **Profiling**: Execute specific profile functions which return a list containing:
    - `[[1]]`: A `GRanges` object with calculated relative positions.
    - `[[2]]`: A `ggplot2` object for visualization.

## Primary Functions

### Transcriptome-wide Profiling
- `metaGeneProfile(object, annotation, ...)`: Visualizes peaks across 5'UTR, CDS, and 3'UTR.
    - Use `include_intron = TRUE` for pre-mRNA analysis or `FALSE` for polyA+ data.
    - Use `split = TRUE` to see separate distributions for each region.
- `geneTypeProfile(object, annotation)`: Summarizes the types of genes (e.g., protein_coding, lncRNA) where peaks are located.

### Splicing and Intronic Analysis
- `intronProfile(object, annotation, ...)`: Profiles peaks within intronic regions relative to 5' and 3' splice sites.
    - Parameters `minLength` and `maxLength` filter introns by size.
- `exonProfile(object, annotation)`: Profiles peaks in internal exons (surrounded by introns).
- `spliceSiteProfile(object, annotation, flanking=200, bin=40)`: Shows absolute distance enrichment around splice junctions.

### Custom and Sequence Analysis
- `windowProfile(object, annotation)`: A flexible version for non-Gencode annotations or specific custom regions (e.g., specific enhancers or ncRNAs).
- `motifProfile(object, motif, genome, flanking=10, fraction=TRUE)`: Analyzes sequence motif enrichment (using IUPAC codes) around peak centers. Requires a `BSgenome` object.

## Key Parameters and Filtering
- `group`: Specify a metadata column in the GRanges object (e.g., "Treatment" vs "Control") to generate comparative plots.
- `exlevel`: Exclude specific Gencode metadata levels (e.g., `exlevel = 3` to remove low-confidence annotations).
- `extranscript_support_level`: Filter by transcript support level (TSL). Use `6` to exclude `NA` values.

## Tips for Interpretation
- **Position Values**: In relative profiles (metaGene, intron, exon), values near 0 represent the 5' end/splice site, while values near 1 represent the 3' end/splice site.
- **Customization**: Since the output plots are `ggplot` objects, you can modify them using standard `ggplot2` syntax (e.g., `+ ggtitle("New Title") + theme_bw()`).

## Reference documentation
- [cliProfiler Vignettes](./references/cliProfilerIntroduction.md)
- [cliProfiler Source](./references/cliProfilerIntroduction.Rmd)