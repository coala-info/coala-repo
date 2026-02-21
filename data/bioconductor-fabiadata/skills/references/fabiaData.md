Software Manual

Institute of Bioinformatics, Johannes Kepler University Linz

fabiaData (Gene Expression Data Sets for
Biclustering)
— Manual for the R package —

Sepp Hochreiter

Institute of Bioinformatics, Johannes Kepler University Linz
Altenberger Str. 69, 4040 Linz, Austria
hochreit@bioinf.jku.at

Version 1.48.0, November 4, 2025

Institute of Bioinformatics
Johannes Kepler University Linz
A-4040 Linz, Austria

Tel. +43 732 2468 8880
Fax +43 732 2468 9511
http://www.bioinf.jku.at

2

Contents

1

Introduction

2 Getting Started: fabiaData

3 Data Sets

3.1 Breast_A .
3.2 DLBCL_B .
.
3.3 Multi_A .

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Demos

Contents

3

3

4
4
4
4

5

1 Introduction

1 Introduction

3

The fabiaData package is part of the Bioconductor (http://www.bioconductor.org) project. The
package provides gene expression data sets for biclustering demos in the R package fabia. It is
automatically loaded by fabia when needed.

The package fabia allows to extract biclusters from data sets based on a generative model
according to the FABIA method (Hochreiter et al., 2010). It has been designed especially for
microarray data sets, but can be used for other kinds of data sets as well.

Please

visit

for

additional

information

the

FABIA

homepage

http://www.bioinf.jku.at/software/fabia/fabia.html.

2 Getting Started: fabiaData

First load the fabia package:

R> library(fabia)

Then load the fabiaData package

R> library(fabiaData)

Now biclusters can be extracted from these data sets in the fabia demos:

R> fabiaDemo()

1. demo2: Microarray data set of (van’t Veer et al., 2002) on breast cancer.

R> fabiaDemo()

Choose “2” to extract subclasses in the data set of van’t Veer as biclusters.

2. demo3: Microarray data set of (Su et al., 2002) on different mammalian.

R> fabiaDemo()

Choose “3” to check whether the different mouse and human tissue types can be extracted.

3. demo4: Microarray data set of (Rosenwald et al., 2002) diffuse large-B-cell lymphoma.

(Hoshida et al., 2007) divided the data set into three classes

OxPhos: oxidative phosphorylation

BCR: B-cell response

HR: host response

R> fabiaDemo()

Choose “4” to check whether the different classes can be extracted.

4

3 Data Sets

3.1 Breast_A

3 Data Sets

Microarray data set of van’t Veer breast cancer.

Microarray data from Broad Institute “Cancer Program Data Sets” which was produced by
(van’t Veer et al., 2002) (http://www.broadinstitute.org/cgi-bin/cancer/datasets.
cgi) Array S54 was removed because it is an outlier.

Goal was to find a gene signature to predict the outcome of a cancer therapy that is to predict

whether metastasis will occur. A 70 gene signature has been discovered.

Here we want to find subclasses in the data set.

(Hoshida et al., 2007) found 3 subclasses and verified that 50/61 cases from class 1 and 2 were

ER positive and only in 3/36 from class 3.

XBreast is the data set with 97 samples and 1213 genes, CBreast give the three subclasses

from (Hoshida et al., 2007).

3.2 DLBCL_B

Microarray data set of Rosenwald diffuse large-B-cell lymphoma.

Microarray data from Broad Institute “Cancer Program Data Sets” which was produced by
(Rosenwald et al., 2002) (http://www.broadinstitute.org/cgi-bin/cancer/datasets.
cgi)

Goal was to predict the survival after chemotherapy

(Hoshida et al., 2007) divided the data set into three classes:

OxPhos: oxidative phosphorylation

BCR: B-cell response

HR: host response

We want to identify these subclasses.

The data has 180 samples and 661 probe sets (genes).

XDLBCL is the data set with 180 samples and 661 genes, CDLBCL give the three subclasses from

(Hoshida et al., 2007).

3.3 Multi_A

Microarray data set of Su on different mammalian tissue types.

Microarray data from Broad Institute “Cancer Program Data Sets” which was produced by (Su

et al., 2002) (http://www.broadinstitute.org/cgi-bin/cancer/datasets.cgi)

4 Demos

5

Gene expression from human and mouse samples across a diverse array of tissues, organs,
and cell lines have been profiled. The goal was to have a reference for the normal mammalian
transcriptome.

Here we want to identify the subclasses which correspond to the tissue types.

The data has 102 samples and 5565 probe sets (genes).

XMulti is the data set with 102 samples and 5565 genes, CMulti give the four subclasses

corresponding to the tissue types.

4 Demos

library(fabiaData)

#------------------------------------------
###########################################
# fabia Demos
###########################################
#------------------------------------------

#------------------------------------------
# DEMO1: Laura van't Veer's gene expression
#
data set for breast cancer
#------------------------------------------

avail <- require(fabia)

if (!avail) {

message("")
message("")
message("#####################################################")
message("Package 'fabia' is not available: please install.")
message("#####################################################")

} else {

data(Breast_A)

X <- as.matrix(XBreast)

resBreast1 <- fabia(X,5,0.1,400,1.0,1.0)

rBreast1 <- extractPlot(resBreast1,ti="FABIA Breast cancer(Veer)")

6

4 Demos

raBreast1 <- extractBic(resBreast1)

if ((raBreast1$bic[[1]][1]>1) && (raBreast1$bic[[1]][2])>1) {

plotBicluster(raBreast1,1)

}
if ((raBreast1$bic[[2]][1]>1) && (raBreast1$bic[[2]][2])>1) {

plotBicluster(raBreast1,2)

}
if ((raBreast1$bic[[3]][1]>1) && (raBreast1$bic[[3]][2])>1) {

plotBicluster(raBreast1,3)

}
if ((raBreast1$bic[[4]][1]>1) && (raBreast1$bic[[4]][2])>1) {

plotBicluster(raBreast1,4)

}

plot(resBreast1,dim=c(1,2),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast1,dim=c(1,3),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast1,dim=c(1,4),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast1,dim=c(1,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast1,dim=c(2,3),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast1,dim=c(2,4),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast1,dim=c(2,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast1,dim=c(3,4),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast1,dim=c(3,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast1,dim=c(4,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)

}

#-----------------------------------
# DEMO2: Su's multiple tissue types
#
#-----------------------------------

gene expression data set

avail <- require(fabia)

if (!avail) {

message("")
message("")
message("#####################################################")
message("Package 'fabia' is not available: please install.")
message("#####################################################")

} else {

4 Demos

7

data(Multi_A)

X <- as.matrix(XMulti)

resMulti1 <- fabia(X,5,0.1,300,1.0,1.0)

rMulti1 <- extractPlot(resMulti1,ti="FABIA Multiple tissues(Su)")

raMulti1 <- extractBic(resMulti1)

if ((raMulti1$bic[[1]][1]>1) && (raMulti1$bic[[1]][2])>1) {

plotBicluster(raMulti1,1)

}
if ((raMulti1$bic[[2]][1]>1) && (raMulti1$bic[[2]][2])>1) {

plotBicluster(raMulti1,2)

}
if ((raMulti1$bic[[3]][1]>1) && (raMulti1$bic[[3]][2])>1) {

plotBicluster(raMulti1,3)

}
if ((raMulti1$bic[[4]][1]>1) && (raMulti1$bic[[4]][2])>1) {

plotBicluster(raMulti1,4)

}

plot(resMulti1,dim=c(1,2),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti1,dim=c(1,3),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti1,dim=c(1,4),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti1,dim=c(1,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti1,dim=c(2,3),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti1,dim=c(2,4),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti1,dim=c(2,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti1,dim=c(3,4),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti1,dim=c(3,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti1,dim=c(4,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)

}

#-----------------------------------------
# DEMO3: Rosenwald's diffuse large-B-cell
lymphoma gene expression data set
#
#-----------------------------------------

avail <- require(fabia)

8

if (!avail) {

4 Demos

message("")
message("")
message("#####################################################")
message("Package 'fabia' is not available: please install.")
message("#####################################################")

} else {

data(DLBCL_B)

X <- as.matrix(XDLBCL)

resDLBCL1 <- fabia(X,5,0.1,400,1.0,1.0)

rDLBCL1 <- extractPlot(resDLBCL1,ti="FABIA Lymphoma(Rosenwald)")

raDLBCL1 <- extractBic(resDLBCL1)

if ((raDLBCL1$bic[[1]][1]>1) && (raDLBCL1$bic[[1]][2])>1) {

plotBicluster(raDLBCL1,1)

}
if ((raDLBCL1$bic[[2]][1]>1) && (raDLBCL1$bic[[2]][2])>1) {

plotBicluster(raDLBCL1,2)

}
if ((raDLBCL1$bic[[3]][1]>1) && (raDLBCL1$bic[[3]][2])>1) {

plotBicluster(raDLBCL1,3)

}
if ((raDLBCL1$bic[[4]][1]>1) && (raDLBCL1$bic[[4]][2])>1) {

plotBicluster(raDLBCL1,4)

}

plot(resDLBCL1,dim=c(1,2),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL1,dim=c(1,3),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL1,dim=c(1,4),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL1,dim=c(1,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL1,dim=c(2,3),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL1,dim=c(2,4),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL1,dim=c(2,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL1,dim=c(3,4),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL1,dim=c(3,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL1,dim=c(4,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)

}

#------------------------------------------

4 Demos

9

###########################################
# fabias Demos
###########################################
#------------------------------------------

#------------------------------------------
# DEMO1: Laura van't Veer's gene expression
#
data set for breast cancer
#------------------------------------------

avail <- require(fabia)

if (!avail) {

message("")
message("")
message("#####################################################")
message("Package 'fabia' is not available: please install.")
message("#####################################################")

} else {

data(Breast_A)

X <- as.matrix(XBreast)

resBreast2 <- fabias(X,5,0.6,300,1.0)

rBreast2 <- extractPlot(resBreast2,ti="FABIAS Breast cancer(Veer)")

raBreast2 <- extractBic(resBreast2)

if ((raBreast2$bic[[1]][1]>1) && (raBreast2$bic[[1]][2])>1) {

plotBicluster(raBreast2,1)

}
if ((raBreast2$bic[[2]][1]>1) && (raBreast2$bic[[2]][2])>1) {

plotBicluster(raBreast2,2)

}
if ((raBreast2$bic[[3]][1]>1) && (raBreast2$bic[[3]][2])>1) {

plotBicluster(raBreast2,3)

}
if ((raBreast2$bic[[4]][1]>1) && (raBreast2$bic[[4]][2])>1) {

plotBicluster(raBreast2,4)

}

plot(resBreast2,dim=c(1,2),label.tol=0.03,col.group=CBreast,lab.size=0.6)

10

4 Demos

plot(resBreast2,dim=c(1,3),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast2,dim=c(1,4),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast2,dim=c(1,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast2,dim=c(2,3),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast2,dim=c(2,4),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast2,dim=c(2,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast2,dim=c(3,4),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast2,dim=c(3,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast2,dim=c(4,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)

}

#-----------------------------------
# DEMO2: Su's multiple tisse types
#
#-----------------------------------

gene expression data set

avail <- require(fabia)

if (!avail) {

message("")
message("")
message("#####################################################")
message("Package 'fabia' is not available: please install.")
message("#####################################################")

} else {

data(Multi_A)

X <- as.matrix(XMulti)

resMulti2 <- fabias(X,5,0.6,300,1.0)

rMulti2 <- extractPlot(resMulti2,ti="FABIAS Multiple tissues(Su)")

raMulti2 <- extractBic(resMulti2)

if ((raMulti2$bic[[1]][1]>1) && (raMulti2$bic[[1]][2])>1) {

plotBicluster(raMulti2,1)

}
if ((raMulti2$bic[[2]][1]>1) && (raMulti2$bic[[2]][2])>1) {

plotBicluster(raMulti2,2)

}
if ((raMulti2$bic[[3]][1]>1) && (raMulti2$bic[[3]][2])>1) {

plotBicluster(raMulti2,3)

4 Demos

11

}
if ((raMulti2$bic[[4]][1]>1) && (raMulti2$bic[[4]][2])>1) {

plotBicluster(raMulti2,4)

}

plot(resMulti2,dim=c(1,2),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti2,dim=c(1,3),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti2,dim=c(1,4),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti2,dim=c(1,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti2,dim=c(2,3),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti2,dim=c(2,4),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti2,dim=c(2,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti2,dim=c(3,4),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti2,dim=c(3,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti2,dim=c(4,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)

}

#-----------------------------------------
# DEMO3: Rosenwald's diffuse large-B-cell
#
lymphoma gene expression data set
#-----------------------------------------

avail <- require(fabia)

if (!avail) {

message("")
message("")
message("#####################################################")
message("Package 'fabia' is not available: please install.")
message("#####################################################")

} else {

data(DLBCL_B)

X <- as.matrix(XDLBCL)

resDLBCL2 <- fabias(X,5,0.6,300,1.0)

rDLBCL2 <- extractPlot(resDLBCL2,ti="FABIAS Lymphoma(Rosenwald)")

raDLBCL2 <- extractBic(resDLBCL2)

if ((raDLBCL2$bic[[1]][1]>1) && (raDLBCL2$bic[[1]][2])>1) {

plotBicluster(raDLBCL2,1)

12

4 Demos

}
if ((raDLBCL2$bic[[2]][1]>1) && (raDLBCL2$bic[[2]][2])>1) {

plotBicluster(raDLBCL2,2)

}
if ((raDLBCL2$bic[[3]][1]>1) && (raDLBCL2$bic[[3]][2])>1) {

plotBicluster(raDLBCL2,3)

}
if ((raDLBCL2$bic[[4]][1]>1) && (raDLBCL2$bic[[4]][2])>1) {

plotBicluster(raDLBCL2,4)

}

plot(resDLBCL2,dim=c(1,2),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL2,dim=c(1,3),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL2,dim=c(1,4),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL2,dim=c(1,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL2,dim=c(2,3),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL2,dim=c(2,4),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL2,dim=c(2,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL2,dim=c(3,4),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL2,dim=c(3,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL2,dim=c(4,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)

}

#------------------------------------------
###########################################
# MFSC Demos
###########################################
#------------------------------------------

#------------------------------------------
# DEMO1: Laura van't Veer's gene expression
#
data set for breast cancer
#------------------------------------------

avail <- require(fabia)

if (!avail) {

message("")
message("")
message("#####################################################")

4 Demos

13

message("Package 'fabia' is not available: please install.")
message("#####################################################")

} else {

data(Breast_A)

X <- as.matrix(XBreast)

resBreast4 <- mfsc(X,5,100,0.6,0.6)

rBreast4 <- extractPlot(resBreast4,ti="MFSC Breast cancer(Veer)")

raBreast4 <- extractBic(resBreast4,thresZ=0.01,thresL=0.05)

if ((raBreast4$bic[[1]][1]>1) && (raBreast4$bic[[1]][2])>1) {

plotBicluster(raBreast4,1)

}
if ((raBreast4$bic[[2]][1]>1) && (raBreast4$bic[[2]][2])>1) {

plotBicluster(raBreast4,2)

}
if ((raBreast4$bic[[3]][1]>1) && (raBreast4$bic[[3]][2])>1) {

plotBicluster(raBreast4,3)

}
if ((raBreast4$bic[[4]][1]>1) && (raBreast4$bic[[4]][2])>1) {

plotBicluster(raBreast4,4)

}

plot(resBreast4,dim=c(1,2),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast4,dim=c(1,3),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast4,dim=c(1,4),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast4,dim=c(1,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast4,dim=c(2,3),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast4,dim=c(2,4),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast4,dim=c(2,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast4,dim=c(3,4),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast4,dim=c(3,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)
plot(resBreast4,dim=c(4,5),label.tol=0.03,col.group=CBreast,lab.size=0.6)

}

#-----------------------------------
# DEMO2: Su's multiple tissue types
#
#-----------------------------------

gene expression data set

14

4 Demos

avail <- require(fabia)

if (!avail) {

message("")
message("")
message("#####################################################")
message("Package 'fabia' is not available: please install.")
message("#####################################################")

} else {

data(Multi_A)

X <- as.matrix(XMulti)

resMulti4 <- mfsc(X,5,100,0.6,0.6)

rMulti4 <- extractPlot(resMulti4,ti="MFSC Multiple tissues(Su)")

raMulti4 <- extractBic(resMulti4,thresZ=0.01,thresL=0.05)

if ((raMulti4$bic[[1]][1]>1) && (raMulti4$bic[[1]][2])>1) {

plotBicluster(raMulti4,1)

}
if ((raMulti4$bic[[2]][1]>1) && (raMulti4$bic[[2]][2])>1) {

plotBicluster(raMulti4,2)

}
if ((raMulti4$bic[[3]][1]>1) && (raMulti4$bic[[3]][2])>1) {

plotBicluster(raMulti4,3)

}
if ((raMulti4$bic[[4]][1]>1) && (raMulti4$bic[[4]][2])>1) {

plotBicluster(raMulti4,4)

}

plot(resMulti4,dim=c(1,2),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti4,dim=c(1,3),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti4,dim=c(1,4),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti4,dim=c(1,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti4,dim=c(2,3),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti4,dim=c(2,4),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti4,dim=c(2,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti4,dim=c(3,4),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti4,dim=c(3,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)
plot(resMulti4,dim=c(4,5),label.tol=0.01,col.group=CMulti,lab.size=0.6)

15

4 Demos

}

#-----------------------------------------
# DEMO3: Rosenwald's diffuse large-B-cell
#
lymphoma gene expression data set
#-----------------------------------------

avail <- require(fabia)

if (!avail) {

message("")
message("")
message("#####################################################")
message("Package 'fabia' is not available: please install.")
message("#####################################################")

} else {

data(DLBCL_B)

X <- as.matrix(XDLBCL)

resDLBCL4 <- mfsc(X,5,100,0.6,0.6)

rDLBCL4 <- extractPlot(resDLBCL4,ti="MFSC Lymphoma(Rosenwald)")

raDLBCL4 <- extractBic(resDLBCL4,thresZ=0.01,thresL=0.05)

if ((raDLBCL4$bic[[1]][1]>1) && (raDLBCL4$bic[[1]][2])>1) {

plotBicluster(raDLBCL4,1)

}
if ((raDLBCL4$bic[[2]][1]>1) && (raDLBCL4$bic[[2]][2])>1) {

plotBicluster(raDLBCL4,2)

}
if ((raDLBCL4$bic[[3]][1]>1) && (raDLBCL4$bic[[3]][2])>1) {

plotBicluster(raDLBCL4,3)

}
if ((raDLBCL4$bic[[4]][1]>1) && (raDLBCL4$bic[[4]][2])>1) {

plotBicluster(raDLBCL4,4)

}

plot(resDLBCL4,dim=c(1,2),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL4,dim=c(1,3),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL4,dim=c(1,4),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)

16

REFERENCES

plot(resDLBCL4,dim=c(1,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL4,dim=c(2,3),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL4,dim=c(2,4),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL4,dim=c(2,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL4,dim=c(3,4),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL4,dim=c(3,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)
plot(resDLBCL4,dim=c(4,5),label.tol=0.03,col.group=CDLBCL,lab.size=0.6)

}

References

Hochreiter, S., Bodenhofer, U., Heusel, M., Mayr, A., Mitterecker, A., Kasim, A., Khamiakova, T., Sanden, S. V., Lin, D., Talloen, W., Bi-
jnens, L., Göhlmann, H. W. H., Shkedy, Z., and Clevert, D.-A. (2010). FABIA: Factor analysis for bicluster acquisition. Bioinformatics.
doi:10.1093/bioinformatics/btq227, http://bioinformatics.oxfordjournals.org/cgi/content/abstract/btq227.

Hoshida, Y., Brunet, J.-P., Tamayo, P., Golub, T. R., and Mesirov, J. P. (2007). Subclass mapping: Identifying common subtypes in independent disease

data sets. PLoS ONE, 2(11), e1195.

Rosenwald, A., Wright, G., Chan, W. C., Connors, J. M., Campo, E., Fisher, R. I., Gascoyne, R. D., Muller-Hermelink, H. K., Smeland, E. B., Giltnane,
J. M., Hurt, E. M., Zhao, H., Averett, L., Yang, L., Wilson, W. H., Jaffe, E. S., Simon, R., Klausner, R. D., Powell, J., Duffey, P. L., Longo, D. L.,
Greiner, T. C., Weisenburger, D. D., Sanger, W. G., Dave, B. J., Lynch, J. C., Vose, J., Armitage, J. O., Montserrat, E., L’opez-Guillermo, A., Grogan,
T. M., Miller, T. P., LeBlanc, M., Ott, G., Kvaloy, S., Delabie, J., Holte, H., Krajci, P., Stokke, T., and Staudt, L. M. (2002). The use of molecular
profiling to predict survival after chemotherapy for diffuse large-B-cell lymphoma. New Engl. J. Med., 346, 1937–1947.

Su, A. I., Cooke, M. P., A.Ching, K., Hakak, Y., Walker, J. R., Wiltshire, T., Orth, A. P., Vega, R. G., Sapinoso, L. M., Moqrich, A., Patapoutian, A.,
Hampton, G. M., Schultz, P. G., and Hogenesch, J. B. (2002). Large-scale analysis of the human and mouse transcriptomes. P. Natl. Acad. Sci. USA,
99(7), 4465–4470.

van’t Veer, L. J., Dai, H., van de Vijver, M. J., He, Y. D., Hart, A. A., Mao, M., Peterse, H. L., van der Kooy, K., Marton, M. J., Witteveen, A. T.,
Schreiber, G. J., Kerkhoven, R. M., Roberts, C., Linsley, P. S., Bernards, R., and Friend, S. H. (2002). Gene expression profiling predicts clinical
outcome of breast cancer. Nature, 415, 530–536.

