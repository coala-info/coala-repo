Heterogeneous Error Model (HEM) for Identification
of
Differentially Expressed Genes Under Multiple
Conditions

HyungJun Cho and Jae K. Lee

October 30, 2025

Contents

1 Introduction

2 Heterogeneous Error Model (HEM)

3 Empirical Bayes (EB) Prior Specification

4 False Discovery Rate (FDR) Thesholding

5 When One of either Biological or Experimental Replicates is Unavail-

ble

6 Explanation of Arguments and Values

1

Introduction

1

2

5

6

7

9

The HEM package fits an error model with heterogenous experimental and/or biological
error variances for analyzing microarray data. It enables identification of differentially-
expressed genes by correctly and simultaneously estimating a large number of heteroge-
neous variance parameters. Some features of the HEM package are

• Bayesian error modeling with one or two layers of error,

• simultaneous estimation of all parameters by Markov Chain Monte Carlo (MCMC),

• estimation of decomposed experimental and biological variances,

1

• consideration of heterogeneity of error variances for all genes and under multiple

biological conditions, and

• parametric or nonparametric Empirical Bayes (EB) prior specification for vari-

ances.

To use the hem package in R, install the distributed HEM package and call it as follows

> library(HEM)

The HEM package consists of three main functions (hem, hem.eb.prior, and hem.fdr)
and several additional functions. Package information and examples can be obtained by
typing help(hem), help(hem.eb.prior), and help(hem.fdr).

The remaining sections are organized as explained below.Section 2 describes a Bayesian

hierarchical error model (HEM) with experimental and biological error variances and
demonstrates the use of the hem function by an example. Section 3 shows how to use
Empirical Bayes (EB) prior specification, which is useful particularly for a small number
of replicates. Section 4 explains false discovery rate (FDR) evaluation to determine a
theshold value. Section 5 describes HEM when one of either biological or experimen-
tal replicates is not available. Section 6 explains the arguments and values of three
functions: hem, hem.eb.prior, and hem.fdr.

2 Heterogeneous Error Model (HEM)

This section explains the use of two-layer EM for microarray data with both experimental
and biological replicates. One of either biological or experimental replicates, however, is
often unavailable; this case is described in Section 4. We assume that data are already
preprocessed as normalization and log-transformation.

