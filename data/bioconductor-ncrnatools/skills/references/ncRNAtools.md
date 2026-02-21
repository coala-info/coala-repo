# Contents

* [1 Abstract](#abstract)
* [2 Introduction](#introduction)
* [3 Installation](#installation)
* [4 Software features](#software-features)
* [5 Examples](#examples)
  + [5.1 Searching the RNAcentral database](#searching-the-rnacentral-database)
  + [5.2 Predicting the secondary structure of an RNA](#predicting-the-secondary-structure-of-an-rna)
  + [5.3 Calculating and plotting of base pair probability matrices](#calculating-and-plotting-of-base-pair-probability-matrices)
  + [5.4 Reading and writing files and other utilities](#reading-and-writing-files-and-other-utilities)
* [6 Session info](#session-info)
* [References](#references)

ncRNAtools

Lara Selles Vidal,
Rafael Ayala, Guy-Bart Stan, Rodrigo Ledesma-Amaro

July 24, 2020

# 1 Abstract

Non-coding RNA (ncRNA) comprise a variety of RNA
molecules that are transcribed from DNA but are not translated into proteins.

# 2 Introduction

The key role of ncRNAs in cellular processes has been well established over the
last two decades, with at least 70% of the human genome reported to be
transcribed into RNAs of different sizes. Given the fact that only around 28% of
the human genome corresponds to protein-encoding regions (including introns and
other untranslated regions), it is currently thought that the rest of the genome
encodes a high number of functional RNA molecules that are not translated to
proteins (Fu [2014](#ref-fu2014)).

One of the main characteristic features of ncRNAs is their secondary structure,
defined by the intramolecular pairing of bases through hydrogen bonds. The
identification of RNA secondary structure is often the basis for determining
essential bases for ncRNA function, as well as for engineering novel or modified
ncRNAs, including ribozymes. Furthermore, several methodologies for the
prediction of RNA threedimensional structure require secondary structure
information as a key input (Wang & Xu [2011](#ref-zhiyong2011); Thiel *et al.* [2017](#ref-thiel2017)).

ncRNAtools aims to facilitate the inclusion of ncRNA identification and analysis
within existing genomics and transcriptomics workflows, as well as the
application of statistical modeling for the prediction of ncRNA properties and
structure by providing a set of tools for importing, exporting, plotting and
analyzing ncRNAs and their features.

# 3 Installation

To install ncRNAtools, start R (>=4.0) and run:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")

# The following line initializes usage of Bioc devel, and therefore should be
# skipped in order to install the stable release version
BiocManager::install(version = "devel")

BiocManager::install("ncRNAtools")
```

# 4 Software features

A first set of ncRNAtools functionalities allows to search the [RNAcentral](https://rnacentral.org/)
database of annotated ncRNA (Consortium [2019](#ref-rnacentral2019)). The RNAcentral database can be
searched in two different ways: by keywords, and by genomic coordinates.
Information about a specific entry can also be retrieved.

ncRNAtools also enables the prediction of secondary structure of RNA by simply
providing a sequence of interest. Secondary structure predictions are performed
through the [rtools](http://rtools.cbrc.jp/) web server for RNA Bioinformatics (Hamada *et al.* [2016](#ref-hamada2016)).
Currently supported methodologies for secondary structure prediction include
centroidFold (Hamada *et al.* [2008](#ref-hamada2008)), centroidHomfold (Hamada *et al.* [2011](#ref-hamada2011)) and IPknot (Sato *et al.* [2011](#ref-sato2011)).
Only IPknot can detect pseudoknots. Alternative secondary structures can be
predicted with the RintW method (Hagio *et al.* [2018](#ref-hagio2018)). Utilities to determine paired
bases from a secondary structure string and viceversa are also available.

Additionally, ncRNAtools provides utilities to calculate a matrix of base pair
probabilities and visualize it as a heatmap, with the possibility to make a
composite plot including also a defined secondary structure.

Finally, ncRNAtools supports reading and writing files in the CT and Dot-Bracket
formats, the two most commonly employed formats for storing the secondary
structure of RNA.

# 5 Examples

## 5.1 Searching the RNAcentral database

The RNAcentral database can be searched by keywords with the “rnaCentralTextSearch”
function. The function returns a character vector where each element is a string
representing the RNAcentral accession for an entry that matched the search.
RNAcentral accessions are always of either the “URSXXXXXXXXXX” form, where X is
any hexadecimal numeral, or “URSXXXXXXXXXX\_taxid”, where taxid is the NCBI
taxonomy identifier for the species or strain corresponding to the entry.
Searches can either include only a keyword or phrase, or be given in the
field\_name:“field value” syntax, with several fields separated by logical
operators as described in <https://rnacentral.org/help/text-search>. It should be
noted that logical operators must be capitalized.

For example, the keyword “HOTAIR” can be passed as the query to the search
function to identify entries corresponding to the HOTAIR ncRNA:

```
rnaCentralTextSearch("HOTAIR")
```

```
##  [1] "URS00026A23F2_9606" "URS00008BE50E_9606" "URS00001A335C_9606"
##  [4] "URS000011D1F0_9606" "URS0000513030_9606" "URS000019A694_9606"
##  [7] "URS00026A2632_9606" "URS00026A26A6_9606" "URS00026A19E6_9606"
## [10] "URS00026A1E8F_9606" "URS00026A23DD_9606" "URS00025F2EE3_9606"
## [13] "URS00025F7E70_9606" "URS000233D5A1_9606" "URS00023489CA_9606"
```

With a more refined search, it is possible to identify RNAs corresponding to the
FMN riboswitch present in Bacillus subtilis strains only. It should be noted
that the quotes enclosing the value for specific fields must be escaped:

```
rnaCentralTextSearch("FMN AND species:\"Bacillus subtilis\"")
```

```
## character(0)
```

Information about the resulting entries can be retrieved with the
“rnaCentralRetrieveEntry” function:

```
rnaCentralRetrieveEntry("URS000037084E_1423")
```

```
## $rnaCentralID
## [1] "URS000037084E_1423"
##
## $sequence
## [1] "UGUAUCCUUCGGGGCAGGGUGGAAAUCCCGACCGGCGGUAGUAAAGCACAUUUGCUUUAGAGCCCGUGACCCGUGUGCAUAAGCACGCGGUGGAUUCAGUUUAAGCUGAAGCCGACAGUGAAAGUCUGGAUGGGAGAAGGAUGAU"
##
## $sequenceLength
## [1] 145
##
## $description
## [1] "Bacillus subtilis FMN sequence"
##
## $species
## [1] "Bacillus subtilis"
##
## $ncbiTaxID
## [1] 1423
##
## $RNATypes
## NULL
```

It is also possible to perform a search of the RNAcentral database by specifying
genomic coordinates with the “rnaCentralGenomicCoordinatesSearch” function.
A GRanges object must be provided, with sequence names of the **chr?** or simply
**?** format (where **?** denotes any number, the X or Y characters or another
letter for organisms where chromosomes are named with letters), or, alternatively,
“MT” to denote mitochondrial DNA. The species name must also be provided as a
string with the scientific name. A list of organisms for which search by genomic
coordinates is supported can be found at <https://rnacentral.org/help/genomic-mapping>.
Several ranges can be provided in the same GRanges object, but they must refer
to the same organism.

In the following example, we aim to retrieve the known ncRNA present in Yarrowia
lipolytica (oleaginous yeast) between positions 200000 and 300000 of
chromosome C, and positions 500000 and 550000 of chromosome D:

```
## Generate a GRanges object with the genomic ranges to be used to search the
## RNAcentral database

genomicCoordinates <- GenomicRanges::GRanges(seqnames = S4Vectors::Rle(c("chrC",
    "chrD")), ranges = IRanges::IRanges(c(2e+05, 5e+05), c(3e+05, 550000)))

## Use the generated GRanges object to search the RNAcentral database

RNAcentralHits <- rnaCentralGenomicCoordinatesSearch(genomicCoordinates, "Yarrowia lipolytica")

## Check the number of hits in each provided genomic range

length(RNAcentralHits[[1]])  # 22 known ncRNA between positions 200000 and 300000 of chromosome C
```

```
## [1] 22
```

```
length(RNAcentralHits[[2]])  # No known ncRNA between positions 500000 and 550000 of chromosome D
```

```
## [1] 0
```

## 5.2 Predicting the secondary structure of an RNA

The “predictSecondaryStructure” function enables the prediction of the secondary
structure of RNA through three different methods: centroidFold (Hamada *et al.* [2008](#ref-hamada2008)),
centroidHomfold (Hamada *et al.* [2011](#ref-hamada2011)) and IPknot (Sato *et al.* [2011](#ref-sato2011)). IPknot has the advantage
of being able to detect pseudoknots.

The secondary structure predictions by centroidFold and centroidHomfold are
output in the Dot-Bracket format, where dots (“.”) represent unpaired bases and
pairs of open and closed round brackets (“(”-“)”) represent paired bases. Such
format cannot unambiguously represent nested structures such as pseudoknots.
Therefore, the output of IPknot is provided, if required, in the extended
Dot-Bracket format, where additional pairs of symbols are used to represent such
nested structures.

In the following example, all three methods are used to predict the structure of
a fragment of a tRNA:

```
tRNAfragment <- "UGCGAGAGGCACAGGGUUCGAUUCCCUGCAUCUCCA"

centroidFoldPrediction <- predictSecondaryStructure(tRNAfragment, "centroidFold")
centroidFoldPrediction$secondaryStructure
```

```
## [1] ".....((((..(((((.......)))))..)))).."
```

```
centroidHomFoldPrediction <- predictSecondaryStructure(tRNAfragment, "centroidHomFold")
centroidFoldPrediction$secondaryStructure
```

```
## [1] ".....((((..(((((.......)))))..)))).."
```

```
IPknotPrediction <- predictSecondaryStructure(tRNAfragment, "IPknot")
IPknotPrediction$secondaryStructure
```

```
## [1] "...((((....(((((.......)))))..)))).."
```

It is also possible to predict not only a single canonical secondary structure,
but also a set of possible alternative secondary structures. This is achieved
with the RintW method (Hagio *et al.* [2018](#ref-hagio2018)), available through the
“predictAlternativeSecondaryStructures” function.

```
tRNAfragment2 <- "AAAGGGGUUUCCC"

RintWPrediction <- predictAlternativeSecondaryStructures(tRNAfragment2)

length(RintWPrediction)  # A total of 2 alternative secondary structures were identified by RintW
```

```
## [1] 2
```

```
RintWPrediction[[1]]$secondaryStructure
```

```
## [1] "...(((....)))"
```

```
RintWPrediction[[2]]$secondaryStructure
```

```
## [1] "....(((...)))"
```

## 5.3 Calculating and plotting of base pair probability matrices

Both centroidFold and centroidHomfold return not only a prediction of the
secondary structure of an RNA, but also a list of probabilities for potential
base pairs for each nucleotide. Such a matrix can be useful in assessing the
potential presence of alternative secondary structures.

A matrix of base pair probabilities can be generated with the
“generatePairsProbabilityMatrix”, which takes as input the probabilities in the
format returned by centroidFold and centroidHomFold. The base pair probabilities
matrix can then be plotted with the “plotPairsProbabilityMatrix” function:

```
basePairProbabilityMatrix <- generatePairsProbabilityMatrix(centroidFoldPrediction$basePairProbabilities)

plotPairsProbabilityMatrix(basePairProbabilityMatrix)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the ncRNAtools package.
##   Please report the issue at
##   <https://github.com/LaraSellesVidal/ncRNAtools/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the ncRNAtools package.
##   Please report the issue at
##   <https://github.com/LaraSellesVidal/ncRNAtools/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

A composite plot, where the top right triangle represents the base pair
probabilities while the bottom left triangle represents base pairings in a
specific secondary structure, can be generated with the “plotCompositePairsMatrix”
function. Usually, base pairs in a secondary structure correspond to pairs with
a high probability. The function takes as its input a matrix of base pair
probabilities, and a dataframe with bases paired in a given secondary structure.
Such a dataframe can be generated from a secondary structure string with the
“findPairedBases” function.

In the following example, such a composite plot is generated the secondary
structure predicted by centroidFold for the tRNA fragment:

```
pairedBases <- findPairedBases(sequence = tRNAfragment, secondaryStructureString = IPknotPrediction$secondaryStructure)

plotCompositePairsMatrix(basePairProbabilityMatrix, pairedBases)
```

![](data:image/png;base64...)

## 5.4 Reading and writing files and other utilities

ncRNAtools supports reading and writing files in the CT and Dot-Bracket format.
For a description of each format, see <http://projects.binf.ku.dk/pgardner/bralibase/RNAformats.html>
and <https://rna.urmc.rochester.edu/Text/File_Formats.html>.

CT files are read with the “readCT” function. Some CT files contain a line for
each nucleotide of the RNA sequence, while others contain lines only for paired
nucleotides. In the second case, the full sequence must be provided when calling
“readCT”.

The list returned by “readCT” includes an element named “pairsTable”, consisting
of a dataframe indicating paired nucleotides. A corresponding secondary
structure string in the Dot-Bracket format can be generated with the
“pairsToSecondaryStructure” function.

CT files are written with the “writeCT” function. A complete CT file is always
output by “writeCT”.

Files in the Dot-Bracket format are read and written with the “readDotBracket”
and “writeDotBracket” functions respectively. If the read Dot-Bracket file
contains an energy value for the represented structure, it will be included in
the output of “readDotBracket”.

```
## Read an example CT file corresponding to E. coli tmRNA

exampleCTFile <- system.file("extdata", "exampleCT.ct", package = "ncRNAtools")

tmRNASequence <- "GGGGCUGAUUCUGGAUUCGACGGGAUUUGCGAAACCCAAGGUGCAUGCCGAGGGGCGGUUGGCCUCGUAAAAAGCCGCAAAAAAUAGUCGCAAACGACGAAAACUACGCUUUAGCAGCUUAAUAACCUGCUUAGAGCCCUCUCUCCCUAGCCUCCGCUCUUAGGACGGGGAUCAAGAGAGGUCAAACCCAAAAGAGAUCGCGUGGAAGCCCUGCCUGGGGUUGAAGCGUUAAAACUUAAUCAGGCUAGUUUGUUAGUGGCGUGUCCGUCCGCAGCUGGCAAGCGAAUGUAAAGACUGACUAAGCAUGUAGUACCGAGGAUGUAGGAAUUUCGGACGCGGGUUCAACUCCCGCCAGCUCCACCA"

tmRNASecondaryStructure <- readCT(exampleCTFile, tmRNASequence)

## Write a complete CT file for E. coli tmRNA

tempDir <- tempdir()
testCTFile <- paste(tempDir, "testCTfile.ct", sep = "")

tmRNASecondaryStructureString <- pairsToSecondaryStructure(pairedBases = tmRNASecondaryStructure$pairsTable,
    sequence = tmRNASequence)

writeCT(testCTFile, sequence = tmRNASequence, secondaryStructure = tmRNASecondaryStructureString,
    sequenceName = "tmRNA")

## Read an example Dot-Bracket file

exampleDotBracketFile <- system.file("extdata", "exampleDotBracket.dot", package = "ncRNAtools")

exampleDotBracket <- readDotBracket(exampleDotBracketFile)

exampleDotBracket$freeEnergy  # The structure has a free energy of -41.2 kcal/mol
```

```
## [1] -41.2
```

```
## Write a Dot-Bracket file

tempDir2 <- tempdir()
testDotBracketFile <- paste(tempDir2, "testDotBracketFile.dot", sep = "")

writeDotBracket(testDotBracketFile, sequence = exampleDotBracket$sequence, secondaryStructure = exampleDotBracket$secondaryStructure,
    sequenceName = "Test sequence")
```

ncRNAtools includes an utility to flatten representations of secondary structure
in the extended Dot-Bracket format to basic Dot-Bracket format (i.e., comprising
only the “.”, “(” and “)” characters). Although information is potentially lost
upon such transformation, this is required for some RNA Bioinformatics software,
which can only accept secondary structures in the Dot-Bracket format as input.
This can be achieved with the “flattenDotBracket” function.

```
extendedDotBracketString <- "...((((..[[[.))))]]]..."

plainDotBracketString <- flattenDotBracket(extendedDotBracketString)
```

# 6 Session info

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
## [1] ggplot2_4.0.0        GenomicRanges_1.62.0 Seqinfo_1.0.0
## [4] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
## [7] generics_0.1.4       ncRNAtools_1.20.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        jsonlite_2.0.0      crayon_1.5.3
##  [4] dplyr_1.1.4         compiler_4.5.1      BiocManager_1.30.26
##  [7] Rcpp_1.1.0          tinytex_0.57        tidyselect_1.2.1
## [10] xml2_1.4.1          magick_2.9.0        dichromat_2.0-0.1
## [13] jquerylib_0.1.4     scales_1.4.0        yaml_2.3.10
## [16] fastmap_1.2.0       R6_2.6.1            curl_7.0.0
## [19] knitr_1.50          tibble_3.3.0        bookdown_0.45
## [22] bslib_0.9.0         pillar_1.11.1       RColorBrewer_1.1-3
## [25] rlang_1.1.6         cachem_1.1.0        xfun_0.53
## [28] sass_0.4.10         S7_0.2.0            cli_3.6.5
## [31] withr_3.0.2         magrittr_2.0.4      formatR_1.14
## [34] digest_0.6.37       grid_4.5.1          lifecycle_1.0.4
## [37] vctrs_0.6.5         evaluate_1.0.5      glue_1.8.0
## [40] farver_2.1.2        rmarkdown_2.30      httr_1.4.7
## [43] tools_4.5.1         pkgconfig_2.0.3     htmltools_0.5.8.1
```

# References

Consortium, T.R. (2019). RNAcentral: A hub of information for non-coding rna sequences. *Nucleic Acids Research*, **47**, D221—D229. Retrieved from <https://doi.org/10.1093/nar/gky1034>

Fu, X.-D. (2014). Non-coding rna: A new frontier in regulatory biology. *National Science Review*, **1**, 190–204. Retrieved from <https://doi.org/10.1093/nsr/nwu008>

Hagio, T., Sakuraba, S., Iwakiri, J., Mori, R. & Asai, K. (2018). Capturing alternative secondary structures of rna by decomposition of base-pairing probabilities. *BMC Bioinformatics*, **19**, 38. Retrieved from [https://doi.org/10.1186/s12859-018-2018-4](https://doi.org/10.1186/s12859-018-2018-4%20)

Hamada, M., Kiryu, H., Sato, K., Mituyama, T. & Asai, K. (2008). Prediction of rna secondary structure using generalized centroid estimators. *Bioinformatics*, **25**, 465–473. Retrieved from <https://doi.org/10.1093/bioinformatics/btn601>

Hamada, M., Ono, Y., Kiryu, H., Sato, K., Kato, Y., Fukunaga, T., Mori, R. & Asai, K. (2016). Rtools: A web server for various secondary structural analyses on single rna sequences. *Nucleic Acids Research*, **44**, W302–W307. Retrieved from <https://doi.org/10.1093/nar/gkw337>

Hamada, M., Yamada, K., Sato, K., Frith, M.C. & Asai, K. (2011). CentroidHomfold-last: Accurate prediction of rna secondary structure using automatically collected homologous sequences. *Nucleic Acids Research*, **39**, W100–W106. Retrieved from <https://doi.org/10.1093/nar/gkr290>

Sato, K., Kato, Y., Hamada, M., Akutsu, T. & Asai, K. (2011). IPknot: Fast and accurate prediction of rna secondary structures with pseudoknots using integer programming. *Bioinformatics*, **27**, i85–i93. Retrieved from <https://doi.org/10.1093/bioinformatics/btr215>

Thiel, B.C., Flamm, C. & Hofacker, I.L. (2017). RNA structure prediction: From 2D to 3D. *Emerging Topics in Life Sciences*, **1**, 275–285. Retrieved from <https://doi.org/10.1042/ETLS20160027>

Wang, Z. & Xu, J. (2011). A conditional random fields method for rna sequence–structure relationship modeling and conformation sampling. *Bioinformatics*, **27**, i102–i110. Retrieved from <https://doi.org/10.1093/bioinformatics/btr232>