Adaptive Gene Picking for Microarray
Expression Data Analysis

Brian S. Yandell, Yi Lin, Hong Lan and Alan D. Attie
Univeristy of Wisconsin–Madison

October 30, 2025

1 Overview

The following is adapted from Lin et al. (2002). References can be found there
or at http://www.stat.wisc.edu/∼yandell/statgen.

Our gene array analysis algorithm uses rank order to normalize data for
each experimental condition and estimates the variability at each level of gene
expression to set varying significance thresholds for differential expression across
levels of mRNA abundance. This procedure can be used to prefilter data in
detecting patterns of differential gene expression, for instance using clustering
methods. We propose assigning Bonferroni-corrected p-values, which requires
only minimal assumptions. Although expression data may be acquired from
a variety of technologies, we focus attention on the oligonucleotide arrays in
Affymetrix chips used in a mouse experiment on diabetes and obesity.

Our approach was motivated by a series of experiments on diabetes and obe-
sity. Nadler et al. (2000) used Affymetrix MGU74AV2 chips with over 13,000
probes representing about 12,000 genes on mRNA from adipose tissue to exam-
ine the relationship between obesity and mouse genotype (B6, BTBR, or F1).
Further experiments have grown out of this collaboration using replicates and
will be reported elsewhere. The primary goal was to find patterns of differential
gene expression in mouse tissue between strains. Thus, we have a two-factor
experiment with possible replication for each chip mRNA.

1.1 Transformation to Approximate Normality

Raw microarray measurements are typically normalized to account for system-
atic bias and noise to attempt to restore expression levels from raw data (Lock-
hart et al. 1996). One important source of bias is background fluorescence.
Other factors that require attention include variations in array, dye, thickness
of sample, and measurement noise. Background fluorescence may be measured
in several ways, depending on chip technology, and is typically removed by sub-
traction (see Lockhart et al. 1996; Li and Wong 2001; Schadt et al. 2001;
Irizarry et al. 2002; Li and Wong 2002). Affymetrix chips handle background

1

by comparing perfect match (P M ) with mismatch (M M ) intensity. We use
weighted averages P M and M M across oligo probe pairs using recent ‘low-
level’ analysis (Li and Wong 2001; Schadt et al. 2001; Li and Wong 2002) to
reduce measurement variability. More recently, Irizarry et al. (2003) and Zhang
et al. (2003) have proposed normalization without using M M measurements.

Background-adjusted intensities are typically log-transformed to reduce the
dynamic range and achieve normality. Various authors have noted that com-
parisons based on such log-transformed gene expression levels appear to be ap-
proximately normal (see Kerr and Churchill 2001). However, negative adjusted
values can arise from low expression levels swamped by background noise. Some
authors have proposed adding a small value before taking the log to recover some
of these data (Kerr and Churchill 2001). Our alternative normalization method
leverages this idea while providing comparisons that are more robust to difficul-
ties with the lognormal assumption. For further discussion on normalization,
see Dudoit and Yang (2002) and Colantuoni et al. (2002).

Our procedure converts the background-adjusted expression values into normal-

scores without discarding negative values. This normal-scores transformation
has been employed for microarray data using a different approach (Efron et al.
2001). If expression data are really lognormal, then this normal-scores transfor-
mation is indistinguishable from a log transformation after rescaling. We have
found that log-transformed data appear roughly normal in the middle of the
distribution, while the normal scores are normal throughout.

