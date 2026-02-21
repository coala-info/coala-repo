# Resource specific interaction attributes

Denes Turei1\*

1Institute for Computational Biomedicine, Heidelberg University

\*turei.denes@gmail.com

#### 29 January 2026

#### Abstract

OmniPath provides a broad variety of protein annotations, but for
interactions, until recently, only a standard set of essential attributes
(direction, effect, etc) and a handful of others (e.g. DoRothEA confidence
level) were available. The newly introduced `extra_attrs` column consists of
JSON encoded custom, resource specific attributes from network databases.
We also revised the processing of these resources to ensure that we include
as many useful attributes as possible. In the OmnipathR package we added a
few new functions to support the processing of the JSON encoded column:
to scan it for keys and values, and to extract specific variables of
interest into new columns. We give a brief overview of these here.

#### Package

OmnipathR 3.18.4

# Contents

* [1 Loading a network](#loading-a-network)
* [2 Which extra attributes are available?](#which-extra-attributes-are-available)
* [3 Inspecting one attribute](#inspecting-one-attribute)
* [4 Converting extra attributes to columns](#converting-extra-attributes-to-columns)
* [5 Filtering records based on extra attributes](#filtering-records-based-on-extra-attributes)
* [6 Example: finding ubiquitination interactions](#example-finding-ubiquitination-interactions)
* [7 Session information](#session-information)

1 Institute for Computational Biomedicine, Heidelberg University

# 1 Loading a network

```
library(OmnipathR)
```

First we retrieve the complete directed PPI network. Importantly, the extra
attributes are only included if the `fields = "extra_attrs"` argument is
provided.

```
i <- post_translational(fields = 'extra_attrs')
dplyr::select(i, source_genesymbol, target_genesymbol, extra_attrs)
```

```
## # A tibble: 139,054 × 3
##    source_genesymbol target_genesymbol extra_attrs
##    <chr>             <chr>             <list>
##  1 CALM3             TRPC1             <named list [1]>
##  2 CALM1             TRPC1             <named list [1]>
##  3 CALM2             TRPC1             <named list [1]>
##  4 CAV1              TRPC1             <named list [1]>
##  5 DRD2              TRPC1             <named list [1]>
##  6 MDFI              TRPC1             <named list [1]>
##  7 ITPR2             TRPC1             <named list [1]>
##  8 MARCKS            TRPC1             <named list [1]>
##  9 TRPC1             GRM1              <named list [0]>
## 10 GRM1              TRPC1             <named list [1]>
## # ℹ 139,044 more rows
```

Above we see, the `extra_attrs` column is a list type column. Each list
is a nested list itself, containing the extra attributes from all resources,
as it was extracted from the JSON.

# 2 Which extra attributes are available?

Which attributes present in the network depends only on the interactions: if
none of the interactions is from the `SPIKE` database, obviously the
`SPIKE_mechanism` won’t be present. The names of the extra attributes consist
of the name of the resource and the name of the attribute, separated by an
underscore. The resource name never contains underscore, while some attribute
names do. To list the extra attributes available in a particular data frame
use the `extra_attrs` function:

```
extra_attrs(i)
```

```
##  [1] "TRIP_method"                "SIGNOR_mechanism"           "PhosphoSite_noref_evidence"
##  [4] "PhosphoPoint_category"      "PhosphoSite_evidence"       "HPRD-phos_mechanism"
##  [7] "Li2012_mechanism"           "Li2012_route"               "SPIKE_effect"
## [10] "SPIKE_mechanism"            "SPIKE_LC_effect"            "SPIKE_LC_mechanism"
## [13] "CA1_effect"                 "CA1_type"                   "Macrophage_type"
## [16] "Macrophage_location"        "ACSN_effect"                "Cellinker_type"
## [19] "CellChatDB_category"        "talklr_putative"            "CellPhoneDB_type"
## [22] "CellPhoneDB_is_ppi"         "Ramilowski2015_source"      "ARN_effect"
## [25] "ARN_is_direct"              "ARN_is_directed"            "NRF2ome_effect"
## [28] "NRF2ome_is_direct"          "NRF2ome_is_directed"
```

The labels listed here are the top level keys in the lists in the
`extra_attrs` column. Note, the coverage of these variables varies a lot,
typically in agreement with the size of the resource.

# 3 Inspecting one attribute

The values of each extra attribute, in theory, can be arbitrarily complex
nested lists, but in reality, these are most often simple numeric, logical
or character values or vectors. To see the unique values of one attribute
use the `extra_attr_values` function. Let’s see the values of the
`SIGNOR_mechanism` attribute:

```
extra_attr_values(i, SIGNOR_mechanism)
```

```
##  [1] "phosphorylation"                    "binding"
##  [3] "dephosphorylation"                  "Phosphorylation"
##  [5] "ubiquitination"                     "N/A"
##  [7] "Physical Interaction"               "Proteolytic Processing"
##  [9] "cleavage"                           "Ubiquitination"
## [11] "polyubiquitination"                 "deubiquitination"
## [13] "Deubiqitination"                    "relocalization"
## [15] "Dephosphorylation"                  "Other"
## [17] "guanine nucleotide exchange factor" "Transcription Regulation"
## [19] "gtpase-activating protein"          "Indirect"
## [21] ""                                   "sumoylation"
## [23] "Sumoylation"                        "palmitoylation"
## [25] "Acetylation"                        "acetylation"
## [27] "demethylation"                      "Demethylation"
## [29] "mRNA stability"                     "methylation"
## [31] "Methylation"                        "trimethylation"
## [33] "hydroxylation"                      "monoubiquitination"
## [35] "Deacetylation"                      "deacetylation"
## [37] "Translational Regulation"           "Protein Degradation"
## [39] "Glycosylation"                      "s-nitrosylation"
## [41] "post transcriptional regulation"    "phosphomotif_binding"
## [43] "chemical activation"                "Proteolytic Cleavage"
## [45] "glycosylation"                      "Carboxylation"
## [47] "carboxylation"                      "ADP-ribosylation"
## [49] "catalytic activity"                 "neddylation"
## [51] "translation regulation"             "tyrosination"
## [53] "post translational modification"    "isomerization"
## [55] "desumoylation"                      "destabilization"
## [57] "chemical inhibition"                "lipidation"
## [59] "deglycosylation"                    "chemical modification"
## [61] "stabilization"                      "oxidation"
## [63] "Neddylation"                        "Alkylation"
```

The values are provided as they are in the original resource, including
potential typos and inconsistencies, e.g. see above the capitalized vs.
lowercase forms of each value.

# 4 Converting extra attributes to columns

To make use of the attributes, it is convenient to extract the interesting
ones into separate columns of the data frame. With the `extra_attrs_to_cols`
function multiple attributes can be converted in a single call. Custom column
names can be passed by argument names. As an example, let’s extract two
attributes:

```
i0 <- extra_attrs_to_cols(
    i,
    si_mechanism = SIGNOR_mechanism,
    ma_mechanism = Macrophage_type,
    keep_empty = FALSE
)

dplyr::select(
    i0,
    source_genesymbol,
    target_genesymbol,
    si_mechanism,
    ma_mechanism
)
```

```
## # A tibble: 65,433 × 4
##    source_genesymbol target_genesymbol si_mechanism ma_mechanism
##    <chr>             <chr>             <list>       <list>
##  1 PRKG1             TRPC3             <list [1]>   <NULL>
##  2 FYN               TRPC6             <list [1]>   <NULL>
##  3 PRKG1             TRPC6             <list [1]>   <NULL>
##  4 SRC               TRPC6             <list [1]>   <NULL>
##  5 PRKG1             TRPC7             <list [1]>   <NULL>
##  6 CDK5              TRPV1             <list [1]>   <NULL>
##  7 OS9               TRPV4             <list [1]>   <NULL>
##  8 PTPN1             TRPV6             <list [1]>   <NULL>
##  9 RACK1             TRPM6             <list [1]>   <NULL>
## 10 TRPM6             TRPM7             <list [1]>   <NULL>
## # ℹ 65,423 more rows
```

Above we disabled the `keep_empty` option, otherwise the new columns would
have `NULL` values for most of the records, simply because out of the 80k
interactions in the data frame only a few thousands are from either SIGNOR
or Macrophage. The new columns are list type, individual values are character
vectors. Let’s look into one value:

```
dplyr::pull(i0, si_mechanism)[[7]]
```

```
## [[1]]
## [1] "binding"
```

Here we have two values, but only because the inconsistent names in the
resource.

Depending on downstream methods, atomic columns might be preferable instead
of lists. In this case one interaction record might yield multiple rows in
the resulted data frame, depending on the number of attributes it has. To
have atomic columns, use the `flatten` option:

```
i1 <- extra_attrs_to_cols(
    i,
    si_mechanism = SIGNOR_mechanism,
    ma_mechanism = Macrophage_type,
    keep_empty = FALSE,
    flatten = TRUE
)

dplyr::select(
    i1,
    source_genesymbol,
    target_genesymbol,
    si_mechanism,
    ma_mechanism
)
```

```
## # A tibble: 67,704 × 4
##    source_genesymbol target_genesymbol si_mechanism ma_mechanism
##    <chr>             <chr>             <list>       <list>
##  1 PRKG1             TRPC3             <chr [1]>    <NULL>
##  2 FYN               TRPC6             <chr [1]>    <NULL>
##  3 PRKG1             TRPC6             <chr [1]>    <NULL>
##  4 SRC               TRPC6             <chr [1]>    <NULL>
##  5 PRKG1             TRPC7             <chr [1]>    <NULL>
##  6 CDK5              TRPV1             <chr [1]>    <NULL>
##  7 OS9               TRPV4             <chr [1]>    <NULL>
##  8 PTPN1             TRPV6             <chr [1]>    <NULL>
##  9 RACK1             TRPM6             <chr [1]>    <NULL>
## 10 TRPM6             TRPM7             <chr [1]>    <NULL>
## # ℹ 67,694 more rows
```

# 5 Filtering records based on extra attributes

Another useful application of extra attributes is filtering the records of
the interactions data frame. The `with_extra_attrs` function filters to
records which have certain extra attributes. For example, to have only
interactions with `SIGNOR_mechanism` given:

```
nrow(with_extra_attrs(i, SIGNOR_mechanism))
```

```
## [1] 65144
```

This results around 11 thousands rows. Filtering for multiple attributes the
records which have at least one of them will be selected. Adding some more
attributes results more interactions:

```
nrow(with_extra_attrs(i, SIGNOR_mechanism, CA1_effect, Li2012_mechanism))
```

```
## [1] 66037
```

It is possible to filter the records not only by the names but the values
of the extra attributes. Let’s select the interactions which are
phosphorylation according to SIGNOR:

```
phos <- c('phosphorylation', 'Phosphorylation')

si_phos <- filter_extra_attrs(i, SIGNOR_mechanism = phos)

dplyr::select(si_phos, source_genesymbol, target_genesymbol)
```

```
## # A tibble: 6,585 × 2
##    source_genesymbol target_genesymbol
##    <chr>             <chr>
##  1 PRKG1             TRPC3
##  2 FYN               TRPC6
##  3 PRKG1             TRPC6
##  4 SRC               TRPC6
##  5 PRKG1             TRPC7
##  6 CDK5              TRPV1
##  7 TRPM6             TRPM7
##  8 PRKACA            MCOLN1
##  9 MAPK14            MAPKAPK2
## 10 MAPKAPK2          HNRNPA0
## # ℹ 6,575 more rows
```

# 6 Example: finding ubiquitination interactions

First let’s search for the word “ubiquitination” in the attributes. Below
is a slow but simple solution:

```
keys <- extra_attrs(i)
keys_ubi <- purrr::keep(
    keys,
    function(k){
        any(stringr::str_detect(extra_attr_values(i, !!k), 'biqu'))
    }
)
keys_ubi
```

```
## [1] "SIGNOR_mechanism"    "HPRD-phos_mechanism" "SPIKE_mechanism"     "SPIKE_LC_mechanism"
## [5] "CA1_type"            "Macrophage_type"
```

We found five attributes that have at least one value which matches “biqu”.
Next take a look at their values:

```
ubi <- rlang::set_names(
    purrr::map(
        keys_ubi,
        function(k){
            stringr::str_subset(extra_attr_values(i, !!k), 'biqu')
        }
    ),
    keys_ubi
)
ubi
```

```
## $SIGNOR_mechanism
## [1] "ubiquitination"     "Ubiquitination"     "polyubiquitination" "deubiquitination"   "monoubiquitination"
##
## $`HPRD-phos_mechanism`
## [1] "Ubiquitination"
##
## $SPIKE_mechanism
## [1] "Ubiquitination"     "Polyubiquitination"
##
## $SPIKE_LC_mechanism
## [1] "Ubiquitination"     "Polyubiquitination"
##
## $CA1_type
## [1] "Ubiquitination"
##
## $Macrophage_type
## [1] "Ubiquitination"
```

Actually to match all ubiquitination interactions, it’s enough to filter for
“ubiquitination” in its lowercase and capitalized forms (note, we could also
include deubiqutination and polyubiquitination):

```
ubi_kws <- c('ubiquitination', 'Ubiquitination')

i_ubi <-
    dplyr::distinct(
        dplyr::bind_rows(
            purrr::map(
                keys_ubi,
                function(k){
                    filter_extra_attrs(i, !!k := ubi_kws, na_ok = FALSE)
                }
            )
        )
    )

dplyr::select(i_ubi, source_genesymbol, target_genesymbol)
```

```
## # A tibble: 49,709 × 2
##    source_genesymbol target_genesymbol
##    <chr>             <chr>
##  1 NUMB              NOTCH1
##  2 BTRC_CUL1_SKP1    PER2
##  3 PRKN              SEPTIN5
##  4 PRKN              RANBP2
##  5 PRKN              SNCAIP
##  6 PRKN              SNCA
##  7 FBXW7             MYC
##  8 MIB1              DAPK1
##  9 UBE2T             FANCL
## 10 FANCL             UBE2T
## # ℹ 49,699 more rows
```

We found 405 ubiquitination interactions. We had to use `map`, `bind_rows`
and `distinct` because otherwise `filter_extra_attrs` would return the
intersection of the matches, instead of their union.

In this data frame we have 150 unique ubiquitin E3 ligases:

```
length(unique(i_ubi$source_genesymbol))
```

```
## [1] 435
```

UniProt annotates E3 ligases by the “Ubl conjugation” keyword. We can check
how many of those 150 proteins have this annotation:

```
uniprot_kws <- annotations(
    resources = 'UniProt_keyword',
    entity_type = 'protein',
    wide = TRUE
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
e3_ligases <- dplyr::pull(
    dplyr::filter(uniprot_kws, keyword == 'Ubl conjugation'),
    genesymbol
)

length(e3_ligases)
```

```
## [1] 2738
```

```
length(intersect(unique(i_ubi$source_genesymbol), e3_ligases))
```

```
## [1] 144
```

```
length(setdiff(unique(i_ubi$source_genesymbol), e3_ligases))
```

```
## [1] 291
```

We retrieved 2503 E3 ligases from UniProt. 83 of these has substrates in
the interaction database, while 67 of the effectors of the interactions are
not annotated in UniProt.

In the OmniPath enzyme-substrate database we collect ubiquitination
interactions from enzyme-PTM resources. However, these contain only a small
number of interactions:

```
es_ubi <- enzyme_substrate(types = 'ubiquitination')
es_ubi
```

```
## # A tibble: 164 × 12
##    enzyme substrate enzyme_genesymbol substrate_genesymbol residue_type residue_offset modification   sources
##    <chr>  <chr>     <chr>             <chr>                <chr>                 <dbl> <chr>          <chr>
##  1 Q9Y385 Q92813    UBE2J1            DIO2                 K                       244 ubiquitination SIGNOR
##  2 Q9Y385 Q92813    UBE2J1            DIO2                 K                       237 ubiquitination SIGNOR
##  3 P38398 O75367    BRCA1             MACROH2A1            K                       123 ubiquitination SIGNOR
##  4 P63279 O75030    UBE2I             MITF                 K                       308 ubiquitination SIGNOR
##  5 Q9UNE7 Q01860    STUB1             POU5F1               K                       284 ubiquitination SIGNOR
##  6 P63208 Q13426    SKP1              XRCC4                K                       296 ubiquitination SIGNOR
##  7 Q13616 Q13426    CUL1              XRCC4                K                       296 ubiquitination SIGNOR
##  8 Q969H0 Q13426    FBXW7             XRCC4                K                       296 ubiquitination SIGNOR
##  9 P63208 P35659    SKP1              DEK                  K                       137 ubiquitination SIGNOR
## 10 P63208 P35659    SKP1              DEK                  K                       344 ubiquitination SIGNOR
## # ℹ 154 more rows
## # ℹ 4 more variables: references <chr>, curation_effort <dbl>, n_references <int>, n_resources <int>
```

With only two exception, all these have been recovered by using the extra
attributes from the network database:

```
es_i_ubi <-
    dplyr::inner_join(
        es_ubi,
        i_ubi,
        by = c(
            'enzyme_genesymbol' = 'source_genesymbol',
            'substrate_genesymbol' = 'target_genesymbol'
        )
    )

nrow(dplyr::distinct(dplyr::select(es_i_ubi, enzyme, substrate, residue_offset)))
```

```
## [1] 110
```

# 7 Session information

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
## [1] magrittr_2.0.4   ggraph_2.2.2     igraph_2.2.1     ggplot2_4.0.1    dplyr_1.1.4      OmnipathR_3.18.4
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    viridisLite_0.4.2   farver_2.1.2        blob_1.3.0          viridis_0.6.5
##  [6] R.utils_2.13.0      S7_0.2.1            fastmap_1.2.0       tweenr_2.0.3        promises_1.5.0
## [11] XML_3.99-0.20       digest_0.6.39       timechange_0.3.0    lifecycle_1.0.5     processx_3.8.6
## [16] RSQLite_2.4.5       compiler_4.5.2      rlang_1.1.7         sass_0.4.10         progress_1.2.3
## [21] tools_4.5.2         utf8_1.2.6          yaml_2.3.12         knitr_1.51          labeling_0.4.3
## [26] graphlayouts_1.2.2  prettyunits_1.2.0   bit_4.6.0           curl_7.0.0          xml2_1.5.2
## [31] RColorBrewer_1.1-3  websocket_1.4.4     withr_3.0.2         purrr_1.2.1         R.oo_1.27.1
## [36] polyclip_1.10-7     grid_4.5.2          scales_1.4.0        MASS_7.3-65         tinytex_0.58
## [41] dichromat_2.0-0.1   cli_3.6.5           rmarkdown_2.30      crayon_1.5.3        generics_0.1.4
## [46] otel_0.2.0          httr_1.4.7          tzdb_0.5.0          sessioninfo_1.2.3   readxl_1.4.5
## [51] DBI_1.2.3           cachem_1.1.0        chromote_0.5.1      ggforce_0.5.0       stringr_1.6.0
## [56] rvest_1.0.5         parallel_4.5.2      BiocManager_1.30.27 selectr_0.5-1       cellranger_1.1.0
## [61] vctrs_0.7.1         jsonlite_2.0.0      bookdown_0.46       hms_1.1.4           ggrepel_0.9.6
## [66] bit64_4.6.0-1       magick_2.9.0        jquerylib_0.1.4     tidyr_1.3.2         glue_1.8.0
## [71] ps_1.9.1            lubridate_1.9.4     stringi_1.8.7       gtable_0.3.6        later_1.4.5
## [76] tibble_3.3.1        logger_0.4.1        pillar_1.11.1       rappdirs_0.3.4      htmltools_0.5.9
## [81] R6_2.6.1            httr2_1.2.2         tcltk_4.5.2         tidygraph_1.3.1     vroom_1.7.0
## [86] evaluate_1.0.5      readr_2.1.6         R.methodsS3_1.8.2   backports_1.5.0     memoise_2.0.1
## [91] bslib_0.10.0        Rcpp_1.1.1          zip_2.3.3           gridExtra_2.3       checkmate_2.3.3
## [96] xfun_0.56           fs_1.6.6            pkgconfig_2.0.3
```