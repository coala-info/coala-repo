# regioneReloaded

Roberto Malinverni

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
  + [1.1 regioneR and regioneReloaded](#regioner-and-regionereloaded)
  + [1.2 Normalized Z-Score](#normalized-z-score)
* [2 Installation](#installation)
* [3 Quick start](#quick-start)
* [4 Example dataset: the Alien Genome](#example-dataset-the-alien-genome)
* [5 Multi Permutation Test with regioneReloaded](#multi-permutation-test-with-regionereloaded)
  + [5.1 Crosswise Analysis and the genoMatriXeR object](#crosswise-analysis-and-the-genomatrixer-object)
    - [5.1.1 Parameters](#parameters)
    - [5.1.2 multiOverlaps](#multioverlaps)
    - [5.1.3 Matrix](#matrix)
  + [5.2 Evaluation functions](#evaluation-functions)
  + [5.3 Randomization functions](#randomization-functions)
  + [5.4 Matrix Calculation and visualization](#matrix-calculation-and-visualization)
  + [5.5 Plot Single permutation test](#plot-single-permutation-test)
  + [5.6 Plot Dimensionality Reduction](#plot-dimensionality-reduction)
* [6 Multi Local Zscore](#multi-local-zscore)
* [7 Analyses of non-square matrices](#analyses-of-non-square-matrices)
* [8 Session Info](#session-info)

# 1 Introduction

In genetic and epigenetic research, high-throughput sequencing methods generate large amounts of data. The meaningful interpretation is one of the biggest challenges when analyzing multiple genomic datasets.

Sequencing results can be summarized as ‘region sets’: a list of genomic regions defined by specific coordinates in a reference genome. This is true for all frequently used epigenomic methods such as chromatin immuprecipation (ChIP)-seq, CUT&RUN, DNA-methylation profiling and chromosome conformation capture-based methods. Genome-sequencing studies provide information on mutations, copy number variations and inversions that can be expressed as region sets. Transcriptomic data can be converted in region sets for instance by extracting the genomic position of differentially expressed genes or their regulatory elements. All regions can be further associated with metadata further characterizing them. Any annotated feature of interest in the genome itself, such as repetitive elements, conserved regions, or regulatory elements, can be chosen as regions set for further analysis.

To interpret the meaning of overlaps between regions sets, in 2015 we published *[regioneR](https://bioconductor.org/packages/3.22/regioneR)*, an R package developed for the statistical evaluation of the association between sets of genomic regions. The main limitation of regioneR was that it can only perform pairwise association analysis. The resulting association value (“z-score”) of different pairwise analyses could not be directly compared since z-scores depend on the size and nature of the input region sets. When scaling up the number of pairwise comparisons of larger data sets, the required increase in calculation time becomes a serious limitation.

To address these issues, we now present *regioneReloaded*: an R package that is the logically designed evolution of *[regioneR](https://bioconductor.org/packages/3.22/regioneR)* allowing to calculate the statistical association between multiple regions sets at the same time. *regionReloaded* comprises a set of functions created to analyze clusters of associations and to facilitate the interpretation of results. Importantly, it includes strategies to improve p-value calculations and provides normalized z-scores allowing the direct comparison of multiple analysis. It also builds upon *[regioneR](https://bioconductor.org/packages/3.22/regioneR)* by adding new plotting functions for obtaining publication-ready graphs.

Taken together, *regioneReloaded*, aims to be a novel and valuable addition to the repertoire of available tools in the Bioconductor repository for the analysis of high-content genomic datasets.

## 1.1 regioneR and regioneReloaded

*[regioneR](https://bioconductor.org/packages/3.22/regioneR)* is an R package published in 2015 created to statistically test the positional association between genomic region sets. The core of *[regioneR](https://bioconductor.org/packages/3.22/regioneR)* is a permutation test framework specifically designed to work in a genomic environment. For a detailed insight into the permutation test strategy implemented in *[regioneR](https://bioconductor.org/packages/3.22/regioneR)*, including the different randomization and evaluation strategies, please see the [regioneR vignette](https://bioconductor.org/packages/release/bioc/vignettes/regioneR/inst/doc/regioneR.html). The two main results that can be obtained with this statistical method can be summarized in two graphs. Figure 1A shows the association observed between the two region sets under study, highlighting the distance calculated in standard deviations from the random distribution. Figure 1B shows the local z-score: a narrow peak, as the one shown, indicates that the association is highly dependent on the exact location of the region. One the contrary, a flat profile would suggest a regional association.

(figure 1)

![](data:image/png;base64...)

regioneR basic Graphs

## 1.2 Normalized Z-Score

*regioneReloaded* aims to integrate the framework previously developed for *[regioneR](https://bioconductor.org/packages/3.22/regioneR)* to calculate associations of different region sets simultaneously. However, the values of z-score obtained in different tests can not be directly compared. In particular, the value of the z-score is directly associated to the square root of the number of regions present in the first region set of the test (RS1).

To compare the z-scores obtained in multi pairwise tests between region sets, we introduce the concept of **normalized z-score**, which allows not only to directly compare different association events but also to work with subsets of data and speed up the calculations.

The normalized z-score is calculated as follows:

nZS = ZS / \(\sqrt{n}\)

We can empirically evaluate how the value of z-score between two well known strongly associated proteins, CTCF (ENCFF237OKO) and RAD21 (ENCFF072UEX) in HepG2 cell line from ENCODE portal, (Sloan et al. 2016, <https://www.encodeproject.org/>) , increases with the number of regions included in the test. On the other hand, the value of the normalized z-score is much more stable with different number of regions. Importantly, we see that the value of normalized z-score is stable approximately after including only 30% of the regions in the dataset. This demonstrates than sampling a portion of the dataset is a viable strategy to reduce calculation time without impacting the capacity to obtain meaningful normalized z-score values.

![](data:image/png;base64...)

Normal z-score empirical calculations

Another crucial factor for the calculation of the normal z-score is the number of permutations performed in the test (`ntimes`). We suggest to use a minimum of 5000 permutations to achieve reproducible results.

![](data:image/png;base64...)

Ntimes demonstration

# 2 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("regioneReloaded")
```

# 3 Quick start

```
library("regioneReloaded")
#> Loading required package: regioneR
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
```

The permutation test can be performed on a list multiple region sets by the function `crosswisePermTest()`. This process is computing intensive and its calculation time depends on the number of cores called by the parameter `mc.cores` (see *[regioneR](https://bioconductor.org/packages/3.22/regioneR)*). The result of the permutation test obtained by running the code below is included as a pre-computed example dataset which can be loaded into the environment by running the command `data("cw_Alien_RaR")`.

`AlienGenome` and `AlienRSList` are toy datasets described in the next section of the vignette.

```
#NOT RUN

  set.seed(42)
  cw_Alien_ReG<-crosswisePermTest(Alist = AlienRSList_narrow,
                            sampling = FALSE,
                            mc.cores= 25,
                            ranFUN = "resampleGenome",
                            evFUN = "numOverlaps",
                            genome = AlienGenome,
                            ntimes= 1000
  )
#
```

Once the multiple permutation tests are performed, we can generate a matrix of pairwise associations between the region sets with the function `makeCrosswiseMatrix()` and visualize it with `plotCrosswiseMatrix()`.

```
data("cw_Alien")

cw_Alien_ReG<-makeCrosswiseMatrix(cw_Alien_ReG, pvcut = 1)
#> [1] "method selected for hclustering: average"
#>  complete   average    single   ward.D2    median  centroid  mcquitty
#> 0.7497654 0.7857181 0.6514804 0.7363304 0.3459672 0.4561003 0.7516609

plotCrosswiseMatrix(cw_Alien_ReG)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the regioneReloaded package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

# 4 Example dataset: the Alien Genome

Performing Permutation tests with region sets on an eukaryotic genome can take a long computation time. To demonstrate the different regionReloaded features on a small toy dataset with low computation times, we have created a fake genome called the ‘AlienGenome’ and an associated list of region sets. The Alien Genome consists of four chromosomes of lengths ranging from 2Mb to 0.1Mb.

![](data:image/png;base64...)

Graphical descrition of the AlienGenome

```
AlienGenome <-
  toGRanges(data.frame(
    chr = c("AlChr1", "AlChr2", "AlChr3", "AlChr4"),
    start = c(rep(1, 4)),
    end = c(2e6, 1e6, 5e5, 1e5)
  ))
```

Four basic region sets were created on this genome. The first three (“regA”, “regB”, “regC”), were created using the function `createRandomRegions()` from the package *[regioneR](https://bioconductor.org/packages/3.22/regioneR)*. Each region set consists of 100 regions with an average width of 100 bp (and a standard deviation of 50 bp). Being randomly generated, the three region sets should show no significant associations with each other.

```
gnm <- AlienGenome

nreg=100

regA <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = gnm
  )

regB <-
  createRandomRegions(
    nregions = nreg,
    length.mean =  100,
    length.sd = 50 ,
    non.overlapping = TRUE,
    genome = gnm
  )

regC <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = gnm
  )
```

To generate “artificial” associations we can use the `similarRegionSet()` function, which produces sets of random regions with some degree of similarity to the original input region set. For each set of regions regA, regB and regC, we create a list of region sets that share a percentage (90% to 10%) of similarity with the original set.

```
vectorPerc <- seq(0.1, 0.9, 0.1)

RsetA <-
  similarRegionSet(
    GR = regA,
    name = "regA",
    genome = gnm,
    vectorPerc = vectorPerc
  )
RsetB <-
  similarRegionSet(
    GR = regB,
    name = "regB",
    genome = gnm,
    vectorPerc = vectorPerc
  )
RsetC <-
  similarRegionSet(
    GR = regC,
    name = "regC",
    genome = gnm,
    vectorPerc = vectorPerc
  )
```

Next we create a region set of 100 regions that shares half the regions with regA and half with regB called regAB. From this region set we create similar region sets again using `similarRegionSet()`.

```
vectorPerc2 <- seq(0.2, 0.8, 0.2)
regAB <- c(sample(regA, nreg / 2), sample(regB, nreg / 2))
RsetAB <-
  similarRegionSet(
    GR = regAB,
    name = "regAB",
    genome = gnm,
    vectorPerc = vectorPerc2
  )
```

As a negative association control, we create random region sets that contain no regions of “regA”, “regB”, “regC”, “regAB or”regABC" using `createRandomRegions()` and `substractRegions()` functions from *[regioneR](https://bioconductor.org/packages/3.22/regioneR)*.

```
reg_no_A <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = subtractRegions(gnm, regA)
  )

reg_no_B <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = subtractRegions(gnm, regB)
  )

reg_no_C <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = subtractRegions(gnm, regC)
  )

reg_no_AB <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = subtractRegions(gnm, c(regA, regB))
  )

reg_no_ABC <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = subtractRegions(gnm, c(regA, regB, regC))
  )
```

To demonstrate the detection of “lateral” association (association with a region close to the one being tested), we create the “regD” region set. It is composed of regions in the vicinity of region set “regA” but does not overlap with the regions of “regA” itself.

```
dst <- sample(c(-300,300),length(regA),replace = TRUE)
regD <- regioneR::toGRanges(
                    data.frame(
                      chr=as.vector(GenomeInfoDb::seqnames(regA)),
                      start = start(regA) + dst,
                      end = end (regA) + dst
                      )
                    )

RsetD <-
  similarRegionSet(
    GR = regD,
    name = "regD",
    genome = gnm,
    vectorPerc = vectorPerc2
  )
```

Finally, we store all the generated sets of regions in a list called `AlienRSList` which we can use as input for the `crosswisePermTest()` function to perform the multiple permutation test.

```
Rset_NO <- list(reg_no_A, reg_no_B, reg_no_C, reg_no_AB, reg_no_ABC)

names(Rset_NO) <- c("reg_no_A", "reg_no_B", "reg_no_C", "reg_no_AB", "reg_no_ABC")

AlienRSList_narrow <- c(RsetA, RsetB, RsetC, RsetD, RsetAB, Rset_NO)

summary(AlienRSList_narrow)
#>            Length Class   Mode
#> regA_01    100    GRanges S4
#> regA_02    100    GRanges S4
#> regA_03    100    GRanges S4
#> regA_04    100    GRanges S4
#> regA_05    100    GRanges S4
#> regA_06    100    GRanges S4
#> regA_07    100    GRanges S4
#> regA_08    100    GRanges S4
#> regA_09    100    GRanges S4
#> regA       100    GRanges S4
#> regB_01    100    GRanges S4
#> regB_02    100    GRanges S4
#> regB_03    100    GRanges S4
#> regB_04    100    GRanges S4
#> regB_05    100    GRanges S4
#> regB_06    100    GRanges S4
#> regB_07    100    GRanges S4
#> regB_08    100    GRanges S4
#> regB_09    100    GRanges S4
#> regB       100    GRanges S4
#> regC_01    100    GRanges S4
#> regC_02    100    GRanges S4
#> regC_03    100    GRanges S4
#> regC_04    100    GRanges S4
#> regC_05    100    GRanges S4
#> regC_06    100    GRanges S4
#> regC_07    100    GRanges S4
#> regC_08    100    GRanges S4
#> regC_09    100    GRanges S4
#> regC       100    GRanges S4
#> regD_02    100    GRanges S4
#> regD_04    100    GRanges S4
#> regD_06    100    GRanges S4
#> regD_08    100    GRanges S4
#> regD       100    GRanges S4
#> regAB_02   100    GRanges S4
#> regAB_04   100    GRanges S4
#> regAB_06   100    GRanges S4
#> regAB_08   100    GRanges S4
#> regAB      100    GRanges S4
#> reg_no_A   100    GRanges S4
#> reg_no_B   100    GRanges S4
#> reg_no_C   100    GRanges S4
#> reg_no_AB  100    GRanges S4
#> reg_no_ABC 100    GRanges S4
```

# 5 Multi Permutation Test with regioneReloaded

## 5.1 Crosswise Analysis and the genoMatriXeR object

`crosswisePermTest()` is the main statistical function of the package. “Crosswise” analysis (in contrast to “pairwise”) refers to the calculation of permutation tests between all possible combinations of elements in a first list of region sets (`Alist`) with those in a second list (`Blist`). The core statistical calculations of the permutation tests rely on [permTest()](https://rdrr.io/bioc/regioneR/man/permTest.html).

The result of `crosswisePermTest()` is stored in an S4 object of class `genoMatriXeR` that contains three slots: *parameters*, *multiOverlaps* and *matrix*.

* gMXR\_obj
  + @parameters
    - Alist
    - Blist
    - sampling
    - fraction
    - min\_sampling
    - ranFUN
    - evFUN
    - universe
    - adj\_pv\_method
    - max\_pv
    - nc
    - matOrder
    - ntimes
  + @multiOverlaps
    - one field for each comparison
  + @matrix
    - GMat
    - GMat\_pv
    - GMat\_corX
    - GMat\_corY
    - FitRow
    - FitCol

### 5.1.1 Parameters

The slot “parameters” stores all the parameters that were used to obtain the `genoMatriXeR` object and can be retrieved with `getParameters()`.

```
data("cw_Alien")
getParameters(cw_Alien_ReG)
#>        parameter              value
#> 1          Alist AlienRSList_narrow
#> 2          Blist AlienRSList_narrow
#> 3       sampling              FALSE
#> 4       fraction               0.15
#> 5   min_sampling               0.15
#> 6         ranFUN     resampleGenome
#> 7          evFUN        numOverlaps
#> 8         ntimes               1000
#> 9       universe               NULL
#> 10 adj_pv_method                 BH
#> 11            nc               NULL
#> 12      matOrder               NULL
```

### 5.1.2 multiOverlaps

The “multiOverlaps” slot contains a list of data frames that contain the results of each permutation test performed. For each region set in “Alist”, a data frame is generated with 11 columns and a number of rows equal to the elements in “Blist”. The columns of the data frame contain the following information:

* **order.id:** order of comparison
* **name:** name of region sets in Blist
* **n\_regionA:** number of permuted Alist regions
* **n\_regionB:** number of regions in each regions set of Blist
* **z\_score:** z-score calculated by [permTest](https://rdrr.io/bioc/regioneR/man/permTest.html)
* **p\_value:** p.value calculated by [permTest](https://rdrr.io/bioc/regioneR/man/permTest.html)
* **n\_hits:** number of hits computed using the evaluation function on a regions set of Alist versus each regions set of Blists
* **mean\_perm\_test:** mean of hits computed using the evaluation function on the permutated region set
* **sd\_perm\_test:** standard deviation of hits computed using the evaluation function on the permutated region set
* **norm\_zscore:** normalized z-scores
* **adj\_p\_value:** adjusted p.value

### 5.1.3 Matrix

When the genoMatriXeR object is initially created by running `crosswisePermTest()`, the “matrix” slot will have a NULL value. See the section [Matrix calculation and visualization](#matrix-calculation-and-visualization) on how to generate, access and visualize the association matrix.

## 5.2 Evaluation functions

*regioneReloaded* can use all the evaluation strategies present in *[regioneR](https://bioconductor.org/packages/3.22/regioneR)*, and it also allows the use of custom evaluation functions. The examples considered by this vignette will be based on the default evaluation function `numOverlaps()`.

## 5.3 Randomization functions

*regioneReloaded* can use all the randomization strategies present in *[regioneR](https://bioconductor.org/packages/3.22/regioneR)* and it also allows the use of custom functions.

A notable difference with regioneR is that the randomization function `resampleRegions()` can work without the presence of the parameter “universe”. In this case a “universe” will be created by using all regions from the list of regions set “Alist” using the function `createUniverse()`. Three example pre-computed objects are included as sample data generated with three different randomization functions: “randomizeRegions”, “resampleRegions” and “resampleGenome”.

```
#NOT RUN

set.seed(42)
cw_Alien_RaR <-  crosswisePermTest(
  Alist = AlienRSList_narrow,
  Blist = AlienRSList_narrow,
  sampling = FALSE,
  genome = AlienGenome,
  per.chromosome=TRUE,
  ranFUN = "randomizeRegions",
  evFUN = "numOverlaps",
  ntimes= 1000,
  mc.cores = 20
)

set.seed(42)
cw_Alien_ReR <-  crosswisePermTest(
  Alist = AlienRSList_narrow,
  Blist = AlienRSList_narrow,
  sampling = FALSE,
  genome = AlienGenome,
  per.chromosome=TRUE,
  ranFUN = "resampleRegions",
  evFUN = "numOverlaps",
  ntimes= 1000,
  mc.cores = 20
)

set.seed(42)
cw_Alien_ReG <-  crosswisePermTest(
  Alist = AlienRSList_narrow,
  Blist = AlienRSList_narrow,
  sampling = FALSE,
  genome = AlienGenome,
  per.chromosome=TRUE,
  ranFUN = "resampleGenome",
  evFUN = "numOverlaps",
  ntimes= 100,
  mc.cores = 20
)

#
```

## 5.4 Matrix Calculation and visualization

Association matrix will be computed with the function `makeCrosswiseMatrix()`. This function returns a *genoMatriXeR* object with the matrix assigned to the “matrix” slot, the matrix will be able to be queried with the `getMatrix()` function. As a default value the matrix will be created using *normalized z-score* for a more in-depth description of the parameters that can be used to create the matrix we refer you to the `makeCrosswiseMatrix()` function manual. If no clustering method is chosen, automatically the most efficient clustering method will be chosen from those in [hclust](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/hclust), as described in the `chooseHclustMet()` function manual.

```
cw_Alien_RaR <- makeCrosswiseMatrix(cw_Alien_RaR)
#> [1] "method selected for hclustering: average"
#>  complete   average    single   ward.D2    median  centroid  mcquitty
#> 0.7592340 0.7805803 0.6610466 0.7222423 0.0402856 0.5192172 0.7231580

cw_Alien_ReG <- makeCrosswiseMatrix(cw_Alien_ReG)
#> [1] "method selected for hclustering: average"
#>  complete   average    single   ward.D2    median  centroid  mcquitty
#> 0.7497654 0.7857181 0.6514804 0.7363304 0.3459672 0.4561003 0.7516609

cw_Alien_ReR <- makeCrosswiseMatrix(cw_Alien_ReR)
#> [1] "method selected for hclustering: average"
#>  complete   average    single   ward.D2    median  centroid  mcquitty
#> 0.7515325 0.7716179 0.6542890 0.7136237 0.2223408 0.5618311 0.7245865
```

To compare the output of the matrices created with different randomization functions, we need to use the fixed order of clusterization for all matrices.

```
modX <- getHClust(cw_Alien_ReG,hctype = "rows")
modY <- getHClust(cw_Alien_ReG,hctype = "cols")

X<-modX$labels[modX$order]
Y<-modY$labels[modX$order]

ord<-list(X=X,Y=Y)

p_ReG <- plotCrosswiseMatrix(cw_Alien_ReG, matrix_type = "association", ord_mat = ord)
p_ReR <- plotCrosswiseMatrix(cw_Alien_ReR, matrix_type = "association", ord_mat = ord)

plot(p_ReG)
```

![](data:image/png;base64...)

```
plot(p_ReR)
```

![](data:image/png;base64...)

`getHClust()` function returns an object of class [hclust](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/hclust) that you can use for further analysis.

```
plot(modX,cex = 0.8)
```

![](data:image/png;base64...)

the *matrix\_type* parameter `plotCrosswiseMatrix()` allows to choose between “association” matrix (where the z-score value obtained from the permutation test calculation will be shown), or “correlation” (where the Pearson’s R-value between each Regions Set will be used).

```
p_ReG_cor <- plotCrosswiseMatrix(cw_Alien_ReG, matrix_type = "correlation", ord_mat = ord)
# p_ReR_cor <- plotCrosswiseMatrix(cw_Alien_ReR, matrix_type = "correlation", ord_mat = ord)

plot(p_ReG_cor)
```

![](data:image/png;base64...)

```
# plot(p_ReR_cor)
```

## 5.5 Plot Single permutation test

*regioneReloaded* allows us to extract and visualize the results of a single Region Sets comparison, the visualization resumes the previous graphs in *[regioneR](https://bioconductor.org/packages/3.22/regioneR)* by exploiting the power of *[ggplot2](https://bioconductor.org/packages/3.22/ggplot2)*.

```
plotSinglePT(cw_Alien_ReG, RS1 = "regA", RS2 = "regA_05")
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the regioneReloaded package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the regioneReloaded package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the regioneReloaded package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning in ggplot2::geom_segment(ggplot2::aes(x = mean.1, y = max_curve/2, : All aesthetics have length 1, but the data has 2 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
```

![](data:image/png;base64...)

```
  p_sPT1 <- plotSinglePT(cw_Alien_ReG, RS1 = "regA", RS2 = "regC")

plot(p_sPT1)
#> Warning in ggplot2::geom_segment(ggplot2::aes(x = mean.1, y = max_curve/2, : All aesthetics have length 1, but the data has 2 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
```

![](data:image/png;base64...)

## 5.6 Plot Dimensionality Reduction

Dimensionality reduction refers to a strategy capable of representing complex (high-density) data in a low-density space while retaining some meaningful properties of the original data. The plotCrosswiseDimRes function allows three of the most widely used algorithms (PCA, tRSNE, UMAP) to be applied to represent genoMatriXeR objects.

```
set.seed(42)

plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="PCA")
#> Warning: The following aesthetics were dropped during statistical transformation: label.
#> ℹ This can happen when ggplot fails to infer the correct grouping structure in
#>   the data.
#> ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
#>   variable into a factor?
```

![](data:image/png;base64...)

The data is clustered using a clustering algorithm that can be selected from (`hclust`, `kmeans` or `pam` ), giving the possibility of importing an external clustering method.

```
set.seed(42)
p_cdr_hc <- plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="PCA", clust_met = "hclust")

# set.seed(42)
# p_cdr_pam <- plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="PCA", clust_met = "pam")

plot(p_cdr_hc)
#> Warning: The following aesthetics were dropped during statistical transformation: label.
#> ℹ This can happen when ggplot fails to infer the correct grouping structure in
#>   the data.
#> ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
#>   variable into a factor?
```

![](data:image/png;base64...)

```
# plot(p_cdr_pam)
```

The parameters *listRS* and *emphasize* were added to emphasise the data found to be interesting.

```
lsRegSet<-list(regA="regA",regB="regB",regC="regC")

set.seed(42)
plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="PCA",listRS = lsRegSet)
#> Warning: The following aesthetics were dropped during statistical transformation: label.
#> ℹ This can happen when ggplot fails to infer the correct grouping structure in
#>   the data.
#> ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
#>   variable into a factor?
```

![](data:image/png;base64...)

```
set.seed(42)
plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="PCA",listRS = lsRegSet,ellipse = TRUE, emphasize =TRUE)
#> Warning: The following aesthetics were dropped during statistical transformation: label.
#> ℹ This can happen when ggplot fails to infer the correct grouping structure in
#>   the data.
#> ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
#>   variable into a factor?
```

![](data:image/png;base64...)

```
set.seed(67)
plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="tSNE",listRS = lsRegSet,ellipse = TRUE, emphasize =TRUE)
#> Warning: The following aesthetics were dropped during statistical transformation: label.
#> ℹ This can happen when ggplot fails to infer the correct grouping structure in
#>   the data.
#> ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
#>   variable into a factor?
```

![](data:image/png;base64...)

```
set.seed(67)
plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="UMAP",listRS = lsRegSet,ellipse = TRUE, emphasize =TRUE)
#> Warning: The following aesthetics were dropped during statistical transformation: label.
#> ℹ This can happen when ggplot fails to infer the correct grouping structure in
#>   the data.
#> ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
#>   variable into a factor?
```

![](data:image/png;base64...)
The \* return\_table\* parameter displays a table summarising the results of the clustering, incorporating the value *ASW* total mean of individual silhouette widths [silohuette](https://www.rdocumentation.org/packages/cluster/versions/2.1.3/topics/silhouette).

```
set.seed(67)
silTable <- plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="UMAP",listRS = lsRegSet,return_table = TRUE)
#> Warning: The following aesthetics were dropped during statistical transformation: label.
#> ℹ This can happen when ggplot fails to infer the correct grouping structure in
#>   the data.
#> ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
#>   variable into a factor?
```

![](data:image/png;base64...)

```
silTable
#>          Name Cluster       ASW
#> 1    regAB_08 clust_1 0.0871640
#> 2     regC_08 clust_1 0.0871640
#> 3     regC_07 clust_1 0.0871640
#> 4     regA_08 clust_1 0.0871640
#> 5     regC_09 clust_1 0.0871640
#> 6     regB_09 clust_1 0.0871640
#> 7    reg_no_B clust_1 0.0871640
#> 8     regA_09 clust_1 0.0871640
#> 9   reg_no_AB clust_1 0.0871640
#> 10   reg_no_C clust_1 0.0871640
#> 11 reg_no_ABC clust_1 0.0871640
#> 12   reg_no_A clust_1 0.0871640
#> 13   regAB_06 clust_2 0.3365061
#> 14   regAB_04 clust_2 0.3365061
#> 15      regAB clust_2 0.3365061
#> 16   regAB_02 clust_2 0.3365061
#> 17    regD_08 clust_3 0.3496858
#> 18    regD_06 clust_3 0.3496858
#> 19    regD_04 clust_3 0.3496858
#> 20       regD clust_3 0.3496858
#> 21    regD_02 clust_3 0.3496858
#> 22    regC_06 clust_4 0.4882054
#> 23    regC_05 clust_4 0.4882054
#> 24    regC_04 clust_4 0.4882054
#> 25    regC_03 clust_4 0.4882054
#> 26    regC_02 clust_4 0.4882054
#> 27       regC clust_4 0.4882054
#> 28    regC_01 clust_4 0.4882054
#> 29    regB_05 clust_5 0.2574193
#> 30    regB_04 clust_5 0.2574193
#> 31    regB_03 clust_5 0.2574193
#> 32    regB_02 clust_5 0.2574193
#> 33       regB clust_5 0.2574193
#> 34    regB_01 clust_5 0.2574193
#> 35    regB_08 clust_5 0.2574193
#> 36    regB_07 clust_5 0.2574193
#> 37    regB_06 clust_5 0.2574193
#> 38    regA_07 clust_6 0.3734175
#> 39    regA_06 clust_6 0.3734175
#> 40    regA_05 clust_6 0.3734175
#> 41    regA_04 clust_6 0.3734175
#> 42    regA_03 clust_6 0.3734175
#> 43    regA_02 clust_6 0.3734175
#> 44       regA clust_6 0.3734175
#> 45    regA_01 clust_6 0.3734175
```

# 6 Multi Local Zscore

The [multiLocalZscore] function allows the association of a single regions Set against a list of regions Sets to be analysed by applying the [localZScore](https://rdrr.io/bioc/regioneR/man/localZScore.html) function in a neighbourhood defined by the *window* parameter a number of times defined by the *step* parameter.

```
#NOT RUN
mlz_Alien_ReG<-multiLocalZscore(A = AlienRSList_narrow$regA,
                 Blist = AlienRSList_narrow,
                 ranFUN = "resampleGenome",
                 evFUN = "numOverlaps",
                 window = 100,
                 step = 1,
                 max_pv = 1,
                 genome = AlienGenome)
```

As with the `crosswisePermTest()` function, an object consisting of three slots *paremeters* *multiLocalZscores* and *matrix* will be created. These can be queried by the functions `getParametrs()`, `getMultiEvaluation()` and `getMatrix()` respectively. Again, the object thus created will have the matrix slot = NULL.

```
getParameters(mLZ_regA_ReG)
#>        parameter                   value
#> 1              A AlienRSList_narrow$regA
#> 2          Blist      AlienRSList_narrow
#> 3       sampling                   FALSE
#> 4       fraction                    0.15
#> 5   min_sampling                    0.15
#> 6         ranFUN          resampleGenome
#> 7          evFUN             numOverlaps
#> 8       universe                    NULL
#> 9         window                     600
#> 10          step                      10
#> 11 adj_pv_method                      BH
#> 12        max_pv                    0.05
#> 13      Nregions                     100

mlz_Me <- getMultiEvaluation(rR = mLZ_regA_ReG )

head(mlz_Me$resumeTable)
#>      name     p_value  z_score mean_perm_test sd_perm_test n_overlaps
#> 1 regA_01 0.000999001 115.5593          0.576    0.7738364         90
#> 2 regA_02 0.000999001 104.9830          0.559    0.7662285         81
#> 3 regA_03 0.000999001  91.9693          0.568    0.7549476         70
#> 4 regA_04 0.000999001  79.3280          0.555    0.7493574         60
#> 5 regA_05 0.000999001  65.0379          0.598    0.7595874         50
#> 6 regA_06 0.000999001  52.3927          0.600    0.7710996         41
#>   norm_zscore adj.p_value
#> 1    11.55593       0.003
#> 2    10.49830       0.003
#> 3     9.19693       0.003
#> 4     7.93280       0.003
#> 5     6.50379       0.003
#> 6     5.23927       0.003
```

The matrix will be created by the function `makeLZMatrix()` in a similar manner as illustrated for the function `makeCrosswiseMatrix()`. Again, it is possible to pass a clustering method to the function, and if not, the best clustering function calculated using `chooseHclustMet()` will be chosen.

```
mLZ_regA_ReG <- makeLZMatrix(mLZ_regA_ReG)
#> [1] "method selected for hclustering: complete"
#>  complete   average    single   ward.D2    median  centroid  mcquitty
#> 0.9098230 0.8541174 0.7986368 0.8320493 0.8348816 0.8510903 0.8475492
#> [1] "method selected for hclustering: average"
#>  complete   average    single   ward.D2    median  centroid  mcquitty
#> 0.8909663 0.8944326 0.7892161 0.8311822 0.8813696 0.8857083 0.8784679

plot(getHClust(mLZ_regA_ReG),cex = 0.8)
```

![](data:image/png;base64...)
The `plotLocalZScoreMatrix()` function allows the visualisation of an object of class *multilocalZScore*. This type of visualization will also allow the association to be tested in the area adjacent to the tested Region Set.

```
plotLocalZScoreMatrix(mLZ_regA_ReG, maxVal = "max")
```

![](data:image/png;base64...)
## Single Local ZScore

Similarly to as seen above for the `plotSinglePT()` function, the `plotSingleLZ()` function allows us to specifically display single associations drawn from a *multiLocalZScore* object.

```
plotSingleLZ(mLZ = mLZ_regA_ReG, RS =c("regA"), smoothing = TRUE)
```

![](data:image/png;base64...)

It is also possible to simultaneously display multiple associations in the same graph by introducing a vector of region set names

```
plotSingleLZ(mLZ = mLZ_regA_ReG,RS =c("regA","regA_02","regA_06","regA_08","regD"),smoothing = TRUE)
```

![](data:image/png;base64...)

# 7 Analyses of non-square matrices

*regioneReloaded* allows the association of Regions Sets of any length to be calculated. *AlienRSList\_broad* is a list of Region Set created from *AlienRSList\_narrow*, in which the [extendRegions](https://rdrr.io/bioc/regioneR/man/extendRegions.html) function has increased the width to an average of 5kb, to complete *AlienRSList\_broad* a set of random region sets was added (RegR).

```
# average of the widths of AlienRSList_narrow
do.call("c",lapply(lapply(AlienRSList_narrow, width),mean))
#>    regA_01    regA_02    regA_03    regA_04    regA_05    regA_06    regA_07
#>     104.05     104.05     104.05     104.05     104.05     104.05     104.05
#>    regA_08    regA_09       regA    regB_01    regB_02    regB_03    regB_04
#>     104.05     104.05     104.05      99.26      99.26      99.26      99.26
#>    regB_05    regB_06    regB_07    regB_08    regB_09       regB    regC_01
#>      99.26      99.26      99.26      99.26      99.26      99.26     101.46
#>    regC_02    regC_03    regC_04    regC_05    regC_06    regC_07    regC_08
#>     101.46     101.46     101.46     101.46     101.46     101.46     101.46
#>    regC_09       regC    regD_02    regD_04    regD_06    regD_08       regD
#>     101.46     101.46     104.05     104.05     104.05     104.05     104.05
#>   regAB_02   regAB_04   regAB_06   regAB_08      regAB   reg_no_A   reg_no_B
#>      98.48      98.48      98.48      98.48      98.48     104.79     101.69
#>   reg_no_C  reg_no_AB reg_no_ABC
#>     102.93     102.54      94.02
# average of the widths of AlienRSList_broad
do.call("c",lapply(lapply(AlienRSList_broad, width),mean))
#> regA_br_02 regA_br_04 regA_br_06 regA_br_08    regA_br regB_br_02 regB_br_04
#>    5104.05    5104.05    5104.05    5104.05    5104.05    5099.26    5099.26
#> regB_br_06 regB_br_08    regB_br regC_br_02 regC_br_04 regC_br_06 regC_br_08
#>    5099.26    5099.26    5099.26    5101.46    5101.46    5101.46    5101.46
#>    regC_br regD_br_02 regD_br_04 regD_br_06 regD_br_08    regD_br regR_br_02
#>    5101.46    5104.05    5104.05    5104.05    5104.05    5104.05    5023.83
#> regR_br_04 regR_br_06 regR_br_08    regR_br
#>    5023.83    5023.83    5023.83    5023.83
```

```
##NOT RUN
cw_Alien_RaR_no_Square <-  crosswisePermTest(
  Alist = AlienRSList_narrow,
  Blist = AlienRSList_broad,
  sampling = FALSE,
  genome = AlienGenome,
  per.chromosome=TRUE,
  ranFUN = "resampleGenome",
  evFUN = "numOverlaps",
  ntimes= 100,
  mc.cores = 6
)

###
```

the matrix calculated in this case is based on a double clustering of rows and columns

```
cw_Alien_ReG_no_Square <- makeCrosswiseMatrix(cw_Alien_ReG_no_Square)
#> Warning in makeCrosswiseMatrix(cw_Alien_ReG_no_Square): impossible to create
#> symmetrical matrix, number of columns is different from number of rows
#> [1] "method selected for hclustering: average"
#>  complete   average    single   ward.D2    median  centroid  mcquitty
#> 0.7848737 0.7898638 0.7125290 0.7639944 0.7359119 0.7656280 0.7740310
#> [1] "method selected for hclustering: complete"
#>  complete   average    single   ward.D2    median  centroid  mcquitty
#> 0.7582517 0.7077825 0.4051347 0.6923967 0.7266403 0.7205035 0.7558722

plotCrosswiseMatrix(cw_Alien_ReG_no_Square)
```

![](data:image/png;base64...)

In this case, the `multiLocalZscore()` function works in exactly the same way as in the previous cases, but in order to see the form of the association, it is recommended to enlarge *window* parameter.

```
#NOT RUN
mLZ_regA_ReG_br<-multiLocalZscore(A =
                                    AlienRSList_narrow$regA,
                                  Blist = AlienRSList_broad,
                                  ranFUN = "resampleGenome",
                                  genome = AlienGenome,
                                  window = 5000,
                                  step =100)
##
```

```
mLZ_regA_ReG_br<-makeLZMatrix(mLZ_regA_ReG_br)
#> [1] "method selected for hclustering: average"
#>  complete   average    single   ward.D2    median  centroid  mcquitty
#> 0.8736273 0.8783594 0.8460795 0.8706955 0.8744848 0.8776389 0.8773126
#> [1] "method selected for hclustering: average"
#>  complete   average    single   ward.D2    median  centroid  mcquitty
#> 0.9348281 0.9374008 0.9133837 0.9153168 0.8793742 0.9256832 0.8900115

plotLocalZScoreMatrix(mLZ_regA_ReG_br)
```

![](data:image/png;base64...)

```
plotSingleLZ(mLZ = mLZ_regA_ReG_br,RS =c("regA_br","regA_br_02","regA_br_06","regA_br_08","regD_br"), smoothing = TRUE)
```

![](data:image/png;base64...)

# 8 Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] regioneReloaded_1.12.0 regioneR_1.42.0        GenomicRanges_1.62.0
#> [4] Seqinfo_1.0.0          IRanges_2.44.0         S4Vectors_0.48.0
#> [7] BiocGenerics_0.56.0    generics_0.1.4         BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1            dplyr_1.1.4
#>  [3] farver_2.1.2                Biostrings_2.78.0
#>  [5] S7_0.2.0                    bitops_1.0-9
#>  [7] fastmap_1.2.0               RCurl_1.98-1.17
#>  [9] GenomicAlignments_1.46.0    XML_3.99-0.19
#> [11] digest_0.6.37               lifecycle_1.0.4
#> [13] cluster_2.1.8.1             magrittr_2.0.4
#> [15] compiler_4.5.1              rlang_1.1.6
#> [17] sass_0.4.10                 tools_4.5.1
#> [19] yaml_2.3.10                 rtracklayer_1.70.0
#> [21] knitr_1.50                  labeling_0.4.3
#> [23] askpass_1.2.1               S4Arrays_1.10.0
#> [25] curl_7.0.0                  reticulate_1.44.0
#> [27] DelayedArray_0.36.0         plyr_1.8.9
#> [29] RColorBrewer_1.1-3          abind_1.4-8
#> [31] BiocParallel_1.44.0         Rtsne_0.17
#> [33] withr_3.0.2                 grid_4.5.1
#> [35] ggplot2_4.0.0               MASS_7.3-65
#> [37] scales_1.4.0                tinytex_0.57
#> [39] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
#> [41] cli_3.6.5                   rmarkdown_2.30
#> [43] crayon_1.5.3                umap_0.2.10.0
#> [45] RSpectra_0.16-2             httr_1.4.7
#> [47] reshape2_1.4.4              rjson_0.2.23
#> [49] cachem_1.1.0                stringr_1.5.2
#> [51] parallel_4.5.1              BiocManager_1.30.26
#> [53] XVector_0.50.0              restfulr_0.0.16
#> [55] matrixStats_1.5.0           vctrs_0.6.5
#> [57] Matrix_1.7-4                jsonlite_2.0.0
#> [59] bookdown_0.45               ggrepel_0.9.6
#> [61] magick_2.9.0                jquerylib_0.1.4
#> [63] glue_1.8.0                  codetools_0.2-20
#> [65] stringi_1.8.7               gtable_0.3.6
#> [67] GenomeInfoDb_1.46.0         BiocIO_1.20.0
#> [69] UCSC.utils_1.6.0            tibble_3.3.0
#> [71] pillar_1.11.1               htmltools_0.5.8.1
#> [73] openssl_2.3.4               BSgenome_1.78.0
#> [75] R6_2.6.1                    evaluate_1.0.5
#> [77] lattice_0.22-7              Biobase_2.70.0
#> [79] png_0.1-8                   Rsamtools_2.26.0
#> [81] cigarillo_1.0.0             memoise_2.0.1
#> [83] bslib_0.9.0                 Rcpp_1.1.0
#> [85] SparseArray_1.10.0          xfun_0.53
#> [87] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```