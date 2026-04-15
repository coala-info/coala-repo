---
name: bioconductor-geneticsped
description: This tool provides comprehensive pedigree management and genetic analysis within the R environment. Use when user asks to manage pedigree data, calculate genetic relationship matrices, compute inbreeding coefficients, or set up mixed model equations for quantitative genetics.
homepage: https://bioconductor.org/packages/release/bioc/html/GeneticsPed.html
---

# bioconductor-geneticsped

name: bioconductor-geneticsped
description: Comprehensive pedigree management and genetic analysis. Use when working with R to manage pedigree data, calculate genetic relationship matrices (additive/numerator relationship matrix), compute inbreeding coefficients, or set up mixed model equations (animal models) for quantitative genetics.

# bioconductor-geneticsped

## Overview

The GeneticsPed package provides specialized classes and methods for managing pedigree data in R. It is designed for quantitative geneticists to handle complex family structures, perform data integrity checks, and calculate relationship matrices (A and A-inverse) required for Best Linear Unbiased Prediction (BLUP) and animal models.

## Core Workflows

### Creating and Managing Pedigrees

The primary data structure is the `Pedigree` class. It represents individuals and their parents (ascendants).

```R
library(GeneticsPed)

# Create a pedigree from a data frame
# unknown values (0, "", "unknown") are converted to NA
ped <- Pedigree(x = my_data, 
                subject = "id", 
                ascendant = c("father", "mother"),
                ascendantSex = c("Male", "Female"), 
                sex = "sex",
                unknown = c(0, ""))

# Ensure all parents are also listed as subjects
ped_extended <- extend(ped)
```

### Pedigree Validation

Use the `check` function to ensure the pedigree is biologically and computationally consistent.

```R
# Perform comprehensive checks
check(ped)

# Specific checks performed include:
# - idClass: All IDs must have the same class
# - subjectIsNA: Subjects cannot be NA
# - subjectNotUnique: IDs must be unique
# - subjectEqualAscendant: An individual cannot be its own parent
# - ascendantInAscendant: A father cannot also be a mother
```

### Calculating Genetic Relationships

The package provides tools to calculate the numerator relationship matrix (A) and its inverse, which are essential for mixed models.

```R
# Calculate the inverse of the additive relationship matrix (A-inverse)
# This is much more efficient than inverting A directly for large pedigrees
Ainv <- inverseAdditive(x = ped_extended)

# Get the number of individuals in the pedigree
n <- nIndividual(ped_extended)
```

### Setting up Animal Models (MME)

You can use the pedigree object to generate design matrices for mixed model equations.

```R
# Create a design matrix (Z) for additive genetic effects
# This maps phenotype records to individuals in the pedigree
Z <- model.matrix(object = ped, y = ped$phenotype, id = ped$id)

# Calculate alpha (ratio of residual variance to additive genetic variance)
alpha <- sigma2e / sigma2a

# Add A-inverse * alpha to the random effects block of the LHS of MME
LHS_genetic_block <- Z_transpose_Z + Ainv * alpha
```

## Tips and Best Practices

- **Unknown IDs**: Always use `NA` to represent unknown parents. Use the `unknown` argument in the `Pedigree` constructor to convert other representations (like 0 or "unknown") automatically.
- **Sorting**: Many genetic algorithms require the pedigree to be sorted (parents before offspring). Use `extend()` and ensure the pedigree is properly ordered before calculating relationship matrices.
- **Memory Efficiency**: For large populations, use `inverseAdditive` directly rather than constructing the full A matrix, as the inverse is typically sparse.

## Reference documentation

- [Calculation of genetic relatedness/relationship between individuals in the pedigree](./references/geneticRelatedness.md)
- [Pedigree handling](./references/pedigreeHandling.md)
- [Quantitative genetic (animal) model example in R](./references/quanGenAnimalModel.md)