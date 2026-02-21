Package ‘IntramiRExploreR’

May 19, 2017

Title Predicting Targets for Drosophila Intragenic miRNAs

Version 1.00.0

Author Surajit Bhattacharya and Daniel Cox
Maintainer Surajit Bhattacharya <sbhattacharya3@student.gsu.edu>
Description Intra-miR-ExploreR, an integrative miRNA target prediction

bioinformatics tool, identiﬁes targets combining expression and biophysical
interactions of a given microRNA (miR). Using the tool, we have identiﬁed
targets for 92 intragenic miRs in D. melanogaster, using available microarray
expression data, from Affymetrix 1 and Affymetrix2 microarray array platforms,
providing a global perspective of intragenic miR targets in Drosophila.
Predicted targets are grouped according to biological functions using the DAVID
Gene Ontology tool and are ranked based on a biologically relevant scoring
system, enabling the user to identify functionally relevant targets for a given
miR.

Depends R (>= 3.4)

Imports igraph (>= 1.0.1),

FGNet (>= 3.0.7),
knitr (>= 1.12.3),
stats,
utils,
grDevices,
graphics

Suggests RDAVIDWebService,

gProﬁleR,
topGO,
KEGGproﬁle,
org.Dm.eg.db,
rmarkdown,
testthat

VignetteBuilder knitr

License GPL-2

biocViews Software, Microarray, GeneTarget, StatisticalMethod, GeneExpression, GenePrediction

Encoding UTF-8

LazyData true

RoxygenNote 5.0.1

URL https://github.com/sbhattacharya3/IntramiRExploreR/

1

2

Affy1_Distance_Final

BugReports https://github.com/sbhattacharya3/IntramiRExploreR/issues

R topics documented:

.
.
Affy1_Distance_Final .
.
.
.
Affy1_Pearson_Final
.
.
Affy2_Distance_Final .
.
.
.
Affy2_Pearson_Final
.
extract_HostGene .
.
.
.
.
extract_intragenic_miR .
.
.
genes_Stat .
.
.
.
.
Gene_Visualisation .
.
.
.
GetGOS_ALL .
.
.
.
.
IntramiRExploreR .
miRNA_ID_to_Function .
.
miRNA_summary_DB .
.
.
miRTargets_Stat .
.
.
.
Visualisation .

.
.
.
.

.
.

.
.

.
.

.

.

.

.

.
.
.
.
.
.
.
.
.
.
.
.
.
.

2
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10

Index

11

Affy1_Distance_Final

Targets for the microRNA analyzed from Affy1 plaform using Distance.

Description

A precomputed dataset containing the targets, scores and other attributes of 83 intragenic microR-
NAs using Distance Correlation for plaform Affymetrix 1.

Usage

Affy1_Distance_Final

Format

A data frame with 53399 rows and 8 variables:

miRNA miRNA name, miRNA symbol

GeneSymbol Gene name, in Gene Symbol

FBGN Gene name, in FlybaseID

CGID Gene name, in CGID

Score Computed Score, in ﬂoat

GeneFunction Gene Functions, from Flybase

experiments Experiments, from ArrayExpress

TargetDatabases Target Database Name, from TargetDatabases

Affy1_Pearson_Final

3

Affy1_Pearson_Final

Targets for the microRNA analyzed from Affy1 plaform using Pearson.

Description

A precomputed dataset containing the targets, scores and other attributes of 83 intragenic microR-
NAs using Pearson Correlation for plaform Affymetrix 1.

Usage

Affy1_Pearson_Final

Format

A data frame with 41845 rows and 8 variables:

miRNA miRNA name, miRNA symbol
GeneSymbol Gene name, in Gene Symbol
FBGN Gene name, in FlybaseID
CGID Gene name, in CGID
Score Computed Score, in ﬂoat
GeneFunction Gene Functions, from Flybase
experiments Experiments, from ArrayExpress
TargetDatabases Target Database Name, from TargetDatabases

