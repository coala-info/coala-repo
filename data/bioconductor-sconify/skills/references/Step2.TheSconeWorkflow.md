# Step 2: The Scone Workflow

#### Tyler J Burns

#### 9/30/2017

### K-nearest neighbors:

We read in input.scone.csv, which is our file modified (and renamed) from the get.marker.names() function. The K-nearest neighbor generation is derived from the Fast Nearest Neighbors (FNN) R package, within our function Fnn(), which takes as input the “input markers” to be used, along with the concatenated data previously generated, and the desired k. We advise the default selection to the total number of cells in the dataset divided by 100, as has been optimized on existing mass cytometry datasets. The output of this function is a matrix of each cell and the identity of its k-nearest neighbors, in terms of its row number in the dataset used here as input.

```
library(Sconify)
# Markers from the user-generated excel file
marker.file <- system.file('extdata', 'markers.csv', package = "Sconify")
markers <- ParseMarkers(marker.file)

# How to convert your excel sheet into vector of static and functional markers
markers
```

```
## $input
##  [1] "CD3(Cd110)Di"           "CD3(Cd111)Di"           "CD3(Cd112)Di"
##  [4] "CD235-61-7-15(In113)Di" "CD3(Cd114)Di"           "CD45(In115)Di"
##  [7] "CD19(Nd142)Di"          "CD22(Nd143)Di"          "IgD(Nd145)Di"
## [10] "CD79b(Nd146)Di"         "CD20(Sm147)Di"          "CD34(Nd148)Di"
## [13] "CD179a(Sm149)Di"        "CD72(Eu151)Di"          "IgM(Eu153)Di"
## [16] "Kappa(Sm154)Di"         "CD10(Gd156)Di"          "Lambda(Gd157)Di"
## [19] "CD24(Dy161)Di"          "TdT(Dy163)Di"           "Rag1(Dy164)Di"
## [22] "PreBCR(Ho165)Di"        "CD43(Er167)Di"          "CD38(Er168)Di"
## [25] "CD40(Er170)Di"          "CD33(Yb173)Di"          "HLA-DR(Yb174)Di"
##
## $functional
##  [1] "pCrkL(Lu175)Di"  "pCREB(Yb176)Di"  "pBTK(Yb171)Di"   "pS6(Yb172)Di"
##  [5] "cPARP(La139)Di"  "pPLCg2(Pr141)Di" "pSrc(Nd144)Di"   "Ki67(Sm152)Di"
##  [9] "pErk12(Gd155)Di" "pSTAT3(Gd158)Di" "pAKT(Tb159)Di"   "pBLNK(Gd160)Di"
## [13] "pP38(Tm169)Di"   "pSTAT5(Nd150)Di" "pSyk(Dy162)Di"   "tIkBa(Er166)Di"
```

```
# Get the particular markers to be used as knn and knn statistics input
input.markers <- markers[[1]]
funct.markers <- markers[[2]]

# Selection of the k. See "Finding Ideal K" vignette
k <- 30

# The built-in scone functions
wand.nn <- Fnn(cell.df = wand.combined, input.markers = input.markers, k = k)
# Cell identity is in rows, k-nearest neighbors are columns
# List of 2 includes the cell identity of each nn,
#   and the euclidean distance between
#   itself and the cell of interest

# Indices
str(wand.nn[[1]])
```

```
##  int [1:1000, 1:30] 794 90 881 600 730 450 860 295 633 699 ...
```

```
wand.nn[[1]][1:20, 1:10]
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
##  [1,]  794  138  207  187  352  446  852  735  602   272
##  [2,]   90  889  561  944  995  799  729  863  575    25
##  [3,]  881  169  318  718  658  667  834  145  571   505
##  [4,]  600   35  612  942  826  282  987  738  210   106
##  [5,]  730  455   14  266  244  658  688  667  809   976
##  [6,]  450  684  865  704  336  176  547   52  348   716
##  [7,]  860  509  542  208  111  667  688  521  815   611
##  [8,]  295  760  549  479  252  241  962  342  769   970
##  [9,]  633  214   36  811  573  310  462  693  514   498
## [10,]  699   39  103  690  519  639  447  207  290   962
## [11,]  655  931  845  992  605   86  337  908  482   402
## [12,]  339  278  855  960  504  643  531  836  184   956
## [13,]  615   42   76  714   19  656  836  869  735   988
## [14,]  738  540  658  771  904  166  801  111  452   667
## [15,]  866  607  449  956  230  669  982  126  685   339
## [16,]  519  568  428  533  291  958  403  334  896   872
## [17,]  747  671  945  445  614  686  630  395  753   761
## [18,]   87  930  647   22  917  176  322  488  376   341
## [19,]  405  445   13  630   76  751  869   42  747   524
## [20,]  667  688  244  658  282  738  809  627  730   477
```

```
# Distance
str(wand.nn[[2]])
```

```
##  num [1:1000, 1:30] 2.88 2.21 4.54 3.32 4.53 ...
```

