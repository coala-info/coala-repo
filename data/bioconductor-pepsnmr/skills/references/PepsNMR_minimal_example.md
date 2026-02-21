# Application of PepsNMR on the Human Serum dataset

Manon Martin

#### 2025-10-30

#### Package

PepsNMR 1.28.0

# 1 Introduction

This document provides a brief summary on how to use the *[PepsNMR](https://bioconductor.org/packages/3.22/PepsNMR)* package. In this package, pre-processing functions transform raw FID signals from 1H NMR spectroscopy into a set of interpretable spectra.

# 2 Installation

The *[PepsNMR](https://bioconductor.org/packages/3.22/PepsNMR)* package is available on Bioconductor and can be installed via `BiocManager::install`:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("PepsNMR",
                     dependencies = c("Depends", "Imports", "Suggests"))
```

Note tha installing the `Suggests` dependencies will install the *[PepsNMRData](https://bioconductor.org/packages/3.22/PepsNMRData)* package to run the demo below.

The package needs to be loaded once installed to be used:

```
library(PepsNMR)
```

The package development version is available on Github (Master branch): <https://github.com/ManonMartin/PepsNMR>, although it is highly recommended to rely on the Bioconductor release version of the package to avoid any package version mismatch.

# 3 Data importation

The first step is meant to access the raw data files. To import Free Induction Decays (FIDs) in Bruker format, use the `ReadFids` function. This function will return a list with the FID data matrix (saved in `Fid_data`) and metadata about these FIDs (saved in `Fid_info`).

```
fidList <- ReadFids(file.path(path,dataset_name))

Fid_data <- fidList[["Fid_data"]]
Fid_info <- fidList[["Fid_info"]]
```

The possible directory structures are illustrated here:

![Accepted directory structures for the raw Bruker files](data:image/png;base64...)

Figure 1: Accepted directory structures for the raw Bruker files

And is to be linked with the possible options of the `ReadFids` function:

1. If use of *title* file and presence of sub-directories: set the FID Title line, `subdirs = TRUE`, `dirs.names = FALSE`
2. If use of *title* file and no sub-directories: set the FID Title line, `subdirs = FALSE`, `dirs.names = FALSE`
3. If no use of *title* file and presence of sub-directories: `subdirs = TRUE`, `dirs.names = TRUE`
4. If no use of *title* file and no sub-directories: `subdirs = FALSE`, `dirs.names = TRUE`

# 4 Pre-processing steps

Here is the recommended pre-processing workflow on the FIDs and the spectra once the raw data have been loaded in R:

Table 1: Pre-processing steps
They are presented in the suggested order.

| Steps | Description |
| --- | --- |
| Group Delay Correction | Correct for the Bruker Group Delay. |
| Solvent Suppression | Remove the solvent signal from the FIDs. |
| Apodization | Increase the Signal-to-Noise ratio of the FIDs. |
| ZeroFilling | Improve the visual representation of the spectra. |
| Fourier Transform | Transform the FIDs into a spectrum and convert the frequency scale (Hz -> ppm). |
| Zero Order Phase Correction | Correct for the zero order phase dephasing. |
| Internal Referencing | Calibrate the spectra with an internal reference compound. Referencing with an internal (e.g. TMSP at 0 ppm) |
| Baseline Correction | Remove the spectral baseline. |
| Negative Values Zeroing | Set negatives values to 0. |
| Warping | Warp the spectra according to a reference spectrum. |
| Window Selection | Select the informative part of the spectrum. |
| Bucketing | Data reduction. |
| Region Removal | Set a desired spectral region to 0. |
| Zone Aggregation | Aggregate a spectral region into a single peak. |
| Normalization | Normalize the spectra. |

Information on each function is provided in R, (e.g. type `?ReadFids` in the R console) and methodological details are found in Martin et al. ([2018](#ref-Martin2018)).

# 5 Available datasets

Human serum (`HS`) and urine (`HU`) datasets are available as raw data (FIDs in Bruker format) and as (partially) pre-processed signals/spectra in the ad hoc *[PepsNMRData](https://bioconductor.org/packages/3.22/PepsNMRData)* package that is automatically installed with *[PepsNMR](https://bioconductor.org/packages/3.22/PepsNMR)* (through ).

Here are examples of available datasets:

```
library(PepsNMRData)

str(FidData_HU)
#>  cplx [1:24, 1:29411] 0+0i 0+0i 0+0i ...
#>  - attr(*, "dimnames")=List of 2
#>   ..$ : chr [1:24] "S1-D0-E1" "S1-D0-E2" "S1-D1-E2" "S2-D0-E2" ...
#>   ..$ : chr [1:29411] "0" "5.1e-05" "0.000102" "0.000153" ...

str(FinalSpectra_HS)
#>  cplx [1:32, 1:500] 0.0769-371030i 0.0466-362686i 0.0639-216899i ...
#>  - attr(*, "dimnames")=List of 2
#>   ..$ : chr [1:32] "J1-D1-1D-T1" "J3-D2-1D-T8" "J3-D3-1D-T9" "J3-D4-1D-T14" ...
#>   ..$ : chr [1:500] "9.98986984692192" "9.97027064485524" "9.95067144278856" "9.93107224072187" ...
```

Information for each dataset is available, (e.g. enter `?FidData_HS` in the R Console).

# 6 Demo on the HSerum dataset

## 6.1 Load the data

Raw Bruker FIDs can be loaded from where *[PepsNMRData](https://bioconductor.org/packages/3.22/PepsNMRData)* has been intalled:

```
data_path <-  system.file("extdata", package = "PepsNMRData")
dir(data_path)
#> [1] "Group_HS.csv" "HumanSerum"
```

## 6.2 Read the FID data file

To import FIDs in Bruker format, the `ReadFids` function is used. This function will return a list with the FID data matrix (here saved as `Fid_data`) and information about these FIDs (here saved as `Fid_info`).

```
# ==== read the FIDs and their metadata =================
fidList <- ReadFids(file.path(data_path, "HumanSerum"))
Fid_data0 <- fidList[["Fid_data"]]
Fid_info <- fidList[["Fid_info"]]
kable(head(Fid_info))
```

|  | TD | BYTORDA | DIGMOD | DECIM | DSPFVS | SW\_h | SW | O1 | DTYPA | DT |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| J1-D1-1D-T1 | 65536 | 1 | 1 | 16 | 12 | 10245.9 | 20.48638 | 2352.222 | 0 | 4.88e-05 |
| J3-D2-1D-T8 | 65536 | 1 | 1 | 16 | 12 | 10245.9 | 20.48638 | 2352.222 | 0 | 4.88e-05 |
| J3-D3-1D-T9 | 65536 | 1 | 1 | 16 | 12 | 10245.9 | 20.48638 | 2352.222 | 0 | 4.88e-05 |
| J3-D4-1D-T14 | 65536 | 1 | 1 | 16 | 12 | 10245.9 | 20.48638 | 2352.222 | 0 | 4.88e-05 |
| J4-D1-1D-T4 | 65536 | 1 | 1 | 16 | 12 | 10245.9 | 20.48638 | 2352.222 | 0 | 4.88e-05 |
| J4-D2-1D-T7 | 65536 | 1 | 1 | 16 | 12 | 10245.9 | 20.48638 | 2352.222 | 0 | 4.88e-05 |

![Raw FID.](data:image/png;base64...)

Figure 2: Raw FID

## 6.3 Group Delay Correction

The Bruker’s digital filter originally produces a Group Delay that is removed during this step.

```
# ==== GroupDelayCorrection =================
Fid_data.GDC <- GroupDelayCorrection(Fid_data0, Fid_info)
```

![Signal before and after the Group Delay removal.](data:image/png;base64...)

Figure 3: Signal before and after the Group Delay removal

## 6.4 Solvent Suppression

Pre-acquisition techniques for solvent suppression can be unsufficient to remove the solvent signal from the FIDs. `SolventSuppression` estimates and removes this residual solvent signal based on a Whittaker smoother.

```
# ====  SolventSuppression =================
SS.res <- SolventSuppression(Fid_data.GDC, returnSolvent=TRUE)

Fid_data.SS <- SS.res[["Fid_data"]]
SolventRe <- SS.res[["SolventRe"]]
```

![Signal before and after the Residual Solvent Removal.](data:image/png;base64...)

Figure 4: Signal before and after the Residual Solvent Removal

## 6.5 Apodization

The apodization step increases the spectral Signal-to-Noise ratio by multiplying the FIDs by an appropriate factor (by default a negative exponential).

```
# ==== Apodization =================
Fid_data.A <- Apodization(Fid_data.SS, Fid_info)
```

![Signal before and after Apodization.](data:image/png;base64...)

Figure 5: Signal before and after Apodization

## 6.6 Zero Filling

The zero filling adds 0 to the end of the FIDs to improve the visual representation of spectra.

```
# ==== Zero Filling =================
Fid_data.ZF <- ZeroFilling(Fid_data.A, fn = ncol(Fid_data.A))
```

![Signal before and after Apodization.](data:image/png;base64...)

Figure 6: Signal before and after Apodization

## 6.7 FourierTransform

The Fourier Transform is applied to the FIDs to obtain spectra expressed in the frequency domain. The `FourierTransform` function further converts this frequency scale originally in hertz into parts per million (ppm).

```
# ==== FourierTransform =================
RawSpect_data.FT <- FourierTransform(Fid_data.ZF, Fid_info)
```

![Spectrum after FT.](data:image/png;base64...)

Figure 7: Spectrum after FT

## 6.8 Zero Order Phase Correction

After Fourier Transform, the spectra need to be phased for the real part to be in pure absoptive mode (i.e. with positive intensities).

```
# ==== ZeroOrderPhaseCorrection =================
Spectrum_data.ZOPC <- ZeroOrderPhaseCorrection(RawSpect_data.FT)

# with a graph of the criterion to maximize over 2pi
Spectrum_data.ZOPC <- ZeroOrderPhaseCorrection(RawSpect_data.FT,
                                               plot_rms = "J1-D1-1D-T1")
```

![Spectrum after Zero Order Phase Correction.](data:image/png;base64...)

Figure 8: Spectrum after Zero Order Phase Correction

## 6.9 Internal Referencing

During this step, the spectra are aligned with an internal reference compound (e.g. with the TMSP). The user determines the ppm value of the reference compound which is by default 0.

```
# ==== InternalReferencing =================
target.value <- 0

IR.res <- InternalReferencing(Spectrum_data.ZOPC, Fid_info,
                                        ppm.value = target.value,
                                        rowindex_graph = c(1,2))
# draws Peak search zone and location of the 2 first spectra
IR.res$plots
#> [[1]]
```

![](data:image/png;base64...)

```
Spectrum_data.IR <- IR.res$Spectrum_data
```

![Spectrum after Internal Referencing.](data:image/png;base64...)

Figure 9: Spectrum after Internal Referencing

## 6.10 Baseline Correction

The spectral baseline is estimated and removed from the spectral profiles with the Asymetric Least Squares smoothing algorithm.

```
# ==== BaselineCorrection =================
BC.res <- BaselineCorrection(Spectrum_data.IR, returnBaseline = TRUE,
                             lambda.bc = 1e8, p.bc = 0.01)
```

![Spectrum before and after the Baseline Correction.](data:image/png;base64...)

Figure 10: Spectrum before and after the Baseline Correction

## 6.11 Negative Values Zeroing

The remaining negative values are set to 0 since they cannot be interpreted.

```
# ==== NegativeValuesZeroing =================
Spectrum_data.NVZ <- NegativeValuesZeroing(Spectrum_data.BC)
```

![Spectrum after Negative Values Zeroing.](data:image/png;base64...)

Figure 11: Spectrum after Negative Values Zeroing

## 6.12 Warping

The spectra are realigned based on a reference spectrum with a Semi-Parametric Time Warping technique.

```
# ==== Warping =================
W.res <- Warping(Spectrum_data.NVZ, returnWarpFunc = TRUE,
                 reference.choice = "fixed")

Spectrum_data.W <- W.res[["Spectrum_data"]]
warp_func <- W.res[["Warp.func"]]
```

![Spectrum before and after the Baseline Correction.](data:image/png;base64...)

Figure 12: Spectrum before and after the Baseline Correction

## 6.13 Window Selection

During this step the user selects the part of the spectrum that is of interest and the other parts are removed from the spectral matrix.

```
# ==== WindowSelection =================
Spectrum_data.WS <- WindowSelection(Spectrum_data.W, from.ws = 10,
                                    to.ws = 0.2)
```

![Spectrum after Window Selection.](data:image/png;base64...)

Figure 13: Spectrum after Window Selection

## 6.14 Bucketing

The `Bucketing` function reduces the number of spectral descriptors by aggregating intensities into a series of buckets.

```
# ==== Bucketing =================
Spectrum_data.B <- Bucketing(Spectrum_data.WS, intmeth = "t")
```

![Spectrum before and after Bucketing.](data:image/png;base64...)

Figure 14: Spectrum before and after Bucketing

## 6.15 Region Removal

By default, this step sets to zero spectral areas that are of no interest or have a sigificant and unwanted amount of variation (e.g. the water area).

```
# ==== RegionRemoval =================
Spectrum_data.RR <- RegionRemoval(Spectrum_data.B,
                                  typeofspectra = "serum")
```

![Spectrum after Region Removal](data:image/png;base64...)

Figure 15: Spectrum after Region Removal

## 6.16 Normalization

The normalization copes with the dilution factor and other issues that render the spectral profiles non-comparable to each other.

```
# ==== Normalization =================
Spectrum_data.N <- Normalization(Spectrum_data.RR, type.norm = "mean")
```

![Spectrum before and after Normalization](data:image/png;base64...)

Figure 16: Spectrum before and after Normalization

Note: the function `ZoneAggregation` is not used here, but is can be applied e.g. to urine spectra to aggregate the citrate peak.

# 7 Final spectra visualisation

The `Draw` function enables to produce line plots with `type.draw = "signal"` or PCA results with `type.draw = "pca"` of FIDs or spectra. These plots can be saved as pdf files with the option `output = "pdf"`, see `?Draw`, `?DrawSignal` and `?DrawPCA` for more details on the other available options.

```
Draw(Spectrum_data.N[1:4,], type.draw = c("signal"),
     subtype= "stacked", output = c("default"))
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the PepsNMR package.
#>   Please report the issue at <https://github.com/ManonMartin/PepsNMR/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![4 first pre-processed spectra](data:image/png;base64...)

Figure 17: 4 first pre-processed spectra

```
Draw(Spectrum_data.N, type.draw = c("pca"),
     output = c("default"), Class = Group_HS,
     type.pca = "scores")
#> Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the PepsNMR package.
#>   Please report the issue at <https://github.com/ManonMartin/PepsNMR/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![PCA scores of the pre-processed spectra](data:image/png;base64...)

Figure 18: PCA scores of the pre-processed spectra

```
Draw(Spectrum_data.N, type.draw = c("pca"),
     output = c("default"),
     Class = Group_HS, type.pca = "loadings")
```

![PCA loadings of the pre-processed spectra](data:image/png;base64...)

Figure 19: PCA loadings of the pre-processed spectra

# 8 Session info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] PepsNMRData_1.27.0 PepsNMR_1.28.0     knitr_1.50         BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         generics_0.1.4      stringi_1.8.7
#>  [4] lattice_0.22-7      digest_0.6.37       magrittr_2.0.4
#>  [7] evaluate_1.0.5      grid_4.5.1          RColorBrewer_1.1-3
#> [10] bookdown_0.45       fastmap_1.2.0       plyr_1.8.9
#> [13] jsonlite_2.0.0      Matrix_1.7-4        tinytex_0.57
#> [16] gridExtra_2.3       BiocManager_1.30.26 scales_1.4.0
#> [19] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
#> [22] crayon_1.5.3        ptw_1.9-16          withr_3.0.2
#> [25] cachem_1.1.0        yaml_2.3.10         tools_4.5.1
#> [28] reshape2_1.4.4      dplyr_1.1.4         ggplot2_4.0.0
#> [31] RcppDE_0.1.8        vctrs_0.6.5         R6_2.6.1
#> [34] matrixStats_1.5.0   lifecycle_1.0.4     magick_2.9.0
#> [37] stringr_1.5.2       pkgconfig_2.0.3     pillar_1.11.1
#> [40] bslib_0.9.0         gtable_0.3.6        glue_1.8.0
#> [43] Rcpp_1.1.0          xfun_0.53           tibble_3.3.0
#> [46] tidyselect_1.2.1    dichromat_2.0-0.1   farver_2.1.2
#> [49] htmltools_0.5.8.1   rmarkdown_2.30      labeling_0.4.3
#> [52] compiler_4.5.1      S7_0.2.0
```

# References

Martin, Manon, Benoît Legat, Justine Leenders, Julien Vanwinsberghe, Réjane Rousseau, Bruno Boulanger, Paul H. C. Eilers, Pascal De Tullio, and Bernadette Govaerts. 2018. “PepsNMR for 1H NMR Metabolomic Data Pre-Processing.” *Analytica Chimica Acta* 1019: 1–13. <https://doi.org/10.1016/j.aca.2018.02.067>.