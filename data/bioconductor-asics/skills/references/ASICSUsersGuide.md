# ASICS User’s Guide

Gaëlle Lefort, Rémi Servien and Nathalie Vialaneix

#### 2020-11-23

This user’s guide provides an overview of the package `ASICS`. `ASICS` is a
fully automated procedure to identify and quantify metabolites in \(^1\)H 1D-NMR
spectra of biological mixtures (Tardivel *et al.*, 2017). It will enable
empowering NMR-based metabolomics by quickly and accurately helping experts to
obtain metabolic profiles. In addition to the quantification method, several
functions allowing spectrum preprocessing or statistical analyses of quantified
metabolites are available.

```
library(ASICS)
library(ASICSdata)
```

# 1 Dataset

In this user’s guide, a subset of the public datasets from Salek *et al.* (2007)
is used. The experiment has been designed to improve the understanding of early
stage of type 2 diabetes mellitus (T2DM) development.
In the dataset used, \(^1\)H-NMR human metabolome was obtained from 25 healthy
volunteers and 25 T2DM patients. Raw 1D Bruker spectral data files were found in
the MetaboLights database (<https://www.ebi.ac.uk/metabolights/>, study MTBLS1).

# 2 Parallel environment

For most time consumming functions, a parallel implementation is available for
unix-like OS using the BiocParallel package of Bioconductor. The number of used
cores is set with the option `ncores` of the corresponding functions (default
to `1`, no parallel environment).

# 3 Library of pure NMR metabolite spectrum

An object of class `PureLibrary` with spectra of pure metabolites is required to
perform the quantification. Such a reference library is provided in `ASICS` with
191 pure metabolite spectra. These spectra are metabolite spectra used as
references for quantification: only metabolites that are present in the library
object can be identified and quantified with `ASICS`.

The default library is automatically loaded at package start. Available
metabolites are displayed with:

```
head(getSampleName(pure_library), n = 8)
```

```
## [1] "1,3-Diaminopropane"   "Levoglucosan"         "1-Methylhydantoin"
## [4] "1-Methyl-L-Histidine" "QuinolinicAcid"       "2-AminoAdipicAcid"
## [7] "2-AminobutyricAcid"   "2-Deoxyadenosine"
```

This library can be complemented or another library can be created with new
spectra of pure metabolites. These spectra are imported from Bruker files and
a new library can be created with:

```
pure_spectra <- importSpectraBruker(system.file("extdata", "example_library",
                                                package = "ASICS"))
new_pure_library <- createPureLibrary(pure_spectra,
                                        nb.protons = c(5, 4))
```

A new library can also be created from txt or csv files, with samples in columns
and chemical shifts in rows (see help page of `createPureLibrary` function for
all details).

The newly created library can be used for quantification or merged with another
one:

```
merged_pure_library <- c(pure_library[1:10], new_pure_library)
```

The `PureLibrary` `merged_pure_library` contains the first ten spectra of the
default library and the two newly imported spectra.

# 4 Identification and quantification of metabolites with ASICS

First, data are imported in a data frame from Bruker files with the
`importSpectraBruker` function. These spectra are baseline corrected
(Wang *et al*, 2013) and normalised by the area under the curve.

```
spectra_data <- importSpectraBruker(system.file("extdata",
                                                "Human_diabetes_example",
                                                package = "ASICSdata"))
```

Data can also be imported from other file types with `importSpectra` function.
The only constraint is to have a data frame with spectra in columns
(column names are sample names) and chemical shifts in rows (row names
correspond to the ppm grid).

```
diabetes <- system.file("extdata", package = "ASICSdata")
spectra_data_txt <- importSpectra(name.dir = diabetes,
                                  name.file = "spectra_diabetes_example.txt",
                                  type = "txt")
```

Several functions for the preprocessing of spectra are also available:
normalisation and alignment on a reference spectrum
(based on Vu et al. (2011)).

Many types of normalisation are available. By default, spectra are normalised
to a constant sum (`type.norm = "CS"`). Otherwise, a normalisation method
implemented in the `PepsNMR` package could be used. For example:

```
spectra_norm <- normaliseSpectra(spectra_data_txt, type.norm = "pqn")
```

```
## Normalisation method : pqn
```

The alignment algorithm is based on Vu et al. (2011). To find the reference
spectrum, the FFT cross-correlation is used. Then the
alignment is performed using the FFT cross-correlation and a hierarchical
classification.

```
spectra_align <- alignSpectra(spectra_norm)
```

Finally, from the data frame, a `Spectra` object is created. This is a required
step for the quantification.

```
spectra_obj <- createSpectra(spectra_align)
```

Identification and quantification of metabolites can now be carried out using
only the function `ASICS`. All the steps described in the following figure are
included:

![](data:image/png;base64...)

Steps of the quantification workflow

Recently, new methods for reference library alignment and metabolite
quantification were added. Thus, multiple scenarios can be performed:

![Scenarios available in ASICS](data:image/png;base64...)
The method provided in the first version of the package is given in red. It can
now be used by setting `joint.align = FALSE` and `quantif.method = "FWER"`. To
perform a joint alignment (blue, green and yellow scenarios), `joint.align`
needs to be set to `TRUE`. The yellow scenario that performs joint
quantification based on a simple joint alignment is obtained by additionally
setting `quantif.method = "Lasso"`. Finally, the green scenario performs a joint
quantification using metabolites identified with a first step consisting of
independent quantification. It is obtained by setting `quantif.method = "both"`.

With `quantif.method = "both"`, the number of identified metabolites can be
controlled using `clean.thres`. If `clean.thres = 10`, only the metabolites
identified in at least 10% of the complex spectra (during the first independant
quantification step) are used in the joint quantification.

More details on these new algorithms can be found in Lefort *et al.* (2020).

`ASICS` function takes approximately 2 minutes per
spectrum to run. To control randomness in the algorithm (used in the estimation
of the significativity of a given metabolite concentration), the `set.seed`
parameter can be used.

```
# part of the spectrum to exclude (water and urea)
to_exclude <- matrix(c(4.5, 5.1, 5.5, 6.5), ncol = 2, byrow = TRUE)
ASICS_results <- ASICS(spectra_obj, exclusion.areas = to_exclude)
```

Summary of ASICS results:

```
ASICS_results
```

```
## An object of class ASICSResults
## It contains 50 spectra of 31087 points.
##
## ASICS results:
##  162 metabolites are identified for this set of spectra.
## Most concentrated metabolites are: Creatinine, Citrate, AceticAcid, L-GlutamicAcid, L-Glycine, L-Proline
```

The quality of the results can be assessed by stacking the original and
the reconstructed spectra on one plot. A pure metabolite spectrum can also be
added for visual comparison. For example, the first spectrum with Creatinine:

```
plot(ASICS_results, idx = 1, xlim = c(2.8, 3.3), add.metab = "Creatinine")
```

![](data:image/png;base64...)

Relative concentrations of identified metabolites are saved in a data frame
accessible via the `get_quantification` function:

```
head(getQuantification(ASICS_results), 10)[, 1:2]
```

```
##                   ADG10003u_007 ADG10003u_008
## Creatinine          0.027524645   0.016992328
## Citrate             0.009818148   0.003665571
## AceticAcid          0.004454905   0.000000000
## L-GlutamicAcid      0.002655211   0.001562384
## L-Glycine           0.002147344   0.002070631
## L-Proline           0.001960824   0.003139267
## 2-AminoAdipicAcid   0.001943956   0.001038924
## D-Mannose           0.001916896   0.002843512
## L-Aspartate         0.001868333   0.004047524
## ThreonicAcid        0.001803600   0.000000000
```

# 5 Analysis on relative quantifications

Some analysis functions are also available in `ASICS`.

First, a design data frame is imported. In this data frame, the first column
needs to correspond to sample names of all spectra.

```
design <- read.table(system.file("extdata", "design_diabete_example.txt",
                                 package = "ASICSdata"), header = TRUE)
```

Then, a preprocessing is performed on relative quantifications: metabolites with
more than 75% of null quantifications are removed as well as two samples that
are considered as outliers.

```
analysis_data <- formatForAnalysis(getQuantification(ASICS_results),
                                   design = design, zero.threshold = 75,
                                   zero.group = "condition",
                                   outliers = c("ADG10003u_007",
                                                "ADG19007u_163"))
```

To explore results of ASICS quantification, a PCA can be performed on results of
preprocessing with:

```
resPCA <- pca(analysis_data)
```

```
## Warning: 'info.txtC = NULL' argument value is deprecated; use 'info.txtC =
## 'none'' instead.
```

```
## Warning: 'fig.pdfC = NULL' argument value is deprecated; use 'fig.pdfC = 'none''
## instead.
```

```
plot(resPCA, graph = "ind", col.ind = "condition")
```

![](data:image/png;base64...)

```
plot(resPCA, graph = "var")
```

![](data:image/png;base64...)

It is also possible to find differences between two conditions with an OPLS-DA
(Thevenot *et al*, 2015) or with Kruskall-Wallis tests:

```
resOPLSDA <- oplsda(analysis_data, condition = "condition", orthoI = 1)
resOPLSDA
```

```
## OPLS-DA performed on quantifications
## Cross validation error: 0.12
##
## Variable with the higher VIP:
##                       Control Group diabetes mellitus      VIP influential
## L-Citrulline           1.577558e-03      6.348160e-04 2.293155        TRUE
## Galactitol             1.062704e-03      2.947166e-04 2.259247        TRUE
## D-Glucose-6-Phosphate  1.718698e-03      2.042602e-03 2.046632        TRUE
## Trimethylamine         0.000000e+00      3.390938e-05 1.885807        TRUE
## Uracil                 1.290575e-03      4.742019e-04 1.862658        TRUE
## 3-PhenylPropionicAcid  6.515734e-04      8.718475e-04 1.818105        TRUE
## D-GluconicAcid         7.105618e-04      1.667304e-03 1.797962        TRUE
## 2-Oxobutyrate          4.440598e-05      5.164097e-04 1.754901        TRUE
## UrocanicAcid           1.578936e-05      1.932797e-04 1.713738        TRUE
## Levoglucosan           7.772079e-04      3.861891e-04 1.683468        TRUE
## [...]
```

```
plot(resOPLSDA)
```

![](data:image/png;base64...)

Results of Kruskall-Wallis tests and Benjamini-Hochberg correction:

```
resTests <- kruskalWallis(analysis_data, "condition")
resTests
```

```
## Kruskal-Wallis tests performed on quantifications
## Variable with the lower adjusted p-value:
##
##                  Feature Adjusted.p.value
## 1           L-Citrulline     9.789748e-05
## 2             Galactitol     2.703854e-04
## 3               Glycerol     3.268214e-03
## 4           Ethanolamine     1.624328e-02
## 5                 Uracil     6.168396e-02
## 6  D-Glucose-6-Phosphate     6.568338e-02
## 7         D-GluconicAcid     9.634158e-02
## 8                Inosine     1.117938e-01
## 9           Trigonelline     1.148400e-01
## 10         2-Oxobutyrate     1.617243e-01
## [...]
```

```
plot(resTests)
```

![](data:image/png;base64...)

# 6 Analysis on buckets

An analysis on buckets can also be performed. An alignment is required before
the spectrum bucketing:

```
spectra_align <- alignSpectra(spectra_norm)
spectra_bucket <- binning(spectra_align)
```

Alignment visualization:

```
spectra_obj_align <- createSpectra(spectra_align)

plotAlignment(spectra_obj, xlim = c(3.5,4))
```

![](data:image/png;base64...)

```
plotAlignment(spectra_obj_align, xlim = c(3.5,4))
```

![](data:image/png;base64...)

Then, a `SummarizedExperiment` object is created with the `formatForAnalysis`
function as for quantification:

```
analysis_data_bucket <- formatForAnalysis(spectra_bucket, design = design,
                                          zero.threshold = 75)
```

Finally, all analyses can be carried out on this object with the parameter
`type.data` set to `buckets`. For example, the OPLS-DA is performed with:

```
resOPLSDA_buckets <- oplsda(analysis_data_bucket, condition = "condition",
                            type.data = "buckets")
resOPLSDA_buckets
```

```
## OPLS-DA performed on buckets
## Cross validation error: 0.12
##
## Variable with the higher VIP:
##       Control Group diabetes mellitus      VIP influential
## 8.935 -1.133369e-05      3.615169e-07 2.240782        TRUE
## 4.115  1.014203e-03      1.317695e-03 2.164346        TRUE
## 3.785  4.080651e-03      4.902450e-03 2.144845        TRUE
## 8.625 -1.267405e-05      6.430714e-06 2.093072        TRUE
## 3.685  8.273601e-03      5.333275e-03 2.090887        TRUE
## 4.245  7.322459e-04      4.692211e-04 2.074871        TRUE
## 9.735 -8.501084e-06      2.194731e-06 2.063978        TRUE
## 6.335  1.075097e-05      3.006047e-05 2.036788        TRUE
## 5.255  2.055731e-04      3.849152e-04 2.032645        TRUE
## 8.635 -7.321572e-06      7.141929e-06 1.968756        TRUE
## [...]
```

Moreover, another plot with the median spectrum and OPLS-DA results can be
produced with the option `graph = "buckets"`:

```
plot(resOPLSDA_buckets, graph = "buckets")
```

![](data:image/png;base64...)

# 7 References

Lefort G., Liaubet L., Marty-Gasset N., Canlet C., Vialaneix N., Servien R. . 2020. Pre-print, <https://www.biorxiv.org/content/10.1101/2020.10.08.331090v1>.

Tardivel P., Canlet C., Lefort G., Tremblay-Franco M., Debrauwer L., Concordet
D., Servien R. (2017). ASICS: an automatic method for identification and
quantification of metabolites in complex 1D 1H NMR spectra. *Metabolomics*,
**13**(10), 109. <https://doi.org/10.1007/s11306-017-1244-5>

Salek, R. M., Maguire, M. L., Bentley, E., Rubtsov, D. V., Hough, T.,
Cheeseman, M., … & Connor, S. C. (2007). A metabolomic comparison of urinary
changes in type 2 diabetes in mouse, rat, and human. *Physiological genomics*,
**29**(2), 99-108.

Wang, K. C., Wang, S. Y., Kuo, C. H., Tseng, Y. J. (2013). Distribution-based
classification method for baseline correction of metabolomic 1D proton nuclear
magnetic resonance spectra. *Analytical Chemistry*, **85**(2), 1231–1239.

Vu, T. N., Valkenborg, D., Smets, K., Verwaest, K. A., Dommisse, R., Lemiere,
F., … & Laukens, K. (2011). An integrated workflow for robust alignment and
simplified quantitative analysis of NMR spectrometry data.
*BMC bioinformatics*, **12**(1), 405.

Thevenot, E.A., Roux, A., Xu, Y., Ezan, E., Junot, C. 2015. Analysis of the
human adult urinary metabolome variations with age, body mass index and gender
by implementing a comprehensive workflow for univariate and OPLS statistical
analyses. *Journal of Proteome Research*. **14**, 3322-3335.

# 8 Session information

This user’s guide has been created with the following system configuration:

```
sessionInfo()
```

```
## R version 4.0.3 (2020-10-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.4 LTS
##
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.7.1
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.7.1
##
## locale:
##  [1] LC_CTYPE=fr_FR.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=fr_FR.UTF-8        LC_COLLATE=fr_FR.UTF-8
##  [5] LC_MONETARY=fr_FR.UTF-8    LC_MESSAGES=fr_FR.UTF-8
##  [7] LC_PAPER=fr_FR.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=fr_FR.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ASICSdata_1.8.0  ASICS_2.6.1      BiocStyle_2.16.1
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.5                  mvtnorm_1.1-1
##  [3] lattice_0.20-41             zoo_1.8-8
##  [5] ropls_1.20.0                glmnet_4.0-2
##  [7] digest_0.6.27               foreach_1.5.1
##  [9] R6_2.5.0                    GenomeInfoDb_1.24.2
## [11] plyr_1.8.6                  stats4_4.0.3
## [13] evaluate_0.14               ggplot2_3.3.2
## [15] pillar_1.4.6                zlibbioc_1.34.0
## [17] rlang_0.4.8                 nloptr_1.2.2.2
## [19] S4Vectors_0.26.1            Matrix_1.2-18
## [21] rmarkdown_2.5               labeling_0.4.2
## [23] splines_4.0.3               BiocParallel_1.22.0
## [25] stringr_1.4.0               RCurl_1.98-1.2
## [27] munsell_0.5.0               DelayedArray_0.14.1
## [29] compiler_4.0.3              xfun_0.18
## [31] pkgconfig_2.0.3             BiocGenerics_0.34.0
## [33] shape_1.4.5                 htmltools_0.5.0
## [35] tidyselect_1.1.0            SummarizedExperiment_1.18.2
## [37] tibble_3.0.4                gridExtra_2.3
## [39] GenomeInfoDbData_1.2.3      bookdown_0.21
## [41] quadprog_1.5-8              IRanges_2.22.2
## [43] codetools_0.2-16            matrixStats_0.57.0
## [45] crayon_1.3.4                dplyr_1.0.2
## [47] MASS_7.3-53                 bitops_1.0-6
## [49] grid_4.0.3                  gtable_0.3.0
## [51] lifecycle_0.2.0             magrittr_1.5
## [53] PepsNMR_1.6.1               scales_1.1.1
## [55] stringi_1.5.3               farver_2.0.3
## [57] XVector_0.28.0              reshape2_1.4.4
## [59] ptw_1.9-15                  ellipsis_0.3.1
## [61] generics_0.1.0              vctrs_0.3.4
## [63] RColorBrewer_1.1-2          iterators_1.0.13
## [65] tools_4.0.3                 Biobase_2.48.0
## [67] glue_1.4.2                  purrr_0.3.4
## [69] parallel_4.0.3              survival_3.2-7
## [71] yaml_2.2.1                  colorspace_1.4-1
## [73] BiocManager_1.30.10         GenomicRanges_1.40.0
## [75] knitr_1.30
```