```
wand.nn[[2]][1:20, 1:10]
```

```
##           [,1]     [,2]     [,3]     [,4]     [,5]     [,6]     [,7]     [,8]
##  [1,] 2.876851 3.230275 3.231254 3.292981 3.407014 3.443274 3.570165 3.579812
##  [2,] 2.213633 2.370185 2.693816 2.841634 2.859277 2.904089 3.081602 3.096632
##  [3,] 4.535107 4.933615 5.067362 5.081027 5.141806 5.161890 5.243734 5.307418
##  [4,] 3.321649 3.452362 3.490052 3.572306 3.637633 3.660755 3.673769 3.731091
##  [5,] 4.534855 4.652209 4.700434 4.787138 4.799307 4.936175 5.022785 5.035981
##  [6,] 3.037649 3.369404 3.487481 3.589727 3.601190 3.619865 3.663499 3.716100
##  [7,] 3.754009 3.952653 4.491266 4.506636 4.685829 4.791210 4.811563 4.898619
##  [8,] 4.514579 4.732992 5.055575 5.144416 5.153642 5.163699 5.177355 5.194464
##  [9,] 4.300989 4.333011 4.343596 4.371364 4.436539 4.453613 4.487755 4.570057
## [10,] 3.025722 3.261289 3.356304 3.627670 3.671106 3.720092 3.740435 3.763745
## [11,] 4.249507 4.817943 4.975306 4.983098 5.097261 5.131622 5.333571 5.372617
## [12,] 3.135347 3.395116 3.412474 3.549475 3.585570 3.589862 3.591775 3.617930
## [13,] 2.567725 2.575365 2.696979 2.769046 2.798915 2.862286 2.873548 2.874440
## [14,] 3.327672 3.496007 3.600312 3.662678 3.692267 3.793516 3.938747 4.016861
## [15,] 2.847317 3.189816 3.193380 3.297860 3.443673 3.487595 3.580327 3.771578
## [16,] 3.781681 4.238408 4.372341 4.621226 4.739013 4.741922 4.761297 4.765291
## [17,] 2.490997 2.728539 2.761806 2.800912 2.821396 2.887494 2.940268 2.948158
## [18,] 3.977072 4.141066 4.246897 4.313911 4.317570 4.338693 4.347362 4.368750
## [19,] 2.545865 2.705539 2.798915 2.900180 2.995501 3.009345 3.019087 3.040590
## [20,] 4.067747 4.321824 4.555948 4.646032 4.718562 4.823128 4.858189 4.917033
##           [,9]    [,10]
##  [1,] 3.584089 3.588584
##  [2,] 3.179710 3.205984
##  [3,] 5.322587 5.352871
##  [4,] 3.827220 3.932257
##  [5,] 5.090182 5.159841
##  [6,] 3.754625 3.760595
##  [7,] 4.910816 4.912577
##  [8,] 5.207046 5.233239
##  [9,] 4.575667 4.619212
## [10,] 3.778993 3.843476
## [11,] 5.379952 5.408303
## [12,] 3.633145 3.640325
## [13,] 2.885491 2.892904
## [14,] 4.042424 4.064575
## [15,] 3.773533 3.783298
## [16,] 4.803227 4.864673
## [17,] 2.988546 2.988839
## [18,] 4.388408 4.389687
## [19,] 3.058576 3.079463
## [20,] 4.950909 4.953250
```

### Finding scone values:

This function iterates through each KNN, and performs a series of calculations. The first is fold change values for each maker per KNN, where the user chooses whether this will be based on medians or means. The second is a statistical test, where the user chooses t test or Mann-Whitney U test. I prefer the latter, because it does not assume any properties of the distributions. Of note, the p values are adjusted for false discovery rate, and therefore are called q values in the output of this function. The user also inputs a threshold parameter (default 0.05), where the fold change values will only be shown if the corresponding statistical test returns a q value below said threshold. Finally, the “multiple.donor.compare” option, if set to TRUE will perform a t test based on the mean per-marker values of each donor. This is to allow the user to make comparisons across replicates or multiple donors if that is relevant to the user’s biological questions. This function returns a matrix of cells by computed values (change and statistical test results, labeled either marker.change or marker.qvalue). This matrix is intermediate, as it gets concatenated with the original input matrix in the post-processing step (see the relevant vignette). We show the code and the output below. See the post-processing vignette, where we show how this gets combined with the input data, and additional analysis is performed.

```
wand.scone <- SconeValues(nn.matrix = wand.nn,
                      cell.data = wand.combined,
                      scone.markers = funct.markers,
                      unstim = "basal")

wand.scone
```