Affy2_Distance_Final

Targets for the microRNA analyzed from Affy2 plaform using Distance.

Description

A precomputed dataset containing the targets, scores and other attributes of 83 intragenic microR-
NAs using Distance Correlation for plaform Affymetrix 1.

Usage

Affy2_Distance_Final

Format

A data frame with 73374 rows and 8 variables:

miRNA miRNA name, miRNA symbol
GeneSymbol Gene name, in Gene Symbol
FBGN Gene name, in FlybaseID
CGID Gene name, in CGID
Score Computed Score, in ﬂoat
GeneFunction Gene Functions, from Flybase
experiments Experiments, from ArrayExpress
TargetDatabases Target Database Name, from TargetDatabases

4

extract_HostGene

Affy2_Pearson_Final

Targets for the microRNA analyzed from Affy2 plaform using Pearson.

Description

A precomputed dataset containing the targets, scores and other attributes of 83 intragenic microR-
NAs using Pearson Correlation for plaform Affymetrix 1.

Usage

Affy2_Pearson_Final

Format

A data frame with 52913 rows and 8 variables:

miRNA miRNA name, miRNA symbol

GeneSymbol Gene name, in Gene Symbol

FBGN Gene name, in FlybaseID

CGID Gene name, in CGID

Score Computed Score, in ﬂoat

GeneFunction Gene Functions, from Flybase

experiments Experiments, from ArrayExpress

TargetDatabases Target Database Name, from TargetDatabases

extract_HostGene

Extract Host Gene for a given Intragenic miRNA.

Description

Extract Host Gene for a given Intragenic miRNA.

Usage

extract_HostGene(miRNA)

Arguments

miRNA

Value

A String containing the miRNA name.

genf, a character string or vector containing Host gene for the Intragenic miRNA.

Examples

miRNA="dme-miR-12"
extract_HostGene(miRNA)

extract_intragenic_miR

5

extract_intragenic_miR

Extract Intragenic miRNA for a given Host gene.

Description

Extract Intragenic miRNA for a given Host gene.

Usage

extract_intragenic_miR(gene)

Arguments

gene

Value

character. Gene Symbol.

miRf, a character string or vector containing Intragenic miRNA for the Host Gene.

Examples

gene="Gmap"
extract_intragenic_miR(gene)

genes_Stat

Extracting miRNAs that target a query gene.

Description

Extracting miRNAs that target a query gene.

Usage

genes_Stat(gene, geneIDType = c("GeneSymbol", "FBGN", "CGID"),
method = c("Pearson", "Distance", "Both", "BothIntersect"),
Platform = c("Affy1", "Affy2"), Text = FALSE, outpath = tempdir())

Arguments

gene

geneIDType

method

Platform

Text

outpath

character. gene Identiﬁer.

character. GeneIDtype choices are ’GeneSymbol’, ’FBGN’, ’CGID’

character. Choices are ’Pearson’,’Distance’,’Both’ and ’BothIntersected’

character. Choices are ’Affy1’,’Affy2’.

logical . To choose between storing the data as text ﬁle. Default is FALSE.

character. The path where the data is stored if TEXT=TRUE. Default is

6

Value

Gene_Visualisation

Outputs the miRNA information, Target Prediction Score, miRNA miRNA function and Target
Database that predicts the interaction in a dataframe. Depending upon the ouput choice data is
stored in the path speciﬁed. Default option prints output to the console.

Examples

gene="Syb"
genes_Stat(gene,geneIDType="GeneSymbol",method=c("Pearson"),

Platform=c("Affy1"),Text=FALSE)

Gene_Visualisation

Visualises the targetGene:miRNA network using Cytoscape and igraph
.

Description

Visualises the targetGene:miRNA network using Cytoscape and igraph .

Usage

