Code

* Show All Code
* Hide All Code

# Pathway Integrated Regression-based Kernel Association Test (PaIRKAT)

Charlie Carpenter1\*, Weiming Zhang1\*\*, Lucas Gillenwater1\*\*\*, Cameron Severn1\*\*\*\*, Tusharkanti Ghosh1\*\*\*\*\*, Russel Bowler1\*\*\*\*\*\*, Katerina Kechris1\*\*\*\*\*\*\* and Debashis Ghosh1\*\*\*\*\*\*\*\*

1University of Colorado Anschutz Medical Campus

\*CHARLES.CARPENTER@CUANSCHUTZ.EDU
\*\*WEIMING.ZHANG@CUANSCHUTZ.EDU
\*\*\*LUCAS.GILLENWATER@CUANSCHUTZ.EDU
\*\*\*\*CAMERON.SEVERN@CUANSCHUTZ.EDU
\*\*\*\*\*TUSHARKANTI.GHOSH@CUANSCHUTZ.EDU
\*\*\*\*\*\*BOWLERR@NJHEALTH.ORG
\*\*\*\*\*\*\*KATERINA.KECHRIS@CUANSCHUTZ.EDU
\*\*\*\*\*\*\*\*DEBASHIS.GHOSH@CUANSCHUTZ.EDU

#### 9/1/2021

#### Package

pairkat 1.16.0

# 1 Introduction

Pathway Integrated Regression-based Kernel Association Test (PaIRKAT) is a
model framework for assessing statistical relationships between networks
and some outcome of interest while adjusting for
potential confounders and covariates.

The PaIRKAT method is motivated by the analysis of networks of metabolites
from a metabolomics assay and the relationship of those networks with a
phenotype or clinical outcome of interest, though the method can be generalized
to other domains.

PaIRKAT queries the KEGG database to determine interactions between
metabolites from which network connectivity is constructed. This model
framework improves testing power on high dimensional data by including
graph topography in the kernel machine regression setting. Studies on high
dimensional data can struggle to include the complex relationships between
variables. The semi-parametric kernel machine regression model is a powerful
tool for capturing these types of relationships. They provide a framework for
testing for relationships between outcomes of interest and high dimensional
data such as metabolomic, genomic, or proteomic pathways. PaIRKAT uses known
biological connections between high dimensional variables by representing them
as edges of ‘graphs’ or ‘networks.’ It is common for nodes (e.g. metabolites)
to be disconnected from all others within the graph, which leads to meaningful
decreases in testing power whether or not the graph information is included.
We include a graph regularization or ‘smoothing’ approach for managing
this issue.

# 2 Installation

```
# install from bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("pairkat")
```

# 3 Load pairkat library and example data

PaIRKAT comes with an example data set to use as a reference when formatting
data inputs to its functions. This synthetic dataset called “smokers” contains
a set of human subjects with phenotype variables related to
lung health among smokers. Subjects have associated metabolomics assay data
that are linked to KEGG pathway database IDs.

```
# load pairkat library
library(pairkat)
data("smokers")
```

# 4 Create a summarized experiment object

Data need to be added to a SummarizedExperiment class object before they can
be analyzed with PaIRKAT. There are three components of the
SummarizedExperiment that need to be added:

1. Phenotype Data: Contains outcomes of interest and any meaningful covariates
   to be adjusted for. Rows should be subjects and columns should be variables.
2. Pathway Data: Maps measured metabolites names to KEGG IDs in order to query
   the KEGG database. Rows are metabolite names and one column should contain
   KEGG IDs.
3. Metabolite Assay: Contains measurements of metabolites for all subjects.
   Rows should be subjects and columns should be metabolite names. One column
   should have subject IDs matching subject IDs in clinical data.

We will walk through each of these data and discuss their formats.

## 4.1 Phenotype Data

Phenotype data should be formatted such that subject ID’s are row names and
variables of interest are column names. Categorical variables should be
converted to dummy variables (i.e. one-hot-encoded).

In our example, we will be working with a data set containing measures related
to lung health among smokers. Variables in this data set include:

`log_FEV1_FVC_ratio`: [log(FEV1/FVC)] A measure of lung capacity.
The FEV1/FVC ratio is the ratio of the forced expiratory volume in the first
one second to the forced vital capacity of the lungs. This measure has been
log transformed.

`high_log_FEV1_FVC_ratio_binary`: A binarized transformation of
`log_FEV1_FVC_ratio` which indicates whether `log_FEV1_FVC_ratio` is “high”
with a 1, otherwise 0.

`race_binary`: A binary indicator of race.

`age`: Age in years

