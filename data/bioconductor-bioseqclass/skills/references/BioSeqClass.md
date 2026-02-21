Using the BioSeqClass Package

Hong Li‡*

October 30, 2018

‡Key Lab of Systems Biology
Shanghai Institutes for Biological Sciences
Chinese Academy of Sciences, P. R. China

Contents

1 Overview

2 Installation

2.1 Requirements . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
Installation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2

3 Function description

3.1 Homolog Reduction . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Feature Extraction and Numerical Coding . . . . . . . . . . . . . . . . . . .
3.2.1 Biological sequences
. . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2.2 Feature Coding . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 Feature Selection . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 Model Building and Performance Evaluation . . . . . . . . . . . . . . . . . .

4 Examples

5 Session Information

1 Overview

1

2
2
2

4
4
4
4
5
5
5

6

14

There are now 863 completely sequenced genomes of cellular organisms in NCBI genome
database. Nevertheless, functional annotation drops far behind sequencing because func-
tional valida-tion experiments are time-consuming and costly. Taken model organism Homo

*sysptm@gmail.com

1

sapiens, Mus musculus and Saccharomyces cere-visiae as examples, only 16and 18anno-
tations in Gene Ontology), respectively. Thus computational methods for predicting function
is still a fun-damental complement. The most common com-putation approach is biologi-
cal sequence based classiﬁcation, since sequence information is still the most abundant and
reliable. Se-quence based classiﬁcation has been used in: discovering new microRNA can-
didates, predicting transcription factor binding sites , detecting protein post-translational
modiﬁcation sites , and so on.

Features and models are two basic factors for classiﬁcation. Features generally are nu-
merical values that can be used to distinguish diﬀerent classes. Therefore it is preferable
to select features that can achieve better and faster classiﬁcation. Classiﬁcation models are
built from features by various algorithms, and it is necessary to evaluate its prediction ability
by cross validation or jackknife test. For biological sequences, there are additional steps: one
is to reduce homolog sequences which might result in overestimation of prediction accuracy,
and then another most important step is to convert sequences into numerical features. Thus,
the general workﬂow for sequence-based classiﬁcations includes (Figure 1): reduce homolog
sequences; extract features from sequences and code them to numerical values; evaluate and
select features; build classiﬁcation model and evaluate its performance.

Here we present an R package (BioSeqClass) to carry out the general workﬂow for bi-
ological sequence based classiﬁcation. It contains diverse fearure coding schemas for RNA,
DNA and proteins, supports feature seletion, and integrates multiple classiﬁcation methods.

2 Installation

2.1 Requirements

BioSeqClass employs some external programs to extract biological properties and use other
R packages to build classiﬁcation model:

1. BioSeqClass imported R packages are listed in table 1. These packages will be auto-

matically installed when Biocalss is ﬁrstly loaded.

2. External programs are used to assist the performance of BioSeqClass (see table 2).
Some programs are invoked via their web service, and some ones are needed to be
installed at the local computer.

Note: You do not need to install programs listed in table 2, unless you will use the
related function in BioSeqClass.

2.2 Installation

BiocManager is used to install PAnnBuilder from within R:

> if (!requireNamespace("BiocManager", quietly=TRUE))
install.packages("BiocManager")
+
> BiocManager::install("BioSeqClass")

2

Figure 1: Workﬂow for Biological Sequence based Classiﬁcation.

3

Users also can use the installation script ”BioSeqClass.R”to download and install BioSeqClass
package.

> source("http://www.biosino.org/download/BioSeqClass/BioSeqClass.R")
> BioSeqClass()

Load package:

> library(BioSeqClass)

Note: Web Connection is needed to install BioSeqClass and its required packages. All
the codes in this vignette were tested in R 2.8.0 and 2.9.0, thus the latest R version is
recommended.

3 Function description

3.1 Homolog Reduction

