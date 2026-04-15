---
name: bioconductor-pedixplorer
description: Pedixplorer is a Bioconductor package for creating, analyzing, and visualizing family pedigree data and kinship matrices. Use when user asks to create pedigree objects, calculate kinship coefficients, plot static or interactive pedigrees, and filter or shrink family structures for genetic studies.
homepage: https://bioconductor.org/packages/release/bioc/html/Pedixplorer.html
---

# bioconductor-pedixplorer

name: bioconductor-pedixplorer
description: Expert guidance for the Pedixplorer R package to handle family pedigree data. Use this skill for creating Pedigree objects, calculating kinship matrices (including X chromosome), plotting pedigrees (static and interactive), and filtering or trimming family structures for genetic studies.

# bioconductor-pedixplorer

## Overview
Pedixplorer is a Bioconductor package for handling, analyzing, and visualizing family pedigree data. It is an evolution of the `kinship2` package, providing tools to create correlation structures for mixed-effects models (like `coxme`), calculate kinship coefficients, and generate high-quality pedigree plots. It includes advanced features for pedigree trimming, shrinking to specific bit sizes, and handling special relationships like twins and inbreeding.

## Core Workflows

### 1. Creating a Pedigree Object
The `Pedigree()` function automatically detects necessary columns (id, dadid, momid, sex).
```r
library(Pedixplorer)
data("sampleped")

# Create a Pedigree object
# If multiple families exist, a 'famid' column is required
pedi <- Pedigree(sampleped)

# Subset by family ID
ped1 <- pedi[famid(ped(pedi)) == "1"]
summary(ped1)
```

### 2. Calculating Kinship Matrices
Kinship coefficients represent the probability that alleles are identical by descent (IBD).
```r
# Calculate kinship for a single pedigree or multiple families
kin_mat <- kinship(ped1)

# Kinship for twins (requires rel_df with codes: 1=MZ, 2=DZ, 3=UZ)
# MZ twins will have a kinship of 0.5
kin_all <- kinship(pedi)
```

### 3. Pedigree Visualization
Pedixplorer provides flexible plotting options, including support for affected status and deceased indicators.
```r
# Basic plot
plot(ped1, cex = 0.7)

# Plot with labels and legend
plot(ped1, label = "num", legend = TRUE, leg_loc = c(0.45, 0.9, 0.8, 1))

# Interactive plot using plotly
plot_list <- plot(ped1, ggplot_gen = TRUE, tips = c("id", "affection"))
plotly::ggplotly(plot_list$ggplot)
```

### 4. Fixing and Filtering Pedigrees
Use these utilities to clean data or reduce complexity for computational efficiency.
```r
# Fix sex mismatches (e.g., a father coded as female)
fixed_df <- with(my_df, fix_parents(id, dadid, momid, sex))
ped_fixed <- Pedigree(fixed_df)

# Filter for "useful" individuals within a certain distance
ped1 <- is_informative(ped1, informative = c("1_110"))
ped1 <- useful_inds(ped1, max_dist = 1)
ped_filtered <- ped1[useful(ped(ped1))]

# Shrink pedigree to a specific bit size for linkage analysis
shrunk_ped <- shrink(ped1, max_bits = 25)$pedObj
```

## Special Relationships
Specify relationships using a `rel_df` data frame passed to the `Pedigree` constructor:
- **Codes**: `1` (MZ twins), `2` (DZ twins), `3` (Unknown twins), `4` (Spouse/Marry-in without children).
- **Inbreeding**: Represented by adding ancestral nodes that connect founders.

## Tips for Success
- **Unique IDs**: When multiple families are present, Pedixplorer often pastes `famid` to `id` (e.g., "1_101") to ensure global uniqueness.
- **Alignment**: If a plot looks messy, try reordering the input data frame rows. The alignment algorithm is sensitive to the order in which founders and siblings are encountered.
- **Colors**: Use `generate_colors()` to map metadata columns to plot aesthetics (filling and borders).
- **Unrelateds**: Use `unrelated(ped_obj)` to find the maximum set of unrelated available individuals for study controls.

## Reference documentation
- [Pedixplorer tutorial](./references/Pedixplorer.md)
- [Pedigree alignment details](./references/pedigree_alignment.md)
- [The kinship algorithm](./references/pedigree_kinship.md)
- [The Pedigree object](./references/pedigree_object.md)
- [The plotting algorithm](./references/pedigree_plot.md)