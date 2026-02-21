PloGO2: An R package for plotting GO or Pathway annotation
and abundance

J.Wu and D.Pascovici

April 28, 2020

Abstract

This R package is an upgrade of the PloGO package described in Pascovici et al. (2012),
and contains tools for plotting gene ontology or KEGG pathway information for multiple
data subsets at the same time. It is designed to incorporate additive information about
data abundance (if available) in addition to the gene ontology and pathway annotation,
handle multiple input ﬁles corresponding to multiple data subsets of interest, and allow for
a small selection of gene ontology categories of interest. It allows to potentially compare all
subsets to a baseline condition, typically the set of all proteins identiﬁed in an experiment,
to determine enrichment. The package includes samples of the publicly available data of
Mirzaei et al. and Wu et al. (2016).

1 Introduction

Both GO (Gene Ontology) and KEGG pathway data summaries are routinely used by pro-
teomic publications to provide some ﬁrst-glance insight into the function, process, location,
interaction and relation of collections of genes or proteins. The GO data is organized as a
directed acyclic graph starting from one parent node, which means that particular ontology
categories can have multiple parents as well as multiple children. The KEGG pathway data,
on the other hand, is simply orgnaised into seven big categories including metabolism, generic
information processing and so on.

This package was designed for the following tasks

(cid:136) Generate GO or KEGG summaries in text or excel format for a large number of data

subsets

(cid:136) Allow for selection of particular categories of interest for an experiment (e.g.

stress
response) across many annotation ﬁles, instead of working with a particular level of the
GO hierarchy.

(cid:136) Summarise aditive protein abundance information (such as percentages of total abun-
dance, or log fold changes) for all data sets and all categories of interest, if available

(cid:136) Determine enrichment by comparing all sets to one of the selected sets, typically all

proteins identiﬁed in the experiment

1

2 Package use

First load up PloGO2; we are also loading up the xtable packages so we can display some
tables nicely in this document.

> library(PloGO2)
> library(xtable)

Fig 1 shows the high level PloGO2 workﬂow usage. The workﬂow contains two parts: Gene

Ontology analysis and pathway analysis.

Figure 1: PloGO2 workﬂow usage

3 Gene Ontology analysis

3.1 Generate some gene ontology ﬁles from scratch

The starting point of a gene ontology analysis is always a collection of identiﬁers with all their
available gene ontology annotation. At this point, only Ensembl human or Uniprot identiﬁers
are accepted, though this can be easily extended. The GO annotation is obtained from biomaRt
or directly from the Uniprot website.

The code fragment below generates a very small such ﬁle in the local folder where R is
running from. Keep in mind that this will require online accesing of the Ensembl biomart
repository and as such can take a while (or can fail if the repository is not available for
whatever reason).

2

> v <- c("Q9HWC9","Q9HWD0","Q9I4N8","Q9HW18","Q9HWC9","Q9HWD0")
> wego.file <- genWegoFile(v, fname = "F1.txt")

Now a quick look at the ﬁles generated: the format is very simple, with the identiﬁer in

the ﬁrst column followed by space separated GO identiﬁers.

> print(xtable(read.annot.file(wego.file), align = "rp{4cm}p{10cm}"))

IDS
1 Q9HWC9

2 Q9HWD0

3 Q9I4N8
4 Q9HW18

V1
GO:0000287 GO:0003677 GO:0003899 GO:0006351
GO:0008270
GO:0000049 GO:0003735 GO:0005840 GO:0006412
GO:0015935 GO:0019843
GO:0016020 GO:0047355

Alternatively, one can obtain some gene ontology ﬁles in ”long” format, namely identiﬁer
followed by GO annotation separated by white space (spaces or tabs). One online program
that generates such ﬁles is GORetriever (part of the McCarthy et al. (2006) set of tools); other
options for obtaining similar output are a direct download of ID and GO information only from
places such as Biomart or Uniprot. Only the ﬁrst two columns of the ﬁles will be processed,
the rest (if any) will be discarded. Two such sample ﬁles, one from GoRetriever and another
a Biomart download are included in the package, and we show the ﬁrst few lines below.

