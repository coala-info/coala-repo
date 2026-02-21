# Example workflow for processing of raw spectral cytometry files

Jakob Theorell1,2

1Oxford Autoimmune Neurology Group, Nuffield Department of Clinical Neurosciences, University of Oxford, Oxford, United Kingdom
2Department of Clinical Neurosciences, Karolinska Institutet, Stockholm, Sweden

#### 2025-10-29

# 1 Introduction

In this document, I aim at showing a typical analysis of a spectral cytometry
file, including the construction of the spectral decomposition matrix, the
actual decomposition, correction of the resulting file (as there generally
are minor differences between the single-stained controls and the fully
stained sample) and finally converting the resulting flowFrame or flowSet to a
dataframe that can be used for any downstream application.
Note: This whole package is very much dependent on
**flowCore**, and much of the functionality herein works as an extention of the
basic **flowCore** functionality.

# 2 Installation

This is how to install the package, if that has not already been done:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("flowSpecs")
```

# 3 Example data description

The dataset that is used in this vinjette, and that is the example dataset in
the package generally, is a PBMC sample stained with 12 fluorochrome-conjugated
antibodies against a wide range of leukocyte antigens. Included is also a set
of single-stained controls, that fill the same function with spectral cytometry
as in conventional ditto. The files were generated on a 44 channel Cytek Aurora®
instrument 2018-10-25.

```
library(flowSpecs)
library(flowCore)
data("unmixCtrls")
unmixCtrls
```

```
## A flowSet with 15 experiments.
##
## column names(47): Time SSC-H ... R9-A R10-A
```

```
data('fullPanel')
fullPanel[,seq(4,7)]
```

```
## flowFrame object 'fullPanel.fcs'
## with 8000 cells and 4 observables:
##       name   desc     range  minRange  maxRange
## $P4   V1-A     NA   4194304      -111   4194303
## $P5   V2-A     NA   4194304      -111   4194303
## $P6   V3-A     NA   4194304      -111   4194303
## $P7   V4-A     NA   4194304      -111   4194303
## 416 keywords are stored in the 'description' slot
```

As can be noted, flowSpecs adheres to flowCore standards, and thus uses
flowFrames and flowSets as input to all user functions.

# 4 Construction of spectral unmixing matrix

To do this, we need the single-stained unmixing controls. As the fluorescent
sources can be of different kinds, such as from antibodies, fluorescent
proteins, or dead cell markers, the specMatCalc function accepts any number
of different such groups. However, the groups need to have a common part of
their names. If this was not the case during acquisition, the names of the fcs
files can always be changed afterwards. To check the names, run the
sampleNames function from flowCore:

```
sampleNames(unmixCtrls)
```

```
##  [1] "Beads_AF647_IgM.fcs"    "Beads_AF700_CD4.fcs"    "Beads_APCCy7_CD19.fcs"
##  [4] "Beads_BV605_CD14.fcs"   "Beads_BV650_CD56.fcs"   "Beads_BV711_CD11c.fcs"
##  [7] "Beads_BV785_CD8a.fcs"   "Beads_FITC_CD41b.fcs"   "Beads_PB_CD3.fcs"
## [10] "Beads_PE_X.fcs"         "Beads_PECy7_CD45RA.fcs" "Beads_unstained.fcs"
## [13] "Dead_PO_DCM.fcs"        "Dead_unstained.fcs"     "PBMC_unstained.fcs"
```

This shows that we have three groups of samples: “Beads”, “Dead” and “PBMC”. The
two first are groups that define the fluorochromes from antibodies and the dead
cell marker (which is pacific orange-NHS in this case). The last one, “PBMC”,
will be used for autofluorescence correction. For obvious reasons, the autofluo
control should always be from the same type of sample as the samples that will
be analyzed downstream.
With this knowledge about the groups of samples, we can now create the matrix:

```
specMat <- specMatCalc(unmixCtrls, groupNames = c("Beads_", "Dead_"),
                        autoFluoName = "PBMC_unstained.fcs")
