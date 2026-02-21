# Using BumpyMatrix objects

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: December 15, 2020

#### Package

BumpyMatrix 1.18.0

# 1 Overview

The `BumpyMatrix` class is a two-dimensional object where each entry contains a non-scalar object of constant type/class but variable length.
This can be considered to be raggedness in the third dimension, i.e., “bumpiness”.
The `BumpyMatrix` is intended to represent complex data that has zero-to-many mappings between individual data points and each feature/sample,
allowing us to store it in Bioconductor’s standard 2-dimensional containers such as the `SummarizedExperiment`.
One example could be to store transcript coordinates for highly multiplexed FISH data;
the dimensions of the `BumpyMatrix` can represent genes and cells while each entry is a data frame with the relevant x/y coordinates.

# 2 Construction

A variety of `BumpyMatrix` subclasses are implemented but the most interesting is probably the `BumpyDataFrameMatrix`.
This is an S4 matrix class where each entry is a `DataFrame` object, i.e., Bioconductor’s wrapper around the `data.frame`.
To demonstrate, let’s mock up some data for our hypothetical FISH experiment:

```
library(S4Vectors)
df <- DataFrame(
    x=rnorm(10000), y=rnorm(10000),
    gene=paste0("GENE_", sample(100, 10000, replace=TRUE)),
    cell=paste0("CELL_", sample(20, 10000, replace=TRUE))
)
df
```

```
## DataFrame with 10000 rows and 4 columns
##                x          y        gene        cell
##        <numeric>  <numeric> <character> <character>
## 1       1.262954 -1.2195513     GENE_81      CELL_9
## 2      -0.326233 -1.2014602     GENE_10     CELL_14
## 3       1.329799 -0.4960425     GENE_66      CELL_7
## 4       1.272429  0.0669311      GENE_4     CELL_12
## 5       0.414641 -0.0569491     GENE_74      CELL_5
## ...          ...        ...         ...         ...
## 9996   0.2136543  -0.771187     GENE_82     CELL_20
## 9997   0.7330922  -2.094271     GENE_36      CELL_5
## 9998   0.7570839  -0.328441     GENE_58      CELL_6
## 9999   0.7986270   0.849142     GENE_85      CELL_3
## 10000 -0.0556033   0.279099     GENE_52      CELL_5
```

We then use the `splitAsBumpyMatrix()` utility to easily create our `BumpyDataFrameMatrix` based on the variables on the x- and y-axes.
Here, each row is a gene, each column is a cell, and each entry holds all coordinates for that gene/cell combination.

```
library(BumpyMatrix)
mat <- splitAsBumpyMatrix(df[,c("x", "y")], row=df$gene, column=df$cell)
mat
```

```
## 100 x 20 BumpyDataFrameMatrix
## rownames: GENE_1 GENE_10 ... GENE_98 GENE_99
## colnames: CELL_1 CELL_10 ... CELL_8 CELL_9
## preview [1,1]:
##   DataFrame with 5 rows and 2 columns
##             x          y
##     <numeric>  <numeric>
##   1 -0.456681  1.1802570
##   2  2.260953  0.0664656
##   3  1.589902 -0.5645328
##   4 -0.932046 -0.9511974
##   5  1.073516  0.8238178
```

```
mat[1,1][[1]]
```

```
## DataFrame with 5 rows and 2 columns
##           x          y
##   <numeric>  <numeric>
## 1 -0.456681  1.1802570
## 2  2.260953  0.0664656
## 3  1.589902 -0.5645328
## 4 -0.932046 -0.9511974
## 5  1.073516  0.8238178
```

We can also set `sparse=TRUE` to use a more efficient sparse representation, which avoids explicit storage of empty `DataFrame`s.
This may be necessary for larger datasets as there is a limit of 2147483647 (non-empty) entries in each `BumpyMatrix`.

```
chosen <- df[1:100,]
smat <- splitAsBumpyMatrix(chosen[,c("x", "y")], row=chosen$gene,
    column=chosen$cell, sparse=TRUE)
smat
```