> path <- system.file("files", package = "PloGO2")
> goRet <- file.path(path, "goRetOutput.txt")
> print(xtable(read.annot.file(goRet)[1:10, ]))

IDS

V1
1 P00359 GO:0001950 C
2 P00359 GO:0003824 F
3 P00359 GO:0004365 F
4 P00359 GO:0005488 F
5 P00359 GO:0005515 F
6 P00359 GO:0005737 C
7 P00359 GO:0005739 C
8 P00359 GO:0005811 C
9 P00359 GO:0006006 P
10 P00359 GO:0006094 P

> bioMt <- file.path(path, "mart_export.txt")
> print(xtable(read.annot.file(bioMt, format="long")[1:10, ]))

3

IDS

V1

1 ENSG00000010256 GO:0006119 GO:0006122 GO:0006508 GO:0006810 GO:0009060 GO:0014823 GO:0022904 GO:0043279 GO:0055114 GO:0005739 GO:0005743 GO:0005746 GO:0005750 GO:0016020 GO:0004222 GO:0005515 GO:0008121 GO:0008270 GO:0032403 GO:0046872 GO:0003824
2 ENSG00000072110 GO:0002576 GO:0007596 GO:0030168 GO:0034329 GO:0042981 GO:0048041 GO:0051271 GO:0005576 GO:0005730 GO:0005737 GO:0005829 GO:0005925 GO:0015629 GO:0030018 GO:0031093 GO:0031143 GO:0003779 GO:0005178 GO:0005509 GO:0005515 GO:0017166
3 ENSG00000072786 GO:0006468 GO:0000166 GO:0004674 GO:0005524 GO:0016740 GO:0004672
4 ENSG00000075415
5 ENSG00000080824 GO:0000086 GO:0000278 GO:0006839 GO:0006986 GO:0007165 GO:0007411 GO:0034619 GO:0042026 GO:0045040 GO:0045429 GO:0046209 GO:0050999 GO:0006950 GO:0006457 GO:0005622 GO:0005737 GO:0005829 GO:0005886 GO:0042470 GO:0000166 GO:0005515 GO:0005524 GO:0030235 GO:0030911 GO:0042803 GO:0051082
6 ENSG00000083720 GO:0007420 GO:0007507 GO:0007584 GO:0008152 GO:0009725 GO:0014823 GO:0032024 GO:0042493 GO:0042594 GO:0044255 GO:0045471 GO:0046950 GO:0046952 GO:0060612 GO:0071229 GO:0071333 GO:0005739 GO:0005759 GO:0008260 GO:0016740 GO:0042803 GO:0008410
7 ENSG00000083845 GO:0006412 GO:0006413 GO:0006414 GO:0006415 GO:0006450 GO:0010467 GO:0016032 GO:0019058 GO:0019083 GO:0031018 GO:0044267 GO:0005829 GO:0022627 GO:0030529 GO:0005622 GO:0005840 GO:0015935 GO:0003723 GO:0003729 GO:0003735
8 ENSG00000085719 GO:0006629 GO:0016192 GO:0005737 GO:0005829 GO:0004674 GO:0005215 GO:0005544 GO:0005515
9 ENSG00000085872 GO:0006874 GO:0007399 GO:0008285 GO:0006396 GO:0005737 GO:0005783 GO:0048471 GO:0005622 GO:0003674 GO:0003723 GO:0003676

10 ENSG00000086589 GO:0000060 GO:0006397 GO:0008380 GO:0005634 GO:0005681 GO:0005737 GO:0000166 GO:0003723 GO:0005515 GO:0008270 GO:0046872 GO:0048306 GO:0003676

3.2 Process existing gene ontology ﬁles

From now on we assume we have several gene ontology ﬁles, whether generated with PloGO2
or obtained elsewhere. For a realistic example, there are 5 sample gene ontology ﬁles in-
cluded in the package; they are a subset of all those analyzed for the paper by Mirzaei et al.
and correspond to various presence-absence categories in which the total number of proteins
were partitioned. The same package also contains a protein abundance ﬁle which has protein
abundance values for each identiﬁer, as well as protein names.

