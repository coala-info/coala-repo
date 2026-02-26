---
name: bioconductor-celldex
description: The celldex package provides a standardized interface for retrieving curated reference datasets of pure cell types for single-cell transcriptomics. Use when user asks to find available reference datasets, download curated expression matrices, or search for cell type labels for automated annotation.
homepage: https://bioconductor.org/packages/release/data/experiment/html/celldex.html
---


# bioconductor-celldex

## Overview

The `celldex` package provides a standardized interface for retrieving curated reference datasets of pure cell types. These references typically consist of log-normalized expression matrices and associated cell type labels at multiple resolutions (broad, fine, and ontology-mapped). It is a core component of the Bioconductor single-cell ecosystem, frequently used in conjunction with `SingleR` for automated cell type annotation.

## Core Workflows

### Finding References

Use `surveyReferences()` to list all available datasets and their metadata, including species, number of samples, and available labels.

```r
library(celldex)

# List all available references
all_refs <- surveyReferences()

# Search for specific keywords (e.g., "B cell")
b_cell_refs <- searchReferences("B cell")

# Advanced search using boolean logic
mouse_immune <- searchReferences(
    defineTextQuery("immun%", partial=TRUE) & 
    defineTextQuery("10090", field="taxonomy_id")
)
```

### Fetching Data

Once a reference is identified, use `fetchReference()` to download it. It is best practice to specify the version for reproducibility.

```r
# Fetch the Human Primary Cell Atlas (HPCA)
ref_hpca <- fetchReference("hpca", "2024-02-26")

# Fetch with Ensembl IDs instead of Gene Symbols
ref_ensembl <- fetchReference("hpca", "2024-02-26", ensembl=TRUE)
```

### Understanding Reference Labels

Datasets typically provide three levels of annotation in the `colData`:
- `label.main`: Broad categories (e.g., "T cells", "B cells").
- `label.fine`: High-resolution subtypes (e.g., "T cells, CD4+, memory").
- `label.ont`: Standardized Cell Ontology terms.

```r
# View available labels
head(colData(ref_hpca)$label.main)
table(ref_hpca$label.fine)
```

## Available Reference Datasets

| Name | Species | Best Use Case |
| :--- | :--- | :--- |
| `hpca` | Human | General purpose; blood and various tissues. |
| `blueprint_encode` | Human | Stroma and immune cells; good for broad labels. |
| `mouse_rnaseq` | Mouse | General purpose; brain, blood, heart. |
| `immgen` | Mouse | Exhaustive immune cell subtypes (very high resolution). |
| `dice` | Human | CD4+ T cell subsets and immune cells. |
| `novershtern_hematopoietic` | Human | Myeloid and progenitor cells (bone marrow). |
| `monaco_immune` | Human | Comprehensive PBMC coverage (B, T, Mono, DC, Neutro). |

## Contributing New References

To add a custom reference to the ecosystem:
1. Prepare a log-normalized matrix and a `DataFrame` of labels.
2. Create a metadata list following the Bioconductor schema.
3. Use `saveReference(matrix, labels, path, metadata)` to stage the data.
4. Use `gypsum::uploadDirectory()` to upload to the backend (requires permissions).

```r
# Example staging
norm_mat <- matrix(runif(1000), ncol=20)
rownames(norm_mat) <- paste0("GENE_", 1:50)
labels <- DataFrame(label.main=rep(c("A", "B"), each=10))

meta <- list(
    title="My Custom Reference",
    description="Description of the data",
    taxonomy_id="9606",
    genome="GRCh38",
    maintainer_name="User Name",
    maintainer_email="user@example.com"
)

staging <- tempfile()
saveReference(norm_mat, labels, staging, meta)
```

## Reference documentation

- [Pokédex for Cell Types](./references/userguide.md)