# PhyloProfile

Vinh Tran1\*

1Goethe University Frankfurt, Frankfurt am Main, Germany

\*tran@bio.uni-frankfurt.de

#### 2025-11-20

#### Abstract

PhyloProfile: dynamic visualization and exploration of multi-layered
phylogenetic profiles

#### Package

PhyloProfile 2.2.2

# Introduction

Phylogenetic profiles capture the presence - absence pattern of genes across
species (Pellegrini et al., 1999). The presence of an ortholog in a given
species is often taken as evidence that also the corresponding function is
represented (Lee et al., 2007). Moreover, if two genes agree in their
phylogenetic profile, it can suggest that they functionally interact
(Pellegrini et al., 1999). Phylogenetic profiles are therefore commonly used
for tracing functional protein clusters or metabolic networks across species
and through time. However, orthology inference is not error-free (Altenhoff
et al., 2016), and orthology does not guarantee functional equivalence for
two genes (Studer and Robinson-Rechavi, 2009). Therefore, phylogenetic
profiles are often integrated with accessory information layers, such as
sequence similarity, domain architecture similarity, or semantic similarity
of Gene Ontology-term descriptions.

Various approaches exist to visualize such profiles. However, there is still a
shortage of tools that provide a comprehensive set of functions for the display,
filtering and analysis of multi-layered phylogenetic profiles comprising
hundreds of genes and taxa. To close this methodological gap, we present here
**PhyloProfile**, an *R-based tool to visualize, explore and analyze
multi-layered phylogenetic profiles*.

# How to install PhyloProfile

To install the PhyloProfile package via
[Bioconductor](https://bioconductor.org/packages/PhyloProfile)
using BiocManager:

```
if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("PhyloProfile")
```

To install the dev version from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version='devel')
BiocManager::install("PhyloProfile")
```

To install the dev version from [github](https://github.com/BIONF/PhyloProfile):

```
if (!requireNamespace("remotes"))
    install.packages("remotes", repos = "http://cran.us.r-project.org")