str(specMat)
```

```
##  num [1:13, 1:42] 0.000058 0.001032 0.000649 0.029998 0.052618 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:13] "AF647_IgM" "AF700_CD4" "APCCy7_CD19" "BV605_CD14" ...
##   ..$ : chr [1:42] "V1-A" "V2-A" "V3-A" "V4-A" ...
```

Here we can see that a matrix with the original fluorescence detector names
as column names, and the new fluorochrome/marker names as row names has been
created. The function does a lot of preprocessing, with automatic gating of the
most dominant population, as well as picking out the positive population if a
negative control was included in each sample, etc, to ensure the best possible
resolution and consistency in the determination of the matrix.

# 5 Spectral unmixing

Now it is time to apply the newly constructed specMat to the fully stained
sample. This is done in the following way:

```
fullPanelUnmix <- specUnmix(fullPanel, specMat)
fullPanelUnmix
```

```
## flowFrame object 'fullPanel.fcs'
## with 8000 cells and 18 observables:
##              name         desc     range  minRange  maxRange
## $P1          Time         Time  16777216         0  16777215
## $P2         SSC-H        SSC-H   4194304         0   4194303
## $P3         SSC-A        SSC-A   4194304         0   4194303
## $P4         FSC-H        FSC-H   4194304         0   4194303
## $P5         FSC-A        FSC-A   4194304         0   4194303
## ...           ...          ...       ...       ...       ...
## $P14       PB_CD3       PB_CD3   4194304      -111   4194303
## $P15         PE_X         PE_X   4194304      -111   4194303
## $P16 PECy7_CD45RA PECy7_CD45RA   4194304      -111   4194303
## $P17       PO_DCM       PO_DCM   4194304      -111   4194303
## $P18     Autofluo     Autofluo   4194304      -111   4194303
## 416 keywords are stored in the 'description' slot
```

Notable is that the names now have been exchanged for the fluorescent molecules
instead of the detector channels. The algorithm below this function is currently
least squares regression.

# 6 Transformation

As with all cytometry data, for correct interpretation, the data needs to be
transformed using one of the lin-log functions. As the arcsinh function is
widely used and also has a single co-function that controls the level of
compression aroud zero, it is used in this package. The function has a number
of built-in features, such as automatic detection of if the file comes from
mass or flow cytometry, and will give differenc cofactors accordingly. It is
however always the best practice to set the cofactors individually, to ensure
that no artifactual populations are created, which can happen, if there is
too much resolution around zero. One automated strategy for this, which
would make the arcTrans function unnecessary, is to use the [flowVS](https://www.bioconductor.org/packages/release/bioc/html/flowVS.html) package.

The arcTrans function requires the names of the variables that should be
transformed to be specified.

```
fullPanelTrans <- arcTrans(fullPanelUnmix, transNames =
                            colnames(fullPanelUnmix)[6:18])
par(mfrow=c(1,2))
hist(exprs(fullPanelUnmix)[,7], main = "Pre transformation",
     xlab = "AF700_CD4", breaks = 200)
hist(exprs(fullPanelTrans)[,7], main = "Post transformation",
     xlab = "AF700_CD4", breaks = 200)
