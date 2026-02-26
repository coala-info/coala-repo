---
name: bioconductor-biovizbase
description: biovizBase provides foundational utilities and standardized color schemes for genomic data visualization in R. Use when user asks to access biological color palettes, calculate disjoint levels for genomic tracks, shrink genomic gaps, compute GC content, or fetch ideogram data from UCSC.
homepage: https://bioconductor.org/packages/release/bioc/html/biovizBase.html
---


# bioconductor-biovizbase

name: bioconductor-biovizbase
description: Specialized utilities and color schemes for genomic data visualization in R. Use when Claude needs to: (1) Access standardized biological color palettes (nucleotides, amino acids, cytobands, strands), (2) Calculate disjoint levels for genomic tracks (stepping), (3) Shrink genomic gaps for visualization, (4) Compute GC content or mismatch summaries from BAM files, or (5) Fetch ideogram data from UCSC.

## Overview

biovizBase provides the foundational infrastructure for Bioconductor visualization packages, most notably ggbio. It handles the transformation of raw genomic data into formats suitable for plotting, manages colorblind-safe palettes for biological categories, and provides utilities for coordinate manipulation such as gap shrinking and track stepping.

## Color Schemes

Manage and retrieve standardized color palettes for biological data.

*   Retrieve default colors: Use getBioColor(type) where type is "DNA_BASES_N", "STRAND", "CYTOBAND", or "AMINO_ACID_CODE".
*   Access colorblind-safe palettes: Use colorBlindSafePal(palette) to get a color-generating function. Check available palettes with blind.pal.info.
*   Visualize palettes: Use showColor(colors) or plotColorLegend(colors) to inspect schemes.
*   Customize global colors: Modify the biovizBase option list via opts <- getOption("biovizBase") and reset with options(biovizBase = opts).

## Genomic Range Manipulation

Prepare GRanges objects for track-based visualization.

*   Add stepping levels: Use addStepping(gr) to calculate disjoint bins and add a .levels column. This prevents overlapping features in tracks. Use the group.name argument to keep related intervals (e.g., paired-end reads) on the same level.
*   Shrink genomic gaps:
    1.  Identify gaps using gaps(gr).
    2.  Calculate a max gap threshold using maxGap(gaps_gr, ratio = 0.05).
    3.  Create a transformation function: shrink.fun <- shrinkageFun(gaps_gr, max.gap = threshold).
    4.  Apply the function to your data: shrunk_gr <- shrink.fun(gr).
*   Validate ideograms: Use isIdeogram(gr) or isSimpleIdeogram(gr) to check if a GRanges object conforms to ideogram standards.

## Biological Summaries

Extract quantitative information from genomic sequences and alignments.

*   Calculate GC content: Use GCcontent(BSgenome.Species, gr) to get the GC proportion for specific regions.
*   Summarize BAM files:
    1.  Generate a pileup: pileupAsGRanges(bamfile, region = gr).
    2.  Create a mismatch table: pileupGRangesAsVariantTable(pileup_gr, BSgenome.Species). This returns counts for A, C, T, G, N and indicates matches/mismatches against the reference.

## Ideograms and Data Sets

Fetch and use reference data for genomic overviews.

*   Fetch ideograms: Use getIdeogram(genome = "hg19", cytoband = TRUE) to download cytoband information from UCSC.
*   Access built-in data:
    *   data(hg19IdeogramCyto): Pre-loaded human cytoband data.
    *   data(genesymbol): A GRanges object of human gene symbols and Ensembl IDs for quick mapping.

## Reference documentation

- [An Introduction to biovizBase](./references/intro.md)