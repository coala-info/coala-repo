subSeq Package Vignette (Version 1.40.0)

David G. Robinson and John D. Storey

October 30, 2025

Contents

1 Introduction

2 Quick Start Guide

. . . . . . . . . . . . . . . . . . . . . . .
2.1 The subsamples object
2.2 Summarizing Output by Depth . . . . . . . . . . . . . . . . . . .
2.2.1 Estimating False Discovery Proportion . . . . . . . . . . .

3 Plotting

4 Writing Your Own Analysis Method

4.1 Advanced Uses of Handlers

. . . . . . . . . . . . . . . . . . . . .

5 Reproducing or Adding to a Previous Run

5.1 Adding Methods or Depths
. . . . . . . . . . . . . . . . . . . . .
5.2 Examining a Matrix More Closely . . . . . . . . . . . . . . . . .

6 Note on Subsampling

1

Introduction

1

2
3
5
6

7

10
11

11
12
13

14

This is a vignette for the subSeq package, which performs subsampling of
sequencing data to test the effect of depth on your conclusions. When you use
a RNA-Seq differential expression method, such as edgeR or DESeq2, you can
answer a couple of biological questions:

1. What genes are differentially expressed?

2. What classes of genes show differential expression?

However, what if we’re interested in questions of experimental design:

1. Do I have enough reads to detect most of the biologically relevant differ-

ences?

1

2. If I run a similar experiment, should I run additional lanes, or can I

multiplex even more samples and work with fewer reads?

One way to help answer these questions is to pretend you have fewer reads
than you do, and to see how your results (the number of significant genes, your
estimates of their effects, and so on) change. If you can achieve the same results
with just 10% of your reads, it indicates that (when using your particular anal-
ysis method to answer your particular question) the remaining 90% of the reads
In turn, if your conclusions changed considerably between
added very little.
80% and 100% of your reads, it is likely they would change more if you added
additional reads.

subSeq is also designed to work with any analysis method you want, as
long as it takes as input a matrix of count data per gene. edgeR, DESeq2, voom
and DEXSeq are provided as default examples, but if you prefer to use a different
package, to use these packages with a different set of options, or even to use your
own method, it is very easy to do so and still take advantage of this package’s
subsampling methods. See Writing Your Own Analysis Method for more.

2 Quick Start Guide

We demonstrate the use of this method on a subset of the Hammer et al 2010
dataset [4]. This dataset (as provided by the ReCount database [3]), comes built
in to the subSeq package:

library(subSeq)
data(hammer)

Alternatively we could have downloaded the RNA-Seq counts directly from

the ReCount database:

load(url("http://bowtie-bio.sourceforge.net/recount/ExpressionSets/hammer_eset.RData"))
hammer = hammer.eset

We then filter such that no genes had fewer than 5 reads:

hammer.counts = Biobase::exprs(hammer)[, 1:4]
hammer.design = Biobase::pData(hammer)[1:4, ]
hammer.counts = hammer.counts[rowSums(hammer.counts) >=

5, ]

First we should decide which proportions to use. In general, it’s a good idea
to pick subsamplings on a logarithmic scale, since there tends to be a rapid
increase in power for low read depths that then slows down for higher read
depths.

2

proportions = 10^seq(-2, 0, 0.5)
proportions

## [1] 0.01000000 0.03162278 0.10000000 0.31622777
## [5] 1.00000000

The more proportions you use for subsampling, the greater your resolution
and the better your understanding of the trend. However, it will also take longer
to run. We give these proportions, along with the matrix and the design, to the
subsample function, which performs the subsampling:

subsamples = subsample(hammer.counts, proportions,

method = c("edgeR", "voomLimma"), treatment = hammer.design$protocol)

In this command, we are giving it a count matrix (hammer.counts), a vec-
tor of proportions to sample, and a vector describing the treatment design
(hammer.design$protocol), and telling it to try two methods (edgeR and
voom/limma) and report the results of each. (If there are a large number of
proportions, this step may take a few minutes. If it is being run interactively,
it will show a progress bar with an estimated time remaining).

2.1 The subsamples object

The subsample function returns a subsamples object. This also inherits the
data.table class, as it is a table with one row for each gene, in each subsample,
with each method :

options(width = 40)
subsamples

