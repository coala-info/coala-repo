---
name: bioconductor-vasp
description: This tool discovers, quantifies, and visualizes genome-wide variable alternative splicing events from RNA-seq data. Use when user asks to calculate Single Splicing Strength scores, identify genotype-specific splicing events using bimodal distribution analysis, or generate splicing plots from Ballgown objects.
homepage: https://bioconductor.org/packages/3.11/bioc/html/vasp.html
---

# bioconductor-vasp

name: bioconductor-vasp
description: Discovery, quantification, and visualization of genome-wide variable alternative splicing events from RNA-seq data. Use this skill to calculate Single Splicing Strength (3S) scores, identify genotype-specific splicing (GSS) events using bimodal distribution analysis, and generate publication-quality splicing plots from Ballgown objects.

# bioconductor-vasp

## Overview
The `vasp` package (Variation of Splicing in Population) is designed for analyzing alternative splicing variations across populations using short-read RNA-seq data. It operates on `ballgown` objects (typically generated via HISAT2 and StringTie). Its core metric is the **Single Splicing Strength (3S) score**, calculated as the junction read count normalized by the gene-level average read coverage. This allows for the identification of Genotype-Specific Splicing (GSS) and the visualization of complex splicing patterns.

## Core Workflow

### 1. Data Preparation
`vasp` requires a `ballgown` object as input.
```r
library(vasp)
library(ballgown)

# Load existing ballgown data
data(rice.bg) 

# Or create from StringTie output directory
# path <- "path/to/ballgown_data"
# bg_obj <- ballgown(samples = list.dirs(path = path, recursive = FALSE))
```

### 2. Calculating Splicing Scores (3S)
You can calculate scores for a specific gene or the entire genome. The `junc.type` can be "score" (normalized) or "count" (raw).

```r
# For a single gene
gene_score <- spliceGene(rice.bg, gene = "MSTRG.183", junc.type = "score")

# For the whole genome
genome_splice <- spliceGenome(rice.bg, gene.select = NA, intron.select = NA)
# genome_splice$score contains the matrix; genome_splice$intron contains GRanges
```

### 3. Finding Genotype-Specific Splicing (GSS)
The `BMfinder` function uses k-means clustering to identify features with bimodal distributions, which often correspond to large-effect splicing variations in a population.

```r
# Find bimodal features (GSS)
gss_results <- BMfinder(gene_score, cores = 1)

# Results show sample groupings (1 or 2) for identified introns
print(gss_results)
```

### 4. Visualization
`splicePlot` creates multi-panel figures showing read depth, junction arcs, and gene models. Note: This function relies on the `Sushi` package.

```r
# Plot specific gene region for selected samples
samples_to_plot <- sampleNames(rice.bg)[c(1, 3, 5)]
bam_dir <- system.file("extdata", package = "vasp")

splicePlot(rice.bg, 
           gene = 'MSTRG.183', 
           samples = samples_to_plot, 
           bam.dir = bam_dir, 
           junc.text = TRUE)
```

## Key Functions
- `spliceGene()`: Calculates 3S scores for a specific gene ID.
- `spliceGenome()`: Calculates scores for all genes; returns a list with a score matrix and a `GRanges` object.
- `BMfinder()`: Discovers bimodal distribution features (GSS). Parameters `maf` (minor allele frequency) and `fold` (fold change between groups) can be adjusted.
- `getDepth()`: Extracts read depth from BAM files in a bedgraph-compatible format.
- `getGeneinfo()`: Extracts gene/exon structure from Ballgown objects for plotting.

## Tips
- **Filtering**: Use `gene.select` and `intron.select` in `spliceGenome` to filter out low-expressed genes or introns with insufficient junction reads (e.g., `intron.select = "rowMaxs(x) >= 5"`).
- **Score Interpretation**: A 3S score of 1.0 suggests the junction is used at a level consistent with the average coverage of the gene.
- **BAM Files**: For `splicePlot` to show actual read depth, the `bam.dir` must contain `.bam` files named identically to the sample names in the Ballgown object.

## Reference documentation
- [VaSP: Quantification and Visualization of Variations of Splicing in Population](./references/VaSP.Rmd)
- [VaSP Package Manual](./references/manual.md)
- [VaSP Function Reference](./references/vasp.md)