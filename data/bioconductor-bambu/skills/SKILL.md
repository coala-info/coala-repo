---
name: bioconductor-bambu
description: Bambu performs transcript discovery and quantification from long-read RNA-Seq data. Use when user asks to identify novel isoforms, estimate transcript or gene abundance, or analyze long-read sequencing data from Nanopore or PacBio.
homepage: https://bioconductor.org/packages/release/bioc/html/bambu.html
---

# bioconductor-bambu

name: bioconductor-bambu
description: Transcript discovery and quantification from long-read RNA-Seq data (Nanopore/PacBio). Use when Claude needs to identify novel isoforms, estimate transcript/gene abundance, or perform differential expression analysis using aligned long-read data.

# bioconductor-bambu

## Overview

The `bambu` package is designed for the analysis of long-read RNA-Seq data. It performs two primary tasks:
1. **Transcript Discovery**: Identifying novel transcripts by comparing aligned reads against a reference annotation.
2. **Quantification**: Estimating the expression levels of both known and newly discovered transcripts using an Expectation-Maximization (EM) algorithm.

The package outputs a `SummarizedExperiment` object, making it compatible with standard Bioconductor downstream tools like `DESeq2` and `DEXSeq`.

## Core Workflow

### 1. Installation and Loading
Install via BiocManager and load the library:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("bambu")
library(bambu)
```

### 2. Preparing Input Data
Bambu requires three main inputs:
- **Aligned Reads**: A path to a BAM file or a `Rsamtools::BamFileList`.
- **Reference Annotations**: A GTF file, `TxDb` object, or a `bambuAnnotation` object.
- **Genome Sequence**: A FASTA file or a `BSgenome` object.

```r
# Prepare annotations from GTF
annotations <- prepareAnnotations("path/to/annotation.gtf")

# Define genome sequence
genome <- "path/to/genome.fa" # or a BSgenome object
```

### 3. Running Bambu
The `bambu` function is the primary interface. It can perform discovery and quantification simultaneously.

```r
# Standard run (Discovery + Quantification)
se <- bambu(reads = "sample.bam", annotations = annotations, genome = genome)

# Multi-sample run with parallel processing
bamFiles <- Rsamtools::BamFileList(c("s1.bam", "s2.bam"), yieldSize = 1000000)
se <- bambu(reads = bamFiles, annotations = annotations, genome = genome, ncore = 4)
```

### 4. Accessing Results
The output is a `SummarizedExperiment` object.
- `assays(se)$counts`: Transcript-level counts.
- `assays(se)$CPM`: Counts per million.
- `rowRanges(se)`: Genomic coordinates (GRangesList) of all transcripts.
- `rowData(se)`: Metadata including gene IDs and discovery status.

## Key Functionalities

### Modulating Discovery Sensitivity
Control the balance between sensitivity and precision using the Novel Discovery Rate (NDR).
- **Lower NDR (e.g., 0.05)**: Higher precision, fewer novel transcripts (conservative).
- **Higher NDR (e.g., 0.2)**: Higher sensitivity, more novel transcripts.

```r
se <- bambu(reads = bamFiles, annotations = annotations, genome = genome, NDR = 0.1)
```

### Gene-Level Expression
Convert transcript-level estimates to gene-level estimates for standard differential expression.

```r
seGene <- transcriptToGeneExpression(se)
```

### Visualization
Use `plotBambu` to inspect results.

```r
# Heatmap of sample correlations
plotBambu(se, type = "heatmap")

# PCA plot
plotBambu(se, type = "pca")

# Visualize specific gene models and expression
plotBambu(se, type = "annotation", gene_id = "ENSG00000099968")
```

### Exporting Data
Save extended annotations and expression matrices.

```r
# Write counts and annotations to a directory
writeBambuOutput(se, path = "./results", prefix = "project_")

# Export extended GTF only
writeToGTF(rowRanges(se), file = "extended_annotations.gtf")
```

## Advanced Usage

### Efficiency with rcFiles
For large datasets or iterative runs, save intermediate "read class" (rc) files to skip the time-consuming read-to-transcript assignment step.

```r
# Save rcFiles during run
se <- bambu(reads = bamFiles, annotations = annotations, genome = genome, rcOutDir = "./rc_cache")

# Use rcFiles in subsequent runs
se_new <- bambu(reads = "./rc_cache/sample.rds", annotations = annotations, genome = genome)
```

### De-novo Discovery
If no reference annotation is available, run in de-novo mode.

```r
# Run without annotations (uses pre-trained model)
se_denovo <- bambu(reads = bamFiles, annotations = NULL, genome = genome, NDR = 0.1)
```

### Downstream Differential Expression
Bambu results are compatible with `DESeq2`.

```r
library(DESeq2)
# Round counts for DESeq2
dds <- DESeqDataSetFromMatrix(countData = round(assays(seGene)$counts),
                              colData = colData(seGene),
                              design = ~ condition)
dds <- DESeq(dds)
```

## Reference documentation
- [Analysing Long Read RNA-Seq data with bambu](./references/bambu.md)