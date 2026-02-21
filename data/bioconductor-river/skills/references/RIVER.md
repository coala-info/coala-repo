# RIVER

Yungil Kim

#### 30 October 2025

#### Abstract

A probabilistic modeling framework that jointly analyzes personal genome and transcriptome data to estimate the probability that a variant has regulatory impact in that individual.

#### Package

RIVER 1.34.0

# Contents

* [1 Introduction](#introduction)
* [2 Quick Start](#quick-start)
* [3 Two Main Functions](#two-main-functions)
  + [3.1 Evaluation of *RIVER*](#evaluation-of-river)
  + [3.2 Application of *RIVER*](#application-of-river)
* [4 Generation of custumized data for *RIVER*](#generation-of-custumized-data-for-river)
* [5 Basics](#basics)
  + [5.1 Installation of `RIVER`](#installation-of-river)
  + [5.2 Session Info](#session-info)
  + [5.3 Asking for Help](#asking-for-help)
  + [5.4 References](#references)
* [6 Appendices](#appendices)
  + [6.1 Optional parameters](#optional-parameters)
  + [6.2 Stability of Estimated Parameters with Different Parameter Initializations](#stability-of-estimated-parameters-with-different-parameter-initializations)

# 1 Introduction

`RIVER` is an `R` package of a probabilistic modeling framework, called
*RIVER (RNA-Informed Variant Effect on Regulation)*, that jointly analyzes
personal genome (WGS) and transcriptome data (RNA-seq) to estimate the
probability that a variant has regulatory impact in that individual.
It is based on a generative model that assumes that genomic annotations,
such as the location of a variant with respect to regulatory elements,
determine the prior probability that variant is a functional regulatory
variant, which is an unobserved variable. The functional regulatory variant
status then influences whether nearby genes are likely to display outlier
levels of gene expression in that person.

*RIVER* is a hierarchical Bayesian model that predicts the regulatory
effects of rare variants by integrating gene expression with genomic
annotations. The *RIVER* consists of three layers: a set of nodes
\(G = G\_{1}, ..., G\_{P}\) in the topmost layer representing \(P\) observed
genomic annotations over all rare variants near a particular gene,
a latent binary variable \(FR\) in the middle layer representing the unobserved
funcitonal regulatory status of the rare variants, and one binary node \(E\)
in the final layer representing expression outlier status of the nearby gene.
We model each conditional probability distribution as follows:
\[ FR | G \sim Bernoulli(\psi), \psi = logit^{-1}(\beta^T, G) \]
\[E | FR \sim Categorical(\theta\_{FR}) \]
\[ \beta\_i \sim N(0, \frac{1}{\lambda})\]
\[\theta\_{FR} \sim Beta(C,C)\]
with parameters \(\beta\) and \(\theta\) and
hyper-parameters \(\lambda\) and \(C\).

Because \(FR\) is unobserved, log-likelihood objective
of *RIVER* over instances \(n = 1, ..., N\),
\[
\sum\_{n=1}^{N} log\sum\_{FR\_n= 0}^{1} P(E\_n, G\_n, FR\_n | \beta, \theta),
\]
is non-convex. We therefore optimize model parameters via
Expectation-Maximization (EM) as follows:

In the E-step, we compute the posterior probabilities (\(\omega\_n^{(i)}\))
of the latent variables \(FR\_n\) given current parameters and observed data.
For example, at the \(i\)-th iteration, the posterior probability
of \(FR\_n = 1\) for the \(n\)-th instance is
\[
\omega\_{1n}^{(i)} = P(FR\_n = 1 | G\_n, \beta^{(i)}, E\_n, \theta^{(i)})
=\frac{P(FR\_n = 1 | G\_n, \beta^{(i)}) \cdotp P(E\_n | FR\_n = 1, \theta^{(i)})}{\sum\_{FR\_n = 0}^1 P(FR\_n | G\_n, \beta^{(i)}) \cdotp P(E\_n | FR\_n, \theta^{(i)})},
\]
\[\omega\_{0n}^{(i)} = 1 - \omega\_{1n}^{(i)}.\]

In the M-step, at the \(i\)-th iteration, given the current
estimates \(\omega^{(i)}\), the parameters (\(\beta^{(i+1)\*}\))
are estimated as
\[
\max\_{\beta^{(i+1)}} \sum\_{n = 1}^N \sum\_{FR\_n = 0}^1 log(P(FR\_n | G\_n, \beta^{(i+1)})) \cdotp \omega\_{FR, n}^{(i)} - \frac{\lambda}{2}||\beta^{(i+1)}||\_2,
\]
where \(\lambda\) is an L2 penalty hyper-parameter derived
from the Gaussian prior on \(\beta\).
The parameters \(\theta\) get updated as:
\[
\theta\_{s,t}^{(i+1)} = \sum\_{n = 1}^{N} I(E\_n = t) \cdotp \omega\_{s,n}^{(i)} + C.
\]
where \(I\) is an indicator operator, \(t\) is the binary value
of expression \(E\_n\), \(s\) is the possible binary values of \(FR\_n\)
and \(C\) is a pseudo count derived from the Beta prior on .
The E- and M-steps are applied iteratively until convergence.

[Back to Top](#top)

# 2 Quick Start

The purpose of this section is to provide users a general sense
of our package, `RIVER`, including components and their behaviors
and applications. We will briefly go over main functions,
observe basic operations and corresponding outcomes.
Throughout this section, users may have better ideas about which functions
are available, which values to be chosen for necessary parameters, and
where to seek help. More detailed descriptions are given in later sections.

First, we load `RIVER`:

```
library("RIVER")
```

`RIVER` consists of several functions mainly supporting two main functions
including `evaRIVER` and `appRIVER`, which we are about to show how to use
them here. We first load simulated data created beforehand for illustration.

```
filename <- system.file("extdata", "simulation_RIVER.gz",
                       package="RIVER")
dataInput <- getData(filename) # import experimental data
```

`getData` combines different resources including genomic features,
outlier status of gene expression, and N2 pairs having same rare variants
into standardized data structures, called `ExpressionSet` class.

```
print(dataInput)
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 18 features, 6122 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: indiv58:gene1614 indiv5:gene1331 ... indiv18:gene1111
##     (6122 total)
##   varLabels: Outlier N2pair
##   varMetadata: labelDescription
## featureData: none
## experimentData: use 'experimentData(object)'
## Annotation:
```

```
Feat <- t(Biobase::exprs(dataInput)) # genomic features (G)
Out <- as.numeric(unlist(dataInput$Outlier))-1 # outlier status (E)
```

In the simulated data, an input object `dataInput` consists of
18 genomic features and expression outlier status of 6122 samples and
which samples belong to N2 pairs.

```
head(Feat)
```

```
##                    Feature1   Feature2   Feature3   Feature4   Feature5
## indiv58:gene1614  0.4890338 -1.2143183 -0.5015241 -0.8093881 -0.1916957
## indiv5:gene1331  -4.1665487 -0.6355490 -1.0914989 -2.8069442 -0.3921658
## indiv76:gene447  -0.4469724 -0.9440314  0.7386942  0.6786997  0.6043647
## indiv16:gene126   1.6252083 -2.2686506  1.4156013 -0.5662072 -0.1405224
## indiv45:gene1044  0.3086791  1.0044798  0.8493856  0.3515569 -0.3763434
## indiv6:gene258    0.9046627  1.7618399 -1.6258895  0.3961724 -0.2203089
##                     Feature6   Feature7   Feature8   Feature9   Feature10
## indiv58:gene1614 -0.06614698  0.1993153 -0.7544253 -1.3505036 -0.03477715
## indiv5:gene1331  -0.43831006  1.8175888 -0.8411557  2.1495237 -0.48691686
## indiv76:gene447   1.47627930  0.6521233 -0.6416004  1.0309900 -0.38262446
## indiv16:gene126   2.11676989  1.0670951  0.3404799 -1.5970916 -0.49910751
## indiv45:gene1044  1.45269690 -0.8368466 -1.0016646  0.1908291 -0.26598159
## indiv6:gene258   -0.76821018 -1.3436283 -0.7201516  0.5440035  0.31006097
##                   Feature11  Feature12   Feature13  Feature14  Feature15
## indiv58:gene1614 2.08675352  0.7283183  0.15074710  1.5183579  0.2226134
## indiv5:gene1331  2.57339374  0.4840111  0.58897093 -0.2069596  0.1000502
## indiv76:gene447  0.30621172  0.6690835 -1.39701213  1.4853201  1.6552545
## indiv16:gene126  0.58599041 -0.7052013 -0.07715282 -1.3326831  0.1719152
## indiv45:gene1044 1.45029299 -0.4530850 -0.09610983  1.4731617 -0.9372256
## indiv6:gene258   0.05174989  0.4026417 -0.50911462 -0.3623563 -2.5279770
##                    Feature16  Feature17  Feature18
## indiv58:gene1614  1.88846321 -0.4408236 -0.4558111
## indiv5:gene1331   0.22640429  1.2535793 -1.0163254
## indiv76:gene447   0.71720775  0.2758493  1.1378452
## indiv16:gene126   1.12919669  0.6166061 -1.6069772
## indiv45:gene1044  0.14794114  1.2241711  1.4916670
## indiv6:gene258   -0.01574568 -1.5835940 -1.2366762
```

```
head(Out)
```

```
## [1] 1 1 1 0 1 1
```

`Feat` contains continuous values of genomic features (defined as \(G\)
in the objective function) while `Out` contains binary values
representing outlier status of same samples as `Feat` (defined as \(E\)
in the objective function).

For evaluation, we hold out pairs of individuals at genes
where only those two individuals shared the same rare variants.
Except for the list of instances, we train *RIVER* with the rest of instances,
compute the *RIVER* score (the posterior probability of having a functional
regulatory variant given both WGS and RNA-seq data) from one individual,
and assess the accuracy with respect to the second individual’s held-out
expression levels. Since there is currently quite few gold standard set of
functional rare variants, using this labeled test data allow us
to evaluate predictive accuracy of *RIVER* compared with genomic annotation model,
*GAM*, that uses genomic annotations alone. We can observe
a significant improvement by incorporating expression data.

To do so, we simply use `evaRIVER`:

```
evaROC <- evaRIVER(dataInput)
```

```
##  ::: EM iteration is terminated since it converges within a
##         predefined tolerance (0.001) :::
```

```
## Setting levels: control = 0, case = 1
```

```
## Setting direction: controls < cases
```

```
## Setting levels: control = 0, case = 1
```

```
## Setting direction: controls < cases
```

`evaROC` is an S4 object of class `evaRIVER` which contains
two AUC values from *RIVER* and *GAM*, specificity and sensitivity
measures from the two models, and p-value of comparing the two AUC values.

```
cat('AUC (GAM-genomic annotation model) = ', round(evaROC$GAM_auc,3), '\n')
```

```
## AUC (GAM-genomic annotation model) =  0.58
```

```
cat('AUC (RIVER) = ', round(evaROC$RIVER_auc,3), '\n')
```

```
## AUC (RIVER) =  0.8
```

```
cat('P-value ', format.pval(evaROC$pvalue, digits=2, eps=0.001), '***\n')
```

```
## P-value  <0.001 ***
```

We can visualize the ROC curves with AUC values:

```
par(mar=c(6.1, 6.1, 4.1, 4.1))
plot(NULL, xlim=c(0,1), ylim=c(0,1),
     xlab="False positive rate", ylab="True positive rate",
     cex.axis=1.3, cex.lab=1.6)
abline(0, 1, col="gray")
lines(1-evaROC$RIVER_spec, evaROC$RIVER_sens,
      type="s", col='dodgerblue', lwd=2)
lines(1-evaROC$GAM_spec, evaROC$GAM_sens,
      type="s", col='mediumpurple', lwd=2)
legend(0.7,0.2,c("RIVER","GAM"), lty=c(1,1), lwd=c(2,2),
       col=c("dodgerblue","mediumpurple"), cex=1.2,
       pt.cex=1.2, bty="n")
title(main=paste("AUC: RIVER = ", round(evaROC$RIVER_auc,3),
                 ", GAM = ", round(evaROC$GAM_auc,3),
                 ", P = ", format.pval(evaROC$pvalue, digits=2,
                                       eps=0.001),sep=""))
```

![](data:image/png;base64...)
Each ROC curve from either *RIVER* or *GAM* is computed by
comparing the posterior probability given available data
for the 1st individual with the outlier status of the 2nd individual
in the list of held-out pairs and vice versa.

To extract posterior probabilities for prioritizing functional rare variants
in any downstream analysis such as finding pathogenic rare variants in disease,
you simply run `appRIVER` to obtain the posterior probabilities:

```
postprobs <- appRIVER(dataInput)
```

```
##  ::: EM iteration is terminated since it converges within a
##         predefined tolerance (0.001) :::
```

`postprobs` is an S4 object of class `appRIVER` which contains
subject IDs, gene names, \(P(FR = 1 | G)\), \(P(FR = 1 | G, E)\), and `fitRIVER`,
all the relevant information of the fitted *RIVER* including hyperparamters
for further use.

Probabilities of rare variants being functional from *RIVER* and *GAM*
for a few samples are shown below:

```
example_probs <- data.frame(Subject=postprobs$indiv_name,
                           Gene=postprobs$gene_name,
                           RIVERpp=postprobs$RIVER_posterior,
                           GAMpp=postprobs$GAM_posterior)
head(example_probs)
```

```
##   Subject     Gene   RIVERpp     GAMpp
## 1 indiv58 gene1614 0.4303673 0.2319994
## 2  indiv5 gene1331 0.3597397 0.1939262
## 3 indiv76  gene447 0.5249447 0.3061179
## 4 indiv16  gene126 0.1316062 0.2447880
## 5 indiv45 gene1044 0.4488103 0.2370526
## 6  indiv6  gene258 0.3598831 0.1714101
```

From left to right, it shows subject ID, gene name, posterior probabilities
from *RIVER*, posterior probabilities from *GAM*.

To observe how much we can obtain additional information on functional
rare variants by integrating the outlier status of gene expression
into *RIVER* in the following figure.

```
plotPosteriors(postprobs, outliers=as.numeric(unlist(dataInput$Outlier))-1)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the RIVER package.
##   Please report the issue at <https://github.com/ipw012/RIVER/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the RIVER package.
##   Please report the issue at <https://github.com/ipw012/RIVER/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)
As shown in this figure, the integration of both genomic features and
expression outliers indeed provide higher quantitative power
for prioritizing functional rare variants. You can observe a few examples
of pathogenic regulatory variants based on posterior probabilities
from *RIVER* in our paper (<http://biorxiv.org/content/early/2016/09/09/074443>).

[Back to Top](#top)

# 3 Two Main Functions

## 3.1 Evaluation of *RIVER*

The function, `evaRIVER`, is to see how much we can gain additional information
by integrating an outlier status of gene expression into integrated models.
The prioritization of functional rare variants has difficulty in its evaluation
especially due to no gold standard class of the functionality of rare variants.
To come up with this limitation, we extract pairs of individuals for genes
having same rare variants and hold them out for the evaluation. In other words,
we train *RIVER* with all the instances except for those held-out pairs of individuals,
calculate posterior probabilities of functional regulatory variants
given genomic features and outlier status for the first individual, and
compare the probabilities with the second individual’s outlier status and vice versa.
You can simply observe how the entire steps of evaluating models including
both *RIVER* and *GAM* proceed by using `evaRIVER` with `verbose=TRUE`:

```
filename <- system.file("extdata", "simulation_RIVER.gz",
                       package="RIVER")
dataInput <- getData(filename) # import experimental data
evaROC <- evaRIVER(dataInput, pseudoc=50,
                   theta_init=matrix(c(.99, .01, .3, .7), nrow=2),
                   costs=c(100, 10, 1, .1, .01, 1e-3, 1e-4),
                   verbose=TRUE)
```

```
##  *** best lambda = 0.1 ***
##
##  *** RIVER: EM step 1
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.9523
##      M-step: norm(theta difference) = 0.1479, norm(beta difference) = 0.0081 ***
##
##  *** RIVER: EM step 2
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.918
##      M-step: norm(theta difference) = 0.0548, norm(beta difference) = 0.0099 ***
##
##  *** RIVER: EM step 3
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.8853
##      M-step: norm(theta difference) = 0.052, norm(beta difference) = 0.0103 ***
##
##  *** RIVER: EM step 4
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.8543
##      M-step: norm(theta difference) = 0.0492, norm(beta difference) = 0.0096 ***
##
##  *** RIVER: EM step 5
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.8248
##      M-step: norm(theta difference) = 0.0464, norm(beta difference) = 0.009 ***
##
##  *** RIVER: EM step 6
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.7972
##      M-step: norm(theta difference) = 0.0437, norm(beta difference) = 0.0084 ***
##
##  *** RIVER: EM step 7
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.7711
##      M-step: norm(theta difference) = 0.041, norm(beta difference) = 0.0077 ***
##
##  *** RIVER: EM step 8
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.7463
##      M-step: norm(theta difference) = 0.0383, norm(beta difference) = 0.0071 ***
##
##  *** RIVER: EM step 9
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.7235
##      M-step: norm(theta difference) = 0.0358, norm(beta difference) = 0.0066 ***
##
##  *** RIVER: EM step 10
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.7022
##      M-step: norm(theta difference) = 0.0333, norm(beta difference) = 0.0062 ***
##
##  *** RIVER: EM step 11
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.6821
##      M-step: norm(theta difference) = 0.031, norm(beta difference) = 0.0059 ***
##
##  *** RIVER: EM step 12
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.6633
##      M-step: norm(theta difference) = 0.0287, norm(beta difference) = 0.0056 ***
##
##  *** RIVER: EM step 13
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.6461
##      M-step: norm(theta difference) = 0.0266, norm(beta difference) = 0.0054 ***
##
##  *** RIVER: EM step 14
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.63
##      M-step: norm(theta difference) = 0.0246, norm(beta difference) = 0.0053 ***
##
##  *** RIVER: EM step 15
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.615
##      M-step: norm(theta difference) = 0.0227, norm(beta difference) = 0.0052 ***
##
##  *** RIVER: EM step 16
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.6009
##      M-step: norm(theta difference) = 0.0209, norm(beta difference) = 0.005 ***
##
##  *** RIVER: EM step 17
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5878
##      M-step: norm(theta difference) = 0.0192, norm(beta difference) = 0.0048 ***
##
##  *** RIVER: EM step 18
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5757
##      M-step: norm(theta difference) = 0.0177, norm(beta difference) = 0.0046 ***
##
##  *** RIVER: EM step 19
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5645
##      M-step: norm(theta difference) = 0.0163, norm(beta difference) = 0.0045 ***
##
##  *** RIVER: EM step 20
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5542
##      M-step: norm(theta difference) = 0.0149, norm(beta difference) = 0.0045 ***
##
##  *** RIVER: EM step 21
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5446
##      M-step: norm(theta difference) = 0.0137, norm(beta difference) = 0.0044 ***
##
##  *** RIVER: EM step 22
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5355
##      M-step: norm(theta difference) = 0.0126, norm(beta difference) = 0.0043 ***
##
##  *** RIVER: EM step 23
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5272
##      M-step: norm(theta difference) = 0.0115, norm(beta difference) = 0.0043 ***
##
##  *** RIVER: EM step 24
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5194
##      M-step: norm(theta difference) = 0.0106, norm(beta difference) = 0.0042 ***
##
##  *** RIVER: EM step 25
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5121
##      M-step: norm(theta difference) = 0.0097, norm(beta difference) = 0.0041 ***
##
##  *** RIVER: EM step 26
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5052
##      M-step: norm(theta difference) = 0.0088, norm(beta difference) = 0.004 ***
##
##  *** RIVER: EM step 27
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4988
##      M-step: norm(theta difference) = 0.0081, norm(beta difference) = 0.0038 ***
##
##  *** RIVER: EM step 28
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.493
##      M-step: norm(theta difference) = 0.0074, norm(beta difference) = 0.0037 ***
##
##  *** RIVER: EM step 29
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4873
##      M-step: norm(theta difference) = 0.0068, norm(beta difference) = 0.0036 ***
##
##  *** RIVER: EM step 30
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4821
##      M-step: norm(theta difference) = 0.0062, norm(beta difference) = 0.0034 ***
##
##  *** RIVER: EM step 31
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.477
##      M-step: norm(theta difference) = 0.0056, norm(beta difference) = 0.0033 ***
##
##  *** RIVER: EM step 32
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4722
##      M-step: norm(theta difference) = 0.0051, norm(beta difference) = 0.0031 ***
##
##  *** RIVER: EM step 33
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4678
##      M-step: norm(theta difference) = 0.0047, norm(beta difference) = 0.0029 ***
##
##  *** RIVER: EM step 34
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4635
##      M-step: norm(theta difference) = 0.0043, norm(beta difference) = 0.0028 ***
##
##  *** RIVER: EM step 35
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4596
##      M-step: norm(theta difference) = 0.0039, norm(beta difference) = 0.0027 ***
##
##  *** RIVER: EM step 36
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4558
##      M-step: norm(theta difference) = 0.0035, norm(beta difference) = 0.0025 ***
##
##  *** RIVER: EM step 37
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4523
##      M-step: norm(theta difference) = 0.0032, norm(beta difference) = 0.0024 ***
##
##  *** RIVER: EM step 38
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4489
##      M-step: norm(theta difference) = 0.0029, norm(beta difference) = 0.0022 ***
##
##  *** RIVER: EM step 39
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4457
##      M-step: norm(theta difference) = 0.0026, norm(beta difference) = 0.0021 ***
##
##  *** RIVER: EM step 40
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4426
##      M-step: norm(theta difference) = 0.0024, norm(beta difference) = 0.002 ***
##
##  *** RIVER: EM step 41
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4397
##      M-step: norm(theta difference) = 0.0021, norm(beta difference) = 0.0019 ***
##
##  *** RIVER: EM step 42
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4369
##      M-step: norm(theta difference) = 0.0019, norm(beta difference) = 0.0018 ***
##
##  *** RIVER: EM step 43
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4342
##      M-step: norm(theta difference) = 0.0017, norm(beta difference) = 0.0017 ***
##
##  *** RIVER: EM step 44
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4316
##      M-step: norm(theta difference) = 0.0015, norm(beta difference) = 0.0016 ***
##
##  *** RIVER: EM step 45
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4292
##      M-step: norm(theta difference) = 0.0014, norm(beta difference) = 0.0015 ***
##
##  *** RIVER: EM step 46
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4268
##      M-step: norm(theta difference) = 0.0012, norm(beta difference) = 0.0014 ***
##
##  *** RIVER: EM step 47
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4245
##      M-step: norm(theta difference) = 0.0011, norm(beta difference) = 0.0013 ***
##
##  *** RIVER: EM step 48
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4223
##      M-step: norm(theta difference) = 0.001, norm(beta difference) = 0.0013 ***
##
##  *** RIVER: EM step 49
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4202
##      M-step: norm(theta difference) = 8e-04, norm(beta difference) = 0.0012 ***
##
##  *** RIVER: EM step 50
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4181
##      M-step: norm(theta difference) = 7e-04, norm(beta difference) = 0.0011 ***
##
##  *** RIVER: EM step 51
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.416
##      M-step: norm(theta difference) = 7e-04, norm(beta difference) = 0.0011 ***
##
##  *** RIVER: EM step 52
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4141
##      M-step: norm(theta difference) = 8e-04, norm(beta difference) = 0.001 ***
##
##  *** RIVER: EM step 53
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4123
##      M-step: norm(theta difference) = 8e-04, norm(beta difference) = 0.001 ***
##
##  ::: EM iteration is terminated since it converges within a
##         predefined tolerance (0.001) :::
```

```
## Setting levels: control = 0, case = 1
```

```
## Setting direction: controls < cases
```

```
## Setting levels: control = 0, case = 1
```

```
## Setting direction: controls < cases
```

```
## *** AUC (GAM - genomic annotation model):  0.58
##     AUC (RIVER):  0.8
##      P-value:  <0.001 ***
```

`evaRIVER` requires a `ExpressionSet` class object containing genomic features,
outlier status, and a list of N2 pairs as an input and four optional parameters
including pseudo count, initial theta, a list of candidate \(\lambda\), and verbose.
The input class is obtained by running `getData` with an original gzipped file.
If you would like to know which format you should follow when generating
the original compressed file, refer to the section **4 Generation of custumized data for RIVER** below.
Most of optional parameters are set according to your input data.
The `pseudoc` is a hyperparameter for estimating `theta`, parameters
between an unobserved `FR` node and observed outlier `E` node.
Lower `pseudoc` provides higher reliance on observed data.
The `theta_init` is an initial set of theta parameters. From left to right,
the elements are \(P(E = 0 | FR = 0)\), \(P(E = 1 | FR = 0)\), \(P(E = 0 | FR = 1)\),
and \(P(E = 1 | FR = 1)\), respecitively. The `costs` are the list of
candidate \(\lambda\) for searching the best L2 penaly hyperparameter
for both *GAM* and *RIVER*. For more information on optional paramters,
see Appendix 5.1 for optional parameters and Appendix 5.2 for parameter
stabilities across different initializations.

To train *RIVER* with training data (all instances except for N2 pairs),
we first select best lambda value based on 10 cross-validation on
training dataset via `glmnet`. You can see the selected \(\lambda\) parameter
at the first line of output. The initial paramters of \(\beta\) in *RIVER*
were set based on the estimated \(\beta\) parameters from *GAM*.
In each EM iteration, the `evaRIVER` reports both the top 10 % threshold
of expected \(P(FR = 1 | G, E)\) and norms of difference between previous and
current estimates of parameters. The EM algorithm iteratively
find best estimates of both \(\beta\) and \(\theta\) until it converges
within the predefined tolerence of the norm (\(0.001\) for both \(\beta\) and \(\theta\)).
After the estimates of paramters converge, `evaRIVER` reports AUC values
from both models and its p-value of the difference between them.

[Back to Top](#top)

## 3.2 Application of *RIVER*

The function, `appRIVER`, is to train *RIVER* (and *GAM*) with all instances and
compute posterior probabilities of them for the future analyses (i.e. finding
pathogenic rare variants in disease). Same as `evaRIVER`, this function also
requires a `ExpressionSet` class object as an input and three optional parameters
which you can set again based on your data. If you use a certain set of values
for the optional parameters, you would use same ones here.

```
postprobs <- appRIVER(dataInput, pseudoc=50,
                      theta_init=matrix(c(.99, .01, .3, .7), nrow=2),
                      costs=c(100, 10, 1, .1, .01, 1e-3, 1e-4),
                      verbose=TRUE)
```

```
##  *** best lambda = 0.1 ***
##
##  *** RIVER: EM step 1
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.9542
##      M-step: norm(theta difference) = 0.1511, norm(beta difference) = 0.0081 ***
##
##  *** RIVER: EM step 2
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.9221
##      M-step: norm(theta difference) = 0.0522, norm(beta difference) = 0.0082 ***
##
##  *** RIVER: EM step 3
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.8916
##      M-step: norm(theta difference) = 0.0495, norm(beta difference) = 0.0084 ***
##
##  *** RIVER: EM step 4
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.8625
##      M-step: norm(theta difference) = 0.0469, norm(beta difference) = 0.0078 ***
##
##  *** RIVER: EM step 5
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.8352
##      M-step: norm(theta difference) = 0.0444, norm(beta difference) = 0.0072 ***
##
##  *** RIVER: EM step 6
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.8091
##      M-step: norm(theta difference) = 0.0418, norm(beta difference) = 0.0068 ***
##
##  *** RIVER: EM step 7
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.7845
##      M-step: norm(theta difference) = 0.0393, norm(beta difference) = 0.0062 ***
##
##  *** RIVER: EM step 8
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.7612
##      M-step: norm(theta difference) = 0.0369, norm(beta difference) = 0.0058 ***
##
##  *** RIVER: EM step 9
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.7393
##      M-step: norm(theta difference) = 0.0345, norm(beta difference) = 0.0054 ***
##
##  *** RIVER: EM step 10
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.7187
##      M-step: norm(theta difference) = 0.0323, norm(beta difference) = 0.0052 ***
##
##  *** RIVER: EM step 11
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.6995
##      M-step: norm(theta difference) = 0.0301, norm(beta difference) = 0.0048 ***
##
##  *** RIVER: EM step 12
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.6815
##      M-step: norm(theta difference) = 0.028, norm(beta difference) = 0.0046 ***
##
##  *** RIVER: EM step 13
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.6648
##      M-step: norm(theta difference) = 0.026, norm(beta difference) = 0.0044 ***
##
##  *** RIVER: EM step 14
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.6492
##      M-step: norm(theta difference) = 0.0241, norm(beta difference) = 0.0044 ***
##
##  *** RIVER: EM step 15
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.6347
##      M-step: norm(theta difference) = 0.0223, norm(beta difference) = 0.0043 ***
##
##  *** RIVER: EM step 16
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.6212
##      M-step: norm(theta difference) = 0.0206, norm(beta difference) = 0.0042 ***
##
##  *** RIVER: EM step 17
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.6084
##      M-step: norm(theta difference) = 0.019, norm(beta difference) = 0.0041 ***
##
##  *** RIVER: EM step 18
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5965
##      M-step: norm(theta difference) = 0.0176, norm(beta difference) = 0.004 ***
##
##  *** RIVER: EM step 19
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5853
##      M-step: norm(theta difference) = 0.0162, norm(beta difference) = 0.0039 ***
##
##  *** RIVER: EM step 20
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5751
##      M-step: norm(theta difference) = 0.0149, norm(beta difference) = 0.0038 ***
##
##  *** RIVER: EM step 21
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5654
##      M-step: norm(theta difference) = 0.0137, norm(beta difference) = 0.0038 ***
##
##  *** RIVER: EM step 22
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5563
##      M-step: norm(theta difference) = 0.0126, norm(beta difference) = 0.0037 ***
##
##  *** RIVER: EM step 23
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5478
##      M-step: norm(theta difference) = 0.0116, norm(beta difference) = 0.0036 ***
##
##  *** RIVER: EM step 24
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.54
##      M-step: norm(theta difference) = 0.0107, norm(beta difference) = 0.0035 ***
##
##  *** RIVER: EM step 25
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5326
##      M-step: norm(theta difference) = 0.0098, norm(beta difference) = 0.0035 ***
##
##  *** RIVER: EM step 26
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5258
##      M-step: norm(theta difference) = 0.009, norm(beta difference) = 0.0034 ***
##
##  *** RIVER: EM step 27
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5194
##      M-step: norm(theta difference) = 0.0083, norm(beta difference) = 0.0033 ***
##
##  *** RIVER: EM step 28
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5133
##      M-step: norm(theta difference) = 0.0076, norm(beta difference) = 0.0032 ***
##
##  *** RIVER: EM step 29
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5077
##      M-step: norm(theta difference) = 0.007, norm(beta difference) = 0.003 ***
##
##  *** RIVER: EM step 30
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.5023
##      M-step: norm(theta difference) = 0.0064, norm(beta difference) = 0.0029 ***
##
##  *** RIVER: EM step 31
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4974
##      M-step: norm(theta difference) = 0.0058, norm(beta difference) = 0.0028 ***
##
##  *** RIVER: EM step 32
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4927
##      M-step: norm(theta difference) = 0.0053, norm(beta difference) = 0.0027 ***
##
##  *** RIVER: EM step 33
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4882
##      M-step: norm(theta difference) = 0.0049, norm(beta difference) = 0.0025 ***
##
##  *** RIVER: EM step 34
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4841
##      M-step: norm(theta difference) = 0.0045, norm(beta difference) = 0.0024 ***
##
##  *** RIVER: EM step 35
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.48
##      M-step: norm(theta difference) = 0.0041, norm(beta difference) = 0.0023 ***
##
##  *** RIVER: EM step 36
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4763
##      M-step: norm(theta difference) = 0.0037, norm(beta difference) = 0.0022 ***
##
##  *** RIVER: EM step 37
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4728
##      M-step: norm(theta difference) = 0.0034, norm(beta difference) = 0.0021 ***
##
##  *** RIVER: EM step 38
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4694
##      M-step: norm(theta difference) = 0.0031, norm(beta difference) = 0.002 ***
##
##  *** RIVER: EM step 39
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4662
##      M-step: norm(theta difference) = 0.0028, norm(beta difference) = 0.0018 ***
##
##  *** RIVER: EM step 40
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4631
##      M-step: norm(theta difference) = 0.0025, norm(beta difference) = 0.0017 ***
##
##  *** RIVER: EM step 41
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4601
##      M-step: norm(theta difference) = 0.0023, norm(beta difference) = 0.0016 ***
##
##  *** RIVER: EM step 42
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4573
##      M-step: norm(theta difference) = 0.0021, norm(beta difference) = 0.0016 ***
##
##  *** RIVER: EM step 43
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4547
##      M-step: norm(theta difference) = 0.0019, norm(beta difference) = 0.0015 ***
##
##  *** RIVER: EM step 44
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4521
##      M-step: norm(theta difference) = 0.0017, norm(beta difference) = 0.0014 ***
##
##  *** RIVER: EM step 45
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4497
##      M-step: norm(theta difference) = 0.0015, norm(beta difference) = 0.0013 ***
##
##  *** RIVER: EM step 46
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4473
##      M-step: norm(theta difference) = 0.0014, norm(beta difference) = 0.0012 ***
##
##  *** RIVER: EM step 47
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.445
##      M-step: norm(theta difference) = 0.0012, norm(beta difference) = 0.0012 ***
##
##  *** RIVER: EM step 48
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4427
##      M-step: norm(theta difference) = 0.0011, norm(beta difference) = 0.0011 ***
##
##  *** RIVER: EM step 49
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4406
##      M-step: norm(theta difference) = 0.001, norm(beta difference) = 0.001 ***
##
##  *** RIVER: EM step 50
##      E-step: Top 10 % Threshold of expected P(FR=1 | G, E): 0.4386
##      M-step: norm(theta difference) = 9e-04, norm(beta difference) = 0.001 ***
##
##  ::: EM iteration is terminated since it converges within a
##         predefined tolerance (0.001) :::
```

Like the reported procedures from `evaRIVER`, we can recognize which \(\lambda\)
is set and variant top 10 % threshold of expected \(P(FR = 1 | G, E)\) and
norms of difference during each of EM iteractions.

If you would like to observe estimated parameters associated with genomic features
(\(\beta\)) and outliers (\(\theta\)), you can simply use `print` for the corresponding
parameters of interest.

```
print(postprobs$fitRIVER$beta)
```

```
##      Feature1      Feature2      Feature3      Feature4      Feature5
##  0.0468452545  0.0006976417  0.0723175214  0.0763155944  0.0427705093
##      Feature6      Feature7      Feature8      Feature9     Feature10
##  0.0269997566  0.0734000766 -0.0206468997  0.0248426648 -0.0012436251
##     Feature11     Feature12     Feature13     Feature14     Feature15
##  0.0060632810  0.0358184099 -0.0044748430  0.0453044233  0.0481758514
##     Feature16     Feature17     Feature18
## -0.0005280174  0.0079277389 -0.0084118400
```

```
print(postprobs$fitRIVER$theta)
```

```
##           [,1]      [,2]
## [1,] 0.8394424 0.4784675
## [2,] 0.1605576 0.5215325
```

These parameters can be used for computing test posterior probabilities of
new instances given their \(G\) and \(E\) for further analyses.

[Back to Top](#top)

# 4 Generation of custumized data for *RIVER*

An original compressed file, generated from all necessary processed data
including genomic features from various genomic annotations, Z-scores
from gene expression, and a list of N2 pairs based on WGS, contains
all the information.

```
filename <- system.file("extdata", "simulation_RIVER.gz",
                       package = "RIVER")
system(paste('zcat ', filename, " | head  -2", sep=""),
       ignore.stderr=TRUE)
```

From right to left column in each row, the data includes subject ID,
gene name, values of genomic features of interest (18 features here),
Z-scores of corresponding gene expression, and either integer values or
*NA* representing the existence/absence in N2 pairs sharing same rare variants.
If one subject has a unique set of rare variants compared to other subjects
near a particular gene, *NA* is assigned in N2pair column. Otherwise,
two subjects sharing same rare variants in any gene have same integers
as unique identifiers of each of N2 pairs.

If you would like to train RIVER with your own data, you need to generate
your own compressed file having same file format as explained above.
Then, you simply put an entire path of your compressed data file
into `getData` which generates a `ExpressionSet` class object
(`YourInputToRIVER`) with all necessary information for running RIVER
with your own data.

```
YourInputToRIVER <- getData(filename) # import experimental data
```

For our paper, genomic features were generated from various genomic annotations
including conservation scores like Gerp, chromatin states from chromHMM or segway,
and other summary scores such as CADD and DANN. The intances were selected
based on two criteria: (1) any genes having at least one individual outlier
in term of z-scores of gene expression and (2) any individuals having
at least one rare variant within specific regions near each gene.
In each instance, the feature values within regions of interest were aggreated
into one summary statistics by applying relevant mathematical operations like max.
In more details of a list of genomic annotations used for constructing features and
how to generate the features and outlier status, please refer to our publication
[pre-print](http://biorxiv.org/content/early/2016/09/09/074443).

[Back to Top](#top)

# 5 Basics

## 5.1 Installation of `RIVER`

`R` is an open-source statistical environment which can be easily modified
to enhance its functionality via packages. `RIVER` is a `R` package available
via the [Bioconductor](https://www.bioconductor.org/packages/release/BiocViews.html#___Software)
repository for packages. `R` can be installed on any operating system from
[CRAN](https://cran.r-project.org/) after which you can install `RIVER`
by using the following commands in your `R` session:

```
## try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("RIVER")
```

[Back to Top](#top)

## 5.2 Session Info

Here is the output of sessionInfo() on the system on which this document
was compiled:

```
## Session info
library('devtools')
```

```
## Loading required package: usethis
```

```
options(width=120)
session_info()
```

```
## ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.5.1 Patched (2025-08-23 r88802)
##  os       Ubuntu 24.04.3 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2025-10-30
##  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
##  quarto   1.7.32 @ /usr/local/bin/quarto
##
## ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
##  package      * version  date (UTC) lib source
##  Biobase        2.70.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocGenerics   0.56.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocManager    1.30.26  2025-06-05 [2] CRAN (R 4.5.1)
##  BiocStyle    * 2.38.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bookdown       0.45     2025-10-03 [2] CRAN (R 4.5.1)
##  bslib          0.9.0    2025-01-30 [2] CRAN (R 4.5.1)
##  cachem         1.1.0    2024-05-16 [2] CRAN (R 4.5.1)
##  cli            3.6.5    2025-04-23 [2] CRAN (R 4.5.1)
##  codetools      0.2-20   2024-03-31 [3] CRAN (R 4.5.1)
##  crayon         1.5.3    2024-06-20 [2] CRAN (R 4.5.1)
##  devtools     * 2.4.6    2025-10-03 [2] CRAN (R 4.5.1)
##  dichromat      2.0-0.1  2022-05-02 [2] CRAN (R 4.5.1)
##  digest         0.6.37   2024-08-19 [2] CRAN (R 4.5.1)
##  dplyr          1.1.4    2023-11-17 [2] CRAN (R 4.5.1)
##  ellipsis       0.3.2    2021-04-29 [2] CRAN (R 4.5.1)
##  evaluate       1.0.5    2025-08-27 [2] CRAN (R 4.5.1)
##  farver         2.1.2    2024-05-13 [2] CRAN (R 4.5.1)
##  fastmap        1.2.0    2024-05-15 [2] CRAN (R 4.5.1)
##  foreach        1.5.2    2022-02-02 [2] CRAN (R 4.5.1)
##  fs             1.6.6    2025-04-12 [2] CRAN (R 4.5.1)
##  generics       0.1.4    2025-05-09 [2] CRAN (R 4.5.1)
##  ggplot2        4.0.0    2025-09-11 [2] CRAN (R 4.5.1)
##  glmnet         4.1-10   2025-07-17 [2] CRAN (R 4.5.1)
##  glue           1.8.0    2024-09-30 [2] CRAN (R 4.5.1)
##  gtable         0.3.6    2024-10-25 [2] CRAN (R 4.5.1)
##  htmltools      0.5.8.1  2024-04-04 [2] CRAN (R 4.5.1)
##  iterators      1.0.14   2022-02-05 [2] CRAN (R 4.5.1)
##  jquerylib      0.1.4    2021-04-26 [2] CRAN (R 4.5.1)
##  jsonlite       2.0.0    2025-03-27 [2] CRAN (R 4.5.1)
##  knitr          1.50     2025-03-16 [2] CRAN (R 4.5.1)
##  labeling       0.4.3    2023-08-29 [2] CRAN (R 4.5.1)
##  lattice        0.22-7   2025-04-02 [3] CRAN (R 4.5.1)
##  lifecycle      1.0.4    2023-11-07 [2] CRAN (R 4.5.1)
##  magick         2.9.0    2025-09-08 [2] CRAN (R 4.5.1)
##  magrittr       2.0.4    2025-09-12 [2] CRAN (R 4.5.1)
##  Matrix         1.7-4    2025-08-28 [3] CRAN (R 4.5.1)
##  memoise        2.0.1    2021-11-26 [2] CRAN (R 4.5.1)
##  pillar         1.11.1   2025-09-17 [2] CRAN (R 4.5.1)
##  pkgbuild       1.4.8    2025-05-26 [2] CRAN (R 4.5.1)
##  pkgconfig      2.0.3    2019-09-22 [2] CRAN (R 4.5.1)
##  pkgload        1.4.1    2025-09-23 [2] CRAN (R 4.5.1)
##  pROC           1.19.0.1 2025-07-31 [2] CRAN (R 4.5.1)
##  purrr          1.1.0    2025-07-10 [2] CRAN (R 4.5.1)
##  R6             2.6.1    2025-02-15 [2] CRAN (R 4.5.1)
##  RColorBrewer   1.1-3    2022-04-03 [2] CRAN (R 4.5.1)
##  Rcpp           1.1.0    2025-07-02 [2] CRAN (R 4.5.1)
##  remotes        2.5.0    2024-03-17 [2] CRAN (R 4.5.1)
##  RIVER        * 1.34.0   2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
##  rlang          1.1.6    2025-04-11 [2] CRAN (R 4.5.1)
##  rmarkdown      2.30     2025-09-28 [2] CRAN (R 4.5.1)
##  S7             0.2.0    2024-11-07 [2] CRAN (R 4.5.1)
##  sass           0.4.10   2025-04-11 [2] CRAN (R 4.5.1)
##  scales         1.4.0    2025-04-24 [2] CRAN (R 4.5.1)
##  sessioninfo    1.2.3    2025-02-05 [2] CRAN (R 4.5.1)
##  shape          1.4.6.1  2024-02-23 [2] CRAN (R 4.5.1)
##  survival       3.8-3    2024-12-17 [3] CRAN (R 4.5.1)
##  tibble         3.3.0    2025-06-08 [2] CRAN (R 4.5.1)
##  tidyselect     1.2.1    2024-03-11 [2] CRAN (R 4.5.1)
##  tinytex        0.57     2025-04-15 [2] CRAN (R 4.5.1)
##  usethis      * 3.2.1    2025-09-06 [2] CRAN (R 4.5.1)
##  vctrs          0.6.5    2023-12-01 [2] CRAN (R 4.5.1)
##  withr          3.0.2    2024-10-28 [2] CRAN (R 4.5.1)
##  xfun           0.53     2025-08-19 [2] CRAN (R 4.5.1)
##  yaml           2.3.10   2024-07-26 [2] CRAN (R 4.5.1)
##
##  [1] /tmp/Rtmp1oqPRP/Rinst2b60594094e612
##  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
##  [3] /home/biocbuild/bbs-3.22-bioc/R/library
##  * ── Packages attached to the search path.
##
## ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

[Back to Top](#top)

## 5.3 Asking for Help

As package developers, we try to explain clearly how to use our packages
and in which order to use the functions. But `R` and `Bioconductor` have
a steep learning curve so it is critical to learn where to ask for help.
The blog post quoted above mentions some but we would like to highlight
the [Bioconductor support site](https://support.bioconductor.org/)
as the main resource for getting help. Other alternatives are available
such as creating GitHub issues and tweeting. However, please note that
if you want to receive help you should adhere to the
[posting guidlines](http://www.bioconductor.org/help/support/posting-guide/).
It is particularly critical that you provide a small reproducible example
and your session information so package developers can track down
the source of the error.

[Back to Top](#top)

## 5.4 References

Xin Li\(^{\*}\), Yungil Kim\(^{\*}\), Emily K. Tsang\(^{\*}\), Joe R. Davis\(^{\*}\), Farhan N. Damani, Colby Chiang, Zachary Zappala, Benjamin J. Strober, Alexandra J. Scott, Andrea Ganna, Jason Merker, GTEx Consortium, Ira M. Hall, Alexis Battle\(^{\#}\), Stephen B. Montgomery\(^{\#}\) (2016).
[The impact of rare variation on gene expression across tissues](http://biorxiv.org/content/early/2016/09/09/074443)
*(in arXiv, submitted, \*: equal contribution, #: corresponding authors)*

[Back to Top](#top)

# 6 Appendices

## 6.1 Optional parameters

Functions within `RIVER` have a set of optional parameters which control
some aspects of the computation of *RIVER* scores. The *factory default*
settings are expected to serve in many cases, but users might need
to make changes based on the input data.

There are four parameters that users can change:

`pseudoc` - Pseudo count (hyperparameter) in a beta distribution for \(\theta\); *factory default = 50*

`theta_init` - Initial values of \(\theta\); *factory default = (P(E = 0 | FR = 0), P(E = 1 | FR = 0), P(E = 0 | FR = 1), P(E = 1 | FR = 1)) = (0.99, 0.01, 0.3, 0.7)*

`costs` - List of candidate \(\lambda\) values for finding a best \(\lambda\) (hyperparameter). A best \(\lambda\) value among the candidate list is selected from L2-regularized logistic regression (*GAM*) via 10 cross-validation; *factory default = (100, 10, 1, .1, .01, 1e-3, 1e-4)*

`verbose` - If you set this parameter as `TRUE`, you observe
how parameters including \(\theta\) and \(\beta\) converge
until their updates at each EM iteration are within predefined tolerance levels
(one norm of the difference between current and previous parameters < 1e-3); *factory default = `FALSE`*

Note that initial values of \(\beta\) are generated from
L2-regularized logistic regression (*GAM*) with
pre-selected \(\lambda\) from 10 cross-validation.

[Back to Top](#top)

## 6.2 Stability of Estimated Parameters with Different Parameter Initializations

In this section, we reports how several different initialization parameters
for either \(\beta\) or \(\theta\) affect the estimated parameters.
We initialized a noisy \(\beta\) by adding K% Gaussian noise compared to the mean
of \(\beta\) with fixed \(\theta\) (for K = 10, 20, 50 100, 200, 400, 800).
For \(\theta\), we fixed P(E = 1 | FR = 0) and P(E = 0 | FR = 0) as 0.01 and 0.99,
respectively, and initialized (P(E = 1 | FR = 1), P(E = 0 | FR = 1))
as (0.1, 0.9), (0.4, 0.6), and (0.45, 0.55) instead of (0.3, 0.7) with \(\beta\) fixed.
For each parameter initialization, we computed Spearman rank correlations
between parameters from *RIVER* using the original initialization and
the alternative initializations. We also investigated how many instances
within top 10% of posterior probabilities from *RIVER* under the original settings
were replicated in the top 10% of posterior probabilities under the alternative
initializations. We also tried five different values of pseudoc as 10, 20, 30, 75, and 100
with default settings of \(\beta\) and \(\theta\) and computed
both Spearman rank correlations and accuracy as explained above.

| Parameter | Initialization | Spearman ρ | Accuracy |
| --- | --- | --- | --- |
|  | 10% noise | > .999 | 0.880 |
|  | 25% noise | > .999 | 0.862 |
|  | 50% noise | > .999 | 0.849 |
| \(\beta\) | 100% noise | > .999 | 0.848 |
|  | 200% noise | > .999 | 0.843 |
|  | 400% noise | > .999 | 0.846 |
|  | 800% noise | > .999 | 0.846 |
|  | [0.1, 0.9] | > .999 | 0.841 |
| \(\theta\) | [0.4, 0.6] | > .999 | 1.000 |
|  | [0.45, 0.55] | > .999 | 1.000 |
|  | 10 | .988 | 0.934 |
|  | 20 | .996 | 0.955 |
| pseudoc | 30 | .999 | 0.972 |
|  | 75 | .999 | 0.979 |
|  | 100 | .998 | 0.967 |

[Back to Top](#top)