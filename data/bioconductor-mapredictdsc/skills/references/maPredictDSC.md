Bioconductor’s maPredictDSC package

Adi L. Tarca1,2,3

October 30, 2025

1Department of Computer Science, Wayne State University
2Bioinformatics and Computational Biology Unit of the NIH Perinatology Research Branch
3Center for Molecular Medicine and Genetics, Wayne State University

1 Overview

This package implements the classification pipeline of the best overall team (Team221) (see Tarca
et al. (2013a)) in the IMPROVER Diagnostic Signature Challenge described in Meyer et al. (2012).
Additional capability is added to explore other combinations of methods for data preprocessing,
feature ranking and classification described in Tarca et al. (2013b). In a nutshell, with this package
one starts with Affymetrix .CEL expression files (all platforms supported) some of which correspond
to a set of training samples (class is required, 2 classes only) while some other correspond to test
samples for which the class will be predicted. One or more models are built on the training data,
and predictions are made on the test samples. Several performance metrics used in the IMPROVER
DSC can be computed for the fitted models if the class of the test samples is known including the
Area Under the Precision-Recall Curve (AUPR), Belief Confusion Metric (BCM) and Correct Class
Enrichment Metric (CCEM). Note that the sample size for this example as well as the arguments
in the function calls below were chosen to limit the amount of time required to run the example
on a decent computer (max 5 mins, as required by the Bioconductor standards). See the cited
references for results on several datasets of much larger sample size and more appropriate values for
the arguments in the function calls.

2 Developing prediction models with maPredictDSC package

This document provides basic introduction on how to use the maPredictDSC package. For extended
description of the methods used in this package please consult these references: Tarca et al. (2013a)
and Tarca et al. (2013b).

We demonstrate the functionality of this package using a set of lung cancer samples obtained using
Affymetrix HG-U133 Plus 2.0 technology that are available from GEO. In this example we use
7 Adenocarcinoma (AC) and 8 Squamous cell carcinoma (SCC) samples taken at random from
3 GEO datasets (GSE10245, GSE18842 and GSE2109) and 15 samples used for testing purpose
from a dataset produced by the organizers of the IMPROVER Diagnostic Signature Challenge also
available from GEO (GSE43580). The data is available in the LungCancerACvsSCCGEO package.

1

The assignment of the samples into groups is defined in the anoLC data frame available by loading
the LungCancerACvsSCCGEO datset as shown below:

> library(maPredictDSC)
> library(LungCancerACvsSCCGEO)
> data(LungCancerACvsSCCGEO)
> anoLC

GSM137916.CEL.gz
1
GSM258560.CEL.gz
2
GSM258579.CEL.gz
3
GSM258589.CEL.gz
4
GSM258598.CEL.gz
5
GSM353885.CEL.gz
6
GSM467021.CEL.gz
7
GSM152624.CEL.gz
8
9
GSM258580.CEL.gz
10 GSM277678.CEL.gz
11 GSM466956.CEL.gz
12 GSM466980.CEL.gz
13 GSM466989.CEL.gz
14 GSM467023.CEL.gz
GSM46976.CEL.gz
15
lung_100.CEL
16
lung_107.CEL
17
lung_111.CEL
18
lung_15.CEL
19
lung_150.CEL
20
lung_29.CEL
21
lung_30.CEL
22
lung_35.CEL
23
lung_40.CEL
24
lung_41.CEL
25
lung_50.CEL
26
lung_51.CEL
27
lung_59.CEL
28
lung_62.CEL
29
30

files group
AC
AC
AC
AC
AC
AC
AC
SCC
SCC
SCC
SCC
SCC
SCC
SCC
SCC
Test
Test
Test
Test
Test
Test
Test
Test
Test
Test
Test
Test
Test
Test
lung_8.CEL Test

> gsLC

lung_15.CEL
lung_29.CEL
lung_30.CEL

SCC AC
0
1
1
0
1
0

2

lung_59.CEL
lung_51.CEL
lung_100.CEL
lung_62.CEL
lung_8.CEL
lung_41.CEL
lung_40.CEL
lung_150.CEL
lung_111.CEL
lung_35.CEL
lung_107.CEL
lung_50.CEL

1
0
1
0
1 0
0
1
0
1
1
0
1
0
1 0
1 0
0
1
1 0
1
0

The data frame gsLC included also in this dataset gives the class of the test samples that we will use
later to assess the predictions of different models produced by the predictDSC function which is the
main function of the package. The predictDSC function takes as input a folder of raw Affymetrix
CEL files and explores a set of combinations of data preprocessing (rma, gcrma, mas5), feature
ranking methods (t-test, moderated t-test, wilcoxon test) and classifier types (LDA, SVM, kNN).
For each such combination, the optimal number of genes to be used in the model is automatically
determined by optimizing the AUC statistic computed via cross-validation on the training data.
Also, for each combination, a final model is fitted using all training data, and predictions on the
"Test" samples (defined as such in the ano data frame) are computed.

> modlist=predictDSC(ano=anoLC,
+ celfile.path=system.file("extdata/lungcancer",package="LungCancerACvsSCCGEO"),
+ annotation="hgu133plus2.db", preprocs=c("rma"),
+ filters=c("mttest","ttest"),classifiers=c("LDA","kNN"),
+ CVP=2,NF=4, NR=1,FCT=1.0)

