---
name: bioconductor-hibag
description: HIBAG predicts HLA genotypes from SNP data using an ensemble classifier approach. Use when user asks to impute HLA alleles from GWAS data, build custom HLA prediction models, or perform HLA-specific association testing at the allele and amino acid levels.
homepage: https://bioconductor.org/packages/release/bioc/html/HIBAG.html
---

# bioconductor-hibag

## Overview

HIBAG (**H**LA **I**mputation using attribute **BAG**ging) is a Bioconductor package designed for predicting HLA genotypes from SNP data. It is particularly useful for GWAS studies where classical HLA typing is unavailable. HIBAG uses an ensemble classifier approach (attribute bagging) to achieve high accuracy without requiring phased haplotypes. It supports parallel computing and provides tools for downstream association analysis at both the allele and amino acid levels.

## Core Workflows

### 1. HLA Imputation with Pre-fit Models
The most common use case involves using existing model parameters (e.g., from the HIBAG model repository) to impute HLA types in a new dataset.

```R
library(HIBAG)

# 1. Load a model (example uses package data; typically load an .RData file)
model.list <- get(load(system.file("extdata", "ModelList.RData", package="HIBAG")))
model <- hlaModelFromObj(model.list[["A"]])

# 2. Import SNP genotypes (supports PLINK BED format)
yourgeno <- hlaBED2Geno(bed.fn="data.bed", fam.fn="data.fam", bim.fn="data.bim")

# 3. Predict HLA genotypes
pred.guess <- hlaPredict(model, yourgeno, type="response+prob")

# 4. Access results
head(pred.guess$value)    # Best-guess genotypes
head(pred.guess$postprob) # Posterior probabilities
```

### 2. Building a Custom HIBAG Model
If you have a training set with both HLA types and SNP genotypes, you can build a population-specific model.

```R
# 1. Prepare HLA training data
train.HLA <- hlaAllele(sample.id, H1=allele1, H2=allele2, locus="A", assembly="hg19")

# 2. Subset SNPs to flanking region (e.g., 500kb) around the locus
train.geno <- hlaGenoSubsetFlank(HapMap_CEU_Geno, "A", 500*1000, assembly="hg19")

# 3. Train the model (use nclassifier=100 for a balance of speed/accuracy)
set.seed(100)
model <- hlaAttrBagging(train.HLA, train.geno, nclassifier=100)

# 4. Summary and Plotting
summary(model)
plot(model) # Shows SNP importance/frequency in the model
```

### 3. Parallel Computing
For large datasets or many classifiers, use the parallel versions of functions.

```R
library(parallel)
cl <- makeCluster(4) # Use 4 cores

# Parallel training
hlaParallelAttrBagging(cl, train.HLA, train.geno, nclassifier=100)

# Parallel prediction
pred <- hlaPredict(model, yourgeno, cl=cl)

stopCluster(cl)
```

### 4. HLA Association Testing
HIBAG includes specialized functions for association tests using imputed dosages or best-guess genotypes.

```R
# Allelic association (supports dominant, additive, recessive models)
# 'h' in formula represents the HLA genotypes
results <- hlaAssocTest(hla_obj, disease ~ h + pc1, data=pheno_df, model="additive")

# Amino acid association
# Converts alleles to protein sequences before testing
aa_obj <- hlaConvSequence(hla_obj, code="P.code.merge")
aa_results <- hlaAssocTest(aa_obj, disease ~ h, data=pheno_df, model="dominant")
```

## Evaluation and Reporting

*   **Accuracy Assessment**: Use `hlaCompareAllele()` to compare imputed results against a validation set (gold standard).
*   **Matching Proportion**: `hlaReportPlot(pred, model, fig="matching")` visualizes how well the test SNP profiles match the training set. Low values suggest the individual is underrepresented in the training data.
*   **Reporting**: `hlaReport(comp, type="markdown")` generates formatted tables of sensitivity, specificity, and PPV/NPV per allele.

## Performance Optimization
For modern CPUs, you can significantly speed up model building by setting the SIMD kernel target:
```R
# Select the best available kernel (AVX2, AVX512, etc.)
hlaSetKernelTarget("max")
```

## Reference documentation

- [HIBAG vignette](./references/HIBAG.md)
- [HLA association tests](./references/HLA_Association.md)
- [HIBAG algorithm implementation](./references/Implementation.md)