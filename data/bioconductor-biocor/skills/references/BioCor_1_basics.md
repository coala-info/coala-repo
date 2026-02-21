Code

* Show All Code
* Hide All Code

# About BioCor

Lluís Revilla1\*, Juan José Lozano2 and Pau Sancho-Bru1

1August Pi i Sunyer Biomedical Research Institute (IDIBAPS); Liver Unit, Hospital Clinic
2Centro de Investigación Biomédica en Red de Enfermedades Hepaticas y Digestivas (CIBEREHD); Barcelona, Spain

\*lrevilla@clinic.cat

#### 29 October 2025

#### Abstract

Describes the background of the package, important functions defined in the package and some of the applications and usages, including the integration with other packages and analysis, and comparisons with related packages. Some frequent or important questions about the package are answered at the end of the document. For more advanced usage you can look at the other vignette.

#### Package

BioCor 1.34.0

# 1 Introduction

Methods to find similarities have been developed for several purposes, being Jaccard and Dice similarities the most known. In bioinformatics much of the research on the topic is centered around [Gene Ontologies](https://www.geneontology.org/) because they provide controlled vocabularies, as part of their mission:

> The mission of the GO Consortium is to develop an up-to-date, comprehensive, computational model of biological systems, from the molecular level to larger pathways, cellular and organism-level systems.

However, there is another resource of similarities between genes: metabolic pathways. Metabolic pathways describe the relationship between genes, proteins, lipids and other elements of the cells. A pathway describes, to some extent, the function in which it is involved in the cell. There exists several databases about which gene belong to which pathway. Together with pathways, gene sets related to a function or to a phenotype are a source of information of the genes function. With this package we provide the methods to calculate functional similarities based on this information.

Here we provides functions to calculate *functional similarities distances* for pathways, gene sets, genes and clusters of genes. The name BioCor stands from biological correlation, shortened to BioCor, because as said we look if some genes are in the same pathways or gene sets as other genes.

BioCor is different from *[GeneOverlap](https://bioconductor.org/packages/3.22/GeneOverlap)* because here we use the Dice index instead of the Jaccard index (although we provide a function to change from one to the other, see [this section](#D2J))and that package only allows to compare pathways but not genes or groups of genes. But *[GeneOverlap](https://bioconductor.org/packages/3.22/GeneOverlap)* provides some functionalities to plot the similarity scores and provides the associated p-value to the comparison of pathways.

The development of this package aimed initially to improve clustering of genes by functionality in weighted gene co-expression networks using *[WGCNA](https://CRAN.R-project.org/package%3DWGCNA)*. The package has some functions to combine similarities in order to integrate with `WGCNA`. For other uses you can check the [advanced vignette.](https://bioconductor.org/packages/3.22/BioCor/vignettes/BioCor_2_advanced.html).

# 2 Citation

You can cite the package as:

```
citation("BioCor")
```

# 3 Installation

The BioCor package is available at [Bioconductor](https://bioconductor.org) and can be downloaded and installed via BiocManager:

```
install.packages("BiocManager")
BiocManager::install("BioCor")
```

You can install the latest version of *[BioCor](https://github.com/llrs/BioCor)* from Github with:

```
library("devtools")
install_github("llrs/BioCor")
```

# 4 Using BioCor

## 4.1 Preparation

We can load the package and prepare the data for which we want to calculate the similarities:

```
library("BioCor")
## Load libraries with the data of the pathways
library("org.Hs.eg.db")
library("reactome.db")
genesKegg <- as.list(org.Hs.egPATH)
genesReact <- as.list(reactomeEXTID2PATHID)
# Remove genes and pathways which are not from human pathways
genesReact <- lapply(genesReact, function(x){
    unique(grep("R-HSA-", x, value = TRUE))
    })
genesReact <- genesReact[lengths(genesReact) >= 1]
```

To avoid having biased data it is important to have all the data about the pathways and genes associated to all pathways for the organism under study. Here we assume that we are interested in human pathways. We use this two databases KEGG and Reactome as they are easy to obtain the data. However KEGG database is no longer free for large retrievals therefore it is not longer updated in the Bioconductor annotation packages.

However, one can use any list where the names of the list are the genes and the elements of the list the pathways or groups where the gene belong. One could also read from a GMT file or use GeneSetCollections in addition or instead of those associations from a pathway database and convert it to list using:

```
library("GSEABase")
paths2Genes <- geneIds(getGmt("/path/to/file.symbol.gmt",
                 geneIdType=SymbolIdentifier()))

genes <- unlist(paths2Genes, use.names = FALSE)
pathways <- rep(names(paths2Genes), lengths(paths2Genes))
genes2paths <- split(pathways, genes) # List of genes and the gene sets
```

With `genes2paths` we have the information ready to use.

## 4.2 Pathway similarities

We can compute similarities (Dice similarity, see [question 1](#FAQ1) of FAQ) between two pathways or between several pathways and combine them, or not:

```
(paths <- sample(unique(unlist(genesReact)), 2))
## [1] "R-HSA-2142700" "R-HSA-380270"
pathSim(paths[1], paths[2], genesReact)
## [1] 0

(pathways <- sample(unique(unlist(genesReact)), 10))
##  [1] "R-HSA-8866911" "R-HSA-9824585" "R-HSA-381119"  "R-HSA-9006821"
##  [5] "R-HSA-428543"  "R-HSA-5619067" "R-HSA-75158"   "R-HSA-5620912"
##  [9] "R-HSA-6783783" "R-HSA-379716"
mpathSim(pathways, genesReact)
##               R-HSA-8866911 R-HSA-9824585 R-HSA-381119 R-HSA-9006821
## R-HSA-8866911             1             0   0.00000000             0
## R-HSA-9824585             0             1   0.00000000             0
## R-HSA-381119              0             0   1.00000000             0
## R-HSA-9006821             0             0   0.00000000             1
## R-HSA-428543              0             0   0.00000000             0
## R-HSA-5619067             0             0   0.00000000             0
## R-HSA-75158               0             0   0.00000000             0
## R-HSA-5620912             0             0   0.00000000             0
## R-HSA-6783783             0             0   0.03252033             0
## R-HSA-379716              0             0   0.00000000             0
##               R-HSA-428543 R-HSA-5619067 R-HSA-75158 R-HSA-5620912
## R-HSA-8866911            0             0           0             0
## R-HSA-9824585            0             0           0             0
## R-HSA-381119             0             0           0             0
## R-HSA-9006821            0             0           0             0
## R-HSA-428543             1             0           0             0
## R-HSA-5619067            0             1           0             0
## R-HSA-75158              0             0           1             0
## R-HSA-5620912            0             0           0             1
## R-HSA-6783783            0             0           0             0
## R-HSA-379716             0             0           0             0
##               R-HSA-6783783 R-HSA-379716
## R-HSA-8866911    0.00000000            0
## R-HSA-9824585    0.00000000            0
## R-HSA-381119     0.03252033            0
## R-HSA-9006821    0.00000000            0
## R-HSA-428543     0.00000000            0
## R-HSA-5619067    0.00000000            0
## R-HSA-75158      0.00000000            0
## R-HSA-5620912    0.00000000            0
## R-HSA-6783783    1.00000000            0
## R-HSA-379716     0.00000000            1
```

When the method to combine the similarities is set to `NULL` `mpathSim()` returns a matrix of pathway similarities, otherwise it combines the values. In the next section we can see the methods to combine pathway similarities.

### 4.2.1 Combining values

To combine values we provide a function with several methods:

```
sim <- mpathSim(pathways, genesReact)
methodsCombineScores <- c("avg", "max", "rcmax", "rcmax.avg", "BMA",
                          "reciprocal")
sapply(methodsCombineScores, BioCor::combineScores, scores = sim)
##        avg        max      rcmax  rcmax.avg        BMA reciprocal
##  0.1006504  1.0000000  1.0000000  1.0000000  1.0000000  1.0000000
```

We can also specify the method to combine the similarities in `mpathSim()`, `geneSim()`, `mgeneSim()`, `clusterSim()`, `mclusterSim()`, `clusterGeneSim()` and `mclusterGeneSim()`, argument method. By default the method is set to “max” to combine pathways (except in mpathSim where the default is to show all the pathway similarities) and “BMA” to combine similarities of genes or for cluster analysis. This function is adapted from *[GOSemSim](https://bioconductor.org/packages/3.22/GOSemSim)* package.

The function `combineScoresPar()` allows to use a parallel background (using *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)*) to combine the scores. It is recommended to use a parallel background if you calculate more than 300 gene similarities. It also have an argument in case you want to calculate the similarity scores of several sets.

## 4.3 Gene similarities

To compare the function of two genes there is the `geneSim` function and `mgeneSim` function for several comparisons. In this example we compare the genes BRCA1 and BRCA2 and NAT2, which are the genes 672, 675 and 10 respectively in ENTREZID:

```
geneSim("672", "675", genesKegg)
## [1] 0.0824295
geneSim("672", "675", genesReact)
## [1] NA

mgeneSim(c("BRCA1" = "672", "BRCA2" = "675", "NAT2" = "10"), genesKegg)
##           BRCA1       BRCA2        NAT2
## BRCA1 1.0000000 0.082429501 0.000000000
## BRCA2 0.0824295 1.000000000 0.008241758
## NAT2  0.0000000 0.008241758 1.000000000
mgeneSim(c("BRCA1" = "672", "BRCA2" = "675", "NAT2" = "10"), genesReact)
## Warning in mgeneSim(c(BRCA1 = "672", BRCA2 = "675", NAT2 = "10"), genesReact):
## Some genes are not in the list provided.
##       BRCA1    BRCA2     NAT2
## BRCA1    NA       NA       NA
## BRCA2    NA 1.000000 0.228773
## NAT2     NA 0.228773 1.000000
```

Note that for the same genes each database or list provided has different annotations, which result on different similarity scores. In this example BRCA1 has 3 and pathways in KEGG and Reactome respectively and BRCA2 has 1 and pathways in KEGG and Reactome respectively which results on different scores.

## 4.4 Gene cluster similarities

There are two methods:

* Combining all the pathways for each cluster and compare between them.
* Calculate the similarity between genes of a cluster and the other cluster.

### 4.4.1 By pathways

As explained, in this method all the pathways of a cluster are compared with all the pathways of the other cluster. If a method to combine pathways similarities is not provided, all pathway similarities are returned:

```
clusterSim(c("672", "675"), c("100", "10", "1"), genesKegg)
## [1] 0.04210526
clusterSim(c("672", "675"), c("100", "10", "1"), genesKegg, NULL)
##            00230       01100       05340 00232 00983
## 04120 0.00000000 0.000000000 0.011764706     0     0
## 03440 0.04210526 0.006908463 0.000000000     0     0
## 05200 0.00000000 0.008241758 0.005540166     0     0
## 05212 0.00000000 0.001666667 0.019047619     0     0

clusters <- list(cluster1 = c("672", "675"),
                 cluster2 = c("100", "10", "1"),
                 cluster3 = c("18", "10", "83"))
mclusterSim(clusters, genesKegg, "rcmax.avg")
##            cluster1   cluster2   cluster3
## cluster1 1.00000000 0.01587957 0.00256157
## cluster2 0.01587957 1.00000000 0.56412591
## cluster3 0.00256157 0.56412591 1.00000000
mclusterSim(clusters, genesKegg, "max")
##             cluster1   cluster2    cluster3
## cluster1 1.000000000 0.04210526 0.008241758
## cluster2 0.042105263 1.00000000 1.000000000
## cluster3 0.008241758 1.00000000 1.000000000
```

### 4.4.2 By genes

In this method first the similarities between each gene is calculated, then the similarity between each group of genes is calculated. Requiring two methods to combine values, the first one to combine pathways similarities and the second one to combine genes similarities. If only one is provided it returns the matrix of similarities of the genes of each cluster:

```
clusterGeneSim(c("672", "675"), c("100", "10", "1"), genesKegg)
## [1] 0.02605425
clusterGeneSim(c("672", "675"), c("100", "10", "1"), genesKegg, "max")
##            100          10  1
## 672 0.01176471 0.000000000 NA
## 675 0.04210526 0.008241758 NA

mclusterGeneSim(clusters, genesKegg, c("max", "rcmax.avg"))
##             cluster1   cluster2    cluster3
## cluster1 1.000000000 0.02605425 0.006181319
## cluster2 0.026054248 1.00000000 1.000000000
## cluster3 0.006181319 1.00000000 1.000000000
mclusterGeneSim(clusters, genesKegg, c("max", "max"))
##             cluster1   cluster2    cluster3
## cluster1 1.000000000 0.04210526 0.008241758
## cluster2 0.042105263 1.00000000 1.000000000
## cluster3 0.008241758 1.00000000 1.000000000
```

Note the differences between `mclusterGeneSim()` and `mclusterSim()` in the similarity values of the clusters. If we set `method = c("max", "max")` in `mclusterGeneSim()` then the similarity between the clusters is the same as `clusterSim()`.

## 4.5 Converting similarities

If needed, Jaccard similarity can be calculated from Dice similarity using `D2J()`:

```
D2J(sim)
##               R-HSA-8866911 R-HSA-9824585 R-HSA-381119 R-HSA-9006821
## R-HSA-8866911             1             0   0.00000000             0
## R-HSA-9824585             0             1   0.00000000             0
## R-HSA-381119              0             0   1.00000000             0
## R-HSA-9006821             0             0   0.00000000             1
## R-HSA-428543              0             0   0.00000000             0
## R-HSA-5619067             0             0   0.00000000             0
## R-HSA-75158               0             0   0.00000000             0
## R-HSA-5620912             0             0   0.00000000             0
## R-HSA-6783783             0             0   0.01652893             0
## R-HSA-379716              0             0   0.00000000             0
##               R-HSA-428543 R-HSA-5619067 R-HSA-75158 R-HSA-5620912
## R-HSA-8866911            0             0           0             0
## R-HSA-9824585            0             0           0             0
## R-HSA-381119             0             0           0             0
## R-HSA-9006821            0             0           0             0
## R-HSA-428543             1             0           0             0
## R-HSA-5619067            0             1           0             0
## R-HSA-75158              0             0           1             0
## R-HSA-5620912            0             0           0             1
## R-HSA-6783783            0             0           0             0
## R-HSA-379716             0             0           0             0
##               R-HSA-6783783 R-HSA-379716
## R-HSA-8866911    0.00000000            0
## R-HSA-9824585    0.00000000            0
## R-HSA-381119     0.01652893            0
## R-HSA-9006821    0.00000000            0
## R-HSA-428543     0.00000000            0
## R-HSA-5619067    0.00000000            0
## R-HSA-75158      0.00000000            0
## R-HSA-5620912    0.00000000            0
## R-HSA-6783783    1.00000000            0
## R-HSA-379716     0.00000000            1
```

Also if one has a Jaccard similarity and wants a Dice similarity, can use the `J2D()` function.

# 5 High volumes of gene similarities

We can compute the whole similarity of genes in KEGG or Reactome by using :

```
## Omit those genes without a pathway
nas <- sapply(genesKegg, function(y){all(is.na(y)) | is.null(y)})
genesKegg2 <- genesKegg[!nas]
m <- mgeneSim(names(genesKegg2), genesKegg2, method  = "max")
```

It takes around 5 hours in one core but it requires high memory available.

If one doesn’t have such a memory available can compute the similarities by pieces, and then fit it in another matrix with:

```
sim <- AintoB(m, B)
```

Usually B is a matrix of size `length(genes)`, see `?AintoB()`.

# 6 An example of usage

In this example I show how to use BioCor to analyse a list of genes by functionality.
With a list of genes we are going to see how similar are those genes:

```
genes.id <- c("10", "15", "16", "18", "2", "9", "52", "3855", "3880", "644",
              "81327", "9128", "2073", "2893", "5142", "60", "210", "81",
              "1352", "88", "672", "675")
genes.id <- mapIds(org.Hs.eg.db, keys = genes.id, keytype = "ENTREZID",
                   column = "SYMBOL")
## 'select()' returned 1:1 mapping between keys and columns
genes <- names(genes.id)
names(genes) <- genes.id
react <- mgeneSim(genes, genesReact)
## Warning in mgeneSim(genes, genesReact): Some genes are not in the list
## provided.
## We remove genes which are not in list (hence the warning):
nan <- genes %in% names(genesReact)
react <- react[nan, nan]
hc <- hclust(as.dist(1 - react))
plot(hc, main = "Similarities between genes")
```

![Dendrogram of the similarities of genes according to Reactome.](data:image/png;base64...)

Figure 1: Gene clustering by similarities

Now we can see the relationship between the genes. We can group them for a cluster analysis to visualize the relationship between the clusters:

```
mycl <- cutree(hc, h = 0.2)
clusters <- split(genes[nan], as.factor(mycl))
# Removing clusters of just one gene
(clusters <- clusters[lengths(clusters) >= 2])
## $`1`
##   NAT2  AANAT   NAT1  BLVRA   ALAD  COX10
##   "10"   "15"    "9"  "644"  "210" "1352"
##
## $`2`
## AARS1  ACTB
##  "16"  "60"
##
## $`3`
##  ABAT ACTN2
##  "18"  "88"
##
## $`5`
##   KRT7  KRT19
## "3855" "3880"
##
## $`8`
##  ERCC5  BRCA2
## "2073"  "675"
names(clusters) <- paste0("cluster", names(clusters))
## Remember we can use two methods to compare clusters
sim_clus1 <- mclusterSim(clusters, genesReact)
plot(hclust(as.dist(1 - sim_clus1)),
     main = "Similarities between clusters by pathways")
```

![Dendrogram of clusters of genes according to Reactome.](data:image/png;base64...)

Figure 2: Clustering using clusterSim

```
sim_clus2 <- mclusterGeneSim(clusters, genesReact)
plot(hclust(as.dist(1 - sim_clus2)),
     main ="Similarities between clusters by genes")
```

![Dendrogram of clusters according to similarities between genes from Reactome pathways.](data:image/png;base64...)

Figure 3: Clustering using clusterGeneSim

Each method results in a different dendrogram as we can see on Figure [2](#fig:hclust3) compared to Figure [3](#fig:hclust3b).

# 7 Comparing with GOSemSim

In this section I will compare the functional similarity of BioCor with the closely related package *[GOSemSim](https://bioconductor.org/packages/3.22/GOSemSim)*. The genes and gene clusters used were extracted from GOSemSim’s vignette, we only change the ontology, instead of the molecular function, the biological process will be used:

```
hsGO <- GOSemSim::godata('org.Hs.eg.db', ont = "BP", computeIC = FALSE)
##
## Warning in GOSemSim::godata("org.Hs.eg.db", ont = "BP", computeIC = FALSE): use
## 'annoDb' instead of 'OrgDb'
## preparing gene to GO mapping data...
```

I will compare the functions geneSim from section [geneSim and mgeneSim from GOSemSim](https://bioconductor.org/packages/release/bioc/vignettes/GOSemSim/inst/doc/GOSemSim.html#genesim-and-mgenesim) with both data sets from KEGG and Reactome:

```
goSemSim <- GOSemSim::geneSim("241", "251", semData = hsGO,
                              measure = "Wang", combine="BMA")
# In case it is null
sim <- ifelse(is.na(goSemSim), 0, getElement(goSemSim, "geneSim"))
BioCor::geneSim("241", "251", genesReact, "BMA") - sim
## [1] 0.04851789

genes <- c("835", "5261","241", "994")
goSemSim <- GOSemSim::mgeneSim(genes, semData = hsGO,
                   measure = "Wang", combine = "BMA",
                   verbose = FALSE, drop = NULL)
BioCor::mgeneSim(genes, genesReact, "BMA", round = TRUE) - goSemSim
## Warning in BioCor::mgeneSim(genes, genesReact, "BMA", round = TRUE): Some genes
## are not in the list provided.
##      835   5261    241    994
## 835   NA     NA     NA     NA
## 5261  NA  0.000  0.018 -0.275
## 241   NA  0.018  0.000 -0.118
## 994   NA -0.275 -0.118  0.000
```

We can observe there is more similarity according to the gene ontology than according to the pathways.
See FAQ [question 8](#conflict) about the use of `BioCor::` and `GOSemSim::`.

If named characters are passed they are used to name the resulting matrix:

```
genes <- c("CDC45", "MCM10", "CDC20", "NMU", "MMP1")
genese <- mapIds(org.Hs.eg.db, keys = genes, column = "ENTREZID",
                 keytype = "SYMBOL")
## 'select()' returned 1:1 mapping between keys and columns
BioCor::mgeneSim(genese, genesReact, "BMA")
## Warning in BioCor::mgeneSim(genese, genesReact, "BMA"): Some genes are not in
## the list provided.
##            CDC45 MCM10     CDC20        NMU       MMP1
## CDC45 1.00000000    NA 0.4849897 0.05082519 0.08866717
## MCM10         NA    NA        NA         NA         NA
## CDC20 0.48498965    NA 1.0000000 0.16290148 0.21585420
## NMU   0.05082519    NA 0.1629015 1.00000000 0.11323083
## MMP1  0.08866717    NA 0.2158542 0.11323083 1.00000000
```

We can further compare the cluster similarities from the [next section of the vignette](https://bioconductor.org/packages/release/bioc/vignettes/GOSemSim/inst/doc/GOSemSim.html#clustersim-and-mclustersim):

```
gs1 <- c("835", "5261","241", "994", "514", "533")
gs2 <- c("578","582", "400", "409", "411")
BioCor::clusterSim(gs1, gs2, genesReact, "BMA") -
    GOSemSim::clusterSim(gs1, gs2, hsGO, measure = "Wang", combine = "BMA")
## Warning in BioCor::clusterSim(gs1, gs2, genesReact, "BMA"): Some genes are not
## in the list provided.
## [1] -0.1553788

x <- org.Hs.egGO
hsEG <- mappedkeys(x)
set.seed(123)
(clusters <- list(a=sample(hsEG, 20), b=sample(hsEG, 20), c=sample(hsEG, 20)))
## $a
##  [1] "115482686" "4013"      "4539"      "2803"      "5105"      "57805"
##  [7] "6998"      "10092"     "283471"    "4099"      "80168"     "28752"
## [13] "54502"     "90342"     "4289"      "9350"      "9761"      "51066"
## [19] "79863"     "84318"
##
## $b
##  [1] "2335"   "390144" "116835" "152559" "29105"  "51629"  "28559"  "158297"
##  [9] "442038" "4595"   "145942" "23207"  "5947"   "85390"  "24146"  "347517"
## [17] "55624"  "9410"   "692233" "152940"
##
## $c
##  [1] "100996521" "56906"     "80125"     "359845"    "25929"     "91653"
##  [7] "53"        "125111"    "10941"     "10791"     "255488"    "55888"
## [13] "2994"      "10085"     "57509"     "26086"     "51710"     "54663"
## [19] "79490"     "100302250"
BioCor::mclusterSim(clusters, genesReact, "BMA") -
    GOSemSim::mclusterSim(clusters, hsGO, measure = "Wang", combine = "BMA")
## Warning in BioCor::mclusterSim(clusters, genesReact, "BMA"): Some genes are not
## in the list provided.
##              a          b            c
## a  0.000000000 -0.1713721 -0.009666825
## b -0.171372055  0.0000000 -0.115865648
## c -0.009666825 -0.1158656  0.000000000
```

# 8 WGCNA and BioCor

*[WGCNA](https://CRAN.R-project.org/package%3DWGCNA)* uses the correlation of the expression data of several samples to cluster genes. Sometimes, from a biological point of view the interpretation of the resulting modules is difficult, even more when some groups of genes end up not having an enrichment in previously described functions.
BioCor was originally thought to be used to overcome this problem: to help clustering genes, not only by correlation but also by functionality.

In order to have groups functionally related, functional similarities can enhance the clustering of genes when combined with experimental correlations. The resulting groups will reflect, not only the correlation of the expression provided, but also the functionality known of those genes.

We propose the following steps:

1. Calculate the similarities for the expression data
2. Calculate the similarities of the genes in the expression
3. Combine the similarities
4. Calculate the adjacency
5. Identify modules with hierarchical clustering

Here we provide an example on how to use BioCor with WGCNA:

`sim` is a list where each element is a matrix of similarities between genes
Our normalized expression is in the `expr` variable, a matrix where the samples are in the rows and genes in the columns.

```
expr.sim <- WGCNA::cor(expr) # or bicor

## Combine the similarities
similarity <- similarities(c(list(exp = expr.sim), sim), mean, na.rm = TRUE)

## Choose the softThreshold
pSFT <- pickSoftThreshold.fromSimilarity(similarity)

## Or any other function we want
adjacency <- adjacency.fromSimilarity(similarity, power = pSFT$powerEstimate)

## Once we have the similarities we can calculate the TOM with TOM
TOM <- TOMsimilarity(adjacency) ## Requires adjacencies despite its name
dissTOM <- 1 - TOM
geneTree <- hclust(as.dist(dissTOM), method = "average")
## We can use a clustering tool to group the genes
dynamicMods <- cutreeHybrid(dendro = geneTree, distM = dissTOM,
                            deepSplit = 2, pamRespectsDendro = FALSE,
                            minClusterSize = 30)
moduleColors <- labels2colors(dynamicMods$labels)
```

Once the modules are identified using the functional similarities of this package and the gene correlations, one can continue with the workflow of WGCNA.

An important aspect in this process is deciding how to combine the similarities and the expression data:
- If the functional similarities play a huge role, we will end up having only those genes closely related to the same functions.
- If the functional similarities play a low role, it will be similarly to only use WGCNA, and the genes won’t be functionally related.

For these reasons it is better to use weights between `0.5` and `1` for expression if you use `weighted.sum` or similar functions.

There are several things to take into account when choosing a way to combine:
- The size of the gray or 0 modules (those who don’t show a specific pattern)
- The number and size of the modules created.
- The way the similarities are combined

Violin plots may help to view the differences in size and distribution of the modules across different methods of combining the similarities.

# 9 FAQ

## 9.1 How is defined the pathway similarity?

BioCor uses the [Sørensen–Dice index](https://en.wikipedia.org/wiki/S%C3%B8rensen%E2%80%93Dice_coefficient):
The dice similarity is the double of the genes shared by the pathways divided by the number of genes in each pathway.

We can calculate the similarity between two pathways (\(x\), \(w\)) with:

\[Dice(x, w) = \frac{2 |x \cap w|}{|x| + |w|}\]

This is implemented in the `diceSim` function, which results is similar to Jaccard index:

\[Jaccard(x, w) = \frac{|x \cap w|}{|x \cup w|}\]

Both Jaccard index and dice index are between 0 and 1 (\([0, 1]\)). To calculate the Jaccard index from the `diceSim` use the `D2J` function.

## 9.2 Why does BioCor use the dice coefficient and not the Jaccard ?

We consider Dice coefficient better than Jaccard because it has higher values for the same comparisons, which reflects that including a gene in a pathway is not easily done.

## 9.3 How does BioCor combine similarities between several pathways of two genes?

Although the recommend method is the “max” method, (set as default), there are implemented other methods in `combineScores` of the *[GOSemSim](https://bioconductor.org/packages/3.22/GOSemSim)* package which I borrowed111 See the [Combining values section](#combining) and the help page of `combineScores`..

## 9.4 Why do you recommend using the max method to combine similarities scores for pathways?

The purpose of combining the scores is usually to find the relationships between genes through their pathways. The higher the similarity is between two pathway of two genes, the higher functionality do the genes share, even if those genes have other non-related functions.

## 9.5 How to detect which functional relationship is more important between two genes?

If two genes are involved in the same pathways usually they have (to some extent, maybe indirect) interactions. To detect which relationship is more important between two genes one could measure other similarities scores and check the stoichiometry of the pathways and measure the expression changes and correlation between them or use dynamic simulations of the pathways.

## 9.6 How to detect with which genes is my gene of interest related?

You can measure the [gene similarity](#geneSim) between those genes and also measure the expression correlation of your gene of interest with other genes.

## 9.7 Why isn’t available a method for calculating GO similarities?

This is covered by the *[GOSemSim](https://bioconductor.org/packages/3.22/GOSemSim)* package, you can use it to produce a similarity matrix (i.e. use `mgeneSim`). You can parallelize it with `foreach` package or `BiocParallel` if your list of genes is big.

## 9.8 I get an error! How do I solve this?

If the error is like this:

```
Error in FUN(X[[i]], ...) :
  trying to get slot "geneAnno" from an object of a basic class ("list") with no slots
```

And you have loaded the `GOSemSim` library, R is calling the GOSemSim function of the same name. Use `BioCor::` to call the function from `BioCor` (f.ex: `BioCor::geneSim`)

If the error is not previously described in the [support forum](https:///support.bioconductor.org), post a question there.

My apologies if you found a bug or an inconsistency between what `BioCor` should do and what it actually does. Once you checked that it is a bug, please let me know at the *[issues](https://github.com/llrs/BioCor/issues)* page of Github.

# Session Info

```
sessionInfo()
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] reactome.db_1.94.0   org.Hs.eg.db_3.22.0  AnnotationDbi_1.72.0
##  [4] IRanges_2.44.0       S4Vectors_0.48.0     Biobase_2.70.0
##  [7] BiocGenerics_0.56.0  generics_0.1.4       BioCor_1.34.0
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0     GOSemSim_2.36.0     xfun_0.53
##  [4] bslib_0.9.0         lattice_0.22-7      vctrs_0.6.5
##  [7] tools_4.5.1         yulab.utils_0.2.1   parallel_4.5.1
## [10] RSQLite_2.4.3       blob_1.2.4          pkgconfig_2.0.3
## [13] R.oo_1.27.1         Matrix_1.7-4        graph_1.88.0
## [16] lifecycle_1.0.4     compiler_4.5.1      Biostrings_2.78.0
## [19] tinytex_0.57        Seqinfo_1.0.0       codetools_0.2-20
## [22] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
## [25] crayon_1.5.3        jquerylib_0.1.4     GO.db_3.22.0
## [28] R.utils_2.13.0      BiocParallel_1.44.0 cachem_1.1.0
## [31] magick_2.9.0        digest_0.6.37       bookdown_0.45
## [34] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
## [37] magrittr_2.0.4      XML_3.99-0.19       GSEABase_1.72.0
## [40] rappdirs_0.3.3      bit64_4.6.0-1       rmarkdown_2.30
## [43] XVector_0.50.0      httr_1.4.7          bit_4.6.0
## [46] png_0.1-8           R.methodsS3_1.8.2   memoise_2.0.1
## [49] evaluate_1.0.5      knitr_1.50          rlang_1.1.6
## [52] Rcpp_1.1.0          xtable_1.8-4        DBI_1.2.3
## [55] BiocManager_1.30.26 annotate_1.88.0     jsonlite_2.0.0
## [58] R6_2.6.1            fs_1.6.6
```