method proportion
<num>
<fctr>
0.01
edgeR
0.01
edgeR
0.01
edgeR
0.01
edgeR
0.01
edgeR

1:
2:
3:
4:
5:
---

##
##
##
##
##
##
##
##
## 150206: voomLimma
## 150207: voomLimma
## 150208: voomLimma
## 150209: voomLimma
## 150210: voomLimma
##
##
##

1:

replication coefficient
<num>
0.0000000

<int>
1

1.00
1.00
1.00
1.00
1.00

3

1
1
1
1

0.0000000
0.0000000
0.0000000
0.0000000

1
1
1
1
1
pvalue
<num>

-0.4912422
0.9857041
2.7151616
-1.0076837
-0.5339556

ID
<char>
1: 1.000000000 ENSRNOG00000000001
2: 1.000000000 ENSRNOG00000000007
3: 1.000000000 ENSRNOG00000000008
4: 1.000000000 ENSRNOG00000000010
5: 1.000000000 ENSRNOG00000000012

##
2:
##
3:
##
4:
##
5:
---
##
## 150206:
## 150207:
## 150208:
## 150209:
## 150210:
##
##
##
##
##
##
##
##
## 150206: 0.010242271 ENSRNOG00000043503
## 150207: 0.127706149 ENSRNOG00000043504
## 150208: 0.002869796 ENSRNOG00000043507
## 150209: 0.104538896 ENSRNOG00000043512
## 150210: 0.012894190 ENSRNOG00000043513
##
##
##
##
##
##
##
##
## 150206: 1404 19862441 0.009224046
17 19862441 0.065854605
## 150207:
6 19862441 0.003538964
## 150208:
12 19862441 0.056394709
## 150209:
430 19862441 0.011012814
## 150210:

qvalue
<num>
199220 1.000000000
199220 1.000000000
199220 1.000000000
199220 1.000000000
199220 1.000000000

count
<int>
0
0
0
0
0

1:
2:
3:
4:
5:
---

depth
<int>

---

The fields it contains are:

• coefficient: The estimated effect size at each gene. For differential

expression between two conditions, this is the log2 fold-change.

• pvalue: The p-value estimated by the method

• ID: The ID of the gene, normally provided by the rownames of the count

matrix

4

• count: The number of reads for this particular gene at this depth

• depth: The total depth (across all reads) at this level of sampling

• replication: Which subsampling replication (in this subsampling run,
only one replicate was performed; use the replications argument to
subsample to perform multiple replications)

• method: The name of the differential expression method used

• qvalue: A q-value estimated from the p-value distribution using the
qvalue package. If you consider all genes with a q-value below q as can-
didates, you expect to achieve a false discovery rate of q.

2.2 Summarizing Output by Depth

This object gives the differential analysis results per gene, but we are prob-
ably more interested in the results per sampling depth: to see how the overall
conclusions change at lower read depths. Performing summary on the subsam-
plings object shows this:

subsamples.summary = summary(subsamples)
subsamples.summary

method
depth proportion
##
<char>
<num>
<int>
##
199220 0.01000000
edgeR
## 1:
199220 0.01000000 voomLimma
## 2:
628614 0.03162278
edgeR
## 3:
628614 0.03162278 voomLimma
## 4:
## 5: 1984462 0.10000000
edgeR
## 6: 1984462 0.10000000 voomLimma
## 7: 6278016 0.31622777
edgeR
## 8: 6278016 0.31622777 voomLimma
## 9: 19862441 1.00000000
edgeR
## 10: 19862441 1.00000000 voomLimma
replication significant
##
##
<int>
## 1:
## 2:
## 3:
## 4:
## 5:
## 6:
## 7:
## 8:
## 9:

pearson
<num>
180 0.4589406
0 0.4970027
823 0.5788115
0 0.6191432
2348 0.6960633
1368 0.7493862
5004 0.8371370
4784 0.8772103
8280 1.0000000

<int>
1
1
1
1
1
1
1
1
1

5

8623 1.0000000

1
spearman concordance
<num>

MSE
<num>
0.3655546 2.4369343
0.4874957 0.9240722
0.5160160 1.5267546
0.6149457 0.7026432
0.6666271 0.9338693
0.7490146 0.4619120
0.8291669 0.4325943
0.8771650 0.2289477
1.0000000 0.0000000
1.0000000 0.0000000
rFDP
<num>

