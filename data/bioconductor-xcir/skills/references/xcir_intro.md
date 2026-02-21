# Introduction

XCIR implements statistical models designed for the analysis of the X-chromosome.
Specifically, it provides mixture-models for the estimation of the fraction
of inactivation of each parental X (skewing or mosaicism) and tests to
identify X-linked genes escape the inactivation mechanism.

In this vignette, we present a typical pipeline from allele-specific RNA-Seq
counts to subject level estimates of mosaicism and XCI-states for all
X-linked genes.

## Pipeline

`XCIR`'s pipeline for calling XCI-states at the subject usually involve

1. Reading the data (`readVCF4`, `readRNASNPs`)
2. Annotating SNPs (`annnotateX`, `addAnno`)
3. Summarizing information by gene (`getGenicDP`)
4. Modelling (`betaBinomXI`)
   a. Skewing estimate
   b. XCI-calls

# Reading data

Internally, `XCIR` uses `data.table` for efficient computation and most functions
in the package will return a `data.table` object. Naturally, `data.frame` are
accepted as inputs and the conversion of the outputs is trivial.

```
library(XCIR)
library(data.table)
```

We load a small dataset of two samples to display the requirements and
highlight some of the pre-processing functions.

```
vcff <- system.file("extdata/AD_example.vcf", package = "XCIR")
vcf <- readVCF4(vcff)
head(vcf)
```

```
##    CHROM    POS REF ALT sample AD_hap1 AD_hap2
## 1:     X 167755   G   T  samp1       0       0
## 2:     X 167755   G   T  samp2       0       0
## 3:     X 167824   T   C  samp1       0       0
## 4:     X 167824   T   C  samp2       0       0
## 5:     X 167885   A   T  samp1       0       0
## 6:     X 167885   A   T  samp2       0       0
```

This dataset contains the minimum information required to go through the
`XCIR` workflow.

The function `readVCF4` is only provided to help extract essential information
but the data can be loaded through other means as long as allele specific
expression is present and both the SNP and sample are clearly identified.
REF & ALT columns are naturally present in all vcf files
but can be safely omitted for further processing.

# Annotating the data

In order to obtain allele specific expression for the X-linked genes, we first
need to map SNPs to genes and ensure that they are heterozygous. We provide
a function to map SNPs to genes using infromation extracted from ensembl through
`biomaRt`.

```
annoX <- annotateX(vcf)
head(annoX)
```

```
##            ID GENE GENE_pos CHROM      POS REF ALT sample AD_hap1 AD_hap2
## 1: X:10112338 WWC3 10048060     X 10112338   C   A  samp1      17      43
## 2: X:10112338 WWC3 10048060     X 10112338   C   A  samp2      22      64
## 3: X:11785924 MSL3 11785074     X 11785924   A   G  samp1      18      22
## 4: X:11786839 MSL3 11785074     X 11786839   T   C  samp2      14      16
## 5: X:12903659 TLR7 12896850     X 12903659   A   T  samp1      10      38
## 6: X:12906030 TLR7 12896850     X 12906030   G   A  samp2      47      21
```

This adds a GENE column to the dataset and removes SNPs with a lower totak read
count or a read count that is too small on one of the alleles (homozygous SNPs).

In some cases, the data may already be filtered for heterozygous SNPs
(e.g: If genotyping information is also available for the sample). In this
case, the minimum read threshold for **both alleles** can be lowered or removed.

```
annoXgeno <- annotateX(vcf, het_cutoff = 0)
```

By default, `annotateX` aligns to `hg19`. Other versions can be passed through
the `release` argument.

Finally, another option for annotations is through the `seqminer` package. For
more information see `addAnno`'s man page and `annotatePlain` in the seqminer
manual.

Again, this is provided for convenience but annotations mapping to genes through
other means is perfectly valid as long as a new GENE column is added to the
table.

# Summarize by gene

Now that we have annotated SNPs, we can summarize the counts for each gene
to make independant calls.

When high quality phasing information is available, SNPs are reliably
assigned to the correct haplotype and the allele specific counts of all
SNPs within a gene can be summed to get a better estimate of the fraction
of each parental cell (mosaicism).

```
genic <- getGenicDP(annoX, highest_expr = TRUE)
head(genic)
```

