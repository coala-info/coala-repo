mitoODEdata: Dynamical modelling of phenotypes in a
genome-wide RNAi live-cell imaging assay

Gregoire Pau
pau.gregoire@gene.com

November 1, 2018

Contents

1 Introduction

2 Data access

3 References

1 Introduction

1

1

3

The Mitocheck screen [2] is a time-lapse imaging assay that employed small-interfering RNAs (siRNAs) to test
the implication of human genes in transient biological processes such as cell division or migration genome-wide.
In this experiment, HeLa cells stably expressing core histone 2B tagged with green ﬂuorescent protein (GFP)
were seeded on siRNA-spotted slides, incubated for 18 h and imaged with automated ﬂuorescence microscopy
for 48 h. Video sequences of cell populations on each siRNA-spot were analysed by image segmentation, and
at each frame, each individual cell was categorised into one of 16 morphological classes mostly related to cell
division.

The mitoODE package implements a modelling by diﬀerential equations of cellular populations [1], to
quantify the phenotypic eﬀect induced by siRNA treatments in the Mitocheck screen. The package includes
the code to ﬁt any time course data to the model and the scripts used to generate the ﬁgures and results
presented in the paper.

The mitoODEdata package, the experimental companion package of mitoODE, contains the screen data
and methods to access the Mitocheck assay layout, siRNA annotation, time-lapse cell counts and the ﬁtted
phenotypes for each spot. Four cell types are reported:
interphase (referred in the Mitocheck paper as:
Interphase, Large, Elongated, Folded, Hole, SmallIrregular or UndeﬁnedCondensed), mitotic (Metaphase,
Anaphase, MetaphaseAlignment, Prometaphase or ADCCM), polynucleated (Shape1, Shape3, Grape) and
apoptotic (Apoptosis).

2 Data access

Loading the package mitoODEdata loads the Mitocheck screen annotation variables tab and anno in the global
environment. The object tab is a data frame containing spot metadata, including: plate (plate number),
replicate (replicate number), spot (spot number within the plate), qc (original quality control from the
paper), type (spot type) and sirna (spot siRNA ID). The object anno is a data frame containing the siRNA
to gene mapping, including: sirna (siRNA ID), ensembl (target Ensembl gene ID), hgnc (target HGNC
gene symbol), entrez (target Entrez gene ID), genename (target HGNC gene name).

> library("mitoODEdata")
> tab[1:5,]

plate replicate spot id pr

1
2
3

1
1
1

2
2
2

ps

qc
sirna
marker MCO_0016401
1 1 102 1001 TRUE
2 2 102 1002 TRUE markerNeighbors MCO_0007359
3 3 102 1003 TRUE incenpNeighbors MCO_0007324

type

1

4
5

1
1

2
2

4 4 102 1004 TRUE
incenp MCO_0016401
5 5 102 1005 TRUE incenpNeighbors MCO_0006006

> anno[1:5,]

ensembl hgnc1 entrez hgnc

ambion

sirna
1 41652 MCO_0000001 ENSG00000004455
2 41815 MCO_0000002 ENSG00000004455
3 147152 MCO_0000003 ENSG00000004455
4 129427 MCO_0000004 ENSG00000140057
5 129428 MCO_0000005 ENSG00000140057

genename
204 AK2 adenylate kinase 2
AK2
204 AK2 adenylate kinase 2
AK2
AK2
204 AK2 adenylate kinase 2
AK7 122481 AK7 adenylate kinase 7
AK7 122481 AK7 adenylate kinase 7

The functions getspot, getsirna and getanno allow simple conversions between HGNC gene symbols,

Mitocheck siRNAs and spot IDs.

> getsirna(ann="CDH1")

[1] "MCO_0026105" "MCO_0026106" "MCO_0042725" "MCO_0046957" "MCO_0054655"
[6] "MCO_0054656"

> getspot(ann="FGFR2")

[1] 58916 59300 59684 64740 65124 65508 64551 64935 65319

> getanno(spot=1234, field=c("hgnc", "entrez", "genename"))

genename
6991 SLC19A2 10560 solute carrier family 19 (thiamine transporter), member 2

hgnc entrez

The function readspot reads the time-course cell counts of a given spot ID. The output value is a matrix
containing the number of cells of a given type (interphase i, mitotic m, polynucleated s and apoptotic a) per
frame. The ﬁrst image (e.g. row) was acquired 18 h after siRNA transfection and the following images were
acquired every 30 minutes during 48 h. The function plotspot plots the cell count time series of a given
spot ID.

> spotid <- getspot(ann="FGFR2")[1]
> y <- readspot(spotid)
> y[1:10,]

i m s a
[1,] 52 0 0 0
[2,] 50 1 1 0
[3,] 47 4 2 0
[4,] 47 3 3 0
[5,] 51 5 1 0
[6,] 53 2 4 0
[7,] 53 1 3 0
[8,] 54 2 2 0
[9,] 53 2 3 0
[10,] 50 3 6 0

> plotspot(spotid)

2

3 References

References

[1] Pau G, Walter T, Neumann B, Heriche JK, Ellenberg J, and Huber W (2013) Dynamical modelling of

phenotypes in a genome-wide RNAi live-cell imaging assay. (submitted)

[2] Neumann B, Walter T, Heriche JK, Bulkescher J, Erﬂe H, et al. (2010) Phenotypic proﬁling of the human

genome by time-lapse microscopy reveals cell division genes. Nature 464: 721–727.

3

20304050600102030405060Time after cell seeding (h)Number of cellsinterphasemitoticpolynucleateddead