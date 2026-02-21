# Running SIMLR

Daniele Ramazzotti, Bo Wang, Luca De Sano and Serafim Batzoglou

#### October 30, 2025

#### Package

SIMLR 1.36.0

The external R package igraph is required for the computation of the normalized mutual information to
assess the results of the clustering.

```
library(igraph)
```

```
##
## Attaching package: 'igraph'
```

```
## The following objects are masked from 'package:stats':
##
##     decompose, spectrum
```

```
## The following object is masked from 'package:base':
##
##     union
```

```
library(SIMLR)
```

We now run SIMLR as an example on an input dataset from Buettner, Florian, et al. “Computational analysis of
cell-to-cell heterogeneity in single-cell RNA-sequencing data reveals hidden subpopulations of cells.” Nature
biotechnology 33.2 (2015): 155-160. For this dataset we have a ground true of 3 cell populations, i.e., clusters.

```
set.seed(11111)
data(BuettnerFlorian)
example = SIMLR(X = BuettnerFlorian$in_X, c = BuettnerFlorian$n_clust, cores.ratio = 0)
```

```
## Computing the multiple Kernels.
## Performing network diffiusion.
## Iteration:  1
## Iteration:  2
## Iteration:  3
## Iteration:  4
## Iteration:  5
## Iteration:  6
## Iteration:  7
## Iteration:  8
## Iteration:  9
## Iteration:  10
## Iteration:  11
```

```
## Warning in SIMLR(X = BuettnerFlorian$in_X, c = BuettnerFlorian$n_clust, : Maybe
## you should set a larger value of c.
```

```
## Performing t-SNE.
## Epoch: Iteration # 100  error is:  0.1293406
## Epoch: Iteration # 200  error is:  0.07376446
## Epoch: Iteration # 300  error is:  0.05963893
## Epoch: Iteration # 400  error is:  0.05958424
## Epoch: Iteration # 500  error is:  0.05953258
## Epoch: Iteration # 600  error is:  0.05948551
## Epoch: Iteration # 700  error is:  0.05944139
## Epoch: Iteration # 800  error is:  0.05940026
## Epoch: Iteration # 900  error is:  0.05936119
## Epoch: Iteration # 1000  error is:  0.05932415
## Performing Kmeans.
## Performing t-SNE.
## Epoch: Iteration # 100  error is:  10.98628
## Epoch: Iteration # 200  error is:  0.8364971
## Epoch: Iteration # 300  error is:  0.6978426
## Epoch: Iteration # 400  error is:  0.5367967
## Epoch: Iteration # 500  error is:  0.419038
## Epoch: Iteration # 600  error is:  0.4244949
## Epoch: Iteration # 700  error is:  0.4438908
## Epoch: Iteration # 800  error is:  0.437931
## Epoch: Iteration # 900  error is:  0.383611
## Epoch: Iteration # 1000  error is:  0.5312541
```

We now compute the normalized mutual information between the inferred clusters by SIMLR and the true ones.
This measure with values in [0,1], allows us to assess the performance of the clustering with higher values
reflecting better performance.

```
nmi_1 = compare(BuettnerFlorian$true_labs[,1], example$y$cluster, method="nmi")
print(nmi_1)
```

```
## [1] 0.888298
```

As a further understanding of the results, we now visualize the cell populations in a plot.

```
plot(example$ydata,
    col = c(topo.colors(BuettnerFlorian$n_clust))[BuettnerFlorian$true_labs[,1]],
    xlab = "SIMLR component 1",
    ylab = "SIMLR component 2",
    pch = 20,
    main="SIMILR 2D visualization for BuettnerFlorian")
```

![Visualization of the 3 cell populations retrieved by SIMLR on the dataset by Florian, et al.](data:image/png;base64...)

Figure 1: Visualization of the 3 cell populations retrieved by SIMLR on the dataset by Florian, et al

We also run SIMLR feature ranking on the same inputs to get a rank of the key genes with the related pvalues.

```
set.seed(11111)
ranks = SIMLR_Feature_Ranking(A=BuettnerFlorian$results$S,X=BuettnerFlorian$in_X)
```

