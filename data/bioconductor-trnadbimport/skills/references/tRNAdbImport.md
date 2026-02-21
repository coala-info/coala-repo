# Importing from to tRNAdb and mitotRNAdb as `GRanges`

Felix G.M. Ernst

#### 2025-10-30

#### Package

tRNAdbImport 1.28.0

# 1 Introduction

The tRNAdb and mttRNAdb (Jühling et al. [2009](#ref-Juehling.2009)) is a compilation of tRNA sequences and
tRNA genes. It is a follow up version of the database of Sprinzl et al.
(Sprinzl and Vassilenko [2005](#ref-Sprinzl.2005)).

Using `tRNAdbImport` the tRNAdb can be accessed as outlined on the website
<http://trna.bioinf.uni-leipzig.de/> and the results
are returned as a `GRanges` object.

## 1.1 Status 2024

The tRNAdb Server is currently not available. Some chunks of the code in this
vignette are currently not avilable.
See <https://www.bioinf.uni-leipzig.de/services/webservices>
for more information.

# 2 Importing as `GRanges`

```
library(tRNAdbImport)
```

```
# accessing tRNAdb
# tRNA from yeast for Alanine and Phenylalanine
gr <- import.tRNAdb(organism = "Saccharomyces cerevisiae",
                    aminoacids = c("Phe","Ala"))
```

```
## Warning: tRNAdb Server seems to be not available.
```

```
# get a Phenylalanine tRNA from yeast
gr <- import.tRNAdb.id(tdbID = gr[gr$tRNA_type == "Phe",][1L]$tRNAdb_ID)
```

```
# find the same tRNA via blast
gr <- import.tRNAdb.blast(blastSeq = gr$tRNA_seq)
```

```
# accessing mtRNAdb
# get the mitochrondrial tRNA for Alanine in Bos taurus
gr <- import.mttRNAdb(organism = "Bos taurus",
                      aminoacids = "Ala")
```

```
## Warning: tRNAdb Server seems to be not available.
```

```
# get one mitochrondrial tRNA in Bos taurus.
gr <- import.mttRNAdb.id(mtdbID = gr[1L]$tRNAdb_ID)
```

```
# check that the result has the appropriate columns
istRNAdbGRanges(gr)
```

```
## Warning: Input GRanges object does not meet the requirements of the function. The following columns are expected:
## 'tRNA_length', 'tRNA_type', 'tRNA_anticodon', 'tRNA_seq', 'tRNA_str', 'tRNA_CCA.end', 'tRNAdb_ID', 'tRNAdb', 'tRNAdb_organism', 'tRNAdb_strain', 'tRNAdb_taxonomyID', 'tRNAdb_verified'.
```

```
## [1] FALSE
```

# 3 Importing as `GRanges` from the RNA database

The tRNAdb offers two different sets of data, one containing DNA sequences and
one containing RNA sequences. Depending on the database selected, `DNA` as
default, the GRanges will contain a `DNAStringSet` or a `ModRNAStringSet` as
the `tRNA_seq` column. Because the RNA sequences can contain modified
nucleotides, the `ModRNAStringSet` class is used instead of the `RNAStringSet`
class to store the sequences correctly with all information intact.

```
gr <- import.tRNAdb(organism = "Saccharomyces cerevisiae",
                    aminoacids = c("Phe","Ala"),
                    database = "RNA")
gr$tRNA_seq
```

The special characters in the sequence might no exactly match the ones shown on
the website, since they are sanitized internally to a unified dictionary defined
in the `Modstrings` package. However, the type of modification encoded will
remain the same (See the `Modstrings` package for more details).

The information on the position and type of the modifications can also be
converted into a tabular format using the `separate` function from the
`Modstrings` package.

```
separate(gr$tRNA_seq)
```

# 4 Further analysis

The output can be saved or directly used for further analysis.

```
library(Biostrings)
library(rtracklayer)
# saving the tRAN sequences as fasta file
writeXStringSet(gr$tRNA_seq, filepath = tempfile())
# converting tRNAdb information to GFF compatible values
gff <- tRNAdb2GFF(gr)
gff
# Saving the information as gff3 file
export.gff3(gff, con = tempfile())
```

Please have a look at the `tRNA` package for further analysis of the tRNA
sequences.

# 5 Session info

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
##  [1] rtracklayer_1.70.0   tRNAdbImport_1.28.0  tRNA_1.28.0
##  [4] Structstrings_1.26.0 Modstrings_1.26.0    Biostrings_2.78.0
##  [7] XVector_0.50.0       GenomicRanges_1.62.0 Seqinfo_1.0.0
## [10] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
## [13] generics_0.1.4       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
##  [3] rjson_0.2.23                xfun_0.53
##  [5] bslib_0.9.0                 ggplot2_4.0.0
##  [7] httr2_1.2.1                 lattice_0.22-7
##  [9] Biobase_2.70.0              vctrs_0.6.5
## [11] tools_4.5.1                 bitops_1.0-9
## [13] curl_7.0.0                  parallel_4.5.1
## [15] tibble_3.3.0                pkgconfig_2.0.3
## [17] Matrix_1.7-4                RColorBrewer_1.1-3
## [19] cigarillo_1.0.0             S7_0.2.0
## [21] lifecycle_1.0.4             compiler_4.5.1
## [23] farver_2.1.2                stringr_1.5.2
## [25] Rsamtools_2.26.0            codetools_0.2-20
## [27] htmltools_0.5.8.1           sass_0.4.10
## [29] RCurl_1.98-1.17             yaml_2.3.10
## [31] pillar_1.11.1               crayon_1.5.3
## [33] jquerylib_0.1.4             BiocParallel_1.44.0
## [35] DelayedArray_0.36.0         cachem_1.1.0
## [37] abind_1.4-8                 tidyselect_1.2.1
## [39] digest_0.6.37               stringi_1.8.7
## [41] dplyr_1.1.4                 restfulr_0.0.16
## [43] bookdown_0.45               fastmap_1.2.0
## [45] grid_4.5.1                  SparseArray_1.10.0
## [47] cli_3.6.5                   magrittr_2.0.4
## [49] S4Arrays_1.10.0             dichromat_2.0-0.1
## [51] XML_3.99-0.19               scales_1.4.0
## [53] rappdirs_0.3.3              rmarkdown_2.30
## [55] httr_1.4.7                  matrixStats_1.5.0
## [57] evaluate_1.0.5              knitr_1.50
## [59] BiocIO_1.20.0               rlang_1.1.6
## [61] glue_1.8.0                  BiocManager_1.30.26
## [63] xml2_1.4.1                  jsonlite_2.0.0
## [65] R6_2.6.1                    MatrixGenerics_1.22.0
## [67] GenomicAlignments_1.46.0
```

# References

Jühling, Frank, Mario Mörl, Roland K. Hartmann, Mathias Sprinzl, Peter F. Stadler, and Joern Pütz. 2009. “TRNAdb 2009: Compilation of tRNA Sequences and tRNA Genes.” *Nucleic Acids Research* 37: D159–D162. <https://doi.org/10.1093/nar/gkn772>.

Sprinzl, Mathias, and Konstantin S. Vassilenko. 2005. “Compilation of tRNA Sequences and Sequences of tRNA Genes.” *Nucleic Acids Research* 33: D139–D140. <https://doi.org/10.1093/nar/gki012>.