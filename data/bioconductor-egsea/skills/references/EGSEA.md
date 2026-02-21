Ensemble of Gene Set Enrichment Analyses

Monther Alhamdoosh1, Luyi Tian, Milica Ng and Matthew
Ritchie2

October 29, 2025

Contents

1

2

3

Introduction .

Citation.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Installation instructions.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

System prerequistes .

R package dependencies.
3.2.1
3.2.2

.
.
.
Bioconductor packages.
EGSEAdata: essential data package .

.
.

.
.

.
.

.
.

.
.

.
.

.

3.1

3.2

3.3

Installation .
3.3.1
3.3.2 GitHub .

.
.
Bioconductor .
.

.

.

.

.

.
.
.

.

.
.
.

.

.
.
.

.

.
.
.

.

.
.
.

.

4

Quick start .

.

.

.

.

.

.

.

.

4.1

4.2

EGSEA gene set collections .

EGSEA on a human dataset .

S4 classes and methods.

.

.

.

.

.

Ensemble of Gene Set Enrichment Analysis .

5

6

7

8

9

EGSEA report.

.

.

.

.

.

.

.

7.1

Comparative analysis .

.

.

.

.

.

.

.

.

EGSEA on a non-human dataset.

EGSEA on a count matrix .

10 EGSEA on a list of genes .

1m.hamdoosh@gmail.com
2mritchie@wehi.edu.au

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.
.
.

.

.

.

.

.
.
.

.

.

.

.

.
.
.

.

.

.

.

.
.
.

.

.

.

.

.
.
.

.

.

.

.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

3

3

4

4

4
5
5

5
5
6

6

6

7

12

29

30

31

31

32

33

EGSEA

11 Non-standard gene set collections .

12 Adding new GSE method .

13 Packages used .

References .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

34

36

36

38

2

EGSEA

1

Introduction

The EGSEA package implements the Ensemble of Gene Set Enrichment Analysis
(EGSEA) algorithm that utilizes the analysis results of twelve prominent GSE algo-
rithms in the literature to calculate collective significance scores for each gene set.
These methods include: ora [1], globaltest [2], plage [3], safe [4], zscore [5], gage
[6], ssgsea [7], roast, fry [8], PADOG [9], camera [10] and GSVA [11]. The ora,
gage, camera and gsva methods depend on a competitive null hypothesis while the
remaining eight methods are based on a self-contained null hypothesis. Conveniently,
EGSEA is not limited to these twelve GSE methods and new GSE tests can be easily
integrated into the framework. The plage, zscore and ssgsea algorithms are imple-
mented in the GSVA package and camera, fry and roast are implemented in the
limma package. EGSEA was implemented with parallel computation enabled using
the parallel package. There are two levels of parallelism in EGSEA:(i) parallelism at
the method-level and (ii) parallelism at the experimental contrast level. A wrapper
function was written for each individual GSE method to utilize existing R and Bio-
conductor packages and create a universal interface for all methods. The ora method
was implemented using the phyper function from the stats package, which estimates
the hypergeometric distribution for a 2 × 2 contingency table.

RNA-seq reads are first aligned to the reference genome and mapped reads are as-
signed to annotated genomic features to obtain a summarized count matrix. The
EGSEA package was developed so that it can accept a count matrix or a voom ob-
ject. Most of the GSE methods were intrinsically designed to work with microarray
expression values and not with RNA-seq counts, hence the voom transformation is
applied to the count matrix to generate an expression matrix applicable for use with
these methods [12] . Since gene set tests are most commonly applied when two ex-
perimental conditions are compared, a design matrix and a contrast matrix are used
to construct the experimental comparisons of interest. The target collection of gene
sets is indexed so that the gene identifiers can be substituted with the indices of genes
in the rows of the count matrix. The GSE analysis is then carried out by each of
the selected methods independently and an FDR value is assigned to each gene set.
Lastly, the ensemble functions are invoked to calculate collective significance scores
for each gene set.

The EGSEA package also allows for performing the over-representation analysis on the
EGSEA gene set collections that were adopted from MSigDB, KEGG and GeneSetDB
databases.

2

Citation

• Alhamdoosh, M., Ng, M., Wilson, N. J., Sheridan, J. M., Huynh, H., Wilson,
M. J., Ritchie, M. E. (2016). Combining multiple tools outperforms individual
methods in gene set enrichment analyses. bioRxiv.

3

EGSEA

3

Installation instructions

The EGSEA package was developed so that it harmonizes with the existing R packages
in the CRAN repository and the Bioconductor project.

3.1

3.2

System prerequistes
EGSEA does not require any software package or library to be installed before it can
be installed regardless of the operating system.

R package dependencies
The EGSEA package depends on several R packages that are not in the Bioconductor
project. These packages are listed below:

• HTMLUtils facilitates automated HTML report creation, in particular framed
HTML pages and dynamically sortable tables. It is used in EGSEA to generate
the stats tables. To install it, type in the R console

install.packages("HTMLUtils")

• hwriter has easy-to-use and versatile functions to output R objects in HTML
It is used in this package to create the HTML pages of the EGSEA

format.
report. To install it,

install.packages("hwriter")

• ggplot2 is an implementation of the grammar of graphics in R. It is used in

this package to create the summary plots. To install it, type

install.packages("ggplot2")

• gplots has various R programming tools for plotting data. It is used in EGSEA

to create heatmaps. To install it, run

install.packages("gplots")

• stringi allows for fast, correct, consistent, portable, as well as convenient char-
acter string/text processing in every locale and any native encoding. It is used
in generating the HTML pages. To install this package, type

install.packages("stringi")

• metap provides a number of methods for meta-analysis of significance values.

To install this package, type

install.packages("metap")

• parallel handles running much larger chunks of computations in parallel. It is
used to carry out gene set tests on parallel. It is usually installed with R.

4

EGSEA

• devtools is needed to install packages from GitHub. It is available at CRAN. For
Windows this seems to depend on having Rtools for Windows installed. You
can download and install this from: http://cran.r-project.org/bin/windows/
Rtools/. To install devtools, run in R console

install.packages("devtools")

3.2.1 Bioconductor packages

The Bioconductor packages that need to be installed in order for EGSEA to work
properly are: PADOG, GSVA, AnnotationDbi, topGO, pathview , gage, globaltest,
limma, edgeR, safe, org.Hs.eg.db, org.Mm.eg.db, org.Rn.eg.db. They can be in-
stalled from Biocondcutor using the following commands in R console

if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")

BiocManager::install(c("PADOG", "GSVA", "AnnotationDbi", "topGO",

"pathview", "gage", "globaltest", "limma", "edgeR", "safe",

"org.Hs.eg.db", "org.Mm.eg.db", "org.Rn.eg.db"))

3.2.2 EGSEAdata: essential data package

The gene set collections that are used by EGSEA were preprocessed and converted
into R data objects to be used by the EGSEA functions. The data objects are
stored in an R package, named EGSEAdata.
It contains the gene set collections
that are needed by EGSEA to perform gene set testing. EGSEAdata is available at
Bioconductor and can be also installed from GitHub.

EGSEAdata can be installed from Bioconductor by running in R console the following
commands

if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")

BiocManager::install("EGSEAdata")

It can be also installed from GitHub from inside R console using the devtools package
as follows

library(devtools)
install_github("malhamdoosh/EGSEAdata")

3.3

Installation
EGSEA can be installed from the Bioconductor project or the GitHub repository.
We aim to only push the successfully tested versions to Bioconductor. Therefore, the
GitHub version can have additional features that are not yet available in Bioconductor.

3.3.1 Bioconductor

To install the stable release version of EGSEA from Bioconductor, type in R console

5

EGSEA

if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")

BiocManager::install("EGSEA")

To install the developmental version of EGSEA from Bioconductor, run the following
commands in R console

if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")

BiocManager::install("EGSEA", version = "devel")

3.3.2 GitHub

To install the developmental version of EGSEA from GitHub, type in the R console

4

4.1

library(devtools)
install_github("malhamdoosh/EGSEA")

Quick start

EGSEA gene set collections
The Molecular Signatures Database (MSigDB) [13] v5.0 was downloaded from http:
//www.broadinstitute.org/gsea/msigdb (05 July 2015, date last accessed) and the
human gene sets were extracted for each collection (h, c1, c2, c3, c4, c5, c6, c7).
Mouse orthologous gene sets of these MSigDB collections were adopted from http:
//bioinf.wehi.edu.au/software/MSigDB/index.html [10]. EGSEA uses Entrez Gene
identifiers [14] and alternate gene identifiers must be first converted into Entrez IDs.
KEGG pathways [15] for mouse and human were downloaded using the gage package.
To extend the capabilities of EGSEA, a third database of gene sets was downloaded
from the GeneSetDB [16] http://genesetdb.auckland.ac.nz/sourcedb.html project.
In total, more than 25,000 gene sets have been collated along with annotation infor-
mation for each set (where available).