remotes::install_github(
    "BIONF/PhyloProfile",
    INSTALL_opts = c('--no-lock'),
    build_vignettes = TRUE
)
```

Or use directly the online version at
<http://applbio.biologie.uni-frankfurt.de/phyloprofile/>.

# Input

PhyloProfile expects as a main input the phylogenetic distribution of orthologs,
or more generally of homologs. This information can be complemented with domain
architecture annotation and data for up to two additional annotation layers.

Beside tab delimited text and sequences in FASTA format, the tool also accepts
orthoXML (Schmitt et al., 2011), or a list of OMA IDs (Altenhoff et al., 2015)
as input.

Here is an example of a tab delimited input with two additional annotation
layers:

| geneID | ncbiID | orthoID | FAS\_F | FAS\_B |
| --- | --- | --- | --- | --- |
| 100136at6656 | ncbi36329 | 100136at6656|PLAF7@36329@1|Q8ILT8|1 | 0.9875289 | 0.8427314 |
| 100136at6656 | ncbi319348 | 100136at6656|POLVAN@319348@0|319348\_0:004132|1 | 1.0000000 | 1.0000000 |
| 100136at6656 | ncbi208964 | 100136at6656|PSEAE@208964@1|Q9I5U5|1 | 0.9971027 | 0.9971027 |
| 100136at6656 | ncbi418459 | 100136at6656|PUCGT@418459@1|E3KFA2|1 | 0.9895679 | 0.8232540 |
| 100136at6656 | ncbi10116 | 100136at6656|RAT@10116@1|G3V7R8|1 | 0.9996617 | 0.8541265 |
| 100136at6656 | ncbi284812 | 100136at6656|SCHPO@284812@1|Q9USU2|1 | 0.9994874 | 0.9994874 |
| 100136at6656 | ncbi35128 | 100136at6656|THAPS@35128@1|B8C2N6|1 | 0.9852370 | 0.7002961 |
| 100136at6656 | ncbi7070 | 100136at6656|TRICA@7070@1|D6X457|1 | 1.0000000 | 1.0000000 |
| 100136at6656 | ncbi237631 | 100136at6656|USTMA@237631@1|A0A0D1C927|1 | 0.9912998 | 0.6172244 |
| 100136at6656 | ncbi559292 | 100136at6656|YEAST@559292@1|P41819|1 | 0.9978912 | 0.9978912 |

*The [WIKI](https://github.com/BIONF/PhyloProfile/wiki/Input-Data) accompanying
PhyloProfile gives a comprehensive guide of how to format input data.*

# Features and capabilities

## Interactive visualization and dynamic exploration of phylogenetic profiles

Together with several functions for exploring phylogenetic profiles, we provide
an interactive visualization application implemented with
[Shiny](https://shiny.rstudio.com) ([https://CRAN.R-project.org/package=shiny](https://CRAN.R-project.org/package%3Dshiny)).

![PhyloProfile's GUI](data:image/png;base64...)

Figure 1: PhyloProfile’s GUI

For both command-based and visualization analyses, users can:

* dynamically **change the resolution of the analysis** from invidual species
  to phyla or entire kingdoms by collapsing the input taxa into higher systematic
  rank. Species are automatically linked to the NCBI taxonomy, and are ordered
  in increasing taxonomic distance from a user-specified reference taxon.
  *PhyloProfile is able to represent co-orthologs (in-paralogs), if the working
  taxonomic rank is the deepest one (e.g. strain or species) that can be
  found in the input taxa.*
* dynamically **filter data** by applying different thresholds to the integrated
  information (e.g. increasing the fraction of species in a systematic group that
  must harbor an ortholog before the gene is considered present in this group
  reduces the impact of spurious ortholog identification on evolutionary
  interpretations).
* dynamically **modify the apperance of profile** with diverse plot
  configuration options.

PhyloProfile is able to represent the entire data matrix (`Main profile`) or to
visualize only a subset of genes and taxa for a detailed inspection
(`Customized profile`), without the need of modifying the input data.

Besides, PhyloProfile’s interface will be automatically varied according to
user’s input files, such as the names of two additional information layers or
list of input taxa.

## Analysis functions

PhyloProfile provides several functions for dynamically analyzing phylogenetic
profiles.

### Profile clustering

The identification of proteins with similar phylogenetic profiles is a crucial
step in the identification and characterization of novel functional protein
interaction networks (Pellegrini, 2012). PhyloProfile offers the option to
cluster genes according to the distance of their phylogenetic profiles.

```
### An example for plotting the clustered profiles tree.
### See ?getDendrogram for more details.

#' Load built-in data
data("finalProcessedProfile", package="PhyloProfile")
data <- finalProcessedProfile

#' Calculate distance matrix
#' Check ?getDistanceMatrix
profileType <- "binary"
profiles <- getDataClustering(
    data, profileType, var1AggregateBy, var2AggregateBy)
method <- "mutualInformation"
distanceMatrix <- getDistanceMatrix(profiles, method)

#' Create clustered profile tree
clusterMethod <- "complete"
dd <- clusterDataDend(as.dist(distanceMatrix), clusterMethod)
getDendrogram(dd)
#> $type
#> [1] "phylogram"
#>
#> $use.edge.length
#> [1] TRUE
#>
#> $node.pos
#> [1] 1
#>
#> $node.depth
#> [1] 1
#>
#> $show.tip.label
#> [1] TRUE
#>
#> $show.node.label
#> [1] FALSE
#>
#> $font
#> [1] 3
#>
#> $cex
#> [1] 1
#>
#> $adj
#> [1] 0
#>
#> $srt
#> [1] 0
#>
#> $no.margin
#> [1] FALSE
#>
#> $label.offset
#> [1] 0
#>
#> $x.lim
#> [1] 0.0000000 0.1199475
#>
#> $y.lim
#> [1] 1 4
#>
#> $direction
#> [1] "rightwards"
#>
#> $tip.color
#> [1] "black"
#>
#> $Ntip
#> [1] 4
#>
#> $Nnode
#> [1] 3
#>
#> $root.time
#> NULL
#>
#> $align.tip.label
#> [1] FALSE
```

![](data:image/png;base64...)

### Gene age estimation

PhyloProfile can estimate the evolutionary age of a gene from the phylogenetic
profiles using an LCA algorithm (Capra et al., 2013). Specifically, the last
common ancestor of the two most distantly related species displaying a given
gene serves as the minimal gene age. Age estimates are dynamically updated
upon filtering of the data.

```
### An example for calculating gene age for the built-in data set.
### See ?estimateGeneAge for more details.
#' Load built-in data
data("fullProcessedProfile", package="PhyloProfile")

