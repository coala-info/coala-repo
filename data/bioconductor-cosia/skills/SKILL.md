---
name: bioconductor-cosia
description: CoSIA is an R package for comparative transcriptomics that enables the comparison of gene expression patterns, variability, and specificity across different species and tissues. Use when user asks to compare gene expression across model organisms, map orthologs between species, calculate expression variability metrics, or visualize tissue-specific gene diversity.
homepage: https://bioconductor.org/packages/release/bioc/html/CoSIA.html
---


# bioconductor-cosia

## Overview

CoSIA (Cross Species Investigation and Analysis) is an R package designed for comparative transcriptomics. It leverages curated wild-type RNA-Seq data from the Bgee database to allow researchers to compare gene expression patterns across different model organisms and tissues. The package provides a unified framework for gene ID conversion, ortholog mapping, and the calculation of expression variability (CV) and specificity (Shannon Entropy) metrics.

## Core Workflow

### 1. Initialization and Tissue Selection
Before creating the main object, identify shared tissues across your species of interest.

```r
library(CoSIA)

# Find tissues shared between mouse and rat
shared_tissues <- getTissues(c("m_musculus", "r_norvegicus"))

# Initialize the CoSIAn object
cosian_obj <- CoSIAn(
    gene_set = c("GENE1", "GENE2"), # Character vector of gene IDs
    i_species = "h_sapiens",        # Input species
    o_species = c("h_sapiens", "m_musculus"), # Output species
    input_id = "Symbol",            # "Symbol", "Ensembl_id", or "Entrez_id"
    output_ids = "Ensembl_id",      # Must include "Ensembl_id" for GEx retrieval
    map_species = c("h_sapiens", "m_musculus"),
    map_tissues = c("brain", "heart"),
    mapping_tool = "annotationDBI", # or "biomaRt"
    ortholog_database = "HomoloGene", # or "NCBIOrtho"
    metric_type = "CV_Species"      # See Metric Types table below
)
```

### 2. ID Conversion and Ortholog Mapping
Convert your input gene set into the required IDs and find orthologs in the target species.

```r
cosian_obj <- getConversion(cosian_obj)

# View converted IDs
converted_data <- viewCoSIAn(cosian_obj, "converted_id")
```

### 3. Retrieving Gene Expression (GEx)
Download and process Variance Stabilizing Transformed (VST) read counts from Bgee.

```r
cosian_obj <- getGEx(cosian_obj)

# View expression data
gex_data <- viewCoSIAn(cosian_obj, "gex")
```

### 4. Calculating and Plotting Metrics
Calculate variability or diversity metrics and generate visualizations.

```r
# Calculate metrics (CV or DS based on metric_type)
cosian_obj <- getGExMetrics(cosian_obj)

# Plotting variability (CV)
plotCVGEx(cosian_obj)

# Plotting Diversity and Specificity (DS)
plotDSGEx(cosian_obj)
```

## Visualization Tools

- `plotSpeciesGEx(obj, tissue, gene_id)`: Compare expression of one gene in one tissue across multiple species.
- `plotTissueGEx(obj, species, gene_id)`: Compare expression of one gene in one species across multiple tissues.
- `plotCVGEx(obj)`: Visualize the Coefficient of Variation (variability).
- `plotDSGEx(obj)`: Visualize Shannon Entropy (Diversity vs. Specificity).

## Metric Types Reference

| Metric Type | Description |
| :--- | :--- |
| `CV_Species` | Variability of gene expression across species for a specific tissue. |
| `CV_Tissue` | Variability of gene expression across tissues for a specific species. |
| `DS_Gene` | Diversity/Specificity across genes in the provided set for selected tissues. |
| `DS_Tissue` | Diversity/Specificity across selected tissues for the provided gene set. |
| `DS_Gene_all` | Diversity/Specificity across the gene set using all available tissues in Bgee. |

## Important Constraints

- **Species Names**: Use specific strings: `"h_sapiens"`, `"m_musculus"`, `"r_norvegicus"`, `"d_rerio"`, `"d_melanogaster"`, `"c_elegans"`.
- **Ensembl IDs**: The `getGEx` function requires `Ensembl_id` to be present in the `output_ids` slot of the CoSIAn object.
- **Species Mapping**: Any species intended for comparison must be listed in both `map_species` and `o_species`.

## Reference documentation

- [CoSIA, an R package for Cross Species Investigation and Analysis](./references/CoSIA_Intro.md)
- [CoSIA Introduction Vignette (Rmd)](./references/CoSIA_Intro.Rmd)