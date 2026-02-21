# Using PaxtoolsR: A BioPAX and Pathway Commons Tutorial in R

#### *30 October 2018*

# Contents

* [1 PaxtoolsR Tutorial](#paxtoolsr-tutorial)
* [2 Overview](#overview)
  + [2.1 BioPAX, Paxtools, Pathway Commons, and the Simple Interaction Format](#biopax-paxtools-pathway-commons-and-the-simple-interaction-format)
  + [2.2 Limitations](#limitations)
* [3 Basics](#basics)
  + [3.1 Installation](#installation)
  + [3.2 Getting Started](#getting-started)
  + [3.3 Common Function Return Types](#common-function-return-types)
* [4 Handling BioPAX OWL Files](#handling-biopax-owl-files)
  + [4.1 Merging BioPAX Files](#merging-biopax-files)
  + [4.2 Validating BioPAX Files](#validating-biopax-files)
  + [4.3 Converting BioPAX Files to Other Formats](#converting-biopax-files-to-other-formats)
    - [4.3.1 Simple Interaction Format (SIF) Network](#simple-interaction-format-sif-network)
    - [4.3.2 Extended Simple Interaction Format (SIF) Network](#extended-simple-interaction-format-sif-network)
* [5 Searching Pathway Commons](#searching-pathway-commons)
* [6 Extracting Information from BioPAX Datasets Using traverse()](#extracting-information-from-biopax-datasets-using-traverse)
* [7 Common Data Visualization Pathways and Network Analysis](#common-data-visualization-pathways-and-network-analysis)
  + [7.1 Visualizing SIF Interactions from Pathway Commons using R Graph Libraries](#visualizing-sif-interactions-from-pathway-commons-using-r-graph-libraries)
  + [7.2 Pathway Commons Graph Query](#pathway-commons-graph-query)
  + [7.3 Overlaying Experimental Data on Pathway Commons Networks](#overlaying-experimental-data-on-pathway-commons-networks)
  + [7.4 Network Statistics](#network-statistics)
    - [7.4.1 SIF Network Statistics](#sif-network-statistics)
* [8 Gene Set Enrichment Analysis with Pathway Commons](#gene-set-enrichment-analysis-with-pathway-commons)
* [9 ID Mapping](#id-mapping)
* [10 Troubleshooting](#troubleshooting)
  + [10.1 File Paths](#file-paths)
  + [10.2 Memory Limits: Specify JVM Maximum Heap Size](#memory-limits-specify-jvm-maximum-heap-size)
* [11 Session Information](#session-information)
* [12 References](#references)

# 1 PaxtoolsR Tutorial

The **paxtoolsr** package exposes a number of the algorithms and functions provided by the Paxtools Java library and Pathway Commons webservice allowing them to be used in R.

# 2 Overview

## 2.1 BioPAX, Paxtools, Pathway Commons, and the Simple Interaction Format

The [Biological Pathway Exchange](http://www.ncbi.nlm.nih.gov/pubmed/20829833) (BioPAX) format is a community-driven standard language to represent biological pathways at the molecular and cellular level and to facilitate the exchange of pathway data. BioPAX can represent metabolic and signaling pathways, molecular and genetic interactions and gene regulation networks. Using BioPAX, millions of interactions, organized into thousands of pathways, from many organisms are available from a growing number of databases. This large amount of pathway data in a computable form will support visualization, analysis and biological discovery. The BioPAX format using syntax for data exchange based on the OWL ([Web Ontology Language](http://www.w3.org/TR/owl2-overview/)) that aids pathway data integration; classes in the BioPAX ontology are described [here](http://www.biopax.org/owldoc/Level3/). Ontologies are formal systems for knowledge representation allowing machine-readability of pathway data; one well-known example of a biological ontology is the [Gene Ontology](http://geneontology.org) for biological terms.

[Paxtools](http://www.ncbi.nlm.nih.gov/pubmed/24068901) is a Java libary that allows users to interact with biological pathways represented in the BioPAX language. [Pathway Commons](http://www.pathwaycommons.org/about/) is a resource that integrates biological pathway information for a number of public pathway databases, including Reactome, PantherDB, HumanCyc, etc. that are represented using the BioPAX language.

**NOTE:** BioPAX can encode very detailed information about biological processes. Analysis of this data, however, can be complicated as one needs to consider a wide array of n-ary relationships, different states of entities and generics. An alternative approach is to derive higher order relations based on a set of templates to define a simple binary network between biological entities and use conventional graph algorithms to analyze it. For many users of this package, the binary representation termed the Simple Interaction Format (SIF) will be the main entry point to the usage of BioPAX data. Conversion of BioPAX datasets to the SIF format is done through a series of [simplification rules](https://docs.google.com/document/d/1coFo66uuPQQ4ZMSHr8IzCV7I2DwXCoDBfZw7Vg4MgUE/edit?usp=sharing).

## 2.2 Limitations

The Paxtools Java library produces that full model of a given BioPAX data set that can be searched via code. The **paxtoolsr** provides a limited set of functionality mainly to produce SIF representations of networks that can be analyzed in R.

# 3 Basics

## 3.1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("paxtoolsr")
```

## 3.2 Getting Started

Load **paxtoolsr** package:

```
library(paxtoolsr)
```

A list of all accessible vignettes and methods is available with the following command:

```
help.search("paxtoolsr")
```

For help on any **paxtoolsr** package functions, use one of the following command formats:

```
help(graphPc)
?graphPc
```

## 3.3 Common Function Return Types

**paxtoolsr** return two main types of values **data.frame** and **XMLInternalDocument**. Data.frames are table like data structures. **XMLInternalDocument** is a representation provided by the **XML** package and this data structure form is returned for functions that search or return raw BioPAX results. An **XMLInternalDocument** can be used as the input for any function requiring a BioPAX file.

# 4 Handling BioPAX OWL Files

**paxtoolsr** provides several functions for handling BioPAX OWL files. paxtoolsr provides several functions for handling BioPAX OWL files: merging, validation, conversion to other formats. Many databases with protein-protein interactions and pathway information export the BioPAX format and BioPAX files; databases that support the BioPAX format can be found on [PathGuide](http://pathguide.org/), a resource for pathway information.

## 4.1 Merging BioPAX Files

We illustrate how to merge two BioPAX files. Only entities that share IDs will be merged; no additional merging occurs on cross-references. The merging occurs as described further in the Java library [documentation](http://sourceforge.net/projects/biopax/files/paxtools/paxtools.pdf/download). Throughout this BioPAX and Pathway Commons tutorial we use the system.file() command to access sample BioPAX files included with the **paxtoolsr** package. Merging may result in warning messages caused as a result of redundant actions being checked against by the Java library; these messages may be ignored.

```
file1 <- system.file("extdata", "raf_map_kinase_cascade_reactome.owl", package = "paxtoolsr")
file2 <- system.file("extdata", "biopax3-short-metabolic-pathway.owl", package = "paxtoolsr")

mergedFile <- mergeBiopax(file1, file2)
```

Here we summarize information about one of the BioPAX files provide in the **paxtoolsr** package. The summarize() function produces a counts for various BioPAX classes and can be used to filter through BioPAX files matching particular characteristics. In the example below, we show that the merged file contains the sum of the Catalysis elements from the original two BioPAX files. This can be used iterate over and to identify files with particular properties quickly or to summarize across the files from a set.

```
s1 <- summarize(file1)
s2 <- summarize(file2)
s3 <- summarize(mergedFile)

s1$Catalysis
s2$Catalysis
s3$Catalysis
```

```
## [1] "5"
## [1] "2"
## [1] "7"
```

## 4.2 Validating BioPAX Files

To validate BioPAX **paxtoolsr** the types of validation performed are described in the [**BioPAX Validator**](http://www.ncbi.nlm.nih.gov/pubmed/23918249) publication by Rodchenkov I, et al.

```
errorLog <- validate(system.file("extdata", "raf_map_kinase_cascade_reactome.owl",
    package = "paxtoolsr"), onlyErrors = TRUE)
```

## 4.3 Converting BioPAX Files to Other Formats

It is often useful to convert BioPAX into other formats. Currently, **paxtoolsr** supports conversion to [Gene Set Enrichment Analysis](http://www.broadinstitute.org/gsea/index.jsp) (GSEA, .gmt), [Systems Biology Graphical Notation](http://www.sbgn.org/) (SBGN, .sbgn), [Simple Interaction Format](http://wiki.cytoscape.org/Cytoscape_User_Manual/Network_Formats) (SIF).

### 4.3.1 Simple Interaction Format (SIF) Network

The basic SIF format includes a three columns: PARTICIPANT\_A, INTERACTION\_TYPE, and PARTICIPANT\_B; possible INTERACTION\_TYPEs are described [here](http://www.pathwaycommons.org/pc/sif_interaction_rules.do).

```
sif <- toSif(system.file("extdata", "biopax3-short-metabolic-pathway.owl", package = "paxtoolsr"))
```

SIF representations of networks are returned as **data.frame** objects. SIF representations can be readily be visualized in network analysis tools, such as [Cytoscape](http://www.cytoscape.org), which can be interfaced with through the R package, [RCytoscape](http://www.bioconductor.org/packages/release/bioc/html/RCytoscape.html).

```
head(sif)
```

```
##               PARTICIPANT_A INTERACTION_TYPE              PARTICIPANT_B
## 1  Adenosine 5'-diphosphate  used-to-produce  Adenosine 5'-triphosphate
## 2  Adenosine 5'-diphosphate      reacts-with beta-D-glucose 6-phosphate
## 3  Adenosine 5'-diphosphate  used-to-produce             beta-D-glucose
## 4 Adenosine 5'-triphosphate  used-to-produce   Adenosine 5'-diphosphate
## 5 Adenosine 5'-triphosphate  used-to-produce beta-D-glucose 6-phosphate
## 6 Adenosine 5'-triphosphate      reacts-with             beta-D-glucose
```

### 4.3.2 Extended Simple Interaction Format (SIF) Network

Often analysis requires additional items of information, this could be the literature references related to a resource or the name of the data source where an interaction was derived. This information can be retrieved as part of an extended SIF network. A BioPAX dataset can be converted to extended SIF network.

```
# Select additional node and edge properties
inputFile <- system.file("extdata", "raf_map_kinase_cascade_reactome.owl", package = "paxtoolsr")

results <- toSifnx(inputFile = inputFile)
```

The **results** object is a list with two entries: nodes and edges. **nodes** will be a **data.table** where each row corresponds to a biological entity, an **EntityReference**, and will contain any user-selected node properties as additional columns. Similarly, **edges** will be a **data.table** with a SIF extended with any user-selected properties for an **Interaction** as additional columns. Information on possible properties for an EntityReference or Interaction is available through the [BioPAX ontology](http://www.biopax.org/owldoc/Level3/). It is also possible to download a pre-computed extended SIF representation for the entire [Pathway Commons database](http://www.pathwaycommons.org) that includes information about the data sources for interactions and identifiers for nodes; refer to documentation of the method for more details about the returned entries.

**NOTE:** Conversion of **results** entries from **data.table** to **data.frame** can be done using **setDF** in the **data.table** package.

**NOTE:** **downloadPc2** may take several minutes to complete.

```
results <- downloadPc2()
```

It is suggested that the results of this command be saved locally rather than using this command frequently to speed up work. Caching is attempted automatically, the location of downloaded files for this cache is available with this command:

```
Sys.getenv("PAXTOOLSR_CACHE")
```

# 5 Searching Pathway Commons

Networks can also be loaded using Pathway Commons rather than from local BioPAX files. First, we show how Pathway Commons can be searched.

```
## Search Pathway Commons for 'glycolysis'-related pathways
searchResults <- searchPc(q = "glycolysis", type = "pathway")
```

All functions that query Pathway Commons include a flag **verbose** that allows users to see the query URL sent to Pathway Commons for debugging purposes.

```
## Search Pathway Commons for 'glycolysis'-related pathways
searchResults <- searchPc(q = "glycolysis", type = "pathway", verbose = TRUE)
```

```
## URL:  http://www.pathwaycommons.org/pc2/search.xml?q=glycolysis&page=0&type=pathway
```

```
## No encoding supplied: defaulting to UTF-8.
```

Pathway Commons search results are returned as an XML object.

```
str(searchResults)
```

```
## Classes 'XMLInternalDocument', 'XMLAbstractDocument' <externalptr>
```

These results can be filtered using the **XML** package using XPath expressions; [examples of XPath expressions and syntax](http://www.w3schools.com/xpath/xpath_examples.asp). The examples here shows how to pull the name for the pathway and the URI that contains information about the pathway in the BioPAX format.

```
xpathSApply(searchResults, "/searchResponse/searchHit/name", xmlValue)[1]
```

```
## [1] "glycolysis I"
```

```
xpathSApply(searchResults, "/searchResponse/searchHit/pathway", xmlValue)[1]
```

```
## [1] "http://identifiers.org/reactome/R-HSA-1430728"
```

Alternatively, these XML results can be converted to data.frames using the **XML** and **plyr** libraries.

```
library(plyr)
searchResultsDf <- ldply(xmlToList(searchResults), data.frame)

# Simplified results
simplifiedSearchResultsDf <- searchResultsDf[, c("name", "uri", "biopaxClass")]
head(simplifiedSearchResultsDf)
```

```
##           name
## 1 glycolysis I
## 2   Glycolysis
## 3   Glycolysis
## 4   Glycolysis
## 5   Glycolysis
## 6   Glycolysis
##                                                                      uri
## 1 http://pathwaycommons.org/pc2/Pathway_969eac45ae803c84ac3066e1c35f31f8
## 2                            http://identifiers.org/reactome/R-HSA-70171
## 3                          http://identifiers.org/panther.pathway/P00024
## 4                        http://identifiers.org/wikipathways/WP661/b4868
## 5                        http://identifiers.org/wikipathways/WP690/fa8dc
## 6                        http://identifiers.org/wikipathways/WP690/e91ea
##   biopaxClass
## 1     Pathway
## 2     Pathway
## 3     Pathway
## 4     Pathway
## 5     Pathway
## 6     Pathway
```

This type of searching can be used to locally save BioPAX files retrieved from Pathway Commons.

```
## Use an XPath expression to extract the results of interest. In this case,
## the URIs (IDs) for the pathways from the results
tmpSearchResults <- xpathSApply(searchResults, "/searchResponse/searchHit/uri",
    xmlValue)

## Generate temporary file to save content into
biopaxFile <- tempfile()

## Extract a URI for a pathway in the search results and save into a file
idx <- which(grepl("panther", simplifiedSearchResultsDf$uri) & grepl("glycolysis",
    simplifiedSearchResultsDf$name, ignore.case = TRUE))
uri <- simplifiedSearchResultsDf$uri[idx]
saveXML(getPc(uri, format = "BIOPAX"), biopaxFile)
```

# 6 Extracting Information from BioPAX Datasets Using traverse()

The **traverse** function allows the extraction of specific entries from BioPAX records. traverse() functionality should be available for any **uniprot.org** or **purl.org** URI.

```
# Convert the Uniprot ID to a URI that would be found in Pathway Commons
uri <- paste0("http://identifiers.org/uniprot/P31749")

# Get URIs for only the ModificationFeatures of the protein
xml <- traverse(uri = uri, path = "ProteinReference/entityFeature:ModificationFeature")

# Extract all the URIs
uris <- xpathSApply(xml, "//value/text()", xmlValue)

# For the first URI get the modification position and type
tmpXml <- traverse(uri = uris[1], path = "ModificationFeature/featureLocation:SequenceSite/sequencePosition")
cat("Modification Position: ", xpathSApply(tmpXml, "//value/text()", xmlValue))
```

```
## Modification Position:  14
```

```
tmpXml <- traverse(uri = uris[1], path = "ModificationFeature/modificationType/term")
cat("Modification Type: ", xpathSApply(tmpXml, "//value/text()", xmlValue))
```

```
## Modification Type:  N6-acetyllysine MOD_RES N6-acetyllysine
```

# 7 Common Data Visualization Pathways and Network Analysis

## 7.1 Visualizing SIF Interactions from Pathway Commons using R Graph Libraries

A common use case for **paxtoolsr** to retrieve a network or sub-network from a pathway derived from a BioPAX file or a Pathway Commons query. Next, we show how to visualize subnetworks loaded from BioPAX files and retrieved using the Pathway Commons webservice. To do this, we use the **igraph** R graph library because it has simple methods for loading edgelists, analyzing the networks, and visualizing these networks.

Next, we show how subnetworks queried from Pathway Commons can be visualized directly in R using the **igraph** library. Alternatively, these graphical plots can be made using [Cytoscape](http://cytoscape.org) either by exporting the SIF format and then importing the SIF format into Cytoscape or by using the **RCytoscape** package to work with Cytoscape directly from R.

```
library(igraph)
```

We load the network from a BioPAX file using the SIF format:

```
sif <- toSif(system.file("extdata", "biopax3-short-metabolic-pathway.owl", package = "paxtoolsr"))

# graph.edgelist requires a matrix
g <- graph.edgelist(as.matrix(sif[, c(1, 3)]), directed = FALSE)
plot(g, layout = layout.fruchterman.reingold)
```

![](data:image/png;base64...)

## 7.2 Pathway Commons Graph Query

Next, we show how to perform graph search using Pathway Commons useful for finding connections and neighborhoods of elements. This can be used to extract the neighborhood of a single gene that is then filtered for a specific interaction type: “controls-state-change-of”. State change here indicates a modification of another molecule (e.g. post-translational modifications). This interaction type is directed, and it is read as “A controls a state change of B”.

```
gene <- "BDNF"
t1 <- graphPc(source = gene, kind = "neighborhood", format = "SIF", verbose = TRUE)
```

```
## URL:  http://www.pathwaycommons.org/pc2/graph?kind=neighborhood&source=BDNF&format=SIF
```

```
t2 <- t1[which(t1[, 2] == "controls-state-change-of"), ]

# Show only 100 interactions for simplicity
g <- graph.edgelist(as.matrix(t2[1:100, c(1, 3)]), directed = FALSE)
plot(g, layout = layout.fruchterman.reingold)
```

![](data:image/png;base64...)

The example below shows the extraction of a sub-network connecting a set of proteins:

```
genes <- c("AKT1", "IRS1", "MTOR", "IGF1R")
t1 <- graphPc(source = genes, kind = "PATHSBETWEEN", format = "SIF", verbose = TRUE)
```

```
## URL:  http://www.pathwaycommons.org/pc2/graph?kind=PATHSBETWEEN&source=AKT1&source=IRS1&source=MTOR&source=IGF1R&format=SIF
```

```
t2 <- t1[which(t1[, 2] == "controls-state-change-of"), ]

# Show only 100 interactions for simplicity
g <- graph.edgelist(as.matrix(t2[1:100, c(1, 3)]), directed = FALSE)
plot(g, layout = layout.fruchterman.reingold)
```

![](data:image/png;base64...)

## 7.3 Overlaying Experimental Data on Pathway Commons Networks

Often, it is useful not only to visualize a biological pathway, but also to overlay a given network with some form of biological data, such as gene expression values for genes in the network.

```
library(RColorBrewer)

# Generate a color palette that goes from white to red that contains 10 colors
numColors <- 10
colors <- colorRampPalette(brewer.pal(9, "Reds"))(numColors)

# Generate values that could represent some experimental values
values <- runif(length(V(g)$name))

# Scale values to generate indicies from the color palette
xrange <- range(values)
newrange <- c(1, numColors)

factor <- (newrange[2] - newrange[1])/(xrange[2] - xrange[1])
scaledValues <- newrange[1] + (values - xrange[1]) * factor
indicies <- as.integer(scaledValues)

# Color the nodes based using the indicies and the color palette created above
g <- set.vertex.attribute(g, "color", value = colors[indicies])

# get.vertex.attribute(h, 'color')

plot(g, layout = layout.fruchterman.reingold)
```

![](data:image/png;base64...)

## 7.4 Network Statistics

Often it is useful to produce statistics on a network. Here we show how to determine SIF network statistics and statistics on BioPAX files.

### 7.4.1 SIF Network Statistics

Once Pathway Commons and BioPAX networks are loaded as graphs using the **igraph** R package, it is possible to analyze these networks. Here we show how to get common statistics for the current network retrieved from Pathway Commons:

```
# Degree for each node in the igraph network
degree(g)
```

```
##   ACVR1    AKT1    AKT2    AKT3  ACVR1B  ACVR2A  ACVR2B  ACVRL1  AKT1S1
##       3      43      31      26       3       3       3       3       2
##  DEPTOR    IRS1 LAMTOR1 LAMTOR2 LAMTOR3 LAMTOR4 LAMTOR5   MLST8    MTOR
##       2       1       1       1       1       1       1       2       3
##    RHEB    RORC   RPTOR   RRAGA   RRAGB   RRAGC   RRAGD SLC38A9     ALK
##       1       3       2       1       1       1       1       1       3
##   AMHR2    ARAF  BMPR1A  BMPR1B   BMPR2    BRAF     BTK  CAMK2A  CAMK2B
##       3       3       3       3       3       3       3       3       3
##  CAMK2D  CAMK2G    CCNH    CDC7    CDK1    CDK2    CDK3    CDK4    CDK5
##       3       3       3       3       3       3       3       3       3
##    CDK6
##       2
```

```
# Number of nodes
length(V(g)$name)
```

```
## [1] 46
```

```
# Clustering coefficient
transitivity(g)
```

```
## [1] 0
```

```
# Network density
graph.density(g)
```

```
## [1] 0.09661836
```

```
# Network diameter
diameter(g)
```

```
## [1] 3
```

Another common task determine paths between nodes in a network.

```
# Get the first shortest path between two nodes
tmp <- get.shortest.paths(g, from = "IRS1", to = "MTOR")

# igraph seems to return different objects on Linux versus OS X for
# get.shortest.paths()
if (class(tmp[[1]]) == "list") {
    path <- tmp[[1]][[1]]  # Linux
} else {
    path <- tmp[[1]]  # OS X
}

# Convert from indicies to vertex names
V(g)$name[path]
```

```
## [1] "IRS1" "AKT1" "MTOR"
```

# 8 Gene Set Enrichment Analysis with Pathway Commons

The processing of the microarray data is taken from the following webpage: [Bioconductor Tutorial on Microarray Processing and Gene Set Analysis](http://www.bioconductor.org/help/course-materials/2005/BioC2005/labs/lab01/estrogen/) with for grabbing gene sets from a Pathway Commons pathway and using same data as in the example, but stored in the **estrogen** R package.

To access microarray data sets, users should consider retrieving data from the NCBI Gene Expression Omnibus (GEO) using the [GEOQuery package](http://www.bioconductor.org/packages/2.13/bioc/html/GEOquery.html).

The first thing we’ll do is load up the necessary packages.

```
library(paxtoolsr)  # To retrieve data from Pathway Commons
library(limma)  # Contains geneSetTest
library(affy)  # To load microarray data
library(hgu95av2)  # Annotation packages for the hgu95av2 platform
library(hgu95av2cdf)
```

```
## Warning: replacing previous import 'AnnotationDbi::tail' by 'utils::tail'
## when loading 'hgu95av2cdf'
```

```
## Warning: replacing previous import 'AnnotationDbi::head' by 'utils::head'
## when loading 'hgu95av2cdf'
```

```
library(XML)  # To parse XML files
```

We then retrieve a pathway of interest using the the Pathway Commons search functionality.

```
# Generate a Gene Set Search Pathway Commons for 'glycolysis'-related pathways
searchResults <- searchPc(q = "glycolysis", type = "pathway")

## Use an XPath expression to extract the results of interest. In this case,
## the URIs (IDs) for the pathways from the results
searchResults <- xpathSApply(searchResults, "/searchResponse/searchHit/uri", xmlValue)

## Generate temporary files to save content into
biopaxFile <- tempfile()

## Extract the URI for the first pathway in the search results and save into a
## file
uri <- searchResults[2]
saveXML(getPc(uri, "BIOPAX"), biopaxFile)
```

And then, we convert this pathway to a gene set.

```
## Generate temporary files to save content into
gseaFile <- tempfile()

## Generate a gene set for the BioPAX pathway with gene symbols NOTE: Not all
## search results are guaranteed to result in gene sets
tmp <- toGSEA(biopaxFile, gseaFile, "HGNC Symbol", FALSE)
geneSet <- tmp$geneSet
```

Finally, we process the microarray data and apply the gene set entrichment analysis.

```
# Process Microarray Data Load/process the estrogen microarray data
estrogenDataDir <- system.file("extdata", package = "estrogen")
targets <- readTargets(file.path(estrogenDataDir, "estrogen.txt"), sep = "")

abatch <- ReadAffy(filenames = file.path(estrogenDataDir, targets$filename))
eset <- rma(abatch)
```

```
## Background correcting
## Normalizing
## Calculating Expression
```

```
f <- paste(targets$estrogen, targets$time.h, sep = "")
f <- factor(f)
design <- model.matrix(~0 + f)
colnames(design) <- levels(f)

fit <- lmFit(eset, design)

cont.matrix <- makeContrasts(E10 = "present10-absent10", E48 = "present48-absent48",
    Time = "absent48-absent10", levels = design)

fit2 <- contrasts.fit(fit, cont.matrix)
fit2 <- eBayes(fit2)

## Map the gene symbols to the probe IDs
symbol <- unlist(as.list(hgu95av2SYMBOL))

### Check that the gene symbols are on the microarray platform
genesOnChip <- match(geneSet, symbol)
genesOnChip  # CHECK FOR ERROR HERE
```

```
## integer(0)
```

```
genesOnChip <- genesOnChip[!is.na(genesOnChip)]

### Grab the probe IDs for the genes present
genesOnChip <- names(symbol[genesOnChip])
genesOnChip <- match(genesOnChip, rownames(fit2$t))
genesOnChip <- genesOnChip[!is.na(genesOnChip)]

## Run the Gene Set Test from the limma Package
geneSetTest(genesOnChip, fit2$t[, 1], "two.sided")
```

```
## [1] 2
```

# 9 ID Mapping

Functions and results from **paxtoolsr** functions can be used in conjunction with the ID mapping functions of the [**biomaRt** Bioconductor package](http://www.bioconductor.org/packages/release/bioc/html/biomaRt.html); users should check the the **biomaRt** package documentation for a list of possible ID types.

```
sif <- toSif(system.file("extdata", "raf_map_kinase_cascade_reactome.owl", package = "paxtoolsr"))

# Generate a mapping between the HGNC symbols in the SIF to the Uniprot IDs
library(biomaRt)
ensembl <- useMart("ensembl")
ensembl <- useDataset("hsapiens_gene_ensembl", mart = ensembl)

hgnc_symbol <- c(sif$PARTICIPANT_A, sif$PARTICIPANT_B)
output <- getBM(attributes = c("hgnc_symbol", "uniprot_sptrembl"), filters = "hgnc_symbol",
    values = hgnc_symbol, mart = ensembl)

# Remove blank entries
output <- output[output[, 2] != "", ]
```

# 10 Troubleshooting

## 10.1 File Paths

Use properly delimited and full paths (do not use relative paths, such as ../directory/file or ~/directory/file) to files should be used with the **paxtoolsr** package.

```
toSif("/directory/file")
# or
toSif("X:\\directory\\file")
```

## 10.2 Memory Limits: Specify JVM Maximum Heap Size

By default **paxtoolsr** uses a maximum heap size limit of 512MB. For large BioPAX files, this limit may be insufficient. The code below shows how to change this limit and observe that the change was made.

**NOTE:** This limit cannot be changed once the virtual machine has been initialized
by loading the library, so the memory heap size limit must be changed beforehand.

```
options(java.parameters = "-Xmx1024m")

library(paxtoolsr)

# Megabyte size
mbSize <- 1048576

runtime <- .jcall("java/lang/Runtime", "Ljava/lang/Runtime;", "getRuntime")
maxMemory <- .jcall(runtime, "J", "maxMemory")
maxMemoryMb <- maxMemory/mbSize
cat("Max Memory: ", maxMemoryMb, "\n")
```

# 11 Session Information

```
sessionInfo()
```

```
## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8          LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8           LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8       LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8          LC_NAME=en_US.UTF-8
##  [9] LC_ADDRESS=en_US.UTF-8        LC_TELEPHONE=en_US.UTF-8
## [11] LC_MEASUREMENT=en_US.UTF-8    LC_IDENTIFICATION=en_US.UTF-8
##
## attached base packages:
## [1] parallel  stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] hgu95av2cdf_2.18.0  hgu95av2_2.2.0      affy_1.60.0
##  [4] Biobase_2.42.0      BiocGenerics_0.28.0 limma_3.38.0
##  [7] RColorBrewer_1.1-2  igraph_1.2.2        plyr_1.8.4
## [10] paxtoolsr_1.16.0    XML_3.98-1.16       rJava_0.9-10
## [13] knitr_1.20          BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] xfun_0.4              htmltools_0.3.6       stats4_3.5.1
##  [4] yaml_2.2.0            blob_1.1.1            utf8_1.1.4
##  [7] rlang_0.3.0.1         R.oo_1.22.0           pillar_1.3.0
## [10] DBI_1.0.0             R.utils_2.7.0         bit64_0.9-7
## [13] affyio_1.52.0         stringr_1.3.1         zlibbioc_1.28.0
## [16] R.methodsS3_1.7.1     memoise_1.1.0         evaluate_0.12
## [19] IRanges_2.16.0        curl_3.2              fansi_0.4.0
## [22] AnnotationDbi_1.44.0  preprocessCore_1.44.0 Rcpp_0.12.19
## [25] readr_1.1.1           backports_1.1.2       BiocManager_1.30.3
## [28] formatR_1.5           S4Vectors_0.20.0      jsonlite_1.5
## [31] bit_1.1-14            rjson_0.2.20          hms_0.4.2
## [34] digest_0.6.18         stringi_1.2.4         bookdown_0.7
## [37] rprojroot_1.3-2       cli_1.0.1             tools_3.5.1
## [40] magrittr_1.5          RSQLite_2.1.1         tibble_1.4.2
## [43] crayon_1.3.4          pkgconfig_2.0.2       assertthat_0.2.0
## [46] rmarkdown_1.10        httr_1.3.1            R6_2.3.0
## [49] compiler_3.5.1
```

# 12 References

* Cerami EG, Gross BE, Demir E, Rodchenkov I, Babur O, Anwar N, Schultz N, Bader GD, Sander C. Pathway Commons, a web resource for biological pathway data. Nucleic Acids Res. 2011 Jan;39(Database issue):D685-90. doi: 10.1093/nar/gkq1039. Epub 2010 Nov 10.
* Rodchenkov I, Demir E, Sander C, Bader GD. The BioPAX Validator. Bioinformatics. 2013 Oct 15;29(20):2659-60. doi: 10.1093/bioinformatics/btt452. Epub 2013 Aug 5.