#' Choose the working rank and the reference taxon
rankName <- "class"
refTaxon <- "Mammalia"

#' Count taxa within each supertaxon
taxonIDs <- levels(as.factor(fullProcessedProfile$ncbiID))
sortedInputTaxa <- sortInputTaxa(
    taxonIDs, rankName, refTaxon, NULL, NULL, NULL
)
library(dplyr)
#>
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#>
#>     filter, lag
#> The following objects are masked from 'package:base':
#>
#>     intersect, setdiff, setequal, union
taxaCount <- sortedInputTaxa %>% dplyr::count(supertaxon)

#' Set cutoff for 2 additional variables and the percentage of present species
#' in each supertaxon
var1Cutoff <- c(0,1)
var2Cutoff <- c(0,1)
percentCutoff <- c(0,1)

#' Estimate gene age
estimateGeneAge(
    fullProcessedProfile, taxaCount, rankName, refTaxon,
    var1Cutoff, var2Cutoff, percentCutoff
)
#> Key: <geneID>
#>          geneID      cath                           age
#>          <char>    <char>                        <char>
#> 1: 100136at6656 000000001 10_Archaea-Bacteria-Eukaryota
#> 2: 100265at6656 000000111               06_Opisthokonta
#> 3: 101621at6656 000000001 10_Archaea-Bacteria-Eukaryota
#> 4: 103479at6656 000000011                  08_Eukaryota
```

### Core gene identification

Phylogenomic reconstructions are typically based on a collection of core genes
(Daubin et al., 2002), i.e. genes that are shared among all genomes in a taxon
collection. PhyloProfile enables users to select a set of taxa and returns
their core genes.

```
### An example for calculating core gene set for the built-in data set.
### See ?getCoreGene for more details.

#' Load built-in data
data("fullProcessedProfile", package="PhyloProfile")

#' Choose the working rank and a set of taxa of interest
rankName <- "class"
refTaxon <- "Mammalia"
taxaCore <- c("Mammalia", "Saccharomycetes", "Insecta")

#' Set cutoff for 2 additional variables and the percentage of present species
#' in each supertaxon
var1Cutoff <- c(0.75, 1.0)
var2Cutoff <- c(0.75, 1.0)
percentCutoff <- c(0.0, 1.0)

#' Set core coverage, the % of taxa that must be present in the selected set
coreCoverage <- 1

#' Count taxa within each supertaxon
taxonIDs <- levels(as.factor(fullProcessedProfile$ncbiID))
sortedInputTaxa <- sortInputTaxa(
    taxonIDs, rankName, refTaxon, NULL, NULL, NULL
)
taxaCount <- sortedInputTaxa %>% dplyr::count(supertaxon)

