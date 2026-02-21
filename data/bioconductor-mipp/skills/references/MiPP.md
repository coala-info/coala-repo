How to use the MiPP Package

Mat Soukup, HyungJun Cho, and Jae K. Lee

October 30, 2025

Contents

1 Introduction

2 Misclassification-Penalized Posteriors (MiPP)

3 Examples

3.1 Acute Leukemia Data . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Colon Cancer Data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 Sequential selection . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

1

2
2
4
7

1

Introduction

The MiPP package is designed to sequentially add genes to a classification gene model
based upon the Misclassification-Penalized Posteriors (MiPP) as discussed in Section
2. The construction of the model is based upon a training data set and the estimated
actual performance of the model is based upon an independent data set. When no clear
distinction between the training and independent data sets exists, the cross-validation
technique is used to estimate actual performance. For the detailed algorithms, see
Soukup, Cho, and Lee (2005) and Soukup and Lee (2004). The MiPP package employs
libraries MASS for LDA/QDA (linear/quadratic discrimant analysis) and e1071 for
SVM (support vector machine). Users should install the e1071 package from the main
web page of R (http://www.r-project.org/).

2 Misclassification-Penalized Posteriors (MiPP)

In the above section, estimated actual performance is mentioned a number of times.
Classically, the accuracy of a classification model is done by reporting its estimated
actual error rate. However, error rate fails to take into account how likely a particular
sample belongs to a given class and dichotomizes the data into yes the sample was

1

correctly classified or no the sample was NOT correctly classified. Although error rate,
plays a key role in how well a classification model performs, it fails to take into account
all the information that is available from a classification rule.

The Misclassification-Penalized Posteriors (MiPP) takes into account how likely a
sample belongs to a given class by using a posterior probability of correct classification.
MiPP also adjusts its definition any time a sample is misclassified by subtracting a 1
from the posterior probability of correct classification resulting in a negative value of
MiPP. If we define the posterior probability of correct classification using genes x as
ˆf (x), MiPP can be calculated as

ψp =

(cid:88)

ˆf (x) +

(cid:88)

(cid:17)
(cid:16) ˆf (x) − 1

.

correct

wrong

(1)

Here, correct refers to the subset of samples that are correctly classified and wrong refers
to the subset of samples that are misclassified. By introducing a random variable that
takes into account whether a sample is misclassified or not MiPP can be shown to be the
sum of posterior probabilities of correct classification minus the number of misclassified
samples. As a result, MiPP increases whenever the sum of posterior probabilities of
correction classification increase, the number of misclassified samples decreases, or both
of these occur.

We standardize the MiPP score divided by the number of samples in each data set,
denoted as sMiPP. Thus, the range of sMiPP is from -1 to 1. Note that as accuracy
increases, sMiPP converges to 1.

Some basic properties of MiPP are that the maximum value it can take is equal to
the sample size (or sM iP P = 1), and on the flip side, the minimum value is equal to
the negation of the sample size (or sM iP P = −1). Under a pure random model, the
expected value of MiPP is equal to zero (or sM iP P = 0). The variance is derived and is
available from the first author for the two class case, however an explicit value for more
than two classes can not be derived analytically. Thus, a bootstrapped estimate is the
preferred method of estimating the variance.

3 Examples

3.1 Acute Leukemia Data

This data set has been frequently used for testing various methods in classification and
prediction of cancer sub-types. Two distinct subsets of array data for AML and ALL
leukemia patients are available: a training set of 27 ALL and 11 AML samples and
a test set of 20 ALL and 14 AML samples. The independent set was from adult bone
marrow samples, whereas the independent set was from 24 bone marrow samples, 10 from
peripheral blood samples, and 4 of the AML samples from adults. Gene expression levels
contain probes for 6817 human genes from Affymetrix™oligonucleotide microarrays. Note
that a subset of genes (713 probe sets) was stored into the MiPP package.

2

To run MiPP , the data can be prepared as follows.

data(leukemia)

#IQR normalization
leukemia <- cbind(leuk1, leuk2)
leukemia <- mipp.preproc(leukemia, data.type="MAS4")

#Train set
x.train <- leukemia[,1:38]
y.train <- factor(c(rep("ALL",27),rep("AML",11)))
#Test set
x.test <- leukemia[,39:72]
y.test <- factor(c(rep("ALL",20),rep("AML",14)))

Since two distinct data sets exist, the model is constructed on the training data and

evaluated on the test data set as follows.

out <- mipp(x=x.train, y=y.train, x.test=x.test, y.test=y.test,
n.fold=5, percent.cut=0.05, rule="lda")

This sequentially selects genes one gene at a time with the LDA rule (rule="lda")
and 5-fold cross-validation (n.fold=5 ) on the training set. To reduce computing time,
it pre-selects the most plausuable 5% out of 713 genes by the two-sample t-test (per-
cent.cut=0.05 ), and then performs gene selection. To utilize all genes without pre-
selection, set the argument percent.cut=1 . The above command generates the following
output.

out$model

Te.ER Te.MiPP Te.sMiPP Select

Order Gene
1
2
3
4
5
6
7

Tr.ER Tr.MiPP Tr.sMiPP
30.86
36.89
37.95
38.00
38.00
38.00
38.00

0.8122 0.1176
0.9707 0.0294
0.9988 0.0294
0.9999 0.0294
1.0000 0.0294
1.0000 0.0000
1.0000 0.0000

571 0.0526
436 0.0000
366 0.0000
457 0.0000
413 0.0000
635 0.0000
648 0.0000

1
2
3
4
5
6
7

23.92
30.41
31.35
32.14
32.18
33.75
33.57

0.7035
0.8945
0.9222
0.9453
0.9464
0.9927
0.9874

**

The gene models are evaluated by both train (denoted by Tr) and test (denoted by
Te) sets; however, we select the final model based on the test set independent of the train

3

set used for gene selection. The gene model with the maximum sMiPP is indicated by
one star (*) and the parsimonious model (indicated by **) contains the fewest number
of genes with sMiPP greater than or equal to (max sMiPP - 0.01). In this example,
the maximum and parsimonious models (indicated by **) are the same. Thus, the final
model with sMiPP 0.993 contains genes 571, 436, 366, 457, 413, and 635. Note that
genes listed in the output correspond to the column number of the matrices.

3.2 Colon Cancer Data

The colon cancer data set consists of the 2000 genes with the highest minimal intensity
across the 62 tissue samples out of the original 6, 500+ genes. The data set is filtered
using the procedures described at the author’s web site. The 62 samples consist of 40
colon tumor tissue samples and 22 normal colon tissue samples (Alon et al., 1999). Li
et al. (2001) identified 5 samples (N34, N36, T30, T33, and T36) which were likely to
have been contaminated. As a result, these five samples are excluded from any future
analysis; our error rate would be higher if they were included.

Since we are working with a small data set (57 samples), we will be implementing
cross-validation techniques. With the lack of a ’true’ independent test set, we randomly
create a training data set with 38 samples (25 tumor and 13 normal) and an independent
data set with 19 samples (12 tumor and 7 normal). Since this is a random creation of
the data set, it would be of interest to see what model is selected based upon a different
random split of the data. Note that the choice of the sizes of the training and independent
test set is somewhat arbitrary, but consistent results were found using a training and test
set of sizes 29 (19 tumor and 10 normal) and 28 (18 tumor and 10 normal), respectively.
The colon data set of the MiPP package contains only 200 genes as an example. For
the colon data with no independent test set, MiPP can be run as follows.

data(colon)
x <- mipp.preproc(colon)
y <- factor(c("T", "N", "T", "N", "T", "N", "T", "N", "T", "N",
"T", "N", "T", "N", "T", "N", "T", "N", "T", "N",
"T", "N", "T", "N", "T", "T", "T", "T", "T", "T",
"T", "T", "T", "T", "T", "T", "T", "T", "N", "T",
"T", "N", "N", "T", "T", "T", "T", "N", "T", "N",
"N", "T", "T", "N", "N", "T", "T", "T", "T", "N",
"T", "N"))

#Deleting comtaminated chips
x <- x[,-c(51,55,45,49,56)]
y <- y[ -c(51,55,45,49,56)]

4

out <- mipp(x=x, y=y, n.fold=5, p.test=1/3, n.split=20, n.split.eval=100,

percent.cut = 0.1 , rule="lda")

This divides the whole data into two groups for training (two-third) and testing (one-
third) (p.test = 1/3 ) and performs the forward gene selection as done with the acute
leukemia data. Splitting of the data set into training and independent dat seta and then
selecting a model for a given split are repeated 20 times (n.split=20 ). This generates
the following output.

out$model

1
1
1
1
1
1
1
1
1
1
1
1

2
2
2
2
2
2
2
2
2
2
2
2

1
2
3
4
5
6
7
8
9
10
11
12

1
2
3
4
5
6
7
8
9
10
11
12

29 0.0263
36 0.0263
30 0.0000
177 0.0000
18 0.0000
185 0.0000
49 0.0000
163 0.0000
91 0.0000
78 0.0000
148 0.0000
95 0.0000

163 0.0789
177 0.0000
29 0.0000
36 0.0000
28 0.0000
185 0.0000
182 0.0000
65 0.0000
84 0.0000
18 0.0000
102 0.0000
76 0.0000

34.75
35.95
37.89
38.00
38.00
38.00
38.00
38.00
38.00
38.00
38.00
38.00

30.22
37.12
37.76
37.97
37.96
37.98
37.98
37.99
37.99
37.99
38.00
38.00

0.9144 0.1579
0.9461 0.0000
0.9972 0.0000
0.9999 0.0000
1.0000 0.0000
1.0000 0.0000
1.0000 0.0000
1.0000 0.0000
1.0000 0.0000
1.0000 0.0000
1.0000 0.0000
1.0000 0.0000

0.7952 0.1053
0.9767 0.0000
0.9936 0.0000
0.9991 0.0000
0.9991 0.0000
0.9995 0.0000
0.9995 0.0000
0.9998 0.0000
0.9999 0.0000
0.9999 0.0000
0.9999 0.0000
0.9999 0.0000

13.38
18.35
18.88
18.98
18.96
19.00
19.00
19.00
19.00
19.00
19.00
19.00

14.39
18.65
18.98
18.99
18.99
18.99
18.98
18.99
18.99
18.99
18.99
18.99

0.7042
0.9659
0.9939
0.9990
0.9979
1.0000
1.0000
1.0000
1.0000
0.9999
1.0000
1.0000

0.7574
0.9818
0.9988
0.9996
0.9997
0.9997
0.9987
0.9993
0.9994
0.9995
0.9993
0.9996

**

*

**

*

1
2
3
4
5
6
7
8
9
10
11
12

13
14
15
16
17
18
19
20
21
22
23
24

.
.
.

5

206
207
208
209
210
211
212
213
214
215
216
217

20
20
20
20
20
20
20
20
20
20
20
20

1
2
3
4
5
6
7
8
9
10
11
12

30 0.0263
78 0.0263
36 0.0000
51 0.0000
18 0.0000
177 0.0000
28 0.0000
102 0.0000
182 0.0000
148 0.0000
84 0.0000
141 0.0000

35.31
36.35
38.00
38.00
38.00
38.00
38.00
38.00
38.00
38.00
38.00
38.00

0.9291 0.1579
0.9566 0.0526
0.9999 0.0000
1.0000 0.0526
1.0000 0.0526
1.0000 0.1053
1.0000 0.1053
1.0000 0.1579
1.0000 0.1053
1.0000 0.1053
1.0000 0.1579
1.0000 0.1053

12.39
16.54
18.86
17.05
16.93
15.32
15.03
13.38
14.81
14.98
13.35
14.86

0.6522
0.8704
0.9924
0.8974
0.8911
0.8062
0.7911
0.7040
0.7794
0.7883
0.7027
0.7821

**

For each split, the parsimonious model identified (denoted as **) is evaluated by an

independent 100 splits (n.split.eval=100) generating the following output.

out$model.eval

Split G1

G3
G2
30
1 29 36
29
2 163 177
3 30 36 185
4 29 102 177
5 91 177
29
6 49 78 185 177
30
7 29 78
91
NA NA
8 30 36 185
NA
NA
78
9 30 36
NA
10 29 185 177
NA
NA NA
11 29 177
NA
12 30 36 177 185
NA
NA
NA
NA
13 30 36
65 102
14 49 185 141
29 NA
15 163 177 185
78 NA
16 49 91 185
36 148
17 163
49
NA
18 29 177 163
NA
91 NA
19 29 36 185
NA
NA
36
20 30 78

G5
G4
G6 G7 G8
G9 G10 G11 G12 mean ER mean MiPP mean sMiPP
NA 0.022631
NA
NA
NA NA NA
NA
NA
NA
NA 0.004210
NA
NA
NA NA NA
NA
NA
NA
NA 0.000000
NA NA
NA NA NA
NA
NA NA
NA 0.010526
36
84
NA NA NA
NA
NA
NA
NA 0.006842
36 NA
NA NA NA
NA NA
NA
NA 0.015789
NA NA NA
29
NA
NA
NA
NA 0.006842
51 102 36 18
76 141
NA
NA 0.000000
NA NA NA
NA NA
NA
NA 0.000000
NA NA NA
NA
NA
NA
NA 0.006315
NA NA NA
NA
NA
NA
NA 0.014736
NA NA NA
NA NA
NA
NA 0.000000
NA
NA
NA NA NA
NA
NA 0.000526
NA
NA
NA
NA NA NA
29 0.008947
95
18 30 36 163
91
NA 0.005263
NA NA
NA
NA NA NA
NA 0.013684
NA NA
NA
NA NA NA
18 185 141 182 0.027894
91 84 30
NA 0.004210
NA
NA NA NA
NA 0.020526
NA
NA NA NA
NA 0.000000
NA
NA NA NA

0.9487025
0.9840302
0.9951495
0.9743218
0.9798232
0.9646823
0.9857517
0.9951495
0.9938337
0.9826242
0.9517509
0.9986411
0.9874807
0.9799060
0.9860384
0.9643648
0.9396381
0.9840302
0.9551247
0.9938337

18.03
18.70
18.91
18.51
18.62
18.33
18.73
18.91
18.88
18.67
18.08
18.97
18.76
18.62
18.73
18.32
17.85
18.69
18.15
18.88

NA
NA
NA NA
NA
NA

29

S1
S2
S3
S4
S5
S6
S7
S8
S9
S10
S11
S12
S13
S14
S15
S16
S17
S18
S19
S20

6

S1
0.10526316
S2
0.05263158
S3
0.00000000
S4
0.05263158
S5
0.05263158
S6
0.05263158
S7
0.05263158
S8
0.00000000
0.00000000
S9
S10 0.05263158
S11 0.05526316
S12 0.00000000
S13 0.00000000
S14 0.05526316
S15 0.05263158
S16 0.05263158
S17 0.10526316
S18 0.05263158
S19 0.05263158
S20 0.00000000

5% ER 50% ER 95% ER 5% sMiPP 50% sMiPP 95% sMiPP
0 0.8083084 0.9898493 0.9969918
0 0.9083072 0.9949838 0.9996731
0 0.9858440 0.9965600 0.9990983
0 0.8829518 0.9965193 0.9996263
0 0.8964819 0.9946817 0.9993379
0 0.8906567 0.9925318 0.9998255
0 0.9074560 0.9992884 0.9999863
0 0.9858440 0.9965600 0.9990983
0 0.9856433 0.9947618 0.9987210
0 0.8974827 0.9959758 0.9989191
0 0.8655241 0.9726538 0.9902048
0 0.9968295 0.9991665 0.9998100
0 0.9744228 0.9896188 0.9954914
0 0.8777725 0.9992962 0.9999910
0 0.9071621 0.9976359 0.9997154
0 0.8896781 0.9860472 0.9983609
0 0.7931386 0.9778348 0.9995296
0 0.9083072 0.9949838 0.9996731
0 0.8801255 0.9952021 0.9989584
0 0.9856433 0.9947618 0.9987210

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

3.3 Sequential selection

Good classifying (masked) genes may be masked by other better classifying (masking)
genes, so the masked genes may be discovered if the masking genes are not present.
Therefore, it is worth selecting gene models after removing genes selected in the previ-
ous runs. This sequential selection can be performed by manually removing the genes
selected in the previous runs. For users’ convenience, the MiPP package enables one to
perform such a sequential selection process automatically many times.

For the acute leukemia data with an independent test set, the sequntial analysis can

be performed by the following arguments in the mipp.seq function:

out <- mipp.seq(x=x.train, y=y.train, x.test=x.test, y.test=y.test, n.seq=3)

The argument n.seq=3 means that the sequential selection is performed 3 times after
removing all the genes in the selected gene models. For the colon cancer data with no
independent test set, the sequntial analysis can be performed by the following arguments:

7

out <- mipp.seq(x=x, y=y, n.seq=3, cutoff.sMiPP=0.7)

By the argument cutoff.sMiPP=0.7 , the gene models with 5% sMiPP > 0.7 are selected,
so all the genes in the selected models are removed for the next run. All the arguments
in the mipp.seq function can also used in the mipp.seq function.

Reference

Soukup M, Cho H, and Lee JK (2005). Robust classification modeling on microar-
ray data using misclassification penalized posterior, Bioinformatics, 21 (Suppl):
i423-i430.

Soukup M and Lee JK (2004). Developing optimal prediction models for cancer
classification using gene expression data, Journal of Bioinformatics and Compu-
tational Biology, 1(4) 681-694.

8

