BGmix

Alex Lewin∗, Natalia Bochkina†

April 24, 2017

∗Centre for Biostatistics, Department of Epidemiology and Public Health,
Imperial College London
†School of Mathematics, University of Edinburgh
http://www.bgx.org.uk/alex/
a.m.lewin@imperial.ac.uk

Contents

1 Overview

2 Data format

3 Experimental design

3.1 Diﬀerential expression, unpaired data
. . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Diﬀerential expression, paired data . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 Multi-class data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Example: How to run the model

5 Plotting the results

6 Predictive model checking

7 Tail posterior probability

8 Model options

9 Other functions

10 Acknowledgements

1 Overview

1

2

2
3
3
3

3

4

6

8

10

10

10

The BGmix package implements the models used in Lewin et al. (2007) for ﬁnding diﬀerential ex-
pression for genes in two or more samples. When there are two samples, a 3-component mixture
is used to classify genes as over-expressed, under-expressed and non-diﬀerentially expressed, and

1

gene variances are modelled exchangeably to allow for variability between genes. The model is fully
Bayesian, estimating the proportion of diﬀerentially expressed genes and the mixture parameters
simultaneously. The model can also be run with unstructured priors, for use with multi-class data.

Several diﬀerent parametric models are possible. An important part of the analysis is to check if
the model is a reasonable ﬁt to the data, and we do this via predictive checks.

The analysis is carried out using Markov Chain Monte Carlo. Convergence of the output can be
checked using the coda package available from CRAN. We also provide a function to plot the trace
of the parameters as part of the BGmix package.

Two alternatives are provided for assessing error rates. With the mixture model, an estimate of
the false discovery rate (FDR) based on posterior probabilities can be calculated. For unstructured
priors, a tail posterior probability method (Bochkina & Richardson (2007)) can be used.

The input to the model can be expression data processed by any algorithm. We provide a function
readBGX to read in the output from the package BGX, which is a fully Bayesian hierarchical model
for obtaining gene expression measures (Hein et al. (2005)).

2 Data format

Data input to BGmix consists of sample mean and sample variance for each gene, under each
experimental condition. Three R objects are required as arguments to the BGmix function:

(cid:136) ybar: a matrix, whose columns correspond to experimental conditions and rows correspond

to genes. Each column contains sample means for all genes under one condition.

(cid:136) ss: a matrix, whose columns correspond to experimental conditions and rows correspond to
genes. Each column contains sample variances for all genes under one condition. Sample
variances must be the unbiased estimates, i.e. divide by no. replicates - 1 (this is the default
for the standard R var function).

(cid:136) nreps: a vector containing the number of replicates in each condition.

Note that for a paired design, the data is treated as having only one ‘condition’, and ybar is then
the mean diﬀerence between the two experimental conditions.

The data must be transformed so that Normal sampling errors are a reasonable assumption (eg.
with a log or shifted-log transform), and normalised if necessary.

3 Experimental design

The ﬁrst level of the model can be written as a regression for each gene:

where ¯yg is the vector of sample means for diﬀerent conditions and βg is a vector of eﬀect param-
eters. Diﬀerent parametrisations can be achieved using the ‘design’ matrix X. At most 1 eﬀect

¯yg = X T .βg + (cid:15)g

(1)

2

parameter can have a mixture prior. (This will generally be the diﬀerential expression parameter.)

By default, genes have a separate variance parameter for each condition (σ2
gc). However, a more
general variance structure can be used, for instance each gene can have one variance across all
conditions (σ2

g ).

The BGmix function takes four arguments relating to the parametrisation:

(cid:136) xx: design matrix X. The dimensions of X must be no. eﬀects x no. conditions.

(cid:136) jstar: label of the eﬀect which has the mixture prior. Labels start at 0, since this is passed

to C++. If all parameters are ﬁxed eﬀects, set jstar = -1.

(cid:136) ntau: the number of variance parameters for each gene.

(cid:136) indtau: label for each condition indicating which variance grouping that condition belongs

to. The length of indtau must be the same as the number of conditions.

The defaults for these parameters are those for the diﬀerential expression, unpaired data case
(see below).

3.1 Diﬀerential expression, unpaired data

For unpaired data βg1 is the overall mean for gene g and βg2 is the diﬀerential expression parameter.

Here X =

, jstar = 1.

(cid:18) 1

(cid:19)

1

−1/2 1/2

Two variance structures are commonly used: for gene variances per condition (σ2
indtau = 0:1. For one variance across all conditions (σ2

g ), use ntau = 1, indtau = 0.

gc), use ntau = 2,

3.2 Diﬀerential expression, paired data

For paired data there is only one condition and one eﬀect, which is the diﬀerential expression
parameter. Here X = 1, jstar = 0, ntau = 1, indtau = 0.