Suppose that yi,j,k,l is the l-th experimentally (or technically) replicated gene ex-
pression value of the i-th gene for a particular k-th individual (e.g. cell line) with the
tissue sample), where i = 1, . . . , G; j = 1, . . . , C; k =
j-th biological condition (e.g.
1, . . . , mi,j; l = 1, . . . , ni,j,k. The two-layer EM first separates the experimental error
ei,j,k,l from the observed expression value yi,j,k,l, so as to obtain the expression value
xi,j,k free of the experimental error. The first layer, thus, is defined as

yi,j,k,l|{xi,j,k, σ2

ei,j,k

} = xi,j,k + ei,j,k,l.

(1)

The experimental error term ei,j,k,l is assumed to be i.i.d.N (0, σ2
= σ2

), where the
ei,j,k
experimental variance is defined to be a function of xi,j,k, i.e., σ2
e (xi,j,k), since it
varies on expression intensity levels. In the subsequent layer, expression intensity xi,j,k
is decomposed into additive effects of gene, condition, and interaction, as follows

ei,j,k

xi,j,k|{µi,j, σ2
bi,j

} = µi,j + bi,j,k = µ + gi + cj + ri,j + bi,j,k,

(2)

2

where µ is the parameter for the grand mean; gi and cj are the parameters for the
gene and condition effects respectively; ri,j is the parameter for the interaction effect
of gene and condition; and bi,j,k is the error term for the biological variation, assuming
is allowed to be heterogeneous
i.i.d.N (0, σ2
for each combination of gene i and condition j because a gene has its inherent biological
variation under a condition.

). The biological variance parameter σ2
bi,j

bi,j

The prior distributions are assumed to be a uniform prior on µ and normal priors
, respectively. For variance
, and σ2
on gi, cj, and ri,j with mean zero and variance σ2
r
parameters σ−2
e (xi,j,k), gamma priors with parameters (αb, βb) and (αe, βe) are
bi,j
used; however, note that the constant gamma assumptions for variances can be relaxed
so as to be more sensitive to heterogeneous (non-constant) variances, which is suitable for
microarray data with a small number of replicates particularly, as described in Section
3.

and σ−2

g, σ2
c

The Gibbs sampling is utilized to estimate such a large number of parameters and
unobserved data simulataneously. For discovering differentially expressed genes, the
summary statistic using the estimates (¯µ, ¯gi, ¯cj, ¯ri,j, ¯σ2
bi,j

, ¯σ2

) is

ei,j,k

C
(cid:88)

Hi =

wi,j(¯µi,j − ¯¯µi)2
+ (cid:80)mi,j
k=1 ¯σ2

,

(¯σ2

/mi,j)
j mi,j, ¯µi,j = ¯µ+¯gi+¯cj+¯ri,j, and ¯¯µi = (cid:80)

ei,j,k

j=1

bi,j

where wi,j = mi,j/ (cid:80)
j ¯µi,j/C. More differentially
expressed genes have larger H-scores; hence, a desired number of genes with large H-
scores are selected. The false discovery rate (FDR) can be used to determine a threshold
value of H, as described in Section 4.

Example 2.1 shows how the HEM package is used to estimate parameters in the
above model. The used primate brain data consists of gene expression from the post-
mortem tissue samples of the frozen brains of three humans and three chimpanzees. Two
independent tissue samples for each individual were used; thus, for HEM with two layers
mi,1 = 3, mi,2 = 3, and ni,j,k = 2, where i = 1, . . . , 12600, j = 1, 2, k = 1, . . . , mi,j, and
l = 1, . . . , ni,j,k. The design matrix must be prepared as in Example 2.1. The first col-
umn of the design matrix is for conditions, and the other two columns are for biological
replicate and experimental (technical) replicate.

The hem.preproc function is used to do IQR normalization and log2-transformation;
however, other normalization methods can be used. In the hem function, the argument
n.layer=2 indicates two-layer HEM, and the missing arguments method.var.e="gam"
and method.var.b="gam" (as the default) represent Gamma(αe, βe) and Gamma(αb, βb)
priors for experimental and biological variance parameters.
In addition, the default
values (var.g=1, var.c=1, var.r=1, alpha.e=3, bet.e=.1, alpha.b=3, beta.b=.1 ) are used
for prior parameters unless other values are given. For estimation, 3000 MCMC samples
are used after 1000 burn-ins as the default (burn-ins=1000, n.samples=3000 ).

Example 2.1: Two-layer HEM

3

> library(HEM)

> data(pbrain)
> dim(pbrain)
[1] 12600

13

> pbrain[1:5,]

#call pbrain data

> cond <- c(1,1,1,1,1,1,2,2,2,2,2,2)
<- c(1,1,2,2,3,3,1,1,2,2,3,3)
> ind
> rep
<- c(1,2,1,2,1,2,1,2,1,2,1,2)
> design <- data.frame(cond,ind,rep) #design matrix
> design

cond ind rep
1
2
1
2
1
2
1
2
1
2
1
2

1
1
2
2
3
3
1
1
2
2
3
3

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

> pbrain.nor <- hem.preproc(pbrain[,2:13])
> pbrain.nor[1:5,]

#preprocessing

> pbrain.hem <- hem(pbrain.nor, n.layer=2, design=design)
> pbrain.hem$H

#fit HEM
#H-scores

H-scores are saved into pbrain.hem$H in the order of original data, and estimates of
are contained in m.x, m.mu, m.var.e, and n.var.b under
xi,j,k, µi,j, σ2
pbrain.hem.

and σ2
bi,j

ei,j,k

4

3 Empirical Bayes (EB) Prior Specification

In the previous section we used normal, gamma, or uniform priors for the model pa-
rameters. However, constant gamma priors, Gamma(αe, βe) and Gamma(αb, βb), for
variances are not enough to capture heterogeneity of variances with a small number
of replicates. Prior specification can be defined differently to improve the performance
of variance estimation. Biological variance parameter, σ−2
, can be defined to follow a
bi,j
gamma prior of gene-condition specific parameters (αb, βbi,j ), where it is important to
specify appropriate values of the paramemeters. To do so, we need to employ a baseline
variance estimator such as LPE. The algorithm of parametric EB prior specification for
biological variance, σ2
bi,j

, is summarized as follows

(1) Assume that σ−2
bi,j

is distributed as Gamma(αb, βbi,j ).

(2) Employ LPE to obtain the prior estimate of σ2
bi,j

.

(3) Use Gibbs sampling to obtain the posterior estimate of σ2
bi,j

.

Prior specification for experimental variance can be defined similarly. Experimen-
tal variance, however, can precisely be estimated by LPE and a re-sampling technique
without assuming any parametric distribution because the variance depends on the ex-
pression intensity as a function of xi,j,k. Experimental variance can thus be estimated
as follows

(1) Assume that σ−2

e (xi,j,k) is distributed as an unknown distribution h(.).

(2) Employ LPE and bootstrapping to estimate h(.).

(3) Use the Metropolis-Hasting algorithm to obtain the posterior estimate of σ2

ei,j,k

.

Example 3.1 shows how to apply the above EB prior specification to the primate brain
data, using hem and hem.eb.prior functions. The arguments, method.var.e="neb" and
method.var.b="peb", represent a nonparametric EB prior for experimental variance and
parametric EB prior for biological variance, respectively. The matrices of the variance
estimates from hem.eb.prior are plugged into hem. The important (missing) arguments
are q and B , which control the count of genes in a bin for pooling and the number
of iterations for re-sampling respectively. The default q=0.01 partitions 12600 genes
into 100 groups based on their expression intensity levels; hence, 126 genes are used
to compute a pooled variance in each bin. The default B=25 generates 100 variance
estimates for each intensity level by re-sampling.

Example 3.1: Two-layer HEM with EB

> pbrain.eb

<- hem.eb.prior(pbrain.nor, n.layer=2,

design=design,

5

> pbrain.hem <- hem(pbrain.nor, n.layer=2,

method.var.e="neb", method.var.b="peb")
design=design,
method.var.e="neb", method.var.b="peb",
var.e=pbrain.eb$var.e, var.b=pbrain.eb$var.b)

4 False Discovery Rate (FDR) Thesholding

The HEM package provides resampling-based FDR estimates, which can be used to
determine a theshold value of F . For resampling-based estimation, it is essential to
generate null data assimilating real microarray data. A within-gene permutation has a
limited number of distinct permutations in a microarray experiment with a small number
of replicates. In null data from across-gene (or full) permutation, variances are homo-
geneous over all intensity levels, which is not the pattern of practical microarray data;
moreover, there is no distinction between both biological and experimental replicates
that exist in raw data since full permutation does not preserve chip identities. To obtain
null data assimilating practical microarray data, we resample raw data preserving gene
and condition identities, i.e., all of yi,j,1,1, . . . , yi,j,mi,j ,ni,j,k
for gene i and condition j are
sampled together for a generated gene under a condition.

Suppose H-statistics are computed from raw data, and H 0-statistics from generated
null data. Generation of null data is repeated B times independently. Given a critical
value ∆, the estimate of FDR is defined as

(cid:100)F DR(∆) =

ˆπ0(λ) ¯R0(∆)
R(∆)

,

(3)

ib|H 0

where ¯R0(∆) = #{H 0
ib ≥ ∆, i = 1, . . . , G, b = 1, . . . , B}/B is the average number of
significant genes in null data, and R(∆) = #{Hi|Hi ≥ ∆, i = 1, . . . , G} is the number
of significant genes in raw data. The estimate of a correction factor with the λ-quantile
mλ of H 0
ib ≤ mλ}, which is required because of
ib
the different numbers of true insignificant genes in raw data and null data.

