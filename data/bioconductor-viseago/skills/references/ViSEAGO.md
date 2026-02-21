# An overview of ViSEAGO: Visualisation, Semantic similarity, Enrichment Analysis of Gene Ontology.

Aurelien Brionne1, Amelie Juanchich1 and Christelle Hennequet-Antier1

1Institut national de recherche pour l'agriculture, l'alimentation et l'environnement (INRAE)

#### 30 October, 2025

# Contents

* [Introduction](#introduction)
* [package diagram](#package-diagram)
* [Installation](#installation)
* [1 Genes of interest](#genes-of-interest)
  + [topGO](#topgo)
  + [fgsea](#fgsea)
* [2 GO annotation of genes](#go-annotation-of-genes)
* [3 Functionnal GO enrichment](#functionnal-go-enrichment)
  + [3.1 GO enrichment tests](#go-enrichment-tests)
    - [topGO](#topgo-1)
    - [fgsea](#fgsea-1)
  + [3.2 Combine enriched GO terms](#combine-enriched-go-terms)
  + [3.3 Graphs of GO enrichment tests](#graphs-of-go-enrichment-tests)
* [4 GO terms Semantic Similarity](#go-terms-semantic-similarity)
* [5 Visualization and interpretation of enriched GO terms](#visualization-and-interpretation-of-enriched-go-terms)
  + [5.1 Multi Dimensional Scaling of GO terms - A preview](#multi-dimensional-scaling-of-go-terms---a-preview)
  + [5.2 Clustering heatmap of GO terms](#clustering-heatmap-of-go-terms)
  + [5.3 Multi Dimensional Scaling of GO terms](#multi-dimensional-scaling-of-go-terms)
* [6 Visualization and interpretation of GO clusters](#visualization-and-interpretation-of-go-clusters)
  + [6.1 Compute semantic similiarity between GO clusters](#compute-semantic-similiarity-between-go-clusters)
  + [6.2 GO clusters semantic similarities heatmap](#go-clusters-semantic-similarities-heatmap)
* [7 Conclusion](#conclusion)
* [Information session](#information-session)
* [References](#references)

# Introduction

The main objective of ViSEAGO package is to carry out a data mining of biological functions and establish links between genes involved in the study. We developed ViSEAGO in R to facilitate functional Gene Ontology (GO) analysis of complex experimental design with multiple comparisons of interest. It allows to study large-scale datasets together and visualize GO profiles to capture biological knowledge. The acronym stands for three major concepts of the analysis: **Vi**sualization, **S**emantic similarity and **E**nrichment **A**nalysis of **G**ene **O**ntology. It provides access to the last current GO annotations, which are retrieved from one of NCBI EntrezGene, Ensembl or Uniprot databases for several species. Using available R packages and novel developments, ViSEAGO extends classical functional GO analysis to focus on functional coherence by aggregating closely related biological themes while studying multiple datasets at once. It provides both a synthetic and detailed view using interactive functionalities respecting the GO graph structure and ensuring functional coherence supplied by semantic similarity. ViSEAGO has been successfully applied on several datasets from different species with a variety of biological questions. Results can be easily shared between bioinformaticians and biologists, enhancing reporting capabilities while maintaining reproducibility.

# package diagram

ViSEAGO is like a workflow with input lists of genes and associated genomic resources in order to perform enrichment tests, followed by a clustering of GO terms based on theirs semantic similarity. Most of outputs (tables and graphs) could be visualized in static or interactive mode.

![workflow](data:image/png;base64...)

# Installation

Firtsly, install the *[ViSEAGO](https://bioconductor.org/packages/3.22/ViSEAGO)* R package from [Bioconductor](https://www.bioconductor.org/), or [ForgeMIA](https://forgemia.inra.fr/umr-boa/viseago) gitlab.

```
# Install ViSEAGO package from Bioconductor
BiocManager::install("ViSEAGO")
```

NB: This vignette is not runnable and provide a pseudo-code to illustrate ViSEAGO package capabilities.

# 1 Genes of interest

## topGO

Firstly, you need to provide the gene *background* (= expressed genes) and *selection* files.

```
# load genes background
background<-scan(
    "background.txt",
    quiet=TRUE,
    what=""
)

# load gene selection
selection<-scan(
    "selection.txt",
    quiet=TRUE,
    what=""
)
```

## fgsea

Or a table with gene identifiers and statistical value to use for ranking.

```
# load gene identifiers column 1) and corresponding statistical value (column 2)
table<-data.table::fread("table.txt")

# rank gene identifiers according statistical value
data.table::setorder(table,value)
```

# 2 GO annotation of genes

The [Gene Ontology](http://www.geneontology.org) (GO) is a community-based bioinformatics resource that supplies information about gene product function using ontologies to represent biological knowledge [[1](#ref-pmid25428369)].

Currently, the 3 predominant genomic ressources are [EntrezGene](https://www.ncbi.nlm.nih.gov/gene) [[2](#ref-pmid25355515)], [Ensembl](http://ensemblgenomes.org/) [[3](#ref-pmid27899575)], and [Uniprot-GOA](http://www.ebi.ac.uk/GOA) [[4](#ref-pmid25378336)].
Furthermore, an easy access with the R langage [[5](#ref-R)] to some genomic GO annotations from EntrezGene is available using [Bioconductor](https://www.bioconductor.org/) [[6](#ref-pmid25633503)] *org.xx.eg.db* databases.
However, there are important differences between supported species, and corresponding genes knowledge according to database used. This has necessary an impact on GO annotations and enrichment and downstream analyses.

More precisely, since December 2006, the GOA and [Ensembl Compara](http://www.ebi.ac.uk/GOA/compara_go_annotations) teams have used the gene orthology data obtained from Ensembl Compara to project GO terms from a source species onto one or more target species. For this pipeline, only one to one and apparent one to one orthologies are used, and only manually annotated GO terms with an experimental evidence type of either EXP, IDA, IEP, IGI, IMP or IPI are projected. GO annotations created using this technique receive the evidence code ‘IEA’ (Inferred from Electronic Annotation).

A similar approach for [EntrezGene](https://www.ncbi.nlm.nih.gov/gene) database and with the [orthologs\_groups](https://www.ncbi.nlm.nih.gov/genome/annotation_euk/process/) [[7](#ref-pmid24063302)] from the NCBI annotation pipeline.
This method is available using the `ViSEAGO::annotate(id,EntrezGene,ortholog = TRUE)`.

The easy access to GO annotations for all the availables species from these databases are provided by:

```
# connect to Bioconductor
Bioconductor<-ViSEAGO::Bioconductor2GO()

# connect to EntrezGene
EntrezGene<-ViSEAGO::EntrezGene2GO()

# connect to Ensembl
Ensembl<-ViSEAGO::Ensembl2GO()

# connect to Uniprot-GOA
Uniprot<-ViSEAGO::Uniprot2GO()

# connect to Custom file
Custom<-ViSEAGO::Custom2GO(system.file("extdata/customfile.txt",package = "ViSEAGO"))
```

In order to know if your target species is supported by the database, we can display the available organisms in an interactive table using `ViSEAGO::available_organisms` method. The **organism key identifiant** is always displayed in the **first column** of the table.

```
# Display table of available organisms with Bioconductor
ViSEAGO::available_organisms(Bioconductor)

# Display table of available organisms with EntrezGene
ViSEAGO::available_organisms(EntrezGene)

# Display table of available organisms with Ensembl
ViSEAGO::available_organisms(Ensembl)

# Display table of available organisms with Uniprot
ViSEAGO::available_organisms(Uniprot)

# Display table of available organisms with Custom
ViSEAGO::available_organisms(Custom)
```

At this step, we need to provide the **organism key identifiant** based on the genomic ressource used (Bioconductor, EntrezGene, Ensembl, or Uniprot), in order to extract and store the species GO annotations using `ViSEAGO::annotate()` method.

```
# load GO annotations from Bioconductor
myGENE2GO<-ViSEAGO::annotate(
    "bioconductor_id",
    Bioconductor
)

# load GO annotations from EntrezGene
myGENE2GO<-ViSEAGO::annotate(
    "EntrezGene_id",
    EntrezGene
)

# load GO annotations from EntrezGene
# with the add of GO annotations from orthologs genes (see above)
myGENE2GO<-ViSEAGO::annotate(
    "EntrezGene_id",
    EntrezGene,
    ortholog = TRUE
)

# load GO annotations from Ensembl
myGENE2GO<-ViSEAGO::annotate(
    "Ensembl_id",
    Ensembl
)

# load GO annotations from Uniprot
myGENE2GO<-ViSEAGO::annotate(
    "Uniprot_id",
    Uniprot
)

# load GO annotations from Custom
myGENE2GO<-ViSEAGO::annotate(
    "Custom_id",
    Custom
)
```

# 3 Functionnal GO enrichment

## 3.1 GO enrichment tests

### topGO

The GO terms enrichment tests can be performed with the *[topGO](https://bioconductor.org/packages/3.22/topGO)* package [[8](#ref-pmid16606683)], which support several algorithms that improve GO group scoring using the underlying GO graph topology.

First, we create a `topGOdata` object, using `ViSEAGO::create_topGOdata` method, with inputs as: genes selection, genes background, GO terms category used (*MF*, *BP*, or *CC*), and minimum of annotated genes by GO terms (nodeSize).

```
# create topGOdata for BP
BP<-ViSEAGO::create_topGOdata(
    geneSel=selection,
    allGenes=background,
    gene2GO=myGENE2GO,
    ont="BP",
    nodeSize=5
)
```

Now, we perform the GO enrichment tests for *BP* category with Fisher’s exact test with one of the four available algorithms (*classic*, *elim*, *weight*, and *weight01*) using `topGO::runTest` method.

```
# perform TopGO test using clasic algorithm
classic<-topGO::runTest(
    BP,
    algorithm ="classic",
    statistic = "fisher"
)
```

### fgsea

The GO terms enrichment tests can be performed with the *[fgsea](https://bioconductor.org/packages/3.22/fgsea)* package [[9](#ref-fgsea)], with inputs as: preranked gene identifiers with statistical values , GO terms category used (*MF*, *BP*, or *CC*), fgsea algorithm, and fgsea parameters to use.

```
# perform fgseaMultilevel tests
BP<-ViSEAGO::runfgsea(
    geneSel=table,
    ont="BP",
    gene2GO=myGENE2GO,
    method ="fgseaMultilevel",
    params = list(
        scoreType = "pos",
         minSize=5
    )
)
```

## 3.2 Combine enriched GO terms

We combine results of enrichment tests into an object using `ViSEAGO::merge_enrich_terms` method. A table of enriched GO terms in at least one comparison is displayed in interactive mode, or printed in a file using `ViSEAGO::show_table` method. The printed table contains for each enriched GO terms, additional columns including the list of significant genes and frequency (ratio of number of significant genes to number of background genes) evaluated by comparison.

```
# merge results from topGO
BP_sResults<-ViSEAGO::merge_enrich_terms(
    Input=list(
        condition=c("BP","classic")
    )
)

# merge results from fgsea
BP_sResults<-ViSEAGO::merge_enrich_terms(
    Input=list(
        condition="BP"
    )
)
```

```
# display the merged table
ViSEAGO::show_table(BP_sResults)

# print the merged table in a file
ViSEAGO::show_table(
    BP_sResults,
    "BP_sResults.xls"
)
```

## 3.3 Graphs of GO enrichment tests

Several graphs summarize important features. An interactive barchart showing the number of GO terms enriched or not in each comparison, using `ViSEAGO::GOcount` method. Intersections of lists of enriched GO terms between comparisons are displayed in an Upset plot using `ViSEAGO::Upset` method.

```
# count significant (or not) pvalues by condition
ViSEAGO::GOcount(BP_sResults)
```

```
# display interactions
ViSEAGO::Upset(
    BP_sResults,
    file="OLexport.xls"
)
```

# 4 GO terms Semantic Similarity

GO annotations of genes created at a previous step and enriched GO terms are combined using `ViSEAGO::build_GO_SS` method. The Semantic Similarity (SS) between enriched GO terms are calculated using `ViSEAGO::compute_SS_distances` method which is a wrapper of functions implemented in the *[GOSemSim](https://bioconductor.org/packages/3.22/GOSemSim)* package [[10](#ref-pmid20179076)]. Among the SS algorithms between GO terms, 4 of them use information content (IC) of a GO term which is computed by the negative log probability of the term occurring in GO corpus. A rarely used term contains a greater amount of information. These IC-based mehods are *Resnik*, *Lin*, *Rel*, and *Jiang*. A Graph-based method, using the topology of GO graph structure to compute semantic similarity is also available with the *Wang* method. The built object `myGOs` contains all informations of enriched GO terms and computed SS distances between them.

```
# initialyse
myGOs<-ViSEAGO::build_GO_SS(
    gene2GO=myGENE2GO,
    enrich_GO_terms=BP_sResults
)

# compute all available Semantic Similarity (SS) measures
myGOs<-ViSEAGO::compute_SS_distances(
    myGOs,
    distance="Wang"
)
```

# 5 Visualization and interpretation of enriched GO terms

## 5.1 Multi Dimensional Scaling of GO terms - A preview

A Multi Dimensional Scale (MDS) plot with `ViSEAGO::MDSplot` method provides a representation of distances among a set of enriched GO terms on the two first dimensions. Some patterns could appear at this time and could be investigated in an interactive mode. The plot could be also printed in a png file.

```
# display MDSplot
ViSEAGO::MDSplot(myGOs)

# print MDSplot
ViSEAGO::MDSplot(
    myGOs,
    file="mdsplot1.png"
)
```

## 5.2 Clustering heatmap of GO terms

To fully explore the results of this functional analysis, a hierarchical clustering method using `ViSEAGO::GOterms_heatmap` is performed based on one of SS distances (i.e `Wang`) between the enriched GO terms and a chosen aggregation criteria (i.e `ward.D2`).

Clusters of enriched GO terms are obtained by cutting branches off the dendrogram. Here, we choose a dynamic branch cutting method based on the shape of clusters using *[dynamicTreeCut](https://CRAN.R-project.org/package%3DdynamicTreeCut)* [[11](#ref-pmid18024473),[12](#ref-dynamicTreeCut)]. It builds clusters in a bottom top manner in two steps.
In step 1, branches that satisfy specific criteria for being clusters, based on the merging information of the dendrogram, are detected.
A simple control of the relative sensitivity to cluster splitting is provided in the parameter *deepSplit* (The higher the value, the more and smaller clusters will be produced), and the minimum cluster size with *minClusterSize*.
In step 2, all previously unassigned objects are tested for sufficient proximity to clusters detected in the first step using a modified Partitioning Around Medoids (PAM). If the closest cluster is close enough in a precise sense that we define below, the object is assigned to that cluster. The PAM stage will be performed using *pamStage=TRUE* parameter, and respect the dendrogram using *pamRespectsDendro=TRUE* parameter, in the sense an object can be PAM-assigned only to clusters that lie below it on the branch that the object is merged into.

Enriched GO terms are ranked in a dendrogram as a result of a hierarchical clustering and colored depending on their cluster assignation. Additional illustrations are displayed: the GO description of GO terms (trimmed if more than 50 characters), a heatmap of -log10(pvalue) of enrichment test for each comparison, and optionally the Information Content (IC). The illustration is displayed with `ViSEAGO::show_heatmap` method.

```
# GOterms heatmap with the default parameters
Wang_clusters_wardD2<-ViSEAGO::GOterms_heatmap(
    myGOs,
    showIC=TRUE,
    showGOlabels=TRUE,
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
# Display the clusters-heatmap
ViSEAGO::show_heatmap(
    Wang_clusters_wardD2,
    "GOterms"
)

# print the clusters-heatmap
ViSEAGO::show_heatmap(
    Wang_clusters_wardD2,
    "GOterms",
    "cluster_heatmap_Wang_wardD2.png"
)
```

A table of enriched GO terms in at least one of the comparison is displayed in interactive mode, or printed in a file using `ViSEAGO::show_table` method. The columns GO cluster number and IC value are added to the previous table of enriched terms table. The printed table contains for each enriched GO terms, additional columns including the list of significant genes and frequency (ratio between the number of significant genes and number of background genes in a specific GO tag) evaluated by comparison.

```
# Display the clusters-heatmap table
ViSEAGO::show_table(Wang_clusters_wardD2)

# Print the clusters-heatmap table
ViSEAGO::show_table(
    Wang_clusters_wardD2,
    "cluster_heatmap_Wang_wardD2.xls"
)
```

## 5.3 Multi Dimensional Scaling of GO terms

We also display a Multi Dimensional Scale (MDS) plot with the overlay of GO terms clusters from `Wang_clusters_wardD2` object with `ViSEAGO::MDSplot` method. It is a way to check the coherence of GO terms clusters on the MDS plot.

```
# display colored MDSplot
ViSEAGO::MDSplot(
    Wang_clusters_wardD2,
    "GOterms"
)

# print colored MDSplot
ViSEAGO::MDSplot(
    Wang_clusters_wardD2,
    "GOterms",
    file="mdsplot2.png"
)
```

# 6 Visualization and interpretation of GO clusters

This part is dedicated to explore relationships between clusters of GO terms defined by the last hierarchical clustering with `ViSEAGO::GOterms_heatmap` method. This analysis should be conducted if the number of clusters of GO terms is large enough and therefore difficult to investigate.

## 6.1 Compute semantic similiarity between GO clusters

A Semantic Similarity (SS) between clusters of GO terms, previously defined, are calculated using `ViSEAGO::compute_SS_distances` method.
The availables SS algorithms between GO terms clusters, implemented in the *[GOSemSim](https://bioconductor.org/packages/3.22/GOSemSim)* package [[10](#ref-pmid20179076)], could be *max*, *average*, *rcmax*, or *BMA*.

A colored Multi Dimensional Scale (MDS) plot with `ViSEAGO::MDSplot` method provides a representation of distances between the clusters of GO terms. Each circle represents a cluster of GO terms and its size depends on the number of GO terms that it contains. Clusters of GO terms that are close should share a functional coherence.

```
# calculate semantic similarites between clusters of GO terms
Wang_clusters_wardD2<-ViSEAGO::compute_SS_distances(
    Wang_clusters_wardD2,
    distance=c("max", "avg","rcmax", "BMA")
)
```

```
# build and highlight in an interactive MDSplot grouped clusters for one distance object
ViSEAGO::MDSplot(
    Wang_clusters_wardD2,
    "GOclusters"
)

# build and highlight in MDSplot grouped clusters for one distance object
ViSEAGO::MDSplot(
    Wang_clusters_wardD2,
    "GOclusters",
    file="mdsplot3.png"
)
```

## 6.2 GO clusters semantic similarities heatmap

A new hierarchical clustering using `ViSEAGO::GOclusters_heatmap` is performed based on one of the SS distance (i.e. `BMA`) between the clusters of GO terms, previously computed, and a chosen aggregation criteria (i.e `ward.D2`).

Clusters of GO terms are ranked in a dendrogram and branches are colored depending on the cluster assignation. Additional illustrations are displayed: definition of the cluster of GO terms corresponds to the first common GO term ancestor followed by the cluster label in brackets, and heatmap of GO terms count from the corresponding cluster. The illustration is displayed with `ViSEAGO::show_heatmap` method.

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
# sisplay the GOClusters heatmap
ViSEAGO::show_heatmap(
    Wang_clusters_wardD2,
    "GOclusters"
)

# print the GOClusters heatmap in a file
ViSEAGO::show_heatmap(
    Wang_clusters_wardD2,
    "GOclusters",
    "Wang_clusters_wardD2_heatmap_groups.png"
)
```

# 7 Conclusion

A complete functional Gene Ontology (GO) enrichment analysis can be performed using *[ViSEAGO](https://bioconductor.org/packages/3.22/ViSEAGO)* package. It facilitates the interpretation of biological processes, functions, or cellular component involved in the study. It provides both a synthetic and detailed view using interactive functionalities respecting GO graph structure and ensuring functional coherence.
Also, comparisons of enrichment can be made on large datasets and for complex experimental designs, such as explained in mouse mammary gland status comparison example (see `utils::vignette("2_mouse_bionconductor",package ="ViSEAGO")`).
Moreover, we can explore the effect of the GO semantic similarity algorithms on the tree structure, such as illustrate in the clustering comparions example (see`vignette("3_SS_choice",package ="ViSEAGO")`).

# Information session

```
               _
platform       x86_64-pc-linux-gnu
arch           x86_64
os             linux-gnu
system         x86_64, linux-gnu
status         Patched
major          4
minor          5.1
year           2025
month          08
day            23
svn rev        88802
language       R
version.string R version 4.5.1 Patched (2025-08-23 r88802)
nickname       Great Square Root
```

# References

1. Blake JA, Christie KR, Dolan ME, Drabkin HJ, Hill DP, Ni L, et al. Gene Ontology Consortium: going forward. Nucleic Acids Res. 2015;43:D1049–1056.

2. Brown GR, Hem V, Katz KS, Ovetsky M, Wallin C, Ermolaeva O, et al. Gene: a gene-centered information resource at NCBI. Nucleic Acids Res. 2015;43:36–42.

3. Aken BL, Achuthan P, Akanni W, Amode MR, Bernsdorff F, Bhai J, et al. Ensembl 2017. Nucleic Acids Res. 2017;45:D635–42.

4. Huntley RP, Sawford T, Mutowo-Meullenet P, Shypitsyna A, Bonilla C, Martin MJ, et al. The GOA database: gene Ontology annotation updates for 2015. Nucleic Acids Res. 2015;43:D1057–1063.

5. R Core Team. R: A language and environment for statistical computing [Internet]. Vienna, Austria: R Foundation for Statistical Computing; 2017. <https://www.R-project.org/>

6. Huber W, Carey VJ, Gentleman R, Anders S, Carlson M, Carvalho BS, et al. Orchestrating high-throughput genomic analysis with Bioconductor. Nat Methods. 2015;12:115–21.

7. Fong JH, Murphy TD, Pruitt KD. Comparison of RefSeq protein-coding regions in human and vertebrate genomes. BMC Genomics. 2013;14:654.

8. Alexa A, Rahnenfuhrer J, Lengauer T. Improved scoring of functional groups from gene expression data by decorrelating GO graph structure. Bioinformatics. 2006;22:1600–7.

9. Korotkevich G, Sukhov V, Sergushichev A. Fast gene set enrichment analysis. bioRxiv [Internet]. Cold Spring Harbor Labs Journals; 2019; <https://doi.org/10.1101/060012>

10. Yu G, Li F, Qin Y, Bo X, Wu Y, Wang S. GOSemSim: an R package for measuring semantic similarity among GO terms and gene products. Bioinformatics. 2010;26:976–8.

11. Langfelder P, Zhang B, Horvath S. Defining clusters from a hierarchical cluster tree: the Dynamic Tree Cut package for R. Bioinformatics. 2008;24:719–20.

12. Langfelder P, Zhang B, Steve Horvath. DynamicTreeCut: Methods for detection of clusters in hierarchical clustering dendrograms [Internet]. 2016. [https://CRAN.R-project.org/package=dynamicTreeCut](https://CRAN.R-project.org/package%3DdynamicTreeCut)