```
## 67 x 20 BumpyDataFrameMatrix
## rownames: GENE_1 GENE_10 ... GENE_97 GENE_99
## colnames: CELL_1 CELL_10 ... CELL_8 CELL_9
## preview [1,1]:
##   DataFrame with 0 rows and 2 columns
```

# 3 Basic operations

The `BumpyMatrix` implements many of the standard matrix operations, e.g., `nrow()`, `dimnames()`, the combining methods and transposition.

```
dim(mat)
```

```
## [1] 100  20
```

```
dimnames(mat)
```

```
## [[1]]
##   [1] "GENE_1"   "GENE_10"  "GENE_100" "GENE_11"  "GENE_12"  "GENE_13"
##   [7] "GENE_14"  "GENE_15"  "GENE_16"  "GENE_17"  "GENE_18"  "GENE_19"
##  [13] "GENE_2"   "GENE_20"  "GENE_21"  "GENE_22"  "GENE_23"  "GENE_24"
##  [19] "GENE_25"  "GENE_26"  "GENE_27"  "GENE_28"  "GENE_29"  "GENE_3"
##  [25] "GENE_30"  "GENE_31"  "GENE_32"  "GENE_33"  "GENE_34"  "GENE_35"
##  [31] "GENE_36"  "GENE_37"  "GENE_38"  "GENE_39"  "GENE_4"   "GENE_40"
##  [37] "GENE_41"  "GENE_42"  "GENE_43"  "GENE_44"  "GENE_45"  "GENE_46"
##  [43] "GENE_47"  "GENE_48"  "GENE_49"  "GENE_5"   "GENE_50"  "GENE_51"
##  [49] "GENE_52"  "GENE_53"  "GENE_54"  "GENE_55"  "GENE_56"  "GENE_57"
##  [55] "GENE_58"  "GENE_59"  "GENE_6"   "GENE_60"  "GENE_61"  "GENE_62"
##  [61] "GENE_63"  "GENE_64"  "GENE_65"  "GENE_66"  "GENE_67"  "GENE_68"
##  [67] "GENE_69"  "GENE_7"   "GENE_70"  "GENE_71"  "GENE_72"  "GENE_73"
##  [73] "GENE_74"  "GENE_75"  "GENE_76"  "GENE_77"  "GENE_78"  "GENE_79"
##  [79] "GENE_8"   "GENE_80"  "GENE_81"  "GENE_82"  "GENE_83"  "GENE_84"
##  [85] "GENE_85"  "GENE_86"  "GENE_87"  "GENE_88"  "GENE_89"  "GENE_9"
##  [91] "GENE_90"  "GENE_91"  "GENE_92"  "GENE_93"  "GENE_94"  "GENE_95"
##  [97] "GENE_96"  "GENE_97"  "GENE_98"  "GENE_99"
##
## [[2]]
##  [1] "CELL_1"  "CELL_10" "CELL_11" "CELL_12" "CELL_13" "CELL_14" "CELL_15"
##  [8] "CELL_16" "CELL_17" "CELL_18" "CELL_19" "CELL_2"  "CELL_20" "CELL_3"
## [15] "CELL_4"  "CELL_5"  "CELL_6"  "CELL_7"  "CELL_8"  "CELL_9"
```

```
rbind(mat, mat)
```

```
## 200 x 20 BumpyDataFrameMatrix
## rownames: GENE_1 GENE_10 ... GENE_98 GENE_99
## colnames: CELL_1 CELL_10 ... CELL_8 CELL_9
## preview [1,1]:
##   DataFrame with 5 rows and 2 columns
##             x          y
##     <numeric>  <numeric>
##   1 -0.456681  1.1802570
##   2  2.260953  0.0664656
##   3  1.589902 -0.5645328
##   4 -0.932046 -0.9511974
##   5  1.073516  0.8238178
```

```
cbind(mat, mat)
```

