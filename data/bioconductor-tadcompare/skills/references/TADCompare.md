# TAD comparison between two conditions

Kellen Cresswell1 and Mikhail Dozmorov1

1Department of Biostatistics, Virginia Commonwealth University, Richmond, VA

#### 30 October 2025

# Contents

* [0.1 Installation](#installation)
* [1 TADCompare](#tadcompare)
  + [1.1 Introduction](#introduction)
  + [1.2 Running TADcompare](#running-tadcompare)
  + [1.3 Types of TADCompare output](#types-of-tadcompare-output)
  + [1.4 Pre-specification of TADs](#pre-specification-of-tads)
  + [1.5 Visualization of TADCompare Results](#visualization)
    - [1.5.1 Comparing TAD boundary scores](#comparing-tad-boundary-scores)
    - [1.5.2 Comparing pre-defined TAD boundaries](#comparing-pre-defined-tad-boundaries)
* [2 TimeCompare](#timecompare)
  + [2.1 Introduction](#introduction-1)
  + [2.2 Running TimeCompare](#running-timecompare)
* [3 ConsensusTAD](#consensustads)
  + [3.1 Introduction](#introduction-2)
  + [3.2 Running ConsensusTADs](#running-consensustads)
* [4 Session Info](#session-info)
* [References](#references)

## 0.1 Installation

```
BiocManager::install("TADCompare")
# Or, for the developmental version
devtools::install_github("dozmorovlab/TADCompare")
```

```
library(dplyr)
library(SpectralTAD)
library(TADCompare)
```

# 1 TADCompare

## 1.1 Introduction

`TADCompare` is a function that allows users to automatically identify differential TAD boundaries between two datasets. For each differential boundary, we provide unique classification (complex, merge, split, shifted, and strength change) defining how the TAD boundaries change between the datasets.

## 1.2 Running TADcompare

The only required input is two contact matrices in one of the permitted forms specified in the [Input data vignette](Input_Data.html). `TADCompare` function will automatically determine the type of matrix and convert it to an appropriate form, given it is one of the supported formats. The only requirement is that all matrices be in the same format. For the fastest results, we suggest using \(n \times n\) matrices. Additionally, we recommend users to provide resolution of their data. If the resolution is not provided, we estimate it using the numeric column names of contact matrices. We illustrate running `TADCompare` using the data from GM12878 cell line, chromosome 22, 50kb resolution (Rao et al. [2014](#ref-Rao:2014aa)).

```
# Get the rao contact matrices built into the package
data("rao_chr22_prim")
data("rao_chr22_rep")
# We see these are n x n matrices
dim(rao_chr22_prim)
```

```
## [1] 704 704
```

```
dim(rao_chr22_rep)
```

```
## [1] 704 704
```

```
# And, get a glimpse how the data looks like
rao_chr22_prim[100:105, 100:105]
```

```
##          2.1e+07 21050000 21100000 21150000 21200000 21250000
## 2.1e+07     6215     1047     1073      714      458      383
## 21050000    1047     4542     2640     1236      619      489
## 21100000    1073     2640    13468     4680     1893     1266
## 21150000     714     1236     4680    13600     4430     2124
## 21200000     458      619     1893     4430    11313     4465
## 21250000     383      489     1266     2124     4465    11824
```

```
# Running the algorithm with resolution specified
results = TADCompare(rao_chr22_prim, rao_chr22_rep, resolution = 50000)
# Repeating without specifying resolution
no_res = TADCompare(rao_chr22_prim, rao_chr22_rep)
```

```
## Estimating resolution
```

```
# We can see below that resolution can be estimated automatically if necessary
identical(results$Diff_Loci, no_res$Diff_Loci)
```

```
## [1] TRUE
```

## 1.3 Types of TADCompare output

`TADCompare` function returns a list with two data frames and one plot. The first data frame contains all regions of the genome containing a TAD boundary in at least one of the contact matrices. The results are shown below:

```
head(results$TAD_Frame)
```

```
##   Boundary   Gap_Score TAD_Score1 TAD_Score2     Differential Enriched_In
## 1 16300000 -18.6589859  0.7698503   7.704411     Differential    Matrix 2
## 2 16850000   0.2361100  7.8431724   7.580056 Non-Differential    Matrix 1
## 3 17350000   0.9683905  3.6628411   3.220253 Non-Differential    Matrix 1
## 4 18000000  -0.1033894  2.3616107   2.347392 Non-Differential    Matrix 2
## 5 18750000   3.0426660  4.7997622   3.558975     Differential    Matrix 1
## 6 18850000   2.6911660  3.7674844   2.680707     Differential    Matrix 1
##               Type
## 1             <NA>
## 2 Non-Differential
## 3 Non-Differential
## 4 Non-Differential
## 5  Strength Change
## 6  Strength Change
```

The “Boundary” column contains genomic coordinates of the given boundary. “Gap\_Score” corresponds to the differential boundary score (Z-score of the difference between boundary scores). “TAD\_Score1” and “TAD\_Score2” corresponds to the boundary score of the two contact matrices. “Differential” simply indicates whether the boundary is differential or not differential. “Enriched\_In” indicates which matrix contains the TAD boundary. “Type” identifies the type of TAD boundary change. Note: The first boundary will always be classified as “NA” since specific classification is impossible without a reference boundary to the left and right.

The second data frame contains the same information as the first data frame but includes every region of the genome. We show it below:

```
head(results$Boundary_Scores)
```

```
##   Boundary TAD_Score1 TAD_Score2     Gap_Score     Differential Enriched_In
## 1 16300000  0.7698503  7.7044114 -18.658985912     Differential    Matrix 2
## 2 16850000  7.8431724  7.5800558   0.236110024 Non-Differential    Matrix 1
## 3 16900000 -0.4402121 -0.4337948   0.009161239 Non-Differential    Matrix 1
## 4 16950000 -0.7460531 -0.5551327  -0.467725582 Non-Differential    Matrix 2
## 5 17000000 -0.6803509 -0.6512025  -0.037456910 Non-Differential    Matrix 2
## 6 17050000 -0.6626352 -0.5562997  -0.245694062 Non-Differential    Matrix 2
##               Type
## 1             <NA>
## 2 Non-Differential
## 3 Non-Differential
## 4 Non-Differential
## 5 Non-Differential
## 6 Non-Differential
```

Finally, we include a plot that contains a stacked barplot indicating the prevalence of each type of TAD boundary. The barplot is a `ggplot2` object, making it completely customizable. We show this below:

```
p <- results$Count_Plot
class(p)
```

```
## [1] "ggplot2::ggplot" "ggplot"          "ggplot2::gg"     "S7_object"
## [5] "gg"
```

```
plot(p)
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_bar()`).
```

![](data:image/png;base64...)

## 1.4 Pre-specification of TADs

We recognize that users may like to use their own TAD caller for the identification of TAD boundaries prior to boundary comparison. As a result, we provide the option for pre-specification of TADs in a form of two data frames with chromosome, start, and end coordinates of TAD boundaries for the two contact matrices. With this option, only provided TAD boundaries will be tested. We provide an example below using the [SpectralTAD](https://bioconductor.org/packages/release/bioc/html/SpectralTAD.html) TAD caller (Cresswell, Stansfield, and Dozmorov, [n.d.](#ref-Cresswell:2019aa)):

```
# Call TADs using SpectralTAD
bed_coords1 = bind_rows(SpectralTAD::SpectralTAD(rao_chr22_prim, chr = "chr22", levels = 3))
```

```
## Estimating resolution
```

```
bed_coords2 = bind_rows(SpectralTAD(rao_chr22_rep,  chr = "chr22", levels = 3))
```

```
## Estimating resolution
```

```
# Combining the TAD boundaries for both contact matrices
Combined_Bed = list(bed_coords1, bed_coords2)

# Printing the combined list of TAD boundaries
```

Above, we see the dataset output by SpectralTAD contains a column named “start” and “end” indicating the start and end coordinate of each TAD. This is required, though the output of any TAD caller can be used effectively with some data manipulation. The “Level” column indicates the level of TAD in a hierarchy.

```
# Running TADCompare with pre-specified TADs
TD_Compare = TADCompare(rao_chr22_prim, rao_chr22_rep, resolution = 50000, pre_tads = Combined_Bed)

# Returning the boundaries
head(TD_Compare$TAD_Frame)
```

```
##   Boundary   Gap_Score TAD_Score1 TAD_Score2     Differential Enriched_In
## 1 16850000  0.23611002  7.8431724  7.5800558 Non-Differential    Matrix 1
## 2 17250000 -0.08875306  0.1103987  0.1409999 Non-Differential    Matrix 2
## 3 17300000 -0.12694247 -0.6160007 -0.5549497 Non-Differential    Matrix 2
## 4 17350000  0.96839048  3.6628411  3.2202526 Non-Differential    Matrix 1
## 5 17600000 -0.06733403 -0.4153272 -0.3809658 Non-Differential    Matrix 2
## 6 18000000 -0.10338944  2.3616107  2.3473922 Non-Differential    Matrix 2
##               Type
## 1      Non-Overlap
## 2      Non-Overlap
## 3      Non-Overlap
## 4      Non-Overlap
## 5      Non-Overlap
## 6 Non-Differential
```

```
# Testing to show that all pre-specified boundaries are returned
table(TD_Compare$TAD_Frame$Boundary %in% bind_rows(Combined_Bed)$end)
```

```
##
## TRUE
##   96
```

Here, we see that the only boundaries that are returned are those we pre-specified.

## 1.5 Visualization of TADCompare Results

We provide means for visualizing differential TAD boundaries using the `DiffPlot` function. As an input, `DiffPlot` takes the output from the `TADCompare` function and the original contact matrices. As an output, it returns a `ggplot2` object that can be further customized. We demonstrate visualization of the differences between GM12878 and IMR90 cell lines, on the subset of chromosome 2, 40kb resolution data processed in Schmitt et al. (Schmitt et al. [2016](#ref-Schmitt:2016aa)):

```
data("GM12878.40kb.raw.chr2")
data("IMR90.40kb.raw.chr2")
mtx1 <- GM12878.40kb.raw.chr2
mtx2 <- IMR90.40kb.raw.chr2
res <- 40000 # Set resolution
# Globally normalize matrices for better visual comparison (does not affect TAD calling)
mtx1_total <- sum(mtx1)
mtx2_total <- sum(mtx2)
(scaling_factor <- mtx1_total / mtx2_total)
```

```
## [1] 0.3837505
```

```
# Rescale matrices depending on which matrix is smaller
if (mtx1_total > mtx2_total) {
  mtx2 <- mtx2 * scaling_factor
} else {
  mtx1 <- mtx1 * (1 / scaling_factor)
}
# Coordinates of interesting regions
start_coord <- 8000000
end_coord   <- 16000000
# Another interesting region
# start_coord <- 40000000
# end_coord   <- 48000000
```

### 1.5.1 Comparing TAD boundary scores

```
# Running TADCompare as-is
TD_Compare <- TADCompare(mtx1, mtx2, resolution = res)
# Running the plotting algorithm with pre-specified TADs
p <- DiffPlot(tad_diff    = TD_Compare,
              cont_mat1   = mtx1,
              cont_mat2   = mtx2,
              resolution  = res,
              start_coord = start_coord,
              end_coord   = end_coord,
              show_types  = TRUE,
              point_size  = 5,
              max_height  = 5,
              rel_heights = c(1, 2),
              palette     = "RdYlBu")
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## ℹ The deprecated feature was likely used in the TADCompare package.
##   Please report the issue at
##   <https://github.com/dozmorovlab/TADCompare/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
plot(p)
```

![](data:image/png;base64...)

From these results, we can see that boundary scores from both matrices (“Boundary score 1” and “Boundary score 2”) frequently detected as significant boundaries in both matrices (boundary scores above the 1.5 threshold), but are non-differential (black dots). The differential boundaries correspond to the “Differential boundary score” track, where absolute boundary score differences above the 2.0 threshold are detected. The different types of differential boundaries are defined according to a schema described in the `TADCompare` manuscript. Note that coloring by types may be disabled by setting “show\_types” to FALSE; only differential and non-differential labels will be shown.

### 1.5.2 Comparing pre-defined TAD boundaries

We can also use pre-specified TADs by providing a list of TAD coordinates containing TAD boundaries for each contact matrix. The list should be of length 2. We show how to do this below, using SpectralTAD for pre-specification:

```
# Call TADs using SpectralTAD
bed_coords1 = bind_rows(SpectralTAD(mtx1, chr = "chr2", levels = 3))
```

```
## Estimating resolution
```

```
bed_coords2 = bind_rows(SpectralTAD::SpectralTAD(mtx2, chr = "chr2", levels = 3))
```

```
## Estimating resolution
```

```
# Placing the data in a list for the plotting procedure
Combined_Bed = list(bed_coords1, bed_coords2)

# Running TADCompare with pre-specified TADs
TD_Compare <-  TADCompare(mtx1, mtx2, resolution = res, pre_tads = Combined_Bed)
# Running the plotting algorithm with pre-specified TADs
p <- DiffPlot(tad_diff    = TD_Compare,
              cont_mat1   = mtx1,
              cont_mat2   = mtx2,
              resolution  = res,
              start_coord = start_coord,
              end_coord   = end_coord,
              pre_tad     = Combined_Bed,
              show_types  = FALSE,
              point_size  = 5,
              max_height  = 10,
              rel_heights = c(1.5, 2),
              palette     = "RdYlBu")
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the TADCompare package.
##   Please report the issue at
##   <https://github.com/dozmorovlab/TADCompare/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
plot(p)
```

![](data:image/png;base64...)

As we can see, the pre-specification of TADs allows us to outline TAD boundaries enhancing visualization. Additionally, the differential boundaries presented now correspond to those called by the TAD caller as opposed to those detected by `TADCompare` using boundary scores. Note that the pre-specified TAD boundaries do not necessarily correspond to the boundary scores; consequently, the classification schema is applied with respect to the pre-specified TAD boundaries. Howevery, using pre-specified TADs makes it is easier to visually interpret the differences of the differences. Therefore, we recommend setting “show\_types” to FALSE. Additionally, for the pre-specified TADs, a new category is introduced, called “Non-Overlap”. Non-Overlap corresponds to boundaries that are determined to be non-differential by `TADCompare` but do not overlap when called by the TAD caller.

# 2 TimeCompare

## 2.1 Introduction

`TimeCompare` is a function for the time-course analysis of data. Briefly, a user inputs a list of contact matrices representing at least four time points. The `TimeCompare` function will run with fewer time points, but the classification of temporal changes may be incorrect. The output is a data frame containing all regions with TAD boundaries detected in at least one time point. These regions are further classified into six separate types of temporal changes (Highly common, dynamic, early/late appearing, and early/late disappearing) based on how TAD boundaries evolve over time. The function also returns a plot summarizing the occurrence of each TAD boundary and another data frame containing a summary of change at each region, regardless of whether a boundary was detected.

## 2.2 Running TimeCompare

`TimeCompare` function takes a list of matrices similar in format to `TADCompare` function. Like `TADCompare`, `TimeCompare` function will estimate resolution and convert matrices to the appropriate format. For this example, we use time-varying sparse 3-column contact matrices from (Rao et al. [2017](#ref-Rao:2017aa)), representing the HCT-116 cell line. The matrices represent a single chromosome 22 cell sample treated with TAD boundary destroying auxin. The data is then sequenced at four time points (20, 40, 60, and 180 minutes) after the withdrawal of auxin. Once auxin is withdrawn, the TAD boundaries slowly return. Using `TimeCompare` function, we can track the return of TADs after withdrawal.

```
# Get the list of contact matrices
data("time_mats")
# Checking format
head(time_mats[[1]])
```

```
## # A tibble: 6 × 3
##         X1       X2    X3
##      <dbl>    <dbl> <dbl>
## 1 16050000 16050000    14
## 2 16100000 16100000     3
## 3 16200000 16200000     1
## 4 16250000 16250000     1
## 5 16300000 16300000    10
## 6 16350000 16350000     2
```

```
# These are sparse 3-column matrices
# Running MultiCompare
time_var <- TimeCompare(time_mats, resolution = 50000)
```

```
## Converting to n x n matrix
```

```
## Matrix dimensions: 704x704
## Matrix dimensions: 704x704
## Matrix dimensions: 704x704
## Matrix dimensions: 704x704
```

The first item returned by `TimeCompare` function is `TAD_Bounds`, a data frame containing all regions that contain a TAD boundary detected in at least one time point:

```
head(time_var$TAD_Bounds)
```

```
##   Coordinate   Sample 1   Sample 2   Sample 3   Sample 4 Consensus_Score
## 1   16900000 -0.6733709 -0.7751516 -0.7653696 15.1272252     -0.71937026
## 2   17350000  3.6406563  2.3436229  3.0253018  0.7840556      2.68446232
## 3   18850000  0.6372268  6.3662244 -0.7876844  6.9255446      3.50172562
## 4   20700000  1.5667926  3.0968633  2.9130479  2.8300136      2.87153075
## 5   22000000 -1.0079676 -0.7982571  0.6007264  3.1909178     -0.09876534
## 6   22050000 -1.0405532 -0.9892242 -0.2675822  4.2737511     -0.62840320
##                 Category
## 1     Late Appearing TAD
## 2 Early Disappearing TAD
## 3    Early Appearing TAD
## 4            Dynamic TAD
## 5     Late Appearing TAD
## 6     Late Appearing TAD
```

The first column corresponds to genomic coordinates. The columns beginning with the “Sample” prefix correspond to the boundary score at the given coordinate in each sample. The consensus score is simply the median score across all samples, and the category corresponds to the type of change.

`All_Bounds` is the second list entry and is identical in structure to the `TAD_Bounds` data frame, but it includes every region of the genome regardless of whether it is a TAD or not.

```
head(time_var$All_Bounds)
```

```
##   Coordinate   Sample 1   Sample 2   Sample 3   Sample 4 Consensus_Score
## 1   16900000 -0.6733709 -0.7751516 -0.7653696 15.1272252      -0.7193703
## 2   16950000 -0.6343671 -0.6624276 -0.4107173 -0.6656620      -0.6483973
## 3   17000000 -1.0409280 -0.7618272  0.7910678 -1.0008876      -0.8813574
## 4   17050000 -0.9199917 -0.7123180  0.6712399 -0.8254422      -0.7688801
## 5   17100000 -0.6097913 -0.4785485 -0.6232367 -0.2095729      -0.5441699
## 6   17150000 -0.7215028 -0.5669957  0.2413230 -0.6332710      -0.6001333
##             Category
## 1 Late Appearing TAD
## 2  Highly Common TAD
## 3  Highly Common TAD
## 4  Highly Common TAD
## 5  Highly Common TAD
## 6  Highly Common TAD
```

We also include a stacked barplot that includes the number of times each type of temporal boundary occurs in the data. This plot is created in ggplot2 and fully customizable.

```
time_var$Count_Plot
```

![](data:image/png;base64...)

# 3 ConsensusTAD

## 3.1 Introduction

`ConsensusTADs` function implements an approach for calling TADs across multiple datasets. It uses the median boundary score across \(n\) replicates or cell lines to calculate a consensus of TAD boundaries, that is, consistently detected across replicates. This effectively filters out noisy TAD boundaries that may appear in only one or a few replicates or cell lines.

## 3.2 Running ConsensusTADs

`ConsensusTADs` function takes essentially the same input as the `TimeCompare` function (a list of contact matrices). It provides consensus TAD scores for each region, summarized across each contact matrix of the genome. It also provides a list of regions with significant TAD scores. These regions can be thought of as consensus TAD boundaries. Using these, we can get a single set of TADs summarized across a set of replicates, conditions, or time points. For this example, we use the two replicates from (Rao et al. [2014](#ref-Rao:2014aa)).

We demonstrate how to run `ConsensusTADs` by calling consensus TADs on time-varying contact matrices created by treating a single sample with auxin, which destroys its TAD boundaries, and then tracking their return at four time points (20, 40, 60 and 180 minutes) (Rao et al. [2017](#ref-Rao:2017aa)). The consensus boundary score is intended to provide a summary of TAD boundaries across all time points.

```
# Get the rao contact matrices built into the package
data("time_mats")
# Running MultiCompare
con_tads <- ConsensusTADs(time_mats, resolution = 50000)
```

```
## Converting to n x n matrix
```

```
## Matrix dimensions: 704x704
## Matrix dimensions: 704x704
## Matrix dimensions: 704x704
## Matrix dimensions: 704x704
```

`ConsensusTADs` returns two data frames. The first data frame, `Consensus`, contains all regions containing consensus TADs based on the consensus score.

```
head(con_tads$Consensus)
```

```
##   Coordinate   Sample 1   Sample 2   Sample 3   Sample 4 Consensus_Score
## 1   16900000 -0.6733709 -0.7751516 -0.7653696 15.1272252     -0.71937026
## 2   17350000  3.6406563  2.3436229  3.0253018  0.7840556      2.68446232
## 3   18850000  0.6372268  6.3662244 -0.7876844  6.9255446      3.50172562
## 4   20700000  1.5667926  3.0968633  2.9130479  2.8300136      2.87153075
## 5   22000000 -1.0079676 -0.7982571  0.6007264  3.1909178     -0.09876534
## 6   22050000 -1.0405532 -0.9892242 -0.2675822  4.2737511     -0.62840320
```

The columns correspond to the coordinate of the region with a significant boundary score, the individual boundary score for each region, and the consensus score.

The second data frame, `All_Regions`, is identical to the `Consensus` data frame, but it includes every region of the genome, which occurs in both matrices.

```
head(con_tads$All_Regions)
```

```
##   Coordinate   Sample 1   Sample 2   Sample 3   Sample 4 Consensus_Score
## 1   16900000 -0.6733709 -0.7751516 -0.7653696 15.1272252      -0.7193703
## 2   16950000 -0.6343671 -0.6624276 -0.4107173 -0.6656620      -0.6483973
## 3   17000000 -1.0409280 -0.7618272  0.7910678 -1.0008876      -0.8813574
## 4   17050000 -0.9199917 -0.7123180  0.6712399 -0.8254422      -0.7688801
## 5   17100000 -0.6097913 -0.4785485 -0.6232367 -0.2095729      -0.5441699
## 6   17150000 -0.7215028 -0.5669957  0.2413230 -0.6332710      -0.6001333
```

# 4 Session Info

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
## [1] microbenchmark_1.5.0 TADCompare_1.20.0    SpectralTAD_1.26.0
## [4] dplyr_1.1.4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] gridExtra_2.3               sandwich_3.1-1
##   [3] rlang_1.1.6                 magrittr_2.0.4
##   [5] multcomp_1.4-29             matrixStats_1.5.0
##   [7] compiler_4.5.1              mgcv_1.9-3
##   [9] vctrs_0.6.5                 reshape2_1.4.4
##  [11] stringr_1.5.2               pkgconfig_2.0.3
##  [13] crayon_1.5.3                fastmap_1.2.0
##  [15] backports_1.5.0             magick_2.9.0
##  [17] XVector_0.50.0              labeling_0.4.3
##  [19] rmarkdown_2.30              tinytex_0.57
##  [21] purrr_1.1.0                 xfun_0.53
##  [23] cachem_1.1.0                jsonlite_2.0.0
##  [25] rhdf5filters_1.22.0         DelayedArray_0.36.0
##  [27] Rhdf5lib_1.32.0             BiocParallel_1.44.0
##  [29] broom_1.0.10                parallel_4.5.1
##  [31] cluster_2.1.8.1             R6_2.6.1
##  [33] bslib_0.9.0                 stringi_1.8.7
##  [35] RColorBrewer_1.1-3          car_3.1-3
##  [37] GenomicRanges_1.62.0        jquerylib_0.1.4
##  [39] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [41] bookdown_0.45               SummarizedExperiment_1.40.0
##  [43] knitr_1.50                  zoo_1.8-14
##  [45] IRanges_2.44.0              Matrix_1.7-4
##  [47] splines_4.5.1               tidyselect_1.2.1
##  [49] dichromat_2.0-0.1           abind_1.4-8
##  [51] yaml_2.3.10                 codetools_0.2-20
##  [53] lattice_0.22-7              tibble_3.3.0
##  [55] plyr_1.8.9                  InteractionSet_1.38.0
##  [57] Biobase_2.70.0              withr_3.0.2
##  [59] S7_0.2.0                    evaluate_1.0.5
##  [61] survival_3.8-3              PRIMME_3.2-6
##  [63] pillar_1.11.1               BiocManager_1.30.26
##  [65] ggpubr_0.6.2                MatrixGenerics_1.22.0
##  [67] carData_3.0-5               KernSmooth_2.23-26
##  [69] stats4_4.5.1                generics_0.1.4
##  [71] S4Vectors_0.48.0            ggplot2_4.0.0
##  [73] scales_1.4.0                HiCcompare_1.32.0
##  [75] gtools_3.9.5                glue_1.8.0
##  [77] pheatmap_1.0.13             tools_4.5.1
##  [79] data.table_1.17.8           ggsignif_0.6.4
##  [81] mvtnorm_1.3-3               cowplot_1.2.0
##  [83] rhdf5_2.54.0                grid_4.5.1
##  [85] tidyr_1.3.1                 nlme_3.1-168
##  [87] Formula_1.2-5               cli_3.6.5
##  [89] S4Arrays_1.10.0             gtable_0.3.6
##  [91] rstatix_0.7.3               sass_0.4.10
##  [93] digest_0.6.37               BiocGenerics_0.56.0
##  [95] SparseArray_1.10.0          TH.data_1.1-4
##  [97] farver_2.1.2                htmltools_0.5.8.1
##  [99] lifecycle_1.0.4             MASS_7.3-65
```

# References

Cresswell, Kellen G, John C Stansfield, and Mikhail G Dozmorov. n.d. “SpectralTAD: An R Package for Defining a Hierarchy of Topologically Associated Domains Using Spectral Clustering.” *bioRxiv*, 549170. <https://doi.org/10.1101/549170>.

Rao, Suhas S. P., Su-Chen Huang, Brian Glenn St Hilaire, Jesse M. Engreitz, Elizabeth M. Perez, Kyong-Rim Kieffer-Kwon, Adrian L. Sanborn, et al. 2017. “Cohesin Loss Eliminates All Loop Domains.” *Cell* 171 (2): 305–320.e24. <https://doi.org/10.1016/j.cell.2017.09.026>.

Rao, Suhas S.P., Miriam H. Huntley, Neva C. Durand, Elena K. Stamenova, Ivan D. Bochkov, James T. Robinson, Adrian L. Sanborn, et al. 2014. “A 3D Map of the Human Genome at Kilobase Resolution Reveals Principles of Chromatin Looping.” *Cell* 159 (7): 1665–80. <https://doi.org/10.1016/j.cell.2014.11.021>.

Schmitt, Anthony D, Ming Hu, Inkyung Jung, Zheng Xu, Yunjiang Qiu, Catherine L Tan, Yun Li, et al. 2016. “A Compendium of Chromatin Contact Maps Reveals Spatially Active Regions in the Human Genome.” *Cell Rep* 17 (8): 2042–59. <https://doi.org/10.1016/j.celrep.2016.10.061>.