## 10:
##
##
<num>
## 1: 0.4739997
## 2: 0.4942100
## 3: 0.6056664
## 4: 0.6208187
## 5: 0.7400826
## 6: 0.7535023
## 7: 0.8750171
## 8: 0.8798614
## 9: 1.0000000
## 10: 1.0000000
percent
##
##
<num>
## 1: 0.005450674 0.005555556 0.02516165
## 2: 0.000000000 0.000000000 0.00000000
## 3: 0.008858711 0.010935601 0.10405215
## 4: 0.000000000 0.000000000 0.00000000
## 5: 0.008996278 0.009369676 0.28543380
## 6: 0.014787915 0.015350877 0.16054827
## 7: 0.022783893 0.020583533 0.59283900
## 8: 0.035305054 0.034908027 0.53698535
## 9: 0.051050122 0.000000000 1.00000000
## 10: 0.050418549 0.000000000 1.00000000

estFDP
<num>

As one example: the first row of this summary table indicates that at a read
depth of 199220, edgeR found 180 genes significant (at an FDR of .05), and that
its fold change estimates had a 0.4739997 Spearman correlation and a 0.4589406
Pearson correlation with the full experiment.

Note that different methods are compared on the same subsampled matrix
for each depth. That is, at depth 199220, results from edgeR are being compared
to results from voomLimma on the same matrix.

2.2.1 Estimating False Discovery Proportion

One question that subSeq can answer is whether decreasing your read depth
ever introduces false positives. This would be a worrisome sign, as it suggests
that increasing your read depth even more might prove that you are finding
many false positives. subSeq has two ways of estimating the false discovery
proportion at each depth, each of which requires choosing an FDR threshold to
control for (default 5%):

• eFDP: The estimated false discovery proportion at each depth when con-
trolling for FDR. This is found by calculating the local false discovery rate
of each gene in the oracle, (which we will call the ”oracle lFDR”), then

6

finding the mean oracle lFDR of the genes found significant at each depth.
This is effectively using the best information available (the full, oracle ex-
periment) to estimate how successful your FDR control is at each depth.
This estimate will converge to the desired FDR threshold (e.g. 5%) at the
full depth.

• rFDP: the ”relative” false discovery proportion at each depth, where a rel-
ative false discovery is defined as a gene found significant at a subsampled
depth that was not found significant at the full depth. This estimate will
converge to 0% at the full depth.

Generally, we recommend the eFDP over the rFDP (and the eFDP is the default
metric plotted), as a) it is a less noisy estimate, b) It converges to 5% rather
than dropping back down to 0, and c) it takes into account how unlikely each
hypothesis appeared to be in the oracle, rather than simply the binary question
of whether it fell above a threshold. We report the rFDP only because it a
simpler metric that does not require the estimation of local FDR.

In either case, it is important to note that the full experiment is not per-
fect and has false positives and negatives of its own, so these metrics should
not be viewed as an absolute false discovery rate (i.e., ”proof” that an exper-
iment is correct). Instead, they examine whether decreasing read depth tends
to introduce false results.

3 Plotting

The best way to understand your subsampling results intuitively is to plot
them. You can do this by plotting the summary object (not the original subsam-
ples). plot(subsamples.summary) creates Figure 1, which plots some useful
metrics of quality by read depth.

Creating your own plot by read depth from the summary object is easy using
ggplot2. For instance, if you would like to plot the percentage of oracle (full
experiment) genes that were found significant at each depth, you could do:

library(ggplot2)
ggplot(subsamples.summary, aes(x = depth,

y = percent, col = method)) + geom_line()

7

Figure 1: The default output of plot(subsamples.summary). This shows four
plots: (i) The number of significant genes found significant at each depth; (ii)
the estimated false discovery at this depth, calculated as the average oracle local
FDR of the genes found significant at this depth; (iii) The Spearman correlation
of estimates at each depth with the estimates at the full experiment; (iv) the
mean-squared error of the estimates at each depth with the estimates at the full
experiment.

8

Spearman corr of estimatesMSE of estimates# significant genes at 5% FDREstimated FDP0.0e+005.0e+061.0e+071.5e+072.0e+070.0e+005.0e+061.0e+071.5e+072.0e+070.000.010.020.030.040.050.00.51.01.52.02.502500500075000.50.60.70.80.91.0DepthMetricmethodedgeRvoomLimmaIf you’d like to focus on the Pearson correlations of the estimates, you could

