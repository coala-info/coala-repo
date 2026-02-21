# SeSAMe Data User Guide

# Introduction

`sesameData` package provides associated data for sesame package. This includes example data for testing and instructional purpose, as we ll as probe annotation for different Infinium platforms.

```
library(sesameData)
library(GenomicRanges)
sesameDataCache(c("genomeInfo.mm10", "HM450.address"))
```

# Genome Information

Sesame provides some utility functions to process transcript models, which can be represented as data.frame, GRanges and GRangesList objects. For example, `sesameData_getTxnGRanges` calls `sesameDataGet("genomeInfo.mm10")$txns` to retrieve a transcript-centric GRangesList object from GENCODE including its gene annotation, exon and cds (for protein-coding genes). It is then turned into a simple GRanges object of transcript:

```
sesameData_getTxnGRanges("mm10")
```

```
## GRanges object with 142604 ranges and 9 metadata columns:
##                        seqnames          ranges strand |      transcript_type
##                           <Rle>       <IRanges>  <Rle> |          <character>
##   ENSMUST00000193812.1     chr1 3073253-3074322      + |                  TEC
##   ENSMUST00000082908.1     chr1 3102016-3102125      + |                snRNA
##   ENSMUST00000162897.1     chr1 3205901-3216344      - | processed_transcript
##   ENSMUST00000159265.1     chr1 3206523-3215632      - | processed_transcript
##   ENSMUST00000070533.4     chr1 3214482-3671498      - |       protein_coding
##                    ...      ...             ...    ... .                  ...
##   ENSMUST00000082419.1     chrM     13552-14070      - |       protein_coding
##   ENSMUST00000082420.1     chrM     14071-14139      - |              Mt_tRNA
##   ENSMUST00000082421.1     chrM     14145-15288      + |       protein_coding
##   ENSMUST00000082422.1     chrM     15289-15355      + |              Mt_tRNA
##   ENSMUST00000082423.1     chrM     15356-15422      - |              Mt_tRNA
##                          transcript_name     gene_name              gene_id
##                              <character>   <character>          <character>
##   ENSMUST00000193812.1 4933401J01Rik-201 4933401J01Rik ENSMUSG00000102693.1
##   ENSMUST00000082908.1       Gm26206-201       Gm26206 ENSMUSG00000064842.1
##   ENSMUST00000162897.1          Xkr4-203          Xkr4 ENSMUSG00000051951.5
##   ENSMUST00000159265.1          Xkr4-202          Xkr4 ENSMUSG00000051951.5
##   ENSMUST00000070533.4          Xkr4-201          Xkr4 ENSMUSG00000051951.5
##                    ...               ...           ...                  ...
##   ENSMUST00000082419.1        mt-Nd6-201        mt-Nd6 ENSMUSG00000064368.1
##   ENSMUST00000082420.1         mt-Te-201         mt-Te ENSMUSG00000064369.1
##   ENSMUST00000082421.1       mt-Cytb-201       mt-Cytb ENSMUSG00000064370.1
##   ENSMUST00000082422.1         mt-Tt-201         mt-Tt ENSMUSG00000064371.1
##   ENSMUST00000082423.1         mt-Tp-201         mt-Tp ENSMUSG00000064372.1
##                             gene_type      source       level  cdsStart
##                           <character> <character> <character> <numeric>
##   ENSMUST00000193812.1            TEC      HAVANA           2        NA
##   ENSMUST00000082908.1          snRNA     ENSEMBL           3        NA
##   ENSMUST00000162897.1 protein_coding      HAVANA           2        NA
##   ENSMUST00000159265.1 protein_coding      HAVANA           2        NA
##   ENSMUST00000070533.4 protein_coding      HAVANA           2   3216025
##                    ...            ...         ...         ...       ...
##   ENSMUST00000082419.1 protein_coding     ENSEMBL           3     13555
##   ENSMUST00000082420.1        Mt_tRNA     ENSEMBL           3        NA
##   ENSMUST00000082421.1 protein_coding     ENSEMBL           3     14145
##   ENSMUST00000082422.1        Mt_tRNA     ENSEMBL           3        NA
##   ENSMUST00000082423.1        Mt_tRNA     ENSEMBL           3        NA
##                           cdsEnd
##                        <numeric>
##   ENSMUST00000193812.1        NA
##   ENSMUST00000082908.1        NA
##   ENSMUST00000162897.1        NA
##   ENSMUST00000159265.1        NA
##   ENSMUST00000070533.4   3671348
##                    ...       ...
##   ENSMUST00000082419.1     14070
##   ENSMUST00000082420.1        NA
##   ENSMUST00000082421.1     15288
##   ENSMUST00000082422.1        NA
##   ENSMUST00000082423.1        NA
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

The returned GRanges object does not contain the exon coordinates. We can further collapse different transcripts of the same gene (isoforms) to gene level. Gene start is the minimum of all isoform starts and end is the maximum of all isoform ends.

```
sesameData_getTxnGRanges("mm10", merge2gene=TRUE)
```

```
## GRanges object with 55401 ranges and 2 metadata columns:
##                        seqnames          ranges strand |     gene_name
##                           <Rle>       <IRanges>  <Rle> |   <character>
##   ENSMUSG00000102693.1     chr1 3073253-3074322      + | 4933401J01Rik
##   ENSMUSG00000064842.1     chr1 3102016-3102125      + |       Gm26206
##   ENSMUSG00000051951.5     chr1 3205901-3671498      - |          Xkr4
##   ENSMUSG00000102851.1     chr1 3252757-3253236      + |       Gm18956
##   ENSMUSG00000103377.1     chr1 3365731-3368549      - |       Gm37180
##                    ...      ...             ...    ... .           ...
##   ENSMUSG00000064368.1     chrM     13552-14070      - |        mt-Nd6
##   ENSMUSG00000064369.1     chrM     14071-14139      - |         mt-Te
##   ENSMUSG00000064370.1     chrM     14145-15288      + |       mt-Cytb
##   ENSMUSG00000064371.1     chrM     15289-15355      + |         mt-Tt
##   ENSMUSG00000064372.1     chrM     15356-15422      - |         mt-Tp
##                                   gene_type
##                                 <character>
##   ENSMUSG00000102693.1                  TEC
##   ENSMUSG00000064842.1                snRNA
##   ENSMUSG00000051951.5       protein_coding
##   ENSMUSG00000102851.1 processed_pseudogene
##   ENSMUSG00000103377.1                  TEC
##                    ...                  ...
##   ENSMUSG00000064368.1       protein_coding
##   ENSMUSG00000064369.1              Mt_tRNA
##   ENSMUSG00000064370.1       protein_coding
##   ENSMUSG00000064371.1              Mt_tRNA
##   ENSMUSG00000064372.1              Mt_tRNA
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