`bmi`: Body Mass Index

`smoking_status`: Binary indicator of whether a subject is a current smoker
(1) or not (0)

`pack_years`: A way to measure the amount a person has smoked over a long
period of time. It is calculated by multiplying the number of packs of
cigarettes smoked per day by the number of years the person has smoked.

The example data are already packaged as a SummarizedExperiment. We will extract
each of the components to look at their structures. Phenotype data are saved
in the colData partition of the SummarizedExperiment can can be extracted as
follows:

```
phenotype <- SummarizedExperiment::colData(smokers)
head(phenotype)
```

```
## DataFrame with 6 rows and 7 columns
##    log_FEV1_FVC_ratio high_log_FEV1_FVC_ratio_binary race_binary       age
##             <numeric>                      <numeric>   <numeric> <numeric>
## S1           0.838751                              1           1      76.0
## S2          -0.163348                              0           1      68.6
## S3          -0.283701                              0           1      51.5
## S4          -0.997419                              0           1      69.3
## S5           1.114170                              1           1      60.7
## S6          -0.366500                              0           1      75.2
##          bmi smoking_status pack_years
##    <numeric>      <numeric>  <numeric>
## S1     31.81              0       68.4
## S2     37.10              1       72.4
## S3     29.24              1       44.3
## S4     22.47              0       41.4
## S5     29.51              1       21.6
## S6     25.25              0       86.6
```

## 4.2 Pathway Data

Pathway data primarily functions to link metabolite names with KEGG ID’s.
Row names should be metabolite names and one column should contain KEGG IDs.
Other columns may be present if desired.

Pathway data are saved
in the rowData partition of the SummarizedExperiment can can be extracted as
follows:

```
pathways <- SummarizedExperiment::rowData(smokers)
head(pathways)[, 1:2]
```

```
## DataFrame with 6 rows and 2 columns
##                                  kegg_id compound_id
##                              <character>   <numeric>
## 1-arachidonoyl-GPC* (20:4)*       C05208       33228
## 1-arachidonylglycerol (20:4)      C13857       34397
## 1-linoleoyl-GPC (18:2)            C04100       34419
## 1-methyl-4-imidazoleacetate       C05828       32350
## 1-methyladenosine                 C02494       15650
## 1-methylhistidine                 C01152       30460
```

## 4.3 Metabolite Assay

Metabolite assay data should have metabolite names as row names (matching
pathway data names) and subject IDs as column names.

Metabolite Assay data are saved
in the assays partition of the SummarizedExperiment. Multiple assays can be
stored in the SummarizedExperiment object. PaIRKAT relies on the assay to be
named “metabolomics”. The assay data can can be extracted as follows:

```
metabolome <- SummarizedExperiment::assays(smokers)$metabolomics
head(metabolome)[, 1:3]
```

```
##                                    S1       S2       S3
## 1-arachidonoyl-GPC* (20:4)*  17.36150 18.32505 16.70162
## 1-arachidonylglycerol (20:4) 11.52322 12.03081 13.40373
## 1-linoleoyl-GPC (18:2)       16.68326 19.04595 15.93618
## 1-methyl-4-imidazoleacetate  13.89287 15.59214 14.69882
## 1-methyladenosine            15.83022 14.67049 13.31189
## 1-methylhistidine            13.04124 11.91380 11.84175
```

## 4.4 Create the Summarized Experiment Object

Once the three components are formatted correctly, it is straightforward to
add these dataframes to the SummarizedExperiment object with the
SummarizedExperiment function.

In this example, we re-save our SummarizedExperiment data to an object
called `smokers`

```
smokers <-
  SummarizedExperiment::SummarizedExperiment(
    assays = list(metabolomics = metabolome),
    rowData = pathways,
    colData = phenotype
  )
```

# 5 GatherNetworks Function

GatherNetworks queries the KEGG API to discover molecular interactions and
build a network graph between measured metabolites.

GatherNetworks takes 4 arguments

`SE` - a SummarizedExperiment object

`keggID` - a string of the column name in pathway data containing KEGG IDs

`species` - a three letter species IDs can be found by
running `keggList("organism")`

`minPathwaySize` - this argument filters KEGG pathways that contain fewer
metabolites than the number specified

## 5.1 Get species ID

Our data were gathered from humans, so we will use the three letter species
code “hsa”.

```
head(KEGGREST::keggList("organism"))[, 2:3]
```