Gene_Visualisation(mRNA, mRNA_type = c("GeneSymbol", "FBGN", "CGID"),

method = c("Pearson", "Distance", "Both"), platform = c("Affy1", "Affy2"),
visualisation = c("igraph", "Cytoscape", "text", "console"),
path = tempdir(), layout = c("kamadakawai", "reingold.tilford",
"fruchterman.reingold", "interactive"))

Arguments

mRNA

mRNA_type

method

platform

visualisation

path

layout

Value

character. gene Identiﬁer.

character. mRNA id type. The choices are ’GeneSymbol’,’FBID’ and ’CGID’.

character. Statistical Methods. Choices are ’Pearson’,’Distance’,’Both’

character. Affymetrix Platforms. Choices are ’Affy1’,’Affy2’.

character.Visualisation type. Choices are ’igraph’,’Cytoscape’,’text’and "con-
sole"

character. Path where data.frame is saved when visualisation is text. Default is
tempdir().

character. Network choices. Choices are ’kamadakawai’,’reingold.tilford’,’fruchterman.reingold’
and ’interactive’.

Depending upon the ouput choice network image or dataframe containg miRNAs that target the
query gene are ouput.

Examples

mRNA='Syb'
Gene_Visualisation(mRNA,mRNA_type=c('GeneSymbol'),method=c('Pearson'),

platform=c('Affy1'), visualisation = "console")

GetGOS_ALL

7

GetGOS_ALL

Gene ontology for Target Genes.

Description

Gene ontology for Target Genes.

Usage

GetGOS_ALL(gene, GO = c("DAVID", "topGO"), term = c("GOTERM_BP_ALL",
"GOTERM_MF_ALL", "GOTERM_CC_ALL"), geneIdType = "ALIAS", email,
path = tempdir(), ontology = c("GO_BP", "GO_MF", "GO_CC"), filename)

Arguments

gene

GO

term

List A String or vector containing the Gene names.

A String depicting the chosen GO tool. Choices are "David" and "topGO"

A String depicting the chosen term. Choices are "GOTERM_BP_ALL","GOTERM_MF_ALL",
"GOTERM_CC_ALL".

geneIdType

Type of gene Id given as input. Default "ALIAS"

email

path

ontology

filename

Value

Email Id to connect to David.

String. The path where the data is stored if TEXT=TRUE.

Ontology selection for topGO. Choices are "GO_BP","GO_MF","GO_CC".

Name of the ﬁle to store Gene Ontology.

Depending upon the ouput choice data is stored in the path speciﬁed. Default option prints output
to the console.

Examples

## Not run:
miR="dme-miR-12"
a<-Visualisation(miR,mRNA_type=c("GeneSymbol"),method=c("Both"),

platform=c("Affy1"),thresh=100)

genes<-a$Target_GeneSymbol
GetGOS_ALL(genes,GO=c("topGO"),term=c("GO_BP"),path=tempdir(),

filename="test")

## End(Not run)

8

miRNA_ID_to_Function

IntramiRExploreR

IntramiRExploreR:Prediction of
Drosophila.

targets for Intragenic miRNA in

Description

Prediction of targets for Drosophila Intragenic microRNAs and Integrated approach using Gene
Ontology and Networking tools.

Examples

## Not run:
gene='Gmap'
extract_intragenic_miR(gene)

## End(Not run)

miRNA_ID_to_Function

Contains the miRNA function information from Flybase database.

Description

A dataset containing the function for the intragenic miRNA.

Usage

miRNA_ID_to_Function

Format

A data frame with 66 rows and 4 variables:

miRNA miRNA name, miRNA symbol

FBGN target gene name, gene symbol

miRNAFunction miRNA function, from Flybase

Source

http://flybase.org/

miRNA_summary_DB

9

miRNA_summary_DB

Contains the summary for the intragenic miRNA.

Description

A dataset containing the summary for the intragenic miRNA.

Usage

miRNA_summary_DB

Format

