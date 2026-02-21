Package ‘psygenet2r’

April 12, 2018

Title psygenet2r - An R package for querying PsyGeNET and to perform

comorbidity studies in psychiatric disorders

Version 1.10.0

Description Package to retrieve data from PsyGeNET database (www.psygenet.org) and to per-

form comorbidity studies with PsyGeNET's and user's data.

Depends R (>= 3.4)

License MIT + ﬁle LICENSE

LazyData true

Imports stringr, RCurl, igraph, ggplot2, reshape2, grid, parallel,

biomaRt, BgeeDB, topGO, BiocInstaller, Biobase, labeling, GO.db

Suggests testthat, knitr

NeedsCompilation no

VignetteBuilder knitr
Maintainer Alba Gutierrez-Sacristan <alba.gutierrez@upf.edu>

biocViews Software, BiomedicalInformatics, Genetics, Infrastructure,

DataImport, DataRepresentation

RoxygenNote 6.0.1

Author Alba Gutierrez-Sacristan [aut, cre],
Carles Hernandez-Ferrer [aut],
Jaun R. Gonzalez [aut],
Laura I. Furlong [aut]

R topics documented:

.

.

.
.

DataGeNET.Psy-class .
.
.
.
.
enrichedPD .
.
.
.
.
.
extract .
.
.
.
extractSentences
.
.
.
.
geneAttrPlot .
.
.
getUMLs
.
.
.
.
.
jaccardEstimation .
JaccardIndexPsy-class
.
.
.
ndisease .
.
ngene .
.
.
.
.
pantherGraphic .

.
.
.

.
.
.

.
.

.
.

.
.

.

.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .

2
3
3
4
5
6
7
8
8
9
9

1

2

DataGeNET.Psy-class

.

.

.
.

.
.

.
.

.
.

plot,DataGeNET.Psy,ANY-method . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
plot,JaccardIndexPsy,ANY-method . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
.
.
psygenet2r .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
psygenetDisease .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
psygenetDiseaseSentences
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
.
.
psygenetGene .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
psygenetGeneSentences .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
.
qr
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
.
topAnatEnrichment
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
.
.
universe .

.
.
.
.
.

.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

Index

19

DataGeNET.Psy-class

Class DataGeNET.Psy

Description

Class DataGeNET.Psy is the basic object use in psygenet2r package.
It is the main data con-
tainer to using the different functions to query PsyGeNET database and generate teir output. The
constructors of this class are the functions psygenetGene and psygenetDisease.

Slots

type Character containing 'gene' of 'disease'. It is used to eprform the correct query to Psy-

GeNET.

search Character containing 'single' of 'list'.It is used to eprform the correct query to Psy-

GeNET.

database Character containing the name of the database that will be queried. It can take the values
'MODELS' to use Comparative Toxigenomics Database, data from mouse and rat; 'GAD' to use
Genetic Association Database; 'CTD' to use Comparative Toxigenomics Database, data from
human; 'PsyCUR' to use Psychiatric disorders Gene association manually curated; 'CURATED'
to use Human, manually curated databases (PsyCUR and CTD); or 'ALL' to use all these
databases.

term Charcter with the term(s) to search into the database(s).

qresult data.frame with the obtained result

See Also

psygenetGene, psygenetDisease, DataGeNET.Psy-methods

enrichedPD

3

enrichedPD

Enrichment of a user’s input (genes) in PsyGeNET’s diseases.

Description

Test the enrichment of a given gene list on Psychiatric Disorders from PsyGeNET.

Usage

enrichedPD(gene, database = "ALL", verbose = FALSE, warnings = FALSE)

Arguments

gene

database

verbose

warnings

Value

Name or vector of names (that can be both code or uml) to speciﬁc genes from
PsyGeNET.
Name of the database that will be queried. It can take the values 'psycur15' to
use data validated by experts for ﬁrst release of PsyGeNET; 'psycur16' to use
data validated by experts for second release of PsyGeNET; or 'ALL' to use both
databases. Default 'ALL'.
By default FALSE. Change it to TRUE to get a on-time log from the function.
By default TRUE. Change it to FALSE to not see the warnings.

A data.frame with the enricment at each Psychiatric Disorder

Examples

enrichedPD(c("ADCY2", "AKAP13", "ANK3"), "ALL")

extract

Raw data from DataGeNET.Psy and JaccardIndexPsy.

Description

