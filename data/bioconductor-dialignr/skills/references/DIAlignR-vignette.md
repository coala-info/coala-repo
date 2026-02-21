# MS2 chromatograms based alignment of targeted mass-spectrometry runs

Shubham Gupta and Hannes Röst

#### 2020-05-08

#### Package

DIAlignR 1.0.5

In this document we are presenting a workflow of retention-time alignment across multiple Targeted-MS (e.g. DIA, SWATH-MS, PRM, SRM) runs using DIAlignR. This tool requires MS2 chromatograms and provides a hybrid approach of global and local alignment to establish correspondence between peaks.

## 0.1 Install DIAlignR

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DIAlignR")
```

```
library(DIAlignR)
```

## 0.2 Prepare input files for alignment

Mass-spectrometry files mostly contains spectra. Targeted proteomics workflow identifyies analytes from their chromatographic elution profile. DIAlignR extends the same concept for retention-time (RT) alignment and, therefore, relies on MS2 chromatograms. DIAlignR expects raw chromatogram file (.chrom.mzML) and FDR-scored features (.osw) file.
Example files are available with this package and can be located with this command:

```
dataPath <- system.file("extdata", package = "DIAlignR")
```

(Optional) To obtain files for alignment, following three steps are needed:

* Step 1 Convert spectra files from vendor-specific format to standard mzMl format using [ProteoWizard-MSConvert](http://proteowizard.sourceforge.net/tools.shtml).
* Step 2 Extract features and raw extracted-ion chromatograms(XICs) for library analytes. A detailed tutorial using [OpenSWATH](http://openswath.org/en/latest/docs/openswath.html) is available for this steps. In short, following `bash` command can be used:

```
OpenSwathWorkflow -in Filename.mzML.gz -tr library.pqp -tr_irt
iRTassays.TraML -out_osw Filename.osw -out_chrom Filename.chrom.mzML
```

Output files **Filename.osw** and **Filename.chrom.mzML** are required to next steps. Some chromatograms are stored in compressed form and currently inaccesible by `mzR`. In such cases `mzR` would throw an error indicating `Invalid cvParam accession "1002746"`. To avoid this issue, uncompress chromatograms using OpenMS.

```
FileConverter -in Filename.chrom.mzML -in_type 'mzML' -out Filename.chrom.mzML
```

* Step 3: Score features and calculate their q-values. A machine-learning based workflow is available with [PyProphet](http://openswath.org/en/latest/docs/pyprophet.html). For multiplt-runs experiment-wide FDR is recommended. An example of running pyprophet on OpenSWATH results is given below:

```
pyprophet merge --template=library.pqp --out=merged.osw *.osw
pyprophet score --in=merged.osw --classifier=XGBoost --level=ms2 --xeval_num_iter=3 \
--ss_initial_fdr=0.05 --ss_iteration_fdr=0.01
pyprophet peptide --in=merged.osw --context=experiment-wide
```

Congrats! Now we have raw chromatogram files and associated scored features in merged.osw files. Move all .chrom.mzML files in `mzml` directory and merged.osw file in `osw` directory. The parent folder is given as `dataPath` to DIAlignR functions.

## 0.3 Performing alignment on DIA runs

`alignTargetedRuns` function aligns Proteomics or Metabolomics DIA runs. It expects two directories “osw” and “mzml” at `dataPath`. It outputs an intensity table where rows specify each analyte and columns specify runs. Use parameter `saveFiles = TRUE` to have aligned retetion time and intensities saved in the current directory.

```
runs <- c("hroest_K120809_Strep0%PlasmaBiolRepl2_R04_SW_filt",
          "hroest_K120809_Strep10%PlasmaBiolRepl2_R04_SW_filt")