The EGSEA package has four indexing functions that utilize the gene set collections
of EGSEAdata. They map the Entrez gene IDs of the input dataset into the gene
sets of each collection and create an index for each collection. These fucntions also
extract annotation information from EGSEAdata for each gene set to be displayed
within the EGSEA HTML report. These functions are as follow

• buildKEGGIdx builds an index for the KEGG pathways collection and loads
gene set annotation. Type ?buildKEGGIdx in the console to see how to use
this function.

• buildMSigDBIdx builds indexes for the MSigDB gene set collections and loads
gene set annotation. Type ?buildMSigDBIdx in the console to see how to use
this function.

6

EGSEA

• buildGeneSetDBIdx builds indexes for the GeneSetDB collections and loads
gene set annotation. Type ?buildGeneSetDBIdx in the console to see how to
use this function.

• buildIdx is one-step method to build indexes for collections selected from the
KEGG, MSigDB and GeneSetDB databases. Type ?buildIdx in the console to
see how to use this function.

These four functions take a vector of Entrez Gene IDs and the species name and
return an object (or list of objects) of class GSCollectionIndex.

Note: To use the GSCollectionIndex objects with the other EGSEA functions, the
order of input ids vector should match that of the row names of the count matrix or
the voom object.

4.2

EGSEA on a human dataset
The EGSEA package basically performs gene set enrichment analysis on a voom object
generated by the voom function from the limma package. Actually, it was primarily
developed to extend the limma-voom RNA-seq analysis pipeline. To quickly start
with EGSEA analysis, an example on analyzing a human IL-13 dataset is presented
here.

This experiment aims to identify the biological pathways and diseases associated
with the cytokine Interleukin 13 (IL-13) using gene expression measured in peripheral
blood mononuclear cells (PBMCs) obtained from 3 healthy donors. The expression
profiles of in vitro IL-13 stimulation were generated using RNA-seq technology for
3 PBMC samples at 24 hours. The transcriptional profiles of PBMCs without IL-
13 stimulation were also generated to be used as controls. Finally, an IL-13Rα1
antagonist was introduced into IL-13 stimulated PBMCs and the gene expression
levels after 24h were profiled to examine the neutralization of IL-13 signaling by
the antagonist. Only two samples were available for the last condition. Single-end
100bp reads were obtained via RNA-seq from total RNA using a HiSeq 2000 Illumina
sequencer. TopHat was used to map the reads to the human reference genome
(GRCh37.p10). HTSeq was then used to summarize reads into a gene-level count
matrix. The TMM method from the edgeR package was used to normalize the RNA-
seq counts. Data are available from the GEO database www.ncbi.nlm.nih.gov/geo/
as series GSE79027.

To perform EGSEA analysis on this dataset, the EGSEA package is first loaded follow

library(EGSEA)

Then, the voom data object of this experiment is loaded from EGSEAdata as follows

library(EGSEAdata)

data(il13.data)

v = il13.data$voom

7

EGSEA

names(v)

## [1] "genes"

"targets" "E"

"weights" "design"

v$design

##

X24 X24IL13 X24IL13Ant X40513 X40913

## 1

## 2

## 3

## 4

## 5

## 6

## 7

## 8

0

0

1

0

1

0

0

1

1

0

0

1

0

1

0

0

0

1

0

0

0

0

1

0

0

0

1

1

0

0

0

0

0

0

0

0

1

1

1

0

## attr(,"assign")

## [1] 1 1 1 2 2

## attr(,"contrasts")
## attr(,"contrasts")$`d1$samples$group`
## [1] "contr.treatment"

##
## attr(,"contrasts")$`d1$samples$Date`
## [1] "contr.treatment"

contrasts = il13.data$contra

contrasts

##

Contrasts

## Levels

X24IL13 - X24 X24IL13Ant - X24IL13

##

##

##

##

##

X24

X24IL13

X24IL13Ant

X40513

X40913

-1

1

0

0

0

0

-1

1

0

0

A detailed explanation on how a voom can be created from a raw RNA-seq count
matrix can be found in this workflow article [17].

Before the EGSEA pipeline is invoked, gene set collections need to be pre-processed
and indexed using the EGSEA indexing functions as it was mentioned earlier. Here,
indexes for the KEGG pathways and the c5 collection from the MSigDB are created
as follows

gs.annots = buildIdx(entrezIDs = rownames(v$E), species = "human",

msigdb.gsets = "c5", kegg.exclude = c("Metabolism"))

## [1] "Loading MSigDB Gene Sets ... "

## [1] "Loaded gene sets for the collection c5 ..."

## [1] "Indexed the collection c5 ..."

8

EGSEA

## [1] "Created annotation for the collection c5 ..."

## [1] "Building KEGG pathways annotation object ... "

names(gs.annots)

## [1] "c5"

"kegg"

The gs.annots is a list of two objects of class GSCollectionIndex that are labelled
with "kegg" and "c5".

A quick summary of the collection indexes can be displayed using the summary function
as follows

summary(gs.annots$kegg)

## KEGG Pathways (kegg): 203 gene sets - Version: NA, Update date: 07 March 2017

summary(gs.annots$c5)

## c5 GO Gene Sets (c5): 6166 gene sets - Version: 5.2, Update date: 07 March 2017

This shows the name, label and number of gene sets in the KEGG collection. Next,
we select the base methods of the EGSEA analysis

baseMethods = egsea.base()[-c(2, 12)]

baseMethods

## [1] "camera"

## [6] "zscore"

"safe"

"gsva"

"gage"

"padog"

"plage"

"ssgsea"

"globaltest" "ora"

Another important parameter for the EGSEA analysis is the sort.by argument which
determines how the gene sets are ordered. The possible values of this argument can
be seen as follows

egsea.sort()

## [1] "p.value"

"p.adj"

"vote.rank"

"avg.rank"

## [5] "med.rank"

"min.pvalue"

"min.rank"

"avg.logfc"

## [9] "avg.logfc.dir" "direction"

"significance"

"camera"

## [13] "roast"

## [17] "plage"

"safe"

"zscore"

## [21] "globaltest"

"ora"

"gage"

"gsva"

"fry"

"padog"

"ssgsea"

Finally, the EGSEA analysis can be performed using the egsea function as follows

# perform the EGSEA analysis set report = TRUE to generate

# HTML report.

set display.top = 20 to display more gene

# sets. It takes longer time to run.

gsa = egsea(voom.results = v, contrasts = contrasts, gs.annots = gs.annots,

symbolsMap = v$genes, baseGSEAs = baseMethods, report.dir = "./il13-egsea-report",

9

EGSEA

sort.by = "avg.rank", num.threads = 4, report = FALSE)

## EGSEA analysis has started

## ##------ Wed Oct 29 23:47:02 2025 ------##

## Log fold changes are estimated using limma package ...

## limma DE analysis is carried out ...

## EGSEA is running on the provided data and c5 collection

##

## EGSEA is running on the provided data and kegg collection

##

## ##------ Wed Oct 29 23:47:56 2025 ------##

## EGSEA analysis took 54.483 seconds.

## EGSEA analysis has completed

The function egsea returns an object of class EGSEAResults, which is described
next in Section 5. To generate an HTML report of the EGSEA analysis results, you
need to set report=TRUE. Then, the EGSEA report can be launched by opening
./il13-egsea-report/index.html. A quick summary of the top ten significant gene sets
from each collection and for each contrast including the comparative analysis, if there
are more than one contrast, can be displayed using the summary function as follows

summary(gsa)

## **** Top 10 gene sets in the c5 GO Gene Sets collection ****
## ** Contrast X24IL13-X24 **
## GO_CLATHRIN_COATED_ENDOCYTIC_VESICLE_MEMBRANE | GO_CLATHRIN_COATED_VESICLE_MEMBRANE
## GO_CLATHRIN_COATED_ENDOCYTIC_VESICLE | GO_ICOSANOID_BIOSYNTHETIC_PROCESS
## GO_FATTY_ACID_DERIVATIVE_BIOSYNTHETIC_PROCESS | GO_UNSATURATED_FATTY_ACID_BIOSYNTHETIC_PROCESS
## GO_POSITIVE_REGULATION_OF_CYTOKINE_SECRETION | GO_MHC_CLASS_II_PROTEIN_COMPLEX
## GO_MHC_CLASS_II_RECEPTOR_ACTIVITY | GO_LEUKOTRIENE_METABOLIC_PROCESS
##
## ** Contrast X24IL13Ant-X24IL13 **
## GO_CLATHRIN_COATED_ENDOCYTIC_VESICLE_MEMBRANE | GO_POSITIVE_REGULATION_OF_NF_KAPPAB_IMPORT_INTO_NUCLEUS
## GO_CLATHRIN_COATED_VESICLE_MEMBRANE | GO_POSITIVE_REGULATION_OF_ACUTE_INFLAMMATORY_RESPONSE
## GO_CXCR_CHEMOKINE_RECEPTOR_BINDING | GO_REGULATION_OF_INTERLEUKIN_1_BETA_PRODUCTION
## GO_POSITIVE_REGULATION_OF_CYTOKINE_SECRETION | GO_POSITIVE_REGULATION_OF_INTERLEUKIN_8_PRODUCTION
## GO_IGG_BINDING | GO_REGULATION_OF_VASCULAR_ENDOTHELIAL_GROWTH_FACTOR_PRODUCTION
##
## ** Comparison analysis **
## GO_CLATHRIN_COATED_ENDOCYTIC_VESICLE_MEMBRANE | GO_CLATHRIN_COATED_VESICLE_MEMBRANE
## GO_POSITIVE_REGULATION_OF_NF_KAPPAB_IMPORT_INTO_NUCLEUS | GO_POSITIVE_REGULATION_OF_CYTOKINE_SECRETION

