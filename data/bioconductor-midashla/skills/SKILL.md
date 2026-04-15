---
name: bioconductor-midashla
description: The midasHLA package provides a comprehensive pipeline for performing immunogenetic association studies including HLA and KIR analysis. Use when user asks to perform HLA or KIR association testing, conduct amino acid fine-mapping, analyze HLA-KIR interactions, or calculate HLA heterozygosity and divergence.
homepage: https://bioconductor.org/packages/release/bioc/html/midasHLA.html
---

# bioconductor-midashla

name: bioconductor-midashla
description: Expert guidance for using the midasHLA R package for immunogenetic association analysis. Use this skill when performing HLA and KIR association studies, including classical allele associations, amino acid fine-mapping, HLA-KIR interaction analysis, and HLA heterozygosity/divergence studies.

## Overview

The `midasHLA` (MiDAS) package is a comprehensive pipeline for immunogenetic association studies. It transforms HLA allele calls into various formats (amino acids, G-groups, NK cell ligands) and provides a framework for statistical association testing using standard R model objects (like `glm`).

## Core Workflow

### 1. Data Import and Sanity Check
Load phenotype data and HLA calls. MiDAS validates HLA nomenclature and can reduce resolution during import.

```r
library(midasHLA)
library(magrittr)

# Import phenotypes
dat_pheno <- read.table("phenotypes.txt", header = TRUE)

# Import HLA calls (resolution 4 = 4-digit)
dat_HLA <- readHlaCalls("hla_calls.txt", resolution = 4)

# Check frequencies against reference populations
freq_HLA <- getHlaFrequencies(hla_calls = dat_HLA, compare = TRUE)
```

### 2. Preparing the MiDAS Object
The `prepareMiDAS` function is the central hub for feature engineering.

```r
# For classical allele analysis
HLA <- prepareMiDAS(dat_HLA, colData = dat_pheno, experiment = "hla_alleles")

# For amino acid analysis
HLA_AA <- prepareMiDAS(dat_HLA, colData = dat_pheno, experiment = "hla_aa")

# For NK cell ligands (Bw4/Bw6, C1/C2)
NKlig <- prepareMiDAS(dat_HLA, colData = dat_pheno, experiment = "hla_NK_ligands")
```

### 3. Association Testing
MiDAS uses a "placeholder" approach. You define a model with the `term` keyword, and `runMiDAS` iterates through all features in the experiment.

```r
# Define the base model
my_model <- glm(disease ~ term + age + sex, data = HLA, family = binomial())

# Run the analysis
results <- runMiDAS(
  object = my_model,
  experiment = "hla_alleles",
  inheritance_model = "dominant", # options: dominant, recessive, additive, overdominant
  lower_frequency_cutoff = 0.02,
  correction = "bonferroni",
  exponentiate = TRUE # returns Odds Ratios for logistic regression
)
```

### 4. Advanced Analysis Patterns

**Conditional Fine-mapping:**
To find independent signals, use `conditional = TRUE`. MiDAS performs stepwise conditioning on the top-associated alleles.
```r
results_cond <- runMiDAS(my_model, experiment = "hla_alleles", conditional = TRUE)
```

**Amino Acid Omnibus Test:**
Test the overall effect of a position (grouping all residues) using a likelihood ratio test.
```r
aa_omnibus <- runMiDAS(my_model, experiment = "hla_aa", omnibus = TRUE)
```

**Mapping Residues to Alleles:**
Identify which alleles carry a specific associated residue.
```r
alleles_at_pos <- getAllelesForAA(HLA_AA, "DQB1_9")
```

## Tips for Success
- **HWE Filtering:** Always run `HWETest` before association analysis to filter out genotyping errors.
- **Inheritance Models:** The choice of `inheritance_model` (e.g., "dominant" vs "additive") significantly impacts power and interpretation.
- **KIR Data:** Use `readKirCalls` for KIR presence/absence data. Ensure IDs match your HLA and phenotype data.
- **Placeholders:** The `term` variable in your model formula is mandatory; it represents the specific HLA feature being tested in each iteration of `runMiDAS`.

## Reference documentation
- [MiDAS tutorial](./references/MiDAS_tutorial.md)
- [MiDAS vignette](./references/MiDAS_vignette.md)