```
## 100 x 40 BumpyDataFrameMatrix
## rownames: GENE_1 GENE_10 ... GENE_98 GENE_99
## colnames: CELL_1 CELL_10 ... CELL_8 CELL_9
## preview [1,1]:
##   DataFrame with 5 rows and 2 columns
##             x          y
##     <numeric>  <numeric>
##   1 -0.456681  1.1802570
##   2  2.260953  0.0664656
##   3  1.589902 -0.5645328
##   4 -0.932046 -0.9511974
##   5  1.073516  0.8238178
```

```
t(mat)
```

```
## 20 x 100 BumpyDataFrameMatrix
## rownames: CELL_1 CELL_10 ... CELL_8 CELL_9
## colnames: GENE_1 GENE_10 ... GENE_98 GENE_99
## preview [1,1]:
##   DataFrame with 5 rows and 2 columns
##             x          y
##     <numeric>  <numeric>
##   1 -0.456681  1.1802570
##   2  2.260953  0.0664656
##   3  1.589902 -0.5645328
##   4 -0.932046 -0.9511974
##   5  1.073516  0.8238178
```

Subsetting will yield a new `BumpyMatrix` object corresponding to the specified submatrix.
If the returned submatrix has a dimension of length 1 and `drop=TRUE`, the underlying `CompressedList` of values (in this case, the list of `DataFrame`s) is returned.

```
mat[c("GENE_2", "GENE_20"),]
```

```
## 2 x 20 BumpyDataFrameMatrix
## rownames: GENE_2 GENE_20
## colnames: CELL_1 CELL_10 ... CELL_8 CELL_9
## preview [1,1]:
##   DataFrame with 9 rows and 2 columns
##              x          y
##      <numeric>  <numeric>
##   1  0.6006726  2.2264549
##   2  0.5633180 -0.5785644
##   3 -0.9858359  0.5030357
##   4  1.9680003  1.8404334
##   5  0.2817334  0.0957103
##   6 -0.0787825 -1.1799429
##   7 -1.5499071 -0.1132942
##   8  0.3269564  0.2557983
##   9 -0.5103373 -0.3180972
```

```
mat[,1:5]
```

```
## 100 x 5 BumpyDataFrameMatrix
## rownames: GENE_1 GENE_10 ... GENE_98 GENE_99
## colnames: CELL_1 CELL_10 CELL_11 CELL_12 CELL_13
## preview [1,1]:
##   DataFrame with 5 rows and 2 columns
##             x          y
##     <numeric>  <numeric>
##   1 -0.456681  1.1802570
##   2  2.260953  0.0664656
##   3  1.589902 -0.5645328
##   4 -0.932046 -0.9511974
##   5  1.073516  0.8238178
```

```
mat["GENE_10",]
```

```
## SplitDataFrameList of length 20
## $CELL_1
## DataFrame with 6 rows and 2 columns
##            x          y
##    <numeric>  <numeric>
## 1 -0.4437397 -1.1806866
## 2  2.6989263  0.9616407
## 3 -0.7392878  0.5467073
## 4  0.0485278  0.3189288
## 5 -1.6825538  0.7924868
## 6  0.1882398  0.0267774
##
## $CELL_10
## DataFrame with 7 rows and 2 columns
##           x         y
##   <numeric> <numeric>
## 1 -0.294196  0.531934
## 2  0.216737  0.690170
## 3 -0.603301 -1.024468
## 4 -1.198632  0.866599
## 5 -1.160206  1.029362
## 6 -0.996214 -0.731540
## 7 -1.497422 -0.635969
##
## $CELL_11
## DataFrame with 3 rows and 2 columns
##            x          y
##    <numeric>  <numeric>
## 1  1.3397324 -0.8455987
## 2  0.0355647  0.9836901
## 3 -0.9233099  0.0480218
##
## ...
## <17 more elements>
```

For `BumpyDataFrameMatrix` objects, we have an additional third index that allows us to easily extract an individual column of each `DataFrame` into a new `BumpyMatrix`.
In the example below, we extract the x-coordinate into a new `BumpyNumericMatrix`:

```
out.x <- mat[,,"x"]
out.x
```