Homologous sequences in training/testing data may lead to overestimation of prediction ac-
curacy. Therefore, the ﬁrst step for sequence based classiﬁcation and prediction is homolog
reduction based on sequence similarity. Taking computation complexity and similarity re-
striction into consideration, homolog reductions for full-length sequences and fragment se-
quences are diﬀerent. We have designed diﬀerent functions to deal with them, respectively
(see table 3).

(cid:136) hr - It employs cdhitHR and aligndisHR to ﬁlter homolog sequences by sequence sim-
ilarity. cdhitHR is designed to ﬁlter full-length protein or gene sequences. aligndisHR
is designed for aligned sequences with equal length.

(cid:136) cdhitHR - It uses cd-hit program to do homolog reduction (”formatdb” and ”blastall”
are required for running cd-hit program). CD-HIT is a program for clustering large
protein database at high sequence identity threshold (Li and Godzik, 2006).

(cid:136) aligndisHR - It uses the number of diﬀerent residues to do homolog reduction (D et al.,
2008). The algorithm proceeds in a stepwise manner by ﬁrst eliminating sequences that
were diﬀerent from another in exactly 1 position. Elimination proceeds one peptide
at a time; Re-evaluate after each peptide is removed. Once no further homologs of
distance 1 remain, homologs of distance 2 are eliminated, and so forth until identity
between all peptides are less than given cutoﬀ.

3.2 Feature Extraction and Numerical Coding

3.2.1 Biological sequences

RNA, DNA and protein are three kinds of basic biological sequences. RNA and DNA are
composed of bases, while proteins are composed of amino acids. Furthermore, amino acids

4

have diﬀerent physical-chemical properties, which were used to divide amino acids into diﬀer-
ent groups. These elements and groups are basic objects for feature extraction (see table 4).

3.2.2 Feature Coding

Feature coding means to extract features from sequences and convert them into numerical
values. The frequently used features are the basic elements of sequence (bases, amino acids),
physical-chemical properties, secondary structures, and so on. There are many methods to
convert features to numerical values. The simplest is the composition of element. But more
sophisticated conversions are preferrable for achieving better distinguishing power. Previous
studies have shown that feature coding is the key point for the accuracy of classiﬁcation
and prediction. Here we have summarized various feature coding methods used in published
papers and carried out them in BioSeqClass (see table 5). These functions will allow more
diverse choices of coding strategies and accelerate the feature coding process. We also provide
a function featureEvaluate to test the performance of models with diﬀerent feature coding
schemes and diﬀerent classiﬁcation algorithms.

3.3 Feature Selection

Features are important for the accuracy of prediction model. However, it does not mean that
the more the better. Computation time is usually increased with the increase of number of
features. Conﬂictive features would even reduce the accuracy. Therefore, suitable feature
selection is needed for better prediction performance and less computation cost. We provided
two functions for feature selection (see table 6).

3.4 Model Building and Performance Evaluation

Besides features, classiﬁcation method is another factor that inﬂuences classiﬁcation. Diﬀer-
ent cases may have diﬀerent perference over classiﬁcation methods. Multiple classiﬁcation
methods are integrated and available in BioSeqClass (see table 7). To evaluate and compare
classiﬁcation models, performance assessment is done for each model, including precision,
sensitivity, speciﬁcity, accuracy, and matthews correlation coeﬃcient.

5

Table 1: Imported R packages.

Existing R Package Functions used by BioSeqClass
readAAStringSet, writeXStringSet
Biostrings
svm
e1071
bagging
ipred
svmlight, NaiveBayes
klaR
randomForest
randomForest
knn
class
tree
tree
nnet
nnet
rpart
rpart
ctree
party
write.arﬀ
foreign
addVigs2WinMenu
Biobase

4 Examples

To illustrate the use of BioSeqClass, lysine acetylation site prediction is taken as an example.