is ˆπ0(λ) = #{Hi|Hi ≤ mλ}/#{H 0

ib|H 0

The function hem.fdr provides FDRs at all H values and H critical values for given
target FDRs. Example 3.1 shows how to obtain an FDR estimate using the hem.fdr
function for the primate brain data.

Example 3.1 (Continued):

> pbrain.fdr <- hem.fdr(pbrain, n.layer=2,

design=design,

hem.out=pbrain.hem, eb.out=pbrain.eb)

> plot(pbrain.fdr$fdr)

6

> pbrain.fdr$targets

5 When One of either Biological or Experimental Repli-

cates is Unavailble

We have described the two-layer EM for microarray data with both biological and ex-
periemental replicates in Section 2. A biologically-replicated experiment does not have
experimental replicates and an experimentally-replicated experiment does not have bio-
logical replicates, i.e., one of either biological or experimental replicates is unavailable.
In such cases, biological and experimental errors are confounded; hence, EM is reduced
into a model with one layer as follows

yi,j,k|{µ, gi, cj, ri,j, σ2
ϵi,j

} = µ + gi + cj + ri,j + ϵi,j,k,

(4)

where ϵi,j,k is the error term for the biological and experimental error variation, assuming
). The other parameters are the same as those in the two-layer model and
i.i.d.N (0, σ2
the l−subscript is suppressed in this model.

ϵi,j

.

For variance parameter σ−2
ϵi,j

, use non-contant gamma prior with hyper-parameters
). The parametric prior distribution can also be relaxed for variance parameters,
j=1 wi,j(¯µi,j −

(αϵ, βϵi,j
as described in Section 3. The summary statistic is defined as Hi = (cid:80)C
¯¯µi)2/¯σ2
ϵi,j

The use of one-layer HEM is demonstrated with the mouse B-cell development data
set, which consists of gene expression of the five consecutive stages (pre-B1, large pre-B2,
small pre-B2, immature B, and mature B cells) of mouse B-cell development. The data
was obtained with high-density oligonucleotide arrays, Affymetrix Mu11k GeneChip™,
from flow-cytometrically purified cells. Each of six sample replicates for pre-B1 cell and
each of the five sample replicates for the other conditions were hybridized on a chip, but
there was no replicate for an identical sample condition (i.e., mi,1 = 6, mi,2 = mi,3 =
mi,4 = mi,5 = 5).

Example 5.1 shows how to fit one-layer HEM with Gamma(αϵ, βϵ) prior for variance
parameter, σ−2
. Note that the design matrix consists of two columns: one for condition
ϵi,j
and the other for (individual or experimental) replicate. The argument n.layer=1 repre-
sents one-layer HEM and the missing argument method.var.t=1 represents Gamma(αϵ, βϵ)
prior for variance parameter, σ−2
ϵi,j

.

Example 5.1: One-layer HEM

> data(mubcp)

7

> dim(mubcp) #call MuBCP data
[1] 13027

26

> cond <- c(rep(1,6),rep(2,5),rep(3,5),rep(4,5),rep(5,5))
> ind <- c(1:6,rep((1:5),4))
> design <- data.frame(cond,ind)
> design

cond ind
1
1
2
1
3
1

.
.
.

5
5
5

.
.
.

3
4
5

1
2
3

.
.
.

24
25
26

> mubcp.nor <- hem.preproc(mubcp)

#preprocessing

> mubcp.hem <- hem(mubcp.nor, n.layer=1,design=design)
> mubcp.fdr <- hem.fdr(mubcp.nor, n.layer=1, design=design,

#fit HEM
#get FDR

hem.out=mubcp.hem)

In Example 5.2, the arguments method.var.t="neb" represent nonparametric EB
prior specification. The prior estimate of total error variance from hem.eb.prior is
plugged into var.t of hem.

Example 5.2: One-layer HEM with EB

> mubcp.eb

<- hem.eb.prior(mubcp.nor, n.layer=1, design=design,
method.var.t="neb")

#EB

> mubcp.hem <- hem(mubcp.nor, n.layer=1, design=design,

#fit HEM

method.var.t="neb", var.t=mubcp.eb$var.t)

> mubcp.fdr <- hem.fdr(mubcp.nor, n.layer=1, design=design,

#get FDR

hem.out=mubcp.hem, eb.out=mubcp.eb)

8

6 Explanation of Arguments and Values

This section explains the arguments and values of three main functions (hem, hem.eb.prior,
and hem.fdr) in the HEM package.

hem(x, tr=" ", n.layer, design, burn.ins=1000, n.samples=3000,

method.var.e="gam", method.var.b="gam", method.var.t="gam",
var.e=NULL, var.b=NULL, var.t=NULL, var.g=1, var.c=1, var.r=1,
alpha.e=3, beta.e=.1, alpha.b=3, beta.b=.1, alpha.t=3, beta.t=.2,
n.digits=10, print.message.on.screen=TRUE)

• x : data.

• tr :

if “log2”, “log10”, or “loge”, then log-transformation (with base 2, 10, or e

respectively) is taken.

• n.layer : number of layers: 1=one-layer EM; 2=two-layer EM.

• design: the design matrix-the first column is for conditions: if n.layer=2, the sec-
ond and third columns are for biological and experimental replicates; if n.layer=1,
then the second column is for one of either biological or experimental replicates.

• burn.ins, n.samples: numbers of burn-ins and samples for MCMC.

• method.var.e: prior specification method for experimental variance; "gam"=Gamma(alpha,beta),

"peb"=parametric EB prior specification, "neb"=nonparametric EB prior specifi-
cation (n.layer=2).

• method.var.b: prior specification method for biological variance; "gam"=Gamma(alpha,beta),

"peb"=parametric EB prior specification (n.layer=2).

• method.var.t: prior specification method for total variance; "gam"=Gamma(alpha,beta),

"peb"=parametric EB prior (n.layer=1).

• var.e, var.b: prior estimate matrices for experimental and biological error variances

(n.layer=2).

• var.t: prior estimate matrix for total error variance (n.layer=1).

• var.g, var.c, var.r : variance prior parameters for the effects of gene, condition, or

their interaction, i.e., N(0, σ2
g

), N(0, σ2
c

), or N(0, σ2
r

).

9

• alpha.e, beta.e, alpha.b, beta.b: prior parameters for inverses of experimental and
biological error variance (n.layer=2), i.e., Gamma(αe, βe) and Gamma(αb, βb).

• alpha.t, beta.t: prior parameters for inverse of total error variance (n.layer=1), i.e.,

Gamma(αϵ, βϵ).

• n.digits: number of digits.

• print.message.on.screen: if TRUE, process status is shown on screen.

The hem function provides the following values

• n.gene, n.chip, n.cond : numbers of genes, chips, and conditions.

• design: the design matrix.

• burn.ins, n.samples: numbers of burn-ins and samples for MCMC.

• priors: given prior parameters, σ2
g

αϵ, βϵ (n.layer=1).

, σ2
c

, σ2
r

, αe, βe, αb, βb (n.layer=2), or σ2
g

, σ2
c

, σ2
r

,

• m.mu: estimated mean expression intensity, µi,j = µ + gi + cj + ri,j.

• m.x : estimated unobserved expression intensity, xi,j,k (n.layer=2).

• m.var.b: estimated biological variances, σ2
bi,j

(n.layer=2).

• m.var.e: estimated experimental variances, σ2

ei,j

(n.layer=2).

• m.var.t: estimated total variances, σ2
ϵi,j

(n.layer=1).

• H : H-scores.

hem.eb.prior(x, tr=" ",

n.layer, design,

method.var.e="neb", method.var.b="peb", method.var.t="neb",
q=0.01, B=25, n.digits=10, print.message.on.screen=TRUE)

• q: quantile for partitioning genes based on expression.

• B : number of iterations for re-sampling

The hem.eb.prior function provides the following values

10

• var.b: prior estimate matrix for biological variances (n.layer=2).

• var.e: prior estimate matrix for experimental variances (n.layer=2).

• var.t: prior estimate matrix for total variances (n.layer=1).

In the prior estimate matrices, if parametric EB prior specification is used, the columns
If nonparametric
and rows of the matrices are for conditions and genes respectively.
EB prior specification is used, the columns are for quantiles and the rows are for re-
sampling iterations and expression quantiles, i.e., the matrix size is (B + 1)×(number
of conditions) by (1/q).

hem.fdr(x, tr=" ", n.layer, design, hem.out, eb.out=NULL, n.iter=5, q.trim=0.9,

target.fdr=c(0.001,0.005,0.01,0.05,0.1,0.15,0.20,0.30,0.40,0.50),
n.digits=10, print.message.on.screen=TRUE)

• hem.out: output from hem function.

• eb.out: output from hem.eb.prior function.

• n.iter : number of iterations.

• q.trim: quantile used for estimtaing the proportion of true negatives (pi0).

• target.fdr : target FDRs

The hem.fdr function provides the following values

• fdr : H-scores and corresponding FDRs.

• pi0 : estimated proportion of true negatives.

• H.null : H-scores from null data.

• targets: given target FDRs; corrsponding critical values and numbers of significant

genes are provided.

11

