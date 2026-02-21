# CoGAPS - Coordinated Gene Association in Pattern Sets

Jeanette Johnson, Ashley Tsang, Thomas Sherman, Genevieve Stein-O'Brien, Hyejune Limb, Elana Fertig

#### 29 October 2025

# Contents

* [1 Vignette Version](#vignette-version)
* [2 Introduction](#introduction)
* [3 Software Setup](#software-setup)
* [4 Running CoGAPS on Simulated Toy Data](#running-cogaps-on-simulated-toy-data)
  + [4.1 Analyzing the Toy Data CoGAPS result](#analyzing-the-toy-data-cogaps-result)
* [5 Single-cell CoGAPS](#single-cell-cogaps)
* [6 Analyzing the CoGAPS result](#analyzing-the-cogaps-result)
  + [6.1 Load CoGAPS pattern information into Seurat object](#load-cogaps-pattern-information-into-seurat-object)
  + [6.2 Plot patterns on an embedding](#plot-patterns-on-an-embedding)
* [7 Pattern Markers](#pattern-markers)
  + [7.1 Marker assignment methods](#marker-assignment-methods)
  + [7.2 Axis selection](#axis-selection)
  + [7.3 `patternMarkers()` Output](#patternmarkers-output)
  + [7.4 Example](#example)
* [8 Pattern GSEA](#pattern-gsea)
* [9 Citing CoGAPS](#citing-cogaps)
* [References](#references)

# 1 Vignette Version

This vignette was built using CoGAPS version:

```
packageVersion("CoGAPS")
```

```
## [1] '3.30.0'
```

# 2 Introduction

Coordinated Gene Association in Pattern Sets (CoGAPS) is a technique for
latent space learning in gene expression data. CoGAPS is a member of the
Nonnegative Matrix Factorization (NMF) class of algorithms. NMFs
factorize a data matrix into two related matrices containing gene
weights, the Amplitude (A) matrix, and sample weights, the Pattern (P)
Matrix. Each column of A or row of P defines a feature and together this
set of features defines the latent space among genes and samples,
respectively. In NMF, the values of the elements in the A and P matrices
are constrained to be greater than or equal to zero. This constraint
simultaneously reflects the non-negative nature of gene expression data
and enforces the additive nature of the resulting feature dimensions,
generating solutions that are biologically intuitive to interpret
(Seung and Lee ([1999](#ref-SEUNG_1999))).

# 3 Software Setup

*CoGAPS* can be installed directly from the FertigLab Github Repository
using R devtools or from Bioconductor

```
devtools::install_github("FertigLab/CoGAPS")

# To install via BioConductor:
install.packages("BiocManager")
BiocManager::install("FertigLab/CoGAPS")
```

When CoGAPS has installed correctly, you will see this message:

\*\* installing vignettes

\*\* testing if installed package can be loaded from temporary location

\*\* checking absolute paths in shared objects and dynamic libraries

\*\* testing if installed package can be loaded from final location

\*\* testing if installed package keeps a record of temporary
installation path

\* DONE (CoGAPS)

# 4 Running CoGAPS on Simulated Toy Data

We first give a walkthrough of the package features using a simple,
simulated data set. In later sections we provide two example workflows
on real data sets.

Import the CoGAPS library with the following command:

```
library(CoGAPS)
```

To ensure CoGAPS is working properly, we will first load in the
simulated toy data for a test run.

Single-cell data will be loaded later in this file.

```
data('modsimdata')
# input to CoGAPS
modsimdata
```

```
##          V1      V2      V3      V4      V5     V6      V7      V8      V9
## 1  0.077764 0.94742  4.2487  7.0608  4.8730 4.2687  9.1061 12.6020  9.0283
## 2  0.081467 0.99253  4.4507  7.3906  5.0387 4.1205  8.5843 11.8690  8.5029
## 3  0.085170 1.03760  4.6527  7.7204  5.2044 3.9723  8.0626 11.1360  7.9775
## 4  0.088873 1.08270  4.8547  8.0502  5.3700 3.8241  7.5408 10.4030  7.4521
## 5  0.092576 1.12790  5.0567  8.3800  5.5357 3.6759  7.0190  9.6695  6.9266
## 6  0.096279 1.17300  5.2587  8.7098  5.7014 3.5277  6.4973  8.9362  6.4012
## 7  0.099982 1.21810  5.4607  9.0396  5.8670 3.3795  5.9755  8.2030  5.8758
## 8  0.103680 1.26320  5.6627  9.3694  6.0327 3.2313  5.4538  7.4698  5.3503
## 9  0.107390 1.30830  5.8647  9.6992  6.1984 3.0831  4.9320  6.7366  4.8249
## 10 0.111090 1.35340  6.0667 10.0290  6.3640 2.9349  4.4103  6.0034  4.2995
## 11 0.044437 0.54138  2.4277  4.0319  2.7547 2.2811  4.7735  6.6014  4.7299
## 12 0.055810 0.67994  3.0488  5.0588  3.4079 2.5904  5.2490  7.2493  5.1939
## 13 0.067184 0.81850  3.6700  6.0857  4.0611 2.8996  5.7244  7.8973  5.6579
## 14 0.078557 0.95707  4.2911  7.1127  4.7144 3.2089  6.1998  8.5453  6.1219
## 15 0.089931 1.09560  4.9122  8.1396  5.3676 3.5182  6.6752  9.1932  6.5859
## 16 0.101300 1.23420  5.5333  9.1665  6.0208 3.8274  7.1506  9.8412  7.0500
## 17 0.112680 1.37280  6.1545 10.1930  6.6740 4.1367  7.6260 10.4890  7.5140
## 18 0.124050 1.51130  6.7756 11.2200  7.3272 4.4460  8.1014 11.1370  7.9780
## 19 0.135420 1.64990  7.3967 12.2470  7.9804 4.7552  8.5768 11.7850  8.4420
## 20 0.146800 1.78840  8.0179 13.2740  8.6337 5.0645  9.0523 12.4330  8.9060
## 21 0.158170 1.92700  8.6390 14.3010  9.2869 5.3738  9.5277 13.0810  9.3700
## 22 0.169550 2.06560  9.2601 15.3280  9.9401 5.6830 10.0030 13.7290  9.8341
## 23 0.180920 2.20410  9.8812 16.3550 10.5930 5.9923 10.4780 14.3770 10.2980
## 24 0.192290 2.34270 10.5020 17.3820 11.2470 6.3016 10.9540 15.0250 10.7620
## 25 0.203670 2.48120 11.1230 18.4090 11.9000 6.6108 11.4290 15.6730 11.2260
##       V10     V11      V12      V13     V14    V15     V16      V17      V18
## 1  3.3217 0.63098 0.081912 0.076605 0.15584 0.2000 0.15576 0.073576 0.021080
## 2  3.1288 0.59813 0.099451 0.150000 0.31159 0.4000 0.31152 0.147150 0.042160
## 3  2.9359 0.56529 0.116990 0.223400 0.46735 0.6000 0.46728 0.220730 0.063240
## 4  2.7430 0.53244 0.134530 0.296800 0.62310 0.8000 0.62304 0.294300 0.084319
## 5  2.5500 0.49959 0.152070 0.370200 0.77886 1.0000 0.77880 0.367880 0.105400
## 6  2.3571 0.46674 0.169610 0.443600 0.93462 1.2000 0.93456 0.441460 0.126480
## 7  2.1642 0.43390 0.187150 0.517000 1.09040 1.4000 1.09030 0.515030 0.147560
## 8  1.9713 0.40105 0.204690 0.590400 1.24610 1.6000 1.24610 0.588610 0.168640
## 9  1.7784 0.36820 0.222230 0.663800 1.40190 1.8000 1.40180 0.662180 0.189720
## 10 1.5854 0.33535 0.239770 0.737200 1.55760 2.0000 1.55760 0.735760 0.210800
## 11 1.7517 0.44215 0.685340 2.282400 4.82860 6.2000 4.82860 2.280900 0.653480
## 12 1.9220 0.47021 0.664380 2.198500 4.65060 5.9714 4.65060 2.196800 0.629380
## 13 2.0922 0.49826 0.643410 2.114600 4.47260 5.7429 4.47250 2.112700 0.605290
## 14 2.2625 0.52632 0.622450 2.030600 4.29460 5.5143 4.29450 2.028600 0.581200
## 15 2.4328 0.55438 0.601480 1.946700 4.11660 5.2857 4.11650 1.944500 0.557110
## 16 2.6031 0.58243 0.580520 1.862800 3.93860 5.0571 3.93850 1.860400 0.533020
## 17 2.7733 0.61049 0.559550 1.778900 3.76060 4.8286 3.76050 1.776300 0.508930
## 18 2.9436 0.63855 0.538590 1.694900 3.58260 4.6000 3.58250 1.692200 0.484840
## 19 3.1139 0.66660 0.517620 1.611000 3.40450 4.3714 3.40450 1.608200 0.460750
## 20 3.2841 0.69466 0.496660 1.527100 3.22650 4.1429 3.22650 1.524100 0.436650
## 21 3.4544 0.72272 0.475690 1.443100 3.04850 3.9143 3.04840 1.440000 0.412560
## 22 3.6247 0.75077 0.454730 1.359200 2.87050 3.6857 2.87040 1.355900 0.388470
## 23 3.7949 0.77883 0.433760 1.275300 2.69250 3.4571 2.69240 1.271800 0.364380
## 24 3.9652 0.80689 0.412800 1.191300 2.51450 3.2286 2.51440 1.187700 0.340290
## 25 4.1355 0.83494 0.391840 1.107400 2.33650 3.0000 2.33640 1.103600 0.316200
##          V19        V20
## 1  0.0036631 0.00038609
## 2  0.0073263 0.00077218
## 3  0.0109890 0.00115830
## 4  0.0146530 0.00154440
## 5  0.0183160 0.00193050
## 6  0.0219790 0.00231650
## 7  0.0256420 0.00270260
## 8  0.0293050 0.00308870
## 9  0.0329680 0.00347480
## 10 0.0366310 0.00386090
## 11 0.1135600 0.01196900
## 12 0.1093700 0.01152800
## 13 0.1051800 0.01108600
## 14 0.1010000 0.01064500
## 15 0.0968110 0.01020400
## 16 0.0926250 0.00976260
## 17 0.0884380 0.00932130
## 18 0.0842520 0.00888010
## 19 0.0800660 0.00843880
## 20 0.0758790 0.00799760
## 21 0.0716930 0.00755630
## 22 0.0675060 0.00711510
## 23 0.0633200 0.00667390
## 24 0.0591330 0.00623260
## 25 0.0549470 0.00579140
```

Next, we will set the parameters to be used by CoGAPS. First, we will
create a CogapsParams object, then set parameters with the setParam
function.

```
# create new parameters object
params <- new("CogapsParams", nPatterns=6)

# view all parameters
params
```

```
## -- Standard Parameters --
## nPatterns            6
## nIterations          50000
## seed                 579
## sparseOptimization   FALSE
##
## -- Sparsity Parameters --
## alpha          0.01
## maxGibbsMass   100
```

```
# get the value for a specific parameter
getParam(params, "nPatterns")
```

```
## [1] 6
```

```
# set the value for a specific parameter
params <- setParam(params, "nPatterns", 3)
getParam(params, "nPatterns")
```

```
## [1] 3
```

Run `CoGAPS` on the ModSim data.

Since this is a small dataset, the expected runtime is only about 5-10
seconds.

The only required argument to `CoGAPS` is the data set. This can be a
`matrix`, `data.frame`, `SummarizedExperiment`, `SingleCellExperiment`
or the path of a file (`tsv`, `csv`, `mtx`, `gct`) containing the data.

```
# run CoGAPS with specified parameters
cogapsresult <- CoGAPS(modsimdata, params, outputFrequency = 10000)
```

```
##
## This is CoGAPS version 3.30.0
## Running Standard CoGAPS on modsimdata (25 genes and 20 samples) with parameters:
##
## -- Standard Parameters --
## nPatterns            3
## nIterations          50000
## seed                 579
## sparseOptimization   FALSE
##
## -- Sparsity Parameters --
## alpha          0.01
## maxGibbsMass   100
```

Verify that a similar output appears:

```
This is CoGAPS version 3.19.1

Running Standard CoGAPS on modsimdata (25 genes and 20 samples) with
parameters:

-- Standard Parameters --
nPatterns            3
nIterations          50000
seed                 622
sparseOptimization   FALSE

-- Sparsity Parameters --
alpha          0.01
maxGibbsMass   100
Data Model: Dense, Normal
Sampler Type: Sequential
Loading Data\...Done! (00:00:00)

-- Equilibration Phase --
10000 of 50000, Atoms: 59(A), 49(P), ChiSq: 245, Time: 00:00:00 00:00:00
20000 of 50000, Atoms: 68(A), 46(P), ChiSq: 188, Time: 00:00:00 00:00:00
30000 of 50000, Atoms: 80(A), 47(P), ChiSq: 134, Time: 00:00:00 00:00:00
40000 of 50000, Atoms: 69(A), 46(P), ChiSq: 101, Time: 00:00:00 00:00:00
50000 of 50000, Atoms: 76(A), 53(P), ChiSq: 132, Time: 00:00:00 00:00:00

-- Sampling Phase --

10000 of 50000, Atoms: 82(A), 52(P), ChiSq: 94, Time: 00:00:00 00:00:00
20000 of 50000, Atoms: 74(A), 54(P), ChiSq: 144, Time: 00:00:01 00:00:01
30000 of 50000, Atoms: 79(A), 47(P), ChiSq: 116, Time: 00:00:01 00:00:01
40000 of 50000, Atoms: 79(A), 46(P), ChiSq: 132, Time: 00:00:01 00:00:01
50000 of 50000, Atoms: 76(A), 48(P), ChiSq: 124, Time: 00:00:01 00:00:01
```

This means that the underlying C++ library has run correctly, and
everything is installed how it should be.

We now examine the result object.

## 4.1 Analyzing the Toy Data CoGAPS result

CoGAPS returns a object of the class `CogapsResult` which inherits from
`LinearEmbeddingMatrix` (defined in the `SingleCellExperiment` package).
CoGAPS stores the lower dimensional representation of the samples (P
matrix) in the `sampleFactors` slot and the weight of the features (A
matrix) in the `featureLoadings` slot. `CogapsResult` also adds two of
its own slots - `factorStdDev` and `loadingStdDev` which contain the
standard deviation across sample points for each matrix.

There is also some information in the `metadata` slot such as the
original parameters and value for the Chi-Sq statistic. In general, the
metadata will vary depending on how `CoGAPS` was called in the first
place. The package provides these functions for querying the metadata in
a safe manner:

```
cogapsresult
```

```
## [1] "CogapsResult object with 25 features and 20 samples"
## [1] "3 patterns were learned"
```

```
cogapsresult@sampleFactors
```

```
##        Pattern_1    Pattern_2    Pattern_3
## V1  0.0007829146 8.376830e-03 0.0063578808
## V2  0.0008041965 8.959175e-02 0.1354026198
## V3  0.0022175102 4.003438e-01 0.6106285453
## V4  0.0039081662 6.645921e-01 0.9999995232
## V5  0.0016223749 4.514975e-01 0.6085854173
## V6  0.0010739972 3.549553e-01 0.1346134543
## V7  0.0027163778 7.272644e-01 0.0059095323
## V8  0.0036731185 1.000000e+00 0.0073537952
## V9  0.0026742197 7.170513e-01 0.0047806706
## V10 0.0008199923 2.644304e-01 0.0015397557
## V11 0.0058842157 5.342964e-02 0.0005462590
## V12 0.1127035618 1.657533e-03 0.0010092010
## V13 0.3672112823 2.384492e-04 0.0021312856
## V14 0.7796774507 3.132708e-04 0.0011260170
## V15 1.0000000000 3.938233e-04 0.0013912595
## V16 0.7795618773 3.320297e-04 0.0010128946
## V17 0.3680920005 2.178458e-04 0.0007567994
## V18 0.1051179692 1.745439e-04 0.0005319439
## V19 0.0137133626 9.028725e-04 0.0010764666
## V20 0.0001889676 6.433205e-05 0.0001602904
```

```
cogapsresult@featureLoadings
```

```
##         Pattern_1 Pattern_2   Pattern_3
## Gene_1  0.1871659 11.512225 0.003135191
## Gene_2  0.3961535 11.430764 0.013807174
## Gene_3  0.5958351 11.194637 0.125800341
## Gene_4  0.7945669 10.486231 0.884026408
## Gene_5  0.9939734  9.629650 1.929483652
## Gene_6  1.1915917  8.898258 2.757993698
## Gene_7  1.3903776  8.178508 3.550808668
## Gene_8  1.5877522  7.455221 4.348552704
## Gene_9  1.7858759  6.723314 5.158891678
## Gene_10 1.9821053  5.991307 5.960696697
## Gene_11 6.1614852  6.335921 0.004868119
## Gene_12 5.9354281  7.327224 0.068674982
## Gene_13 5.7097583  8.051400 0.517570794
## Gene_14 5.4876494  8.599793 1.284549594
## Gene_15 5.2549558  9.198512 1.970015645
## Gene_16 5.0347815  9.843598 2.566066027
## Gene_17 4.8044667 10.486246 3.157508850
## Gene_18 4.5770602 11.140410 3.733096600
## Gene_19 4.3495665 11.770279 4.336921692
## Gene_20 4.1229801 12.428734 4.904112816
## Gene_21 3.8937597 13.063639 5.497893333
## Gene_22 3.6631010 13.710291 6.063236237
## Gene_23 3.4332941 14.352925 6.660706997
## Gene_24 3.2076528 14.974977 7.251054764
## Gene_25 2.9760268 15.609497 7.848759174
```

```
# check reference result:
data('modsimresult')
```

If both matrices–sampleFactors and featureLoadings–have reasonable
values (small, nonnegative, somewhat random-seeming), it is an
indication that CoGAPS is working as expected.

We now continue with single-cell analysis.

# 5 Single-cell CoGAPS

```
# OPTION: download data object from Zenodo
options(timeout=50000) # adjust this if you're getting timeout downloading the file
bfc <- BiocFileCache::BiocFileCache()
pdac_url <- "https://zenodo.org/record/7709664/files/inputdata.Rds"
pdac_data <- BiocFileCache::bfcrpath(bfc, pdac_url)
pdac_data <- readRDS(pdac_data)
pdac_data
```

```
## An object of class Seurat
## 15184 features across 25442 samples within 2 assays
## Active assay: originalexp (15176 features, 2000 variable features)
##  3 layers present: counts, data, scale.data
##  1 other assay present: CoGAPS
##  5 dimensional reductions calculated: PCA, Aligned, UMAP, pca, umap
```

We also want to extract the counts matrix to provide directly to CoGAPS

```
pdac_epi_counts <- as.matrix(pdac_data@assays$originalexp@counts)
norm_pdac_epi_counts <- log1p(pdac_epi_counts)

head(pdac_epi_counts, n=c(5L, 2L))
head(norm_pdac_epi_counts, n=c(5L, 2L))
```

Most of the time we will set some parameters before running CoGAPS.
Parameters are managed with a CogapsParams object. This object will
store all parameters needed to run CoGAPS and provides a simple
interface for viewing and setting the parameter values.

```
library(CoGAPS)
pdac_params <- CogapsParams(nIterations=50000, # 50000 iterations
                seed=42, # for consistency across stochastic runs
                nPatterns=8, # each thread will learn 8 patterns
                sparseOptimization=TRUE, # optimize for sparse data
                distributed="genome-wide") # parallelize across sets

pdac_params
```

```
## -- Standard Parameters --
## nPatterns            8
## nIterations          50000
## seed                 42
## sparseOptimization   TRUE
## distributed          genome-wide
##
## -- Sparsity Parameters --
## alpha          0.01
## maxGibbsMass   100
##
## -- Distributed CoGAPS Parameters --
## nSets          4
## cut            8
## minNS          2
## maxNS          6
```

If you wish to run distributed CoGAPS, which is recommended to improve
the computational efficiency for most large datasets, you must also call
the setDistributedParams function. For a complete description of the
parallelization strategy used in distributed CoGAPS, please refer to our
preprint: <https://www.biorxiv.org/content/10.1101/2022.07.09.499398v1>

```
pdac_params <- setDistributedParams(pdac_params, nSets=7)
```

```
## setting distributed parameters - call this again if you change nPatterns
```

```
pdac_params
```

```
## -- Standard Parameters --
## nPatterns            8
## nIterations          50000
## seed                 42
## sparseOptimization   TRUE
## distributed          genome-wide
##
## -- Sparsity Parameters --
## alpha          0.01
## maxGibbsMass   100
##
## -- Distributed CoGAPS Parameters --
## nSets          7
## cut            8
## minNS          4
## maxNS          11
```

With all parameters set, we are now ready to run CoGAPS. Please note
that this is the most time-consuming step of the procedure. Timing can
take several hours and scales nlog(n) based on dataset size, as well as
the parameter values set for ‘nPatterns’ and ‘nIterations’. Time is
increased when learning more patterns, when running more iterations, and
when running a larger dataset, with iterations having the largest
variable impact on the runtime of the NMF function.

```
startTime <- Sys.time()

pdac_epi_result <- CoGAPS(pdac_epi_counts, pdac_params)
endTime <- Sys.time()

saveRDS(pdac_epi_result, "../data/pdac_epi_cogaps_result.Rds")

# To save as a .csv file, use the following line:
toCSV(pdac_epi_result, "../data")
```

# 6 Analyzing the CoGAPS result

Now that the CoGAPS run is complete, learned patterns can be
investigated. Due to the stochastic nature of the MCMC sampling in
CoGAPS and long run time, it is generally a good idea to immediately
save your CoGAPS result object to a file to have (Box 17), then read it
in for downstream analysis.

If you wish to load and examine a precomputed result object, please do
so by:

```
# OPTION: download precomputed CoGAPS result object from Zenodo
#caches download of the hosted file
cogapsresult_url <- "https://zenodo.org/record/7709664/files/cogapsresult.Rds"
cogapsresult <- BiocFileCache::bfcrpath(bfc, cogapsresult_url)
cogapsresult <- readRDS(cogapsresult)
```

To load your own result, simply edit the file path:

```
library(CoGAPS)
cogapsresult <- readRDS("../data/pdac_epi_cogaps_result.Rds")
```

It is recommended to immediately visualize pattern weights on a UMAP
because you will immediately see whether they are showing strong signal
and make common sense.

Since pattern weights are all continuous and nonnegative, they can be
used to color a UMAP in the same way as one would color by gene
expression. The sampleFactors matrix is essentially just nPatterns
different annotations for each cell, and featureLoadings is likewise
just nPatterns annotations for each gene. This makes it very simple to
incorporate pattern data into any data structure and workflow.

## 6.1 Load CoGAPS pattern information into Seurat object

To store CoGAPS patterns as an Assay within a Seurat object
(recommended):

```
library(Seurat)
# make sure pattern matrix is in same order as the input data
patterns_in_order <-t(cogapsresult@sampleFactors[colnames(pdac_data),])

# add CoGAPS patterns as an assay
pdac_data[["CoGAPS"]] <- CreateAssayObject(counts = patterns_in_order)
```

## 6.2 Plot patterns on an embedding

With the help of Seurat’s FeaturePlot function, we generate a UMAP
embedding of the cells colored by the intensity of each pattern.

```
DefaultAssay(pdac_data) <- "CoGAPS"
pattern_names = rownames(pdac_data@assays$CoGAPS)

library(viridis)
color_palette <- viridis(n=10)

FeaturePlot(pdac_data, pattern_names, cols=color_palette, reduction = "umap") & NoLegend()
```

# 7 Pattern Markers

We provide a `patternMarkers()` CoGAPS function to find markers (i.e. genes or
samples) most associated with each pattern. It returns a per-pattern
dictionary of markers, their ranking, and their distance “score” for each
pattern.

## 7.1 Marker assignment methods

`patternMarkers()` can run in two marker selection modes, controlled with
the “threshold” parameter, which can be set to “all” or “cut”. In both cases
the ranking of markers is essentially sorting Euclidian distances between a
candidate marker and a synthetic one-row matrix that represents an “ideal”
pattern.

If `threshold="all"` (default), each gene is treated as a marker of exactly one pattern,
whichever it is most strongly associated with, based on the distance metric.

For the `threshold="cut"`, the candidates are sorted by best intra-pattern rank
and are added to markers list unitil a certain rank is reached. This rank
corresponds to the first occurence of intra-pattern rank being worse than the
inter-pattern rank. This mode usually yields much less markers per pattern, and
the same marker can appear in multiple patterns.

## 7.2 Axis selection

The `axis` parameter can be used to select the axis along which the markers are
selected. By default, `axis=1`, which means that the feature (i.e. gene) markers
are estimated. If `axis=2`, the sample markers are estimated.

The three components of the returned dictionary pm are:

## 7.3 `patternMarkers()` Output

Output is a list of three components:

PatternMarkers:

* A list of marker genes for each pattern

PatternRanks:

* Each marker gene ranked by association for each pattern
* Whole natural numbers, assigning each marker a place in the
  rank for each pattern.
* Lower rank indicates higher association and vice versa.

PatternScores:

* Scores describe how strongly a marker gene is associated with a
  pattern.
* A higher score value indicates the marker gene is less associated
  with the pattern (as score is a distance) metric, and vice versa.
* Scores have nonnegative values mostly falling between 0 and 2

## 7.4 Example

```
pm <- patternMarkers(cogapsresult)
```

# 8 Pattern GSEA

One way to explore and use CoGAPS patterns is to conduct gene set enrichment analysis by functionally annotating the genes which are significant for each pattern. The getPatternGeneSet function provides a wrapper around the gsea and fora methods from fgsea for gene set enrichment in CoGAPS pattern amplitudes or gene set overrepresentation in pattern markers, respectively. Gene sets for testing are provided as a list to allow testing of gene sets from many sources, such as hallmark gene sets from [msigDB](https://www.gsea-msigdb.org/gsea/msigdb/) or gene ontology sets from [org.Hs.eg.db](https://bioconductor.org/packages/release/data/annotation/html/org.Hs.eg.db.html).

To perform gene set overrepresentation on pattern markers, please run:

```
hallmark_ls <- list(
  "HALLMARK_ALLOGRAFT_REJECTION" = c(
    "AARS1","ABCE1","ABI1","ACHE","ACVR2A","AKT1","APBB1","B2M","BCAT1","BCL10","BCL3","BRCA1","C2","CAPG","CARTPT","CCL11","CCL13","CCL19","CCL2","CCL22","CCL4","CCL5","CCL7","CCND2","CCND3","CCR1","CCR2","CCR5","CD1D","CD2","CD247","CD28","CD3D","CD3E","CD3G","CD4","CD40","CD40LG","CD47","CD7","CD74","CD79A","CD80","CD86","CD8A","CD8B","CD96","CDKN2A","CFP","CRTAM","CSF1","CSK","CTSS","CXCL13","CXCL9","CXCR3","DARS1","DEGS1","DYRK3","EGFR","EIF3A","EIF3D","EIF3J","EIF4G3","EIF5A","ELANE","ELF4","EREG","ETS1","F2","F2R","FAS","FASLG","FCGR2B","FGR","FLNA","FYB1","GALNT1","GBP2","GCNT1","GLMN","GPR65","GZMA","GZMB","HCLS1","HDAC9","HIF1A","HLA-A","HLA-DMA","HLA-DMB","HLA-DOA","HLA-DOB","HLA-DQA1","HLA-DRA","HLA-E","HLA-G","ICAM1","ICOSLG","IFNAR2","IFNG","IFNGR1","IFNGR2","IGSF6","IKBKB","IL10","IL11","IL12A","IL12B","IL12RB1","IL13","IL15","IL16","IL18","IL18RAP","IL1B","IL2","IL27RA","IL2RA","IL2RB","IL2RG","IL4","IL4R","IL6","IL7","IL9","INHBA","INHBB","IRF4","IRF7","IRF8","ITGAL","ITGB2","ITK","JAK2","KLRD1","KRT1","LCK","LCP2","LIF","LTB","LY75","LY86","LYN","MAP3K7","MAP4K1","MBL2","MMP9","MRPL3","MTIF2","NCF4","NCK1","NCR1","NLRP3","NME1","NOS2","NPM1","PF4","PRF1","PRKCB","PRKCG","PSMB10","PTPN6","PTPRC","RARS1","RIPK2","RPL39","RPL3L","RPL9","RPS19","RPS3A","RPS9","SIT1","SOCS1","SOCS5","SPI1","SRGN","ST8SIA4","STAB1","STAT1","STAT4","TAP1","TAP2","TAPBP","TGFB1","TGFB2","THY1","TIMP1","TLR1","TLR2","TLR3","TLR6","TNF","TPD52","TRAF2","TRAT1","UBE2D1","UBE2N","WARS1","WAS","ZAP70"
    ),
  "HALLMARK_EPITHELIAL_MESENCHYMAL_TRANSITION" = c(
    "ABI3BP","ACTA2","ADAM12","ANPEP","APLP1","AREG","BASP1","BDNF","BGN","BMP1","CADM1","CALD1","CALU","CAP2","CAPG","CD44","CD59","CDH11","CDH2","CDH6","COL11A1","COL12A1","COL16A1","COL1A1","COL1A2","COL3A1","COL4A1","COL4A2","COL5A1","COL5A2","COL5A3","COL6A2","COL6A3","COL7A1","COL8A2","COMP","COPA","CRLF1","CCN2","CTHRC1","CXCL1","CXCL12","CXCL6","CCN1","DAB2","DCN","DKK1","DPYSL3","DST","ECM1","ECM2","EDIL3","EFEMP2","ELN","EMP3","ENO2","FAP","FAS","FBLN1","FBLN2","FBLN5","FBN1","FBN2","FERMT2","FGF2","FLNA","FMOD","FN1","FOXC2","FSTL1","FSTL3","FUCA1","FZD8","GADD45A","GADD45B","GAS1","GEM","GJA1","GLIPR1","COLGALT1","GPC1","GPX7","GREM1","HTRA1","ID2","IGFBP2","IGFBP3","IGFBP4","IL15","IL32","IL6","CXCL8","INHBA","ITGA2","ITGA5","ITGAV","ITGB1","ITGB3","ITGB5","JUN","LAMA1","LAMA2","LAMA3","LAMC1","LAMC2","P3H1","LGALS1","LOX","LOXL1","LOXL2","LRP1","LRRC15","LUM","MAGEE1","MATN2","MATN3","MCM7","MEST","MFAP5","MGP","MMP1","MMP14","MMP2","MMP3","MSX1","MXRA5","MYL9","MYLK","NID2","NNMT","NOTCH2","NT5E","NTM","OXTR","PCOLCE","PCOLCE2","PDGFRB","PDLIM4","PFN2","PLAUR","PLOD1","PLOD2","PLOD3","PMEPA1","PMP22","POSTN","PPIB","PRRX1","PRSS2","PTHLH","PTX3","PVR","QSOX1","RGS4","RHOB","SAT1","SCG2","SDC1","SDC4","SERPINE1","SERPINE2","SERPINH1","SFRP1","SFRP4","SGCB","SGCD","SGCG","SLC6A8","SLIT2","SLIT3","SNAI2","SNTB1","SPARC","SPOCK1","SPP1","TAGLN","TFPI2","TGFB1","TGFBI","TGFBR3","TGM2","THBS1","THBS2","THY1","TIMP1","TIMP3","TNC","TNFAIP3","TNFRSF11B","TNFRSF12A","TPM1","TPM2","TPM4","VCAM1","VCAN","VEGFA","VEGFC","VIM","WIPF1","WNT5A"
  )
)

hallmarks_ora <- getPatternGeneSet(cogapsresult,
                                   gene.sets = hallmark_ls,
                                   method = "overrepresentation")
```

hallmarks is a list of data frames, each containing hallmark overrepresentation statistics corresponding to one pattern.

To generate a barchart of the most significant hallmarks for any given pattern, please run:

```
pl_pattern7 <- plotPatternGeneSet(
  patterngeneset = hallmarks_ora, whichpattern = 7, padj_threshold = 0.05
)
pl_pattern7
```

![](data:image/png;base64...)
To generate statistics on the association between certain sample groups and patterns, we provide a wrapper function, called MANOVA.This will allow us to explore if the patterns we have discovered lend to statistically significant differences in the sample groups. We will first load in the original data (if not already done earlier).

Then, create a new matrix called “interestedVariables” consisting of the metadata variables of interest in conducting analysis on. Lastly, call the wrapper function, passing in the result object as well.

```
# create dataframe of interested variables
interestedVariables <- cbind(pdac_data@meta.data[["nCount_RNA"]], pdac_data@meta.data[["nFeature_RNA"]])
# call cogaps manova wrapper
manova_results <- MANOVA(interestedVariables, cogapsresult)
```

```
## [1] "Pattern_1"
##                   Df  Pillai approx F num Df den Df    Pr(>F)
## pattern_column     1 0.46053    10858      2  25439 < 2.2e-16 ***
## Residuals      25440
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## [1] "Pattern_2"
##                   Df  Pillai approx F num Df den Df    Pr(>F)
## pattern_column     1 0.14815   2212.2      2  25439 < 2.2e-16 ***
## Residuals      25440
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## [1] "Pattern_3"
##                   Df  Pillai approx F num Df den Df    Pr(>F)
## pattern_column     1 0.46173    10911      2  25439 < 2.2e-16 ***
## Residuals      25440
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## [1] "Pattern_4"
##                   Df  Pillai approx F num Df den Df    Pr(>F)
## pattern_column     1 0.31354   5809.5      2  25439 < 2.2e-16 ***
## Residuals      25440
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## [1] "Pattern_5"
##                   Df  Pillai approx F num Df den Df    Pr(>F)
## pattern_column     1 0.16056   2432.8      2  25439 < 2.2e-16 ***
## Residuals      25440
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## [1] "Pattern_6"
##                   Df  Pillai approx F num Df den Df    Pr(>F)
## pattern_column     1 0.19702   3120.9      2  25439 < 2.2e-16 ***
## Residuals      25440
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## [1] "Pattern_7"
##                   Df  Pillai approx F num Df den Df    Pr(>F)
## pattern_column     1 0.18574   2901.5      2  25439 < 2.2e-16 ***
## Residuals      25440
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## [1] "Pattern_8"
##                   Df  Pillai approx F num Df den Df    Pr(>F)
## pattern_column     1 0.11419   1639.7      2  25439 < 2.2e-16 ***
## Residuals      25440
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

The function will print out the MANOVA results for each pattern learned based on the variables of interest. From the output, we can observe that all p-values have a value of 0.0, indicating that differences observed in the sample groups based on the patterns are statistically significant.

# 9 Citing CoGAPS

If you use the CoGAPS package for your analysis, please cite
Fertig et al. ([2010](#ref-FERTIG_2010))

If you use the gene set statistic, please cite Ochs et al. ([2009](#ref-OCHS_2009))

# References

Fertig, Elana J., Jie Ding, Alexander V. Favorov, Giovanni Parmigiani, and Michael F. Ochs. 2010. “CoGAPS: An R/C++ Package to Identify Patterns and Biological Process Activity in Transcriptomic Data.” *Bioinformatics* 26 (21): 2792–3. <https://doi.org/10.1093/bioinformatics/btq503>.

Ochs, Michael F., Lori Rink, Chi Tarn, Sarah Mburu, Takahiro Taguchi, Burton Eisenberg, and Andrew K. Godwin. 2009. “Detection of Treatment-Induced Changes in Signaling Pathways in Gastrointestinal Stromal Tumors Using Transcriptomic Data.” *Cancer Research* 69 (23): 9125–32. <https://doi.org/10.1158/0008-5472.CAN-09-1709>.

Seung, Sebastian, and Daniel D. Lee. 1999. “Learning the Parts of Objects by Non-Negative Matrix Factorization.” *Nature* 401 (6755): 788–91. <https://doi.org/10.1038/44565>.