```
##            ID GENE GENE_pos CHROM      POS REF ALT sample AD_hap1 AD_hap2
## 1: X:10112338 WWC3 10048060     X 10112338   C   A  samp1      17      43
## 2: X:10112338 WWC3 10048060     X 10112338   C   A  samp2      22      64
## 3: X:11785924 MSL3 11785074     X 11785924   A   G  samp1      18      22
## 4: X:11786839 MSL3 11785074     X 11786839   T   C  samp2      14      16
## 5: X:12903659 TLR7 12896850     X 12903659   A   T  samp1      10      38
## 6: X:12906030 TLR7 12896850     X 12906030   G   A  samp2      47      21
##    gender n_snps tot
## 1: female      1  60
## 2: female      1  86
## 3: female      1  40
## 4: female      1  30
## 5: female      1  48
## 6: female      1  68
```

When this isn't the case, we can only safely use one SNP. Therefore, we limit
our data to the most highly expressed SNP in each gene.

```
genic <- getGenicDP(annoX, highest_expr = FALSE)
```

# Skewing estimates & XCI-escape inference

For this section, we load a simulated example inlcuded with the package.
Read counts for allele specific expression (ASE) at heterozygous SNP and skewing
based on pre-determined mode and overdispersion parameters are simulated. The
list of training genes is included.

```
data <- fread(system.file("extdata/data34_vignette.tsv", package = "XCIR"))
xcig <- readLines(system.file("extdata/xcig_vignette.txt", package = "XCIR"))
```

```
head(data)
```

```
##      sample gender CHROM        GENE  true_status AD_hap1 AD_hap2 tot
## 1: sample30 female     X gene_test_1 test_subject      32     281 313
## 2: sample31 female     X gene_test_1 test_subject      53     260 313
## 3: sample32 female     X gene_test_1 test_subject      77     236 313
## 4: sample33 female     X gene_test_1 test_subject      79     234 313
## 5: sample34 female     X gene_test_1 test_subject      87     226 313
## 6: sample35 female     X gene_test_1 test_subject      66     247 313
```

The data presented here contains the minimum necessary information to start
imediately at the modelling step.

Raw data can be read from a VCF file using `readVCF4`. The only requirements
being that the allelic depth (AD) field should be recorded in the VCF.

The main function of the package `betaBinomXI` allows to fit a simple beta-binomial
distribution to the expression of genes in the training set.

```
bb <- betaBinomXI(data, xciGenes = xcig, model = "BB")
```

This will estimate the skewing for each individual as well as test for
XCI-escape for each gene in each sample.

## Models

In this example, the training set contains artificial sequencing errors in some of the samples,
such that a simple beta-binomial may not be the best choice to fit the training data.

The `plotQC` function plots the estimated skewing along with the observed
allele specific expression fraction in the training genes.

It can be used to spot outliers (such as sequencing errors or escape genes in
the training set) to use a better fitting model.

```
plotQC(bb[sample == "sample36"], xcig = xcig)
```

![plot of chunk unnamed-chunk-5](data:image/png;base64... "plot of chunk unnamed-chunk-5")

```
s36 <- data[sample == "sample36"]
```

For example, looking at the QC plot for the sample above, we observe that a
few training genes have a suspiciously low \(f\_g\) (i.e: very highly skewed).
This is often due to sequencing error making an homozygous SNP appear as
heterozygous.

Here, we let the AIC based model selection procedure select the best fitting
model for that sample.

```
s36fit <- betaBinomXI(s36, model = "AUTO", xciGenes = xcig, plot = TRUE)
```

![plot of chunk betabin-s36](data:image/png;base64... "plot of chunk betabin-s36")

The function correctly identified the outliers and selected the “MM” model,
which is a mixture model with a Beta-binomial component for the true
heterozygous SNPs and a binomial mixture to fit the sequencing errors.

This can naturally be applied to the full dataset for subject specific model
selection.

```
auto <- betaBinomXI(data, xciGenes = xcig, model = "AUTO")
```

The returned table contains a skewing estimate **f** for every subject and
a p-value for XCI-escape test for each sample/gene combination.

It is then trivial to annotate the XCI status for each gene based on the selected
significance threshold.

```
auto[, status := ifelse(p_value < 0.05, "E", "S")]
auto[, .N, by = "status"]
```

```
##    status   N
## 1:      S 750
## 2:      E 394
```

## Helpers

The table returned by `betaBinomXI` is comprehensive. In order to summarize
results at the subject level, `sample_clean` returns informations
relevant to each sample, such as estimated skew and the model used.

```
sc <- sample_clean(auto)
head(sc)
```

