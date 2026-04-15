---
name: bioconductor-mirmine
description: This tool provides access to a curated collection of human miRNA expression profiles and metadata from the miRmine dataset. Use when user asks to load the miRmine dataset, subset miRNA expression data by tissue or disease, access miRNA sequences, or prepare miRmine data for differential expression analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/miRmine.html
---

# bioconductor-mirmine

name: bioconductor-mirmine
description: Access and analyze the miRmine human miRNA expression dataset. Use this skill to load the miRmine RangedSummarizedExperiment object, subset miRNA expression data by tissue, disease, or cell line, and integrate miRNA profiles into differential expression workflows (e.g., DESeq2).

## Overview
The `miRmine` package provides a curated collection of human miRNA expression profiles derived from 304 publicly available experiments (NCBI SRA). The data is structured as a `RangedSummarizedExperiment`, integrating miRNA expression counts (RPM) with extensive metadata for samples (tissues, cell lines, sex, disease state) and genomic features (miRBase v21 annotations and sequences).

## Core Workflow

### Loading the Dataset
The primary dataset is loaded using the `data()` function after attaching the library.

```r
library(miRmine)
data(miRmine)

# Inspect the object
miRmine
```

### Exploring Metadata
The object contains rich metadata in both `colData` (samples) and `rowData` (miRNAs).

```r
# View available sample variables (Tissue, Disease, Cell.Line, etc.)
colnames(colData(miRmine))

# View miRNA annotations
rowData(miRmine)
```

### Subsetting Data
You can subset the dataset using standard SummarizedExperiment brackets `[row, column]`.

```r
# Subset by Disease
adenocarcinoma <- miRmine[, miRmine$Disease == "Adenocarcinoma"]

# Subset by Tissue
lung_samples <- miRmine[, miRmine$Tissue == "Lung"]

# Subset by specific miRNA names
specific_mirna <- miRmine["hsa-let-7a-5p.hsa-let-7a-1", ]
```

### Accessing miRNA Sequences
The `rowRanges` contain the actual miRNA sequences as `DNAString` objects.

```r
library(Biostrings)
# Get sequence for a specific miRNA
rowRanges(miRmine)$mirna_seq["hsa-let-7a-5p.hsa-let-7a-1"]
```

## Integration with Differential Expression (DESeq2)
Because `miRmine` provides RPM (Reads Per Million) rather than raw integer counts, you must transform the data (e.g., using `ceiling()`) if you intend to use tools like `DESeq2` that require integer inputs.

```r
library(DESeq2)

# Example: Compare Lung vs Saliva
sub <- miRmine[, miRmine$Tissue %in% c("Lung", "Saliva")]

# Create a new SummarizedExperiment with integer counts
mirmine_int <- SummarizedExperiment(
    assays = SimpleList(counts = ceiling(assays(sub)$counts)),
    colData = colData(sub),
    rowRanges = rowRanges(sub)
)

# Initialize DESeq2 object
dds <- DESeqDataSet(mirmine_int, design = ~ Tissue)
dds <- DESeq(dds)
res <- results(dds)
```

## Usage Tips
- **Expression Units**: Values in `assays(miRmine)$counts` are RPM. Always check if your downstream analysis tool requires raw counts or normalized values.
- **Unique Names**: Row names are formatted as `miRNA_name.precursor_name` (e.g., `hsa-let-7a-5p.hsa-let-7a-1`) to handle cases where the same mature miRNA originates from different genomic loci.
- **Filtering**: Before differential expression, it is standard practice to filter out miRNAs with very low counts across samples using `rowSums(counts(dds)) > 1`.

## Reference documentation
- [miRmine dataset as RangedSummarizedExperiment](./references/miRmine.md)