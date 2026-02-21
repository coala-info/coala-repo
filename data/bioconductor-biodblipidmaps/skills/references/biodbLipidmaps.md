# An introduction to biodbLipidmaps

Pierrick Roger

#### 28 October 2021

#### Package

biodbLipidmaps 1.0.1

# 1 Introduction

biodbLipidmaps is a *biodb* extension package that implements a connector to
Lipidmaps Structure (Sud et al. 2007).

# 2 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install('biodbLipidmaps')
```

# 3 Initialization

The first step in using *biodbLipidmaps*, is to create an instance of the biodb
class `BiodbMain` from the main *biodb* package. This is done by calling the
constructor of the class:

```
mybiodb <- biodb::newInst()
```

During this step the configuration is set up, the cache system is initialized
and extension packages are loaded.

We will see at the end of this vignette that the *biodb* instance needs to be
terminated with a call to the `terminate()` method.

# 4 Creating a connector to Lipidmaps Structure

In *biodb* connections to databases are handled by connector instances that
you can get from the factory.
Here is the code to instantiate a connector to Lipidmaps Structure database:

```
conn <- mybiodb$getFactory()$createConn('lipidmaps.structure')
```

```
## Loading required package: biodbLipidmaps
```

# 5 Accessing entries

To get the number of entries stored inside the database, run:

```
conn$getNbEntries()
```

```
## [1] NA
```

To get some of the first entry IDs (accession numbers) from the database, run:

```
ids <- conn$getEntryIds(2)
ids
```

```
## [1] "LMFA00000001" "LMFA00000002"
```

To retrieve entries, use:

```
entries <- conn$getEntry(ids)
entries
```

```
## [[1]]
## Biodb LIPID MAPS Structure entry instance LMFA00000001.
##
## [[2]]
## Biodb LIPID MAPS Structure entry instance LMFA00000002.
```

To convert a list of entries into a data frame, run:

```
x <- mybiodb$entriesToDataframe(entries)
```

```
## Loading required package: biodbChebi
```

```
x
```

```
##      accession ncbi.pubchem.comp.id
## 1 LMFA00000001             10930192
## 2 LMFA00000002             42607281
##                                 comp.iupac.name.syst monoisotopic.mass
## 1 2-methoxy-12-methyloctadec-17-en-5-ynoyl anhydride          626.4910
## 2                    N-(3S-hydroxydecanoyl)-L-serine          275.1733
##     formula                                                                name
## 1  C40H66O5 2-methoxy-12-methyloctadec-17-en-5-ynoyl anhydride;Acetylenic acids
## 2 C13H25NO5                                                     Serratamic acid
##   lipidmaps.structure.id chebi.id
## 1           LMFA00000001     <NA>
## 2           LMFA00000002   137783
##                                                                                                                           inchi
## 1                                                                                                                          <NA>
## 2 InChI=1S/C13H25NO5/c1-2-3-4-5-6-7-10(16)8-12(17)14-11(9-15)13(18)19/h10-11,15-16H,2-9H2,1H3,(H,14,17)(H,18,19)/t10-,11-/m0/s1
##                      inchikey molecular.mass
## 1                        <NA>             NA
## 2 NDDJIMSGSZNACM-QWRGUYRKSA-N        275.342
```

# 6 Running the “LMSDSearch” web service

You can access the web service “LMSDSearch” directly with the *wsLmsdSearch*
method:

```
ids <- conn$wsLmsdSearch(mode='ProcessStrSearch', name="fatty", retfmt="ids")
ids
```

```
## [1] "LMFA01010000" "LMFA01140081" "LMFA01140082" "LMFA01140083" "LMFA01140084"
## [6] "LMFA01140085" "LMFA05000000" "LMFA06000000"
```

From this list of identifiers, we can obtain the full entry objects:

```
entries <- conn$getEntry(ids)
```

And then a data frame:

```
entriesDf <- mybiodb$entriesToDataframe(entries)
```

That you can see in table [1](#tab:entriesTable).

Table 1: The entries listed in the result of the search.

| accession | chebi.id | kegg.compound.id | comp.iupac.name.syst | name | lipidmaps.structure.id | inchi | inchikey | molecular.mass | ncbi.pubchem.comp.id | monoisotopic.mass | formula |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| LMFA01010000 | 35366 | C00162 | fatty acid | fatty acid | LMFA01010000 | NA | NA | 45.0174 | NA | NA | NA |
| LMFA01140081 | NA | NA | 2-[5]-ladderane ethanoic acid | 2-[5]-ladderane ethanoic acid;C14-[5]-ladderane fatty acid | LMFA01140081 | NA | NA | NA | 137323820 | 218.1307 | C14H18O2 |
| LMFA01140082 | NA | NA | 2-[3]-ladderane ethanoic acid | 2-[3]-ladderane ethanoic acid;C14-[3]-ladderane fatty acid | LMFA01140082 | NA | NA | NA | 137323821 | 220.1463 | C14H20O2 |
| LMFA01140083 | NA | NA | 8-[1]-ladderane octanoic acid | 8-[1]-ladderane octanoic acid;C20-[1]-ladderane fatty acid | LMFA01140083 | NA | NA | NA | 137323822 | 302.2246 | C20H30O2 |
| LMFA01140084 | NA | NA | 8-[1]-ladderane octanoic acid | 8-[1]-ladderane octanoic acid;C20-[1]-ladderane fatty acid | LMFA01140084 | NA | NA | NA | 137323823 | 304.2402 | C20H32O2 |
| LMFA01140085 | NA | NA | 6-[1]-ladderane hexanoic acid | 6-[1]-ladderane hexanoic acid;C18-[1]-ladderane fatty acid | LMFA01140085 | NA | NA | NA | 137323824 | 274.1933 | C18H26O2 |
| LMFA05000000 | 142622 | NA | NA | Fatty Alcohol | LMFA05000000 | NA | NA | 31.0340 | NA | NA | NA |
| LMFA06000000 | 35746 | NA | NA | Fatty Aldehyde | LMFA06000000 | NA | NA | 29.0180 | NA | NA | NA |

# 7 Closing biodb instance

When done with your *biodb* instance you have to terminate it, in order to
ensure release of resources (file handles, database connection, etc):

```
mybiodb$terminate()
```

```
## INFO  [16:58:26.715] Closing BiodbMain instance...
## INFO  [16:58:26.717] Connector "lipidmaps.structure" deleted.
## INFO  [16:58:26.724] Connector "chebi" deleted.
```

# 8 Session information

```
sessionInfo()
```

```
## R version 4.1.1 (2021-08-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.14-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.14-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] biodbChebi_1.0.1     biodbLipidmaps_1.0.1 BiocStyle_2.22.0
##
## loaded via a namespace (and not attached):
##  [1] progress_1.2.2      tidyselect_1.1.1    xfun_0.27
##  [4] bslib_0.3.1         purrr_0.3.4         vctrs_0.3.8
##  [7] generics_0.1.1      htmltools_0.5.2     BiocFileCache_2.2.0
## [10] yaml_2.2.1          utf8_1.2.2          blob_1.2.2
## [13] XML_3.99-0.8        rlang_0.4.12        jquerylib_0.1.4
## [16] pillar_1.6.4        withr_2.4.2         glue_1.4.2
## [19] DBI_1.1.1           rappdirs_0.3.3      bit64_4.0.5
## [22] dbplyr_2.1.1        lifecycle_1.0.1     plyr_1.8.6
## [25] stringr_1.4.0       memoise_2.0.0       evaluate_0.14
## [28] knitr_1.36          fastmap_1.1.0       curl_4.3.2
## [31] fansi_0.5.0         highr_0.9           biodb_1.2.0
## [34] Rcpp_1.0.7          openssl_1.4.5       filelock_1.0.2
## [37] BiocManager_1.30.16 cachem_1.0.6        jsonlite_1.7.2
## [40] bit_4.0.4           hms_1.1.1           chk_0.7.0
## [43] askpass_1.1         digest_0.6.28       stringi_1.7.5
## [46] bookdown_0.24       dplyr_1.0.7         bitops_1.0-7
## [49] tools_4.1.1         magrittr_2.0.1      sass_0.4.0
## [52] RCurl_1.98-1.5      RSQLite_2.2.8       tibble_3.1.5
## [55] crayon_1.4.1        pkgconfig_2.0.3     ellipsis_0.3.2
## [58] prettyunits_1.1.1   assertthat_0.2.1    rmarkdown_2.11
## [61] httr_1.4.2          lgr_0.4.3           R6_2.5.1
## [64] compiler_4.1.1
```

# References

Sud, Manish, Eoin Fahy, Dawn Cotter, Alex Brown, Edward A. Dennis, Christopher K. Glass, Alfred H. Merrill Jr., et al. 2007. “LMSD: LIPID Maps Structure Database.” *Nucleic Acids Research* 35 (Database issue): D527–D532. <https://doi.org/10.1093/nar/gkl838>.