# GeoTcgaData

---

## Authors

Erqiang Hu

Department of Bioinformatics, School of Basic Medical Sciences, Southern Medical University.

## Introduction

GEO and TCGA provide us with a wealth of data, such as RNA-seq, DNA Methylation, single nucleotide Variation and Copy number variation data. It’s easy to download data from TCGA using the  gdc tool or `TCGAbiolinks`, and some software provides organized TCGA data, such as [UCSC Xena](http://xena.ucsc.edu/) , UCSCXenaTools, and [sangerbox](http://vip.sangerbox.com/), but processing these data into a format suitable for bioinformatics  analysis requires more work. This R package was developed to handle these data.

```
library(GeoTcgaData)
```

## Example

This is a basic example which shows you how to solve a common problem:

### RNA-seq data differential expression analysis

It is convenient to use TCGAbiolinks  or [`GDCRNATools`](https://bioconductor.org/packages/GDCRNATools/) to download and analysis Gene expression data.  `TCGAbiolinks` use `edgeR` package to do differential expression analysis, while `GDCRNATools` can implement three most commonly used methods: limma, edgeR , and DESeq2 to identify differentially expressed  genes (DEGs).

Alicia Oshlack  et al. claimed that unlike the chip data, the RNA-seq data had one [bias](https://pubmed.ncbi.nlm.nih.gov/20132535/)[1]: the larger the transcript length / mean read count , the more likely it was to be  identified as a differential gene, while there was no such trend in the [chip data](https://pubmed.ncbi.nlm.nih.gov/19371405/)[2].

 However, when we use their chip data for difference analysis  (using the limma package), we find that chip data has the same trend as  RNA-seq data. And we also found this trend in the difference analysis results  given by the data  [authors](https://genome.cshlp.org/content/18/9/1509.long)[3].

 It is worse noting that only technical replicate data, which has small gene  dispersions, shows this [bias](https://pubmed.ncbi.nlm.nih.gov/28545404/)[4].  This is because in technical replicate RNA-seq data a long gene has more  reads mapping to it compared to a short gene of similar expression,  and most of the statistical methods used to detect differential expression  have stronger detection ability for genes with more reads. However, we have  not deduced why there is such a bias in the current difference  analysis algorithms.

Some software, such as [CQN](http://www.bioconductor.org/packages/cqn/) , present a [normalization algorithm](https://pubmed.ncbi.nlm.nih.gov/22285995/) [5] to correct systematic biases(gene length bias and [GC-content bias](https://pubmed.ncbi.nlm.nih.gov/22177264/)[6]. But they did not provide sufficient evidence to prove that the correction is effective. We use the [Marioni dataset](https://pubmed.ncbi.nlm.nih.gov/19371405/)[2] to verify the correction effect of CQN and find that there is still a deviation after correction:

[GOseq](http://bioconductor.org/packages/goseq/) [1]based on Wallenius’ noncentral hypergeometric distribution can effectively correct the gene length deviation in enrichment analysis. However, the current RNA-seq data often have no gene length bias, but only the expression amount(read count) bias, GOseq may overcorrect these data, correcting originally unbiased data into reverse bias.

GOseq also fails to correct for expression bias, therefore, read count bias correction is still a challenge for us.

```
# use user-defined data
df <- matrix(rnbinom(400, mu = 4, size = 10), 25, 16)
df <- as.data.frame(df)
rownames(df) <- paste0("gene", 1:25)
colnames(df) <- paste0("sample", 1:16)
group <- sample(c("group1", "group2"), 16, replace = TRUE)
result <- differential_RNA(counts = df, group = group,
    filte = FALSE, method = "Wilcoxon")
# use SummarizedExperiment object input
df <- matrix(rnbinom(400, mu = 4, size = 10), 25, 16)
rownames(df) <- paste0("gene", 1:25)
colnames(df) <- paste0("sample", 1:16)
group <- sample(c("group1", "group2"), 16, replace = TRUE)

nrows <- 200; ncols <- 20
counts <- matrix(
    runif(nrows * ncols, 1, 1e4), nrows,
    dimnames = list(paste0("cg",1:200),paste0("S",1:20))
)

colData <- S4Vectors::DataFrame(
  row.names = paste0("sample", 1:16),
  group = group
)
data <- SummarizedExperiment::SummarizedExperiment(
         assays=S4Vectors::SimpleList(counts=df),
         colData = colData)

result <- differential_RNA(counts = data, groupCol = "group",
    filte = FALSE, method = "Wilcoxon")
```

### DNA Methylation data integration

use `TCGAbiolinks` data.

The codes may need to be modified if `TCGAbiolinks` updates. So please read its documents.

```
# use user defined data
library(ChAMP)
cpgData <- matrix(runif(2000), nrow = 200, ncol = 10)
rownames(cpgData) <- paste0("cpg", seq_len(200))
colnames(cpgData) <- paste0("sample", seq_len(10))
sampleGroup <- c(rep("group1", 5), rep("group2", 5))
names(sampleGroup) <- colnames(cpgData)
cpg2gene <- data.frame(cpg = rownames(cpgData),
    gene = rep(paste0("gene", seq_len(20)), 10))
result <- differential_methy(cpgData, sampleGroup,
    cpg2gene = cpg2gene, normMethod = NULL)
# use SummarizedExperiment object input
library(ChAMP)
cpgData <- matrix(runif(2000), nrow = 200, ncol = 10)
rownames(cpgData) <- paste0("cpg", seq_len(200))
colnames(cpgData) <- paste0("sample", seq_len(10))
sampleGroup <- c(rep("group1", 5), rep("group2", 5))
names(sampleGroup) <- colnames(cpgData)
cpg2gene <- data.frame(cpg = rownames(cpgData),
    gene = rep(paste0("gene", seq_len(20)), 10))
colData <- S4Vectors::DataFrame(
    row.names = colnames(cpgData),
    group = sampleGroup
)
data <- SummarizedExperiment::SummarizedExperiment(
         assays=S4Vectors::SimpleList(counts=cpgData),
         colData = colData)
result <- differential_methy(cpgData = data,
    groupCol = "group", normMethod = NULL,
    cpg2gene = cpg2gene)
```

**Note:** `ChAMP`has a large number of dependent packages. If you cannot install it successfully, you can download each dependent package separately(Source or Binary) and install it locally.

We provide two models to get methylation difference genes:

if model = “cpg”, step1: calculate difference cpgs; step2: calculate difference genes;

if model = “gene”, step1: calculate the methylation level of genes; step2: calculate difference genes.

We find that only model = “gene” has no deviation of CpG number.

### Copy number variation data integration and differential gene extraction

use TCGAbiolinks to download TCGA data(Gene Level Copy Number Scores)

```
# use random data as example
aa <- matrix(sample(c(0, 1, -1), 200, replace = TRUE), 25, 8)
rownames(aa) <- paste0("gene", 1:25)
colnames(aa) <- paste0("sample", 1:8)
sampleGroup <- sample(c("A", "B"), ncol(aa), replace = TRUE)
diffCnv <- differential_CNV(aa, sampleGroup)
```

### Difference analysis of single nucleotide Variation data

We provide SNP\_QC function to do quality control of SNP data

```
snpDf <- matrix(sample(c("AA", "Aa", "aa"), 100, replace = TRUE), 10, 10)
snpDf <- as.data.frame(snpDf)
sampleGroup <- sample(c("A", "B"), 10, replace = TRUE)
result <- SNP_QC(snpDf)
```

Then use differential\_SNP to do differential analysis.

```
#' snpDf <- matrix(sample(c("mutation", NA), 100, replace = TRUE), 10, 10)
#' snpDf <- as.data.frame(snpDf)
#' sampleGroup <- sample(c("A", "B"), 10, replace = TRUE)
#' result <- differential_SNP(snpDf, sampleGroup)
```

### GEO chip data processing

The function `gene_ave` could average the expression data of different ids for the same gene in the GEO chip data. For example:

```
aa <- c("MARCH1","MARC1","MARCH1","MARCH1","MARCH1")
bb <- c(2.969058399,4.722410064,8.165514853,8.24243893,8.60815086)
cc <- c(3.969058399,5.722410064,7.165514853,6.24243893,7.60815086)
file_gene_ave <- data.frame(aa=aa,bb=bb,cc=cc)
colnames(file_gene_ave) <- c("Gene", "GSM1629982", "GSM1629983")
result <- gene_ave(file_gene_ave, 1)
```

Multiple genes symbols may correspond to a same chip id. The result of function `repAssign` is to assign the expression of this id to each gene, and function `repRemove` deletes the expression. For example:

```
aa <- c("MARCH1 /// MMA","MARC1","MARCH2 /// MARCH3",
        "MARCH3 /// MARCH4","MARCH1")
bb <- c("2.969058399","4.722410064","8.165514853","8.24243893","8.60815086")
cc <- c("3.969058399","5.722410064","7.165514853","6.24243893","7.60815086")
input_file <- data.frame(aa=aa,bb=bb,cc=cc)
repAssign_result <- repAssign(input_file," /// ")
repRemove_result <- repRemove(input_file," /// ")
```

### Other downstream analyses

1. The function `id_conversion_TCGA` could convert ENSEMBL gene id to gene Symbol in TCGA. For example:

```
data(profile)
result <- id_conversion_TCGA(profile)
```

The parameter `profile` is a data.frame or matrix of gene expression data in TCGA.

**Note:** In previous versions(< 1.0.0) the `id_conversion` and `id_conversion_TCGA` used HGNC data to convert human gene id.
In future versions, we will use `clusterProfiler::bitr` for ID conversion.

2. The function `countToFpkm` and `countToTpm` could convert count data to FPKM or TPM data.

```
data(gene_cov)
lung_squ_count2 <- matrix(c(1,2,3,4,5,6,7,8,9),ncol=3)
rownames(lung_squ_count2) <- c("DISC1","TCOF1","SPPL3")
colnames(lung_squ_count2) <- c("sample1","sample2","sample3")
result <- countToFpkm(lung_squ_count2, keyType = "SYMBOL",
    gene_cov = gene_cov)
#> 'select()' returned 1:1 mapping between keys and columns
#> Warning in clusterProfiler::bitr(rownames(gene_cov), fromType = "ENTREZID", :
#> 0.08% of input gene IDs are fail to map...
```

```
data(gene_cov)
lung_squ_count2 <- matrix(c(0.11,0.22,0.43,0.14,0.875,
    0.66,0.77,0.18,0.29),ncol=3)
rownames(lung_squ_count2) <- c("DISC1","TCOF1","SPPL3")
colnames(lung_squ_count2) <- c("sample1","sample2","sample3")
result <- countToTpm(lung_squ_count2, keyType = "SYMBOL",
    gene_cov = gene_cov)
```

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
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] ChAMP_2.40.0
#>  [2] RPMM_1.25
#>  [3] cluster_2.1.8.1
#>  [4] DT_0.34.0
#>  [5] IlluminaHumanMethylationEPICmanifest_0.3.0
#>  [6] Illumina450ProbeVariants.db_1.45.0
#>  [7] DMRcate_3.6.0
#>  [8] ChAMPdata_2.41.0
#>  [9] minfi_1.56.0
#> [10] bumphunter_1.52.0
#> [11] locfit_1.5-9.12
#> [12] iterators_1.0.14
#> [13] foreach_1.5.2
#> [14] Biostrings_2.78.0
#> [15] XVector_0.50.0
#> [16] SummarizedExperiment_1.40.0
#> [17] Biobase_2.70.0
#> [18] MatrixGenerics_1.22.0
#> [19] matrixStats_1.5.0
#> [20] GenomicRanges_1.62.0
#> [21] Seqinfo_1.0.0
#> [22] IRanges_2.44.0
#> [23] S4Vectors_0.48.0
#> [24] BiocGenerics_0.56.0
#> [25] generics_0.1.4
#> [26] GeoTcgaData_2.10.0
#>
#> loaded via a namespace (and not attached):
#>   [1] R.methodsS3_1.8.2
#>   [2] dichromat_2.0-0.1
#>   [3] cqn_1.56.0
#>   [4] progress_1.2.3
#>   [5] nnet_7.3-20
#>   [6] shinythemes_1.2.0
#>   [7] HDF5Array_1.38.0
#>   [8] vctrs_0.6.5
#>   [9] ggtangle_0.0.7
#>  [10] digest_0.6.37
#>  [11] png_0.1-8
#>  [12] lumi_2.62.0
#>  [13] ggrepel_0.9.6
#>  [14] deldir_2.0-4
#>  [15] combinat_0.0-8
#>  [16] permute_0.9-8
#>  [17] fontLiberation_0.1.0
#>  [18] MASS_7.3-65
#>  [19] reshape_0.8.10
#>  [20] reshape2_1.4.4
#>  [21] httpuv_1.6.16
#>  [22] qvalue_2.42.0
#>  [23] ggfun_0.2.0
#>  [24] xfun_0.53
#>  [25] survival_3.8-3
#>  [26] doRNG_1.8.6.2
#>  [27] memoise_2.0.1
#>  [28] gson_0.1.0
#>  [29] clusterProfiler_4.18.0
#>  [30] MatrixModels_0.5-4
#>  [31] BiasedUrn_2.0.12
#>  [32] systemfonts_1.3.1
#>  [33] tidytree_0.4.6
#>  [34] gtools_3.9.5
#>  [35] DNAcopy_1.84.0
#>  [36] R.oo_1.27.1
#>  [37] Formula_1.2-5
#>  [38] prettyunits_1.2.0
#>  [39] KEGGREST_1.50.0
#>  [40] promises_1.4.0
#>  [41] otel_0.2.0
#>  [42] httr_1.4.7
#>  [43] restfulr_0.0.16
#>  [44] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
#>  [45] rhdf5filters_1.22.0
#>  [46] rhdf5_2.54.0
#>  [47] rstudioapi_0.17.1
#>  [48] UCSC.utils_1.6.0
#>  [49] DOSE_4.4.0
#>  [50] base64enc_0.1-3
#>  [51] curl_7.0.0
#>  [52] h5mread_1.2.0
#>  [53] quadprog_1.5-8
#>  [54] ExperimentHub_3.0.0
#>  [55] SparseArray_1.10.0
#>  [56] xtable_1.8-4
#>  [57] stringr_1.5.2
#>  [58] doParallel_1.0.17
#>  [59] evaluate_1.0.5
#>  [60] S4Arrays_1.10.0
#>  [61] BiocFileCache_3.0.0
#>  [62] preprocessCore_1.72.0
#>  [63] hms_1.1.4
#>  [64] colorspace_2.1-2
#>  [65] filelock_1.0.3
#>  [66] JADE_2.0-4
#>  [67] IlluminaHumanMethylationEPICanno.ilm10b4.hg19_0.6.0
#>  [68] marray_1.88.0
#>  [69] magrittr_2.0.4
#>  [70] readr_2.1.5
#>  [71] ggtree_4.0.0
#>  [72] later_1.4.4
#>  [73] viridis_0.6.5
#>  [74] lattice_0.22-7
#>  [75] genefilter_1.92.0
#>  [76] SparseM_1.84-2
#>  [77] cowplot_1.2.0
#>  [78] XML_3.99-0.19
#>  [79] Hmisc_5.2-4
#>  [80] pillar_1.11.1
#>  [81] nlme_3.1-168
#>  [82] compiler_4.5.1
#>  [83] beachmat_2.26.0
#>  [84] stringi_1.8.7
#>  [85] dendextend_1.19.1
#>  [86] GenomicAlignments_1.46.0
#>  [87] plyr_1.8.9
#>  [88] crayon_1.5.3
#>  [89] abind_1.4-8
#>  [90] BiocIO_1.20.0
#>  [91] gridGraphics_0.5-1
#>  [92] org.Hs.eg.db_3.22.0
#>  [93] bit_4.6.0
#>  [94] dplyr_1.1.4
#>  [95] fastmatch_1.1-6
#>  [96] codetools_0.2-20
#>  [97] openssl_2.3.4
#>  [98] bslib_0.9.0
#>  [99] biovizBase_1.58.0
#> [100] plotly_4.11.0
#> [101] multtest_2.66.0
#> [102] mime_0.13
#> [103] wateRmelon_2.16.0
#> [104] splines_4.5.1
#> [105] Rcpp_1.1.0
#> [106] quantreg_6.1
#> [107] dbplyr_2.5.1
#> [108] sparseMatrixStats_1.22.0
#> [109] IlluminaHumanMethylation450kmanifest_0.4.0
#> [110] interp_1.1-6
#> [111] knitr_1.50
#> [112] blob_1.2.4
#> [113] clue_0.3-66
#> [114] BiocVersion_3.22.0
#> [115] AnnotationFilter_1.34.0
#> [116] fs_1.6.6
#> [117] checkmate_2.3.3
#> [118] DelayedMatrixStats_1.32.0
#> [119] Gviz_1.54.0
#> [120] ggplotify_0.1.3
#> [121] tibble_3.3.0
#> [122] Matrix_1.7-4
#> [123] statmod_1.5.1
#> [124] tzdb_0.5.0
#> [125] pkgconfig_2.0.3
#> [126] tools_4.5.1
#> [127] cachem_1.1.0
#> [128] cigarillo_1.0.0
#> [129] RSQLite_2.4.3
#> [130] viridisLite_0.4.2
#> [131] globaltest_5.64.0
#> [132] DBI_1.2.3
#> [133] impute_1.84.0
#> [134] fastmap_1.2.0
#> [135] rmarkdown_2.30
#> [136] scales_1.4.0
#> [137] grid_4.5.1
#> [138] Rsamtools_2.26.0
#> [139] AnnotationHub_4.0.0
#> [140] sass_0.4.10
#> [141] patchwork_1.3.2
#> [142] BiocManager_1.30.26
#> [143] VariantAnnotation_1.56.0
#> [144] scrime_1.3.5
#> [145] rpart_4.1.24
#> [146] farver_2.1.2
#> [147] mgcv_1.9-3
#> [148] yaml_2.3.10
#> [149] latticeExtra_0.6-31
#> [150] foreign_0.8-90
#> [151] rtracklayer_1.70.0
#> [152] illuminaio_0.52.0
#> [153] cli_3.6.5
#> [154] purrr_1.1.0
#> [155] siggenes_1.84.0
#> [156] GEOquery_2.78.0
#> [157] txdbmaker_1.6.0
#> [158] lifecycle_1.0.4
#> [159] askpass_1.2.1
#> [160] backports_1.5.0
#> [161] BiocParallel_1.44.0
#> [162] annotate_1.88.0
#> [163] methylumi_2.56.0
#> [164] gtable_0.3.6
#> [165] rjson_0.2.23
#> [166] missMethyl_1.44.0
#> [167] ape_5.8-1
#> [168] limma_3.66.0
#> [169] jsonlite_2.0.0
#> [170] edgeR_4.8.0
#> [171] isva_1.9
#> [172] bitops_1.0-9
#> [173] ggplot2_4.0.0
#> [174] bit64_4.6.0-1
#> [175] assertthat_0.2.1
#> [176] yulab.utils_0.2.1
#> [177] base64_2.0.2
#> [178] geneLenDataBase_1.45.0
#> [179] jquerylib_0.1.4
#> [180] GOSemSim_2.36.0
#> [181] R.utils_2.13.0
#> [182] lazyeval_0.2.2
#> [183] shiny_1.11.1
#> [184] enrichplot_1.30.0
#> [185] htmltools_0.5.8.1
#> [186] affy_1.88.0
#> [187] GO.db_3.22.0
#> [188] rappdirs_0.3.3
#> [189] ensembldb_2.34.0
#> [190] glue_1.8.0
#> [191] ROC_1.86.0
#> [192] httr2_1.2.1
#> [193] gdtools_0.4.4
#> [194] RCurl_1.98-1.17
#> [195] treeio_1.34.0
#> [196] mclust_6.1.1
#> [197] BSgenome_1.78.0
#> [198] jpeg_0.1-11
#> [199] gridExtra_2.3
#> [200] igraph_2.2.1
#> [201] R6_2.6.1
#> [202] ggiraph_0.9.2
#> [203] sva_3.58.0
#> [204] tidyr_1.3.1
#> [205] GenomicFeatures_1.62.0
#> [206] rngtools_1.5.2
#> [207] Rhdf5lib_1.32.0
#> [208] beanplot_1.3.1
#> [209] aplot_0.2.9
#> [210] GenomeInfoDb_1.46.0
#> [211] bsseq_1.46.0
#> [212] DelayedArray_0.36.0
#> [213] tidyselect_1.2.1
#> [214] ProtGenerics_1.42.0
#> [215] nleqslv_3.3.5
#> [216] htmlTable_2.4.3
#> [217] xml2_1.4.1
#> [218] fontBitstreamVera_0.1.1
#> [219] AnnotationDbi_1.72.0
#> [220] fastICA_1.2-7
#> [221] KernSmooth_2.23-26
#> [222] goseq_1.62.0
#> [223] S7_0.2.0
#> [224] fontquiver_0.2.1
#> [225] affyio_1.80.0
#> [226] nor1mix_1.3-3
#> [227] data.table_1.17.8
#> [228] fgsea_1.36.0
#> [229] htmlwidgets_1.6.4
#> [230] RColorBrewer_1.1-3
#> [231] biomaRt_2.66.0
#> [232] rlang_1.1.6
#> [233] rentrez_1.2.4
#> [234] topconfects_1.26.0
```

## References

1. Young MD, Wakefield MJ, Smyth GK, Oshlack A (2010) Gene ontology analysis for RNA-seq: accounting for selection bias. Genome Biol 11: R14.
2. Oshlack A, Wakefield MJ (2009) Transcript length bias in RNA-seq data confounds systems biology. Biol Direct 4: 14.
3. Marioni JC, Mason CE, Mane SM, Stephens M, Gilad Y (2008) RNA-seq: an assessment of technical reproducibility and comparison with gene expression arrays. Genome Res 18: 1509-1517.
4. Yoon S, Nam D (2017) Gene dispersion is the key determinant of the read count bias in differential expression analysis of RNA-seq data. BMC Genomics 18: 408.
5. Hansen KD, Irizarry RA, Wu Z (2012) Removing technical variability in RNA-seq data using conditional quantile normalization. Biostatistics 13: 204-216.
6. Risso D, Schwartz K, Sherlock G, Dudoit S (2011) GC-content normalization for RNA-Seq data. BMC Bioinformatics 12: 480.