3.3 Multi-class data

If one ﬁxed eﬀect per condition is required, set X to be the identity matrix and jstar = -1. For
gene variances per condition (σ2
gc), use ntau = no. conditions, indtau = 0:(nconds-1). For one
variance across all conditions (σ2
g ), use ntau = 1, indtau = 0.

4 Example: How to run the model

At a minimum, you must consider the data set and experimental design parameters in order to run
the model (see Sections 2 and 3).

We demonstrate BGmix on a small simulated data set. This consists of 8 replicates of 1000 genes
in 2 experimental conditions. We look for diﬀerential expression between the two conditions, with

3

an unpaired design.

First read in the data:

> library(BGmix)
> data(ybar,ss)

The default experimental design parameters are those for unpaired diﬀerential expression, so these
can be left out here. The following command ﬁts BGmix using a mixture of a point mass at zero
for the null distribution and a Gamma and a reﬂected Gamma for the alternatives.

> outdir <- BGmix(ybar, ss, nreps=c(8,8),niter=1000,nburn=1000)

[1] "Mixture prior on comp. 2"
[1] "delta ~ Gamma, MH"
[1] "eta (scale of Gamma) updated"
[1] "lambda (shape of Gamma) not updated"
[1] "Normal Likelihood"
[1] "tau ~ Gamma"
[1] "a (prior for tau) is updated"
[1] "trace output for parameters"
[1] "no trace for predicted data"

Burn-in:

10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 280 290 300 310 320 330 340 350 360 370 380 390 400 410 420 430 440 450 460 470 480 490 500 510 520 530 540 550 560 570 580 590 600 610 620 630 640 650 660 670 680 690 700 710 720 730 740 750 760 770 780 790 800 810 820 830 840 850 860 870 880 890 900 910 920 930 940 950 960 970 980 990 1000

Main up-dates:

10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 280 290 300 310 320 330 340 350 360 370 380 390 400 410 420 430 440 450 460 470 480 490 500 510 520 530 540 550 560 570 580 590 600 610 620 630 640 650 660 670 680 690 700 710 720 730 740 750 760 770 780 790 800 810 820 830 840 850 860 870 880 890 900 910 920 930 940 950 960 970 980 990 1000
[1] "Output directory is ./run.1"

The function BGmix returns the output directory name. The output directory contains several types
of ﬁle:

(cid:136) summary of model options (summary.txt)

(cid:136) posterior means (mean*.txt)

(cid:136) probability of being classiﬁed in the null component (prob-class.txt)

(cid:136) trace of posterior distribution (trace*.txt)

(cid:136) predictive p-values (pval*.txt)

Output data can be read into R with the functions ccSummary , ccParams (this reads in posterior
means and classiﬁcation probabilities), ccTrace and ccPred.

5 Plotting the results

First read in posterior means:

> params <- ccParams(file=outdir)

4

[1] "got beta"
[1] "got sig2"
[1] "got zg"

The output of ccParams is a list of vectors and matrices corresponding to the diﬀerent model
parameters. These are easily plotted using standard R functions. For an unpaired diﬀerential
expression design some standard plots are included in the package. These show smoothing of
parameters and classiﬁcation of genes into diﬀerent mixture components:

> plotBasic(params,ybar,ss)

[1] "These plots are designed for differential expression model."

The estimated FDR (false discovery rate) can also be plotted:

> par(mfrow=c(1,2))
> fdr <- calcFDR(params)
> plotFDR(fdr)

5

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll−100515−1005101520alphaData meanalphallllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll−505−505deltaData diffdeltallllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll5e−025e+005e−025e−015e+005e+01sigma^2, condition 1Data variance, condition 1sigma^2, condition 1llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll−5050.00.20.40.60.81.0Prob(under−expressed)deltaProb(under−expressed)llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll−5050.00.20.40.60.81.0Prob(not differentially expressed)deltaProb(not differentially expressed)llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll−5050.00.20.40.60.81.0Prob(over−expressed)deltaProb(over−expressed)[1] "No. DE genes for FDR<=5% is 148"
[1] "No. DE genes for FDR<=10% is 163"

6 Predictive model checking

First read in the predictive p-values:

> pred <- ccPred(file=outdir)

It is a good idea to look at histograms of the predictive p-values for the gene variances:

> par(mfrow=c(1,2))
> hist(pred$pval.ss.mix[,1])
> hist(pred$pval.ss.mix[,2])

6

0.00.20.40.00.10.20.30.40.5Cut−off on posterior probabilityEstimated FDRFDR=5%FDR=10%901101301500.00.10.20.30.40.5No. DE genesEstimated FDRFDR=5%FDR=10%For mixture models, there is a speciﬁc function to plot histograms of predictive p-values corre-
sponding to each of the mixture components.

