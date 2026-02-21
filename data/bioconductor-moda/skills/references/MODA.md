# Usage of MODA

#### *Dong Li dxl466@cs.bham.ac.uk*

#### *30 January 2017*

# Contents

* [1 Motivation](#motivation)
* [2 Networks construction](#networks-construction)
* [3 Modules detection](#modules-detection)
  + [3.1 Hierarchical clustering](#hierarchical-clustering)
  + [3.2 Community detection](#community-detection)
  + [3.3 Opitmization based approach](#opitmization-based-approach)
* [4 Networks comparison](#networks-comparison)
* [5 Biological explanation](#biological-explanation)
* [6 Developer page](#developer-page)
* [7 Session Information](#session-information)
* [References](#references)

# 1 Motivation

Conventional differential expression analyses for RNA-sequencing and microarray take individual genes as basic units, where the interactions between genes were not fully considered. As a widely used form to represent the interactions among elements, graph (network) would has potential in this filed. Since a decade ago network biology (Barabasi and Oltvai 2004) has attracted much attention as a principle to understand functional organization. Gene co-expression network, in which a node stands for a gene and an edge means the co-expression level of a pair of genes, is one of the main forms of biological networks. And weighted gene co-expression network analysis (WGCNA) (Langfelder and Horvath 2008) has also become popular since the fantastic works by [Steve Horvath](https://scholar.google.co.uk/citations?user=mEM8q5cAAAAJ&hl=en) and his collabrators.

The pricinple of WGCNA is to take the modules as basic units and try to understand the organism on a system level view. The proposed module differential analysis (MODA) (Li, Brown, et al. 2016) follows this principle and focus on modules identified from multiple networks. Because multiple networks can represent the same system under multple conditions or different systems sharing something in common. Comparing multiple networks by comparing modules from each network is a potential way to reveal the similarities and differences of these networks, on a system point of view. Here we embed parts of the examples from the package [MODA](https://bioconductor.org/packages/MODA) help pages into a single document.

# 2 Networks construction

Given the gene expression matrix \(X \in \mathbb{R}^{n\times p}\) with \(n\) genes across \(p\) replicates, the simpliest way to construct a weighted gene co-expression network is to calcuate the correlation matrix \(W\in \mathbb{R}^{n\times n}\) as the adjacency matrix of the desired graph \(G=(V,E)\), where \(V\) is the node set and \(E\) is the edge set. WGCNA suggests to raise the absolute value of the correlation to a power \(\beta > 1\), i.e. the entries in \(W\) is defined as, \[w\_{ij}=|cor(x\_i,x\_j)|^{\beta}\] where the parameter \(\beta\) is chosen by approximate scale-free topology criterion (Zhang and Horvath 2005).

When involving multiple networks comparison, e.g. multiple stresses or environmental perturbations on the same species, it is idea to has enough replicates for each condition. Because the accurate correlation coefficient is approximated by \(1/sqrt(k)\) where \(k\) is the number of replicates. But requiring large replicates is difficult in practice. We use a sample-saving approach to construct condition-specific co-expression networks for each single condition in MODA. Assume network \(N\_1\) is background, normally containing samples from all conditions, is constructed based on the correlation matrix from all samples. Then condition \(D\) specific network \(N\_2\) is constructed from all samples minus samples belong to certain condition \(D\) (Kuijjer et al. 2015). The differences between network \(N\_1\) and \(N\_1\) is supposed to reveal the effects of condition \(D\).

# 3 Modules detection

## 3.1 Hierarchical clustering

Basic module detection functions are provided by WGCNA (Langfelder and Horvath 2008), which uses hierarchical clustering to find modules. The cutting height of dendrogram relies on user-defined value. MODA selects this parameter based on the maximization of average modularity or density of the resulted modules.

we conduct the experiment on the synthetic dataset which contains two expression profiles \(datExpr1\) and \(datExpr2\) with 500 genes, and each has 20 and 25 samples. Details of data generation can be found in supplementary file of MODA paper (Li, Brown, et al. 2016).

```
library(MODA)
```

```
## Warning: vfs customization not available on this platform. Ignoring value:
## vfs = unix-none

## Warning: vfs customization not available on this platform. Ignoring value:
## vfs = unix-none
```

```
##
```

```
data(synthetic)
ResultFolder = 'ForSynthetic' # where middle files are stored
CuttingCriterion = 'Density' # could be Density or Modularity
indicator1 = 'X'     # indicator for data profile 1
indicator2 = 'Y'      # indicator for data profile 2
specificTheta = 0.1 #threshold to define condition specific modules
conservedTheta = 0.1#threshold to define conserved modules
##modules detection for network 1
intModules1 <- WeightedModulePartitionHierarchical(datExpr1,ResultFolder,
                                indicator1,CuttingCriterion)
```

```
##  ..done.
```

```
##modules detection for network 2
intModules2 <- WeightedModulePartitionHierarchical(datExpr2,ResultFolder,
                                indicator2,CuttingCriterion)
```

```
##  ..done.
```

The above code shows how to detect modules using hierecal clustering with the optimal cutting height of dendrogram. The heatmap of correlation matrix of gene expression profile 1 may looks like the following figure:

```
png('ForSynthetic/heatdatExpr1.png')
heatmap(cor(as.matrix(datExpr1)))
dev.off()
```

```
## png
##   2
```

![Correlation matrix of gene expression profile 1.](data:image/png;base64...)

The selection of optimal cutting height for each expression profile would be stored under directory \(ResultFolder\). Another package (Kalinka and Tomancak 2011) has a similar function. Take \(datExpr1\) in the synthetic data for example, a file named \(Partitions\\_X.pdf\) may looks the following figure:

![Maximal partition density based hierarchical clustering for gene expression profile 1.](data:image/png;base64...)

At the same time, each module for each expression profile would be stored as plain text file, with the name indicator from \(indicator1\) and \(indicator2\). Each secondary directory under \(ResultFolder\) has the same name of condition name, e.g \(indicator2\), used to store differential analysis results.

## 3.2 Community detection

Hierarchical clustering simply categorizes “similar” genes together but ignore the possible community structure of the networks, various community detection methods can be applied. The following example shows how to use Louvain algorithm (Blondel et al. 2008), which is based on modularity maximization:

```
data(synthetic)
ResultFolder <- 'ForSyntheticLouvain' # where middle files are stored
indicator <- 'X'     # indicator for data profile 1
GeneNames <- colnames(datExpr1)
intModules <- WeightedModulePartitionLouvain(datExpr1,ResultFolder,indicator,GeneNames)
```

Spectral clustering is also a promising technique, which has been applied in community detection (White and Smyth 2005). The following example shows how to use spectral clustering

```
data(synthetic)
ResultFolder <- 'ForSyntheticSpectral' # where middle files are stored
indicator <- 'X'     # indicator for data profile 1
GeneNames <- colnames(datExpr1)
WeightedModulePartitionSpectral(datExpr1,ResultFolder,indicator,
GeneNames,k=5) # k is the number of clusters
```

```
## ..connectivity..
## ..matrix multiplication..
## ..normalization..
## ..done.
```

## 3.3 Opitmization based approach

Unlike the clustering or community detection which covers all genes, opitmization based approach aims to select the “optimal” subset. MODA uses another package AMOUNTAIN (Li, Pan, et al. 2016) to identify most signigicant module in terms of module weight each time, and extract one by one to identify multiple modules.

```
data(synthetic)
ResultFolder <- 'ForSyntheticAmoutain' # where middle files are stored
GeneNames <- colnames(datExpr1)
WeightedModulePartitionAmoutain(datExpr1,Nmodule=5,ResultFolder,'X',
GeneNames,maxsize=100,minsize=50) #Nmodule is the number of clusters
```

```
## [1] "Finishing module 1"
## [1] "Finishing module 2"
## [1] "Finishing module 3"
## [1] "Finishing module 4"
## [1] "Finishing module 5"
```

All the above three different methods have similar parameters and produce similar results like the Hierarchical clustering does.

# 4 Networks comparison

After the module detection for background network and all condition-specific networks, we can compare them using following function

```
ResultFolder = 'ForSynthetic' # where middle files are stored
CuttingCriterion = 'Density' # could be Density or Modularity
indicator1 = 'X'     # indicator for data profile 1
indicator2 = 'Y'      # indicator for data profile 2
specificTheta = 0.1 #threshold to define condition specific modules
conservedTheta = 0.1#threshold to define conserved modules

CompareAllNets(ResultFolder,intModules1,indicator1,intModules2,
               indicator2,specificTheta,conservedTheta)
```

The condition specific networks can be specified by two vectors if there are more. There are three files under the secondary directory named by condition name: two text files of them are condition specific and conserved modules id from background network, and one pdf for showing how to determine these modules by two parameters \(specificTheta\) and \(conservedTheta\) based on a Jaccard index matrix. Theoretical details can be found in supplementary file of MODA paper. The figure may looks like the following figure:

![Overlap degree of modules from two networks.](data:image/png;base64...)

# 5 Biological explanation

Gene set enrichment analysis is the most feasible way to get biological explanation for us. Normally we use intergative tools like [DAVID](https://david.ncifcrf.gov) or [Enrichr](http://amp.pharm.mssm.edu/Enrichr), to see whether a module gene list can be explained by existing biological process, pathways or even diseases.

# 6 Developer page

Please visit [MODA](https://github.com/fairmiracle/MODA) for new features.

# 7 Session Information

Here is the output of `sessionInfo()` on the system on which this document was compiled:

```
## R version 3.3.1 (2016-06-21)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows 7 x64 (build 7601) Service Pack 1
##
## locale:
## [1] LC_COLLATE=English_United Kingdom.1252
## [2] LC_CTYPE=English_United Kingdom.1252
## [3] LC_MONETARY=English_United Kingdom.1252
## [4] LC_NUMERIC=C
## [5] LC_TIME=English_United Kingdom.1252
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] MODA_1.1.2      BiocStyle_2.2.1
##
## loaded via a namespace (and not attached):
##  [1] fastcluster_1.1.20    splines_3.3.1         lattice_0.20-33
##  [4] colorspace_1.2-6      htmltools_0.3.5       stats4_3.3.1
##  [7] yaml_2.1.14           chron_2.3-47          survival_2.39-5
## [10] foreign_0.8-66        DBI_0.5-1             BiocGenerics_0.20.0
## [13] RColorBrewer_1.1-2    matrixStats_0.50.2    foreach_1.4.3
## [16] plyr_1.8.4            stringr_1.1.0         munsell_0.4.3
## [19] gtable_0.2.0          codetools_0.2-14      evaluate_0.10
## [22] latticeExtra_0.6-28   Biobase_2.34.0        knitr_1.15.1
## [25] IRanges_2.8.1         doParallel_1.0.10     parallel_3.3.1
## [28] AnnotationDbi_1.36.1  preprocessCore_1.36.0 Rcpp_0.12.5
## [31] acepack_1.3-3.3       backports_1.0.5       scales_0.4.1
## [34] S4Vectors_0.12.1      Hmisc_3.17-4          WGCNA_1.51
## [37] gridExtra_2.2.1       impute_1.48.0         AMOUNTAIN_1.0.0
## [40] ggplot2_2.2.1         digest_0.6.9          stringi_1.1.1
## [43] grid_3.3.1            rprojroot_1.2         tools_3.3.1
## [46] magrittr_1.5          lazyeval_0.2.0        RSQLite_1.0.0
## [49] tibble_1.2            dynamicTreeCut_1.63-1 Formula_1.2-1
## [52] cluster_2.0.4         GO.db_3.4.0           Matrix_1.2-6
## [55] data.table_1.9.6      assertthat_0.1        rmarkdown_1.3
## [58] iterators_1.0.8       rpart_4.1-10          igraph_1.0.1
## [61] nnet_7.3-12
```

# References

Barabasi, Albert-Laszlo, and Zoltan N Oltvai. 2004. “Network Biology: Understanding the Cell’s Functional Organization.” *Nature Reviews Genetics* 5 (2). Nature Publishing Group: 101–13.

Blondel, Vincent D, Jean-Loup Guillaume, Renaud Lambiotte, and Etienne Lefebvre. 2008. “Fast Unfolding of Communities in Large Networks.” *Journal of Statistical Mechanics: Theory and Experiment* 2008 (10). IOP Publishing: P10008.

Kalinka, Alex T, and Pavel Tomancak. 2011. “Linkcomm: An R Package for the Generation, Visualization, and Analysis of Link Communities in Networks of Arbitrary Size and Type.” *Bioinformatics* 27 (14). Oxford Univ Press.

Kuijjer, Marieke Lydia, Matthew Tung, GuoCheng Yuan, John Quackenbush, and Kimberly Glass. 2015. “Estimating Sample-Specific Regulatory Networks.” *ArXiv Preprint ArXiv:1505.06440*.

Langfelder, Peter, and Steve Horvath. 2008. “WGCNA: An R Package for Weighted Correlation Network Analysis.” *BMC Bioinformatics* 9 (1). BioMed Central Ltd: 559.

Li, Dong, James Brown, Luisa Orsini, Zhisong Pan, Guyu Hu, and Shan He. 2016. “MODA: MOdule Differential Analysis for Weighted Gene Co-Expression Network.” *BioRxiv*. Cold Spring Harbor Labs Journals. doi:[10.1101/053496](https://doi.org/10.1101/053496).

Li, Dong, Zhisong Pan, Gongyu Hu, and Shan He. 2016. “AMOUNTAIN: Active Modules for Multilayer Weighted Gene Co-Expression Networks: A Continuous Optimization Approach.” <http://bioconductor.org/packages/AMOUNTAIN>.

White, Scott, and Padhraic Smyth. 2005. “A Spectral Clustering Approach to Finding Communities in Graph.” In *SDM*, 5:76–84. SIAM.

Zhang, Bin, and Steve Horvath. 2005. “A General Framework for Weighted Gene Co-Expression Network Analysis.” *Statistical Applications in Genetics and Molecular Biology* 4 (1).