10

EGSEA

## GO_POSITIVE_REGULATION_OF_ACUTE_INFLAMMATORY_RESPONSE | GO_CLATHRIN_COATED_ENDOCYTIC_VESICLE
## GO_MHC_CLASS_II_PROTEIN_COMPLEX | GO_MHC_CLASS_II_RECEPTOR_ACTIVITY
## GO_CXCR_CHEMOKINE_RECEPTOR_BINDING | GO_REGULATION_OF_INTERLEUKIN_1_BETA_PRODUCTION
##
## **** Top 10 gene sets in the KEGG Pathways collection ****
## ** Contrast X24IL13-X24 **
## Amoebiasis | Asthma

## Intestinal immune network for IgA production | Endocrine and other factor-regulated calcium reabsorption

## Viral myocarditis | HTLV-I infection

## Prion diseases | Proteoglycans in cancer

## Hematopoietic cell lineage | Legionellosis

##
## ** Contrast X24IL13Ant-X24IL13 **
## Toll-like receptor signaling pathway | NOD-like receptor signaling pathway

## Viral myocarditis | Malaria

## HTLV-I infection | Asthma

## Legionellosis | Melanoma

## TNF signaling pathway | Hematopoietic cell lineage

##
## ** Comparison analysis **
## Asthma | Viral myocarditis

## Amoebiasis | HTLV-I infection

## NOD-like receptor signaling pathway | Intestinal immune network for IgA production

## Toll-like receptor signaling pathway | Legionellosis

## Hematopoietic cell lineage | Malaria

To run the EGSEA analysis with all the gene set collections that are avilable in the
EGSEAdata package, use the buildIdx function to create the gene set indexes as
follows

gs.annots = buildIdx(entrezIDs = rownames(v$E), species = "human",

gsdb.gsets = "all")

## [1] "Loading MSigDB Gene Sets ... "

## [1] "Loaded gene sets for the collection h ..."

## [1] "Indexed the collection h ..."

## [1] "Created annotation for the collection h ..."

## [1] "Loaded gene sets for the collection c1 ..."

## [1] "Indexed the collection c1 ..."

## [1] "Created annotation for the collection c1 ..."

## [1] "Loaded gene sets for the collection c2 ..."

## [1] "Indexed the collection c2 ..."

## [1] "Created annotation for the collection c2 ..."

## [1] "Loaded gene sets for the collection c3 ..."

## [1] "Indexed the collection c3 ..."

11

EGSEA

## [1] "Created annotation for the collection c3 ..."

## [1] "Loaded gene sets for the collection c4 ..."

## [1] "Indexed the collection c4 ..."

## [1] "Created annotation for the collection c4 ..."

## [1] "Loaded gene sets for the collection c5 ..."

## [1] "Indexed the collection c5 ..."

## [1] "Created annotation for the collection c5 ..."

## [1] "Loaded gene sets for the collection c6 ..."

## [1] "Indexed the collection c6 ..."

## [1] "Created annotation for the collection c6 ..."

## [1] "Loaded gene sets for the collection c7 ..."

## [1] "Indexed the collection c7 ..."

## [1] "Created annotation for the collection c7 ..."

## [1] "Loading GeneSetDB Gene Sets ... "

## [1] "Created the GeneSetDB Gene Sets collection ... "

## 260 gene sets from the GeneSetDB gsdbgo collection do not have valid GO ID.

## They will be removed.

## [1] "Building KEGG pathways annotation object ... "

names(gs.annots)

## [1] "h"

## [7] "c6"

"c1"

"c7"

## [13] "gsdbreg"

"kegg"

"c2"

"c3"

"c4"

"c5"

"gsdbdrug" "gsdbdis"

"gsdbgo"

"gsdbpath"

5

S4 classes and methods

EGSEA implements two S4 classes to perform its functionalities efficiently. The
GSCollectionIndex stores an indexed gene set collection, which can be used to perform
an EGSEA analysis, and the EGSEAResults stores the results of an EGSEA analysis.
Each class has several slots and S4 methods to enable the user explore EGSEA results
efficiently and effectively (Figure 1).

The GSCollectionIndex class has seven slots and four S4 methods that are defined
as follows

• GSCollectionIndex slots:

• original is a list of character vectors, each stores the Entrez Gene IDs

of a gene set.

• idx is a list of character vectors, each stores only the indexes of the

mapped genes of a set.

• anno is a data frame that stores additional annotation for each gene set.

• featureIDs is a character vector of the Entrez Gene IDs that were used

to index the gene sets.

12

EGSEA

Figure 1: The S4 classes and methods of EGSEA.

• species is a character that stores the species name. It accepts

• name is a character that stores a short description of the gene set collection.

• label is a character that stores a label for the collection to identify it
from other collections when multiple collections are used for an EGSEA
analysis.

• GSCollectionIndex S4 methods:

• show displays the content of the gene set collection.

• summary displays a brief summary of the gene set collection.

• getSetByName returns a list of the details of gene sets given their names.

• getSetByID returns a list of the details of gene sets given their IDs.

The EGSEAResults class has eleven slots and ten S4 methods that are defined as
follows

• EGSEAResults slots:

13

EGSEA

• results is a list that stores the EGSEA analysis results in a hierarchi-
cal format (Figure 2). The comparison element only exists when more
than one contrast are analyzed. The ind.results only exists if the EGSEA
function argument print.base = TRUE.

• limmaResults is a limma linear fit model. This is only defined when

keep.limma = TRUE.

• contrasts is a character vector of contrast names.

• sampleSize is a numeric value of the number of samples.

• gs.annots is a list of objects of class GSCollectionIndex that stores the
indexed gene set collections that were used in the EGSEA analysis.

• baseMethods is a character vector of the base GSE methods that were

used in the EGSEA analysis.

• baseInfo is a list that stores additional information on the base methods

(e.g., version).

• combineMethod is a character value of the name of p-value combinging

method.

• sort.by is a character value of the sorting EGSEA score.

• symbolsMap is a data frame of two columns that stores the mapping of

the Entrez Gene IDs to their gene symbols.

• logFC is a matrix of the calculated (or provided) logFC values where

columns correspond to contrasts and rows correspond to genes.

• report is a logical value indicates whether an HTML report was generated

or not.

• report.dir is a character value of the HTML report directory (if it was

generated).

• EGSEAResults S4 methods:

• show displays the parameters of the EGSEAResults object.

• summary displays a brief summary of the EGSEA analysis results.

• topSets extracts a table of the top-ranked gene sets from an EGSEA

analysis.

• plotSummary generates a Summary plot of an EGSEA analysis for a given

gene set collection and a selected contrast.

• plotMethods generates a multi-dimensional scaling (MDS) plot for the

gene set rankings of the base methods of an EGSEA analysis.

• plotHeatmap generates a heatmap of fold changes for a selected gene set.

• plotPathway generates a visual map for a selected KEGG pathway.

14

EGSEA

• showSetByName displays the details of gene sets given their names and

their collection.

• showSetByID displays the details of gene sets given their IDs and their

collection.

• limmaTopTable returns a dataframe of the top table of the limma analysis
for a given contrast. This is only defined when keep.limma = TRUE.

• getlimmaResults returns the linear model fit produced by limma::eBayes.

This is only defined when keep.limma = TRUE.

• getSetScores returns a dataframe of the gene set enrichment scores per
sample. This can be only calculated using specific base methods, namely,
"ssgsea". This is only defined when keep.set.scores = TRUE.

• plotSummaryHeatmap generates a summary heatmap for the top n gene

sets of the comparative analysis of multiple contrasts.

Figure 2: The structure of the slot results of the class EGSEAResults.

Next, we show how these different methods can be used to query the EGSEA results.
To obtain a quick overview of the parameters of IL-13 EGSEA analysis

show(gsa)

## An object of class "EGSEAResults"

15

