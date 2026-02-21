# ModRNAString alphabet

Felix G.M. Ernst & Denis L.J. Lafontaine

#### 2025-10-30

#### Abstract

Details on the RNA modification alphabet used by the Modstrings package

#### Package

Modstrings 1.26.0

# Contents

* [References](#references)

The alphabets for the modifications used in this package are based on the
compilation of RNA modifications by
the Bujnicki lab (Boccaletto et al. [2018](#ref-Boccaletto.2018)). The alphabet was modified to remove some
incompatible characters.

If modifications are missing, let us know.

Table 1: List of RNA modifications supported by ModRNAString objects.

| modification | short name | nomenclature | orig. base | abbreviation |
| --- | --- | --- | --- | --- |
| 1,2’-O-dimethyladenosine | m1Am | 01A | A | œ |
| 1,2’-O-dimethylguanosine | m1Gm | 01G | G | ε |
| 1,2’-O-dimethylinosine | m1Im | 019A | A | ξ |
| 1-methyl-3-(3-amino-3-carboxypropyl)pseudouridine | m1acp3Y | 1309U | U | α |
| 1-methyladenosine | m1A | 1A | A | " |
| 1-methylguanosine | m1G | 1G | G | K |
| 1-methylinosine | m1I | 19A | A | O |
| 1-methylpseudouridine | m1Y | 19U | U | ] |
| 2,8-dimethyladenosine | m2,8A | 28A | A | ± |
| 2-geranylthiouridine | ges2U | 21U | U | Γ |
| 2-lysidine | k2C | 21C | C | } |
| 2-methyladenosine | m2A | 2A | A | / |
| 2-methylthiomethylenethio-N6-isopentenyl-adenosine | msms2i6A | 2361A | A | £ |
| 2-methylthio-cyclic-N6-threonylcarbamoyladenosine | ms2ct6A | 2164A | A | ÿ |
| 2-methylthio-N6-(cis-hydroxyisopentenyl)-adenosine | ms2io6A | 2160A | A | ≠ |
| 2-methylthio-N6-hydroxynorvalylcarbamoyladenosine | ms2hn6A | 2163A | A | ≈ |
| 2-methylthio-N6-isopentenyladenosine | ms2i6A | 2161A | A | \* |
| 2-methylthio-N6-methyladenosine | ms2m6A | 621A | A | ∞ |
| 2-methylthio-N6-threonylcarbamoyladenosine | ms2t6A | 2162A | A | [ |
| 2-selenouridine | se2U | 20U | U | ω |
| 2-thio-2’-O-methyluridine | s2Um | 02U | U | ∏ |
| 2-thiocytidine | s2C | 2C | C | % |
| 2-thiouridine | s2U | 2U | U | 2 |
| 2’-O-methyladenosine | Am | 0A | A | : |
| 2’-O-methylcytidine | Cm | 0C | C | B |
| 2’-O-methylguanosine | Gm | 0G | G | # |
| 2’-O-methylinosine | Im | 09A | A | ≤ |
| 2’-O-methylpseudouridine | Ym | 09U | U | Z |
| 2’-O-methyluridine | Um | 0U | U | J |
| 2’-O-methyluridine 5-oxyacetic acid methyl ester | mcmo5Um | 0503U | U | Ä |
| 2’-O-ribosyladenosine (phosphate) | Ar(p) | 00A | A | ^ |
| 2’-O-ribosylguanosine (phosphate) | Gr(p) | 00G | G | ℑ |
| 3,2’-O-dimethyluridine | m3Um | 03U | U | σ |
| 3-(3-amino-3-carboxypropyl)-5,6-dihydrouridine | acp3D | 308U | U | Ð |
| 3-(3-amino-3-carboxypropyl)pseudouridine | acp3Y | 309U | U | Þ |
| 3-(3-amino-3-carboxypropyl)uridine | acp3U | 30U | U | X |
| 3-methylcytidine | m3C | 3C | C | ’ |
| 3-methylpseudouridine | m3Y | 39U | U | κ |
| 3-methyluridine | m3U | 3U | U | δ |
| 4-demethylwyosine | imG-14 | 4G | G | † |
| 4-thiouridine | s4U | 74U | U | 4 |
| 5,2’-O-dimethylcytidine | m5Cm | 05C | C | τ |
| 5,2’-O-dimethyluridine | m5Um | 05U | U | ¤ |
| 5-(carboxyhydroxymethyl)-2’-O-methyluridine methyl ester | mchm5Um | 0522U | U | b |
| 5-(carboxyhydroxymethyl)uridine methyl ester | mchm5U | 522U | U | , |
| 5-(isopentenylaminomethyl)-2-thiouridine | inm5s2U | 2583U | U | ½ |
| 5-(isopentenylaminomethyl)-2’-O-methyluridine | inm5Um | 0583U | U | ¼ |
| 5-(isopentenylaminomethyl)uridine | inm5U | 583U | U | ¾ |
| 5-aminomethyl-2-geranylthiouridine | nm5ges2U | 21510U | U | Δ |
| 5-aminomethyl-2-selenouridine | nm5se2U | 20510U | U | π |
| 5-aminomethyl-2-thiouridine | nm5s2U | 2510U | U | ∫ |
| 5-aminomethyluridine | nm5U | 510U | U | ∪ |
| 5-carbamoylhydroxymethyluridine | nchm5U | 531U | U | r |
| 5-carbamoylmethyl-2-thiouridine | ncm5s2U | 253U | U | l |
| 5-carbamoylmethyl-2’-O-methyluridine | ncm5Um | 053U | U | ~ |
| 5-carbamoylmethyluridine | ncm5U | 53U | U | & |
| 5-carboxyhydroxymethyluridine | chm5U | 520U | U | ≥ |
| 5-carboxymethyl-2-thiouridine | cm5s2U | 2540U | U | ℘ |
| 5-carboxymethylaminomethyl-2-geranylthiouridine | cmnm5ges2U | 2151U | U | f |
| 5-carboxymethylaminomethyl-2-selenouridine | cmnm5se2U | 2051U | U | ⊥ |
| 5-carboxymethylaminomethyl-2-thiouridine | cmnm5s2U | 251U | U | $ |
| 5-carboxymethylaminomethyl-2’-O-methyluridine | cmnm5Um | 051U | U | ) |
| 5-carboxymethylaminomethyluridine | cmnm5U | 51U | U | ! |
| 5-carboxymethyluridine | cm5U | 52U | U | ◊ |
| 5-cyanomethyluridine | cnm5U | 55U | U | Ѷ |
| 5-formyl-2’-O-methylcytidine | f5Cm | 071C | C | ° |
| 5-formylcytidine | f5C | 71C | C | × |
| 5-hydroxycytidine | ho5C | 50C | C | Ç |
| 5-hydroxymethylcytidine | hm5C | 51C | C | ∅ |
| 5-hydroxyuridine | ho5U | 50U | U | ∝ |
| 5-methoxycarbonylmethyl-2-thiouridine | mcm5s2U | 2521U | U | 3 |
| 5-methoxycarbonylmethyl-2’-O-methyluridine | mcm5Um | 0521U | U | ∩ |
| 5-methoxycarbonylmethyluridine | mcm5U | 521U | U | 1 |
| 5-methoxyuridine | mo5U | 501U | U | 5 |
| 5-methyl-2-thiouridine | m5s2U | 25U | U | F |
| 5-methylaminomethyl-2-geranylthiouridine | mnm5ges2U | 21511U | U | h |
| 5-methylaminomethyl-2-selenouridine | mnm5se2U | 20511U | U | ≅ |
| 5-methylaminomethyl-2-thiouridine | mnm5s2U | 2511U | U | S |
| 5-methylaminomethyluridine | mnm5U | 511U | U | { |
| 5-methylcytidine | m5C | 5C | C | ? |
| 5-methyldihydrouridine | m5D | 58U | U | ρ |
| 5-methyluridine | m5U | 5U | U | T |
| 5-taurinomethyl-2-thiouridine | tm5s2U | 254U | U | ∃ |
| 5-taurinomethyluridine | tm5U | 54U | U | Ê |
| 7-aminocarboxypropyl-demethylwyosine | yW-86 | 47G | G | ¥ |
| 7-aminocarboxypropylwyosine | yW-72 | 347G | G | Ω |
| 7-aminocarboxypropylwyosine methyl ester | yW-58 | 348G | G | ⇑ |
| 7-aminomethyl-7-deazaguanosine | preQ1tRNA | 101G | G | ∉ |
| 7-cyano-7-deazaguanosine | preQ0tRNA | 100G | G | φ |
| 7-methylguanosine | m7G | 7G | G | 7 |
| 8-methyladenosine | m8A | 8A | A | â |
| N2,2’-O-dimethylguanosine | m2Gm | 02G | G | γ |
| N2,7,2’-O-trimethylguanosine | m2,7Gm | 027G | G | æ |
| N2,7-dimethylguanosine | m2,7G | 27G | G | ∨ |
| N2,N2,2’-O-trimethylguanosine | m2,2Gm | 022G | G | | |
| N2,N2,7-trimethylguanosine | m2,2,7G | 227G | G | ∠ |
| N2,N2-dimethylguanosine | m2,2G | 22G | G | R |
| N2-methylguanosine | m2G | 2G | G | L |
| N4,2’-O-dimethylcytidine | m4Cm | 04C | C | λ |
| N4,N4,2’-O-trimethylcytidine | m4,4Cm | 044C | C | β |
| N4,N4-dimethylcytidine | m4,4C | 44C | C | μ |
| N4-acetyl-2’-O-methylcytidine | ac4Cm | 042C | C | ℵ |
| N4-acetylcytidine | ac4C | 42C | C | M |
| N4-methylcytidine | m4C | 4C | C | ν |
| N6,2’-O-dimethyladenosine | m6Am | 06A | A | χ |
| N6,N6,2’-O-trimethyladenosine | m6,6Am | 066A | A | η |
| N6,N6-dimethyladenosine | m6,6A | 66A | A | ζ |
| N6-(cis-hydroxyisopentenyl)adenosine | io6A | 60A | A | ` |
| N6-acetyladenosine | ac6A | 64A | A | ⇓ |
| N6-formyladenosine | f6A | 67A | A | Ϩ |
| N6-glycinylcarbamoyladenosine | g6A | 65A | A | ≡ |
| N6-hydroxymethyladenosine | hm6A | 68A | A | Ϫ |
| N6-hydroxynorvalylcarbamoyladenosine | hn6A | 63A | A | √ |
| N6-isopentenyladenosine | i6A | 61A | A | Θ |
| N6-methyl-N6-threonylcarbamoyladenosine | m6t6A | 662A | A | E |
| N6-methyladenosine | m6A | 6A | A | = |
| N6-threonylcarbamoyladenosine | t6A | 62A | A | 6 |
| agmatidine | C+ | 20C | C | ¿ |
| archaeosine | G+ | 103G | G | ( |
| cyclic N6-threonylcarbamoyladenosine | ct6A | 69A | A | e |
| dihydrouridine | D | 8U | U | D |
| epoxyqueuosine | oQtRNA | 102G | G | ς |
| galactosyl-queuosine | galQtRNA | 104G | G | 9 |
| glutamyl-queuosine | gluQtRNA | 105G | G | ⊄ |
| hydroxy-N6-threonylcarbamoyladenosine | ht6A | 2165A | A | « |
| hydroxywybutosine | OHyW | 34830G | G | ⊆ |
| inosine | I | 9A | A | I |
| isowyosine | imG2 | 42G | G | ⊇ |
| mannosyl-queuosine | manQtRNA | 106G | G | 8 |
| methylated undermodified hydroxywybutosine | OHyWy | 3480G | G | y |
| methylwyosine | mimG | 342G | G | ∑ |
| peroxywybutosine | o2yW | 34832G | G | W |
| pseudouridine | Y | 9U | U | P |
| queuosine | QtRNA | 10G | G | Q |
| undermodified hydroxywybutosine | OHyWx | 3470G | G | š |
| unknown methylated base | Xm | 0X | N | Î |
| unknown modification | xX | X | N | ÷ |
| unknown modified adenosine | xA | ?A | A | H |
| unknown modified cytidine | xC | ?C | C | < |
| unknown modified guanosine | xG | ?G | G | ; |
| unknown modified uridine | xU | ?U | U | Ü |
| uridine 5-oxyacetic acid | cmo5U | 502U | U | V |
| uridine 5-oxyacetic acid methyl ester | mcmo5U | 503U | U | υ |
| wybutosine | yW | 3483G | G | Y |
| wyosine | imG | 34G | G | € |

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

Boccaletto, Pietro, Magdalena A. Machnicka, Elzbieta Purta, Pawel Piatkowski, Blazej Baginski, Tomasz K. Wirecki, Valérie de Crécy-Lagard, et al. 2018. “MODOMICS: A Database of Rna Modification Pathways. 2017 Update.” *Nucleic Acids Research* 46 (D1): D303–D307. <https://doi.org/10.1093/nar/gkx1030>.