> file.names <- file.path(path, c("00100.txt", "01111.txt", "10000.txt",
+
> datafile <- file.path(path, "NSAFDesc.csv")

"11111.txt", "Control.txt"))

As a next step we could either look at a few categories of interest, or extract all categories

at a particular level of the gene ontology graph.

The following code fragment would extract all nodes at the Level 2 (3 or 4) of the GO

hierarchy:

> GOIDlist <- GOTermList("BP", level = 2)

While perhaps restrictive, the list at level 2 could be quite informative; at levels 3 or 4 it
is very long. By some manual input or processing you can choose to enter for instance a GO
slim of interest; for instance below we selected the cellular component part of the generic GO
slim developed by the GO consortium.

> GOSlimCC <- c( "GO:0000228", "GO:0000229", "GO:0005575", "GO:0005576",
+
+
+
+
+
+
+

"GO:0005578", "GO:0005615", "GO:0005618", "GO:0005622", "GO:0005623",
"GO:0005634", "GO:0005635", "GO:0005654", "GO:0005694", "GO:0005730",
"GO:0005737", "GO:0005739", "GO:0005764", "GO:0005768", "GO:0005773",
"GO:0005777", "GO:0005783", "GO:0005794", "GO:0005811", "GO:0005815",
"GO:0005829", "GO:0005840", "GO:0005856", "GO:0005886", "GO:0005929",
"GO:0009536", "GO:0009579", "GO:0016023", "GO:0030312", "GO:0043226",
"GO:0043234" )

4

For the purpose of this analysis, a more targeted ﬁxed list of categories of interest was

preferred by Mirzaei et al., as below.

> # Extract a few categories of interest
> termList <- c("response to stimulus", "transport", "protein folding",
+
+
+
+
+
+
+
> GOIDmap <- getGoID(termList)
> GOIDlist <- names(GOIDmap)

"protein metabolic process", "carbohydrate metabolic process",
"oxidation reduction", "photosynthesis", "lipid metabolic process",
"cell redox homeostasis",
"cellular amino acid and derivative metabolic process",
"nucleobase, nucleoside and nucleotide metabolic process",
"vitamin metabolic process", "generation of precursor metabolites and energy",
"metabolic process", "signaling")

Once you have the ﬁles and the GO categories, you need to process the ﬁles one by one
to extract summaries of the categories of interest. The ﬁle by ﬁle processing is done by the
processGoFile function.

> go.file <- processGoFile(wego.file, GOIDlist)

The bulk of processing a set of annotation ﬁles is done by the processAnnotation ﬁle,
which can print annotation listings for each ﬁle, and merge with abundance information if any
is available.

> res.list <- processAnnotation(file.names, GOIDlist, printFiles = FALSE)

After processing the ﬁles, the annotationPlot function produces some visual summaries and

generates the counts and percentages.

> annot.res <- annotationPlot(res.list)

Below are the summaries generated for the protein annotation ﬁles considered.

> print(xtable(annot.res$counts, align = "rp{1.2cm}p{1.2cm}p{1.2cm}p{1.2cm}p{1.2cm}"))

> print(xtable(annot.res$percentages, align = "rp{1.2cm}p{1.2cm}p{1.2cm}p{1.2cm}p{1.2cm}"))

5

response to stimulus
transport
protein folding
protein metabolic process
carbohydrate metabolic process
photosynthesis
lipid metabolic process
cell redox homeostasis
vitamin metabolic process
generation of precursor metabolites and energy
metabolic process
signaling

response to stimulus
transport
protein folding
protein metabolic process
carbohydrate metabolic process
photosynthesis
lipid metabolic process
cell redox homeostasis
vitamin metabolic process
generation of precursor metabolites and energy
metabolic process
signaling

00100.txt 01111.txt 10000.txt 11111.txt Control.txt
11
16
3
20
8
1
2
2
2
3
67
6

42
81
28
139
112
38
35
13
4
71
574
3

24
50
15
74
64
30
15
7
2
55
313
3

1
6
0
25
5
3
0
3
1
4
48
0

4
4
1
12
8
1
7
1
0
3
44
0

