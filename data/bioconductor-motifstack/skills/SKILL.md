---
name: bioconductor-motifstack
description: The motifStack package provides flexible graphical representations and visualizations for multiple sequence motifs across DNA, RNA, and amino acid sequences. Use when user asks to visualize multiple motifs, create motif stacks or hierarchical clustering trees, generate radial layouts, or produce interactive motif plots.
homepage: https://bioconductor.org/packages/release/bioc/html/motifStack.html
---

# bioconductor-motifstack

## Overview
The `motifStack` package is a flexible tool for the graphical representation of multiple sequence motifs. It supports DNA, RNA, and amino acid sequences, as well as affinity logos (PSAM). Its primary strength lies in its ability to visualize the relationships between multiple motifs through stacking, hierarchical clustering (trees), radial layouts, and interactive d3.js plots.

## Core Workflows

### 1. Importing Motifs
Motifs can be imported from external files or converted from Bioconductor objects like `XMatrixList`.
```R
library(motifStack)

# Import from files (formats: meme, transfac, jaspar, scpd, cisbp, psam)
motif_files <- system.file("extdata", "MA0002.1.jaspar", package="motifStack")
motifs <- importMatrix(motif_files)

# Convert from JASPAR2020/TFBSTools
library(JASPAR2020)
library(TFBSTools)
pfms <- getMatrixSet(JASPAR2020, list(species="Mus musculus"))
motifs <- importMatrix(pfms)
```

### 2. Basic Logo Plotting
You can plot individual motifs as Position Count Matrices (pcm) or Position Frequency Matrices (pfm).
```R
# Create a pcm object manually
pcm_data <- matrix(runif(28), nrow=4)
rownames(pcm_data) <- c("A", "C", "G", "T")
motif <- new("pcm", mat=pcm_data, name="Example_Motif")

# Basic plot
plot(motif)

# Customize: change font, color scheme, or scale
motif@color <- colorset(colorScheme='basepairing')
plot(motif, font="serif", ic.scale=FALSE, ylab="probability")
```

### 3. Adding Markers
Markers (rectangles, lines, or text) can highlight specific positions within a motif.
```R
markerRect <- new("marker", type="rect", start=6, stop=7, gp=gpar(lty=2, fill=NA, col="orange"))
markerText <- new("marker", type="text", start=2, label="core", gp=gpar(col="red"))
motif@markers <- c(markerRect, markerText)
plot(motif)
```

### 4. Visualizing Multiple Motifs (Stacks and Trees)
The `motifStack` function is the primary high-level interface for visualizing groups of motifs.
```R
# Load multiple motifs
motif_path <- system.file("extdata", package="motifStack")
pcms <- importMatrix(dir(motif_path, "pcm$", full.names=TRUE))

# Vertical stack
motifStack(pcms, layout="stack")

# Stack with hierarchical clustering tree
motifStack(pcms, layout="tree")

# Radial phylogeny (best for large numbers of motifs)
motifStack(pcms, layout="radialPhylog", circle=0.3)
```

### 5. Advanced Visualizations
- **Motif Cloud**: Use `motifCloud` to create a tag-cloud style visualization based on motif signatures.
- **Motif Circos**: Use `motifCircos` for circular layouts comparing two sets of motifs.
- **Motif Piles**: Use `motifPiles` to combine motif logos with heatmaps or other annotations.
- **Interactive Plots**: Use `browseMotifs(pfms)` to open an interactive d3.js-based visualization in a browser.

### 6. Integration with ggplot2
Use `geom_motif` to incorporate sequence logos into ggplot objects.
```R
library(ggplot2)
df <- data.frame(xmin=0.25, ymin=0.25, xmax=0.75, ymax=0.75)
df$motif <- list(pcm2pfm(motif))

ggplot(df, aes(xmin=xmin, ymin=ymin, xmax=xmax, ymax=ymax, motif=motif)) +
    geom_motif() + theme_bw()
```

## Tips and Best Practices
- **RNA Motifs**: To plot RNA, ensure the rownames of your matrix use "U" instead of "T". You can use `DNAmotifToRNAmotif(motifs)` for quick conversion.
- **Alignment**: Before stacking, motifs often need alignment. `motifStack` handles this internally, but you can manually use `DNAmotifAlignment` for more control.
- **Trimming**: For cleaner plots, use `trimMotif(motif, t=0.4)` to remove low-information positions from the ends of the motif.
- **Color Schemes**: Use `colorset(alphabet="DNA", colorScheme="classic")` to quickly apply standard color palettes.

## Reference documentation
- [motifStack Vignette](./references/motifStack_HTML.md)