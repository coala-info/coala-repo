# Qtlizer: comprehensive QTL annotation of GWAS results

Julia Remes & Matthias Munz

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Loading package](#loading-package)
* [4 Example function calls](#example-function-calls)
* [5 Output of Session Info](#output-of-session-info)

# 1 Introduction

This **R** package provides access to the **Qtlizer** web server. **Qtlizer** annotates lists of common small variants (mainly SNPs) and genes in humans with associated changes in gene expression using the most comprehensive database of published quantitative trait loci (QTLs).

# 2 Installation

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Qtlizer")
```

# 3 Loading package

```
library(Qtlizer)
#>
#>   ---------
#>
#>   For example usage please run: vignette('Qtlizer')
#>
#>   Web-based GUI: http://genehopper.de/qtlizer
#>   Documentation: http://genehopper.de/help#qtlizer_docu
#>   Github Repo: https://github.com/matmu/Qtlizer
#>
#>   Citation appreciated:
#>   Munz M et al. (2020) Qtlizer: comprehensive QTL annotation of GWAS results. Scientific Reports. doi:10.1038/s41598-020-75770-7
#>   Munz M. et al. (2015) Multidimensional gene search with Genehopper. Nucleic Acids Res. doi:10.1093/nar/gkv511
#>
#>   Support me: https://matthiasmunz.de/support_me/
#>
#>   ---------
```

# 4 Example function calls

The Qtlizer database can be queried with the function `get_qtls`. Accepted query terms are variant and gene identifiers of the form

* Rsid : rs + number e.g. “rs4284742”
* reference:chr:pos e.g. “hg19:19:45412079” (Allowed references: hg19/GRCh37, hg38/GRCh38; accepted chromosomes are 1-22)
* Gene symbol consisting of letters and numbers according to <https://www.genenames.org/about/guidelines/>

```
# Call get_qtls with a variant as a single query term
get_qtls("rs4284742")
#> 1 unique query term(s) found
#> Retrieving QTL information from Qtlizer...
#> 10 data point(s) received
#>    query_type query_term  sentinel proxy_variant corr ld_method corr_thr chr
#> 1     Variant  rs4284742 rs4284742          <NA> <NA>      <NA>     <NA>  19
#> 2     Variant  rs4284742 rs4284742          <NA> <NA>      <NA>     <NA>  19
#> 3     Variant  rs4284742 rs4284742          <NA> <NA>      <NA>     <NA>  19
#> 4     Variant  rs4284742 rs4284742          <NA> <NA>      <NA>     <NA>  19
#> 5     Variant  rs4284742 rs4284742          <NA> <NA>      <NA>     <NA>  19
#> 6     Variant  rs4284742 rs4284742          <NA> <NA>      <NA>     <NA>  19
#> 7     Variant  rs4284742 rs4284742          <NA> <NA>      <NA>     <NA>  19
#> 8     Variant  rs4284742 rs4284742          <NA> <NA>      <NA>     <NA>  19
#> 9     Variant  rs4284742 rs4284742          <NA> <NA>      <NA>     <NA>  19
#> 10    Variant  rs4284742 rs4284742          <NA> <NA>      <NA>     <NA>  19
#>    var_pos_hg19 var_pos_hg38 type     gene          ensgid colocalization
#> 1      52131733     51628480 eQTL   SHANK1 ENSG00000161681          trans
#> 2      52131733     51628480 eQTL     CD33 ENSG00000105383            cis
#> 3      52131733     51628480 eQTL  SIGLEC5 ENSG00000105501            cis
#> 4      52131733     51628480 eQTL  SIGLEC5 ENSG00000105501            cis
#> 5      52131733     51628480 eQTL  RPL9P33 ENSG00000244071            cis
#> 6      52131733     51628480 eQTL SIGLEC14 ENSG00000254415            cis
#> 7      52131733     51628480 eQTL   ZNF813 ENSG00000198346          trans
#> 8      52131733     51628480 eQTL   NDUFA3 ENSG00000170906          trans
#> 9      52131733     51628480 eQTL     SYT5 ENSG00000129990          trans
#> 10     52131733     51628480 eQTL   ZNF787 ENSG00000142409          trans
#>    distance                            tissue       p       sign_info      beta
#> 1     909.0                            Spleen 6.9e-07          FDR<5% -0.394972
#> 2     384.6 Cells - Lymphoblastoid cell lines 1.2e-01 Q-value; FDR<5%      <NA>
#> 3       0.0                  Peripheral blood 7.7e-14          FDR<5%      <NA>
#> 4       0.0                       Whole blood 3.3e-05          FDR<5%   -0.1105
#> 5       6.8                       Whole blood 2.2e-06          FDR<5% -0.181466
#> 6      14.1                         Pituitary 2.0e-05          FDR<5% -0.297989
#> 7    1839.3                Brain - Cerebellum 4.5e-03         FWER<5%      <NA>
#> 8    2474.2             Brain - Parietal lobe 4.3e-03         FWER<5%      <NA>
#> 9    3542.7             Brain - Parietal lobe 8.7e-03         FWER<5%      <NA>
#> 10   4458.9             Brain - Parietal lobe 6.4e-03         FWER<5%      <NA>
#>      ea  nea             source          pmid is_sign is_best n_qtls n_best
#> 1     G    A            GTEx v8 PMID:23715323    true    true      1      1
#> 2  <NA> <NA>             seeQTL PMID:22171328   false   false      8      0
#> 3     A    G Blood eQTL Browser PMID:24013639    true   false    151      0
#> 4     G    A            GTEx v8 PMID:23715323    true   false     87      0
#> 5     G    A            GTEx v8 PMID:23715323    true   false     31      0
#> 6     G    A            GTEx v8 PMID:23715323    true   false     32      0
#> 7  <NA> <NA>             ScanDB PMID:19933162   false   false     18      0
#> 8  <NA> <NA>             ScanDB PMID:19933162   false   false      8      0
#> 9  <NA> <NA>             ScanDB PMID:19933162   false   false      9      0
#> 10 <NA> <NA>             ScanDB PMID:19933162   false   false     21      0
#>    n_sw_sign n_occ
#> 1          1     1
#> 2          0     1
#> 3          2     2
#> 4          2     2
#> 5          1     1
#> 6          1     1
#> 7          0     1
#> 8          0     1
#> 9          0     1
#> 10         0     1
```

Common seperators (space, comma, space + comma, …) are accepted. Multiple terms can be passed in a single string, each term separated by comma, whitespace or both:

```
# Call get_qtls with multiple query terms in single string
df = get_qtls("rs4284742, rs2070901")
#> 2 unique query term(s) found
#> Retrieving QTL information from Qtlizer...
#> 45 data point(s) received
```

Alternatively, terms can be passed as a vector:

```
# Call get_qtls with multiple query terms as vector
df = get_qtls(c("rs4284742", "DEFA1"))
#> 2 unique query term(s) found
#> Retrieving QTL information from Qtlizer...
#> 221 data point(s) received
```

Input variants can be enriched by variants in linkage disequilibrium (LD). The correlation method to be used can be set with `ld_method`. Default is “r2”, alternatively “dprime” can be used. The correlation threshold, above which other correlated variants should be included, can be set with `corr` and ranges between 0 and 1. Default is “NA”

```
# Use parameters corr and ld_method
df = get_qtls(c("rs4284742", "DEFA1"), corr = 0.8, ld_method = "r2")
#> 2 unique query term(s) found
#> Retrieving QTL information from Qtlizer...
#> 221 data point(s) received
```

Also, column descriptions can be viewed:

```
# View meta info
df = get_qtls("rs4284742")
#> 1 unique query term(s) found
#> Retrieving QTL information from Qtlizer...
#> 10 data point(s) received
comment(df)
#>  [1] "# query_type:Query type"
#>  [2] "# query_term:Query term"
#>  [3] "# sentinel:Index variant"
#>  [4] "# chr: Chromosome name of sentinel/proxy variant on reference genome"
#>  [5] "# var_pos_hg19: Position of sentinel (or proxy if defined) variant on reference genome hg19"
#>  [6] "# var_pos_hg38: Position of sentinel (or proxy if defined) variant on reference genome hg38"
#>  [7] "# type:QTL type"
#>  [8] "# gene:Gene"
#>  [9] "# ensgid:Ensembl Gene ID"
#> [10] "# colocalization:Co-localization;Cis indicates, if index/proxy variant and gene are located in the same topologically associated domain, trans if not"
#> [11] "# distance:Distance;Distance between index/proxy variant and gene in kilobases"
#> [12] "# tissue:Tissue"
#> [13] "# p:P-value"
#> [14] "# sign_info:Significance info"
#> [15] "# beta:Beta;Effect size and direction with respect to effect allele"
#> [16] "# ea:EA;Effect allele"
#> [17] "# nea:NEA;Non-effect allele"
#> [18] "# source:Source"
#> [19] "# pmid:PMID"
#> [20] "# is_sign:Is sign"
#> [21] "# is_best:Is best"
#> [22] "# n_qtls:N QTLs"
#> [23] "# n_best:N best"
#> [24] "# n_sign:N sign"
#> [25] "# n_occ:N occ"
```

The QTL results is returned as data frame by default or as `GenomicRanges::GRanges` object. To return the results as GenomicRanges::GRanges object, `return_obj` is set to “granges”. If `return_obj` is set to “granges”, parameter `ref_version` sets the reference version in which the GRange object is returned. Allowed values are “hg19” (GRCh37) by default and “hg38” (GRCh38).

```
# Return result as GRange object with ref_version hg38
granges = get_qtls("rs4284742", return_obj = "granges", ref_version = "hg38")
#> 1 unique query term(s) found
#> Retrieving QTL information from Qtlizer...
#> 10 data point(s) received
```

# 5 Output of Session Info

The output of `sessionInfo()` on the system
on which this document was compiled:

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] Qtlizer_1.24.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] httr_1.4.7           cli_3.6.5            knitr_1.50
#>  [4] rlang_1.1.6          xfun_0.53            stringi_1.8.7
#>  [7] generics_0.1.4       jsonlite_2.0.0       S4Vectors_0.48.0
#> [10] htmltools_0.5.8.1    sass_0.4.10          stats4_4.5.1
#> [13] rmarkdown_2.30       Seqinfo_1.0.0        evaluate_1.0.5
#> [16] jquerylib_0.1.4      fastmap_1.2.0        IRanges_2.44.0
#> [19] yaml_2.3.10          lifecycle_1.0.4      bookdown_0.45
#> [22] BiocManager_1.30.26  compiler_4.5.1       digest_0.6.37
#> [25] R6_2.6.1             curl_7.0.0           GenomicRanges_1.62.0
#> [28] bslib_0.9.0          tools_4.5.1          BiocGenerics_0.56.0
#> [31] cachem_1.1.0
```