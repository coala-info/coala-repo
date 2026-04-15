---
name: bioconductor-planttfhunter
description: This tool identifies and classifies plant transcription factors from protein sequences using profile Hidden Markov Models and the PlantTFDB classification scheme. Use when user asks to identify transcription factor families in plant proteomes, classify protein sequences into TF subfamilies, or compare transcription factor counts across multiple species.
homepage: https://bioconductor.org/packages/release/bioc/html/planttfhunter.html
---

# bioconductor-planttfhunter

name: bioconductor-planttfhunter
description: Identify and classify plant transcription factors (TFs) from protein sequences using the PlantTFDB classification scheme. Use this skill when analyzing plant proteomes to determine TF family and subfamily membership, or when comparing TF counts across multiple species.

## Overview

The planttfhunter package provides a workflow for the genome-wide identification of transcription factors (TFs) in plants. It uses profile Hidden Markov Models (HMMs) to detect signature protein domains (DNA-binding, auxiliary, and forbidden domains) and classifies them according to the PlantTFDB 4.0 scheme. The package integrates with standard Bioconductor classes like AAStringSet for input and SummarizedExperiment for multi-species count data.

## Core Workflow

### 1. Data Preparation
Input sequences must be in an `AAStringSet` object. If starting from a FASTA file, use the `Biostrings` package.

```r
library(planttfhunter)
library(Biostrings)

# Load from FASTA
# sequences <- readAAStringSet("path/to/proteome.fasta")

# Example data provided by package
data(gsu)
```

### 2. Domain Annotation
The `annotate_pfam()` function identifies TF-related domains. This requires HMMER to be installed on the system.

```r
# Check if HMMER is available
if(hmmer_is_installed()) {
    annotation <- annotate_pfam(gsu)
}
```

### 3. TF Classification
Once domains are annotated, classify the sequences into families and subfamilies.

```r
# Classify into families
tf_families <- classify_tfs(annotation)

# View results
head(tf_families)
table(tf_families$Family)
```

## Multi-species Analysis

To compare TF distributions across multiple species, use `get_tf_counts()`. This function accepts a list of `AAStringSet` objects and returns a `SummarizedExperiment`.

```r
# proteomes: a named list of AAStringSet objects
# species_metadata: a data frame where rownames match names(proteomes)

if(hmmer_is_installed()) {
    tf_counts_se <- get_tf_counts(proteomes, species_metadata)
}

# Access the count matrix
counts <- SummarizedExperiment::assay(tf_counts_se)

# Access species metadata
metadata <- SummarizedExperiment::colData(tf_counts_se)
```

## Tips and Best Practices

- **HMMER Dependency**: Ensure HMMER is in your system PATH. The package uses it internally to scan sequences against pre-built HMM profiles stored in the package's `extdata/` directory.
- **Classification Scheme**: You can inspect the underlying rules for TF classification by loading the built-in dataset: `data(classification_scheme)`.
- **Input Formatting**: Ensure protein sequences do not contain internal stop codons or invalid characters that might interfere with HMMER scanning.
- **Integration**: For large-scale genomic datasets, use `syntenet::fasta2AAStringSetlist()` to quickly load multiple proteomes from a directory for use in `get_tf_counts()`.

## Reference documentation

- [Genome-wide identification and classification of transcription factors in plant genomes](./references/vignette_planttfhunter.md)