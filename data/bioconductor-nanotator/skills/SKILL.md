---
name: bioconductor-nanotator
description: bioconductor-nanotator annotates and classifies structural variants from Bionano Genomics optical mapping data. Use when user asks to calculate structural variant population frequencies, perform cohort analysis, identify gene overlaps, or prioritize variants based on phenotypic keywords.
homepage: https://bioconductor.org/packages/3.9/bioc/html/nanotatoR.html
---

# bioconductor-nanotator

name: bioconductor-nanotator
description: Structural variant (SV) annotation and classification for genomic data, specifically optimized for Bionano Genomics optical mapping outputs (.smap files). Use this skill to calculate SV population frequencies (DGV, DECIPHER), perform cohort analysis, identify gene overlaps, and prioritize variants based on phenotypic keywords.

# bioconductor-nanotator

## Overview
`nanotatoR` is an R package designed to bridge the diagnostic gap in structural variant (SV) analysis. While primarily built to handle Bionano Genomics optical mapping data, it provides a comprehensive framework for annotating large genomic variations (insertions, deletions, duplications, inversions, and translocations) with population frequencies, gene overlaps, and phenotype-driven prioritization.

## Core Workflow

### 1. Data Loading and Frequency Estimation
The package uses `.smap` files as the primary input for SV data. It compares these against external databases to estimate rarity.

```r
library(nanotatoR)

# Estimate frequency using DECIPHER
decipherpath <- system.file("extdata", "population_cnv.txt", package = "nanotatoR")
smappath <- system.file("extdata", package = "nanotatoR")

decipherext <- Decipher_extraction(
    decipherpath = decipherpath, 
    input_fmt = "Text", 
    smappath = smappath,
    smap = "sample.smap",
    win_indel = 10000, 
    perc_similarity = 0.5, 
    returnMethod = "dataFrame"
)
```

### 2. Cohort and Internal Frequency
To identify de novo variants or calculate internal cohort frequencies, use `internalFrequency`. This helps distinguish rare familial variants from common technical artifacts.

```r
intFreq <- internalFrequency(
    mergedFiles = "path/to/merged_internal_db.txt", 
    smappath = "path/to/smaps/",
    smap = "sample.smap", 
    buildSVInternalDB = FALSE,
    win_indel = 10000,
    win_inv_trans = 50000,
    returnMethod = "dataFrame"
)
```

### 3. Gene Overlap Annotation
Annotate SVs with overlapping genes and calculate distances to the nearest non-overlapping upstream/downstream genes.

```r
bedFile <- system.file("extdata", "Homo_sapiens.Hg19_BN_bed.txt", package="nanotatoR")

datcomp <- compSmapbed(
    smap = "path/to/sample.smap", 
    bed = bedFile, 
    inputfmtBed = "BNBED", # Use BNBED for Bionano-style chromosome naming (23, 24)
    n = 3, 
    returnMethod_bedcomp = "dataFrame"
)
```

### 4. Phenotype-Based Prioritization
Generate gene lists based on clinical terms (using ClinVar, OMIM, GTR) to filter SVs affecting relevant biological pathways.

```r
# Generate gene list from phenotype
terms <- "Muscle Weakness"
pheno_genes <- gene_list_generation(method = "Single", term = terms, returnMethod = "dataFrame")

# Filter SVs based on the generated list
run_bionano_filter(
    input_fmt_geneList = "dataframe",
    input_fmt_svMap = "Text",
    SVFile = "path/to/sample.smap", 
    dat_geneList = pheno_genes,
    outpath = "output/", 
    outputFilename = "prioritized_variants"
)
```

### 5. Automated Pipeline (Main)
The `nanotatoR_main` function wraps all sub-functions into a single execution path, producing a final annotated Excel/text file.

```r
nanotatoR_main(
    smap = smappath, 
    bed = bedFile,
    inputfmtBed = "BNBED",
    buildSVInternalDB = TRUE,
    dat_geneList = pheno_genes,
    outpath = "output/",
    outputFilename = "final_annotation"
)
```

## Key Parameters & Tips
- **Similarity Thresholds**: By default, SVs are considered the "same" if they share the same category, have >50% size similarity, and breakpoints are within 10kb (indels) or 50kb (inversions/translocations).
- **Chromosome Naming**: Use `inputfmtBed = "BNBED"` if your reference uses 23/24 for X/Y chromosomes, common in Bionano workflows.
- **Confidence Scores**: Default thresholds are 0.5 for indels, 0.01 for inversions, and 0.1 for translocations. Adjust these based on the specific sensitivity requirements of your study.

## Reference documentation
- [nanotatoR: structural variant annotation and classification](./references/nanotatoR.md)