```
## 100 x 20 BumpyNumericMatrix
## rownames: GENE_1 GENE_10 ... GENE_98 GENE_99
## colnames: CELL_1 CELL_10 ... CELL_8 CELL_9
## preview [1,1]:
##   num [1:5] -0.457 2.261 1.59 -0.932 1.074
```

```
out.x[,1]
```

```
## NumericList of length 100
## [["GENE_1"]] -0.456680962301832 2.26095325993182 ... 1.07351568637374
## [["GENE_10"]] -0.443739703296155 2.69892631656385 ... 0.188239840894589
## [["GENE_100"]] -0.0521083287975451 -0.959848960471883 -1.69849738722303 1.20187171507774
## [["GENE_11"]] 0.170720585504045 -0.632693519163165 0.0474731889735527 0.686758871296805
## [["GENE_12"]] -0.995342637599223 -0.145945860989099 ... -0.75308908554855
## [["GENE_13"]] -0.449876006420393 -0.491325515925785 -0.0800044195125232 1.47031802805851
## [["GENE_14"]] 0.837394397366885 -1.09885654076545 ... 0.0788476240211941
## [["GENE_15"]] -1.30967954169979 -1.07803449338206 ... 1.10399748359464
## [["GENE_16"]] -0.299215117897316 -0.655378696153722 ... 1.04146605380096
## [["GENE_17"]] 0.387769028629511 1.27455066651572 0.0634504926146246 -0.654969069758301
## ...
## <90 more elements>
```

Common arithmetic and logical operations are already implemented for `BumpyNumericMatrix` subclasses.
Almost all of these operations will act on each entry of the input object (or corresponding entries, for multiple inputs)
and produce a new `BumpyMatrix` of the appropriate type.

```
pos <- out.x > 0
pos[,1]
```

```
## LogicalList of length 100
## [["GENE_1"]] FALSE TRUE TRUE FALSE TRUE
## [["GENE_10"]] FALSE TRUE FALSE TRUE FALSE TRUE
## [["GENE_100"]] FALSE FALSE FALSE TRUE
## [["GENE_11"]] TRUE FALSE TRUE TRUE
## [["GENE_12"]] FALSE FALSE FALSE FALSE TRUE FALSE FALSE TRUE TRUE FALSE TRUE FALSE
## [["GENE_13"]] FALSE FALSE FALSE TRUE
## [["GENE_14"]] TRUE FALSE FALSE TRUE FALSE FALSE TRUE
## [["GENE_15"]] FALSE FALSE TRUE TRUE FALSE TRUE
## [["GENE_16"]] FALSE FALSE TRUE FALSE FALSE TRUE
## [["GENE_17"]] TRUE TRUE TRUE FALSE
## ...
## <90 more elements>
```

```
shift <- 10 * out.x + 1
shift[,1]
```

```
## NumericList of length 100
## [["GENE_1"]] -3.56680962301832 23.6095325993182 ... 11.7351568637374
## [["GENE_10"]] -3.43739703296155 27.9892631656385 ... 2.88239840894589
## [["GENE_100"]] 0.478916712024549 -8.59848960471883 -15.9849738722303 13.0187171507774
## [["GENE_11"]] 2.70720585504045 -5.32693519163165 1.47473188973553 7.86758871296805
## [["GENE_12"]] -8.95342637599223 -0.459458609890994 ... -6.5308908554855
## [["GENE_13"]] -3.49876006420393 -3.91325515925785 0.199955804874768 15.7031802805851
## [["GENE_14"]] 9.37394397366885 -9.98856540765453 ... 1.78847624021194
## [["GENE_15"]] -12.0967954169979 -9.78034493382059 ... 12.0399748359464
## [["GENE_16"]] -1.99215117897316 -5.55378696153722 ... 11.4146605380095
## [["GENE_17"]] 4.87769028629511 13.7455066651572 1.63450492614625 -5.54969069758301
## ...
## <90 more elements>
```

```
out.y <- mat[,,"y"]
greater <- out.x < out.y
greater[,1]
```

