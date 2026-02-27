---
name: bioconductor-ribodipa
description: RiboDiPA identifies differential ribosome occupancy patterns along transcripts by analyzing the positional distribution of ribosome-protected fragments. Use when user asks to identify shifts in ribosome distribution, map RPFs to P-sites, perform differential pattern testing, or visualize ribosome occupancy tracks.
homepage: https://bioconductor.org/packages/release/bioc/html/RiboDiPA.html
---


# bioconductor-ribodipa

## Overview

RiboDiPA (Ribosome Differential Pattern Analysis) is a bioinformatics pipeline for analyzing the positional distribution of ribosomes along transcripts. Unlike standard differential expression which measures total abundance, RiboDiPA identifies shifts in ribosome occupancy patterns. The workflow involves mapping RPFs to P-sites, binning counts to handle data sparsity, and performing statistical inference using a negative binomial distribution.

## Core Workflow

### 1. Prepare Class Labels
Define the experimental design using a data frame. The `comparison` column must use `1` for the reference/control and `2` for the treatment.

```r
classlabel <- data.frame(
    condition = c("mutant", "mutant", "wildtype", "wildtype"),
    comparison = c(2, 2, 1, 1)
)
rownames(classlabel) <- c("mutant1", "mutant2", "wildtype1", "wildtype2")
```

### 2. The Wrapper Function (Quick Start)
Use `RiboDiPA()` to run the entire pipeline (mapping, binning, and testing) in one step.

```r
# bam_path: vector of BAM files; gtf_path: path to GTF file
result <- RiboDiPA(bam_path, gtf_path, classlabel, cores = 2)
# View top significant genes
head(result$gene[order(result$gene$qvalue), ])
```

### 3. Step-by-Step Analysis

#### P-site Mapping
Map RPFs to P-site positions. Use `psite.mapping = "auto"` to let the package calculate offsets based on start codons, or provide a custom offset matrix.

```r
data.psite <- psiteMapping(bam_file_list = bam_path, gtf_file = gtf_path, psite.mapping = "auto")
```

#### Data Binning
Aggregate P-site counts into bins. Adaptive binning (`bin.width = 0`) is recommended for sparse Ribo-seq data.

```r
# Adaptive binning (default)
data.binned <- dataBinning(data = data.psite$coverage, bin.width = 0)

# Single-codon resolution (fixed width)
data.codon <- dataBinning(data = data.psite$coverage, bin.width = 1)
```

#### Differential Pattern Testing
Perform the statistical test. The $T$-value (0 to 1) indicates the magnitude of the pattern shift.

```r
result.pst <- diffPatternTest(data = data.binned, classlabel = classlabel, method = c('gtxr', 'qvalue'))
```

## Visualization

### Plotting Tracks
Visualize P-site counts or binned data for specific genes.

```r
# Plot per-nucleotide P-site tracks
plotTrack(data = data.psite, genes.list = c("GENE_ID"))

# Plot binned data with significant bins highlighted
plotTest(result = result.pst, genes.list = c("GENE_ID"), threshold = 0.05)
```

### Genome Browser Integration
Generate `GRanges` objects for visualization in `igvR`.

```r
# Generate tracks for IGV
tracks.bin <- binTrack(data = result.pst, exon.anno = data.psite$exons)
```

## Key Parameters and Tips

- **Cores**: Most functions support a `cores` argument. If left unspecified, the package uses `parallel::detectCores()`.
- **T-value**: Use the $T$-value to prioritize genes. A high $T$-value indicates a large structural difference in ribosome distribution, even if $q$-values are similar.
- **Exon Binning**: For higher organisms with complex splicing, use `diffPatternTestExon()` to treat exons as the fundamental bins for testing.
- **GTF Consistency**: Ensure the GTF file matches the reference genome used for BAM alignment exactly.

## Reference documentation
- [RiboDiPA](./references/RiboDiPA.md)