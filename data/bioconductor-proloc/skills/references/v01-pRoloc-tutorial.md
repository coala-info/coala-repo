# Using pRoloc for spatial proteomics data analysis

Lisa M. Breckels1 and Laurent Gatto2

1Cambridge Centre for Proteomics, University of Cambridge, UK
2de Duve Institute, UCLouvain, Belgium

#### 30 October 2025

#### Abstract

This tutorial illustrates the usage of the `pRoloc` R package for the analysis and interpretation of spatial proteomics data. It walks the reader through the creation of *MSnSet* instances, that hold the quantitative proteomics data and meta-data and introduces several aspects of data analysis, including data visualisation and application of machine learning to predict protein localisation.

#### Package

pRoloc 1.50.0

# Foreword

*[MSnbase](http://bioconductor.org/packages/MSnbase)* and
*[pRoloc](http://bioconductor.org/packages/pRoloc)* are under active
developed; current functionality is evolving and new features are
added on a regular basis. This software is free and open-source
software. If you use it, please support the project by citing it in
publications:

> Gatto L. and Lilley K.S. *MSnbase - an R/Bioconductor package for
> isobaric tagged mass spectrometry data visualization, processing and
> quantitation*. [Bioinformatics 28, 288-289 (2011)](https://academic.oup.com/bioinformatics/article-lookup/doi/10.1093/bioinformatics/btr645).

> Gatto L, Breckels LM, Wieczorek S, Burger T, Lilley
> KS. *Mass-spectrometry-based spatial proteomics data analysis using
> pRoloc and pRolocdata.*
> [Bioinformatics. 2014 May 1;30(9):1322-4.](https://academic.oup.com/bioinformatics/article-lookup/doi/10.1093/bioinformatics/btu013).

> Breckels LM, Mulvey CM, Lilley KS and Gatto L. A Bioconductor
> workflow for processing and analysing spatial proteomics
> data. F1000Research 2016, 5:2926
> [doi: 10.12688/f1000research.10411.1](https://f1000research.com/articles/5-2926/).

If you are using the *phenoDisco* function, please also cite

> Breckels L.M., Gatto L., Christoforou A., Groen A.J., Kathryn Lilley
> K.S. and Trotter M.W. *The effect of organelle discovery upon
> sub-cellular protein localisation.* J Proteomics,
> [S1874-3919(13)00094-8 (2013)](http://www.sciencedirect.com/science/article/pii/S1874391913000948).

If you are using any of the transfer learning functions, please also
cite

> Breckels LM, Holden S, Wonjar D, Mulvey CM, Christoforou A, Groen A,
> Trotter MW, Kohlbacker O, Lilley KS and Gatto L (2016). *Learning
> from heterogeneous data sources: an application in spatial
> proteomics*. PLoS Comput Biol 13;12(5):e1004920. doi:
> [10.1371/journal.pcbi.1004920](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004920).

If you are using any of the Bayesian generative models, please also
cite

> A Bayesian Mixture Modelling Approach For Spatial Proteomics Oliver
> M Crook, Claire M Mulvey, Paul D. W. Kirk, Kathryn S Lilley, Laurent
> Gatto bioRxiv 282269; doi: <https://doi.org/10.1101/282269>

For an introduction to spatial proteomics data analysis:

> Gatto L, Breckels LM, Burger T, Nightingale DJ, Groen AJ, Campbell
> C, Nikolovski N, Mulvey CM, Christoforou A, Ferro M, Lilley KS. *A
> foundation for reliable spatial proteomics data analysis*. Mol Cell
> Proteomics. [2014 Aug;13(8):1937-52](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4125728/). doi:
> 10.1074/mcp.M113.036350.

The *[pRoloc](http://bioconductor.org/packages/pRoloc)* package
contains additional vignettes and reference material:

* *pRoloc-tutorial*: pRoloc tutorial (this vignette).
* *pRoloc-ml*: Machine learning techniques available in pRoloc.
* *pRoloc-transfer-learning*: A transfer learning algorithm for spatial proteomics.
* *pRoloc-bayesian*: Bayesian spatial proteomics with pRoloc.

# Questions and bugs

You are welcome to contact me directly about *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)*.
For bugs, typos, suggestions or other questions, please file an issue
in our issue tracking system
(<https://github.com/lgatto/pRoloc/issues>) providing as much
information as possible, a reproducible example and the output of
`sessionInfo()`.

If you wish to reach a broader audience for general questions about
proteomics analysis using `R`, you may want to use the Bioconductor
support site: <https://support.bioconductor.org/>.

# 1 Introduction

## 1.1 Spatial proteomics

Spatial (or organelle) proteomics is the study of the localisation of
proteins inside cells. The sub-cellular compartment can be organelles,
i.e. structures defined by lipid bi-layers,macro-molecular assemblies
of proteins and nucleic acids or large protein complexes. In this
document, we will focus on mass-spectrometry based approaches that
assay a population of cells, as opposed as microscopy based techniques
that monitor single cells, as the former is the primary concern of
*[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)*, although the techniques described below and the
infrastructure in place could also be applied the processed image
data. The typical experimental use-case for using *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* is
a set of fractions, originating from a total cell lysate. These
fractions can originate from a continuous gradient, like in the LOPIT
(Dunkley et al. [2006](#ref-Dunkley2006)) or PCP (Foster et al. [2006](#ref-Foster2006)) approaches, or can be
discrete fractions. The content of the fractions is then identified
and quantified (using labelled or un-labelled quantitation
techniques). Using relative quantitation of known organelle residents,
termed organelle markers, organelle-specific profiles along the
gradient are determined and new residents are identified based on
matching of these distribution profiles. See for example
(Gatto et al. [2010](#ref-Gatto2010)) and references therein for a detailed review on
organelle proteomics.

It should be noted that large protein complexes, that are not
necessarily separately enclosed within their own lipid bi-layer, can
be detected by such techniques, as long as a distinct profile can be
defined across the fractions.

## 1.2 About R and *pRoloc*

R (R Development Core Team [2011](#ref-Rstat)) is a statistical programming language and interactive
working environment. It can be expanded by so-called packages to
confer new functionality to users. Many such packages have been
developed for the analysis of high-throughput biology, notably through
the Bioconductor project (Gentleman et al. [2004](#ref-Gentleman2004)). Two packages are of
particular interest here, namely *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* (Gatto and Lilley [2012](#ref-Gatto2012))
and *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)*. The former provides flexible infrastructure
to store and manipulate quantitative proteomics data and the
associated meta-data and the latter implements specific algorithmic
technologies to analyse organelle proteomics data.

Among the advantages of R are robust statistical procedures, good
visualisation capabilities, excellent documentation, reproducible
research111 The content of this document is compiled (the code is executed and its output, text and figures, is displayed dynamically) to generate the html file.,
power and flexibility of the R language and environment itself and a
rich environment for specialised functionality in many domains of
bioinformatics: tools for many omics technologies, including
proteomics, bio-statistics, gene ontology and biological pathway
analysis, … Although there exists some specific graphical user
interfaces (GUI), interaction with R is executed through a command
line interface. While this mode of interaction might look alien to new
users, experience has proven that after a first steep learning curve,
great results can be achieved by non-programmers. Furthermore,
specific and general documentation is plenty and beginners and
advanced course material are also widely available.

Once R is started, the first step to enable functionality of a
specific packages is to load them using the `library` function, as
shown in the code chunk below:

```
library("MSnbase")
library("pRoloc")
library("pRolocdata")
```

*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* implements the data containers that are used by
*[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)*. *[pRolocdata](https://bioconductor.org/packages/3.22/pRolocdata)* is a data package
that supplies several published organelle proteomics data sets.

# 2 Data structures

## 2.1 Example data

The data used in this tutorial has been published in
(Tan et al. [2009](#ref-Tan2009)). The LOPIT technique (Dunkley et al. [2006](#ref-Dunkley2006)) is used to
localise integral and associated membrane proteins in
*Drosophila melanogaster* embryos. Briefly, embryos were
collected at 0 – 16 hours, homogenised and centrifuged to collect the
supernatant, removing cell debris and nuclei. Membrane fractionation
was performed on a iodixanol gradient and fractions were quantified
using iTRAQ isobaric tags (Ross et al. [2004](#ref-Ross2004)) as follows: fractions 4/5,
114; fractions 12/13, 115; fraction 19, 116 and fraction 21,
117. Labelled peptides were then separated using cation exchange
chromatography and analysed by LS-MS/MS on a QSTAR XL
quadrupole-time-of-flight mass spectrometer (Applied Biosystems). The
original localisation analysis was performed using partial least
square discriminant analysis (PLS-DA). Relative quantitation data was
retrieved from the supplementary file `pr800866n_si_004.xls`
(<http://pubs.acs.org/doi/suppl/10.1021/pr800866n/suppl_file/pr800866n_si_004.xls>)
and imported into R as described below. We will concentrate on the
first replicate.

## 2.2 Importing and loading data

This section illustrates how to import data in comma-separated value
(csv) format into an appropriate R data structure. The first section
shows the original `csv` (comma separated values) spreadsheet, as
published by the authors, and how one can read such a file into
using the *read.csv* function. This spreadsheet file is similar to the
output of many quantitation software.

In the next section, we show 2 `csv` files containing a subset of the
columns of original `pr800866n_si_004-rep1.csv` file and another
short file, created manually, that will be used to create the
appropriate R data.

### 2.2.1 The original data file

```
## The original data for replicate 1, available
## from the pRolocdata package
f0 <- dir(system.file("extdata", package = "pRolocdata"),
      full.names = TRUE,
      pattern = "pr800866n_si_004-rep1.csv")
csv <- read.csv(f0)
```

The three first lines of the original spreadsheet, containing the data
for replicate one, are illustrated below (using the function
*head*). It contains 888 rows (proteins) and 16
columns, including protein identifiers, database accession numbers,
gene symbols, reporter ion quantitation values, information related to
protein identification, …

```
head(csv, n=3)
```

```
##   Protein.ID        FBgn Flybase.Symbol No..peptide.IDs Mascot.score
## 1    CG10060 FBgn0001104    G-ialpha65A               3       179.86
## 2    CG10067 FBgn0000044         Act57B               5       222.40
## 3    CG10077 FBgn0035720        CG10077               5       219.65
##   No..peptides.quantified area.114 area.115 area.116 area.117
## 1                       1 0.379000 0.281000 0.225000 0.114000
## 2                       9 0.420000 0.209667 0.206111 0.163889
## 3                       3 0.187333 0.167333 0.169667 0.476000
##   PLS.DA.classification Peptide.sequence Precursor.ion.mass
## 1                    PM
## 2                    PM
## 3
##   Precursor.ion.charge pd.2013 pd.markers
## 1                           PM    unknown
## 2                           PM    unknown
## 3                      unknown    unknown
```

### 2.2.2 From `csv` files to R data

There are several ways to create the desired R data object, termed
*MSnSet*, that will be used to perform the actual sub-cellular
localisation prediction. Here, we illustrate a method that uses
separate spreadsheet files for quantitation data, feature meta-data
and sample (fraction) meta-data and the `readMSnSet` constructor
function, that will hopefully be the most straightforward for new
users.

```
## The quantitation data, from the original data
f1 <- dir(system.file("extdata", package = "pRolocdata"),
      full.names = TRUE, pattern = "exprsFile.csv")
exprsCsv <- read.csv(f1)
## Feature meta-data, from the original data
f2 <- dir(system.file("extdata", package = "pRolocdata"),
      full.names = TRUE, pattern = "fdataFile.csv")
fdataCsv <- read.csv(f2)
## Sample meta-data, a new file
f3 <- dir(system.file("extdata", package = "pRolocdata"),
      full.names = TRUE, pattern = "pdataFile.csv")
pdataCsv <- read.csv(f3)
```

* `exprsFile.csv` containing the quantitation (expression) data for
  the 888 proteins and 4 reporter tags.

```
head(exprsCsv, n=3)
```

```
##          FBgn     X114     X115     X116     X117
## 1 FBgn0001104 0.379000 0.281000 0.225000 0.114000
## 2 FBgn0000044 0.420000 0.209667 0.206111 0.163889
## 3 FBgn0035720 0.187333 0.167333 0.169667 0.476000
```

* `fdataFile.csv` containing meta-data for the 888
  features (here proteins).

```
head(fdataCsv, n=3)
```

```
##          FBgn ProteinID FlybaseSymbol NoPeptideIDs MascotScore
## 1 FBgn0001104   CG10060   G-ialpha65A            3      179.86
## 2 FBgn0000044   CG10067        Act57B            5      222.40
## 3 FBgn0035720   CG10077       CG10077            5      219.65
##   NoPeptidesQuantified PLSDA
## 1                    1    PM
## 2                    9    PM
## 3                    3
```

* `pdataFile.csv` containing samples (here fractions) meta-data. This
  simple file has been created manually.

```
pdataCsv
```

```
##   sampleNames Fractions
## 1        X114       4/5
## 2        X115     12/13
## 3        X116        19
## 4        X117        21
```

A self-contained data structure, called *MSnSet* (defined in
the *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* package) can now easily be generated using the
*readMSnSet* constructor, providing the respective
`csv` file names shown above and specifying that the data is
comma-separated (with `sep = ","`). Below, we call that object
`tan2009r1` and display its content.

```
tan2009r1 <- readMSnSet(exprsFile = f1,
            featureDataFile = f2,
            phenoDataFile = f3,
            sep = ",")
tan2009r1
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 888 features, 4 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: X114 X115 X116 X117
##   varLabels: Fractions
##   varMetadata: labelDescription
## featureData
##   featureNames: FBgn0001104 FBgn0000044 ... FBgn0001215 (888 total)
##   fvarLabels: ProteinID FlybaseSymbol ... PLSDA (6 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
## Quantitation data loaded: Thu Oct 30 01:50:19 2025  using readMSnSet.
##  MSnbase version: 2.36.0
```

## 2.3 A shorter input work flow

The `readMSnSet2` function provides a simplified import pipeline. It
takes a single spreadsheet as input (default is `csv`) and extract the
columns identified by `ecol` to create the expression data, while the
others are used as feature meta-data. `ecol` can be a `character` with
the respective column labels or a numeric with their indices. In the
former case, it is important to make sure that the names match
exactly. Special characters like `'-'` or `'('` will be transformed by
R into `'.'` when the `csv` file is read in. Optionally, one can also
specify a column to be used as feature names. Note that these must be
unique to guarantee the final object validity.

```
ecol <- paste("area", 114:117, sep = ".")
fname <- "Protein.ID"
eset <- readMSnSet2(f0, ecol, fname)
eset
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 888 features, 4 samples
##   element names: exprs
## protocolData: none
## phenoData: none
## featureData
##   featureNames: CG10060 CG10067 ... CG9983 (888 total)
##   fvarLabels: Protein.ID FBgn ... pd.markers (12 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
##  MSnbase version: 2.36.0
```

The `ecol` columns can also be queried interactively from R using the
`getEcols` and `grepEcols` function. The former return a character
with all column names, given a splitting character, i.e. the
separation value of the spreadsheet (typically `","` for `csv`,
`"\t"` for `tsv`, …). The latter can be used to grep a
pattern of interest to obtain the relevant column indices.

```
getEcols(f0, ",")
```

```
##  [1] "\"Protein ID\""              "\"FBgn\""
##  [3] "\"Flybase Symbol\""          "\"No. peptide IDs\""
##  [5] "\"Mascot score\""            "\"No. peptides quantified\""
##  [7] "\"area 114\""                "\"area 115\""
##  [9] "\"area 116\""                "\"area 117\""
## [11] "\"PLS-DA classification\""   "\"Peptide sequence\""
## [13] "\"Precursor ion mass\""      "\"Precursor ion charge\""
## [15] "\"pd.2013\""                 "\"pd.markers\""
```

```
grepEcols(f0, "area", ",")
```

```
## [1]  7  8  9 10
```

```
e <- grepEcols(f0, "area", ",")
readMSnSet2(f0, e)
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 888 features, 4 samples
##   element names: exprs
## protocolData: none
## phenoData: none
## featureData
##   featureNames: 1 2 ... 888 (888 total)
##   fvarLabels: Protein.ID FBgn ... pd.markers (12 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
##  MSnbase version: 2.36.0
```

The `phenoData` slot can now be updated accordingly using the
replacement functions `phenoData<-` or `pData<-` (see `?MSnSet` for
details).

### 2.3.1 The *MSnSet* class

Although there are additional specific sub-containers for additional
meta-data (for instance to make the object MIAPE compliant), the
feature (the sub-container, or slot `featureData`) and sample (the
`phenoData` slot) are the most important ones. They need to meet the
following validity requirements (see [figure below](#fig:msnset)):

* the number of row in the expression/quantitation data and feature
  data must be equal and the row names must match exactly, and
* the number of columns in the expression/quantitation data and number
  of row in the sample meta-data must be equal and the column/row
  names must match exactly.

It is common, in the context of *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* to update the
feature meta-data (described in section [5](#sec:analysis)) by adding
new columns, without breaking the objects validity. Similarly, the
sample meta-data can also be updated by adding new sample variables. A
detailed description of the `MSnSet` class is available by typing
`?MSnSet` in the R console.

![](data:image/png;base64...)

Dimension requirements for the respective expression, feature and sample meta-data slots.

The individual parts of this data object can be accessed with their
respective accessor methods:

* the quantitation data can be retrieved with `exprs(tan2009r1)`,
* the feature meta-data with `fData(tan2009r1)` and
* the sample meta-data with `pData(tan2009r1)`.

The advantage of this structure is that it can be manipulated as a
whole and the respective parts of the data object will remain
compatible. The code chunk below, for example, shows how to extract
the first 5 proteins and 2 first samples:

```
smallTan <- tan2009r1[1:5, 1:2]
dim(smallTan)
```

```
## [1] 5 2
```

```
exprs(smallTan)
```

```
##                 X114     X115
## FBgn0001104 0.379000 0.281000
## FBgn0000044 0.420000 0.209667
## FBgn0035720 0.187333 0.167333
## FBgn0003731 0.247500 0.253000
## FBgn0029506 0.216000 0.183000
```

Several data sets, including the 3 replicates from (Tan et al. [2009](#ref-Tan2009)), are
distributed as *MSnSet* instances in the *[pRolocdata](https://bioconductor.org/packages/3.22/pRolocdata)*
package. Others include, among others, the *Arabidopsis thaliana*
LOPIT data from (Dunkley et al. [2006](#ref-Dunkley2006)) (`dunkley2006`) and the mouse PCP data
from (Foster et al. [2006](#ref-Foster2006)) (`foster2006`). Each data set can be loaded with
the `data` function, as show below for the first replicate from
(Tan et al. [2009](#ref-Tan2009)).

```
data(tan2009r1)
```

The original marker proteins are available as a feature meta-data
variables called `markers.orig` and the output of the partial least
square discriminant analysis, applied in the original publication, in
the `PLSDA` feature variable. The most up-to-date marker list for the
experiment can be found in `markers`. This feature meta-data column
can be added from a simple `csv` markers files using the `addMarkers`
function - see `?addMarkers` for details.

The organelle markers are illustrated below using the convenience
function *getMarkers*, but could also be done manually by accessing
feature variables directly using *fData()*.

```
getMarkers(tan2009r1, fcol = "markers.orig")
```

```
## organelleMarkers
##            ER         Golgi            PM mitochondrion       unknown
##            20             6            15            14           833
```

```
getMarkers(tan2009r1, fcol = "PLSDA")
```

```
## organelleMarkers
##      ER/Golgi            PM mitochondrion       unknown
##           235           180            74           399
```

**Important** As can be seen above, some proteins are labelled
`"unknown"`, defining non marker proteins. This is a convention in
many *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* functions. Missing annotations (empty
string) will not be considered as of unknown localisation; we prefer
to avoid empty strings and make the absence of known localisation
explicit by using the `"unknown"` tag. This information will be used
to separate marker and non-marker (unlabelled) proteins when
proceeding with data visualisation and clustering (sections
[3](#sec:viz) and [5.1](#sec:usml)) and classification analysis
(section [5.2](#sec:sml)).

## 2.4 *pRoloc*’s organelle markers

Exploring protein annotations and defining sub-cellular localisation
markers (i.e. known residents of a specific sub-cellular niche in a
species, under a condition of interest) play important roles in the
analysis of spatial proteomics data. The latter is essential for
downstream supervised machine learning (ML) classification for protein
localisation prediction (as discussed later and in the
`vignette("pRoloc-ml", package = "pRoloc")`) and the former is interesting for
initial biological interpretation through matching annotations to the
data structure.

Robust protein-localisation prediction is reliant on markers that
reflect the true sub-cellular diversity of the multivariate data. The
validity of markers is generally assured by expert curation. This can
be time consuming and difficult owing to the limited number of marker
proteins that exist in databases and elsewhere. The Gene Ontology (GO)
database, and in particular the cellular compartment (CC) namespace
provide a good starting point for protein annotation and marker
definition. Nevertheless, automatic extraction from databases, and in
particular GO CC, is only a first step in sub-cellular localisation
analysis and requires additional curation to counter unreliable
annotation based on data that is inaccurate or out of context for the
biological question under investigation.

The *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* package distributes starting sets of markers that
have been obtained by mining the *[pRolocdata](https://bioconductor.org/packages/3.22/pRolocdata)*
datasets and curation by various members of the
[Cambridge Centre for Proteomics](http://proteomics.bio.cam.ac.uk/). The
available marker sets can be obtained and loaded using the
`pRolocmarkers` function:

```
pRolocmarkers()
```

```
## 14 marker lists (version 2) available:
## Arabidopsis thaliana [atha]:
##  Ids: TAIR, 543 markers
## Drosophila melanogaster [dmel]:
##  Ids: Uniprot, 179 markers
## Gallus gallus [ggal]:
##  Ids: IPI, 102 markers
## Homo sapiens [hsap]:
##  Ids: Uniprot, 872 markers
## Homo sapiens [hsap_christopher]:
##  Ids: Uniprot, 1509 markers
## Homo sapiens [hsap_geladaki]:
##  Ids: Uniprot, 579 markers
## Homo sapiens [hsap_itzhak]:
##  Ids: Uniprot, 1076 markers
## Homo sapiens [hsap_villaneuva]:
##  Ids: Uniprot, 682 markers
## Mus musculus [mmus]:
##  Ids: Uniprot, 937 markers
## Mus musculus [mmus_christoforou]:
##  Ids: Uniprot, 922 markers
## Saccharomyces cerevisiae [scer_sgd]:
##  Ids: SGD, 259 markers
## Saccharomyces cerevisiae [scer_uniprot]:
##  Ids: Uniprot, 259 markers
## Toxoplasma gondii [toxo_barylyuk]:
##  Ids: ToxoDB gene identifier, 718 markers
## Trypanosoma brucei [tryp_moloney]:
##  Ids: TriTrypDB gene identifier, 891 markers
```

```
head(pRolocmarkers("dmel"))
```

```
##       Q7JZN0       Q7KLV9       Q9VIU7       P15348       Q7KMP8       O01367
##         "ER" "Proteasome"         "ER"    "Nucleus" "Proteasome"    "Nucleus"
```

```
table(pRolocmarkers("dmel"))
```

```
##
##  40S Ribosome  60S Ribosome  Cytoskeleton            ER         Golgi
##            22            32             7            24             7
##      Lysosome Mitochondrion       Nucleus            PM    Peroxisome
##             8            15            21            25             4
##    Proteasome
##            14
```

These markers can then be added to a new *MSnSet* using the
*addMarkers* function by matching the marker names (protein
identifiers) and the feature names of the *MSnSet*. See *?addMarkers*
for examples.

## 2.5 Data processing

The quantitation data obtained in the supplementary file is normalised
to the sum of intensities of each protein; the sum of fraction
quantitation for each protein equals 1 (considering rounding
errors). This can quickly be verified by computing the row sums of the
expression data.

```
summary(rowSums(exprs(tan2009r1)))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.9990  0.9999  1.0000  1.0000  1.0001  1.0010
```

The `normalise` method (also available as `normalize`) from the
*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* package can be used to obtain relative
quantitation data, as illustrated below on another iTRAQ test data
set, available from *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)*. Several normalisation
`methods` are available and described in `?normalise`. For many
algorithms, including classifiers in general and support vector
machines in particular, it is important to properly per-process the
data. Centering and scaling of the data is also available with the
`scale` method.

In the code chunk below, we first create a test *MSnSet*
instance222 Briefly, the `itraqdata` raw iTRAQ4-plex data is quantified by trapezoidation using *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* functionality. See the `MSnbase-demo` vignette for details.
and illustrate the effect of `normalise(..., method = "sum")`.

```
## create a small illustrative test data
data(itraqdata)
itraqdata <- quantify(itraqdata, method = "trap",
              reporters = iTRAQ4)
## the quantification data
head(exprs(itraqdata), n = 3)
```

```
##     iTRAQ4.114 iTRAQ4.115 iTRAQ4.116 iTRAQ4.117
## X1   1347.6158  2247.3097  3927.6931  7661.1463
## X10   739.9861   799.3501   712.5983   940.6793
## X11 27638.3582 33394.0252 32104.2879 26628.7278
```

```
summary(rowSums(exprs(itraqdata)))
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.      NA's
##     59.06   5638.09  15344.43  38010.87  42256.61 305739.04         1
```

```
## normalising to the sum of feature intensitites
itraqnorm <- normalise(itraqdata, method = "sum")
processingData(itraqnorm)
```

```
## - - - Processing information - - -
## Data loaded: Wed May 11 18:54:39 2011
## Updated from version 0.3.0 to 0.3.1 [Fri Jul  8 20:23:25 2016]
## iTRAQ4 quantification by trapezoidation: Thu Oct 30 01:50:24 2025
## Normalised (sum): Thu Oct 30 01:50:24 2025
##  MSnbase version: 1.1.22
```

```
head(exprs(itraqnorm), n = 3)
```

```
##     iTRAQ4.114 iTRAQ4.115 iTRAQ4.116 iTRAQ4.117
## X1  0.08875373  0.1480074  0.2586772  0.5045617
## X10 0.23178064  0.2503748  0.2232022  0.2946424
## X11 0.23077081  0.2788287  0.2680598  0.2223407
```

```
summary(rowSums(exprs(itraqnorm)))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
##       1       1       1       1       1       1       1
```

Note above how the processing undergone by the *MSnSet*
instances `itraqdata` and `itraqnorm` is stored in
another such specific sub-container, the `processingData`
slot.

The different features (proteins in the `tan2009r1` data
above, but these could also represent peptides or MS\(^2\) spectra) are
characterised by unique names. These can be retrieved with the
`featureNames` function.

```
head(featureNames(tan2009r1))
```

```
## [1] "P20353" "P53501" "Q7KU78" "P04412" "Q7KJ73" "Q7JZN0"
```

If we look back at section [2.2.2](#sec:csv), we see that these have been
automatically assigned using the first columns in the `exprsFile.csv`
and `fdataFile.csv` files. It is thus crucial for these respective
first columns to be identical. Similarly, the sample names can be
retrieved with `sampleNames(tan2009r1)`.

# 3 Data visualisation

The following sections will focus on two closely related aspects, data
visualisation and data analysis (i.e. organelle assignments). Data
visualisation is used in the context on quality control, to convince
ourselves that the data displays the expected properties so that the
output of further processing can be trusted. Visualising results of
the localisation prediction is also essential, to control the validity
of these results, before proceeding with orthogonal (and often
expensive) *dry* or *wet* validation.

## 3.1 Profile plots

The underlying principle of gradient approaches is that we have
separated organelles along the gradient and by doing so, generated
organelle-specific protein distributions along the gradient
fractions. The most natural visualisation is shown on figure
[1](#fig:plotdist1), obtained using the sub-setting functionality of
*MSnSet* instances and the `plotDist` function, as illustrated below.

```
## indices of the mito markers
j <- which(fData(tan2009r1)$markers.orig == "mitochondrion")
## indices of all proteins assigned to the mito
i <- which(fData(tan2009r1)$PLSDA == "mitochondrion")
plotDist(tan2009r1[i, ],
     markers = featureNames(tan2009r1)[j])
```

![Distribution of protein intensities along the fractions of the separation gradient for 4 organelles: mitochondrion (red), ER/Golgi (blue, ER markers and green, Golgi markers) and plasma membrane (purple).](data:image/png;base64...)

Figure 1: Distribution of protein intensities along the fractions of the separation gradient for 4 organelles: mitochondrion (red), ER/Golgi (blue, ER markers and green, Golgi markers) and plasma membrane (purple)

## 3.2 Sub-cellular cluster dendrogram

To gain a quick overview of the distance/similarity between the
sub-cellular clusters, it can useful to compare average marker
profiles, rather than all profiles, as presented in the profile plots
above. The `mrkHClust` calculates average class profiles and generates
the resulting dendrogram.

```
mrkHClust(tan2009r1)
```

![Hierarchical clustering. Average distance between organelle classes.](data:image/png;base64...)

Figure 2: Hierarchical clustering
Average distance between organelle classes.

On figure [2](#fig:dendro), we see that the lysosome and the ribosome
60S are separated by the smallest distance. The advantage of this
representation is that it provides a quick snapshot of the average
similarity between organelles using the complete profiles (as opposed
to a PCA plot, discussed in the next section). The main drawback is
that it ignores any variability in individual markers (cluster
tightness). It is however a good guide for a more thorough exploration
of the data, as described in the next sections.

Note the colours of the labels on the dendrogram (figure
[2](#fig:dendro)), which match the colours used to annotate PCA
plots, described in the next section (figure [4](#fig:plot2d). These
colours are defined at the session level (see `getStockcol` and
`setStockcol`) and re-used throughout *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* for
consistent annotation.

## 3.3 Average organelle class profile plot

We can also visualise the average organelle class profiles generated by
`mrkConsProfiles` using `plotConsProfiles`. We can optionally order the organelle
classes on the y-axis according to the heirachical clustering from `mrkHClust`.

See `?mrkHClust` for more details

```
## histogram
hc <- mrkHClust(tan2009r1, plot=FALSE)

## order of markers according to histogram
mm <- getMarkerClasses(tan2009r1)
m_order <- levels(factor(mm))[order.dendrogram(hc)]

## average marker profile
fmat <- mrkConsProfiles(tan2009r1)

plotConsProfiles(fmat, order=m_order)
```

![Average organelle class profiles. Protein intensity indicated by colour. Organelle classes ordered by hierarchical clustering](data:image/png;base64...)

Figure 3: Average organelle class profiles
Protein intensity indicated by colour. Organelle classes ordered by hierarchical clustering

## 3.4 Dimensionality reduction

Alternatively, we can combine all organelle groups in one single 2
dimensional figure by applying a dimensionality reduction technique
such as Principal Component Analysis (PCA) using the `plot2D` function
(see figure [4](#fig:plot2d)). The protein profile vectors are
summarised into 2 values that can be visualised in two dimensions, so
that the variability in the data will be maximised along the first
principal component (PC1). The second principal component (PC2) is
then chosen as to be orthogonal to PC1 while explaining as much
variance in the data as possible, and so on for PC3, PC4, etc.

Using a PCA representation to visualise a spatial proteomics
experiment, we can easily plot all the proteins on the same figure as
well a many sub-cellular clusters. These clusters are defined in a
feature meta-data column (slot `featureData`, accessed as a
`data.frame` with the `fData` function) that is
declared with the `fcol` argument (default is
`"markers"` which contains the most current known markers for
this experiment, while the original markers published with the data
can be found in the slot `"markers.orig"`).

```
plot2D(tan2009r1, fcol = "markers")
addLegend(tan2009r1, fcol = "markers", cex = .7,
      where = "bottomright", ncol = 2)
```

![PCA plot. Representation of the proteins of `tan2009r1` after reduction of the 4 reporter quantitation data to 2 principal components.](data:image/png;base64...)

Figure 4: PCA plot
Representation of the proteins of `tan2009r1` after reduction of the 4 reporter quantitation data to 2 principal components.

As the default value for the `fcol` argument is `"markers"`, it is not
necessary to specify it. It is however mandatory to specify other
annotation feature variables, such as to visualise the set of markers
described in the original publication.

```
plot2D(tan2009r1, fcol = "markers.orig")
addLegend(tan2009r1, fcol = "markers.orig", where = "bottomright")
```

![PCA plot. Reduced set of markers for the `tan2009r1` data projected onto 2 principal components.](data:image/png;base64...)

Figure 5: PCA plot
Reduced set of markers for the `tan2009r1` data projected onto 2 principal components.

It is also possible to visualise the data along 3 dimensions using the
*plot3D* function, which works like the 2 dimension version
([figure below](#fig:plot3D)). The resulting figure can be rotated by the
user.

```
plot3D(tan2009r1)
```

![](data:image/png;base64...)

Snapshot of the 3-dimensional PCA plot. The `tan2009r1` data is represented along the first 3 principal components.

As can be seen on the figures [4](#fig:plot2d), [5](#fig:plot2dorg)
and on the [3D plot above](#fig:plot3D), we indicate on the axis
labels the percentage of total variance explained by the individual
PCs. It is not unusual to reach over 75% along the first two PCs,
even for experiments with several tens of fractions. One can calculate
this information for all PCs by setting `method = "scree"` in
`plot2D`. On figure [6](#fig:scree), we see that the four PCs in the
`tan2009r1` data account for 58.53, 29.96, 11.52
and 0 percent of the total variance.

```
plot2D(tan2009r1, method = "scree")
```

![Percentage of variance explained.](data:image/png;base64...)

Figure 6: Percentage of variance explained

A variety of dimensionality reduction methods are available in
`plot2D`: PCA, MDS, kpca, lda, t-SNE, UMAP, nipals, hexbin, none, scree.
Except for `scree` (see above) and `none` (no data transformation,
which can be useful when the data is already transformed and only
needs to be plotted), these can used to produce visualisation of the
data in two dimensions. Two are worth some discussion here; the
readers are redirected to the manual page for more details.

Linear discriminant analysis (LDA) will project the protein occupancy
profiles in a new set of dimensions using as a criterion the
separation of marker classes by maximising the between class variance
to the within class variance ratio. As opposed to the
*unsupervised* PCA, the *supervised* LDA should not be
used as an to explore the data or as a quality control, but can be
useful to assess if one or more organelles have been preferentially
separated.

The t-Distributed Stochastic Neighbour Embedding
(t-SNE)333 <https://lvdmaaten.github.io/tsne/> (Maaten and Hinton [2008](#ref-tsne:2008)) is widely
applied in many areas in computational biology and more generally
field that need to visualise high-dimensional data. The t-SNE method
is non-linear, and will emphasise separation of different features
while grouping features with similar profiles. In addition, different
transformations are applied on different regions leading to plots that
can substantially differ from a PCA plot. As a result, proximity in
two dimensions and tightness of the clusters can’t be related to these
quantities in the original data. See *How to Use t-SNE
Effectively*444 <http://distill.pub/2016/misread-tsne/> for a useful
non-technical introduction.

The results of the algorithm crucially depend on the values of its
input parameters, in particular the *perplexity*, which
balances global and local aspects of the data. The suggested range of
value ranges from 5 to 50, and should not be greater than the number
of data points (which we can assume not to be the case in modern
spatial proteomics experiments). Below, we test the effect of this
parameter along the suggested range, including the default value of
30, at which the algorithm converges.

```
data(dunkley2006)
perps <- sort(c(30, seq(5, 50, 15)))
par(mfrow = c(3, 2))
plot2D(dunkley2006, main = "PCA")
sapply(perps,
       function(perp) {
       plot2D(dunkley2006, method = "t-SNE",
          methargs = list(perplexity = perp))
       title(main = paste("t-SNE, perplexity", perp))
       })
```

![](data:image/png;base64...)

Effect of t-SNE’s perplexity parameter on the `dunkley2006` data.

Other parameters that can effect the results are the number of
iterations and the learning rate epsilon.

The t-SNE algorithm takes much more time to complete than the other
available methods. In such cases, saving the results and re-plotting
with method `none` can be useful (see `?plot2D`). In the case of this
document, the [figure above](#fig:tsne), was pre-generated rather than
computed upon compilation.

It is also possible to visualise the data using a Uniform Manifold
Approximation Projection (UMAP) (McInnes et al. [2018](#ref-McInnes:2018)). UMAP is another
non-linear dimensionality reduction method. It has also become
increasingly popular in recent years in the omics’ field. It works in
a similar way to t-SNE in that it tried to find a low-dimensional
representation that preserves the relationship between
neighbours in high-dimensional space. Without going into the theory,

Like t-SNE the results of running an embedding depend on the input
parameters. The `plot2D` function uses the default settings from
the `umap` package in CRAN (Konopka [2023](#ref-umap)) (see `umap.defaults`). One of
the main parameters to optimise is the number of nearest neighbours.
In the below code chunk we test `c(5, 10, 30, 75, 100)`. The optimal
number of neighbours will depend on several factors, including the
total number of proteins or peptides in the data and also the number of
subcellular classes in the data. The default number of training
epochs should also been explored. This is the number of iterations to
be used in the initial low dimensional embedding. This is set to 200
i.e. `n_epochs = 200`. Large values are expected to give a more accurate
embedding. See the `umap` vignette555 <https://cran.r-project.org/web/packages/umap/vignettes/umap.html>
for more details.

```
nn <- c(5, 10, 30, 75, 100)
par(mfrow = c(3, 2))
plot2D(dunkley2006, main = "PCA")
sapply(nn,
       function(nn) {
       set.seed(1)
       plot2D(dunkley2006, method = "UMAP",
          methargs = list(n_neighbors = nn, n_epochs = 50))
       title(main = paste("UMAP, nearest neighbours = ", nn))
       })
```

![](data:image/png;base64...)

Effect of UMAPs nearest neighbours parameter on the `dunkley2006` data.

## 3.5 Features of interest

In addition to highlighting sub-cellular niches as coloured clusters
on the PCA plot, it is also possible to define some arbitrary
*features of interest* that represent, for example, proteins of a
particular pathway or a set of interaction partners. Such sets of
proteins are recorded as *FeaturesOfInterest* instances, as illustrated
below (using the ten first features of our experiment):

```
foi1 <- FeaturesOfInterest(description = "Feats of interest 1",
               fnames = featureNames(tan2009r1[1:10]))
description(foi1)
```

```
## [1] "Feats of interest 1"
```

```
foi(foi1)
```

```
##  [1] "P20353" "P53501" "Q7KU78" "P04412" "Q7KJ73" "Q7JZN0" "Q7KLV9" "Q9VM65"
##  [9] "Q9VCK0" "Q9VIU7"
```

Several such features of interest can be combined into collections:

```
foi2 <- FeaturesOfInterest(description = "Feats of interest 2",
               fnames = featureNames(tan2009r1[880:888]))
foic <- FoICollection(list(foi1, foi2))
foic
```

```
## A collection of 2 features of interest.
```

*FeaturesOfInterest* instances can now be overlaid on the PCA plot
with the `highlightOnPlot` function. The `highlightOnPlot3D` can be
used to overlay data onto a 3 dimensional figure produced by `plot3D`.

```
plot2D(tan2009r1, fcol = "PLSDA")
addLegend(tan2009r1, fcol = "PLSDA",
      where = "bottomright",
      cex = .7)
highlightOnPlot(tan2009r1, foi1,
        col = "black", lwd = 2)
highlightOnPlot(tan2009r1, foi2,
        col = "purple", lwd = 2)
legend("topright", c("FoI 1", "FoI 2"),
       bty = "n", col = c("black", "purple"),
       pch = 1)
```

![Adding features of interest on a PCA plot.](data:image/png;base64...)

Figure 7: Adding features of interest on a PCA plot

See `?FeaturesOfInterest` and `?highlightOnPlot` for more details.

## 3.6 Interactive visualisation

The *[pRolocGUI](https://bioconductor.org/packages/3.22/pRolocGUI)* application allows one to explore the
spatial proteomics data using an interactive, web-based
interface (RStudio and Inc. [2014](#ref-shiny)). The package is available from
Bioconductor and can be installed and started as follows:

```
library("BiocManager")
BiocManager::install("pRolocGUI")
library("pRolocGUI")
data(Barylyuk2020ToxoLopit)
pRolocVis(Barylyuk2020ToxoLopit)
```

![](data:image/png;base64...)

Screenshot of the *[pRolocGUI](https://bioconductor.org/packages/3.22/pRolocGUI)* interface. The GUI is also available as an online app for the hyperLOPIT experiment from (Barylyuk et al. [2020](#ref-Barylyuk:2020)) at <https://proteome.shinyapps.io/toxolopittzex/>.

More details are available in the vignette that can be started from
the application by clicking on any of the question marks, by starting
the vignette from R with `vignette("pRolocGUI")` or can be accessed
online
(<http://bioconductor.org/packages/devel/bioc/vignettes/pRolocGUI/inst/doc/pRolocGUI.html>).

# 4 Assessing sub-cellular resolution

## 4.1 QSep metrics

The sub-cellular resolution of a spatial proteomics experiment,
i.e. the quantitation of how well the respective sub-cellular niches
are separated, can be computed with the `QSep` function. Briefly, this
function compares, for each pairs ofx sub-cellular niches, the ratio
between the the average Euclidean distance between niche *i* and *j* and
the the average within distance of cluster *j*. A large ratio indicates
that *i* and *j* are well separated with respect to the tightness of
cluster *j*. The larger the distances, the better the spatial proteomics
experiment.

Below, we calulate and visualise the *QSep* distances for the
`hyperLOPIT2015` data:

```
library("pRolocdata")
data(hyperLOPIT2015)

## Create the object and get a summary
hlq <- QSep(hyperLOPIT2015)
hlq
```

```
## Object of class 'QSep'.
##  Data: hyperLOPIT2015
##  With 14 sub-cellular clusters.
```

```
levelPlot(hlq)
```

![](data:image/png;base64...)

```
plot(hlq)
```

![](data:image/png;base64...)

See [Assessing sub-cellular resolution in spatial proteomics
experiments](https://doi.org/10.1101/377630) (Gatto, Breckels, and Lilley [2018](#ref-Gatto:2018)) for
details, including a large meta-analysis on 29 different spatial
proteomics experiments.

## 4.2 Euclidian distance metrics

In addition to `QSep` metrics there exists the `ClustDist` framework which
includes a set of classes and methods that given a set of proteins computes the
(normalised) distances between protein correlation profiles. Whilst the
motivation behind `QSep` is to assess the resolution of a correlation profiling
experiment by looking at between cluster (relative to within cluster) distances,
the `clustDist` method was developed to assess cluster tightness. Moreover,
correlate annotation information e.g. markers or GO terms, with the multivariate
data space to identify densely and sparsely annotated regions that reflect the
fit of the markers. Given a set of proteins that share some property e.g. a
specified GO term, or subcellular class label, the `clustDist` method performs
an initial k-means clustering of all proteins annotated to the class (testing
small values of `k`, the default is `k = 1:5`) and then for each number of `k`
components tested, all pairwise Euclidean distances are calculated per
component, and then normalised. The minimum mean normalised distance is then
extracted and used as a measure of fit of the annotation or markers to the data.
This is repeated for all terms/annotation sets. These sets can then be ranked
according to minimum mean normalised distance and then displayed and explored
using the `r`Biocpkg(“pRolocGUI”)` package.

The motivation behind performing an initial clustering for each term/marker set
is to account for sets which might have several distributions, for example,
components of a protein complex or sub-compartment resolution. If the annotation
is protein markers, the best `k` components per protein set is likely to be 1 as
on average we expect residents of known organelles to co-fractionate in
correlation profiling experiments. We may find 2, 3 or more components as the
best `k` for when evaluating annotation sets that have multiple distributions or
if the annotation is more ambiguous.

Before running the `clustDist` algorithm a matrix of markers must be created
where the number of rows in the matrix matches the same proteins in the `MSnSet`
(as denoted by `featureNames`) and the columns denote if the protein is present
in that term/organelle. A matrix of markers is used over a standard character
vector (e.g. `fcol = "markers"`) to allow flexibility for proteins being allocated
to multiple locations. If we wish to test an existing `fcol` in the `MSnSet`
there is a convenience function that converts a character vector e.g. “markers”
to a matrix of “markers”, this is called `mrkVecToMat`. In the below code chunk
we use the `mrkVecToMat` function to take the `"markers"` column from the
`hyperLOPIT2015` dataset and convert it to a matrix of markers which we call
`"MM"` in the `fData` slot of the `MSnSet`. A new object with this information
is created called `hld`.

```
hld <- mrkVecToMat(hyperLOPIT2015, vfcol = "markers", mfcol = "MM")
head(fData(hld)$MM)
```

```
##          40S Ribosome 60S Ribosome Actin cytoskeleton Cytosol
## Q9JHU4              0            0                  0       0
## Q9QXS1-3            0            0                  0       0
## Q9ERU9              0            0                  0       0
## P26039              0            0                  1       0
## Q8BTM8              0            0                  0       0
## A2ARV4              0            0                  0       0
##          Endoplasmic reticulum/Golgi apparatus Endosome Extracellular matrix
## Q9JHU4                                       0        0                    0
## Q9QXS1-3                                     0        0                    0
## Q9ERU9                                       0        0                    0
## P26039                                       0        0                    0
## Q8BTM8                                       0        0                    0
## A2ARV4                                       0        0                    0
##          Lysosome Mitochondrion Nucleus - Chromatin Nucleus - Non-chromatin
## Q9JHU4          0             0                   0                       0
## Q9QXS1-3        0             0                   0                       0
## Q9ERU9          0             0                   0                       0
## P26039          0             0                   0                       0
## Q8BTM8          0             0                   0                       0
## A2ARV4          0             0                   0                       0
##          Peroxisome Plasma membrane Proteasome
## Q9JHU4            0               0          0
## Q9QXS1-3          0               0          0
## Q9ERU9            0               0          0
## P26039            0               0          0
## Q8BTM8            0               0          0
## A2ARV4            0               0          0
```

We see the function has converted the `"markers`" vector in the `fData`
to a matrix of markers called `MM` where a 1 denotes the protein
is annotated to that term/class and a 0 means it is not.

In the below code chunk we run the `clustDist` function testing k’s between 1
and 3 per class. We also specify the minimum number of proteins per class to be
5. If any of the k-means components result in less than `n` proteins per
component a NA value is recorded.

```
dd <- clustDist(hld, fcol = "MM", k = 1:3, n = 5, verbose = FALSE)
dd
```

```
## Instance of class 'ClustDistList' containig 14 objects.
```

The output is a `"ClustDistList"` of length equal to the number of sets/classes
tested. The `"ClustDist"` and `"ClustDistList"` class summarises the algorithm
information including the number of k’s components tested, size of each
component, the mean and normalised pairwise Euclidean distances per number of
component clusters tested.

```
dd[[1]]
```

```
## Object of class "ClustDist"
## fcol =  MM
##  term =  40S Ribosome
##  nrow =  27
## k's tested: 1 2 3
##   Size:  27
##   Size:  20, 7
##   Size:  NA
## Clusters info:
##       ks.mean     mean ks.norm     norm
## k = 1       1  0.08389       1 *0.02796
## k = 2       2 *0.07710       2  0.03504
## k = 3      NA       NA      NA       NA
```

```
dd[[2]]
```

```
## Object of class "ClustDist"
## fcol =  MM
##  term =  60S Ribosome
##  nrow =  43
## k's tested: 1 2 3
##   Size:  43
##   Size:  24, 19
##   Size:  21, 11, 11
## Clusters info:
##       ks.mean     mean ks.norm     norm
## k = 1       1  0.08250       1 *0.02355
## k = 2       2  0.07354       2  0.02652
## k = 3       3 *0.06813       3  0.02845
```

The plotting method for a `ClustDist` object is a boxplot of the normalised distances
per term.

```
plot(dd)
```

![](data:image/png;base64...)

It is also possible to view the individual k-means component clusterings for
each class by selecting an element in the `"ClustDistList"` by name or index.
For example, in the code chunk below we look at the list of available classes
from the matrix of markers we created `"MM"` and then select interesting terms
to plot.

```
getMarkerClasses(hld, "MM")
```

```
##  [1] "40S Ribosome"
##  [2] "60S Ribosome"
##  [3] "Actin cytoskeleton"
##  [4] "Cytosol"
##  [5] "Endoplasmic reticulum/Golgi apparatus"
##  [6] "Endosome"
##  [7] "Extracellular matrix"
##  [8] "Lysosome"
##  [9] "Mitochondrion"
## [10] "Nucleus - Chromatin"
## [11] "Nucleus - Non-chromatin"
## [12] "Peroxisome"
## [13] "Plasma membrane"
## [14] "Proteasome"
```

```
plot(dd[["Endoplasmic reticulum/Golgi apparatus"]], hld)
```

![](data:image/png;base64...)

```
plot(dd[["Actin cytoskeleton"]], hld)
```

![](data:image/png;base64...)

The output is a set of principal components analysis (PCA) plots, one for each
`k` tested, highlighting the component clusters found according to the
algorithm. We see for the first example, of the `k = 1:3` clusterings all
combinations were fit, but for the second example only one clustering of `k = 1`
was fit as the higher values of `k` gave rise to components with less than `n`
members per cluster.

It is also possible to plot the raw Euclidean distances by calling the
argument `method = "raw"`.

```
plot(dd, method = "raw")
```

![](data:image/png;base64...)

# 5 Data analysis

Classification of proteins, i.e. assigning sub-cellular localisation
to proteins, is the main aspect of the present data analysis. The
principle is the following and is, in its basic form, a 2 step
process. First, an algorithm learns from the known markers that are
shown to him and models the data space accordingly. This phase is also
called the training phase. In the second phase, un-labelled proteins,
i.e. those that have not been labelled as resident of any organelle,
are matched to the model and assigned to a group (an organelle). This
2 step process is called machine learning (ML), because the computer
(machine) learns by itself how to recognise instances that possess
certain characteristics and classifies them without human
intervention. That does however not mean that results can be trusted
blindly.

In the above paragraph, we have defined what is called supervised ML,
because the algorithm is presented with some know instances from which
it learns (see section [5.2](#sec:sml)). Alternatively, un-supervised
ML does not make any assumptions about the group memberships, and uses
the structure of the data itself to defined sub-groups (see section
[5.1](#sec:usml)). It is of course possible to classify data based on
labelled and unlabelled data. This extension of the supervised
classification problem described above is called semi-supervised
learning. In this case, the training data consists of both labelled
and unlabelled instances with the obvious goal of generating a better
classifier than would be possible with the labelled data only. The
TAGM methods fall under this genre of algorithms and are available in
`pRoloc` and described in the *pRoloc-bayesian* vignette.

## 5.1 Unsupervised ML

The `plot2D` can also be used to visualise the data on a PCA plot
omitting any marker definitions, as shown on figure
[8](#fig:plot2dnull). This approach avoids any bias towards marker
definitions and concentrate on the data and its underlying structure
itself.

```
plot2D(tan2009r1, fcol = NULL)
```

![Plain PCA representation of the `tan2009r1` data.](data:image/png;base64...)

Figure 8: Plain PCA representation of the `tan2009r1` data

Alternatively, *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* also gives access to
*[MLInterfaces](https://bioconductor.org/packages/3.22/MLInterfaces)*’s `MLean` unified interface for, among
others, unsupervised approaches using k-means (figure
[9](#fig:plotKmeans)), hierarchical (figure [10](#fig:plotHclust)) or
partitioning around metiods (figure [11](#fig:plotPam)), clustering.

```
kcl <- MLearn( ~ ., tan2009r1,  kmeansI, centers=5)
plot(kcl, exprs(tan2009r1))
```

![k-means clustering on the `tan2009r1` data.](data:image/png;base64...)

Figure 9: k-means clustering on the `tan2009r1` data

```
hcl <- MLearn( ~ ., tan2009r1,
          hclustI(distFun = dist,
              cutParm = list(k = 5)))
plot(hcl, labels = FALSE)
```

![Hierarchical clustering on the `tan2009r1` data.](data:image/png;base64...)

Figure 10: Hierarchical clustering on the `tan2009r1` data

```
pcl <- MLearn( ~ ., tan2009r1,  pamI(dist), k = 5)
plot(pcl, data = exprs(tan2009r1))
```

![Partitioning around medoids on the `tan2009r1` data.](data:image/png;base64...)

Figure 11: Partitioning around medoids on the `tan2009r1` data

## 5.2 Supervised ML

In this section, we show how to use *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* to run a typical
supervised ML analysis. Several ML methods are available, including
k-nearest neighbour (knn), partial least square discriminant analysis
(plsda), random forest (rf), support vector machines (svm), The
detailed description of each method is outside of the scope of this
document. We will use support vector machines to illustrate a typical
pipeline and the important points that should be paid attention
to. These points are equally valid and work, from a *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)*
user perspective, exactly the same for the other approaches.

### 5.2.1 Classification algorithm parameters optimisation

Before actually generating a model on the new markers and classifying
unknown residents, one has to take care of properly setting the model
parameters. Wrongly set parameters can have a very negative impact on
classification performance. To do so, we create testing (to model) and
training (to predict) subsets using known residents, i.e. marker
proteins. By comparing observed and expected classification
prediction, we can assess how well a given model works using the macro
F1 score (see below). This procedure is repeated for a range of
possible model parameter values (this is called a grid search), and
the best performing set of parameters is then used to construct a
model on all markers and predict un-labelled proteins. For this
parameter optimisation procedure to perform well and produce useful
results, it is essential to run it with a reasonable amount of
markers. In our experience, 15 such marker proteins are necessary.

Model accuracy is evaluated using the F1 score, \(F1 = 2 ~ \frac{precision \times recall}{precision + recall}\), calculated as the
harmonic mean of the precision (\(precision = \frac{tp}{tp+fp}\), a
measure of *exactness* – returned output is a relevant result) and
recall (\(recall=\frac{tp}{tp+fn}\), a measure of *completeness* –
indicating how much was missed from the output). What we are aiming
for are high generalisation accuracy, i.e high \(F1\), indicating that
the marker proteins in the test data set are consistently correctly
assigned by the algorithms.

In order to evaluate how well a classifier performs on profiles it was
not exposed to during its creation, we implemented the following
schema. Each set of marker protein profiles, i.e. labelled with known
organelle association, are separated into *training* and
*test/validation* partitions by sampling 80% of the profile
corresponding to each organelle (i.e. stratified) without replacement
to form the training partition \(S\_{tr}\) with the remainder becoming
the test/validation partition \(S\_{ts}\). The SVM regularisation
parameter \(C\) and Gaussian kernel width \(sigma\) are selected using a
further round of stratified five-fold cross-validation on each
training partition. All pairs of parameters \((C\_i, sigma\_j)\) under
consideration are assessed using the macro F1 score and the pair that
produces the best performance is subsequently employed in training a
classifier on all training profiles \(S\_{tr}\) prior to assessment on
all test/validation profiles \(S\_{ts}\). This procedure is repeated \(N\)
times (in the example below 10) in order to produce \(N\) macro F1
estimated generalisation performance values (figures
[12](#fig:params1) and [13](#fig:params2)). This procedure is implemented in the
`svmOptimisation`. See `?svmOptimisation` for details, in particular
the range of \(C\) and \(sigma\) parameters and how the relevant feature
variable is defined by the `fcol` parameters, which defaults to
`"markers"`.

```
params <- svmOptimisation(tan2009r1,
                          fcol = "markers.orig",
                          times = 100, xval = 5,
                          verbose = FALSE)
```

In the interest of time, the optimisation is not executed
but loaded with

```
fn <- dir(system.file("extdata", package = "pRoloc"),
      full.names = TRUE, pattern = "params.rda")
load(fn)
```

```
params
```

```
## Object of class "GenRegRes"
## Algorithm: svm
## Hyper-parameters:
##  cost: 0.0625 0.125 0.25 0.5 1 2 4 8 16
##  sigma: 0.01 0.1 1 10 100 1000
## Design:
##  Replication: 10 x 5-fold X-validation
##  Partitioning: 0.2/0.8 (test/train)
## Results
##  macro F1:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.8889  0.8889  1.0000  0.9556  1.0000  1.0000
##  best sigma: 0.1 1
##  best cost: 0.5 1
```

```
plot(params)
```

![Assessing parameter optimisation. Here, we see the respective distributions of the 10 macro F1 scores for the best cost/sigma parameter pairs. See also the output of *f1Count* in relation to this plot.](data:image/png;base64...)

Figure 12: Assessing parameter optimisation
Here, we see the respective distributions of the 10 macro F1 scores for the best cost/sigma parameter pairs. See also the output of *f1Count* in relation to this plot.

```
levelPlot(params)
```

![Assessing parameter optimisation. Visualisation of the averaged macro F1 scores, for the full range of parameter values.](data:image/png;base64...)

Figure 13: Assessing parameter optimisation
Visualisation of the averaged macro F1 scores, for the full range of parameter values.

In addition to the plots on figures [12](#fig:params1) and
[13](#fig:params2), `f1Count(params)` returns, for each combination of
parameters, the number of best (highest) F1 observations. One can use
`getParams` to see the default set of parameters that are chosen based
on the executed optimisation. Currently, the first best set is
automatically extracted, and users are advised to critically assess
whether this is the most wise choice.

```
f1Count(params)
```

```
##     0.5 1
## 0.1   1 0
## 1    NA 5
```

```
getParams(params)
```

```
## sigma  cost
##   0.1   0.5
```

**Important** It is essential to emphasise that the accuracy scores
obtained during parameter optimisation are only a reflection of the
classification performance on a set of distinct and ideally separated
spatial clusters. Here, we assume that the data is characterised by
good separation of the various spatial niches which are reflected by
sub-cellular markers. Quality control of the data and the markers
using the visualisation described in section [3](#sec:viz) is
essential and subsequent analyses are doomed to fail in the absence of
such separation.

These classification scores are not representative of the reliability
of the final classification (described in section [5.2](#sec:sml)), in
particular along the boundaries separating the different sub-cellular
niches. High scores at the optimisation stage are a requirement to
proceed with the analysis, but are by no means indicative of the false
positive rate in the final sub-cellular assignment of non-marker
proteins.

### 5.2.2 Classification

We can now re-use the result from our parameter optimisation (a best
cost/sigma pair is going to be automatically extracted, using the
`getParams` method, although it is possible to set them
manually), and use them to build a model with all the marker proteins
and predict unknown residents using the *svmClassification*
function (see the manual page for more details). By default, the
organelle markers will be defined by the `"markers"` feature
variables (and can be defined by the `fcol` parameter)
e.g. here we use the original markers in `"markers.orig"` as a
use case. New feature variables containing the organelle assignments
and assignment probabilities, called scores hereafter, are
automatically added to the `featureData` slot; in this case,
using the `svm` and `svm.scores` labels.

**Important** The calculation of the classification probabilities is
dependent on the classification algorithm. These probabilities are
not to be compared across algorithms; they do **not** reflect any
**biologically relevant** sub-cellular localisation probability but
rather an algorithm-specific classification confidence score.}

```
## manual setting of parameters
svmres <- svmClassification(tan2009r1,
                            fcol = "markers.orig",
                            sigma = 1, cost = 1)
```

```
## using default best parameters
svmres <- svmClassification(tan2009r1,
                            fcol = "markers.orig",
                            assessRes = params)
```

```
## [1] "markers.orig"
```

```
processingData(svmres)
```

```
## - - - Processing information - - -
## Added markers from  'mrk' marker vector. Thu Jul 16 22:53:44 2015
## Performed svm prediction (sigma=0.1 cost=0.5) Thu Oct 30 01:50:39 2025
##  MSnbase version: 1.17.12
```

```
tail(fvarLabels(svmres), 4)
```

```
## [1] "markers"    "markers.tl" "svm"        "svm.scores"
```

The original markers, classification results and scores can be
accessed with the `fData` accessor method, e.g. `fData(svmres)$svm`
or `fData(svmres)$svm.scores`. Two helper functions, `getMarkers` and
`getPredictions` are available and add some level of automation and
functionality, assuming that the default feature labels are used. Both
(invisibly) return the corresponding feature variable (the markers or
assigned classification) and print a summary table. The `fcol`
parameter must be specified for `getPredictions`. It is also possible
to defined a classification probability below which classifications
are set to `"unknown"`.

```
p1 <- getPredictions(svmres, fcol = "svm")
```

```
## ans
##  Cytoskeleton            ER         Golgi      Lysosome       Nucleus
##             7           234            43             8            21
##            PM    Peroxisome    Proteasome  Ribosome 40S  Ribosome 60S
##           285             4            15            20            32
## mitochondrion
##           219
```

```
p1 <- fData(p1)$svm.pred
minprob <- median(fData(svmres)$svm.scores)
p2 <- getPredictions(svmres, fcol = "svm", t = minprob)
```

```
## ans
##  Cytoskeleton            ER         Golgi      Lysosome       Nucleus
##             7           166            23             8            21
##            PM    Peroxisome    Proteasome  Ribosome 40S  Ribosome 60S
##           150             4            15            20            32
## mitochondrion       unknown
##           107           335
```

```
p2 <- fData(p2)$svm.pred
table(p1, p2)
```

```
##                p2
## p1              Cytoskeleton  ER Golgi Lysosome Nucleus  PM Peroxisome
##   Cytoskeleton             7   0     0        0       0   0          0
##   ER                       0 166     0        0       0   0          0
##   Golgi                    0   0    23        0       0   0          0
##   Lysosome                 0   0     0        8       0   0          0
##   Nucleus                  0   0     0        0      21   0          0
##   PM                       0   0     0        0       0 150          0
##   Peroxisome               0   0     0        0       0   0          4
##   Proteasome               0   0     0        0       0   0          0
##   Ribosome 40S             0   0     0        0       0   0          0
##   Ribosome 60S             0   0     0        0       0   0          0
##   mitochondrion            0   0     0        0       0   0          0
##                p2
## p1              Proteasome Ribosome 40S Ribosome 60S mitochondrion unknown
##   Cytoskeleton           0            0            0             0       0
##   ER                     0            0            0             0      68
##   Golgi                  0            0            0             0      20
##   Lysosome               0            0            0             0       0
##   Nucleus                0            0            0             0       0
##   PM                     0            0            0             0     135
##   Peroxisome             0            0            0             0       0
##   Proteasome            15            0            0             0       0
##   Ribosome 40S           0           20            0             0       0
##   Ribosome 60S           0            0           32             0       0
##   mitochondrion          0            0            0           107     112
```

To graphically illustrate the organelle-specific score distributions,
we can use a boxplot and plot the scores for the respective predicted
SVM classes, as shown on figure [14](#fig:predscores). As can be seen,
different organelles are characterised by different score
distributions. Using a unique threshold (`minprob` with value
0.78 above) results in accepting
71% of the
initial ER predictions and only
49%
of the mitochondrion predictions. The *getPredictions* function also
accepts organelle-specific score thresholds. Below, we calculate
organelle-specific median scores.

```
boxplot(svm.scores ~ svm, data = fData(svmres),
    ylab = "SVM scores")
abline(h = minprob, lwd = 2, lty = 2)
```

![Organelle-specific SVM score distributions.](data:image/png;base64...)

Figure 14: Organelle-specific SVM score distributions

```
ts <- orgQuants(svmres, fcol = "svm", t = .5)
```

```
##            ER         Golgi            PM mitochondrion
##     0.8336581     0.6332884     0.7669141     0.7498666
```

Using these scores equates to choosing the 50% predictions with
highest scores for organelle.

```
getPredictions(svmres, fcol = "svm", t = ts)
```

```
## ans
##  Cytoskeleton            ER         Golgi      Lysosome       Nucleus
##             7           131            28             8            21
##            PM    Peroxisome    Proteasome  Ribosome 40S  Ribosome 60S
##           160             4            15            20            32
## mitochondrion       unknown
##           124           338
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 888 features, 4 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: X114 X115 X116 X117
##   varLabels: Fractions
##   varMetadata: labelDescription
## featureData
##   featureNames: P20353 P53501 ... P07909 (888 total)
##   fvarLabels: FBgn Protein.ID ... svm.pred (19 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
##   pubMedIds: 19317464
## Annotation:
## - - - Processing information - - -
## Added markers from  'mrk' marker vector. Thu Jul 16 22:53:44 2015
## Performed svm prediction (sigma=0.1 cost=0.5) Thu Oct 30 01:50:39 2025
## Added svm predictions according to thresholds: ER = 0.83, Golgi = 0.63, PM = 0.77, mitochondrion = 0.75 Thu Oct 30 01:50:40 2025
##  MSnbase version: 1.17.12
```

We can now visualise these results using the plotting functions
presented in section [5.1](#sec:usml), as shown on figure
[15](#fig:svmres). We clearly see that besides the organelle marker
clusters that have been assigned high confidence members, many other
proteins have substantially lower prediction scores.

```
ptsze <- exp(fData(svmres)$svm.scores) - 1
plot2D(svmres, fcol = "svm", fpch = "markers.orig",
       cex = ptsze)
addLegend(svmres, fcol = "svm",
      where = "bottomright",
      cex = .5)
```

![Representation of the svm prediction on the `tan2009r1` data set. The svm scores have been used to set the point size (`cex` argument; the scores have been transformed to emphasise the extremes). Different symbols (`fpch`) are used to differentiate markers and new assignments.](data:image/png;base64...)

Figure 15: Representation of the svm prediction on the `tan2009r1` data set
The svm scores have been used to set the point size (`cex` argument; the scores have been transformed to emphasise the extremes). Different symbols (`fpch`) are used to differentiate markers and new assignments.

### 5.2.3 Class imbalance

Traditional ML methods assume datasets with an equal numbers of labelled
instances per class, for example, here we would assume the same number of marker
proteins per organelle class. In subcellular spatial proteomics data we see the
number of marker proteins varies greatly from organelle to organelle, this is
known as class imbalance in field of ML.

In the below code chunk we again load a dataset from a LOPIT experiment on
Pluripotent Mouse Embryonic stems ([Christoforou et al 2016](http://www.nature.com/ncomms/2016/160112/ncomms9992/full/ncomms9992.html)),
available and documented in the *[pRolocdata](https://bioconductor.org/packages/3.22/pRolocdata)* data package as
`hyperlopit2015`. We see from looking at the markers in the data we have over
300 markers for some organelles e.g. the mitochondria, but only 13 for other
compartments such as the endosome.

```
data("hyperLOPIT2015")
getMarkers(hyperLOPIT2015, fcol = "markers")
```

```
## organelleMarkers
##                          40S Ribosome                          60S Ribosome
##                                    27                                    43
##                    Actin cytoskeleton                               Cytosol
##                                    13                                    43
## Endoplasmic reticulum/Golgi apparatus                              Endosome
##                                   107                                    13
##                  Extracellular matrix                              Lysosome
##                                    13                                    33
##                         Mitochondrion                   Nucleus - Chromatin
##                                   383                                    64
##               Nucleus - Non-chromatin                            Peroxisome
##                                    85                                    17
##                       Plasma membrane                            Proteasome
##                                    51                                    34
##                               unknown
##                                  4106
```

We can account for this class imbalance by setting specific class weights when
generating the SVM model. In the code chunks below, we use class specific
weights when creating the SVM model; the weights are set to be inversely
proportional to class frequencies.

```
w <- classWeights(hyperLOPIT2015, fcol = "markers")
w
```

```
##
##                          40S Ribosome                          60S Ribosome
##                           0.037037037                           0.023255814
##                    Actin cytoskeleton                               Cytosol
##                           0.076923077                           0.023255814
## Endoplasmic reticulum/Golgi apparatus                              Endosome
##                           0.009345794                           0.076923077
##                  Extracellular matrix                              Lysosome
##                           0.076923077                           0.030303030
##                         Mitochondrion                   Nucleus - Chromatin
##                           0.002610966                           0.015625000
##               Nucleus - Non-chromatin                            Peroxisome
##                           0.011764706                           0.058823529
##                       Plasma membrane                            Proteasome
##                           0.019607843                           0.029411765
```

```
params2 <- svmOptimisation(hyperLOPIT2015,
                           fcol = "markers",
                           times = 100, xval = 5,
                           class.weights = w)
```

As above, in the interest of time the results are pre-computed and available in
the extdata package directory.

```
fn <- dir(system.file("extdata", package = "pRoloc"),
full.names = TRUE, pattern = "params2.rda")
load(fn)
```

```
params2
```

```
## Object of class "GenRegRes"
## Algorithm: svm
## Hyper-parameters:
##  cost: 0.0625 0.125 0.25 0.5 1 2 4 8 16
##  sigma: 0.01 0.1 1 10 100 1000
## Design:
##  Replication: 100 x 5-fold X-validation
##  Partitioning: 0.2/0.8 (test/train)
## Results
##  macro F1:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.8432  0.8983  0.9211  0.9174  0.9331  0.9907
##  best sigma: 0.1
##  best cost: 16 8 4
```

```
hl <- svmClassification(hyperLOPIT2015,
                        params2,
                        fcol = "markers",
                        class.weights = w)
```

```
## [1] "markers"
```

We can set a classification threshold, below which we choose to not assign
a localisation and leave the protein “unlabelled” i.e. in `pRoloc` terminology
these are denoted by the term “unknown”. In the below code chunk we use the
`orgQuants` function to calculate an organelle specific threshold according
to the the third quantile for each organelles SVM scores.

```
ts <- orgQuants(hl, fcol = "svm", t = .75)
```

```
##                          40S Ribosome                          60S Ribosome
##                             0.5963762                             0.4242311
##                    Actin cytoskeleton                               Cytosol
##                             0.4812128                             0.8341535
## Endoplasmic reticulum/Golgi apparatus                              Endosome
##                             0.9006204                             0.5511319
##                  Extracellular matrix                              Lysosome
##                             0.5203290                             0.7540196
##                         Mitochondrion                   Nucleus - Chromatin
##                             0.9727813                             0.8905482
##               Nucleus - Non-chromatin                            Peroxisome
##                             0.8532296                             0.5044311
##                       Plasma membrane                            Proteasome
##                             0.8232016                             0.6201787
```

```
hl <- getPredictions(hl, fcol = "svm", scol = "svm.scores", t = ts)
```

```
## ans
##                          40S Ribosome                          60S Ribosome
##                                    57                                   109
##                    Actin cytoskeleton                               Cytosol
##                                    51                                   175
## Endoplasmic reticulum/Golgi apparatus                              Endosome
##                                   265                                    64
##                  Extracellular matrix                              Lysosome
##                                    22                                    77
##                         Mitochondrion                   Nucleus - Chromatin
##                                   460                                   147
##               Nucleus - Non-chromatin                            Peroxisome
##                                   217                                    28
##                       Plasma membrane                            Proteasome
##                                   189                                    95
##                               unknown
##                                  3076
```

The data is visualised as described previously, we plot the filtered
SVM results using the `plot2D` function (figure [16](#fig:plothl)).

![Classification results following prediction from a class-weight SVM classifier on LOPIT data produced from mouse embryonic stem cells.](data:image/png;base64...)

Figure 16: Classification results following prediction from a class-weight SVM classifier on LOPIT data produced from mouse embryonic stem cells

## 5.3 Bayesian generative models

We also offer generative models that, as opposed to the descriptive
classifier presented above, explicitly model the spatial proteomics
data. In `pRoloc`, we propose two models using T-augmented Gaussian
mixtures using repectively a Expectration-Maximisation approach to
*maximum a posteriori* estimation of the model parameters (TAGM-MAP),
and an MCMC approach (TAGM-MCMC) that enables a proteome-wide
uncertainty quantitation. These methods are described in the
*pRoloc-bayesian* vignette. For a details description of the methods
and their validation, please refer to (Crook et al. [2018](#ref-Crook:2018)).

# 6 Conclusions

This tutorial focuses on practical aspects of organelles proteomics
data analysis using *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)*. Two important aspects have
been illustrates: (1) data generation, manipulation and visualisation
and (2) application of contemporary and novel machine learning
techniques. Other crucial parts of a full analysis pipeline that were
not covered here are raw mass-spectrometry quality control,
quantitation, post-analysis and data validation.

Data analysis is not a trivial task, and in general, one can not
assume that any off-the-shelf algorithm will perform well. As such,
one of the emphasis of the software presented in this document is
allowing users to track data processing and critically evaluate the
results.

# Acknowledgement

We would like to thank Dr Daniel J.H. Nightingale, Dr Arnoud J. Groen,
Dr Claire M. Mulvey and Dr Andy Christoforou for their organelle
marker contributions.

# Session information

All software and respective versions used to produce this document are
listed below.

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
##  [1] class_7.3-23         pRolocdata_1.47.0    pRoloc_1.50.0
##  [4] BiocParallel_1.44.0  MLInterfaces_1.90.0  cluster_2.1.8.1
##  [7] annotate_1.88.0      XML_3.99-0.19        AnnotationDbi_1.72.0
## [10] IRanges_2.44.0       MSnbase_2.36.0       ProtGenerics_1.42.0
## [13] S4Vectors_0.48.0     mzR_2.44.0           Rcpp_1.1.0
## [16] Biobase_2.70.0       BiocGenerics_0.56.0  generics_0.1.4
## [19] knitr_1.50           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1               filelock_1.0.3
##   [3] tibble_3.3.0                hardhat_1.4.2
##   [5] preprocessCore_1.72.0       pROC_1.19.0.1
##   [7] rpart_4.1.24                lifecycle_1.0.4
##   [9] httr2_1.2.1                 doParallel_1.0.17
##  [11] globals_0.18.0              lattice_0.22-7
##  [13] MASS_7.3-65                 MultiAssayExperiment_1.36.0
##  [15] dendextend_1.19.1           magrittr_2.0.4
##  [17] limma_3.66.0                plotly_4.11.0
##  [19] sass_0.4.10                 rmarkdown_2.30
##  [21] jquerylib_0.1.4             yaml_2.3.10
##  [23] MsCoreUtils_1.22.0          DBI_1.2.3
##  [25] RColorBrewer_1.1-3          lubridate_1.9.4
##  [27] abind_1.4-8                 GenomicRanges_1.62.0
##  [29] purrr_1.1.0                 mixtools_2.0.0.1
##  [31] AnnotationFilter_1.34.0     nnet_7.3-20
##  [33] rappdirs_0.3.3              ipred_0.9-15
##  [35] lava_1.8.1                  listenv_0.9.1
##  [37] gdata_3.0.1                 parallelly_1.45.1
##  [39] ncdf4_1.24                  codetools_0.2-20
##  [41] DelayedArray_0.36.0         tidyselect_1.2.1
##  [43] Spectra_1.20.0              farver_2.1.2
##  [45] viridis_0.6.5               matrixStats_1.5.0
##  [47] BiocFileCache_3.0.0         Seqinfo_1.0.0
##  [49] jsonlite_2.0.0              caret_7.0-1
##  [51] e1071_1.7-16                survival_3.8-3
##  [53] iterators_1.0.14            foreach_1.5.2
##  [55] segmented_2.1-4             tools_4.5.1
##  [57] progress_1.2.3              glue_1.8.0
##  [59] prodlim_2025.04.28          gridExtra_2.3
##  [61] SparseArray_1.10.0          BiocBaseUtils_1.12.0
##  [63] xfun_0.53                   MatrixGenerics_1.22.0
##  [65] dplyr_1.1.4                 withr_3.0.2
##  [67] BiocManager_1.30.26         fastmap_1.2.0
##  [69] digest_0.6.37               timechange_0.3.0
##  [71] R6_2.6.1                    colorspace_2.1-2
##  [73] gtools_3.9.5                lpSolve_5.6.23
##  [75] dichromat_2.0-0.1           biomaRt_2.66.0
##  [77] RSQLite_2.4.3               tidyr_1.3.1
##  [79] hexbin_1.28.5               data.table_1.17.8
##  [81] recipes_1.3.1               FNN_1.1.4.1
##  [83] prettyunits_1.2.0           PSMatch_1.14.0
##  [85] httr_1.4.7                  htmlwidgets_1.6.4
##  [87] S4Arrays_1.10.0             ModelMetrics_1.2.2.2
##  [89] pkgconfig_2.0.3             gtable_0.3.6
##  [91] timeDate_4051.111           blob_1.2.4
##  [93] S7_0.2.0                    impute_1.84.0
##  [95] XVector_0.50.0              htmltools_0.5.8.1
##  [97] bookdown_0.45               MALDIquant_1.22.3
##  [99] clue_0.3-66                 scales_1.4.0
## [101] png_0.1-8                   gower_1.0.2
## [103] MetaboCoreUtils_1.18.0      reshape2_1.4.4
## [105] coda_0.19-4.1               nlme_3.1-168
## [107] curl_7.0.0                  proxy_0.4-27
## [109] cachem_1.1.0                stringr_1.5.2
## [111] parallel_4.5.1              mzID_1.48.0
## [113] vsn_3.78.0                  pillar_1.11.1
## [115] grid_4.5.1                  vctrs_0.6.5
## [117] pcaMethods_2.2.0            randomForest_4.7-1.2
## [119] dbplyr_2.5.1                xtable_1.8-4
## [121] evaluate_1.0.5              magick_2.9.0
## [123] tinytex_0.57                mvtnorm_1.3-3
## [125] cli_3.6.5                   compiler_4.5.1
## [127] rlang_1.1.6                 crayon_1.5.3
## [129] future.apply_1.20.0         labeling_0.4.3
## [131] LaplacesDemon_16.1.6        mclust_6.1.1
## [133] QFeatures_1.20.0            affy_1.88.0
## [135] plyr_1.8.9                  fs_1.6.6
## [137] stringi_1.8.7               viridisLite_0.4.2
## [139] Biostrings_2.78.0           lazyeval_0.2.2
## [141] Matrix_1.7-4                hms_1.1.4
## [143] bit64_4.6.0-1               future_1.67.0
## [145] ggplot2_4.0.0               KEGGREST_1.50.0
## [147] statmod_1.5.1               SummarizedExperiment_1.40.0
## [149] kernlab_0.9-33              igraph_2.2.1
## [151] memoise_2.0.1               affyio_1.80.0
## [153] bslib_0.9.0                 sampling_2.11
## [155] bit_4.6.0
```

# References

Barylyuk, Konstantin, Ludek Koreny, Huiling Ke, Simon Butterworth, Oliver M. Crook, Imen Lassadi, Vipul Gupta, et al. 2020. “A Comprehensive Subcellular Atlas of the Toxoplasma Proteome via hyperLOPIT Provides Spatial Context for Protein Functions.” *Cell Host &Amp; Microbe* 28 (5): 752–766.e9. <https://doi.org/10.1016/j.chom.2020.09.011>.

Crook, Oliver M, Claire M Mulvey, Paul D. W. Kirk, Kathryn S Lilley, and Laurent Gatto. 2018. “A Bayesian Mixture Modelling Approach for Spatial Proteomics.” *bioRxiv*. <https://doi.org/10.1101/282269>.

Dunkley, Tom P. J., Svenja Hester, Ian P. Shadforth, John Runions, Thilo Weimar, Sally L. Hanton, Julian L. Griffin, et al. 2006. “Mapping the Arabidopsis Organelle Proteome.” *Proc Natl Acad Sci USA* 103 (17): 6518–23. <https://doi.org/10.1073/pnas.0506958103>.

Foster, Leonard J., Carmen L. de Hoog, Yanling Zhang, Yong Zhang, Xiaohui Xie, Vamsi K. Mootha, and Matthias Mann. 2006. “A Mammalian Organelle Map by Protein Correlation Profiling.” *Cell* 125 (1): 187–99. <https://doi.org/10.1016/j.cell.2006.03.022>.

Gatto, Laurent, Lisa M Breckels, and Kathryn S Lilley. 2018. “Assessing Sub-Cellular Resolution in Spatial Proteomics Experiments.” *bioRxiv*. <https://doi.org/10.1101/377630>.

Gatto, Laurent, and Kathryn S Lilley. 2012. “MSnbase – an R/Bioconductor Package for Isobaric Tagged Mass Spectrometry Data Visualization, Processing and Quantitation.” *Bioinformatics* 28 (2): 288–9. <https://doi.org/10.1093/bioinformatics/btr645>.

Gatto, Laurent, Juan Antonio Vizcaíno, Henning Hermjakob, Wolfgang Huber, and Kathryn S Lilley. 2010. “Organelle Proteomics Experimental Designs and Analysis.” *Proteomics*. <https://doi.org/10.1002/pmic.201000244>.

Gentleman, Robert C., Vincent J. Carey, Douglas M. Bates, Ben Bolstad, Marcel Dettling, Sandrine Dudoit, Byron Ellis, et al. 2004. “Bioconductor: Open Software Development for Computational Biology and Bioinformatics.” *Genome Biol* 5 (10): –80. <https://doi.org/10.1186/gb-2004-5-10-r80>.

Konopka, Tomasz. 2023. *Umap: Uniform Manifold Approximation and Projection*. <https://cran.r-project.org/web/packages/umap>.

Maaten, Laurens van der, and Geoffrey Hinton. 2008. “Visualizing Data using t-SNE.” *Journal of Machine Learning Research* 9 (November): 2579–2605. <http://www.jmlr.org/papers/volume9/vandermaaten08a/vandermaaten08a.pdf>.

McInnes, Leland, John Healy, Nathaniel Saul, and Lukas Großberger. 2018. “UMAP: Uniform Manifold Approximation and Projection.” *Journal of Open Source Software* 3 (29): 861. <https://doi.org/10.21105/joss.00861>.

R Development Core Team. 2011. *R: A Language and Environment for Statistical Computing*. Vienna, Austria: R Foundation for Statistical Computing. <http://www.R-project.org/>.

Ross, Philip L., Yulin N. Huang, Jason N. Marchese, Brian Williamson, Kenneth Parker, Stephen Hattan, Nikita Khainovski, et al. 2004. “Multiplexed Protein Quantitation in Saccharomyces Cerevisiae Using Amine-Reactive Isobaric Tagging Reagents.” *Mol Cell Proteomics* 3 (12): 1154–69. <https://doi.org/10.1074/mcp.M400129-MCP200>.

RStudio, and Inc. 2014. *Shiny: Web Application Framework for R*. [http://CRAN.R-project.org/package=shiny](http://CRAN.R-project.org/package%3Dshiny).

Tan, Denise J, Heidi Dvinge, Andy Christoforou, Paul Bertone, Alfonso A Martinez, and Kathryn S Lilley. 2009. “Mapping Organelle Proteins and Protein Complexes in Drosophila Melanogaster.” *J Proteome Res* 8 (6): 2667–78. <https://doi.org/10.1021/pr800866n>.