```
## # A tibble: 1,000 × 34
##    `pCrkL(Lu175)Di.IL7.qvalue` pCREB(Yb176)Di.IL7.qvalu…¹ pBTK(Yb171)Di.IL7.qv…²
##                          <dbl>                      <dbl>                  <dbl>
##  1                       0.431                      1                      0.790
##  2                       0.685                      1                      0.698
##  3                       0.924                      0.993                  0.841
##  4                       0.532                      1                      0.790
##  5                       0.851                      0.930                  0.981
##  6                       0.666                      1                      0.866
##  7                       0.685                      0.967                  0.790
##  8                       0.765                      0.930                  0.979
##  9                       0.789                      0.930                  0.915
## 10                       0.448                      0.967                  0.829
## # ℹ 990 more rows
## # ℹ abbreviated names: ¹​`pCREB(Yb176)Di.IL7.qvalue`,
## #   ²​`pBTK(Yb171)Di.IL7.qvalue`
## # ℹ 31 more variables: `pS6(Yb172)Di.IL7.qvalue` <dbl>,
## #   `cPARP(La139)Di.IL7.qvalue` <dbl>, `pPLCg2(Pr141)Di.IL7.qvalue` <dbl>,
## #   `pSrc(Nd144)Di.IL7.qvalue` <dbl>, `Ki67(Sm152)Di.IL7.qvalue` <dbl>,
## #   `pErk12(Gd155)Di.IL7.qvalue` <dbl>, `pSTAT3(Gd158)Di.IL7.qvalue` <dbl>, …
```

### For programmers: performing additional per-KNN statistics

If one wants to export KNN data to perform other statistics not available in this package, then I provide a function that produces a list of each cell identity in the original input data matrix, and a matrix of all cells x features of its KNN.

I also provide a function to find the KNN density estimation independently of the rest of the “scone.values” analysis, to save time if density is all the user wants. With this density estimation, one can perform interesting analysis, ranging from understanding phenotypic density changes along a developmental progression (see post-processing vignette for an example), to trying out density-based binning methods (eg. X-shift). Of note, this density is specifically one divided by the aveage distance to k-nearest neighbors. This specific measure is related to the Shannon Entropy estimate of that point on the manifold (<https://hal.archives-ouvertes.fr/hal-01068081/document>).

I use this metric to avoid the unusual properties of the volume of a sphere as it increases in dimensions (<https://en.wikipedia.org/wiki/Volume_of_an_n-ball>). This being said, one can modify this vector to be such a density estimation (example <http://www.cs.haifa.ac.il/~rita/ml_course/lectures_old/KNN.pdf>), by treating the distance to knn as the radius of a n-dimensional sphere and incoroprating said volume accordingly.

An individual with basic programming skills can iterate through these elements to perform the statistics of one’s choosing. Examples would include per-KNN regression and classification, or feature imputation. The additional functionality is shown below, with the example knn.list in the package being the first ten instances:

```
# Constructs KNN list, computes KNN density estimation
wand.knn.list <- MakeKnnList(cell.data = wand.combined, nn.matrix = wand.nn)
wand.knn.list[[8]]
```

```
## # A tibble: 30 × 51
##    `CD3(Cd110)Di` `CD3(Cd111)Di` `CD3(Cd112)Di` `CD235-61-7-15(In113)Di`
##             <dbl>          <dbl>          <dbl>                    <dbl>
##  1        0.0745         -0.523         -0.316                    0.207
##  2       -0.226           0.115         -0.957                    0.138
##  3       -0.194          -0.374         -0.562                   -0.702
##  4       -0.348          -0.638         -0.770                    0.363
##  5       -0.0893         -0.0653        -0.0490                  -0.135
##  6       -0.223          -0.865         -1.16                    -1.42
##  7       -0.199          -0.0196         0.0463                  -1.03
##  8       -0.0210         -0.0601         0.432                   -0.906
##  9        0.00845        -0.103          0.128                    0.0507
## 10       -0.137          -0.696          0.523                    0.598
## # ℹ 20 more rows
## # ℹ 47 more variables: `CD3(Cd114)Di` <dbl>, `CD45(In115)Di` <dbl>,
## #   `CD19(Nd142)Di` <dbl>, `CD22(Nd143)Di` <dbl>, `IgD(Nd145)Di` <dbl>,
## #   `CD79b(Nd146)Di` <dbl>, `CD20(Sm147)Di` <dbl>, `CD34(Nd148)Di` <dbl>,
## #   `CD179a(Sm149)Di` <dbl>, `CD72(Eu151)Di` <dbl>, `IgM(Eu153)Di` <dbl>,
## #   `Kappa(Sm154)Di` <dbl>, `CD10(Gd156)Di` <dbl>, `Lambda(Gd157)Di` <dbl>,
## #   `CD24(Dy161)Di` <dbl>, `TdT(Dy163)Di` <dbl>, `Rag1(Dy164)Di` <dbl>, …
```

```
# Finds the KNN density estimation for each cell, ordered by column, in the
# original data matrix
wand.knn.density <- GetKnnDe(nn.matrix = wand.nn)
str(wand.knn.density)
```

```
##  num [1:1000] 0.276 0.307 0.177 0.248 0.189 ...
```