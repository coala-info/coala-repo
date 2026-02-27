---
name: bioconductor-rmmquant
description: Rmmquant is a Bioconductor package for gene expression quantification that explicitly handles multi-mapping reads and overlapping genomic features. Use when user asks to quantify gene expression from BAM files, handle multi-mapping reads using merged feature categories, or perform read counting with specific overlap thresholds.
homepage: https://bioconductor.org/packages/release/bioc/html/Rmmquant.html
---


# bioconductor-rmmquant

## Overview

Rmmquant is a Bioconductor package designed for gene expression quantification. While similar to tools like `featureCounts` or `HTSeq-counts`, its primary advantage is the explicit handling of multi-mapping reads. It provides a robust mechanism to assign reads that map to multiple genomic locations or overlapping features by creating merged feature categories (e.g., `gene_A--gene_B`) or using overlap thresholds to disambiguate assignments.

## Core Workflow

The primary interface is the `RmmquantRun` function, which returns a `SummarizedExperiment` object.

### 1. Basic Quantification
To quantify expression using a GTF file and a BAM file:

```r
library(Rmmquant)

# Define paths to inputs
gtfFile <- "path/to/annotation.gtf"
bamFile <- "path/to/reads.bam"

# Run quantification
output <- RmmquantRun(gtfFile, bamFile)

# Access the count matrix
counts <- assays(output)$counts
```

### 2. Using GenomicRanges
Instead of a GTF file, you can provide annotations directly as `GenomicRanges` or `GenomicRangesList`.

```r
library(TxDb.Mmusculus.UCSC.mm9.knownGene)
gr <- genes(TxDb.Mmusculus.UCSC.mm9.knownGene)

output <- RmmquantRun(genomicRanges = gr, readsFiles = "sample.bam")
```

### 3. Handling Multi-mapping and Overlaps
Rmmquant provides specific parameters to refine how reads are assigned when they overlap multiple genes:

*   **overlap**: Controls the overlap requirement.
    *   Negative value: Read must be fully included in the feature.
    *   Positive integer: Minimum number of overlapping nucleotides.
    *   Float (0, 1): Minimum percentage of the read that must overlap.
*   **nOverlapDiff / pcOverlapDiff**: Used to assign a read to a single gene if it overlaps "significantly" more with one gene than others, preventing the creation of a merged feature (e.g., `gene_A--gene_B`).

### 4. Library Specificity
Specify the sequencing protocol using the `strands` parameter:
*   `U`: Unstranded (default).
*   `F` / `R`: Single-end forward or reverse.
*   `FR` / `RF`: Paired-end orientations.

## Downstream Analysis

The output is compatible with standard Bioconductor differential expression tools.

### Integration with DESeq2
```r
library(DESeq2)

# Create DESeqDataSet from Rmmquant output
dds <- DESeqDataSetFromMatrix(countData = assays(output)$counts,
                              colData = colData(output),
                              design = ~ condition)
```

### Interpreting Statistics
Use `colData(output)` to inspect mapping statistics:
*   `n.uniquely.mapped.reads`: Reads mapping to exactly one location.
*   `n.ambiguously.mapped.hits`: Hits overlapping multiple distinct features.
*   `n.unassigned.hits`: Hits that do not overlap any features.

## Tips and Best Practices
*   **Input Sorting**: While not strictly required, BAM files sorted by position are preferred for performance.
*   **NH Flag**: Ensure your aligner (e.g., STAR, TopHat2) sets the `NH` tag correctly, as Rmmquant relies on it to identify multi-mapping reads.
*   **Gene Names**: Set `printGeneName = TRUE` in `RmmquantRun` to use human-readable gene names in the count matrix instead of internal IDs.
*   **Merging Features**: If a read maps to both Gene A and Gene B, Rmmquant creates a row `Gene_A--Gene_B`. If you find many reads in these merged rows, consider adjusting `mergeThreshold` to consolidate counts into the primary gene.

## Reference documentation
- [The Rmmquant package](./references/Rmmquant.md)