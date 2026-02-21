# Annotating Variants

#### *30 October 2018*

# Contents

* [0.1 Working with Variants](#working-with-variants)
* [0.2 Annotating Variants](#annotating-variants)
* [0.3 Provenance](#provenance)

## 0.1 Working with Variants

[Google Genomics](http://cloud.google.com/genomics) implements the [GA4GH](http://ga4gh.org/) variants API and this R package can retrieve data from that implementation. For more detail, see <https://cloud.google.com/genomics/v1beta2/reference/variants>

```
library(GoogleGenomics)
```

```
## Warning: Package 'GoogleGenomics' is deprecated and will be removed from
##   Bioconductor version 3.9
```

```
# This vignette is authenticated on package load from the env variable GOOGLE_API_KEY.
# When running interactively, call the authenticate method.
# ?authenticate
```

By default, this function retrieves variants for a small genomic region from the [1,000 Genomes](http://googlegenomics.readthedocs.org/en/latest/use_cases/discover_public_data/1000_genomes.html) phase 1 variants.

```
variants <- getVariants()
```

```
## Fetching variants page.
```

```
## Variants are now available.
```

```
length(variants)
```

```
## [1] 4
```

We can see that 4 individual variants were returned and that the JSON response was deserialized into an R list object:

```
class(variants)
```

```
## [1] "list"
```

```
mode(variants)
```

```
## [1] "list"
```

The top level field names are:

```
names(variants[[1]])
```

```
##  [1] "variantSetId"   "id"             "names"          "created"
##  [5] "referenceName"  "start"          "end"            "referenceBases"
##  [9] "alternateBases" "quality"        "filter"         "info"
## [13] "calls"
```

The variant contains nested calls:

```
length(variants[[1]]$calls)
```

```
## [1] 1092
```

With top level call field names:

```
names(variants[[1]]$calls[[1]])
```

```
## [1] "callSetId"          "callSetName"        "genotype"
## [4] "phaseset"           "genotypeLikelihood" "info"
```

And examining a call for a particular variant:

```
variants[[1]]$referenceName
```

```
## [1] "22"
```

```
variants[[1]]$start
```

```
## [1] "16051452"
```

```
variants[[1]]$alternateBases
```

```
## [[1]]
## [1] "C"
```

```
variants[[1]]$calls[[1]]
```

```
## $callSetId
## [1] "10473108253681171589-0"
##
## $callSetName
## [1] "HG00261"
##
## $genotype
## $genotype[[1]]
## [1] 0
##
## $genotype[[2]]
## [1] 0
##
##
## $phaseset
## [1] "*"
##
## $genotypeLikelihood
## $genotypeLikelihood[[1]]
## [1] -0.1
##
## $genotypeLikelihood[[2]]
## [1] -0.67
##
## $genotypeLikelihood[[3]]
## [1] -3.3
##
##
## $info
## $info$DS
## $info$DS[[1]]
## [1] "0.000"
```

This is good, but this data becomes **much** more useful when it is converted to Bioconductor data types. For example, we can convert variants in this list representation to VRanges from *[VariantAnnotation](https://bioconductor.org/packages/3.8/VariantAnnotation)*:

```
variantsToVRanges(variants)
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## VRanges object with 4 ranges and 2 metadata columns:
##               seqnames    ranges strand         ref              alt
##                  <Rle> <IRanges>  <Rle> <character> <characterOrRle>
##   rs143503259    chr22  16051453      *           A                C
##   rs192339082    chr22  16051477      *           C                A
##    rs79725552    chr22  16051480      *           T                C
##   rs141578542    chr22  16051497      *           A                G
##                   totalDepth       refDepth       altDepth   sampleNames
##               <integerOrRle> <integerOrRle> <integerOrRle> <factorOrRle>
##   rs143503259           <NA>           <NA>           <NA>          <NA>
##   rs192339082           <NA>           <NA>           <NA>          <NA>
##    rs79725552           <NA>           <NA>           <NA>          <NA>
##   rs141578542           <NA>           <NA>           <NA>          <NA>
##               softFilterMatrix |      QUAL      FILTER
##                       <matrix> | <numeric> <character>
##   rs143503259                  |       100        PASS
##   rs192339082                  |       100        PASS
##    rs79725552                  |       100        PASS
##   rs141578542                  |       100        PASS
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##   hardFilters: NULL
```

## 0.2 Annotating Variants

Next let’s use package *[VariantAnnotation](https://bioconductor.org/packages/3.8/VariantAnnotation)* to annotate some specific 1,000 Genomes Phase 1 variants.

```
library(VariantAnnotation)
```

Note that the parameters `start` and `end` are expressed in 0-based coordinates per the GA4GH specification but the Bioconductor data type converters in *[GoogleGenomics](https://bioconductor.org/packages/3.8/GoogleGenomics)*, by default, transform the returned data to 1-based coordinates.

```
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

Now locate the protein coding variants in each:

```
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
```

```
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
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

And predict the effect of the protein coding variants:

```
library(BSgenome.Hsapiens.UCSC.hg19)
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

Finally, add gene information:

```
library(org.Hs.eg.db)
```

```
annots <- select(org.Hs.eg.db,
                 keys=granges_coding$GENEID,
                 keytype="ENTREZID",
                 columns=c("SYMBOL", "GENENAME","ENSEMBL"))
```

```
## 'select()' returned many:1 mapping between keys and columns
```

```
cbind(elementMetadata(granges_coding), annots)
```

```
## DataFrame with 7 rows and 20 columns
##                        REF                ALT      QUAL      FILTER
##             <DNAStringSet> <DNAStringSetList> <numeric> <character>
## rs114335781              G                  A       100        PASS
## rs8135963                T                  C       100        PASS
## rs200080075              C                  T       100        PASS
## rs147801200              G                  A       100        PASS
## rs138060012              C                  T       100        PASS
## rs114264124              C                  T       100        PASS
## rs149209714              C                  G       100        PASS
##                  varAllele    CDSLOC    PROTEINLOC   QUERYID        TXID
##             <DNAStringSet> <IRanges> <IntegerList> <integer> <character>
## rs114335781              T       939           313        24       75253
## rs8135963                G       885           295        25       75253
## rs200080075              A       873           291        26       75253
## rs147801200              T       867           289        27       75253
## rs138060012              A       777           259        28       75253
## rs114264124              A       698           233        57       75253
## rs149209714              C       665           222        58       75253
##                     CDSID      GENEID   CONSEQUENCE       REFCODON
##             <IntegerList> <character>      <factor> <DNAStringSet>
## rs114335781        218562       79087    synonymous            ATC
## rs8135963          218562       79087    synonymous            GCA
## rs200080075        218562       79087    synonymous            CCG
## rs147801200        218562       79087    synonymous            CAC
## rs138060012        218562       79087    synonymous            CCG
## rs114264124        218563       79087 nonsynonymous            CGG
## rs149209714        218563       79087 nonsynonymous            GGA
##                   VARCODON         REFAA         VARAA    ENTREZID
##             <DNAStringSet> <AAStringSet> <AAStringSet> <character>
## rs114335781            ATT             I             I       79087
## rs8135963              GCG             A             A       79087
## rs200080075            CCA             P             P       79087
## rs147801200            CAT             H             H       79087
## rs138060012            CCA             P             P       79087
## rs114264124            CAG             R             Q       79087
## rs149209714            GCA             G             A       79087
##                  SYMBOL                             GENENAME         ENSEMBL
##             <character>                          <character>     <character>
## rs114335781       ALG12 ALG12, alpha-1,6-mannosyltransferase ENSG00000182858
## rs8135963         ALG12 ALG12, alpha-1,6-mannosyltransferase ENSG00000182858
## rs200080075       ALG12 ALG12, alpha-1,6-mannosyltransferase ENSG00000182858
## rs147801200       ALG12 ALG12, alpha-1,6-mannosyltransferase ENSG00000182858
## rs138060012       ALG12 ALG12, alpha-1,6-mannosyltransferase ENSG00000182858
## rs114264124       ALG12 ALG12, alpha-1,6-mannosyltransferase ENSG00000182858
## rs149209714       ALG12 ALG12, alpha-1,6-mannosyltransferase ENSG00000182858
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
##  [1] org.Hs.eg.db_3.7.0
##  [2] BSgenome.Hsapiens.UCSC.hg19_1.4.0
##  [3] BSgenome_1.50.0
##  [4] rtracklayer_1.42.0
##  [5] TxDb.Hsapiens.UCSC.hg19.knownGene_3.2.2
##  [6] GenomicFeatures_1.34.0
##  [7] AnnotationDbi_1.44.0
##  [8] GoogleGenomics_2.4.0
##  [9] VariantAnnotation_1.28.0
## [10] GenomicAlignments_1.18.0
## [11] Rsamtools_1.34.0
## [12] Biostrings_2.50.0
## [13] XVector_0.22.0
## [14] SummarizedExperiment_1.12.0
## [15] DelayedArray_0.8.0
## [16] BiocParallel_1.16.0
## [17] matrixStats_0.54.0
## [18] Biobase_2.42.0
## [19] GenomicRanges_1.34.0
## [20] GenomeInfoDb_1.18.0
## [21] IRanges_2.16.0
## [22] S4Vectors_0.20.0
## [23] BiocGenerics_0.28.0
## [24] knitr_1.20
## [25] BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.19           lattice_0.20-35        prettyunits_1.0.2
##  [4] assertthat_0.2.0       rprojroot_1.3-2        digest_0.6.18
##  [7] R6_2.3.0               backports_1.1.2        RSQLite_2.1.1
## [10] evaluate_0.12          httr_1.3.1             zlibbioc_1.28.0
## [13] rlang_0.3.0.1          progress_1.2.0         curl_3.2
## [16] blob_1.1.1             Matrix_1.2-14          rmarkdown_1.10
## [19] stringr_1.3.1          RCurl_1.95-4.11        bit_1.1-14
## [22] biomaRt_2.38.0         compiler_3.5.1         xfun_0.4
## [25] pkgconfig_2.0.2        htmltools_0.3.6        GenomeInfoDbData_1.2.0
## [28] bookdown_0.7           XML_3.98-1.16          crayon_1.3.4
## [31] bitops_1.0-6           grid_3.5.1             jsonlite_1.5
## [34] DBI_1.0.0              magrittr_1.5           stringi_1.2.4
## [37] rjson_0.2.20           tools_3.5.1            bit64_0.9-7
## [40] hms_0.4.2              yaml_2.2.0             BiocManager_1.30.3
## [43] memoise_1.1.0
```