```
## LogicalList of length 100
## [["GENE_1"]] TRUE FALSE FALSE FALSE FALSE
## [["GENE_10"]] FALSE FALSE TRUE TRUE TRUE FALSE
## [["GENE_100"]] TRUE TRUE TRUE FALSE
## [["GENE_11"]] TRUE TRUE FALSE FALSE
## [["GENE_12"]] TRUE FALSE FALSE TRUE TRUE TRUE TRUE FALSE FALSE FALSE TRUE FALSE
## [["GENE_13"]] TRUE TRUE TRUE FALSE
## [["GENE_14"]] TRUE FALSE TRUE FALSE TRUE TRUE TRUE
## [["GENE_15"]] TRUE TRUE FALSE FALSE FALSE TRUE
## [["GENE_16"]] TRUE TRUE FALSE TRUE FALSE FALSE
## [["GENE_17"]] TRUE FALSE TRUE TRUE
## ...
## <90 more elements>
```

```
diff <- out.y - out.x
diff[,1]
```

```
## NumericList of length 100
## [["GENE_1"]] 1.63693791572228 -2.19448769611817 ... -0.249697865694356
## [["GENE_10"]] -0.736946857599669 -1.73728562932688 ... -0.161462478389356
## [["GENE_100"]] 0.385070842100422 0.830947088787695 1.28842673980641 -0.930637428293555
## [["GENE_11"]] 2.19924827461933 1.2939182751824 -0.73459027884472 -0.974124539123142
## [["GENE_12"]] 0.0112704909161504 -2.10310060588711 ... -0.902168554270107
## [["GENE_13"]] 1.16478634799064 0.186402515479371 0.996944355639376 -0.116586294264194
## [["GENE_14"]] 0.157749191982352 -0.397552739170927 ... 1.36241042737296
## [["GENE_15"]] 2.15036798366318 0.253710634937292 ... 0.39941302358738
## [["GENE_16"]] 0.96817595171046 0.114756919804117 ... -2.01727368917211
## [["GENE_17"]] 1.28069410635393 -2.78487321775219 0.152233191585686 1.9392696521926
## ...
## <90 more elements>
```

# 4 Advanced subsetting

When subsetting a `BumpyMatrix`, we can use another `BumpyMatrix` containing indexing information for each entry.
Consider the following code chunk:

```
i <- mat[,,'x'] > 0 & mat[,,'y'] > 0
i
```

```
## 100 x 20 BumpyLogicalMatrix
## rownames: GENE_1 GENE_10 ... GENE_98 GENE_99
## colnames: CELL_1 CELL_10 ... CELL_8 CELL_9
## preview [1,1]:
##   logi [1:5] FALSE TRUE FALSE FALSE TRUE
```

```
i[,1]
```

```
## LogicalList of length 100
## [["GENE_1"]] FALSE TRUE FALSE FALSE TRUE
## [["GENE_10"]] FALSE TRUE FALSE TRUE FALSE TRUE
## [["GENE_100"]] FALSE FALSE FALSE TRUE
## [["GENE_11"]] TRUE FALSE FALSE FALSE
## [["GENE_12"]] FALSE FALSE FALSE FALSE TRUE FALSE FALSE TRUE TRUE FALSE TRUE FALSE
## [["GENE_13"]] FALSE FALSE FALSE TRUE
## [["GENE_14"]] TRUE FALSE FALSE FALSE FALSE FALSE TRUE
## [["GENE_15"]] FALSE FALSE TRUE FALSE FALSE TRUE
## [["GENE_16"]] FALSE FALSE FALSE FALSE FALSE FALSE
## [["GENE_17"]] TRUE FALSE TRUE FALSE
## ...
## <90 more elements>
```

```
sub <- mat[i]
sub
```

```
## 100 x 20 BumpyDataFrameMatrix
## rownames: GENE_1 GENE_10 ... GENE_98 GENE_99
## colnames: CELL_1 CELL_10 ... CELL_8 CELL_9
## preview [1,1]:
##   DataFrame with 2 rows and 2 columns
##             x         y
##     <numeric> <numeric>
##   1   2.26095 0.0664656
##   2   1.07352 0.8238178
```

