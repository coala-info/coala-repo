---
name: bioconductor-fobitools
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/fobitools.html
---

# bioconductor-fobitools

name: bioconductor-fobitools
description: Analysis of dietary data and metabolomics using the Food Biomarker Ontology (FOBI). Use this skill to annotate food items from text, convert chemical identifiers (PubChem, KEGG, HMDB) to FOBI IDs, and perform food-specific enrichment analysis (ORA and MSEA) to link metabolites to dietary patterns.

# bioconductor-fobitools

## Overview

The `fobitools` package provides a suite of tools to work with the Food Biomarker Ontology (FOBI). It bridges the gap between dietary intake data (from questionnaires like FFQs) and metabolomics results. Its primary capabilities include automatic text annotation of food items, seamless ID conversion between various chemical databases and FOBI, and specialized enrichment analyses that identify food groups or chemical classes associated with metabolic profiles.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("fobitools")
library(fobitools)
```

## Dietary Text Annotation

Use `annotate_foods()` to map free-text food descriptions to FOBI/FoodOn identifiers.

- **Input**: A data frame with two columns: `FOOD_ID` and `FOOD_NAME`.
- **Similarity**: The `similarity` argument (default 0.85) controls the fuzzy matching threshold (0 to 1).

```r
# Example with a data frame 'my_ffq'
annotated <- annotate_foods(my_ffq, similarity = 0.85)

# Access results
results <- annotated$annotated
percentage <- annotated$percentage
```

## ID Conversion

The `id_convert()` function is a versatile tool for mapping between FOBI IDs and common chemical identifiers including PubChem CID, KEGG ID, HMDB ID, ChemSpider, and InChIKey.

```r
# Convert PubChem CIDs to FOBI IDs
fobi_ids <- id_convert(my_pubchem_list, from = "PubChemCID", to = "FOBI")

# Supported 'from'/'to' values: "FOBI", "HMDB", "KEGG", "PubChemCID", "InChIKey", "ChemSpider"
```

## Enrichment Analysis

`fobitools` allows you to move from a list of significant metabolites to the food groups they represent.

### Over Representation Analysis (ORA)
Evaluates if specific food classes are over-represented in a list of significant metabolites compared to a background universe.

```r
# metaboliteList and metaboliteUniverse should be FOBI IDs
ora_results <- ora(metaboliteList = sig_fobi_ids,
                   metaboliteUniverse = all_fobi_ids,
                   pvalCutoff = 0.05)
```

### Metabolite Set Enrichment Analysis (MSEA)
Uses a ranked list of metabolites (e.g., ranked by p-value or fold change) to identify enriched food groups without requiring a hard significance threshold.

```r
# Create a named vector of ranks (names = FOBI IDs)
ranked_metabolites <- limma_results$pvalue
names(ranked_metabolites) <- limma_results$FOBI

msea_results <- msea(ranked_metabolites, pvalCutoff = 0.05)
```

## Visualization

The `fobi_graph()` function visualizes the relationships between annotated terms or enriched classes within the FOBI ontology structure.

```r
# Visualize a list of FOBI terms and their ancestors
fobi_graph(terms = my_fobi_ids,
           get = "anc", 
           labels = TRUE,
           legend = TRUE)
```

## Typical Workflow

1. **Annotation**: Convert FFQ text to FOBI IDs using `annotate_foods()`.
2. **Mapping**: Convert metabolomics feature IDs (PubChem/KEGG) to FOBI IDs using `id_convert()`.
3. **Association**: Join metabolomics results with FOBI metadata to identify which metabolites are biomarkers of specific foods.
4. **Enrichment**: Run `msea()` or `ora()` to determine which food groups are significantly associated with the experimental conditions.
5. **Visualization**: Use `fobi_graph()` to map the results onto the ontology hierarchy.

## Reference documentation

- [Dietary text annotation](./references/Dietary_data_annotation.md)
- [Use case ST000291: Cranberry vs Apple Juice](./references/MW_ST000291_enrichment.md)
- [Use case ST000629: Dietary Salt and Blood Pressure](./references/MW_ST000629_enrichment.md)
- [Food enrichment analysis patterns](./references/food_enrichment_analysis.md)