A data frame with 257 rows and 6 variables:

miRNA miRNA name, miRNA symbol

Intragenic Responsee, in boolean

Intergenic Responsee, in boolean

Gene miRNA name, miRNA symbol

Type.of.HostGene.mRNA.lncRNA. Type of Hostgene

Notes Comments about the miRNA

miRTargets_Stat

Extracting miRNAs that target a query gene.

Description

Extracting miRNAs that target a query gene.

Usage

miRTargets_Stat(miR, method = c("Pearson", "Distance", "Both",

"BothIntersect"), Platform = c("Affy1", "Affy2"), outpath = tempdir(),
Text = FALSE)

Arguments

miR

method

Platform

outpath

Text

Value

character. miRNA symbol.

character. Choices are "Pearson", "Distance","Both" and "BothIntersected"

character. Choices are "Affy1","Affy2".

character. The path where the data is stored if TEXT=TRUE. Default is tem-
pdir().

logical . To choose between storing the data as text ﬁle. Default is FALSE.

Outputs the target information, Target Prediction Score, miRNA target function and Target Database
that predicts the interaction in a dataframe. Depending upon the ouput choice data is stored in the
path speciﬁed. Default option prints output to the console.

10

Examples

Visualisation

miRNA="dme-miR-12"
miRTargets_Stat (miRNA,method=c ("Pearson"),Platform=c ("Affy1"),Text=FALSE)

Visualisation

Visualises the targetGene:miRNA network using Cytoscape and igraph
.

Description

Visualises the targetGene:miRNA network using Cytoscape and igraph .

Usage

Visualisation(miRNA, mRNA_type = c("GeneSymbol", "FBID", "CGID"),

method = c("Pearson", "Distance", "Both"), platform = c("Affy1", "Affy2"),
thresh = 50, visualisation = c("igraph", "Cytoscape", "Text", "console"),
path = tempdir(), layout = c("kamadakawai", "reingold.tilford",
"fruchterman.reingold", "interactive"))

Arguments

miRNA

mRNA_type

method

platform

thresh

visualisation

path

layout

Value

character. miRNA Identiﬁer.

character. mRNA id type. The choices are ’GeneSymbol’,’FBID’ and ’CGID’.

character. Statistical Methods. Choices are ’Pearson’,’Distance’,’Both’

character. Affymetrix Platforms. Choices are ’Affy1’,’Affy2’.

integar. Threshold depicting number of rows to show.

character.Visualisation type. Choices are ’igraph’,’Cytoscape’,’text’ and ’con-
sole’.

character. Path where data.frame is saved when visualisation is text. Default is
tempdir().

character. Network choices. Choices are ’kamadakawai’,’reingold.tilford’,’fruchterman.reingold’
and ’interactive’.

Depending upon the ouput choice network image or dataframe containg miRNAs that target the
query gene are ouput.

Examples

miRNA='dme-miR-12'
Visualisation(miRNA,mRNA_type=c('GeneSymbol'),method=c('Pearson'),
platform=c('Affy1'),visualisation=c('igraph'),layout=c('kamadakawai'),

path=tempdir())

Index

∗Topic datasets

Affy1_Distance_Final, 2
Affy1_Pearson_Final, 3
Affy2_Distance_Final, 3
Affy2_Pearson_Final, 4
miRNA_ID_to_Function, 8
miRNA_summary_DB, 9

Affy1_Distance_Final, 2
Affy1_Pearson_Final, 3
Affy2_Distance_Final, 3
Affy2_Pearson_Final, 4

extract_HostGene, 4
extract_intragenic_miR, 5

Gene_Visualisation, 6
genes_Stat, 5
GetGOS_ALL, 7

IntramiRExploreR, 8
IntramiRExploreR-package

(IntramiRExploreR), 8

miRNA_ID_to_Function, 8
miRNA_summary_DB, 9
miRTargets_Stat, 9

Visualisation, 10

11

