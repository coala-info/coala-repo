---
name: bioconductor-enrichtf
description: This tool performs transcription factor enrichment analysis by integrating motif enrichment with the PECA model to identify functional regulators from genomic regions. Use when user asks to identify candidate transcription factors, perform motif enrichment analysis, or connect genomic regions to target genes in human or mouse genomes.
homepage: https://bioconductor.org/packages/3.9/bioc/html/enrichTF.html
---

# bioconductor-enrichtf

name: bioconductor-enrichtf
description: Transcription Factor (TF) enrichment analysis using the enrichTF R package. Use this skill when you need to identify candidate functional TFs from a set of genomic regions (BED format) by combining motif enrichment with the PECA model. It supports human (hg19, hg38) and mouse (mm9, mm10) genomes.

# bioconductor-enrichtf

## Overview

The `enrichTF` package performs Transcription Factor enrichment analysis. Unlike standard motif enrichment, `enrichTF` integrates four types of biological relationships:
1.  **Region-gene**: Connecting genomic regions to target genes (via proximity or 3D genome data like Hi-C).
2.  **Gene-TF**: Correlation scores between genes and TFs based on the PECA model.
3.  **TF-motif**: Mapping TFs to one or more sequence motifs.
4.  **Motif-region**: Scanning motifs within the input genomic regions.

The package provides both a high-level "one-step" pipeline and a modular workflow for customized analysis.

## Installation and Loading

```R
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("enrichTF")

library(enrichTF)
```

## Quick Start (Default Pipeline)

The simplest way to run the analysis is using `PECA_TF_enrich`. You only need a BED file (chr, start, end) of your regions of interest (e.g., ATAC-seq peaks).

```R
# Path to your BED file
foregroundBedPath <- "path/to/your_peaks.bed"

# Run the full pipeline
# Supported genomes: "hg19", "hg38", "mm9", "mm10"
PECA_TF_enrich(inputForegroundBed = foregroundBedPath, genome = "hg38")
```

## Customized Workflow

For more control, use the modular steps. This is often done using the `pipeFrame` framework and `magrittr` pipes.

### 1. Initialize and Generate Background
Set the genome and generate background regions that match the GC-content of your input.
```R
setGenome("hg38")
gen <- genBackground(inputForegroundBed = foregroundBedPath)
```

### 2. Connect Regions to Target Genes
Identify which genes are likely regulated by the input regions.
```R
conTG <- enrichRegionConnectTargetGene(gen)
```

### 3. Scan Motifs in Regions
Scan for motif occurrences within the foreground and background regions.
```R
# motifRc="integrate" uses the integrated motif-TF mapping
findMotif <- enrichFindMotifsInRegions(gen, motifRc = "integrate")
```

### 4. Perform TF Enrichment Test
Calculate the final enrichment p-values and FDR.
```R
result <- enrichTFsEnrichInRegions(gen)
```

### Combined Pipe Workflow
```R
library(magrittr)
setGenome("hg38")

results <- genBackground(inputForegroundBed = foregroundBedPath) %>%
    enrichRegionConnectTargetGene() %>%
    enrichFindMotifsInRegions(motifRc = "integrate") %>%
    enrichTFsEnrichInRegions()
```

## Interpreting Results

The output is a data frame containing:
*   **TF**: The Transcription Factor name.
*   **Motif_enrichment**: P-value from Fisher's exact test for motif presence.
*   **Target_gene_enrichment**: P-value from the t-test of TF-Gene correlation scores.
*   **P_value**: Combined significance score.
*   **FDR**: False Discovery Rate adjusted p-value.

## Tips
*   **Genome Support**: Ensure the `genome` parameter matches your data assembly.
*   **Background Generation**: The default generates 10,000 background regions. If your input set is very large or small, you may need to adjust parameters in `genBackground`.
*   **Center-based Scanning**: By default, the package scans 1000bp regions (-500 to +500 relative to the center of the input regions).

## Reference documentation
- [An Introduction to enrichTF](./references/enrichTF.Rmd)
- [enrichTF-Introduction](./references/enrichTF.md)