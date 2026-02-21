goProfiles: an R package for the
Statistical Analysis of Functional Profiles

Alex Sánchez, Jordi Ocaña and Miquel Salicrú

October 30, 2025

1 Introduction

This document presents an introduction to the use of goProfiles, an R package for the analysis of lists of
genes based on their projection at a given level of the Gene Ontology following the methodology developed
by [2, 3].

2 Requirements

To use the package one must have R (2.7 or greater) installed. Bioconductor 2.2 or greater is also needed.

3 Quick start

For the impatient user the following lines provide a quick and simple example on the use of the package
to explore and compare two experimental datasets obtained from two prostate cancer experiments ([4, 1]).
Detailed explanations about the computations can be found in the following chapters and in the package
help.

The analysis proceeds as follows:

• First a dataset is loaded into memory. This dataset contains several lists of genes, from two different
studies, selected as being differentially expressed in prostate cancer. help(prostateIds) will
provide extra information about the lists of genes.

> require(goProfiles)
> data(prostateIds)

• Next a functional profile is build for each list. For simplicity it is build for the MF ontology only.

> welsh.MF <- basicProfile (welsh01EntrezIDs[1:100], onto="MF", level=2, orgPackage="org.Hs.eg.db")
> singh.MF <- basicProfile (singh01EntrezIDs[1:100], onto="MF", level=2, orgPackage="org.Hs.eg.db")
> welsh.singh.MF <-mergeProfilesLists(welsh.MF, singh.MF, profNames=c("Welsh", "Singh"))
> printProfiles(welsh.singh.MF, percentage=TRUE)

Functional Profile
==================
[1] "MF ontology"

Description

ATP-dependent activity... GO:0140657
antioxidant activity GO:0016209

23
7
5
2
catalytic activity GO:0003824
1 cytoskeletal motor activi... GO:0003774

GOID Welsh Singh
5
4.0
2
1.0
98
binding GO:0005488 100.0
39
25.3
0
1.0

1

6 electron transfer activit... GO:0009055
13 molecular adaptor activit... GO:0060090
17 molecular carrier activit... GO:0140104
15 molecular function regula... GO:0098772
20 molecular sequestering ac... GO:0140313
12 molecular transducer acti... GO:0060089
9 protein folding chaperone... GO:0044183
25 protein-containing comple... GO:0140776
3 structural molecule activ... GO:0005198
18 transcription regulator a... GO:0140110
32 translation factor activi... GO:0180051
transporter activity GO:0005215
4

0.0
16.2
2.0
20.2
3.0
6.1
0.0
0.0
22.2
8.1
0.0
7.1

1
12
0
18
2
3
3
1
11
10
2
6

> plotProfiles (welsh.MF, aTitle="Welsh (2001). Prostate cancer data")

Figure 1: Basic profile for a dataset at the second level of the MF ontology

Changing the parameter onto to ’ANY’ instead of ’MF’ will compute profiles for the three ontologies.

> welsh <- basicProfile (welsh01EntrezIDs[1:100], onto="ANY", level=2, orgPackage="org.Hs.eg.db")

• A visual comparison of profiles can be useful to give hints about the difference between them.

• Finally a numerical comparison of both profiles is performed and its summary is printed. Notice that
the comparison rebuilds the profiles, that is the input for the computation are the two lists of genes
not the profiles.

2

0204060804019902510000000162203006000002208007ATP−dependent activity...antioxidant activitycargo receptor activity...cytoskeletal motor activi...electron transfer activit...general transcription ini...membrane destabilizing ac...molecular adaptor activit...molecular function regula...molecular tag activity...molecular transducer acti...pore−forming activity...protein−containing comple...structural molecule activ...transcription regulator a...translation regulator act...Welsh (2001). Prostate cancer data. MF ontology> plotProfiles (welsh.singh.MF, percentage=T,aTitle="Welsh vs Singh", legend=T)

Figure 2: Comparison between two profiles at the second level of the MF ontology

3

SinghWelsh4.0451.0121009825.25391.0100116.16122.02020.2183.0326.063030122.22118.0810027.076020406080100ATP−dependent activity...antioxidant activitybindingcatalytic activitycytoskeletal motor activi...electron transfer activit...molecular adaptor activit...molecular carrier activit...molecular function regula...molecular sequestering ac...molecular transducer acti...protein folding chaperone...protein−containing comple...structural molecule activ...transcription regulator a...translation factor activi...transporter activityWelsh vs Singh. MF ontology> compared.welsh.singh.01.MF <- compareGeneLists (welsh01EntrezIDs[1:100], singh01EntrezIDs[1:100], onto="MF", level=2, orgPackage="org.Hs.eg.db")
> print(compSummary(compared.welsh.singh.01.MF))

