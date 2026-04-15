---
name: bioconductor-genesis
description: The GENESIS package performs genetic association testing and population structure inference in samples with complex ancestry and relatedness. Use when user asks to infer population structure using PC-AiR, estimate kinship with PC-Relate, fit linear mixed models, or perform variant association tests for quantitative and binary traits.
homepage: https://bioconductor.org/packages/release/bioc/html/GENESIS.html
---

# bioconductor-genesis

name: bioconductor-genesis
description: Genetic association testing and population structure inference using the GENESIS R package. Use this skill when performing mixed model association analysis (LMM/GLMM), estimating heritability, or inferring population structure (PC-AiR) and relatedness (PC-Relate) in samples with population stratification and cryptic relatedness.

## Overview

The GENESIS package provides tools for analyzing genetic data from samples with complex population structure and familial relatedness. It implements PC-AiR for robust Principal Component Analysis and PC-Relate for estimating kinship coefficients adjusted for ancestry. These components are integrated into a mixed-model framework for association testing of both quantitative and binary traits, supporting both SNP array and sequencing data.

## Core Workflow

### 1. Data Preparation
GENESIS uses `GenotypeData` (GWASTools) or `SeqVarData` (SeqVarTools) objects.

```R
library(GENESIS)
library(GWASTools)

# For GDS files
geno <- GdsGenotypeReader(filename = "genotype.gds")
scanAnnot <- ScanAnnotationDataFrame(pheno_data) # Must include 'scanID'
genoData <- GenotypeData(geno, scanAnnot = scanAnnot)
```

### 2. Population Structure and Relatedness
To account for structure without confounding from relatives:

1.  **LD Pruning**: Use `SNPRelate::snpgdsLDpruning`.
2.  **PC-AiR**: Identify ancestry PCs robust to relatedness.
    ```R
    # KINGmat is a kinship matrix from KING or snpgdsIBDKING
    mypcair <- pcair(genoData, kinobj = KINGmat, divobj = KINGmat, snp.include = pruned_ids)
    ```
3.  **PC-Relate**: Estimate kinship adjusted for PCs.
    ```R
    iterator <- GenotypeBlockIterator(genoData, snpInclude = pruned_ids)
    mypcrel <- pcrelate(iterator, pcs = mypcair$vectors[,1:2], training.set = mypcair$unrels)
    grm <- pcrelateToMatrix(mypcrel, scaleKin = 2)
    ```

### 3. Null Model Fitting
Fit the model under the null hypothesis (no SNP effect) before running association tests.

```R
# Quantitative trait (LMM)
nullmod <- fitNullModel(scanAnnot, outcome = "pheno", covars = c("pc1", "sex"), 
                        cov.mat = grm, family = "gaussian")

# Binary trait (GLMM via PQL)
nullmod_bin <- fitNullModel(scanAnnot, outcome = "case_control", covars = "pc1", 
                            cov.mat = grm, family = "binomial")
```

### 4. Association Testing
Use the null model to test SNPs.

*   **Single Variant**:
    ```R
    genoIterator <- GenotypeBlockIterator(genoData, snpBlock = 10000)
    assoc <- assocTestSingle(genoIterator, null.model = nullmod)
    ```
*   **Aggregate (Rare Variants)**:
    ```R
    # Requires SeqVarData and an iterator (Window, Range, or List)
    assoc_agg <- assocTestAggregate(seqIterator, nullmod, test = "Burden", AF.max = 0.05)
    ```

## Key Functions and Tips

- **`pcrelateToMatrix`**: Converts PC-Relate output to a Genetic Relationship Matrix (GRM). Use `scaleKin = 2` to match the scale expected by `fitNullModel`.
- **`varCompCI`**: Estimates heritability (proportion of variance explained) for quantitative traits.
- **Parallelization**: Use the `BPPARAM` argument (e.g., `BiocParallel::MulticoreParam()`) in `assocTestSingle` and `pcrelate` to speed up computation.
- **Memory Management**: For large datasets, use `GenotypeBlockIterator` or `SeqVarBlockIterator` to process SNPs in chunks.
- **Binary Traits**: Variance components from PQL (binary models) are not directly interpretable as heritability.

## Reference documentation

- [Genetic Association Testing using the GENESIS Package](./references/assoc_test.md)
- [Analyzing Sequence Data using the GENESIS Package](./references/assoc_test_seq.md)
- [Population Structure and Relatedness Inference using the GENESIS Package](./references/pcair.md)