```
## 1
## 2
## 3
## 4
## 5
## 6
## 7
## 8
## 9
## 10
## 11
## 12
## 13
## 14
## 15
## 16
## 17
## 18
## 19
## 20
## 21
## 22
## 23
## 24
## 25
## 26
## 27
## 28
## 29
## 30
## 31
## 32
## 33
## 34
## 35
## 36
## 37
## 38
## 39
## 40
## 41
## 42
## 43
## 44
## 45
## 46
## 47
## 48
## 49
## 50
## 51
## 52
## 53
## 54
## 55
## 56
## 57
## 58
## 59
## 60
## 61
## 62
## 63
## 64
## 65
## 66
## 67
## 68
## 69
## 70
## 71
## 72
## 73
## 74
## 75
## 76
## 77
## 78
## 79
## 80
## 81
## 82
## 83
## 84
## 85
## 86
## 87
## 88
## 89
## 90
## 91
## 92
## 93
## 94
## 95
## 96
## 97
## 98
## 99
## 100
```

```
head(ranks$pval)
```

```
## [1] 1.086748e-128  1.189327e-90  5.504924e-80  4.652359e-75  5.593957e-73
## [6]  3.373056e-69
```

```
head(ranks$aggR)
```

```
## [1] 5701 1689 7549   57 2653 8081
```

Similarly, we show an example for SIMLR large scale on an input dataset being a reduced version of the dataset
provided in Buettner, Zeisel, Amit, et al. “Cell types in the mouse cortex and hippocampus revealed by single-cell
RNA-seq.” Science 347.6226 (2015): 1138-1142. For this dataset we have a ground true of 9 cell populations, i.e., clusters.
But we should notice that here we use for computational reasons a reduced version of the data, so please refer to the
original publication for the full data.

```
set.seed(11111)
data(ZeiselAmit)
example_large_scale = SIMLR_Large_Scale(X = ZeiselAmit$in_X, c = ZeiselAmit$n_clust, kk = 10)
```