EGSEAResults@results	Collec&on	1	Collec&on	2	Collec&on	3	Collec&on	n	…	comparison	test.results	top.gene.sets	base.results	test.results	top.gene.sets	contrast		1	contrast	2	contrast		3	contrast		m	.	.	.		contrast		1	contrast	2	contrast		3	contrast		m	contrast		1	contrast	2	contrast		3	contrast		m	.	.	.		.	.	.		{}	list	[]	data	frame	()	vector	()	()	()	()	()	[]	[]	[]	[]	{}	{}	{}	{}	[]	{}	{}	{}	{}	{}	{}	{}	{}	{}	Method	1	Method	2	Method	L	.	.	.		{}	[]	[]	[]	EGSEA

## Total number of genes: 17343

## Total number of samples: 8

## Contrasts: X24IL13-X24, X24IL13Ant-X24IL13

## Base GSE methods: camera (limma:3.66.0), safe (safe:3.50.0), gage (gage:2.60.0), padog (PADOG:1.52.0), plage (GSVA:2.4.0), zscore (GSVA:2.4.0), gsva (GSVA:2.4.0), ssgsea (GSVA:2.4.0), globaltest (globaltest:5.64.0), ora (stats:4.5.1)

## P-values combining method: wilkinson

## Sorting statistic: avg.rank

## Organism: Homo sapiens

## HTML report generated: No

## Tested gene set collections:

##

##

c5 GO Gene Sets (c5): 6166 gene sets - Version: 5.2, Update date: 07 March 2017

KEGG Pathways (kegg): 203 gene sets - Version: NA, Update date: 07 March 2017

## EGSEA version: 1.38.0

## EGSEAdata version: 1.37.0

## Use summary(object) and topSets(object, ...) to explore this object.

The EGSEA analysis results can be queried in different ways. For example, the top
10 gene sets of the KEGG collection for the contrast X24IL13-X24 can be retrieved
as follows

topSets(gsa, contrast = 1, gs.label = "kegg", number = 10)

## Extracting the top gene sets of the collection

## KEGG Pathways for the contrast X24IL13-X24

## Sorted by avg.rank

## [1] "Amoebiasis"

## [2] "Asthma"

## [3] "Intestinal immune network for IgA production"

## [4] "Endocrine and other factor-regulated calcium reabsorption"

## [5] "Viral myocarditis"

## [6] "HTLV-I infection"

## [7] "Prion diseases"

## [8] "Proteoglycans in cancer"

## [9] "Hematopoietic cell lineage"

## [10] "Legionellosis"

Here the gene sets are ordered based on the value of the argument sort.by when the
EGSEA analysis was invoked, i.e., the avg.rank in this example. However, the top
gene sets based on a selected EGSEA score, e.g. ORA ranking, can be retreieved as
follows

t = topSets(gsa, contrast = 1, gs.label = "c5", sort.by = "ora",

number = 10, names.only = FALSE)

## Extracting the top gene sets of the collection

## c5 GO Gene Sets for the contrast X24IL13-X24

## Sorted by ora

16

EGSEA

t

5

6050

1555

3925

5555

1590

5075

10

10

3825

p.value

1 4.223452e-30

2 6.084844e-26

3 1.786982e-25

4 4.501501e-21

5 1.407154e-20

6 1.016920e-19

7 2.449741e-19

8 1.327858e-18

9 3.646334e-18

10 3.146056e-17

p.adj vote.rank

Rank

2.602913e-26

3.671056e-22

8.953256e-17

1.445381e-17

6.935687e-18

1.875045e-22

##
## GO_IMMUNE_RESPONSE
## GO_IMMUNE_SYSTEM_PROCESS
## GO_DEFENSE_RESPONSE
## GO_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
## GO_EXTRACELLULAR_SPACE
## GO_INNATE_IMMUNE_RESPONSE
## GO_RESPONSE_TO_CYTOKINE
## GO_CELLULAR_RESPONSE_TO_CYTOKINE_STIMULUS
## GO_POSITIVE_REGULATION_OF_RESPONSE_TO_STIMULUS
## GO_POSITIVE_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
##
## GO_IMMUNE_RESPONSE
## GO_IMMUNE_SYSTEM_PROCESS
## GO_DEFENSE_RESPONSE
## GO_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
## GO_EXTRACELLULAR_SPACE
## GO_INNATE_IMMUNE_RESPONSE
## GO_RESPONSE_TO_CYTOKINE
## GO_CELLULAR_RESPONSE_TO_CYTOKINE_STIMULUS
## GO_POSITIVE_REGULATION_OF_RESPONSE_TO_STIMULUS
2.042942e-15
## GO_POSITIVE_REGULATION_OF_IMMUNE_SYSTEM_PROCESS 1.491473e-14
##
## GO_IMMUNE_RESPONSE
## GO_IMMUNE_SYSTEM_PROCESS
## GO_DEFENSE_RESPONSE
## GO_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
## GO_EXTRACELLULAR_SPACE
## GO_INNATE_IMMUNE_RESPONSE
## GO_RESPONSE_TO_CYTOKINE
## GO_CELLULAR_RESPONSE_TO_CYTOKINE_STIMULUS
## GO_POSITIVE_REGULATION_OF_RESPONSE_TO_STIMULUS
## GO_POSITIVE_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
##
## GO_IMMUNE_RESPONSE
## GO_IMMUNE_SYSTEM_PROCESS
## GO_DEFENSE_RESPONSE
## GO_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
## GO_EXTRACELLULAR_SPACE
## GO_INNATE_IMMUNE_RESPONSE
## GO_RESPONSE_TO_CYTOKINE
## GO_CELLULAR_RESPONSE_TO_CYTOKINE_STIMULUS
## GO_POSITIVE_REGULATION_OF_RESPONSE_TO_STIMULUS

4.051483e-19

5.001667e-22

1.985535e-26

2.721934e-20

1.887219e-16

1.327858e-19

8.183590e-16

4.692724e-31

6.760938e-27

1.563504e-21

1.016920e-20

2266.1

3151.2

3166.1

3187.8

3284.5

2596.1

2498.1

3658.4

1979.4

3015.3

avg.rank med.rank

2516.5

3411.5

2536.5

3081.5

4299.5

1986.5

3340.5

1478.0

3631.5

2804.0

min.pvalue min.rank

1

2

3

4

5

4

4

3

9

17

EGSEA

avg.logfc avg.logfc.dir

direction significance

10

1.775304

1.632048

1.786638

1.485645

1.942962

2.010952

2.173693

2.204445

1.657213

1.463488

100.00000

79.88931

84.26414

60.46068

73.55714

68.42096

72.19984

70.88090

55.46152

50.42693

Up

Up

Up

Up

Up

Up

1.600137

1.545729

1.991152

1.851236

1.493355

1.558363

1.666075

1.806955

1.656540

1.946023

## GO_POSITIVE_REGULATION_OF_IMMUNE_SYSTEM_PROCESS 3.495618e-18
##
## GO_IMMUNE_RESPONSE
## GO_IMMUNE_SYSTEM_PROCESS
## GO_DEFENSE_RESPONSE
## GO_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
## GO_EXTRACELLULAR_SPACE
## GO_INNATE_IMMUNE_RESPONSE
## GO_RESPONSE_TO_CYTOKINE
## GO_CELLULAR_RESPONSE_TO_CYTOKINE_STIMULUS
## GO_POSITIVE_REGULATION_OF_RESPONSE_TO_STIMULUS
## GO_POSITIVE_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
##
## GO_IMMUNE_RESPONSE
## GO_IMMUNE_SYSTEM_PROCESS
## GO_DEFENSE_RESPONSE
## GO_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
## GO_EXTRACELLULAR_SPACE
## GO_INNATE_IMMUNE_RESPONSE
## GO_RESPONSE_TO_CYTOKINE
## GO_CELLULAR_RESPONSE_TO_CYTOKINE_STIMULUS
## GO_POSITIVE_REGULATION_OF_RESPONSE_TO_STIMULUS
## GO_POSITIVE_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
##
## GO_IMMUNE_RESPONSE
## GO_IMMUNE_SYSTEM_PROCESS
## GO_DEFENSE_RESPONSE
## GO_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
## GO_EXTRACELLULAR_SPACE
## GO_INNATE_IMMUNE_RESPONSE
## GO_RESPONSE_TO_CYTOKINE
## GO_CELLULAR_RESPONSE_TO_CYTOKINE_STIMULUS
## GO_POSITIVE_REGULATION_OF_RESPONSE_TO_STIMULUS
## GO_POSITIVE_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
##
## GO_IMMUNE_RESPONSE
## GO_IMMUNE_SYSTEM_PROCESS
## GO_DEFENSE_RESPONSE
## GO_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
## GO_EXTRACELLULAR_SPACE
## GO_INNATE_IMMUNE_RESPONSE
## GO_RESPONSE_TO_CYTOKINE
## GO_CELLULAR_RESPONSE_TO_CYTOKINE_STIMULUS
## GO_POSITIVE_REGULATION_OF_RESPONSE_TO_STIMULUS
## GO_POSITIVE_REGULATION_OF_IMMUNE_SYSTEM_PROCESS

3293 3995

