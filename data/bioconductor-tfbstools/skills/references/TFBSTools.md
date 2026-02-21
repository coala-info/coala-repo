# Transcription factor binding site (TFBS) analysis with the “TFBSTools” package

Ge Tan

#### 30 October 2025

#### Abstract

Analysis and manipulation of transcription factor binding sites.

#### Package

TFBSTools 1.48.0

# Contents

* [1 Introduction](#introduction)
* [2 *S4* classes in TFBSTools](#s4-classes-in-tfbstools)
  + [2.1 XMatrix and its subclasses](#xmatrix-and-its-subclasses)
  + [2.2 XMatrixList and its subclasses](#xmatrixlist-and-its-subclasses)
  + [2.3 SiteSet, SiteSetList, SitePairSet and SitePairSetList](#siteset-sitesetlist-sitepairset-and-sitepairsetlist)
  + [2.4 MotifSet](#motifset)
  + [2.5 TFFM and its subclasses](#tffm-and-its-subclasses)
* [3 Database interfaces for JASPAR2014 database](#database-interfaces-for-jaspar2014-database)
  + [3.1 Search JASPAR2014 database](#search-jaspar2014-database)
  + [3.2 Store, delete and initialize JASPAR2014 database](#store-delete-and-initialize-jaspar2014-database)
* [4 PFM, PWM and ICM methods](#pfm-pwm-and-icm-methods)
  + [4.1 PFM to PWM](#pfm-to-pwm)
  + [4.2 PFM to ICM](#pfm-to-icm)
  + [4.3 Align PFM to a custom matrix or IUPAC string](#align-pfm-to-a-custom-matrix-or-iupac-string)
  + [4.4 PWM similarity](#pwm-similarity)
  + [4.5 Dynamic random profile generation](#dynamic-random-profile-generation)
* [5 TFFM methods](#tffm-methods)
  + [5.1 The graphical representation of TFFM](#the-graphical-representation-of-tffm)
* [6 Scan sequence and alignments with PWM pattern](#scan-sequence-and-alignments-with-pwm-pattern)
  + [6.1 searchSeq](#searchseq)
  + [6.2 searchAln](#searchaln)
  + [6.3 searchPairBSgenome](#searchpairbsgenome)
* [7 Use *de novo* motif discovery software](#use-de-novo-motif-discovery-software)
* [8 Session info](#session-info)
* [9 References](#references)
* **Appendix**

# 1 Introduction

Eukaryotic regulatory regions are characterized based a set of
discovered transcription factor binding sites (TFBSs),
which can be represented as sequence patterns
with various degree of degeneracy.

This *[TFBSTools](https://bioconductor.org/packages/3.22/TFBSTools)* package is designed to be a compuational framework
for TFBSs analysis.
Based on the famous perl module TFBS (Lenhard and Wasserman [2002](#ref-lenhard_tfbs:_2002)),
we extended the class definitions and enhanced implementations
in an interactive environment.
So far this package contains a set of integrated *R* *S4* style classes,
tools, JASPAR database interface functions.
Most approaches can be described in three sequential phases.
First, a pattern is generated for a set of target sequences
known to be bound by a specific transcription factor.
Second, a set of DNA sequences are analyzed to determine
the locations of sequences consistent with the described binding pattern.
Finally, in advanced cases, predictive statistical models of regulatory
regions are constructed based on mutiple occurrences of the detected
patterns.

Since JASPAR2016, the next generation of
transcription factor binding site, *TFFM* (Mathelier and Wasserman [2013](#ref-mathelier_next_2013)),
was introduced into JASPAR for the first time.
Now *[TFBSTools](https://bioconductor.org/packages/3.22/TFBSTools)* also supports the manipulation of *TFFM*.
TFFM is based on hidden Markov Model (HMM).
The biggest advantage of TFFM over basic PWM is that
it can model position interdependence within TFBSs and variable motif length.
A novel graphical representation of the TFFM motifs that captures
the position interdependence is also introduced.
For more details regarding TFFM,
please refer to <http://cisreg.cmmt.ubc.ca/TFFM/doc/>.

*[TFBSTools](https://bioconductor.org/packages/3.22/TFBSTools)* aims to support all these functionalities
in the environment *R*, except the external motif finding software,
such as *MEME* (Bailey and Elkan [1994](#ref-bailey_fitting_1994)).

# 2 *S4* classes in TFBSTools

The package is built around a number of *S4* class of
which the `XMatrix`,
`SiteSet` classes are the most important.
The section will briefly explain most of them defined in *[TFBSTools](https://bioconductor.org/packages/3.22/TFBSTools)*.

## 2.1 XMatrix and its subclasses

`XMatrix` is a virtual class,
which means no concrete objects can be created directly from it.
The subclass `PFMatrix` is designed to store all the relevant information
for one raw position frequency matrix (PFM).
This object is compatible with one record from JASPAR database.
`PWMatrix` is used to store a position weight matrix (PWM).
Compared with `PFMatrix`, it has one extra slot *pseudocounts*.
`ICMatrix` is used to store a information content matrix (ICM).
Compared with `PWMatrix`, it has one extra slot *schneider*.

The following examples demonstrate the creation of `PFMatrix`,
the conversions between these matrices and some assocated methods defined for these classes.

```
library(TFBSTools)
## PFMatrix construction; Not all of the slots need to be initialised.
pfm <- PFMatrix(ID="MA0004.1", name="Arnt",
                matrixClass="Zipper-Type", strand="+",
                bg=c(A=0.25, C=0.25, G=0.25, T=0.25),
                tags=list(family="Helix-Loop-Helix", species="10090",
                          tax_group="vertebrates",medline="7592839",
                          type="SELEX",ACC="P53762", pazar_tf_id="TF0000003",
                          TFBSshape_ID="11", TFencyclopedia_ID="580"),
                profileMatrix=matrix(c(4L,  19L, 0L,  0L,  0L,  0L,
                                       16L, 0L,  20L, 0L,  0L,  0L,
                                       0L,  1L,  0L,  20L, 0L,  20L,
                                       0L,  0L,  0L,  0L,  20L, 0L),
                                     byrow=TRUE, nrow=4,
                                     dimnames=list(c("A", "C", "G", "T"))
                                     )
                )

pfm
#> An object of class PFMatrix
#> ID: MA0004.1
#> Name: Arnt
#> Matrix Class: Zipper-Type
#> strand: +
#> Tags:
#> $family
#> [1] "Helix-Loop-Helix"
#>
#> $species
#> [1] "10090"
#>
#> $tax_group
#> [1] "vertebrates"
#>
#> $medline
#> [1] "7592839"
#>
#> $type
#> [1] "SELEX"
#>
#> $ACC
#> [1] "P53762"
#>
#> $pazar_tf_id
#> [1] "TF0000003"
#>
#> $TFBSshape_ID
#> [1] "11"
#>
#> $TFencyclopedia_ID
#> [1] "580"
#>
#> Background:
#>    A    C    G    T
#> 0.25 0.25 0.25 0.25
#> Matrix:
#>   [,1] [,2] [,3] [,4] [,5] [,6]
#> A    4   19    0    0    0    0
#> C   16    0   20    0    0    0
#> G    0    1    0   20    0   20
#> T    0    0    0    0   20    0

## coerced to matrix
as.matrix(pfm)
#>   [,1] [,2] [,3] [,4] [,5] [,6]
#> A    4   19    0    0    0    0
#> C   16    0   20    0    0    0
#> G    0    1    0   20    0   20
#> T    0    0    0    0   20    0

## access the slots of pfm
ID(pfm)
#> [1] "MA0004.1"
name(pfm)
#> [1] "Arnt"
Matrix(pfm)
#>   [,1] [,2] [,3] [,4] [,5] [,6]
#> A    4   19    0    0    0    0
#> C   16    0   20    0    0    0
#> G    0    1    0   20    0   20
#> T    0    0    0    0   20    0
ncol(pfm)
#> [1] 6
length(pfm)
#> [1] 6

## convert a PFM to PWM, ICM
pwm <- toPWM(pfm, type="log2probratio", pseudocounts=0.8,
             bg=c(A=0.25, C=0.25, G=0.25, T=0.25))

icm <- toICM(pfm, pseudocounts=sqrt(rowSums(pfm)[1]), schneider=FALSE,
             bg=c(A=0.25, C=0.25, G=0.25, T=0.25))

## get the reverse complment matrix with all the same information except the strand.
pwmRevComp <- reverseComplement(pwm)
```

## 2.2 XMatrixList and its subclasses

`XMatrixList` is used to store a set of `XMatrix` objects.
Basically it is a SimpleList for easy manipulation the whole set of
`XMatrix`.
The concrete objects can be `PFMatrix`, `PWMatrix` and
`ICMatrix`.

```
pfm2 <- pfm
pfmList <- PFMatrixList(pfm1=pfm, pfm2=pfm2, use.names=TRUE)
pfmList
#> PFMatrixList of length 2
#> names(2): pfm1 pfm2
names(pfmList)
#> [1] "pfm1" "pfm2"
```

## 2.3 SiteSet, SiteSetList, SitePairSet and SitePairSetList

The `SiteSet` class is a container for storing a set of putative
transcription factor binding sites on a nucleotide sequence
(start, end, strand, score, pattern as a `PWMatrix`, etc.)
from scaning a nucleotide sequence with the corresponding `PWMatrix`.
Similarly, `SiteSetList` stores a set of `SiteSet` objects.

For holding the results returned from a pairwise alignment scaaning,
`SitePairSet` and `SitePairSetList` are provided.

More detailed examples of using these classes will be given in
later Section.

## 2.4 MotifSet

This `MotifSet` class is used to store the generated motifs from
*de novo* motif discovery software, such as
*MEME* (Bailey and Elkan [1994](#ref-bailey_fitting_1994)).

## 2.5 TFFM and its subclasses

`TFMM` is a virtual class and two classes
`TFFMFirst` and `TFFMDetail` are derived from this virtual class.
Compared with `PFMatrix` class, `TFFM` has two extra slots
that store the emission distribution parameters and transition probabilities.
`TFFMFirst` class stands for the first-order TFFMs, while
`TFFMDetail` stands for the more detailed and descriptive TFFMs.

Although we provide the constructor functions for `TFFM` class,
the `TFFM` object is usually generated from reading a XML file from
the Python module *TFFM*.

```
  xmlFirst <- file.path(system.file("extdata", package="TFBSTools"),
                        "tffm_first_order.xml")
  tffmFirst <- readXMLTFFM(xmlFirst, type="First")
  tffm <- getPosProb(tffmFirst)

  xmlDetail <- file.path(system.file("extdata", package="TFBSTools"),
                         "tffm_detailed.xml")
  tffmDetail <- readXMLTFFM(xmlDetail, type="Detail")
  getPosProb(tffmDetail)
#>           1         2         3         4          5           6          7
#> A 0.2114735 0.2838839 0.1637668 0.1871573 0.03681719 0.005747193 0.01883841
#> C 0.3347593 0.2854457 0.2441757 0.1840625 0.41600416 0.935778162 0.77794455
#> G 0.2278705 0.2736597 0.2133885 0.4208620 0.49585999 0.055218351 0.07339319
#> T 0.2258967 0.1570107 0.3786690 0.2079182 0.05131866 0.003256293 0.12982385
#>           8          9        10          11          12         13        14
#> A 0.0493708 0.07792452 0.4653410 0.128592905 0.003276879 0.04503578 0.2113065
#> C 0.3350808 0.43249364 0.1518607 0.078588841 0.067743421 0.51743026 0.4022825
#> G 0.1622687 0.40736410 0.3456973 0.786245657 0.924717895 0.40148909 0.1895450
#> T 0.4532797 0.08221774 0.0371010 0.006572597 0.004261805 0.03604487 0.1968661
#>          15
#> A 0.3661852
#> C 0.2161336
#> G 0.2429433
#> T 0.1747378
```

# 3 Database interfaces for JASPAR2014 database

This section will demonstrate how to operate on the JASPAR 2014 database.
JASPAR is a collection of transcription factor DNA-binding preferences,
modeled as matrices.
These can be converted into PWMs, used for scanning genomic sequences.
JASPAR is the only database with this scope where the data can be used
with no restrictions (open-source).
A `Bioconducto` experiment data package *[JASPAR2014](https://bioconductor.org/packages/3.22/JASPAR2014)*
is provided with each release of JASPAR.

## 3.1 Search JASPAR2014 database

This search function fetches matrix data for all matrices in the database
matching criteria defined by the named arguments
and returns a PFMatrixList object.
For more search criterias,
please see the help page for `getMatrixSet`.

```
suppressMessages(library(JASPAR2014))
opts <- list()
opts[["species"]] <- 9606
opts[["name"]] <- "RUNX1"
opts[["type"]] <- "SELEX"
opts[["all_versions"]] <- TRUE
PFMatrixList <- getMatrixSet(JASPAR2014, opts)
PFMatrixList
#> PFMatrixList of length 1
#> names(1): MA0002.1

opts2 <- list()
opts2[["type"]] <- "SELEX"
PFMatrixList2 <- getMatrixSet(JASPAR2014, opts2)
PFMatrixList2
#> PFMatrixList of length 111
#> names(111): MA0004.1 MA0006.1 MA0008.1 MA0009.1 ... MA0588.1 MA0589.1 MA0590.1
```

## 3.2 Store, delete and initialize JASPAR2014 database

We also provide some functions to initialize an empty JASPAR2014
style database,
store new `PFMatrix` or `PFMatrixList` into it,
or delete some records based on ID.
The backend of the database is *SQLite*.

```
db <- "myMatrixDb.sqlite"
initializeJASPARDB(db, version="2014")
#> [1] "Success"
data("MA0043")
storeMatrix(db, MA0043)
#> [1] "Success"
deleteMatrixHavingID(db,"MA0043.1")
file.remove(db)
#> [1] TRUE
```

# 4 PFM, PWM and ICM methods

This section will give an introduction of matrix operations,
including conversion from PFM to PWM and ICM, profile matrices comparison,
dynamic random profile generation.

## 4.1 PFM to PWM

The method `toPWM` can convert PFM to PWM (Wasserman and Sandelin [2004](#ref-Wasserman:2004ec)).
Optional parameters include *type*, *pseudocounts*, *bg*.
The implementation in this package is a bit different from that in *[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)*.

First of all, `toPWM` allows the input matrix to have different column sums,
which means the count matrix can have an unequal number of sequences contributing
to each column. This scenario is rare, but exists in JASPAR SELEX data.

Second, we can specify customized *pseudocounts*.
*pseudocounts* is necessary for correcting the small number of counts
or eliminating the zero values before log transformation.
In TFBS perl module, the square root of the number of sequences contributing to each column.
However, it has been shown to too harsh (Nishida, Frith, and Nakai [2009](#ref-nishida_pseudocounts_2009)).
Hence, a default value of 0.8 is used.
Of course, it can be changed to other customized value or even different values for each column.

```
pwm <- toPWM(pfm, pseudocounts=0.8)
pwm
#> An object of class PWMatrix
#> ID: MA0004.1
#> Name: Arnt
#> Matrix Class: Zipper-Type
#> strand: +
#> Pseudocounts: 0.8
#> Tags:
#> $family
#> [1] "Helix-Loop-Helix"
#>
#> $species
#> [1] "10090"
#>
#> $tax_group
#> [1] "vertebrates"
#>
#> $medline
#> [1] "7592839"
#>
#> $type
#> [1] "SELEX"
#>
#> $ACC
#> [1] "P53762"
#>
#> $pazar_tf_id
#> [1] "TF0000003"
#>
#> $TFBSshape_ID
#> [1] "11"
#>
#> $TFencyclopedia_ID
#> [1] "580"
#>
#> Background:
#>    A    C    G    T
#> 0.25 0.25 0.25 0.25
#> Matrix:
#>         [,1]      [,2]      [,3]      [,4]      [,5]      [,6]
#> A -0.3081223  1.884523 -4.700440 -4.700440 -4.700440 -4.700440
#> C  1.6394103 -4.700440  1.957772 -4.700440 -4.700440 -4.700440
#> G -4.7004397 -2.115477 -4.700440  1.957772 -4.700440  1.957772
#> T -4.7004397 -4.700440 -4.700440 -4.700440  1.957772 -4.700440
```

## 4.2 PFM to ICM

The method `toICM` can convert PFM to ICM (Schneider et al. [1986](#ref-schneider_information_1986)).
Besides the similar *pseudocounts*, *bg*,
you can also choose to do the *schneider* correction.

The information content matrix has a column sum between 0 (no base preference)
and 2 (only 1 base used).
Usually this information is used to plot sequence log.

How a PFM is converted to ICM: we have the PFM matrix \(x\),
base backrgound frequency \(bg\), \(pseudocounts\) for correction.

\[Z[j] = \sum\_{i=1}^{4} x[i,j]\]

\[p[i,j] = {(x[i,j] + bg[i] \times pseudocounts[j]) \over (Z[j] + \sum\_{i}bg[i] \times pseudocounts[j]}\]

\[D[j] = \log\_2{4} + \sum\_{i=1}^{4} p[i,j]\*\log{p[i,j]}\]

\[ICM[i,j] = p[i,j] \times D[j]\]

```
icm <- toICM(pfm, pseudocounts=0.8, schneider=TRUE)
icm
#> An object of class ICMatrix
#> ID: MA0004.1
#> Name: Arnt
#> Matrix Class: Zipper-Type
#> strand: +
#> Pseudocounts: 0.8
#> Schneider correction: TRUE
#> Tags:
#> $family
#> [1] "Helix-Loop-Helix"
#>
#> $species
#> [1] "10090"
#>
#> $tax_group
#> [1] "vertebrates"
#>
#> $medline
#> [1] "7592839"
#>
#> $type
#> [1] "SELEX"
#>
#> $ACC
#> [1] "P53762"
#>
#> $pazar_tf_id
#> [1] "TF0000003"
#>
#> $TFBSshape_ID
#> [1] "11"
#>
#> $TFencyclopedia_ID
#> [1] "580"
#>
#> Background:
#>    A    C    G    T
#> 0.25 0.25 0.25 0.25
#> Matrix:
#>          [,1]       [,2]       [,3]       [,4]       [,5]       [,6]
#> A 0.203985791 1.30439694 0.01588159 0.01588159 0.01588159 0.01588159
#> C 0.786802337 0.01358747 1.60404024 0.01588159 0.01588159 0.01588159
#> G 0.009713609 0.08152481 0.01588159 1.60404024 0.01588159 1.60404024
#> T 0.009713609 0.01358747 0.01588159 0.01588159 1.60404024 0.01588159
```

To plot the sequence logo, we use the package *[seqlogo](https://bioconductor.org/packages/3.22/seqlogo)*.
In sequence logo, each position gives the information content obtained
for each nucleotide.
The higher of the letter corresponding to a nucleotide,
the larger information content and higher probability of getting that nucleotide
at that position.

```
seqLogo(icm)
```

![](data:image/png;base64...)

## 4.3 Align PFM to a custom matrix or IUPAC string

In some cases, it is beneficial to assess similarity of existing profile matrices,
such as JASPAR, to a newly discovered matrix
(as with using BLAST for sequence data comparison when using Genbank).

*[TFBSTools](https://bioconductor.org/packages/3.22/TFBSTools)* provides tools for comparing pairs of PFMs,
or a PFM with IUPAC string, using a modified Needleman-Wunsch algorithm
(Sandelin et al. [2003](#ref-sandelin_integrated_2003)).

```
## one to one comparison
data(MA0003.2)
data(MA0004.1)
pfmSubject <- MA0003.2
pfmQuery <-  MA0004.1
PFMSimilarity(pfmSubject, pfmQuery)
#>     score  relScore
#>  7.294736 60.789466

## one to several comparsion
PFMSimilarity(pfmList, pfmQuery)
#> $pfm1
#>    score relScore
#>       12      100
#>
#> $pfm2
#>    score relScore
#>       12      100

## align IUPAC string
IUPACString <- "ACGTMRWSYKVHDBN"
PFMSimilarity(pfmList, IUPACString)
#> $pfm1
#>    score relScore
#>  8.81500 73.45833
#>
#> $pfm2
#>    score relScore
#>  8.81500 73.45833
```

## 4.4 PWM similarity

To measure the similarity of two PWM matrix in three measurements:
*normalised Euclidean distance*, *Pearson correlation*
and *Kullback Leibler divergence* (Linhart, Halperin, and Shamir [2008](#ref-linhart_transcription_2008)).
Given two PWMs in probability type, \(P^1\) and \(P^2\), where \(l\) is the length.
\(P^j\_{i,b}\) is the values in column \(i\) with base \(b\) in PWM \(j\).
The normalised Euclidean distance is computed in

\[ D(P^1, P^2) = {1 \over {\sqrt{2}l}} \cdot \sum\_{i=1}^{l} \sqrt{\sum\_{b \in {\{A,C,G,T\}}} (P\_{i,b}^1-P\_{i,b}^2)^2}\]

This distance is between 0 (perfect identity) and 1 (complete dis-similarity).

The pearson correlation coefficient is computed in

\[ r(P^1, P^2) = {1 \over l} \cdot \sum\_{i=1}^l {\sum\_{b \in \{A,C,G,T\}} (P\_{i,b}^1 - 0.25)(P\_{i,b}^2-0.25) \over \sqrt{\sum\_{b \in \{A,C,G,T\}} (P\_{i,b}^1 - 0.25)^2 \cdot \sum\_{b \in \{A,C,G,T\}} (P\_{i,b}^2 - 0.25)^2}}\]

The Kullback-Leibler divergence is computed in

\[KL(P^1, P^2) = {1 \over {2l}} \cdot \sum\_{i=1}^l \sum\_{b \in \{A,C,G,T\}} (P\_{i,b}^1\log{ P\_{i,b}^1 \over P\_{i,b}^2}+ P\_{i,b}^2\log{P\_{i,b}^2 \over {P\_{i,b}^1}})\]

```
data(MA0003.2)
data(MA0004.1)
pwm1 <- toPWM(MA0003.2, type="prob")
pwm2 <- toPWM(MA0004.1, type="prob")
PWMSimilarity(pwm1, pwm2, method="Euclidean")
#> [1] 0.5134956
PWMSimilarity(pwm1, pwm2, method="Pearson")
#> [1] 0.2828507
PWMSimilarity(pwm1, pwm2, method="KL")
#> [1] 2.385866
```

## 4.5 Dynamic random profile generation

In this section, we will demonstrate the capability of random profile matrices generation with matrix permutation and probabilitis sampling.
In many computational/simulation studies,
it is particularly desired to have a set of random matrices.
Some cases includes the estimation of distance between putative TFBS
and transcription start site, the evaluation of comparison between matrices (Bryne et al. [2008](#ref-bryne_jaspar_2008)).
These random matrices are expected to have same statistical properties with
the selcted profiles, such as nucleotide content or information content.

The permutation method is relatively easy.
It simply shuffles the columns either constrainted in each matrix, or columns almong all selected matrices.
The probabilistic sampling is more complicated and can be done in two steps:

1. A Dirichlet multinomial mixture model is trained on all available matrices in JASPAR.
2. Random columns are sampled from the posterior distribution of the trained Dirichlet model based on selected profiles.

```
## Matrice permutation
permuteMatrix(pfmQuery)
#> An object of class PFMatrix
#> ID: MA0004.1
#> Name: Arnt
#> Matrix Class: Zipper-Type
#> strand: +
#> Tags:
#> $comment
#> [1] "-"
#>
#> $family
#> [1] "Helix-Loop-Helix"
#>
#> $medline
#> [1] "7592839"
#>
#> $pazar_tf_id
#> [1] "TF0000003"
#>
#> $tax_group
#> [1] "vertebrates"
#>
#> $tfbs_shape_id
#> [1] "11"
#>
#> $tfe_id
#> [1] "580"
#>
#> $type
#> [1] "SELEX"
#>
#> $collection
#> [1] "CORE"
#>
#> $species
#> [1] "10090"
#>
#> $acc
#> [1] "P53762"
#>
#> Background:
#>    A    C    G    T
#> 0.25 0.25 0.25 0.25
#> Matrix:
#>   [,1] [,2] [,3] [,4] [,5] [,6]
#> A   19    0    0    4    0    0
#> C    0    0    0   16    0   20
#> G    1    0   20    0   20    0
#> T    0   20    0    0    0    0
permuteMatrix(pfmList, type="intra")
#> PFMatrixList of length 2
#> names(2): pfm1 pfm2
permuteMatrix(pfmList, type="inter")
#> PFMatrixList of length 2
#> names(2): pfm1 pfm2
```

```
## Dirichlet model training
data(MA0003.2)
data(MA0004.1)
pfmList <- PFMatrixList(pfm1=MA0003.2, pfm2=MA0004.1, use.names=TRUE)
dmmParameters <- dmmEM(pfmList, K=6, alg="C")
## Matrice sampling from trained Dirichlet model
pwmSampled <- rPWMDmm(MA0003.2, dmmParameters$alpha0, dmmParameters$pmix,
                      N=1, W=6)
```

# 5 TFFM methods

## 5.1 The graphical representation of TFFM

Basic PWMs can be graphically represented by the sequence logos shown above.
A novel graphical representation of TFFM is requied for
taking the dinucleotide dependence into account.

For the upper part of the sequence logo,
we represent the nucleotide probabilities
at position \(p\) for each possible nucleotide at position \(p-1\).
Hence, each column represents a position within a TFBS and
each row the nucleotide probabilities found at that position.
Each row assumes a specific nucleotide has been emitted
by the previous hidden state.
The intersection between a column corresponding to position \(p\) and
row corresponding to nucleotide \(n\) gives the probabilities of
getting each nucleotide at position \(p\) if \(n\) has been seen at position \(p-1\).
The opacity to represent the sequence logo is proportional to
the probablity of possible row to be used by the TFFM.

```
  ## sequence logo for First-order TFFM
  seqLogo(tffmFirst)
```

![](data:image/png;base64...)

```
  ## sequence logo for detailed TFFM
  seqLogo(tffmDetail)
```

![](data:image/png;base64...)

# 6 Scan sequence and alignments with PWM pattern

## 6.1 searchSeq

`searchSeq` scans a nucleotide sequence with the pattern represented in the PWM.
The strand argument controls which strand of the sequence will be searched.
When it is \_\*\_, both strands will be scanned.

A `SiteSet` object will be returned which can be exported into
GFF3 or GFF2 format.
Empirical p-values for the match scores can be calculated by an exact method
from *[TFMPvalue](https://CRAN.R-project.org/package%3DTFMPvalue)* or the distribution of sampled scores.

```
library(Biostrings)
data(MA0003.2)
data(MA0004.1)
pwmList <- PWMatrixList(MA0003.2=toPWM(MA0003.2), MA0004.1=toPWM(MA0004.1),
                        use.names=TRUE)
subject <- DNAString("GAATTCTCTCTTGTTGTAGTCTCTTGACAAAATG")
siteset <- searchSeq(pwm, subject, seqname="seq1", min.score="60%", strand="*")

sitesetList <- searchSeq(pwmList, subject, seqname="seq1",
                         min.score="60%", strand="*")

## generate gff2 or gff3 style output
head(writeGFF3(siteset))
#>   seqname source feature start end     score strand frame
#> 1    seq1   TFBS    TFBS     8  13 -1.888154      +     .
#> 2    seq1   TFBS    TFBS    21  26 -1.888154      +     .
#> 3    seq1   TFBS    TFBS    29  34 -3.908935      +     .
#> 4    seq1   TFBS    TFBS     8  13 -1.961403      -     .
#> 5    seq1   TFBS    TFBS    10  15 -3.908935      -     .
#> 6    seq1   TFBS    TFBS    21  26 -1.961403      -     .
#>                                  attributes
#> 1 TF=Arnt;class=Zipper-Type;sequence=CTCTTG
#> 2 TF=Arnt;class=Zipper-Type;sequence=CTCTTG
#> 3 TF=Arnt;class=Zipper-Type;sequence=AAAATG
#> 4 TF=Arnt;class=Zipper-Type;sequence=CAAGAG
#> 5 TF=Arnt;class=Zipper-Type;sequence=AACAAG
#> 6 TF=Arnt;class=Zipper-Type;sequence=CAAGAG
head(writeGFF3(sitesetList))
#>            seqname source feature start end      score strand frame
#> MA0003.2      seq1   TFBS    TFBS    18  32 -16.437682      -     .
#> MA0004.1.1    seq1   TFBS    TFBS     8  13  -1.888154      +     .
#> MA0004.1.2    seq1   TFBS    TFBS    21  26  -1.888154      +     .
#> MA0004.1.3    seq1   TFBS    TFBS    29  34  -3.908935      +     .
#> MA0004.1.4    seq1   TFBS    TFBS     8  13  -1.961403      -     .
#> MA0004.1.5    seq1   TFBS    TFBS    10  15  -3.908935      -     .
#>                                                      attributes
#> MA0003.2   TF=TFAP2A;class=Zipper-Type;sequence=TTTTGTCAAGAGACT
#> MA0004.1.1            TF=Arnt;class=Zipper-Type;sequence=CTCTTG
#> MA0004.1.2            TF=Arnt;class=Zipper-Type;sequence=CTCTTG
#> MA0004.1.3            TF=Arnt;class=Zipper-Type;sequence=AAAATG
#> MA0004.1.4            TF=Arnt;class=Zipper-Type;sequence=CAAGAG
#> MA0004.1.5            TF=Arnt;class=Zipper-Type;sequence=AACAAG
head(writeGFF2(siteset))
#>   seqname source feature start end     score strand frame
#> 1    seq1   TFBS    TFBS     8  13 -1.888154      +     .
#> 2    seq1   TFBS    TFBS    21  26 -1.888154      +     .
#> 3    seq1   TFBS    TFBS    29  34 -3.908935      +     .
#> 4    seq1   TFBS    TFBS     8  13 -1.961403      -     .
#> 5    seq1   TFBS    TFBS    10  15 -3.908935      -     .
#> 6    seq1   TFBS    TFBS    21  26 -1.961403      -     .
#>                                          attributes
#> 1 TF "Arnt"; class "Zipper-Type"; sequence "CTCTTG"
#> 2 TF "Arnt"; class "Zipper-Type"; sequence "CTCTTG"
#> 3 TF "Arnt"; class "Zipper-Type"; sequence "AAAATG"
#> 4 TF "Arnt"; class "Zipper-Type"; sequence "CAAGAG"
#> 5 TF "Arnt"; class "Zipper-Type"; sequence "AACAAG"
#> 6 TF "Arnt"; class "Zipper-Type"; sequence "CAAGAG"

## get the relative scores
relScore(siteset)
#> [1] 0.6652185 0.6652185 0.6141340 0.6633668 0.6141340 0.6633668
relScore(sitesetList)
#> $MA0003.2
#> [1] 0.6196884
#>
#> $MA0004.1
#> [1] 0.6652185 0.6652185 0.6141340 0.6633668 0.6141340 0.6633668

## calculate the empirical p-values of the scores
pvalues(siteset, type="TFMPvalue")
#> [1] 0.02734375 0.02734375 0.04638672 0.04052734 0.04638672 0.04052734
pvalues(siteset, type="sampling")
#> [1] 0.0261 0.0261 0.0551 0.0397 0.0551 0.0397
```

## 6.2 searchAln

`searchAln` scans a pairwise alignment with the pattern
represented by the PWM.
It reports only those hits that are present in equivalent positions of both sequences
and exceed a specified threshold score in both,
AND are found in regions of the alignment above the specified.

```
library(Biostrings)
data(MA0003.2)
pwm <- toPWM(MA0003.2)
aln1 <- DNAString("ACTTCACCAGCTCCCTGGCGGTAAGTTGATC---AAAGG---AAACGCAAAGTTTTCAAG")
aln2 <- DNAString("GTTTCACTACTTCCTTTCGGGTAAGTAAATATATAAATATATAAAAATATAATTTTCATC")
sitePairSet <- searchAln(pwm, aln1, aln2, seqname1="seq1", seqname2="seq2",
                         min.score="50%", cutoff=0.5,
                         strand="*", type="any")
## generate gff style output
head(writeGFF3(sitePairSet))
#>   seqname source feature start end      score strand frame
#> 1    seq1   TFBS    TFBS     6  20  -9.515444      +     .
#> 2    seq1   TFBS    TFBS     7  21 -13.348617      +     .
#> 3    seq1   TFBS    TFBS     8  22 -13.182322      +     .
#> 4    seq1   TFBS    TFBS     9  23  -3.729917      +     .
#> 5    seq1   TFBS    TFBS    10  24  -7.677850      +     .
#> 6    seq1   TFBS    TFBS    14  28 -20.774619      +     .
#>                                             attributes
#> 1 TF=TFAP2A;class=Zipper-Type;sequence=ACCAGCTCCCTGGCG
#> 2 TF=TFAP2A;class=Zipper-Type;sequence=CCAGCTCCCTGGCGG
#> 3 TF=TFAP2A;class=Zipper-Type;sequence=CAGCTCCCTGGCGGT
#> 4 TF=TFAP2A;class=Zipper-Type;sequence=AGCTCCCTGGCGGTA
#> 5 TF=TFAP2A;class=Zipper-Type;sequence=GCTCCCTGGCGGTAA
#> 6 TF=TFAP2A;class=Zipper-Type;sequence=CCTGGCGGTAAGTTG
head(writeGFF2(sitePairSet))
#>   seqname source feature start end      score strand frame
#> 1    seq1   TFBS    TFBS     6  20  -9.515444      +     .
#> 2    seq1   TFBS    TFBS     7  21 -13.348617      +     .
#> 3    seq1   TFBS    TFBS     8  22 -13.182322      +     .
#> 4    seq1   TFBS    TFBS     9  23  -3.729917      +     .
#> 5    seq1   TFBS    TFBS    10  24  -7.677850      +     .
#> 6    seq1   TFBS    TFBS    14  28 -20.774619      +     .
#>                                                     attributes
#> 1 TF "TFAP2A"; class "Zipper-Type"; sequence "ACCAGCTCCCTGGCG"
#> 2 TF "TFAP2A"; class "Zipper-Type"; sequence "CCAGCTCCCTGGCGG"
#> 3 TF "TFAP2A"; class "Zipper-Type"; sequence "CAGCTCCCTGGCGGT"
#> 4 TF "TFAP2A"; class "Zipper-Type"; sequence "AGCTCCCTGGCGGTA"
#> 5 TF "TFAP2A"; class "Zipper-Type"; sequence "GCTCCCTGGCGGTAA"
#> 6 TF "TFAP2A"; class "Zipper-Type"; sequence "CCTGGCGGTAAGTTG"

## search the Axt alignment
# library(CNEr)
# axtFilesHg19DanRer7 <- file.path(system.file("extdata", package="TFBSTools"),
#                                  "hg19.danRer7.net.axt")
# axtHg19DanRer7 <- readAxt(axtFilesHg19DanRer7)
# sitePairSet <-  searchAln(pwm, axtHg19DanRer7, min.score="80%",
#                           windowSize=51L, cutoff=0.7, strand="*",
#                           type="any", conservation=NULL, mc.cores=1)
# GRangesTFBS <- toGRangesList(sitePairSet, axtHg19DanRer7)
# GRangesTFBS$targetTFBS
# GRangesTFBS$queryTFBS
```

## 6.3 searchPairBSgenome

`searchPairBSgenome` is designed to do the genome-wise phylogenetic footprinting.
Given two `BSgenome`, a chain file for liftover from one genome to another,
`searchPairBSgenome` identifies the putative transcription factor binding sites
which are conserved in both genomes.

```
library(rtracklayer)
library(JASPAR2014)
library(BSgenome.Hsapiens.UCSC.hg19)
library(BSgenome.Mmusculus.UCSC.mm10)
pfm <- getMatrixByID(JASPAR2014, ID="MA0004.1")
pwm <- toPWM(pfm)
chain <- import.chain("Downloads/hg19ToMm10.over.chain")
sitePairSet <- searchPairBSgenome(pwm, BSgenome.Hsapiens.UCSC.hg19,
                                 BSgenome.Mmusculus.UCSC.mm10,
                                 chr1="chr1", chr2="chr1",
                                 min.score="90%", strand="+", chain=chain)
```

# 7 Use *de novo* motif discovery software

In this section, we will introduce wrapper functions for external motif discovery programs.
So far, *MEME* is supported.
## *MEME*
`runMEME` takes a `DNAStringSet` or a set of `characters` as input,
and returns a `MotifSet` object.

```
motifSet <- runMEME(file.path(system.file("extdata",
                                          package="TFBSTools"), "crp0.s"),
                    binary="meme",
                    arguments=list("-nmotifs"=3)
                   )
## Get the sites sequences and surrounding sequences
sitesSeq(motifSet, type="all")
## Get the sites sequences only
sitesSeq(motifSet, type="none")
consensusMatrix(motifSet)
```

# 8 Session info

Here is the output of `sessionInfo()` on the system on which this
document was compiled:

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] JASPAR2014_1.45.0   Biostrings_2.78.0   Seqinfo_1.0.0
#>  [4] XVector_0.50.0      IRanges_2.44.0      S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0 generics_0.1.4      TFBSTools_1.48.0
#> [10] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DirichletMultinomial_1.52.0 SummarizedExperiment_1.40.0
#>  [3] rjson_0.2.23                xfun_0.53
#>  [5] bslib_0.9.0                 caTools_1.18.3
#>  [7] Biobase_2.70.0              lattice_0.22-7
#>  [9] vctrs_0.6.5                 tools_4.5.1
#> [11] bitops_1.0-9                curl_7.0.0
#> [13] parallel_4.5.1              RSQLite_2.4.3
#> [15] blob_1.2.4                  pkgconfig_2.0.3
#> [17] Matrix_1.7-4                BSgenome_1.78.0
#> [19] cigarillo_1.0.0             lifecycle_1.0.4
#> [21] compiler_4.5.1              Rsamtools_2.26.0
#> [23] tinytex_0.57                codetools_0.2-20
#> [25] htmltools_0.5.8.1           sass_0.4.10
#> [27] RCurl_1.98-1.17             yaml_2.3.10
#> [29] crayon_1.5.3                jquerylib_0.1.4
#> [31] BiocParallel_1.44.0         cachem_1.1.0
#> [33] DelayedArray_0.36.0         magick_2.9.0
#> [35] abind_1.4-8                 gtools_3.9.5
#> [37] digest_0.6.37               restfulr_0.0.16
#> [39] bookdown_0.45               fastmap_1.2.0
#> [41] grid_4.5.1                  SparseArray_1.10.0
#> [43] cli_3.6.5                   magrittr_2.0.4
#> [45] S4Arrays_1.10.0             XML_3.99-0.19
#> [47] TFMPvalue_0.0.9             bit64_4.6.0-1
#> [49] rmarkdown_2.30              pwalign_1.6.0
#> [51] httr_1.4.7                  matrixStats_1.5.0
#> [53] bit_4.6.0                   memoise_2.0.1
#> [55] evaluate_1.0.5              knitr_1.50
#> [57] GenomicRanges_1.62.0        BiocIO_1.20.0
#> [59] rtracklayer_1.70.0          rlang_1.1.6
#> [61] Rcpp_1.1.0                  DBI_1.2.3
#> [63] BiocManager_1.30.26         seqLogo_1.76.0
#> [65] jsonlite_2.0.0              R6_2.6.1
#> [67] MatrixGenerics_1.22.0       GenomicAlignments_1.46.0
```

# 9 References

Bailey, T L, and C Elkan. 1994. “Fitting a Mixture Model by Expectation Maximization to Discover Motifs in Biopolymers.” *Proc Int Conf Intell Syst Mol Biol* 2: 28–36.

Bryne, Jan Christian, Eivind Valen, Man-Hung Eric Tang, Troels Marstrand, Ole Winther, Isabelle da Piedade, Anders Krogh, Boris Lenhard, and Albin Sandelin. 2008. “JASPAR, the Open Access Database of Transcription Factor-Binding Profiles: New Content and Tools in the 2008 Update.” *Nucleic Acids Res.* 36 (Database issue): D102–106. <https://doi.org/10.1093/nar/gkm955>.

Lenhard, Boris, and Wyeth W Wasserman. 2002. “TFBS: Computational Framework for Transcription Factor Binding Site Analysis.” *Bioinformatics* 18 (8): 1135–6.

Linhart, Chaim, Yonit Halperin, and Ron Shamir. 2008. “Transcription Factor and microRNA Motif Discovery: The Amadeus Platform and a Compendium of Metazoan Target Sets.” *Genome Res.* 18 (7): 1180–9. <https://doi.org/10.1101/gr.076117.108>.

Mathelier, Anthony, and Wyeth W Wasserman. 2013. “The Next Generation of Transcription Factor Binding Site Prediction.” *PLoS Comput. Biol.* 9 (9): e1003214. <https://doi.org/10.1371/journal.pcbi.1003214>.

Nishida, Keishin, Martin C Frith, and Kenta Nakai. 2009. “Pseudocounts for Transcription Factor Binding Sites.” *Nucleic Acids Res.* 37 (3): 939–44. <https://doi.org/10.1093/nar/gkn1019>.

Sandelin, Albin, Annette Höglund, Boris Lenhard, and Wyeth W Wasserman. 2003. “Integrated Analysis of Yeast Regulatory Sequences for Biologically Linked Clusters of Genes.” *Funct. Integr. Genomics* 3 (3): 125–34. <https://doi.org/10.1007/s10142-003-0086-6>.

Schneider, T D, G D Stormo, L Gold, and A Ehrenfeucht. 1986. “Information Content of Binding Sites on Nucleotide Sequences.” *J. Mol. Biol.* 188 (3): 415–31.

Wasserman, Wyeth W, and Albin Sandelin. 2004. “Applied bioinformatics for the identification of regulatory elements.” *Nature Publishing Group* 5 (4): 276–87.

# Appendix