# Functional analysis of mouse mammary gland RNA-Seq

Aurelien Brionne1, Amelie Juanchich1 and Christelle Hennequet-Antier1

1Institut national de recherche pour l'agriculture, l'alimentation et l'environnement (INRAE)

#### 30 October, 2025

# Contents

* [Introduction](#introduction)
* [Data](#data)
* [1 Genes of interest](#genes-of-interest)
* [2 GO annotation of genes](#go-annotation-of-genes)
* [3 Functional GO enrichment](#functional-go-enrichment)
  + [3.1 GO enrichment tests](#go-enrichment-tests)
  + [3.2 Combine enriched GO terms](#combine-enriched-go-terms)
  + [3.3 Graphs of GO enrichment tests](#graphs-of-go-enrichment-tests)
* [4 GO terms Semantic Similarity](#go-terms-semantic-similarity)
* [5 Visualization and interpretation of enriched GO terms](#visualization-and-interpretation-of-enriched-go-terms)
  + [5.1 Multi Dimensional Scaling of GO terms - A preview](#multi-dimensional-scaling-of-go-terms---a-preview)
  + [5.2 Clustering heatmap of GO terms](#clustering-heatmap-of-go-terms)
  + [5.3 Multi Dimensional Scaling of GO terms](#multi-dimensional-scaling-of-go-terms)
* [6 Visualization and interpretation of GO clusters](#visualization-and-interpretation-of-go-clusters)
  + [6.1 Compute semantic similarity between GO clusters](#compute-semantic-similarity-between-go-clusters)
  + [6.2 GO clusters semantic similarities heatmap](#go-clusters-semantic-similarities-heatmap)
* [7 Conclusion](#conclusion)
* [Information session](#information-session)
* [References](#references)

# Introduction

This study explores expression profiles of basal stem-cell enriched cells (B) and committed luminal cells (L) of the mammary gland of virgin, pregnant and lactating mice [[1](#ref-pmid25730472)]. Six groups are compared corresponding to a combination of cell type and mouse status. Each group contains two biological replicates. Sequences and counts datasets are publicly available from the Gene Expression Omnibus (GEO) with the serie accession number GSE60450. The RNA-Seq data is analysed by *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* development team [[2](#ref-edgeR)].

As described in edgeR user guide, we tested for significant differential expression in gene, using the QL F-test [[3](#ref-pmid23104842)]. Here, we focused in gene expression analysis in only one type of cell, i.e. luminal cells for the three developmental status (virgin, pregnant and lactating mice). Among the 15,804 expressed genes, we obtained 7,302 significantly differentially expressed (DE) genes for the comparison virgin versus pregnant, 7,699 for the comparison pregnant versus lactate, and 9,583 for the comparison virgin versus lactate, with Benjamini-Hochberg correction to control the false discovery rate at 5%.

# Data

Vignette build convenience (for less build time and package size) need that data were pre-calculated (provided by the package), and that illustrations were not interactive.

```
# load vignette data
data(
    myGOs,
    package="ViSEAGO"
)
```

# 1 Genes of interest

We load examples files from *[ViSEAGO](https://bioconductor.org/packages/3.22/ViSEAGO)* package using `system.file` from the locally installed package. We read the gene identifiers for the background (= expressed genes) file and the three lists of DE genes of the study. Here, gene identifiers are GeneID from EntrezGene database.

```
# load genes identifiants (GeneID,ENS...) background (expressed genes)
background<-scan(
    system.file(
        "extdata/data/input",
        "background_L.txt",
        package = "ViSEAGO"
    ),
    quiet=TRUE,
    what=""
)

# load Differentialy Expressed (DE) gene identifiants from lists
PregnantvsLactateDE<-scan(
    system.file(
        "extdata/data/input",
        "pregnantvslactateDE.txt",
        package = "ViSEAGO"
    ),
    quiet=TRUE,
    what=""
)

VirginvsLactateDE<-scan(
    system.file(
        "extdata/data/input",
        "virginvslactateDE.txt",
        package = "ViSEAGO"
    ),
    quiet=TRUE,
    what=""
)

VirginvsPregnantDE<-scan(
    system.file(
        "extdata/data/input",
        "virginvspregnantDE.txt",
        package = "ViSEAGO"
    ),
    quiet=TRUE,
    what=""
)
```

Here, we display the first 6 GeneID from the *PregnantvsLactateDE* list.

# 2 GO annotation of genes

In this study, we build a `myGENE2GO` object using the Bioconductor *[org.Mm.eg.db](https://bioconductor.org/packages/3.22/org.Mm.eg.db)* database package for the mouse species. This object contains all available GO annotations for categories Molecular Function (MF), Biological Process (BP), and Cellular Component (CC).

NB: Don’t forget to check if the last current annotation database version is installed in your R session! See `ViSEAGO::available_organisms(Bioconductor)`.

```
# connect to Bioconductor
Bioconductor<-ViSEAGO::Bioconductor2GO()

# load GO annotations from Bioconductor
myGENE2GO<-ViSEAGO::annotate(
    "org.Mm.eg.db",
    Bioconductor
)
```

```
# display summary
myGENE2GO
```

```
- object class: gene2GO
- database: Bioconductor
- stamp/version: 2019-Jul10
- organism id: org.Mm.eg.db

GO annotations:
- Molecular Function (MF): 22707 annotated genes with 91986 terms (4121 unique terms)
- Biological Process (BP): 23210 annotated genes with 164825 terms (12224 unique terms)
- Cellular Component (CC): 23436 annotated genes with 107852 terms (1723 unique terms)
```

# 3 Functional GO enrichment

## 3.1 GO enrichment tests

We perform a functional Gene Ontology (GO) enrichment analysis from differentially expressed (DE) genes of luminal cells in the mammary gland. The enriched **Biological process** (BP) are obtained using a Fisher’s exact test with `elim` algorithm developped in *[topGO](https://bioconductor.org/packages/3.22/topGO)* package.

First, we create three `topGOdata` objects, using `ViSEAGO::create_topGOdata` method, corresponding to the three DE genes lists for the comparison virgin versus pregnant, pregnant versus lactate, and virgin versus lactate. The gene background corresponding to expressed genes in luminal cells of the mammary gland and GO annotations are also provided.

```
# create topGOdata for BP for each list of DE genes
BP_PregnantvsLactate<-ViSEAGO::create_topGOdata(
    geneSel=PregnantvsLactateDE,
    allGenes=background,
    gene2GO=myGENE2GO,
    ont="BP",
    nodeSize=5
)

BP_VirginvsLactate<-ViSEAGO::create_topGOdata(
    geneSel=VirginvsLactateDE,
    allGenes=background,
    gene2GO=myGENE2GO,
    ont="BP",
    nodeSize=5
)

BP_VirginvsPregnant<-ViSEAGO::create_topGOdata(
    geneSel=VirginvsPregnantDE,
    allGenes=background,
    gene2GO=myGENE2GO,
    ont="BP",
    nodeSize=5
)
```

Now, we perform the GO enrichment tests for BP category with Fisher’s exact test and *elim* algorithm using `topGO::runTest` method.

NB: p-values of enriched GO terms are not adjusted and considered significant if below 0.01.

```
# perform topGO tests
elim_BP_PregnantvsLactate<-topGO::runTest(
    BP_PregnantvsLactate,
    algorithm ="elim",
    statistic = "fisher",
    cutOff=0.01
)

elim_BP_VirginvsLactate<-topGO::runTest(
    BP_VirginvsLactate,
    algorithm ="elim",
    statistic = "fisher",
    cutOff=0.01
)

elim_BP_VirginvsPregnant<-topGO::runTest(
    BP_VirginvsPregnant,
    algorithm ="elim",
    statistic = "fisher",
    cutOff=0.01
)
```

## 3.2 Combine enriched GO terms

We combine the results of the three enrichment tests into an object using `ViSEAGO::merge_enrich_terms` method. A table of enriched GO terms in at least one comparison is displayed in interactive mode, or printed in a file using `ViSEAGO::show_table` method.
The printed table contains for each enriched GO terms, additional columns including the list of significant genes and frequency (ratio between the number of significant genes and number of background genes in a specific GO tag) evaluated by comparison.

```
# merge topGO results
BP_sResults<-ViSEAGO::merge_enrich_terms(
    cutoff=0.01,
    Input=list(
        PregnantvsLactate=c(
            "BP_PregnantvsLactate",
            "elim_BP_PregnantvsLactate"
        ),
        VirginvsLactate=c(
            "BP_VirginvsLactate",
            "elim_BP_VirginvsLactate"
        ),
        VirginvsPregnant=c(
            "BP_VirginvsPregnant",
            "elim_BP_VirginvsPregnant"
        )
    )
)
```

```
# display a summary
BP_sResults
```

```
- object class: enrich_GO_terms
- ontology: BP
- method: topGO
- summary:PregnantvsLactate
      BP_PregnantvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7699
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_PregnantvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 199
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        Nontrivial_nodes: 8433
 VirginvsLactate
      BP_VirginvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 9583
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 152
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        Nontrivial_nodes: 8457
 VirginvsPregnant
      BP_VirginvsPregnant
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7302
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsPregnant
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 243
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        Nontrivial_nodes: 8413

- enrichment pvalue cutoff:
        PregnantvsLactate : 0.01
        VirginvsLactate : 0.01
        VirginvsPregnant : 0.01
- enrich GOs (in at least one list): 521 GO terms of 3 conditions.
        PregnantvsLactate : 199 terms
        VirginvsLactate : 152 terms
        VirginvsPregnant : 243 terms
```

```
# show table in interactive mode
ViSEAGO::show_table(BP_sResults)
```

![bioconductor_table1](data:image/png;base64...)

## 3.3 Graphs of GO enrichment tests

Several graphs summarize important features. An interactive barchart showing the number of GO terms enriched or not in each comparison, using `ViSEAGO::GOcount` method. Intersections of lists of enriched GO terms between comparisons are displayed in an Upset plot using `ViSEAGO::Upset` method.

```
# barchart of significant (or not) GO terms by comparison
ViSEAGO::GOcount(BP_sResults)
```

![gocount](data:image/png;base64...)

```
# display intersections
ViSEAGO::Upset(
    BP_sResults,
    file="upset.xls"
)
```

![upset](data:image/png;base64...)

# 4 GO terms Semantic Similarity

GO annotations of genes created at a previous step and enriched GO terms are combined using `ViSEAGO::build_GO_SS` method. The Semantic Similarity (SS) between enriched GO terms are calculated using `ViSEAGO::compute_SS_distances` method which is a wrapper of functions implemented in the *[GOSemSim](https://bioconductor.org/packages/3.22/GOSemSim)* package [[4](#ref-pmid20179076)]. Here, we choose *Wang* method based on the topology of GO graph structure. The built object `myGOs` contains all informations of enriched GO terms and the SS distances between them.

```
# create GO_SS-class object
myGOs<-ViSEAGO::build_GO_SS(
    gene2GO=myGENE2GO,
    enrich_GO_terms=BP_sResults
)
```

```
# compute Semantic Similarity (SS)
myGOs<-ViSEAGO::compute_SS_distances(
    myGOs,
    distance="Wang"
)
```

```
# display a summary
myGOs
```

```
- object class: GO_SS
- ontology: BP
- method: topGO
- summary:
PregnantvsLactate
      BP_PregnantvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7699
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_PregnantvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 199
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        Nontrivial_nodes: 8433
 VirginvsLactate
      BP_VirginvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 9583
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 152
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        Nontrivial_nodes: 8457
 VirginvsPregnant
      BP_VirginvsPregnant
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7302
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsPregnant
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 243
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        Nontrivial_nodes: 8413
 - enrichment pvalue cutoff:
        PregnantvsLactate : 0.01
        VirginvsLactate : 0.01
        VirginvsPregnant : 0.01
- enrich GOs (in at least one list): 521 GO terms of 3 conditions.
        PregnantvsLactate : 199 terms
        VirginvsLactate : 152 terms
        VirginvsPregnant : 243 terms
- terms distances:  Wang
```

# 5 Visualization and interpretation of enriched GO terms

## 5.1 Multi Dimensional Scaling of GO terms - A preview

A Multi Dimensional Scale (MDS) plot with `ViSEAGO::MDSplot` method provides a representation of distances among a set of enriched GO terms on the two first dimensions. Some patterns could appear at this time and could be investigated in the interactive mode. The plot could also be printed in a png file.

```
# MDSplot
ViSEAGO::MDSplot(myGOs)
```

![mds1](data:image/png;base64...)

## 5.2 Clustering heatmap of GO terms

To fully explore the results of this functional analysis, a hierarchical clustering using `ViSEAGO::GOterms_heatmap` is performed based on `Wang` SS distance between enriched GO terms and `ward.D2` aggregation criteria.

Clusters of enriched GO terms are obtained by cutting branches off the dendrogram. Here, we choose a dynamic branch cutting method based on the shape of clusters using *[dynamicTreeCut](https://CRAN.R-project.org/package%3DdynamicTreeCut)* [[5](#ref-pmid18024473),[6](#ref-dynamicTreeCut)]. Here, we use parameters to detect small clusters in agreement with the dendrogram structure.

Enriched GO terms are ranked in a dendrogram and colored depending on their cluster assignation. Additional illustrations are displayed: the GO description of terms (trimmed if more than 50 characters), a heatmap of -log10(pvalue) of enrichment test for each comparison, and optionally the Information Content (IC). The IC of a GO term is computed by the negative log probability of the term occurring in the GO annotations database of the studied species. A rarely used term contains a greater amount of IC. The illustration is displayed with `ViSEAGO::show_heatmap` method.

```
# Create GOterms heatmap
Wang_clusters_wardD2<-ViSEAGO::GOterms_heatmap(
    myGOs,
    showIC=FALSE,
    showGOlabels =FALSE,
    GO.tree=list(
        tree=list(
            distance="Wang",
            aggreg.method="ward.D2"
        ),
        cut=list(
            dynamic=list(
                pamStage=TRUE,
                pamRespectsDendro=TRUE,
                deepSplit=2,
                minClusterSize =2
            )
        )
    ),
    samples.tree=NULL
)
```

```
# display the heatmap
ViSEAGO::show_heatmap(
    Wang_clusters_wardD2,
    "GOterms"
)
```

![GOtermsheatmap](data:image/png;base64...)

A table of enriched GO terms in at least one of the comparison is displayed in interactive mode, or printed in a file using `ViSEAGO::show_table` method. The columns GO cluster number and IC value are added to the previous table of enriched terms table.
The printed table contains for each enriched GO terms, additional columns including the list of significant genes and frequency (ratio between the number of significant genes and number of background genes in a specific GO tag) evaluated by comparison.

```
# display table
ViSEAGO::show_table(
    Wang_clusters_wardD2
)
```

![bioconductor_table2](data:image/png;base64...)

NB: For this vignette, this illustration is not interactive.

## 5.3 Multi Dimensional Scaling of GO terms

We also display a colored Multi Dimensional Scale (MDS) plot showing the overlay of GO terms clusters from `Wang_clusters_wardD2` object with `ViSEAGO::MDSplot` method. It is a way to check the coherence of GO terms clusters on the MDS plot.

```
# colored MDSplot
ViSEAGO::MDSplot(
    Wang_clusters_wardD2,
    "GOterms"
)
```

![mds2](data:image/png;base64...)

# 6 Visualization and interpretation of GO clusters

This part is dedicated to explore relationships between clusters of GO terms defined by the last hierarchical clustering with `ViSEAGO::GOterms_heatmap` method. This analysis should be conducted if the number of clusters of GO terms is large enough and therefore difficult to investigate.

## 6.1 Compute semantic similarity between GO clusters

A Semantic Similarity (SS) between clusters of GO terms, previously defined, is calculated using `ViSEAGO::compute_SS_distances` method. Here, we choose the Best-Match Average, also known as *BMA* method implemented in the *[GOSemSim](https://bioconductor.org/packages/3.22/GOSemSim)* package [[4](#ref-pmid20179076)]. It calculates the average of all maximum similarities between two clusters of GO terms.

A colored Multi Dimensional Scale (MDS) plot with `ViSEAGO::MDSplot` method provides a representation of distances between the clusters of GO terms. Each circle represents a cluster of GO terms and its size depends on the number of GO terms that it contains. Clusters of GO terms that are close should share a functional coherence.

```
# calculate semantic similarites between clusters of GO terms
Wang_clusters_wardD2<-ViSEAGO::compute_SS_distances(
    Wang_clusters_wardD2,
    distance="BMA"
)
```

```
# MDSplot
ViSEAGO::MDSplot(
    Wang_clusters_wardD2,
    "GOclusters"
)
```

![mds3](data:image/png;base64...)

## 6.2 GO clusters semantic similarities heatmap

A new hierarchical clustering using `ViSEAGO::GOclusters_heatmap` is performed based on the `BMA` SS distance between the clusters of GO terms, previously computed, and the `ward.D2` aggregation criteria.

Clusters of GO terms are ranked in a dendrogram and colored depending on their cluster assignation. Additional illustrations are displayed: the definition of the cluster of GO terms corresponds to the first common GO term ancestor followed by the cluster label in brackets, and the heatmap of GO terms count in the corresponding cluster. The illustration is displayed with `ViSEAGO::show_heatmap` method.

```
# GOclusters heatmap
Wang_clusters_wardD2<-ViSEAGO::GOclusters_heatmap(
    Wang_clusters_wardD2,
    tree=list(
        distance="BMA",
        aggreg.method="ward.D2"
    )
)
```

```
# display the heatmap
ViSEAGO::show_heatmap(
    Wang_clusters_wardD2,
    "GOclusters"
)
```

![BMA](data:image/png;base64...)

An history of the enrichment functional analysis is reported.

```
# display a summary
Wang_clusters_wardD2
```

```
- object class: GO_clusters
- ontology: BP
- method: topGO
- summary:
PregnantvsLactate
      BP_PregnantvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7699
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_PregnantvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 199
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        Nontrivial_nodes: 8433
 VirginvsLactate
      BP_VirginvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 9583
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsLactate
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 152
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        Nontrivial_nodes: 8457
 VirginvsPregnant
      BP_VirginvsPregnant
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7302
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsPregnant
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 243
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        Nontrivial_nodes: 8413
 - enrichment pvalue cutoff:
        PregnantvsLactate : 0.01
        VirginvsLactate : 0.01
        VirginvsPregnant : 0.01
- enrich GOs (in at least one list): 521 GO terms of 3 conditions.
        PregnantvsLactate : 199 terms
        VirginvsLactate : 152 terms
        VirginvsPregnant : 243 terms
- terms distances:  Wang
- clusters distances: BMA
- Heatmap:
          * GOterms: TRUE
                    - GO.tree:
                              tree.distance: Wang
                              tree.aggreg.method: ward.D2
                              cut.dynamic.pamStage: TRUE
                              cut.dynamic.pamRespectsDendro: TRUE
                              cut.dynamic.deepSplit: 2
                              cut.dynamic.minClusterSize: 2
                              number of clusters: 62
                              clusters min size: 2
                              clusters mean size: 8
                              clusters max size: 32
                   - sample.tree: FALSE
          * GOclusters: TRUE
                       - tree:
                              distance: BMA
                              aggreg.method: ward.D2
```

# 7 Conclusion

A functional Gene Ontology (GO) enrichment analysis was performed using *[ViSEAGO](https://bioconductor.org/packages/3.22/ViSEAGO)* package, from differentially expressed (DE) genes in luminal cells of the mouse mammary gland. It facilitates the interpretation of biological processes involved between these three comparisons of virgin, pregnant and lactating mice. It provides both a synthetic and detailed view using interactive functionalities respecting the GO graph structure and ensuring functional coherence.

# Information session

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
[1] ViSEAGO_1.24.0   BiocStyle_2.38.0

loaded via a namespace (and not attached):
  [1] DBI_1.2.3              bitops_1.0-9           gridExtra_2.3
  [4] httr2_1.2.1            biomaRt_2.66.0         rlang_1.1.6
  [7] magrittr_2.0.4         clue_0.3-66            GetoptLong_1.0.5
 [10] matrixStats_1.5.0      compiler_4.5.1         RSQLite_2.4.3
 [13] png_0.1-8              vctrs_0.6.5            stringr_1.5.2
 [16] shape_1.4.6.1          pkgconfig_2.0.3        crayon_1.5.3
 [19] fastmap_1.2.0          dbplyr_2.5.1           XVector_0.50.0
 [22] ca_0.71.1              rmarkdown_2.30         graph_1.88.0
 [25] UpSetR_1.4.0           purrr_1.1.0            bit_4.6.0
 [28] xfun_0.53              cachem_1.1.0           jsonlite_2.0.0
 [31] progress_1.2.3         blob_1.2.4             BiocParallel_1.44.0
 [34] cluster_2.1.8.1        parallel_4.5.1         prettyunits_1.2.0
 [37] R6_2.6.1               bslib_0.9.0            stringi_1.8.7
 [40] RColorBrewer_1.1-3     topGO_2.62.0           jquerylib_0.1.4
 [43] GOSemSim_2.36.0        assertthat_0.2.1       Rcpp_1.1.0
 [46] Seqinfo_1.0.0          bookdown_0.45          iterators_1.0.14
 [49] knitr_1.50             R.utils_2.13.0         IRanges_2.44.0
 [52] igraph_2.2.1           Matrix_1.7-4           tidyselect_1.2.1
 [55] dichromat_2.0-0.1      yaml_2.3.10            viridis_0.6.5
 [58] TSP_1.2-5              doParallel_1.0.17      codetools_0.2-20
 [61] curl_7.0.0             plyr_1.8.9             lattice_0.22-7
 [64] tibble_3.3.0           Biobase_2.70.0         KEGGREST_1.50.0
 [67] S7_0.2.0               evaluate_1.0.5         AnnotationForge_1.52.0
 [70] heatmaply_1.6.0        BiocFileCache_3.0.0    circlize_0.4.16
 [73] Biostrings_2.78.0      pillar_1.11.1          BiocManager_1.30.26
 [76] filelock_1.0.3         DiagrammeR_1.0.11      DT_0.34.0
 [79] foreach_1.5.2          stats4_4.5.1           plotly_4.11.0
 [82] generics_0.1.4         RCurl_1.98-1.17        S4Vectors_0.48.0
 [85] hms_1.1.4              ggplot2_4.0.0          scales_1.4.0
 [88] glue_1.8.0             lazyeval_0.2.2         tools_4.5.1
 [91] dendextend_1.19.1      data.table_1.17.8      SparseM_1.84-2
 [94] webshot_0.5.5          fgsea_1.36.0           registry_0.5-1
 [97] visNetwork_2.1.4       fs_1.6.6               XML_3.99-0.19
[100] fastmatch_1.1-6        cowplot_1.2.0          grid_4.5.1
[103] tidyr_1.3.1            seriation_1.5.8        colorspace_2.1-2
[106] AnnotationDbi_1.72.0   cli_3.6.5              rappdirs_0.3.3
[109] viridisLite_0.4.2      ComplexHeatmap_2.26.0  dplyr_1.1.4
[112] gtable_0.3.6           dynamicTreeCut_1.63-1  R.methodsS3_1.8.2
[115] yulab.utils_0.2.1      sass_0.4.10            digest_0.6.37
[118] BiocGenerics_0.56.0    htmlwidgets_1.6.4      rjson_0.2.23
[121] farver_2.1.2           memoise_2.0.1          htmltools_0.5.8.1
[124] R.oo_1.27.1            lifecycle_1.0.4        httr_1.4.7
[127] GlobalOptions_0.1.2    GO.db_3.22.0           bit64_4.6.0-1
```

# References

1. Fu NY, Rios AC, Pal B, Soetanto R, Lun AT, Liu K, et al. EGF-mediated induction of Mcl-1 at the switch to lactation is essential for alveolar cell survival. Nat Cell Biol. 2015;17:365–75.

2. Chen Y, McCarthy D, Ritchie M, Robinson M, Smyth GK. EdgeRUsersGuide.

3. Lund SP, Nettleton D, McCarthy DJ, Smyth GK. Detecting differential expression in RNA-sequence data using quasi-likelihood with shrunken dispersion estimates. Stat Appl Genet Mol Biol. 2012;11.

4. Yu G, Li F, Qin Y, Bo X, Wu Y, Wang S. GOSemSim: an R package for measuring semantic similarity among GO terms and gene products. Bioinformatics. 2010;26:976–8.

5. Langfelder P, Zhang B, Horvath S. Defining clusters from a hierarchical cluster tree: the Dynamic Tree Cut package for R. Bioinformatics. 2008;24:719–20.

6. Langfelder P, Zhang B, Steve Horvath. DynamicTreeCut: Methods for detection of clusters in hierarchical clustering dendrograms [Internet]. 2016. [https://CRAN.R-project.org/package=dynamicTreeCut](https://CRAN.R-project.org/package%3DdynamicTreeCut)