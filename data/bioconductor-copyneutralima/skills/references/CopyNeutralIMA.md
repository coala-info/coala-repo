# CopyNeutralIMA

Moritz Przybilla1 and Xavier Pastor1,2\*

1Division of Theoretical Bioinformatics, German Cancer Research Center (DKFZ), Heidelberg, Germany
2Heidelberg Center for Personalized Oncology (DKFZ-HIPO), Heidelberg, Germany

\*xavier.pastor@compbio-dev.com

#### 2025-11-04

# 1 Overview

*CopyNeutralIMA* provides reference samples for performing copy-number variation (CNV) analysis using Illumina Infinium 450k or EPIC DNA methylation arrays.
There is a number of R/Bioconductor packages that do genomic copy number profiling, including [*conumee*](http://bioconductor.org/packages/release/bioc/html/conumee.html) (Hovestadt and Zapatka, [n.d.](#ref-conumee)), [*ChAMP*](http://bioconductor.org/packages/release/bioc/html/ChAMP.html) (Tian et al. [2017](#ref-champ)) or *CopyNumber450k*, now deprecated. In order to extract information about the copy number alterations, a set of copy neutral samples is required as a reference. The package *CopyNumber450kData*, usually used to provide the reference, is no longer available. Additionally, there has never been an effort to provide reference samples for the EPIC arrays. To fill this gap of lacking reference samples, we here introduce the *CopyNeutralIMA* package.

# 2 Description

In this package we provide a set of 51 IlluminaHumanMethylation450k and 13 IlluminaHumanMethylationEPIC samples. The provided samples consist of material from healthy individuals with nominally no copy number aberrations. Users of *conumee* or other copy number profiling packages may use this data package as reference genomes.

# 3 Data

We selected the data from different studies accessible in the [Gene Expression Omnibus (GEO)](https://www.ncbi.nlm.nih.gov/geo/). In particular, for 450k arrays samples from [GSE49618](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE49618) (Ley et al. [2013](#ref-GSE49618)), [GSE61441](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE61441) (Wei et al. [2015](#ref-GSE61441)) and [GSE106089](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE106089) (Tomlinson et al. [2017](#ref-GSE106089)) were chosen. For EPIC arrays, normal or control samples from series [GSE86831](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE86831)/[GSE86833](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE86833) (Pidsley et al. [2016](#ref-GSE86831)), [GSE98990](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE98990) (Zhou, Laird, and Shen [2017](#ref-GSE98990)) and [GSE100825](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE100825) (Guastafierro et al. [2017](#ref-GSE100825)) were chosen.

# 4 Example with *conumee*

First, we load the data we want to analyse and rename it. We will use the examples provided by the [*minfiData*](https://bioconductor.org/packages/release/data/experiment/html/minfiData.html) (Daniel, Aryee, and Timp [2018](#ref-minfiData)) package and will follow the steps described in the vignette of *conumee*.

```
library(minfi)
library(conumee)
library(minfiData)

data(RGsetEx)
sampleNames(RGsetEx) <- pData(RGsetEx)$Sample_Name
cancer <- pData(RGsetEx)$status == 'cancer'
RGsetEx <- RGsetEx[,cancer]
RGsetEx
#> class: RGChannelSet
#> dim: 622399 3
#> metadata(0):
#> assays(2): Green Red
#> rownames(622399): 10600313 10600322 ... 74810490 74810492
#> rowData names(0):
#> colnames(3): GroupB_3 GroupB_1 GroupB_2
#> colData names(13): Sample_Name Sample_Well ... Basename filenames
#> Annotation
#>   array: IlluminaHumanMethylation450k
#>   annotation: ilmn12.hg19
```

After loading the data we normalize it:

```
MsetEx <- preprocessIllumina(RGsetEx)
MsetEx
#> class: MethylSet
#> dim: 485512 3
#> metadata(0):
#> assays(2): Meth Unmeth
#> rownames(485512): cg00050873 cg00212031 ... ch.22.47579720R
#>   ch.22.48274842R
#> rowData names(0):
#> colnames(3): GroupB_3 GroupB_1 GroupB_2
#> colData names(13): Sample_Name Sample_Well ... Basename filenames
#> Annotation
#>   array: IlluminaHumanMethylation450k
#>   annotation: ilmn12.hg19
#> Preprocessing
#>   Method: Illumina, bg.correct = TRUE, normalize = controls, reference = 1
#>   minfi version: 1.56.0
#>   Manifest version: 0.4.0
```

Now we load our control samples, from the same array type as our test samples and normalize them:

```
library(CopyNeutralIMA)
ima <- annotation(MsetEx)[['array']]
RGsetCtrl <- getCopyNeutralRGSet(ima)
# preprocess as with the sample data
MsetCtrl <- preprocessIllumina(RGsetCtrl)
MsetCtrl
#> class: MethylSet
#> dim: 485512 51
#> metadata(0):
#> assays(2): Meth Unmeth
#> rownames(485512): cg00050873 cg00212031 ... ch.22.47579720R
#>   ch.22.48274842R
#> rowData names(0):
#> colnames(51): GSM1185582 GSM1185583 ... GSM2829413 GSM2829418
#> colData names(7): ID gsm ... source_name_ch1 characteristics_ch1
#> Annotation
#>   array: IlluminaHumanMethylation450k
#>   annotation: ilmn12.hg19
#> Preprocessing
#>   Method: Illumina, bg.correct = TRUE, normalize = controls, reference = 1
#>   minfi version: 1.56.0
#>   Manifest version: 0.4.0
```

Finally we can run the conumee analysis following the author’s indications:

```
# use the information provided by conumee to create annotation files or define
# them according to the package instructions
data(exclude_regions)
data(detail_regions)
anno <- CNV.create_anno(array_type = "450k", exclude_regions = exclude_regions, detail_regions = detail_regions)
#> using genome annotations from UCSC
#> getting 450k annotations
#>  - 470870 probes used
#> importing regions to exclude from analysis
#> importing regions for detailed analysis
#> creating bins
#>  - 53891 bins created
#> merging bins
#>  - 15820 bins remaining

# load in the data from the reference and samples to be analyzed
control.data <- CNV.load(MsetCtrl)
ex.data <- CNV.load(MsetEx)

cnv <- CNV.fit(ex.data["GroupB_1"], control.data, anno)
cnv <- CNV.bin(cnv)
cnv <- CNV.detail(cnv)
cnv <- CNV.segment(cnv)
cnv
#> CNV analysis object
#>    created   : Tue Nov  4 11:16:24 2025
#>   @name      : GroupB_1
#>   @anno      : 22 chromosomes, 470870 probes, 15820 bins
#>   @fit       : available (noise: 2.32)
#>   @bin       : available (shift: 0.005)
#>   @detail    : available (20 regions)
#>   @seg       : available (29 segments)

CNV.genomeplot(cnv)
```

![](data:image/png;base64...)

```
CNV.genomeplot(cnv, chr = 'chr18')
```

![](data:image/png;base64...)

```
head(CNV.write(cnv, what = 'segments'))
#>         ID chrom loc.start   loc.end num.mark     bstat          pval seg.mean
#> 1 GroupB_1  chr1    635684 148927230      931 21.475711  1.422312e-99   -0.194
#> 2 GroupB_1  chr1 149077230 149379823        5 26.044755 7.787661e-147    3.058
#> 3 GroupB_1  chr1 149579823 249195311      657        NA            NA   -0.077
#> 4 GroupB_1 chr10    105000 135462374      840        NA            NA   -0.054
#> 5 GroupB_1 chr11    130000 134873258      914        NA            NA    0.081
#> 6 GroupB_1 chr12    172870  65175000      413  8.802509  1.958883e-16   -0.006
#>   seg.median
#> 1     -0.180
#> 2      0.621
#> 3     -0.070
#> 4     -0.050
#> 5      0.068
#> 6     -0.015
head(CNV.write(cnv, what='probes'))
#>   Chromosome Start   End    Feature GroupB_1
#> 1       chr1 15864 15865 cg13869341   -0.064
#> 2       chr1 18826 18827 cg14008030   -0.321
#> 3       chr1 29406 29407 cg12045430    0.109
#> 4       chr1 29424 29425 cg20826792   -0.264
#> 5       chr1 29434 29435 cg00381604   -0.069
#> 6       chr1 68848 68849 cg20253340   -0.360
```

# Session info

```
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
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] CopyNeutralIMA_1.28.0
#>  [2] minfiData_0.56.0
#>  [3] conumee_1.44.0
#>  [4] IlluminaHumanMethylationEPICmanifest_0.3.0
#>  [5] IlluminaHumanMethylationEPICanno.ilm10b2.hg19_0.6.0
#>  [6] IlluminaHumanMethylation450kmanifest_0.4.0
#>  [7] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
#>  [8] minfi_1.56.0
#>  [9] bumphunter_1.52.0
#> [10] locfit_1.5-9.12
#> [11] iterators_1.0.14
#> [12] foreach_1.5.2
#> [13] Biostrings_2.78.0
#> [14] XVector_0.50.0
#> [15] SummarizedExperiment_1.40.0
#> [16] Biobase_2.70.0
#> [17] MatrixGenerics_1.22.0
#> [18] matrixStats_1.5.0
#> [19] GenomicRanges_1.62.0
#> [20] Seqinfo_1.0.0
#> [21] IRanges_2.44.0
#> [22] S4Vectors_0.48.0
#> [23] BiocGenerics_0.56.0
#> [24] generics_0.1.4
#> [25] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
#>   [3] magrittr_2.0.4            magick_2.9.0
#>   [5] GenomicFeatures_1.62.0    rmarkdown_2.30
#>   [7] BiocIO_1.20.0             vctrs_0.6.5
#>   [9] multtest_2.66.0           memoise_2.0.1
#>  [11] Rsamtools_2.26.0          DelayedMatrixStats_1.32.0
#>  [13] RCurl_1.98-1.17           askpass_1.2.1
#>  [15] tinytex_0.57              htmltools_0.5.8.1
#>  [17] S4Arrays_1.10.0           AnnotationHub_4.0.0
#>  [19] curl_7.0.0                Rhdf5lib_1.32.0
#>  [21] SparseArray_1.10.1        rhdf5_2.54.0
#>  [23] sass_0.4.10               nor1mix_1.3-3
#>  [25] bslib_0.9.0               httr2_1.2.1
#>  [27] plyr_1.8.9                cachem_1.1.0
#>  [29] GenomicAlignments_1.46.0  lifecycle_1.0.4
#>  [31] pkgconfig_2.0.3           Matrix_1.7-4
#>  [33] R6_2.6.1                  fastmap_1.2.0
#>  [35] rbibutils_2.3             digest_0.6.37
#>  [37] siggenes_1.84.0           reshape_0.8.10
#>  [39] AnnotationDbi_1.72.0      ExperimentHub_3.0.0
#>  [41] RSQLite_2.4.3             base64_2.0.2
#>  [43] filelock_1.0.3            httr_1.4.7
#>  [45] abind_1.4-8               compiler_4.5.1
#>  [47] beanplot_1.3.1            rngtools_1.5.2
#>  [49] withr_3.0.2               bit64_4.6.0-1
#>  [51] BiocParallel_1.44.0       DBI_1.2.3
#>  [53] HDF5Array_1.38.0          MASS_7.3-65
#>  [55] openssl_2.3.4             rappdirs_0.3.3
#>  [57] DelayedArray_0.36.0       rjson_0.2.23
#>  [59] DNAcopy_1.84.0            tools_4.5.1
#>  [61] rentrez_1.2.4             glue_1.8.0
#>  [63] quadprog_1.5-8            h5mread_1.2.0
#>  [65] restfulr_0.0.16           nlme_3.1-168
#>  [67] rhdf5filters_1.22.0       grid_4.5.1
#>  [69] tzdb_0.5.0                preprocessCore_1.72.0
#>  [71] tidyr_1.3.1               data.table_1.17.8
#>  [73] hms_1.1.4                 xml2_1.4.1
#>  [75] BiocVersion_3.22.0        pillar_1.11.1
#>  [77] limma_3.66.0              genefilter_1.92.0
#>  [79] splines_4.5.1             dplyr_1.1.4
#>  [81] BiocFileCache_3.0.0       lattice_0.22-7
#>  [83] survival_3.8-3            rtracklayer_1.70.0
#>  [85] bit_4.6.0                 GEOquery_2.78.0
#>  [87] annotate_1.88.0           tidyselect_1.2.1
#>  [89] knitr_1.50                bookdown_0.45
#>  [91] xfun_0.54                 scrime_1.3.5
#>  [93] statmod_1.5.1             yaml_2.3.10
#>  [95] evaluate_1.0.5            codetools_0.2-20
#>  [97] cigarillo_1.0.0           tibble_3.3.0
#>  [99] BiocManager_1.30.26       cli_3.6.5
#> [101] Rdpack_2.6.4              xtable_1.8-4
#> [103] jquerylib_0.1.4           Rcpp_1.1.0
#> [105] dbplyr_2.5.1              png_0.1-8
#> [107] XML_3.99-0.19             readr_2.1.5
#> [109] blob_1.2.4                mclust_6.1.2
#> [111] doRNG_1.8.6.2             sparseMatrixStats_1.22.0
#> [113] bitops_1.0-9              illuminaio_0.52.0
#> [115] purrr_1.1.0               crayon_1.5.3
#> [117] rlang_1.1.6               KEGGREST_1.50.0
```

# References

Aryee, MJ, AE Jaffe, H Corrada-Bravo, C Ladd-Acosta, AP Feinberg, KD Hansen, and RA Irizarry. 2014. “Minfi: A flexible and comprehensive Bioconductor package for the analysis of Infinium DNA Methylation microarrays.” *Bioinformatics* 30 (10): 1363–9. <https://doi.org/10.1093/bioinformatics/btu049>.

Daniel, K, M Aryee, and W Timp. 2018. *minfiData: Example data for the Illumina Methylation 450k array*.

Guastafierro, T, MG Bacalini, A Marcoccia, D Gentilini, S Pisoni, AM Di Blasio, A Corsi, et al. 2017. “Genome-wide DNA methylation analysis in blood cells from patients with Werner syndrome.” *Clinical Epigenetics* 9: 92. <https://doi.org/10.1186/s13148-017-0389-4>.

Hovestadt, V, and M Zapatka. n.d. *conumee: Enhanced copy-number variation analysis using Illumina DNA methylation arrays*. Division of Molecular Genetics, German Cancer Research Center (DKFZ), Heidelberg, Germany. <http://bioconductor.org/packages/conumee/>.

Ley, TJ, C Miller, L Ding, and The Cancer Genome Atlas Research Network. 2013. “Genomic and epigenomic landscapes of adult de novo acute myeloid leukemia.” *The New England of Journal Medicine* 368 (22): 2059–74. <https://doi.org/10.1056/NEJMoa1301689>.

Pidsley, R, E Zotenko, TJ Peters, MG Lawrence, GP Risbridger, P Molloy, S Van Djik, B Muhlhausler, C Stirzaker, and SJ Clark. 2016. “Critical evaluation of the Illumina MethylationEPIC BeadChip microarray for whole-genome DNA methylation profiling.” *Genome Biology* 17 (1): 208. <https://doi.org/10.1186/s13059-016-1066-1>.

Tian, Y, TJ Morris, AP Webster, Z Yang, S Beck, A Feber, and AE Teschendorff. 2017. “ChAMP: updated methylatioon analysis pipeline for Illumina BeadChips.” *Bioinformatics* 33 (24): 3982–4. <https://doi.org/10.1093/bioinformatics/btx513>.

Tomlinson, MS, PA Bommarito, EM Martin, L Smeester, RN Fichorova, AB Onderdonk, KCK Kuban, TM O’Shea, and RC Fry. 2017. “Microorganisms in the human placenta are associated with altered CpG methylation of immune and inflammation-related genes.” *PLoS One* 12 (12): e0188664. <https://doi.org/10.1371/journal.pone.0188664>.

Wei, JH, A Haddad, JH Luo, and others. 2015. “A CpG-methylation-based assay to predict survival in clear cell renal cell carcinoma.” *Nature Communications* 30 (6): 8699. <https://doi.org/10.1038/ncomms9699>.

Zhou, W, PW Laird, and H Shen. 2017. “Comprehensive characterization, annotation and innovative use of Infinium DNA methylation BeadChip probes.” *Nucleic Acids Research* 45 (4): e22. <https://doi.org/10.1093/nar/gkw967>.