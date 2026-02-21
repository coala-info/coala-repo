# Step 3: Post-Processing

#### Tyler J Burns

#### October 2, 2017

### The post-processing function:

This vignette covers what takes place following the generation of SCONE output detailed in TheSconeWorkflow.Rmd. The obvious step that needs to take place is the Scone generated columns being merged into the original input data. The user gets the option of log base 10 transforming q values, which is easier to visualize. The user also gets the option to run t-SNE on the data, such that said maps can be colored by SCONE generated values. In this case, t-SNE is run utilizing the Rtsne package, using the same markers that were used as input for the KNN. generation.

```
library(Sconify)
wand.final <- PostProcessing(scone.output = wand.scone,
                         cell.data = wand.combined,
                         input = input.markers)
```

```
## Read the 1000 x 27 data matrix successfully!
## OpenMP is working. 1 threads.
## Using no_dims = 2, perplexity = 30.000000, and theta = 0.500000
## Computing input similarities...
## Building tree...
## Done in 0.11 seconds (sparsity = 0.126912)!
## Learning embedding...
## Iteration 50: error is 64.015809 (50 iterations in 0.23 seconds)
## Iteration 100: error is 60.529233 (50 iterations in 0.17 seconds)
## Iteration 150: error is 60.157611 (50 iterations in 0.19 seconds)
## Iteration 200: error is 60.063856 (50 iterations in 0.16 seconds)
## Iteration 250: error is 60.026977 (50 iterations in 0.16 seconds)
## Iteration 300: error is 1.348976 (50 iterations in 0.14 seconds)
## Iteration 350: error is 1.236064 (50 iterations in 0.13 seconds)
## Iteration 400: error is 1.213796 (50 iterations in 0.13 seconds)
## Iteration 450: error is 1.202978 (50 iterations in 0.13 seconds)
## Iteration 500: error is 1.195581 (50 iterations in 0.13 seconds)
## Iteration 550: error is 1.187989 (50 iterations in 0.13 seconds)
## Iteration 600: error is 1.184214 (50 iterations in 0.13 seconds)
## Iteration 650: error is 1.180105 (50 iterations in 0.13 seconds)
## Iteration 700: error is 1.177977 (50 iterations in 0.13 seconds)
## Iteration 750: error is 1.175112 (50 iterations in 0.13 seconds)
## Iteration 800: error is 1.173040 (50 iterations in 0.13 seconds)
## Iteration 850: error is 1.171772 (50 iterations in 0.13 seconds)
## Iteration 900: error is 1.170674 (50 iterations in 0.13 seconds)
## Iteration 950: error is 1.169278 (50 iterations in 0.13 seconds)
## Iteration 1000: error is 1.168042 (50 iterations in 0.13 seconds)
## Fitting performed in 2.90 seconds.
```

```
wand.combined # input data
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
wand.scone # scone-generated data
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

```
wand.final # the data after post-processing
```

```
## # A tibble: 1,000 × 87
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
## # ℹ 83 more variables: `CD3(Cd114)Di` <dbl>, `CD45(In115)Di` <dbl>,
## #   `CD19(Nd142)Di` <dbl>, `CD22(Nd143)Di` <dbl>, `IgD(Nd145)Di` <dbl>,
## #   `CD79b(Nd146)Di` <dbl>, `CD20(Sm147)Di` <dbl>, `CD34(Nd148)Di` <dbl>,
## #   `CD179a(Sm149)Di` <dbl>, `CD72(Eu151)Di` <dbl>, `IgM(Eu153)Di` <dbl>,
## #   `Kappa(Sm154)Di` <dbl>, `CD10(Gd156)Di` <dbl>, `Lambda(Gd157)Di` <dbl>,
## #   `CD24(Dy161)Di` <dbl>, `TdT(Dy163)Di` <dbl>, `Rag1(Dy164)Di` <dbl>, …
```

```
# tSNE map shows highly responsive population of interest
TsneVis(wand.final,
        "pSTAT5(Nd150)Di.IL7.change",
        "IL7 -> pSTAT5 change")
```

```
## $plot
```

![](data:image/png;base64...)

```
# tSNE map now colored by q value
TsneVis(wand.final,
        "pSTAT5(Nd150)Di.IL7.qvalue",
        "IL7 -> pSTAT5 -log10(qvalue)")