Obtain the raw data from a PsyGeNET’s query stored in a DataGeNET.Psy object or the raw data
with all the Jaccard Index for the disease of interest of an JaccardIndexPsy object.

Usage

extract(object, ...)

## S4 method for signature 'DataGeNET.Psy'
extract(object)

## S4 method for signature 'JaccardIndexPsy'
extract(object, order.cl = "pval", ...)

extractSentences

Object of class DataGeNET.Psy or JaccardIndexPsy

NO USED
Order resulting data.frame by the name of this column.

4

Arguments

object

...

order.cl

Value

A data.frame containing the raw result from PsyGeNET or a data.frame with the result Jaccard
Index for each disease.
A data.frame containing the raw result from PsyGeNET
A data.frame with the result Jaccard Index for each disease.

Methods (by class)

• DataGeNET.Psy: Extract function for DataGeNET.Psy
• JaccardIndexPsy: Extract function for JacardIndexPsy

Examples

data(qr)
extract(qr)[1:2, ] # get internat data.frame
## Not run:
#Being x an JaccardIndexPsy
extract(x)

## End(Not run)

extractSentences

Method to obtain the sentences that support a gene-disease associa-
tion from a DataGeNET.Psy object.

Description

PsyGeNET contains a list of sentences that support a gene-disease association from public lit-
erature. The internal table of a DataGeNET.Psy object contains this information. The method
extractSentences allows to extract those sentences that support a gene-disease association given
a DataGeNET.Psy object and a disorder of interest.

Usage

extractSentences(object, disorder, verbose)

## S4 method for signature 'DataGeNET.Psy'
extractSentences(object, disorder, verbose = FALSE)

geneAttrPlot

Arguments

object

disorder

verbose

Value

5

Object of class DataGeNET.Psy.
The disorder of interest. Only those sentences supporting a gene-disease asso-
ciation with this speciﬁc disorder will be extracted. Disorder must be provided
by using "Disease Id" or "Disease Name". The "Disease Id" can be provided
with or without the "uml" tag. Example of a "Disease Name": "schizophre-
nia"; Example of a "Disease Id": "umls:C0036341", that is equivalent of using
"C0036341".
If set to TRUE informative messages are show.

A data frame showing the sentences.

Methods (by class)

• DataGeNET.Psy: Get sentences or evidences

Examples

data(qr)
extractSentences(qr, "Depression")

geneAttrPlot

Ploting the relation between genes and disease-categories

Description

Given a set of genes or a result of psygenetGene creates four types of plots showing the relation of
the genes with the disease’s category in psyGeNET.

Usage

geneAttrPlot(x, type = "pie", ..., verbose = FALSE)

Arguments

x

type

...

verbose

Value

Vector of genes of interest of DataGeNET.Psy resulting of psyegnetDisease.
Type of the drawn chart. By default it is "pie". It can takes "pie" to plot a pie
chart with the number of genes for each psychiatric category, "disease category"
for visualizing a barplot with the total and speciﬁc number of genes for each psy-
chiatric disorder, "evidence index" for a barplot showing for each psychiatric
disorder the number of gene-disease associations according to the Evidence in-
dex and "gene" for visualizing a barplot with the total and speciﬁc number of
diseases associated to each gene.

(Check NOTE section) Passed to inner functions for different plots.
By default FALSE. Change it to TRUE to get a on-time log from the function.

A plot for a DataGeNET.Psy in terms of the panther-class.

6

Note

getUMLs

The "Evidence Index" is gotten from PsyGeNET. For more information about it and its calculation,
pease visit psygenet.org. Argument ... can be ﬁlled with speciﬁc argument depending on the
type of plot:

Type
gene

disease category

Argument
cuiBarColor
diseaseCategoryBarColor Yellow Determines the color of the bar for psychiatric categories
uniqueGenesBarColor
totalGenesBarColor

Orange Determines the color of the bar for unique genes for a disease category
Blue

Description
Determines the color of the bar for diseases

Determines the color of the bar for total genes for a disease category

Color
Purple

getUMLs

Query PsyGeNET for given gene(s) and generates an DataGeNET.Psy

Description

Given the name of one or multiple gene and retrives their information from PsyGeNET and creates
an object of type DataGeNET.Psy.

Usage

getUMLs(word, database = "ALL")

Arguments

word

database

Value

Disese to convert to UMLS using PsyGeNET database.

