# Keywords from the UniProt database

#### Zuguang Gu (z.gu@dkfz.de)

#### 2023-09-27

UniProt database provides a list of controlled vocabulary represented as keywords for genes or proteins (<https://www.uniprot.org/keywords/>). This is useful for summarizing gene functions in a compact way. This package provides data of keywords hierarchy and gene-keyword relations.

First load the package:

```
library(UniProtKeywords)
```

First the release and source information of the data:

```
UniProtKeywords
```

```
## UniProt Keywords
##   Release: 2023_04 of 13-Sep-2023
##   Source: https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/docs/keywlist.txt
##   Number of keywords: 1201
##   Built date: 2023-09-23
```

The package has five data objects. The first contains basic information of every keyword term:

```
data(kw_terms)
length(kw_terms)
```

```
## [1] 1201
```

```
kw_terms[["Cell cycle"]]
```

```
## $Identifier
## [1] "Cell cycle"
##
## $Accession
## [1] "KW-0131"
##
## $Description
## [1] "Protein involved in the complex series of events by which the cell duplicates its contents and divides into two. The eukaryotic cell cycle can be divided in four phases termed G1 (first gap period), S (synthesis, phase during which the DNA is replicated), G2 (second gap period) and M (mitosis). The prokaryotic cell cycle typically involves a period of growth followed by DNA replication, partition of chromosomes, formation of septum and division into two similar or identical daughter cells."
##
## $Gene_ontology
## [1] "GO:0007049; cell cycle"
##
## $Hierarchy
## [1] "Biological process: Cell cycle"
##
## $Category
## [1] "Biological process"
```

The other four contain hierarchical structures of the keyword terms:

```
data(kw_parents)
kw_parents[1:2]
```

```
## $`2Fe-2S`
## [1] "Iron-sulfur"   "Metal-binding"
##
## $`3D-structure`
## [1] "Technical term"
```

```
data(kw_children)
kw_children[1:2]
```

```
## $`ATP synthesis`
## [1] "CF(1)"
##
## $`ATP-binding`
## [1] "Helicase"
```

```
data(kw_ancestors)
kw_ancestors[1:2]
```

```
## $`Iron-sulfur`
## [1] "Metal-binding" "Ligand"        "Iron"
##
## $`2Fe-2S`
## [1] "Iron-sulfur"   "Metal-binding" "Ligand"        "Iron"
```

```
data(kw_offspring)
kw_offspring[1:2]
```

```
## $`Iron-sulfur`
## [1] "2Fe-2S" "3Fe-4S" "4Fe-4S"
##
## $`Metal-binding`
## [1] "Iron-sulfur"            "2Fe-2S"                 "3Fe-4S"
## [4] "4Fe-4S"                 "Heme"                   "LIM domain"
## [7] "Metal-thiolate cluster" "Zinc-finger"
```

The **UniProtKeywords** package has also compiled genesets of keywords for some species, which can get by the function `load_keyword_genesets()`. The argument is the taxon ID of a species. The full set of supported organisms can be found in the document of `load_keyword_genesets()`.

```
gl = load_keyword_genesets(9606)
gl[3:4]  # because gl[1:2] has a very long output, here we print gl[3:4]
```

```
## $`3Fe-4S`
## [1] "6390"
##
## $`4Fe-4S`
##  [1] "6059"   "48"     "50"     "54901"  "64428"  "51654"  "57019"  "1663"
##  [9] "1763"   "5424"   "5426"   "1806"   "55140"  "2068"   "2110"   "64789"
## [17] "83990"  "3658"   "11019"  "4337"   "4595"   "4719"   "4720"   "374291"
## [25] "4728"   "4723"   "4682"   "10101"  "5558"   "5471"   "55316"  "91543"
## [33] "51750"  "6390"   "441250" "55253"
```

Argument `as_table` can be set to `TRUE`, then `load_keyword_genesets()` returns a two-column data frame.

```
tb = load_keyword_genesets(9606, as_table = TRUE)
head(tb)
```

```
##   keyword   gene
## 1  2Fe-2S   2230
## 2  2Fe-2S    316
## 3  2Fe-2S  55847
## 4  2Fe-2S 493856
## 5  2Fe-2S 284106
## 6  2Fe-2S  57019
```

To make it more flexible, you can also provide the Latin name or the common name of the species.

```
gl2 = load_keyword_genesets("mouse")
gl2[3:4]
```

```
## $`3Fe-4S`
## [1] "67680"
##
## $`4Fe-4S`
##  [1] "24015"  "11428"  "11429"  "68916"  "67563"  "66971"  "109006" "320209"
##  [9] "327762" "18971"  "18973"  "99586"  "74195"  "13871"  "66841"  "73172"
## [17] "237911" "64602"  "79464"  "56738"  "70603"  "227197" "226646" "75406"
## [25] "225887" "17995"  "18207"  "26425"  "26426"  "19076"  "231327" "19714"
## [33] "237926" "58185"  "269400" "67680"  "100929"
```

We can simply check some statistics.

1. Sizes of keyword genesets:

```
plot(table(sapply(gl, length)), log = "x",
    xlab = "Size of keyword genesets",
    ylab = "Number of keywords"
)
```

![](data:image/png;base64...)

2. Numbers of words in keywords:

```
plot(table(sapply(gregexpr(" |-|/", names(gl)), length)),
    xlab = "Number of words in keywords",
    ylab = "Number of keywords"
)
```

![](data:image/png;base64...)

3. Numbers of characters in keywords:

```
plot(table(nchar(names(gl))),
    xlab = "Number of characters in keywords",
    ylab = "Number of keywords"
)
```

![](data:image/png;base64...)

Session info:

```
sessionInfo()
```

```
## R version 4.3.1 (2023-06-16)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 22.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.18-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
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
## [1] UniProtKeywords_0.99.7
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.33   R6_2.5.1        fastmap_1.1.1   xfun_0.40
##  [5] cachem_1.0.8    knitr_1.44      htmltools_0.5.6 rmarkdown_2.25
##  [9] cli_3.6.1       sass_0.4.7      jquerylib_0.1.4 compiler_4.3.1
## [13] tools_4.3.1     evaluate_0.21   bslib_0.5.1     yaml_2.3.7
## [17] rlang_1.1.1     jsonlite_1.8.7
```