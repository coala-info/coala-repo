# UCSC RepeatMasker AnnotationHub Resource Metadata

Robert Castelo1\*

1Dept. of Medicine and Life Sciences, Universitat Pompeu Fabra, Barcelona, Spain

\*robert.castelo@upf.edu

#### 29 October 2025

#### Abstract

UCSC RepeatMasker annotations are available as Bioconductor AnnotationHub resources. The UCSCRepeatMasker annotation package stores the metadata for these resources and provides this vignette to illustrate how to use them.

#### Package

UCSCRepeatMasker 3.22.0

# 1 Retrieval of UCSC RepeatMasker annotations through AnnotationHub resources

The `UCSCRepeatMasker` package provides metadata for
*[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* resources associated with UCSC RepeatMasker
annotations. The original data can be found through UCSC download URLs
`https://hgdownload.soe.ucsc.edu/goldenPath/XXXX/database/rmsk.txt.gz`,
where `XXXX` is the corresponding code to a UCSC genome version.
Details about how those original data were processed into
*[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* resources can be found in the source
file:

```
UCSCRepeatMasker/scripts/make-data_UCSCRepeatMasker.R
```

while details on how the metadata for those resources has been generated
can be found in the source file:

```
UCSCRepeatMasker/scripts/make-metadata_UCSCRepeatMasker.R
```

UCSC RepeatMasker annotations can be retrieved using the
*[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)*,
which is a web resource that provides a central location where genomic files
(e.g., VCF, bed, wig) and other resources from standard (e.g., UCSC, Ensembl)
and distributed sites, can be found. A Bioconductor *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)*
web resource creates and manages a local cache of files retrieved by the user,
helping with quick and reproducible access.

For example, to list the available UCSC RepeatMasker annotations for the human
genome, we should first load the *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* package:

```
library(AnnotationHub)
```

and then query the annotation hub as follows:

```
ah <- AnnotationHub()
query(ah, c("UCSC", "RepeatMasker", "Homo sapiens"))
```

```
## AnnotationHub with 3 records
## # snapshotDate(): 2025-10-28
## # $dataprovider: UCSC
## # $species: Homo sapiens
## # $rdataclass: GRanges
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH99002"]]'
##
##              title
##   AH99002  | UCSC RepeatMasker annotations (Mar2020) for Human (hg19)
##   AH99003  | UCSC RepeatMasker annotations (Sep2021) for Human (hg38)
##   AH111333 | UCSC RepeatMasker annotations (Oct2022) for Human (hg38)
```

We can retrieve the desired resource, e.g., UCSC RepeatMasker annotations
for hg38, using the following syntax:

```
rmskhg38 <- ah[["AH99003"]]
rmskhg38
```

```
## GRanges object with 5633664 ranges and 11 metadata columns:
##                        seqnames        ranges strand |   swScore  milliDiv
##                           <Rle>     <IRanges>  <Rle> | <integer> <numeric>
##         [1]                chr1   10001-10468      + |       463        13
##         [2]                chr1   15798-15849      + |        18       232
##         [3]                chr1   16713-16744      + |        18       137
##         [4]                chr1   18907-19048      + |       239       338
##         [5]                chr1   19972-20405      + |       994       312
##         ...                 ...           ...    ... .       ...       ...
##   [5633660] chrX_KV766199v1_alt 179150-179234      - |       255       248
##   [5633661] chrX_KV766199v1_alt 184474-184785      - |      2039       173
##   [5633662] chrX_KV766199v1_alt 186964-187271      - |       386       283
##   [5633663] chrX_KV766199v1_alt 187486-187569      - |       270       321
##   [5633664] chrX_KV766199v1_alt 187597-187822      - |      1301       102
##              milliDel  milliIns   genoLeft     repName      repClass
##             <numeric> <numeric>  <integer> <character>   <character>
##         [1]         6        17 -248945954   (TAACCC)n Simple_repeat
##         [2]         0        19 -248940573   (TGCTCC)n Simple_repeat
##         [3]         0         0 -248939678      (TGG)n Simple_repeat
##         [4]       129         0 -248937374         L2a          LINE
##         [5]        60        25 -248936017          L3          LINE
##         ...       ...       ...        ...         ...           ...
##   [5633660]        69        28      -8770    MIR1_Amn          SINE
##   [5633661]         0         0      -3219       AluJb          SINE
##   [5633662]        44        78       -733      MLT1G3           LTR
##   [5633663]        23         0       -435      MLT1G3           LTR
##   [5633664]        47         4       -182       L1MA8          LINE
##                 repFamily  repStart    repEnd   repLeft
##               <character> <integer> <integer> <integer>
##         [1] Simple_repeat         1       471         0
##         [2] Simple_repeat         1        52         0
##         [3] Simple_repeat         1        32         0
##         [4]            L2      2942      3104      -322
##         [5]           CR1      2680      3129      -970
##         ...           ...       ...       ...       ...
##   [5633660]           MIR       -80       150        63
##   [5633661]           Alu         0       312         1
##   [5633662]     ERVL-MaLR       -65       526       232
##   [5633663]     ERVL-MaLR      -414       141        56
##   [5633664]            L1        -5      6286      6051
##   -------
##   seqinfo: 711 sequences (1 circular) from hg38 genome
```

Note that the data is returned using a `GRanges` object, please consult the
vignettes from the *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* package for details on how to
manipulate this type of object. The contents of the 11 metadata columns are
described at the UCSC Genome Browser web page for the
[RepeatMasker database schema](https://genome.ucsc.edu/cgi-bin/hgTables?db=hg38&hgta_group=rep&hgta_track=rmsk&hgta_table=rmsk&hgta_doSchema=describe+table+schema).
Please consult the credits and references sections on that page for information
on how to cite these data.

The `GRanges` object contains further metadata accessible with the `metadata()`
method as follows:

```
metadata(rmskhg38)
```

```
## $srcurl
## [1] "https://hgdownload.soe.ucsc.edu/goldenPath/hg38/database/rmsk.txt.gz"
##
## $srcVersion
## [1] "Sep2021"
##
## $citation
## A. Smit, R. Hubley, P. Green (1996-2010). _RepeatMasker Open-3.0_.
## <https://www.repeatmasker.org>.
##
## $gdesc
## | organism: Homo sapiens (Human)
## | provider: UCSC
## | genome: hg38
## | release date: Dec. 2013
## | ---
## | seqlengths:
```

```
## |                  chr1                 chr2 ...  chrX_MU273397v1_alt
## |             248956422            242193529 ...               330493
```

# 2 Session information

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
##  [1] GenomicRanges_1.61.8 Seqinfo_0.99.4       IRanges_2.43.8
##  [4] S4Vectors_0.47.6     AnnotationHub_3.99.6 BiocFileCache_2.99.6
##  [7] dbplyr_2.5.1         BiocGenerics_0.55.4  generics_0.1.4
## [10] BiocStyle_2.37.1
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          BiocVersion_3.22.0
##  [4] RSQLite_2.4.3        digest_0.6.37        magrittr_2.0.4
##  [7] evaluate_1.0.5       bookdown_0.45        fastmap_1.2.0
## [10] blob_1.2.4           jsonlite_2.0.0       AnnotationDbi_1.71.2
## [13] GenomeInfoDb_1.45.13 DBI_1.2.3            BiocManager_1.30.26
## [16] httr_1.4.7           purrr_1.1.0          UCSC.utils_1.5.1
## [19] Biostrings_2.77.2    httr2_1.2.1          jquerylib_0.1.4
## [22] cli_3.6.5            crayon_1.5.3         rlang_1.1.6
## [25] XVector_0.49.3       Biobase_2.69.1       bit64_4.6.0-1
## [28] withr_3.0.2          cachem_1.1.0         yaml_2.3.10
## [31] tools_4.5.1          memoise_2.0.1        dplyr_1.1.4
## [34] filelock_1.0.3       curl_7.0.0           vctrs_0.6.5
## [37] R6_2.6.1             png_0.1-8            lifecycle_1.0.4
## [40] KEGGREST_1.49.2      bit_4.6.0            pkgconfig_2.0.3
## [43] pillar_1.11.1        bslib_0.9.0          glue_1.8.0
## [46] xfun_0.53            tibble_3.3.0         tidyselect_1.2.1
## [49] knitr_1.50           htmltools_0.5.8.1    rmarkdown_2.30
## [52] compiler_4.5.1
```