---
name: bioconductor-lymphoseqdb
description: This tool provides access to the LymphoSeqDB database containing prevalence data and known antigen specificities for T cell receptor beta CDR3 sequences. Use when user asks to annotate TCR repertoire data with healthy population frequencies, identify sequences with known antigen specificity, or filter sequences based on clinical relevance.
homepage: https://bioconductor.org/packages/release/data/annotation/html/LymphoSeqDB.html
---

# bioconductor-lymphoseqdb

name: bioconductor-lymphoseqdb
description: Access and utilize the LymphoSeqDB database, which contains prevalence data for T cell receptor beta (TRB) CDR3 amino acid sequences from healthy individuals and published sequences with known antigen specificity. Use this skill when analyzing TCR repertoire data to annotate sequences with frequency in healthy populations or to identify sequences with known clinical or antigenic relevance.

# bioconductor-lymphoseqdb

## Overview
LymphoSeqDB is a data-only Bioconductor package that serves as a companion to the LymphoSeq analysis package. It provides two primary datasets: `prevalenceTRB`, which contains frequency data for over 11 million TRB CDR3 sequences across 55 healthy individuals (ages 0-90), and `publishedTRB`, which contains curated sequences with known antigen specificities, HLA types, and associated PubMed IDs.

## Data Access and Usage

To use the datasets, first load the library:

```r
library(LymphoSeqDB)
```

### 1. Healthy Population Prevalence (`prevalenceTRB`)
This dataset is used to determine how common a specific TRB CDR3 sequence is in the general healthy population.

*   **Structure**: A dataframe with 2 columns:
    *   `aminoAcid`: The TRB CDR3 amino acid sequence.
    *   `prevalence`: The percentage frequency of the sequence across the 55 healthy individuals.
*   **Common Workflow**: Merging with your own TCR sequencing results to filter out common "public" sequences or to identify rare clones.

```r
# View the first few rows
head(prevalenceTRB)

# Search for a specific sequence
my_sequence <- "CASSLGETQYF"
prevalenceTRB[prevalenceTRB$aminoAcid == my_sequence, ]
```

### 2. Known Antigen Specificity (`publishedTRB`)
This dataset is used to annotate TCR sequences with known targets (e.g., viral epitopes, tumor antigens).

*   **Structure**: A dataframe with 6 columns:
    *   `aminoAcid`: The TRB CDR3 amino acid sequence.
    *   `PMID`: PubMed ID for the source study.
    *   `HLA`: Associated HLA type.
    *   `antigen`: The target antigen.
    *   `epitope`: The specific epitope sequence.
    *   `prevalence`: Frequency in the 55 healthy individuals.
*   **Common Workflow**: Identifying functional relevance of expanded clones in a repertoire.

```r
# View the first few rows
head(publishedTRB)

# Filter for a specific antigen (e.g., CMV)
cmv_sequences <- publishedTRB[publishedTRB$antigen == "CMV", ]
```

## Integration with LymphoSeq
While LymphoSeqDB can be used independently, it is designed to work with the `LymphoSeq` package functions. Specifically, functions like `searchPublished` and `searchPrevalence` in the `LymphoSeq` package wrap these data frames to facilitate searching and merging with `lseq` list objects.

## Tips
*   **Memory Management**: `prevalenceTRB` is a very large dataframe (over 11 million rows). Ensure your R environment has sufficient RAM when performing joins or large-scale filtering.
*   **Exact Matches**: When searching for sequences, ensure they are productive TRB CDR3 amino acid sequences. The database does not contain nucleotide sequences or non-productive (out-of-frame/stop codon) sequences.

## Reference documentation
- [LymphoSeqDB Reference Manual](./references/reference_manual.md)