1. Suppose the original data are protein FASTA sequences and lysine acetylation sites.
You can use getTrain to extract the ﬂanking peptides of acetylation sites as positive
dataset, and ﬁlter these peptides based on sequence identity. Lysine without acetylation
annotation are regarded as negative dataset, and are ﬁltered like the positive dataset.
Considering the computational time, only 20 positive data are used as examples in the
following codes.

>
>
>
>
+
>
>
>
+
>

library(BioSeqClass)
# Example data in BioSeqClass.
file=file.path(path.package("BioSeqClass"),"example","acetylation_K.fasta")
posfile = file.path(path.package("BioSeqClass"),

"example", "acetylation_K.site")

# Only a part of lysine acetylation sites are used for demo.
posfile1=tempfile()
write.table(read.table(posfile,sep=

,header=F)[1:20,], posfile1,

\t

’

’

’

’

sep=

\t

, quote=F, row.names=F, col.names=F)

seqList = getTrain(file, posfile1, aa="K", w=7, identity=0.4)

[1] "Positive Site: 18"
[1] "Positive Protein: 9"
[1] "Positive Site After Homolog Reduction: 16"
[1] "Positive Protein After Homolog Reduction: 9"

6

Table 2: Invoked External Programs.

External
Program
cd-hit

blastpgp

SVMlight
DSSP

Proteus2
HMMER

Description

a program for clustering large
protein database at high se-
quence identity threshold
PSI-BLAST (Position-Speciﬁc
Iterated BLAST) for capturing
the conservation pattern
support vector machine
a database of secondary struc-
ture assignments for protein en-
tries in the Protein Data Bank
(PDB)
predict secondary structure
predict domains with hmmpfam
using models of Pfam database

Related BioSeqClass
Function
cdhitHR

Need In-
stalled?
Yes

Ref

(Li and Godzik, 2006)

featurePSSM

Yes

(Altschul et al., 1997)

classifyModelSVMLIGHT No
No
getDSSP

(T, 1999)
(Kabsch and Sander, 1983)

predictPROTEUS
predictPFAM

No
No

(S et al., 2006)
(Eddy, 1998)

Table 3: Summary Table for Homolog Reduction Functions.

Function
hr
cdhitHR
aligndisHR calculated identity of aligned sequences

Description
employ cdhitHR and aligndisHR to do homolog reduction
invoke cd-hit to cluster sequences

Ref

(Li and Godzik, 2006)
(D et al., 2008)

Table 4: Summary Table for Base and Amino Acid Groups.

Function Description
elements
aaClass

basic elements of biological sequence
amino acids groups depend on their physical-chemical properties:
hydrophobicity, normalized Van der Waals volume, polarizability,
polarity, and so on

Ref

(CS et al., 2006)

7

Table 5: Summary table for Feature Coding Functions.

Type

DNA,
RNA, or
protein

Function
featureBinary

featureCTD

featureFragmentComposition

featureGapPairComposition

featureCKSAAP

featureHydro

featureACH

protein

featureAAindex

featureACI

featureACF

featurePseudoAAComp

featurePSSM

featureDOMAIN

featureSSC

DNA or
RNA

featureBDNAVIDEO

featureDIPRODB

Feature Coding Scheme
use 0-1 vector to code each element

numeric vector for the composition, transition
and distribution of properties
numeric vector for the frequency of k-mer se-
quence fragment
numeric vector for the frequency of g-spaced ele-
ment pair
integer vector for the number of k-spaced element
pair (k cycled from 0 to g)
hydrophobic eﬀect

average cumulative hydrophobicity over a sliding
window
numeric vector measuring the physicochemical
and biochemical properties based on AAindex
database
numeric vector measuring the average cumulative
properties in AAindex
numeric vector measuring the Auto Correlation
Function (ACF) of properties in AAindex
numeric vector for the pseudo amino acid com-
position proposed by Chou,K.C.
numeric vector for the normalized position-
speciﬁc score of PSSM generated by PSI-BLAST

