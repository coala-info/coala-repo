---
name: riboplot
description: riboplot visualizes translation dynamics by plotting RNA-seq coverage and Ribo-seq P-site positions against transcript models. Use when user asks to visualize translation events, identify translated isoforms, detect frameshifts, or plot Ribo-seq data against gene structures.
homepage: https://github.com/hsinyenwu/RiboPlotR
---


# riboplot

## Overview
The `riboplot` skill (utilizing the RiboPlotR package) enables the visualization of translation dynamics by plotting RNA-seq coverage and Ribo-seq P-site positions against transcript models. It is particularly effective for detecting novel translation events in unannotated regions, identifying translated isoforms, and visualizing frameshifts or variations in coding regions. It supports plant-style GTF/GFF3 formats where transcript names follow a `gene.number` convention.

## Core Workflow
To generate a Ribo-plot, follow this sequential R workflow:

1.  **Initialize Gene Structure**: Load the transcriptome annotation.
    ```R
    # Load GTF/GFF3 containing gene, mRNA, exon, and CDS ranges
    gs <- gene.structure("path/to/annotation.gtf")
    ```

2.  **Load uORF Structure (Optional)**: If analyzing upstream Open Reading Frames.
    ```R
    us <- uorf.structure("path/to/uorf_annotation.gtf")
    ```

3.  **Load Sequencing Data**: Bind BAM files (RNA-seq) and P-site coordinate files (Ribo-seq).
    ```R
    # Load RNA-seq BAM and Ribo-seq P-site files
    data <- rna_bam.ribo(rna_bam = "sample_rna.bam", ribo_psite = "sample_psite.txt")
    ```

4.  **Generate Plot**: Visualize a specific gene and isoform.
    ```R
    # Plot isoform 1 of a specific gene
    # Default colors: Red (Frame 0), Blue (Frame +1), Green (Frame +2), Grey (Outside CDS)
    PLOTch(gene_name = "AT1G01010", isoform_number = 1, gs = gs, data = data)
    ```

## Input File Requirements
*   **Annotation (GTF/GFF3)**: Must be compatible with `GenomicFeatures`. Note: Current version is optimized for plant genome formats where transcript IDs are formatted as `GeneName.IsoformNumber`.
*   **RNA-seq**: Mapped and coordinate-sorted BAM files.
*   **Ribo-seq P-sites**: A tab-delimited file containing P-site coordinates.
*   **uORF (Optional)**: GTF/GFF3 file specifically for uORF coordinates.

## Expert Tips and Best Practices
*   **Isoform Selection**: RiboPlotR plots one isoform at a time. If Ribo-seq reads appear grey (out of frame) in the expected CDS, try plotting alternative isoforms to see if the P-sites align better with a different model.
*   **P-site Identification**: High-quality translation data will show a majority of P-sites in **red** within the expected CDS. A shift to blue or green often indicates a frameshift or a misannotated start codon.
*   **Visualizing Regulation**: Use the `uorf.structure` function to overlay yellow boxes representing uORFs. This helps identify if a uORF is being translated instead of, or in addition to, the primary CDS.
*   **Comparative Analysis**: You can read in up to two sets of BAM and P-site files simultaneously to compare different conditions or replicates within the same plotting functions.

## Reference documentation
- [RiboPlotR Main Documentation](./references/github_com_hsinyenwu_RiboPlotR.md)