Sqr.Euc.Dist
0.038261
0.95CI.up
0.083716

StdErr
0.023192

pValue
0.041864

0.95CI.low
-0.007194

• If one finds that the lists are globally different it may be interesting to check out to which categories
may be this difference attributed. Recent versions of goProfiles (from 1.11.02) allow to do a Fisher
test on every category in the level of the profile.

> list1 <- welsh01EntrezIDs[1:100]
> list2 <- singh01EntrezIDs[1:100]
> commProf <- basicProfile(intersect(list1, list2), onto="MF", level=2, orgPackage="org.Hs.eg.db")$MF
> fisherGOProfiles(welsh.MF$MF, singh.MF$MF, commProf, method="holm")

1.00000

1.00000

GO:0140657 GO:0016209 GO:0005488 GO:0003824 GO:0003774
1.00000
GO:0009055 GO:0060090 GO:0140104 GO:0098772 GO:0140313
1.00000
GO:0060089 GO:0044183 GO:0140776 GO:0005198 GO:0140110
1.00000

1.00000

1.00000

0.88432

1.00000

1.00000

1.00000

1.00000

1.00000

1.00000

1.00000
GO:0180051 GO:0005215
1.00000

1.00000

1.000000

attr(,"unadjusted")
GO:0140657 GO:0016209 GO:0005488 GO:0003824 GO:0003774
0.481865
GO:0009055 GO:0060090 GO:0140104 GO:0098772 GO:0140313
0.673394
GO:0060089 GO:0044183 GO:0140776 GO:0005198 GO:0140110
0.807751

0.498057

0.065106

0.230894

1.000000

1.000000

0.052019

0.498057

1.000000

0.533954

0.317467

0.247085
GO:0180051 GO:0005215
0.777213

0.498057

• The reason to compare two lists from similar studies may be to combine them. In this case what is

more meaningful to do is an equivalence test, instead of a difference test as above.

level=2, orgPackage="org.Hs.eg.db")

> data(prostateIds)
> expandedWelsh <- expandedProfile(welsh01EntrezIDs[1:100], onto="MF",
+
> expandedSingh <- expandedProfile(singh01EntrezIDs[1:100], onto="MF",
+
> commonGenes <- intersect(welsh01EntrezIDs[1:100], singh01EntrezIDs[1:100])
> commonExpanded <- expandedProfile(commonGenes, onto="MF", level=2, orgPackage="org.Hs.eg.db")
> equivMF <-equivalentGOProfiles (expandedWelsh[['MF']],
+
= expandedSingh[['MF']],
+
> print(equivSummary(equivMF, decs=5))

qm
pqn0= commonExpanded[['MF']])

level=2, orgPackage="org.Hs.eg.db")

Sqr.Euc.Dist
0.03826
pValue
0.42749

StdErr
0.02319
CI.up
0.07641
d0 Equivalent? (1=yes,0=not)
0.00000

0.04250

4

>

4 User guide

This introduction has simply shown the possibilities of the program. A more complete user guide can be
found at the program’s wiki in github:
https://github.com/alexsanchezpla/goProfiles/wiki

References

[1] Singh, Dinesh., William R Sellers, Philip K. Febbo, Kenneth Ross, Donald G Jackson, Judith Manola,
Christine Ladd, Pablo Tamayo, Andrew A Renshaw, Anthony V D’Amico, Jerome P Richie, Eric S
Lander, Massimo Loda, Philip W Kantoff, and Todd R Golub. Gene expression correlates of clinical
prostate cancer behavior. Cancer Cell, 1(2):203–209, 2002.

[2] A. Sánchez-Pla, M. Salicrú, and J. Ocaña. Statistical methods for the analysis of high-throughput
data based on functional profiles derived from the gene ontology. Journal of Statistical Planning and
Inference, 137(12):3975–3989, 2007.

[3] M. Salicrú, J. Ocaña and A. Sánchez-Pla. Comparison of Gene Lists based on Functional Profiles.

BMC Bioinformatics, DOI: 10.1186/1471-2105-12-401, 2011.

[4] J.B. Welsh, Lisa M. Sapinoso, Andrew I. Su, Suzanne G. Kern, Jessica Wang-Rodriguez, Christo-
pher A. Moskaluk-Jr., Henry F. Frierson, and Hampton Garret M. Analysis of gene expression iden-
tifies candidate markers and pharmacological targets in prostate cancer. Cancer Res, 61:5974–5978,
2001.

5