Name of the database that will be queried. It can take the values 'psycur15' to
use data validated by experts for ﬁrst release of PsyGeNET; 'psycur16' to use
data validated by experts for second release of PsyGeNET; or 'ALL' to use both
databases. Default 'ALL'.

The corresponding UMLs for the input disease/s

Examples

umls <- getUMLs( word = "depressive", database = "ALL" )

jaccardEstimation

7

jaccardEstimation

Calculation of the Jaccard Index between ideseases

Description

This function is able to calculate the Jacard Index between: 1. muliple disases, 2. a set og genes and
multiple diseases, 3. a set of genes and multiple main psychiatric disorders and 4. multiple diseases
and multiple main psychiatric disorders.

Usage

jaccardEstimation(pDisease, sDisease, database = "ALL", nboot = 100,

ncores = 1, verbose = FALSE)

Arguments

pDisease

sDisease

database

nboot

ncores

verbose

Details

vector of diseases, vector of genes, vector of main psychiatric disorder.

vector of diseases, vector of genes, vector of main psychiatric disorder. Only
necessary when comparing genes vs. diseases, genes vs. main psychiatric dis-
orders or diseases vs. main psychiatric disorders. To compare multiple diseases
only use pDisease.
Name of the database that will be queried. It can take the values 'psycur15' to
use data validated by experts for ﬁrst release of PsyGeNET; 'psycur16' to use
data validated by experts for second release of PsyGeNET; or 'ALL' to use both
databases.

Number of iterations sued to compute the pvalue associted to the calculated
Jaccard Index (default 100).

Number of cores used to calculate the pvalue associated to the computed Jaccard
Index (default 1).
By default FALSE. Change it to TRUE to get a on-time log from the function.

Warning: The main psychiatric disorders are understood as a single set of genes composed by the
genes of all the diseases that the main psychiatric disorder cotains.

Value

An object of class JaccardIndexPsy with the computed calculation of the JaccardIndex.

Examples

ji <- jaccardEstimation( c( "COMT", "CLOCK", "DRD3" ), "umls:C0005586", "ALL" )

8

ndisease

JaccardIndexPsy-class Class JaccardIndexPsy

Description

Class JaccardIndexPsy is theresult of the process to look for a Jaccard Index between muliple
diseases in psygenet2r package.

Slots

nit Number of iterations to calculate the estimated Jaccard index
type Slot to save type of query (disease-disease, gene-disease)
table data.frame containing the result table of Jaccard indexes
i1 [internal use] vector with names of ﬁrst component
i2 [internal use] vector with names of second component

See Also

psygenetGene, psygenetDisease, JaccardIndexPsy-methods

Examples

ji <- jaccardEstimation( c( "COMT", "CLOCK", "DRD3" ), "umls:C0005586", "ALL" )

ndisease

Getter from DataGeNET.Psy.

Description

Obtain the number of unique diseases in a DataGeNET.Psy.

Usage

ndisease(object)

## S4 method for signature 'DataGeNET.Psy'
ndisease(object)

Arguments

object

Value

Object of class DataGeNET.Psy.

The number of unique diseases

Methods (by class)

• DataGeNET.Psy: Get number of diseases

9

ngene

Examples

data(qr)
ndisease(qr)

ngene

Getter from DataGeNET.Psy.

Description

Obtain the number of unique genes in a DataGeNET.Psy.

Usage

ngene(object)

## S4 method for signature 'DataGeNET.Psy'
ngene(object)

Arguments

object

Value

Object of class DataGeNET.Psy.

The number of unique genes

The number of unique genes

Methods (by class)

• DataGeNET.Psy: Get number of genes

Examples

data(qr)
ngene(qr)

pantherGraphic

Query PsyGeNET for given genes and creates a representation in base
of their panther-class

Description

Given a vector of genes of interest (or using a DataGeNET.Psy object), this function creates a
representation of a the panther-class these genes belongs to.

Usage

pantherGraphic(x, database = "ALL", evidenceIndex, verbose = FALSE)

10

Arguments

x

database

evidenceIndex

verbose

Value

plot,DataGeNET.Psy,ANY-method

Vector of genes of interest of DataGeNET.Psy resulting of psyegnetDisease.
Name of the database that will be queried. It can take the values 'psycur15' to
use data validated by experts for ﬁrst release of PsyGeNET; 'psycur16' to use
data validated by experts for second release of PsyGeNET; or 'ALL' to use both
databases. Default 'ALL'.
threshold to take into account a gene in the analysis
By default FALSE. Change it to TRUE to get a on-time log from the function.

