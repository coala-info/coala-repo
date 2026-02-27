---
name: bioconductor-mousefm
description: bioconductor-mousefm performs genetic finemapping in inbred mice by leveraging homozygous genotypes to identify candidate variants and genes. Use when user asks to fetch genotypes for genomic regions, identify variants by comparing strain sets, or prioritize mouse strains to refine QTL regions.
homepage: https://bioconductor.org/packages/release/bioc/html/MouseFM.html
---


# bioconductor-mousefm

name: bioconductor-mousefm
description: Genetic finemapping in inbred mice using homozygous genotypes. Use this skill to fetch genotypes for specific genomic regions (GRCm38), identify candidate variants/genes by comparing strain sets (case vs. control), and prioritize additional mouse strains to refine QTL regions.

## Overview

MouseFM is an R package designed for genetic finemapping in inbred mouse strains. It leverages the extremely high homozygosity rate (>95%) of these strains to identify causal variants. The package allows users to download genotypes for 37 inbred strains, perform automated finemapping based on phenotypic differences, and prioritize strain combinations for follow-up crossing experiments.

## Core Workflows

### 1. Fetching Genotypes
Retrieve homozygous genotypes for a specific genomic region (GRCm38).

```r
library(MouseFM)

# Fetch genotypes for a specific region
df <- fetch(chr = "chr1", start = 5000000, end = 6000000)

# View metadata (reference version and reference strain info)
comment(df)
```

### 2. Genetic Finemapping
Identify variants where alleles differ between two groups of strains (e.g., strains with a trait vs. strains without).

```r
# List available strains to get correct IDs
avail_strains()

# Finemap a region by comparing two sets of strains
# impact filters for VEP impact: HIGH, MODERATE, LOW
res <- finemap(chr = "chr7",
               strain1 = c("C57BL_6J", "C57L_J"), 
               strain2 = c("C3H_HeJ", "MOLF_EiJ"),
               impact = c("HIGH", "MODERATE"))

# Annotate results with gene information (flanking in bp)
genes <- annotate_mouse_genes(res, flanking = 50000)

# Annotate with detailed consequences (use sparingly for large datasets)
cons <- annotate_consequences(res, "mouse")
```

### 3. Strain Prioritization
Determine which additional strains would best refine a QTL region identified in a cross between two specific strains.

```r
# Prioritize strains to refine a region found in a C57BL_6J x AKR_J cross
prio_res <- prio(chr = "chr1", start = 5000000, end = 6000000, 
                 strain1 = "C57BL_6J", strain2 = "AKR_J")

# Get the top 3 strain combinations for maximum refinement
top_strains <- get_top(prio_res$reduction, n_top = 3)

# Visualize the reduction factors
plots <- vis_reduction_factors(prio_res$genotypes, prio_res$reduction, n_strains = 2)
print(plots[[1]])
```

## Tips and Best Practices

- **Genome Build**: All coordinates must be in **GRCm38**.
- **Reference Strain**: C57BL_6J is typically treated as the reference (0) in the genotype matrices.
- **Performance**: `annotate_consequences` can be slow and resource-intensive for large regions; use `annotate_mouse_genes` for initial screening.
- **Strain IDs**: Always use `avail_strains()` to verify the exact string IDs required by the `strain1` and `strain2` arguments.

## Reference documentation

- [Fetch homozygous genotypes](./references/fetch.md)
- [Finemapping genetic regions](./references/finemap.md)
- [Prioritization of mouse strains](./references/prio.md)