vector for the number of domain. Domains can
be obtained by ’predictPFAM’ function.
coding for secondary structure of protein. Sec-
ondary structure can be got by ’predictPRO-
TEUS’ or ’getDSSP’.
Conformational and physicochemical DNA fea-
tures from B-DNA-VIDEO database
conformational
cleotide properties
(http://diprodb.ﬂi-leibniz.de)

dinu-
from DiProDB database

thermodynamic

and

Ref
(Jia et al., 2006; Chen
et al., 2006)
(Cai et al., 2003)

(CS et al., 2004; RY
et al., 2002)
(CS et al., 2006)

(Chen et al., 2008)

(A and R, 1988; MJ
et al., 2000)
(Zhang et al., 2008;
Kurgan et al., 2007)
(S et al., 1999; Cai
and Lu, 2008)

(Zhang et al., 1998;
Liu and Chou, 1998)
(Chou, 2001)

(Zhang et al., 2005;
Chung-Tsai Su and
Ou, 2006; S and A,
2005; Zhang et al.,
2008)
(Jia et al., 2007)

(Zheng and Kurgan,
2008)

Ponomarenko

(v.
et al., 1999)
(Friedel et al., 2009)

8

Table 6: Summary Table for Feature Selection Functions.

Description

Function
selectWeka feature selction by methods in WEKA
selectFFS

feature forword selction based on the performance of
classiﬁcation model
build and test model with cross validation, also support
feature selection by envoking WEKA

classify

Ref
(Witten and Fran, 2005)
(Cai and Lu, 2008)

Table 7: Summary Table for Classiﬁcation Methods.

Function
classifyModelLIBSVM
classifyModelSVMLIGHT
classifyModelNB
classifyModelRF
classifyModelKNN
classifyModelTree
classifyModelNNET
classifyModelRPART
classifyModelCTREE
classifyModelCTREELIBSVM combine conditional inference trees and sup-

Description
support vector machine by LIBSVM
support vector machine by SVM-light
naive bayes
random forest
k-nearest neighbor
tree model
neural net algorithm
recursive partitioning trees
conditional inference trees

Depended R package
e1071
klaR
klaR
randomForest
class
tree
VR
rpart
party
party, e1071

classifyModelBAG

port vector machine
bagging method

ipred

9

[1] "Negative Site: 215"
[1] "Negative Protein: 9"
[1] "Negative Site After Homolog Reduction and Random Selection: 16"
[1] "Negative Protein After Homolog Reduction and Random Selection: 8"

2. If the original data are non-redundant positive/negative peptides. We directly read

the data into R and assign class labels for them.

>
>
>
>
>
>
>
>

’

’

’

’

),

’
’

example

BioSeqClass

