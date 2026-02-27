---
name: bioconductor-pasillatranscriptexpr
description: This package provides metadata and quantification workflows for the pasilla Drosophila RNA-seq dataset. Use when user asks to retrieve experimental design information, download raw SRA data, or process transcript-level counts for Drosophila melanogaster samples.
homepage: https://bioconductor.org/packages/release/data/experiment/html/PasillaTranscriptExpr.html
---


# bioconductor-pasillatranscriptexpr

name: bioconductor-pasillatranscriptexpr
description: Access metadata and quantification workflows for the pasilla Drosophila RNA-seq dataset. Use this skill to retrieve experimental design information (SraRunInfo), download raw data, or process transcript-level counts generated via kallisto for Drosophila melanogaster samples.

## Overview
The `PasillaTranscriptExpr` package is a Bioconductor data experiment package that provides the metadata and processing framework for the pasilla dataset (Brooks et al., 2011). This dataset is used to study exons regulated by the pasilla protein in *Drosophila melanogaster*. The package facilitates the transition from raw SRA data to transcript-level counts using the kallisto quantification workflow.

## Accessing Experimental Metadata
The package includes a comprehensive metadata file (`SraRunInfo.csv`) that describes the 7 biologically independent samples (4 control, 3 knockdown) and their sequencing specifications (single-end vs. paired-end).

```r
library(PasillaTranscriptExpr)

# Locate and read the metadata
data_dir <- system.file("extdata", package = "PasillaTranscriptExpr")
sri <- read.table(file.path(data_dir, "SraRunInfo.csv"), 
                  stringsAsFactors = FALSE, sep = ",", header = TRUE)

# Filter for the specific experimental samples (Untreated and CG8144 RNAi)
keep <- grep("CG8144|Untreated-", sri$LibraryName)
sri <- sri[keep, ]
```

## Data Retrieval Workflow
The metadata contains direct download paths for the SRA files. You can automate the download process within R:

```r
# Download SRA files based on metadata paths
sra_files <- basename(sri$download_path)
for(i in 1:nrow(sri)) {
    download.file(sri$download_path[i], sra_files[i])
}
```

## Transcript Quantification Workflow
The package outlines a workflow using `kallisto`. While `kallisto` itself is an external command-line tool, `PasillaTranscriptExpr` provides the R logic to manage the inputs and outputs:

1.  **Metadata Preparation**: Organize samples by `LibraryLayout` (PAIRED vs SINGLE) and `avgLength` (required for single-end quantification).
2.  **Index Building**: Reference the Drosophila genome FASTA (e.g., BDGP5.70).
3.  **Quantification**: Generate `abundance.txt` files for each sample.

## Merging and Annotating Results
After quantification, use R to aggregate individual sample files into a single expression matrix and map transcript IDs to gene IDs.

```r
# Example of merging multiple kallisto abundance files
# Assuming 'metadata' contains 'UniqueName' (folder paths) and 'SampleName'
library(rtracklayer)

# Load GTF to create a mapping between transcript_id and gene_id
gtf <- import("Drosophila_melanogaster.BDGP5.70.gtf")
gt <- unique(mcols(gtf)[, c("gene_id", "transcript_id")])
rownames(gt) <- gt$transcript_id

# Merge logic (simplified)
# 1. Read abundance.txt for each sample
# 2. Use Reduce(merge, ...) to combine by 'target_id'
# 3. Add gene_id column: counts$gene_id <- gt[counts$feature_id, "gene_id"]
```

## Key Data Considerations
- **Paired-end vs Single-end**: The dataset contains both. Single-end samples require the average fragment length (`avgLength` in metadata) for accurate quantification.
- **Sample GSM461179**: This specific sample was sequenced using different read lengths. The workflow recommends quantifying each length separately and then summing the expected counts.
- **Conditions**: Samples are labeled as `CTL` (Control/Untreated) or `KD` (Knockdown/CG8144_RNAi).

## Reference documentation
- [PasillaTranscriptExpr](./references/PasillaTranscriptExpr.md)