```
sub[,1]
```

```
## SplitDataFrameList of length 100
## $GENE_1
## DataFrame with 2 rows and 2 columns
##           x         y
##   <numeric> <numeric>
## 1   2.26095 0.0664656
## 2   1.07352 0.8238178
##
## $GENE_10
## DataFrame with 3 rows and 2 columns
##           x         y
##   <numeric> <numeric>
## 1 2.6989263 0.9616407
## 2 0.0485278 0.3189288
## 3 0.1882398 0.0267774
##
## $GENE_100
## DataFrame with 1 row and 2 columns
##           x         y
##   <numeric> <numeric>
## 1   1.20187  0.271234
##
## ...
## <97 more elements>
```

Here, `i` is a `BumpyLogicalMatrix` where each entry is a logical vector.
When we do `x[i]`, we effectively loop over the corresponding entries of `x` and `i`, using the latter to subset the `DataFrame` in the former.
This produces a new `BumpyDataFrameMatrix` containing, in this case, only the observations with positive x- and y-coordinates.

For `BumpyDataFrameMatrix` objects, subsetting to a single field in the third dimension will automatically drop to the type of the underlying column of the `DataFrame`.
This can be stopped with `drop=FALSE` to preserve the `BumpyDataFrameMatrix` output:

```
mat[,,'x']
```

```
## 100 x 20 BumpyNumericMatrix
## rownames: GENE_1 GENE_10 ... GENE_98 GENE_99
## colnames: CELL_1 CELL_10 ... CELL_8 CELL_9
## preview [1,1]:
##   num [1:5] -0.457 2.261 1.59 -0.932 1.074
```

```
mat[,,'x',drop=FALSE]
```

```
## 100 x 20 BumpyDataFrameMatrix
## rownames: GENE_1 GENE_10 ... GENE_98 GENE_99
## colnames: CELL_1 CELL_10 ... CELL_8 CELL_9
## preview [1,1]:
##   DataFrame with 5 rows and 1 column
##             x
##     <numeric>
##   1 -0.456681
##   2  2.260953
##   3  1.589902
##   4 -0.932046
##   5  1.073516
```

In situations where we want to drop the third dimension but not the first two dimensions (or vice versa), we use the `.dropk` argument.
Setting `.dropk=FALSE` will ensure that the third dimension is not dropped, as shown below:

```
mat[1,1,'x']
```

```
## NumericList of length 1
## [[1]] -0.456680962301832 2.26095325993182 ... 1.07351568637374
```

```
mat[1,1,'x',.dropk=FALSE]
```

```
## SplitDataFrameList of length 1
## [[1]]
## DataFrame with 5 rows and 1 column
##           x
##   <numeric>
## 1 -0.456681
## 2  2.260953
## 3  1.589902
## 4 -0.932046
## 5  1.073516
```

```
mat[1,1,'x',drop=FALSE]
```

```
## 1 x 1 BumpyDataFrameMatrix
## rownames: GENE_1
## colnames: CELL_1
## preview [1,1]:
##   DataFrame with 5 rows and 1 column
##             x
##     <numeric>
##   1 -0.456681
##   2  2.260953
##   3  1.589902
##   4 -0.932046
##   5  1.073516
```

```
mat[1,1,'x',.dropk=TRUE,drop=FALSE]
```

```
## 1 x 1 BumpyNumericMatrix
## rownames: GENE_1
## colnames: CELL_1
## preview [1,1]:
##   num [1:5] -0.457 2.261 1.59 -0.932 1.074
```

Subset replacement is also supported, which is most useful for operations to modify specific fields:

```
copy <- mat
copy[,,'x'] <- copy[,,'x'] * 20
copy[,1]
```