tmpDir=file.path(path.package(
tmpFile1=file.path(tmpDir,
tmpFile2=file.path(tmpDir,
posSeq=as.matrix(read.csv(tmpFile1,header=F,sep=
negSeq=as.matrix(read.csv(tmpFile2,header=F,sep=
seq=c(posSeq,negSeq)
classLable=c(rep("+1",length(posSeq)),rep("-1",length(negSeq)) )
length(seq)

acetylation_K.pos40.pep
acetylation_K.neg40.pep
\t
\t

)
)
,row.names=1))[,1]
,row.names=1))[,1]

’
’
’
’

’
’

)

[1] 1200

3. Once you have positive/negative datasets, you can code them to numeric vectors by
functions listed in table 5. Function featureBinary and featureGapPairComposition
are taken as examples of diﬀerent coding methods, which use binary 0-1 coding and
the composition of gapped amino acid pair, respectively. Other functions can be used
in the same way.

>
>
>

# Use 0-1 binary coding.
feature1 = featureBinary(seq,elements("aminoacid"))
dim(feature1)

[1] 1200 300

>
>
>

# Use the compostion of paired amino acids.
feature2 = featureGapPairComposition(seq,0,elements("aminoacid"))
dim(feature2)

[1] 1200 400

4. classify is used to build classiﬁcation model under cross validation. It also supports
feature selection by invoking WEKA. Models built with selected features usually can
obtain higher accuracy. In the following codes, two models are built by classify. The
1st classiﬁcation model ’LIBSVM CV5’ is built by support vector machine with linear
kernel and get an accuracy of 0.56 under 5-fold cross validation. The 2nd classiﬁcation
model ’FS LIBSVM CV5’ is also built by support vector machine with linear kernel,
but a feature selection method called ”CfsSubsetEval” is used before building model.
Thus the 2nd model using feature selection achieves an higher accuracy of 0.62 than
the 1st model using all features.

10

>
>
>
+
>

data = data.frame(feature1,classLable)
# Use support vector machine and 5 fold cross validation to do classification.
LIBSVM_CV5 = classify(data, classifyMethod=
cv=5, svm.kernel=

,svm.scale=F)

libsvm

linear

,

’

’

’

’

LIBSVM_CV5[["totalPerformance"]]

tn

tp

fn
337.0000000 337.0000000 263.0000000 263.0000000
pc
0.3918323

mcc
0.1243355

acc
0.5616667

sp
0.5616667

fp

prc
0.5599397

sn
0.5616667

>
>
+
+
>

# Features selection is done by envoking "CfsSubsetEval" method in WEKA.
FS_LIBSVM_CV5 = classify(data, classifyMethod=
CfsSubsetEval

libsvm
, search=

BestFirst

’
’

,

,

’

’

’

’

cv=5, evaluator=
svm.kernel=

linear

’

’

, svm.scale=F)

FS_LIBSVM_CV5[["totalPerformance"]] ## Accuracy is increased by feature selection.

tn

tp

fn
258.0000000 488.0000000 112.0000000 342.0000000
pc
0.3651539

mcc
0.2621407

acc
0.6216667

sp
0.8133333

fp

prc
0.6924855

sn
0.4300000

>
>

# Selected features:
colnames(data)[FS_LIBSVM_CV5$features[[1]]]

[1] "BIN.1_A" "BIN.2_R" "BIN.3_K" "BIN.4_K" "BIN.5_K" "BIN.5_N"
[7] "BIN.6_N" "BIN.6_G" "BIN.6_T" "BIN.6_P" "BIN.7_P" "BIN.9_W"
[13] "BIN.9_H" "BIN.9_Y" "BIN.9_L" "BIN.10_Q" "BIN.11_W" "BIN.11_V"
[19] "BIN.12_K" "BIN.12_F" "BIN.13_K" "BIN.13_I" "BIN.13_M" "BIN.14_A"
[25] "BIN.15_K" "BIN.15_E" "BIN.15_A" "BIN.15_T"

5. Diﬀerent feature coding methods usually might result in diﬀerent prediction perfor-
mance. featureEvaluate can be used to test multiple feature coding methods. Figure
2 shows the 3D plot of prediction accuracy varied with feature coding functions and
parameters. It can be generated by employing featureEvaluate as follows (Note: It
may be time consuming!):

>
>
>
+
+
+
+

fileName = tempfile()
# Note: It may be time consuming.
testFeatureSet = featureEvaluate(seq, classLable, fileName, cv=5,

aminoacid

, featureMethod=c(

Binary

,

GapPairComposition

),

’

’

’

’

’

’

’

’

’

,
SARAH1

,

aaP
’

aaF

,
), hydro.indexs=c(

aaS

,

aaE
hydroE

), g=0,
,

’

’

’
’

’

hydroF

,

’

’

hydroC

) )

’

’

’

’