#' Identify core genes
getCoreGene(
    rankName,
    taxaCore,
    fullProcessedProfile,
    taxaCount,
    var1Cutoff, var2Cutoff,
    percentCutoff, coreCoverage
)
#> [1] "100136at6656" "100265at6656" "101621at6656" "103479at6656"
```

### Group comparison

This function is used to compare the distribution of the additional variables
between two taxon groups, an in- and an out-group. Users can define the in-group
and all taxa not included in this are used as the out-group. The value
distributions of the variables are then compared using statistical tests
(Kolmogorov-Smirnov and Wilcoxon-Mann-Whitney) using the specified significant
level (*0.05 by default*). Genes that have a significantly different
distribution will be shown in the candidate gene list for further analysis.

```
#' Load built-in data
data("mainLongRaw", package="PhyloProfile")
data <- mainLongRaw
#' choose the in-group taxa
inGroup <- c("ncbi9606", "ncbi10116")
#' choose variable to be compared
variable <- colnames(data)[4]
#' compare the selected variable between the in-group and out-group taxa
compareTaxonGroups(data, inGroup, TRUE, variable, 0.05)
#> 103479at6656 100136at6656 101621at6656 100265at6656
#>    0.1399542    0.4889198    0.5620258    0.5850421
```

### Distribution analysis

The interpretation of phylogenetic profiles, and the result of downstream
analyses can change substantially upon filtering the data. To help users to
decide on reasonable filtering thresholds, PhyloProfile provides a function to
plot the distributions of the values incurred by the integrated information
layers.

```
### An example for plotting the distribution of the 1st additional variable.
### See ?createVarDistPlot for more details.

#' Load built-in data
data("mainLongRaw", package="PhyloProfile")

#' Process data for distribution analysis
#' See ?createVariableDistributionData
data <- createVariableDistributionData(
    mainLongRaw, c(0, 1), c(0.5, 1)
)
head(data, 6)
#>                                             orthoID      var1      var2
#> 4596            100136at6656|PLAF7@36329@1|Q8ILT8|1 0.9875289 0.8427314
#> 4597 100136at6656|POLVAN@319348@0|319348_0:004132|1 1.0000000 1.0000000
#> 4598           100136at6656|PSEAE@208964@1|Q9I5U5|1 0.9971027 0.9971027
#> 4599           100136at6656|PUCGT@418459@1|E3KFA2|1 0.9895679 0.8232540
#> 4600              100136at6656|RAT@10116@1|G3V7R8|1 0.9996617 0.8541265
#> 4602           100136at6656|SCHPO@284812@1|Q9USU2|1 0.9994874 0.9994874

#' Choose a variable for plotting and set the variable name
varType <- "var1"
varName <- "Variable 1"

#' Set cutoff for the percentage of present species in each supertaxon
percentCutoff <- c(0,1)

#' Set text size
distTextSize <- 12

#' Create distribution plot
createVarDistPlot(
    data,
    varName,
    varType,
    percentCutoff,
    distTextSize
)
```

![](data:image/png;base64...)

# Examples

## Process raw input

Process raw input (in different format) into a dataframe that contains all
required information for the phylogenetic profile analysis.

```
#' Load built-in data
#' If input data is in other format (e.g. fasta, OrthoXML, or wide matrix),
#' see ?createLongMatrix
rawInput <- system.file(
    "extdata", "test.main.long", package = "PhyloProfile", mustWork = TRUE
)

#' Set working rank and the reference taxon
rankName <- "class"
refTaxon <- "Mammalia"

#' Input a user-defined taxonomy tree to replace NCBI taxonomy tree (optional)
taxaTree <- NULL
#' Or a sorted taxon list (optional)
sortedTaxonList <- NULL

#' Choose how to aggregate the additional variables when pocessing the data
#' into supertaxon
var1AggregateBy <- "max"
var2AggregateBy <- "mean"

#' Set cutoffs for for percentage of species present in a supertaxon,
#' allowed number of co orthologs, and cutoffs for the additional variables
percentCutoff <- c(0.0, 1.0)
coorthologCutoffMax <- 10
var1Cutoff <- c(0.75, 1.0)
var2Cutoff <- c(0.5, 1.0)

#' Choose the relationship of the additional variables, if they are related to
#' the orthologous proteins or to the species
var1Relation <- "protein"
var2Relation <- "species"

#' Identify categories for input genes (by a mapping tab-delimited file)
groupByCat <- FALSE
catDt <- NULL