00100.txt 01111.txt 10000.txt 11111.txt Control.txt
7.97
11.59
2.17
14.49
5.80
0.72
1.45
1.45
1.45
2.17
48.55
4.35

4.28
8.25
2.85
14.15
11.41
3.87
3.56
1.32
0.41
7.23
58.45
0.31

4.67
9.73
2.92
14.40
12.45
5.84
2.92
1.36
0.39
10.70
60.89
0.58

1.15
6.90
0.00
28.74
5.75
3.45
0.00
3.45
1.15
4.60
55.17
0.00

4.17
4.17
1.04
12.50
8.33
1.04
7.29
1.04
0.00
3.12
45.83
0.00

3.3 Compare annotation to a given reference

One can choose to compare the percentages of annotation in various subsets to a selected
reference, to check whether there is an association between the presence in a particular gene
ontology category and presence in the particular subset (e.g. are there more carbohydrate
metabolism proteins in the subset X than expected by chance considering the whole popula-
tion?) . This is done by means of applying Fisher’s exact test for each gene ontology category
and for each subset as compared to the selected reference. The test returns a p-value, which
is only recorded if the counts for the respective category are not too small (n > 5).

> res <- compareAnnot(res.list, "Control")
> print(xtable(res))

Given the large number of tests, and the fact that multiple testing corrections are not
applied, such a table should be regarded as a suggestion for selecting further categories and
protein subsets for further consideration. In the example at hand for instance, there is a clear
indication that there are more signalling proteins in the “00100” subset (Protein present at
extreme stress conditions only) than expected by chance.

6

Figure 2: Annotation plot: a barplot of the percentage of identiﬁcation in each selected category
and for each selected ﬁle, on a log scale

3.4 Add abundance data

We now consider the protein abundance data. We process the annotation again, this time
indicating that we have an abundance dataﬁle. Note that the abundance ﬁle has two de-
scriptive columns (a protein ID and a protein description), so we indicate that by setting the
dataﬁle.ignore.cols.

> res.list <- processAnnotation(file.names, GOIDlist, data.file.name = datafile,
+

printFiles = FALSE, datafile.ignore.cols = 2)

If the printFiles parameter is set to TRUE, a tab separated annotation ﬁle will be printed
in the current directory for each of the GO ﬁles processed. The format can be changed to a
CSV matrix containing identiﬁers as rows and GO categories as columns. You can inspect for
instance the “Annot 11111.csv” and “Annot 11111.txt” to see the diﬀerent formats. The matrix
one might be preferred if one wishes to see combinations of GO identiﬁers (”Which of my ID’s
were involved in both transport and signaling?”).

7

log(Percentage + 1)0123Biosynthesis of secondary metabolitesMetabolic pathwaysPorphyrin and chlorophyll metabolismRibosomeStarch and sucrose metabolismAllData.txtblack.txtblue.txtbrown.txtgreen.txtred.txtturquoise.txtyellow.txtresponse to stimulus
transport
protein folding
protein metabolic process
carbohydrate metabolic process
photosynthesis
lipid metabolic process
cell redox homeostasis
vitamin metabolic process
generation of precursor metabolites and energy
metabolic process
signaling

00100.txt
0.13
0.26
1.00
1.00
0.11

0.09
0.09
0.00

01111.txt

0.98

0.01
0.35
1.00

0.35

0.80
0.80

10000.txt
1.00
0.40

0.89
0.69

0.32

0.40
0.16

11111.txt Control.txt

1.00
0.87
1.00
1.00
0.87
0.49
0.87
1.00

0.27
0.87
0.87

> annot.file <- writeAnnotation(res.list, datafile = datafile, format = "matrix")

After processing the abundance ﬁles, some graphs can be generated by abundancePlot and

are included below. One levelplot for each ﬁle will be generated.

> tp <- abundancePlot(res.list)

8

Figure 3: Abundance levelplot for File 1, showing the total abundance for each GO category
in each ﬁle. One such image is generated for each ﬁle under consideration.

9

4 KEGG pathway analysis

In this section, we will describe the steps involved in KEGG pathway analysis using PloGO2,
which is a major extension of our PloGO R packagePascovici et al. (2012). We will use a public
dataset in Wu et al. (2016) as an example to help go through the steps of the PloGO2 pathway
analysis.