do:

ggplot(subsamples.summary, aes(x = depth,

y = pearson, col = method)) + geom_line()

9

0.000.250.500.751.000.0e+005.0e+061.0e+071.5e+072.0e+07depthpercentmethodedgeRvoomLimma0.60.81.00.0e+005.0e+061.0e+071.5e+072.0e+07depthpearsonmethodedgeRvoomLimma4 Writing Your Own Analysis Method

There are five methods of RNA-Seq differential expression analysis built in

to subSeq:

• edgeR Uses edgeR’s exact negative binomial test to compare two condi-

tions [6]

• edgeR.glm Uses edgeR’s generalized linear model, which allows fitting a

continuous variable and including covariates.

• voomLimma Uses voom from the edgeR package to normalize the data, then

apply’s limma’s linear model with empirical Bayesian shrinkage [5].

• DESeq2 Applies the negative binomial Wald test from the DESeq2 package

[1]. DESeq2 is notable for including shrinkage on the parameters.

• DEXSeq Uses a negative binomial generalized linear model to look for dif-

ferential exon usage in mapped exon data (see ??) [2].

These handlers are provided so you can perform subSeq analyses ”out-of-the-
box”. However, it is very likely that your RNA-Seq analysis does not fit into one
of these methods! It may use different published software, include options you
need to set manually, or it could be a method you wrote yourself. No problem:
all you need to do is write a function, called a handler, that takes in a count
matrix and any additional options, then performs your analysis and returns the
result as a data.frame.

Start by writing up the code you would use to analyze a count matrix to
produce (i) coefficients (such as the log fold-change) and (ii) p-values. But put
your code inside a function, and have the function take as its first argument
the (possibly subsampled) count matrix, and return the results as a two-column
data.frame with one row per gene (in the same order as the matrix):

myMethod = function(count.matrix, treatment) {

# calculate your coefficients based on the input count matrix
coefficients = <some code>
# calculate your p-values
pvalues = <some more code>

# return them as a data.frame
return(data.frame(coefficient=coefficients, pvalue=pvalues))

}

Your function can be as long or complicated as you want, as long as its first
argument is a count.matrix and it returns a data frame with coefficient and
pvalue columns.

Now that you’ve defined this function, you can pass its name to subsample

just like you would one of the built-in ones:

10

subsamples = subsample(hammer.counts, proportions,
method = c("edgeR", "DESeq2", "myMethod"),
treatment = hammer.design$protocol)

4.1 Advanced Uses of Handlers

Your handler can do more than take these two arguments and calculate a

p-value:

• Your handler can return more columns than a coefficient and p-value (for
example, you can return a column of dispersion estimates, confidence in-
terval boundaries, or anything else on which you would like to examine
the effect of depth). These columns will be included in the output.

If you provide multiple methods,
including one that returns an extra
columns and one that doesn’t, the column will be filled with NA for the
method that doesn’t provide the column.

• Your handler can take more arguments than just a count matrix and
treatment vector. Any arguments passed at the end of the ‘subsample‘
function will be passed on to it. However, you cannot use multiple methods
where some take extra arguments and some do not. Instead, perform them
separately (using the same seed; see Reproducing or Adding to a Previous
Run) and then use combineSubsamples.

• Your handler does not necessarily have to return one row per gene. For
example, you could have a handler that performs gene set enrichment
analysis (GSEA) on your data, which then returns one gene set per row. If
so, it must return an additional column: ID (those were otherwise acquired
from the rownames of the count matrix). Note that count column (noting
the read depth per gene) will become NA unless it is provided by the
handler function.

5 Reproducing or Adding to a Previous Run

If you have a subsamples or subsample summary object that either you or
someone else ran, you might be interested in working with the original data
further. For example:

• You may want to perform additional methods, and be able to compare

them directly to the original

• You may want to sample additional depths, and combine them together

• You may have noticed a strange discrepancy in one of the results, and

want to further examine the count matrix at that specific depth

All of these are possible, as subSeq stores the random seed used for the run

in the results.

11

5.1 Adding Methods or Depths