#' Process the input file into a phylogenetic profile data that contains
#' taxonomy information and the aggregated values for the 2 additional variables
profileData <- fromInputToProfile(
    rawInput,
    rankName,
    refTaxon,
    taxaTree,
    sortedTaxonList,
    var1AggregateBy,
    var2AggregateBy,
    percentCutoff,
    coorthologCutoffMax,
    var1Cutoff,
    var2Cutoff,
    var1Relation,
    var2Relation,
    groupByCat,
    catDt
)

head(profileData)
#> # A tibble: 6 × 12
#>   geneID   supertaxon supertaxonID  var1 presSpec category orthoID  var2 paralog
#>   <fct>    <fct>             <dbl> <dbl>    <dbl> <fct>    <chr>   <dbl>   <dbl>
#> 1 100136a… 100001_Ma…        40674 1.000        1 cat      100136… 0.867       1
#> 2 100136a… 100002_Av…         8782 0.999        1 cat      100136… 0.999       1
#> 3 100136a… 100003_Ac…       186623 1            1 cat      100136… 0.828       1
#> 4 100136a… 100005_Le…      2682552 1            1 cat      100136… 1           1
#> 5 100136a… 100006_In…        50557 1            1 cat      100136… 0.917       1
#> 6 100136a… 100007_Br…         6658 0.989        1 cat      100136… 0.729       1
#> # ℹ 3 more variables: presentTaxa <int>, totalTaxa <int>, geneName <fct>
```

## Create profile plot

Generate phylogenetic profile heatmap after processing the raw input file.

```
#' Load built-in processed data
data("finalProcessedProfile", package="PhyloProfile")

#' Create data for plotting
plotDf <- dataMainPlot(finalProcessedProfile)

#' You can also choose a subset of genes and/or taxa for plotting with:
#' selectedTaxa <- c("Mammalia", "Echinoidea", "Gunneridae")
#' selectedSeq <- "all"
#' plotDf <- dataCustomizedPlot(
#'     finalProcessedProfile, selectedTaxa, selectedSeq
#' )

#' Identify plot's parameters
plotParameter <- list(
    "xAxis" = "taxa",
    "var1ID" = "FAS_FW",
    "var2ID"  = "FAS_BW",
    "midVar1" = 0.5,
    "midColorVar1" =  "#FFFFFF",
    "lowColorVar1" =  "#FF8C00",
    "highColorVar1" = "#4682B4",
    "midVar2" = 1,
    "midColorVar2" =  "#FFFFFF",
    "lowColorVar2" = "#CB4C4E",
    "highColorVar2" = "#3E436F",
    "paraColor" = "#07D000",
    "xSize" = 8,
    "ySize" = 8,
    "legendSize" = 8,
    "mainLegend" = "top",
    "dotZoom" = 0,
    "xAngle" = 60,
    "guideline" = 0,
    "colorByGroup" = FALSE,
    "colorByOrthoID" = FALSE
)

#' Generate profile plot
p <- heatmapPlotting(plotDf, plotParameter)
p
#' To highlight a gene and/or taxon of interest
taxonHighlight <- "Mammalia"
workingRank <- "class"
geneHighlight <- "none"
#' Then use ?highlightProfilePlot function
# highlightProfilePlot(
#    p, plotDf, taxonHighlight, workingRank, geneHighlight, plotParameter$xAxis
# )
```

![](data:image/png;base64...)

## Create protein domain architecture plot

Generate the domain architecture plot for a gene of interest and its orthologs.

```
#' Load protein domain architecture file
domainFile <- system.file(
    "extdata", "domainFiles/101621at6656.domains",
    package = "PhyloProfile", mustWork = TRUE
)

#' Identify IDs of gene of interest and its ortholog partner
seedID <- "101621at6656"
orthoID <- "101621at6656|AGRPL@224129@0|224129_0:001955|1"
info <- c(seedID, orthoID)

#' Get data for 2 selected genes from input file
domainDf <- parseDomainInput(seedID, domainFile, "file")