4.1 Prepare the pathway DB ﬁle

Unlike the publicly available GO annotation databases, KEGG pathway database requires paid
subscription for using their APIs. As such, PloGO2 does not provide functions of accessing
KEGG pathway annotations on the ﬂy, hence the pathway annotations for all proteins of
interest have to be pre-downloaded. Besides using subscribed APIs, there are a number of
ways for downloading KEGG pathway annotations such as using the KEGG website or a
third-party tool such as DAVID.

The downloaded pathway annotations need to be saved in a simple two-column CSV ﬁle
format which is the same as the GO annotation described in 3.1. Each row has one protein ID
and one or more pathway IDs separated by space. An example of the pathway DB ﬁle is as
below.

> path <- system.file("files", package = "PloGO2")
> filedb <- file.path(path, "pathwayDB.csv")
> print(xtable(read.csv(filedb)[1:5,]))

Protein

1 A0A0N7KEB1
2 A3C4S4
3 B7E914
4 B7EKA4
5 B7ERZ5

x
osa01100 osa01212 osa01040 osa00061
osa01100 osa01110 osa00520 osa00053
osa01100 osa00190
osa01100 osa01110 osa01230 osa00270
osa01100 osa01110 osa00010

4.2 Generate pathway annotation ﬁles

Similar to the GO analysis, the starting point of a pathway analysis is also a collection of
identiﬁers with all their available KEGG pathway IDs in a WegoYe et al. (2006) ﬁle format.
Function genAnnotationFiles will take a multi-tabbed Excel ﬁle with some protein IDs as input
and generate an annotation .txt ﬁle for each tab.

The 531 diﬀerentially expressed proteins from Wu et al. (2016) were clustered into 7 clusters
using WGCNA (please refer to PloGO2WithWGCNA vignette for details). Results were saved
in an Excel ﬁle with each tab containing proteins from one cluster. The KEGG pathway
annotations for all proteins were downloaded and formatted in a pathway DB ﬁle. Use the
following commands to generate the annotation ﬁles for all clusters. Parameter colName is used
to specify the name of the column that contains the protein IDs, by default, it is “Uniprot”.
DB.name speciﬁes the pathway DB ﬁle name and parameter folder speciﬁes the folder that the
generated annotation ﬁles will be stored.

10

> path <- system.file("files", package = "PloGO2")
> res.annot <- genAnnotationFiles(fExcelName = file.path(path,
+
+
+
+

colName="Uniprot",
DB.name = file.path(path, "pathwayDB.csv"),
folder="PWFiles")

"ResultsWGCNA_Input4PloGO2.xlsx"),

The generated pathway annotation ﬁle is in the same ﬁle format as the GO annotation ﬁle.

Below is an example.

> print(xtable(read.annot.file(file.path(path, "PWFiles", "red.txt"))[1:5,]))

IDS
1 Q53RM0
2 Q2QP54
3 Q6ZJ16
4 Q7XQQ7
5 Q6ZG77

V1
osa01100 osa01110 osa00860

osa01100 osa01110 osa01230 osa00300

4.3 Semi-automated pathway analysis

When the pathway annotation ﬁles have been generated, we can proceed to perform the path-
way analysis. PloGO2 provides two ways of executing a pathway analysis: semi-automated
and automated.

Using the semi-automated approach, the users can control the analysis and inspect the
intermediate output from each step. The ﬁrst step in this mode is to process the list of
annotated ﬁles generated above.

Similar to the processGoFile, an individual pathway annotation ﬁle can be processed using
function processPathFile and the identiﬁers belonging to each pathway category will be ex-
tracted. The following code fragment shows how to process the annotation for the “AllData”
ﬁle given a list of pathway categories of interest.

> fname <- file.path(path,"PWFiles/AllData.txt")
> AnnotIDlist <- c("osa01100","osa01110","osa01230","osa00300","osa00860")
> res.pathfile <- processPathFile(fname, AnnotIDlist)

If the abundance data ﬁle is available, it can be added as the value of the dataﬁle parameter

and the abundance for each pathway category will be aggregated.

