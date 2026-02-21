XDE: A Bayesian hierarchical model for analysis of differential
expression in multiple studies

Robert Scharpf, Andrew Nobel, Giovanni Parmigiani, Håkon Tjelmeland

October 30, 2025

1

Introduction

There are many publicly available high throughput gene expression studies that address comparable
biological questions with similar patient populations. For economical and practical reasons many of
these studies have a relatively small number of biological replicates. To improve the statistical power
it is of interest to combine observed data from several microarray studies, potentially measured with
different technologies. However, variation in the measured gene expression levels is caused not only
by the biological conditions of interest and natural variation in gene expression in different samples of
the same type, but also to a great extent by technological differences between studies. To successfully
combine observed data from different studies, it is therefore essential to filter out the technological
effects. The R package XDE fits a Bayesian Hierarchical model for estimation of differential expression
in 2 or more studies. Alternative methods for assessing differential expression are provided. Other R
packages developed for the cross-study analysis of differential expression are GeneMeta [7], metaArray
[1], and rankProduct [6].

After reading this vignette, one should be able to

• create an instance of the class ExpressionSetList

• create an instance of the class XdeParameter that contains default options for the MCMC

• fit the Bayesian hierarchical model to two or more studies stored as an ExpressionSetList class

• plot MCMC chains to assess convergence

• compute posterior averages for concordant and discordant differential expression

• generate alternative cross-study summaries of differential expression

See [10] for a more detailed discussion of the Bayesian hierarchical model

2 The ExpressionSetList Class

Presently the software for fitting the Bayesian hierarchical model requires that each study be represented
as an ExpressionSet [5] and that the same features be present in each study (the featureNames of the

1

studies must be identical). Therefore, for the meta-analysis of several platforms, platform-specific
annotations must be mapped to a common reference identifier. Mapping identifiers in each platform
is a non-trivial stop in any cross-study analysis. The R packages funcBox (not yet publicly available)
and MergeMaid have been developed to facilitate the annotation process and the merging of multiple
studies, respectively [2].

For the purposes of this vignette, XDE provides an example dataset of a single study that was split
into three artificial datasets.

> library(XDE)
> data(expressionSetList)
> xlist <- expressionSetList
> class(xlist)

[1] "ExpressionSetList"
attr(,"package")
[1] "XDE"

