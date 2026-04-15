---
name: bioconductor-tximeta
description: Bioconductor-tximeta imports transcript-level quantification data into R while automatically attaching metadata and genomic annotations via sequence digests. Use when user asks to import RNA-seq counts into SummarizedExperiment objects, summarize transcript-level data to the gene level, or add alternative identifiers and genomic ranges to quantification data.
homepage: https://bioconductor.org/packages/release/bioc/html/tximeta.html
---

# bioconductor-tximeta

name: bioconductor-tximeta
description: Import transcript-level quantification data (from Salmon, Alevin, Oarfish) into R/Bioconductor with automatic metadata and annotation retrieval. Use this skill when you need to: (1) Import RNA-seq counts into SummarizedExperiment objects, (2) Automatically attach genomic ranges and transcript/gene metadata via sequence digests, (3) Summarize transcript-level data to gene-level, (4) Add alternative identifiers (Entrez, Symbol, etc.) to genomic objects, or (5) Prepare quantification data for differential expression tools like DESeq2, edgeR, or Swish.

# bioconductor-tximeta

## Overview

The `tximeta` package is an extension of `tximport` that automates the addition of annotation metadata to RNA-seq quantification data. It works by identifying the unique "digest" (checksum) of the reference transcriptome used during quantification (e.g., Salmon index). If the digest matches a known source (GENCODE, Ensembl, RefSeq), `tximeta` automatically attaches genomic ranges, versioned transcript databases (TxDb/EnsDb), and genome information to the resulting `SummarizedExperiment` object.

## Core Workflow

### 1. Prepare Input
Create a `coldata` data frame containing at least two columns: `files` (path to `quant.sf` files) and `names` (unique sample IDs).

```r
library(tximeta)
coldata <- data.frame(
  files = c("path/to/sample1/quant.sf", "path/to/sample2/quant.sf"),
  names = c("Sample1", "Sample2"),
  condition = c("Control", "Treatment"),
  stringsAsFactors = FALSE
)
```

### 2. Import Data
The primary function `tximeta()` performs the import and metadata lookup.

```r
se <- tximeta(coldata)
# Check assays (counts, abundance, length)
assayNames(se)
# Check genomic ranges
rowRanges(se)
```

### 3. Summarize to Gene Level
Use `summarizeToGene()` to aggregate transcript counts to genes. This uses the internal metadata to perform the mapping automatically.

```r
gse <- summarizeToGene(se)

# Optional: Assign ranges based on the most abundant isoform
gse_abundant <- summarizeToGene(se, assignRanges="abundant")
```

### 4. Add Identifiers
Map between different ID types (e.g., Ensembl to Entrez or Symbol) using `addIds()`.

```r
library(org.Hs.eg.db)
gse <- addIds(gse, "SYMBOL", gene=TRUE)
```

## Advanced Features

### Linked Transcriptomes
If using a custom or modified transcriptome that `tximeta` doesn't recognize automatically, you must "link" it manually before calling `tximeta()`.

```r
makeLinkedTxome(
  indexDir = "path/to/salmon_index",
  source = "LocalEnsembl",
  organism = "Homo sapiens",
  release = "104",
  genome = "GRCh38",
  fasta = "ftp://path/to/fasta.fa.gz",
  gtf = "path/to/local.gtf.gz"
)
# Subsequent calls to tximeta() will now recognize this index
```

### Mixed Reference Transcripts (Oarfish)
For quantification involving both annotated and novel transcripts:
1. Use `importData(coldata, type="oarfish")` to get an un-ranged object.
2. Use `inspectDigests(se)` to check matching status.
3. Use `updateMetadata(se)` to attach ranges and metadata to the annotated portions.

### Integration with DE Tools
`tximeta` objects are compatible with major Bioconductor DE packages:

*   **DESeq2**: `dds <- DESeqDataSet(gse, design = ~condition)`
*   **edgeR**: `y <- makeDGEList(gse)`
*   **Fishpond (Swish)**: Works directly on `se` (transcript-level) with inferential replicates.

## Tips and Troubleshooting

*   **Cache Management**: `tximeta` uses `BiocFileCache`. If a database connection fails, use `getTximetaBFC()` and `BiocFileCache::bfcremove()` to clear the problematic entry and force regeneration.
*   **Missing Transcripts**: It is common to see warnings about transcripts missing from the GTF but present in the FASTA. These are dropped from the ranged object by default. Use `skipMeta=TRUE` in `tximeta()` to keep all transcripts without adding ranges.
*   **Salmon Output**: Do not modify the Salmon output directory structure; `tximeta` relies on the `aux_info` folder to identify the transcriptome digest.

## Reference documentation

- [tximeta](./references/tximeta.md)