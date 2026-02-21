---
name: bioconductor-ggbio
description: The package supports detailed views of particular genomic regions, as well as genome-wide overviews. Supported overviews include ideograms and grand linear views. High-level plots include sequence fragment length, edge-linked interval to data view, mismatch pileup, and several splicing summaries.
homepage: https://bioconductor.org/packages/release/bioc/html/ggbio.html
---

# bioconductor-ggbio

name: bioconductor-ggbio
description: Visualization of genomic data using the ggbio package. Use this skill to create complex genomic plots including ideograms, gene models, circular plots (Circos-style), Manhattan plots (grand linear), and karyograms. It is particularly useful for integrating Bioconductor objects like GRanges, TxDb, and BamFiles with the ggplot2 grammar of graphics.

# bioconductor-ggbio

## Overview
The `ggbio` package extends the grammar of graphics (ggplot2) to biological data. It provides high-level functions to visualize genomic regions, genome-wide overviews, and specific tracks (alignments, variants, and annotations). It leverages standard Bioconductor data structures such as `GRanges`, `GenomicRangesList`, `TxDb`, and `SummarizedExperiment`.

## Core Workflows

### 1. High-Level Plotting with autoplot
The `autoplot` function is the primary entry point for most Bioconductor objects. It automatically chooses a sensible visualization based on the object class.

```r
library(ggbio)
library(Homo.sapiens)

# Plot a gene model from an OrganismDb or TxDb object
wh <- genesymbol[c("BRCA1")]
autoplot(Homo.sapiens, which = wh)

# Plot a BAM file (coverage and alignments)
autoplot("path/to/file.bam", which = wh, geom = "gapped.pair")

# Plot a VCF file (variants)
autoplot("path/to/file.vcf.bgz", which = wh)
```

### 2. Building Multi-Track Plots
Use the `tracks()` function to stack different genomic visualizations into a single aligned view.

```r
p1 <- Ideogram(genome = "hg19")
p2 <- autoplot(Homo.sapiens, which = wh)
p3 <- autoplot(bam_file, which = wh)

tracks(Ideogram = p1, Gene = p2, Alignment = p3, heights = c(2, 5, 3))
```

### 3. Genome-Wide Overviews
`ggbio` provides specialized layouts for whole-genome data.

*   **Circular Plots:** Use `circle()` within a `ggbio()` constructor to create Circos-style plots.
    ```r
    ggbio() + 
      circle(gr_data, geom = "rect", aes(fill = value)) + 
      circle(gr_links, geom = "link", linked.to = "to.gr")
    ```
*   **Grand Linear (Manhattan) Plots:** Use `plotGrandLinear()` for GWAS results or genome-wide scores.
    ```r
    plotGrandLinear(gr_snp, aes(y = pvalue), color = c("gray40", "gray70"))
    ```
*   **Karyograms:** Use `layout = "karyogram"` in `autoplot` to show data on a stacked chromosome layout.
    ```r
    autoplot(gr_data, layout = "karyogram", aes(color = score))
    ```

### 4. Navigation and Zooming
You can programmatically navigate plots using the navigation API.

```r
p <- autoplot(Homo.sapiens, which = wh)
p + zoom(1/2)      # Zoom in
p + nextView()     # Move to next genomic chunk
```

## Tips and Best Practices
*   **Coordinate Systems:** Use `coord = "genome"` to transform multiple chromosomes into a single linear coordinate system.
*   **Aesthetics:** Since `ggbio` is built on `ggplot2`, you can use `+ theme()`, `+ scale_fill_manual()`, and other standard ggplot layers.
*   **Ideograms:** The `Ideogram()` function supports "hg19", "hg18", "mm10", and "mm9" internally without needing to download data.
*   **Performance:** For large BAM or VCF files, always provide a `which` argument (a `GRanges` object) to limit the data loaded into memory.

## Reference documentation
- [ggbio: visualization toolkits for genomic data](./references/ggbio.md)