# INSPEcT-GUI

de Pretis S., Furlan M. and Pelizzola M.

#### 2025-10-30

#### Package

INSPEcT 1.40.0

# Contents

* [1 Introduction](#introduction)
* [2 Run the application from an R session](#run-the-application-from-an-r-session)
* [3 Presentation of the Graphical User Interface](#presentation-of-the-graphical-user-interface)
  + [3.1 Interaction with an object of class *INSPEcT*](#interaction-with-an-object-of-class-inspect)
  + [3.2 Visualization of the RNA dynamics for a single gene](#visualization-of-the-rna-dynamics-for-a-single-gene)
  + [3.3 Model minimization](#modelmin)
  + [3.4 Interaction with individual parameters of RNA kinetic rates](#interaction-with-individual-parameters-of-rna-kinetic-rates)
  + [3.5 Assessing rate variability via confidence intervals estimation](#assessing-rate-variability-via-confidence-intervals-estimation)
* [4 De novo hypothesis generation - Case studies](#denovo)
  + [4.1 Constant RNA kinetic rates](#constant-rna-kinetic-rates)
  + [4.2 Modulation of processing rate](#modulation-of-processing-rate)
  + [4.3 Modulation of the synthesis rate](#modulation-of-the-synthesis-rate)
  + [4.4 Concomitant modulation of synthesis and degradation rates](#concomitant-modulation-of-synthesis-and-degradation-rates)
* [5 Video tutorial](#video-tutorial)
* [6 About this document](#about-this-document)

# 1 Introduction

The life cycle of RNAs is composed of three main steps, i.e. transcription and processing of the premature RNA (\(P\)) and degradation of the mature (\(M\)). The kinetic rates governing these steps define the dynamics of each transcript (\(k\_{1-3}\) for synthesis, processing and degradation, respectively), and their role in transcriptional regulation is often underestimated. A complete understanding of the effects of the rates of the RNA life-cycle on premature and mature RNA requires mathematical and/or computer skills to solve the corresponding system of differential equations:

\[\begin{equation}\label{eq:modelsystem}
\left\{
\begin{array}{l l}
\dot{P}=k\_1 - k\_2 \, \cdot \, P \\
\dot{M}=k\_2 \, \cdot \, P - k\_3 \, \cdot \, M
\end{array}
\right.
\end{equation}\]

This system of differential equations is used by *INSPEcT* to estimate the rates of the RNA-life cycle when transctiptomic data and (possibly) newly-synthesized RNA are available. *INSPEcT* aims at assessing the dynamics of each gene by modeling the temporal behavior of the RNA kinetic rates with either constant or variable functions.

In order to visualize and interact with output of the modelig procedure of *INSPEcT*, and to facilitate the understanding of the impact of RNA kinetic rates on the dynamics of premature and mature RNA, we developed a Graphical User Interface (GUI). Specifically, the GUI allows to:

1. interact with the results of *INSPEcT* analysis on single genes, refining a model, or testing modes of regulation that are alternative to the one identified by *INSPEcT*
2. explore how a given combination of rates results in the dynamical behavior of premature and mature RNA species.

Importantly, we developed two wrapper functions (*inspectFromBAM* and *inspectFromPCR*, see *[INSPEcT](https://bioconductor.org/packages/3.22/INSPEcT/vignettes/INSPEcT)* vignette for more details), which streamline the generation of novel *INSPEcT* datasets, to be uploaded in the GUI.

# 2 Run the application from an R session

The GUI is distributed within the *INSPEcT* package, and starts with the following command line operations:

```
library(INSPEcT)
runINSPEcTGUI()
```

# 3 Presentation of the Graphical User Interface

The GUI is divided into 4 sections (Fig. [1](#fig:fig1)):

* Section 1: interaction with an object of class *INSPEcT*;
* Section 2: visualization of the RNA dynamics for a single gene;
* Section 3: model minimization;
* Section 4: interaction with individual parameters of RNA rates.

![Representation of the GUI divided into its 4 main sections.](data:image/png;base64...)

Figure 1: Representation of the GUI divided into its 4 main sections

## 3.1 Interaction with an object of class *INSPEcT*

At startup, the software loads a predefined *INSPEcT* object, which contains 10 genes and can be used to explore the software functionalities. This object can be replaced by any *INSPEcT* dataset previously saved in the “rds” format (“Choose *INSPEcT* file”, Fig. [2](#fig:fig2)). Genes that are part of the *INSPEcT* object are divided according to their regulation class. This is encoded by a string where letters representing the step(s) of the RNA life-cycle that are regulated (‘s’ for synthesis, ‘p’ for processing and ‘d’ for degradation) are concatenated. For example: “p” represents a gene only regulated in its processing rate, “sd” a gene regulated in its synthesis and degradation rates. When no rates are identified as regulated the corresponding class is named “no-reg”. Once a regulation class is selected via “Select class”, a specific gene can be chosen from the list that appears in “Select gene” (Fig. [2](#fig:fig2)). Experimental profiles might be smoothed to reduce the noise associated with this kind of data (“Smooth experimental data” in “Select input”, Fig. [2](#fig:fig2)). Nonetheless, raw experimental data are selected by default (“Raw experimental data” in “Select input”, Fig. [2](#fig:fig2)). The “User defined” mode in “Select input” will be covered in section [4](#denovo).

![Interaction with an object of class INSPEcT (section 1).](data:image/png;base64...)

Figure 2: Interaction with an object of class INSPEcT (section 1)

## 3.2 Visualization of the RNA dynamics for a single gene

For the selected gene, the experimental quantifications of the premature and mature RNA levels (estimated from RNA-seq data) are plotted together with their standard deviations (Fig. [3](#fig:fig3)). If nascent RNA has been profiled, the rate of synthesis is also considered part of the experimental data (since it directly dereives from nascent RNA profiling), and it is plotted with its standard deviation. Otherwise, the rate of synthesis is inferred from total RNA-seq data and lacks the standard deviation. The results of the *INSPEcT* modeling are plotted with continuous lines within the synthesis, pre-RNA, processing, mature RNA and degradation panels (Fig. [3](#fig:fig3)), and can be downloaded in PDF (image) or TSV (tabular) formats. Below the plot panel, the visualization options allow to:

* switching on/off the logarithmic time-spacing (“Log time”),
* stopping the automatic adjustment of y-axis limits, thus freezing them (“Fix Y-axis”),
* switching from absolute rates and concentrations, to measures that are relative to their initial values (“Rel.Expr.”).

![Visualization of the RNA dynamics for a single gene (section 2).](data:image/png;base64...)

Figure 3: Visualization of the RNA dynamics for a single gene (section 2)

## 3.3 Model minimization

The minimization status corresponding to the modeling is reported in section 3 of the GUI (Fig. [4](#fig:fig4)). In particular, the p-value associated to the goodness-of-fit statistic and the Akaike information criterion indicate the ability of a model to explain the experimental observations. Both these metrics are penalized for the complexity of the model, meaning that they measure a trade-off between its performance and its simplicity, and they can be used to compare models with different complexity. The complexity of a model depends on the functional forms that describe the RNA life-cycle kinetic rates: a constant rate has a complexity of 1, a sigmoidal 4, and impulsive 6, i.e. the number of their parameters. In practice, when two models explain the data adequately well, the simpler one is selected (lower p-value of the goodness-of-fit statistic and lower AIC). Additionally, the goodness-of-fit p-value is used to assess whether the model under consideration adequately explains the experimental data (e.g. p<0.05). Finally, the minimization status is reported, i.e. whether the minimization converged to a local minimum or not. Supplementary iterations can be provided to identify a better minimum, using either Nelder Mead method (NM, used from *INSPEcT*) or the quasi-Newton BFGS method (button “Optimization - Run”).

![Model minimization (section 3).](data:image/png;base64...)

Figure 4: Model minimization (section 3)

## 3.4 Interaction with individual parameters of RNA kinetic rates

Parameters of the modeling can be directly modified “by hand”. In fact, for each kinetic rate of the RNA life-cycle, the parameters describing the selected functional form are provided in the right part of the GUI (Fig. [5](#fig:fig5)). Constant rates are described by a single parameter, which correspond to the value of the rates throughout the time-course. Rather, variable rates can be described either by sigmoid or impulse functions. Sigmoids are S-shaped functions described by four parameters: starting levels, final levels, time of transition between starting and final levels, and slope of the response. Impulse functions allow more complex behaviors with two additional parameters that describe time and levels of a second transition, possibly encoding for bell-shaped responses. The range of the sliders for starting and final levels can be set for each rate (“set min” and “set max”), giving full flexibility in the setting of rates levels. At startup, these ranges are set to cover the range of all parameters of the example dataset. Each time a new dataset is loaded, ranges are updated accordingly.

![Direct interaction with RNA life-cycle kinetic rates (section 4).](data:image/png;base64...)

Figure 5: Direct interaction with RNA life-cycle kinetic rates (section 4)

The user can test regulative scenarios that are alternative to the one selected by *INSPEcT*, by tuning each function parameter, or by changing the functional form assigned to one or more rates. In the latter case, the new parameter settings can be defined by hand, or searched via minimization of the error over the data ([3.3](#modelmin)). Noteworthy, within the derivative framework, variable functional forms are contrained to be identical among kinetic rates. Therefore, a combination of sigmoid (or impulse) and constants is allowed, while sigmoid and impulse cannot be combined. Each time the model is modified, its plot and minimization status are updated.

## 3.5 Assessing rate variability via confidence intervals estimation

The button “Conf.Int.” below the plot panel (Fig. [2](#fig:fig2)) determines 95% confidence intervals of the modeled rates. The running time of this procedure varies according to the analysis framework, the number of time points, and the complexity of the model. The analysis framework depends on the settings of *INSPEcT* at the time of generation of the loaded dataset. In general, the quantification of confidence intervals is faster in the Derivative framework, and slower in the Integrative (in the worse case, up to few minutes). Confidence intervals are then used to assess the variability of each rate, testing the null hypothesis that the rate profile can be fit by a constant model. Test p-values are reported into the y-axis labels of the corresponding rate. Every change in the model requires a fresh computation of confidence intervals, for this reason, especially in the integrative framework, it is suggested to compute confidence intervals when the model is considered definitive.

# 4 De novo hypothesis generation - Case studies

The procedure explained in the previous sections mostly refers to the interaction with experimental data. Nonetheless, the software is designed also to test hypothesis independently from experiments. This can be easily achieved by choosing “User defined (No input)” in “Select input” (Fig. [2](#fig:fig2)). In this mode, neither the row or smooth experimental data, nor the minimization status are represented. The user is thus free to set the functional form (and the corresponding parameters) for each RNA kinetic rate, directly assessing the impact on premature and mature RNA dynamics. In the following subsections, we report some case studies to exemplify the role of the RNA kinetic rates in the definition of premature and mature RNA dynamics.

## 4.1 Constant RNA kinetic rates

The combination of kinetic rates determines the abundance of mature and premature RNA species. Specifically, the ratio between the rates of synthesis and processing sets premature RNA levels, and the ratio between synthesis and degradation sets the mature ones. When no perturbations occur, this long standing condition is called steady state. (Set rates to: synthesis = constant{10}; processing = constant{20}; degradation = constant{2})

![Case study 1: constant kinetic rates.](data:image/png;base64...)

Figure 6: Case study 1: constant kinetic rates

As a consequence of this, steady state premature RNA levels are independent from degradation rates, and (more importantly and less intuitively) steady state mature RNA levels are independent from processing rates.

## 4.2 Modulation of processing rate

As mentioned above, steady state mature RNA levels are independent from processing rates. Nonetheless, a perturbation in the processing dynamics leads to a transient variation of mature RNA levels. Conversely, it produces a lasting effect on premature RNA levels. (Set rates to: synthesis = constant{10}; processing = sigmoidal{5,20,8,1}; degradation = constant{2})

![Case study 2: modulation of processing rate.](data:image/png;base64...)

Figure 7: Case study 2: modulation of processing rate

Noteworthy, a reduction in the rate of degradation reduces the amplitude of mature RNA perturbation. (Set degradation = constant{0.5})

## 4.3 Modulation of the synthesis rate

A modulation in the synthesis rate determines a similar modulation for premature and mature RNAs (in terms of fold change compared to the untreated condition). (Set rates to: synthesis = sigmoidal{10,20,8,1}; processing = constant{20}; degradation = constant{2})

![Case study 3: modulation of synthesis rate.](data:image/png;base64...)

Figure 8: Case study 3: modulation of synthesis rate

Noteworthy, the time-lag between the modulation of synthesis and the response of premature RNA is inversely proportional to the processing rate (Set processing = constant{10}). Following the same logic, the time-lag between the reponse of premature and mature RNAs is inversely proportional to the degradation rate (Set degradation = constant{0.5}).

## 4.4 Concomitant modulation of synthesis and degradation rates

When synthesis and degradation rates are modulated in the same direction, they apply an opposite effect on mature RNA levels, leaving trace of the transcriptional regulation only on premature RNA levels (a similar response has been observed in yeast, during heat shock responses). (Set rates to: synthesis = sigmoidal{10,20,8,1}; processing = constant{20}; degradation = sigmoidal{0.25,0.5,8,1}). Rather, the opposite modulation of synthesis and degradation reinforces the modulation of mature RNA. (Set degradation = sigmoidal{0.5,0.25,8,1})

![Case study 4: concomitant modulation of synthesis and degradation rates.](data:image/png;base64...)

Figure 9: Case study 4: concomitant modulation of synthesis and degradation rates

# 5 Video tutorial

# 6 About this document

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
##  [1] TxDb.Mmusculus.UCSC.mm9.knownGene_3.2.2
##  [2] GenomicFeatures_1.62.0
##  [3] AnnotationDbi_1.72.0
##  [4] GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0
##  [6] IRanges_2.44.0
##  [7] S4Vectors_0.48.0
##  [8] INSPEcT_1.40.0
##  [9] BiocParallel_1.44.0
## [10] Biobase_2.70.0
## [11] BiocGenerics_0.56.0
## [12] generics_0.1.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            rootSolve_1.8.2.4
##  [3] dplyr_1.1.4                 farver_2.1.2
##  [5] blob_1.2.4                  Biostrings_2.78.0
##  [7] S7_0.2.0                    bitops_1.0-9
##  [9] fastmap_1.2.0               RCurl_1.98-1.17
## [11] promises_1.4.0              GenomicAlignments_1.46.0
## [13] pROC_1.19.0.1               XML_3.99-0.19
## [15] digest_0.6.37               mime_0.13
## [17] lifecycle_1.0.4             KEGGREST_1.50.0
## [19] RSQLite_2.4.3               magrittr_2.0.4
## [21] compiler_4.5.1              rlang_1.1.6
## [23] sass_0.4.10                 tools_4.5.1
## [25] yaml_2.3.10                 rtracklayer_1.70.0
## [27] knitr_1.50                  S4Arrays_1.10.0
## [29] bit_4.6.0                   curl_7.0.0
## [31] DelayedArray_0.36.0         RColorBrewer_1.1-3
## [33] KernSmooth_2.23-26          abind_1.4-8
## [35] grid_4.5.1                  xtable_1.8-4
## [37] ggplot2_4.0.0               scales_1.4.0
## [39] MASS_7.3-65                 tinytex_0.57
## [41] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
## [43] cli_3.6.5                   rmarkdown_2.30
## [45] crayon_1.5.3                otel_0.2.0
## [47] httr_1.4.7                  rjson_0.2.23
## [49] readxl_1.4.5                DBI_1.2.3
## [51] cachem_1.1.0                parallel_4.5.1
## [53] cellranger_1.1.0            BiocManager_1.30.26
## [55] XVector_0.50.0              restfulr_0.0.16
## [57] matrixStats_1.5.0           vctrs_0.6.5
## [59] Matrix_1.7-4                jsonlite_2.0.0
## [61] bookdown_0.45               bit64_4.6.0-1
## [63] magick_2.9.0                locfit_1.5-9.12
## [65] plgem_1.82.0                jquerylib_0.1.4
## [67] glue_1.8.0                  codetools_0.2-20
## [69] gtable_0.3.6                later_1.4.4
## [71] BiocIO_1.20.0               tibble_3.3.0
## [73] pillar_1.11.1               htmltools_0.5.8.1
## [75] deSolve_1.40                R6_2.6.1
## [77] shiny_1.11.1                evaluate_1.0.5
## [79] lattice_0.22-7              cigarillo_1.0.0
## [81] png_0.1-8                   Rsamtools_2.26.0
## [83] memoise_2.0.1               httpuv_1.6.16
## [85] bslib_0.9.0                 Rcpp_1.1.0
## [87] SparseArray_1.10.0          DESeq2_1.50.0
## [89] xfun_0.53                   MatrixGenerics_1.22.0
## [91] pkgconfig_2.0.3
```