A plot for a DataGeNET.Psy in terms of the panther-class.

Examples

d.alch <- pantherGraphic( c( "COMT", "CLOCK", "DRD3" ), "ALL" )

plot,DataGeNET.Psy,ANY-method

Plots the content of a DataGeNET.Psy object

Description

This functions llows to create a variety of plots for DataGeNEt.Psy and JaccardIndexPsy objects.

Usage

## S4 method for signature 'DataGeNET.Psy,ANY'
plot(x, y,

layout = igraph::layout.fruchterman.reingold, type = "GDA network",
verbose = FALSE, ...)

Arguments

x

y

layout

type

verbose

...

Value

Object of class DataGeNET.Psy
NOT USED
Function to design the location of the different nodes. By default layout.fruchterman.reingold
from igraph is used.
Type of the drawn chart. By default it is "GDA network" but it also can be
"GDCA network", "GDCA heatmap", "GDA heatmap" and "publications".
The ﬁrst two are network representations of the second two. While the last one
draws a barplot with the number of PMIDs between genes and diseases.
By default FALSE. If set to TRUE information on the drawing process will be
shown.

(Check NOTE section) Passed to inner functions for different plots.

A plot for DataGeNET.Psy.

plot,JaccardIndexPsy,ANY-method

11

Note

The "Evidence Index" is gotten from PsyGeNET. For more information about it and its calculation,
pease visit psygenet.org. Argument ... can be ﬁlled with speciﬁc argument depending on the
type of plot:

Description
Determines the color of the gene nodes
Determines the color of the disease nodes
Determines the color of the heatmap for the highest value
Determines the color of the heatmap for the lowest value
Determines the color for those associations with evidence index 0
Determines the color for those associations with evidence index greater than 0 and lower than 1
Determines the color for those associations with evidence index 1

Type
GDA network

GDA heatmap

GDCA network

GDCA heatmap AUDcolor

Color
Yellow
Blue
Blue
White
Yellow

Argument
geneColor
diseaseColor
highColor
lowColor
ei0color
eiAmbiguitcolor Grey
Blue
ei1color
#FF3C32
#FFC698
#9BE75E
#1F6024
#5AB69C
#50B8D6
#5467C3
#A654C3
Orange

BDcolor
DEPcolor
SCHZcolor
CUDcolor
SIDEPcolor
CanUDcolor
SYPSYcolor
geneColor

Examples

data(qr)
plot(qr) # for all-disease plot
plot(qr, type = 'GDCA network') # for MPI plot

plot,JaccardIndexPsy,ANY-method

Plot the content of a JaccardIndexPsy object.

Description

This functions llows to create a variety of plots for DataGeNEt.Psy and JaccardIndexPsy objects.

Usage

## S4 method for signature 'JaccardIndexPsy,ANY'
plot(x, y, cutOff, zero.remove = TRUE,

noTitle = FALSE, lowColor = "white", highColor = "mediumorchid4",
verbose = FALSE, ...)

Arguments

x

y

Object of class JaccardIndexPsy.
NOT USED

cutOff

zero.remove

Number to ﬁlter the shown results.
By deffault TRUE. It removes those relations with a Jaccard Index of 0.

12

noTitle

lowColor

By default FALSE. If set to true no title will be added to the plot.

By default "white". It can be changed to any other color.

psygenet2r

highColor

By default "mediumorchid4". It can be changed to any other color.

verbose

By default FALSE. If set to TRUE information on the drawing process will be
shown.

...

NOT USED

Value

A plot for JaccardIndexPsy.

Examples

## Not run:
#Being x an JaccardIndexPsy
qr <- plot(x)

## End(Not run)

psygenet2r

psygenet2r: Package to query PsyGeNET database and to perform
comorbidity studies

Description

psygenet2r has two categories of functions: querying functions and analysis and plotting functions.

querying functions

The functions to retrieve data from PsyGeNET are psygenetDisease and psygenetGene. There are
some other support functions like psygenetGeneSentences.

analysis and plotting functions

The functions extract and extractSentences allows to retrieve the row data obtained from on-line
resources. The functions plot and pantherGraphic draws a variety of charts to illustrate the obtained
results. The function enrichedPD was built to perform enrichment studies on PsyGeNET data.
Finally the function jaccardEstimation computes a Jaccard Index from a given input on PsyGeNET
data.