3308 4014

4221 5900

4066 5787

5790 5731

3565 3835

4658 5747

3888 4513

6158 5681

4650 5084

1589 2384

6077 1252

Up

Up

Up

Up

camera safe gage padog plage

1962 1174 5644

6049 1127 5221

1553 2353 5367

3923 1150 5545

5555 1185 5973

1

3071

919

2602

1136

2720

377

2240

3168

4906

4

664

2601

5074 1228 5791

9

5832 1129 5231

3823 1192 5469

zscore gsva ssgsea

4

3

9

2031

1704

2605

383

1785

4636

5488

4341

5902

4533

4216

5568

4554

5289

5924

18

EGSEA

##
## GO_IMMUNE_RESPONSE
## GO_IMMUNE_SYSTEM_PROCESS
## GO_DEFENSE_RESPONSE
## GO_REGULATION_OF_IMMUNE_SYSTEM_PROCESS
## GO_EXTRACELLULAR_SPACE
## GO_INNATE_IMMUNE_RESPONSE
## GO_RESPONSE_TO_CYTOKINE
## GO_CELLULAR_RESPONSE_TO_CYTOKINE_STIMULUS
## GO_POSITIVE_REGULATION_OF_RESPONSE_TO_STIMULUS
## GO_POSITIVE_REGULATION_OF_IMMUNE_SYSTEM_PROCESS

globaltest ora

1204

1316

1166

1216

1406

930

716

653

1003

1

2

3

4

5

6

7

8

9

1236

10

This can be useful to identify over-represented GO terms since GO gene sets in the
c5 collection are based on ontologies which do not necessarily comprise co-regulated
genes. More information on the first gene set can be retrieved as follows

showSetByName(gsa, "c5", rownames(t)[1])

## ID: M14329
## GeneSet: GO_IMMUNE_RESPONSE
## BroadUrl: http://www.broadinstitute.org/gsea/msigdb/cards/GO_IMMUNE_RESPONSE.html
## Description: Any immune system process that functions in the calibrated response of an organism to a potential internal or invasive threat.

## PubMedID:

## NumGenes: 829/1100

## Contributor: Gene Ontology

## Ontology: BP

## GOID: GO:0006955

The NumGenes shows the number of your dataset genes that were mapped to this
gene set out of the total number of genes in the set. This ratio mainly depends on
the filtering criteria that are used for constructing the count matrix.

Similarly, the top gene sets of the comparative analysis can be retrieved as follows

t = topSets(gsa, contrast = "comparison", gs.label = "kegg",

number = 10)

## Extracting the top gene sets of the collection

## KEGG Pathways for the contrast comparison

## Sorted by avg.rank

t

## [1] "Asthma"

## [2] "Viral myocarditis"

## [3] "Amoebiasis"

## [4] "HTLV-I infection"

## [5] "NOD-like receptor signaling pathway"

19

EGSEA

## [6] "Intestinal immune network for IgA production"

## [7] "Toll-like receptor signaling pathway"

## [8] "Legionellosis"

## [9] "Hematopoietic cell lineage"

## [10] "Malaria"

More information on the first gene set of the comparative analysis can be retrieved
as follows

showSetByName(gsa, "kegg", rownames(t)[1])

Next, the visualization capabilities of EGSEA are explored. The results can be visu-
alized at the experiment-level using the MDS plot, Summary or GO Graph plots, or
at the set-level using heatmaps and pathway maps.

The performance of the EGSEA base methods on a selected contrast can be visualized
usign an MDS plot that shows how different methods rank a gene set collection
(Figure 3). For example, the performance of the various methods on the contrast
X24IL13-X24 and the KEGG collection can be plotted as follows

plotMethods(gsa, gs.label = "kegg", contrast = 1, file.name = "X24IL13-X24-kegg-methods")

## Generating methods plot for the collection

## KEGG Pathways and for the contrast X24IL13-X24

## character(0)

The overall EGSEA significance of all gene sets in a given collection and a selected
contrast can be visualized using the summary plots (Figure 4) as follows

plotSummary(gsa, gs.label = "kegg", contrast = 1, file.name = "X24IL13-X24-kegg-summary")

## Generating Summary plots for the collection

## KEGG Pathways and for the contrast X24IL13-X24

## Warning:

‘qplot()‘ was deprecated in ggplot2 3.4.0.

## i The deprecated feature was likely used in the EGSEA package.

##

Please report the issue to the authors.

## This warning is displayed once every 8 hours.
## Call ‘lifecycle::last_lifecycle_warnings()‘ to see where this warning
was

## generated.

Gene set IDs are used to highlight significant sets on the Summary plot. To obtain
additional information on these gene sets, the function showSetByID can be used as
follows

20

EGSEA

Figure 3: The performance of multiple GSE methods on the contrast X24IL13-X24.

showSetByID(gsa, gs.label = "kegg", c("hsa04060", "hsa04640"))

## ID: hsa04060

## GeneSet: Cytokine-cytokine receptor interaction

## NumGenes: 194/270

## Type: Signaling

##

## ID: hsa04640

## GeneSet: Hematopoietic cell lineage

## NumGenes: 85/97

## Type: Signaling

21

−2002040−20−10010203040Leading rank dim 1 (41%)Leading rank dim 2 (20%)camerasafegagepadogplagezscoregsvassgseaglobaltestoraEGSEA

(a) Directional summary plot

(b) Ranking summary plot

Figure 4: Summary plots for the contrast X24IL13-X24 on the KEGG pathways collection.

Gene Ontology (GO) graphs can be generated for the three categories of GO terms:
Biological Process (BP), Molecular Function (MF) and Cellular Componenet (CC).
There are two GO term collections in the package EGSEAdata: c5 from MSigDB
and gsdbgo from GeneSetDB. To generate the GO graphs for c5 collection on the
contrast X24IL13-X24

plotGOGraph(gsa, gs.label = "c5", file.name = "X24IL13-X24-c5-top-",

sort.by = "avg.rank")

## Generating GO Graphs for the collection c5 GO Gene Sets

## and for the contrast X24IL13-X24 based on the avg.rank

##

## Building most specific GOs .....

## Loading required package:

org.Hs.eg.db

## ( 11116 GO terms found.

)

##

## Build GO DAG topology ..........

## ( 13989 GO terms and 30843 relations.

)

##

## Annotating nodes ...............

## ( 12555 genes annotated to the GO terms.

)

##

## Building most specific GOs .....

## ( 4256 GO terms found.

)

##

## Build GO DAG topology ..........

## ( 4626 GO terms and 6045 relations.

)

22

hsa05146hsa05310hsa04672hsa04961hsa05416hsa05166hsa05020hsa05205hsa04640hsa05134hsa04145hsa05150hsa04060hsa052170123450510−log10(p−value)Average Absolute logFCsignificance0255075100Regulation Direction−1.0−0.50.00.51.0hsa05146hsa05310hsa04672hsa04961hsa05416hsa05166hsa05020hsa05205hsa04640hsa051340123450510−log10(p−value)Average Absolute logFCRank255075100Cardinality100200300400EGSEA

##

## Annotating nodes ...............

## ( 12767 genes annotated to the GO terms.

)

##

## Building most specific GOs .....

## ( 1768 GO terms found.

)

##

## Build GO DAG topology ..........

## ( 1929 GO terms and 3153 relations.

)

##

## Annotating nodes ...............

## ( 13170 genes annotated to the GO terms.

)

## Loading required package:

Rgraphviz

## Loading required package:

grid

##

## Attaching package: ’grid’

## The following object is masked from ’package:topGO’:

##

##

##

depth

## Attaching package: ’Rgraphviz’

## The following objects are masked from ’package:IRanges’:

##

##

from, to

## The following objects are masked from ’package:S4Vectors’:

##

##

from, to

This command generates three graphs, one for each GO category and, by default,
displays the top 5 significant terms in each category. For example, Figure 5 shows
the BP graph.

Heatmaps of the gene fold changes can be gereated for a selected gene set as follows

plotHeatmap(gsa, "Asthma", gs.label = "kegg", contrast = 1, file.name = "asthma-hm")

## Generating heatmap for Asthma from the collection

## KEGG Pathways and for the contrast X24IL13-X24

23

EGSEA

Figure 5: The top significant Biological Processes (BP) from the c5 collection.

Figure 6 shows the Asthma gene set heatmap. For the KEGG collection, a pathway
map that shows the gene interactiosn can be generated as follows

plotPathway(gsa, "Asthma", gs.label = "kegg", file.name = "asthma-pathway")

24

