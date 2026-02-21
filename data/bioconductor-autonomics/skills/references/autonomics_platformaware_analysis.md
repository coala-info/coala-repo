# autonomics: platform-aware analysis

### read + preprocess + analyze + plot cross-platform omics data

#### 29 October 2025

# Contents

* [Abstract](#abstract)
* [1 RNAseq](#rnaseq)
  + [read\_rnaseq\_counts](#read_rnaseq_counts)
  + [read\_rnaseq\_bams](#read_rnaseq_bams)
  + [cpm/tmm/voom effects on power](#cpmtmmvoom-effects-on-power)
* [2 Proteingroups/phosphosites](#proteingroupsphosphosites)
  + [LFQ intensities](#lfq-intensities)
  + [Normalized ratios](#normalized-ratios)
* [3 Metabolon](#metabolon)
* [4 Somascan](#somascan)
* [SessionInfo](#sessioninfo)
* [References](#references)
* **Appendix**

# Abstract

`autonomics` is created to make cross-platform omics analysis intuitive and enjoyable. It contains **import + preprocess + analyze + visualize** one-liners for *RNAseq*, *MS proteomics*, *SOMAscan* and *Metabolon* platforms and a *generic* importer for data from *any rectangular omics file*. With a focus on not only automation but also customization, these importers have a flexible `formula`/ `block`/`contrastdefs` interface which allows to define any statistical formula, fit any general linear model, quantify any contrast, and use random effects or precision weights if required, building on top of the powerful `limma` platform for statistical analysis. It also offers exquisite support for analyzing **complex designs** such as the innovative **contrastogram** visualization to unravel and summarize the differential expression structure in complex designs. By autonomating repetitive tasks, generifying common steps, and intuifying complex designs, it makes cross-platform omics data analysis a fun experience. Try it and enjoy :-).

Autonomics offers **import + preprocess + analyze + visualize** one-liners for *RNAseq*, *MS proteomics*, *SOMAscan* and *Metabolon* platforms, as well a *generic* importer for data from *any rectangular omics file*. We will discuss each of these in more detail in the following sections, but all of them follow the following general steps:

* **read**
  + exprs, features, samples
  + extract **subgroups** from sampleids / samplefile
  + wrap these into a **SummarizedExperiment**
* **preprocess**
  + **normalize**
  + **log2** transform
  + **impute** in a platform-aware fashion
  + **filter**
* **analyze**
  + plot **sample distributions**
  + plot **detections** (absent/present)
  + plot **pca** biplots
  + **fit** the linear model `~0+subgroup`
  + quantify **contrasts** between subsequent factor levels and **plot volcanoes**

# 1 RNAseq

Autonomics provides ready-to-use importers for both **count** as well as **BAM** files, which read / preprocess / analyze RNAseq data. Specific to RNAseq is counting reads using Rsubread::featureCounts (for read\_rna\_bams)), normalizing for library composition (**cpm**) or gene length (**tpm**), estimating **voom** precision weights, and using these in linear modeling. Let’s illustrate both of these on example datasets:

## read\_rnaseq\_counts

**Billing et al. (2019)** studied the differentiation of embryonic (**E00**) into mesenchymal stem cells (**E00.8**, **E01**, **E02**, **E05**, **E15**, **E30**), with similar properties as bone-marrow mesenchymal stem cells (**M00**). Importing the RNAseq counts:

```
require(autonomics, quietly = TRUE)
##
## Attaching package: 'autonomics'
## The following objects are masked from 'package:stats':
##
##     biplot, loadings
## The following object is masked from 'package:base':
##
##     beta
file <- system.file('extdata/billing19.rnacounts.txt', package = 'autonomics')
object <-  read_rnaseq_counts(file = file, fit = 'limma', plot = TRUE, label = 'gene')
##  Read /tmp/Rtmp4hDO8R/Rinst3418b110a8f854/autonomics/extdata/billing19.rnacounts.txt
##      Preprocess
##          Keep 24/24 features: count >= 10 (~subgroup)
##          counts: add 0.5
##          cpm:    tmm scale libsizes
##              cpm
##          voom: ~subgroup
##          counts: rm 0.5
##               Add PCA
##               linmod_limma( ~subgroup, weights = assays(object)$weights, coding = 'code_control' )
##                              coefficient    fit downfdr upfdr downp   upp
##                                   <fctr> <fctr>   <int> <int> <int> <int>
##                           1:   E00.8-E00  limma       1     1     1     2
##                           2:     E01-E00  limma       3     2     5     2
##                           3:     E02-E00  limma       3     3     3     4
##                           4:     E05-E00  limma       1     2     3     2
##                           5:     E15-E00  limma       8     9     8    10
##                           6:     E30-E00  limma       8    10     8    10
##                           7:     M00-E00  limma       6     7     6     7
##      Plot summary
```

![](data:image/png;base64...)

## read\_rnaseq\_bams

**Billing et al. (2016)** compared three types of stem cells: embryonic (**E**), embryonic differentiated into mesenchymal (**EM**), and bone-marrow mesenchymal (**BM**). Importing a downsized version of the RNAseq BAM files (with only a subset of all reads):

```
# not run to avoid issues with R CMD CHECK
if (requireNamespace('Rsubread')){
  object <- read_rnaseq_bams(
                dir    = download_data('billing16.bam.zip'),
                paired = TRUE,
                genome = 'hg38',
                pca    = TRUE,
                fit   = 'limma',
                plot   = TRUE)
}
```

## cpm/tmm/voom effects on power

Proper preprocessing leads to increased power:

```
  file <- system.file('extdata/billing19.rnacounts.txt', package = 'autonomics')
# log2counts
  object <- read_rnaseq_counts(file,
       cpm = FALSE, voom = FALSE, fit = 'limma', verbose = FALSE, plot = FALSE)
  colSums(summarize_fit(fdt(object), 'limma')[-1, c(3,4)])
## downfdr   upfdr
##       7      13
# log2cpm
  object <- read_rnaseq_counts(file,
       cpm = TRUE,  voom = FALSE, fit = 'limma', verbose = FALSE, plot = FALSE)
  colSums(summarize_fit(fdt(object), 'limma')[-1, c(3,4)])
## downfdr   upfdr
##      28      33
# log2cpm + voom
  object <- read_rnaseq_counts(file,  # log2 cpm + voom
       cpm = TRUE,  voom = TRUE,  fit = 'limma', verbose = FALSE, plot = FALSE)
  colSums(summarize_fit(fdt(object), 'limma')[-1, c(3,4)])
## downfdr   upfdr
##      29      33
```

# 2 Proteingroups/phosphosites

A popular approach in (DDA) MS proteomics data analysis is to use **MaxQuant** to produce **proteinGroups.txt** and **phospho (STY)Sites.txt** files. These can be imported using `read_proteingroups` / `read_phosphosites`, which :

* **Read**
  + **quantification cols**: LFQ intensities, Normalized Ratios, or Reporter intensities
  + **feature cols**: id, Majority protein IDs, Protein names, Gene names, Contaminant, Potential contaminant, Reverse
  + **subgroups** from sampleids / samplefile
* **Preprocess**
  + Convert **0 -> NA** (they represent lack of detection)
  + **Log2** transform
  + Rm **contaminants/reverse/unreplicated** features
  + **Impute** consistent NAs with values drawn from a half-normal distribution around zero
  + For phosphosites: **compute occupancies** by subtracting protein expressions
* **Analyze**
  + plot **sample distributions**
  + plot **detections**
  + **pca** biplot
  + **Fit** a linear model
  + Quantify **contrasts** between subsequent factor levels and plot **volcanoes**

## LFQ intensities

An **LFQ intensities** example is the **Fukuda et al. (2020)** dataset, which compares the proteome of **30d** zebrafish juveniles versus **adults** using label-free quantification. In the volcano plot measured values are shown with circles, imputed values as triangles.

```
file <- system.file('extdata/fukuda20.proteingroups.txt', package = 'autonomics')
object <- read_maxquant_proteingroups(file = file, plot = TRUE)
##         Read  proteingroups maxlfq                         /tmp/Rtmp4hDO8R/Rinst3418b110a8f854/autonomics/extdata/fukuda20.proteingroups.txt
##               contamin fastahdrs                           /tmp/Rtmp4hDO8R/Rinst3418b110a8f854/autonomics/extdata/contaminants.tsv
##               maxquant fastahdrs
##     Annotate  Uncollapse        20 proIds into     32  proteins
##               Drop REV_                            32  proteins
##               Annotate                                     0 using uniprothdrs
##                                                            1 using contaminanthdrs
##                                                           29 using maxquanthdrs
##                                                            0 using uniprotrestapi
##               Filter                               32  proteins
##               within proId                         31  proteins  swissprot > trembl
##                                                    25  proteins  fullseq   > fragment
##                                                    20  proteins  protein   > transcript > homolog > prediction > uncertain
##               Add REV__                            20  proteins
##               Recollapse        20 proIds
##     SumExp
##               Replace 0->NA for 27/120 values (in 11/20 features of 6/6 samples)
##               Standardize snames: LFQ intensity 30dpt.R1  ->  30dpt.R1
##               Retain 19/20 features: ~reverse == ""
##               Retain 18/19 features: ~contaminant == ""
##               Add PCA
##               linmod_limma( ~subgroup, coding = 'code_control' )
##                               coefficient    fit downfdr upfdr downp   upp
##                                    <fctr> <fctr>   <int> <int> <int> <int>
##                           1: Adult-X30dpt  limma       2     2     2     2
##      Plot summary
```

![](data:image/png;base64...)

## Normalized ratios

**Normalized ratios** were used in the proteomics profiling of the earlier described **Billing et al. (2019)** study, which examined the differentiation of embryonic stem cells (**E00**) into mesenchymal stem cells (**E01**,**E02**, **E05**, **E15**, **E30**), and compared these to bone-marrow derived mesenchymal stem cells (**M00**). The proteomics profiling experiment was performed using MS1 labeling: a light (**L**) labeled internal standard was created by mixing all samples in equal amounts, the subsequent samples were either medium (**M**) or heavy (**H**) labeled. Not all label combinations were of interest, and the `select_subgroups` argument allows to specifies which subgroup combinations to retain:

```
file <- system.file('extdata/billing19.proteingroups.txt', package = 'autonomics')
subgroups <- c('E00_STD', 'E01_STD', 'E02_STD', 'E05_STD', 'E15_STD', 'E30_STD', 'M00_STD')
object <- read_maxquant_proteingroups(file = file, subgroups = subgroups, plot = TRUE)
##         Read  proteingroups normalizedratio                /tmp/Rtmp4hDO8R/Rinst3418b110a8f854/autonomics/extdata/billing19.proteingroups.txt
##               contamin fastahdrs                           /tmp/Rtmp4hDO8R/Rinst3418b110a8f854/autonomics/extdata/contaminants.tsv
##               maxquant fastahdrs
##     Annotate  Uncollapse        25 proIds into     83  proteins
##               Drop REV_                            45  proteins
##               Annotate                                     0 using uniprothdrs
##                                                            1 using contaminanthdrs
##                                                           34 using maxquanthdrs
##                                                            0 using uniprotrestapi
##               Filter                               45  proteins
##               within proId                         24  proteins  swissprot > trembl
##               Add REV__                            24  proteins
##               Recollapse        25 proIds
##     SumExp
##               Replace NaN->NA for 175/825 values (in 12/25 features of 33/33 samples)
##               Standardize snames: Ratio M/L normalized STD(L).E00(M).E01(H).R1  ->  STD(L).E00(M).E01(H).R1{M/L}
##               Retain 21/33 samples: ~subgroup %in% subgroups
##               Retain 24/25 features: ~reverse == ""
##               Retain 23/24 features: ~contaminant == ""
##               Retain 22/23 features: non-zero, non-NA, and non-NaN for some sample
##               Add PCA
##               linmod_limma( ~subgroup, coding = 'code_control' )
##                                  coefficient    fit downfdr upfdr downp   upp
##                                       <fctr> <fctr>   <int> <int> <int> <int>
##                           1: E01_STD-E00_STD  limma       0     0     0     1
##                           2: E02_STD-E00_STD  limma       0     2     1     2
##                           3: E05_STD-E00_STD  limma       0     0     0     4
##                           4: E15_STD-E00_STD  limma       2     9     2    10
##                           5: E30_STD-E00_STD  limma       2     8     2     8
##                           6: M00_STD-E00_STD  limma       2     6     2     6
##      Plot summary
```

![](data:image/png;base64...)

The phosphosites can be read in a similar fashion:

```
fosfile <- system.file('extdata/billing19.phosphosites.txt',  package = 'autonomics')
profile <- system.file('extdata/billing19.proteingroups.txt', package = 'autonomics')
subgroups <- c('E00_STD', 'E01_STD', 'E02_STD', 'E05_STD', 'E15_STD', 'E30_STD', 'M00_STD')
object <- read_maxquant_phosphosites(fosfile = fosfile, profile = profile, subgroups = subgroups, plot = TRUE)
##         Read  proteingroups normalizedratio                /tmp/Rtmp4hDO8R/Rinst3418b110a8f854/autonomics/extdata/billing19.proteingroups.txt
##               phosphosites  normalizedratio                /tmp/Rtmp4hDO8R/Rinst3418b110a8f854/autonomics/extdata/billing19.phosphosites.txt
##                                                        Read    21 phosphosites in proteins, contaminants, reverse
##                                                        Retain  21 phosphosites in single proteingroup
##                                                        Retain  21 phosphosites with signal in some sample
##                                                        Keep proteingroup uniprots
##               contamin fastahdrs                           /tmp/Rtmp4hDO8R/Rinst3418b110a8f854/autonomics/extdata/contaminants.tsv
##               maxquant fastahdrs
##     Annotate  Uncollapse        21 fosIds into     53  proteins
##               Drop REV_                            28  proteins
##               Annotate                                     0 using uniprothdrs
##                                                            1 using contaminanthdrs
##                                                           20 using maxquanthdrs
##                                                            0 using uniprotrestapi
##               Filter                               28  proteins
##               within fosId                         16  proteins  swissprot > trembl
##               Add REV__                            16  proteins
##               Recollapse        21 fosIds
##     SumExp
##               Replace NaN->NA for 104/693 values (in 6/21 features of 33/33 samples)
##               Retain 21/33 samples: ~subgroup %in% subgroups
##               Retain 20/21 features: ~reverse == ""
##               Retain 19/20 features: ~contaminant == ""
##               Add PCA
##               linmod_limma( ~subgroup, coding = 'code_control' )
##                                  coefficient    fit downfdr upfdr downp   upp
##                                       <fctr> <fctr>   <int> <int> <int> <int>
##                           1: E01_STD-E00_STD  limma       1     0     1     2
##                           2: E02_STD-E00_STD  limma       2     1     3     2
##                           3: E05_STD-E00_STD  limma       1     2     1     4
##                           4: E15_STD-E00_STD  limma       2     6     2     6
##                           5: E30_STD-E00_STD  limma       1     4     1     5
##                           6: M00_STD-E00_STD  limma       2     3     2     4
##      Plot summary
```

![](data:image/png;base64...)

# 3 Metabolon

**Metabolon** delivers metabolomics results in the form of an **xlsx** file, with values of interest likely in the (second) **OrigScale** sheet. Features are laid out in rows, samples in columns, and additional feature/sample data are self-contained in the file. Metabolon data can be read/analyzed with the autonomics function `read_metabolon`, as illustrated below on the dataset of **Halama and and Atkin (2018)**, who investigates the effects of **hypoglycemia** on a number of subjects (**SUB**) at four different time points (**t0**, **t1**, **t2**, **t3**):

```
file <- system.file('extdata/atkin.metabolon.xlsx', package = 'autonomics')
object <- read_metabolon(file,  block = 'Subject', plot = TRUE)
##  Read: /tmp/Rtmp4hDO8R/Rinst3418b110a8f854/autonomics/extdata/atkin.metabolon.xlsx
##               log2 metabolon
##               Add PCA
##               Dupcor `Subject`
##               linmod_limma( ~subgroup | Subject, coding = 'code_control' )
##                              coefficient    fit downfdr upfdr downp   upp
##                                   <fctr> <fctr>   <int> <int> <int> <int>
##                           1:       t1-t0  limma       8     1    10     1
##                           2:       t2-t0  limma       7     3     8     3
##                           3:       t3-t0  limma       1     1     4     2
##      Plot summary
```

![](data:image/png;base64...)

# 4 Somascan

**Somascan** results are returned in a txt file with extension **.adat**. Features are laid out in columns and samples in rows. Rectangles with feature/sample data are also contained in the file. The autonomics function `read_somascan` reads/analyzes SOMAscan files, additionally filtering samples/features for quality and type. This is illustrated on the above described dataset from **Halama and and Atkin (2018)**, who investigated the effects of **hypoglycemia** on a number of subjects (**SUB**) at four different time points (**t0**, **t1**, **t2**, **t3**):

```
file <- system.file('extdata/atkin.somascan.adat', package = 'autonomics')
object <- read_somascan(file, block = 'Subject', plot = TRUE)
##  Read: /tmp/Rtmp4hDO8R/Rinst3418b110a8f854/autonomics/extdata/atkin.somascan.adat
##               log2 somascan
##               Add PCA
##               Dupcor `Subject`
##               linmod_limma( ~SampleGroup | Subject, coding = 'code_control' )
##                              coefficient    fit downfdr upfdr downp   upp
##                                   <fctr> <fctr>   <int> <int> <int> <int>
##                           1:       t1-t0  limma       0     1     1     3
##                           2:       t2-t0  limma       2     2     2     4
##                           3:       t3-t0  limma       0     0     0     0
##      Plot summary
```

![](data:image/png;base64...)

# SessionInfo

```
sessionInfo()
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] autonomics_1.18.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] ICSNP_1.1-2                 DBI_1.2.3
##   [3] gridExtra_2.3               httr2_1.2.1
##   [5] readxl_1.4.5                rlang_1.1.6
##   [7] magrittr_2.0.4              matrixStats_1.5.0
##   [9] compiler_4.5.1              RSQLite_2.4.3
##  [11] reshape2_1.4.4              vctrs_0.6.5
##  [13] stringr_1.5.2               pkgconfig_2.0.3
##  [15] fastmap_1.2.0               magick_2.9.0
##  [17] dbplyr_2.5.1                XVector_0.50.0
##  [19] labeling_0.4.3              rmarkdown_2.30
##  [21] tinytex_0.57                purrr_1.1.0
##  [23] bit_4.6.0                   xfun_0.53
##  [25] MultiAssayExperiment_1.36.0 cachem_1.1.0
##  [27] jsonlite_2.0.0              fractional_0.1.3
##  [29] blob_1.2.4                  DelayedArray_0.36.0
##  [31] BiocParallel_1.44.0         tweenr_2.0.3
##  [33] codingMatrices_0.4.0        parallel_4.5.1
##  [35] cluster_2.1.8.1             R6_2.6.1
##  [37] bslib_0.9.0                 stringi_1.8.7
##  [39] RColorBrewer_1.1-3          limma_3.66.0
##  [41] GenomicRanges_1.62.0        jquerylib_0.1.4
##  [43] cellranger_1.1.0            Rcpp_1.1.0
##  [45] Seqinfo_1.0.0               bookdown_0.45
##  [47] assertthat_0.2.1            SummarizedExperiment_1.40.0
##  [49] knitr_1.50                  R.utils_2.13.0
##  [51] IRanges_2.44.0              BiocBaseUtils_1.12.0
##  [53] Matrix_1.7-4                splines_4.5.1
##  [55] igraph_2.2.1                tidyselect_1.2.1
##  [57] dichromat_2.0-0.1           abind_1.4-8
##  [59] yaml_2.3.10                 codetools_0.2-20
##  [61] curl_7.0.0                  plyr_1.8.9
##  [63] lattice_0.22-7              tibble_3.3.0
##  [65] rARPACK_0.11-0              Biobase_2.70.0
##  [67] withr_3.0.2                 S7_0.2.0
##  [69] evaluate_1.0.5              survival_3.8-3
##  [71] survey_4.4-8                polyclip_1.10-7
##  [73] BiocFileCache_3.0.0         pillar_1.11.1
##  [75] BiocManager_1.30.26         filelock_1.0.3
##  [77] MatrixGenerics_1.22.0       stats4_4.5.1
##  [79] ellipse_0.5.0               generics_0.1.4
##  [81] S4Vectors_0.48.0            ggplot2_4.0.0
##  [83] scales_1.4.0                glue_1.8.0
##  [85] tools_4.5.1                 data.table_1.17.8
##  [87] RSpectra_0.16-2             locfit_1.5-9.12
##  [89] mvtnorm_1.3-3               grid_4.5.1
##  [91] mitools_2.4                 ICS_1.4-2
##  [93] tidyr_1.3.1                 edgeR_4.8.0
##  [95] colorspace_2.1-2            ggforce_0.5.0
##  [97] cli_3.6.5                   rappdirs_0.3.3
##  [99] mixOmics_6.34.0             S4Arrays_1.10.0
## [101] rematch_2.0.0               arrow_22.0.0
## [103] dplyr_1.1.4                 corpcor_1.6.10
## [105] pcaMethods_2.2.0            gtable_0.3.6
## [107] R.methodsS3_1.8.2           sass_0.4.10
## [109] digest_0.6.37               BiocGenerics_0.56.0
## [111] SparseArray_1.10.0          ggrepel_0.9.6
## [113] farver_2.1.2                memoise_2.0.1
## [115] htmltools_0.5.8.1           R.oo_1.27.1
## [117] lifecycle_1.0.4             statmod_1.5.1
## [119] bit64_4.6.0-1               MASS_7.3-65
```

# References

# Appendix

A M Billing, S S Dib, A M Bhagwat, I T da Silva, R D Drummond, S Hayat, R Al-Mismar, H Ben-Hamidane, N Goswami, K Engholm-Keller, M R Larsen, K Suhre, A Rafii, J Graummann (2019). Mol Cell Proteomics. 18(10):1950-1966. doi: 10.1074/mcp.RA119.001356.

A M Billing, H Ben Hamidane, S S Dib, R J Cotton, A M Bhagwat, P Kumar, S Hayat, N A Yousri, N Goswami, K Suhre, A Rafii, J Graumann (2016). Comprehensive transcriptomics and proteomics characterization of human mesenchymal stem cells reveals source specific cellular markers. Sci Rep. 9;6:21507. doi: 10.1038/srep21507.

R Fukuda, R Marin-Juez, H El-Sammak, A Beisaw, R Ramadass, C Kuenne, S Guenther, A Konzer, A M Bhagwat, J Graumann, D YR Stainier (2020). EMBO Rep. 21(8): e49752. doi: 10.15252/embr.201949752

A Halama, M Kulinski, S Dib, S B Zaghlool, K S Siveen, A Iskandarani, J Zierer 3, K S Prabhu, N J Satheesh, A M Bhagwat, S Uddin, G Kastenmüller, O Elemento, S S Gross, K Suhre (2018). Accelerated lipid catabolism and autophagy are cancer survival mechanisms under inhibited glutaminolysis. Cancer Lett., 430:133-147. doi:10.1016/j.canlet.2018.05.017

A Halama, H Kahal, A M Bhagwat, J Zierer, T Sathyapalan, J Graumann, K Suhre, S L Atkin (2018). Metabolic and proteomics signatures of hypoglycaemia in type 2 diabetes. Diabetes, obesity and metabolism, <https://doi.org/10.1111/dom.13602>