Bioconductor’s SPIA package

Adi L. Tarca1,2,3, Purvesh Khatri1 and Sorin Draghici1

October 30, 2025

1Department of Computer Science, Wayne State University
2Bioinformatics and Computational Biology Unit of the NIH Perinatology Research Branch
3Center for Molecular Medicine and Genetics, Wayne State University

1 Overview

This package implements the Signaling Pathway Impact Analysis (SPIA) algorithm described in
Tarca et al. (2009), Khatri et al. (2007) and Draghici et al. (2007). SPIA uses the information from
a set of differentially expressed genes and their fold changes, as well as pathways topology in order
to assess the significance of the pathways in the condition under the study. The current version of
SPIA algorithm includes out-of-date KEGG signaling pathway data for hsa and mmu organisms for
illustration purposes. However, the current version of the package includes functionality to generate
the required up-to-date processed pathway data from KEGG xml (KGML) files that licensed users
can download for the organism of interest from KEGG’s ftp site. Also, these files can be downloaded
individualy using the Dowload KEGML button from each pathway’s web page. The pathways that
will be processed and analyzed for a given organism are those i) containing at least one relation
between genes/proteins considered by SPIA, and ii) having no reactions.
The outdated KEGG data that was preprocessed for SPIA analysis and is included for the hsa and
mmu organisms was downloaded from KEGG’s website on: 09/07/2012. For a list of changes in
SPIA compared to previous versions see the last section in this document.

2 Pathway analysis with SPIA package

This document provides basic introduction on how to use the SPIA package. For extended descrip-
tion of the methods used by this package please consult these references: Tarca et al. (2009); Khatri
et al. (2007); Draghici et al. (2007).

We demonstrate the functionality of this package using a colorectal cancer dataset obtained using
Affymetrix GeneChip technology and available through GEO (GSE4107). The experiment contains
10 normal samples and 12 colorectal cancer samples and is described by Hong et al. (2007). RMA
preprocessing of the raw data was performed using the affy package, and a two group moderated
t-test was applied using the limma package. The data frame obtained as an end result from the
function topTable in limma is used as starting point for preparing the input data for SPIA. This

1

data frame called top was made available in the colorectalcancer dataset included in the SPIA
package:

> library(SPIA)
> data(colorectalcancer)
> options(digits=3)
> head(top)

ID logFC AveExpr

10738
18604
11143 201694_s_at
10490 201041_s_at
10913 201464_x_at
11463

201289_at 5.96
209189_at 5.14
4.15
2.43
1.53
202014_at 1.43

t

P.Value adj.P.Val

B ENTREZ
3491
6.23 23.9 1.79e-17 9.78e-13 25.4
2353
7.49 17.4 1.56e-14 2.84e-10 21.0
1958
7.04e-10 20.1
7.04 16.5 5.15e-14
1843
1.41e-08 17.7
9.59 14.1 1.29e-12
8.22 11.0 1.69e-10
3725
1.15e-06 13.6
5.33 10.5 4.27e-10 2.42e-06 12.8 23645

For SPIA to work, we need a vector with log2 fold changes between the two groups for all the genes
considered to be differentially expressed. The names of this vector must be Entrez gene IDs. The
following lines will add one additional column in the top data frame annotating each affymetrix
probeset to an Entrez ID. Since there may be several probesets for the same Entrez ID, there are two
easy ways to obtain one log fold change per gene. The first option is to use the fold change of the
most significant probeset for each gene, while the second option is to average the log fold-changes
of all probestes of the same gene. In the example below we used the former approach. The genes in
this example are called differentially expressed provided that their FDR adjusted p-values (q-values)
are less than 0.05. The following lines start with the top data frame and produce two vectors that
are required as input by spia function:

> library(hgu133plus2.db)
> x <- hgu133plus2ENTREZID
> top$ENTREZ<-unlist(as.list(x[top$ID]))
> top<-top[!is.na(top$ENTREZ),]
> top<-top[!duplicated(top$ENTREZ),]
> tg1<-top[top$adj.P.Val<0.1,]
> DE_Colorectal=tg1$logFC
> names(DE_Colorectal)<-as.vector(tg1$ENTREZ)
> ALL_Colorectal=top$ENTREZ

The DE_Colorectal is a vector containing the log2 fold changes of the genes found to be differentially
expressed between cancer and normal samples, and ALL_Colorectal is a vector with the Entrez
IDs of all genes profiled on the microarray. The names of the DE_Colorectal are the Entrez gene
IDs corresponding to the computed log fold-changes.

> DE_Colorectal[1:10]

3491
5.96

2353 1958 1843
5.14 4.15 2.43

3725 23645 9510 84869
1.53 1.43 3.94 -1.15

7432
1490
4.72 3.45

2

> ALL_Colorectal[1:10]

[1] "3491"
[10] "1490"

"2353" "1958" "1843"

"3725"

"23645" "9510"

"84869" "7432"

The SPIA algorithm takes as input the two vectors above and produces a table of pathways ranked
from the most to the least significant. This can be achieved by calling the spia function as follows:

> # pathway analysis based on combined evidence; # use nB=2000 or more for more accurate results
> res=spia(de=DE_Colorectal,all=ALL_Colorectal,organism="hsa",nB=2000,plots=FALSE,beta=NULL,combine="fisher",verbose=FALSE)
> #make the output fit this screen
> res$Name=substr(res$Name,1,10)
> #show first 15 pathways, omit KEGG links
> res[1:20,-12]

Name
Focal adhe 04510
1
Alzheimer' 05010
2
ECM-recept 04512
3
Parkinson' 05012
4
PPAR signa 03320
5
Pathways i 05200
6
Axon guida 04360
7
Huntington 05016
8
9
Fc gamma R 04666
10 Regulation 04810
11 MAPK signa 04010
12 Small cell 05222
13 Glutamater 04724
14 Bacterial
05100
15 Pathogenic 05130
16 Renal cell 05211
17 Wnt signal 04310
18 Transcript 05202
Malaria 05144
19
20 ErbB signa 04012

ID pSize NDE
177
148 84 1.03e-10

74

tA

pG

pNDE

pPERT

65 37 1.56e-05
295 123 8.33e-05
119
167
80

pGFdr
88 1.99e-07 100.6448 0.000005 2.85e-11 3.90e-09
-5.6547 0.228000 5.97e-10 2.73e-08
42 4.69e-06 26.0618 0.000005 5.98e-10 2.73e-08
109 64 2.62e-09 -11.1299 0.060000 3.71e-09 1.27e-07
-3.0516 0.039000 9.31e-06 2.55e-04
68.6673 0.009000 1.13e-05 2.59e-04
59 2.14e-05 11.8109 0.141000 4.14e-05 8.11e-04
-3.0780 0.220000 5.48e-05 9.39e-04
78 1.86e-05
42 5.99e-05 -11.0240 0.199000 1.47e-04 2.24e-03
15.6643 0.248000 2.64e-04 3.62e-03
10.7104 0.152000 3.46e-04 4.28e-03
33 8.28e-03 26.3360 0.004000 3.75e-04 4.28e-03
112 44 4.25e-02 -11.5403 0.005000 2.01e-03 2.12e-02
2.5179 0.846000 4.67e-03 4.57e-02
32 6.48e-04
62
17.4147 0.022000 5.15e-03 4.70e-02
21 2.79e-02
46
28 8.61e-03 -8.0807 0.089000 6.26e-03 5.36e-02
60
-6.5886 0.318000 6.67e-03 5.37e-02
135
58 2.59e-03
149 61 7.45e-03
-1.1845 0.164000 9.41e-03 7.03e-02
0.0625 0.982000 9.75e-03 7.03e-02
23 1.29e-03
34 8.99e-03 -17.4329 0.154000 1.05e-02 7.19e-02

