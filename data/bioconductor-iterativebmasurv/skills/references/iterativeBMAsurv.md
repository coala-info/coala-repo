The Iterative Bayesian Model Averaging Algorithm for Survival
Analysis: an Improved Method for Gene Selection and Survival
Analysis on Microarray Data

Amalia Annest, Roger E. Bumgarner, Adrian E. Raftery, and Ka Yee Yeung

October 30, 2025

1 Introduction

Survival analysis is a supervised learning technique that in the context of microarray data is most fre-
quently used to identify genes whose expression levels are correlated with patient survival prognosis.
Survival analysis is generally applied to diseased samples for the purpose of analyzing time to event,
where the event can be any milestone of interest (e.g., metastases, relapse, or death). Typically, the
interest is in identifying genes that are predictive of a patient’s chances for survival. In such cases,
both the accuracy of the prediction and the number of genes necessary to obtain a given accuracy is
important. In particular, methods that select a small number of relevant genes and provide accurate
patient risk assessment can aid in the development of simpler diagnostic tests. In addition, methods
that adopt a weighted average approach over multiple models have the potential to provide more ac-
curate predictions than methods that do not take model uncertainty into consideration. To this end,
we developed the iterative Bayesian Model Averaging (BMA) method for gene selection and survival
analysis on microarray data [1]. Typical gene selection and survival analysis procedures ignore model
uncertainty and use a single set of relevant genes (model) to predict patient risk. BMA is a multivariate
technique that takes the interaction of variables (typically genes) and model uncertainty into account.
In addition, the output of BMA contains posterior probabilities for each prediction, which can be useful
in assessing the correctness of a given prognosis.

1.1 Bayesian Model Averaging (BMA)

Bayesian Model Averaging (BMA) takes model uncertainty into consideration by averaging over the
posterior distributions of a quantity of interest based on multiple models, weighted by their posterior
model probabilities [3]. The posterior probability that a test sample is at risk for the given event is the
posterior probability that the test sample is at risk for the given even computed using the set of relevant
genes in model Mk multiplied by the posterior probability of model Mk, summed over a set of ‘good’
models Mk.

1.2

Iterative Bayesian Model Averaging (BMA) Algorithm for Survival Analysis

The BMA algorithm we have described is limited to data in which the number of variables is greater
than the number of responses. In the case of performing survival analysis on microarray data, there

1

are typically thousands or tens of thousands of genes (variables) and only a few dozens samples (re-
sponses).

In this package, the iterative BMA algorithm for survival analysis is implemented. In the iterative
BMA algorithm for survival analysis, we start by ranking the genes in descending order of their log
likelihood using a univariate measure such as the Cox Proportional Hazards Model [2]. In this initial
preprocessing step, genes with a larger log likelihood are given a higher ranking. Once the dataset
is sorted, we apply the traditional BMA algorithm to the maxN var top log-ranked genes. We use
a default of maxN var = 25, because the traditional BMA algorithm employs the leaps and bounds
algorithm that is inefficient for numbers of genes (variables) greater than 30. In the next step, genes
to which the BMA algorithm assigns low posterior probabilities of being in the predictive model are
removed. In our study, we used 1% as the threshold and eliminated genes with posterior probabilities
< 1%. Suppose m genes are removed. The next m genes from the rank ordered log likelihood scores
are added back to the set of genes so that we maintain a window of maxN var genes and apply the
traditional BMA algorithm again. These steps of gene swaps and iterative applications of BMA are
continued until all genes are considered.

2 Some examples

The R package BMA is required to run the key commands in this package.

> library(BMA)
> library(iterativeBMAsurv)

An adapted diffuse large B-Cell lymphoma (DLBCL) dataset [4] is included for illustration pur-
poses. The adapted DLBCL dataset consists of the top 100 genes selected using the Cox Proportional
Hazards Model. The training set consists of 65 samples, while the test set consists of 36 samples. In
the following examples, we chose parameters to reduce computational time for illustrative purposes.
Please refer to our manuscript ([1]) for recommended input parameters.

> ## Use the sample training data. The data matrix is called trainData.
> data(trainData)
> ## The survival time vector for the training set is called trainSurv, where survival times are reported in years.
> data(trainSurv)
> ## The censor vector for the training set is called trainCens, where 0 = censored and 1 = uncensored.
> data(trainCens)

The function iterateBMAsurv.train selects relevant variables by iteratively applying the