If you already have some methods performed (as we do in subsamples), we
may want to add additional methods. For example you might want to analyze
the same depths with the voom method. To do this, use the getSeed function
to retrieve the random seed from the subsamples results, and then provide that
seed to the subsample function:

seed = getSeed(subsamples)

subsamples.more = subsample(hammer.counts,

proportions, method = c("voomLimma"),
treatment = hammer.design$protocol, seed = seed)

After that, you can combine the two objects using combineSubsamples:

subsamples.combined = combineSubsamples(subsamples,

subsamples.more)

plot(summary(subsamples.combined))

12

5.2 Examining a Matrix More Closely

Say that after your analysis, you are surprised that a particular method
performed how it did at a particular depth, and you wish to examine that
depth further.

You can also use the seed to retrieve the precise matrix used. For instance,

if we want to find the matrix used for the .1 proportion subsampling:

submatrix = generateSubsampledMatrix(hammer.counts,

0.1, seed = seed)

dim(submatrix)

## [1] 15021

4

sum(submatrix)

13

Spearman corr of estimatesMSE of estimates# significant genes at 5% FDREstimated FDP0.0e+005.0e+061.0e+071.5e+072.0e+070.0e+005.0e+061.0e+071.5e+072.0e+070.000.010.020.030.040.050.00.51.01.52.02.501000020000300000.50.60.70.80.91.0DepthMetricmethodedgeRvoomLimma## [1] 1984462

6 Note on Subsampling

subSeq performs read subsampling using a random draw from a binomial
distribution. Specifically, for a subsampling proportion pk, each value m, n in
the subsampled matrix Y (k) is generated as:

Y (k)
m,n ∼ Binom(Xm,n, pk)

This is equivalent to allowing each original mapped read to have probability
pk of being included in the new counts, as done, for example, by the Picard
DownsampleSam function [7].

A computationally intensive alternative is to sample the reads before they
are mapped, then to perform mapping on the sampled data. When the mapping
is done independently and deterministically for each read, as it is e.g. in Bowtie,
this is mathematically identical to subsampling the aligned reads or counts, since
the inclusion of one read does not affect the mapping of any other. This applies
to methods such as Bar-Seq and Tn-Seq, or for RNA-Seq in organisms with no or
very few introns (e.g. bacteria or yeast). Note that some spliced read mappers,
such as TopHat, do not perform all their mappings entirely independently, since
unspliced mappings are first used to determine exonic regions before searching
for spliced reads. However, those methods are (not coincidentally) among the
most computationally intensive mappers in terms of running time and memory
usage, giving subSeq an especially large advantage.

Several other papers that perform subsampling have made the assumption of
independence implicitly, but if you are unsure, it may be useful to subsample the
original fastq file, then perform the read mapping on each sample individually,
and compare the subsampled counts to those from subSeq to check that this
approximation is reasonable for your data.

References

[1] Simon Anders and Wolfgang Huber. Differential expression analysis for

sequence count data. Genome Biology, 11:R106, 2010.

[2] Simon Anders, Alejandro Reyes, and Wolfgang Huber. Detecting differential
usage of exons from RNA-seq data. Genome research, 22(10):2008–2017,
October 2012.

[3] Alyssa C Frazee, Ben Langmead, and Jeffrey T Leek. ReCount: a multi-
experiment resource of analysis-ready RNA-seq gene count datasets. BMC
Bioinformatics, 12:449, 2011.

14

[4] Paul Hammer, Michaela S Banck, Ronny Amberg, Cheng Wang, Gabriele
Petznick, Shujun Luo, Irina Khrebtukova, Gary P Schroth, Peter Beyerlein,
and Andreas S Beutler. mRNA-seq with agnostic splice site discovery for
nervous system transcriptomics tested in chronic pain. Genome research,
20(6):847–860, June 2010.

[5] CW Law, Y Chen, W Shi, and GK Smyth. Voom: precision weights un-
lock linear model analysis tools for RNA-seq read counts. Genome Biology,
January 2014.

[6] Mark D Robinson, Davis J McCarthy, and Gordon K Smyth. edgeR: a
Bioconductor package for differential expression analysis of digital gene ex-
pression data. Bioinformatics, 26(1):139–140, January 2010.

[7] A. Wysoker,

Tibbetts,
http://picard.sourceforge.net, 2012.

K.

and

T.

Fennell.

Picard.

15

