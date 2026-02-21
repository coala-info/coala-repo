# The conumee vignette

Volker Hovestadt, Marc Zapatka (Division of Molecular Genetics, German Cancer Research Center, Heidelberg, Germany)

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Load data](#load-data)
* [3 Create annotation object](#create-annotation-object)
* [4 Combine intensity values](#combine-intensity-values)
* [5 Perform CNV analysis](#perform-cnv-analysis)
* [6 Output plots and text files](#output-plots-and-text-files)
* [7 Contact & citation](#contact-citation)
* [8 Session info](#session-info)
* [References](#references)

# 1 Introduction

The `conumee` package provides tools for performing **co**py-**nu**mber variation (CNV) analysis using Illumina 450k or EPIC DNA **me**thylation arrays. Although the primary purpose of these arrays is the detection of genome-wide DNA methylation levels [[1](#ref-bibikovahigh2011)], it can additionally be used to extract useful information about copy-number alterations, e.g. in clinical cancer samples. The approach was initially described in Sturm et al., 2012 [[2](#ref-sturmhotspot2012)]. Other tools following a similar strategy include `ChAMP` [[3](#ref-feberusing2014)] and `CopyNumber450k` (now deprecated).

CNV analysis is performed using a two-step approach. First, the combined intensity values of both ‘methylated’ and ‘unmethylated’ channel of each CpG are normalized using a set of normal controls (i.e. with a flat genome not showing any copy-number alterations). This step is required for correcting for probe and sample bias (e.g. caused by GC-content, type I/II differences or technical variability). Secondly, neighboring probes are combined in a hybrid approach, resulting in bins of a minimum size and a minimum number of probes. This step is required to reduce remaining technical variability and enable meaningful segmentation results.

The `conumee` package has been written for seamless integration with frequently-used Bioconductor packages. It is recommended that methylation array data is loaded using the `minfi` package [[4](#ref-aryeeminfi2014)]. Segmentation is performed using the circular binary segmentation (CBS) algorithm implemented in the `DNAcopy` package [[5](#ref-olshencircular2004)]. Processing time is typically less than a minute per sample.

Finally, the `conumee` package also provides a set of plotting methods to create publication-grade CNV plots of the whole genome, selected chromosomes or previously defined regions of interest. Writing of text-based output files for visualization in other tools (e.g. the IGV browser) or downstream processing (e.g. using GISTIC) is also supported.

# 2 Load data

The recommended input format are `Mset` objects generated from raw IDAT files using the `minfi` package. Depending on the analysis workflow, these objects might be already available. A good example 450k data-set for testing the `conumee` package can be downloaded from TCGA (971.6 MB):

~~<https://tcga-data.nci.nih.gov/tcgafiles/ftp_auth/distro_ftpusers/anonymous/tumor/brca/cgcc/jhu-usc.edu/humanmethylation450/methylation/jhu-usc.edu_BRCA.HumanMethylation450.Level_1.8.8.0.tar.gz>~~

UPDATE October 2016: The TCGA Data Portal is no longer operational. TCGA DNA methylation data can now be downloaded from the NCI GDC Legacy Archive: <https://gdc-portal.nci.nih.gov/legacy-archive>

This data-set comprises of 42 primary breast cancer samples, 2 breast cancer cell lines and 16 control samples. Make sure to unpack the archive. For the purpose of this vignette, only two illustrative examples are downloaded using the `read.450k.url` method.

```
library("minfi")
library("conumee")
#RGsetTCGA <- read.450k.exp(base = "~/conumee_analysis/jhu-usc.edu_BRCA.HumanMethylation450.Level_1.8.8.0")  # adjust path
RGsetTCGA <- read.450k.url()  # use default parameters for vignette examples
MsetTCGA <- preprocessIllumina(RGsetTCGA)
MsetTCGA
## class: MethylSet
## dim: 485512 2
## metadata(0):
## assays(2): Meth Unmeth
## rownames(485512): cg00050873 cg00212031 ... ch.22.47579720R
##   ch.22.48274842R
## rowData names(0):
## colnames(2): 6042324037_R05C02 6042324037_R06C01
## colData names(0):
## Annotation
##   array: IlluminaHumanMethylation450k
##   annotation: ilmn12.hg19
## Preprocessing
##   Method: Illumina, bg.correct = TRUE, normalize = controls, reference = 1
##   minfi version: 1.56.0
##   Manifest version: 0.4.0
```

Alternatively, you can use the `minfiData` example data-set, comprising of 3 cancer samples and 3 normal controls.

```
library("minfiData")
data(MsetEx)
MsetEx
## class: MethylSet
## dim: 485512 6
## metadata(0):
## assays(2): Meth Unmeth
## rownames(485512): cg00050873 cg00212031 ... ch.22.47579720R
##   ch.22.48274842R
## rowData names(0):
## colnames(6): 5723646052_R02C02 5723646052_R04C01 ... 5723646053_R05C02
##   5723646053_R06C02
## colData names(13): Sample_Name Sample_Well ... Basename filenames
## Annotation
##   array: IlluminaHumanMethylation450k
##   annotation: ilmn12.hg19
## Preprocessing
##   Method: Raw (no normalization or bg correction)
##   minfi version: 1.21.2
##   Manifest version: 0.4.0
```

~~The `CopyNumber450k` package provides a large data-set of 52 control samples which can be used for normalization.~~

UPDATE April 2017: The `CopyNumber450k` and `CopyNumber450kData` packages are now depreacted. We will use the 3 normal controls from the `minfiData` package for now. Using a larger set of control samples would give better results.

```
# library("CopyNumber450kData")
# data(RGcontrolSetEx)
# MsetControls <- preprocessIllumina(RGcontrolSetEx)
```

If raw IDAT files are unavailable, data can also be supplied by importing text-based input files, e.g. as generated by GenomeStudio or downloaded from the GEO repository. More details are given later.

# 3 Create annotation object

To begin with the CNV analysis, an annotation object, generated by the `CNV.create_anno` function, is required. This object holds information which only needs to be generated once, irrespective of the number of samples that are processed.

Arguments `bin_minprobes` and `bin_minsize` define the minimum number of probes per bin and the minimum bin size (default values that were optimized for 450k data are 15 and 50000, respectively). Argument `exclude_regions` defines regions to be excluded (e.g. polymorphic regions, an example is given in `data(exclude_regions)`). Please see `?CNV.create_anno` for more details.

Argument `detail_regions` defines regions to be examined in detail (e.g. dedicated detail plots or text output, see below). For example, detail regions can contain known oncogenes or tumor suppressor genes. These regions should either be supplied as a path to a BED file or as a GRanges object (an example is given in `data(detail_regions)`). The start and stop coordinates indicate the regions in which probes are analyzed in detail. The plotting range of detail plots are defined in a second set of start and stop coordinates in the GRanges object values (or the 7th and 8th column in the BED file).

```
data(exclude_regions)
data(detail_regions)
head(detail_regions, n = 2)
## GRanges object with 2 ranges and 5 metadata columns:
##       seqnames            ranges strand |        name             thick
##          <Rle>         <IRanges>  <Rle> | <character>         <IRanges>
##   [1]    chr11 69453874-69469242      + |       CCND1 68961558-69961557
##   [2]    chr19 30300902-30315215      + |       CCNE1 29808059-30808058
##           score probes_gene probes_promoter
##       <integer>   <integer>       <integer>
##   [1]        70          38              32
##   [2]        16          10               6
##   -------
##   seqinfo: 11 sequences from an unspecified genome; no seqlengths

anno <- CNV.create_anno(array_type = "450k", exclude_regions = exclude_regions, detail_regions = detail_regions)
## using genome annotations from UCSC
## getting 450k annotations
##  - 470870 probes used
## importing regions to exclude from analysis
## importing regions for detailed analysis
## creating bins
##  - 53891 bins created
## merging bins
##  - 15820 bins remaining

anno
## CNV annotation object
##    created  : Wed Oct 29 23:21:22 2025
##   @genome   : 22 chromosomes
##   @gap      : 313 regions
##   @probes   : 470870 probes
##   @exclude  : 3 regions (overlapping 570 probes)
##   @detail   : 20 regions (overlapping 768 probes)
##   @bins     : 15820 bins (min/avg/max size: 50/168.5/5000kb, probes: 15/29.7/478)
```

# 4 Combine intensity values

Intensity values of the ‘methylated’ and ‘unmethylated’ channel are combined using the `CNV.load` function. Input can be either an `Mset` object (recommended, see above), or a `data.frame` or `matrix` object containing intensities generated by GenomeStudio or downloaded from GEO (imported using e.g. `read.table`, should work without reformatting for most tables, please refer to `?CNV.load` for more details).

```
data(tcgaBRCA.sentrix2name)  # TCGA sample IDs are supplied with the conumee package
sampleNames(MsetTCGA) <- tcgaBRCA.sentrix2name[sampleNames(MsetTCGA)]
tcga.data <- CNV.load(MsetTCGA)
tcga.controls <- grep("-11A-", names(tcga.data))
names(tcga.data)
## [1] "TCGA-AR-A1AU-01A-11D-A12R-05" "TCGA-AR-A1AY-01A-21D-A12R-05"
tcga.data
## CNV data object
##    created   :
##   @intensity : available (2 samples, 485512 probes)

minfi.data <- CNV.load(MsetEx)
minfi.controls <- pData(MsetEx)$status == "normal"

# controls.data <- CNV.load(MsetControls)
```

# 5 Perform CNV analysis

The main CNV analysis is separated into four parts:

* First, `CNV.fit` is used to normalize a single query sample to a set of control samples by multiple linear regression. For best results control samples of matched normal tissues that are profiled within the same experiment are used (which are likely to have the same technical bias). Essentially this regression analysis yields the linear combination of control samples that most closely fits the intensities of the query sample. Subsequently, the log2-ratio of probe intensities of the query sample versus the combination of control samples are calculated and used for further analysis. More details are given in the publication.
* Secondly, `CNV.bin` is used to combine probes within predefined genomic bins. Bins are previously generated using `CNV.create_anno`. Intensity values are shifted to minimize the median absolute deviation from all bins to zero to determine the copy-number neutral state.
* Thirdly, `CNV.detail` is used to analyze detail regions in detail. This step is optional, but required if detail regions should be outputted in plots and text files. Detail regions are defined using `CNV.create_anno`.
* Finally, `CNV.segment` is used to segment the genome into regions of the same copy-number state. This function is a wrapper of the `CNA`, `segment`, `segments.summary` and `segments.p` functions of the `DNAcopy` package. Default parameters were optimized for 450k data, but can be changed. See `?CNV.segment` for more details.

```
x <- CNV.fit(minfi.data["GroupB_1"], minfi.data[minfi.controls], anno)
# y <- CNV.fit(tcga.data["TCGA-AR-A1AU-01A-11D-A12R-05"], controls.data, anno)  # CopyNumber450kData package is deprecated
# z <- CNV.fit(tcga.data["TCGA-AR-A1AY-01A-21D-A12R-05"], controls.data, anno)
y <- CNV.fit(tcga.data["TCGA-AR-A1AU-01A-11D-A12R-05"], minfi.data[minfi.controls], anno)  # minfiData control samples
z <- CNV.fit(tcga.data["TCGA-AR-A1AY-01A-21D-A12R-05"], minfi.data[minfi.controls], anno)

x <- CNV.bin(x)
x <- CNV.detail(x)
x <- CNV.segment(x)

y <- CNV.segment(CNV.detail(CNV.bin(y)))
z <- CNV.segment(CNV.detail(CNV.bin(z)))

x
## CNV analysis object
##    created   : Wed Oct 29 23:21:48 2025
##   @name      : GroupB_1
##   @anno      : 22 chromosomes, 470870 probes, 15820 bins
##   @fit       : available (noise: 0.237)
##   @bin       : available (shift: -0.018)
##   @detail    : available (20 regions)
##   @seg       : available (48 segments)
```

# 6 Output plots and text files

The `conumee` package supports two types of plots:

* The `CNV.genomeplot` method produces plots of the complete genome or of one or multiple chromosomes. Intensity values of each bin are plotted in colored dots. Segments are shown as blue lines. See `?CNV.genomeplot` for more details.
* The `CNV.detailplot` methods produces plots of individual detail regions, as defined in `CNV.create_anno`. Intensity values of individual probes are plotted in colored crosses. Bins are shown as blue lines. `CNV.detailplot_wrap` is a wrapper function that produces a single plot of all detail regions.

Text output is generated using the `CNV.write` method. Parameter `what` specifies if “probes”, “bins”, “detail” or “segments” should be returned. If parameter `file` is specified, the output is written into a file, otherwise a `data.frame` is returned. See `?CNV.write` for more details.

```
#pdf("~/conumee_analysis/CNVplots.pdf", height = 9, width = 18)
CNV.genomeplot(x)

CNV.genomeplot(y)
CNV.genomeplot(y, chr = "chr6")

CNV.genomeplot(z)
CNV.genomeplot(z, chr = "chr10")
CNV.detailplot(z, name = "PTEN")
CNV.detailplot_wrap(z)
#dev.off()

head(CNV.write(y, what = "segments"), n = 5)
##                             ID chrom loc.start   loc.end num.mark    bstat
## 1 TCGA-AR-A1AU-01A-11D-A12R-05  chr1    635684  88100000      726 29.32946
## 2 TCGA-AR-A1AU-01A-11D-A12R-05  chr1  88675000 118475000      163 32.18477
## 3 TCGA-AR-A1AU-01A-11D-A12R-05  chr1 119000000 249195311      704       NA
## 4 TCGA-AR-A1AU-01A-11D-A12R-05 chr10    105000 135462374      840       NA
## 5 TCGA-AR-A1AU-01A-11D-A12R-05 chr11    130000  50516927      326 22.74454
##            pval seg.mean seg.median
## 1 2.906752e-186    0.009      0.015
## 2 1.991610e-224   -0.264     -0.254
## 3            NA    0.097      0.098
## 4            NA   -0.023     -0.021
## 5 5.343554e-112    0.141      0.136

#CNV.write(y, what = "segments", file = "~/conumee_analysis/TCGA-AR-A1AU.CNVsegments.seg")  # adjust path
#CNV.write(y, what = "bins", file = "~/conumee_analysis/TCGA-AR-A1AU.CNVbins.igv")
#CNV.write(y, what = "detail", file = "~/conumee_analysis/TCGA-AR-A1AU.CNVdetail.txt")
#CNV.write(y, what = "probes", file = "~/conumee_analysis/TCGA-AR-A1AU.CNVprobes.igv")
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

# 7 Contact & citation

For bug-reports, comments and feature requests please write to conumee@hovestadt.bio.

When using `conumee` in your work, please cite as:

```
citation("conumee")
## To cite package 'conumee' in publications use:
##
##   Hovestadt V, Zapatka M (2017). "conumee: Enhanced copy-number
##   variation analysis using Illumina DNA methylation arrays.", R package
##   version 1.9.0. <URL: http://bioconductor.org/packages/conumee/>.
##
## A BibTeX entry for LaTeX users is
##
##   @Manual{,
##     title = {conumee: Enhanced copy-number variation analysis using Illumina DNA methylation
##     arrays},
##     author = {Volker Hovestadt and Marc Zapatka},
##     address = {Division of Molecular Genetics, German Cancer Research Center (DKFZ), Heidelberg, Germany},
##     note = {R package version 1.9.0},
##     url = {http://bioconductor.org/packages/conumee/},
##   }
```

# 8 Session info

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] minfiData_0.55.0
##  [2] conumee_1.44.0
##  [3] IlluminaHumanMethylationEPICmanifest_0.3.0
##  [4] IlluminaHumanMethylationEPICanno.ilm10b2.hg19_0.6.0
##  [5] IlluminaHumanMethylation450kmanifest_0.4.0
##  [6] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
##  [7] minfi_1.56.0
##  [8] bumphunter_1.52.0
##  [9] locfit_1.5-9.12
## [10] iterators_1.0.14
## [11] foreach_1.5.2
## [12] Biostrings_2.78.0
## [13] XVector_0.50.0
## [14] SummarizedExperiment_1.40.0
## [15] Biobase_2.70.0
## [16] MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0
## [18] GenomicRanges_1.62.0
## [19] Seqinfo_1.0.0
## [20] IRanges_2.44.0
## [21] S4Vectors_0.48.0
## [22] BiocGenerics_0.56.0
## [23] generics_0.1.4
## [24] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] beanplot_1.3.1            DBI_1.2.3
##   [3] bitops_1.0-9              magrittr_2.0.4
##   [5] rlang_1.1.6               scrime_1.3.5
##   [7] compiler_4.5.1            RSQLite_2.4.3
##   [9] GenomicFeatures_1.62.0    DelayedMatrixStats_1.32.0
##  [11] png_0.1-8                 vctrs_0.6.5
##  [13] quadprog_1.5-8            pkgconfig_2.0.3
##  [15] crayon_1.5.3              fastmap_1.2.0
##  [17] magick_2.9.0              Rsamtools_2.26.0
##  [19] rmarkdown_2.30            tzdb_0.5.0
##  [21] preprocessCore_1.72.0     tinytex_0.57
##  [23] purrr_1.1.0               bit_4.6.0
##  [25] xfun_0.53                 cachem_1.1.0
##  [27] cigarillo_1.0.0           jsonlite_2.0.0
##  [29] blob_1.2.4                rhdf5filters_1.22.0
##  [31] DelayedArray_0.36.0       reshape_0.8.10
##  [33] Rhdf5lib_1.32.0           BiocParallel_1.44.0
##  [35] R6_2.6.1                  bslib_0.9.0
##  [37] RColorBrewer_1.1-3        limma_3.66.0
##  [39] rtracklayer_1.70.0        genefilter_1.92.0
##  [41] DNAcopy_1.84.0            jquerylib_0.1.4
##  [43] Rcpp_1.1.0                bookdown_0.45
##  [45] knitr_1.50                readr_2.1.5
##  [47] tidyselect_1.2.1          rentrez_1.2.4
##  [49] illuminaio_0.52.0         Matrix_1.7-4
##  [51] splines_4.5.1             abind_1.4-8
##  [53] yaml_2.3.10               siggenes_1.84.0
##  [55] codetools_0.2-20          curl_7.0.0
##  [57] doRNG_1.8.6.2             tibble_3.3.0
##  [59] lattice_0.22-7            plyr_1.8.9
##  [61] KEGGREST_1.50.0           askpass_1.2.1
##  [63] evaluate_1.0.5            survival_3.8-3
##  [65] xml2_1.4.1                mclust_6.1.1
##  [67] pillar_1.11.1             BiocManager_1.30.26
##  [69] rngtools_1.5.2            RCurl_1.98-1.17
##  [71] hms_1.1.4                 sparseMatrixStats_1.22.0
##  [73] xtable_1.8-4              glue_1.8.0
##  [75] tools_4.5.1               BiocIO_1.20.0
##  [77] data.table_1.17.8         annotate_1.88.0
##  [79] GenomicAlignments_1.46.0  GEOquery_2.78.0
##  [81] XML_3.99-0.19             rhdf5_2.54.0
##  [83] grid_4.5.1                tidyr_1.3.1
##  [85] AnnotationDbi_1.72.0      base64_2.0.2
##  [87] nlme_3.1-168              nor1mix_1.3-3
##  [89] HDF5Array_1.38.0          restfulr_0.0.16
##  [91] cli_3.6.5                 S4Arrays_1.10.0
##  [93] dplyr_1.1.4               sass_0.4.10
##  [95] digest_0.6.37             SparseArray_1.10.0
##  [97] rjson_0.2.23              memoise_2.0.1
##  [99] htmltools_0.5.8.1         multtest_2.66.0
## [101] lifecycle_1.0.4           h5mread_1.2.0
## [103] httr_1.4.7                statmod_1.5.1
## [105] openssl_2.3.4             bit64_4.6.0-1
## [107] MASS_7.3-65
```

# References

1. Bibikova M, Barnes B, Tsan C, Ho V, Klotzle B, Le JM, Delano D, Zhang L, Schroth GP, Gunderson KL, Fan JB, Shen R: **High density DNA methylation array with single CpG site resolution.** *Genomics* 2011, **98**:288–295.

2. Sturm D, Witt H, Hovestadt V, Khuong-Quang D-A, Jones DT, Konermann C, Pfaff E, Toenjes M, Sill M, Bender S, Kool M, Zapatka M, Becker N, Zucknick M, Hielscher T, Liu XY, Fontebasso AM, Ryzhova M, Albrecht S, Jacob K, Wolter M, Ebinger M, Schuhmann MU, Meter T van, Fruehwald MC, Hauch H, Pekrun A, Radlwimmer B, Niehues T, Komorowski G von, et al.: **Hotspot mutations in H3F3A and IDH1 define distinct epigenetic and biological subgroups of glioblastoma.** *Cancer Cell* 2012, **22**:425–437.

3. Feber A, Guilhamon P, Lechner M, Fenton T, Wilson GA, Thirlwell C, Morris TJ, Flanagan AM, Teschendorff AE, Kelly JD, Beck S: **Using high-density DNA methylation arrays to profile copy number alterations.** *Genome Biology* 2014, **15**.

4. Aryee MJ, Jaffe AE, Hector C, Christine L, Feinberg AP, Hansen KD, Irizarry RA: **Minfi: A flexible and comprehensive bioconductor package for the analysis of infinium DNA methylation microarrays.** *Bioinformatics* 2014, **30**:1363–1369.

5. Olshen AB, Venkatraman E, Lucito R, Wigler M: **Circular binary segmentation for the analysis of array-based DNA copy number data.** *Biostatistics* 2004, **5**:557–572.