```
##      sample model          f        a_est        b_est
## 1: sample30    MM 0.09754767 3.341427e+01     309.1287
## 2: sample31    BB 0.24807246 1.642445e+06 4978382.5780
## 3: sample32   MM3 0.23260832 1.333344e+03    4398.7996
## 4: sample33    BB 0.24142586 3.016987e+05  947954.8098
## 5: sample34    MM 0.25126586 6.533422e+01     194.6861
## 6: sample35    MM 0.24574585 4.982794e+05 1529341.2573
```

Although one of `XCIR`'s major strength is in its ability to make individual
level calls, it can be of interest to look at the classification of X-linked
genes in the entire dataset.

For every gene in the dataset, `getXCIstate` reports the number of samples
where a call was made (Ntot), the percentage of them in which it escaped (pe)
and an overall classification based on the following cutoffs

* pe \(\leq\) .25 \(\rightarrow\) Silenced (S)
* .25 < pe < .75 \(\rightarrow\) Variable escape (VE)
* pe \(\geq\) .75 \(\rightarrow\) Escape (E)

```
xcis <- getXCIstate(auto)
head(xcis)
```

```
##            GENE Ntot Nesc         pe XCIstate
## 1:  gene_test_1   11    0 0.00000000        S
## 2: gene_test_11   11    8 0.72727273       VE
## 3: gene_test_13   11    1 0.09090909        S
## 4: gene_test_14   11   10 0.90909091        E
## 5: gene_test_16   11    9 0.81818182        E
## 6: gene_test_17   11   11 1.00000000        E
```

# Session info

```
sessionInfo()
```

```
## R version 3.6.1 (2019-07-05)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.10-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.10-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] data.table_1.12.6 XCIR_1.0.0        knitr_1.25
##
## loaded via a namespace (and not attached):
##  [1] Biobase_2.46.0              httr_1.4.1
##  [3] bit64_0.9-7                 assertthat_0.2.1
##  [5] askpass_1.1                 highr_0.8
##  [7] stats4_3.6.1                BiocFileCache_1.10.0
##  [9] blob_1.2.0                  BSgenome_1.54.0
## [11] GenomeInfoDbData_1.2.2      cellranger_1.1.0
## [13] Rsamtools_2.2.0             progress_1.2.2
## [15] pillar_1.4.2                RSQLite_2.1.2
## [17] backports_1.1.5             lattice_0.20-38
## [19] glue_1.3.1                  digest_0.6.22
## [21] GenomicRanges_1.38.0        XVector_0.26.0
## [23] colorspace_1.4-1            Matrix_1.2-17
## [25] XML_3.98-1.20               pkgconfig_2.0.3
## [27] biomaRt_2.42.0              zlibbioc_1.32.0
## [29] purrr_0.3.3                 scales_1.0.0
## [31] seqminer_7.1                BiocParallel_1.20.0
## [33] tibble_2.1.3                openssl_1.4.1
## [35] IRanges_2.20.0              ggplot2_3.2.1
## [37] SummarizedExperiment_1.16.0 GenomicFeatures_1.38.0
## [39] BiocGenerics_0.32.0         lazyeval_0.2.2
## [41] magrittr_1.5                crayon_1.3.4
## [43] readxl_1.3.1                memoise_1.1.0
## [45] evaluate_0.14               tools_3.6.1
## [47] prettyunits_1.0.2           hms_0.5.1
## [49] matrixStats_0.55.0          stringr_1.4.0
## [51] S4Vectors_0.24.0            munsell_0.5.0
## [53] DelayedArray_0.12.0         AnnotationDbi_1.48.0
## [55] Biostrings_2.54.0           compiler_3.6.1
## [57] GenomeInfoDb_1.22.0         rlang_0.4.1
## [59] grid_3.6.1                  RCurl_1.95-4.12
## [61] VariantAnnotation_1.32.0    rappdirs_0.3.1
## [63] bitops_1.0-6                labeling_0.3
## [65] gtable_0.3.0                DBI_1.0.0
## [67] curl_4.2                    R6_2.4.0
## [69] GenomicAlignments_1.22.0    dplyr_0.8.3
## [71] rtracklayer_1.46.0          bit_1.1-14
## [73] zeallot_0.1.0               stringi_1.4.3
## [75] parallel_3.6.1              Rcpp_1.0.2
## [77] vctrs_0.2.0                 dbplyr_1.4.2
## [79] tidyselect_0.2.5            xfun_0.10
```