# In-silico cleavage of polypeptides using the cleaver package

Sebastian Gibb1

1Department of Anesthesiology and Intensive Care, University Medicine Greifswald, Germany.

#### 29 October 2025

#### Abstract

This vignette describes the in-silico cleavage of polypeptides using the `cleaver` package.

#### Package

cleaver 1.48.0

# 1 Introduction

Most proteomics experiments need protein (peptide) separation and cleavage
procedures before these molecules could be analyzed or identified
by mass spectrometry or other analytical tools.

*[cleaver](https://bioconductor.org/packages/3.22/cleaver)* allows in-silico cleavage of polypeptide
sequences to e.g. create theoretical mass spectrometry data.

The cleavage rules are taken from the
[ExPASy PeptideCutter tool](https://web.expasy.org/peptide_cutter/peptidecutter_enzymes.html)
(Gasteiger et al. [2005](#ref-peptidecutter)).

# 2 Simple Usage

Loading the *[cleaver](https://bioconductor.org/packages/3.22/cleaver)* package:

```
library("cleaver")
```

Getting help and list all available cleavage rules:

```
help("cleave")
```

Cleaving of *Gastric juice peptide 1 (P01358)* using *Trypsin*:

```
## cleave it
cleave("LAAGKVEDSD", enzym="trypsin")
```

```
## $LAAGKVEDSD
## [1] "LAAGK" "VEDSD"
```

```
## get the cleavage ranges
cleavageRanges("LAAGKVEDSD", enzym="trypsin")
```

```
## $LAAGKVEDSD
##      start end
## [1,]     1   5
## [2,]     6  10
```

```
## get only cleavage sites
cleavageSites("LAAGKVEDSD", enzym="trypsin")
```

```
## $LAAGKVEDSD
## [1] 5
```

Sometimes cleavage is not perfect and the enzym miss some cleavage positions:

```
## miss one cleavage position
cleave("LAAGKVEDSD", enzym="trypsin", missedCleavages=1)
```

```
## $LAAGKVEDSD
## [1] "LAAGKVEDSD"
```

```
cleavageRanges("LAAGKVEDSD", enzym="trypsin", missedCleavages=1)
```

```
## $LAAGKVEDSD
##      start end
## [1,]     1  10
```

```
## miss zero or one cleavage positions
cleave("LAAGKVEDSD", enzym="trypsin", missedCleavages=0:1)
```

```
## $LAAGKVEDSD
## [1] "LAAGK"      "VEDSD"      "LAAGKVEDSD"
```

```
cleavageRanges("LAAGKVEDSD", enzym="trypsin", missedCleavages=0:1)
```

```
## $LAAGKVEDSD
##      start end
## [1,]     1   5
## [2,]     6  10
## [3,]     1  10
```

Combine *[cleaver](https://bioconductor.org/packages/3.22/cleaver)* and
*[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)* (Pages et al., [n.d.](#ref-Biostrings)):

```
## create AAStringSet object
p <- AAStringSet(c(gaju="LAAGKVEDSD", pnm="AGEPKLDAGV"))

## cleave it
cleave(p, enzym="trypsin")
```

```
## AAStringSetList of length 2
## [["gaju"]] LAAGK VEDSD
## [["pnm"]] AGEPK LDAGV
```

```
cleavageRanges(p, enzym="trypsin")
```

```
## IRangesList object of length 2:
## $gaju
## IRanges object with 2 ranges and 0 metadata columns:
##           start       end     width
##       <integer> <integer> <integer>
##   [1]         1         5         5
##   [2]         6        10         5
##
## $pnm
## IRanges object with 2 ranges and 0 metadata columns:
##           start       end     width
##       <integer> <integer> <integer>
##   [1]         1         5         5
##   [2]         6        10         5
```

```
cleavageSites(p, enzym="trypsin")
```

```
## $gaju
## [1] 5
##
## $pnm
## [1] 5
```

# 3 Insulin & Somatostatin Example

Downloading *Insulin (P01308)* and *Somatostatin (P61278)* sequences
from the [UniProt](http://www.uniprot.org) (The UniProt Consortium [2012](#ref-uniprot)) database using
*[UniProt.ws](https://bioconductor.org/packages/3.22/UniProt.ws)* (Carlson, [n.d.](#ref-UniProt.ws)).

```
## load UniProt.ws library
library("UniProt.ws")

## select species Homo sapiens
up <- UniProt.ws(taxId=9606)

## download sequences of Insulin/Somatostatin
s <- select(up,
    keys=c("P01308", "P61278"),
    columns=c("sequence"),
    keytype="UniProtKB"
)

## fetch only sequences
sequences <- setNames(s$Sequence, s$Entry)

## remove whitespaces
sequences <- gsub(pattern="[[:space:]]", replacement="", x=sequences)
```

Cleaving using *Pepsin*:

```
cleave(sequences, enzym="pepsin")
```

```
## $P01308
##  [1] "MA"              "L"               "W"               "MRLLP"
##  [5] "LL"              "A"               "WGPDPAAA"        "F"
##  [9] "VNQH"            "CGSH"            "VEA"             "Y"
## [13] "VCGERG"          "FF"              "YTPKTRREAED"     "QVGQVE"
## [17] "GGGPGAGS"        "LQP"             "LA"              "EGS"
## [21] "QKRGIVEQCCTSICS" "Q"               "EN"              "CN"
##
## $P61278
##  [1] "ML"                    "SCRL"                  "QCA"
##  [4] "L"                     "AA"                    "SIV"
##  [7] "A"                     "GCVTGAPSDPRL"          "RQ"
## [10] "FL"                    "QKS"                   "LAAAAGKQEL"
## [13] "AK"                    "Y"                     "AE"
## [16] "SEPNQTENDA"            "LEPED"                 "SQAAEQDEMRL"
## [19] "EL"                    "QRSANSNPAMAPRERKAGCKN" "FF"
## [22] "W"                     "KT"                    "FTSC"
```

# 4 Isotopic Distribution Of Tryptic Digested Insulin

A common use case of in-silico cleavage is the calculation of the
isotopic distribution of peptides (which were enzymatic digested in the
in-vitro experimental workflow). Here
*[BRAIN](https://bioconductor.org/packages/3.22/BRAIN)* (Claesen et al. [2012](#ref-BRAIN); Dittwald et al. [2013](#ref-BRAIN2)) is used to calculate
the isotopic distribution of *[cleaver](https://bioconductor.org/packages/3.22/cleaver)*’s output.
(please note: it is only a toy example, e.g. the relation of intensity values
between peptides isn’t correct).

```
## load BRAIN library
library("BRAIN")

## cleave insulin
cleavedInsulin <- cleave(sequences[1], enzym="trypsin")[[1]]

## create empty plot area
plot(NA, xlim=c(150, 4300), ylim=c(0, 1),
     xlab="mass", ylab="relative intensity",
     main="tryptic digested insulin - isotopic distribution")

## loop through peptides
for (i in seq(along=cleavedInsulin)) {
  ## count C, H, N, O, S atoms in current peptide
  atoms <- BRAIN::getAtomsFromSeq(cleavedInsulin[[i]])
  ## calculate isotopic distribution
  d <- useBRAIN(atoms)
  ## draw peaks
  lines(d$masses, d$isoDistr, type="h", col=2)
}
```

![](data:image/png;base64...)

# 5 Session Information

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
##  [1] BRAIN_1.56.0        lattice_0.22-7      PolynomF_2.0-8
##  [4] UniProt.ws_2.50.0   cleaver_1.48.0      Biostrings_2.78.0
##  [7] Seqinfo_1.0.0       XVector_0.50.0      IRanges_2.44.0
## [10] S4Vectors_0.48.0    BiocGenerics_0.56.0 generics_0.1.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          RSQLite_2.4.3
##  [4] hms_1.1.4            digest_0.6.37        magrittr_2.0.4
##  [7] grid_4.5.1           evaluate_1.0.5       bookdown_0.45
## [10] fastmap_1.2.0        blob_1.2.4           jsonlite_2.0.0
## [13] progress_1.2.3       AnnotationDbi_1.72.0 DBI_1.2.3
## [16] tinytex_0.57         BiocManager_1.30.26  httr_1.4.7
## [19] httr2_1.2.1          jquerylib_0.1.4      cli_3.6.5
## [22] rlang_1.1.6          crayon_1.5.3         dbplyr_2.5.1
## [25] Biobase_2.70.0       bit64_4.6.0-1        cachem_1.1.0
## [28] yaml_2.3.10          BiocBaseUtils_1.12.0 tools_4.5.1
## [31] memoise_2.0.1        dplyr_1.1.4          filelock_1.0.3
## [34] curl_7.0.0           rjsoncons_1.3.2      vctrs_0.6.5
## [37] R6_2.6.1             png_0.1-8            magick_2.9.0
## [40] lifecycle_1.0.4      BiocFileCache_3.0.0  KEGGREST_1.50.0
## [43] bit_4.6.0            pkgconfig_2.0.3      bslib_0.9.0
## [46] pillar_1.11.1        Rcpp_1.1.0           glue_1.8.0
## [49] xfun_0.53            tibble_3.3.0         tidyselect_1.2.1
## [52] knitr_1.50           htmltools_0.5.8.1    rmarkdown_2.30
## [55] compiler_4.5.1       prettyunits_1.2.0
```

# References

Carlson, Marc. n.d. *UniProt.ws: R Interface to Uniprot Web Services*.

Claesen, Jürgen, Piotr Dittwald, Tomasz Burzykowski, and Dirk Valkenborg. 2012. “An Efficient Method to Calculate the Aggregated Isotopic Distribution and Exact Center-Masses.” *Journal of the American Society for Mass Spectrometry* 23 (4): 753–63.

Dittwald, Piotr, Jürgen Claesen, Tomasz Burzykowski, Dirk Valkenborg, and Anna Gambin. 2013. “BRAIN: A Universal Tool for High-Throughput Calculations of the Isotopic Distribution for Mass Spectrometry.” *Analytical Chemistry* 85 (4): 1991–4.

Gasteiger, Elisabeth, Christine Hoogland, Alexandre Gattiker, S’everine Duvaud, Marc R. Wilkins, Ron D. Appel, and Amos Bairoch. 2005. “Protein Identification and Analysis Tools on the Expasy Server.” In *The Proteomics Protocols Handbook*, edited by John M. Walker, 571–607. Humana Press. [https://doi.org/10.1385/1-59259-890-0:571](https://doi.org/10.1385/1-59259-890-0%3A571).

Pages, H., P. Aboyoun, R. Gentleman, and S. DebRoy. n.d. *Biostrings: String Objects Representing Biological Sequences, and Matching Algorithms*.

The UniProt Consortium. 2012. “Reorganizing the Protein Space at the Universal Protein Resource (Uniprot).” *Nucleic Acids Research* 40 (D1): D71–D75. <https://doi.org/10.1093/nar/gkr981>.