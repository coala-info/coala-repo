---
name: bioconductor-clusterjudge
description: This tool evaluates the quality of cluster analysis by measuring its mutual information against external entity-attribute associations. Use when user asks to judge clustering quality, compare clusters to Gene Ontology terms, or validate cluster assignments using external information.
homepage: https://bioconductor.org/packages/release/bioc/html/ClusterJudge.html
---


# bioconductor-clusterjudge

## Overview

The `ClusterJudge` package provides a framework for judging the quality of a cluster analysis based on external information. It uses Mutual Information (MI) to quantify how well a clustering "agrees" with a system of attributes (like Gene Ontology). A high-quality clustering should show a significant decrease in total mutual information when entities are randomly swapped between clusters.

## Core Workflow

### 1. Prepare Clustering Data
The clustering must be a **named vector** where values are cluster IDs and names are entity IDs (e.g., Gene IDs). Ensure there are no `NA` values and each entity belongs to exactly one cluster.

```r
# Example: Convert a dataframe to a named vector
# clusters_df has columns 'GeneID' and 'Cluster'
clusters <- clusters_df$Cluster
names(clusters) <- clusters_df$GeneID
```

### 2. Obtain Entity-Attribute Associations
You need a data frame with two columns: Entity IDs and Attribute IDs (e.g., GO terms).

*   **For Yeast:** Use the built-in dataset `data(Yeast.GO.assocs)`.
*   **For other species:** Use `biomaRt` to fetch GO terms or custom mappings.
*   **Validation:** Always run `validate_association(your_assoc_df)` to check for NAs, NULLs, or duplicates.

### 3. Consolidate Attributes
To improve performance and reduce noise, consolidate attributes that are too rare or highly redundant.

*   **Filter by frequency:** Remove attributes associated with very few entities.
*   **Filter by redundancy:** Use mutual information to remove redundant attributes based on an uncertainty limit (`U.limit`).

```r
# Consolidate based on frequency and redundancy
# mi.GO.Yeast is a pre-calculated MI matrix for Yeast
data(mi.GO.Yeast)
consolidated <- consolidate_entity_attribute(
  entity.attribute = Yeast.GO.assocs,
  min.entities.per.attr = 3,
  mut.inf = mi.GO.Yeast,
  U.limit = c(0.1, 0.001) # Lower limit = more aggressive consolidation
)

# Access a specific level
assoc_to_use <- consolidated[["0.001"]]
```

### 4. Judge the Clustering
The `clusterJudge` function performs random swaps of entities between clusters and tracks the change in mutual information.

```r
mi_results <- clusterJudge(
  clusters = clusters,
  entity.attribute = assoc_to_use,
  plot.notes = 'Description of the experiment',
  plot.saveRDS.file = 'results_plot.rds'
)
```

## Interpreting Results

*   **Decreasing Trend:** If the plot shows a sharp decrease in Mutual Information as the number of random swaps increases, the original clustering is well-supported by the attributes.
*   **Flat Trend:** If the MI remains constant or changes minimally, the clustering does not align with the provided attributes.
*   **Increasing Trend (Rare):** May suggest the clustering captures novel relationships that contradict or complement existing annotations, provided the experimental data is highly reliable.

## Key Functions

*   `validate_association(df)`: Checks integrity of entity-attribute mapping.
*   `entities_attribute_stats(df)`: Visualizes the distribution of entities per attribute.
*   `consolidate_entity_attribute(...)`: Reduces attribute set size via frequency and MI thresholds.
*   `attribute_mut_inf(df)`: Calculates the mutual information matrix for a new set of attributes (computationally intensive).
*   `clusterJudge(clusters, entity.attribute)`: The main evaluation and plotting function.

## Reference documentation

- [ClusterJudge](./references/ClusterJudge-intro.md)