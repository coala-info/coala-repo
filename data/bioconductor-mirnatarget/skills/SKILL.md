---
name: bioconductor-mirnatarget
description: This package provides miRNA target gene tables, gene ID conversion mappings, and conservation data for human and mouse. Use when user asks to perform miRNA target inference, map miRNAs to target genes, or provide data support for the MiRaGE algorithm.
homepage: https://bioconductor.org/packages/release/data/experiment/html/miRNATarget.html
---

# bioconductor-mirnatarget

name: bioconductor-mirnatarget
description: Provides access to miRNA target gene tables, gene ID conversion tables, and miRNA conservation data for human and mouse. Use when performing miRNA target inference, specifically when using the MiRaGE algorithm or package to analyze gene regulation.

# bioconductor-mirnatarget

## Overview

The `miRNATarget` package is a data experiment package designed to support the `MiRaGE` (miRNA Ranking by Gene Expression) framework. It provides essential mapping data between miRNAs and their target genes for Human (*Homo sapiens*) and Mouse (*Mus musculus*). It includes RefSeq to Ensembl ID conversions and conservation tables necessary for inferring miRNA-mediated gene regulation from expression data.

## Loading Data

The package primarily consists of datasets rather than complex functions. Load the library and specific datasets as follows:

```r
library(miRNATarget)

# Load Mouse RefSeq to Ensembl mapping
data(MM_refseq_to_ensembl_gene_id)

# Load Mouse miRNA target table (TBL2)
data(TBL2_MM)

# Load Mouse ID conversion table
data(MM_conv_id)

# For Human data, use the HS prefix (if available in the namespace)
# data(TBL2_HS)
```

## Typical Workflow

1.  **Identify Target Species**: Determine if you are working with Human (HS) or Mouse (MM) data.
2.  **Prepare Gene IDs**: Use the provided conversion tables (e.g., `MM_conv_id`) to ensure your gene expression data IDs match the format required by the MiRaGE algorithm.
3.  **Integrate with MiRaGE**: Pass these loaded data objects into the `MiRaGE` package functions to calculate the statistical significance of miRNA target regulation.

## Tips

*   **Dependency**: This package is rarely used in isolation. It is a data provider for the `MiRaGE` package. Ensure `MiRaGE` is installed to perform the actual analysis.
*   **Data Structure**: The `TBL2` objects are typically large matrices or data frames where rows represent genes and columns represent miRNAs, containing targeting information (often binary or conservation-based).
*   **Object Naming**: Data objects follow a naming convention: `MM` for *Mus musculus* and `HS` for *Homo sapiens*.

## Reference documentation

- [The miRNATarget data User's Guide](./references/miRNATarget.md)