# For specific runs provide their names.
alignTargetedRuns(dataPath = dataPath, outFile = "test.csv", runs = runs, oswMerged = TRUE)
# For all the analytes in all runs, keep them as NULL.
alignTargetedRuns(dataPath = dataPath, outFile = "test.csv", runs = NULL, oswMerged = TRUE)
```

## 0.4 Investigating alignment of analytes

For getting alignment object which has aligned indices of XICs `getAlignObjs` function can be used. Like previous function, it expects two directories “osw” and “mzml” at `dataPath`. It performs alignment for exactly two runs. In case of `refRun` is not provided, m-score from osw files is used to select reference run.

```
runs <- c("hroest_K120809_Strep0%PlasmaBiolRepl2_R04_SW_filt",
          "hroest_K120809_Strep10%PlasmaBiolRepl2_R04_SW_filt")
AlignObjLight <- getAlignObjs(analytes = 4618L, runs = runs, dataPath = dataPath, objType   = "light")
#> [1] "hroest_K120809_Strep0%PlasmaBiolRepl2_R04_SW_filt"
#> [2] "hroest_K120809_Strep10%PlasmaBiolRepl2_R04_SW_filt"
#> [1] "Finding reference run using m-score."
# First element contains names of runs, spectra files, chromatogram files and feature files.
AlignObjLight[[1]][, c("runName", "spectraFile")]
#>                                                 runName
#> run1  hroest_K120809_Strep0%PlasmaBiolRepl2_R04_SW_filt
#> run2 hroest_K120809_Strep10%PlasmaBiolRepl2_R04_SW_filt
#>                                                              spectraFile
#> run1  data/raw/hroest_K120809_Strep0%PlasmaBiolRepl2_R04_SW_filt.mzML.gz
#> run2 data/raw/hroest_K120809_Strep10%PlasmaBiolRepl2_R04_SW_filt.mzML.gz
obj <- AlignObjLight[[2]][["4618"]][[1]][["AlignObj"]]
slotNames(obj)
#> [1] "indexA_aligned" "indexB_aligned" "score"
names(as.list(obj))
#> [1] "indexA_aligned" "indexB_aligned" "score"
AlignObjMedium <- getAlignObjs(analytes = 4618L, runs = runs, dataPath = dataPath, objType  = "medium")
#> [1] "hroest_K120809_Strep0%PlasmaBiolRepl2_R04_SW_filt"
#> [2] "hroest_K120809_Strep10%PlasmaBiolRepl2_R04_SW_filt"
#> [1] "Finding reference run using m-score."
obj <- AlignObjMedium[[2]][["4618"]][[1]][["AlignObj"]]
slotNames(obj)
#> [1] "s"              "path"           "indexA_aligned" "indexB_aligned"
#> [5] "score"
```

Alignment object has slots
\* indexA\_aligned aligned indices of reference chromatogram.
\* indexB\_aligned aligned indices of experiment chromatogram
\* score cumulative score of the alignment till an index.
\* s similarity score matrix.
\* path path of the alignment through similarity score matrix.

## 0.5 Visualizing the aligned chromatograms

We can visualize aligned chromatograms using `plotAlignedAnalytes`. The top figure is experiment unaligned-XICs, middle one is reference XICs, last figure is experiment run aligned to reference.

```
runs <- c("hroest_K120809_Strep0%PlasmaBiolRepl2_R04_SW_filt",
 "hroest_K120809_Strep10%PlasmaBiolRepl2_R04_SW_filt")
AlignObj <- getAlignObjs(analytes = 4618L, runs = runs, dataPath = dataPath)
#> [1] "hroest_K120809_Strep0%PlasmaBiolRepl2_R04_SW_filt"
#> [2] "hroest_K120809_Strep10%PlasmaBiolRepl2_R04_SW_filt"
#> [1] "Finding reference run using m-score."
plotAlignedAnalytes(AlignObj, annotatePeak = TRUE)
#> Warning: Removed 30 row(s) containing missing values (geom_path).
```

![](data:image/png;base64...)

## 0.6 Visualizing the alignment path

We can also visualize the alignment path using `plotAlignemntPath` function.

```
library(lattice)
runs <- c("hroest_K120809_Strep0%PlasmaBiolRepl2_R04_SW_filt",
 "hroest_K120809_Strep10%PlasmaBiolRepl2_R04_SW_filt")