The original study is described in [3]. The processed data was mapped to unigene identifiers and made
available in the experimental data package lungExpression (http://www.bioconductor.org) to facilitate
the reproducibility of the analyses described in [8].

The function validObject checks that the each element in ExpressionSetList is a valid ExpressionSet
and that the featureNames are the same in each element.

> validObject(xlist)

[1] TRUE

In order to assess differential expression across multiple studies, one must define a dichotomous covariate
in the phenoData of each ExpressionSet element in the ExpressionSetList object. This covariate must
have an identical name in each study. In this vignette, we will use XDE to quantify differential expression
between adenocarcinomas and squamous carcinomas. The binary covariate “adenoVsquamous” has been
defined in each of the ExpressionSet elements for this purpose. The following statement must evaluate
to TRUE:

> stopifnot(all(sapply(xlist, function(x, label){ label %in% varLabels(x)}, label="adenoVsquamous")))

3 The XdeParameter Class

There are many features in our implementation of the hierarchical Bayesian model that can be modified:

• hyperparameters for the Bayesian hierarchical model

• the seed for generating random values in the MCMC

• the starting values for the MCMC chains

2

• tuning parameters for Metropolis-Hastings proposals

• the number of updates per MCMC iteration (each parameter can have a different number of

updates)

• selection of MCMC chains that are to be written to log files

All of the above features are provided in the XdeParameter class. The attributes provided when ini-
tializing an instance of class XdeParameter work well in most instances. The XdeParameter vignette
provides a more detailed description of how the attributes can be modified, as well as a brief description
of the Bayesian model and the algorithm for the MCMC. See [10] for a more detailed description of the
Bayesian model.

The default values for our xlist object are obtained by initializing an instance of the XdeParameter
class:

> params <- new("XdeParameter", esetList=xlist, phenotypeLabel="adenoVsquamous")
> params

Instance of XdeParameter

hyperparameters:
beta.a
alpha.a
1.0
1.0
p1.b
0.1

...

p0.a
0.1

p1.a alpha.b
1.0

0.1

beta.b
1.0

p0.b
0.1

updates (frequency of updates per MCMC iteration):

nu Delta
1

1

a
3

b
3

c2
1

...

tuning (the epsilon for Metropolis-Hastings proposals):
c2
0.01

b
0.04 0.04

nu Delta
0.01 0.01

a

...

output (parameters to save (0 = not saved, 1 = saved to log file):

potential acceptance
1

1

nu
1

DDelta
1

a
1

...

iterations: 1000
thin: 1
seed: 291594
notes:
firstMcmc:
List of 5

$ Nu
$ DDelta: num [1:1500] 0.185 -0.216 -0.472 -0.319 -1.527 ...

: num [1:1500] -0.648 -0.595 -0.829 0.157 1.109 ...

3

$ A
$ B
$ C2

...

: num [1:3] 0.567 0.875 0.326
: num [1:3] 0 0.141 0.671
: num 0.584

showIterations: TRUE
specifiedInitialValues: TRUE
directory (where to save the MCMC chains):
phenotypeLabel: adenoVsquamous
studyNames: study1 study2 study3
one.delta: TRUE

./

This parameterization, presently the default, assumes that a gene is differentially expressed in all studies
or in none. An alternative parametrization that allows genes to be differentially expressed in a subset
of studies can be obtained by setting the argument one.delta to FALSE.

> params <- new("XdeParameter", esetList=xlist,
+

phenotypeLabel="adenoVsquamous", one.delta=FALSE)

Whether one fits the “δg” (one.delta=TRUE) or the “δgp” model (one.delta=FALSE), the chain written
to file is of dimension G x P x I, where G is the number of genes, P is the number of studies, and S is
the number of samples (in the case of the δg model, the value written to file for a single gene will be
the same for each study. The same is true for the ξp parameter.)

4

Fitting the Bayesian hierarchical model

4.1 Starting values

Randomly simulated starting values By default, the first iteration of the MCMC chain stored in
the slot firstMcmc of the params are simulated randomly from the priors. When the value of burnin
is true, the output from the MCMC are not saved to file and the chain can not be monitored for
convergence. By default the value of burnin is TRUE and only the last iteration from the chain will be
available (the parameters are not written to log files).

Empirical starting values One can use empirical values for starting the chain (or specify your own
starting values) by initializing an object of class XdeParameter and then specifying your own values for
the first MCMC:

> params <- new("XdeParameter", esetList=xlist, phenotypeLabel="adenoVsquamous", one.delta=FALSE)
> empirical <- empiricalStart(xlist, phenotypeLabel="adenoVsquamous")
> firstMcmc(params) <- empirical

To run a burnin of 3 iterations starting from the empircal values:

> iterations(params) <- 3
> burnin(params) <- TRUE
> fit <- xde(params, xlist)

4

Only the first and last iterations of the MCMC are available when burnin is TRUE. The output of the
xde is an object of class XdeMcmc. The object fit contains the last iteration from the MCMC, as well
as a different seed that can be used for initiating the next chain. For instance, to run two additional
iterations starting at the last iteration stored in the fit object, one should provide the params, xlist,
and fit objects to the xde function:

> iterations(params) <- 2
> fit2 <- xde(params, xlist, fit)

When an object of class XdeMcmc is supplied as an argument to the xde function, the seed and the last
iteration from the fit object are used to begin the next chain. Note that the results from the previous
call to the xde would be identical to the following sequence of commands:

> firstMcmc(params) <- lastMcmc(fit)
> seed(params) <- seed(fit)
> fit2 <- xde(params, xlist)

One should run several thousand iterations (saving all parameters to file) to monitor convergence. In
the following code chunk (not run) we save only the chains for the parameters that are not indexed by
genes and/or study by setting the output for these parameters to zero – this step was taken to keep
this package from becoming unnecessarily large. By setting the thin to 2, we only write every other
MCMC iteration to file. In total, 1000 iterations are saved.

> burnin(params) <- FALSE
> iterations(params) <- 2000
> output(params)[c("potential", "acceptance",
+
+
+
+
+
+
> thin(params) <- 2
> directory(params) <- "logFiles"
> xmcmc <- xde(params, xlist)

"diffExpressed",
"nu", ##"DDelta",
##"delta",
"probDelta",
##"sigma2",
"phi")] <- 0

See the XdeParameter vignette for a more detailed discussion of the output, burnin, and thin methods.
The xmcmc object can be loaded by:

5 MCMC diagnostics

In this section we briefly describe how to access the chains for assessing convergence of the MCMC. We
refer the Ruser to the package coda for more detailed discussion of MCMC diagnostics [9].

The following is a list of the chains that were saved in our run with 1000 saved iterations:

> output(xmcmc)[2:22][output(xmcmc)[2:22] == 1]

5

a
1
t
1

b
1
l
1

c2
1
theta
1

gamma2
1
lambda
1

r
1

rho
1
tau2R tau2Rho
1

1

xi
1

The $ operator can be used to read in log files. First, we need to update the directory slot in the
xmcmc with a character string indicating the path to the log files. (Note that an assignment method for
directory is only available for R object of class XdeMcmc – typically one would not need to change the
directory in the XdeMcmc object). In the following code chunk, we extract the chain for the c2 parameter:

> pathToLogFiles <- system.file("logFiles", package="XDE")
> xmcmc@directory <- pathToLogFiles
> c2 <- xmcmc$c2

> par(las=1)
> plot.ts(c2, ylab="c2", xlab="iterations", plot.type="single")

Here we extract only the parameters that are not indexed by gene and platform (log files for parameters
indexed by gene and platform are typically very large):

6

iterationsc2020040060080010000.10.20.30.40.50.6params <- output(object)[output(object) == 1]
params <- params[!(names(params) %in% c("nu", "phi", "DDelta", "delta", "sigma2", "diffExpressed"))]
names(params)

> getLogs <- function(object){
+
+
+
+ }
> param.names <- getLogs(xmcmc)
> params <- lapply(lapply(as.list(param.names), function(name, object) eval(substitute(object$NAME_ARG, list(NAME_ARG=name))), object=xmcmc), as.ts)
> names(params) <- param.names
> tracefxn <- function(x, name) plot(x, plot.type="single", col=1:ncol(x), ylab=name)
> mapply(tracefxn, params, name=names(params))

6 Posterior probabilities of differential expression

We refer to the posterior mean of the standardized offsets in the hierarchical model as the Bayesian
effect size (BES). The BES is calculated as δg∆gp
cτ σbp

and obtained by

> bayesianEffectSize(xmcmc) <- calculateBayesianEffectSize(xmcmc)

As the function calculateBayesianEffectSize requires that the δ, ∆, and σ2 chains are saved, the
above code chunk is not evaluated in this vignette.

> load(file.path(pathToLogFiles, "BES.rda"))
> load(file.path(pathToLogFiles, "postAvg.rda"))

Posterior averages for the probability of differential expression, concordant differential expression, and
discordant differential expression are stored in the postAvg object.

See [10] for a discussion of how the above posterior average probabilities are computed.

7

8

posterior probability of concordant differential expressionFrequency0.00.20.40.60.81.00102030405060We may wish to differentially label the study-specific statistics of effect size that have high probabilities
of concordant differential expression. To do this, we order the matrix of the BES so that the genes with
the highest posterior probabilities are plotted last. The function symbolsInteresting returns a list of
graphical options to pairs.

> op.conc <- symbolsInteresting(rankingStatistic=postAvg[, "concordant"])
> op.disc <- symbolsInteresting(rankingStatistic=postAvg[, "discordant"])

> par(las=1)
> graphics:::pairs(BES[op.conc$order, ], pch=op.conc$pch, col=op.conc$col,
+

bg=op.conc$bg, upper.panel=NULL, cex=op.conc$cex)

9

posterior probability of discordant differential expressionFrequency0.00.20.40.60.81.0051015202530or high probabilities of discordant differential expression

> graphics:::pairs(BES[op.disc$order, ], pch=op.disc$pch, col=op.disc$col, bg=op.disc$bg,
+

upper.panel=NULL, cex=op.disc$cex)

10

−2−101−2−101split1−1012ooooooooooooooooooooooooooooooooooooooooooooooooo−2−101−2−1012ooooooooooooooooooooooooooooooooooooooooooooooooosplit2−1012ooooooooooooooooooooooooooooooooooooooooooooooooo−2−1012−2−1012split37 Alternative cross-study summaries of differential expression

Study-specific estimates of effect size, such as SAM or t-statistics, can be useful to check the overall
reproducibility between studies. Again using pairwise scatterplots we plot t- and SAM-statistics using
different colors and plotting symbols for the genes that show high posterior probabilities of concordant
differential expression.

sam <- ssStatistic(statistic="sam", phenotypeLabel="adenoVsquamous", esetList=xlist)

> ##t <- ssStatistic(statistic="t", phenotypeLabel="adenoVsquamous", esetList=xlist)
> tt <- rowttests(xlist, "adenoVsquamous", tstatOnly=TRUE)
> if(require(siggenes)){
+
+ }
> if(require(GeneMeta)){
+
+ }

z <- ssStatistic(statistic="z", phenotypeLabel="adenoVsquamous", esetList=xlist)

> graphics:::pairs(tt[op.conc$order, ], pch=op.conc$pch, col=op.conc$col,

11

−2−101−2−101split1−1012ooooooooooooooooooooooooooooooooooooooooooooooooo−2−101−2−1012ooooooooooooooooooooooooooooooooooooooooooooooooosplit2−1012ooooooooooooooooooooooooooooooooooooooooooooooooo−2−1012−2−1012split3+
>

bg=op.conc$bg, upper.panel=NULL, cex=op.conc$cex)

> graphics:::pairs(tt[op.conc$order, ], pch=op.conc$pch, col=op.conc$col,
+
>

bg=op.conc$bg, upper.panel=NULL, cex=op.conc$cex)

> graphics:::pairs(tt[op.disc$order, ], pch=op.disc$pch, col=op.disc$col,
+

bg=op.disc$bg, upper.panel=NULL, cex=op.disc$cex)

Uncorrelated t and SAM statistics suggest a low level of reproducibility that may be attributable to
technological differences in the platforms, probes that align to different transcripts of the same gene, or
differences in the study populations. Low or non-existing reproducibility may induce a wrong borrowing
of strength in the Bayesian model, whereby concordant differential expression is seen as noise and shrunk
to zero. Hence, study-specific estimates of t- and SAM-statistics may be helpful in deciding whether
the Bayesian model is likely to be beneficial.

If the correlation across studies is low, we suggest an unsupervised approach to gene filtering, such as
integrative correlation, to select for genes that show some level of reproducibility across studies. The R
packages MergeMaid and genefilter may be helpful.

For evaluating the overall differential expression, we follow the discussion of Garrett-Mayer [4], and
combine the elements of single study statistics in a linear fashion to obtain a statistic suitable for
assessing differential expression. For a more detailed discussion of how these cross-study summaries
were generated for evaluating concordant and discordant differential expression, see [10].

> tScores <- xsScores(tt, N=nSamples(xlist))
> samScores <- xsScores(sam, nSamples(xlist))
> zScores <- xsScores(z[, match(names(xlist), colnames(z))], N=nSamples(xlist))
> ##Concordant differential expression, we use the combined score from the random effects model directly
> zScores[, "concordant"] <- z[, "zSco"]

8 Session Information

The version number of R and packages loaded for generating the vignette were:

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

12

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: Biobase 2.70.0, BiocGenerics 0.56.0, XDE 2.56.0, generics 0.1.4

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0, Biostrings 2.78.0, DBI 1.2.3,

GeneMeta 1.82.0, IRanges 2.44.0, KEGGREST 1.50.0, MASS 7.3-65, Matrix 1.7-4,
MatrixGenerics 1.22.0, R6 2.6.1, RColorBrewer 1.1-3, RSQLite 2.4.3, S4Vectors 0.48.0,
Seqinfo 1.0.0, XML 3.99-0.19, XVector 0.50.0, annotate 1.88.0, bit 4.6.0, bit64 4.6.0-1,
blob 1.2.4, cachem 1.1.0, cli 3.6.5, compiler 4.5.1, crayon 1.5.3, fastmap 1.2.0, genefilter 1.92.0,
grid 4.5.1, gtools 3.9.5, httr 1.4.7, lattice 0.22-7, matrixStats 1.5.0, memoise 2.0.1,
multtest 2.66.0, mvtnorm 1.3-3, png 0.1-8, rlang 1.1.6, scrime 1.3.5, siggenes 1.84.0, splines 4.5.1,
stats4 4.5.1, survival 3.8-3, tools 4.5.1, vctrs 0.6.5, xtable 1.8-4

References

[1] Hyungwon Choi, Ronglai Shen, Arul Chinnaiyan, and Debashis Ghosh. A latent variable approach
for meta-analysis of gene expression data from multiple microarray experiments. BMC Bioinfor-
matics, 8(1):364, Sep 2007.

[2] Leslie Cope, Xiaogang Zhong, Elizabeth Garrett, and Giovanni Parmigiani. MergeMaid: R tools for
merging and cross-study validation of gene expression data. Stat Appl Genet Mol Biol, 3:Article29,
2004.

[3] Mitchell E. Garber, Olga G. Troyanskaya, Karsten Schluens, Simone Petersen, Zsuzsanna Thaesler,
Manuela Pacyna-Gengelbach, Matt van de Rijn, Glenn D. Rosen, Charles M. Perou, Richard I.
Whyte, Russ B. Altman, Patrick O. Brown, David Botstein, and Iver Petersen. Diversity of gene
expression in adenocarcinoma of the lung. Proceedings of the National Academy of Sciences USA,
98:13784–13789, 2001.

[4] Elizabeth Garrett-Mayer, Giovanni Parmigiani, Xiaogang Zhong, Leslie Cope, and Edward Gabriel-
son. Cross-study validation and combined analysis of gene expression microarray data. Biostatistics,
Sep 2007.

[5] Robert C Gentleman, Vincent J Carey, Douglas M Bates, Ben Bolstad, Marcel Dettling, Sandrine
Dudoit, Byron Ellis, Laurent Gautier, Yongchao Ge, Jeff Gentry, Kurt Hornik, Torsten Hothorn,
Wolfgang Huber, Stefano Iacus, Rafael Irizarry, Friedrich Leisch, Cheng Li, Martin Maechler,
Anthony J Rossini, Gunther Sawitzki, Colin Smith, Gordon Smyth, Luke Tierney, Jean Y H Yang,
and Jianhua Zhang. Bioconductor: open software development for computational biology and
bioinformatics. Genome Biol, 5(10):R80, 2004.

[6] Fangxin Hong, Rainer Breitling, Connor W McEntee, Ben S Wittner, Jennifer L Nemhauser, and
Joanne Chory. Rankprod: a bioconductor package for detecting differentially expressed genes in
meta-analysis. Bioinformatics, 22(22):2825–2827, Nov 2006.

[7] Lara Lusa, R. Gentleman, and M. Ruschhaupt. GeneMeta: MetaAnalysis for High Throughput

Experiments, 2007. R package version 1.11.0.

[8] Giovanni Parmigiani, Elizabeth S Garrett-Mayer, Ramaswamy Anbazhagan, and Edward Gabriel-
son. A cross-study comparison of gene expression studies for the molecular classification of lung
cancer. Clin Cancer Res, 10(9):2922–2927, May 2004.

13

[9] Martyn Plummer, Nicky Best, Kate Cowles, and Karen Vines. coda: Output analysis and diagnos-

tics for MCMC, 2007. R package version 0.12-1.

[10] Robert B. Scharpf, Håkon Tjelmeland, Giovanni Parmigiani, and Andrew Nobel. A Bayesian model

for cross-study differential gene expression. JASA, 2009. To appear.

14