ele.type=
’
classifyMethod=
’
group=c(
hydro.methods=c(

aaH

,

’

’

’
libsvm
’
’
aaV
’

,
’
kpm

,

’

,
aaZ
’

11

>
>
>
>
>
+
>
>
+
+
+
+
+
+

’

summary = read.csv(fileName,sep="\t",header=T)
# Plot the result of
require("scatterplot3d")
tmp1 = summary[,"Feature_Function"]
tmp2 = as.factor(sapply(as.vector(summary[,
function(x){unlist(strsplit(x,split=

featureEvaluate

’
’

’

Feature_Parameter
;

))[1]}))

’

’

]),

testResult = data.frame(as.integer(tmp2), as.integer(tmp1), summary[,"acc"])
s3d=scatterplot3d(testResult,
red

Parameter

)[testResult[,2]], pch=19, xlab=
’

,

’

’

’

’

’

’

’
’

blue

,
Feature Coding
Accuracy

color=c(
ylab=
zlab=
x.ticklabs=gsub(
’
type=
h
y.ticklabs=c(

’’

’

’

’

,gsub(

,

’

class:

, lab=c(9,3,7),

’

’’

,

,sort(unique(tmp2))),

,ylim=c(0,3),y.margin.add=2.5,

’

’’

feature

,

,sort(unique(tmp1))),

) )

’’

6. Features from multiple functions can be combined and re-selected to increase the predic-
tion accuracy. In the following code chunk, the ﬁrst three feature sets from ’testFeature-
Set’ are combined together (’testFeatureSet’ is generated in the aforementioned codes
by featureEvaluate). Then feature selection functions (classify and selectFFS)
can be employed to selecte features. (classify has been illustrated in the aforemen-
tioned code chunk. Thus selectFFS is used here to do feature forward selection to
select a subset with maximum prediction accuracy (Note: It may be time consuming!).
The process of feature selection and the increasing accuracy are shown in Figure 3.

>
>
>
>
+
+
+
>
>
+
+
+
+
+
+
+
+
>
>

feature.index = 1:3
tmp <- testFeatureSet[[1]]$data
tmp1 <- testFeatureSet[[feature.index[1]]]$model
colnames(tmp) <- paste(

tmp1["Feature_Function"],
tmp1["Feature_Parameter"],
colnames(tmp),sep=" ; ")

data <- tmp[,-ncol(tmp)]
for(i in 2:length(feature.index) ){

tmp <- testFeatureSet[[feature.index[i]]]$data
tmp1 <- testFeatureSet[[feature.index[i]]]$model
colnames(tmp) <- paste(

tmp1["Feature_Function"],
tmp1["Feature_Parameter"],
colnames(tmp),sep=" ; ")

data <- data.frame(data, tmp[,-ncol(tmp)] )

}
name <- colnames(data)
data <- data.frame(data, tmp[,ncol(tmp)] ) ## Combined features

12

>
>
>
+
>
+
>
+
>

’

’

selectFFS

to do feature forward selection.

# Use
# Note: It may be time consuming.
combineFeatureResult = selectFFS(data,accCutoff=0.005,
classifyMethod="knn",cv=5) ## It is time consuming.

tmp = sapply(combineFeatureResult,function(x){
c(length(x$features),x$performance["acc"])})

plot(tmp[1,],tmp[2,],xlab="Feature Number",ylab="Accuracy",

, pch=19)

lines(tmp[1,],tmp[2,])

13

Figure 2: Result of featureEvaluate.

5 Session Information

This vignette was generated using the following package versions:

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

14

aaEaaFaaHaaPaaSaaVaaZaminoacid0.560.570.580.590.600.610.62BinaryGapPairCompositionParameterFeature CodingAccuracy under 5−fold cross validationllllllllllllllllFigure 3: Result of selectFFS.

15

llllllll123456780.600.620.640.660.68Feature NumberAccuracylocale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats

graphics grDevices utils

datasets methods

base

other attached packages:
[1] BioSeqClass_1.40.0

scatterplot3d_0.3-41

loaded via a namespace (and not attached):

[1] Rcpp_0.12.19
[4] questionr_0.6.3
[7] zlibbioc_1.28.0

XVector_0.22.0
later_0.7.5
class_7.3-14
digest_0.6.18
Matrix_1.2-14
parallel_3.5.1

[10] rpart_4.1-13
[13] lattice_0.20-35
[16] rstudioapi_0.8
[19] prodlim_2018.04.18 coin_1.2-2
[22] IRanges_2.16.0
[25] combinat_0.0-8
[28] nnet_7.3-12
[31] R6_2.3.0
[34] multcomp_1.4-8
[37] klaR_0.6-14
[40] promises_1.0.1
[43] MASS_7.3-51
[46] randomForest_4.6-14 strucchange_1.5-1
[49] xtable_1.8-3
[52] party_1.3-1

S4Vectors_0.20.0
stats4_3.5.1
tree_1.0-39
survival_2.43-1
TH.data_1.0-9
magrittr_1.5
htmltools_0.3.6
splines_3.5.1

httpuv_1.4.5
miniUI_0.1.1.1

compiler_3.5.1
highr_0.7
tools_3.5.1
ipred_0.9-7
shiny_1.1.0
mvtnorm_1.0-8
e1071_1.7-0
Biostrings_2.50.0
grid_3.5.1
Biobase_2.42.0
foreign_0.8-71
lava_1.6.3
codetools_0.2-15
modeltools_0.2-22
BiocGenerics_0.28.0
mime_0.6
sandwich_2.5-0
zoo_1.8-4

References

Radzicka A and Wolfenden R. Comparing the polarities of the amino acids: Side-chain
distribution coeﬃcients between the vapor phase, cyclohexane, 1-octanol, and neutral
aqueous solution. Biochemistry, 27:1664–1670, 1988.

S.F. Altschul, T.L. Madden, A.A. Schaﬀer, J. Zhang, Z. Zhang, W. Miller, and D.J. Lipman.

16

Gapped blast and psi-blast: a new generation of protein database search programs. Nucleic
Acids Res, 25:3389–3402, 1997.

C.Z. Cai, L.Y. Han, Z.L. Ji, X. Chen, and Y.Z. Chen. Svm-prot: web-based support vec-
tor machine software for functional classiﬁcation of a protein from its primary sequence.
Nucleic Acids Research, 31(13):3692´lC3697, 2003.

Yu-Dong Cai and Lin Lu. Predicting n-terminal acetylation based on feature selection
method. Biochemical and Biophysical Research Communications, 372(4):862–865, 2008.

Hu Chen, Yu Xue, Ni Huang, Xuebiao Yao, and Zhirong Sun. Memo: a web tool for

prediction of protein methylation modiﬁcations. Protein Sci, 34:249–53, 2006.

Yong-Zi Chen, Yu-Rong Tang, Zhi-Ya Sheng, and Ziding Zhang. Prediction of mucin-type
o-glycosylation sites in mammalian proteins using the composition of k-spaced amino acid
pairs. BMC Bioinformatics, 9:101, 2008.

K. C Chou. Prediction of protein cellular attributes using pseudo-amino acid composition.

Proteins, 43(3):246–255, 2001.

Chien-Yu Chen Chung-Tsai Su and Yu-Yen Ou. Protein disorder prediction by condensed

pssm considering propensity for order or disorder. Bioinformatics, 7:319, 2006.

Yu CS, Lin CJ, and Hwang JK. Predicting subcellular localization of proteins for gram-
negative bacteria by support vector machines based on n-peptide compositions. Protein
Sci, 13(5):1402–6, 2004.

Yu CS, Chen YC, Lu CH, and Hwang JK. Prediction of protein subcellular localization.

Proteins, 64(3):643–51, 2006.

Schwartz D, Chou MF, and Church GM. Predicting protein post-translational modiﬁcations

using meta-analysis of proteome-scale data sets. Mol Cell Proteomics, 2008.

S. R. Eddy. Proﬁle hidden markov models. Bioinformatics, 14:755–763, 1998.

Maik Friedel, Swetlana Nikolajewa, Jurgen Suhne, and Thomas Wilhelm. Diprodb: a

database for dinucleotide properties. Bioinformatics, 37:37–40, 2009.

Peilin Jia, Tieliu Shi, Yudong Cai, and Yixue Li. Demonstration of two novel methods for

predicting functional sirna eﬃciency. BMC Bioinformatics, 7:271, 2006.

Peilin Jia, Ziliang Qian, Zhen Bin Zeng, Yudong Cai, and Yixue Li. Prediction of subcel-
lular protein localization based on functional domain composition. Biochem Biophys Res
Commun,, 357(2):366–370, 2007.

W. Kabsch and C Sander. Dictionary of protein secondary structure: pattern recognition of

hydrogen-bonded and geometrical features. Biopolymers, 22(12):2577–637, 1983.

17

Lukasz A. Kurgan, Wojciech Stach, and Jishou Ruan. Novel scales based on hydrophobicity

indices for secondary protein structure. J. Theor. Biol., 248:354´lC366, 2007.

Weizhong Li and Adam Godzik. Cd-hit: a fast program for clustering and comparing large

sets of protein or nucleotide sequences. Bioinformatics, 19(1):155–6, 2006.

Wei-min Liu and Kuo-Chen Chou. Prediction of protein structural classes by modiﬁed
mahalanobis discriminant algorithm. Journal of Protein Chemistry, 17(3):209–217, 1998.

Korenberg MJ, David R, Hunter IW, and Solomon JE. Automatic classiﬁcation of protein
sequences into structure/function groups via parallel cascade identiﬁcation: a feasibility
study. Ann Biomed, 28(7):803–811, 2000.

Luo RY, Feng ZP, and Liu JK. Prediction of protein structural class by amino acid and

polypeptide composition. Eur J Biochem, 269(17):4219–4225, 2002.

Ahmad S and Sarai A. Pssm-based prediction of dna binding sites in proteins. BMC Bioin-

formatics, 6:33, 2005.

Kawashima S, Ogata H, and Kanehisa M. Aaindex: amino acid index database. Nucleic

Acids Res, 27:368–369, 1999.

Montgomerie S, Sundararaj S, Gallin WJ, and Wishart DS.

Improving the accuracy of
protein secondary structure prediction using structural alignment. BMC Bioinformatics,
14:301, 2006.

Joachims T. Making large-scale svm learning practical. MIT Press, pages 169–184, 1999.

Julia v. Ponomarenko, Mikhail P. Ponomarenko, Anatoly S. Frolvo, Denies G. Vorobyev,
G.Christian Overton, and NIkolay A. Kolchanov. Conformational and physicochemical
dna features speciﬁc for transcription factor binding sites. Bioinformatics, 15:654–668,
1999.

Ian H. Witten and Eibe Fran. Data mining: Practical machine learning tools and techniques.

Morgan Kaufmann, San Francisco, 2005.

C. Zhang, Z. Lin, Z. Zhang, and M. Yan. Prediction of the helix/strand content of globular

proteins based on their primary sequences. Protein Eng, 11(11):971–979, 1998.

Qidong Zhang, Sukjoon Yoon, and William J. Welsh. Improved method for predicting beta-

turn using support vector machine. Bioinformatics, 21(10):2370–2374, 2005.

Tuo Zhang, Ke Chen Hua Zhang, Shiyi Shen, Jishou Ruan, and Lukasz Kurgan. Accurate
sequence-based prediction of catalytic residues. Bioinformatics, 24(20):329´lC2338, 2008.

Ce Zheng and Lukasz Kurgan. Prediction of beta-turns at over 80predicted secondary struc-

tures and multiple alignments. BMC Bioinformatics, 9:430, 2008.

18