# Probes

```
library(GenomicRanges)
```

The following code get probes from different parts of the genome.

```
## probes in a region
sesameData_getProbesByRegion(GRanges('chr5',
    IRanges(135313937, 135419936)), platform = 'Mammal40')
## get chrX probes
sesameData_getProbesByRegion(chrm = 'chrX', platform = "Mammal40")
## get autosomal probes
sesameData_getProbesByRegion(
    chrm_to_exclude = c("chrX", "chrY"), platform = "Mammal40")
## get DNMT3A probes
sesameData_getProbesByGene('DNMT3A', "Mammal40", upstream=500)
## get DNMT3A promoter probes
sesameData_getProbesByGene('DNMT3A', "Mammal40", promoter = TRUE)
## get all promoter probes
sesameData_getProbesByGene(NULL, "Mammal40", promoter = TRUE)
```

One can annotate given probe ID using any genomic features stored in GRanges objects. For example, the following demonstrate the annotation of 500 random Mammal40 probes for gene promoters.

```
input_probes <- names(sesameData_getManifestGRanges("Mammal40"))[1:500]

## annotate for promoter
regs <- promoters(sesameData_getTxnGRanges("hg38"))
sesameData_annoProbes(input_probes, regs, column = "gene_name")

## annotate for gene association
regs <- sesameData_getTxnGRanges("hg38", merge2gene = TRUE)
sesameData_annoProbes(input_probes, regs, column = "gene_name")

## get genes associated with probes
regs <- sesameData_getTxnGRanges("hg38", merge2gene = TRUE)
sesameData_annoProbes(input_probes, regs, return_ov_features=TRUE)

## get genes associated with probes extending 10kb
input_probes <- c("cg14620903","cg22464003")
sesameData_annoProbes(input_probes, regs+10000, column = "gene_name")
```