```
##      organism species
## [1,] "hsa"    "Homo sapiens (human)"
## [2,] "ptr"    "Pan troglodytes (chimpanzee)"
## [3,] "pps"    "Pan paniscus (bonobo)"
## [4,] "ggo"    "Gorilla gorilla gorilla (western lowland gorilla)"
## [5,] "pon"    "Pongo abelii (Sumatran orangutan)"
## [6,] "ppyg"   "Pongo pygmaeus (Bornean orangutan)"
```

## 5.2 Run GatherNetworks

```
networks <- GatherNetworks(
  SE = smokers,
  keggID = "kegg_id",
  species = "hsa",
  minPathwaySize = 5
)
```

# 6 PaIRKAT function

PaIRKAT can be used to get a kernel score for all pathways found in
GatherNetworks. PaIRKAT takes 3 arguments:

`formula.H0` - The null model in the “formula” format used in lm and glm
functions.

`networks` - networks object obtained with GatherNetworks

`tau` - A parameter to control the amount of smoothing, analogous to a
bandwidth parameter in kernel smoothing. We found 1 often gave reasonable
results, as over-smoothing can lead to inflated Type I errors.

```
# run PaIRKAT
output <- PaIRKAT(log_FEV1_FVC_ratio ~ age,
                  networks = networks)
```

## 6.1 View Results

The formula call and results of the kernel test can be viewed by calling items
from the PaIRKAT function output. In our example, the first result can be
interpreted as follows:

Histidine metabolism has a significant relationship with
log\_FEV1\_FVC\_ratio when controlling for age (p = 0.0038).
Similarly, Arginine biosynthesis has a significant relationship with
log\_FEV1\_FVC\_ratio when controlling for age (p = 0.0070). etc.

```
# view formula call
output$call
```

```
## log_FEV1_FVC_ratio ~ age
```

```
# view results
results <- dplyr::arrange(output$results, p.value)
head(results)
```

```
##                                       pathway    Q.adj     p.value
## 1                        Histidine metabolism 1.289588 0.003775968
## 2                       Arginine biosynthesis 1.269609 0.007545011
## 3 Alanine, aspartate and glutamate metabolism 1.135580 0.026493023
## 4                              Bile secretion 1.048787 0.071780296
## 5                    Linoleic acid metabolism 1.085318 0.126369867
## 6 Amino sugar and nucleotide sugar metabolism 1.035781 0.146602397
```

## 6.2 Visualize Networks

To look further into significant metabolic pathways, it is possible to plot
pathway networks using the plotNetworks function and passing the networks
object along with one of the pathway names as a string. To visualize all
networks, pass “all” to the pathways argument.

```
plotNetworks(networks = networks,
             pathway = "Glycerophospholipid metabolism")
```

![](data:image/png;base64...)

# 7 Session Information

```
sessionInfo()
```

```
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] pairkat_1.16.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 generics_0.1.4
##  [3] SparseArray_1.10.0          lattice_0.22-7
##  [5] digest_0.6.37               magrittr_2.0.4
##  [7] evaluate_1.0.5              grid_4.5.1
##  [9] bookdown_0.45               CompQuadForm_1.4.4
## [11] fastmap_1.2.0               jsonlite_2.0.0
## [13] Matrix_1.7-4                tinytex_0.57
## [15] BiocManager_1.30.26         httr_1.4.7
## [17] Biostrings_2.78.0           jquerylib_0.1.4
## [19] abind_1.4-8                 cli_3.6.5
## [21] rlang_1.1.6                 crayon_1.5.3
## [23] XVector_0.50.0              Biobase_2.70.0
## [25] cachem_1.1.0                DelayedArray_0.36.0
## [27] yaml_2.3.10                 S4Arrays_1.10.0
## [29] tools_4.5.1                 dplyr_1.1.4
## [31] SummarizedExperiment_1.40.0 BiocGenerics_0.56.0
## [33] curl_7.0.0                  vctrs_0.6.5
## [35] R6_2.6.1                    png_0.1-8
## [37] magick_2.9.0                matrixStats_1.5.0
## [39] stats4_4.5.1                lifecycle_1.0.4
## [41] KEGGREST_1.50.0             Seqinfo_1.0.0
## [43] S4Vectors_0.48.0            IRanges_2.44.0
## [45] pkgconfig_2.0.3             bslib_0.9.0
## [47] pillar_1.11.1               Rcpp_1.1.0
## [49] data.table_1.17.8           glue_1.8.0
## [51] tidyselect_1.2.1            xfun_0.53
## [53] tibble_3.3.0                GenomicRanges_1.62.0
## [55] MatrixGenerics_1.22.0       knitr_1.50
## [57] htmltools_0.5.8.1           igraph_2.2.1
## [59] rmarkdown_2.30              compiler_4.5.1
```