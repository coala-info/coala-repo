---
name: bioconductor-asafe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ASAFE.html
---

# bioconductor-asafe

name: bioconductor-asafe
description: Estimate ancestry-specific allele frequencies from genotypes and local ancestry in admixed populations. Use this skill when you need to perform Expectation-Maximization (EM) to find P(Allele | Ancestry) for bi-allelic markers (SNPs) where genotype phase relative to ancestry is unknown.

## Overview

ASAFE (Ancestry Specific Allele Frequency Estimation) implements an EM algorithm to estimate allele frequencies for specific ancestries in multi-way admixed individuals (typically 3-way admixture like African, European, and Native American). It is particularly useful because it handles cases where the phase between the genotype and the local ancestry is unknown.

## Data Preparation

ASAFE requires two primary inputs: an ancestry matrix and a genotype matrix.

### 1. Ancestry Matrix
- **Format**: Rows are markers, columns are individuals.
- **Structure**: Each individual has two consecutive columns representing their two homologous chromosomes.
- **Values**: Integers (0, 1, or 2) representing the ancestry label.
- **Example Header**: `Marker ADM1 ADM1 ADM2 ADM2 ...`

### 2. Genotype Matrix
- **Format**: Rows are markers, columns are individuals.
- **Structure**: One column per person.
- **Values**: Unphased genotypes strings (e.g., "0/0", "0/1", "1/0", "1/1").
- **Requirement**: Individuals must be in the same order as the ancestry file.

## Typical Workflow

### Loading Data
```R
library(ASAFE)

# Load your data
ancestry_df <- read.table("ancestry_file.txt", header = TRUE)
genotype_df <- read.table("genotype_file.txt", header = TRUE)

# Prepare matrices (remove ID column and set as row names)
row.names(ancestry_df) <- ancestry_df[,1]
row.names(genotype_df) <- genotype_df[,1]
anc_mat <- as.matrix(ancestry_df[,-1])
geno_mat <- as.matrix(genotype_df[,-1])
```

### Processing Genotypes
Genotypes must be converted from strings to a numeric matrix of alleles.
```R
# Split "0/1" into individual alleles
alleles_list <- apply(geno_mat, 1, strsplit, split = "/")
# Unlist and convert to numeric matrix (Chromosomes x Markers)
alleles_unlisted <- sapply(alleles_list, unlist)
alleles_mat <- apply(alleles_unlisted, 2, as.numeric)
```

### Running the EM Algorithm
Use `algorithm_1snp_wrapper` to process markers. This function is typically used with `sapply` to iterate over all SNPs.

```R
# Run estimation for all markers
# alleles_mat: Matrix where rows are chromosomes (2 per person)
# anc_mat: Matrix where rows are markers, columns are chromosomes
results <- sapply(X = 1:ncol(alleles_mat), 
                  FUN = algorithm_1snp_wrapper, 
                  alleles = alleles_mat, 
                  ancestries = anc_mat)
```

## Interpreting Results

The output matrix (`results`) contains:
- **Row 1**: Marker ID (e.g., rsID).
- **Row 2**: Estimated frequency of Allele 1 given Ancestry 0.
- **Row 3**: Estimated frequency of Allele 1 given Ancestry 1.
- **Row 4**: Estimated frequency of Allele 1 given Ancestry 2.

## Tips
- **Ancestry Labels**: The labels 0, 1, and 2 are arbitrary but must be consistent across your dataset.
- **Phasing**: ASAFE does not require genotypes to be phased with respect to each other or with respect to ancestry; the EM algorithm handles the phase uncertainty.
- **Performance**: For large datasets, ensure you have sufficient RAM as the `sapply` approach creates a large results matrix.

## Reference documentation
- [ASAFE](./references/ASAFE.md)