# Manifest

Sesame provides access to array manfiest stored as GRanges object. These GRanges object are converted from the raw tsv files on our [array annotation website](http://zwdzwd.github.io/InfiniumAnnotation) using the [conversion code](https://tinyurl.com/8bt9dssc)

```
gr <- sesameData_getManifestGRanges("HM450")
length(gr)
```

```
## [1] 485545
```

Note that by default the GRanges object exclude decoy sequence probes (e.g., \_alt, and \_random contigs). To include them, we need to use the `decoy = TRUE` option in sesameData\_getManifestDF.

# Raw Data Retrieval

Titles of all the available data can be shown with:

```
head(sesameDataList())
```

Each sesame datum from ExperimentHub is accessible through the `sesameDataGet` interface. It should be noted that all data must be pre-cached to local disk before they can be used. This design is to prevent conflict in annotation data caching and remove internet dependency. Caching needs only be done once per sesame/sesameData installation. One can cache data using

```
sesameDataCache()
```

Once a data object is loaded, it is stored to a tempoary cache, so that the data doesn’t need to be retrieved again next time we call `sesameDataGet`. This design is meant to speeed up the run time.

For example, the annotation for HM27 can be retrieved with the title:

```
HM27.address <- sesameDataGet('HM27.address')
```

It’s worth noting that once a data is retrieved through the `sesameDataGet` inferface (below), it will stay in memory so next time the object will be returned immediately. This design avoids repeated disk/web retrieval. In some rare situation, one may want to redo the download/disk IO, or empty the cache to save memory. This can be done with:

```
sesameDataGet_resetEnv()
```

```
##            used  (Mb) gc trigger  (Mb) max used  (Mb)
## Ncells  4682131 250.1    8089567 432.1  8089567 432.1
## Vcells 10614859  81.0   28097688 214.4 23849083 182.0
```

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
##  [1] GenomicRanges_1.62.0 Seqinfo_1.0.0        IRanges_2.44.0
##  [4] S4Vectors_0.48.0     sesameData_1.28.0    ExperimentHub_3.0.0
##  [7] AnnotationHub_4.0.0  BiocFileCache_3.0.0  dbplyr_2.5.1
## [10] BiocGenerics_0.56.0  generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          BiocVersion_3.22.0
##  [4] stringi_1.8.7        RSQLite_2.4.3        hms_1.1.4
##  [7] digest_0.6.37        magrittr_2.0.4       evaluate_1.0.5
## [10] fastmap_1.2.0        blob_1.2.4           jsonlite_2.0.0
## [13] AnnotationDbi_1.72.0 DBI_1.2.3            BiocManager_1.30.26
## [16] httr_1.4.7           purrr_1.1.0          Biostrings_2.78.0
## [19] httr2_1.2.1          jquerylib_0.1.4      cli_3.6.5
## [22] rlang_1.1.6          crayon_1.5.3         XVector_0.50.0
## [25] Biobase_2.70.0       bit64_4.6.0-1        withr_3.0.2
## [28] cachem_1.1.0         yaml_2.3.10          tools_4.5.1
## [31] tzdb_0.5.0           memoise_2.0.1        dplyr_1.1.4
## [34] filelock_1.0.3       curl_7.0.0           vctrs_0.6.5
## [37] R6_2.6.1             png_0.1-8            lifecycle_1.0.4
## [40] stringr_1.5.2        KEGGREST_1.50.0      bit_4.6.0
## [43] pkgconfig_2.0.3      pillar_1.11.1        bslib_0.9.0
## [46] glue_1.8.0           xfun_0.54            tibble_3.3.0
## [49] tidyselect_1.2.1     knitr_1.50           htmltools_0.5.8.1
## [52] rmarkdown_2.30       readr_2.1.5          compiler_4.5.1
```