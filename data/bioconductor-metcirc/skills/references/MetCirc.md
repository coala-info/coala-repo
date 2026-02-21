# MetCirc: Navigating mass spectral similarity in high-resolution MS/MS metabolomics data

Thomas Naake and Emmanuel Gaquerel1

1European Molecular Biology Laboratory, 69117 Heidelberg, Germany; Institut de biologie mol\'{e}culaire du m\'{e}tabolisme des plantes, Universit\'{e} de Strasbourg, 67084 Strasbourg, France

#### 30 October 2025

#### Package

MetCirc 1.40.0

# 1 Introduction

The `MetCirc` package comprises functionalities to display,
(interactively) explore similarities and annotate features of MS/MS metabolomics
data. It is especially designed to
improve the interactive exploration of metabolomics data obtained from
cross-species/cross-tissues comparative experiments. `MetCirc` relies
on the `Spectra` infrastructure to handle MS/MS spectra. Specifically,
`MetCirc` uses the Spectra`class from which similarities between features are calculated and which stores information on spectra in the columns of the slot`metadata`.

Notably, `MetCirc`
provides functions to calculate the similarity between individual MS/MS
spectra based on a normalised dot product (NDP, see Li, Baldwin, and Gaquerel ([2015](#ref-Li2015)) for further
details) calculation taking into account shared fragments or main neutral
losses.

Visualisation of molecular networks was pioneered by the Dorrestein lab
(Watrous et al. [2012](#ref-Watrous2012)) to efficiently organize MS/MS spectra in such a
way that clusters of MS/MS spectra sharing multiple common fragments are rapidly
inferred.

In contrary to the analysis there, the `MetCirc` framework offers two
ways for the computation of mass spectrum similarity: one way deploys common
(shared) fragments and the other shared neutral losses that are deduced from
the spectra. Especially the latter
approach allows to extract clusters of spectra corresponding to compound families
facilitating the rapid dereplication of hitherto unknown metabolites. Small
molecules, as produced by plants, return during fragmentation few fragments.
Sometimes only a few fragments among them are shared and diagnostic across
the compound family. Compared to the
MS/MS similarity scoring based on shared fragments, the second similarity
measure incorporates, in a non-supervised manner, neutral losses, which
definitely helps obtaining biochemically-meaningful MS/MS groupings.
Furthermore, any
other function to calculate similarities can be provided or a similarity
matrix providing similarity (in the range from 0 to 1) for features that
are present in the `Spectra` object.

The interpretation drawn from network reconstruction highly depends
from topological parameters applied during the network construction steps.
`MetCirc` circumvents this confinement. Furthermore, it uses instead
smaller MS/MS datasets obtained from experiments involving
*a priori* defined biological groups (organisms, tissues, etc.) to
visualize within and between MS/MS feature similarities on a circular
layout - inspired by the Circos framework (Krzywinski et al. [2009](#ref-Krzywinkski2009)). The
visualisation is adjustable (MS/MS ordering and similarity thresholds) via the
`shiny` interface and does not uniquely emphasize on large clusters
of MS/MS features (a frequent caveat of network visualisation). Furthermore,
the implemented functionality for annotation may improve
dereplication of known and unknown molecules.

This vignette uses as a case study indiscriminant MS/MS (idMS/MS) data from
Li, Baldwin, and Gaquerel ([2015](#ref-Li2015)), unpublished idMS/MS data
collected from different organs of tobacco flowers and data from the
Global Natural Product Social Molecular Networking (GNPS) library
to navigate through the
analysis pipeline. The pipeline includes the creation of `Spectra`
objects, the calculation of a similarity measure (NDP),
assignment to a similarity matrix and visualisation of similarity based
on interactive and non-interactive graphical tools using the
`circlize` framework (Gu et al. [2014](#ref-Gu2014)).

`MetCirc` is currently under active development. If you
discover any bugs, typos or develop ideas of improving
`MetCirc` feel free to raise an issue via
[GitHub](https://github.com/tnaake/MetCirc) or
send a mail to the developers.

# 2 Prepare the environment

To install `MetCirc` enter the following to the `R` console

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("MetCirc")
```

Before starting, load the `MetCirc` package. This will also
load the required packages `Spectra`, `circlize`,
`amap`, `scales` and `shiny`:

```
library("MetCirc")
library("MsCoreUtils")
```

