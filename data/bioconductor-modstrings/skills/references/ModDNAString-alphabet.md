# ModDNAString alphabet

Felix G.M. Ernst & Denis L.J. Lafontaine

#### 2025-10-30

#### Abstract

Details on the DNA modification alphabet used by the Modstrings package

#### Package

Modstrings 1.26.0

# Contents

* [References](#references)

The alphabets for the modifications used in this package are based on the
compilation of DNA modifications by the Hoffman lab (Sood, Viner, and Hoffman [2019](#ref-Sood.2019)). The alphabet
was modified to make it compatible for the `Modstrings` package.

If modifications are missing, let us know.

Table 1: List of DNA modifications supported by ModDNAString objects.

| modification | short name | nomenclature | orig. base | abbreviation |
| --- | --- | --- | --- | --- |
| 5-putrescinylthymine | 5pT | 5pT | T | p |
| 3-methylthymine | 3mT | 3mT | T | δ |
| O4-methylthymine | O4meT | O4meT | T | O |
| 1-methylthymine | 1mT | 1mT | T | ] |
| 5,6-dihydrothymine | dhT | dhT | T | D |
| Î²-glucosyl-hydroxymethyluracil | baseJ | baseJ | T | J |
| 5-formyluracil | 5fU | 5fU | T | e |
| 5-hydroxymethyluracil | 5hmU | 5hmU | T | g |
| 5-dihydroxypentyluracil | dhpU | dhpU | T | ` |
| 5-carboxyluracil | 5caU | 5caU | T | b |
| 2’-deoxyuridine | dU | dU | T | U |
| 5,6-dihydroxy-2’-deoxyuridine | DHdU | DHdU | T | ∝ |
| 5-(2-aminoethyl)uridine | 5nmU | 5nmU | T | π |
| 2’-deoxyinosine | dI | dI | A | I |
| 7-methylguanine | 7mG | 7mG | G | 7 |
| 6-O-methylguanine | 6mG | 6mG | G | 6 |
| 3-methylguanine | 3mG | 3mG | G | 3 |
| 2-methylguanine | 2mG | 2mG | G | 2 |
| 1-methylguanine | 1mG | 1mG | G | 1 |
| 8-oxoguanine | 8oxoG | 8oxoG | G | 8 |
| 7-amido-7-deazaguanosine | 7a7dG | 7a7dG | G | ∉ |
| 1,N2-ethenoguanine | 12eG | 12eG | G | ⊆ |
| N2,3-ethenoguanine | 23eG | 23eG | G | ⊇ |
| N2,N2-dimethylguanosine | 2,2mG | 2,2mG | G | R |
| N2-carboxyethylguanine | 2ceG | 2ceG | G | α |
| 5-methylcytosine | 5mC | 5mC | C | m |
| 5-hydroxymethylcytosine | 5hmC | 5hmC | C | h |
| 5-glucosylmethylcytosine | 5gmC | 5gmC | C | × |
| 5-formylcytosine | 5fC | 5fC | C | f |
| 5-carboxylcytosine | 5caC | 5caC | C | 4 |
| 4-methylcytosine | 4mC | 4mC | C | ν |
| 3,N4-ethenocytosine | 34eC | 34eC | C | X |
| 3-methylcytosine | 3mC | 3mC | C | ’ |
| 3-ethylcytosine | 3eC | 3eC | C | κ |
| 2-O-methylcytosine | 2mC | 2mC | C | o |
| 1-methylcytosine | 1mC | 1mC | C | ( |
| 9-methyladenine | 9mA | 9mA | A | ) |
| 7-methyladenine | 7mA | 7mA | A | η |
| 6-methyladenine | 6mA | 6mA | A | a |
| 4-methyladenine | 4mA | 4mA | A | ⇓ |
| 3-methyladenine | 3mA | 3mA | A | ⇑ |
| 1-methyladenine | 1mA | 1mA | A | " |
| 6-hydroxyaminopurine | 6haA | 6haA | A | √ |
| 2-aminoadenine | 2mA | 2mA | A | / |
| 2-amino-6-hydroxyaminopurine | 2a6haA | 2a6haA | A | ≡ |
| N6,N6-dimethyladenine | 6,6mA | 6,6mA | A | ζ |
| N6-carbamoylmethyladenine | 6ncmA | 6ncmA | A | ~ |

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
## [1] Modstrings_1.26.0   Biostrings_2.78.0   Seqinfo_1.0.0
## [4] XVector_0.50.0      IRanges_2.44.0      S4Vectors_0.48.0
## [7] BiocGenerics_0.56.0 generics_0.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] crayon_1.5.3         cli_3.6.5            knitr_1.50
##  [4] rlang_1.1.6          xfun_0.53            stringi_1.8.7
##  [7] jsonlite_2.0.0       glue_1.8.0           htmltools_0.5.8.1
## [10] sass_0.4.10          rmarkdown_2.30       evaluate_1.0.5
## [13] jquerylib_0.1.4      fastmap_1.2.0        yaml_2.3.10
## [16] lifecycle_1.0.4      bookdown_0.45        stringr_1.5.2
## [19] BiocManager_1.30.26  compiler_4.5.1       digest_0.6.37
## [22] R6_2.6.1             magrittr_2.0.4       GenomicRanges_1.62.0
## [25] bslib_0.9.0          tools_4.5.1          cachem_1.1.0
```

# References

Sood, Ankur Jai, Coby Viner, and Michael M. Hoffman. 2019. “DNAmod: The Dna Modification Database.” *Journal of Cheminformatics* 11 (1): 30. <https://doi.org/10.1186/s13321-019-0349-4>.