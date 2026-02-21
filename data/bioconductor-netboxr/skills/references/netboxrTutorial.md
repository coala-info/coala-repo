# NetBoxR Tutorial

Eric Minwei Liu and Augustin Luna

#### 04 September, 2020

# Contents

* [1 Overview](#overview)
* [2 Basics](#basics)
  + [2.1 Installation](#installation)
  + [2.2 Getting Started](#getting-started)
* [3 Example of Cerami et al. PLoS One 2010](#example-of-cerami-et-al.plos-one-2010)
  + [3.1 Load Human Interactions Network (HIN) network](#load-human-interactions-network-hin-network)
  + [3.2 Load altered gene list](#load-altered-gene-list)
  + [3.3 Map altered gene list on HIN network](#map-altered-gene-list-on-hin-network)
  + [3.4 Consistency with Previously Published Results](#consistency-with-previously-published-results)
* [4 Statistical Significance of Discovered Network](#statistical-significance-of-discovered-network)
  + [4.1 Global Network Null Model](#global-network-null-model)
  + [4.2 Local Network Null Model](#local-network-null-model)
* [5 View Module Membership](#view-module-membership)
* [6 Write NetBox Output to Files](#write-netbox-output-to-files)
* [7 Term Enrichment in Modules using Gene Ontology (GO) Analysis](#term-enrichment-in-modules-using-gene-ontology-go-analysis)
  + [7.1 Enrichment Results](#enrichment-results)
  + [7.2 Visualize Enrichment Results](#visualize-enrichment-results)
* [8 Alternative Module Discovery Methods](#alternative-module-discovery-methods)
* [9 Alternative Pathway Data](#alternative-pathway-data)
  + [9.1 Using Tabular Simple Interaction Format (SIF)-Based Network Data](#using-tabular-simple-interaction-format-sif-based-network-data)
  + [9.2 Using PaxtoolsR for Pathway Commons Data](#using-paxtoolsr-for-pathway-commons-data)
* [10 Selecting Input Gene Lists for use with NetBox](#selecting-input-gene-lists-for-use-with-netbox)
  + [10.1 Accesing Pre-Computed Alteration Results from the cBioPortal DataHub](#accesing-pre-computed-alteration-results-from-the-cbioportal-datahub)
  + [10.2 Accessing Cancer Genomics Data from cBioPortal](#accessing-cancer-genomics-data-from-cbioportal)
* [11 References](#references)
* [12 Session Information](#session-information)

# 1 Overview

The **netboxr** package composes a number of functions to retrive and process
genetic data from large-scale genomics projects (e.g. TCGA projects) including
from mutations, copy number alterations, gene expression and DNA methylation.
The netboxr package implements NetBox algorithm in R package. NetBox algorithm
integrates genetic alterations with literature-curated pathway knowledge to
identify pathway modules in cancer. NetBox algorithm uses (1) global network
null model and (2) local network null model to access the statistic significance
of the discovered pathway modules.

# 2 Basics

## 2.1 Installation

```
BiocManager::install("netboxr")
```

## 2.2 Getting Started

Load **netboxr** package:

```
library(netboxr)
```

A list of all accessible vignettes and methods is available with the following command:

```
help(package="netboxr")
```

For help on any **netboxr** package functions, use one of the following command formats:

```
help(geneConnector)
?geneConnector
```

# 3 Example of Cerami et al. PLoS One 2010

This is an example to reproduce the network discovered on [Cerami et al.(2010)](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0008918).

The results presented here are comparable to the those from Cerami et al. 2010
though the unadjusted p-values for linker genes are not the same.
It is because the unadjusted p-value of linker genes in Cerami et al. 2010 were
calculated by the probabiliy of the observed data point, Pr(X). The netboxr used the probability
of an observed or more extreme assuming the null hypothesis is true, Pr(X>=x|H),
as unadjusted p-value for linker genes. The final number of linker genes after
FDR correction are the same between netboxr result and original Cerami et al. 2010.

## 3.1 Load Human Interactions Network (HIN) network

Load pre-defined HIN network and simplify the interactions by removing loops
and duplicated interactions in the network. The netowork after reduction
contains 9264 nodes and 68111 interactions.

```
data(netbox2010)
sifNetwork <- netbox2010$network
graphReduced <- networkSimplify(sifNetwork, directed = FALSE)
```

```
## Loading network of 9264 nodes and 157780 interactions
```

```
## Treated as undirected network
```

```
## Removing multiple interactions and loops
```

```
## Returning network of 9264 nodes and 68111 interactions
```

## 3.2 Load altered gene list

The altered gene list contains 517 candidates from mutations and copy number
alterations.

```
geneList <- as.character(netbox2010$geneList)
length(geneList)
```

```
## [1] 517
```

## 3.3 Map altered gene list on HIN network

The geneConnector function in the netboxr package takes altered gene list as
input and maps the genes on the curated network to find the local processes
represented by the gene list.

```
## Use Benjamini-Hochberg method to do multiple hypothesis correction for linker
## candidates.

## Use edge-betweeness method to detect community structure in the network.
threshold <- 0.05
results <- geneConnector(geneList = geneList, networkGraph = graphReduced, directed = FALSE,
    pValueAdj = "BH", pValueCutoff = threshold, communityMethod = "ebc", keepIsolatedNodes = FALSE)
```

```
## 274 / 517 candidate nodes match the name in the network of 9264
##                 nodes
```

```
## Only test neighbor nodes with local degree equals or exceeds 2
```

```
## Multiple hypothesis corrections for 892 neighbor nodes in the network
```

```
## For p-value 0.05 cut-off, 6 nodes were included as linker nodes
```

```
## Connecting 274 candidate nodes and 6 linker nodes
```

```
## Remove 208 isolated candidate nodes from the input
```

```
## Final network contains 72 nodes and 152 interactions
```

```
## Detecting modules using "edge betweeness" method
```

```
# Add edge annotations
library(RColorBrewer)
edges <- results$netboxOutput
interactionType <- unique(edges[, 2])
interactionTypeColor <- brewer.pal(length(interactionType), name = "Spectral")

edgeColors <- data.frame(interactionType, interactionTypeColor, stringsAsFactors = FALSE)
colnames(edgeColors) <- c("INTERACTION_TYPE", "COLOR")

netboxGraphAnnotated <- annotateGraph(netboxResults = results, edgeColors = edgeColors,
    directed = FALSE, linker = TRUE)

# Check the p-value of the selected linker
linkerDF <- results$neighborData
linkerDF[linkerDF$pValueFDR < threshold, ]
```

```
##         idx   name localDegree globalDegree    pValueRaw oddsRatio  pValueFDR
## CRK    1712    CRK          11           81 2.392088e-05  1.708732 0.01866731
## IFNAR1 4546 IFNAR1           6           23 4.185496e-05  2.518726 0.01866731
## CBL      20    CBL          14          140 6.505470e-05  1.361057 0.01934293
## GAB1    500   GAB1           8           57 2.483197e-04  1.751122 0.04887827
## CDK6    414   CDK6           5           21 3.008515e-04  2.406906 0.04887827
## PTPN11   84 PTPN11          14          163 3.287776e-04  1.191405 0.04887827
```

```
# The geneConnector function returns a list of data frames.
names(results)
```

```
## [1] "netboxGraph"      "netboxCommunity"  "netboxOutput"     "nodeType"
## [5] "moduleMembership" "neighborData"
```

```
# Plot graph with the Fruchterman-Reingold layout algorithm As an example, plot
# both the original and the annotated graphs Save the layout for easier
# comparison
graph_layout <- layout_with_fr(results$netboxGraph)

# plot the original graph
plot(results$netboxCommunity, results$netboxGraph, layout = graph_layout)
```

![](data:image/png;base64...)

```
# Plot the edge annotated graph
plot(results$netboxCommunity, netboxGraphAnnotated, layout = graph_layout, vertex.size = 10,
    vertex.shape = V(netboxGraphAnnotated)$shape, edge.color = E(netboxGraphAnnotated)$interactionColor,
    edge.width = 3)

# Add interaction type annotations
legend("bottomleft", legend = interactionType, col = interactionTypeColor, lty = 1,
    lwd = 2, bty = "n", cex = 1)
```

![](data:image/png;base64...)

## 3.4 Consistency with Previously Published Results

The GBM result by netboxr identified exactly the same linker genes (6 linker genes), the same number of modules (10 modules) and the same genes in each identified module as GBM result in Cerami et al. 2010.

The results of netboxr are consistent with previous implementation of the NetBox algorithm. The RB1 and PIK3R1 modules are clearly represented in the figure. For example, the RB1 module contains genes in blue color and enclosed by light orange circle. The PIK3R1 module contains genes in orange color and enclosed by pink circle.

# 4 Statistical Significance of Discovered Network

NetBox algorithm used (1) global network null model and (2) local network null model to access the statistical significance of the discovered network.

## 4.1 Global Network Null Model

The global network null model calculates the empirical p-value as the number of times (over a set of iterations) the size of the largest connected component (the giant component) in the network coming from the same number of randomly selected genes (number of genes is 274 in this example) equals or exceeds the size of the largest connected component in the observed network. The suggested iterations are 1000.

```
## This function will need a lot of time to complete.
globalTest <- globalNullModel(netboxGraph = results$netboxGraph, networkGraph = graphReduced,
    iterations = 10, numOfGenes = 274)
```

## 4.2 Local Network Null Model

Local network null model evaluates the deviation of modularity in the observed network from modularity distribution in the random network. For each interaction, a random network is produced from local re-wiring of literature curated network. It means all nodes in the network kept the same degree of connections but connect to new neighbors randomly. Suggested iterations is 1000.

```
localTest <- localNullModel(netboxGraph = results$netboxGraph, iterations = 1000)
```

```
## ###########
```

```
## Based on 1000 random trails
```

```
## Random networks: mean modularity = 0.3
```

```
## Random networks: sd modularity = 0.058
```

```
## Observed network modularity is: 0.519
```

```
## Observed network modularity z-score is: 3.799
```

```
## One-tail p-value is: 7.271e-05
```

Through 1000 iterations, we can obtain the mean and the standard deviation of modularity in the local network null model. Using the mean (~0.3) and the standard deviation (0.06), we can covert the observed modularity in the network (0.519) into a Z-score (~3.8). From the Z-score, we can calculate one-tail p-value. If one-tail pvalue is less than 0.05, the observed modularity is significantly different from random. In the histogram, the blue region is the distribution of modularity in the local network null model. The red vertical line is the observed modularity in the NetBox results.

```
h <- hist(localTest$randomModularityScore, breaks = 35, plot = FALSE)
h$density = h$counts/sum(h$counts)
plot(h, freq = FALSE, ylim = c(0, 0.1), xlim = c(0.1, 0.6), col = "lightblue")
abline(v = localTest$modularityScoreObs, col = "red")
```

![](data:image/png;base64...)

* The global null model is used to assess the global connectivity (number of nodes and edges) of the largest module in the identified network compared with the same number but randomly selected gene list.
* The local null model is used to assess the network modularity in the identified network compared with random re-wired network.

# 5 View Module Membership

The table below shows the module memberships for all genes.

```
DT::datatable(results$moduleMembership, rownames = FALSE)
```

# 6 Write NetBox Output to Files

```
# Write results for further visilaztion in the cytoscape software.  network.sif
# file is the NetBox algorithm output in SIF format.
write.table(results$netboxOutput, file = "network.sif", sep = "\t", quote = FALSE,
    col.names = FALSE, row.names = FALSE)
# netighborList.txt file contains the information of all neighbor nodes.
write.table(results$neighborData, file = "neighborList.txt", sep = "\t", quote = FALSE,
    col.names = TRUE, row.names = FALSE)
# community.membership.txt file indicates the identified pathway module numbers.
write.table(results$moduleMembership, file = "community.membership.txt", sep = "\t",
    quote = FALSE, col.names = FALSE, row.names = FALSE)
# nodeType.txt file indicates the node is 'linker' node or 'candidate' node.
write.table(results$nodeType, file = "nodeType.txt", sep = "\t", quote = FALSE, col.names = FALSE,
    row.names = FALSE)
```

# 7 Term Enrichment in Modules using Gene Ontology (GO) Analysis

After module identification, one main task is understanding the biological processes that may be represented by the returned modules. Here we use the Bioncoductor clusterProfiler to do an enrichment analysis using GO Biological Process terms on a selected module.

```
library(clusterProfiler)
```

```
## clusterProfiler v3.16.1  For help: https://guangchuangyu.github.io/software/clusterProfiler
##
## If you use clusterProfiler in published research, please cite:
## Guangchuang Yu, Li-Gen Wang, Yanyan Han, Qing-Yu He. clusterProfiler: an R package for comparing biological themes among gene clusters. OMICS: A Journal of Integrative Biology. 2012, 16(5):284-287.
```

```
##
## Attaching package: 'clusterProfiler'
```

```
## The following object is masked from 'package:igraph':
##
##     simplify
```

```
## The following object is masked from 'package:stats':
##
##     filter
```

```
library(org.Hs.eg.db)
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:parallel':
##
##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##     clusterExport, clusterMap, parApply, parCapply, parLapply,
##     parLapplyLB, parRapply, parSapply, parSapplyLB
```

```
## The following objects are masked from 'package:igraph':
##
##     normalize, path, union
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, intersect, is.unsorted,
##     lapply, mapply, match, mget, order, paste, pmax, pmax.int, pmin,
##     pmin.int, rank, rbind, rownames, sapply, setdiff, sort, table,
##     tapply, union, unique, unsplit, which, which.max, which.min
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
## Loading required package: IRanges
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:clusterProfiler':
##
##     rename
```

```
## The following object is masked from 'package:base':
##
##     expand.grid
```

```
##
## Attaching package: 'IRanges'
```

```
## The following object is masked from 'package:clusterProfiler':
##
##     slice
```

```
##
## Attaching package: 'AnnotationDbi'
```

```
## The following object is masked from 'package:clusterProfiler':
##
##     select
```

```
##
```

```
module <- 6
selectedModule <- results$moduleMembership[results$moduleMembership$membership ==
    module, ]
geneList <- selectedModule$geneSymbol

# Check available ID types in for the org.Hs.eg.db annotation package
keytypes(org.Hs.eg.db)
```

```
##  [1] "ACCNUM"       "ALIAS"        "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS"
##  [6] "ENTREZID"     "ENZYME"       "EVIDENCE"     "EVIDENCEALL"  "GENENAME"
## [11] "GO"           "GOALL"        "IPI"          "MAP"          "OMIM"
## [16] "ONTOLOGY"     "ONTOLOGYALL"  "PATH"         "PFAM"         "PMID"
## [21] "PROSITE"      "REFSEQ"       "SYMBOL"       "UCSCKG"       "UNIGENE"
## [26] "UNIPROT"
```

```
ids <- bitr(geneList, fromType = "SYMBOL", toType = c("ENTREZID"), OrgDb = "org.Hs.eg.db")
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
## Warning in bitr(geneList, fromType = "SYMBOL", toType = c("ENTREZID"), OrgDb =
## "org.Hs.eg.db"): 25% of input gene IDs are fail to map...
```

```
head(ids)
```

```
##   SYMBOL ENTREZID
## 1  NUP50    10762
## 3 NUP107    57122
## 4  SNRPE     6635
```

```
ego <- enrichGO(gene = ids$ENTREZID, OrgDb = org.Hs.eg.db, ont = "BP", pAdjustMethod = "BH",
    pvalueCutoff = 0.01, qvalueCutoff = 0.05, readable = TRUE)
```

## 7.1 Enrichment Results

```
head(ego)
```

```
##                    ID
## GO:0051170 GO:0051170
## GO:0006913 GO:0006913
## GO:0051169 GO:0051169
## GO:0006409 GO:0006409
## GO:0071431 GO:0071431
## GO:0051031 GO:0051031
##                                                              Description
## GO:0051170                                           import into nucleus
## GO:0006913                                   nucleocytoplasmic transport
## GO:0051169                                             nuclear transport
## GO:0006409                                      tRNA export from nucleus
## GO:0071431 tRNA-containing ribonucleoprotein complex export from nucleus
## GO:0051031                                                tRNA transport
##            GeneRatio   BgRatio       pvalue     p.adjust       qvalue
## GO:0051170       3/3 163/18670 6.533792e-07 6.337779e-05 6.877676e-06
## GO:0006913       3/3 343/18670 6.147683e-06 1.674774e-04 1.817443e-05
## GO:0051169       3/3 346/18670 6.310888e-06 1.674774e-04 1.817443e-05
## GO:0006409       2/3  34/18670 9.646109e-06 1.674774e-04 1.817443e-05
## GO:0071431       2/3  34/18670 9.646109e-06 1.674774e-04 1.817443e-05
## GO:0051031       2/3  36/18670 1.083175e-05 1.674774e-04 1.817443e-05
##                        geneID Count
## GO:0051170 NUP50/NUP107/SNRPE     3
## GO:0006913 NUP50/NUP107/SNRPE     3
## GO:0051169 NUP50/NUP107/SNRPE     3
## GO:0006409       NUP50/NUP107     2
## GO:0071431       NUP50/NUP107     2
## GO:0051031       NUP50/NUP107     2
```

## 7.2 Visualize Enrichment Results

```
dotplot(ego)
```

![](data:image/png;base64...)

# 8 Alternative Module Discovery Methods

In netboxr, we used the Girvan-Newman algorithm (communityMethod=“ebc”) as the default method to detect community membership in the identified network. The Girvan-Newman algorithm iteratativly removes the edge in the network with highest edge betweeness until no edges left. When the identified network contains many edges, the Girvan-Newman algorithm will spend a large amount of time to remove edges and re-calucalte the edge betweenese score in the network. If the user cannot get the community detection result in reasonable time, we suggest to switch to leading eigenvector method (communityMethod=“lec”) for community detection. Users can check original papers of [the Girvan-Newman algorithm](http://www.pnas.org/content/99/12/7821) and [leading eigenvector method](https://journals.aps.org/pre/abstract/10.1103/PhysRevE.74.036104) for more details.

# 9 Alternative Pathway Data

## 9.1 Using Tabular Simple Interaction Format (SIF)-Based Network Data

Users can load alternative pathway data formatted in the SIF format (Simple Interaction Format). SIF is a space/tab separated format that summarizes interactions in a graph as an edgelist. In the format, every row corresponds to an individual interaction (edge) between a source and a target node. NOTE: An arbitrary interaction type can be used, such as “interacts” if the true interaction type is unknown.

```
PARTICIPANT_A INTERACTION_TYPE PARTICIPANT_B
nodeA relationship nodeB
nodeC relationship nodeA
nodeD relationship nodeE
```

Resources, such as the Functional Interaction network from Reactome (<https://reactome.org/download-data>) and StringDB (<https://string-db.org/>) provide network information in formats reusable as a SIF. NOTE: The next section demonstrates how to retrieve SIF-based networks for many well-known interaction databases using paxtoolsr.

SIF formatted data can be passed to networkSimplify(). The result of which is used with the geneConnector() function as other examples in this vignette demonstrate.

```
example <- "PARTICIPANT_A\tINTERACTION_TYPE\tPARTICIPANT_B
TP53\tinteracts\tMDM2
MDM2\tinteracts\tMDM4"

sif <- read.table(text = example, header = TRUE, sep = "\t", stringsAsFactors = FALSE)

graphReduced <- networkSimplify(sif, directed = FALSE)
```

```
## Loading network of 3 nodes and 2 interactions
```

```
## Treated as undirected network
```

```
## Removing multiple interactions and loops
```

```
## Returning network of 3 nodes and 2 interactions
```

## 9.2 Using PaxtoolsR for Pathway Commons Data

Users can load alternative pathway data from the [Pathway Commons](http://www.pathwaycommons.org/) repository using the **paxtoolsr** package from [Bioconductor](https://bioconductor.org/packages/release/bioc/html/paxtoolsr.html). This pathway data represents an update to the Pathway Commons data used in the original 2010 NetBox publication. Below is an example that makes use of data from the [Reactome pathway database](http://www.reactome.org/).

**NOTE:** Downloaded data is automatically cached to avoid unnecessary downloads.

```
library(paxtoolsr)

filename <- "PathwayCommons.8.reactome.EXTENDED_BINARY_SIF.hgnc.txt.gz"
sif <- downloadPc2(filename, version = "8")

# Filter interactions for specific types
interactionTypes <- getSifInteractionCategories()

filteredSif <- filterSif(sif$edges, interactionTypes = interactionTypes[["BetweenProteins"]])
filteredSif <- filteredSif[(filteredSif$INTERACTION_TYPE %in% "in-complex-with"),
    ]

# Re-run NetBox algorithm with new network
graphReduced <- networkSimplify(filteredSif, directed = FALSE)
geneList <- as.character(netbox2010$geneList)

threshold <- 0.05
pcResults <- geneConnector(geneList = geneList, networkGraph = graphReduced, directed = FALSE,
    pValueAdj = "BH", pValueCutoff = threshold, communityMethod = "lec", keepIsolatedNodes = FALSE)

# Check the p-value of the selected linker
linkerDF <- results$neighborData
linkerDF[linkerDF$pValueFDR < threshold, ]

# The geneConnector function returns a list of data frames.
names(results)

# plot graph with the Fruchterman-Reingold layout algorithm
plot(results$netboxCommunity, results$netboxGraph, layout = layout_with_fr)
```

# 10 Selecting Input Gene Lists for use with NetBox

The main input for the NetBox algorithm is an input list of “significantly” altered genes. Each project is different, unique considerations for how significance should be considered may be required. Researchers may seek stronger thresholds of significance for particular questions and different profiling technologies may have their own considerations. It is beyond the scope of this work to provide guidance for all situations.

However, to help users better understand the process of generating an input gene list we provide examples using best practices derived from the The Cancer Genome Project using the cBioPortal (<http://cbioportal.org/>), a platform that aggregates clinical genomics datasets into a standard representation. As of August 2020, cBioPortal has approximately 290 studies. In cases where appropriate data is available a similar procedure to the example can be used.

## 10.1 Accesing Pre-Computed Alteration Results from the cBioPortal DataHub

For TCGA studies on cBioPortal, users can access pre-processed datasets from the [cBioPortal DataHub](https://github.com/cBioPortal/datahub/tree/master/public) that contain significantly altered genes by mutations and copy number. Example study link: <https://github.com/cBioPortal/datahub/tree/master/public/acc_tcga>

* Significantly altered genes by mutations (via MutSig algorithm) are accessible within the ‘data\_mutsig.txt’ file for a study; typically mutations with a q-value < 0.1 are selected as significantly altered
* Significantly altered genes by copy number (via GISTIC algorithm) are accessible within the ‘data\_gistic\_genes\_del.txt’ (deletions) file and ‘data\_gistic\_genes\_amp.txt’ (amplifications).

Users are directed to the accompanying study publications; study publication details are in the ‘meta\_study.txt’ file for a study.

## 10.2 Accessing Cancer Genomics Data from cBioPortal

Users can download cancer alteration data from [cBioPortal](https://www.cbioportal.org/) using the **cgdsr** package from [CRAN](https://cran.r-project.org/web/packages/cgdsr/index.html). Here we show how a simple example for selecting genes for use with netboxr for datasets provided by cBioPortal using a using a 10% alteration frequency threshold to select genes; this general procedure has previously been used as part of [TCGA studies](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3910500/). In the example, we consider:

* For mutations, mutations of any type contribute to the overall alteration frequency of the gene
* For copy number, discretized GISTIC-derived values for amplification or deep deletions contribute to the overall alteration frequency

The resulting gene list then becomes an input for netboxr. The resulting gene list will select EGFR and TP53, which have high alteration frequencies in glioblastoma (GBM) over the housekeeping genes ACTB and GAPDH, which have very low alteration frequencies.

```
library(cgdsr)

mycgds <- CGDS("http://www.cbioportal.org/")

# Find available studies, caselists, and geneticProfiles
studies <- getCancerStudies(mycgds)
caselists <- getCaseLists(mycgds, "gbm_tcga_pub")
geneticProfiles <- getGeneticProfiles(mycgds, "gbm_tcga_pub")

genes <- c("EGFR", "TP53", "ACTB", "GAPDH")

results <- sapply(genes, function(gene) {
    geneticProfiles <- c("gbm_tcga_pub_cna_consensus", "gbm_tcga_pub_mutations")
    caseList <- "gbm_tcga_pub_cnaseq"

    dat <- getProfileData(mycgds, genes = gene, geneticProfiles = geneticProfiles,
        caseList = caseList)
    head(dat)

    cna <- dat$gbm_tcga_pub_cna_consensus
    cna <- as.numeric(levels(cna))[cna]

    mut <- dat$gbm_tcga_pub_mutations
    mut <- as.character(levels(mut))[mut]

    tmp <- data.frame(cna = cna, mut = mut, stringsAsFactors = FALSE)
    tmp$isAltered <- abs(tmp$cna) == 2 | !is.na(tmp$mut)  # Amplification or Deep Deletion or any mutation
    length(which(tmp$isAltered))/nrow(tmp)
}, USE.NAMES = TRUE)

# 10 percent alteration frequency cutoff
geneList <- names(results)[results > 0.1]
```

# 11 References

* Cerami E, Demir E, Schultz N, Taylor BS, Sander C (2010) Automated Network Analysis Identifies Core Pathways in Glioblastoma. PLoS ONE 5(2): e8918. doi:10.1371/journal.pone.0008918
* Cerami EG, Gross BE, Demir E, Rodchenkov I, Babur O, Anwar N, Schultz N, Bader GD, Sander C. Pathway Commons, a web resource for biological pathway data. Nucleic Acids Res. 2011 Jan;39(Database issue):D685-90. doi:10.1093/nar/gkq1039. Epub 2010 Nov 10.

# 12 Session Information

```
sessionInfo()
```

```
## R version 4.0.2 (2020-06-22)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.11-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.11-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] org.Hs.eg.db_3.11.4    AnnotationDbi_1.50.3   IRanges_2.22.2
##  [4] S4Vectors_0.26.1       Biobase_2.48.0         BiocGenerics_0.34.0
##  [7] clusterProfiler_3.16.1 RColorBrewer_1.1-2     netboxr_1.0.1
## [10] igraph_1.2.5           knitr_1.29             BiocStyle_2.16.0
##
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-6        enrichplot_1.8.1    bit64_4.0.5
##  [4] progress_1.2.2      httr_1.4.2          tools_4.0.2
##  [7] R6_2.4.1            DT_0.15             KernSmooth_2.23-17
## [10] DBI_1.1.0           colorspace_1.4-1    prettyunits_1.1.1
## [13] tidyselect_1.1.0    gridExtra_2.3       bit_4.0.4
## [16] compiler_4.0.2      formatR_1.7         scatterpie_0.1.4
## [19] xml2_1.3.2          labeling_0.3        triebeard_0.3.0
## [22] bookdown_0.20       caTools_1.18.0      scales_1.1.1
## [25] ggridges_0.5.2      stringr_1.4.0       digest_0.6.25
## [28] rmarkdown_2.3       DOSE_3.14.0         pkgconfig_2.0.3
## [31] htmltools_0.5.0     htmlwidgets_1.5.1   rlang_0.4.7
## [34] RSQLite_2.2.0       gridGraphics_0.5-0  generics_0.0.2
## [37] farver_2.0.3        jsonlite_1.7.0      crosstalk_1.1.0.1
## [40] BiocParallel_1.22.0 gtools_3.8.2        GOSemSim_2.14.2
## [43] dplyr_1.0.2         magrittr_1.5        ggplotify_0.0.5
## [46] GO.db_3.11.4        Matrix_1.2-18       Rcpp_1.0.5
## [49] munsell_0.5.0       viridis_0.5.1       lifecycle_0.2.0
## [52] stringi_1.4.6       yaml_2.2.1          ggraph_2.0.3
## [55] MASS_7.3-52         gplots_3.0.4        plyr_1.8.6
## [58] qvalue_2.20.0       grid_4.0.2          blob_1.2.1
## [61] gdata_2.18.0        ggrepel_0.8.2       DO.db_2.9
## [64] crayon_1.3.4        lattice_0.20-41     graphlayouts_0.7.0
## [67] cowplot_1.0.0       splines_4.0.2       hms_0.5.3
## [70] magick_2.4.0        pillar_1.4.6        fgsea_1.14.0
## [73] reshape2_1.4.4      fastmatch_1.1-0     glue_1.4.2
## [76] evaluate_0.14       downloader_0.4      data.table_1.13.0
## [79] BiocManager_1.30.10 urltools_1.7.3      vctrs_0.3.4
## [82] tweenr_1.0.1        gtable_0.3.0        purrr_0.3.4
## [85] polyclip_1.10-0     tidyr_1.1.2         ggplot2_3.3.2
## [88] xfun_0.16           ggforce_0.3.2       europepmc_0.4
## [91] tidygraph_1.2.0     viridisLite_0.3.0   tibble_3.0.3
## [94] rvcheck_0.1.8       memoise_1.1.0       ellipsis_0.3.1
```