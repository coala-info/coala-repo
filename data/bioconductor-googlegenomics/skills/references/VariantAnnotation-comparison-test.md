# Reproducing Variant Annotation Results

#### *30 October 2018*

# Contents

* [0.1 Load Data](#load-data)
  + [0.1.1 VCF Data](#vcf-data)
  + [0.1.2 Google Genomics Data](#google-genomics-data)
  + [0.1.3 Compare the Loaded Data](#compare-the-loaded-data)
* [0.2 Compare the Annotation Results](#compare-the-annotation-results)
* [0.3 Provenance](#provenance)

## 0.1 Load Data

Below we compare the results of annotating variants via *[VariantAnnotation](https://bioconductor.org/packages/3.8/VariantAnnotation)* specifically repeating a subset of the steps in vignette [Introduction to VariantAnnotation](http://bioconductor.org/packages/release/bioc/vignettes/VariantAnnotation/inst/doc/VariantAnnotation.pdf). We compare using data from 1,000 Genomes Phase 1 Variants:

* as parsed from a VCF file
* retrieved from the Google Genomics API

### 0.1.1 VCF Data

First we read in the data from the VCF file:

```
library(VariantAnnotation)
```

```
fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
vcf <- readVcf(fl, "hg19")
vcf <- renameSeqlevels(vcf, c("22"="chr22"))
vcf
```

```
## class: CollapsedVCF
## dim: 10376 5
## rowRanges(vcf):
##   GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER
## info(vcf):
##   DataFrame with 22 columns: LDAF, AVGPOST, RSQ, ERATE, THETA, CIEND, CIP...
## info(header(vcf)):
##              Number Type    Description
##    LDAF      1      Float   MLE Allele Frequency Accounting for LD
##    AVGPOST   1      Float   Average posterior probability from MaCH/Thunder
##    RSQ       1      Float   Genotype imputation quality from MaCH/Thunder
##    ERATE     1      Float   Per-marker Mutation rate from MaCH/Thunder
##    THETA     1      Float   Per-marker Transition rate from MaCH/Thunder
##    CIEND     2      Integer Confidence interval around END for imprecise ...
##    CIPOS     2      Integer Confidence interval around POS for imprecise ...
##    END       1      Integer End position of the variant described in this...
##    HOMLEN    .      Integer Length of base pair identical micro-homology ...
##    HOMSEQ    .      String  Sequence of base pair identical micro-homolog...
##    SVLEN     1      Integer Difference in length between REF and ALT alleles
##    SVTYPE    1      String  Type of structural variant
##    AC        .      Integer Alternate Allele Count
##    AN        1      Integer Total Allele Count
##    AA        1      String  Ancestral Allele, ftp://ftp.1000genomes.ebi.a...
##    AF        1      Float   Global Allele Frequency based on AC/AN
##    AMR_AF    1      Float   Allele Frequency for samples from AMR based o...
##    ASN_AF    1      Float   Allele Frequency for samples from ASN based o...
##    AFR_AF    1      Float   Allele Frequency for samples from AFR based o...
##    EUR_AF    1      Float   Allele Frequency for samples from EUR based o...
##    VT        1      String  indicates what type of variant the line repre...
##    SNPSOURCE .      String  indicates if a snp was called when analysing ...
## geno(vcf):
##   SimpleList of length 3: GT, DS, GL
## geno(header(vcf)):
##       Number Type   Description
##    GT 1      String Genotype
##    DS 1      Float  Genotype dosage from MaCH/Thunder
##    GL .      Float  Genotype Likelihoods
```

The file `chr22.vcf.gz` within package VariantAnnotation holds data for 5 of the 1,092 individuals in 1,000 Genomes, starting at position 50300078 and ending at position 50999964.

`HG00096 HG00097 HG00099 HG00100 HG00101`

### 0.1.2 Google Genomics Data

Important data differences to note:

* VCF data uses 1-based coordinates but data from the GA4GH APIs is 0-based.
* There are two variants in the Google Genomics copy of 1,000 Genomes phase 1 variants that are not in `chr22.vcf.gz`. They are the only two variants within the genomic range with `ALT == <DEL>`.

```
library(GoogleGenomics)
# This vignette is authenticated on package load from the env variable GOOGLE_API_KEY.
# When running interactively, call the authenticate method.
# ?authenticate
```

```
# We're just getting the first few variants so that this runs quickly.
# If we wanted to get them all, we sould set end=50999964.
granges <- getVariants(variantSetId="10473108253681171589",
                       chromosome="22",
                       start=50300077,
                       end=50303000,
                       converter=variantsToGRanges)
```

```
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CIWK_hcQ_Nr-8ZGlk78i
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CIaM_hcQvM_un46SmcJ0
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CJGN_hcQiYna3cSwse_RAQ
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CMKQ_hcQr9OUpKu4n_xz
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CMKS_hcQn-nIneaph7WJAQ
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CKOU_hcQ2eCCwsmBysdd
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CLWV_hcQmo-n-tX08uPyAQ
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CMqX_hcQ__3H4KKV9tUR
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CKuZ_hcQ9pHXwa742bKgAQ
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CLqa_hcQ-6zjo_Dc86gy
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CLSb_hcQ3vrDo5XJwsB_
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CKOd_hcQ6IPgk-PVjskK
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CPGe_hcQ-8Saw6Ojg8yXAQ
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Continuing variant query with the nextPageToken: CPGf_hcQuKDdodiCvLUm
## Fetching variants page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Variants are now available.
```

### 0.1.3 Compare the Loaded Data

Ensure that the data retrieved by each matches:

```
vcf <- vcf[1:length(granges)] # Truncate the VCF data so that it is the same
                              # set as what was retrieved from the API.
```

```
library(testthat)
```

```
expect_equal(start(granges), start(vcf))
expect_equal(end(granges), end(vcf))
expect_equal(as.character(granges$REF), as.character(ref(vcf)))
expect_equal(as.character(unlist(granges$ALT)), as.character(unlist(alt(vcf))))
expect_equal(granges$QUAL, qual(vcf))
expect_equal(granges$FILTER, filt(vcf))
```

## 0.2 Compare the Annotation Results

Now locate the protein coding variants in each:

```
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
```

```
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

rd <- rowRanges(vcf)
vcf_locations <- locateVariants(rd, txdb, CodingVariants())
```

```
## Warning in valid.GenomicRanges.seqinfo(x, suggest.trim = TRUE): GRanges object contains 1 out-of-bound range located on sequence
##   75253. Note that ranges located on a sequence whose length is
##   unknown (NA) or on a circular sequence are not considered
##   out-of-bound (use seqlengths() and isCircular() to get the lengths
##   and circularity flags of the underlying sequences). You can use
##   trim() to trim these ranges. See ?`trim,GenomicRanges-method` for
##   more information.
```

```
## 'select()' returned many:1 mapping between keys and columns
```

```
vcf_locations
```

```
## GRanges object with 7 ranges and 9 metadata columns:
##       seqnames    ranges strand | LOCATION  LOCSTART    LOCEND   QUERYID
##          <Rle> <IRanges>  <Rle> | <factor> <integer> <integer> <integer>
##   [1]    chr22  50301422      - |   coding       939       939        24
##   [2]    chr22  50301476      - |   coding       885       885        25
##   [3]    chr22  50301488      - |   coding       873       873        26
##   [4]    chr22  50301494      - |   coding       867       867        27
##   [5]    chr22  50301584      - |   coding       777       777        28
##   [6]    chr22  50302962      - |   coding       698       698        57
##   [7]    chr22  50302995      - |   coding       665       665        58
##              TXID         CDSID      GENEID       PRECEDEID        FOLLOWID
##       <character> <IntegerList> <character> <CharacterList> <CharacterList>
##   [1]       75253        218562       79087            <NA>            <NA>
##   [2]       75253        218562       79087            <NA>            <NA>
##   [3]       75253        218562       79087            <NA>            <NA>
##   [4]       75253        218562       79087            <NA>            <NA>
##   [5]       75253        218562       79087            <NA>            <NA>
##   [6]       75253        218563       79087            <NA>            <NA>
##   [7]       75253        218563       79087            <NA>            <NA>
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
granges_locations <- locateVariants(granges, txdb, CodingVariants())
```

```
## Warning in valid.GenomicRanges.seqinfo(x, suggest.trim = TRUE): GRanges object contains 1 out-of-bound range located on sequence
##   75253. Note that ranges located on a sequence whose length is
##   unknown (NA) or on a circular sequence are not considered
##   out-of-bound (use seqlengths() and isCircular() to get the lengths
##   and circularity flags of the underlying sequences). You can use
##   trim() to trim these ranges. See ?`trim,GenomicRanges-method` for
##   more information.
```

```
## 'select()' returned many:1 mapping between keys and columns
```

```
granges_locations
```

```
## GRanges object with 7 ranges and 9 metadata columns:
##       seqnames    ranges strand | LOCATION  LOCSTART    LOCEND   QUERYID
##          <Rle> <IRanges>  <Rle> | <factor> <integer> <integer> <integer>
##   [1]    chr22  50301422      - |   coding       939       939        24
##   [2]    chr22  50301476      - |   coding       885       885        25
##   [3]    chr22  50301488      - |   coding       873       873        26
##   [4]    chr22  50301494      - |   coding       867       867        27
##   [5]    chr22  50301584      - |   coding       777       777        28
##   [6]    chr22  50302962      - |   coding       698       698        57
##   [7]    chr22  50302995      - |   coding       665       665        58
##              TXID         CDSID      GENEID       PRECEDEID        FOLLOWID
##       <character> <IntegerList> <character> <CharacterList> <CharacterList>
##   [1]       75253        218562       79087            <NA>            <NA>
##   [2]       75253        218562       79087            <NA>            <NA>
##   [3]       75253        218562       79087            <NA>            <NA>
##   [4]       75253        218562       79087            <NA>            <NA>
##   [5]       75253        218562       79087            <NA>            <NA>
##   [6]       75253        218563       79087            <NA>            <NA>
##   [7]       75253        218563       79087            <NA>            <NA>
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
expect_equal(granges_locations, vcf_locations)
```

And predict the effect of the protein coding variants:

```
library(BSgenome.Hsapiens.UCSC.hg19)
```

```
vcf_coding <- predictCoding(vcf, txdb, seqSource=Hsapiens)
```

```
## Warning in valid.GenomicRanges.seqinfo(x, suggest.trim = TRUE): GRanges object contains 1 out-of-bound range located on sequence
##   75253. Note that ranges located on a sequence whose length is
##   unknown (NA) or on a circular sequence are not considered
##   out-of-bound (use seqlengths() and isCircular() to get the lengths
##   and circularity flags of the underlying sequences). You can use
##   trim() to trim these ranges. See ?`trim,GenomicRanges-method` for
##   more information.
```

```
vcf_coding
```

```
## GRanges object with 7 ranges and 17 metadata columns:
##                   seqnames    ranges strand | paramRangeID            REF
##                      <Rle> <IRanges>  <Rle> |     <factor> <DNAStringSet>
##       rs114335781    chr22  50301422      - |         <NA>              G
##         rs8135963    chr22  50301476      - |         <NA>              T
##   22:50301488_C/T    chr22  50301488      - |         <NA>              C
##   22:50301494_G/A    chr22  50301494      - |         <NA>              G
##   22:50301584_C/T    chr22  50301584      - |         <NA>              C
##       rs114264124    chr22  50302962      - |         <NA>              C
##       rs149209714    chr22  50302995      - |         <NA>              C
##                                  ALT      QUAL      FILTER      varAllele
##                   <DNAStringSetList> <numeric> <character> <DNAStringSet>
##       rs114335781                  A       100        PASS              T
##         rs8135963                  C       100        PASS              G
##   22:50301488_C/T                  T       100        PASS              A
##   22:50301494_G/A                  A       100        PASS              T
##   22:50301584_C/T                  T       100        PASS              A
##       rs114264124                  T       100        PASS              A
##       rs149209714                  G       100        PASS              C
##                      CDSLOC    PROTEINLOC   QUERYID        TXID
##                   <IRanges> <IntegerList> <integer> <character>
##       rs114335781       939           313        24       75253
##         rs8135963       885           295        25       75253
##   22:50301488_C/T       873           291        26       75253
##   22:50301494_G/A       867           289        27       75253
##   22:50301584_C/T       777           259        28       75253
##       rs114264124       698           233        57       75253
##       rs149209714       665           222        58       75253
##                           CDSID      GENEID   CONSEQUENCE       REFCODON
##                   <IntegerList> <character>      <factor> <DNAStringSet>
##       rs114335781        218562       79087    synonymous            ATC
##         rs8135963        218562       79087    synonymous            GCA
##   22:50301488_C/T        218562       79087    synonymous            CCG
##   22:50301494_G/A        218562       79087    synonymous            CAC
##   22:50301584_C/T        218562       79087    synonymous            CCG
##       rs114264124        218563       79087 nonsynonymous            CGG
##       rs149209714        218563       79087 nonsynonymous            GGA
##                         VARCODON         REFAA         VARAA
##                   <DNAStringSet> <AAStringSet> <AAStringSet>
##       rs114335781            ATT             I             I
##         rs8135963            GCG             A             A
##   22:50301488_C/T            CCA             P             P
##   22:50301494_G/A            CAT             H             H
##   22:50301584_C/T            CCA             P             P
##       rs114264124            CAG             R             Q
##       rs149209714            GCA             G             A
##   -------
##   seqinfo: 1 sequence from hg19 genome; no seqlengths
```

```
granges_coding <- predictCoding(rep(granges, elementNROWS(granges$ALT)),
                                txdb,
                                seqSource=Hsapiens,
                                varAllele=unlist(granges$ALT, use.names=FALSE))
```

```
## Warning in valid.GenomicRanges.seqinfo(x, suggest.trim = TRUE): GRanges object contains 1 out-of-bound range located on sequence
##   75253. Note that ranges located on a sequence whose length is
##   unknown (NA) or on a circular sequence are not considered
##   out-of-bound (use seqlengths() and isCircular() to get the lengths
##   and circularity flags of the underlying sequences). You can use
##   trim() to trim these ranges. See ?`trim,GenomicRanges-method` for
##   more information.
```

```
granges_coding
```

```
## GRanges object with 7 ranges and 16 metadata columns:
##               seqnames    ranges strand |            REF                ALT
##                  <Rle> <IRanges>  <Rle> | <DNAStringSet> <DNAStringSetList>
##   rs114335781    chr22  50301422      - |              G                  A
##     rs8135963    chr22  50301476      - |              T                  C
##   rs200080075    chr22  50301488      - |              C                  T
##   rs147801200    chr22  50301494      - |              G                  A
##   rs138060012    chr22  50301584      - |              C                  T
##   rs114264124    chr22  50302962      - |              C                  T
##   rs149209714    chr22  50302995      - |              C                  G
##                    QUAL      FILTER      varAllele    CDSLOC    PROTEINLOC
##               <numeric> <character> <DNAStringSet> <IRanges> <IntegerList>
##   rs114335781       100        PASS              T       939           313
##     rs8135963       100        PASS              G       885           295
##   rs200080075       100        PASS              A       873           291
##   rs147801200       100        PASS              T       867           289
##   rs138060012       100        PASS              A       777           259
##   rs114264124       100        PASS              A       698           233
##   rs149209714       100        PASS              C       665           222
##                 QUERYID        TXID         CDSID      GENEID   CONSEQUENCE
##               <integer> <character> <IntegerList> <character>      <factor>
##   rs114335781        24       75253        218562       79087    synonymous
##     rs8135963        25       75253        218562       79087    synonymous
##   rs200080075        26       75253        218562       79087    synonymous
##   rs147801200        27       75253        218562       79087    synonymous
##   rs138060012        28       75253        218562       79087    synonymous
##   rs114264124        57       75253        218563       79087 nonsynonymous
##   rs149209714        58       75253        218563       79087 nonsynonymous
##                     REFCODON       VARCODON         REFAA         VARAA
##               <DNAStringSet> <DNAStringSet> <AAStringSet> <AAStringSet>
##   rs114335781            ATC            ATT             I             I
##     rs8135963            GCA            GCG             A             A
##   rs200080075            CCG            CCA             P             P
##   rs147801200            CAC            CAT             H             H
##   rs138060012            CCG            CCA             P             P
##   rs114264124            CGG            CAG             R             Q
##   rs149209714            GGA            GCA             G             A
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
expect_equal(as.matrix(granges_coding$REFCODON), as.matrix(vcf_coding$REFCODON))
expect_equal(as.matrix(granges_coding$VARCODON), as.matrix(vcf_coding$VARCODON))
expect_equal(granges_coding$GENEID, vcf_coding$GENEID)
expect_equal(granges_coding$CONSEQUENCE, vcf_coding$CONSEQUENCE)
```

## 0.3 Provenance

```
sessionInfo()
```

```
## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
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
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] testthat_2.0.1
##  [2] ggbio_1.30.0
##  [3] ggplot2_3.1.0
##  [4] org.Hs.eg.db_3.7.0
##  [5] BSgenome.Hsapiens.UCSC.hg19_1.4.0
##  [6] BSgenome_1.50.0
##  [7] rtracklayer_1.42.0
##  [8] TxDb.Hsapiens.UCSC.hg19.knownGene_3.2.2
##  [9] GenomicFeatures_1.34.0
## [10] AnnotationDbi_1.44.0
## [11] GoogleGenomics_2.4.0
## [12] VariantAnnotation_1.28.0
## [13] GenomicAlignments_1.18.0
## [14] Rsamtools_1.34.0
## [15] Biostrings_2.50.0
## [16] XVector_0.22.0
## [17] SummarizedExperiment_1.12.0
## [18] DelayedArray_0.8.0
## [19] BiocParallel_1.16.0
## [20] matrixStats_0.54.0
## [21] Biobase_2.42.0
## [22] GenomicRanges_1.34.0
## [23] GenomeInfoDb_1.18.0
## [24] IRanges_2.16.0
## [25] S4Vectors_0.20.0
## [26] BiocGenerics_0.28.0
## [27] knitr_1.20
## [28] BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] colorspace_1.3-2       rjson_0.2.20           rprojroot_1.3-2
##  [4] biovizBase_1.30.0      htmlTable_1.12         base64enc_0.1-3
##  [7] dichromat_2.0-0        rstudioapi_0.8         bit64_0.9-7
## [10] splines_3.5.1          Formula_1.2-3          jsonlite_1.5
## [13] cluster_2.0.7-1        graph_1.60.0           BiocManager_1.30.3
## [16] compiler_3.5.1         httr_1.3.1             backports_1.1.2
## [19] assertthat_0.2.0       Matrix_1.2-14          lazyeval_0.2.1
## [22] acepack_1.4.1          htmltools_0.3.6        prettyunits_1.0.2
## [25] tools_3.5.1            bindrcpp_0.2.2         gtable_0.2.0
## [28] glue_1.3.0             GenomeInfoDbData_1.2.0 reshape2_1.4.3
## [31] dplyr_0.7.7            Rcpp_0.12.19           xfun_0.4
## [34] stringr_1.3.1          ensembldb_2.6.0        XML_3.98-1.16
## [37] zlibbioc_1.28.0        scales_1.0.0           hms_0.4.2
## [40] ProtGenerics_1.14.0    RBGL_1.58.0            AnnotationFilter_1.6.0
## [43] RColorBrewer_1.1-2     yaml_2.2.0             curl_3.2
## [46] memoise_1.1.0          gridExtra_2.3          biomaRt_2.38.0
## [49] rpart_4.1-13           reshape_0.8.8          latticeExtra_0.6-28
## [52] stringi_1.2.4          RSQLite_2.1.1          checkmate_1.8.5
## [55] rlang_0.3.0.1          pkgconfig_2.0.2        bitops_1.0-6
## [58] evaluate_0.12          lattice_0.20-35        purrr_0.2.5
## [61] bindr_0.1.1            htmlwidgets_1.3        labeling_0.3
## [64] bit_1.1-14             tidyselect_0.2.5       GGally_1.4.0
## [67] plyr_1.8.4             magrittr_1.5           bookdown_0.7
## [70] R6_2.3.0               Hmisc_4.1-1            DBI_1.0.0
## [73] pillar_1.3.0           foreign_0.8-71         withr_2.1.2
## [76] survival_2.43-1        RCurl_1.95-4.11        nnet_7.3-12
## [79] tibble_1.4.2           crayon_1.3.4           OrganismDbi_1.24.0
## [82] rmarkdown_1.10         progress_1.2.0         grid_3.5.1
## [85] data.table_1.11.8      blob_1.1.1             digest_0.6.18
## [88] munsell_0.5.0
```