```
## Performing fast PCA.
## Performing k-nearest neighbour search.
## Computing the multiple Kernels.
## Performing the iterative procedure  5  times.
## Iteration:  1
## Iteration:  2
## Iteration:  3
## Iteration:  4
## Iteration:  5
## Performing Kmeans.
## Performing t-SNE.
## The main loop will be now performed with a maximum of 300 iterations.
## Performing iteration 1.
## Performing iteration 2.
## Performing iteration 3.
## Performing iteration 4.
## Performing iteration 5.
## Performing iteration 6.
## Performing iteration 7.
## Performing iteration 8.
## Performing iteration 9.
## Performing iteration 10.
## Performing iteration 11.
## Performing iteration 12.
## Performing iteration 13.
## Performing iteration 14.
## Performing iteration 15.
## Performing iteration 16.
## Performing iteration 17.
## Performing iteration 18.
## Performing iteration 19.
## Performing iteration 20.
## Performing iteration 21.
## Performing iteration 22.
## Performing iteration 23.
## Performing iteration 24.
## Performing iteration 25.
## Performing iteration 26.
## Performing iteration 27.
## Performing iteration 28.
## Performing iteration 29.
## Performing iteration 30.
## Performing iteration 31.
## Performing iteration 32.
## Performing iteration 33.
## Performing iteration 34.
## Performing iteration 35.
## Performing iteration 36.
## Performing iteration 37.
## Performing iteration 38.
## Performing iteration 39.
## Performing iteration 40.
## Performing iteration 41.
## Performing iteration 42.
## Performing iteration 43.
## Performing iteration 44.
## Performing iteration 45.
## Performing iteration 46.
## Performing iteration 47.
## Performing iteration 48.
## Performing iteration 49.
## Performing iteration 50.
## Performing iteration 51.
## Performing iteration 52.
## Performing iteration 53.
## Performing iteration 54.
## Performing iteration 55.
## Performing iteration 56.
## Performing iteration 57.
## Performing iteration 58.
## Performing iteration 59.
## Performing iteration 60.
## Performing iteration 61.
## Performing iteration 62.
## Performing iteration 63.
## Performing iteration 64.
## Performing iteration 65.
## Performing iteration 66.
## Performing iteration 67.
## Performing iteration 68.
## Performing iteration 69.
## Performing iteration 70.
## Performing iteration 71.
## Performing iteration 72.
## Performing iteration 73.
## Performing iteration 74.
## Performing iteration 75.
## Performing iteration 76.
## Performing iteration 77.
## Performing iteration 78.
## Performing iteration 79.
## Performing iteration 80.
## Performing iteration 81.
## Performing iteration 82.
## Performing iteration 83.
## Performing iteration 84.
## Performing iteration 85.
## Performing iteration 86.
## Performing iteration 87.
## Performing iteration 88.
## Performing iteration 89.
## Performing iteration 90.
## Performing iteration 91.
## Performing iteration 92.
## Performing iteration 93.
## Performing iteration 94.
## Performing iteration 95.
## Performing iteration 96.
## Performing iteration 97.
## Performing iteration 98.
## Performing iteration 99.
## Performing iteration 100.
## Performing iteration 101.
## Performing iteration 102.
## Performing iteration 103.
## Performing iteration 104.
## Performing iteration 105.
## Performing iteration 106.
## Performing iteration 107.
## Performing iteration 108.
## Performing iteration 109.
## Performing iteration 110.
## Performing iteration 111.
## Performing iteration 112.
## Performing iteration 113.
## Performing iteration 114.
## Performing iteration 115.
## Performing iteration 116.
## Performing iteration 117.
## Performing iteration 118.
## Performing iteration 119.
## Performing iteration 120.
## Performing iteration 121.
## Performing iteration 122.
## Performing iteration 123.
## Performing iteration 124.
## Performing iteration 125.
## Performing iteration 126.
## Performing iteration 127.
## Performing iteration 128.
## Performing iteration 129.
## Performing iteration 130.
## Performing iteration 131.
## Performing iteration 132.
## Performing iteration 133.
## Performing iteration 134.
## Performing iteration 135.
## Performing iteration 136.
## Performing iteration 137.
## Performing iteration 138.
## Performing iteration 139.
## Performing iteration 140.
## Performing iteration 141.
## Performing iteration 142.
## Performing iteration 143.
## Performing iteration 144.
## Performing iteration 145.
## Performing iteration 146.
## Performing iteration 147.
## Performing iteration 148.
## Performing iteration 149.
## Performing iteration 150.
## Performing iteration 151.
## Performing iteration 152.
## Performing iteration 153.
## Performing iteration 154.
## Performing iteration 155.
## Performing iteration 156.
## Performing iteration 157.
## Performing iteration 158.
## Performing iteration 159.
## Performing iteration 160.
## Performing iteration 161.
## Performing iteration 162.
## Performing iteration 163.
## Performing iteration 164.
## Performing iteration 165.
## Performing iteration 166.
## Performing iteration 167.
## Performing iteration 168.
## Performing iteration 169.
## Performing iteration 170.
## Performing iteration 171.
## Performing iteration 172.
## Performing iteration 173.
## Performing iteration 174.
## Performing iteration 175.
## Performing iteration 176.
## Performing iteration 177.
## Performing iteration 178.
## Performing iteration 179.
## Performing iteration 180.
## Performing iteration 181.
## Performing iteration 182.
## Performing iteration 183.
## Performing iteration 184.
## Performing iteration 185.
## Performing iteration 186.
## Performing iteration 187.
## Performing iteration 188.
## Performing iteration 189.
## Performing iteration 190.
## Performing iteration 191.
## Performing iteration 192.
## Performing iteration 193.
## Performing iteration 194.
## Performing iteration 195.
## Performing iteration 196.
## Performing iteration 197.
## Performing iteration 198.
## Performing iteration 199.
## Performing iteration 200.
## Performing iteration 201.
## Performing iteration 202.
## Performing iteration 203.
## Performing iteration 204.
## Performing iteration 205.
## Performing iteration 206.
## Performing iteration 207.
## Performing iteration 208.
## Performing iteration 209.
## Performing iteration 210.
## Performing iteration 211.
## Performing iteration 212.
## Performing iteration 213.
## Performing iteration 214.
## Performing iteration 215.
## Performing iteration 216.
## Performing iteration 217.
## Performing iteration 218.
## Performing iteration 219.
## Performing iteration 220.
## Performing iteration 221.
## Performing iteration 222.
## Performing iteration 223.
## Performing iteration 224.
## Performing iteration 225.
## Performing iteration 226.
## Performing iteration 227.
## Performing iteration 228.
## Performing iteration 229.
## Performing iteration 230.
## Performing iteration 231.
## Performing iteration 232.
## Performing iteration 233.
## Performing iteration 234.
## Performing iteration 235.
## Performing iteration 236.
## Performing iteration 237.
## Performing iteration 238.
## Performing iteration 239.
## Performing iteration 240.
## Performing iteration 241.
## Performing iteration 242.
## Performing iteration 243.
## Performing iteration 244.
## Performing iteration 245.
## Performing iteration 246.
## Performing iteration 247.
## Performing iteration 248.
## Performing iteration 249.
## Performing iteration 250.
## Performing iteration 251.
## Performing iteration 252.
## Performing iteration 253.
## Performing iteration 254.
## Performing iteration 255.
## Performing iteration 256.
## Performing iteration 257.
## Performing iteration 258.
## Performing iteration 259.
## Performing iteration 260.
## Performing iteration 261.
## Performing iteration 262.
## Performing iteration 263.
## Performing iteration 264.
## Performing iteration 265.
## Performing iteration 266.
## Performing iteration 267.
## Performing iteration 268.
## Performing iteration 269.
## Performing iteration 270.
## Performing iteration 271.
## Performing iteration 272.
## Performing iteration 273.
## Performing iteration 274.
## Performing iteration 275.
## Performing iteration 276.
## Performing iteration 277.
## Performing iteration 278.
## Performing iteration 279.
## Performing iteration 280.
## Performing iteration 281.
## Performing iteration 282.
## Performing iteration 283.
## Performing iteration 284.
## Performing iteration 285.
## Performing iteration 286.
## Performing iteration 287.
## Performing iteration 288.
## Performing iteration 289.
## Performing iteration 290.
## Performing iteration 291.
## Performing iteration 292.
## Performing iteration 293.
## Performing iteration 294.
## Performing iteration 295.
## Performing iteration 296.
## Performing iteration 297.
## Performing iteration 298.
## Performing iteration 299.
## Performing iteration 300.
```

