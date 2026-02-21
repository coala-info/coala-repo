Correlation Motif Vignette

Hongkai Ji, Yingying Wei

October 29, 2025

1

Introduction

The standard algorithms for detecting differential genes from microarray data
are mostly designed for analyzing a single data set. However, with the wide use
of microarray technologies in biology and medicine, many different microarray
studies are available for the same biological problem. Separately analyzing each
data set is not an ideal strategy as it may fail to detect some key genes showing
low fold changes consistently in all studies. Jointly modeling all data allows one
to borrow information across studies to improve statistical inference. However,
the simple concordance model, which assumes that differential expression occurs
in either all studies or none of the studies, fails to capture study-specific dif-
ferentially expressed genes. A more flexible model which considers all possible
differential expression patterns faces the problem of exponentially growing pa-
rameter space when the number of studies increases. Here the R package Corm-
toif fits a Bayesian Hierachical model to address this dilemma while improving
inference on differential expression. The algorithm automatically searches for a
small number of latent probability vectors called correlation motif to capture
the major correlation patterns among multiple data sets. The motifs provide
the basis for sharing information across studies. The approach overcomes the
barrier of exponentially growing parameter space and is capable of handling a
large number of studies. Missing values are also handled by Cormtoif .

2 Data preparation

In order to fit the correlation motif model, one needs to call the function cormo-
tiffit. The first requirement exprs is the matrix containing the gene expression
data that needs to be analyzed. Each row of the matrix corresponds to a gene
and each column of the matrix corresponds to a sample. The data should be
normalized, for example by RMA, thus it is in log2 scale.

The second arguement, groupid, identifies the group label of each sample. Here
we use data simudata2 as an illustration. simudata2 are combined from four
studies sharing the same 3, 000 genes, each having two experimental conditions
and three samples for each condition.

> library(Cormotif)
> data(simudata2)
> colnames(simudata2)

1

[1] "gene" "R1"
"U2"
"X3"

[11] "U1"
[21] "X2"

"R2"
"U3"
"Y1"

"R3"
"V1"
"Y2"

"S1"
"V2"
"Y3"

"S2"
"V3"

"S3"
"W1"

"T1"
"W2"

"T2"
"W3"

"T3"
"X1"

> exprs.simu2<-as.matrix(simudata2[,2:25])
> data(simu2_groupid)
> simu2_groupid

R1 R2 R3 S1 S2 S3 T1 T2 T3 U1 U2 U3 V1 V2 V3 W1 W2 W3 X1 X2 X3 Y1 Y2 Y3
8 8
4 5

1 1

2 2

6 6

3 3

7 7

1

2

3

5

4

4

5

6

7

8

1

The third arguement, compid, represents the study design and hence the com-
parison pattern. In simudata2 , R1,R2,R3 are samples from condition 1 in study
1 and S1,S2,S3 are from condition 2 in study 1. Simiarly, T1,T2,T3 represent
condition 1 in study 2 and U1,U2,U3 represent condition 2 in study 2, and so
on so forth. We aim at detecting the differential expression pattern of a gene
under two different experimental conditions in each study, so we make up the
comparison matrix simu2_compgroup as following:

> data(simu2_compgroup)
> simu2_compgroup

Cond1 Cond2
2
4
6
8

1
3
5
7

1
2
3
4

3 Model fitting

3.1 No missing data

Once we have specified the group labels and the study design, we are able to fit
the correlation motif model. We can fit the data with varying motif numbers
and use information criterion, such as AIC or BIC, to select the best model.
Here for simudata2 , we fit 5 models with total motif patterns number varying
from 1 to 5. And we can see later from the BIC plot, using BIC criterion, the
best model is the one with 3 motifs.

> motif.fitted<-cormotiffit(exprs.simu2,simu2_groupid,simu2_compgroup,
+

K=1:5,max.iter=1000,BIC=TRUE)

2