bic.surv function from the BMA package until all variables are exhausted. The function iterateBMAsurv.train.wrapper
acts as a wrapper for iterateBMAsurv.train, initializing the bic.surv parameters and calling
iterateBMAsurv.train to launch the bic.surv iterations. When iterateBMAsurv.train.wrapper
is called, the data is assumed to be pre-sorted by rank and assumed to contain the desired number of
variables. In the training phase, only the sorted training dataset and the corresponding survival times
and censor data are required as input.

> ## Training phase: select relevant genes
> ## In this example training set, the top 100 genes have already been sorted in decreasing order of their log likelihood
> ret.list <- iterateBMAsurv.train.wrapper (x=trainData, surv.time=trainSurv, cens.vec=trainCens, nbest=5)

2

17: Explored up to variable # 100
Iterate bic.surv is done!
Selected genes:

[1] "X31687" "X33840" "X31242" "X16948" "X31471" "X17154" "X28531" "X19241"
[9] "X26146" "X17804" "X27332" "X17241" "X32212" "X29911" "X33558" "X33013"
[17] "X27884" "X33706" "X16817" "X31968" "X30209" "X29650" "X25054" "X16988"
[25] "X32904"
Posterior probabilities of selected genes:

[1] 100.0
0.0
[13]
[25] 100.0

47.5
0.0

47.3
10.0

2.4 38.5
2.5
0.0

28.5 40.1 96.7
98.8
2.1
58.3

2.8
28.4

1.7
7.1 95.1

0.0 59.9
0.0

> ## Extract the {\tt bic.surv} object
> ret.bic.surv <- ret.list$obj
> ## Extract the names of the genes from the last iteration of {\tt bic.surv}
> gene.names <- ret.list$curr.names
> ## Get the selected genes with probne0 > 0
> top.gene.names <- gene.names[ret.bic.surv$probne0 > 0]
> top.gene.names

[1] "X31687" "X33840" "X31242" "X16948" "X31471" "X17154" "X28531" "X19241"
[9] "X26146" "X17804" "X17241" "X33558" "X27884" "X33706" "X16817" "X31968"

[17] "X30209" "X29650" "X25054" "X32904"

> ## Get the posterior probabilities for the selected models
> ret.bic.surv$postprob

[1] 0.075782322 0.068183539 0.062240254 0.056227073 0.045761712 0.044794588
[7] 0.043328132 0.042831731 0.039567629 0.039285627 0.038997242 0.034867824
[13] 0.032225236 0.030210326 0.026904418 0.025508701 0.025052995 0.024869256
[19] 0.021711946 0.021061750 0.020689119 0.020114454 0.017345536 0.017179713
[25] 0.017104052 0.015294500 0.014059561 0.014050900 0.012658966 0.010182444
[31] 0.008768581 0.007844758 0.007014883 0.006609877 0.006555310 0.005115046

If all the variables are exhausted in the bic.surv iterations, the iterateBMAsurv.train.wrapper

function returns curr.names, or a vector containing the names of the variables in the last iteration of
bic.surv. It also returns an object of class bic.surv from the last iteration of bic.surv. This
object is a list consisting of many components. Here are some of the relevant components:

• namesx: The names of the variables in the last iteration of bic.surv.

• postprob: The posterior probabilities of the models selected. The length of this vector indi-

cates the number of models selected by BMA.

• which: A logical matrix with one row per model and one column per variable indicating whether

that variable is in the model.

3

• probne0: The posterior probability that each variable is non-zero (in percent) in the last itera-

tion of bic.surv. The length of this vector should be identical to that of curr.mat.

• mle: Matrix with one row per model and one column per variable giving the maximum likeli-

hood estimate of each coefficient for each model.

In the training phase, the relevant variables (genes) are selected using the training data, the survival
In the test phase, we call the function predictBicSurv with the
times, and the censor vector.
selected variables (genes), the selected models, and the corresponding posterior probabilities to predict
the risk scores for the patient samples in the test set. The predicted risk score of a test sample is equal
to the weighted average of the risk score of the test sample under each selected model, multiplied by
the predicted posterior probability of each model. Note that in this case, a model consists of a set of
genes, and different models can potentially have overlapping genes. The posterior probability of a gene
is equal to the sum of the posterior probabilities of all the models that the gene belongs to. Finally, the
function predictiveAssessCategory assigns each test sample to a risk group (either high-risk
or low-risk) based on the predicted risk score of the sample.

