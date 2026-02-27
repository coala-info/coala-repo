---
name: bioconductor-viseago
description: ViSEAGO performs Gene Ontology enrichment analysis and clusters results based on semantic similarity for functional visualization. Use when user asks to retrieve GO annotations, perform functional enrichment analysis, compare multiple experimental conditions, or cluster GO terms using semantic similarity.
homepage: https://bioconductor.org/packages/release/bioc/html/ViSEAGO.html
---


# bioconductor-viseago

## Overview
ViSEAGO (Visualization, Semantic similarity, and Enrichment Analysis of Gene Ontology) is an R package designed to facilitate functional GO analysis, especially for complex experimental designs with multiple comparisons. It extends classical enrichment by aggregating closely related biological themes using semantic similarity, ensuring functional coherence in the results. It supports major genomic resources (EntrezGene, Ensembl, Uniprot) and integrates with enrichment tools like `topGO` and `fgsea`.

## Core Workflow

### 1. GO Annotation Retrieval
ViSEAGO provides unified access to several databases. First, identify the available organisms, then annotate your genes.

```R
# Connect to a resource
Ensembl <- ViSEAGO::Ensembl2GO()
# List available organisms to find the key identifier
ViSEAGO::available_organisms(Ensembl)

# Extract annotations for a specific species
myGENE2GO <- ViSEAGO::annotate("mmusculus_gene_ensembl", Ensembl)
```

### 2. Functional Enrichment
You can use either `topGO` (Fisher's exact test) or `fgsea` (Gene Set Enrichment Analysis).

**Using topGO:**
```R
# Create topGOdata object
BP <- ViSEAGO::create_topGOdata(
    geneSel = selection_vector,
    allGenes = background_vector,
    gene2GO = myGENE2GO,
    ont = "BP",
    nodeSize = 5
)

# Run test
result <- topGO::runTest(BP, algorithm = "elim", statistic = "fisher")
```

**Using fgsea:**
```R
# Requires a ranked data.table with 'Id' and statistical value
BP_fgsea <- ViSEAGO::runfgsea(
    geneSel = ranked_dt,
    ont = "BP",
    gene2GO = myGENE2GO,
    method = "fgseaMultilevel",
    params = list(scoreType = "pos", minSize = 5)
)
```

### 3. Merging and Comparing Results
Combine multiple enrichment tests to compare conditions.

```R
BP_sResults <- ViSEAGO::merge_enrich_terms(
    Input = list(
        Condition1 = c("BP", "elim"),
        Condition2 = c("BP", "elim")
    )
)

# Visualize intersections
ViSEAGO::Upset(BP_sResults)
```

### 4. Semantic Similarity and Clustering
This is the core strength of ViSEAGO: grouping GO terms by functional similarity.

```R
# Build the Semantic Similarity object
myGOs <- ViSEAGO::build_GO_SS(myGENE2GO, BP_sResults)

# Compute distances (Resnik, Lin, Rel, Jiang, or Wang)
myGOs <- ViSEAGO::compute_SS_distances(myGOs, distance = "Wang")

# Cluster GO terms and create a heatmap
Wang_clusters <- ViSEAGO::GOterms_heatmap(
    myGOs,
    showIC = TRUE,
    GO.tree = list(
        tree = list(distance = "Wang", aggreg.method = "ward.D2"),
        cut = list(dynamic = list(deepSplit = 2, minClusterSize = 2))
    )
)

# Display interactive heatmap
ViSEAGO::show_heatmap(Wang_clusters, "GOterms")
```

### 5. Higher-Level Clustering (GO Clusters)
If you have many GO clusters, you can compute similarity between the clusters themselves.

```R
# Compute similarity between clusters (max, avg, rcmax, or BMA)
Wang_clusters <- ViSEAGO::compute_SS_distances(Wang_clusters, distance = "BMA")

# Cluster the clusters
Wang_clusters <- ViSEAGO::GOclusters_heatmap(
    Wang_clusters,
    tree = list(distance = "BMA", aggreg.method = "ward.D2")
)

# Show the cluster-level heatmap
ViSEAGO::show_heatmap(Wang_clusters, "GOclusters")
```

## Tips for Success
- **Interactive Plots**: Most `show_heatmap` and `MDSplot` calls generate interactive plotly objects. Use `file = "output.png"` to save static versions.
- **Data Export**: Use `ViSEAGO::show_table(Wang_clusters)` to get a detailed Excel-ready table containing GO terms, clusters, p-values, and the specific genes associated with each term.
- **IC-based vs Graph-based**: Semantic similarities like Resnik and Lin are Information Content (IC) based, while Wang is graph-topology based. IC-based methods often cluster more tightly.

## Reference documentation
- [Evaluate impact of Semantic Similarity choice](./references/SS_choice.md)
- [An overview of ViSEAGO](./references/ViSEAGO.md)
- [Functional analysis using fgsea instead of topGO](./references/fgsea_alternative.md)
- [Functional analysis of mouse mammary gland RNA-Seq](./references/mouse_bioconductor.md)