```
## SplitDataFrameList of length 100
## $GENE_1
## DataFrame with 5 rows and 2 columns
##           x          y
##   <numeric>  <numeric>
## 1  -9.13362  1.1802570
## 2  45.21907  0.0664656
## 3  31.79805 -0.5645328
## 4 -18.64092 -0.9511974
## 5  21.47031  0.8238178
##
## $GENE_10
## DataFrame with 6 rows and 2 columns
##            x          y
##    <numeric>  <numeric>
## 1  -8.874794 -1.1806866
## 2  53.978526  0.9616407
## 3 -14.785756  0.5467073
## 4   0.970557  0.3189288
## 5 -33.651075  0.7924868
## 6   3.764797  0.0267774
##
## $GENE_100
## DataFrame with 4 rows and 2 columns
##           x         y
##   <numeric> <numeric>
## 1  -1.04217  0.332963
## 2 -19.19698 -0.128902
## 3 -33.96995 -0.410071
## 4  24.03743  0.271234
##
## ...
## <97 more elements>
```

# 5 Additional operations

Some additional statistical operations are also implemented that will usually produce an ordinary matrix.
Here, each entry corresponds to the statistic computed from the corresponding entry of the `BumpyMatrix`.

```
mean(out.x)[1:5,1:5] # matrix
```

```
##               CELL_1    CELL_10     CELL_11    CELL_12     CELL_13
## GENE_1    0.70712887  0.2128110 -0.40556554 -0.3274332  0.11342557
## GENE_10   0.01168545 -0.7904620  0.15066241 -0.8528919  0.43556752
## GENE_100 -0.37714574 -0.6514196  0.28494400  0.5962598 -0.03492945
## GENE_11   0.06806478  0.3087175 -0.49577063  0.1712767 -0.08399315
## GENE_12  -0.37907379  0.5438429  0.03386324 -0.7309794  0.26734736
```

```
var(out.x)[1:5,1:5] # matrix
```

```
##             CELL_1   CELL_10   CELL_11   CELL_12    CELL_13
## GENE_1   1.8423115 0.2797058 0.5265598 1.4911920 2.25707591
## GENE_10  2.1791223 0.3568664 1.2902758 0.1812921 0.07158465
## GENE_100 1.5614862 0.6738425 2.1982677 0.1351770 0.58199316
## GENE_11  0.2949356 0.2208074 0.5296845 1.3845811 1.79176470
## GENE_12  0.9008503 0.8346523 0.7860442 1.2395604 1.48033310
```

The exception is with operations that naturally produce a vector, in which case a matching 3-dimensional array is returned:

```
quantile(out.x)[1:5,1:5,]
```

```
## , , 0%
##
##              CELL_1    CELL_10    CELL_11     CELL_12    CELL_13
## GENE_1   -0.9320460 -0.4345906 -1.3222878 -1.97005386 -2.9048991
## GENE_10  -1.6825538 -1.4974221 -0.9233099 -1.28504028  0.2463789
## GENE_100 -1.6984974 -1.6887599 -0.8260650  0.09508173 -1.2458351
## GENE_11  -0.6326935 -0.3023776 -1.0103989 -0.95832412 -1.2367482
## GENE_12  -2.5432442 -1.0981897 -0.7845837 -2.77582663 -0.7187626
##
## , , 25%
##
##              CELL_1     CELL_10    CELL_11    CELL_12    CELL_13
## GENE_1   -0.4566810 -0.09455929 -0.9413205 -1.3130549 -0.2176967
## GENE_10  -0.6654008 -1.17941890 -0.4438726 -1.1460665  0.3409732
## GENE_100 -1.1445111 -1.20769109 -0.5568366  0.4201514 -0.3004851
## GENE_11  -0.1225685  0.10848147 -0.7530848 -0.6162069 -1.0592760
## GENE_12  -0.8848881  0.26482573 -0.3850977 -1.5437361 -0.6038440
##
## , , 50%
##
##              CELL_1    CELL_10     CELL_11     CELL_12     CELL_13
## GENE_1    1.0735157  0.2666342 -0.34471488  0.03546206  0.18547368
## GENE_10  -0.1976059 -0.9962139  0.03556469 -0.89716938  0.43556752
## GENE_100 -0.5059786 -0.8892505 -0.28760824  0.56051620 -0.04182030
## GENE_11   0.1090969  0.2021316 -0.49577063 -0.39927829 -0.82739620
## GENE_12  -0.3351033  0.8535404 -0.17140432 -0.46267392 -0.06859857
##
## , , 75%
##
##             CELL_1     CELL_10     CELL_11     CELL_12   CELL_13
## GENE_1   1.5899023  0.57400451  0.01671434  0.66592781 0.4748549
## GENE_10  0.1533118 -0.44874893  0.68764857 -0.60399476 0.5301618
## GENE_100 0.2613867  0.04925645  0.84044849  0.91384869 0.3956748
## GENE_11  0.2997302  0.44607885 -0.23845649  0.94710292 1.0263022
## GENE_12  0.3423434  1.21512396  0.01259719  0.06282157 0.8025928
##
## , , 100%
##
##             CELL_1   CELL_10    CELL_11    CELL_12   CELL_13
## GENE_1   2.2609533 0.7525662 0.58132266  0.8210081 2.6843208
## GENE_10  2.6989263 0.2167373 1.33973245 -0.3321887 0.6247561
## GENE_100 1.2018717 0.5358361 1.96850521  0.9917012 0.9650991
## GENE_11  0.6867589 1.3118250 0.01885764  1.8947475 1.6771525
## GENE_12  0.8858188 1.2499268 1.93803165  0.7024325 1.9253492
```

