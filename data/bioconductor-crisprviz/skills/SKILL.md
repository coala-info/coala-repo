---
name: bioconductor-crisprviz
description: This tool provides graphical visualization of CRISPR guide RNA cutting locations against gene models and genomic features. Use when user asks to visualize gRNA distribution across gene models, create publication-quality plots of GuideSet objects, compare targeting between multiple nucleases, or overlay genomic annotations like SNPs and repeats.
homepage: https://bioconductor.org/packages/release/bioc/html/crisprViz.html
---


# bioconductor-crisprviz

name: bioconductor-crisprviz
description: Graphical visualization of CRISPR guide RNA (gRNA) cutting locations against gene models and genomic regions. Use this skill to create publication-quality plots of GuideSet objects, visualize gRNA distribution across exons/isoforms, compare multiple nucleases (e.g., Cas9 vs Cas12a), and overlay genomic annotations like SNPs, repeats, CAGE peaks, or DNase sites.

# bioconductor-crisprviz

## Overview

The `crisprViz` package provides specialized plotting functions for the `crisprVerse` ecosystem. It primarily acts as a visualization bridge for `GuideSet` objects created in `crisprDesign`, allowing users to see exactly where gRNAs target in relation to gene structures (transcripts, CDS, exons) and other genomic features. It uses `Gviz` under the hood to produce track-based genomic visualizations.

## Core Workflows

### Visualizing a GuideSet

The primary function is `plotGuideSet`. It requires a `GuideSet` and a gene model (typically a `GRangesList`).

```r
library(crisprViz)
library(crisprDesign)

# Basic plot
plotGuideSet(myGuideSet, 
             geneModel=myGeneModel, 
             targetGene="GENE_NAME")
```

### Adjusting the Plot Window

By default, the plot zooms to the range of the spacers. Use coordinate arguments to expand the view:

*   `from`, `to`: Set specific genomic coordinates.
*   `extend.left`, `extend.right`: Add padding (in bp) around the target region.

```r
plotGuideSet(myGuideSet,
             geneModel=myGeneModel,
             targetGene="KRAS",
             extend.left=1000,
             extend.right=1000)
```

### Customizing Guide Appearance

*   **Hide Labels**: Set `showGuideLabels=FALSE` to reduce clutter in dense regions.
*   **PAM Site Only**: Set `pamSiteOnly=TRUE` to represent guides as single points rather than full boxes.
*   **Color by Score**: Use `onTargetScore` to color-code guides by a specific metadata column (e.g., "score_deephf").
*   **Stacking**: Use `guideStacking="dense"` to save vertical space.

### Adding Genomic Annotations

You can overlay additional genomic features (Repeats, SNPs, etc.) using the `annotations` argument, which accepts a named list of `GRanges` objects.

```r
plotGuideSet(myGuideSet,
             geneModel=myGeneModel,
             annotations=list(Repeats=repeats_gr, DNase=dnase_gr),
             includeSNPTrack=TRUE)
```

### Comparing Multiple Nucleases

To compare targeting density between different nucleases (e.g., SpCas9 vs. AsCas12a), use `plotMultipleGuideSets`.

```r
plotMultipleGuideSets(list(Cas9=guideSet1, Cas12a=guideSet2),
                      geneModel=myGeneModel,
                      targetGene="LTN1",
                      gcWindow=10) # Adds GC content track
```

### Sequence-Level Visualization

To see individual nucleotides, provide a `BSgenome` object and zoom in to a narrow range.

```r
plotGuideSet(myGuideSet,
             geneModel=myGeneModel,
             bsgenome=BSgenome.Hsapiens.UCSC.hg38,
             margin=0.3)
```

## Tips for Success

*   **Plot Size**: If the plot fails to render due to many isoforms, increase the device dimensions using `grDevices::pdf()` or `grDevices::quartz()` with larger `width` and `height` values.
*   **Filtering**: It is often better to filter the `GuideSet` (e.g., removing guides with SNPs or repeats) using `crisprDesign` functions *before* passing the object to `plotGuideSet`.
*   **Strand Labels**: Note that `->` indicates the forward strand and `<-` indicates the reverse strand in track labels.

## Reference documentation

- [Introduction to crisprViz](./references/intro.Rmd)
- [Introduction to crisprViz (Markdown Version)](./references/intro.md)