> ## The test data matrix is called testData.
> data(testData)
> ## The survival time vector for the test set is called testSurv, where survival times are reported in years
> data(testSurv)
> ## The censor vector for the test set is called testCens, where 0 = censored and 1 = uncensored
> data(testCens)
> ## Get the subset of test data with the genes from the last iteration of bic.surv
> curr.test.dat <- testData[, top.gene.names]
> ## Compute the predicted risk scores for the test samples
> y.pred.test <- apply (curr.test.dat, 1, predictBicSurv, postprob.vec=ret.bic.surv$postprob, mle.mat=ret.bic.surv$mle)
> ## Compute the risk scores for the training samples
> y.pred.train <- apply (trainData[, top.gene.names], 1, predictBicSurv, postprob.vec=ret.bic.surv$postprob, mle.mat=ret.bic.surv$mle)
> ## Assign risk categories for test samples
> ## Argument {\tt cutPoint} is the percentage cutoff for separating the high-risk group from the low-risk group
> ret.table <- predictiveAssessCategory (y.pred.test, y.pred.train, testCens, cutPoint=50)
> ## Extract risk group vector and risk group table
> risk.vector <- ret.table$groups
> risk.table <- ret.table$assign.risk
> risk.table

cens.vec.test

High Risk
Low Risk

0
1
8 10
7 11

> ## Create a survival object from the test set
> mySurv.obj <- Surv(testSurv, testCens)
> ## Extract statistics including p-value, chi-square, and variance matrix
> stats <- survdiff(mySurv.obj ~ unlist(risk.vector))
> stats

4

Call:
survdiff(formula = mySurv.obj ~ unlist(risk.vector))

unlist(risk.vector)=High Risk 18
18
unlist(risk.vector)=Low Risk

N Observed Expected (O-E)^2/E (O-E)^2/V
0.0538
0.0538

0.0267
0.0268

10.5
10.5

10
11

Chisq= 0.1

on 1 degrees of freedom, p= 0.8

The p-value is calculated using the central chi-square distribution.
The function iterateBMAsurv.train.predict.assess combines the training, predic-
tion, and test phases. The function begins by calling singleGeneCoxph, which sorts the genes
in descending order of their log likelihood. After calling iterateBMAsurv.train.wrapper to
conduct the bic.surv iterations, the algorithm predicts the risk scores for the test samples and as-
signs them to a risk group. Predictive accuracy is evaluated through the p-value and chi-square statistic,
along with a Kaplan-Meier survival analysis curve to serve as a pictorial nonparametric estimator of the
difference between risk groups. If the Cox Proportional Hazards Model is the desired univariate rank-
ing measure, then calling the function iterateBMAsurv.train.predict.assess is all that is
necessary for a complete survival analysis run. The parameter p represents the number of top univariate
sorted genes to be used in the iterative calls to the bic.surv algorithm. Our studies showed that a
relatively large p typically yields good results [5]. For simplicity, there are 100 genes in the sample
training set, and we used p= 100 in the iterative BMA algorithm for survival analysis. Experimenting
with greater p values, higher numbers of nbest models, and different percentage cutoffs for cutP oint
will likely yield more significant results than the following examples illustrate. The function returns a
list consisting of the following components:

• nvar: The number of variables selected by the last iteration of bic.surv.

• nmodel: The number of models selected by the last iteration of bic.surv.

• ypred: The predicted risk scores on the test samples.

• result.table: A 2 x 2 table indicating the number of test samples in each category (high-

risk/censored, high-risk/uncensored, low-risk/censored, low-risk/uncensored).

• statistics: An object of class survdiff that contains the statistics from survival analysis,

including the variance matrix, chi-square statistic, and p-value.

• success: A boolean variable returned as TRUE if both risk groups are present in the patient

test samples.

If all test samples are assigned to a single risk group or all samples are in the same censor category,

a boolean variable success is returned as FALSE.

> ## Use p=10 genes and nbest=5 for fast computation
> ret.bma <- iterateBMAsurv.train.predict.assess (train.dat=trainData, test.dat=testData, surv.time.train=trainSurv, surv.time.test=testSurv, cens.vec.train=trainCens, cens.vec.test=testCens, p=10, nbest=5)

5

1: Explored up to variable # 10
Iterate bic.surv is done!
Selected genes:

