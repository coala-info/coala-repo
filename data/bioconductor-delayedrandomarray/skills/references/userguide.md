# DelayedArrays of random values

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: April 17, 2021

#### Package

DelayedRandomArray 1.18.0

# 1 Introduction

The *[DelayedRandomArray](https://bioconductor.org/packages/3.22/DelayedRandomArray)* package implements `DelayedArray` subclasses containing dynamically sampled random values.
Specifically, the actual values are never fully held in memory but are generated when the relevant part of the array is accessed.
This allows users to create very large arrays of random values that would not otherwise be possible by filling an ordinary matrix.

To install the package, follow the instructions on *[DelayedRandomArray](https://bioconductor.org/packages/3.22/DelayedRandomArray)* landing page.
Using the package is then as simple as:

```
library(DelayedRandomArray)
X <- RandomUnifArray(c(1e6, 1e6))
X
```

```
## <1000000 x 1000000> RandomUnifMatrix object of type "double":
##                   [,1]        [,2]        [,3] ...  [,999999] [,1000000]
##       [1,]  0.55961110  0.04677600  0.47662698   .  0.5370808  0.4845867
##       [2,]  0.65709786  0.39938003  0.20676582   .  0.9385588  0.3416586
##       [3,]  0.09962809  0.52349691  0.52622803   .  0.5794956  0.3968041
##       [4,]  0.91910631  0.58578729  0.12418291   .  0.6815243  0.5711277
##       [5,]  0.94302208  0.89756987  0.28609900   .  0.3665509  0.2260392
##        ...           .           .           .   .          .          .
##  [999996,] 0.645673884 0.561686116 0.085533564   .  0.6412353  0.1673345
##  [999997,] 0.472965787 0.702839168 0.876543693   .  0.7728066  0.5213184
##  [999998,] 0.593628131 0.627396131 0.001750493   .  0.2571008  0.7211425
##  [999999,] 0.708574043 0.198062087 0.573289363   .  0.1814372  0.4091144
## [1000000,] 0.234685234 0.550751270 0.236357967   .  0.4227732  0.1807525
```

The resulting array can be used in any pipeline that is compatible with `DelayedArray` objects.
This object occupies only 64 MB in memory,
whereas an ordinary `matrix` would require 8 PB instead.

# 2 Available distributions

Almost every distribution in *stats* is available here.
To list a few:

```
RandomNormArray(c(100, 50))
```

```
## <100 x 50> RandomNormMatrix object of type "double":
##               [,1]        [,2]        [,3] ...       [,49]       [,50]
##   [1,]   0.2052052   0.4301681   1.9395761   .   0.8671560  -1.0238199
##   [2,]   0.3480112  -0.2308187   0.7825390   .  -0.5724951   0.3183692
##   [3,]   0.3821670   1.3858634   1.3759261   .  -0.9868943  -0.7665961
##   [4,]  -1.3735644  -0.3916928   1.1121782   .   0.6773905  -0.4769739
##   [5,]  -0.3472205  -0.4933259  -0.0321906   .  -1.2689952  -0.2966281
##    ...           .           .           .   .           .           .
##  [96,] -1.71223908 -1.14820839 -1.15004788   .  0.06311599 -0.36754999
##  [97,] -1.35738740 -0.21064459 -0.61351617   . -1.00465284 -0.14575053
##  [98,] -1.09294045  0.21646371 -0.16278559   .  1.35578054 -0.25928126
##  [99,]  1.03740603 -0.02489131  1.59825300   . -0.34288739 -0.20368705
## [100,]  1.15415424 -0.34043149  0.39208482   . -0.10269480  0.29765911
```

```
RandomPoisArray(c(100, 50), lambda=5)
```

```
## <100 x 50> RandomPoisMatrix object of type "double":
##         [,1]  [,2]  [,3] ... [,49] [,50]
##   [1,]     4     4     6   .     3     5
##   [2,]     9     4     9   .     9     6
##   [3,]     3     4     1   .     7     3
##   [4,]     3     4     4   .     5     7
##   [5,]     4     5     4   .     2     2
##    ...     .     .     .   .     .     .
##  [96,]     4     6     9   .     5     8
##  [97,]     6     7     3   .     3     7
##  [98,]     5     6     3   .     5     3
##  [99,]     4     3     6   .     9     5
## [100,]     6     2     3   .     7     6
```

```
RandomGammaArray(c(100, 50), shape=2, rate=5)
```

```
## <100 x 50> RandomGammaMatrix object of type "double":
##              [,1]       [,2]       [,3] ...      [,49]      [,50]
##   [1,]  0.5271486  0.4530431  0.1035348   .  0.5082925  0.4850073
##   [2,]  0.5081914  0.1307665  0.2348222   .  0.1593903  0.2010818
##   [3,]  0.4396448  1.5410614  0.4412404   .  0.2184451  0.2662694
##   [4,]  0.6637376  0.1962013  0.3073928   .  0.1660010  0.5450935
##   [5,]  0.6485878  0.3666891  0.4403969   .  0.2071839  0.2182151
##    ...          .          .          .   .          .          .
##  [96,] 0.19711998 0.49827762 0.24686680   . 0.22286539 1.06474357
##  [97,] 0.07879035 0.09343829 1.99679794   . 0.63460035 0.09535979
##  [98,] 1.10589466 0.28424909 0.20673655   . 0.68694796 0.09586012
##  [99,] 0.58332579 0.74607622 0.76415687   . 0.32041781 0.33261615
## [100,] 0.42245868 0.14182033 0.22795269   . 0.35115329 0.91029886
```

```
RandomWeibullArray(c(100, 50), shape=5)
```

```
## <100 x 50> RandomWeibullMatrix object of type "double":
##             [,1]      [,2]      [,3] ...     [,49]     [,50]
##   [1,] 0.6747885 0.7247487 0.8502660   . 0.6951060 0.9027349
##   [2,] 0.9018641 0.8664327 0.6190545   . 0.6532800 0.7176524
##   [3,] 1.3301879 1.0878478 0.7840226   . 0.6873099 0.8511305
##   [4,] 0.8296297 0.8654395 1.0795910   . 1.0216893 0.8783134
##   [5,] 0.6686069 0.8920021 0.5550355   . 0.8937831 0.9101526
##    ...         .         .         .   .         .         .
##  [96,] 1.0741231 0.8037968 0.7946442   . 0.4835784 0.6313221
##  [97,] 0.9408647 0.6125118 0.8989656   . 0.9590126 1.0660472
##  [98,] 1.1240899 0.9684447 0.6330051   . 0.9507420 0.9854453
##  [99,] 0.4920449 0.8178240 0.8004888   . 0.8939623 0.7889141
## [100,] 0.8374699 0.7837877 0.9854849   . 0.9873378 1.0375646
```

Distributional parameters can either be scalars:

```
RandomNormArray(c(100, 50), mean=1)
```

```
## <100 x 50> RandomNormMatrix object of type "double":
##               [,1]        [,2]        [,3] ...       [,49]       [,50]
##   [1,]   1.4436681   0.6999826   0.9445607   .  2.48242463  1.32609793
##   [2,]   1.2437764   0.4047366   1.6951640   . -1.21693219  0.02516515
##   [3,]   3.5482290   1.2758684   1.1278910   .  0.44200086  0.60079552
##   [4,]   2.5220865   1.5432607   0.1633348   .  0.24948685  0.22023903
##   [5,]   2.7550859   1.0833868   2.0125143   .  1.05651316  0.68900829
##    ...           .           .           .   .           .           .
##  [96,]  2.06233101  0.83256241  1.63649537   .   0.8254569  -0.1582572
##  [97,]  1.84875913  0.57656006  1.14995026   .   1.9885211   1.6583660
##  [98,]  4.19500600  0.02352568  2.29752017   .  -0.2112991   1.9045705
##  [99,]  0.26457398  3.37429828  2.28322060   .   0.7247715   0.6499275
## [100,] -0.52930666  0.30582786  1.33383727   .   0.4126162   1.0614017
```

Or vectors, which are recycled along the length of the array:

```
RandomNormArray(c(100, 50), mean=1:100)
```

```
## <100 x 50> RandomNormMatrix object of type "double":
##             [,1]      [,2]      [,3] ...    [,49]    [,50]
##   [1,] 0.8444366 2.5037763 1.6342739   . 1.565246 1.948100
##   [2,] 2.3288075 2.8867350 2.5523417   . 0.974865 1.568174
##   [3,] 1.4405602 1.3427407 3.0811619   . 1.987915 3.394611
##   [4,] 5.5297225 2.7775166 5.7449357   . 3.977329 4.212836
##   [5,] 3.5612618 5.1806150 5.0249186   . 3.948713 5.192117
##    ...         .         .         .   .        .        .
##  [96,]  96.91322  96.81723  96.77508   . 95.73453 96.77275
##  [97,]  96.55170  98.52735  97.83303   . 98.17737 98.88615
##  [98,]  98.59140  98.70310 100.09250   . 95.53854 97.94415
##  [99,]  97.07987  99.24875  99.14039   . 98.49697 98.91620
## [100,] 101.04312  98.54810 100.09412   . 99.73712 99.62367
```

Or other arrays of the same dimensions, which are used to sample the corresponding parts of the random array:

```
means <- RandomNormArray(c(100, 50))
RandomPoisArray(c(100, 50), lambda=2^means)
```

```
## <100 x 50> RandomPoisMatrix object of type "double":
##         [,1]  [,2]  [,3] ... [,49] [,50]
##   [1,]     0     0     2   .     7     2
##   [2,]     0     0     1   .     2     3
##   [3,]     1     0     0   .     4     1
##   [4,]     1     2     0   .     1     0
##   [5,]     1     0     1   .     0     0
##    ...     .     .     .   .     .     .
##  [96,]     0     0     0   .     2     1
##  [97,]     0     0     2   .     0     0
##  [98,]     0     0     1   .     1     0
##  [99,]     0     1     0   .     0     1
## [100,]     1     0     0   .     0     0
```

For example, a hypothetical simulation of a million-cell single-cell RNA-seq dataset might look like this:

```
ngenes <- 20000
log.abundances <- runif(ngenes, -2, 5)

nclusters <- 20 # define 20 clusters and their population means.
cluster.means <- matrix(2^rnorm(ngenes*nclusters, log.abundances, sd=2), ncol=nclusters)

ncells <- 1e6
clusters <- sample(nclusters, ncells, replace=TRUE) # randomly allocate cells
cell.means <- DelayedArray(cluster.means)[,clusters]

dispersions <- 0.05 + 10/cell.means # typical mean variance trend.

y <- RandomNbinomArray(c(ngenes, ncells), mu=cell.means, size=1/dispersions)
y
```

```
## <20000 x 1000000> RandomNbinomMatrix object of type "double":
##                [,1]       [,2]       [,3] ...  [,999999] [,1000000]
##     [1,]          0          0          0   .          5          0
##     [2,]          3          0          9   .          0          0
##     [3,]         11         18          7   .         36         10
##     [4,]          2         57          2   .         27         33
##     [5,]          8         75          8   .          7          0
##      ...          .          .          .   .          .          .
## [19996,]          3        102          5   .         11         26
## [19997,]          0          0          0   .          0          0
## [19998,]          0          7          0   .          1          0
## [19999,]          0          3          0   .         10          0
## [20000,]         27         98          1   .          1          1
```

# 3 Chunking

Each random `DelayedArray`s is broken into contiguous rectangular chunks of identical size and shape.
Each chunk is assigned a seed at construction time that is used to initialize a random number stream (using the PCG32 generator from the *[dqrng](https://CRAN.R-project.org/package%3Ddqrng)* package).
When the user accesses any part of the array, we generate the random numbers in the overlapping chunks and return the desired values.
This provides efficient random access to any subarray without the need to use any jump-ahead functionality.

The chunking scheme determines the efficiency of accessing our random `DelayedArray`s.
Chunks that are too large require unnecessary number generation when a subarray is requested, while chunks that are too small would increase memory usage and book-keeping overhead.
The “best” choice also depends on the downstream access pattern, if such information is known.
For example, in a matrix where each column is a chunk, retrieval of a column would be very efficient while retrieval of a single row would be very slow.
The default chunk dimensions are set to the square root of the array dimensions (or 100, whichever is larger), providing a reasonable compromise between all of these considerations.
This can also be manually specified with the `chunkdim=` argument.

```
# Row-wise chunks:
RandomUnifArray(c(1000, 500), chunkdim=c(1, 500))
```

```
## <1000 x 500> RandomUnifMatrix object of type "double":
##               [,1]       [,2]       [,3] ...       [,499]       [,500]
##    [1,] 0.34183590 0.16943408 0.13697855   .    0.3742005    0.7878034
##    [2,] 0.14306935 0.84659915 0.48964419   .    0.9859083    0.1209865
##    [3,] 0.56113587 0.24837508 0.23722880   .    0.2845222    0.9371417
##    [4,] 0.44135979 0.25035622 0.67012599   .    0.4369570    0.8795329
##    [5,] 0.12689138 0.29438292 0.06288585   .    0.7100034    0.4005527
##     ...          .          .          .   .            .            .
##  [996,] 0.02809723 0.63965427 0.87049882   . 0.9531269320 0.3229864901
##  [997,] 0.21219902 0.83294676 0.43337313   . 0.4646550249 0.0007043867
##  [998,] 0.96813072 0.10258344 0.04297487   . 0.8487962764 0.3962373710
##  [999,] 0.56389059 0.32425934 0.44555864   . 0.0331147015 0.9718483556
## [1000,] 0.98149188 0.66594049 0.49981640   . 0.5603973730 0.8491233266
```

```
# Column-wise chunks:
RandomUnifArray(c(1000, 500), chunkdim=c(1000, 1))
```

```
## <1000 x 500> RandomUnifMatrix object of type "double":
##               [,1]       [,2]       [,3] ...     [,499]     [,500]
##    [1,] 0.24720863 0.21756868 0.91546164   . 0.50679661 0.04311065
##    [2,] 0.07047027 0.77626654 0.58172045   . 0.62056850 0.73948922
##    [3,] 0.75016602 0.63970907 0.83017241   . 0.13329527 0.48245106
##    [4,] 0.27643459 0.14805137 0.73229031   . 0.49230879 0.24964657
##    [5,] 0.53689901 0.79585405 0.15341265   . 0.38849801 0.40905805
##     ...          .          .          .   .          .          .
##  [996,]  0.5544063  0.3349674  0.6474358   .  0.1594206  0.8615829
##  [997,]  0.4872590  0.1260171  0.7636951   .  0.6935878  0.7280168
##  [998,]  0.1787248  0.1495553  0.4887845   .  0.9394455  0.2797951
##  [999,]  0.9620991  0.7995752  0.4126173   .  0.9767407  0.7830430
## [1000,]  0.6193899  0.7838540  0.2418651   .  0.7845646  0.7260430
```

Unlike other chunk-based `DelayedArray`s, the actual values of the random `DelayedArray` are dependent on the chunk parameters.
This is because the sampling is done within each chunk and any alteration to the chunk shape or size will rearrange the stream of random numbers within the array.
Thus, even when the seed is set, a different `chunkdim` will yield different results:

```
set.seed(199)
RandomUnifArray(c(10, 5), chunkdim=c(1, 5))
```

```
## <10 x 5> RandomUnifMatrix object of type "double":
##               [,1]         [,2]         [,3]         [,4]         [,5]
##  [1,] 0.4432813900 0.7119991907 0.7257159729 0.9557158216 0.2104000037
##  [2,] 0.3134128384 0.0670862596 0.3807734565 0.1526811279 0.1971345709
##  [3,] 0.5525409468 0.7807079460 0.9905007351 0.0898367104 0.8541555854
##  [4,] 0.8914577304 0.3764661429 0.6028462166 0.2576166289 0.0145520803
##  [5,] 0.5042253651 0.2618340398 0.2405915416 0.6800763716 0.5603335327
##  [6,] 0.3953960796 0.1314800435 0.9008538304 0.1165704445 0.9035755624
##  [7,] 0.6270407308 0.0001234491 0.3542078000 0.3546805161 0.9760325255
##  [8,] 0.2882098067 0.9133890264 0.8018615395 0.7615402588 0.6458653482
##  [9,] 0.2233627134 0.2957882064 0.7371763836 0.3001928469 0.8730950402
## [10,] 0.6481108814 0.5491673953 0.6821353873 0.4434014931 0.1461723484
```

```
set.seed(199)
RandomUnifArray(c(10, 5), chunkdim=c(10, 1))
```

```
## <10 x 5> RandomUnifMatrix object of type "double":
##             [,1]       [,2]       [,3]       [,4]       [,5]
##  [1,] 0.44328139 0.31341284 0.55254095 0.89145773 0.50422537
##  [2,] 0.71199919 0.06708626 0.78070795 0.37646614 0.26183404
##  [3,] 0.72571597 0.38077346 0.99050074 0.60284622 0.24059154
##  [4,] 0.95571582 0.15268113 0.08983671 0.25761663 0.68007637
##  [5,] 0.21040000 0.19713457 0.85415559 0.01455208 0.56033353
##  [6,] 0.63126383 0.10118984 0.76830283 0.17583353 0.62183470
##  [7,] 0.87478047 0.26076972 0.58018989 0.92146566 0.90680388
##  [8,] 0.55180537 0.20464839 0.38008429 0.56606812 0.75101891
##  [9,] 0.40323090 0.20083487 0.28559824 0.67769322 0.11943279
## [10,] 0.13404760 0.94959186 0.61432837 0.67675354 0.64178865
```

# 4 Further comments

Like any other random process, the seed should be set to achieve reproducible results.
We stress that the R-level seed only needs to be set before *construction* of the random `DelayedArray`; it is not necessary to set the seed during its *use*.
This is because the class itself will define further seeds (one per chunk) and store these in the object for use in per-chunk sampling.

```
set.seed(999)
RandomNormArray(c(10, 5))
```

```
## <10 x 5> RandomNormMatrix object of type "double":
##              [,1]        [,2]        [,3]        [,4]        [,5]
##  [1,]  0.07299897 -0.62967402  0.48686043 -1.00406271  0.09839211
##  [2,] -1.87549362  0.11653501  0.98496315 -0.85515988 -1.44932474
##  [3,]  0.62150210 -0.24704984 -0.69766033 -1.60089511  0.94752723
##  [4,] -1.68035676  0.20939894 -3.29663662  0.57270346  0.94413669
##  [5,]  0.22933664  1.12333362 -0.77725398  1.59886411  1.07042538
##  [6,]  0.43082191 -0.22740387  1.25381398  0.32842239  0.20448699
##  [7,] -0.71424097  0.27773134  1.53748664  0.01761569  1.15470498
##  [8,]  0.35908991  0.35618136 -0.49375892 -0.38652760  0.95591577
##  [9,]  0.06472627  0.79333115 -0.73803086 -0.56434493  0.22473943
## [10,] -2.41389122  0.76273286  0.47567035 -0.08524682 -1.17849232
```

```
set.seed(999)
RandomNormArray(c(10, 5))
```

```
## <10 x 5> RandomNormMatrix object of type "double":
##              [,1]        [,2]        [,3]        [,4]        [,5]
##  [1,]  0.07299897 -0.62967402  0.48686043 -1.00406271  0.09839211
##  [2,] -1.87549362  0.11653501  0.98496315 -0.85515988 -1.44932474
##  [3,]  0.62150210 -0.24704984 -0.69766033 -1.60089511  0.94752723
##  [4,] -1.68035676  0.20939894 -3.29663662  0.57270346  0.94413669
##  [5,]  0.22933664  1.12333362 -0.77725398  1.59886411  1.07042538
##  [6,]  0.43082191 -0.22740387  1.25381398  0.32842239  0.20448699
##  [7,] -0.71424097  0.27773134  1.53748664  0.01761569  1.15470498
##  [8,]  0.35908991  0.35618136 -0.49375892 -0.38652760  0.95591577
##  [9,]  0.06472627  0.79333115 -0.73803086 -0.56434493  0.22473943
## [10,] -2.41389122  0.76273286  0.47567035 -0.08524682 -1.17849232
```

For certain distributions, it is possible to indicate that the array is sparse.
This does not change the result or efficiency of the sampling process, but can still be useful as it allows downstream functions to use more efficient sparse algorithms.
Of course, this is only relevant if the distributional parameters are such that sparsity is actually observed.

```
RandomPoisArray(c(1e6, 1e6), lambda=0.5) # dense by default
```

```
## <1000000 x 1000000> RandomPoisMatrix object of type "double":
##                  [,1]       [,2]       [,3] ...  [,999999] [,1000000]
##       [1,]          0          0          1   .          1          0
##       [2,]          0          1          1   .          0          1
##       [3,]          0          1          1   .          0          0
##       [4,]          0          1          0   .          1          0
##       [5,]          0          0          0   .          1          0
##        ...          .          .          .   .          .          .
##  [999996,]          1          0          0   .          1          1
##  [999997,]          0          1          0   .          1          1
##  [999998,]          2          0          1   .          0          0
##  [999999,]          1          0          1   .          0          1
## [1000000,]          0          0          0   .          1          0
```

```
RandomPoisArray(c(1e6, 1e6), lambda=0.5, sparse=TRUE) # treat as sparse
```

```
## <1000000 x 1000000> sparse RandomPoisMatrix object of type "double":
##                  [,1]       [,2]       [,3] ...  [,999999] [,1000000]
##       [1,]          0          1          1   .          1          0
##       [2,]          0          1          1   .          1          0
##       [3,]          0          1          1   .          0          0
##       [4,]          1          2          0   .          0          0
##       [5,]          0          1          0   .          0          2
##        ...          .          .          .   .          .          .
##  [999996,]          0          0          1   .          0          0
##  [999997,]          0          0          0   .          1          0
##  [999998,]          3          0          0   .          1          1
##  [999999,]          1          0          0   .          1          0
## [1000000,]          0          2          1   .          1          0
```

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
##  [1] DelayedRandomArray_1.18.0 DelayedArray_0.36.0
##  [3] SparseArray_1.10.0        S4Arrays_1.10.0
##  [5] IRanges_2.44.0            abind_1.4-8
##  [7] S4Vectors_0.48.0          MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0         BiocGenerics_0.56.0
## [11] generics_0.1.4            Matrix_1.7-4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           jsonlite_2.0.0      dqrng_0.4.1
##  [7] htmltools_0.5.8.1   sass_0.4.10         rmarkdown_2.30
## [10] grid_4.5.1          evaluate_1.0.5      jquerylib_0.1.4
## [13] fastmap_1.2.0       yaml_2.3.10         lifecycle_1.0.4
## [16] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
## [19] Rcpp_1.1.0          XVector_0.50.0      lattice_0.22-7
## [22] digest_0.6.37       R6_2.6.1            bslib_0.9.0
## [25] tools_4.5.1         cachem_1.1.0
```