[1] "We have run the first 50 iterations for K=2"
[1] "We have run the first 50 iterations for K=3"
[1] "We have run the first 100 iterations for K=3"
[1] "We have run the first 150 iterations for K=3"
[1] "We have run the first 200 iterations for K=3"
[1] "We have run the first 250 iterations for K=3"
[1] "We have run the first 300 iterations for K=3"
[1] "We have run the first 350 iterations for K=3"
[1] "We have run the first 400 iterations for K=3"
[1] "We have run the first 450 iterations for K=3"
[1] "We have run the first 500 iterations for K=3"
[1] "We have run the first 550 iterations for K=3"
[1] "We have run the first 600 iterations for K=3"
[1] "We have run the first 650 iterations for K=3"
[1] "We have run the first 50 iterations for K=4"
[1] "We have run the first 100 iterations for K=4"
[1] "We have run the first 150 iterations for K=4"
[1] "We have run the first 50 iterations for K=5"
[1] "We have run the first 100 iterations for K=5"
[1] "We have run the first 150 iterations for K=5"
[1] "We have run the first 200 iterations for K=5"
[1] "We have run the first 250 iterations for K=5"
[1] "We have run the first 300 iterations for K=5"
[1] "We have run the first 350 iterations for K=5"
[1] "We have run the first 400 iterations for K=5"
[1] "We have run the first 450 iterations for K=5"
[1] "We have run the first 500 iterations for K=5"
[1] "We have run the first 550 iterations for K=5"
[1] "We have run the first 600 iterations for K=5"
[1] "We have run the first 650 iterations for K=5"

After fitting the correlation motif model, we can check the BIC values obtained
by all cluster numbers:

> motif.fitted$bic

K

bic
[1,] 1 44688.73
[2,] 2 44235.62
[3,] 3 44210.05
[4,] 4 44227.07
[5,] 5 44247.30

> plotIC(motif.fitted)

3

To picture the motif patterns learned by the algorithm, we can use function
plotMotif. Each row in both graphs corresponds to the same one motif pat-
tern. We call the left graph pattern graph and the right bar chart frequency
graph . In the pattern graph, each row indicates a motif pattern and each column
represents a study. The grey scale of the cell (k, d) demonstrates the probabil-
ity of differential expression in study d for pattern k, and the values are stored
in motif.fitted$bestmotif$motif.prior. Each row of the frequency graph
corresponds to the motif pattern in the same row of the left pattern graph. The
length of the bar in the frequency graph shows the number of genes of the given
pattern in the dataset, which is equal to motif.fitted$bestmotif$motif.prior
multiplying the number of total genes.

> plotMotif(motif.fitted)

4

12345442004430044400445004460044700BICMotif NumberBIC12345441004420044300444004450044600AICMotif NumberAICThe posterior probability of differential expression for each gene in each study
is saved in motif.fitted$bestmotif$p.post

> head(motif.fitted$bestmotif$p.post)

[,3]

[,2]

[,1]

[,4]
[1,] 0.97793075 0.73598939 0.2691783 0.6931868
[2,] 0.99958238 0.31486060 0.9962636 0.9994624
[3,] 0.98275391 0.12177286 0.6968782 0.9984914
[4,] 0.02162949 0.04544011 0.2869910 0.2329644
[5,] 0.99897991 0.93540610 0.9971760 0.5837629
[6,] 0.04468472 0.93294178 0.9977773 0.1020185

And at 0.5 cutoff for the posterior distribution, the differential expression pat-
tern can be obtained as following:

> dif.pattern.simu2<-(motif.fitted$bestmotif$p.post>0.5)
> head(dif.pattern.simu2)

[,1]
[,2] [,3]
TRUE TRUE FALSE

[,4]
TRUE

[1,]

5

1234 patternStudyCorr. Motifs123 frequencyNo. of genes123269620795TRUE
TRUE

TRUE FALSE
TRUE FALSE

