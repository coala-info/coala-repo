# peakPantheR Graphical User Interface

#### Arnaud Wolfer

#### 2020-10-11

**Package**: *[peakPantheR](https://bioconductor.org/packages/3.22/peakPantheR)*
 **Authors**: Arnaud Wolfer, Goncalo Correia

# Introduction

The `peakPantheR` package is designed for the detection, integration and reporting of pre-defined features in MS files (*e.g. compounds, fragments, adducts, …*).

The graphical user interface implements all of `peakPantheR`’s functionalities and can be preferred to understand the methodology, select the best parameters on a subset of the samples before running the command line, or to visually explore results.

Using the *[faahKO](https://bioconductor.org/packages/3.22/faahKO)* raw MS dataset as an example, this vignette will:

* Detail the step-by-step use of the **graphical user interface**
* Apply the **GUI** to a subset of pre-defined features in the *[faahKO](https://bioconductor.org/packages/3.22/faahKO)* dataset

## Abbreviations

* **ROI**: *Regions Of Interest*
  + reference *RT* / *m/z* windows in which to search for a feature
* **uROI**: *updated Regions Of Interest*
  + modifed ROI adapted to the current dataset which override the reference ROI
* **FIR**: *Fallback Integration Regions*
  + *RT* / *m/z* window to integrate if no peak is found

## Example Data

This vignette employ the `.csv` or `.RData` files generated from *[faahKO](https://bioconductor.org/packages/3.22/faahKO)* in the vignette [Getting Started with peakPantheR](getting-started.html).

## Getting Started

The graphical user interface is started as follow:

```
library(peakPantheR)

peakPantheR_start_GUI(browser = TRUE)
#  To exit press ESC in the command line
```

> The graphical interface is divided in 5 main tabs, **Import Data**, **Run annotation**, **Diagnostic: plot & update**, **View results** and **Export results**.

\(~\)

# Graphical User Interface

## Import

The first input format is using a `.RData` file containing a *peakPantheRAnnotation* named `annotationObject`. This object can be annotated or not, for example loading a previously run annotation (*see the **Export** section for more details*).

![](data:image/png;base64...)

\(~\)

The second input format consists of multiple `.csv` files describing the targeted features, spectra to process and corresponding metadata (optional). Spectra can also be directly selected on disk.

![](data:image/png;base64...)

\(~\)

## Run Annotation

With the targeted features and spectra defined, **Run annotation** handles the fitting parameter selection as well as downstream computation. First the use of updated regions of interest (`uROI`) and fallback integration regions (`FIR`) can be selected if available. If `uROI` haven’t been previously defined, the option will be crossed out. Secondly the curve fitting model to use can be selected from the interface. Finally `Parallelisation` enables the selection of the number of CPU cores to employ for parallel file access and processing.

![](data:image/png;base64...)

\(~\)

## Diagnostic: plot & update

> **Note:**
>
> The targeted regions of interest (`ROI`) should represent a good starting point for feature integration, however it might be necessary to refine these boundary box to the specific analytical run considered. This ensures a successful integration over all the spectra irrespective of potential chromatographic equilibration differences or retention time drift.
>
> Updated regions of interest (`uROI`) can be defined and will supplant `ROI`. `uROI` can for example be manually defined to “tighten” or correct the `ROI` and avoid erroneous integration. Another use of `uROI` is to encompass the integration region in each sample throughout the run without targeting any excess spectral region that would interfere with the correct analysis.
>
> Fallback integration regions (`FIR`) are defined as spectral regions that will be integrated (*i.e. integrating the baseline signal*) when no successful chromatographic peak could be detected in a sample. `FIR` shouldn’t reasonably stretch further than the minimum and maximum bound (*RT* / *m/z*) of all found peaks across all samples for a given feature: this way no excess signal will be considered.

\(~\)

With all features integrated in all samples, **Diagnostic** provide tools to assess the quality of the peak integration and refine integration boundaries by setting `uROI` and `FIR` adapted to the specific chromatographic run being processed.

\(~\)

`Annotation statistics` summarises the success in integrating each targeted feature. The `ratio of peaks found (%)`, `ratio of peaks filled (%)` and the average `ppm error` and `RT deviation (s)` will highlight a feature that wasn’t reliably integrated over a large number of samples. Visual evaluation (*see below*) and the adjustment of `uROI` or `FIR` might assist in tuning the integration of said feature.

![](data:image/png;base64...)

\(~\)

`Update uROI/FIR` automatically sets `uROI` and `FIR` for each feature based on the *RT* / *m/z* boundaries of the peaks successfully integrated.

![](data:image/png;base64...)

\(~\)

`Diagnostic plot` offer a visualisation of a selected feature across all samples in order of analysis. This visualisation highlights the fitting of the feature in each sample, as well as the change in *RT* / *m/z* (of the peak apex) and peak area through time. Samples can be automatically coloured based on a *sample metadata* column.

![](data:image/png;base64...)

\(~\)

Once `uROI` and `FIR` are successfully set, it is possible to go back to the **Run annotation** tab and refit all features in all samples (*Note: this will overwrite the current results*).

\(~\)

## View results

If the features integration are satisfactory, **View results** regroups all the integration results

\(~\)

`Overall results` displays a fitting property for all targeted features (*as columns*) and all spectra (*as rows*).

![](data:image/png;base64...)

\(~\)

`Results per targeted feature` displays all fitting properties (*as columns*) for all samples (*as rows*) for a selected targeted feature.

![](data:image/png;base64...)

\(~\)

`Results per sample` displays all fitting properties (*as columns*) for all targeted features (*as rows*) for a selected sample.

![](data:image/png;base64...)

\(~\)

## Export

The **Export** tab manages the saving of input parameters, annotation results and automated reporting.

The `peakPantheRAnnotation` in it’s current state can be saved as a `.RData` file which can subsequently be reloaded. The `.csv` files defining the current analysis can also be exported to reproduce the current processing.

All diagnostic plots from the `Diagnostic` tab can be automatically saved to disk for rapid evaluation. This can be executed in parallel if a large number of plots have to be generated.

Finally each fitting property can be saved as a `.csv` file with all samples as *rows* and all targeted features as *columns*. Additionally a *summary* table will present the integration success rate for each targeted feature.

![](data:image/png;base64...)

\(~\)

# Final Note

If a very high number of targeted features and samples are to be processed, `peakPantheR`’s command line functions are more efficient, as they can be integrated in scripts and the reporting automated.

\(~\)

# See Also

* [Getting Started with peakPantheR](getting-started.html)
* [Real Time Annotation](real-time-annotation.html)
* [Parallel Annotation](parallel-annotation.html)

\(~\)

# Session Information

```
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package              * version   date (UTC) lib source
#>  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  affy                   1.88.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  affyio                 1.80.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationFilter       1.34.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biobase              * 2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocBaseUtils          1.12.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel           1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  clue                   0.3-66    2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  data.table             1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  devtools               2.4.6     2025-10-03 [2] CRAN (R 4.5.1)
#>  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  doParallel           * 1.0.17    2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  DT                     0.34.0    2025-09-02 [2] CRAN (R 4.5.1)
#>  ellipsis               0.3.2     2021-04-29 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  faahKO               * 1.49.1    2025-10-28 [2] Bioconductor 3.22 (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  foreach              * 1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
#>  fs                     1.6.6     2025-04-12 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges          1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2                4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  hms                    1.1.4     2025-10-17 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
#>  httpuv                 1.6.16    2025-04-16 [2] CRAN (R 4.5.1)
#>  igraph                 2.2.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  impute                 1.84.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  IRanges                2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iterators            * 1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
#>  later                  1.4.4     2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval               0.2.2     2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  limma                  3.66.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  magick                 2.9.0     2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  MALDIquant             1.22.3    2024-08-19 [2] CRAN (R 4.5.1)
#>  MASS                   7.3-65    2025-02-28 [3] CRAN (R 4.5.1)
#>  MassSpecWavelet        1.76.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics         1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats            1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  MetaboCoreUtils        1.18.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  mime                   0.13      2025-03-17 [2] CRAN (R 4.5.1)
#>  minpack.lm             1.2-4     2023-09-11 [2] CRAN (R 4.5.1)
#>  MsCoreUtils            1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MsExperiment           1.12.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MsFeatures             1.18.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MSnbase              * 2.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MultiAssayExperiment   1.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  mzID                   1.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  mzR                  * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ncdf4                  1.24      2025-03-25 [2] CRAN (R 4.5.1)
#>  otel                   0.2.0     2025-08-29 [2] CRAN (R 4.5.1)
#>  pander               * 0.6.6     2025-03-01 [2] CRAN (R 4.5.1)
#>  pcaMethods             2.2.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  peakPantheR          * 1.24.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgbuild               1.4.8     2025-05-26 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  pkgload                1.4.1     2025-09-23 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  pracma                 2.4.6     2025-10-22 [2] CRAN (R 4.5.1)
#>  preprocessCore         1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  prettyunits            1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  progress               1.2.3     2023-12-06 [2] CRAN (R 4.5.1)
#>  promises               1.4.0     2025-10-22 [2] CRAN (R 4.5.1)
#>  ProtGenerics         * 1.42.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  PSMatch                1.14.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  purrr                  1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  QFeatures              1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                 * 1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  remotes                2.5.0     2024-03-17 [2] CRAN (R 4.5.1)
#>  reshape2               1.4.4     2020-04-09 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo                1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo            1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  shiny                  1.11.1    2025-07-03 [2] CRAN (R 4.5.1)
#>  shinycssloaders        1.1.0     2024-07-30 [2] CRAN (R 4.5.1)
#>  SparseArray            1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Spectra                1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  statmod                1.5.1     2025-10-09 [2] CRAN (R 4.5.1)
#>  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment   1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  svglite                2.2.2     2025-10-21 [2] CRAN (R 4.5.1)
#>  systemfonts            1.3.1     2025-10-01 [2] CRAN (R 4.5.1)
#>  textshaping            1.0.4     2025-10-10 [2] CRAN (R 4.5.1)
#>  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr                  1.3.1     2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  tinytex                0.57      2025-04-15 [2] CRAN (R 4.5.1)
#>  usethis                3.2.1     2025-09-06 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  vsn                    3.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xcms                   4.8.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  xfun                   0.53      2025-08-19 [2] CRAN (R 4.5.1)
#>  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  xtable                 1.8-4     2019-04-21 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/Rtmp46dGQn/Rinst22f71f76053c79
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```