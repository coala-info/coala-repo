# Step 1: Pre-Processing

#### Tyler J Burns

#### September 29, 2017

### TL:DR:

You will use GetMarkerNames() to obtain properly named markers as a column in a csv saved to your computer. In this csv, you will make two columns, one for markers you want as input for knn, and one for markers you want to make your scone comparisons on. You will read this back into R to access these markers as vectors of strings. You’ll then run ProcessMultipleFiles() to get your subsampled, concatenated matrix ready for KNN computation.

## ABOUT PRE-PROCESSING

### Introduction:

Fluorescence and mass cytometry data are routinely processed by an increasing array of software platforms. Many of these contain graphical user interfaces, and many of these are R packages. However, no two analyses are the same, and many cases may involve direct processing of files in R. The Sconify package provides a suite of functions to make this process simpler and more user-friendly, prior to the knn-centric analysis occurring downstream. In essence, these functions convert fcs files into data matrices, process these matrices, and can output said matrices into fcs files readable by additional software. Although the primary intent of these functions is to pre-process fcs files for use of k-nearest neighbor statistics and visualizations in the remainder of this package, they are intended also to be general use functions.

### Data:

We will be using the Wanderlust dataset through this series of vignettes. (paper: <https://www.ncbi.nlm.nih.gov/pubmed/24766814>, dataset: <https://www.c2b2.columbia.edu/danapeerlab/html/wanderlust-data.html>). We show a particular donor (labeled Sample C), with B cell precursors at the basal state, and stimulated with IL-7. In the paper, this reveals a small subset of precursors elevating its levels of pSTAT5 in relation to the rest of the cells.

## THE PROCEDURE

### The name of your file:

For general comparisons, your files need to take on the structure “name\_condition.fcs.” If you are comparing multiple donors, then your files need to take on the structure "name\_\_donorID\_condition.fcs."

### Getting the right markers out of your file:

I provide the function GetMarkerNames() to get the names of your parameters out of your data and modify them accordingly. This saves a list of marker names to a csv, as a single named column. Open this up in excel and delete the parameters you don’t want. Then, make two named columns. One contains static markers to be used for KNN (typically surface markers). The second contains the markers to be used in the comparisons. Name these two columns what you like. You’ll read in this csv and get these columns out as a vector of strings.

```
library(Sconify)
# Example fcs file
basal <- system.file('extdata',
    'Bendall_et_al_Cell_Sample_C_basal.fcs',
     package = "Sconify")

# Run this, and check your directory for "markers.csv"
markers <- GetMarkerNames(basal)
markers
```

```
##  [1] "Time"                   "Cell_length"            "CD3(Cd110)Di"
##  [4] "CD3(Cd111)Di"           "CD3(Cd112)Di"           "CD235-61-7-15(In113)Di"
##  [7] "CD3(Cd114)Di"           "CD45(In115)Di"          "cPARP(La139)Di"
## [10] "pPLCg2(Pr141)Di"        "CD19(Nd142)Di"          "CD22(Nd143)Di"
## [13] "pSrc(Nd144)Di"          "IgD(Nd145)Di"           "CD79b(Nd146)Di"
## [16] "CD20(Sm147)Di"          "CD34(Nd148)Di"          "CD179a(Sm149)Di"
## [19] "pSTAT5(Nd150)Di"        "CD72(Eu151)Di"          "Ki67(Sm152)Di"
## [22] "IgM(Eu153)Di"           "Kappa(Sm154)Di"         "pErk12(Gd155)Di"
## [25] "CD10(Gd156)Di"          "Lambda(Gd157)Di"        "pSTAT3(Gd158)Di"
## [28] "pAKT(Tb159)Di"          "pBLNK(Gd160)Di"         "CD24(Dy161)Di"
## [31] "pSyk(Dy162)Di"          "TdT(Dy163)Di"           "Rag1(Dy164)Di"
## [34] "PreBCR(Ho165)Di"        "tIkBa(Er166)Di"         "CD43(Er167)Di"
## [37] "CD38(Er168)Di"          "pP38(Tm169)Di"          "CD40(Er170)Di"
## [40] "pBTK(Yb171)Di"          "pS6(Yb172)Di"           "CD33(Yb173)Di"
## [43] "HLA-DR(Yb174)Di"        "pCrkL(Lu175)Di"         "pCREB(Yb176)Di"
## [46] "DNA1(Ir191)Di"          "DNA2(Ir193)Di"          "Viability1(Pt195)Di"
## [49] "Viability2(Pt196)Di"    "wanderlust"
```

```
# Turn this into two columns, one for surface markers, and one for phosphos
# Label the two columns accoridngly. Save to csv. You'll read this modified
# file in the ProcessMultipleFiles() function.
write.csv(markers, "markers.csv", row.names = FALSE)
```

The markers.csv file, when opened in excel, looks like this (first 20 rows):

```
knitr::include_graphics("original.markers.csv.example.png")
```

![](data:image/png;base64...)

You modify it by hand. In the case of this dataset, it looks like this (first 20 rows):

```
knitr::include_graphics("modified.markers.csv.example.png")
```

![](data:image/png;base64...)

### From fcs file to data matrix (a general function):

Skip to “processing multiple files” section for the function that directly produces the data matrix for SCONE. Here, I provide here a general function that takes a single fcs file as input, performs an asinh transformation with a scale argument of 5 (for CyTOF) if instructed to, and converts the final output into a tibble. For SCONE, you’ll use ProcessMultipleFiles(), which has this function embedded inside it. I provide it as well for any instance where you simply want to read a fcs file into R.

```
# FCS file provided in the package
basal <- system.file('extdata',
    'Bendall_et_al_Cell_Sample_C_basal.fcs',
    package = "Sconify")

# Example of data with no transformation
basal.raw <- FcsToTibble(basal, transform = "none")
basal.raw
```

```
## # A tibble: 1,000 × 50
##     Time Cell_length `CD3(Cd110)Di` `CD3(Cd111)Di` `CD3(Cd112)Di`
##    <dbl>       <dbl>          <dbl>          <dbl>          <dbl>
##  1   635          31         -3.54           1.82          -0.417
##  2  1737          25         -0.639         -0.644         -0.758
##  3  2253          27         -1.64           2.78          -4.20
##  4  3138          31         -0.250         -0.304         11.9
##  5  4330          24          2.23           3.76           4.45
##  6  4645          26         -0.795         -0.476         -1.19
##  7  4760          26         -1.24          -0.648          1.23
##  8  4771          24         -0.109         -3.62          -4.50
##  9  4937          29         -0.302          4.43           2.38
## 10  4968          22         -4.85          -1.52          -2.15
## # ℹ 990 more rows
## # ℹ 45 more variables: `CD235-61-7-15(In113)Di` <dbl>, `CD3(Cd114)Di` <dbl>,
## #   `CD45(In115)Di` <dbl>, `cPARP(La139)Di` <dbl>, `pPLCg2(Pr141)Di` <dbl>,
## #   `CD19(Nd142)Di` <dbl>, `CD22(Nd143)Di` <dbl>, `pSrc(Nd144)Di` <dbl>,
## #   `IgD(Nd145)Di` <dbl>, `CD79b(Nd146)Di` <dbl>, `CD20(Sm147)Di` <dbl>,
## #   `CD34(Nd148)Di` <dbl>, `CD179a(Sm149)Di` <dbl>, `pSTAT5(Nd150)Di` <dbl>,
## #   `CD72(Eu151)Di` <dbl>, `Ki67(Sm152)Di` <dbl>, `IgM(Eu153)Di` <dbl>, …
```

```
# Asinh transformation with a scale argument of 5
basal.asinh <- FcsToTibble(basal, transform = "asinh")
basal.asinh
```

```
## # A tibble: 1,000 × 50
##     Time Cell_length `CD3(Cd110)Di` `CD3(Cd111)Di` `CD3(Cd112)Di`
##    <dbl>       <dbl>          <dbl>          <dbl>          <dbl>
##  1  5.54        2.52        -0.659          0.357         -0.0833
##  2  6.54        2.31        -0.128         -0.128         -0.151
##  3  6.80        2.39        -0.322          0.531         -0.763
##  4  7.14        2.52        -0.0500        -0.0608         1.60
##  5  7.46        2.27         0.432          0.694          0.801
##  6  7.53        2.35        -0.158         -0.0951        -0.235
##  7  7.55        2.35        -0.245         -0.129          0.244
##  8  7.55        2.27        -0.0218        -0.672         -0.809
##  9  7.59        2.46        -0.0603         0.798          0.460
## 10  7.59        2.19        -0.860         -0.300         -0.417
## # ℹ 990 more rows
## # ℹ 45 more variables: `CD235-61-7-15(In113)Di` <dbl>, `CD3(Cd114)Di` <dbl>,
## #   `CD45(In115)Di` <dbl>, `cPARP(La139)Di` <dbl>, `pPLCg2(Pr141)Di` <dbl>,
## #   `CD19(Nd142)Di` <dbl>, `CD22(Nd143)Di` <dbl>, `pSrc(Nd144)Di` <dbl>,
## #   `IgD(Nd145)Di` <dbl>, `CD79b(Nd146)Di` <dbl>, `CD20(Sm147)Di` <dbl>,
## #   `CD34(Nd148)Di` <dbl>, `CD179a(Sm149)Di` <dbl>, `pSTAT5(Nd150)Di` <dbl>,
## #   `CD72(Eu151)Di` <dbl>, `Ki67(Sm152)Di` <dbl>, `IgM(Eu153)Di` <dbl>, …
```

### Processing multiple files:

This is the function that will be used as input for the rest of the SCONE pipeline. If multiple files are used, the data will be conatenated into a single labeled tibble with an additional column containing “condition” information for each cell (which file it came from). If multiple donors as used, an additional column can be added with this information as well (see MultipleDonorScone.Rmd). Per marker, the files can be quantile normalized (across files), or z score transformed. The files are downsampled evenly to the number specified by the user. We recommend 20,000.

```
# The FCS files (THEY NEED TO BE IN THE "....._condidtion.fcs" format")
basal <- system.file('extdata',
    'Bendall_et_al_Cell_Sample_C_basal.fcs',
     package = "Sconify")
il7 <- system.file('extdata',
    'Bendall_et_al_Cell_Sample_C_IL7.fcs',
    package = "Sconify")

# The markers (after they were modified by hand as instructed above)
markers <- system.file('extdata',
    'markers.csv',
    package = "Sconify")
markers <- ParseMarkers(markers)
surface <- markers[[1]]
surface
```

```
##  [1] "CD3(Cd110)Di"           "CD3(Cd111)Di"           "CD3(Cd112)Di"
##  [4] "CD235-61-7-15(In113)Di" "CD3(Cd114)Di"           "CD45(In115)Di"
##  [7] "CD19(Nd142)Di"          "CD22(Nd143)Di"          "IgD(Nd145)Di"
## [10] "CD79b(Nd146)Di"         "CD20(Sm147)Di"          "CD34(Nd148)Di"
## [13] "CD179a(Sm149)Di"        "CD72(Eu151)Di"          "IgM(Eu153)Di"
## [16] "Kappa(Sm154)Di"         "CD10(Gd156)Di"          "Lambda(Gd157)Di"
## [19] "CD24(Dy161)Di"          "TdT(Dy163)Di"           "Rag1(Dy164)Di"
## [22] "PreBCR(Ho165)Di"        "CD43(Er167)Di"          "CD38(Er168)Di"
## [25] "CD40(Er170)Di"          "CD33(Yb173)Di"          "HLA-DR(Yb174)Di"
```

```
# Combining these. Note that default is sub-sampling to 10,000 cells.
# Here, we subsample to 1000 cells to minimize processing time for the vignettes.
# not normalizing, and not scaling.
wand.combined <- ProcessMultipleFiles(files = c(basal, il7),
                                      input = surface,
                                      numcells = 1000)
wand.combined
```

```
## # A tibble: 1,000 × 51
##    `CD3(Cd110)Di` `CD3(Cd111)Di` `CD3(Cd112)Di` `CD235-61-7-15(In113)Di`
##             <dbl>          <dbl>          <dbl>                    <dbl>
##  1        0.785          0.387          -0.380                   -0.207
##  2        0.304         -0.136          -0.260                    0.390
##  3       -0.595          0.364           2.07                     0.661
##  4        0.254         -0.0433         -0.0202                  -0.822
##  5       -0.584         -0.534          -0.657                   -1.25
##  6        0.430         -0.00772        -0.0445                   0.0982
##  7       -0.157          0.342           1.03                     0.402
##  8       -0.158         -0.111          -0.0557                  -0.924
##  9       -0.00743       -0.0606         -0.335                    0.0742
## 10       -0.658         -0.0448          0.580                   -1.21
## # ℹ 990 more rows
## # ℹ 47 more variables: `CD3(Cd114)Di` <dbl>, `CD45(In115)Di` <dbl>,
## #   `CD19(Nd142)Di` <dbl>, `CD22(Nd143)Di` <dbl>, `IgD(Nd145)Di` <dbl>,
## #   `CD79b(Nd146)Di` <dbl>, `CD20(Sm147)Di` <dbl>, `CD34(Nd148)Di` <dbl>,
## #   `CD179a(Sm149)Di` <dbl>, `CD72(Eu151)Di` <dbl>, `IgM(Eu153)Di` <dbl>,
## #   `Kappa(Sm154)Di` <dbl>, `CD10(Gd156)Di` <dbl>, `Lambda(Gd157)Di` <dbl>,
## #   `CD24(Dy161)Di` <dbl>, `TdT(Dy163)Di` <dbl>, `Rag1(Dy164)Di` <dbl>, …
```

```
unique(wand.combined$condition)
```

```
## [1] "basal" "IL7"
```

```
# Limit your matrix to surface markers, if just using those downstream
wand.combined.input <- wand.combined[,surface]
wand.combined.input
```

```
## # A tibble: 1,000 × 27
##    `CD3(Cd110)Di` `CD3(Cd111)Di` `CD3(Cd112)Di` `CD235-61-7-15(In113)Di`
##             <dbl>          <dbl>          <dbl>                    <dbl>
##  1        0.785          0.387          -0.380                   -0.207
##  2        0.304         -0.136          -0.260                    0.390
##  3       -0.595          0.364           2.07                     0.661
##  4        0.254         -0.0433         -0.0202                  -0.822
##  5       -0.584         -0.534          -0.657                   -1.25
##  6        0.430         -0.00772        -0.0445                   0.0982
##  7       -0.157          0.342           1.03                     0.402
##  8       -0.158         -0.111          -0.0557                  -0.924
##  9       -0.00743       -0.0606         -0.335                    0.0742
## 10       -0.658         -0.0448          0.580                   -1.21
## # ℹ 990 more rows
## # ℹ 23 more variables: `CD3(Cd114)Di` <dbl>, `CD45(In115)Di` <dbl>,
## #   `CD19(Nd142)Di` <dbl>, `CD22(Nd143)Di` <dbl>, `IgD(Nd145)Di` <dbl>,
## #   `CD79b(Nd146)Di` <dbl>, `CD20(Sm147)Di` <dbl>, `CD34(Nd148)Di` <dbl>,
## #   `CD179a(Sm149)Di` <dbl>, `CD72(Eu151)Di` <dbl>, `IgM(Eu153)Di` <dbl>,
## #   `Kappa(Sm154)Di` <dbl>, `CD10(Gd156)Di` <dbl>, `Lambda(Gd157)Di` <dbl>,
## #   `CD24(Dy161)Di` <dbl>, `TdT(Dy163)Di` <dbl>, `Rag1(Dy164)Di` <dbl>, …
```

```
# We can do this on a single file as well.
wand.basal <- ProcessMultipleFiles(files = basal,
                                   numcells = 1000,
                                   scale = TRUE,
                                   input = surface)
wand.basal
```

```
## # A tibble: 1,000 × 51
##    `CD3(Cd110)Di` `CD3(Cd111)Di` `CD3(Cd112)Di` `CD235-61-7-15(In113)Di`
##             <dbl>          <dbl>          <dbl>                    <dbl>
##  1      -1.14             0.650          -0.133                   0.155
##  2       0.0690          -0.144          -0.216                  -0.278
##  3      -0.374            0.935          -0.967                   0.923
##  4       0.246           -0.0332          1.93                    0.607
##  5       1.35             1.20            0.952                  -0.0163
##  6      -0.000929        -0.0893         -0.319                   0.0802
##  7      -0.198           -0.145           0.269                   0.712
##  8       0.310           -1.03           -1.02                    1.27
##  9       0.222            1.37            0.533                  -0.885
## 10      -1.60            -0.425          -0.543                   0.281
## # ℹ 990 more rows
## # ℹ 47 more variables: `CD3(Cd114)Di` <dbl>, `CD45(In115)Di` <dbl>,
## #   `CD19(Nd142)Di` <dbl>, `CD22(Nd143)Di` <dbl>, `IgD(Nd145)Di` <dbl>,
## #   `CD79b(Nd146)Di` <dbl>, `CD20(Sm147)Di` <dbl>, `CD34(Nd148)Di` <dbl>,
## #   `CD179a(Sm149)Di` <dbl>, `CD72(Eu151)Di` <dbl>, `IgM(Eu153)Di` <dbl>,
## #   `Kappa(Sm154)Di` <dbl>, `CD10(Gd156)Di` <dbl>, `Lambda(Gd157)Di` <dbl>,
## #   `CD24(Dy161)Di` <dbl>, `TdT(Dy163)Di` <dbl>, `Rag1(Dy164)Di` <dbl>, …
```

```
unique(wand.basal$condition)
```

```
## [1] "basal"
```

### (Optional) a control condition using a split single file:

For the type of condition versus basal analysis shown above, it may behoove the user to have a control containing two basal files being compared to each other (eg. with phospho-protein shifts across clusters). To this end, I developed a function called splitFile() that takes in a single file as input and splits it into two sub-matricies such that one group of cells can be the “treated” condition.

```
# Using the aforementioned basal fcs file
markers <- system.file('extdata',
    'markers.csv',
    package = "Sconify")

# The markers
markers <- read.csv(markers, stringsAsFactors = FALSE)
surface <- markers$surface

# The function
split.data <- SplitFile(file = basal,
                        input.markers = surface,
                        numcells = 1000)
split.data
```

```
## # A tibble: 1,000 × 51
##    `CD3(Cd110)Di` `CD3(Cd111)Di` `CD3(Cd112)Di` `CD235-61-7-15(In113)Di`
##             <dbl>          <dbl>          <dbl>                    <dbl>
##  1       -0.224           -0.501        -0.133                    -0.477
##  2       -0.0457          -0.215        -0.663                    -1.23
##  3       -0.00686          0.151         1.79                     -0.986
##  4        0.256            0.316         0.0922                   -0.395
##  5        0.0625          -0.182        -0.448                    -0.238
##  6       -0.132            0.408         0.925                    -0.124
##  7        0.0685          -0.238        -0.170                    -0.189
##  8       -1.51            -1.66         -1.92                     -2.36
##  9       -0.228           -0.581        -0.237                     0.150
## 10       -0.0771          -0.235        -0.438                    -3.28
## # ℹ 990 more rows
## # ℹ 47 more variables: `CD3(Cd114)Di` <dbl>, `CD45(In115)Di` <dbl>,
## #   `CD19(Nd142)Di` <dbl>, `CD22(Nd143)Di` <dbl>, `IgD(Nd145)Di` <dbl>,
## #   `CD79b(Nd146)Di` <dbl>, `CD20(Sm147)Di` <dbl>, `CD34(Nd148)Di` <dbl>,
## #   `CD179a(Sm149)Di` <dbl>, `CD72(Eu151)Di` <dbl>, `IgM(Eu153)Di` <dbl>,
## #   `Kappa(Sm154)Di` <dbl>, `CD10(Gd156)Di` <dbl>, `Lambda(Gd157)Di` <dbl>,
## #   `CD24(Dy161)Di` <dbl>, `TdT(Dy163)Di` <dbl>, `Rag1(Dy164)Di` <dbl>, …
```

```
unique(split.data$condition)
```

```
## [1] "Split.1" "Split.2"
```