#' Modify feature IDs
domainDf$feature_id_mod <- domainDf$feature_id
domainDf$feature_id_mod <- gsub("SINGLE", "LCR", domainDf$feature_id_mod)
domainDf$feature_id_mod[domainDf$feature_type == "coils"] <- "Coils"
domainDf$feature_id_mod[domainDf$feature_type == "seg"] <- "LCR"
domainDf$feature_id_mod[domainDf$feature_type == "tmhmm"] <- "TM"

#' Generate plot
plot <- createArchiPlot(info, domainDf, 9, 9)
grid::grid.draw(plot)
```

![](data:image/png;base64...)

## Other use cases

**Get taxonomy IDs and names in a specified rank for taxa in the input file.**

```
#' Load raw input
data("mainLongRaw", package="PhyloProfile")
inputDf <- mainLongRaw

#' Set working rank and the reference taxon
rankName <- "phylum"

#' Get taxonomy IDs and names for the input data
inputTaxonID <- getInputTaxaID(inputDf)
inputTaxonName <- getInputTaxaName(rankName, inputTaxonID)

head(inputTaxonName)
#>   ncbiID            fullName   rank parentID
#> 1   1117       Cyanobacteria phylum  1798711
#> 2   1224      Proteobacteria phylum        2
#> 3   1224      Proteobacteria phylum        2
#> 4   1224      Proteobacteria phylum        2
#> 5   1297 Deinococcus-Thermus phylum  1783272
#> 6   2836     Bacillariophyta phylum  2696291
```

**Get taxonomy info for list of input taxa and sort it based on the taxonomy**
**distance to a reference taxon**

```
#' Get list of taxon IDs and names for input profile
data("mainLongRaw", package="PhyloProfile")
inputDf <- mainLongRaw
rankName <- "phylum"
inputTaxonID <- getInputTaxaID(inputDf)

#' Input a user-defined taxonomy tree to replace NCBI taxonomy tree (optional)
inputTaxaTree <- NULL

#' Sort taxonomy list based on a selected refTaxon
refTaxon <- "Chordata"
sortedTaxonomy <- sortInputTaxa(
    taxonIDs = inputTaxonID,
    rankName = rankName,
    refTaxon = refTaxon,
    taxaTree = inputTaxaTree,
    NULL,
    NULL
)

head(
    sortedTaxonomy[
        , c("ncbiID", "fullName", "supertaxon", "supertaxonID", "rank")
    ]
)
#>       ncbiID                  fullName         supertaxon supertaxonID   rank
#> 1  ncbi36329 Plasmodium falciparum 3D7 100010_Apicomplexa         5794 phylum
#> 2 ncbi224324      Aquifex aeolicus VF5   100018_Aquificae       200783 phylum
#> 3   ncbi7165         Anopheles gambiae  100002_Arthropoda         6656 phylum
#> 4 ncbi319348  Polypedilum vanderplanki  100002_Arthropoda         6656 phylum
#> 5   ncbi7260     Drosophila willistoni  100002_Arthropoda         6656 phylum
#> 6   ncbi7227   Drosophila melanogaster  100002_Arthropoda         6656 phylum
```

**More examples? Please tell us what you want to see ;-)**

# How to cite

> Ngoc-Vinh Tran, Bastian Greshake Tzovaras, Ingo Ebersberger, PhyloProfile:
> dynamic visualization and exploration of multi-layered phylogenetic profiles,
> Bioinformatics, Volume 34, Issue 17, 01 September 2018, Pages 3041–3043,
> <https://doi.org/10.1093/bioinformatics/bty225>

Or use the citation function in R CMD to have the citation in BibTex or
LaTeX format

```
citation("PhyloProfile")
#> To cite PhyloProfile in publications, please use:
#>
#>   Vinh Tran, Ingo Ebersberger (2025). "PhyloProfile v2 - Exploring
#>   multi-layered phylogenetic profiles at scale." Preprint available at
#>   arXiv: https://doi.org/10.48550/arXiv.2504.19710.
#>
#>   Ngoc-Vinh Tran, Bastian Greshake Tzovaras, Ingo Ebersberger;
#>   PhyloProfile: Dynamic visualization and exploration of multi-layered
#>   phylogenetic profiles, Bioinformatics, Volume 34, Issue 17, 01
#>   September 2018, Pages 3041-3043
#>   https://doi.org/10.1093/bioinformatics/bty225
#>
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