GO:0006082organic acid metabol...GO:0006629lipid metabolic proc...GO:0006631fatty acid metabolic...GO:0006633fatty acid biosynthe...GO:0006636unsaturated fatty ac...GO:0006690icosanoid metabolic ...GO:0006691leukotriene metaboli...GO:0008150biological_processGO:0008152metabolic processGO:0008610lipid biosynthetic p...GO:0009058biosynthetic processGO:0009987cellular processGO:0016053organic acid biosynt...GO:0019752carboxylic acid meta...GO:0032787monocarboxylic acid ...GO:0033559unsaturated fatty ac...GO:0043436oxoacid metabolic pr...GO:0044238primary metabolic pr...GO:0044281small molecule metab...GO:0044283small molecule biosy...GO:0046394carboxylic acid bios...GO:0046456icosanoid biosynthet...GO:0072330monocarboxylic acid ...GO:1901568fatty acid derivativ...GO:1901570fatty acid derivativ...EGSEA

Figure 6: Asthma heatmap for the contrast X24IL13-X24

## Generating pathway map for Asthma from the collection

## KEGG Pathways and for the contrast X24IL13-X24

## [1] TRUE

Figure 7: Asthma pathway map for the contrast X24IL13-X24

25

  IL13IL5IL4HLA−DOBEPXHLA−DRB3MS4A2CD40LGTNFFCER1AFCER1GIL10RNASE3PRG2HLA−DMBHLA−DOAHLA−DMAHLA−DPB1HLA−DQB1HLA−DPA1HLA−DQA1HLA−DRB5HLA−DQA2HLA−DRAHLA−DRB1Asthma(logFC)−100.51logFC051015Color Keyand HistogramCountSignificance of DEFDR <= 0.05FDR > 0.05EGSEA

Figure 7 shows the Asthma pathway map with nodes coloured based on the gene fold
changes in the contrast X24IL13-X24.

Similar reporting capabilities are also provided for the comparative analysis results of
EGSEA. A summary plot that compares two contrasts can be generated as follows

plotSummary(gsa, gs.label = "kegg", contrast = c(1, 2), file.name = "kegg-summary-cmp")

## Generating Summary plots for the collection

## KEGG Pathways and for the comparison X24IL13-X24 vs X24IL13Ant-X24IL13

Figure 8: Summary plot for the comparative analysis

Figure 8 shows a comparative summary plot between the two contrasts of the IL-13
dataset. It clearly highlights the effectiveness of the IL-13 antagonist in neuteralizing
most of the IL-13 stimulated pathways.

Alternatively, a summary heatmap for all the contrasts at the gene set level can
generated as follows

plotSummaryHeatmap(gsa, gs.label = "kegg", show.vals = "p.adj",

file.name = "il13-sum-heatmap")

## Generating summary heatmap for the collection KEGG Pathways

## sort.by:

avg.rank, hm.vals:

avg.rank, show.vals:

p.adj

26

hsa05310hsa05416hsa05146hsa05166hsa04621hsa04672hsa04620hsa05134hsa04640hsa05144hsa05152hsa05150hsa04060hsa0414505100510−log10(p−value) for X24IL13−X24−log10(p−value) for X24IL13Ant−X24IL13significance0255075100Regulation Direction−1.0−0.50.00.51.0EGSEA

Figure 9 shows a summary heatmap for the rankings of top 20 gene sets of the
comparative analysis across all the contrasts. The EGSEA adjusted p-values are
displayed on the heatmap for each gene set. This can help to identify gene sets that
are highly ranked/sgnificant in multiple contrasts.

Figure 9: Summary heatmap for the comparative analysis

To closely see how the antagonist works for a given pathway, a comparative heatmap
can be generated as follows

plotHeatmap(gsa, "Asthma", gs.label = "kegg", contrast = "comparison",

file.name = "asthma-hm-cmp")

## Generating heatmap for Asthma from the collection

## KEGG Pathways and for the contrast comparison

27

X24IL13−X24X24IL13Ant−X24IL13NOD−like receptor  ...Toll−like receptor ...LegionellosisHematopoietic cell ...MalariaMelanomaAmoebiasisIntestinal immune  ...AsthmaViral myocarditisHTLV−I infectionEndocrine and othe ...Proteoglycans in c ...Prion diseasesTuberculosisCardiac muscle con ...Wnt signaling path ...ToxoplasmosisEpstein−Barr virus ...Chronic myeloid le ...0.003400.11824e−040.0020000.00200.00780.01028e−040.00144e−040.004305e−042e−047e−040.01610.00980.00340.10260.02040.00672e−040.1416000.06670.22860.02740.01810.02710.0170.04920.07680.01610.0181KEGG Pathways (sorted by avg.rank)3040506070avg.rankComparison RankHighMediumLowEGSEA

Figure 10: Asthma heatmap for the comparative analysis

The heatmap clearly shows that all the genes that were stimulated by IL-13 were
reveresed when the antagonist was introduced (Figure 10). Finally, a comparative
pathway map can be used to quickly see which genes of the Asthma pathway are
affected by IL-13 stimulation (Figure 11) and can be generated as follows

plotPathway(gsa, "Asthma", gs.label = "kegg", contrast = 0, file.name = "asthma-pathway-cmp")

## Generating pathway map for Asthma from the collection

## KEGG Pathways and for the contrast comparison

## [1] TRUE

28

X24IL13−X24X24IL13Ant−X24IL13IL4IL13IL5CD40LGTNFMS4A2HLA−DOBHLA−DRB3EPXHLA−DMBFCER1AFCER1GRNASE3IL10PRG2HLA−DOAHLA−DMAHLA−DQA1HLA−DPA1HLA−DPB1HLA−DQB1HLA−DQA2HLA−DRAHLA−DRB1HLA−DRB5Asthma(logFC)−100.51logFC02468Color Keyand HistogramCountSignificance of DEFDR <= 0.05 for at least oneFDR > 0.05 for all contrastsEGSEA

Figure 11: Asthma pathway map for the comparative analysis

6

Ensemble of Gene Set Enrichment Analysis

Given an RNA-seq dataset D of samples from N experimental conditions, K an-
notated genes gk(k = 1, · · · , K), L experimental comparisons of interest Cl(l =
1, · · · , L), a collection of gene sets Γ and M methods for gene set enrichment anal-
ysis, the objective of a GSE analysis is to find the most relevant gene sets in Γ which
explain the biological processes and/or pathways that are perturbed in expression in
individual comparisons and/or across multiple contrasts simultaneously. Numerous
statistical gene set enrichment analysis methods have been proposed in the literature
over the past decade. Each method has its own characteristics and assumptions on
the analyzed dataset and gene sets tested.
In principle, gene set tests calculate a
statistic for each gene individually f (gk) and then integrate these significance scores
in a framework to estimate a set significance score h(γi).
We propose seven statistics to combine the individual gene set statistics across mul-
tiple methods, and to rank and hence identify biologically relevant gene sets. Assume
a collection of gene sets Γ, a given gene set γi ∈ Γ, and that the GSE analysis results
of M methods on γi for a specific comparison (represented by ranks Rm
and statisti-
i
cal significance scores pm
, where m = 1, · · · , M and i = 1, · · · , |Γ|) are given. The
i
EGSEA scores can then be devised, for each experimental comparison, as follows:

• The p-value score is the combined p-value assigned to γi and is calculated using

six different methods.

• The minimum p-value score is the smallest p-value calculated for γi
• The minimum rank score of γi is the smallest rank assigned to γi
• The average ranking score is the mean rank across the M ranks

• The median ranking score is the median rank across the M ranks

• The majority voting score is the most commonly assigned bin ranking

• The significance score assigns high scores to the gene sets with strong fold

changes and high statistical significance

It is worth noting that the p-value score can only be calculated under the independence
assumption of individual gene set tests, and thus it is not an accurate estimate of
the ensemble gene set significance, but can still be useful for ranking results. The

29

EGSEA

Figure 12: The main page of the EGSEA HTML report.

significance score is scaled into [0, 100] range for each gene set collection. To learn
more about the calculation of each EGSEA score, the original paper of this work is
available at Section 2.

7

EGSEA report

Since the number of annotated gene set collections in public databases continuously
increases and there is a growing trend towards generating dynamic analytical tools,
our software tool was developed to enable users to interactively navigate through
the analysis results by generating an HTML EGSEA Report (Figure 12). The report
presents the results in different ways. For example, the Stats table displays the top
n gene sets (where n is selected by the user) for each experimental comparison and

30

EGSEA

includes all calculated statistics. Hyperlinks are enabled wherever possible, to access
additional information on the gene sets such as annotation information. The gene
expression fold changes can be visualized using heat maps for individual gene sets
(Figure 6 and 10) or projected onto pathway maps where available (e.g. KEGG gene
sets) (Figure 7 and 11). The most significant Gene Ontology (GO) terms for each
comparison can be viewed in a GO graph that shows their relationships (Figure 5).

Additionally, EGSEA creates summary plots for each gene set collection to visualize
the overall statistical significance of gene sets (Figure 4 and 8). Two types of summary
plots are generated: (i) a plot that emphasizes the gene regulation direction and the
significance score of a gene set and (ii) a plot that emphasizes the set cardinality
and its rank. EGSEA also generates a multidimensional scaling (MDS) plot that
shows how various GSE methods rank a collection of gene sets (Figure 3). This plot
gives insights into the similarity of different methods on a given dataset. Finally,
the reporting capabilities of EGSEA can be used to extend any existing or newly
developed GSE method by simply using only that method.