[1] "X33310" "X28197" "X19373" "X16527" "X27415" "X24394" "X28531" "X27585"
[9] "X27766" "X26940"

Posterior probabilities of selected genes:

[1] 100.0

18.9

16.9

0.0 19.6

0.0 47.0 12.6

0.0

4.3

# selected genes = 7
# selected models = 11
Risk Table:

cens.vec.test

High Risk
Low Risk

1
0
7
9
8 12

Call:
survdiff(formula = mySurv.obj ~ unlist(risk.groups))

unlist(risk.groups)=High Risk 16
20
unlist(risk.groups)=Low Risk

N Observed Expected (O-E)^2/E (O-E)^2/V
0.126
0.126

0.0752
0.0483

8.21
12.79

9
12

Chisq= 0.1

on 1 degrees of freedom, p= 0.7

[,2]
[,1]
[1,] 4.891446 -4.891446
4.891446
[2,] -4.891446
[1] 0.1262768

> ## Extract the statistics from this survival analysis run
> number.genes <- ret.bma$nvar
> number.models <- ret.bma$nmodel
> evaluate.success <- ret.bma$statistics
> evaluate.success

Call:
survdiff(formula = mySurv.obj ~ unlist(risk.groups))

unlist(risk.groups)=High Risk 16
20
unlist(risk.groups)=Low Risk

N Observed Expected (O-E)^2/E (O-E)^2/V
0.126
0.126

0.0752
0.0483

8.21
12.79

9
12

Chisq= 0.1

on 1 degrees of freedom, p= 0.7

The function crossVal performs k runs of n-fold cross validation on the training set, where
k and n are specified by the user through the noRuns and noFolds arguments respectively. The
crossVal function in this package can be used to evaluate the selected mathematical models and

6

determine the optimal input parameters for a given dataset. For each run of cross validation, the train-
ing set, survival times, and censor data are re-ordered according to a random permutation. For each
fold of cross validation, 1/nth of the data is set aside to act as the validation set. In each fold, the
iterateBMAsurv.train.predict.assess function is called in order to carry out a complete
run of survival analysis. This means the univariate ranking measure for this cross validation function
is Cox Proportional Hazards Regression; see iterateBMAsurv.train.wrapper to experiment
with alternate univariate ranking methods. With each run of cross validation, the survival analysis
statistics are saved and written to file. The output of this function is a series of files written to the
working R directory which give the fold results, run results, per-fold statistics, and average statistics
across all runs and all folds.

> ## Perform 1 run of 2-fold cross validation on the training set, using p=10 genes and nbest=5 for fast computation
> ## Argument {\tt diseaseType} specifies the type of disease present the training samples, used for writing to file
> cv <- crossVal (exset=trainData, survTime=trainSurv, censor=trainCens, diseaseType="DLBCL", noRuns=1, noFolds=2, p=10, nbest=5)

******************** BEGINNING CV RUN 1 ********************
---------- BEGINNING FOLD 1 ----------
1: Explored up to variable # 10
Iterate bic.surv is done!
Selected genes:

[1] "X33310" "X27731" "X26586" "X26940" "X17241" "X24394" "X33924" "X27585"
[9] "X19373" "X33585"

Posterior probabilities of selected genes:

[1] 75.7 64.1 98.7 49.6 28.1 45.3 42.7 33.1 11.5 15.2

# selected genes = 10
# selected models = 32
Risk Table:

cens.vec.test

High Risk
Low Risk

1
0
3 11
7

11

Call:
survdiff(formula = mySurv.obj ~ unlist(risk.groups))

unlist(risk.groups)=High Risk 14
18
unlist(risk.groups)=Low Risk

N Observed Expected (O-E)^2/E (O-E)^2/V
4.18
4.18

7.02
10.98

2.25
1.44

11
7

Chisq= 4.2

on 1 degrees of freedom, p= 0.04

[,2]
[,1]
[1,] 3.784496 -3.784496
[2,] -3.784496
3.784496
[1] 4.179244
---------- BEGINNING FOLD 2 ----------
1: Explored up to variable # 10
Iterate bic.surv is done!

7

Selected genes:

[1] "X26146" "X33791" "X34488" "X34015" "X16817" "X31806" "X30209" "X31968"
[9] "X32338" "X32042"

Posterior probabilities of selected genes:

[1] 14.6 86.8 11.9 83.8

0.0 11.9 11.5 30.9 98.9

2.3