# How to contribute

Thanks so much for your interest in contributing to *PhyloProfile* 🎉👍🍾

Contributions to *PhyloProfile* can take many forms. If you are

**biologist**, you can

* [report bugs](https://github.com/BIONF/PhyloProfile/issues/new) for both
  online & standalone version,
* [tell us about what features you would love to see](https://goo.gl/SBU4EG),
* improve our documentation, both
  [in the Wiki](https://github.com/BIONF/PhyloProfile/wiki) and in our
  [README](https://github.com/BIONF/PhyloProfile/blob/master/README.md),
* discuss about [non-coding issues](https://goo.gl/bDS9Cb)

**biologist and love coding**, you can

* [fix existing bugs](https://github.com/BIONF/PhyloProfile/issues/),
* or add new features. Some things we’d love to see are: add scripts to add
  out-of-the-box support for further orthology prediction tools, increasing the
  test coverage from 0% to something above that, or basically whatever great
  idea you have!
* and all points for non-coding contributors as well :)

**not biologist but can code**, it would be great if you can

* test the tool in different environments (Windows, Linux, Mac - Firefox,
  Chrome, IE, Safari,…),
* suggest a better user interface,
* improve the code quality

Don’t hesitate to get in touch with us if you have any questions. You can
contact us at tran@bio.uni-frankfurt.de

## Contributors

* [Vinh Tran](https://github.com/trvinh)
* [Bastian Greshake Tzovaras](https://github.com/gedankenstuecke)
* [Carla Moelbert](https://github.com/CarlaMoelbert)

# SessionInfo()

Here is the output of `sessionInfo()` on the system on which this document was
compiles:

```
#> R version 4.5.2 (2025-10-31)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> character(0)
#>
#> other attached packages:
#> [1] PhyloProfile_2.2.2
#>
#> loaded via a namespace (and not attached):
#>   [1] bitops_1.0-9          pbapply_1.7-4         gridExtra_2.3
#>   [4] rlang_1.1.6           magrittr_2.0.4        otel_0.2.0
#>   [7] compiler_4.5.2        png_0.1-8             systemfonts_1.3.1
#>  [10] vctrs_0.6.5           gsl_2.1-9             stringr_1.6.0
#>  [13] pkgconfig_2.0.3       crayon_1.5.3          fastmap_1.2.0
#>  [16] XVector_0.50.0        energy_1.7-12         labeling_0.4.3
#>  [19] utf8_1.2.6            promises_1.5.0        rmarkdown_2.30
#>  [22] grDevices_4.5.2       purrr_1.2.0           xfun_0.54
#>  [25] Rfast_2.1.5.2         cachem_1.1.0          graphics_4.5.2
#>  [28] jsonlite_2.0.0        shinyFiles_0.9.3      later_1.4.4
#>  [31] parallel_4.5.2        R6_2.6.1              stringi_1.8.7
#>  [34] bslib_0.9.0           RColorBrewer_1.1-3    reticulate_1.44.1
#>  [37] boot_1.3-32           bsplus_0.1.5          lubridate_1.9.4
#>  [40] jquerylib_0.1.4       scattermore_1.2       Rcpp_1.1.0
#>  [43] Seqinfo_1.0.0         bookdown_0.45         knitr_1.50
#>  [46] zoo_1.8-14            IRanges_2.44.0        httpuv_1.6.16
#>  [49] Matrix_1.7-4          timechange_0.3.0      tidyselect_1.2.1
#>  [52] dichromat_2.0-0.1     yaml_2.3.10           miniUI_0.1.2
#>  [55] lattice_0.22-7        tibble_3.3.0          withr_3.0.2
#>  [58] Biobase_2.70.0        shiny_1.11.1          S7_0.2.1
#>  [61] askpass_1.2.1         evaluate_1.0.5        base_4.5.2
#>  [64] tsne_0.1-3.1          RcppParallel_5.1.11-1 xml2_1.5.0
#>  [67] Biostrings_2.78.0     pillar_1.11.1         shinycssloaders_1.1.0
#>  [70] BiocManager_1.30.27   DT_0.34.0             stats4_4.5.2
#>  [73] shinyjs_2.1.0         plotly_4.11.0         generics_0.1.4
#>  [76] RCurl_1.98-1.17       S4Vectors_0.48.0      ggplot2_4.0.1
#>  [79] scales_1.4.0          BiocStyle_2.38.0      stats_4.5.2
#>  [82] xtable_1.8-4          glue_1.8.0            lazyeval_0.2.2
#>  [85] tools_4.5.2           datasets_4.5.2        data.table_1.17.8
#>  [88] RSpectra_0.16-2       colourpicker_1.3.0    bioDist_1.82.0
#>  [91] fs_1.6.6              fastcluster_1.3.0     grid_4.5.2
#>  [94] utils_4.5.2           tidyr_1.3.1           ape_5.8-1
#>  [97] umap_0.2.10.0         methods_4.5.2         nlme_3.1-168
#> [100] cli_3.6.5             zigg_0.0.2            textshaping_1.0.4
#> [103] viridisLite_0.4.2     svglite_2.2.2         dplyr_1.1.4
#> [106] gtable_0.3.6          sass_0.4.10           digest_0.6.39
#> [109] BiocGenerics_0.56.0   htmlwidgets_1.6.4     farver_2.1.2
#> [112] htmltools_0.5.8.1     lifecycle_1.0.4       httr_1.4.7
#> [115] mime_0.13             openssl_2.3.4
```

# References

# Appendix

1. Adebali, O. and Zhulin, I.B. (2017) Aquerium: A web application for
   comparative exploration of domain-based protein occurrences on the taxonomically
   clustered genome tree. Proteins, 85, 72-77.
2. Altenhoff, A.M. et al. (2016) Standardized benchmarking in the quest for
   orthologs. Nat Methods, 13, 425-430.
3. Altenhoff, A.M. et al. (2015) The OMA orthology database in 2015: function
   predictions, better plant support, synteny view and other improvements.
   Nucleic Acids Res, 43, D240-249.
4. Capra, J.A. et al. (2013) How old is my gene? Trends Genet, 29, 659-668.
   Daubin, V., Gouy, M. and Perriere, G. (2002) A phylogenomic approach to
   bacterial phylogeny: evidence of a core of genes sharing a common history.
   Genome Res, 12, 1080-1090.
5. Huerta-Cepas, J., Serra, F. and Bork, P. (2016) ETE 3: Reconstruction,
   Analysis, and Visualization of Phylogenomic Data. Mol Biol Evol, 33, 1635-1638.
6. Koestler, T., Haeseler, A.v. and Ebersberger, I. (2010) FACT: Functional
   annotation transfer between proteins with similar feature architectures.
   BMC Bioinformatics, 11, 417.
7. Lee, D., Redfern, O. and Orengo, C. (2007) Predicting protein function
   from sequence and structure. Nat Rev Mol Cell Biol, 8, 995-1005.
8. Moore, A.D. et al. (2014) DoMosaics: software for domain arrangement
   visualization and domain-centric analysis of proteins. Bioinformatics,
   30, 282-283.
9. Pellegrini, M. (2012) Using phylogenetic profiles to predict functional
   relationships. Methods Mol Biol, 804, 167-177.
10. Pellegrini, M. et al. (1999) Assigning protein functions by comparative
    genome analysis: protein phylogenetic profiles. Proc Natl Acad Sci U S A, 96,
    4285-4288.
11. Schmitt, T. et al. (2011) Letter to the editor: SeqXML and OrthoXML:
    standards for sequence and orthology information. Brief. Bioinform., 12,
    485-488.
12. Studer, R.A. and Robinson-Rechavi, M. (2009) How confident can we be that
    orthologs are similar, but paralogs differ? Trends Genet, 25, 210-216.