```
##
## Attaching package: 'MsCoreUtils'
```

```
## The following objects are masked from 'package:Spectra':
##
##     bin, entropy, smooth
```

```
## The following object is masked from 'package:stats':
##
##     smooth
```

The central infrastructure class of the `MetCirc` package is the
`Spectra` object. The `Spectra` objects stores information
on precursor m/z, retention time, m/z and intensity values of fragments
and possible additional information, e.g. to which class the MS/MS feature
belong to, the identity of the MS/MS feature, information on the adduct of the
precursor, additional information. Furthermore, the `Spectra` object
can host information under which condition (in which tissue, etc.) the
MS/MS feature was detected.

We provide here three examplary workflows to create `Spectra` from
data frames that are loaded into R:
(1) by loading a data frame with a minimum requirement of a column “id” (comprising unique identifiers
for MS/MS features) and of the columns “mz” and “intensity” comprising the
fragment ions and their intensities, respectively, or
(2) by loading a data frame resembling a .MSP file object.

## 2.1 Load example data sets from Li, Baldwin, and Gaquerel ([2015](#ref-Li2015)), tissue idMS/MS data and GNPS data

sd02\_deconvoluted comprises 360 idMS/MS
deconvoluted spectra with fragment ions (m/z, chromatographic retention time, relative
intensity in %) and a column with unique identifiers for MS/MS features (here,
the corresponding principal component group with the
precursor ion). The data set is derived from the study of Li, Baldwin, and Gaquerel ([2015](#ref-Li2015)).

```
## load data from Li et al., 2015
data("sd02_deconvoluted", package = "MetCirc")
```

The second data set comes from the data-independent MS/MS
collection of different floral organs from tobacco plants. Using our pipeline,
this data set will be used to visualize shared metabolites between tissues as
well as structural relationships among within- and between-organ MS/MS spectra.
MS/MS data are merged across floral organs in one unique data file
`idMSMStissueproject.Rdata` as `tissue`. Information on the
organ-localisation of each MS/MS spectrum is stored in
`compartmentTissue`.

```
## load idMSMStissueproject
data("idMSMStissueproject", package = "MetCirc")
```

The third data set comes from the GNPS data base (downloaded at February 11, 2017 from: \
<http://prime.psc.riken.jp/Metabolomics_Software/MS-DIAL/MSMS-GNPS-Curated-Neg.msp>).
It contains 22 MS/MS features (a truncated file of the original one) and
is formatted in the .MSP file format, a typical format for
MS/MS libraries. The MS/MS spectra are (normally) separated by blank lines
and give information on the metabolite (its name, precursor m/z value,
retention time, class, adduct ion) and contain additional information.

```
## load data from GNPS
data("convertMsp2Spectra", package = "MetCirc")
```

# 3 Prepare data for mass spectral similarity calculations

## 3.1 Preparing the sd02\_deconvoluted data set for analysis

Here, we convert the examplatory data from Li, Baldwin, and Gaquerel ([2015](#ref-Li2015)) into a
`Spectra` object that is later used as the input for mass spectral
similarity calculations.
Data in the form of the data frame sd02\_deconvoluted require columns that
store the m/z values of fragments, the intensity values
for the respective fragments and a column containing an “id”. The latter
column contains information about the precursor ion and
should be a unique descriptor for the MS/MS features. For instance, this column
may be the derived from the output of the `xcms`/`CAMERA`
processing creating unique identifiers for each metabolite decoded in the column
“pcgroup”. A pcgroup is defined as a peak correlation group obtained by this
workflow. It corresponds to a MS or MS/MS spectrum deconvoluted by `CAMERA`
and contains information about the precursor identity and its isotope cluster.
The column “id” may additionally contain information
about the precursor retention time.

Create `Spectra` object from the data of Li, Baldwin, and Gaquerel ([2015](#ref-Li2015)):

```
## get all MS/MS spectra
id_uniq <- unique(sd02_deconvoluted[, "id"])

## obtain precursor m/z from id_uniq
prec_mz <- lapply(strsplit(as.character(id_uniq), split = " _ "), "[", 2) |>
    unlist() |>
    as.numeric()

## obtain m/z from fragments per precursor m/z
mz_l <- lapply(id_uniq,
    function(id_i) sd02_deconvoluted[sd02_deconvoluted[, "id"] == id_i, "mz"])

## obtain corresponding intensity values
int_l <- lapply(id_uniq,
    function(id_i) sd02_deconvoluted[sd02_deconvoluted[, "id"] == id_i, "intensity"])

## obtain retention time by averaging all retention time values
rt <- lapply(id_uniq, function(x) sd02_deconvoluted[sd02_deconvoluted[, "id"] == x, "rt"]) |>
    lapply(function(i) mean(i)) |>
    unlist()

## create list of Spectra objects, concatenate, and add metadata
sps_l <- lapply(seq_len(length(mz_l)), function(i) {
    spd <- S4Vectors::DataFrame(
        name = as.character(i),
        rtime = rt[i],
        msLevel = 2L,
        precursorMz = prec_mz[i])
    spd$mz <- list(mz_l[[i]])
    spd$intensity <- list(int_l[[i]])
    Spectra::Spectra(spd)})
sps_li <- Reduce(c, sps_l)
sps_li@metadata <- data.frame(show = rep(TRUE, length(sps_l)))
```

Furthermore, further columns in the `data.frame` passed to
`metadata` can be specified to host additional information, e.g.
metabolite name (column “names”) and classes (column “classes”), adduct ion
names (column “adduct”), further information (column “information”).

## 3.2 Preparing the floral organ data set for analysis

We would like to restrict the proof-of-function analysis to four tissues
(sepal, SPL; limb, LIM; anther, ANT;
style, STY). We will truncate `tissue` in order that it contains only
these instances belonging to these types of tissue. In a next step, we will
create a `Spectra`-object, `spl` with information concerning
if the MS/MS features are found in the tissues SPL, LIM, ANT and STY.

```
## get all MS/MS spectra
tissue <- tissue[tissue[, "id"] %in% compartmentTissue[, "mz_rt_pcgroup"], ]
id_uniq <- unique(tissue[, "id"])

## obtain precursor m/z from id_uniq
prec_mz <- lapply(strsplit(as.character(id_uniq), split = "_"), "[", 1) |>
    unlist() |>
    as.numeric()

## obtain m/z from fragments per precursor m/z
mz_l <- lapply(id_uniq, function(id_i) tissue[tissue[, "id"] == id_i, "mz"])

## obtain corresponding intensity values
int_l <- lapply(id_uniq, function(id_i) tissue[tissue[, "id"] == id_i, "intensity"])

## order mz and intensity values
int_l <- lapply(seq_along(int_l), function(i) int_l[[i]][order(mz_l[[i]])])
mz_l <- lapply(seq_along(mz_l), function(i) sort(mz_l[[i]]))

## obtain retention time by averaging all retention time values
rt <- lapply(id_uniq, function(x) tissue[tissue[, "id"] == x, "rt"]) |>
    lapply(FUN = mean) |>
    unlist()

## create list of Spectra objects and concatenate
sps_l <- lapply(seq_len(length(mz_l)), function(i) {
    spd <- S4Vectors::DataFrame(
        name = as.character(i),
        rtime = rt[i],
        msLevel = 2L,
        precursorMz = prec_mz[i])
    spd$mz <- list(mz_l[[i]])
    spd$intensity <- list(int_l[[i]])
    Spectra::Spectra(spd)})
sps_tissue <- Reduce(c, sps_l)

## add metadata
## use SPL, LIM, ANT, STY for further analysis
sps_tissue@metadata <- data.frame(
    compartmentTissue[, c("SPL", "LIM", "ANT", "STY")])
```

## 3.3 Preparing the GNPS data set for analysis

Alternatively as mentioned above, an `Spectra`-object can also created
from .MSP objects,
that are typical data formats for storing MS/MS libraries.
Required properties of such a data frame are the name of the metabolite
(row entry “NAME:”), the m/z value of the precursor ion (“PRECURSORMZ” or
“EXACTMASS:”), retention time (“RETENTIONTIME:”), information on the number of
peaks (“Num Peaks:”) and information on
fragments and peak areas (for further information see `convertMsp2Spectra`
and retrieve `data("convertMsp2Spectra", package = "MetCirc")` for a typical
msp data frame).

Create `Spectra`-object from the GNPS .MSP file:

```
sps_msp <- convertMsp2Spectra(msp2spectra)
```

# 4 Binning and calculation of similarity matrix

## 4.1 Workflow for `tissue` data set using fragment ions

### 4.1.1 Calculation of the similarity matrix

The similarity matrix can be obtained by by the `Spectra` package
function `compareSpectra` which takes a `Spectra` object and a
function for the similarity calculation as input.

The `MetCirc` package uses functions from the `Spectra`
package to calculate pair-wise similarities between MS/MS features. The
user can select the function (via `FUN`) how to calculate the similarity.
The function `ndotproduct` from the `MsCoreUtils` package
calculates the similarity coefficient
between two MS/MS features using the normalised dot product (NDP).
For a considered MS/MS pair, peak intensities of shared m/z values for
precursor/fragment ions are employed as weights
\(W\_{S1, i}\) and \(W\_{S1, i}\) within the following formula:

\[\begin{equation\*}
NDP = \frac{\sum(W\_{S1, i} \cdot W\_{S2, i}) ^ 2}{ \sum(W\_{S1, i} ^ 2) \* \sum(W\_{S2, i} ^ 2) },
\end{equation\*}\]

with S1 and S2 the spectra 1 and 2, respectively, of the i\(th\) of j common peaks
differing by the tolerance parameter specified in `compareSpectra`’s
argument `binSize`.

Weights are calculated according to \(W = [ peak~intensity] ^{m} \cdot [m/z]^n\),
with m = 0.5 and n = 2 as default values as suggested by MassBank.
For further information see Li, Baldwin, and Gaquerel ([2015](#ref-Li2015)).

Similarly, the function `neutralloss` takes into account neutral
losses between precursor m/z values and all fragments.

Alternatively, the user can specify a custom-defined function to calculate
similarities between MS/MS features or use an implemented function in
`Spectra`.
The function `compareSpectra` returns a symmetrical squared
similarity matrix with pair-wsie similarity coefficients between MS/MS
features.

```
## similarity Matrix
similarityMat <- Spectra::compareSpectra(sps_tissue[1:100,],
    FUN = MsCoreUtils::ndotproduct, ppm = 10, m = 0.5, n = 2)
colnames(similarityMat) <- rownames(similarityMat) <- sps_tissue$name[1:100]
```

`compareSpectra` returns a square matrix; in a next step, we add
the names of the `Spectra` MS/MS features as column and row names.
The entries of the returned matrix have to be similarites cores ranging between
0 and 1 that are the pair-wise similarities between the MS/MS features.

### 4.1.2 Clustering/visualisation

At this stage, we would like to visualize
the pair-wise similarities of MS/MS features after clustering them.
Many functions are available to cluster features such as `hclust`
from `stats`, `Mclust` from `mclust` or
`hcluster` from `amap`. We would like to use the latter
to cluster similar features. To cluster features and visualize the result (see
figure ) we enter:

```
## load package amap
hClustMSP <- hcluster(similarityMat, method="spearman")

## visualize clusters
plot(hClustMSP, labels = FALSE, xlab="", sub="")
```

To promote readibility we will not show labels. These can be printed to the
~console by `colnames(similarityMat)[hClustMSP\$order]`.

### 4.1.3 Extraction of highly-related features using clustering

Within the `R` session the similarity matrix can be truncated by using the
above-mentioned functions to retrieve a similarity matrix that contains
highly-related MS/MS features. For instance, this might be needed when
we want to analyse modules of high similarity, representing e.g. a certain
metabolite class. By way of example, we extract in the following all features
from module 1 when defining three modules in total and define a new
similarity matrix of highly-related features. This kind of matrix can be
used in later analysis steps, e.g. in the analysis with `shinyCircos`.

```
## define three clusters
cutTreeMSP <- cutree(hClustMSP, k = 3)

## extract feature identifiers that belong to module 1
module1 <- names(cutTreeMSP)[as.vector(cutTreeMSP) == "1"]

## create a new similarity matrix that contains only highly related features
similarityMat_module1 <- similarityMat[module1, module1]
```

# 5 Visualisation using the `shiny`/`circlize` framework

`MetCirc`’s main functionality is to visualize metabolomics
data, exploring it interactively and annotate unknown features based on
similarity to other (known) features. One of the key features of the implemented
interactive framework is, that groups can be compared. A group
specifies the affiliation of the sample: it can be
any biological identifier relevant to the comparitive experiment conducted,
e.g. it can be a specific tissue, different
times, different species, etc. The visualisation tools implemented in
`MetCirc` allow then to display similarity between
precursor ions between and/or within groups.

`shinyCircos` uses the function`createLinkDf` which
selects these precursor ions that have a similarity score (e.g. a normalised dot
product) within the range defined by `lower` and `higher` to a precursor ion.
Internally, in`shinyCircos`,`createLinkDf` will be
called to produce a data.frame with link information based on the given
thresholds.

```
linkDf <- createLinkDf(similarityMatrix = similarityMat, sps = sps_tissue,
    condition = c("SPL", "LIM", "ANT", "STY"), lower = 0.5, upper = 1)
```

As we have calculated similarity coefficients between precursors, we would
like to visualize these connections interactively and explore the data.
The `MetCirc` package implements`shinyCircos`
that allows for such kind of exploration. It is based on the `shiny`
and on the `circlize` (Gu et al. [2014](#ref-Gu2014)) framework. Inside of`shinyCircos`
information of precursor ions are displayed by (single-) clicking over precursors.
Precursors can also be permanently selected by double-clicking on them. The similarity
coefficients can be thresholded by changing the slider input. Also, on the
sidebar panel, the type of link to be displayed can be selected:
should only links between groups be displayed, should only links within groups
be displayed or should all links be displayed? Ordering inside of groups
can be changed by selecting the respective option in the sidebar panel.
Momentarily, there are options to reorder features based on clustering,
the m/z or the retention time of the precursor ion. In the “Appearance” tab,
the size of the plot can be changed, as well as the precision of the
displayed values for the m/z and retention time values. Please note,
that the precision will only be changed in the text output (not in the
graphical output). Also, the user can decide if the legend is displayed or not.

On exiting the shiny application
via the exit button in the sidebar panel, selected precursors will
be returned which are allocated here to `selectedFeatures`.
`selectedFeatures` is a vector of the precursor names.

By way of example, we would like to analyse the tissue data set focusing on
the tissues “SPL”, “LIM”, “ANT” and “STY”.

To start the shiny app, run

```
selectedFeatures <- shinyCircos(similarityMat, sps = sps_tissue,
    condition = c("LIM", "ANT", "STY"))
```

in the console. This will load information stored in the `Spectra`
object `sps_tissue` to the `shinyCircos` interface.
Information (metabolite names and
class, adduct ion name and further information) will be printed to the
interface when (single-)clicking on MS/MS features. Since this
`Spectra` object did not contain any information about metabolite
names, class, adduct ion name and further information, initally all fields for
these instances are set to “Unkwown”. Note, that on the
sidebar on the right side text fields will appear, that allow for changing
the annotation of the selected feature. Click “update annotation” to save the
changes to the `Spectra`-object. On exiting `shinyCircos` via
the exit button, selected precursors and the (updated) `Spectra`-object will
be returned to the console. In the example above, enter
`selectedFeatures$sps` to retrieve the `Spectra` object
with updated annotation.

`MetCirc` allows also to create such figures outside of an
interactive context, which might be helpful to create figures and export them
e.g. in .pdf or .jpeg format.`shinyCircos` does currently not
support to export figures as they can be easily rebuilt outside of
`shinyCircos`; building figures outside of the interactive context
also promotes reproducibility of such figures.

To rebuild the figure in a non-interactive environment, run

```
## order similarity matrix according to retention time
condition <- c("SPL", "LIM", "ANT", "STY")
simM <- orderSimilarityMatrix(similarityMatrix = similarityMat,
    sps = sps_tissue, type = "retentionTime", group = FALSE)
groupname <- rownames(simM)
inds <- MetCirc:::spectraCondition(sps_tissue,
    condition = condition)
inds_match <- lapply(inds, function(x) {inds_match <- match(groupname, x)
    inds_match <- inds_match[!is.na(inds_match)]; x[inds_match]})
inds_cond <- lapply(seq_along(inds_match),
    function(x) {
        if (length(inds_match[[x]]) > 0) {
            paste(condition[x], inds_match[[x]], sep = "_")
        } else character()
})
inds_cond <- unique(unlist(inds_cond))

## create link matrix
linkDf <- createLinkDf(similarityMatrix = simM, sps = sps_tissue,
    condition = c("SPL", "LIM", "ANT", "STY"), lower = 0.9, upper = 1)
## cut link matrix (here: only display links between groups)
linkDf_cut <- cutLinkDf(linkDf = linkDf, type = "inter")

## set circlize paramters
circos.par(gap.degree = 0, cell.padding = c(0, 0, 0, 0),
    track.margin = c(0, 0))

## here set indSelected arbitrarily
indSelected <- 14
selectedFeatures <- inds_cond[indSelected]

## actual plotting
plotCircos(inds_cond, linkDf_cut, initialize = TRUE, featureNames = TRUE,
    cexFeatureNames = 0.2, groupSector = TRUE, groupName = FALSE,
    links = FALSE, highlight = TRUE)

highlight(groupname = inds_cond, ind = indSelected, linkDf = linkDf_cut)
```

```
## plot without highlighting
plotCircos(inds_cond, linkDf_cut, initialize = TRUE, featureNames = TRUE,
    cexFeatureNames = 0.2, groupSector = TRUE, groupName = FALSE, links = TRUE,
    highlight = FALSE)
```

# Appendix

## Session information

All software and respective versions to build this vignette are listed here:

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
##  [1] MsCoreUtils_1.22.0  MetCirc_1.40.0      Spectra_1.20.0
##  [4] BiocParallel_1.44.0 S4Vectors_0.48.0    BiocGenerics_0.56.0
##  [7] generics_0.1.4      shiny_1.11.1        scales_1.4.0
## [10] circlize_0.4.16     amap_0.8-20         knitr_1.50
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10            shape_1.4.6.1          digest_0.6.37
##  [4] magrittr_2.0.4         evaluate_1.0.5         grid_4.5.1
##  [7] RColorBrewer_1.1-3     bookdown_0.45          fastmap_1.2.0
## [10] jsonlite_2.0.0         ProtGenerics_1.42.0    tinytex_0.57
## [13] GlobalOptions_0.1.2    promises_1.4.0         BiocManager_1.30.26
## [16] codetools_0.2-20       jquerylib_0.1.4        cli_3.6.5
## [19] rlang_1.1.6            cachem_1.1.0           yaml_2.3.10
## [22] otel_0.2.0             tools_4.5.1            parallel_4.5.1
## [25] dplyr_1.1.4            ggplot2_4.0.0          colorspace_2.1-2
## [28] httpuv_1.6.16          vctrs_0.6.5            R6_2.6.1
## [31] mime_0.13              magick_2.9.0           lifecycle_1.0.4
## [34] fs_1.6.6               IRanges_2.44.0         clue_0.3-66
## [37] MASS_7.3-65            cluster_2.1.8.1        pkgconfig_2.0.3
## [40] pillar_1.11.1          gtable_0.3.6           bslib_0.9.0
## [43] later_1.4.4            glue_1.8.0             Rcpp_1.1.0
## [46] tidyselect_1.2.1       tibble_3.3.0           xfun_0.53
## [49] dichromat_2.0-0.1      farver_2.1.2           xtable_1.8-4
## [52] htmltools_0.5.8.1      rmarkdown_2.30         compiler_4.5.1
## [55] S7_0.2.0               MetaboCoreUtils_1.18.0
```

## Neutral losses

## Bibliography

Gu, Z., L. Gu, R. Eils, M. Schlesner, and B. Brors. 2014. “Circlize Implements and Enhances Circular Visualization in R.” *Bioinformatics* 30: 2811–2. <https://doi.org/10.1093/bioinformatics/btu393>.

Krzywinski, M. I., J. Schein, I. Birol, J. Connors, R. Gascoyne, D. Horsman, S. J. Jones, and M. A. Marra. 2009. “Circos: An Information Aesthetic for Comparative Genomics.” *Genome Research* 19: 1639–45. <https://doi.org/10.1101/gr.092759.109>.

Li, D., I. T. Baldwin, and E. Gaquerel. 2015. “Navigating Natural Variation in Herbivory-Induced Secondary Metabolism in Coyote Tobacco Populations Using Ms/Ms Structural Analysis.” *PNAS* 112: E4147–E4155. <https://doi.org/10.1073/pnas.1503106112>.

Watrous, J., P. Roach, T. Alexandrov, B. S. Heath, J. Y. Yanga, R. D. Kersten, M. van der Voort, et al. 2012. “Mass Spectral Molecular Networking of Living Microbial Colonies.” *PNAS* 109: E1743–E1752. <https://doi.org/10.1073/pnas.1203689109>.