```
range(out.x)[1:5,1:5,]
```

```
## , , 1
##
##              CELL_1    CELL_10    CELL_11     CELL_12    CELL_13
## GENE_1   -0.9320460 -0.4345906 -1.3222878 -1.97005386 -2.9048991
## GENE_10  -1.6825538 -1.4974221 -0.9233099 -1.28504028  0.2463789
## GENE_100 -1.6984974 -1.6887599 -0.8260650  0.09508173 -1.2458351
## GENE_11  -0.6326935 -0.3023776 -1.0103989 -0.95832412 -1.2367482
## GENE_12  -2.5432442 -1.0981897 -0.7845837 -2.77582663 -0.7187626
##
## , , 2
##
##             CELL_1   CELL_10    CELL_11    CELL_12   CELL_13
## GENE_1   2.2609533 0.7525662 0.58132266  0.8210081 2.6843208
## GENE_10  2.6989263 0.2167373 1.33973245 -0.3321887 0.6247561
## GENE_100 1.2018717 0.5358361 1.96850521  0.9917012 0.9650991
## GENE_11  0.6867589 1.3118250 0.01885764  1.8947475 1.6771525
## GENE_12  0.8858188 1.2499268 1.93803165  0.7024325 1.9253492
```

Other operations may return another `BumpyMatrix` if the output length is variable:

```
pmax(out.x, out.y)
```

```
## 100 x 20 BumpyNumericMatrix
## rownames: GENE_1 GENE_10 ... GENE_98 GENE_99
## colnames: CELL_1 CELL_10 ... CELL_8 CELL_9
## preview [1,1]:
##   num [1:5] 1.18 2.261 1.59 -0.932 1.074
```

`BumpyCharacterMatrix` objects also have their own methods for `grep()`, `tolower()`, etc. to manipulate the strings in a convenient manner.

# Session information

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
## [1] BumpyMatrix_1.18.0  S4Vectors_0.48.0    BiocGenerics_0.56.0
## [4] generics_0.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           jsonlite_2.0.0      htmltools_0.5.8.1
##  [7] sass_0.4.10         rmarkdown_2.30      grid_4.5.1
## [10] evaluate_1.0.5      jquerylib_0.1.4     fastmap_1.2.0
## [13] yaml_2.3.10         IRanges_2.44.0      lifecycle_1.0.4
## [16] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
## [19] lattice_0.22-7      digest_0.6.37       R6_2.6.1
## [22] bslib_0.9.0         Matrix_1.7-4        tools_4.5.1
## [25] cachem_1.1.0
```