# selected genes = 9
# selected models = 17
Risk Table:

cens.vec.test

0 1
High Risk 7 9
9 8
Low Risk

Call:
survdiff(formula = mySurv.obj ~ unlist(risk.groups))

unlist(risk.groups)=High Risk 16
17
unlist(risk.groups)=Low Risk

N Observed Expected (O-E)^2/E (O-E)^2/V
0.1
0.1

0.0504
0.0486

8.35
8.65

9
8

Chisq= 0.1

on 1 degrees of freedom, p= 0.8

[,2]
[,1]
[1,] 4.185087 -4.185087
[2,] -4.185087
4.185087
[1] 0.1004971
******************** END CV RUN 1 ********************
Overall results from this run:

Censored Uncensored Percent Uncensored
42.85714
66.66667

Low Risk
High Risk
Overall average result matrix over all runs:

20
10

15
20

15
20

20
10

Censored Uncensored Percent Uncensored
42.85714
66.66667

Low Risk
High Risk
Average p-value across all folds and all runs:
[1] 0.3960779
Standard deviation of p-values across all folds and all runs:
[1] 0.5022664
Average chi-square value across all folds and all runs:
[1] 2.139871
Standard deviation of chi-square across all folds and all runs:
[1] 2.88411

This package also contains the imageplot.iterate.bma.surv function, which allows for

the creation of a heatmap-style image to visualize the selected genes and models (see Figure 1).

In Figure 1, the BMA selected variables are shown on the vertical axis, and the BMA selected

8

Figure 1: An image plot showing the selected genes and models.

9

Models selected by iterativeBMAsurvModel #123468101316202532X17804X16817X16948X27884X26146X29650X33558X30209X17154X31471X28531X31242X33840X33706X17241X25054X19241X31968X32904X31687models are shown on the horizontal axis. The variables (genes) are sorted in decreasing order of the
posterior probability that the variable is not equal to 0 (probne0) from top to bottom. The models are
sorted in decreasing order of the model posterior probability (postprob) from left to right.

Acknowledgements

We would like to thank Isabelle Bichindaritz, Donald Chinn, Steve Hanks, Ian Painter, Deanna Petrochi-
los, and Chris Volinsky. Yeung is supported by NIH-NCI 1K25CA106988. Bumgarner is funded by
NIH-NHLBI P50 HL073996, NIH-NIAID U54 AI057141, NIH-NCRR R24 RR021863-01A1, NIH-
NIDCR R01 DE012212-06, NIH-NCRR 1 UL1 RR 025014-01, and a generous basic research grant
from Merck. Raftery is supported by NIH-NICHD 1R01HDO54511-01A1, NSF llS0534094, NSF
ATM0724721, and Office of Naval Research grant N00014-01-1-0745.

References

[1] A. Annest, R.E. Bumgarner, A.E. Raftery, and K.Y. Yeung. Iterative bayesian model averaging: A
method for the application of survival analysis to high-dimensional microarray data. Manuscript
in preparation, 2008.

[2] D. Cox. Regression models and life tables. Journal of the Royal Statistical Society, 34:187–220,

1972.

[3] A.E. Raftery. Bayesian model selection in social research (with discussion). Sociological Method-

ology, 25:111–196, 1995.

[4] A. Rosenwald, G. Wright, C. Wing, J. Connors, E. Campo, R. Fisher, R. Gascoyne, H. Muller-
Hermelink, E. Smeland, J. Giltnane, E. Hurt, H. Zhao, L. Averett, L. Yang, W. Wilson, E. Jaffe,
R. Simon, R. Klausner, J. Powell, P. Duffey, D. Longo, T. Greiner, D. Weisenburger, W. Sanger,
B. Dave, J. Lynch, J. Vose, J. Armitage, E. Montserrat, A. Lopez-Guillermo, T. Grogan, T. Miller,
M. LeBlanc, G. Ott, S. Kvaloy, J. Delabie, H. Holte, P. Krajci, T. Stokke, and L. Staudt. The use of
molecular profiling to predict survival after chemotherapy for diffuse large b-cell lymphoma. The
New England Journal of Medicine, 346(25):1937–1947, 2002.

[5] K.Y. Yeung, R.E. Bumgarner, and A.E. Raftery. Bayesian Model Averaging: Development of an
improved multi-class, gene selection and classification tool for microarray data. Bioinformatics,
21(10):2394–2402, 2005.

10