psygenetDisease

13

psygenetDisease

Query PsyGeNET for
DataGeNET.Psy

given

disease(s)

and

generates

an

Description

Given the name of one or multiple diseases and retrives their information from PsyGeNET and
creates an object of type DataGeNET.Psy.

Usage

psygenetDisease(disease, database = "ALL", evidenceIndex = c(">", 0),

verbose = FALSE, warnings = TRUE)

Arguments

disease

database

Name or vector of names (that can be both code or uml) to speciﬁc diseases from
PsyGeNET. The diseases non existing in PsyGeNET will be removed from the
output.

Name of the database that will be queried. It can take the values 'psycur15' to
use data validated by experts for ﬁrst release of PsyGeNET; 'psycur16' to use
data validated by experts for second release of PsyGeNET; or 'ALL' to use both
databases. Default 'ALL'.

evidenceIndex A vector with two elements: 1) character with greather '>' or with lower '<'
meaing greather or equal and lower or equal; 2) the evidence index cut-off to be
compared. By default: c('>', 0).

By default FALSE. Change it to TRUE to get a on-time log from the function.

By default TRUE. Change it to FALSE to don’t see the warnings.

verbose

warnings

Value

An object of class DataGeNET.Psy

Note

The "Evidence Index" is gotten from PsyGeNET. For more information about it and its calculation,
pease visit psygenet.org.

Examples

d.sch <- psygenetDisease( "schizophrenia", "ALL" )

14

psygenetGene

psygenetDiseaseSentences

Query PsyGeNET for given disease(s) and extract the pmids sentences
that report a gene-disease asssociation.

Description

Given a disease or a disease list, retrives the pmids and sentences for each gene-disease association
from PsyGeNET and creates an object of type DataGeNET.Psy.

Usage

psygenetDiseaseSentences(diseaseList, database = "ALL", verbose = FALSE)

Arguments

diseaseList

database

verbose

Value

Name or vector of names (that can be both code or uml) to speciﬁc diseases from
PsyGeNET. The diseases non existing in PsyGeNET will be removed from the
output.
Name of the database that will be queried. It can take the values 'psycur15' to
use data validated by experts for ﬁrst release of PsyGeNET; 'psycur16' to use
data validated by experts for second release of PsyGeNET; or 'ALL' to use both
databases. Default 'ALL'.
By default FALSE. Change it to TRUE to get a on-time log from the function.

An object of class DataGeNET.Psy

Examples

diseasesOfInterest <- c( "Bipolar Disorder","Depressive Disorder, Major" )
psyDisSen <- psygenetDiseaseSentences( diseaseList = diseasesOfInterest,

database = "ALL" )

psygenetGene

Query PsyGeNET for given gene(s) and generates an DataGeNET.Psy

Description

Given the name of one or multiple gene and retrives their information from PsyGeNET and creates
an object of type DataGeNET.Psy.

Usage

psygenetGene(gene, database = "ALL", evidenceIndex = c(">", 0),

verbose = FALSE, warnings = TRUE)

psygenetGeneSentences

15

Arguments

gene

database

Name or vector of names (that can be both code or symbol) to speciﬁc genes
from PsyGeNET. The genes non existing in PsyGeNET will be removed from
the output.
Name of the database that will be queried. It can take the values 'psycur15' to
use data validated by experts for ﬁrst release of PsyGeNET; 'psycur16' to use
data validated by experts for second release of PsyGeNET; or 'ALL' to use both
databases. Default 'ALL'.

evidenceIndex A vector with two elements: 1) character with greather '>' or with lower '<'
meaing greather or equal and lower or equal; 2) the evidence index cut-off to be
compared. By default: c('>', 0).
By default FALSE. Change it to TRUE to get a on-time log from the function.
By default TRUE. Change it to FALSE to not see the warnings.

warnings

verbose

Value

An object of class DataGeNET.Psy

Note

The "Evidence Index" is gotten from PsyGeNET. For more information about it and its calculation,
pease visit psygenet.org.

Examples

d.alch <- psygenetGene( "ALDH2", "ALL" )

psygenetGeneSentences Query PsyGeNET for given gene(s) and extract the pmids sentences
that report a gene-disease asssociation.

Description

Given a gene or a gene list, retrives the pmids and sentences for each gene-disease association from
PsyGeNET and creates an object of type DataGeNET.Psy.

Usage

