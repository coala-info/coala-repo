---
name: r-consensustme
description: This tool estimates the relative abundance of immune and stromal cell types in the tumor microenvironment using cancer-specific consensus gene sets and enrichment analysis. Use when user asks to perform cell type deconvolution, estimate tumor microenvironment composition, or calculate enrichment scores for immune and stromal signatures in bulk transcriptomic data.
homepage: https://cran.r-project.org/web/packages/consensustme/index.html
---

# r-consensustme

name: r-consensustme
description: Use the ConsensusTME R package to estimate the relative abundance of immune and stromal cell types in the tumor microenvironment (TME) using cancer-specific consensus gene sets. Use this skill when you need to perform cell type deconvolution or enrichment analysis on bulk transcriptomic data from human cancer samples.

## Overview

ConsensusTME is an integrative R tool that generates cancer-specific gene signatures for multiple cell types within the tumor microenvironment. It employs a consensus approach by combining multiple independent TME cell signatures and uses a Single Sample Gene Set Enrichment Analysis (ssGSEA) framework (or other statistical methods) to provide normalized enrichment scores. These scores represent the relative abundance of cell types across samples.

Key features:
- Cancer-specific gene sets for 32 TCGA cancer types.
- Integration of multiple signature discovery methods.
- Support for various enrichment algorithms (ssGSEA, GSVA, etc.).
- Benchmarked specifically for the tumor microenvironment.

## Installation

To install the ConsensusTME package from GitHub:

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("cansysbio/ConsensusTME")
```

## Cell Type Estimation Workflow

The primary function for analyzing bulk expression data is `consensusTMEAnalysis`.

### Basic Usage

```R
library(ConsensusTME)

# bulk_matrix should be a numeric matrix with HUGO gene symbols as row names
# cancer should be a TCGA study abbreviation (e.g., "BRCA", "OV", "SKCM")
results <- ConsensusTME::consensusTMEAnalysis(
  data = bulk_matrix, 
  cancer = "OV", 
  statMethod = "ssgsea"
)
```

### Supported Cancer Types
You can view all supported TCGA cancer codes using:
```R
ConsensusTME::cancerAll
```
Common codes include: `ACC`, `BLCA`, `BRCA`, `CESC`, `COAD`, `GBM`, `HNSC`, `KIRC`, `LUAD`, `LUSC`, `OV`, `PRAD`, `SKCM`, `STAD`.

### Statistical Methods
The `statMethod` argument supports several frameworks:
- `ssgsea` (Default)
- `gsva`
- `singScore`
- `plage`
- `zscore`

## Advanced Workflows

### Accessing Consensus Gene Sets
If you only need the curated gene sets for your own analysis:
```R
# Access pre-processed consensus gene sets
gene_sets <- ConsensusTME::consensusGeneSets
```

### Running Enrichment on Specific Signatures
To use the ConsensusTME enrichment framework with a specific underlying method's signature (e.g., Bindea et al.):
```R
bindea_sigs <- ConsensusTME::methodSignatures$Bindea
enrichment_results <- ConsensusTME::geneSetEnrichment(bulk_matrix, bindea_sigs)
```

### Custom Consensus Generation
To manually build consensus signatures from raw method signatures:
```R
raw_sigs <- ConsensusTME::methodSignatures
matched_sigs <- ConsensusTME::matchGeneSigs(raw_sigs)
consensus_genes <- ConsensusTME::buildConsensusGenes(matched_sigs)
```

## Usage Tips
- **Gene Symbols**: Ensure your input matrix uses HUGO gene symbols.
- **Relative Quantification**: Results provide cell type quantification that is relative across samples, not necessarily comparable across different cell types within the same sample.
- **Tissue Context**: These gene sets are optimized for the tumor microenvironment. For healthy tissue or PBMCs, alternative methodologies may be more appropriate.
- **Data Scaling**: Input data should typically be normalized (e.g., TPM, FPKM, or log-transformed counts) before enrichment analysis.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)