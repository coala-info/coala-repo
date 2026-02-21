# Introduction to PhILR

Justin Silverman

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Overview of PhILR Analysis](#overview-of-philr-analysis)
* [3 Loading and Preprocessing Dataset](#loading-and-preprocessing-dataset)
* [4 Data preparation: TreeSE](#data-preparation-treese)
  + [4.1 Filter Extremely Low-Abundance OTUs](#filter-extremely-low-abundance-otus)
  + [4.2 Process Phylogenetic Tree](#process-phylogenetic-tree)
  + [4.3 Investigate Dataset Components](#investigate-dataset-components)
* [5 Transform Data using PhILR](#transform-data-using-philr)
* [6 Ordination in PhILR Space](#ordination-in-philr-space)
* [7 Visualization with TreeSE](#visualization-with-treese)
* [8 Identify Balances that Distinguish Human/Non-Human](#identify-balances-that-distinguish-humannon-human)
* [9 Name Balances](#name-balances)
* [10 Visualize Results](#visualize-results)
* [11 Use Balances for Dimension Reduction](#use-balances-for-dimension-reduction)
* [12 Package versions](#package-versions)
* [References](#references)

# 1 Introduction

PhILR is short for “Phylogenetic Isometric Log-Ratio Transform”
(Silverman et al. [2017](#ref-silverman2017)). This package provides functions for the analysis of
[compositional data](https://en.wikipedia.org/wiki/Compositional_data)
(e.g., data representing proportions of different
variables/parts). Specifically this package allows analysis of
compositional data where the parts can be related through a
phylogenetic tree (as is common in microbiota survey data) and makes
available the Isometric Log Ratio transform built from the
phylogenetic tree and utilizing a weighted reference measure
(Egozcue and Pawlowsky-Glahn [2016](#ref-egozcue2016)).

# 2 Overview of PhILR Analysis

The goal of PhILR is to transform compositional data into an
orthogonal unconstrained space (real space) with phylogenetic /
evolutionary interpretation while preserving all information contained
in the original composition. Unlike in the original compositional
space, in the transformed real space, standard statistical tools may
be applied. For a given set of samples consisting of measurements of
taxa, we transform data into a new space of samples and orthonormal
coordinates termed ‘balances’. Each balance is associated with a
single internal node of a phylogenetic tree with the taxa as
leaves. The balance represents the log-ratio of the geometric mean
abundance of the two groups of taxa that descend from the given
internal node. More details on this method can be found in
Silverman et al. ([2017](#ref-silverman2017)) ([Link](https://elifesciences.org/content/6/e21887)).

The analysis uses abundance table and a phylogenetic tree. These can
be provided as separate data objects, or embedded in standard
R/Bioconductor data containers. The philr R package supports two
alternative data containers for microbiome data, `TreeSE` (Huang et al. [2021](#ref-huang2021))
and `phyloseq` (McMurdie and Holmes [2013](#ref-mcmurdie2013)).

# 3 Loading and Preprocessing Dataset

We demonstrate PhILR analysis by using the Global Patterns
dataset that was originally published by Caporaso et al. ([2011](#ref-caporaso2011)).

Let us first load necessary libraries.

```
library(philr); packageVersion("philr")
```

```
## [1] '1.36.0'
```

```
library(ape); packageVersion("ape")
```

```
## [1] '5.8.1'
```

```
library(ggplot2); packageVersion("ggplot2")
```

```
## [1] '4.0.0'
```

# 4 Data preparation: TreeSE

We show the GlobalPatterns example workflow as initially
outlined in (McMurdie and Holmes [2013](#ref-mcmurdie2013)).

We retrieve the example data in `TreeSummarizedExperiment` (`TreeSE`)
data format in this vignette (Huang et al. [2021](#ref-huang2021)), and then show example also
for the [phyloseq](philr-intro-phyloseq.md) format. The TreeSE version
for the GlobalPatterns data is provided with the [`mia`
package](microbiome.github.io/mia) (Lahti et al. [2020](#ref-lahti2020)).

Let us load the data.

```
library(mia); packageVersion("mia")
```

```
## [1] '1.18.0'
```

```
library(dplyr); packageVersion("dplyr")
```

```
## [1] '1.1.4'
```

```
data(GlobalPatterns, package = "mia")
```

## 4.1 Filter Extremely Low-Abundance OTUs

Taxa that were not seen with more than 3 counts in at least 20% of
samples are filtered. Subsequently, those with a coefficient of
variation ≤ 3 are filtered. Finally we add a pseudocount of 1 to the
remaining OTUs to avoid calculating log-ratios involving
zeros. Alternatively other replacement methods (multiplicative
replacement etc…) may be used instead if desired; the subsequent
taxa weighting procedure we will describe complements a variety of
zero replacement methods.

```
## Select prevalent taxa
tse <-  GlobalPatterns %>% subsetByPrevalentTaxa(
                               detection = 3,
                               prevalence = 20/100,
                               as_relative = FALSE)

## Pick taxa that have notable abundance variation across sammples
variable.taxa <- apply(assays(tse)$counts, 1, function(x) sd(x)/mean(x) > 3.0)
tse <- tse[variable.taxa,]
# Collapse the tree!
# Otherwise the original tree with all nodes is kept
# (including those that were filtered out from rowData)
tree <- ape::keep.tip(phy = rowTree(tse), tip = rowLinks(tse)$nodeNum)
rowTree(tse) <- tree

## Add a new assay with a pseudocount
assays(tse)$counts.shifted <- assays(tse)$counts + 1
```

We have now removed the filtered taxa from the OTU table,
pruned the phylogenetic tree, and subset the taxa table.
Here is the result of those filtering steps.

```
## class: TreeSummarizedExperiment
## dim: 1248 26
## metadata(0):
## assays(2): counts counts.shifted
## rownames(1248): 540305 108964 ... 516119 145149
## rowData names(7): Kingdom Phylum ... Genus Species
## colnames(26): CL3 CC1 ... Even2 Even3
## colData names(7): X.SampleID Primer ... SampleType Description
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (1248 rows)
## rowTree: 1 phylo tree(s) (1248 leaves)
## colLinks: NULL
## colTree: NULL
```

## 4.2 Process Phylogenetic Tree

Next we check that the tree is rooted and binary (all multichotomies
have been resolved).

```
library(ape); packageVersion("ape")
```

```
## [1] '5.8.1'
```

```
is.rooted(tree) # Is the tree Rooted?
```

```
## [1] TRUE
```

```
is.binary(tree) # All multichotomies resolved?
```

```
## [1] TRUE
```

Note that if the tree is not binary, the function `multi2di` from the
`ape` package can be used to replace multichotomies with a series of
dichotomies with one (or several) branch(es) of zero length.

Once this is done, we name the internal nodes of the tree so they are
easier to work with. We prefix the node number with `n` and thus the
root is named `n1`.

```
tree <- makeNodeLabel(tree, method="number", prefix='n')

# Add the modified tree back to the (`TreeSE`) data object
rowTree(tse) <- tree
```

We note that the tree is already rooted with Archea as the outgroup
and no multichotomies are present. This uses the function
`name.balance` from the `philr` package. This function uses a simple
voting scheme to find a consensus naming for the two clades that
descend from a given balance. Specifically for a balance named `x/y`,
`x` refers to the consensus name of the clade in the numerator of the
log-ratio and `y` refers to the denominator.

```
# Extract taxonomy table from the TreeSE object
tax <- rowData(tse)[,taxonomyRanks(tse)]

# Get name balances
name.balance(tree, tax, 'n1')
```

```
## [1] "Kingdom_Archaea/Kingdom_Bacteria"
```

## 4.3 Investigate Dataset Components

Finally we transpose the OTU table (`philr` uses the conventions of
the `compositions` package for compositional data analysis in R, taxa
are columns, samples are rows). Then we will take a look at part of
the dataset in more detail.

```
otu.table <- t(as(assays(tse)$counts.shifted, "matrix"))
tree <- rowTree(tse)
metadata <- colData(tse)
tax <- rowData(tse)[,taxonomyRanks(tse)]

otu.table[1:2,1:2] # OTU Table
```

```
##     540305 108964
## CL3      1      1
## CC1      1      2
```

```
tree # Phylogenetic Tree
```

```
##
## Phylogenetic tree with 1248 tips and 1247 internal nodes.
##
## Tip labels:
##   540305, 108964, 175045, 546313, 54107, 71074, ...
## Node labels:
##   n1, n2, n3, n4, n5, n6, ...
##
## Rooted; includes branch length(s).
```

```
head(metadata,2) # Metadata
```

```
## DataFrame with 2 rows and 7 columns
##     X.SampleID   Primer Final_Barcode Barcode_truncated_plus_T
##       <factor> <factor>      <factor>                 <factor>
## CL3        CL3  ILBC_01        AACGCA                   TGCGTT
## CC1        CC1  ILBC_02        AACTCG                   CGAGTT
##     Barcode_full_length SampleType                              Description
##                <factor>   <factor>                                 <factor>
## CL3         CTAGCGTGCGT       Soil Calhoun South Carolina Pine soil, pH 4.9
## CC1         CATCGACGAGT       Soil Cedar Creek Minnesota, grassland, pH 6.1
```

```
head(tax,2) # taxonomy table
```

```
## DataFrame with 2 rows and 7 columns
##            Kingdom        Phylum          Class         Order         Family
##        <character>   <character>    <character>   <character>    <character>
## 540305     Archaea Crenarchaeota Thaumarchaeota Cenarchaeales Cenarchaeaceae
## 108964     Archaea Crenarchaeota Thaumarchaeota Cenarchaeales Cenarchaeaceae
##                 Genus     Species
##           <character> <character>
## 540305             NA          NA
## 108964 Nitrosopumilus      pIVWA5
```

A new variable distinguishing human/non-human:

```
human.samples <- factor(colData(tse)$SampleType %in% c("Feces", "Mock", "Skin", "Tongue"))
```

# 5 Transform Data using PhILR

The function `philr::philr()` implements a user friendly wrapper for the key
steps in the philr transform.

1. Convert the phylogenetic tree to its sequential binary partition (SBP) representation
   using the function `philr::phylo2sbp()`
2. Calculate the weighting of the taxa (aka parts) or use the user specified weights
3. Built the contrast matrix from the SBP and taxa weights using the function
   `philr::buildilrBasep()`
4. Convert OTU table to relative abundance (using `philr::miniclo()`) and
   ‘shift’ dataset using the weightings (Egozcue and Pawlowsky-Glahn [2016](#ref-egozcue2016)) using the function `philr::shiftp()`.
5. Transform the data to PhILR space using the function `philr::ilrp()`
6. (Optional) Weight the resulting PhILR space using phylogenetic distance. These
   weights are either provided by the user or can be calculated by the function
   `philr::calculate.blw()`.

Note: The preprocessed OTU table should be passed to the function
`philr::philr()` before it is closed (normalized) to relative
abundances, as some of the preset weightings of the taxa use the
original count data to down weight low abundance taxa.

Here we will use the same weightings as we used in the main paper.

You can run `philr` with the abundance table and phylogenetic tree.

```
gp.philr <- philr(otu.table, tree,
                  part.weights='enorm.x.gm.counts',
                  ilr.weights='blw.sqrt')
gp.philr[1:5,1:5]
```

```
##                 n1         n2         n3         n4          n5
## CL3     -1.3638521  1.9756259  2.6111996 -3.3174292  0.08335109
## CC1     -0.9441168  3.9054807  2.9804522 -4.7771598 -0.05334306
## SV1      5.8436901  5.9067782  6.7315081 -8.8020849  0.08335109
## M31Fcsw -3.9010427 -0.1816618 -0.5432099  0.1705271  0.08335109
## M11Fcsw -5.4554073  0.5398249 -0.5647474  0.5551616 -0.02389182
```

Alternatively, you can provide the data directly in `TreeSE` format.

```
gp.philr <- philr(tse, abund_values = "counts.shifted",
                  part.weights='enorm.x.gm.counts',
                  ilr.weights='blw.sqrt')
```

Alternatively, you can provide the data in `phyloseq` format. For
simplicity, let us just convert the `TreeSE` object to `phyloseq`
object to give a brief example.

```
pseq <- convertToPhyloseq(tse, assay.type="counts.shifted")
gp.philr <- philr(pseq,
                  part.weights='enorm.x.gm.counts',
                  ilr.weights='blw.sqrt')
```

After running `philr` the transformed data is represented in terms of
balances and since each balance is associated with a single internal
node of the tree, we denote the balances using the same names we
assigned to the internal nodes (e.g., `n1`).

# 6 Ordination in PhILR Space

Euclidean distance in PhILR space can be used for ordination analysis. Let us first calculate distances and then calculate standard MDS ordination.

```
# Distances between samples based on philr transformed data
gp.dist <- dist(gp.philr, method="euclidean")

# Calculate MDS for the distance matrix
d <- as.data.frame(cmdscale(gp.dist))
colnames(d) <- paste0("PC", 1:2)
```

# 7 Visualization with TreeSE

Let us next visualize the ordination. This example employs standard
tools for ordination and visualization that can be used regardless of
the preferred data container. Note that the `phyloseq` and `TreeSE` frameworks
may provide access to additional ordination and visualization methods.

```
# Add some metadata for the visualization
d$SampleType <- factor(metadata$SampleType)

# Create a plot
ggplot(data = d,
  aes(x=PC1, y=PC2, color=SampleType)) +
  geom_point() +
  labs(title = "Euclidean distances with phILR")
```

![](data:image/png;base64...)

# 8 Identify Balances that Distinguish Human/Non-Human

More than just ordination analysis, PhILR provides an entire
coordinate system in which standard multivariate tools can be
used. Here we will make use of sparse logistic regression (from the
`glmnet` package) to identify a small number of balances that best
distinguish human from non-human samples.

Now we will fit a sparse logistic regression model (logistic
regression with \(l\_1\) penalty)

```
library(glmnet); packageVersion('glmnet')
```

```
## [1] '4.1.10'
```

```
glmmod <- glmnet(gp.philr, human.samples, alpha=1, family="binomial")
```

We will use a hard-threshold for the \(l\_1\) penalty of \(\lambda = 0.2526\) which we choose so that the resulting number of non-zero
coefficients is \(\approx 5\) (for easy of visualization in this
tutorial).

```
top.coords <- as.matrix(coefficients(glmmod, s=0.2526))
top.coords <- rownames(top.coords)[which(top.coords != 0)]
(top.coords <- top.coords[2:length(top.coords)]) # remove the intercept as a coordinate
```

```
## [1] "n16"  "n106" "n122" "n188" "n730"
```

# 9 Name Balances

To find the taxonomic labels that correspond to these balances we can
use the function `philr::name.balance()`. This funciton uses a simple
voting scheme to name the two descendent clades of a given balance
separately. For a given clade, the taxonomy table is subset to only
contain taxa from that clade. Starting at the finest taxonomic rank
(e.g., species) the subset taxonomy table is checked to see if any
label (e.g., species name) represents ≥ threshold (default 95%) of the
table entries at that taxonomic rank. If no consensus identifier is
found, the table is checked at the next-most specific taxonomic rank
(etc…).

```
tc.names <- sapply(top.coords, function(x) name.balance(tree, tax, x))
tc.names
```

```
##                                           n16
##          "Kingdom_Bacteria/Phylum_Firmicutes"
##                                          n106
## "Order_Actinomycetales/Order_Actinomycetales"
##                                          n122
##       "Kingdom_Bacteria/Phylum_Cyanobacteria"
##                                          n188
##   "Genus_Campylobacter/Phylum_Proteobacteria"
##                                          n730
##     "Order_Bacteroidales/Order_Bacteroidales"
```

We can also get more information on what goes into the naming by viewing the votes
directly.

```
votes <- name.balance(tree, tax, 'n730', return.votes = c('up', 'down'))
votes[[c('up.votes', 'Family')]]   # Numerator at Family Level
```

```
## votes
## Porphyromonadaceae
##                  1
```

```
votes[[c('down.votes', 'Family')]] # Denominator at Family Level
```

```
## votes
##     Bacteroidaceae Porphyromonadaceae     Prevotellaceae      Rikenellaceae
##                 12                  9                 10                  5
```

# 10 Visualize Results

```
library(ggtree); packageVersion("ggtree")
```

```
## [1] '4.0.1'
```

```
library(dplyr); packageVersion('dplyr')
```

```
## [1] '1.1.4'
```

Above we found the top 5 coordinates (balances) that distinguish
whether a sample is from a human or non-human source. Now using the
`ggtree` (Yu et al. [2016](#ref-yu2016)) package we can visualize these balances on the tree
using the `geom_balance` object. To use these functions we need to
know the acctual node number (not just the names we have given) of
these balances on the tree. To convert between node number and name,
we have added the functions `philr::name.to.nn()` and
`philr::nn.to.name()`. In addition, it is important that we know
which clade of the balance is in the numerator (+) and which is in the
denominator (-) of the log-ratio. To help us keep track we have
created the function `philr::annotate_balance()` which allows us to
easily label these two clades.

```
tc.nn <- name.to.nn(tree, top.coords)
tc.colors <- c('#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99')
p <- ggtree(tree, layout='fan') +
  geom_balance(node=tc.nn[1], fill=tc.colors[1], alpha=0.6) +
  geom_balance(node=tc.nn[2], fill=tc.colors[2], alpha=0.6) +
  geom_balance(node=tc.nn[3], fill=tc.colors[3], alpha=0.6) +
  geom_balance(node=tc.nn[4], fill=tc.colors[4], alpha=0.6) +
  geom_balance(node=tc.nn[5], fill=tc.colors[5], alpha=0.6)
p <- annotate_balance(tree, 'n16', p=p, labels = c('n16+', 'n16-'),
                 offset.text=0.15, bar=FALSE)
annotate_balance(tree, 'n730', p=p, labels = c('n730+', 'n730-'),
                 offset.text=0.15, bar=FALSE)
```

![](data:image/png;base64...)

We can also view the distribution of these 5 balances for human/non-human sources.
In order to plot with `ggplot2` we first need to convert the PhILR transformed
data to long format. We have included a function `philr::convert_to_long()` for
this purpose.

```
gp.philr.long <- convert_to_long(gp.philr, human.samples) %>%
  filter(coord %in% top.coords)
```

```
## Warning: `gather_()` was deprecated in tidyr 1.2.0.
## ℹ Please use `gather()` instead.
## ℹ The deprecated feature was likely used in the philr package.
##   Please report the issue at <https://github.com/jsilve24/philr/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
ggplot(gp.philr.long, aes(x=labels, y=value)) +
  geom_boxplot(fill='lightgrey') +
  facet_grid(.~coord, scales='free_x') +
  labs(x = 'Human', y = 'Balance Value') +
  theme_bw()
```

![](data:image/png;base64...)

# 11 Use Balances for Dimension Reduction

Lets just look at balance n16 vs. balance n730 (the ones we annotated
in the above tree).

```
library(tidyr); packageVersion('tidyr')
```

```
## [1] '1.3.1'
```

```
gp.philr.long %>%
  dplyr::rename(Human=labels) %>%
  dplyr::filter(coord %in% c('n16', 'n730')) %>%
  tidyr::spread(coord, value) %>%
  ggplot(aes(x=n16, y=n730, color=Human)) +
  geom_point(size=4) +
  labs(x = tc.names['n16'], y = tc.names['n730']) +
  theme_bw()
```

![](data:image/png;base64...)

# 12 Package versions

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] tidyr_1.3.1                     ggtree_4.0.1
##  [3] glmnet_4.1-10                   Matrix_1.7-4
##  [5] dplyr_1.1.4                     mia_1.18.0
##  [7] TreeSummarizedExperiment_2.18.0 Biostrings_2.78.0
##  [9] XVector_0.50.0                  SingleCellExperiment_1.32.0
## [11] MultiAssayExperiment_1.36.0     SummarizedExperiment_1.40.0
## [13] Biobase_2.70.0                  GenomicRanges_1.62.0
## [15] Seqinfo_1.0.0                   IRanges_2.44.0
## [17] S4Vectors_0.48.0                BiocGenerics_0.56.0
## [19] generics_0.1.4                  MatrixGenerics_1.22.0
## [21] matrixStats_1.5.0               ggplot2_4.0.0
## [23] ape_5.8-1                       philr_1.36.0
## [25] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1               ggplotify_0.1.3
##   [3] tibble_3.3.0                cellranger_1.1.0
##   [5] DirichletMultinomial_1.52.0 lifecycle_1.0.4
##   [7] lattice_0.22-7              MASS_7.3-65
##   [9] magrittr_2.0.4              sass_0.4.10
##  [11] rmarkdown_2.30              jquerylib_0.1.4
##  [13] yaml_2.3.10                 DBI_1.2.3
##  [15] RColorBrewer_1.1-3          ade4_1.7-23
##  [17] multcomp_1.4-29             abind_1.4-8
##  [19] quadprog_1.5-8              purrr_1.1.0
##  [21] fillpattern_1.0.2           phyloseq_1.54.0
##  [23] yulab.utils_0.2.1           TH.data_1.1-4
##  [25] rappdirs_0.3.3              sandwich_3.1-1
##  [27] gdtools_0.4.4               ggrepel_0.9.6
##  [29] irlba_2.3.5.1               tidytree_0.4.6
##  [31] vegan_2.7-2                 rbiom_2.2.1
##  [33] parallelly_1.45.1           permute_0.9-8
##  [35] DelayedMatrixStats_1.32.0   codetools_0.2-20
##  [37] DelayedArray_0.36.0         scuttle_1.20.0
##  [39] ggtext_0.1.2                xml2_1.4.1
##  [41] shape_1.4.6.1               tidyselect_1.2.1
##  [43] aplot_0.2.9                 farver_2.1.2
##  [45] ScaledMatrix_1.18.0         viridis_0.6.5
##  [47] jsonlite_2.0.0              BiocNeighbors_2.4.0
##  [49] multtest_2.66.0             decontam_1.30.0
##  [51] survival_3.8-3              scater_1.38.0
##  [53] iterators_1.0.14            emmeans_2.0.0
##  [55] systemfonts_1.3.1           foreach_1.5.2
##  [57] tools_4.5.1                 ggnewscale_0.5.2
##  [59] treeio_1.34.0               ragg_1.5.0
##  [61] Rcpp_1.1.0                  glue_1.8.0
##  [63] gridExtra_2.3               SparseArray_1.10.0
##  [65] BiocBaseUtils_1.12.0        xfun_0.54
##  [67] mgcv_1.9-3                  withr_3.0.2
##  [69] BiocManager_1.30.26         fastmap_1.2.0
##  [71] rhdf5filters_1.22.0         bluster_1.20.0
##  [73] digest_0.6.37               rsvd_1.0.5
##  [75] R6_2.6.1                    gridGraphics_0.5-1
##  [77] estimability_1.5.1          textshaping_1.0.4
##  [79] dichromat_2.0-0.1           fontLiberation_0.1.0
##  [81] data.table_1.17.8           DECIPHER_3.6.0
##  [83] htmlwidgets_1.6.4           S4Arrays_1.10.0
##  [85] pkgconfig_2.0.3             gtable_0.3.6
##  [87] S7_0.2.0                    htmltools_0.5.8.1
##  [89] fontBitstreamVera_0.1.1     bookdown_0.45
##  [91] biomformat_1.38.0           scales_1.4.0
##  [93] ggfun_0.2.0                 knitr_1.50
##  [95] tzdb_0.5.0                  reshape2_1.4.4
##  [97] coda_0.19-4.1               nlme_3.1-168
##  [99] cachem_1.1.0                zoo_1.8-14
## [101] rhdf5_2.54.0                stringr_1.5.2
## [103] parallel_4.5.1              vipor_0.4.7
## [105] pillar_1.11.1               grid_4.5.1
## [107] vctrs_0.6.5                 slam_0.1-55
## [109] BiocSingular_1.26.0         beachmat_2.26.0
## [111] xtable_1.8-4                cluster_2.1.8.1
## [113] beeswarm_0.4.0              evaluate_1.0.5
## [115] magick_2.9.0                tinytex_0.57
## [117] readr_2.1.5                 mvtnorm_1.3-3
## [119] cli_3.6.5                   compiler_4.5.1
## [121] rlang_1.1.6                 crayon_1.5.3
## [123] labeling_0.4.3              plyr_1.8.9
## [125] fs_1.6.6                    ggbeeswarm_0.7.2
## [127] ggiraph_0.9.2               stringi_1.8.7
## [129] viridisLite_0.4.2           BiocParallel_1.44.0
## [131] lazyeval_0.2.2              fontquiver_0.2.1
## [133] hms_1.1.4                   patchwork_1.3.2
## [135] sparseMatrixStats_1.22.0    Rhdf5lib_1.32.0
## [137] gridtext_0.1.5              igraph_2.2.1
## [139] bslib_0.9.0                 phangorn_2.12.1
## [141] fastmatch_1.1-6             readxl_1.4.5
```

# References

Caporaso, J Gregory, Christian L Lauber, William A Walters, Donna Berg-Lyons, Catherine A Lozupone, Peter J Turnbaugh, Noah Fierer, and Rob Knight. 2011. “Global Patterns of 16S rRNA Diversity at a Depth of Millions of Sequences Per Sample.” Journal Article. *Proceedings of the National Academy of Sciences* 108: 4516–22.

Egozcue, J. J., and V. Pawlowsky-Glahn. 2016. “Changing the Reference Measure in the Simlex and Its Weightings Effects.” Journal Article. *Austrian Journal of Statistics* 45 (4): 25–44.

Huang, Ruizhu, Charlotte Soneson, Felix G. M. Ernst, Kevin C. Rue-Albrecht, Guangchuang Yu, Stephanie C. Hicks, and Mark D. Robinson. 2021. “*TreeSummarizedExperiment*: A S4 Class for Data with Hierarchical Structure [Version 2].” *F1000Research* 9: 1246. <https://doi.org/10.12688/f1000research.26669.2>.

Lahti, L, FGM Ernst, SA Shetty, T Borman, T Huang, DJ Braccia, and HC Bravo. 2020. “Upgrading the R/Bioconductor Ecosystem for Microbiome Research [Version 1].” *F1000Research* 9: 1464. <https://doi.org/10.7490/f1000research.1118447.1>.

McMurdie, P. J., and S. Holmes. 2013. “Phyloseq: An R Package for Reproducible Interactive Analysis and Graphics of Microbiome Census Data.” Journal Article. *PLoS One* 8 (4): e61217. <https://doi.org/10.1371/journal.pone.0061217>.

Silverman, Justin D, Alex D Washburne, Sayan Mukherjee, and Lawrence A David. 2017. “A Phylogenetic Transform Enhances Analysis of Compositional Microbiota Data.” *eLife* 6. <https://doi.org/10.7554/eLife.21887>.

Yu, Guangchuang, David K Smith, Huachen Zhu, Yi Guan, and Tommy Tsan‐Yuk Lam. 2016. “Ggtree: An R Package for Visualization and Annotation of Phylogenetic Trees with Their Covariates and Other Associated Data.” Journal Article. *Methods in Ecology and Evolution*. <https://doi.org/10.1111/2041-210X.12628>.