```

```
## $plot
```

![](data:image/png;base64...)

```
# tSNE map colored by KNN density estimation
TsneVis(wand.final, "density")
```

```
## $plot
```

![](data:image/png;base64...)

### Subsampling your data prior to running t-SNE:

If one has a large number of cells in the dataset (>100K), then t-SNE can become time-consuming and produce results that are less clean. As such, I provide a wrapper that allows one to subsample the final data and run t-SNE on the subsampled data, producing a new tibble that contains the subsampled data along with two t-SNE dimensions added to it. Note the two added dimensions at the end of the tibble are called “bh-SNE11” and “bh-SNE21”. This is because the dimensions “bh-SNE1” and “bh-SNE2” are already in the data, because t-SNE was run during the post processing step in this example. As I have stated, a user would realistically use this function with a much larger number of cells, in which case the user would have selected “tsne = FALSE” in the post.processing function detailed above in this vignette.

```
wand.final.sub <- SubsampleAndTsne(dat = wand.final,
                                   input = input.markers,
                                   numcells = 500)
```

```
## Read the 500 x 27 data matrix successfully!
## OpenMP is working. 1 threads.
## Using no_dims = 2, perplexity = 30.000000, and theta = 0.500000
## Computing input similarities...
## Building tree...
## Done in 0.05 seconds (sparsity = 0.235976)!
## Learning embedding...
## Iteration 50: error is 54.569298 (50 iterations in 0.10 seconds)
## Iteration 100: error is 53.386649 (50 iterations in 0.09 seconds)
## Iteration 150: error is 53.165068 (50 iterations in 0.09 seconds)
## Iteration 200: error is 53.085755 (50 iterations in 0.09 seconds)
## Iteration 250: error is 53.060096 (50 iterations in 0.10 seconds)
## Iteration 300: error is 0.898479 (50 iterations in 0.07 seconds)
## Iteration 350: error is 0.837935 (50 iterations in 0.06 seconds)
## Iteration 400: error is 0.821827 (50 iterations in 0.06 seconds)
## Iteration 450: error is 0.815230 (50 iterations in 0.06 seconds)
## Iteration 500: error is 0.808767 (50 iterations in 0.06 seconds)
## Iteration 550: error is 0.804101 (50 iterations in 0.06 seconds)
## Iteration 600: error is 0.802081 (50 iterations in 0.06 seconds)
## Iteration 650: error is 0.800514 (50 iterations in 0.06 seconds)
## Iteration 700: error is 0.797337 (50 iterations in 0.06 seconds)
## Iteration 750: error is 0.795689 (50 iterations in 0.06 seconds)
## Iteration 800: error is 0.794641 (50 iterations in 0.07 seconds)
## Iteration 850: error is 0.793318 (50 iterations in 0.07 seconds)
## Iteration 900: error is 0.792849 (50 iterations in 0.07 seconds)
## Iteration 950: error is 0.792311 (50 iterations in 0.07 seconds)
## Iteration 1000: error is 0.790746 (50 iterations in 0.07 seconds)
## Fitting performed in 1.44 seconds.
```

```
wand.final.sub
```

```
## # A tibble: 500 × 89
##    `CD3(Cd110)Di` `CD3(Cd111)Di` `CD3(Cd112)Di` `CD235-61-7-15(In113)Di`
##             <dbl>          <dbl>          <dbl>                    <dbl>
##  1        -0.632         -0.155        -0.152                     -1.24
##  2         0.0745        -0.523        -0.316                      0.207
##  3         0.909          2.30          1.62                       0.822
##  4        -0.364         -0.535        -0.490                     -0.698
##  5        -0.209         -0.144        -0.00255                   -0.616
##  6         0.152          0.384         0.702                      0.529
##  7        -0.350         -0.0394       -0.0823                    -0.213
##  8         0.746         -0.950        -1.97                      -1.79
##  9        -0.460         -0.201        -0.460                     -0.741
## 10        -0.158         -0.0301        0.437                     -0.222
## # ℹ 490 more rows
## # ℹ 85 more variables: `CD3(Cd114)Di` <dbl>, `CD45(In115)Di` <dbl>,
## #   `CD19(Nd142)Di` <dbl>, `CD22(Nd143)Di` <dbl>, `IgD(Nd145)Di` <dbl>,
## #   `CD79b(Nd146)Di` <dbl>, `CD20(Sm147)Di` <dbl>, `CD34(Nd148)Di` <dbl>,
## #   `CD179a(Sm149)Di` <dbl>, `CD72(Eu151)Di` <dbl>, `IgM(Eu153)Di` <dbl>,
## #   `Kappa(Sm154)Di` <dbl>, `CD10(Gd156)Di` <dbl>, `Lambda(Gd157)Di` <dbl>,
## #   `CD24(Dy161)Di` <dbl>, `TdT(Dy163)Di` <dbl>, `Rag1(Dy164)Di` <dbl>, …
```