psygenetGeneSentences(geneList, database = "ALL", verbose = FALSE)

Arguments

geneList

database

verbose

Name or vector of names (that can be both code or symbol) to speciﬁc genes
from PsyGeNET. The genes non existing in PsyGeNET will be removed from
the output.
Name of the database that will be queried. It can take the values 'psycur15' to
use data validated by experts for ﬁrst release of PsyGeNET; 'psycur16' to use
data validated by experts for second release of PsyGeNET; or 'ALL' to use both
databases. Default 'ALL'.
By default FALSE. Change it to TRUE to get a on-time log from the function.

qr

16

Value

An object of class DataGeNET.Psy

Examples

genesOfInterest <- c("PECR", "ADH1C", "CAST", "ERAP1", "PPP2R2B",
"ESR1", "GATA4", "CDH13")

psyGeneSen <- psygenetGeneSentences( geneList = genesOfInterest,

database = "ALL")

qr

DataGeNET.Psy obtained from quering PsyGeNET for gene ’4852’.

Description

A dataset obtained from PsyGeNET after being queried with psygenetGene usig the term ’4852’
on "ALL" databse.

Usage

data("qr")

Format

The format is: Formal class ’DataGeNET.Psy’ [package "psygenet2r"] with 5 slots ..
"gene" .. search : chr "" .. database: chr "ALL" .. term : chr "4852" .. qresult :’data.frame’

type : chr

Value

A DataGeNET.Psy object.

Source

http://psygenet.org

Examples

ngene(qr)
ndisease(qr)

topAnatEnrichment

17

topAnatEnrichment

Enrichment of a user’s input (genes) in anatomical terms (TopAnat).

Description

Test the enrichment of a given gene list on Psychiatric Disorders from PsyGeNET.

Usage

topAnatEnrichment(gene, datatype = c("rna_seq", "affymetrix", "est",
"in_situ"), statistic = "fisher", cutOff = 1, verbose = FALSE,
warnings = FALSE)

Arguments

gene

datatype

statistic

cutOff

verbose

warnings

Name or vector of names (that can be both code or uml) to speciﬁc genes from
PsyGeNET.
It can take the values 'rna_seq', 'affymetrix', "est" or "in situ". Default
c("rna_seq","affymetrix","est","in_situ").
By default it is "fisher". But it can be changed to "ks", "t", "globaltest",
"sum" or "ks.ties". All from runTest.
Default 1.
By default FALSE. Change it to TRUE to get a on-time log from the function.
By default TRUE. Change it to FALSE to not see the warnings.

Value

A data.frame with the enrichment results

Examples

## Not run:
topAnatEnrichment(gene=c("ADCY2", "AKAP13", "ANK3"))

## End(Not run)

universe

Vector with gene universe for Jaccard Index

Description

Vector with all the gene names from DisGeNET database (http://www.disgenet.org) used as gene
universe for Jaccard Index computation.

Usage

universe

universe

18

Format

An object of class character of length 8947.

Details

data("universe", package = "psygenet2r")

Value

A character vector.

Source

http://www.disgenet.org

Examples

length(universe)
universe[1:10]

runTest, 17

topAnatEnrichment, 17

universe, 17

Index

∗Topic datasets
qr, 16
universe, 17

DataGeNET.Psy-class, 2
DataGeNET.Psy-plot

(plot,DataGeNET.Psy,ANY-method),
10

enrichedPD, 3, 12
extract, 3, 12
extract,DataGeNET.Psy-method (extract),

3

extract,JaccardIndexPsy-method

(extract), 3

extractSentences, 4, 12
extractSentences,DataGeNET.Psy-method
(extractSentences), 4

geneAttrPlot, 5
getUMLs, 6

jaccardEstimation, 7, 12
JaccardIndexPsy-class, 8
JaccardIndexPsy-plot

(plot,JaccardIndexPsy,ANY-method),
11

ndisease, 8
ndisease,DataGeNET.Psy-method
(ndisease), 8

ngene, 9
ngene,DataGeNET.Psy-method (ngene), 9

pantherGraphic, 9, 12
plot,DataGeNET.Psy,ANY-method, 10
plot,JaccardIndexPsy,ANY-method, 11
psygenet2r, 12
psygenet2r-package (psygenet2r), 12
psygenetDisease, 12, 13
psygenetDiseaseSentences, 14
psygenetGene, 12, 14
psygenetGeneSentences, 12, 15

qr, 16

19