192 85 9.12e-05
242 102 2.00e-04

42
76

73

pGFWER

Status
3.90e-09 Activated
8.18e-08 Inhibited
8.19e-08 Activated
5.08e-07 Inhibited
1.28e-03 Inhibited
1.55e-03 Activated
5.68e-03 Activated
7.51e-03 Inhibited
2.01e-02 Inhibited

1
2
3
4
5
6
7
8
9

3

10 3.62e-02 Activated
11 4.75e-02 Activated
12 5.13e-02 Activated
13 2.75e-01 Inhibited
14 6.39e-01 Activated
15 7.06e-01 Activated
16 8.58e-01 Inhibited
17 9.13e-01 Inhibited
18 1.00e+00 Inhibited
19 1.00e+00 Activated
20 1.00e+00 Inhibited

If the plots argument is set to TRUE in the function call above, a plot like the one shown in Figure
1 is produced for each pathway on which there are differentially expressed genes. These plots are
saved in a pdf file in the current directory.
An overall picture of the pathways significance according to both the over-representation evidence
and perturbations based evidence can be obtained with the function plotP and shown in Figure 2.
The Colorectal cancer pathway is shown in green.
In this plot, the horizontal axis represents the p-value (minus log of) corresponding to the probabil-
ity of obtaining at least the observed number of genes (NDE) on the given pathway just by chance.
The vertical axis represents the p-value (minus log of) corresponding to the probability of obtaining
the observed total accumulation (tA) or more extreme on the given pathway just by chance. The
computation of pPERT is described in Tarca et al. (2009). In Figure 2 each pathway is shown as a
bullet point, and those significant at 5% (set by the threshold argument in plotP) after Bonferroni
correction are shown in red.

The default method to combine pPERT and pNDE is Fisher’s product method, as was described
in Tarca et al. (2009).
Alternatively, the two types of evidence can be combined using a normal inversion method which
gives smaller pG values when pPERT and pNDE are low simultaneously. This is in contrast with
Fisher’s method that may yield small pG values when only one of the two p-values is low. To use the
normal inversion method, one can set the argument combine="norminv" when the spia function is
called, or by recomputing pG values starting with a result data frame produced by spia function.
This latter approach is illustrated below where a call is made to the function combfunc.
SPIA algorithm is illustrated also using the Vessels dataset:

> data(Vessels)
> # pathway analysis based on combined evidence; # use nB=2000 or more for more accurate results
> res<-spia(de=DE_Vessels,all=ALL_Vessels,organism="hsa",nB=500,plots=FALSE,beta=NULL,verbose=FALSE)
> #make the output fit this screen
> res$Name=substr(res$Name,1,10)
> #show first 15 pathways, omit KEGG links
> res[1:15,-12]

Name
Axon guida 04360

ID pSize NDE
128

pGFdr pGFWER
12 2.08e-04 -6.724 0.056 0.000144 0.0180 0.0180

tA pPERT

pNDE

pG

1

4

Figure 1: Perturbations plot for colorectal cancer pathway (KEGG ID hsa:05210) using the
colorectalcancer dataset. The perturbation of all genes in the pathway are shown as a func-
tion of their initial log2 fold changes (left panel). Non DE genes are assigned 0 log2 fold-change.
The null distribution of the net accumulated perturbations is also given (right panel). The observed
net accumulation tA with the real data is shown as a red vertical line.

5

> plotP(res,threshold=0.05)
> points(I(-log(pPERT))~I(-log(pNDE)),data=res[res$ID=="05210",],col="green",pch=19,cex=1.5)
>

Figure 2: SPIA evidence plot for the colorectal cancer dataset. Each pathway is represented by one
dot. The pathways at the right of the red oblique line are significant after Bonferroni correction of
the global p-values, pG, obtained by combining the pPERT and pNDE using Fisher’s method. The
pathways at the right of the blue oblique line are significant after a FDR correction of the global
p-values, pG.