We compute the normalized mutual information between the inferred clusters by SIMLR large scale and the true ones.

```
nmi_2 = compare(ZeiselAmit$true_labs[,1], example_large_scale$y$cluster, method="nmi")
print(nmi_2)
```

```
## [1] 0.04158302
```

As a further understanding of the results, also in this case we visualize the cell populations in a plot.

```
plot(example_large_scale$ydata,
    col = c(topo.colors(ZeiselAmit$n_clust))[ZeiselAmit$true_labs[,1]],
    xlab = "SIMLR component 1",
    ylab = "SIMLR component 2",
    pch = 20,
    main="SIMILR 2D visualization for ZeiselAmit")
```

![Visualization of the 9 cell populations retrieved by SIMLR large scale on the dataset by Zeisel, Amit, et al.](data:image/png;base64...)

Figure 2: Visualization of the 9 cell populations retrieved by SIMLR large scale on the dataset by Zeisel, Amit, et al

Now, as a final example, we also provide the results of two heuristics (see the original SIMLR paper) to
estimate the number of clusters from data.

```
set.seed(53900)
NUMC = 2:5
res_example = SIMLR_Estimate_Number_of_Clusters(BuettnerFlorian$in_X,
    NUMC = NUMC,
    cores.ratio = 0)
```

Best number of clusters, K1 heuristic:

```
NUMC[which.min(res_example$K1)]
```

```
## [1] 2
```

K2 heuristic:

```
NUMC[which.min(res_example$K2)]
```

```
## [1] 2
```

Results of the two heuristics:

```
res_example
```

```
## $K1
## [1] -63.04223 -19.49278 -23.77182  13.30109
##
## $K2
## [1] -94.56335 -25.99037 -29.71477  15.96130
```