```

![](data:image/png;base64...)
As can be seen in the histograms, the ranges, scales and resolution have now
changed dramatically.
(Biologically, the three peaks correspond to CD4- cells, CD4+myeloid cells and
CD4+T-cells, respectively).

# 7 Investigation of possible unmixing artifacts

An important step in the early processing of cytometry files is to investigate
if, or rather where, unmixing artifacts have arisen. There are multiple reasons
for the occurrence of such artifacts, but listing them are outside of the scope
of this vinjette. In the package, there is one function that is well suited for
for this task, and that is the oneVsAllPlot function. When used without
specifying a marker, the function will create a folder and save all possible
combinations of markers to that folder. Looking at them gives a good overview
of the data. In this case, for the vinjette purpose, I am only plotting one
of the multi-graphs.

```
oneVsAllPlot(fullPanelTrans, "AF647_IgM", saveResult = FALSE)
```

![](data:image/png;base64...)

This shows a typical artifact between BV650\_CD56 and AF647\_IgM: it is
biologically extremely unlikely that the higher expression one sees of CD56,
the more extremely below zero do the values become for IgM\_AF647.

# 8 Correction of artifacts

Now to one of the more controversial subjects of cytometry, that rightly causes
alarm amongst anyone concerned about reproducibility: the correction of
artifacts. When this is done aided by fluorescence-minus-one controls (and an
automated function with that purpose is being considered for this package), it
is less controversial, but even without them, one can follow a few rules, to
increase the usefulness of the data. It is namely important to note, that if
artifacts, of the kind we will now start to correct, are left in the data, then
they are likely to cause incorrect interpretation of the results:
As a rule of thumb, one can assume negative correlations for
single-positive markers (i.e. positive for x but negative for y) to always be
artifacts, as true populations below a negative population cannot exist. Strong
positive correlations are unlikely, but occur in biology, so caution and
biological considerations should be taken before any corrections of such are
attempted, but they should nonetheless be considered, as leaving them in can
cause harm.

Normally, when correcting flow cytometry results, one just changes the
compensation matrix. In this case, however, where the compensation matrix is not
symmetrical, that becomes a non-trivial affair. For that reason, this package
introduces a correction matrix, which is a secondary, symmetric matrix only
meant to be used on already unmixed files. It can for that reason take both
positive and negative values.

When starting the correction phase, we have to create an empty correction
matrix.

```
corrMat <- corrMatCreate(specMat)
```

This is how this correction matrix is meant to be used:
A value of 1 corresponds to +100% correction, a value of 0, to 0% correction.
Thus: if the value 1 is added to the coordinate [x,y], then if event 1 has a
value of 50 in marker x, then event 1 will get +50 in marker y.

Practically, in our case, we see that it seems like BV650\_CD56 is slightly
“overunmixed” from AF647\_IgM. This means that we should add a negative
correction. Let us start with 0.1, or 10%.

```
corrMat["BV650_CD56", "AF647_IgM"] <- -0.1
fullPanelCorr <- correctUnmix(fullPanelUnmix, corrMat)
oneVsAllPlot(fullPanelCorr, "AF647_IgM", saveResult = FALSE)
```

![](data:image/png;base64...)
Here, a few things can be noted. First, the correction function takes the non-
transformed file as input. Second, there is an automatic transformation within
this function, as it would be tedious, always having to rerun the arcTrans
function during this phase, that is generally quite repetitive.
Thrdly, we overdid it, as the population is now clearly “undermixed” instead,
with a considerable bleed-over of CD56+ cells into the IgM marker channel.
Thus, we repeat it with a lower value.

```
corrMat["BV650_CD56", "AF647_IgM"] <- -0.03
fullPanelCorr <- correctUnmix(fullPanelUnmix, corrMat)
oneVsAllPlot(fullPanelCorr, "AF647_IgM", saveResult = FALSE)
```

![](data:image/png;base64...)
This time, the result was satisfactory. There are other minor defects in the
unmixing, however, such as between AF647\_IgM and PE\_X. This is typically the
case, and as long as this needs to be done manually, it will use considerable
time, especialy for more complex panels.
Notable is also that as we are just changing the correction matrix, and
redoing the analysis from the unmixed file every time, we do not need to take
the previous values into consideration.

# 9 Connecting to other non-flowCore compliant applications

Many clustering algorithms and similar take a matrix-like input. If data is
to be combined from multiple fcs files, and clustered together, the most
convenient way might be to create a long data frame containing identifiers as
separate columns from the flowSet. The flowSpecs package contains a function to
do this. It works also for single flowFrames, but there it might be easier to
just extract the data with the exprs() function from flowCore.

To set up our file for the task, we will convert it to a flowSet and change its
currently non-existent name to something useful.

```
fullPanelFs <- flowSet(fullPanelTrans)
sampleNames(fullPanelFs) <- "PBMC_full_panel_d1.fcs"
```

The function we are goning to use can chop up the name of the file into
multiple strings, if the right information is added in a gsub-compliant
format. These strings are then added as new columns to the resulting dataframe,
and if the fcs files have been systematically named (or their sampleNames
changed to something systematic in accordance with the example above), we will
in this way be able to group the data based on the new categorizing columns.

```
fullPanelDf <- flowSet2LongDf(fullPanelFs, idInfo =
        list("Tissue" = "|_full_panel_..\\.fcs",
             "Donor" = "...._full_panel_|\\.fcs"))