6

05101502468101214SPIA two−way evidence plot−log(P NDE)−log(P PERT)0451005010045120501203320052000436005016046660481004010045100501004512050120332005200043600501604666048100401005222047240510005130|||> res$pG=combfunc(res$pNDE,res$pPERT,combine="norminv")
> res$pGFdr=p.adjust(res$pG,"fdr")
> res$pGFWER=p.adjust(res$pG,"bonferroni")
> plotP(res,threshold=0.05)
> points(I(-log(pPERT))~I(-log(pNDE)),data=res[res$ID=="05210",],col="green",pch=19,cex=1.5)
>

Figure 3: SPIA evidence plot for the colorectal cancer dataset. Each pathway is represented by
one dot. The pathways at the right of the red curve are significant after Bonferroni correction of
the global p-values, pG, obtained by combining the pPERT and pNDE using the normal inversion
method. The pathways at the right of the blue curve line are significant after a FDR correction of
the global p-values, pG.

7

05101502468101214SPIA two−way evidence plot−log(P NDE)−log(P PERT)045100501004512050120332005200043600501605222045100501004512050120332005200043600501604666048100401005222047240513005211|||51
200
209
89
69
46
272
258
75
68
46
40
67
42

8 6.74e-05

1.992 0.552 0.000417 0.0193 0.0521
16 1.31e-04 -6.080 0.320 0.000463 0.0193 0.0579
15 6.66e-04
7.828 0.116 0.000809 0.0253 0.1011
10 1.59e-04 0.000 1.000 0.001547 0.0323 0.1933
8 5.76e-04 -1.666 0.276 0.001550 0.0323 0.1937
0.000 1.000 0.002193 0.0344 0.2741
7 2.34e-04
18 5.35e-04 -0.510 0.452 0.002255 0.0344 0.2819
18 2.84e-04 -0.246 0.944 0.002476 0.0344 0.3095
1.492 0.092 0.003570 0.0446 0.4462
7 4.40e-03
8 5.22e-04 0.147 0.952 0.004274 0.0486 0.5342
4 3.66e-02
7.432 0.016 0.004944 0.0515 0.6181
6 7.10e-04 0.000 1.000 0.005859 0.0563 0.7324
7 2.33e-03 4.517 0.352 0.006636 0.0591 0.8295
0.000 1.000 0.007400 0.0591 0.9250
6 9.27e-04

Staphyloco 05150
2
Focal adhe 04510
3
Regulation 04810
4
Rheumatoid 05323
5
Viral myoc 05416
6
Intestinal 04672
7
Neuroactiv 04080
8
9
HTLV-I inf 05166
10 Antigen pr 04612
11 Leishmania 05140
12 Notch sign 04330
13 Graft-vers 05332
14 Complement 04610
15 Type I dia 04940
Status
Inhibited
1
Activated
2
Inhibited
3
Activated
4
Inhibited
5
Inhibited
6
Inhibited
7
Inhibited
8
9
Inhibited
10 Activated
11 Activated
12 Activated
13 Inhibited
14 Activated
15 Inhibited

The pathway image as provided by KEGG having the differentially expressed genes highlighted in
red can be obtained by pasting in a web browser the links available in the KEGGLINK column of
the data frame produced by the function spia. For example,

> res[,"KEGGLINK"][20]

[1] "http://www.genome.jp/dbget-bin/show_pathway?hsa05330+3108+3109+3111+3113+3122"

is the link that would display the image of the 20th pathway in the res dataframe above.
Note that the results for these datasets my differ from the ones described in Tarca et al. (2009) since
a) the pathways database used herein was updated and b) the default beta values were changed.
The directed adjacency matrices of the graphs describing the different types of relations between
genes/proteins (such as activation or repression) used by SPIA are available in the extdata/hsaSPIA.RData
file for the homo sapiens organism. The types of relations considered by SPIA and the default weight
(beta coefficient) given to them are:

