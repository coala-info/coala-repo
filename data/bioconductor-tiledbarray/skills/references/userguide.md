# A DelayedArray backend for TileDB

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: June 12, 2020

#### Package

TileDBArray 1.20.0

# 1 Introduction

TileDB implements a framework for local and remote storage of dense and sparse arrays.
We can use this as a `DelayedArray` backend to provide an array-level abstraction,
thus allowing the data to be used in many places where an ordinary array or matrix might be used.
The *[TileDBArray](https://bioconductor.org/packages/3.22/TileDBArray)* package implements the necessary wrappers around *[TileDB-R](https://github.com/TileDB-Inc/TileDB-R)*
to support read/write operations on TileDB arrays within the *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* framework.

# 2 Creating a `TileDBArray`

Creating a `TileDBArray` is as easy as:

```
X <- matrix(rnorm(1000), ncol=10)
library(TileDBArray)
writeTileDBArray(X)
```

```
## <100 x 10> TileDBMatrix object of type "double":
##               [,1]        [,2]        [,3] ...        [,9]       [,10]
##   [1,]  0.69696004  0.82452064 -1.59649863   .  -0.8801170   0.6731977
##   [2,]  0.69663805 -0.96295184  1.19970189   .   0.3023446   0.8459826
##   [3,] -0.30507738  0.03236815  0.56973898   .   0.6161931  -0.9380608
##   [4,]  1.31001295  1.57714373  0.24627629   .  -0.6457544  -0.4256555
##   [5,]  0.40839813  1.42200923  0.77016385   .   0.3731292  -0.8194557
##    ...           .           .           .   .           .           .
##  [96,]  1.98139405  1.45217632 -0.68100387   . -1.50512796 -0.45956407
##  [97,] -0.18079793  1.79236699 -0.20642487   . -2.16800667  0.56151528
##  [98,]  0.09844591  0.64840087 -1.00219450   .  1.95190638 -0.32603428
##  [99,] -0.73802041 -0.56371564  0.94473932   . -0.09722988  1.62119787
## [100,]  0.07380201  0.62833111 -2.54091311   . -1.42748327 -0.12833338
```

Alternatively, we can use coercion methods:

```
as(X, "TileDBArray")
```

```
## <100 x 10> TileDBMatrix object of type "double":
##               [,1]        [,2]        [,3] ...        [,9]       [,10]
##   [1,]  0.69696004  0.82452064 -1.59649863   .  -0.8801170   0.6731977
##   [2,]  0.69663805 -0.96295184  1.19970189   .   0.3023446   0.8459826
##   [3,] -0.30507738  0.03236815  0.56973898   .   0.6161931  -0.9380608
##   [4,]  1.31001295  1.57714373  0.24627629   .  -0.6457544  -0.4256555
##   [5,]  0.40839813  1.42200923  0.77016385   .   0.3731292  -0.8194557
##    ...           .           .           .   .           .           .
##  [96,]  1.98139405  1.45217632 -0.68100387   . -1.50512796 -0.45956407
##  [97,] -0.18079793  1.79236699 -0.20642487   . -2.16800667  0.56151528
##  [98,]  0.09844591  0.64840087 -1.00219450   .  1.95190638 -0.32603428
##  [99,] -0.73802041 -0.56371564  0.94473932   . -0.09722988  1.62119787
## [100,]  0.07380201  0.62833111 -2.54091311   . -1.42748327 -0.12833338
```

This process works also for sparse matrices:

```
Y <- Matrix::rsparsematrix(1000, 1000, density=0.01)
writeTileDBArray(Y)
```

```
## <1000 x 1000> sparse TileDBMatrix object of type "double":
##            [,1]    [,2]    [,3] ...  [,999] [,1000]
##    [1,]       0       0       0   .       0       0
##    [2,]       0       0       0   .       0       0
##    [3,]       0       0       0   .       0       0
##    [4,]       0       0       0   .       0       0
##    [5,]       0       0       0   .       0       0
##     ...       .       .       .   .       .       .
##  [996,]       0       0       0   .       0       0
##  [997,]       0       0       0   .       0       0
##  [998,]       0       0       0   .       0       0
##  [999,]       0       0       0   .       0       0
## [1000,]       0       0       0   .       0       0
```

Logical and integer matrices are supported:

```
writeTileDBArray(Y > 0)
```

```
## <1000 x 1000> sparse TileDBMatrix object of type "logical":
##            [,1]    [,2]    [,3] ...  [,999] [,1000]
##    [1,]   FALSE   FALSE   FALSE   .   FALSE   FALSE
##    [2,]   FALSE   FALSE   FALSE   .   FALSE   FALSE
##    [3,]   FALSE   FALSE   FALSE   .   FALSE   FALSE
##    [4,]   FALSE   FALSE   FALSE   .   FALSE   FALSE
##    [5,]   FALSE   FALSE   FALSE   .   FALSE   FALSE
##     ...       .       .       .   .       .       .
##  [996,]   FALSE   FALSE   FALSE   .   FALSE   FALSE
##  [997,]   FALSE   FALSE   FALSE   .   FALSE   FALSE
##  [998,]   FALSE   FALSE   FALSE   .   FALSE   FALSE
##  [999,]   FALSE   FALSE   FALSE   .   FALSE   FALSE
## [1000,]   FALSE   FALSE   FALSE   .   FALSE   FALSE
```

As are matrices with dimension names:

```
rownames(X) <- sprintf("GENE_%i", seq_len(nrow(X)))
colnames(X) <- sprintf("SAMP_%i", seq_len(ncol(X)))
writeTileDBArray(X)
```

```
## <100 x 10> TileDBMatrix object of type "double":
##               SAMP_1      SAMP_2      SAMP_3 ...      SAMP_9     SAMP_10
##   GENE_1  0.69696004  0.82452064 -1.59649863   .  -0.8801170   0.6731977
##   GENE_2  0.69663805 -0.96295184  1.19970189   .   0.3023446   0.8459826
##   GENE_3 -0.30507738  0.03236815  0.56973898   .   0.6161931  -0.9380608
##   GENE_4  1.31001295  1.57714373  0.24627629   .  -0.6457544  -0.4256555
##   GENE_5  0.40839813  1.42200923  0.77016385   .   0.3731292  -0.8194557
##      ...           .           .           .   .           .           .
##  GENE_96  1.98139405  1.45217632 -0.68100387   . -1.50512796 -0.45956407
##  GENE_97 -0.18079793  1.79236699 -0.20642487   . -2.16800667  0.56151528
##  GENE_98  0.09844591  0.64840087 -1.00219450   .  1.95190638 -0.32603428
##  GENE_99 -0.73802041 -0.56371564  0.94473932   . -0.09722988  1.62119787
## GENE_100  0.07380201  0.62833111 -2.54091311   . -1.42748327 -0.12833338
```

# 3 Manipulating `TileDBArray`s

`TileDBArray`s are simply `DelayedArray` objects and can be manipulated as such.
The usual conventions for extracting data from matrix-like objects work as expected:

```
out <- as(X, "TileDBArray")
dim(out)
```

```
## [1] 100  10
```

```
head(rownames(out))
```

```
## [1] "GENE_1" "GENE_2" "GENE_3" "GENE_4" "GENE_5" "GENE_6"
```

```
head(out[,1])
```

```
##     GENE_1     GENE_2     GENE_3     GENE_4     GENE_5     GENE_6
##  0.6969600  0.6966380 -0.3050774  1.3100130  0.4083981 -0.6238847
```

We can also perform manipulations like subsetting and arithmetic.
Note that these operations do not affect the data in the TileDB backend;
rather, they are delayed until the values are explicitly required,
hence the creation of the `DelayedMatrix` object.

```
out[1:5,1:5]
```

```
## <5 x 5> DelayedMatrix object of type "double":
##             SAMP_1      SAMP_2      SAMP_3      SAMP_4      SAMP_5
## GENE_1  0.69696004  0.82452064 -1.59649863 -1.35100694  1.13702135
## GENE_2  0.69663805 -0.96295184  1.19970189  0.43745801  0.15303385
## GENE_3 -0.30507738  0.03236815  0.56973898  0.16450280 -0.67070454
## GENE_4  1.31001295  1.57714373  0.24627629  0.95481818  0.62813508
## GENE_5  0.40839813  1.42200923  0.77016385  0.90292542  0.34909169
```

```
out * 2
```

```
## <100 x 10> DelayedMatrix object of type "double":
##               SAMP_1      SAMP_2      SAMP_3 ...     SAMP_9    SAMP_10
##   GENE_1  1.39392009  1.64904129 -3.19299727   . -1.7602341  1.3463953
##   GENE_2  1.39327610 -1.92590369  2.39940377   .  0.6046893  1.6919653
##   GENE_3 -0.61015475  0.06473631  1.13947797   .  1.2323862 -1.8761217
##   GENE_4  2.62002591  3.15428746  0.49255257   . -1.2915088 -0.8513110
##   GENE_5  0.81679626  2.84401845  1.54032769   .  0.7462584 -1.6389113
##      ...           .           .           .   .          .          .
##  GENE_96   3.9627881   2.9043526  -1.3620077   . -3.0102559 -0.9191281
##  GENE_97  -0.3615959   3.5847340  -0.4128497   . -4.3360133  1.1230306
##  GENE_98   0.1968918   1.2968017  -2.0043890   .  3.9038128 -0.6520686
##  GENE_99  -1.4760408  -1.1274313   1.8894786   . -0.1944598  3.2423957
## GENE_100   0.1476040   1.2566622  -5.0818262   . -2.8549665 -0.2566668
```

We can also do more complex matrix operations that are supported by *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*:

```
colSums(out)
```

```
##     SAMP_1     SAMP_2     SAMP_3     SAMP_4     SAMP_5     SAMP_6     SAMP_7
##  21.859484  15.382389  -9.057970  12.225983 -17.070408   9.659608  -2.279628
##     SAMP_8     SAMP_9    SAMP_10
##   2.615597 -11.470525  -3.217286
```

```
out %*% runif(ncol(out))
```

```
##                  [,1]
## GENE_1    1.406227869
## GENE_2   -0.698285087
## GENE_3   -1.240903729
## GENE_4    0.922099962
## GENE_5   -1.888638811
## GENE_6   -1.987763000
## GENE_7   -2.419675677
## GENE_8   -0.283049721
## GENE_9   -1.206452980
## GENE_10   1.267547819
## GENE_11   0.131848133
## GENE_12   0.823359256
## GENE_13   1.656596176
## GENE_14   0.089361056
## GENE_15  -3.312216017
## GENE_16   1.649031772
## GENE_17  -0.483136862
## GENE_18   2.484790628
## GENE_19   0.057334131
## GENE_20  -1.340372027
## GENE_21  -1.599022034
## GENE_22  -0.061309830
## GENE_23  -1.458015590
## GENE_24  -2.040268391
## GENE_25   0.149503197
## GENE_26  -1.429991140
## GENE_27   1.302223777
## GENE_28   0.135590887
## GENE_29  -1.740465479
## GENE_30   0.201476563
## GENE_31   0.109633189
## GENE_32   0.141807662
## GENE_33   0.476044314
## GENE_34   1.380949984
## GENE_35  -0.110343220
## GENE_36   0.378483174
## GENE_37   2.421636893
## GENE_38   0.172526352
## GENE_39  -2.126759382
## GENE_40   0.370530603
## GENE_41   1.422127358
## GENE_42  -2.208964237
## GENE_43  -0.909325392
## GENE_44  -0.902373002
## GENE_45  -1.050354538
## GENE_46   0.421332403
## GENE_47   2.180660705
## GENE_48   0.008034934
## GENE_49   0.042369650
## GENE_50  -1.502001008
## GENE_51  -2.047104023
## GENE_52  -2.643758611
## GENE_53  -1.242222111
## GENE_54   1.483688938
## GENE_55  -0.034865229
## GENE_56   0.473139309
## GENE_57   2.615328333
## GENE_58   0.985599423
## GENE_59  -0.509752087
## GENE_60  -1.486795487
## GENE_61   1.910795126
## GENE_62  -1.764805341
## GENE_63  -1.645540137
## GENE_64   2.006866358
## GENE_65  -0.142128365
## GENE_66   2.345501358
## GENE_67  -0.930461615
## GENE_68   0.395989583
## GENE_69   3.311326966
## GENE_70  -1.415856436
## GENE_71   0.685720520
## GENE_72   0.160930262
## GENE_73  -3.096945963
## GENE_74   0.979187178
## GENE_75   0.354425923
## GENE_76   0.038139807
## GENE_77  -0.443051376
## GENE_78  -1.480429757
## GENE_79   0.285526989
## GENE_80  -1.388175153
## GENE_81  -0.281001878
## GENE_82  -0.762789100
## GENE_83  -1.492710445
## GENE_84   1.132616358
## GENE_85  -1.013974753
## GENE_86  -1.763476953
## GENE_87  -1.261921873
## GENE_88   0.315102174
## GENE_89   1.360844929
## GENE_90  -1.816231379
## GENE_91  -0.277756295
## GENE_92   1.103472056
## GENE_93   0.080709327
## GENE_94   1.022544224
## GENE_95  -1.069325096
## GENE_96  -0.261631412
## GENE_97  -0.262880113
## GENE_98   2.781751582
## GENE_99   1.669736240
## GENE_100 -2.122585165
```

# 4 Controlling backend creation

We can adjust some parameters for creating the backend with appropriate arguments to `writeTileDBArray()`.
For example, the example below allows us to control the path to the backend
as well as the name of the attribute containing the data.

```
X <- matrix(rnorm(1000), ncol=10)
path <- tempfile()
writeTileDBArray(X, path=path, attr="WHEE")
```

```
## <100 x 10> TileDBMatrix object of type "double":
##                [,1]         [,2]         [,3] ...       [,9]      [,10]
##   [1,]  -0.43545814   1.13490968   0.97805371   . -1.4284066  0.4510378
##   [2,]   0.06573225  -0.10357384  -0.39254974   .  0.4099889 -0.2454112
##   [3,]  -0.32217809   0.14094300  -0.04874210   . -1.0951098 -0.1194948
##   [4,]   0.05410163  -1.78957896   0.18540256   . -1.8031261 -0.1056960
##   [5,]  -0.50142775  -0.68969188  -0.31836203   .  0.7552189 -0.4848650
##    ...            .            .            .   .          .          .
##  [96,]  2.096810681 -0.060257928 -0.090130434   .  0.6775854 -0.9833088
##  [97,] -0.050697009 -0.016078086 -0.127276783   .  0.1428825 -0.8449317
##  [98,] -0.007235016 -0.246612025 -1.038962055   .  0.6749769 -0.1542604
##  [99,] -0.164118459 -1.264966094  0.689345275   .  0.9271873 -0.7064422
## [100,] -0.343253813  2.612217778  1.508794825   .  1.7849965 -0.3898809
```

As these arguments cannot be passed during coercion,
we instead provide global variables that can be set or unset to affect the outcome.

```
path2 <- tempfile()
setTileDBPath(path2)
as(X, "TileDBArray") # uses path2 to store the backend.
```

```
## <100 x 10> TileDBMatrix object of type "double":
##                [,1]         [,2]         [,3] ...       [,9]      [,10]
##   [1,]  -0.43545814   1.13490968   0.97805371   . -1.4284066  0.4510378
##   [2,]   0.06573225  -0.10357384  -0.39254974   .  0.4099889 -0.2454112
##   [3,]  -0.32217809   0.14094300  -0.04874210   . -1.0951098 -0.1194948
##   [4,]   0.05410163  -1.78957896   0.18540256   . -1.8031261 -0.1056960
##   [5,]  -0.50142775  -0.68969188  -0.31836203   .  0.7552189 -0.4848650
##    ...            .            .            .   .          .          .
##  [96,]  2.096810681 -0.060257928 -0.090130434   .  0.6775854 -0.9833088
##  [97,] -0.050697009 -0.016078086 -0.127276783   .  0.1428825 -0.8449317
##  [98,] -0.007235016 -0.246612025 -1.038962055   .  0.6749769 -0.1542604
##  [99,] -0.164118459 -1.264966094  0.689345275   .  0.9271873 -0.7064422
## [100,] -0.343253813  2.612217778  1.508794825   .  1.7849965 -0.3898809
```

# 5 Session information

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
##  [1] RcppSpdlog_0.0.23     TileDBArray_1.20.0    DelayedArray_0.36.0
##  [4] SparseArray_1.10.0    S4Arrays_1.10.0       IRanges_2.44.0
##  [7] abind_1.4-8           S4Vectors_0.48.0      MatrixGenerics_1.22.0
## [10] matrixStats_1.5.0     BiocGenerics_0.56.0   generics_0.1.4
## [13] Matrix_1.7-4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] bit_4.6.0           jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 Rcpp_1.1.0          nanoarrow_0.7.0-1
##  [7] jquerylib_0.1.4     yaml_2.3.10         fastmap_1.2.0
## [10] lattice_0.22-7      R6_2.6.1            RcppCCTZ_0.2.13
## [13] XVector_0.50.0      tiledb_0.33.0       knitr_1.50
## [16] bookdown_0.45       bslib_0.9.0         rlang_1.1.6
## [19] cachem_1.1.0        xfun_0.53           sass_0.4.10
## [22] bit64_4.6.0-1       cli_3.6.5           spdl_0.0.5
## [25] digest_0.6.37       grid_4.5.1          lifecycle_1.0.4
## [28] data.table_1.17.8   evaluate_1.0.5      nanotime_0.3.12
## [31] zoo_1.8-14          rmarkdown_2.30      tools_4.5.1
## [34] htmltools_0.5.8.1
```