str(fullPanelDf)
```

```
## 'data.frame':    8000 obs. of  21 variables:
##  $ Time        : num  257175 537280 559170 339827 139500 ...
##  $ SSC.H       : num  351531 902606 615990 502753 1235630 ...
##  $ SSC.A       : num  432574 1127647 784518 604359 1734489 ...
##  $ FSC.H       : num  1629492 1978410 1634036 1716769 2040715 ...
##  $ FSC.A       : num  1912225 2364255 1855924 1925570 2920881 ...
##  $ AF647_IgM   : num  1.73 1.55 1.92 1.96 2.66 ...
##  $ AF700_CD4   : num  5.058 -0.332 5.279 4.866 2.667 ...
##  $ APCCy7_CD19 : num  -2.81 0.373 -1.792 -0.788 1.321 ...
##  $ BV605_CD14  : num  -1.087 5.901 0.253 0.91 5.966 ...
##  $ BV650_CD56  : num  1.316 2.973 0.287 -0.304 2.816 ...
##  $ BV711_CD11c : num  1.032 2.936 1.133 0.532 4.264 ...
##  $ BV785_CD8a  : num  2.17 1.2 2 2.5 1.36 ...
##  $ FITC_CD41b  : num  0.996 1.284 1.05 0.36 1.935 ...
##  $ PB_CD3      : num  5.03 -0.803 4.039 4.198 0.145 ...
##  $ PE_X        : num  -0.928 0.82 0.606 -0.287 1.143 ...
##  $ PECy7_CD45RA: num  6.646 3.109 3 0.231 3.851 ...
##  $ PO_DCM      : num  2.169 2.391 2.428 0.467 2.949 ...
##  $ Autofluo    : num  2.59 3.25 2.44 2.01 3.64 ...
##  $ Tissue      : chr  "PBMC" "PBMC" "PBMC" "PBMC" ...
##  $ Donor       : chr  "d1" "d1" "d1" "d1" ...
##  $ acqDate     : chr  "25-Oct-2018" "25-Oct-2018" "25-Oct-2018" "25-Oct-2018" ...
```

This dataframe can now be used in other applications.

# 10 Summary

In this vinjette, a typical spectral cytometry analysis is performed, which
is currently the main objective with the package. However, a number of functions
for automatic gating, CyTOF fcs file cleanup, etc are in the pipe line and will
be added to the package in the coming months, together with new vinjettes.

# 11 Session information

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
## [1] flowSpecs_1.24.0 flowCore_2.22.0  knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         generics_0.1.4      lattice_0.22-7
##  [4] stringi_1.8.7       digest_0.6.37       magrittr_2.0.4
##  [7] evaluate_1.0.5      grid_4.5.1          RColorBrewer_1.1-3
## [10] bookdown_0.45       fastmap_1.2.0       plyr_1.8.9
## [13] jsonlite_2.0.0      tinytex_0.57        BiocManager_1.30.26
## [16] scales_1.4.0        codetools_0.2-20    jquerylib_0.1.4
## [19] cli_3.6.5           rlang_1.1.6         RProtoBufLib_2.22.0
## [22] Biobase_2.70.0      withr_3.0.2         cachem_1.1.0
## [25] yaml_2.3.10         cytolib_2.22.0      tools_4.5.1
## [28] parallel_4.5.1      reshape2_1.4.4      BiocParallel_1.44.0
## [31] dplyr_1.1.4         ggplot2_4.0.0       BiocGenerics_0.56.0
## [34] vctrs_0.6.5         R6_2.6.1            magick_2.9.0
## [37] zoo_1.8-14          matrixStats_1.5.0   stats4_4.5.1
## [40] lifecycle_1.0.4     stringr_1.5.2       S4Vectors_0.48.0
## [43] pkgconfig_2.0.3     hexbin_1.28.5       bslib_0.9.0
## [46] pillar_1.11.1       gtable_0.3.6        glue_1.8.0
## [49] Rcpp_1.1.0          xfun_0.53           tibble_3.3.0
## [52] tidyselect_1.2.1    dichromat_2.0-0.1   farver_2.1.2
## [55] htmltools_0.5.8.1   labeling_0.4.3      rmarkdown_2.30
## [58] compiler_4.5.1      S7_0.2.0
```