Background correcting
Normalizing
Calculating Expression
Getting probe level data...
Computing p-values
Making P/M/A Calls
rma_mttest_LDA
rma_ttest_LDA
rma_mttest_kNN
rma_ttest_kNN

In addition to the 27 models that can be fitted with the simple call of the function above, one can
obtain 27 additional models by changing the FCT (fold change threshold) from 1.0 to say 1.25 or
1.5 fold. This will exclude genes from being potential candidate to be included in the model if the
change in expression on the current training data fold is not above FCT. Note, if there are not
at least NF features meeting the fold change required threshold, the threshold will be ignored and
features will be selected from the top ones sorted by p-values.
We can explore the details recorded for each methods combination stored in the elements of modlist:

3

> modlist[["rma_ttest_LDA"]]

$predictions

SCC

AC
lung_100.CEL 0.0006 0.9994
lung_107.CEL 1.0000 0.0000
lung_111.CEL 0.9990 0.0010
lung_15.CEL
1.0000 0.0000
lung_150.CEL 1.0000 0.0000
0.0000 1.0000
lung_29.CEL
0.0000 1.0000
lung_30.CEL
0.0000 1.0000
lung_35.CEL
1.0000 0.0000
lung_40.CEL
0.0000 1.0000
lung_41.CEL
0.0001 0.9999
lung_50.CEL
1.0000 0.0000
lung_51.CEL
0.0000 1.0000
lung_59.CEL
1.0000 0.0000
lung_62.CEL
1.0000 0.0000
lung_8.CEL

$features
[1] "F225214_at"

"F212900_at"

"F204703_at"

"F202973_x_at"

$model
Call:
lda(formula(paste("CLS~1", vr, sep = "+")), data = mydat, prior = c(1,

1)/2)

Prior probabilities of groups:

0

1
0.5 0.5

Group means:

F225214_at F212900_at F204703_at F202973_x_at
10.068043
8.503033

7.823691
7.086235

8.048657
7.137370

8.782127
7.878274

0
1

Coefficients of linear discriminants:

LD1
F225214_at
-2.5547801
F212900_at
-2.7501437
-3.9426705
F204703_at
F202973_x_at -0.2958261

$performanceTr

NN

meanAUC

sdAUC

4

[1,]
[2,]
[3,]

2 0.7604167 0.07365696
3 0.6093750 0.19887378
4 1.0000000 0.00000000

$best_AUC
[1] 1

Note that the names of the features selected for this model which correspond to Affymetrix probesets
have an "F" suffix added to their names since LDA does not like variable neames to start with a
number.
The different combinations of methods can be ranked using the cross-validated AUC on the training
data using:

> trainingAUC=sort(unlist(lapply(modlist,"[[","best_AUC")),decreasing=TRUE)
> cbind(trainingAUC)

rma_ttest_LDA
rma_mttest_LDA
rma_mttest_kNN
rma_ttest_kNN

trainingAUC
1.0000000
0.9583333
0.9375000
0.7916667

Now the model that apears to be best using the AUC on the training data will not necessarily be
best according to the same or other statistics on the test data. To illustrate this, we will compute
various metrics such as BCM, CCEM and AUPR implemented in the perfDSC function for these
models on the test data:

> perF=function(out){
+ perfDSC(pred=out$predictions,gs=gsLC)
+ }
> testPerf=t(data.frame(lapply(modlist,perF)))
> testPerf=testPerf[order(testPerf[,"AUC"],decreasing=TRUE),]
> testPerf

BCM

AUC
rma_ttest_LDA 0.9444139 0.9333167 1.0000000 1.0000000
rma_ttest_kNN 0.9444444 0.9333333 0.9777778 0.9444444
rma_mttest_LDA 0.8888778 0.8666600 0.9555556 0.8888889
rma_mttest_kNN 0.8888889 0.8666667 0.9555556 0.8888889

CCEM

AUPR

We can also combine the predictions from several models aka "wisdom of crowds" by using the
aggregateDSC function:

> best3=names(trainingAUC)[1:3]
> aggpred=aggregateDSC(modlist[best3])
> #test the aggregated model on the test data
> perfDSC(aggpred,gsLC)

5

BCM

AUC
0.9073935 0.8777700 1.0000000 1.0000000

AUPR

CCEM

In this example combining the predictions from the best 3 models (as apparent on the training
data) leads to better prediction on the test data compared to using the single best model chosen
according to the training performance.

References

P. Meyer, J. Hoeng, J. J. Rice, R. Norel, J. Sprengel, K. Stolle, T. Bonk, S. Corthesy, A. Royyuru,
M. C. Peitsch, and G. Stolovitzky. Industrial methodology for process verification in research
(IMPROVER): toward systems biology verification. Bioinformatics, 28(9):1193–1201, May 2012.

A. Tarca, N. Than, and R. Romero. Methodological approach from the best overall team in the

improver diagnostic signature challenge. Systems Biomedicine, submitted, 2013a.

A. L. Tarca, M. Lauria, M. Unger, E. Bilal, S. Boue, K. K. Dey, J. Hoeng, H. Koeppl, F. Martin,
P. Meyer, P. Nandy, R. Norel, M. Peitsch, J. J. Rice, R. Romero, G. Stolovitzky, M. Talikka, Y. Xi-
ang, C. Zechner, and I. Collaborators. Strengths and limitations of microarray-based phenotype
prediction: Lessons learned from the improver diagnostic signature challenge. Bioinformatics,
submitted, 2013b.

6

