---
name: bioconductor-supersigs
description: This tool performs supervised mutational signature analysis to identify trinucleotide features associated with specific phenotypes or exposures. Use when user asks to learn supervised signatures from genomic data, predict classification scores for new samples, or apply pre-trained signatures to analyze factors like age and smoking.
homepage: https://bioconductor.org/packages/release/bioc/html/supersigs.html
---


# bioconductor-supersigs

name: bioconductor-supersigs
description: Supervised mutational signature analysis using the Bioconductor package 'supersigs'. Use this skill to learn supervised signatures (SuperSigs) from cancer genomic data, predict classification scores for new samples based on specific factors (e.g., smoking, age, MSI status), and adjust mutation data by removing known signature contributions.

# bioconductor-supersigs

## Overview

The `supersigs` package implements a supervised approach to mutational signature analysis. Unlike unsupervised methods (like NMF) that decompose mutation catalogs into latent signatures, `supersigs` identifies features (trinucleotide contexts) that are specifically associated with a known factor or phenotype (e.g., a specific exposure or clinical variable). It produces highly interpretable "SuperSigs" which are essentially trained logistic regression models that can be used for classification and prediction on new datasets.

## Core Workflow

### 1. Data Preprocessing

The package requires a data frame where each row is a sample and columns represent trinucleotide mutation counts (96 standard contexts).

**From VCF:**
If starting with a VCF file, use `VariantAnnotation` to load it and `process_vcf` to format it.
```r
library(supersigs)
library(VariantAnnotation)

vcf <- readVcf("path_to_file.vcf", "hg19")
colData(vcf)$age <- 60 # Age is a required metadata field
dt <- process_vcf(vcf)
```

**Generating the Mutation Matrix:**
Use `make_matrix` to convert a list of mutations into the required count matrix. This requires a BSgenome object.
```r
library(BSgenome.Hsapiens.UCSC.hg19)
# example_dt should have: sample_id, age, chromosome, position, ref, alt
input_dt <- make_matrix(example_dt)
```

### 2. Learning a Signature

To train a signature, you need an `IndVar` (Indicator Variable) column in your data frame representing the exposure/factor.

```r
# Prepare data: add IndVar (logical or 0/1)
input_dt$IndVar <- as.numeric(input_dt$factor_of_interest == "Exposed")

# Get signature
supersig <- get_signature(data = input_dt, factor = "Smoking")
```

The resulting `supersig` object contains:
- `Signature`: Differences in mean rates between groups.
- `Features`: The specific trinucleotide contexts selected.
- `AUC`: The apparent area under the curve.
- `Model`: The trained `glm` object.

### 3. Prediction and Classification

Apply a learned signature (either custom-made or pre-trained) to new data using `predict_signature`.

```r
# Using a custom signature
results <- predict_signature(supersig, newdata = test_dt, factor = "Smoking")

# Using pre-trained TCGA signatures (available in supersig_ls)
data("supersig_ls")
names(supersig_ls) # View available signatures like "SMOKING (LUAD)", "AGE (BRCA)"
results_tcga <- predict_signature(supersig_ls[["SMOKING (LUAD)"]], newdata = test_dt, factor = "Smoking")

# 'results' will contain a 'score' column (predicted probability)
```

### 4. Interpretation and Visualization

Use `simplify_signature` to group features for easier plotting, optionally using IUPAC labels.

```r
# Simplify for plotting
features_iupac <- simplify_signature(object = supersig, iupac = TRUE)

# Plotting
library(ggplot2)
df_plot <- data.frame(feat = names(features_iupac), val = features_iupac)
ggplot(df_plot, aes(x = feat, y = val)) + geom_col() + theme_minimal()
```

### 5. Partial Signatures (Adjustment)

To remove the effect of a known signature (e.g., aging) before looking for others, use `partial_signature`.

```r
# Adjust data by removing contribution of a specific signature
adjusted_dt <- partial_signature(data = input_dt, object = supersig)
```

## Tips and Best Practices

- **Reference Genomes:** Ensure the `BSgenome` version matches the coordinates in your mutation data (hg19 vs hg38).
- **Pre-trained Signatures:** The `supersig_ls` object contains 67 signatures trained on TCGA data across various tissues and factors (Age, Smoking, POLE, MSI, etc.). Always check `names(supersig_ls)` to find the most relevant tissue-specific model.
- **Interpretation:** The `Signature` slot in the S4 object represents the difference in mean rates. A positive value indicates the feature is more prevalent in the exposed group.
- **Age Factor:** When `factor = "age"`, the signature represents the overall mean rate rather than a difference between groups.

## Reference documentation

- [Using supersigs](./references/supersigs.Rmd)
- [Using supersigs (Markdown)](./references/supersigs.md)