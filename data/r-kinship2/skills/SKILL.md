---
name: r-kinship2
description: "Routines to handle family data with a pedigree object. The initial purpose 	     was to create correlation structures that describe family relationships such  	     as kinship and identity-by-descent, which can be used to model family data  	     in mixed effects models, such as in the coxme function. Also includes a tool 	     for pedigree drawing which is focused on producing compact layouts without  	     intervention. Recent additions include utilities to trim the pedigree object 	     with various criteria, and kinship for the X chromosome.</p>"
homepage: https://cloud.r-project.org/web/packages/kinship2/index.html
---

# r-kinship2

name: r-kinship2
description: Expert guidance for the R package 'kinship2' to handle pedigree data, calculate kinship matrices (including X-chromosome), and generate automated pedigree plots. Use this skill when you need to create, manipulate, or visualize family relationship data in R, or when preparing correlation structures for mixed-effects models (e.g., coxme).

## Overview

The `kinship2` package provides a comprehensive suite of tools for handling pedigree data. It is designed to create `pedigree` objects that can be used for calculating kinship coefficients and generating high-quality, automated pedigree drawings. It supports complex family structures, including multiple marriages, twins, and inbreeding.

## Installation

```R
install.packages("kinship2")
library(kinship2)
```

## Core Workflows

### 1. Creating Pedigrees
The foundation is the `pedigree()` function. It requires basic demographic vectors.

```R
# Basic pedigree creation
ped <- pedigree(id = data$id, 
                dadid = data$father, 
                momid = data$mother, 
                sex = data$sex, 
                famid = data$famid)

# Handling multiple families
ped_list <- pedigree(id = sample.ped$id, 
                     dadid = sample.ped$father, 
                     momid = sample.ped$mother, 
                     sex = sample.ped$sex, 
                     famid = sample.ped$ped)
```

**Key Arguments:**
- `sex`: 1=male, 2=female, 3=unknown, 4=terminated.
- `status`: 0=censored, 1=dead (adds a diagonal line in plots).
- `affected`: A vector or matrix (for multiple traits) of 0/1/NA.
- `relation`: A matrix defining special bonds (1=MZ twins, 2=DZ twins, 3=Unknown twins, 4=Spouse).

### 2. Calculating Kinship Matrices
Kinship coefficients represent the probability that randomly selected alleles from two individuals are identical by descent (IBD).

```R
# Standard autosomal kinship
kmat <- kinship(ped)

# X-chromosome kinship
kmat_x <- kinship(ped, chrtype = "X")

# For a pedigreeList (returns a sparse block-diagonal matrix)
kmat_all <- kinship(ped_list)
```
*Note: Diagonal elements are 0.5 for individuals (1/2 probability of sampling the same allele twice), not 1.0.*

### 3. Pedigree Visualization
The `plot()` method for pedigrees is highly automated, focusing on compact layouts.

```R
# Basic plot
plot(ped)

# Advanced plot with legend and colors
plot(ped, col = ifelse(data$avail, "red", "black"), 
     id = paste(data$id, data$name, sep="\n"))
pedigree.legend(ped, location = "topright")

# Plotting multiple affected statuses (creates "pie" symbols)
plot(ped, affected = as.matrix(data[, c("cancer", "diabetes")]))
```

### 4. Data Cleaning and Utility
Pedigree data often contains inconsistencies that `kinship2` can help resolve.

- **`fixParents()`**: Adds missing parents to the ID list and ensures parents have the correct sex assigned.
- **`pedigree.trim()`**: Removes specific individuals by ID.
- **`pedigree.shrink()`**: Reduces a pedigree to a specified "bit size" while preserving as much genetic information as possible (useful for linkage analysis).
- **`pedigree.unrelated()`**: Identifies the maximum set of unrelated individuals in a pedigree.

## Tips and Best Practices

- **Factors**: Avoid using factors for `id`, `dadid`, or `momid`. Convert them to character or numeric to prevent indexing errors.
- **Marry-ins**: If a spouse has no children in the pedigree, they may not appear in the plot unless a `relation` of code 4 (spouse) is explicitly defined.
- **Alignment**: If a plot looks messy, try reordering the input data. The `align.pedigree` routine is sensitive to the order in which founders and siblings are processed.
- **Large Datasets**: For thousands of subjects, use `pedigreeList`. The resulting kinship matrix is a `dsCMatrix` (sparse) from the `Matrix` package, saving significant memory.

## Reference documentation

- [Pedigree plot alignment details](./references/align_code_details.Rmd)
- [Kinship Matrix Code Details](./references/kinship_code_details.Rmd)
- [Pedigree Examples](./references/pedigree.Rmd)
- [Pedigree constructor details](./references/pedigree_code_details.Rmd)
- [Pedigree Plot Details](./references/plot_code_details.Rmd)