8

rel<-c("activation","compound","binding/association","expression","inhibition",

>
+ "activation_phosphorylation","phosphorylation","inhibition_phosphorylation",
+ "inhibition_dephosphorylation","dissociation","dephosphorylation",
+ "activation_dephosphorylation","state change","activation_indirect effect",
+ "inhibition_ubiquination","ubiquination", "expression_indirect effect",
+ "inhibition_indirect effect","repression","dissociation_phosphorylation",
+ "indirect effect_phosphorylation","activation_binding/association",
+ "indirect effect","activation_compound","activation_ubiquination")
> beta=c(1,0,0,1,-1,1,0,-1,-1,0,0,1,0,1,-1,0,1,-1,-1,0,0,1,0,1,1)
> names(beta)<-rel
> cbind(beta)

activation
compound
binding/association
expression
inhibition
activation_phosphorylation
phosphorylation
inhibition_phosphorylation
inhibition_dephosphorylation
dissociation
dephosphorylation
activation_dephosphorylation
state change
activation_indirect effect
inhibition_ubiquination
ubiquination
expression_indirect effect
inhibition_indirect effect
repression
dissociation_phosphorylation
indirect effect_phosphorylation
activation_binding/association
indirect effect
activation_compound
activation_ubiquination

beta
1
0
0
1
-1
1
0
-1
-1
0
0
1
0
1
-1
0
1
-1
-1
0
0
1
0
1
1

A 0 value for a given relation type results in discarding those type of relations from the analysis for
all pathways. The default values of beta can changed by the user at any time by setting the beta
argument of the spia function call.
The user has the ability to generate his own gene/protein relation data and put it in a list format
as the one shown in the hsaSPIA.RData file. In this file, each pathway data is included in a list:

> load(file=paste(system.file("extdata/hsaSPIA.RData",package="SPIA")))
> names(path.info[["05210"]])

9

[1] "activation"
[3] "binding/association"
[5] "inhibition"
[7] "phosphorylation"
[9] "inhibition_dephosphorylation"

"compound"
"expression"
"activation_phosphorylation"
"inhibition_phosphorylation"
"dissociation"
"activation_dephosphorylation"
"activation_indirect effect"
"ubiquination"
"inhibition_indirect effect"
"dissociation_phosphorylation"

[11] "dephosphorylation"
[13] "state change"
[15] "inhibition_ubiquination"
[17] "expression_indirect effect"
[19] "repression"
[21] "indirect effect_phosphorylation" "activation_binding/association"
[23] "indirect effect"
[25] "activation_ubiquination"
[27] "title"

"activation_compound"
"nodes"
"NumberOfReactions"

> path.info[["05210"]][["activation"]][25:35,30:40]

5602 8312 8313 5900 387 5879 5880 5881 332 4609 595
0
0
0
0
0
0
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
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0

0
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

0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0

369
5894
673
5599
5601
5602
8312
8313
5900
387
5879

In the matrix above, only 0 and 1 values are allowed. 1 means the gene/protein given by the column
has a relation of type "activation" with the gene/protein given by the row of the matrix.
Using other R packages such as graph and Rgraphviz one can visualize the richness of gene/protein
relations of each type in each pathway. Firstly we load the required packages and create a function
that can be used to plot as a graph each type of relation of any pathway, as used by SPIA.

> library(graph)
> library(Rgraphviz)
> plotG<-function(B){
+
+
+
+
+
+
+

nnms<-NULL;colls<-NULL
mynodes<-colnames(B)
L<-list();
n<-dim(B)[1]
for (i in 1:n){
L[i]<-list(edges=rownames(B)[abs(B[,i])>0])
if(sum(B[,i]!=0)>0){

10

nnms<-c(nnms,paste(colnames(B)[i],rownames(B)[B[,i]!=0],sep="~"))
}
}
names(L)<-rownames(B)
g<-new("graphNEL",nodes=mynodes,edgeL=L,edgemode="directed")
plot(g)

+
+
+
+
+
+
+ }
>

