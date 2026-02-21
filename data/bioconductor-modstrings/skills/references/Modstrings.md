# Modstrings

Felix G.M. Ernst & Denis L.J. Lafontaine

#### 2025-10-30

#### Abstract

Classes for DNA and RNA sequences containing modified nucleotides

#### Package

Modstrings 1.26.0

# 1 Introduction

Most nucleic acids, regardless of their being DNA or RNA, contain modified
nucleotides, which enhances the normal function of encoding genetic information.
They have usually a regulatory function and/or modify folding behavior and
molecular interactions.

RNA are nearly always post-transcriptionally modified. Most prominent examples
are of course ribsomal RNA (rRNA) and transfer RNA (tRNA), but in recent years
mRNA was also discovered to be post-transcriptionally modified. In addition,
many small and long non-coding RNAs are also modified.

In many resources, like the tRNAdb (Jühling et al. [2009](#ref-Juehling.2009)) or the modomics database
(Boccaletto et al. [2018](#ref-Boccaletto.2018)), modified nucleotides are repertoried. However in the
Bioconductor context these information were not accessible, since they rely
extensively on special characters in the RNA modification alphabet.

Therefore, the `ModRNAString` class was implemented extending the `BString`
class from the `Biostrings` (H. Pagès, P. Aboyoun, R. Gentleman, and S. DebRoy [2017](#ref-Pages.2017)) package. It can store RNA sequences
containing special characters of the RNA modification alphabet and thus can
store location and identity of modifications. Functions for conversion to a
tabular format are implemented as well.

The implemented classes inherit most of the functions from the parental
`BString` class and it derivatives, which allows them to behave like the
normal `XString` classes within the Bioconductor context. Most of the
functionality is directly inherited and derived from the `Biostrings` package.

Since a DNA modification alphabet also exists, a `ModDNAString` class was
implemented as well. For details on the available letters have a look at the
[RNA modification](ModRNAString-alphabet.html) and
[DNA modification](ModDNAString-alphabet.html alphabet vignettes.

# 2 Creating a `ModRNAString` object

In principle `ModRNAString` and `ModDNAString` objects can be created as any
other `XString` object. However encoding issue will most certainly come into
play, depending on the modification, the operation system and probably the R
version. This is not a problem of how the data is internally used, but how the
letter is transfered from the console to R and back.

```
library(Modstrings)
library(GenomicRanges)
```

```
# This works
mr <- ModRNAString("ACGU7")
# This might work on Linux, but does not on Windows
ModRNAString("ACGU≈")
```

```
## 5-letter ModRNAString object
## seq: ACGU≈
```

```
# This cause a misinterpretation on Windows. Omega gets added as O.
# This modifys the information from yW-72 (7-aminocarboxypropylwyosine) to
# m1I (1-methylinosine)
ModRNAString("ACGUΩ")
```

```
## 5-letter ModRNAString object
## seq: ACGUΩ
```

To eliminate this issue the function `modifyNucleotide()` is implemented,
which can use short names or the nomenclature of a modification to add it at the
desired position.

```
head(shortName(ModRNAString()))
```

```
## [1] "m1Am"    "m1Gm"    "m1Im"    "m1acp3Y" "m1A"     "m1G"
```

```
head(nomenclature(ModRNAString()))
```

```
## [1] "01A"   "01G"   "019A"  "1309U" "1A"    "1G"
```

```
r <- RNAString("ACGUG")
mr2 <- modifyNucleotides(r,5L,"m7G")
mr2
```

```
## 5-letter ModRNAString object
## seq: ACGU7
```

```
mr3 <- modifyNucleotides(r,5L,"7G",nc.type = "nc")
mr3
```

```
## 5-letter ModRNAString object
## seq: ACGU7
```

In addition, one can also use the `alphabet()` function and subset to the
desired modifications.

```
mr4 <- ModRNAString(paste0("ACGU",alphabet(ModRNAString())[33L]))
mr4
```

```
## 5-letter ModRNAString object
## seq: ACGUB
```

# 3 Streamlining object creation and modification

To offer a more streamlined functionality, which can take more information as
input, the function `combineIntoModstrings()` is implemented. It takes a
`XString` object and a `GRanges` object with a `mod` column and returns a
`ModString` object. The information in the `mod` column must match the short
name or nomenclature of the particular modification of interest as returned by
the `shortName()` or `nomenclature()` functions as seen above.

```
gr <- GRanges("1:5", mod = "m7G")
mr5 <- combineIntoModstrings(r, gr)
mr5
```

```
## 5-letter ModRNAString object
## seq: ACGU7
```

`combineIntoModstrings()` is also implemented for `ModStringSet` objects.

```
rs <- RNAStringSet(list(r,r,r,r,r))
names(rs) <- paste0("Sequence", seq_along(rs))
gr2 <- GRanges(seqnames = names(rs)[c(1L,1L,2L,3L,3L,4L,5L,5L)],
               ranges = IRanges(start = c(4L,5L,5L,4L,5L,5L,4L,5L),
                                width = 1L),
               mod = c("D","m7G","m7G","D","m7G","m7G","D","m7G"))
gr2
```

```
## GRanges object with 8 ranges and 1 metadata column:
##        seqnames    ranges strand |         mod
##           <Rle> <IRanges>  <Rle> | <character>
##   [1] Sequence1         4      * |           D
##   [2] Sequence1         5      * |         m7G
##   [3] Sequence2         5      * |         m7G
##   [4] Sequence3         4      * |           D
##   [5] Sequence3         5      * |         m7G
##   [6] Sequence4         5      * |         m7G
##   [7] Sequence5         4      * |           D
##   [8] Sequence5         5      * |         m7G
##   -------
##   seqinfo: 5 sequences from an unspecified genome; no seqlengths
```

```
mrs <- combineIntoModstrings(rs, gr2)
mrs
```

```
##   A ModRNAStringSet instance of length 5
##     width seq                                               names
## [1]     5 ACGD7                                             Sequence1
## [2]     5 ACGU7                                             Sequence2
## [3]     5 ACGD7                                             Sequence3
## [4]     5 ACGU7                                             Sequence4
## [5]     5 ACGD7                                             Sequence5
```

The reverse operation is also available via the function `separate()`, which
allows the positions of modifications to be transfered into a tabular format.

```
gr3 <- separate(mrs)
rs2 <- RNAStringSet(mrs)
gr3
```

```
## GRanges object with 8 ranges and 1 metadata column:
##        seqnames    ranges strand |         mod
##           <Rle> <IRanges>  <Rle> | <character>
##   [1] Sequence1         4      + |           D
##   [2] Sequence1         5      + |         m7G
##   [3] Sequence2         5      + |         m7G
##   [4] Sequence3         4      + |           D
##   [5] Sequence3         5      + |         m7G
##   [6] Sequence4         5      + |         m7G
##   [7] Sequence5         4      + |           D
##   [8] Sequence5         5      + |         m7G
##   -------
##   seqinfo: 5 sequences from an unspecified genome; no seqlengths
```

```
rs2
```

```
## RNAStringSet object of length 5:
##     width seq                                               names
## [1]     5 ACGUG                                             Sequence1
## [2]     5 ACGUG                                             Sequence2
## [3]     5 ACGUG                                             Sequence3
## [4]     5 ACGUG                                             Sequence4
## [5]     5 ACGUG                                             Sequence5
```

`modifyNucleotides()` and therefore also `combineIntoModstrings()` requires,
that the nucleotides to be modified match the originating base for the
modification. The next chunk fails, since the originating base for m7G is of
course G.

```
modifyNucleotides(r,4L,"m7G")
```

```
## Error: Modification type does not match the originating base:
##  U != G  for  m7G
```

Calls for both functions check the sanity for this operation, so that the next
bit is always `TRUE`.

```
r <- RNAString("ACGUG")
mr2 <- modifyNucleotides(r,5L,"m7G")
r == RNAString(mr2)
```

```
## [1] TRUE
```

# 4 Comparing `ModString` objects

`ModString` objects can be directly compared to `RNAString` or `DNAString`
objects depending on the type (`ModRNA` to `RNA` and `ModDNA` to `DNA`).

```
r == ModRNAString(r)
```

```
## [1] TRUE
```

```
r == mr
```

```
## [1] FALSE
```

```
rs == ModRNAStringSet(rs)
```

```
## [1] TRUE TRUE TRUE TRUE TRUE
```

```
rs == c(mrs[1L:3L],rs[4L:5L])
```

```
## [1] FALSE FALSE FALSE  TRUE  TRUE
```

# 5 Conversion of `ModString` objects

`ModString` objects can be converted into each other. However any conversion
will remove any information on modifications and revert each nucleotide back to
its originating nucleotide.

```
RNAString(mr)
```

```
## 5-letter RNAString object
## seq: ACGUG
```

# 6 Quality scaled `ModString`

Quality information can be encoded alongside `ModString` objects by combining it
with a `XStringQuality` object inside a `QualityScaledModStringSet` object. Two
class are implemented: `QualityScaledModRNAStringSet` and
`QualityScaledModDNAStringSet`. They are usable as expected from a
`QualityScaledXStringSet` object.

```
qmrs <- QualityScaledModRNAStringSet(mrs,
                                     PhredQuality(c("!!!!h","!!!!h","!!!!h",
                                                    "!!!!h","!!!!h")))
qmrs
```

```
##   A QualityScaledModRNAStringSet instance containing:
##
##   A ModRNAStringSet instance of length 5
##     width seq                                               names
## [1]     5 ACGD7                                             Sequence1
## [2]     5 ACGU7                                             Sequence2
## [3]     5 ACGD7                                             Sequence3
## [4]     5 ACGU7                                             Sequence4
## [5]     5 ACGD7                                             Sequence5
##
## PhredQuality object of length 5:
##     width seq
## [1]     5 !!!!h
## [2]     5 !!!!h
## [3]     5 !!!!h
## [4]     5 !!!!h
## [5]     5 !!!!h
```

They can also be constructed/deconstructed using the functions
`combineIntoModstrings()` and `separate()` and use an additional metadata column
named `quality`. For quality information to persist during construction, set the
argument `with.qualities = TRUE`. If a `QualityScaledModStringSet` is used as an
input to separate, the quality information are returned in the `quality column`.
We choose to avoid clashes with the `score` column and not to recycle it.

```
qgr <- separate(qmrs)
qgr
```

```
## GRanges object with 8 ranges and 2 metadata columns:
##        seqnames    ranges strand |         mod   quality
##           <Rle> <IRanges>  <Rle> | <character> <integer>
##   [1] Sequence1         4      + |           D        71
##   [2] Sequence1         5      + |         m7G         0
##   [3] Sequence2         5      + |         m7G        71
##   [4] Sequence3         4      + |           D         0
##   [5] Sequence3         5      + |         m7G        71
##   [6] Sequence4         5      + |         m7G         0
##   [7] Sequence5         4      + |           D        71
##   [8] Sequence5         5      + |         m7G        71
##   -------
##   seqinfo: 5 sequences from an unspecified genome; no seqlengths
```

```
combineIntoModstrings(mrs,qgr, with.qualities = TRUE)
```

```
##   A QualityScaledModRNAStringSet instance containing:
##
##   A ModRNAStringSet instance of length 5
##     width seq                                               names
## [1]     5 ACGD7                                             Sequence1
## [2]     5 ACGU7                                             Sequence2
## [3]     5 ACGD7                                             Sequence3
## [4]     5 ACGU7                                             Sequence4
## [5]     5 ACGD7                                             Sequence5
##
## PhredQuality object of length 5:
##     width seq
## [1]     5 !!!h!
## [2]     5 !!!!h
## [3]     5 !!!!h
## [4]     5 !!!!!
## [5]     5 !!!hh
```

# 7 Saving and reading `ModString` objects to/from file

The nucleotide sequences with modifications can be saved to a `fasta` or
`fastq` file using the functions `writeModStringSet()`. Reading of these files
is achieved using `readModRNAStringSet()` or `readModDNAStringSet()`. In case of
`fastq` files, the sequences can be automatically read as a
`QualityScaledModRNAStringSet` using `readQualityScaledModRNAStringSet()`
function.

```
writeModStringSet(mrs, file = "test.fasta")
# note the different function name. Otherwise empty qualities will be written
writeQualityScaledModStringSet(qmrs, file = "test.fastq")
mrs2 <- readModRNAStringSet("test.fasta", format = "fasta")
mrs2
```

```
##   A ModRNAStringSet instance of length 5
##     width seq                                               names
## [1]     5 ACGD7                                             Sequence1
## [2]     5 ACGU7                                             Sequence2
## [3]     5 ACGD7                                             Sequence3
## [4]     5 ACGU7                                             Sequence4
## [5]     5 ACGD7                                             Sequence5
```

```
qmrs2 <- readQualityScaledModRNAStringSet("test.fastq")
qmrs2
```

```
##   A QualityScaledModRNAStringSet instance containing:
##
##   A ModRNAStringSet instance of length 5
##     width seq                                               names
## [1]     5 ACGD7                                             Sequence1
## [2]     5 ACGU7                                             Sequence2
## [3]     5 ACGD7                                             Sequence3
## [4]     5 ACGU7                                             Sequence4
## [5]     5 ACGD7                                             Sequence5
##
## PhredQuality object of length 5:
##     width seq
## [1]     5 !!!!h
## [2]     5 !!!!h
## [3]     5 !!!!h
## [4]     5 !!!!h
## [5]     5 !!!!h
```

Since these functions are specifically designed to work with the modified
nucleotides within the sequence, they are slower than the analogous functions
from the `Biostrings` package. This is the result of a purely R based
implementation, whereas `Biostrings` functions are spead up through a C
backend. This is a potential improvement for future developments, but
currently special sequence files are limited, so it is not a priority.

# 8 Pattern matching

Pattern matching is implemented as well as expected for `XString` objects.

```
matchPattern("U7",mr)
```

```
## Views on a 5-letter ModRNAString subject
## subject: ACGU7
## views:
##       start end width
##   [1]     4   5     2 [U7]
```

```
vmatchPattern("D7",mrs)
```

```
## MIndex object of length 5
## $Sequence1
## IRanges object with 1 range and 0 metadata columns:
##           start       end     width
##       <integer> <integer> <integer>
##   [1]         4         5         2
##
## $Sequence2
## IRanges object with 0 ranges and 0 metadata columns:
##        start       end     width
##    <integer> <integer> <integer>
##
## $Sequence3
## IRanges object with 1 range and 0 metadata columns:
##           start       end     width
##       <integer> <integer> <integer>
##   [1]         4         5         2
##
## $Sequence4
## IRanges object with 0 ranges and 0 metadata columns:
##        start       end     width
##    <integer> <integer> <integer>
##
## $Sequence5
## IRanges object with 1 range and 0 metadata columns:
##           start       end     width
##       <integer> <integer> <integer>
##   [1]         4         5         2
```

```
mrl <- unlist(mrs)
matchLRPatterns("7ACGU","U7ACG",100L,mrl)
```

```
## Views on a 25-letter ModRNAString subject
## subject: ACGD7ACGU7ACGD7ACGU7ACGD7
## views:
##       start end width
##   [1]     5  23    19 [7ACGU7ACGD7ACGU7ACG]
```

# 9 Future development

In principle post-translational modifications of proteins could also be
implemented. However, a one letter alphabet of post-translational modifications
must be developed first. If you are already aware of such an alphabet and want
to use it in a Bioconductor context, let us know.

# 10 Import example

This is a quick example showing how sequence information containing modified
nucleotides can be imported into an R session using the `Modstrings` package.
The file needs to be UTF-8 encoded.

```
# read the lines
test <- readLines(system.file("extdata","test.fasta",package = "Modstrings"),
                      encoding = "UTF-8")
head(test,2L)
```

```
## [1] "> tRNA | Ala | AGC | Saccharomyces cerevisiae | cytosolic"
## [2] "-GGGCGUGUKGCGUAGDC-GGD--AGCGCRCUCCCUUIGCOPGGGAGAG-------------------GDCUCCGGTPCGAUUCCGGACUCGUCCACCA"
```

```
# keep every second line as sequence, the other one as name
names <- test[seq.int(from = 1L, to = 104L, by = 2L)]
seq <- test[seq.int(from = 2L, to = 104L, by = 2L)]
# sanitize input. This needs to be adapt to the individual case
names <- gsub(" ","_",
              gsub("> ","",
                   gsub(" \\| ","-",
                        names)))
seq <- gsub("-","",gsub("_","",seq))
names(seq) <- names
```

```
# sanitize special characters to Modstrings equivalent
seq <- sanitizeFromModomics(seq)
seq <- ModRNAStringSet(seq)
seq
```

```
##   A ModRNAStringSet instance of length 52
##      width seq                                              names
##  [1]    76 GGGCGUGUKGCGUAGDCGGDAGC...PCGAUUCCGGACUCGUCCACCA tRNA-Ala-AGC-Saccha...
##  [2]    75 GCUCGCGUKLCGUAADGGCAACG...PCG"CCCCCAUCGUGAGUGCCA tRNA-Arg-UCU-Saccha...
##  [3]    76 PUCCUCGUKLCCCAADGGDCACG...PCA"GUCCUGGCGGGGAAGCCA tRNA-Arg-ICG-Saccha...
##  [4]    77 GACUCCAUGLCCAAGDDGGDDAA...PCA"CCCUCACUGGGGUCGCCA tRNA-Asn-GUU-Saccha...
##  [5]    75 UCCGUGAUAGUUPAADGGDCAGA...PCAAUUCCCCGUCGCGGAGCCA tRNA-Asp-GUC-Saccha...
##  ...   ... ...
## [48]    76 GCUCUCUUAGCUUAADGGDUAAA...PCAAAUCAUGGAGAGAGUACCA tRNA-Arg-NCU-Saccha...
## [49]    90 GGAUGGUUGACUGAGDGGDUUAA...PCAAAUCCUACAUCAUCCGCCA tRNA-Ser-UGA-Saccha...
## [50]    90 GGAUGGUUGACUGAGDGGDUUAA...PCAAAUCCUACAUCAUCCGCCA tRNA-Ser-UGA-Saccha...
## [51]    73 GUAAAUAUAAUUUAADGGDAAAA...PCAAAUCUUAGUAUUUACACCA tRNA-Thr-UAG-Saccha...
## [52]    74 AAGGAUAUAGUUUAADGGDAAAA...PCGAAUCUCUUUAUCCUUGCCA tRNA-Trp-!CA-Saccha...
```

```
# convert the contained modifications into a tabular format
separate(seq)
```

```
## GRanges object with 567 ranges and 1 metadata column:
##                       seqnames    ranges strand |         mod
##                          <Rle> <IRanges>  <Rle> | <character>
##     [1] tRNA-Ala-AGC-Sacchar..         9      + |         m1G
##     [2] tRNA-Ala-AGC-Sacchar..        16      + |           D
##     [3] tRNA-Ala-AGC-Sacchar..        20      + |           D
##     [4] tRNA-Ala-AGC-Sacchar..        26      + |       m2,2G
##     [5] tRNA-Ala-AGC-Sacchar..        34      + |           I
##     ...                    ...       ...    ... .         ...
##   [563] tRNA-Trp-!CA-Sacchar..        33      + |      cmnm5U
##   [564] tRNA-Trp-!CA-Sacchar..        36      + |          xA
##   [565] tRNA-Trp-!CA-Sacchar..        38      + |           Y
##   [566] tRNA-Trp-!CA-Sacchar..        52      + |         m5U
##   [567] tRNA-Trp-!CA-Sacchar..        53      + |           Y
##   -------
##   seqinfo: 47 sequences from an unspecified genome; no seqlengths
```

# 11 Sessioninfo

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
##  [1] GenomicRanges_1.62.0 Modstrings_1.26.0    Biostrings_2.78.0
##  [4] Seqinfo_1.0.0        XVector_0.50.0       IRanges_2.44.0
##  [7] S4Vectors_0.48.0     BiocGenerics_0.56.0  generics_0.1.4
## [10] BiocStyle_2.38.0
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

Boccaletto, Pietro, Magdalena A. Machnicka, Elzbieta Purta, Pawel Piatkowski, Blazej Baginski, Tomasz K. Wirecki, Valérie de Crécy-Lagard, et al. 2018. “MODOMICS: A Database of Rna Modification Pathways. 2017 Update.” *Nucleic Acids Research* 46 (D1): D303–D307. <https://doi.org/10.1093/nar/gkx1030>.

H. Pagès, P. Aboyoun, R. Gentleman, and S. DebRoy. 2017. “Biostrings.” Bioconductor. <https://doi.org/10.18129/B9.bioc.Biostrings>.

Jühling, Frank, Mario Mörl, Roland K. Hartmann, Mathias Sprinzl, Peter F. Stadler, and Joern Pütz. 2009. “TRNAdb 2009: Compilation of tRNA Sequences and tRNA Genes.” *Nucleic Acids Research* 37: D159–D162. <https://doi.org/10.1093/nar/gkn772>.