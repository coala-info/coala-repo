# An introduction to biodbChebi

Pierrick Roger

#### 29 October 2025

#### Abstract

How to use the biodbChebi connector and its methods.

#### Package

biodbChebi 1.16.0

# 1 Introduction

biodbChebi is a *biodb* extension package that implements a connector to
the [ChEBI](https://www.ebi.ac.uk/chebi/) database (Degtyarenko et al. [2007](#ref-degtyarenko2007_ChEBI); Hastings et al. [2012](#ref-hastings2012_chebi)).

# 2 Installation

Install using Bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install('biodbChebi')
```

# 3 Initialization

The first step in using *biodbChebi*, is to create an instance of the biodb
class `BiodbMain` from the main *biodb* package. This is done by calling the
constructor of the class:

```
mybiodb <- biodb::newInst()
```

During this step the configuration is set up, the cache system is initialized
and extension packages are loaded.

We will see at the end of this vignette that the *biodb* instance needs to be
terminated with a call to the `terminate()` method.

# 4 Creating a connector to ChEBI database

In *biodb* the connection to a database is handled by a connector instance that
you can get from the factory.
biodbChebi implements a connector to a local database, thus when creating an
instance you must provide a URL that points to your database:

```
chebi <- mybiodb$getFactory()$createConn('chebi')
```

```
## Loading required package: biodbChebi
```

# 5 Requesting entries

Using accession numbers, we request entries from ChEBI:

```
entries <- chebi$getEntry(c('2528', '17053', '15440'))
```

# 6 Get entry fields

Getting the values of entry fields are done using `getFieldValue()` method.
Here we retrieve the SMILE field of the first entry from the ChEBI entries
obtained previously:

```
entries[[1]]$getFieldValue('smiles')
```

```
## [1] "CC(C)CC[C@@H](O)[C@](C)(O)[C@H]1CC[C@@]2(O)C3=CC(=O)[C@@H]4C[C@@H](O)[C@@H](O)C[C@]4(C)[C@H]3[C@H](O)C[C@]12C"
```

# 7 Get data frame

We can convert an entry into a data frame:

```
entries[[1]]$getFieldsAsDataframe()
```

```
##   accession charge  formula
## 1      2528      0 C27H44O7
##                                                                                                                                                                                                                      inchi
## 1 InChI=1S/C27H44O7/c1-14(2)6-7-22(32)26(5,33)21-8-9-27(34)16-11-17(28)15-10-18(29)19(30)12-24(15,3)23(16)20(31)13-25(21,27)4/h11,14-15,18-23,29-34H,6-10,12-13H2,1-5H3/t15-,18+,19-,20+,21-,22+,23+,24-,25+,26+,27+/m0/s1
##                      inchikey kegg.compound.id molecular.mass monoisotopic.mass
## 1 LQGNCUXDDPRDJH-UKTRSHMFSA-N           C08811        480.635          480.3087
##             name n.stars
## 1 Ajugasterone C       2
##                                                                                                          smiles
## 1 CC(C)CC[C@@H](O)[C@](C)(O)[C@H]1CC[C@@]2(O)C3=CC(=O)[C@@H]4C[C@@H](O)[C@@H](O)C[C@]4(C)[C@H]3[C@H](O)C[C@]12C
##   chebi.id
## 1     2528
```

Building a data frame for a list of entries is also possible:

```
mybiodb$entriesToDataframe(entries, fields=c('accession', 'formula',
    'molecular.mass', 'inchikey', 'kegg.compound.id'))
```

```
##   accession  formula molecular.mass                    inchikey
## 1      2528 C27H44O7       480.6350 LQGNCUXDDPRDJH-UKTRSHMFSA-N
## 2     17053  C4H7NO4       133.1027 CKLJMWTZIZZHCS-REOHCLBHSA-N
## 3     15440   C30H50       410.7300 YYGNTYWPHWGJRM-AAJYLUCBSA-N
##   kegg.compound.id
## 1           C08811
## 2           C00049
## 3           C00751
```

# 8 Search by name and mass

Searching by name and/or mass is done through the `searchCompound()`.

Searching by name:

```
chebi$searchCompound(name='aspartic', max.results=3)
```

```
## Warning: `searchCompound()` was deprecated in biodb 1.0.0.
## ℹ Please use `searchForEntries()` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## [1] "22660"  "74653"  "136722"
```

Searching by mass:

```
chebi$searchCompound(mass=133, mass.field='molecular.mass', mass.tol=0.3,
    max.results=3)
```

```
## [1] "231506" "30514"  "37130"
```

Searching by name and mass:

```
ids <- chebi$searchCompound(name='aspartic', mass=133,
    mass.field='molecular.mass', mass.tol=0.3, max.results=3)
```

Display results in data frame:

```
mybiodb$entriesToDataframe(chebi$getEntry(ids), fields=c('accession',
    'molecular.mass', 'name'))
```

```
##   accession molecular.mass
## 1     22660       133.1027
## 2     17053       133.1027
## 3     17364       133.1027
##                                                                                                                              name
## 1      aspartic acid;(+-)-Aspartic acid;(R,S)-Aspartic acid;2-aminobutanedioic acid;Asp;D;DL-Aminosuccinic acid;DL-Asparagic acid
## 2 L-aspartic acid;(S)-2-aminobutanedioic acid;(S)-2-aminosuccinic acid;2-Aminosuccinic acid;Asp;ASPARTIC ACID;D;L-Asparaginsaeure
## 3                 D-aspartic acid;(R)-2-aminobutanedioic acid;(R)-2-aminosuccinic acid;aspartic acid D-form;D-Asparaginsaeure;DAS
```

# 9 Convert CAS IDs

Converting CAS IDs to ChEBI IDs:

```
chebi$convCasToChebi(c('87605-72-9', '51-41-2'))
```

```
## [1] "10000" "18357"
```

If more than one ChEBI ID is found for a CAS ID, then a list of character
vectors is returned:

```
chebi$convCasToChebi('14215-68-0')
```

```
## [[1]]
## [1] "40356" "28037"
```

This behaviour can be made the default one by setting `simplify` parameter to
`FALSE`.

# 10 Convert InChI

The method is similar to `convCasToChebi()`.

Converting InChI to ChEBI IDs:

```
chebi$convInchiToChebi('InChI=1S/C8H11NO3/c9-4-8(12)5-1-2-6(10)7(11)3-5/h1-3,8,10-12H,4,9H2/t8-/m0/s1')
```

```
## [1] "18357"
```

You can also use an InChI key:

```
chebi$convInchiToChebi('MBDOYVRWFFCFHM-SNAWJCMRSA-N')
```

```
## [1] "28913"
```

# 11 Closing biodb instance

Do not forget to terminate your biodb instance once you are done with it:

```
mybiodb$terminate()
```

# 12 Session information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] biodbChebi_1.16.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3      sass_0.4.10         bitops_1.0-9
##  [4] RSQLite_2.4.3       stringi_1.8.7       hms_1.1.4
##  [7] digest_0.6.37       magrittr_2.0.4      evaluate_1.0.5
## [10] bookdown_0.45       fastmap_1.2.0       blob_1.2.4
## [13] R.oo_1.27.1         plyr_1.8.9          jsonlite_2.0.0
## [16] R.utils_2.13.0      progress_1.2.3      sqlq_1.0.1
## [19] DBI_1.2.3           BiocManager_1.30.26 XML_3.99-0.19
## [22] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
## [25] chk_0.10.0          crayon_1.5.3        R.methodsS3_1.8.2
## [28] bit64_4.6.0-1       withr_3.0.2         cachem_1.1.0
## [31] yaml_2.3.10         tools_4.5.1         memoise_2.0.1
## [34] biodb_1.18.0        sched_1.0.3         vctrs_0.6.5
## [37] R6_2.6.1            lifecycle_1.0.4     stringr_1.5.2
## [40] bit_4.6.0           pkgconfig_2.0.3     pillar_1.11.1
## [43] bslib_0.9.0         glue_1.8.0          Rcpp_1.1.0
## [46] lgr_0.5.0           xfun_0.53           knitr_1.50
## [49] fscache_1.0.5       htmltools_0.5.8.1   rmarkdown_2.30
## [52] compiler_4.5.1      prettyunits_1.2.0   askpass_1.2.1
## [55] RCurl_1.98-1.17     openssl_2.3.4
```

# References

Degtyarenko, Kirill, Paula de Matos, Marcus Ennis, Janna Hastings, Martin Zbinden, Alan McNaught, Rafael Alcántara, Michael Darsow, Mickaël Guedj, and Michael Ashburner. 2007. “ChEBI: A Database and Ontology for Chemical Entities of Biological Interest.” *Nucleic Acids Research* 36 (suppl\_1): D344–D350. <https://doi.org/10.1093/nar/gkm791>.

Hastings, Janna, Paula de Matos, Adriano Dekker, Marcus Ennis, Bhavana Harsha, Namrata Kale, Venkatesh Muthukrishnan, et al. 2012. “The ChEBI reference database and ontology for biologically relevant chemistry: enhancements for 2013.” *Nucleic Acids Research* 41 (D1): D456–D463. <https://doi.org/10.1093/nar/gks1146>.