We plot then the "activation" relations in the ErbB signaling pathway, based on the hsaSPIA data.

> plotG(path.info[["04012"]][["activation"]])

Figure 4: Display of the "activation" relations in the ErbB signaling pathway, based on the hsaSPIA
data.

11

288520022066206567766777206419562932197861986199102610272475102985058506250635692457144469084405722549703956096416236248678681071895425599560156021398139957476654665525759399694533586464557855795582815816817818533553361839308420696853725252723533529052915293529452955296850310000207208671414595746093747277381950559455955604560536958946733265384548933 Parsing up-to-date KEGG xml files for use with SPIA

Here we assume that the user obtained the KGML (xml) files for all pathways of interest for a
given organism from the KEGG ftp site (or downloaded them one by one from the KEGG web
site). As an example we included four such files in the extdata/keggxml/hsa folder of the SPIA
package installation to demontsrae how to parse these files and run SPIA on the resuting collection
of pathways.

> mydir=system.file("extdata/keggxml/hsa",package="SPIA")
> dir(mydir)

[1] "hsa03013.xml" "hsa03050.xml" "hsa04914.xml" "hsa05210.xml"

> makeSPIAdata(kgml.path=mydir,organism="hsa",out.path="./")

[1] TRUE

> res<-spia(de=DE_Colorectal, all=ALL_Colorectal, organism="hsa",data.dir="./")

Done pathway 1 : RNA transport..
Done pathway 2 : Progesterone-mediated oocyte m..
Done pathway 3 : Colorectal cancer..

> res[,-12]

Name

1
Colorectal cancer 05210
2 Progesterone-mediated oocyte maturation 04914
RNA transport 03013
3

pG

Status
pGFdr pGFWER
1 0.0143 0.0429 0.0429 Activated
2 0.2704 0.4057 0.8113 Activated
3 0.9999 0.9999 1.0000 Inhibited

ID pSize NDE

pNDE

tA pPERT
56 23 0.076 8.48 0.026
29 0.119 2.31 0.632
76
136 31 0.989 0.00 1.000

For more details on how to use the main function in this package use "?spia".
A commercial version of SPIA called PathwayGuide that includes additional capabilites in terms of
visualisation, speed and and user interface is available from http://www.advaitabio.com/.

4 Changes in SPIA 2.10 vs 2.9

The current version (2.10) contains the following changes compared to the previous version (2.9):
A function makeSPIAdata was added that generates xxxSPIA.RData files from KGML (xml) files
provided by the user. The package will not contain anymore up-to-date KEGG pathway data since
the access to the KEGG ftp server requires a license.

12

References

S. Draghici, P. Khatri, A. Tarca, K. Amin, A. Done, C. Voichita, C. Georgescu, and R. Romero. A

systems biology approach for pathway level analysis. Genome Research, 17, 2007.

Y. Hong, K. S. Ho, K. W. Eu, and P. Y. Cheah. A susceptibility gene set for early onset colorectal
implication for tumorigenesis. Clin Cancer

cancer that integrates diverse signaling pathways:
Res, 13(4):1107–14, 2007.

P. Khatri, S. Draghici, A. L. Tarca, S. S. Hassan, and R. Romero. A system biology approach for
the steady-state analysis of gene signaling networks. In 12th Iberoamerican Congress on Pattern
Recognition, Valparaiso, Chile, November 13-16 2007.

A. L. Tarca, S. Draghici, P. Khatri, S. Hassan, P. Mital, J. Kim, C. Kim, J. P. Kusanovic, and
R. Romero. A signaling pathway impact analysis for microarray experiments. Bioinformatics, 25:
75–82, 2009.

13