AlignObjOutput <- getAlignObjs(analytes = 4618L, runs = runs,
                               dataPath = dataPath, objType = "medium")
#> [1] "hroest_K120809_Strep0%PlasmaBiolRepl2_R04_SW_filt"
#> [2] "hroest_K120809_Strep10%PlasmaBiolRepl2_R04_SW_filt"
#> [1] "Finding reference run using m-score."
plotAlignmentPath(AlignObjOutput)
```

![](data:image/png;base64...)

## 0.7 Chromatogram smoothing and Peak area

Chromatogram group can be smoothed using Savitzky-Golay, Gaussian, Boxcar or loess smoothing.

```
data("XIC_QFNNTDIVLLEDFQK_3_DIAlignR")
XICs <- XIC_QFNNTDIVLLEDFQK_3_DIAlignR[["run0"]][["14299_QFNNTDIVLLEDFQK/3"]]
XICs.sm <- smoothXICs(XICs, type = "sgolay", samplingTime = 3.42, kernelLen = 9, polyOrd = 3)
plotXICgroup(XICs, Title = "Raw chromatograms")
```

![](data:image/png;base64...)

```
plotXICgroup(XICs.sm, Title = "Smoothed chromatograms")
```

![](data:image/png;base64...)

Calculate area between peak-boundaries using areaIntegrator

```
time <- lapply(XICs, `[[`, 1)
intensity <- lapply(XICs, `[[`, 2)
areaIntegrator(time, intensity, left = 5203.7, right = 5268.5, integrationType = "intensity_sum", baselineType = "base_to_base", fitEMG = FALSE)
#> [1] 139.925
```

## 0.8 Citation

Gupta S, Ahadi S, Zhou W, Röst H. “DIAlignR Provides Precise Retention Time Alignment Across Distant Runs in DIA and Targeted Proteomics.” Mol Cell Proteomics. 2019 Apr;18(4):806-817. doi: <https://doi.org/10.1074/mcp.TIR118.001132>

## 0.9 Session Info

```
sessionInfo()
#> R version 4.0.0 (2020-04-24)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.4 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.11-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.11-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] lattice_0.20-41  DIAlignR_1.0.5   BiocStyle_2.16.0
#>
#> loaded via a namespace (and not attached):
#>  [1] zoo_1.8-8           tidyselect_1.0.0    xfun_0.13
#>  [4] purrr_0.3.4         colorspace_1.4-1    vctrs_0.2.4
#>  [7] htmltools_0.4.0     yaml_2.2.1          blob_1.2.1
#> [10] rlang_0.4.6         pillar_1.4.4        glue_1.4.0
#> [13] DBI_1.1.0           mzR_2.22.0          RColorBrewer_1.1-2
#> [16] BiocGenerics_0.34.0 bit64_0.9-7         jpeg_0.1-8.1
#> [19] lifecycle_0.2.0     stringr_1.4.0       ProtGenerics_1.20.0
#> [22] munsell_0.5.0       gtable_0.3.0        codetools_0.2-16
#> [25] evaluate_0.14       memoise_1.1.0       labeling_0.3
#> [28] latticeExtra_0.6-29 Biobase_2.48.0      knitr_1.28
#> [31] parallel_4.0.0      Rcpp_1.0.4.6        scales_1.1.0
#> [34] BiocManager_1.30.10 magick_2.3          farver_2.0.3
#> [37] bit_1.1-15.2        gridExtra_2.3       png_0.1-7
#> [40] ggplot2_3.3.0       digest_0.6.25       stringi_1.4.6
#> [43] bookdown_0.18       dplyr_0.8.5         ncdf4_1.17
#> [46] grid_4.0.0          tools_4.0.0         magrittr_1.5
#> [49] tibble_3.0.1        RSQLite_2.2.0       crayon_1.3.4
#> [52] tidyr_1.0.3         pkgconfig_2.0.3     ellipsis_0.3.0
#> [55] MASS_7.3-51.6       assertthat_0.2.1    rmarkdown_2.1
#> [58] R6_2.4.1            signal_0.7-6        compiler_4.0.0
```