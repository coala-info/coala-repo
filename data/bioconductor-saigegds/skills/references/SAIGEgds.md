# Scalable Generalized Mixed Models in PheWAS using SAIGEgds

#### Xiuwen Zheng (Genomics Research Center, AbbVie, North Chicago, US)

#### Mar, 2020

* [1 Installation](#installation)
* [2 Examples](#examples)
  + [2.1 Preparing SNP data for genetic relationship matrix](#preparing-snp-data-for-genetic-relationship-matrix)
  + [2.2 Fitting the null model](#fitting-the-null-model)
  + [2.3 P-value calculations](#p-value-calculations)
  + [2.4 Manhattan and QQ plots for p-values](#manhattan-and-qq-plots-for-p-values)
* [3 Session Information](#session-information)
* [4 References](#references)
* [5 See also](#see-also)

.

.

A phenome-wide association study (PheWAS) is known to be a powerful tool in discovery and replication of genetic association studies. The recent development in the UK Biobank resource with deep genomic and phenotyping data has provided unparalleled research opportunities. To reduce the computational complexity and cost of PheWAS, the SAIGE (scalable and accurate implementation of generalized mixed model [1]) method was proposed recently, controlling for case-control imbalance and sample structure in single variant association studies. However, it is still computationally challenging to analyze the associations of thousands of phenotypes with whole-genome variant data, especially for disease diagnoses using the ICD-10 codes of deep phenotyping.

Here we develop a new high-performance statistical package (SAIGEgds) for large-scale PheWAS using mixed models [2]. In this package, the SAIGE method is implemented with optimized C++ codes taking advantage of sparse structure of genotype dosages. SAIGEgds supports efficient genomic data structure (GDS) files [3] including both integer genotypes and numeric imputed dosages. Benchmarks using the UK Biobank White British genotype data (N=430K) with coronary heart disease and simulated cases, show that SAIGEgds is 5 to 6 times faster than the SAIGE R package in the steps of fitting null models and p-value calculations. When used in conjunction with high-performance computing (HPC) clusters and/or cloud resources, SAIGEgds provides an efficient analysis pipeline for biobank-scale PheWAS.

.

# 1 Installation

* Bioconductor repository

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("SAIGEgds")
```

The `BiocManager::install()` approach may require that you build from source, i.e. `make` and compilers must be installed on your system – see the [R FAQ](http://cran.r-project.org/faqs.html) for your operating system; you may also need to install dependencies manually.

.

.

# 2 Examples

```
library(SeqArray)
library(SAIGEgds)

# the genotype file in SeqArray GDS format (1000 Genomes Phase1, chromosome 22)
(geno_fn <- seqExampleFileName("KG_Phase1"))
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SeqArray/extdata/1KG_phase1_release_v3_chr22.gds"
```

## 2.1 Preparing SNP data for genetic relationship matrix

```
# open a SeqArray file in the package (1000 Genomes Phase1, chromosome 22)
gds <- seqOpen(geno_fn)
```

The LD pruning is provided by [snpgdsLDpruning()](https://rdrr.io/bioc/SNPRelate/man/snpgdsLDpruning.html) in the pacakge [SNPRelate](http://bioconductor.org/packages/SNPRelate):

```
library(SNPRelate)
```

```
## SNPRelate -- supported by Streaming SIMD Extensions 2 (SSE2)
```

```
set.seed(1000)
snpset <- snpgdsLDpruning(gds)
```

```
## SNV pruning based on LD:
## Calculating allele counts/frequencies (19773 variants) ...
## [..................................................]  0%, ETC: --- (1/1)    [==================================================] 100%, used 0s (1/1)    [==================================================] 100%, complete, 0s
## # of selected variants: 9,043
## Excluding 10,730 SNVs (monomorphic: TRUE, MAF: 0.005, missing rate: 0.01)
##     # of samples: 1,092
##     # of SNVs: 9,043
##     using 1 thread/core
##     sliding window: 500,000 basepairs, Inf SNPs
##     |LD| threshold: 0.2
##     method: composite
## Chrom 22: |====================|====================|
##     14.58%, 2,883 / 19,773 (Fri Feb 20 19:51:09 2026)
## 2,883 markers are selected in total.
```

```
str(snpset)
```

```
## List of 1
##  $ chr22: int [1:2883] 1 8 9 10 12 16 17 18 20 23 ...
```

```
snpset.id <- unlist(snpset, use.names=FALSE)  # get the variant IDs of a LD-pruned set
head(snpset.id)
```

```
## [1]  1  8  9 10 12 16
```

Create a genotype file for genetic relationship matrix (GRM) using the LD-pruned SNP set:

```
grm_fn <- "grm_geno.gds"
seqSetFilter(gds, variant.id=snpset.id)
```

```
## # of selected variants: 2,883
```

```
# export to a GDS genotype file without annotation data
seqExport(gds, grm_fn, info.var=character(), fmt.var=character(), samp.var=character())
```

```
## ##< 2026-02-20 19:51:09
## Export to 'grm_geno.gds':
##     sample.id (1,092)    [md5: bd2a93b49750ae227793ed23c575b620]
##     variant.id (2,883)    [md5: 37e34ffd0328a6bb5bcedb53dddad2e3]
##     position    [md5: 9f2c5f81ad3709aa4e8c4549a82d2175]
##     chromosome    [md5: 7b4b80eaf4724d87d0d9b73aab237580]
##     allele    [md5: 20bd0aa343398d59112bd4b58f562f68]
##     genotype    [md5: be854ad6089ef332349ff25a99674949]
##     phase    [md5: 94c1e11249a7e2a4426b02bf852af5cb]
##     annotation/id    [md5: 2020922f9380eddb5e5f8e271ade54e2]
##     annotation/qual    [md5: 5d14e0a74e09172e9192c42b646c1559]
##     annotation/filter    [md5: 9bcb8f5aa38515d50d47129d3c57a542]
## Done.  # 2026-02-20 19:51:10
## Optimize the access efficiency ...
## Clean up the fragments of GDS file:
##     open the file 'grm_geno.gds' (343.3K)
##     # of fragments: 91
##     save to 'grm_geno.gds.tmp'
##     rename 'grm_geno.gds.tmp' (342.9K, reduced: 444B)
##     # of fragments: 54
## ##> 2026-02-20 19:51:10
```

If genotypes are split by chromosomes, `seqMerge()` in the SeqArray package can be used to combine the LD-pruned SNP sets.

```
# close the file
seqClose(gds)
```

.

## 2.2 Fitting the null model

A simulated phenotype data is used to demonstrate the model fitting:

```
set.seed(1000)
sampid <- seqGetData(grm_fn, "sample.id")  # sample IDs in the genotype file

pheno <- data.frame(
    sample.id = sampid,
    y  = sample(c(0, 1), length(sampid), replace=TRUE, prob=c(0.95, 0.05)),
    x1 = rnorm(length(sampid)),
    x2 = rnorm(length(sampid)),
    stringsAsFactors = FALSE)
head(pheno)
```

```
##   sample.id y          x1         x2
## 1   HG00096 0  0.02329127 -0.1700062
## 2   HG00097 0 -1.38629108 -1.0058530
## 3   HG00099 0  0.56339700 -0.6989284
## 4   HG00100 0 -0.25703246 -1.5884806
## 5   HG00101 0  0.02926429  0.7645377
## 6   HG00102 0 -0.44480750  1.9964501
```

```
grm_fn
```

```
## [1] "grm_geno.gds"
```

```
# null model fitting using GRM from grm_fn
glmm <- seqFitNullGLMM_SPA(y ~ x1 + x2, pheno, grm_fn, trait.type="binary", sample.col="sample.id")
```

.

## 2.3 P-value calculations

```
# genetic variants stored in the file geno_fn
geno_fn
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SeqArray/extdata/1KG_phase1_release_v3_chr22.gds"
```

```
# calculate, using 2 processes
assoc <- seqAssocGLMM_SPA(geno_fn, glmm, mac=10, parallel=2)
```

```
## SAIGE association analysis:
## 2026-02-20 19:51:10
##     open '1KG_phase1_release_v3_chr22.gds'
##     trait type: binary
##     # of samples: 1,092
##     # of variants: 19,773
##     MAF threshold: no
##     MAC threshold: >= 10
##     missing proportion threshold: <= 0.05
##     variance ratio for approximation: 1
```

```
## Warning: For more accurate model building, the null model should be built using SAIGEgds>=v1.9.1!
```

```
##     # of processes: 2
## [..................................................]  0%, ETC: --- (1/6)    [==================================================] 100%, used 0s (1/6)    [..................................................]  0%, ETC: --- (3/6)    [==================================================] 100%, used 0s (2/6)    [==================================================] 100%, used 0s (3/6)    [..................................................]  0%, ETC: --- (5/6)    [==================================================] 100%, used 0s (4/6)    [==================================================] 100%, used 0s (5/6)    [==================================================] 100%, used 0s (6/6)    [==================================================] 100%, complete, 0s
## # of variants after filtering by MAF, MAC and missing thresholds: 9,371
## P-value:
##      [0,5e-10]  (5e-10,5e-08]  (5e-08,5e-06] (5e-06,0.0005]     (0.0005,1]
##              0              0              0              3           9368
## 2026-02-20 19:51:11
## Done.
```

```
head(assoc)
```

```
##   id chr      pos       rs.id                ref alt     AF.alt mac  num       beta        SE      pval
## 1  1  22 16051497 rs141578542                  A   G 0.30494505 666 1092  0.2214607 0.2194430 0.3128813
## 2  2  22 16059752 rs139717388                  G   A 0.05677656 124 1092  0.4227084 0.4240575 0.3188526
## 3  5  22 16060995   rs2843244                  G   A 0.06135531 134 1092  0.3044670 0.4100805 0.4578107
## 4  8  22 16166919             ATATTTTCTGCACATATT   A 0.01190476  26 1092 -1.0851502 0.8804521 0.2177653
## 5  9  22 16173887                             GT   G 0.03067766  67 1092 -0.8195449 0.5587294 0.1424302
## 6 10  22 16205515 rs144309057                  G   A 0.01098901  24 1092 -1.0826898 0.9340256 0.2463890
##   method    p.norm converged
## 1 Normal 0.3128813      TRUE
## 2 Normal 0.3188526      TRUE
## 3 Normal 0.4578107      TRUE
## 4 Normal 0.2177653      TRUE
## 5 Normal 0.1424302      TRUE
## 6 Normal 0.2463890      TRUE
```

```
# filtering based on p-value
assoc[assoc$pval < 5e-4, ]
```

```
##         id chr      pos      rs.id ref alt    AF.alt mac  num     beta        SE         pval method
## 8422 17856  22 48507315 rs57751251   T   C 0.1666667 364 1092 0.971123 0.2555021 1.442051e-04    SPA
## 8423 17857  22 48509092  rs7292083   C   T 0.1625458 355 1092 1.008351 0.2585365 9.610252e-05    SPA
## 8630 18282  22 49060987  rs4925399   A   G 0.5929487 889 1092 0.708757 0.1956659 2.920160e-04    SPA
##            p.norm converged
## 8422 5.999175e-05      TRUE
## 8423 3.358045e-05      TRUE
## 8630 2.363433e-04      TRUE
```

The output could be directly saved to an R object file or a GDS file:

```
# save to 'assoc.gds'
seqAssocGLMM_SPA(geno_fn, glmm, mac=10, parallel=2, res.savefn="assoc.gds")
```

```
## SAIGE association analysis:
## 2026-02-20 19:51:11
##     open '1KG_phase1_release_v3_chr22.gds'
##     trait type: binary
##     # of samples: 1,092
##     # of variants: 19,773
##     MAF threshold: no
##     MAC threshold: >= 10
##     missing proportion threshold: <= 0.05
##     variance ratio for approximation: 1
```

```
## Warning: For more accurate model building, the null model should be built using SAIGEgds>=v1.9.1!
```

```
##     # of processes: 2
## Save to 'assoc.gds' ...
## [..................................................]  0%, ETC: --- (1/6)    [==================================================] 100%, used 0s (1/6)    [==================================================] 100%, used 0s (2/6)    [..................................................]  0%, ETC: --- (3/6)    [==================================================] 100%, used 0s (3/6)    [..................................................]  0%, ETC: --- (5/6)    [==================================================] 100%, used 0s (4/6)    [==================================================] 100%, used 0s (5/6)    [==================================================] 100%, used 0s (6/6)    [==================================================] 100%, complete, 0s
## # of variants after filtering by MAF, MAC and missing thresholds: 9,371
## P-value:
##      [0,5e-10]  (5e-10,5e-08]  (5e-08,5e-06] (5e-06,0.0005]     (0.0005,1]
##              0              0              0              3           9368
## 2026-02-20 19:51:12
## Done.
```

Open the output GDS file using the functions in the [gdsfmt](http://www.bioconductor.org/packages/gdsfmt) package:

```
# open the GDS file
(f <- openfn.gds("assoc.gds"))
```

```
## File: /tmp/RtmpYcvC7A/Rbuild59d128207897/SAIGEgds/vignettes/assoc.gds (506.4K)
## +    [  ] *
## |--+ sample.id   { Str8 1092 ZIP(26.0%), 2.2K }
## |--+ id   { Int32 9371 ZIP(35.1%), 12.8K }
## |--+ chr   { Str8 9371 ZIP(0.18%), 52B }
## |--+ pos   { Int32 9371 ZIP(83.8%), 30.7K }
## |--+ rs.id   { Str8 9371 ZIP(40.7%), 38.8K }
## |--+ ref   { Str8 9371 ZIP(28.0%), 105.4K }
## |--+ alt   { Str8 9371 ZIP(22.4%), 4.2K }
## |--+ AF.alt   { Float64 9371 ZIP(27.4%), 20.1K }
## |--+ mac   { Int32 9371 ZIP(41.6%), 15.2K }
## |--+ num   { Int32 9371 ZIP(0.17%), 64B }
## |--+ beta   { Float64 9371 ZIP(94.3%), 69.1K }
## |--+ SE   { Float64 9371 ZIP(92.8%), 67.9K }
## |--+ pval   { Float64 9371 ZIP(92.9%), 68.0K }
## |--+ method   { Int32,factor 9371 ZIP(1.62%), 606B } *
## |--+ p.norm   { Float64 9371 ZIP(92.9%), 68.0K }
## \--+ converged   { Int32,logical 9371 ZIP(0.17%), 62B } *
```

```
# get p-values
pval <- read.gdsn(index.gdsn(f, "pval"))
summary(pval)
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
## 0.0000961 0.2862278 0.4639086 0.4980417 0.7256674 0.9999449
```

```
closefn.gds(f)
```

Load association results using the function `seqSAIGE_LoadPval()` in SAIGEgds:

```
res <- seqSAIGE_LoadPval("assoc.gds")
```

```
## Loading 'assoc.gds' ...
```

```
head(res)
```

```
##   id chr      pos       rs.id                ref alt     AF.alt mac  num       beta        SE      pval
## 1  1  22 16051497 rs141578542                  A   G 0.30494505 666 1092  0.2214607 0.2194430 0.3128813
## 2  2  22 16059752 rs139717388                  G   A 0.05677656 124 1092  0.4227084 0.4240575 0.3188526
## 3  5  22 16060995   rs2843244                  G   A 0.06135531 134 1092  0.3044670 0.4100805 0.4578107
## 4  8  22 16166919             ATATTTTCTGCACATATT   A 0.01190476  26 1092 -1.0851502 0.8804521 0.2177653
## 5  9  22 16173887                             GT   G 0.03067766  67 1092 -0.8195449 0.5587294 0.1424302
## 6 10  22 16205515 rs144309057                  G   A 0.01098901  24 1092 -1.0826898 0.9340256 0.2463890
##   method    p.norm converged
## 1 Normal 0.3128813      TRUE
## 2 Normal 0.3188526      TRUE
## 3 Normal 0.4578107      TRUE
## 4 Normal 0.2177653      TRUE
## 5 Normal 0.1424302      TRUE
## 6 Normal 0.2463890      TRUE
```

.

## 2.4 Manhattan and QQ plots for p-values

```
library(ggmanh)
```

```
## Loading required package: ggplot2
```

```
g <- manhattan_plot(assoc, pval.colname="pval", chr.colname="chr",
    pos.colname="pos", x.label="Chromosome 22")
g
```

![](data:image/png;base64...)

```
# QQ plot
qqunif(assoc$pval)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the ggmanh package.
##   Please report the issue to the authors.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

![](data:image/png;base64...) .

.

# 3 Session Information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ggmanh_1.14.0    ggplot2_4.0.2    SNPRelate_1.44.0 SAIGEgds_2.10.1  Rcpp_1.1.1       SeqArray_1.50.1
## [7] gdsfmt_1.46.0
##
## loaded via a namespace (and not attached):
##  [1] tidyr_1.3.2           sass_0.4.10           generics_0.1.4        lattice_0.22-9
##  [5] digest_0.6.39         magrittr_2.0.4        evaluate_1.0.5        grid_4.5.2
##  [9] RColorBrewer_1.1-3    CompQuadForm_1.4.4    fastmap_1.2.0         jsonlite_2.0.0
## [13] Matrix_1.7-4          purrr_1.2.1           scales_1.4.0          RhpcBLASctl_0.23-42
## [17] Biostrings_2.78.0     jquerylib_0.1.4       cli_3.6.5             rlang_1.1.7
## [21] crayon_1.5.3          XVector_0.50.0        withr_3.0.2           cachem_1.1.0
## [25] yaml_2.3.12           otel_0.2.0            tools_4.5.2           parallel_4.5.2
## [29] dplyr_1.2.0           BiocGenerics_0.56.0   vctrs_0.7.1           R6_2.6.1
## [33] stats4_4.5.2          lifecycle_1.0.5       Seqinfo_1.0.0         S4Vectors_0.48.0
## [37] IRanges_2.44.0        pkgconfig_2.0.3       RcppParallel_5.1.11-1 bslib_0.10.0
## [41] pillar_1.11.1         gtable_0.3.6          glue_1.8.0            xfun_0.56
## [45] tibble_3.3.1          GenomicRanges_1.62.1  tidyselect_1.2.1      knitr_1.51
## [49] dichromat_2.0-0.1     farver_2.1.2          htmltools_0.5.9       labeling_0.4.3
## [53] rmarkdown_2.30        compiler_4.5.2        S7_0.2.1
```

.

# 4 References

1. Zheng X, Davis J.Wade. SAIGEgds – an efficient statistical tool for large-scale PheWAS with mixed models. *Bioinformatics* (2021). Mar;37(5):728-730. [DOI: 10.1093/bioinformatics/btaa731](http://dx.doi.org/10.1093/bioinformatics/btaa731).
2. Zhou W, Nielsen JB, Fritsche LG, Dey R, Gabrielsen ME, Wolford BN, LeFaive J, VandeHaar P, Gagliano SA, Gifford A, Bastarache LA, Wei WQ, Denny JC, Lin M, Hveem K, Kang HM, Abecasis GR, Willer CJ, Lee S. Efficiently controlling for case-control imbalance and sample relatedness in large-scale genetic association studies. *Nat Genet* (2018). Sep;50(9):1335-1341. [DOI: 10.1038/s41588-018-0184-y](https://doi.org/10.1038/s41588-018-0184-y)
3. Zheng X, Gogarten S, Lawrence M, Stilp A, Conomos M, Weir BS, Laurie C, Levine D. SeqArray – A storage-efficient high-performance data format for WGS variant calls. *Bioinformatics* (2017). [DOI: 10.1093/bioinformatics/btx145](http://dx.doi.org/10.1093/bioinformatics/btx145).

.

# 5 See also

[SeqArray](http://www.bioconductor.org/packages/SeqArray): Data Management of Large-scale Whole-genome Sequence Variant Calls

[SNPRelate](http://www.bioconductor.org/packages/SNPRelate): Parallel Computing Toolset for Relatedness and Principal Component Analysis of SNP Data