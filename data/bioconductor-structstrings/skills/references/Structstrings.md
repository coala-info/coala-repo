# Structstrings

Felix G.M. Ernst

#### 2025-10-30

#### Abstract

Classes for RNA sequences with secondary structure informations

#### Package

Structstrings 1.26.0

# 1 Introduction

The `Structstrings` package implements the widely used dot bracket annotation
to store base pairing information in structured RNA. For example it is used
in the ViennaRNA package (Lorenz et al. [2011](#ref-Lorenz.2011)), the tRNAscan-SE software (Lowe and Eddy [1997](#ref-Lowe.1997))
and the tRNAdb (Jühling et al. [2009](#ref-Juhling.2009)).

`Structstrings` uses the infrastructure provided by the
[Biostrings](#References) package (H. Pagès, P. Aboyoun, R. Gentleman, and S. DebRoy, [n.d.](#ref-Pages)) and derives the class
`DotBracketString` and related classes from the `BString` class. From these base
pair tables can be produced for in depth analysis, for which the
`DotBracketDataFrame` class is derived from the `DataFrame` class. In addition,
the loop indices of the base pairs can be retrieved as a `LoopIndexList`, a
derivate if the `IntegerList` class. Generally, all classes check automatically
for the validity of the base pairing information.

The conversion of the `DotBracketString` to the base pair table and the loop
indices is implemented in C for efficiency. The C implementation to a large
extent inspired by the [ViennaRNA](https://www.tbi.univie.ac.at/RNA/) package.

This package was developed as an improvement for the `tRNA` package. However,
other projects might benefit as well, so it was split of and improved upon.

# 2 Creating and accessing structure information

The package is installed from Bioconductor and loaded.

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Structstrings")
library(Structstrings)
```

`DotBracketString` objects can be created from character as any other `XString`.
The validity of the structure information is checked upon creation or
modification of the object.

```
# Hairpin with 4 base pairs
dbs <- DotBracketString("((((....))))")
dbs
```

```
## 12-letter DotBracketString object
## seq: ((((....))))
```

```
# a StringSet with four hairpin structures, which are all equivalent
dbs <- DotBracketStringSet(c("((((....))))",
                             "<<<<....>>>>",
                             "[[[[....]]]]",
                             "{{{{....}}}}"))
dbs
```

```
## DotBracketStringSet object of length 4:
##     width seq
## [1]    12 ((((....))))
## [2]    12 <<<<....>>>>
## [3]    12 [[[[....]]]]
## [4]    12 {{{{....}}}}
```

```
# StringSetList for storing even more structure annotations
dbsl <- DotBracketStringSetList(dbs,rev(dbs))
dbsl
```

```
## DotBracketStringSetList of length 2
## [[1]] ((((....)))) <<<<....>>>> [[[[....]]]] {{{{....}}}}
## [[2]] {{{{....}}}} [[[[....]]]] <<<<....>>>> ((((....))))
```

```
# invalid structure
DotBracketString("((((....)))")
```

```
## Error in validObject(from): invalid class "DotBracketString" object:
## Following structures are invalid:
## '1'.
## They contain unmatched positions.
```

Annotations can be converted using the `convertAnnotation` function.

```
dbs[[2L]] <- convertAnnotation(dbs[[2L]],from = 2L, to = 1L)
dbs[[3L]] <- convertAnnotation(dbs[[3L]],from = 3L, to = 1L)
dbs[[4L]] <- convertAnnotation(dbs[[4L]],from = 4L, to = 1L)
# Note: convertAnnotation checks for presence of annotation and stops
# if there is any conflict.
dbs
```

```
## DotBracketStringSet object of length 4:
##     width seq
## [1]    12 ((((....))))
## [2]    12 ((((....))))
## [3]    12 ((((....))))
## [4]    12 ((((....))))
```

The dot bracket annotation can be turned into a base pairing table, which allows
the base pairing information to be queried more easily. For example, the `tRNA`
package makes uses this to identify the structural elements for tRNAs.

For this purpose the class `DotBracketDataFrame` is derived from `DataFrame`.
This special `DataFrame` can only contain 5 columns, `pos`, `forward`, `reverse`
`character`, `base`. The first three are obligatory, whereas the last two are
optional.

```
# base pairing table
dbdfl <- getBasePairing(dbs)
dbdfl[[1L]]
```

```
## DotBracketDataFrame with 12 rows and 4 columns
##           pos   forward   reverse   character
##     <integer> <integer> <integer> <character>
## 1           1         1        12           (
## 2           2         2        11           (
## 3           3         3        10           (
## 4           4         4         9           (
## 5           5         0         0           .
## ...       ...       ...       ...         ...
## 8           8         0         0           .
## 9           9         9         4           )
## 10         10        10         3           )
## 11         11        11         2           )
## 12         12        12         1           )
```

The types of each column are also fixed as shown in the example above. The fifth
column not shown above must be an `XStringSet` object.

Additionally, loop indices can be generated for the individual annotation types.
These information can also be used to distinguish structure elements.

```
loopids <- getLoopIndices(dbs, bracket.type = 1L)
loopids[[1L]]
```

```
##  [1] 1 2 3 4 4 4 4 4 4 3 2 1
```

```
# can also be constructed from DotBracketDataFrame and contains the same
# information
loopids2 <- getLoopIndices(dbdfl, bracket.type = 1L)
all(loopids == loopids2)
```

```
##
## TRUE TRUE TRUE TRUE
```

# 3 Creating a dot bracket annotation from base pairing information

The dot bracket annotation can be recreated from a `DotBracketDataFrame` object
with the function `getDotBracket()`. If the `character` column is present, this
informations is just concatenated and used to create a `DotBracketString`. If
it is not present or `force.bracket` is set to `TRUE`, the dot bracket string
is created from the base pairing information.

```
rec_dbs <- getDotBracket(dbdfl)
dbdf <- unlist(dbdfl)
dbdf$character <- NULL
dbdfl2 <- relist(dbdf,dbdfl)
# even if the character column is not set, the dot bracket string can be created
rec_dbs2 <- getDotBracket(dbdfl2)
rec_dbs3 <- getDotBracket(dbdfl, force = TRUE)
rec_dbs[[1L]]
```

```
## 12-letter DotBracketString object
## seq: ((((....))))
```

```
rec_dbs2[[1L]]
```

```
## 12-letter DotBracketString object
## seq: ((((....))))
```

```
rec_dbs3[[1L]]
```

```
## 12-letter DotBracketString object
## seq: ((((....))))
```

Please be aware that `getDotBracket()` might return a different output than
original input, if this information is turned around from a `DotBracketString`
to `DotBracketDataFrame` and back to a `DotBracketString`. First the `()`
annotation is used followed by `<>`, `[]` and `{}` in this order.

For a `DotBracketString` containing only one type of annotation this might not
mean much, except if the `character` string itself is evaluated. However,
if pseudoloops are present, this will lead potentially to a reformated and
simplified annotation.

```
db <- DotBracketString("((((....[[[))))....((((....<<<<...))))]]]....>>>>...")
db
```

```
## 52-letter DotBracketString object
## seq: ((((....[[[))))....((((....<<<<...))))]]]....>>>>...
```

```
getDotBracket(getBasePairing(db), force = TRUE)
```

```
## 52-letter DotBracketString object
## seq: ((((....<<<))))....<<<<....[[[[...>>>>>>>....]]]]...
```

# 4 Storing sequence and structure in one object

To store a nucleotide sequence and a structure in one object, the classes
`StructuredRNAStringSet` are implemented.

```
data("dbs", package = "Structstrings")
data("nseq", package = "Structstrings")
sdbs <- StructuredRNAStringSet(nseq,dbs)
sdbs[1L]
```

```
##   A StructuredRNAStringSet instance containing:
##
## RNAStringSet object of length 1:
##     width seq                                               names
## [1]    72 GGGCGUGUGGUCUAGUGGUAUGA...GGGUUCAAUUCCCAGCUCGCCCC Sequence 1
##
## DotBracketStringSet object of length 1:
##     width seq                                               names
## [1]    72 (((((.(..(((.........))...(((.......)))))).))))). Sequence 1
```

```
# subsetting to element returns the sequence
sdbs[[1L]]
```

```
## 72-letter RNAString object
## seq: GGGCGUGUGGUCUAGUGGUAUGAUUCUCGCUUUGGGUGCGAGAGGCCCUGGGUUCAAUUCCCAGCUCGCCCC
```

```
# dotbracket() gives access to the DotBracketStringSet
dotbracket(sdbs)[[1L]]
```

```
## 72-letter DotBracketString object
## seq: (((((.(..(((.........))).(((((.......))))).....(((((.......)))))).))))).
```

The base pair table can be directly accessed using `getBasePairing()`. The
`base` column is automatically populated from the nucleotide sequence. This is a
bit slower than just creating the base pair table. Therefore this step can be
omitted by setting `return.sequence` to `FALSE`.

```
dbdfl <- getBasePairing(sdbs)
dbdfl[[1L]]
```

```
## DotBracketDataFrame with 72 rows and 4 columns
##           pos   forward   reverse   character
##     <integer> <integer> <integer> <character>
## 1           1         1        71           (
## 2           2         2        70           (
## 3           3         3        69           (
## 4           4         4        68           (
## 5           5         5        67           (
## ...       ...       ...       ...         ...
## 68         68        68         4           )
## 69         69        69         3           )
## 70         70        70         2           )
## 71         71        71         1           )
## 72         72         0         0           .
```

```
# returns the result without sequence information
dbdfl <- getBasePairing(sdbs, return.sequence = TRUE)
dbdfl[[1L]]
```

```
## DotBracketDataFrame with 72 rows and 5 columns
##           pos   forward   reverse   character           base
##     <integer> <integer> <integer> <character> <RNAStringSet>
## 1           1         1        71           (              G
## 2           2         2        70           (              G
## 3           3         3        69           (              G
## 4           4         4        68           (              C
## 5           5         5        67           (              G
## ...       ...       ...       ...         ...            ...
## 68         68        68         4           )              G
## 69         69        69         3           )              C
## 70         70        70         2           )              C
## 71         71        71         1           )              C
## 72         72         0         0           .              C
```

# 5 Session info

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
## [1] Structstrings_1.26.0 Biostrings_2.78.0    Seqinfo_1.0.0
## [4] XVector_0.50.0       IRanges_2.44.0       S4Vectors_0.48.0
## [7] BiocGenerics_0.56.0  generics_0.1.4       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5         crayon_1.5.3        cli_3.6.5
##  [4] knitr_1.50          rlang_1.1.6         xfun_0.53
##  [7] stringi_1.8.7       jsonlite_2.0.0      glue_1.8.0
## [10] htmltools_0.5.8.1   sass_0.4.10         rmarkdown_2.30
## [13] evaluate_1.0.5      jquerylib_0.1.4     fastmap_1.2.0
## [16] yaml_2.3.10         lifecycle_1.0.4     bookdown_0.45
## [19] stringr_1.5.2       BiocManager_1.30.26 compiler_4.5.1
## [22] digest_0.6.37       R6_2.6.1            magrittr_2.0.4
## [25] bslib_0.9.0         tools_4.5.1         cachem_1.1.0
```

# References

H. Pagès, P. Aboyoun, R. Gentleman, and S. DebRoy. n.d. “Biostrings.” Bioconductor. <https://doi.org/10.18129/B9.bioc.Biostrings>.

Jühling, Frank, Mario Mörl, Roland K. Hartmann, Mathias Sprinzl, Peter F. Stadler, and Joern Pütz. 2009. “TRNAdb 2009: Compilation of tRNA Sequences and tRNA Genes.” *Nucleic Acids Research* 37 (Database issue): D159–62. <https://doi.org/10.1093/nar/gkn772>.

Lorenz, Ronny, Stephan H. Bernhart, Christian Höner Zu Siederdissen, Hakim Tafer, Christoph Flamm, Peter F. Stadler, and Ivo L. Hofacker. 2011. “ViennaRNA Package 2.0.” *Algorithms for Molecular Biology : AMB* 6: 26. <https://doi.org/10.1186/1748-7188-6-26>.

Lowe, T. M., and S. R. Eddy. 1997. “TRNAscan-Se: A Program for Improved Detection of Transfer Rna Genes in Genomic Sequence.” *Nucleic Acids Research* 25 (5): 955–64.