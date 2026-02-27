---
name: bioconductor-tximport
description: This tool imports and summarizes transcript-level abundance estimates from quantification tools like Salmon, Kallisto, and RSEM for downstream differential expression analysis. Use when user asks to summarize transcript counts to the gene level, correct for gene length changes across samples, or prepare quantification data for DESeq2, edgeR, and limma-voom.
homepage: https://bioconductor.org/packages/release/bioc/html/tximport.html
---


# bioconductor-tximport

name: bioconductor-tximport
description: Import and summarize transcript-level abundance estimates from quantification tools (Salmon, Kallisto, RSEM, etc.) for gene-level or transcript-level differential expression analysis. Use when processing RNA-seq data to: (1) Summarize transcript counts to gene level, (2) Correct for gene length changes across samples, (3) Prepare data for DESeq2, edgeR, or limma-voom, or (4) Import scRNA-seq data from Alevin.

# bioconductor-tximport

## Overview
The `tximport` package imports transcript-level abundance, estimated counts, and effective lengths from various quantification tools and summarizes them into gene-level matrices. This workflow corrects for potential changes in gene length across samples (e.g., from differential isoform usage) and provides a seamless interface to downstream Bioconductor differential expression packages like *DESeq2*, *edgeR*, and *limma-voom*.

## Basic Workflow

### 1. Prepare Input Files
Create a named vector of paths to the quantification files. The names should correspond to sample IDs.
```r
files <- file.path(dir, "salmon", samples$run, "quant.sf")
names(files) <- samples$sample_id
```

### 2. Create Transcript-to-Gene Mapping
For gene-level summarization, provide a data frame with two columns: (1) Transcript ID and (2) Gene ID. The order is strict, but column names are flexible.
```r
# Using a TxDb object
library(AnnotationDbi)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
k <- keys(txdb, keytype = "TXNAME")
tx2gene <- select(txdb, k, "GENEID", "TXNAME")
```

### 3. Import Data
Use the `tximport` function, specifying the tool `type` (e.g., "salmon", "kallisto", "rsem", "stringtie", "alevin", "oarfish").
```r
library(tximport)
txi <- tximport(files, type = "salmon", tx2gene = tx2gene)
```

## Downstream Integration

### DESeq2
Pass the `txi` object directly to `DESeqDataSetFromTximport`. This automatically handles the gene-length offsets.
```r
library(DESeq2)
dds <- DESeqDataSetFromTximport(txi, sampleTable, ~condition)
```

### edgeR
Manually calculate offsets from the `length` matrix to account for gene length changes.
```r
library(edgeR)
cts <- txi$counts
normMat <- txi$length
normMat <- normMat / exp(rowMeans(log(normMat)))
normCts <- cts / normMat
eff.lib <- calcNormFactors(normCts) * colSums(normCts)
normMat <- sweep(normMat, 2, eff.lib, "*")
normMat <- log(normMat)

y <- DGEList(cts)
y <- scaleOffset(y, normMat)
```

### limma-voom
Use `countsFromAbundance="lengthScaledTPM"` or `"scaledTPM"` during import, as `voom` does not use the offset matrix.
```r
txi <- tximport(files, type = "salmon", tx2gene = tx2gene, countsFromAbundance = "lengthScaledTPM")
y <- DGEList(txi$counts)
y <- calcNormFactors(y)
v <- voom(y, design)
```

## Advanced Options and Tips

- **Transcript-level output**: Set `txOut = TRUE` to skip gene-level summarization.
- **Inferential Replicates**: If Salmon/Kallisto were run with Gibbs sampling or bootstrapping, `tximport` automatically imports these into the `infReps` list element.
- **ID Versioning**: If transcript IDs in the files have versions (e.g., `ENST000001.1`) but the `tx2gene` table does not, use `ignoreTxVersion = TRUE`.
- **3' Tagged RNA-seq**: For 3' end sequencing, do not use length correction. Use the raw counts (`txi$counts`) directly without offsets or TPM scaling.
- **Performance**: Ensure the `readr` package is installed; `tximport` will use it automatically for significantly faster file reading.
- **Alevin (scRNA-seq)**: Import Alevin's `quants_mat.gz` by setting `type = "alevin"`. This returns a gene-by-cell sparse matrix.

## Reference documentation
- [Importing transcript abundance with tximport](./references/tximport.md)