TRUE
[2,]
[3,]
TRUE
[4,] FALSE FALSE FALSE FALSE
TRUE
[5,]
TRUE
TRUE TRUE
TRUE FALSE
[6,] FALSE TRUE

We can aslo order the genes in each study according to their posterior probability
of differential expression:

> topgenelist<-generank(motif.fitted$bestmotif$p.post)
> head(topgenelist)

[,1] [,2] [,3] [,4]
59
221
38 238
330 288
249
355
286
319
66
96

117 394
23
196
97
31
355
73
63
177
62
454

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

3.2 With missing data

Cormtoif can handle data with missing values automatically. Especially here we
mimic a situtation where data are merged from studies conducted on different
platforms, where different platforms have non-overlapping genes. We set the
missing proportion to be 10%.

> misprop<-0.10

We assume the first two studies are conducted in one platform while the third
and fourth studies are conducted on another platform. We randomly set 10%
of non-overlapping genes in each platform to be missing. Therefore, 10% miss-
ing data actually means that 20% of genes are present in only one of the two
platforms.

> fullindex<-1:nrow(exprs.simu2)
> ##sample index to mimic the merging of studies from different platforms
> mis_index1<-sample(fullindex,misprop*length(fullindex))
> mis_index2<-sample(fullindex[-mis_index1],misprop*length(fullindex))
> exprs.simu2.missing<-exprs.simu2
> exprs.simu2.missing[mis_index1,1:12]<-NA
> exprs.simu2.missing[mis_index2,13:24]<-NA

Now we fit the model again on the dataset with missing values and check the
learned motifs.

6

> motif.fitted.missing<-cormotiffit(exprs.simu2.missing,simu2_groupid,simu2_compgroup,
+

K=1:5,max.iter=1000,BIC=TRUE)

[1] "We have run the first 50 iterations for K=2"
[1] "We have run the first 50 iterations for K=3"
[1] "We have run the first 100 iterations for K=3"
[1] "We have run the first 150 iterations for K=3"
[1] "We have run the first 50 iterations for K=4"
[1] "We have run the first 100 iterations for K=4"
[1] "We have run the first 150 iterations for K=4"
[1] "We have run the first 50 iterations for K=5"
[1] "We have run the first 100 iterations for K=5"
[1] "We have run the first 150 iterations for K=5"
[1] "We have run the first 200 iterations for K=5"
[1] "We have run the first 250 iterations for K=5"
[1] "We have run the first 300 iterations for K=5"
[1] "We have run the first 350 iterations for K=5"

> plotIC(motif.fitted.missing)
> plotMotif(motif.fitted.missing)

We can see that under 10% missingness our learned motif motif.fitted.missing
behaves similar to the original motif.fitted

7

1234539700398003990040000BICMotif NumberBIC123453960039700398003990040000AICMotif NumberAICFrom this example, we see that Cormtoif is able to deal with data merged from
different platforms with non-overlapping genes.

3.3 Other correlation motif fit

The all motif method applies a Bayesian model assuming that genes are either
differentially expressed in all studies or differentially expressed in none of the
studies.

> motif.fitted.all<-cormotiffitall(exprs.simu2,simu2_groupid,simu2_compgroup,max.iter=1)

The separate motif fits the mixture model to each study separately.

> motif.fitted.sep<-cormotiffitsep(exprs.simu2,simu2_groupid,simu2_compgroup,max.iter=1)

The full motif fits all 2D possible 0-1 motif patterns.

> motif.fitted.full<-cormotiffitfull(exprs.simu2,simu2_groupid,simu2_compgroup,max.iter=1)

8

1234 patternStudyCorr. Motifs123 frequencyNo. of genes123270519895References

[Ji(2011)] Ji, H., Wei, Y. (2011). Correlation Motif. Unpublished.

[Smyth 2004] Smyth, G.K. (2004), Linear models and empirical Bayes methods
for assessing differential expression in microarray experiments. Statistical
Applications in Genetics and Molecular Biology 3, Art. 3.

9