Our procedure depends on the existence of some unknown monotone trans-
formation of the data to near multivariate normal. There is always such a
transformation in one dimension:
let F be the cumulative distribution of ad-
justed values ∆ and Φ be the cumulative normal distribution. Then Φ−1(F (∆))
If F is lognormal, then Φ−1(F (∆)) = log(∆), but
transforms ∆ to normal.
we prefer not to make this assumption up-front. Instead, we approximate the
transformation by Φ−1(FJ (∆)), where FJ is the empirical distribution of the J
adjusted values ∆1, · · · , ∆J . The difference between this approximate transfor-
J). This is known as the
mation and the ideal one is small (on the order of 1/
normal-scores transformation, and is readily computed as

√

x = Φ−1(FJ (∆)) = qnorm(rank(∆)/(J + 1))

where rank(∆) is the rank order of adjusted gene measurements ∆ = P M −M M
among all J genes under the same condition. The normal quantiles, qnorm(),
transform the ranks to be essentially a sample from standard normal: a his-
togram of these x is bell-shaped and centered about zero, with normal scores
equally spaced in terms of probability mass. Thus, these normal scores are
close to a transformation that would make the data appear normal (Efron et al.
2001). If done separately by condition, this normalization automatically stan-
dardizes the center to 0 and the scale (standard deviation) to 1. Alternatively,
if the experimental conditions are viewed as a random sample of a broader set
of possible conditions, data across all conditions could be transformed together
by normal scores. Normal scores are unaffected by monotone transformations of

2

adjusted intensities or by global factors such as array, dye, and thickness of chip
sample. Ranks may be disturbed by local noise, but that effect is unavoidable
in any analysis of such an experiment.

1.2 Differential Expression Across Conditions

Differential expression across conditions of interest can be computed by com-
paring their transformed expression levels. Information on comparison of two
conditions, 1 and 2, is summarized in pairs of normal scores, x1 and x2, across
the genes; plotting x1 against x2 yields points dispersing from the diagonal.
However, differential gene expression between experimental conditions may de-
pend on the average level of gene expression, with genes of different average
expression having intrinsically different variability. Thus, we recommend plot-
ting the average intensity a = (x1 + x2)/2 against the difference d = x1 − x2,
which involves just a 45 degree rotation (Roberts et al. 2000; Dudoit and Yang
2002; Irizarry et al. 2002; Lee and O’Connell 2002; Colantuoni et al. 2002; Wu
et al. 2002). Since our normal scores may be considered a forgiving approxima-
tion to the log transform, we prefer to represent the plotting axes as if the data
were log-transformed; that is, use an antilog or exp scale. Thus, the a axis is
centered on 1 and suggests a fold change in intensity, while the d axis suggests
a fold change in differential expression.

This method can be extended to experiments with multiple conditions, mul-
tiple readings (e.g., dyes) per gene on a chip, and replication of chips (Kerr et
al. 2001; Wu et al. 2002). Consider an ANOVA model

xijk = µ + ci + gj + (cg)ij + ϵijk

with i = 1, · · · , I conditions, j = 1, · · · , J genes, k = 1, · · · , K replicate chips per
condition, ϵijk ∼ Φ(0, σ2
j ) being the measurement error for the kth replicate,
and ci = 0 if there is separate normalization by condition. Both the gene effect
gj and the condition by gene interaction (cg)ij are random effects. In general,
all variance components may depend on the gene effect gj. Adding multiple
readings per chip introduces a nested structure to the experimental design that
we do not develop further here (see Lee et al. 2000).

The major biological research focus is on differential gene expression, the
condition i by gene j interaction. We assume that most genes show no differ-
ential expression; thus with some small probability π1, a particular interaction
(cg)ij is nonzero, say from Φ(0, δ2
j ). Let zj = 1 indicate differential expression,
Prob{zj = 1} = π1. The variance of the expression score is

Var(xijk) = γ2
Var(xijk) = γ2

j + δ2
j + σ2
j
j + σ2
j

if zj = 1 (differential expression),
if zj = 0 (no differential expression),

for i = 1, ..., I, k = 1, ..., K, with γ2
j the variance for the gene j random effect.
This differential expression indicator has been effectively used for microarray
analysis (Lee et al. 2000; Kerr et al. 2001; Newton et al. 2001). This ANOVA
framework allows isolation of the (cg)ij differential expression from the gj gene

3

effect by contrasting conditions. Suppose that wi are condition contrasts such
that (cid:80)
i wi = 0 and (cid:80)
i w2
i = 1. The standardized contrast dj = (¯x1j· −
¯x2j·)(cid:112)K/2 with ¯xij· = (cid:80)
k xijk/K compares condition 1 with condition 2. More
generally, the contrast

djk =

(cid:88)

i

√

K =

(cid:88)

wi

√

wi ¯xij·

K[ci + (cg)ij + ¯ϵij·]

i

with ¯ϵij· = (cid:80)

k ϵijk/K has E(dj) = (cid:80)

i wici

√

K and

Var(dj) = δ2
j + σ2
j
Var(dj) = σ2
j

if zj = 1 (differential expression),
if zj = 0 (no differential expression).

Again, condition effects ci drop out and E(dj) = 0 if each chip is standardized
separately, but in general they remain part of the contrast.

Although microarray experiments began by contrasting two conditions, this
approach adapts naturally to contrasts capturing key features of differential gene
expression across design factors. Time or other progressions over multiple levels,
such as a linear series of glucose concentrations, might be examined for linear
or quadratic trends using orthogonal contrasts (Lentner and Bishop 1993). For
instance, with five conditions the linear and quadratic contrasts are, respectively
(dropping subscripts except for condition),

= (2x5 + x4 − x2 − 2x1)(cid:112)K/8 ,
dlinear
dquadratic = (2x5 − x4 − 2x3 − x2 + 2x1)(cid:112)K/14 .

With conditions resolved as multiple factors, such as obesity and genotype in our
situation, separate contrasts can be considered for main effects and interactions.
Each contrast can be analyzed in a fashion similar to that above. Alternatively,
one can examine factors with multiple levels, say three genotypes, by an appro-
priate ANOVA evaluation (Lee et al. 2000).

1.3 Robust Center and Spread

For the majority of genes that are not changing, the difference dj reflects only
the intrinsic noise. Thus, genes that do change can be detected by assessing their
differential expression relative to the intrinsic noise found in the nonchanging
genes. Although it is natural to use replicates when possible to assess the
significance of contrasts for each gene, microarray experiments have typically
had few replicates K, leading to unreliable tests. Some authors have considered
shrinkage approaches that combine variance information across genes (Efron et
al. 2001; Lönnstedt and Speed 2001).

(cid:80)

Measurement error seems to depend on the gene expression level aj =
ik xijk/IK, and it may be more efficient to combine variance estimates across
genes with similar average expression levels (Hughes et al. 2000; Roberts et al.
2000; Baldi and Long 2001; Kerr et al. 2001; Long et al. 2001; Newton et al.
2001). Further, if there were no replicates, as in early microarray data, then

4

it would be important to combine across genes in some fashion. There may in
addition be systematic biases that depend on the average expression level (Du-
doit et al. 2000; Yang et al. 2000). We noticed that empirically the variance
across nonchanging genes seems to depend approximately on expression level
in some smooth way, decreasing as a increases, due in part to the mechanics
of hybridization and reading spot measurements. Here, we consider smooth es-
timates of abundance-based variance to account for these concerns. In a later
paper, we will investigate shrinking the gene-specific variance estimate using
our abundance-based estimate and an empirical Bayes argument similar to that
of Lönnstedt and Speed (2001).

Our approach involves estimating the center and spread of differential expres-
sion as it varies across average gene expression aj to standardize the differential
expression. Specifically, we use smoothed medians and smoothed median ab-
solute deviations, respectively, to estimate the center and spread. Smoothing
splines (Wahba 1990) are combined with standardized local median absolute
deviation (MAD) to provide a data-adapted, robust estimate of spread s(a). A
smooth, robust estimate of center m(a) can be computed in a similar fashion
by smoothing the medians across the slices. We use these robust estimates of
center and scale to construct standardized values

Tj = (dj − m(aj))/s(aj)

and base further analysis on these standardized differences.

For convenience, we illustrate with two conditions and drop explicit reference
to gene j. Revisiting the motivating model helps explain our specification for
spread. Consider again log(G) = g + h + ϵ and suppose that hybridization error
is negligible or at least the same across conditions. The intrinsic noise ϵ may
depend on the true expression level g: for two conditions 1 and 2, the difference
d is approximately

d ≈ log(G1) − log(G2) = g1 − g2 + ϵ1 − ϵ2 .

If there is no differential expression, g1 = g2 = g, then Var(d|g) = s2(g), and the
gene signal g may be approximated by a. However, the true formula for Var(d|a)
is not exactly s2(a) and cannot be determined without further assumptions.

Thus, differential contrasts standardized by estimated center and spread that
depend on a should have approximately the standard normal distribution for
genes that have no differential expression across the experimental conditions.
Comparison of gene expressions between two conditions involves finding genes
with strong differential expression. Typically, most genes show no real difference,
only chance measurement variation. Therefore, a robust method that ignores
genes showing large differential expression should capture the properties of the
vast majority of unchanging genes.

The genes are sorted and partitioned based on a into many (say 400) slices
containing roughly the same number of genes and summarized by the median
and the MAD for each slice. For example, with 12,000 genes, the 30 contrasts d
for each slice are sorted; the average of ordered values 15 and 16 is the median,

5

while the MAD is the median of absolute deviations from that central value.
These 400 medians and MADs should have roughly the same distribution up
to a constant. To estimate the scale, it is natural to regress the 400 values of
log(MAD) on a with smoothing splines (Wahba 1990), but other nonparametric
smoothing methods would work as well. The smoothing parameter is tuned
automatically by generalized cross-validation (Wahba 1990). The antilog of
the smoothed curve, globally rescaled, provides an estimate of s(a), which can
be forced to be decreasing if appropriate. The 400 medians are smoothed via
regression on a to estimate m(a).

Replicates are averaged over in the robust smoothing approach, that is,
K factor out replicates. We are currently investigating

√

contrasts dj = (cid:80) wi ¯xij·
shrinkage variance estimates of the form

s2
j =

ν0s2(aj) + ν1 ˆσ2
j
ν0 + ν1

j = (cid:80)

with ˆσ2
estimate (see Lönnstedt and Speed 2001) of the degrees of freedom for ˆσ2

k(xijk − ¯xij·)2/ν1, ν1 = I(K − 1), and ν0 is the empirical Bayes
j /s2(aj).
It should be possible to combine estimates of spread across multiple con-
trasts; say, by using the absolute deviations |xijk − aj| for all genes with average
intensity aj within the range of a particular slice to estimate the slice MAD.
This is sensible since these absolute deviations estimate the measurement error
for most genes and most conditions. Those few genes with large differential ef-
fects across conditions would have large absolute deviations that are effectively
ignored by using the robust median absolute deviation.

1.4 Formal Evaluation of Significant Differential Expres-

sion

Formal evaluation of differential expression may be approached as a collection
of tests for each gene of the “null hypothesis” of no difference or alternatively
as estimating the probability that a gene shows differential expression (Kerr et
al. 2001; Newton et al. 2001). Testing raises the need to account for multiple
comparisons, here we use p-values derived using a Bonferroni-style genome-wide
correction (Dudoit et al. 2000). Genes with significant differential expression
are reported in order of increasing p-value.

We can use the standardized differences T to rank the genes. The conditional
distribution of these T given a is assumed to be standard normal across all genes
whose expressions do not change between conditions. Hypothesis testing here
amounts to comparing the standardized differences with the intrinsic noise level.
Since we are conducting multiple tests, we should adjust the test level of each
gene to have a suitable overall level of significance. We prefer the conservative
Zidak version of the Bonferroni correction: the overall p-value is bounded by
1 − (1 − p)J , where p is the single-test p-value.

For example, for 13,000 genes with an overall level of significance of 0.05,
each gene should be tested at level 1.95 × 10−6, which corresponds to 4.62 score

6

units. Testing for a million genes would correspond to identifying significant
differential expression at more than 5.45 score units. Guarding against overall
type I error may seem conservative. However, a larger overall level does not
substantially change the normal critical value (from 4.62 to 4.31 with 13,000
genes for a 0.05 to 0.20 change in p-value). This test can be made one-sided if
preferred.

Apparently less conservative multiple-comparison adjustments to p-values
are proposed in Yang et al. (2000). However, the results are essentially the
same with all such methods, except when more than 5–10% of the genes show
differential expression across conditions. For an alternative interpretation of
p-values in terms of false discovery rates, see Storey and Tibshirani (2003).

It may be appropriate to examine a histogram of standardized differences T
using these critical values as guidelines rather than as strict rules. The density
f of all the scores is a mixture of the densities for nonchanging f0 and changing
f1 genes,

f (T ) = (1 − π1)f0(T ) + π1f1(T ).

By our construction, f0 is approximately standard normal. Following Efron et
al. (2001), set π1 just large enough so that the estimate

f1(T ) = [f (T ) − (1 − π1)f0(T )]/π1

is positive. This in some sense provides a ‘liberal’ estimate of the distribution of
differentially expressed genes. It lends support to examination of a wider set of
genes, with standardized scores that are above 3 or below –3. We suggest using
this set as the basis for hierarchical clustering. Notice also that this provides an
estimate of the posterior probability of differential expression (zj = 1) for each
mRNA,

Prob{zj = 1|Tj} = π1f1(Tj)/f (Tj).

Gross errors on microarrays can be confused with changing genes. Replicates
can be used to detect outliers in a fashion similar to the approach for differential
gene expression. Residual deviations of each replicate from the condition by gene
mean, xijk − ¯xij·, could be plotted against the average intensity, aj. Robust
estimates of center and scale could be used as above in formal Bonferroni-style
tests for outliers. Separate smooth robust estimates of center and scale are
needed for each contrast. Perhaps an additional Bonferroni correction may be
used to adjust for multiple contrasts.

2 Software

The analysis procedures are written as an R language module. The R system
is publicly available from the R Project, and our code is available from the cor-
responding author as the R pickgene library. The function pickgene() plots
d against a, after backtransforming to show fold changes, and picks the genes
with significant differences in expression. Examples include the simulations and
graphics presented here. This library can be found at www.stat.wisc.edu/∼yandell/statgen.

7

In its simplest form, pickgene() takes a data frame (or matrix) of mi-
croarray data, one column per array. We assume that housekeeping genes
have already been removed. Columns are automatically contrasted using the
prevailing form of orthonormal contrast (default is polynomial, contrasts =
"contr.poly").

library( pickgene )
result <- pickgene( data )

This produces a scatterplot with average intensity a along the horizontal axis
and contrasts d along the vertical, with one plot for each contrast (typically one
fewer than the number of columns of data).

With two columns, we are usually interested in something analogous to the
log ratio, which can be achieved by renormalizing the contrast. If desired, the
log transform can be specified by setting rankbased = F. Gene ideas can be
preserved in the results as well.

result <- pickgene( data, geneID = probes,

renorm = sqrt( 2 ), rankbased = F )

print( result$pick[[1]] )

The pick object is a list with one entry for each contrast, including the probe
names, average intensity a, fold change (exp(d), as if Φ−1(F (∆)) = log(∆)),
and Bonferroni-adjusted p-value. The result also contains a score object with
the average intensity a, score T , lower and upper Bonferroni limits, and probe
names.

The pickgene() function relies on two other functions. The function model.pickgene()

generates the contrasts, although this can be bypassed. More importantly, the
function robustscale slices the pairs (a, d) into 400 equal-sized sets based on
a, finds medians and log(MAD)s for each slice, and then smoothes them using
splines (Wahba 1990) to estimate the center, m(a), and spread, s(a), respec-
tively.

Estimates of density are based on the density() function, packaged in our

pickedhist() routine.

pickedhist( result, p1 = .05, bw = NULL )

We pick a bandwidth bw that provides smooth curves and then adjust π1 = p1
so that f1 is positive.

The standard deviation s(a) is not returned directly in result. However, it

is easily calculated as log(upper/lower)/2.

3 References

Lin Y, Nadler ST, Lan H, Attie AD, Yandell BS (2002) Adaptive gene pick-
ing with microarray data: detecting important low abundance signals.
in The
Analysis of Gene Expression Data: Methods and Software, ed by G Parmigiani,
ES Garrett, RA Irizarry, SL Zeger. Springer-Verlag, ch. 13.

8