7.1

Comparative analysis
Unlike most GSE methods that calculate a gene set enrichment score for a given
gene set under a single experimental contrast (e.g. disease vs. control), the com-
parative analysis proposed here allows researchers to estimate the significance of a
gene set across multiple experimental contrasts. This analysis helps in the identifi-
cation of biological processes that are perturbed by multiple experimental conditions
simultaneously. Comparative significance scores are calculated for a gene set.

An interesting application of the comparative analysis would be finding pathways or
biological processes that are activated by a stimulation with a particular cytokine
yet are completely inhibited when the cytokine’s receptor is blocked by an antago-
nist, revealing the functions uniquely associated with the signaling of that particular
receptor as in the experiment below.

8

EGSEA on a non-human dataset

Epithelial cells from the mammary glands of female virgin 8-10 week-old mice were
sorted into three populations of basal, luminal progenitor (LP) and mature luminal
(ML) cells. Three independent samples from each population were profiled via RNA-
seq on total RNA using an Illumina HiSeq 2000 to generate 100bp single-end read
libraries. The Rsubread aligner was used to align these reads to the mouse reference
genome (mm10 ) and mapped reads were summarized into gene-level counts using
featureCounts with default settings. The raw counts are also normalized using the
TMM method. Data are available from the GEO database as series GSE63310.

To perform EGSEA analysis on this dataset, the following commands can be invoked
in the R console

31

EGSEA

# load the mammary dataset

library(EGSEA)

library(EGSEAdata)

data(mam.data)

v = mam.data$voom

names(v)

v$design

contrasts = mam.data$contra

contrasts

# build the gene set collections

gs.annots = buildIdx(entrezIDs = rownames(v$E), species = "mouse",

msigdb.gsets = "c2", kegg.exclude = "all")

names(gs.annots)

# create Entrez IDs - Symbols map

symbolsMap = v$genes[, c(1, 3)]

colnames(symbolsMap) = c("FeatureID", "Symbols")

symbolsMap[, "Symbols"] = as.character(symbolsMap[, "Symbols"])

# replace NA Symbols with IDs

na.sym = is.na(symbolsMap[, "Symbols"])

na.sym

symbolsMap[na.sym, "Symbols"] = symbolsMap[na.sym, "FeatureID"]

# perform the EGSEA analysis set report = TRUE to generate

# the EGSEA interactive report

baseMethods = c("camera", "safe", "gage", "padog", "zscore",

"gsva", "globaltest", "ora")

gsa = egsea(voom.results = v, contrasts = contrasts, gs.annots = gs.annots,

symbolsMap = symbolsMap, baseGSEAs = baseMethods, sort.by = "med.rank",

num.threads = 4, report = FALSE)

# show top 20 comparative gene sets in C2 collection

summary(gsa)

topSets(gsa, gs.label = "c2", contrast = "comparison", number = 20)

9

EGSEA on a count matrix

The EGSEA analysis can be also performed on the count matrix directly without the
need of having a voom object in advance. The egsea.cnt can be invoked on a count
matrix given the group of each sample is provided with design and contrast matrices
as it is illustrated in this example. This function uses the voom function from the
limma pakcage to convert the RNA-seq counts into expression values.

Here, the IL-13 human dataset is reanalyzed using the count matrix.

# load the count matrix and other relevant data

library(EGSEAdata)

32

EGSEA

data(il13.data.cnt)

cnt = il13.data.cnt$counts

group = il13.data.cnt$group

group

design = il13.data.cnt$design

contrasts = il13.data.cnt$contra

genes = il13.data.cnt$genes

# build the gene set collections

gs.annots = buildIdx(entrezIDs = rownames(cnt), species = "human",

msigdb.gsets = "none", kegg.exclude = c("Metabolism"))

# perform the EGSEA analysis set report = TRUE to generate

# the EGSEA interactive report

gsa = egsea.cnt(counts = cnt, group = group, design = design,

contrasts = contrasts, gs.annots = gs.annots, symbolsMap = genes,

baseGSEAs = egsea.base()[-c(2, 12)], sort.by = "avg.rank",

num.threads = 4, report = FALSE)

10

EGSEA on a list of genes

Since performing simple over-representation analysis on large collections of gene sets
is not readily available in Bioconductor, an ORA analysis was augmented to the
EGSEA package so that all the reporting capabilities of EGSEA are enabled.

To perform ORA using the DE genes of the X24IL13-X24 contrast from the IL-13
dataset, cut-off thresholds of p-value=0.05 and logFC = 1 are used to select a subset
of DE genes. Then, the egsea.ora function is invoked as it is illulstrated in the
following example

# load IL-13 dataset

library(EGSEAdata)

data(il13.data)

voom.results = il13.data$voom

contrast = il13.data$contra

# find Differentially Expressed genes

library(limma)

##

## Attaching package: ’limma’

## The following object is masked from ’package:BiocGenerics’:

##

##

plotMA

vfit = lmFit(voom.results, voom.results$design)

vfit = contrasts.fit(vfit, contrast)

vfit = eBayes(vfit)

33

EGSEA

# select DE genes (Entrez IDs and logFC) at p-value <= 0.05

# and |logFC| >= 1

top.Table = topTable(vfit, coef = 1, number = Inf, p.value = 0.05,

lfc = 1)

deGenes = as.character(top.Table$FeatureID)

logFC = top.Table$logFC

names(logFC) = deGenes

# build the gene set collection index

gs.annots = buildIdx(entrezIDs = deGenes, species = "human",

msigdb.gsets = "none", kegg.exclude = c("Metabolism"))

## [1] "Building KEGG pathways annotation object ... "

# perform the ORA analysis set report = TRUE to generate

# the EGSEA interactive report

gsa = egsea.ora(geneIDs = deGenes, universe = as.character(voom.results$genes[,

1]), logFC = logFC, title = "X24IL13-X24", gs.annots = gs.annots,

symbolsMap = top.Table[, c(1, 2)], display.top = 5, report.dir = "./il13-egsea-ora-report",

num.threads = 4, report = FALSE)

## EGSEA analysis has started

## ##------ Wed Oct 29 23:49:28 2025 ------##

## EGSEA is running on the provided data and kegg collection

## .ora*

## ##------ Wed Oct 29 23:49:28 2025 ------##

## EGSEA analysis took 0.186999999999983 seconds.

## EGSEA analysis has completed

11 Non-standard gene set collections

Scientists usually have their own lists of gene sets and are interested in finding which
sets are significant in the investigated dataset. Additional collections of gene sets
can be easily added and tested using the EGSEA algorithm. The buildCustomIdx
function indexes newly created gene sets and attach gene set annotation if provided.
To illustrate the use of this function, assume a list of gene sets is available where each
gene set is represented by a character vector of Entrez Gene IDs. In this example, 50
gene sets were selected from the KEGG collection and then they were used to build
a custom gene set collection index.

library(EGSEAdata)

data(il13.data)

v = il13.data$voom

# load KEGG pathways

34

EGSEA

data(kegg.pathways)

# select 50 pathways

gsets = kegg.pathways$human$kg.sets[1:50]

gsets[1]

## $`hsa00010 Glycolysis / Gluconeogenesis`
## [1] "10327"

"124"

"125"

"126"

"127"

"128"

"130"

"130589"

## [9] "131"

"160287" "1737"

"1738"

"2023"

"2026"

"2027"

## [17] "218"

## [25] "226"

"219"

"229"

"220"

"230"

"2203"

"221"

"222"

"223"

"2538"

"2597"

"26330"

"2645"

"2821"

"217"

"224"

## [33] "3098"

"3099"

"3101"

"3939"

"3945"

"3948"

"441531" "501"

## [41] "5105"

"5106"

"5160"

"5161"

"5162"

"5211"

"5213"

"5214"

## [49] "5223"

"5224"

"5230"

"5232"

"5236"

"5313"

"5315"

"55276"

## [57] "55902"

"57818"

"669"

"7167"

"80201"

"83440"

"84532"

"8789"

## [65] "92483"

"92579"

"9562"

# build custom gene set collection using these 50 pathways

gs.annot = buildCustomIdx(geneIDs = rownames(v$E), gsets = gsets,

species = "human")

## [1] "Created the User-Defined Gene Sets collection ... "

class(gs.annot)

## [1] "GSCollectionIndex"

## attr(,"package")

## [1] "EGSEA"

show(gs.annot)

## An object of class "GSCollectionIndex"

## Number of gene sets: 49

## Annotation columns: ID, GeneSet, NumGenes

## Total number of indexing genes: 17343

## Species: Homo sapiens

## Collection name: User-Defined Gene Sets

## Collection uniqe label: custom

## Database version: NA

## Database update date: Wed Oct 29 23:49:28 2025

