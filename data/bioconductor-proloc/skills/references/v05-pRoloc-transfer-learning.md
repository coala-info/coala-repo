# A transfer learning algorithm for spatial proteomics

Lisa M. Breckels1 and Laurent Gatto2

1Cambridge Centre for Proteomics, University of Cambridge, UK
2de Duve Institute, UCLouvain, Belgium

#### 30 October 2025

#### Abstract

This vignette illustrates the application of a *transfer learning* algorithm to assign proteins to sub-cellular localisations. The *knntlClassification* algorithm combines *primary* experimental spatial proteomics data (LOPIT, PCP, etc.) and an *auxiliary* data set (for example binary data based on Gene Ontology terms) to improve the sub-cellular assignment given an optimal combination of these data sources.

#### Package

pRoloc 1.50.0

# 1 Introduction

Our main data source to study protein sub-cellular localisation are
high-throughput mass spectrometry-based experiments such as LOPIT, PCP
and similar designs (see (Gatto et al. [2010](#ref-Gatto2010)) for an general
introduction). Recent optimised experiments result in high quality
data enabling the identification of over 6000 proteins and
discriminate numerous sub-cellular and sub-organellar niches
(Christoforou et al. [2016](#ref-Christoforou:2016)). Supervised and semi-supervised machine learning
algorithms can be applied to assign thousands of proteins to annotated
sub-cellular niches (Breckels et al. [2013](#ref-Breckels2013), Gatto:2014) (see also the
*pRoloc-tutorial* vignette). These data constitute our main
source for protein localisation and are termed thereafter
*primary* data.

There are other sources of data about sub-cellular localisation of
proteins, such as the Gene Ontology (Ashburner et al. [2000](#ref-Ashburner:2000)) (in
particular the cellular compartment name space), quantitative features
derived from protein sequences (such as pseudo amino acid composition)
or the Human Protein Atlas (Uhlen et al. [2010](#ref-Uhlen:2010)) to cite a few. These
data, while not optimised to a specific system at hand and, in the
case of annotation features, whilst not as reliable as our experimental
data, constitute an invaluable, often plentiful source of *auxiliary*
information.

The aim of a *transfer learning* algorithm is to combine
different sources of data to improve overall classification. In
particular, the goal is to support/complement the primary target
domain (experimental data) with auxiliary data (annotation) features
without compromising the integrity of our primary data. In this
vignette, we describe the application of transfer learning algorithms
for the localisation of proteins from the *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* package, as
described in

> Breckels LM, Holden S, Wonjar D, Mulvey CM, Christoforou A, Groen A,
> Trotter MW, Kohlbacker O, Lilley KS and Gatto L (2016). *Learning
> from heterogeneous data sources: an application in spatial
> proteomics*. PLoS Comput Biol 13;12(5):e1004920. doi:
> [10.1371/journal.pcbi.1004920](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004920).

Two algorithms were developed: a transfer learning algorithm based on
the \(k\)-nearest neighbour classifier, coined kNN-TL hereafter,
described in section [6](#sec:knntl), and one based on the support
vector machine algorithm, termed SVM-TL, described in section
[5](#sec:svmtl).

```
library("pRoloc")
```

# 2 Preparing the data

To run the family of transfer learning algorithms in `pRoloc`
two datasets are required;

1. A primary dataset, constructed as an `MSnSet`,
2. an auxiliary dataset, constructed as an `MSnSet`, and

also a set of common protein markers.

Example/test datasets are readily available in the
*[pRolocdata](https://bioconductor.org/packages/3.22/pRolocdata)* package. We examine the structure of
these datasets in the subsequent sections.

# 3 Primary data

We will not go into detail on how to construct a `MSnSet` from protein
correlation profiling data. We refer users to the main *proloc-tutorial*
vignette. We load a precomputed `MSnSet` called `andy2011`. This dataset was a
proof-of-concept dataset from 2011, for the use of LOPIT with an adherent
mammalian cell culture. Human embryonic kidney fibroblast cells (HEK293T) were
used and LOPIT was employed with 8-plex iTRAQ reagents, thus returning eight
values per protein profile within a single labelling experiment. Nuclei were
discarded at an early stage in the fractionation scheme as previously described,
and membranes were not carbonate washed in order to retain peripheral membrane
and lumenal proteins for analysis.

```
library("pRolocdata")
data("andy2011")
```

If we first look at the LOPIT data we see we have 1371 proteins and 8 columns
of quantitation data.

```
andy2011
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 1371 features, 8 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: X113 X114 ... X121 (8 total)
##   varLabels: Fraction.information
##   varMetadata: labelDescription
## featureData
##   featureNames: O00767 P51648 ... O75312 (1371 total)
##   fvarLabels: Accession.No. Protein.Description ...
##     UniProtKB.entry.name (10 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
## Loaded on Fri Sep 23 15:43:47 2016.
## Normalised to sum of intensities.
## Added markers from  'mrk' marker vector. Fri Sep 23 15:43:47 2016
##  MSnbase version: 1.99.2
```

The quantitation information is stored in the `exprs` slot.

```
head(exprs(andy2011))
```

```
##              X113      X114       X115      X116      X117       X118
## O00767 0.13605472 0.1495961 0.10623931 0.1465050 0.2773137 0.14294025
## P51648 0.19144560 0.2052463 0.05661169 0.1651138 0.2366302 0.09964387
## Q2TAA5 0.12970671 0.2014544 0.05456427 0.1460297 0.2923010 0.14634820
## Q9UKV5 0.09393056 0.2069976 0.04186618 0.2036268 0.3437386 0.10984031
## Q12797 0.17085535 0.1920020 0.00000000 0.1561016 0.2399472 0.11714296
## P16615 0.15532160 0.2236944 0.04018941 0.1723041 0.2820158 0.11350162
##              X119        X121
## O00767 0.03796970 0.003381233
## P51648 0.01803788 0.027270640
## Q2TAA5 0.02057452 0.009021234
## Q9UKV5 0.00000000 0.000000000
## Q12797 0.00000000 0.123950875
## P16615 0.01297306 0.000000000
```

The protein markers are found in the `"markers"` column of the `fData`.

```
getMarkers(andy2011, fcol = "markers.tl")
```

```
## organelleMarkers
##         Cytosol Cytosol/Nucleus              ER           Golgi        Lysosome
##              60              22              36              24              22
##   Mitochondrion         Nucleus              PM    Ribosome 40S    Ribosome 60S
##              89              27              54              18              29
##         unknown
##             990
```

# 4 Auxiliary data

Auxiliary data can be generated from a number of data sources and we give a few
examples of some common sources in the proceeding sections. Whatever source of
information is used the data must be constructed as an `MSnSet` to use with the
`knntl` algorithms.

## 4.1 The Gene Ontology

Gene Ontology (GO) terms can be used as a auxiliary source of information
(providing they were not used to inform the proteins markers annotation). In
Breckels et al 2016 the auxiliary data was prepared from the primary data’s
features i.e. the proteins in the dataset. All the GO terms associated to these
proteins are retrieved and used to create a binary matrix where a one (zero) at
position \((i,j)\) indicates that term \(j\) has (not) been used to annotate feature
\(i\).

GO terms can be retrieved from an appropriate repository, for example, using the `r Biocpkg("biomaRt")` package. The specific Biomart repository and query will
depend on the species under study and the type of features. See, the
[vignettes/documentation](https://bioconductor.org/packages/release/bioc/html/biomaRt.html)
section of the R Bioconductor `biomaRt` package.

The *[pRolocdata](https://bioconductor.org/packages/3.22/pRolocdata)* package contains five example Gene Ontology
auxiliary datasets that were used in (Breckels et al. [2016](#ref-Breckels:2016)). In the below code chunk
the associated GO dataset to the `andy2011` dataset, this is called
`andy2011goCC`.

```
data("andy2011goCC")
andy2011goCC
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 1371 features, 569 samples
##   element names: exprs
## protocolData: none
## phenoData: none
## featureData
##   featureNames: O00767 P51648 ... O75312 (1371 total)
##   fvarLabels: Accession.No. Protein.Description ...
##     UniProtKB.entry.name (10 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
## Constructed GO set using cellular_component namespace: Mon Apr 29 12:24:10 2013
##  MSnbase version: 1.9.1
```

We see for the this GO set we have 1371 proteins and 569 columns. We pull just
the first 10 rows and 10 columns below to show the binary structure of the data.

```
dim(andy2011goCC)
```

```
## [1] 1371  569
```

```
exprs(andy2011goCC)[1:10, 1:10]
```

```
##        GO:0016021 GO:0005789 GO:0005783 GO:0005743 GO:0005792 GO:0005634
## O00767          1          1          1          0          0          0
## P51648          1          1          0          1          1          0
## Q2TAA5          1          1          0          0          0          0
## Q9UKV5          0          0          0          0          0          1
## Q12797          0          1          1          0          0          0
## P16615          0          1          0          0          1          0
## Q96SQ9          0          1          1          0          1          0
## Q16850          1          1          0          0          1          0
## P61803          1          1          0          0          0          0
## Q96HY6          0          0          1          0          0          0
##        GO:0030176 GO:0043025 GO:0030426 GO:0030425
## O00767          0          0          0          0
## P51648          0          0          0          0
## Q2TAA5          0          0          0          0
## Q9UKV5          1          1          1          1
## Q12797          1          0          0          0
## P16615          0          0          0          0
## Q96SQ9          0          0          0          0
## Q16850          0          0          0          0
## P61803          0          0          0          0
## Q96HY6          0          0          0          0
```

We note the we have the same proteins (and in the same order) in both datasets.

```
all(featureNames(andy2011) == featureNames(andy2011goCC))
```

```
## [1] TRUE
```

```
head(featureNames(andy2011))
```

```
## [1] "O00767" "P51648" "Q2TAA5" "Q9UKV5" "Q12797" "P16615"
```

```
head(featureNames(andy2011goCC))
```

```
## [1] "O00767" "P51648" "Q2TAA5" "Q9UKV5" "Q12797" "P16615"
```

### 4.1.1 A note on reproducibility

The pulling of auxiliary data such as GO utilises online servers, which undergo
regular updates, does not guarantee reproducibility of feature/term association
over time. It is always recommended to save and store the data noting software
version numbers and dates. In addition to the *[biomaRt](https://bioconductor.org/packages/3.22/biomaRt)* package
other Bioconductor infrastructure is available, such as specific organism
annotations and the *[GO.db](https://bioconductor.org/packages/3.22/GO.db)* package to use specific versioned
(and thus traceable) annotations.

## 4.2 The Human Protein Atlas

The Human Protein Atlas (HPA) provides another source of auxiliary data for the
prediction of a proteins location from correlation data. The datasets
`andy2011hpa` was constructed (with HPA, version 13, released on 11/06/2014) and
we again load this directly from the `pRolocdata` package.

```
data("andy2011hpa")
andy2011
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 1371 features, 8 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: X113 X114 ... X121 (8 total)
##   varLabels: Fraction.information
##   varMetadata: labelDescription
## featureData
##   featureNames: O00767 P51648 ... O75312 (1371 total)
##   fvarLabels: Accession.No. Protein.Description ...
##     UniProtKB.entry.name (10 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
## Loaded on Fri Sep 23 15:43:47 2016.
## Normalised to sum of intensities.
## Added markers from  'mrk' marker vector. Fri Sep 23 15:43:47 2016
##  MSnbase version: 1.99.2
```

Similar to the structure of the GO `MSnSet`, this auxiliary data, was encoded as
a binary matrix describing the localisation of 670 proteins in 18 sub-cellular
localisations. Information for 192 of the 381 labelled marker proteins were
available.

## 4.3 Protein-protein interactions

Protein-protein interaction data can also be used as auxiliary data
input to the transfer learning algorithm. Several sources can be used
to do so directly from R:

* The *[PSICQUIC](https://bioconductor.org/packages/3.22/PSICQUIC)* package provides an R interfaces to the
  HUPO Proteomics Standard Initiative (HUPO-PSI) project, which
  standardises programmatic access to molecular interaction
  databases. This approach enables to query great many resources in
  one go but, as noted in the vignettes, for bulk interactions, it is
  recommended to directly download databases from individual PSICQUIC
  providers.
* The *[STRINGdb](https://bioconductor.org/packages/3.22/STRINGdb)* package provides a direct interface to
  the STRING protein-protein interactions database. This package can
  be used to generate a table as the one used below. The exact
  procedure is described in the `STRINGdb` vignette and involves
  mapping the protein identifiers with the *map* and retrieve the
  interaction partners with the *get\_neighbors* method.
* Finally, it is possible to use any third-party PPI inference results
  and adequately prepare these results for transfer learning. Below,
  we will described this case with PPI data in a tab-delimited format,
  as retrieved directly from the STRING database.

Below, we access the PPI spreadsheet file for our test data, that is
distributed with the *[pRolocdata](https://bioconductor.org/packages/3.22/pRolocdata)* package.

```
ppif <- system.file("extdata/tabdelimited._gHentss2F9k.txt.gz", package = "pRolocdata")
ppidf <- read.delim(ppif, header = TRUE, stringsAsFactors = FALSE)
head(ppidf)
```

```
##   X.node1  node2 node1_string_id node2_string_id node1_external_id
## 1   NUDT5 IMPDH2         1861432         1850365   ENSP00000419628
## 2    NOP2  RPL23         1858730         1858184   ENSP00000382392
## 3   HSPA4   ENO1         1848476         1843405   ENSP00000302961
## 4   RPS13   DKC1         1862013         1855055   ENSP00000435777
## 5  RPL35A  DDOST         1859718         1856225   ENSP00000393393
## 6  RPL13A   RPS6         1857955         1857216   ENSP00000375730
##   node2_external_id neighborhood fusion cooccurence homology coexpression
## 1   ENSP00000321584        0.000      0           0        0        0.112
## 2   ENSP00000377865        0.000      0           0        0        0.064
## 3   ENSP00000234590        0.000      0           0        0        0.109
## 4   ENSP00000358563        0.462      0           0        0        0.202
## 5   ENSP00000364188        0.000      0           0        0        0.000
## 6   ENSP00000369757        0.000      0           0        0        0.931
##   experimental knowledge textmining combined_score
## 1        0.000       0.0      0.370          0.416
## 2        0.868       0.0      0.000          0.871
## 3        0.222       0.0      0.436          0.575
## 4        0.000       0.0      0.354          0.698
## 5        0.000       0.9      0.265          0.923
## 6        0.419       0.9      0.240          0.996
```

The file contains 18623 pairwise interactions and the STRING
combined interaction score. Below, we create a contingency matrix that
uses these scores to encode and weight interactions.

```
uid <- unique(c(ppidf$X.node1, ppidf$node2))
ppim <- diag(length(uid))
colnames(ppim) <- rownames(ppim) <- uid

for (k in 1:nrow(ppidf)) {
    i <- ppidf[[k, "X.node1"]]
    j <- ppidf[[k, "node2"]]
    ppim[i, j] <- ppidf[[k, "combined_score"]]
}

ppim[1:5, 1:8]
```

```
##        NUDT5 NOP2 HSPA4 RPS13 RPL35A RPL13A CPS1 CTNNB1
## NUDT5      1    0     0     0  0.000  0.000    0      0
## NOP2       0    1     0     0  0.000  0.000    0      0
## HSPA4      0    0     1     0  0.000  0.000    0      0
## RPS13      0    0     0     1  0.997  0.998    0      0
## RPL35A     0    0     0     0  1.000  0.999    0      0
```

We now have a contingency matrix reflecting a total of
19910 interactions between 1287
proteins. Below, we only keep proteins that are also available in our
spatial proteomics data (renamed to `andyppi`), subset the PPI and
LOPIT data, create the appropriate `MSnSet` object, and filter out
proteins without any interaction scores.

```
andyppi <- andy2011
featureNames(andyppi) <- sub("_HUMAN", "", fData(andyppi)$UniProtKB.entry.name)
cmn <- intersect(featureNames(andyppi), rownames(ppim))
ppim <- ppim[cmn, ]
andyppi <- andyppi[cmn, ]

ppi <- MSnSet(ppim, fData = fData(andyppi),
              pData = data.frame(row.names = colnames(ppim)))
ppi <- filterZeroCols(ppi)
```

```
## Removing 178 columns with only 0s.
```

We now have two `MSnSet` objects containing respectively
520 primary experimental protein profiles along a
sub-cellular density gradient (`andyppi`) and 520 auxiliary
interaction profiles (`ppi`).

```
andyppi
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 520 features, 8 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: X113 X114 ... X121 (8 total)
##   varLabels: Fraction.information
##   varMetadata: labelDescription
## featureData
##   featureNames: ALG11 ASPH ... XYLT2 (520 total)
##   fvarLabels: Accession.No. Protein.Description ...
##     UniProtKB.entry.name (10 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
## Loaded on Fri Sep 23 15:43:47 2016.
## Normalised to sum of intensities.
## Added markers from  'mrk' marker vector. Fri Sep 23 15:43:47 2016
## Subset [1371,8][520,8] Thu Oct 30 01:52:16 2025
##  MSnbase version: 1.99.2
```

# 5 Support vector machine transfer learning

The SVM-TL method descibed in (Breckels et al. [2016](#ref-Breckels:2016)) has not yet been
incorporated in the *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* package. The code
implementing the method is currently available in its own repository:

<https://codeberg.org/lgatto/lpsvm-tl-code>

# 6 Nearest neighbour transfer learning

## 6.1 Optimal weights

The weighted nearest neighbours transfer learning algorithm estimates
optimal weights for the different data sources and the spatial niches
described for the data at hand with the *knntlOptimisation*
function. For instance, for the human data modelled by the `andy2011`
and `andygoset`
objects111 We will use the sub-cellular markers defined in the `markers.tl` feature variable, instead of the default `markers`.
and the 10 annotated sub-cellular localisations
(Golgi, Mitochondrion, PM, Lysosome, Cytosol, Cytosol/Nucleus, Nucleus, Ribosome 60S, Ribosome 40S and ER), we want to know how
to optimally combine primary and auxiliary data. If we look at figure
[1](#fig:andypca), that illustrates the experimental separation of
the 10 spatial classes on a principal component plot, we
see that some organelles such as the mitochondrion or the cytosol and
cytosol/nucleus are well resolved, while others such as the Golgi or
the ER are less so. In this experiment, the former classes are not
expected to benefit from another data source, while the latter should
benefit from additional information.

![PCA plot of `andy2011`. The multivariate protein profiles are summarised along the two first principal components. Proteins of unknown localisation are represented by empty grey points. Protein markers, which are well-known residents of specific sub-cellular niches are colour-coded and form clusters on the figure.](data:image/png;base64...)

Figure 1: PCA plot of `andy2011`
The multivariate protein profiles are summarised along the two first principal components. Proteins of unknown localisation are represented by empty grey points. Protein markers, which are well-known residents of specific sub-cellular niches are colour-coded and form clusters on the figure.

Let’s define a set of three possible weights: 0, 0.5 and 1. A weight
of 1 indicates that the final results rely exclusively on the
experimental data and ignore completely the auxiliary data. A weight
of 0 represents the opposite situation, where the primary data is
ignored and only the auxiliary data is considered. A weight of 0.5
indicates that each data source will contribute equally to the final
results. It is the algorithm’s optimisation step task to identify the
optimal combination of class-specific weights for a given primary and
auxiliary data pair. The optimisation process can be quite time
consuming for many weights and many sub-cellular classes, as all
combinations (there are \(number~of~classes^{number~of~weights}\)
possibilities; see below). One would generally defined more weights
(for example 0, 0.25, 0.5, 0.75, 1 or 0, 0.33, 0.67, 1)
to explore more fine-grained integration opportunities. The possible
weight combinations can be calculated with the *thetas* function:

* 3 classes, 3 weights

```
head(thetas(3, by = 0.5))
```

```
## Weigths:
##   (0, 0.5, 1)
```

```
##      [,1] [,2] [,3]
## [1,]    0  0.0  0.0
## [2,]    0  0.0  0.5
## [3,]    0  0.0  1.0
## [4,]    0  0.5  0.0
## [5,]    0  0.5  0.5
## [6,]    0  0.5  1.0
```

```
dim(thetas(3, by = 0.5))
```

```
## Weigths:
##   (0, 0.5, 1)
```

```
## [1] 27  3
```

* 5 classes, 4 weights

```
dim(thetas(5, length.out = 4))
```

```
## Weigths:
##   (0, 0.333333333333333, 0.666666666666667, 1)
```

```
## [1] 1024    5
```

* for the human `andy2011` data, considering 4 weights, there are very
  many combinations:

```
## marker classes for andy2011
m <- unique(fData(andy2011)$markers.tl)
m <- m[m != "unknown"]
th <- thetas(length(m), length.out=4)
```

```
## Weigths:
##   (0, 0.333333333333333, 0.666666666666667, 1)
```

```
dim(th)
```

```
## [1] 1048576      10
```

The actual combination of weights to be tested can be defined in
multiple ways: by passing a weights matrix explicitly (as those
generated with *thetas* above) through the `th` argument; or by
defining the increment between weights using `by`; or by specifying
the number of weights to be used through the `length.out` argument.

Considering the sub-cellular resolution for this experiment, we would
anticipate that the mitochondrion, the cytosol and the cytosol/nucleus
classes would get high weights, while the ER and Golgi would be
assigned lower weights.

As we use a nearest neighbour classifier, we also need to know how
many neighbours to consider when classifying a protein of unknown
localisation. The *knnOptimisation* function (see the
*pRoloc-tutorial* vignette and the functions manual page) can be run
on the primary and auxiliary data sources independently to estimate
the best \(k\_P\) and \(k\_A\) values. Here, based on *knnOptimisation*, we
use 3 and 3, for \(k\_P\) and \(k\_A\) respectively.

Finally, to assess the validity of the weight selection, it should be
repeated a certain number of times (default value is 50). As the
weight optimisation can become very time consuming for a wide range of
weights and many target classes, we would recommend to start with a
lower number of iterations, pre-analyse the results, proceed with
further iterations and eventually combine the optimisation results
data with the *combineThetaRegRes* function before
proceeding with the selection of best weights.

```
topt <- knntlOptimisation(andy2011, andy2011goCC,
                          th = th,
                          k = c(3, 3),
                          fcol = "markers.tl",
                          times = 50)
```

The above code chunk would take too much time to be executed in the
frame of this vignette. Below, we pass a very small subset of theta
matrix to minimise the computation time. The *knntlOptimisation*
function supports parallelised execution using various backends thanks
to the *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* package; an appropriate backend
will be defined automatically according to the underlying architecture
and user-defined backends can be defined through the `BPPARAM`
argument222 Large scale applications of this algorithms were run on a cluster using an MPI backend defined with `SnowParams(256, type="MPI")`..
Also, in the interest of time, the weights optimisation is repeated
only 5 times below.

```
set.seed(1)
i <- sample(nrow(th), 12)
topt <- knntlOptimisation(andy2011, andy2011goCC,
                          th = th[i, ],
                          k = c(3, 3),
                          fcol = "markers.tl",
                          times = 5)
```

```
## Removing 308 columns with only 0s.
```

```
## Note: vector will be ordered according to classes: Cytosol Cytosol/Nucleus ER Golgi Lysosome Mitochondrion Nucleus PM Ribosome 40S Ribosome 60S (as names are not explicitly defined)
```

```
topt
```

```
## Object of class "ThetaRegRes"
## Algorithm: theta
## Theta hyper-parameters:
##  weights: 0 0.3333333 0.6666667 1
##  k: 3 3
##  nrow: 12
## Design:
##  Replication: 5 x 5-fold X-validation
##  Partitioning: 0.2/0.8 (test/train)
## Results
##  macro F1:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.6843  0.8255  0.8258  0.8212  0.8603  0.9101
##  best theta:
##             Cytosol Cytosol.Nucleus ER Golgi Lysosome Mitochondrion Nucleus PM
## weight:0          0               0  4     4        0             1       0  1
## weight:0.33       1               4  0     0        0             0       0  4
## weight:0.67       0               1  0     1        1             0       1  0
## weight:1          4               0  1     0        4             4       4  0
##             Ribosome.40S Ribosome.60S
## weight:0               5            1
## weight:0.33            0            4
## weight:0.67            0            0
## weight:1               0            0
```

The optimisation is performed on the labelled marker examples
only. When removing unlabelled non-marker proteins (the `unknowns`),
some auxiliary GO columns end up containing only 0 (the GO-protein
association was only observed in non-marker proteins), which are
temporarily removed.

The `topt` result stores all the result from the optimisation step,
and in particular the observed theta weights, which can be directly
plotted as shown on the [bubble plot](#fig:bubble) below. These bubble
plots give the proportion of best weights for each marker class that
was observed during the optimisation phase. We see that the
mitochondrion, the cytosol and cytosol/nucleus classes predominantly
are scored with height weights (2/3 and 1), consistent with high
reliability of the primary data. The Golgi and the ribosomal clusters
(and to a lesser extend the ER) favour smaller scores, indicating a
substantial benefit of the auxiliary data.

![](data:image/png;base64...)

Results obtained from an extensive optimisation on the primary `andy2011` and auxiliary `andygoset` data sets, as produced by `plot(topt)`. This figure is not the result for the previous code chunk, where only a random subset of 10 candidate weights have been tested.

## 6.2 Choosing weights

A set of best weights must be chosen and applied to the classification
of the unlabelled proteins (formally annotated as `unknown`). These
can be defined manually, based on the pattern observed in the weights
[bubble plot](#fig:bubble), or automatically extracted with the
*getParams*
method333 Note that the scores extracted here are based on the random subsest of weights.. See
*?getParams* for details and the *favourPrimary* function, if it is
desirable to systematically favour the primary data (i.e. high
weights) when different weight combinations perform equally well.

```
getParams(topt)
```

```
##         Cytosol Cytosol/Nucleus              ER           Golgi        Lysosome
##       1.0000000       0.3333333       0.0000000       0.0000000       1.0000000
##   Mitochondrion         Nucleus              PM    Ribosome 40S    Ribosome 60S
##       1.0000000       1.0000000       0.3333333       0.0000000       0.3333333
```

We provide the best parameters for the extensive parameter
optimisation search, as provided by *getParams*:

```
(bw <- experimentData(andy2011)@other$knntl$thetas)
```

```
##         Cytosol Cytosol/Nucleus              ER           Golgi        Lysosome
##       0.6666667       0.6666667       0.3333333       0.3333333       0.6666667
##   Mitochondrion         Nucleus              PM    Ribosome 40S    Ribosome 60S
##       0.6666667       0.3333333       0.3333333       0.0000000       0.3333333
```

## 6.3 Applying best *theta* weights

To apply our best weights and learn from the auxiliary data
accordingly when classifying the unlabelled proteins to one of the
sub-cellular niches considered in `markers.tl` (as displayed on figure
[1](#fig:andypca)), we pass the primary and auxiliary data sets, best
weights, best k’s (and, on our case the marker’s feature variable we
want to use, default would be `markers`) to the *knntlClassification*
function.

```
andy2011 <- knntlClassification(andy2011, andy2011goCC,
                                bestTheta = bw,
                                k = c(3, 3),
                                fcol = "markers.tl")
```

This will generate a new instance of class *MSnSet*, identical to the
primary data, including the classification results and classifications
scores of the transfer learning classification algorithm (as `knntl`
and `knntl.scores` feature variables respectively). Below, we extract
the former with the *getPrediction* function and plot the results of
the classification.

```
andy2011 <- getPredictions(andy2011, fcol = "knntl")
```

```
## ans
## Chromatin associated              Cytosol      Cytosol/Nucleus
##                   11                  266                   68
##                   ER             Endosome                Golgi
##                  193                   12                   69
##             Lysosome        Mitochondrion              Nucleus
##                   69                  258                  116
##                   PM         Ribosome 40S         Ribosome 60S
##                  229                   18                   62
```

```
setStockcol(paste0(getStockcol(), "80"))
ptsze <- exp(fData(andy2011)$knntl.scores) - 1
plot2D(andy2011, fcol = "knntl", cex = ptsze)
setStockcol(NULL)
addLegend(andy2011, where = "topright",
          fcol = "markers.tl",
          bty = "n", cex = .7)
```

![PCA plot of `andy2011` after transfer learning classification. The size of the points is proportional to the classification scores.](data:image/png;base64...)

Figure 2: PCA plot of `andy2011` after transfer learning classification
The size of the points is proportional to the classification scores.

Please read the *pRoloc-tutorial* vignette, and in particular the
classification section, for more details on how to proceed with
exploration the classification results and classification scores.

# 7 Conclusions

This vignette describes the application of a weighted \(k\)-nearest
neighbour transfer learning algorithm and its application to the
sub-cellular localisation prediction of proteins using quantitative
proteomics data as primary data and Gene Ontology-derived binary data
as auxiliary data source. The algorithm can be used with various data
sources (we show how to compile binary data from the Human Protein
Atlas in section [4.2](#sec:hpaaux)) and have successfully applied the
algorithm (Breckels et al. [2016](#ref-Breckels:2016)) on third-party quantitative auxiliary data.

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

Ashburner, M, C A Ball, J A Blake, D Botstein, H Butler, J M Cherry, A P Davis, et al. 2000. “Gene Ontology: Tool for the Unification of Biology. The Gene Ontology Consortium.” *Nat Genet* 25 (1): 25–29. <https://doi.org/10.1038/75556>.

Breckels, Lisa M, Laurent Gatto, Andy Christoforou, Arnoud J Groen, Kathryn S Lilley, and Matthew W B Trotter. 2013. “The Effect of Organelle Discovery Upon Sub-Cellular Protein Localisation.” *J Proteomics*, March. <https://doi.org/10.1016/j.jprot.2013.02.019>.

Breckels, L M, S B Holden, D Wojnar, C M Mulvey, A Christoforou, A Groen, M W Trotter, O Kohlbacher, K S Lilley, and L Gatto. 2016. “Learning from Heterogeneous Data Sources: An Application in Spatial Proteomics.” *PLoS Comput Biol* 12 (5): e1004920. <https://doi.org/10.1371/journal.pcbi.1004920>.

Christoforou, A, C M Mulvey, L M Breckels, A Geladaki, T Hurrell, P C Hayward, T Naake, et al. 2016. “A Draft Map of the Mouse Pluripotent Stem Cell Spatial Proteome.” *Nat Commun* 7: 8992. <https://doi.org/10.1038/ncomms9992>.

Gatto, Laurent, Juan Antonio Vizcaíno, Henning Hermjakob, Wolfgang Huber, and Kathryn S Lilley. 2010. “Organelle Proteomics Experimental Designs and Analysis.” *Proteomics*. <https://doi.org/10.1002/pmic.201000244>.

Uhlen, Mathias, Per Oksvold, Linn Fagerberg, Emma Lundberg, Kalle Jonasson, Mattias Forsberg, Martin Zwahlen, et al. 2010. “Towards a knowledge-based Human Protein Atlas.” *Nature Biotechnology* 28 (12): 1248–50. <https://doi.org/10.1038/nbt1210-1248>.