> par(mfrow=c(2,3))
> plotPredChecks(pred$pval.ybar.mix2,params$pc,probz=0.8)

7

Histogram of pred$pval.ss.mix[, 1]pred$pval.ss.mix[, 1]Frequency0.00.40.8020406080100120Histogram of pred$pval.ss.mix[, 2]pred$pval.ss.mix[, 2]Frequency0.00.40.80204060801007 Tail posterior probability

Tail posterior probability is used to ﬁnd diﬀerentially expressed genes with unstructured prior for
the diﬀerence (ﬁxed eﬀects). It needs trace and parameters output from BGmix with jstar = -1
(all eﬀects are ﬁxed):

> nreps <- c(8,8)
> outdir2 <- BGmix(ybar, ss, nreps=nreps, jstar=-1, niter=1000,nburn=1000)
> params2 <- ccParams(outdir2)
> res2 <- ccTrace(outdir2)

and the tail posterior probability is calculated by

> tpp.res <- TailPP(res2, nreps=nreps, params2, p.cut = 0.7, plots = F)

Note that in this function the tail posterior probability is calculated only for the second contrast,
assuming that it is the diﬀerence between condition 2 and condition 1 for the default contrast

8

  z=−1mixed predictive p−valueFrequency0.00.40.802468  z=0mixed predictive p−valueFrequency0.00.40.801020304050  z=+1mixed predictive p−valueFrequency0.00.40.802468lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll02040600.00.20.40.60.81.0qq−plot, z=−165  genesllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll02004006000.00.20.40.60.81.0qq−plot, z=0756  geneslllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll02040600.00.20.40.60.81.0qq−plot, z=+167  genesmatrix X (see Section 3.1), or for the ﬁrst contrast in paired data.

The returned values are the tail posterior probabilities tpp, estimated False Discovery Rate FDR and
estimated proportion of non-diﬀerentially expressed genes pi0. FDR and pi0 can also be estimated
separately:

> FDR.res <- FDRforTailPP(tpp.res$tpp, a1 = params2$maa[1], a2
+ = params2$maa[2], n.rep1=nreps[1], n.rep2=nreps[2], p.cut = 0.8)
> pi0 <- EstimatePi0(tpp.res$tpp, tpp.res$pp0)

The histogram of the tail posterior probabilities with its density under the null (no diﬀerentially
expressed genes) and a graph of FDR can be plotted. (These plots can be done in function TailPP
by setting arguments plots = TRUE.)

> par(mfrow=c(1,2))
> histTailPP(tpp.res)
> FDRplotTailPP(tpp.res)

9

Histogtam of tail ppTail posterior probabilityDensity0.00.40.8012340501001500.000.020.040.060.080.100.12Estimated FDRNumber of genes in the listFDR8 Model options

To run the model with a ﬂat prior on all eﬀects (no mixture prior), set jstar = -1.
There are three main choices for the mixture prior, as presented in Lewin et al. (2007). These are
controlled by the option move.choice.bz in BGmix:

(cid:136) Null point mass, alternatives Uniform (move.choice.bz = 1)

(cid:136) Null point mass, alternatives Gamma (move.choice.bz = 4)

(cid:136) Null small Normal, alternatives Gamma (move.choice.bz = 5)

There are two alternatives for the prior on the gene variances. These are controlled by the option
move.choice.tau in BGmix:

(cid:136) Inverse Gamma (move.choice.tau = 1)

(cid:136) log Normal (move.choice.tar = 2)

9 Other functions

plotTrace plots trace plots of model parameters (useful for assessing convergence of the MCMC)

plotCompare produces scatter plot of two variables using the same scale for x and y axes

plotMixDensity plots predictive density for mixture model (Note: you must save the trace of the
predicted data for this: option trace.pred=1 in BGmix and option q.trace=T in ccPred)

TailPP plots the tail posterior probability (for use with unstructured priors on the eﬀect parameters)

readBGX reads in results from the BGX package.

10 Acknowledgements

Thanks to Ernest Turro for invaluable help getting the package to work.

References

Bochkina, N. and Richardson, S. (2007). Tail posterior probability for inference in pairwise and

multiclass gene expression data. Biometrics in press.

Hein, A.-M. K., Richardson, S., Causton, H. C., Ambler, G. K., and Green, P. J. (2005). BGX: a
fully Bayesian gene expression index for Aﬀymetrix GeneChip data. Biostatistics 6(3), 349–373.

Lewin, A. M., Bochkina, N. and Richardson, S. (2007). Fully Bayesian mixture model for diﬀerential

gene expression: simulations and model checks. submitted.

10