The buildCustomIdx creates an annotation data frame for the gene set collection if
the anno parameter is not provided. Once the gene set collection is indexed, it can
be used with any of the EGSEA functions: egsea, egsea.cnt or egsea.ora. Similarly,
the function buildGMTIdx can be used to build an index from a GMT file.

35

EGSEA

12

Adding new GSE method

If you have an interesting gene set test method that you would like to add to the
EGSEA framework, please contact us and we will be happy to add your method to
the next release of EGSEA. We do not allow users to add new methods by themselves
because this procedure is a straightforward and is a method-dependent.

13

Packages used

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##

## attached base packages:

## [1] grid

stats4

stats

graphics

grDevices utils

datasets

## [8] methods

base

##

## other attached packages:
## [1] limma_3.66.0
## [4] EGSEAdata_1.37.0
## [7] topGO_2.62.0
## [10] graph_1.88.0
## [13] S4Vectors_0.48.0
## [16] BiocGenerics_0.56.0
##

org.Hs.eg.db_3.22.0
pathview_1.50.0
GO.db_3.22.0

Rgraphviz_2.54.0
EGSEA_1.38.0
SparseM_1.84-2
AnnotationDbi_1.72.0 IRanges_2.44.0
Biobase_2.70.0
gage_2.60.0
generics_0.1.4

## loaded via a namespace (and not attached):

##

##

[1] splines_4.5.1
[3] tibble_3.3.0

bitops_1.0-9
XML_3.99-0.19

36

EGSEA

##

##

lifecycle_1.0.4
[5] globaltest_5.64.0
edgeR_4.8.0
[7] Rdpack_2.6.4
MASS_7.3-65
[9] lattice_0.22-7
##
magrittr_2.0.4
## [11] hgu133plus2.db_3.13.0
rmarkdown_2.30
## [13] plotly_4.11.0
plotrix_3.8-4
## [15] yaml_2.3.10
sn_2.1.1
## [17] qqconf_1.3.2
DBI_1.2.3
## [19] doRNG_1.8.6.2
HTMLUtils_0.1.9
## [21] RColorBrewer_1.1-3
abind_1.4-8
## [23] multcomp_1.4-29
purrr_1.1.0
## [25] GenomicRanges_1.62.0
TH.data_1.1-4
## [27] RCurl_1.98-1.17
irlba_2.3.5.1
## [29] sandwich_3.1-1
BiocStyle_2.38.0
## [31] GSVA_2.4.0
annotate_1.88.0
## [33] TFisher_0.2.0
DelayedArray_0.36.0
## [35] codetools_0.2-20
tidyselect_1.2.1
## [37] DT_0.34.0
ScaledMatrix_1.18.0
## [39] farver_2.1.2
Seqinfo_1.0.0
## [41] matrixStats_1.5.0
jsonlite_2.0.0
## [43] mathjaxr_1.8-0
survival_3.8-3
## [45] multtest_2.66.0
foreach_1.5.2
## [47] iterators_1.0.14
Rcpp_1.1.0
## [49] tools_4.5.1
mnormt_2.1.1
## [51] glue_1.8.0
xfun_0.53
## [53] SparseArray_1.10.0
MatrixGenerics_1.22.0
## [55] metap_1.12
HDF5Array_1.38.0
## [57] dplyr_1.1.4
numDeriv_2016.8-1.1
## [59] withr_3.0.2
BiocManager_1.30.26
## [61] formatR_1.14
rhdf5filters_1.22.0
## [63] fastmap_1.2.0
digest_0.6.37
## [65] caTools_1.18.3
R6_2.6.1
## [67] rsvd_1.0.5
dichromat_2.0-0.1
## [69] gtools_3.9.5
h5mread_1.2.0
## [71] RSQLite_2.4.3
data.table_1.17.8
## [73] tidyr_1.3.1
htmlwidgets_1.6.4
## [75] httr_1.4.7
GSA_1.03.3
## [77] S4Arrays_1.10.0
org.Mm.eg.db_3.22.0
## [79] PADOG_1.52.0
gtable_0.3.6
## [81] pkgconfig_2.0.3
blob_1.2.4
## [83] R2HTML_2.3.4
## [85] S7_0.2.0
hwriter_1.3.2.1
## [87] SingleCellExperiment_1.32.0 XVector_0.50.0
GSEABase_1.72.0
## [89] htmltools_0.5.8.1
org.Rn.eg.db_3.22.0
## [91] scales_1.4.0
SpatialExperiment_1.20.0
## [93] png_0.1-8

37

EGSEA

## [95] KEGGdzPathwaysGEO_1.47.0
## [97] rjson_0.2.23
## [99] cachem_1.1.0
## [101] rhdf5_2.54.0
## [103] KernSmooth_2.23-26
## [105] hgu133a.db_3.13.0
## [107] vctrs_0.6.5
## [109] BiocSingular_1.26.0
## [111] xtable_1.8-4
## [113] KEGGgraph_1.70.0
## [115] mvtnorm_1.3-3
## [117] locfit_1.5-9.12
## [119] rlang_1.1.6
## [121] rngtools_1.5.2
## [123] labeling_0.4.3
## [125] viridisLite_0.4.2
## [127] Biostrings_2.78.0
## [129] Matrix_1.7-4
## [131] bit64_4.6.0-1
## [133] Rhdf5lib_1.32.0
## [135] statmod_1.5.1
## [137] highr_0.11
## [139] memoise_2.0.1

knitr_1.50
nlme_3.1-168
zoo_1.8-14
safe_3.50.0
parallel_4.5.1
pillar_1.11.1
gplots_3.2.0
beachmat_2.26.0
evaluate_1.0.5
magick_2.9.0
cli_3.6.5
compiler_4.5.1
crayon_1.5.3
mutoss_0.1-13
stringi_1.8.7
BiocParallel_1.44.0
lazyeval_0.2.2
sparseMatrixStats_1.22.0
ggplot2_4.0.0
KEGGREST_1.50.0
SummarizedExperiment_1.40.0
rbibutils_2.3
bit_4.6.0

References

[1] S Tavazoie et al. Systematic determination of genetic network architecture.

Nature Genetics, 22(3):281–5, 1999.

[2]

[3]

Jelle J Goeman et al. A global test for groups of genes: testing association
with a clinical outcome. Bioinformatics, 20(1):93–9, 2004.

John Tomfohr et al. Pathway level analysis of gene expression using singular
value decomposition. BMC Bioinformatics, 6:225, 2005.

[4] William T Barry et al. Significance analysis of functional categories in gene
expression studies: a structured permutation approach. Bioinformatics,
21(9):1943–9, 2005.

[5] Eunjung Lee et al. Inferring pathway activity toward precise disease
classification. PLoS Computational Biology, 4(11):e1000217, 2008.

[6] Weijun Luo et al. GAGE: generally applicable gene set enrichment for pathway

analysis. BMC Bioinformatics, 10:161, 2009.

[7] David A Barbie et al. Systematic RNA interference reveals that oncogenic
KRAS-driven cancers require TBK1. Nature, 462(7269):108–12, 2009.

38

EGSEA

[8] Di Wu et al. ROAST: rotation gene set tests for complex microarray

experiments. Bioinformatics, 26(17):2176–82, 2010.

[9] Adi Laurentiu Tarca et al. Down-weighting overlapping genes improves gene

set analysis. BMC Bioinformatics, 13:136, 2012.

[10] Di Wu and Gordon K Smyth. Camera: a competitive gene set test accounting

for inter-gene correlation. Nucleic Acids Research, 40(17):e133, 2012.

[11] Sonja Hänzelmann et al. GSVA: gene set variation analysis for microarray and

RNA-seq data. BMC Bioinformatics, 14:7, 2013.

[12] Charity W Law et al. voom: Precision weights unlock linear model analysis

tools for RNA-seq read counts. Genome Biology, 15(2):R29, 2014.

[13] Aravind Subramanian et al. Gene set enrichment analysis: a knowledge-based
approach for interpreting genome-wide expression profiles. Proceedings of the
National Academy of Sciences of the United States of America,
102(43):15545–50, 2005.

[14] Donna Maglott et al. Entrez Gene: gene-centered information at NCBI.

Nucleic Acids Research, 33(Database issue):D54–8, 2005.

[15] M Kanehisa and S Goto. KEGG: kyoto encyclopedia of genes and genomes.

Nucleic Acids Research, 28(1):27–30, 2000.

[16] Hiromitsu Araki et al. GeneSetDB: A comprehensive meta-database, statistical
and visualisation framework for gene set analysis. FEBS Open Bio, 2:76–82,
2012.

[17] CW Law, M Alhamdoosh, S Su, GK Smyth, and ME Ritchie. Rna-seq analysis

is easy as 1-2-3 with limma, glimma and edger [version 1; referees: 1
approved]. F1000Research, 5(1408), 2016.
doi:10.12688/f1000research.9005.1.

39