> datafile <- paste(path, "Abundance_data.csv", sep="/")
> res.pathfile.abun <- processPathFile(fname, AnnotIDlist, datafile=datafile)

Again, function processAnnotation can be used to batch processing a list of annotation

ﬁles. An example is as below.

> file.list <- file.path(path,"PWFiles", c("AllData.txt", "red.txt", "yellow.txt") )
> AnnotIDlist <- c("osa01100","osa01110","osa01230","osa00300","osa00860")
> res.list <- processAnnotation(file.list, AnnotIDlist, data.file.name=datafile)

11

If the abundance data ﬁle exists, function abundancePlot can be used to generate some

plots for each annotation ﬁle.

> Group <- names(read.csv(datafile))[-1]
> abundance <- abundancePlot(res.list, Group=Group)

If the reference (usually the whole experimental data) is given, function compareAnnot can

be used to perform the pathway enrichment analysis with Fisher exact test.

> reference="AllData"
> comp <- compareAnnot(res.list, reference)
> print(xtable(comp, digits=4))

Metabolic pathways
Biosynthesis of secondary metabolites
Biosynthesis of amino acids
Lysine biosynthesis
Porphyrin and chlorophyll metabolism

AllData.txt

red.txt
0.5766
0.5766

yellow.txt
0.1587
0.0518

0.0019

4.4 Automated pathway analysis

In the automated mode, the process described above can be automatically executed using one
wrapper function PloPathway. The inputs can be a zip ﬁle or ﬁle folder, with an optional
abundance data ﬁle. An example is as below.

> path <- system.file("files", package = "PloGO2")
> res <- PloPathway( zipFile=paste(path, "PWFiles.zip", sep="/"),
+
+
+

reference="AllData",
data.file.name = paste(path, "Abundance_data.csv", sep="/"),
datafile.ignore.cols = 1)

4.5 Output summary ﬁle and plot

A PloGO2 summary ﬁle can be printed out as an xlsx ﬁle using printSummary.

> printSummary(res)

A barplot of the aggregated abundance can also be plotted (4.

> abudanceBar <- plotAbundanceBar(res$aggregatedAbundance, res$Counts)

5 Conclusions

The PloGO2 package is a simple functional annotation summarizing and plotting tool.
It
provides for integration of abundance information where such information is present, and allows
easy selection of multiple categories of interest as well as allowing for many ﬁles to be analyzed
at the same time.

12

Figure 4: Aggregated abundance barplot for pathways with count >= 5

References

F. McCarthy, N. Wang, G. B. Magee, B. Nanduri, M. Lawrence, E. Camon, D. Barrell,
D. Hill, M. Dolan, W. P. Williams, D. Luthe, S. Bridges, and S. Burgess. Agbase:
a functional genomics resource for agriculture. BMC Genomics, 7(1):229, 2006. doi:
10.1186/1471-2164-7-229. URL http://www.biomedcentral.com/1471-2164/7/229.

M Mirzaei, D Pascovici, B Atwell, and P Haynes. Diﬀerential regulation of aqualporins and
small gtpases proteins in rice leaves subjected to drought stress and recovery. Under review.

Dana Pascovici, Tim Keighley, Mehdi Mirzaei, Paul A Haynes, and Brett Cooke. Plogo: Plot-
ting gene ontology annotation and abundance in multi-condition proteomics experiments.
Proteomics, 12(3):406–410, 2012.

Yunqi Wu, Mehdi Mirzaei, Dana Pascovici, Joel M Chick, Brian J Atwell, and Paul A Haynes.
Quantitative proteomic analysis of two diﬀerent rice varieties reveals that drought tolerance
is correlated with reduced abundance of photosynthetic machinery and increased abundance
of clpd1 protease. Journal of proteomics, 143:73–82, 2016.

Jia Ye, Lin Fang, Hongkun Zheng, Yong Zhang, Jie Chen, Zengjin Zhang, Jing Wang, Shengting
Li, Ruiqiang Li, Lars Bolund, and Jun Wang. Wego: a web tool for plotting go annotations.
Nucleic Acids Research, 34:W293–W297, 2006. Web Server Issue.

13

