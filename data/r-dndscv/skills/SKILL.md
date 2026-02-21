---
name: r-dndscv
description: R package dndscv (documentation from project home).
homepage: https://cran.r-project.org/web/packages/dndscv/index.html
---

# r-dndscv

name: r-dndscv
description: Quantify selection in cancer and somatic evolution using dN/dS methods. Use this skill when analyzing somatic mutation data (SNVs and Indels) to detect cancer driver genes, estimate dN/dS ratios for missense, nonsense, and splice mutations, or build custom reference databases for different species/assemblies.

## Overview
The dndscv package implements maximum-likelihood dN/dS methods specifically designed for somatic evolution. It accounts for trinucleotide context-dependent substitution models and variation in mutation rates across genes using epigenomic covariates. It is primarily used to identify genes under positive selection (drivers) in cancer genomes.

## Installation
```R
# Install from GitHub using devtools
library(devtools)
install_github("im3sanger/dndscv")
```

## Core Workflow
The primary function is `dndscv()`, which performs the dN/dS analysis.

### 1. Input Data Format
The input should be a data frame with at least 5 columns:
1. Sample ID
2. Chromosome
3. Position (1-based)
4. Reference allele
5. Mutant allele

### 2. Basic Analysis
```R
library(dndscv)

# Run dN/dS analysis on human hg19 (default)
out = dndscv(mutations_df)

# View global dN/dS estimates
out$globaldnds

# View gene-specific results (p-values for selection)
sel_genes = out$sel_cv
print(head(sel_genes))
```

### 3. Using Different Assemblies
For human GRCh38/hg38:
```R
out = dndscv(mutations_df, refdb="hg38")
```

### 4. Targeted Sequencing
If using a targeted panel rather than Whole Exome/Genome Sequencing, provide the list of genes to restrict the background model:
```R
out = dndscv(mutations_df, gene_list=my_panel_genes)
```

## Advanced Usage
### Custom Reference Databases
If working with non-human species or custom transcripts, use `buildref()` to create a compatible reference object.
```R
# Example structure for building a reference
buildref(cdsfile="path/to/cds.fa", genomefile="path/to/genome.fa", outfile="my_species_ref.RData")
```

### Key Output Components
- `sel_cv`: Main table with p-values for missense, truncating, and all mutations per gene.
- `globaldnds`: Overall dN/dS ratios across the entire dataset.
- `annotmuts`: Annotated mutations including their functional impact (synonymous, missense, nonsense, splice).

## Tips for Success
- **Epigenomic Covariates**: dndscv uses 20 epigenomic covariates by default to model background mutation rates. This is critical for reducing false positives in driver discovery.
- **Sample Size**: While it works on small datasets, the power to detect selection increases significantly with the number of samples.
- **Indels**: By default, dndscv focuses on SNVs. Ensure your input data is filtered for high-quality somatic variants.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)