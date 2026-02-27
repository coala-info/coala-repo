Motif comparisons and P-values

Benjamin Jean-Marie Tremblay∗

17 October 2021

Abstract

Two important but not often discussed topics with regards to motifs are motif comparisons and

P-values. These are explored here, including implementation details and example use cases.

Contents

1 Introduction

2 Motif comparisons

2.1 An overview of available comparison metrics . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Comparison parameters
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Comparison P-values . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Motif trees with ggtree

3.1 Using motif_tree() . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Using compare_motifs() and ggtree() . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 Plotting motifs alongside trees

4 Motif P-values

4.1 The dynamic programming algorithm for calculating P-values and scores . . . . . . . . . . . .
. . . . . . . . . . . . .
4.2 The branch-and-bound algorithm for calculating P-values from scores
. . . . . . . . . . . . .
4.3 The random subsetting algorithm for calculating scores from P-values

Session info

References

1

Introduction

1

1
2
3
6

6
6
7
9

10
11
14
15

17

19

This vignette covers motif comparisons (including metrics, parameters and clustering) and P-values. For an
introduction to sequence motifs, see the introductory vignette. For a basic overview of available motif-related
functions, see the motif manipulation vignette. For sequence-related utilities, see the sequences vignette.

2 Motif comparisons

There a couple of functions available in other Bioconductor packages which allow for motif comparison,
such as PWMSimlarity() (TFBSTools) and motifSimilarity() (PWMEnrich). Unfortunately these functions
are not designed for comparing large numbers of motifs. Furthermore they are restrictive in their option
range. The universalmotif package aims to fix this by providing the compare_motifs() function. Several

∗benjamin.tremblay@uwaterloo.ca

1

other functions also make use of the core compare_motifs() functionality, including merge_motifs() and
view_motifs().

2.1 An overview of available comparison metrics

This function has been written to allow comparisons using any of the following metrics:

• Euclidean distance (EUCL)
• Weighted Euclidean distance (WEUCL)
• Kullback-Leibler divergence (KL) (Kullback and Leibler 1951; Roepcke et al. 2005)
• Hellinger distance (HELL) (Hellinger 1909)
• Squared Euclidean distance (SEUCL)
• Manhattan distance (MAN)
• Pearson correlation coefficient (PCC)
• Weighted Pearson correlation coefficient (WPCC)
• Sandelin-Wasserman similarity (SW; or sum of squared distances) (Sandelin and Wasserman 2004)
• Average log-likelihood ratio (ALLR) (Wang and Stormo 2003)
• Lower limit average log-likelihood ratio (ALLR_LL; minimum column score of -2) (Mahony, Auron, and

Benos 2007)

• Bhattacharyya coefficient (BHAT) (Bhattacharyya 1943)

For clarity, here are the R implementations of these metrics:
EUCL <- function(c1, c2) {

sqrt( sum( (c1 - c2)^2 ) )

WEUCL <- function(c1, c2, bkg1, bkg2) {

sqrt( sum( (bkg1 + bkg2) * (c1 - c2)^2 ) )

KL <- function(c1, c2) {

( sum(c1 * log(c1 / c2)) + sum(c2 * log(c2 / c1)) ) / 2

HELL <- function(c1, c2) {

sqrt( sum( ( sqrt(c1) - sqrt(c2) )^2 ) ) / sqrt(2)

SEUCL <- function(c1, c2) {

sum( (c1 - c2)^2 )

MAN <- function(c1, c2) {
sum ( abs(c1 - c2) )

}

PCC <- function(c1, c2) {

}

}

}

}

}

}

n <- length(c1)
top <- n * sum(c1 * c2) - sum(c1) * sum(c2)
bot <- sqrt( ( n * sum(c1^2) - sum(c1)^2 ) * ( n * sum(c2^2) - sum(c2)^2 ) )
top / bot

WPCC <- function(c1, c2, bkg1, bkg2) {

2

weights <- bkg1 + bkg2
mean1 <- sum(weights * c1)
mean2 <- sum(weights * c2)
var1 <- sum(weights * (c1 - mean1)^2)
var2 <- sum(weights * (c2 - mean2)^2)
cov <- sum(weights * (c1 - mean1) * (c2 - mean2))
cov / sqrt(var1 * var2)

}

SW <- function(c1, c2) {
2 - sum( (c1 - c2)^2 )

}

ALLR <- function(c1, c2, bkg1, bkg2, nsites1, nsites2) {

left <- sum( c2 * nsites2 * log(c1 / bkg1) )
right <- sum( c1 * nsites1 * log(c2 / bkg2) )
( left + right ) / ( nsites1 + nsites2 )

}

BHAT <- function(c1, c2) {
sum( sqrt(c1 * c2) )

}

Motif comparison involves comparing a single column from each motif individually, and adding up the scores
from all column comparisons. Since this causes the score to be highly dependent on motif length, the scores
can instead be averaged using the arithmetic mean, geometric mean, median, or Fisher Z-transform.

If you’re curious as to how the comparison metrics perform, two columns can be compared individually using
compare_columns():
c1 <- c(0.7, 0.1, 0.1, 0.1)
c2 <- c(0.5, 0.0, 0.2, 0.3)

compare_columns(c1, c2, "PCC")
#> [1] 0.8006408
compare_columns(c1, c2, "EUCL")
#> [1] 0.3162278

Note that some metrics do not work with zero values, and small pseudocounts are automatically added to
motifs for the following:

• KL
• ALLR
• ALLR_LL

As seen in figure 1, the distributions for random individual column comparisons tend to be very skewed. This
is usually remedied when comparing the entire motif, though some metrics still perform poorly in this regard.

#> `summarise()` has grouped output by 'key'. You can override using the `.groups`
#> argument.

2.2 Comparison parameters

There are several key parameters to keep in mind when comparing motifs. Some of these are:

• method: one of the metrics listed previously
• tryRC: choose whether to try comparing the reverse complements of each motif as well

3

Figure 1: Distributions of scores from approximately 500 random motif and individual column comparisons

4

SWWEUCLWPCCMANPCCSEUCLEUCLHELLKLALLRALLR_LLBHAT0.00.51.01.52.00.000.250.500.751.000.000.250.500.751.000.00.51.01.52.0−1.0−0.50.00.51.00.00.51.01.52.00.00.51.00.000.250.500.7501234−3−2−101−2−1010.000.250.500.751.0001230.00.51.01.52.0012301230.00.51.01.5012340.00.51.01.52.0012340.00.51.01.501230.00.51.01.52.02.50.00.51.01.5scoresdensitytypeArithMeanFisherZTransGeoMeanMedianRawColumnScoresWeightedArithMeanWeightedGeoMean• min.overlap: limit the amount of allowed overhang between the two motifs
• min.mean.ic, min.position.ic: don’t allow low IC alignments or positions to contribute to the final

score

• score.strat: how to combine individual column scores in an alignment

See the following example for an idea as to how some of these settings impact scores:

Figure 2: Example scores from comparing two motifs

Table 1: Comparing two motifs with various settings

type

method

default

normalised

checkIC

0.5145697
similarity PCC
0.6603253
similarity WPCC
0.5489863
EUCL
distance
1.5579529
SW
similarity
0.9314823
distance
KL
-0.3158358
similarity ALLR
0.7533046
similarity BHAT
0.4154478
distance
HELL
0.3881919
distance WEUCL
0.4420471
distance
SEUCL
0.8645563
distance MAN
similarity ALLR_LL -0.1706669

0.3087418
0.5045159
0.7401466
1.2057098
1.2424547
-0.1895015
0.6026437
0.2492687
0.5233627
0.2652283
0.5187338
-0.1024001

0.9356122
0.9350947
0.2841903
1.8955966
0.1975716
0.4577374
0.9468133
0.2123219
0.2009529
0.1044034
0.4710645
0.4577374

Settings used in the previous table:

• normalised: normalise.scores = TRUE
• checkIC: min.position.ic = 0.25

5

PK19363.1AFT2123456789101112012012bits2.3 Comparison P-values

By default, compare_motifs() will compare all motifs provided and return a matrix. The compare.to will
cause compare_motifs() to return P-values.
library(universalmotif)
library(MotifDb)
motifs <- filter_motifs(MotifDb, organism = "Athaliana")
#> motifs converted to class 'universalmotif'

score

target

target.i

subject subject.i
<character> <numeric>

# Compare the first motif with everything and return P-values
head(compare_motifs(motifs, 1))
#> Warning in compare_motifs(motifs, 1): Some comparisons failed due to low motif
#> IC
#> DataFrame with 6 rows and 8 columns
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> 6
Eval
#>
#>
<numeric> <numeric>
#> 1 1.31042e-06 0.00514210
#> 2 1.33754e-06 0.00524852
#> 3 1.55744e-06 0.00611138
#> 4 1.55744e-06 0.00611138
#> 5 2.43548e-06 0.00955683
#> 6 2.81553e-06 0.01104816

logPval
<character> <integer> <numeric> <numeric>
-13.5452
-13.5247
-13.3725
-13.3725
-12.9254
-12.7804

1 ERF11 [duplicated #6..
1 CRF4 [duplicated #566]
1
LOB
1 LOB [duplicated #1051]
1
ERF15
1 ERF2 [duplicated #769]

0.991211
0.990756
0.987357
0.987357
0.977213
0.973871

ORA59
ORA59
ORA59
ORA59
ORA59
ORA59
Pval

1371
1195
1297
1845
618
1563

P-values are made possible by estimating distribution (usually the best fitting distribution for motif com-
parisons) parameters from randomized motif scores, then using the appropriate stats::p*() distribution
function to return P-values. These estimated parameters are pre-computed with make_DBscores() and
stored as JASPAR2018_CORE_DBSCORES and JASPAR2018_CORE_DBSCORES_NORM. Since changing any of the
settings and motif sizes will affect the estimated distribution parameters, estimated parameters have been
pre-computed for a variety of these. See ?make_DBscores if you would like to generate your own set of
pre-computed scores using your own parameters and motifs.

3 Motif trees with ggtree

3.1 Using motif_tree()
Additionally, this package introduces the motif_tree() function for generating basic tree-like diagrams
for comparing motifs. This allows for a visual result from compare_motifs(). All options from
compare_motifs() are available in motif_tree(). This function uses the ggtree package and outputs
a ggplot object (from the ggplot2 package), so altering the look of the trees can be done easily after
motif_tree() has already been run.
library(universalmotif)
library(MotifDb)

motifs <- filter_motifs(MotifDb, family = c("AP2", "B3", "bHLH", "bZIP",

"AT hook"))

6

#> motifs converted to class 'universalmotif'
motifs <- motifs[sample(seq_along(motifs), 100)]
tree <- motif_tree(motifs, layout = "daylight", linecol = "family")

## Make some changes to the tree in regular ggplot2 fashion:
# tree <- tree + ...

tree

3.2 Using compare_motifs() and ggtree()
While motif_tree() works as a quick and convenient tree-building function, it can be inconvenient when
more control is required over tree construction. For this purpose, the following code goes through how exactly
motif_tree() generates trees.
library(universalmotif)
library(MotifDb)
library(ggtree)
library(ggplot2)

motifs <- convert_motifs(MotifDb)
motifs <- filter_motifs(motifs, organism = "Athaliana")
motifs <- motifs[sample(seq_along(motifs), 25)]

## Step 1: compare motifs

comparisons <- compare_motifs(motifs, method = "PCC", min.mean.ic = 0,

score.strat = "a.mean")

7

0AP2AT hookbHLHbZIP## Step 2: create a "dist" object

# The current metric, PCC, is a similarity metric
comparisons <- 1 - comparisons

comparisons <- as.dist(comparisons)

# We also want to extract names from the dist object to match annotations
labels <- attr(comparisons, "Labels")

## Step 3: get the comparisons ready for tree-building

# The R package "ape" provides the necessary "as.phylo" function
comparisons <- ape::as.phylo(hclust(comparisons))

## Step 4: incorporate annotation data to colour tree lines

family <- sapply(motifs, function(x) x["family"])
family.unique <- unique(family)

# We need to create a list with an entry for each family; within each entry
# are the names of the motifs belonging to that family
family.annotations <- list()
for (i in seq_along(family.unique)) {

family.annotations <- c(family.annotations,

list(labels[family %in% family.unique[i]]))

}
names(family.annotations) <- family.unique

# Now add the annotation data:
comparisons <- ggtree::groupOTU(comparisons, family.annotations)

## Step 5: draw the tree

tree <- ggtree(comparisons, aes(colour = group), layout = "rectangular") +
theme(legend.position = "bottom", legend.title = element_blank())

## Step 6: add additional annotations

# If we wish, we can additional annotations such as tip labelling and size

# Tip labels:
tree <- tree + geom_tiplab()

# Tip size:
tipsize <- data.frame(label = labels,

icscore = sapply(motifs, function(x) x["icscore"]))

tree <- tree %<+% tipsize + geom_tippoint(aes(size = icscore))

8

3.3 Plotting motifs alongside trees

Unfortunately, the universalmotif package does not provide any function to easily plot motifs as part of
trees (as is possible via the motifStack package). However, it can be done (somewhat roughly) by plotting a
tree and a set of motifs side by side. In the following example, the cowplot package is used to glue the two
plots together, though other packages which perform this function are available.
library(universalmotif)
library(MotifDb)
library(cowplot)

## Get our starting set of motifs:
motifs <- convert_motifs(MotifDb[1:10])

## Get the tree: make sure it's a horizontal type layout
tree <- motif_tree(motifs, layout = "rectangular", linecol = "none")

## Now, make sure we order our list of motifs to match the order of tips:
mot.names <- sapply(motifs, function(x) x["name"])
names(motifs) <- mot.names
new.order <- tree$data$label[tree$data$isTip]
new.order <- rev(new.order[order(tree$data$y[tree$data$isTip])])
motifs <- motifs[new.order]

## Plot the two together (finessing of margins and positions may be required):
plot_grid(nrow = 1, rel_widths = c(1, -0.15, 1),

tree + xlab(""), NULL,
view_motifs(motifs, names.pos = "right") +

ylab(element_blank()) +
theme(

axis.line.y = element_blank(),
axis.ticks.y = element_blank(),
axis.text.y = element_blank(),
axis.text = element_text(colour = "white")

)

)
#> Warning: `label` cannot be a <ggplot2::element_blank> object.

9

4 Motif P-values

Motif P-values are not usually discussed outside of the bioinformatics literature, but are actually quite a
challenging topic. To illustrate this, consider the following example motif:
library(universalmotif)

m <- matrix(c(0.10,0.27,0.23,0.19,0.29,0.28,0.51,0.12,0.34,0.26,
0.36,0.29,0.51,0.38,0.23,0.16,0.17,0.21,0.23,0.36,
0.45,0.05,0.02,0.13,0.27,0.38,0.26,0.38,0.12,0.31,
0.09,0.40,0.24,0.30,0.21,0.19,0.05,0.30,0.31,0.08),

byrow = TRUE, nrow = 4)

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

motif <- create_motif(m, alphabet = "DNA", type = "PWM")
motif
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
N
#> A -1.32 0.10 -0.12 -0.40
#> C 0.53 0.20
#> G 0.85 -2.34 -3.64 -0.94

N
N
0.44
0.15
1.03 0.60 -0.12 -0.66 -0.54 -0.27 -0.12
0.59 -1.06
0.59

motif
DNA
PWM
+-
10.03
0
SHCNNNRNNV

N
1.04 -1.07

N
0.21

0.07

0.11

C

R

S

H

V
0.04
0.51
0.30

10

GZF3FZF1 [RC]ECM23 [RC]CST6FKH2 [RC]EDS1ABF2 [RC]GSM1 [RC]CAT8GIS1 [RC]1234567#> T -1.47 0.66 -0.06 0.26 -0.25 -0.41 -2.31

0.25

0.31 -1.66

Let us then use this motif with scan_sequences():
data(ArabidopsisPromoters)

res <- scan_sequences(motif, ArabidopsisPromoters, verbose = 0,

calc.pvals = FALSE, threshold = 0.8, threshold.type = "logodds")

stop

motif

start

motif.i

1
1
1
1
1
1

sequence sequence.i

score
<integer> <integer> <integer> <numeric>
5.301
5.292
5.869
5.643
5.510
5.637

<character> <integer> <character>
AT1G08090
AT1G49840
AT1G76590
AT2G15390
AT3G57640
AT4G14365

head(res)
#> DataFrame with 6 rows and 13 columns
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> 6
#>
#>
<character>
#> 1 CTCCAAAGAA
#> 2 CTCTGGATTC
#> 3 CTCTAGAGAC
#> 4 CCCCGGAGAC
#> 5 GCCCAGATAG
#> 6 CTCCAAAGTC

925
motif
980
motif
848
motif
337
motif
174
motif
motif
799
match thresh.score min.score max.score score.pct

934
989
857
346
183
808
strand
<numeric> <numeric> <numeric> <numeric> <character>
+
+
+
+
+
+

81.1667
81.0289
89.8637
86.4033
84.3669
86.3114

5.2248
5.2248
5.2248
5.2248
5.2248
5.2248

-15.4
-15.4
-15.4
-15.4
-15.4
-15.4

6.531
6.531
6.531
6.531
6.531
6.531

21
27
19
6
33
35

Now let us imagine that we wish to rank these matches by P-value. First, we must calculate the match
probabilities:

## One of the matches was CTCTAGAGAC, with a score of 5.869 (max possible = 6.531)

bkg <- get_bkg(ArabidopsisPromoters, 1)
bkg <- structure(bkg$probability, names = bkg$klet)
bkg
T
C
#>
#> 0.34768 0.16162 0.15166 0.33904

G

A

Now, use these to calculate the probability of getting CTCTAGAGAC.
hit.prob <- bkg["A"]^3 * bkg["C"]^3 * bkg["G"]^2 * bkg["T"]^2
hit.prob <- unname(hit.prob)
hit.prob
#> [1] 4.691032e-07

Calculating the probability of a single match was easy, but then comes the challenging part: calculating the
probability of all possible matches with a score higher than 5.869, and then summing these. This final sum
then represents the probability of finding a match which scores at least 5.869. One way is to list all possible
sequence combinations, then filtering based on score; however this “brute force” approach is unreasonable for
all but the smallest of motifs.

4.1 The dynamic programming algorithm for calculating P-values and scores

Instead of trying to find and calculate the probabilities of all matches with a score or higher than the query
score, one can use a dynamic programming algorithm to generate a much smaller distribution of probabilities
for the possible range of scores using set intervals. This method is implemented by the FIMO tool (Grant,

11

Bailey, and Noble 2011). The theory behind it is also explained in Gupta et al. (2007), though the purpose
of the algorithm is for motif comparison instead of motif P-values (however it is the same algorithm). The
basic concept will also be briefly explained here.

For each individual position-letter score in the PWM, the chance of getting that score from the respective
background probability of that letter is added to the intervals in which getting that specific score could allow
the final score to land. Once this probability distribution is generated, it can be converted to a cumulative
distribution and re-used for any input P-value/score to output the equivalent score/P-value. For P-value
inputs, it finds the specific score interval where the accompanying P-value in the cumulative distribution
smaller or equal to it, then reports the score of the previous interval. For score inputs, the scores are rounded
to the nearest interval in the cumulative distribution and the accompanying P-value retrieved. The major
advantages of this method include only looking for the probabilities of the range of scores with a set interval,
cutting down on needing to find the probabilities of all actual possible scores (and thus increasing performance
by several orders of magnitude for larger/higher-order motifs), and being able to re-use the distribution for
any number of query P-value/scores. Although this method involves rounding off scores to allow a small set
interval, in practice in the universalmotif package it offers the same maximum possible level of accuracy as
the exhaustive method (described in the next section) as motif PWMs are always internally rounded to a
thousandth of a decimal place for speed. This leaves as the only downside the inability to allow non-finite
values to exist in the PWM (e.g. from zero-probabilities) since then a known range with set intervals could
not possibly be created.

Going back to our example, we can see this in action using the motif_pvalue() function:
res <- res[1:6, ]
pvals <- motif_pvalue(motif, res$score, bkg.probs = bkg)
res2 <- data.frame(motif=res$motif,match=res$match,pval=pvals)[order(pvals), ]
knitr::kable(res2, digits = 22, row.names = FALSE, format = "markdown")

motif match

pval

motif CTCTAGAGAC 0.001495587
motif CCCCGGAGAC 0.001947592
motif CTCCAAAGTC 0.001962531
motif GCCCAGATAG 0.002257443
motif CTCCAAAGAA 0.002825922
motif CTCTGGATTC 0.002852671

To illustrate that we can also do the inverse of this calculation:
res$score
#> [1] 5.301 5.292 5.869 5.643 5.510 5.637
motif_pvalue(motif, pvalue = pvals, bkg.probs = bkg)
#> [1] 5.301 5.292 5.869 5.643 5.510 5.637

You may occasionally see slight errors at the last couple of digits. These are generally unavoidable to the
internal rounding mechanisms of the universalmotif package.

Let us consider more examples, such as the following larger motif:
data(ArabidopsisMotif)
ArabidopsisMotif
#>
#>
#>
#>
#>
#>

YTTTYTTTTTYTTTY
DNA
PPM
+-
15.99

Motif name:
Alphabet:
Type:
Strands:
Total IC:

12

Pseudocount:
Consensus:
Target sites:
E-value:

1
YTYTYTTYTTYTTTY
617
2.5e-87

#>
#>
#>
#>
#>
#>
Y
#> A 0.01 0.00 0.00 0.00 0.00 0.06 0.00 0.01 0.00 0.00 0.02 0.00 0.00 0.00 0.00
#> C 0.30 0.17 0.31 0.01 0.54 0.02 0.24 0.25 0.22 0.04 0.39 0.21 0.16 0.18 0.43
#> G 0.16 0.05 0.03 0.01 0.00 0.02 0.11 0.00 0.04 0.05 0.03 0.01 0.02 0.00 0.11
#> T 0.53 0.78 0.66 0.98 0.45 0.90 0.66 0.74 0.74 0.91 0.55 0.77 0.83 0.82 0.46

Y

T

Y

T

T

T

T

T

Y

T

Y

T

Y

T

Using the motif_range() utility, we can get an idea of the possible range of scores:
motif_range(ArabidopsisMotif)
#>
min
#> -125.070

max
18.784

We can use these ranges to confirm our cumulative distribution of P-values:
(pvals2 <- motif_pvalue(ArabidopsisMotif, score = motif_range(ArabidopsisMotif)))
#> [1] 1.000000e+00 2.143914e-09

And again, going back to scores from these P-values:
motif_pvalue(ArabidopsisMotif, pvalue = pvals2)
#> [1] -125.070

18.784

As a note: if you ever provide scores which are outside the possible ranges, then you will get the following
behaviour:
motif_pvalue(ArabidopsisMotif, score = c(-200, 100))
#> [1] 1 0

1

4

2

3

We can also use this function for the higher-order multifreq motif representation.
data(examplemotif2)
examplemotif2["multifreq"]["2"]
#> $`2`
#>
5 6
#> AA 0.0 0.5 0.5 0.5 0.0 0
#> AC 0.0 0.0 0.0 0.0 0.5 0
#> AG 0.0 0.0 0.0 0.0 0.0 0
#> AT 0.0 0.0 0.0 0.0 0.0 0
#> CA 0.5 0.0 0.0 0.0 0.0 0
#> CC 0.0 0.0 0.0 0.0 0.0 1
#> CG 0.0 0.0 0.0 0.0 0.0 0
#> CT 0.5 0.0 0.0 0.0 0.0 0
#> GA 0.0 0.0 0.0 0.0 0.0 0
#> GC 0.0 0.0 0.0 0.0 0.0 0
#> GG 0.0 0.0 0.0 0.0 0.0 0
#> GT 0.0 0.0 0.0 0.0 0.0 0
#> TA 0.0 0.0 0.0 0.0 0.0 0
#> TC 0.0 0.0 0.0 0.0 0.5 0
#> TG 0.0 0.0 0.0 0.0 0.0 0
#> TT 0.0 0.5 0.5 0.5 0.0 0
motif_range(examplemotif2, use.freq = 2)
#>

max

min

13

#> -39.948 18.921
motif_pvalue(examplemotif2, score = 15, use.freq = 2)
#> [1] 1.907349e-06
motif_pvalue(examplemotif2, pvalue = 0.00001, use.freq = 2)
#> [1] 9.276

motif
EQRTWY
PPM
13.99
0

Motif name:
Alphabet:
Type:
Total IC:
Pseudocount:

Feel free to use this function with any alphabets, such as amino acid motifs or even made up ones!
(m <- create_motif(alphabet = "QWERTY"))
#>
#>
#>
#>
#>
#>
#>
#>
#> E 0.26 0.04 0.42 0.00 0.04 0.00 0.25 0.00 0.36
#> Q 0.00 0.95 0.00 0.46 0.00 0.01 0.10 0.05 0.00
#> R 0.47 0.00 0.56 0.11 0.43 0.81 0.00 0.30 0.51
#> T 0.00 0.00 0.01 0.02 0.38 0.00 0.00 0.63 0.05
#> W 0.27 0.00 0.00 0.24 0.01 0.00 0.01 0.01 0.00
#> Y 0.00 0.00 0.00 0.18 0.14 0.18 0.64 0.01 0.08
motif_pvalue(m, pvalue = c(1, 0.1, 0.001, 0.0001, 0.00001))
3.961
#> [1] -158.765

[,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
0.00
0.00
0.03
0.90
0.00
0.06

-21.524

10.001

14.158

4.2 The branch-and-bound algorithm for calculating P-values from scores

The alternative to the dynamic programming algorithm is to exhaustively find all actual possible hits with a
score equal to or greater than the input score. Generally there is no advantage to solving this exhaustively,
with the exception that it allows non-finite values to be present (i.e., zero-probability letters which were not
pseudocount-adjusted during the calculation of the PWM). A few algorithms have been proposed to make
solving this problem exhaustively more efficient, but the method adopted by the universalmotif package is
that of Luehr, Hartmann, and Söding (2012). The authors propose using a branch-and-bound1 algorithm
(with a few tricks) alongside a certain approximation. Briefly: motifs are first reorganized so that the highest
scoring positions and letters are considered first in the branch-and-bound algorithm. Then, motifs past a
certain width (in the original paper, 10) are split in sub-motifs. All possible combinations are found in these
sub-motifs using the branch-and-bound algorithm, and P-values calculated for the sub-motifs. Finally, the
P-values are combined.

The motif_pvalue() function modifies this process slightly by allowing the size of the sub-motifs to be
specified via the k parameter; and additionally, whereas the original implementation can only calculate
P-values for motifs with a maximum of 17 positions (and motifs can only be split in at most two), the
universalmotif implementation allows for any length of motif to be used (and motifs can be split any
number of times). Changing k allows one to decide between speed and accuracy; smaller k leads to faster but
worse approximations, and larger k leads to slower but better approximations. If k is equal to the width of
the motif, then the calculation is exact. Is it important to note however that this is is still a computationally
intenstive task for larger motifs unless it is broken up into several sub-motifs, though at this point significant
accuracy is lost due to the high level of approximation.

Now, let us return to our original example, and this time for the branch-and-bound algorithm set method =
"exhaustive":

1https://en.wikipedia.org/wiki/Branch_and_bound

14

res <- res[1:6, ]
pvals <- motif_pvalue(motif, res$score, bkg.probs = bkg, method = "e")
res2 <- data.frame(motif=res$motif,match=res$match,pval=pvals)[order(pvals), ]
knitr::kable(res2, digits = 22, row.names = FALSE, format = "markdown")

motif match

pval

motif CTCTAGAGAC 0.001494052
motif CCCCGGAGAC 0.001944162
motif CTCCAAAGTC 0.001960741
motif GCCCAGATAG 0.002255555
motif CTCCAAAGAA 0.002823098
motif CTCTGGATTC 0.002848363

The default k in motif_pvalue() is 8. I have found this to be a good tradeoff between speed and P-value
correctness.

To demonstrate the effect that k has on the output P-value, consider the following (and also note that for
this motif k = 10 represents an exact calculation):
scores <- c(-6, -3, 0, 3, 6)
k <- c(2, 4, 6, 8, 10)
out <- data.frame(k = c(2, 4, 6, 8, 10),

score.minus6 = rep(0, 5),
score.minus3 = rep(0, 5),
score.0 = rep(0, 5),
score.3 = rep(0, 5),
score.6 = rep(0, 5))

for (i in seq_along(scores)) {
for (j in seq_along(k)) {

method = "e")

out[j, i + 1] <- motif_pvalue(motif, scores[i], k = k[j], bkg.probs = bkg,

}

}

knitr::kable(out, format = "markdown", digits = 10)

k

2
4
6
8
10

score.minus6

score.minus3

score.0

score.3

score.6

0.9692815
0.8516271
0.7647867
0.7647867
0.7649169

0.6783292
0.4945960
0.4298417
0.4298417
0.4299862

0.2241568
0.1581260
0.1418337
0.1418337
0.1419202

0.01809649
0.02271134
0.02291211
0.02291211
0.02293202

0.0000000000
0.0009788176
0.0012812392
0.0012812392
0.0012830021

For this particular motif, while the approximation worsens slightly as k decreases, it is still quite accurate
when the number of motif subsets is limited to two. Usually, you should only have to worry about k for
longer motifs (such as those sometimes generated by MEME), where the number of sub-motifs increases.

4.3 The random subsetting algorithm for calculating scores from P-values

Similarly to calculating P-values, exact scores can be calculated from small motifs, and approximate scores
from big motifs using subsetting. When an exact calculation is performed, all possible scores are extracted

15

and a quantile function extracts the appropriate score. For approximate calculations, the overall set of scores
are approximate several times by randomly adding up all possible scores from each k subset before a quantile
function is used.

Starting from a set of P-values and setting method = "exhaustive":
bkg <- c(A=0.25, C=0.25, G=0.25, T=0.25)
pvals <- c(0.1, 0.01, 0.001, 0.0001, 0.00001)
scores <- motif_pvalue(motif, pvalue = pvals, bkg.probs = bkg, k = 10,

method = "e")

scores.approx6 <- motif_pvalue(motif, pvalue = pvals, bkg.probs = bkg, k = 6,

method = "e")

scores.approx8 <- motif_pvalue(motif, pvalue = pvals, bkg.probs = bkg, k = 8,

method = "e")

pvals.exact <- motif_pvalue(motif, score = scores, bkg.probs = bkg, k = 10,

method = "e")

pvals.approx6 <- motif_pvalue(motif, score = scores, bkg.probs = bkg, k = 6,

method = "e")

pvals.approx8 <- motif_pvalue(motif, score = scores, bkg.probs = bkg, k = 8,

method = "e")

res <- data.frame(pvalue = pvals, score = scores,

pvalue.exact = pvals.exact,
pvalue.k6 = pvals.approx6,
pvalue.k8 = pvals.approx8,
score.k6 = scores.approx6,
score.k8 = scores.approx8)

knitr::kable(res, format = "markdown", digits = 22)

pvalue

score

pvalue.exact

pvalue.k6

pvalue.k8

score.k6

score.k8

1e-01
1e-02
1e-03
1e-04
1e-05

1.324
3.596
4.858
5.647
6.182

1.000299e-01
1.000309e-02
1.000404e-03
1.001358e-04
1.049042e-05

9.995747e-02
9.991646e-03
9.984970e-04
9.727478e-05
9.536743e-06

9.995747e-02
9.991646e-03
9.984970e-04
9.727478e-05
9.536743e-06

1.2866
3.6266
4.9543
5.3520
5.5403

1.3236
3.6033
4.8556
5.6717
6.1861

Starting from a set of scores:
bkg <- c(A=0.25, C=0.25, G=0.25, T=0.25)
scores <- -2:6
pvals <- motif_pvalue(motif, score = scores, bkg.probs = bkg, k = 10,

method = "e")

scores.exact <- motif_pvalue(motif, pvalue = pvals, bkg.probs = bkg, k = 10,

method = "e")

scores.approx6 <- motif_pvalue(motif, pvalue = pvals, bkg.probs = bkg, k = 6,

method = "e")

scores.approx8 <- motif_pvalue(motif, pvalue = pvals, bkg.probs = bkg, k = 8,

method = "e")

16

pvals.approx6 <- motif_pvalue(motif, score = scores, bkg.probs = bkg, k = 6,

method = "e")

pvals.approx8 <- motif_pvalue(motif, score = scores, bkg.probs = bkg, k = 8,

method = "e")

res <- data.frame(score = scores, pvalue = pvals,

pvalue.k6 = pvals.approx6,
pvalue.k8 = pvals.approx8,
score.exact = scores.exact,
score.k6 = scores.approx6,
score.k8 = scores.approx8)

knitr::kable(res, format = "markdown", digits = 22)

score

pvalue

pvalue.k6

pvalue.k8

score.exact

score.k6

score.k8

-2
-1
0
1
2
3
4
5
6

4.627047e-01
3.354645e-01
2.185555e-01
1.244183e-01
5.911160e-02
2.163410e-02
5.360603e-03
7.162094e-04
2.193451e-05

4.625721e-01
3.353453e-01
2.184534e-01
1.243525e-01
5.907822e-02
2.160931e-02
5.347252e-03
7.152557e-04
2.193451e-05

4.625721e-01
3.353453e-01
2.184534e-01
1.243525e-01
5.907822e-02
2.160931e-02
5.347252e-03
7.152557e-04
2.193451e-05

-2.000
-1.000
0.000
1.000
2.000
3.000
4.000
5.000
6.057

-1.9919
-1.0050
0.0042
1.0188
1.9934
3.0114
4.0000
4.9855
5.4287

-2.0032
-0.9998
-0.0030
0.9954
1.9970
2.9966
3.9965
5.0133
6.0549

As you may have noticed, results from exact calculations are not quite exact. This is due to the
universalmotif package rounding off values internally for speed.

Session info

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
#>
#> locale:
#> [1] LC_CTYPE=en_US.UTF-8
#> [3] LC_TIME=en_GB
#> [5] LC_MONETARY=en_US.UTF-8
#> [7] LC_PAPER=en_US.UTF-8
#> [9] LC_ADDRESS=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4
#> [8] base

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

grDevices utils

graphics

stats

datasets

LAPACK version 3.12.0

methods

17

dplyr_1.1.4
MotifDb_1.52.0
Seqinfo_1.0.0
S4Vectors_0.48.0
universalmotif_1.28.0

ggtree_4.0.1
GenomicRanges_1.62.0
XVector_0.50.0
BiocGenerics_0.56.0

tidyselect_1.2.1
S7_0.2.0
fastmap_1.2.0
lazyeval_0.2.2
GenomicAlignments_1.46.0
digest_0.6.37
tidytree_0.4.6
compiler_4.5.1
tools_4.5.1
data.table_1.17.8
knitr_1.50
htmlwidgets_1.6.4
curl_7.0.0
DelayedArray_0.36.0
aplot_0.2.9
BiocParallel_1.44.0
purrr_1.1.0
gdtools_0.4.4
MASS_7.3-65
tinytex_0.57

#>
#> other attached packages:
#> [1] cowplot_1.2.0
#> [4] ggplot2_4.0.0
#> [7] Biostrings_2.78.0
#> [10] IRanges_2.44.0
#> [13] generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#> [1] ggiraph_0.9.2
#> [3] farver_2.1.2
#> [5] bitops_1.0-9
#> [7] RCurl_1.98-1.17
#> [9] fontquiver_0.2.1
#> [11] XML_3.99-0.19
#> [13] lifecycle_1.0.4
#> [15] magrittr_2.0.4
#> [17] rlang_1.1.6
#> [19] yaml_2.3.10
#> [21] rtracklayer_1.70.0
#> [23] labeling_0.4.3
#> [25] S4Arrays_1.10.0
#> [27] splitstackshape_1.4.8
#> [29] RColorBrewer_1.1-3
#> [31] abind_1.4-8
#> [33] withr_3.0.2
#> [35] grid_4.5.1
#> [37] scales_1.4.0
#> [39] dichromat_2.0-0.1
#> [41] SummarizedExperiment_1.40.0 cli_3.6.5
#> [43] rmarkdown_2.30
#> [45] treeio_1.34.0
#> [47] rjson_0.2.23
#> [49] parallel_4.5.1
#> [51] restfulr_0.0.16
#> [53] vctrs_0.6.5
#> [55] Matrix_1.7-4
#> [57] fontBitstreamVera_0.1.1
#> [59] gridGraphics_0.5-1
#> [61] systemfonts_1.3.1
#> [63] glue_1.8.0
#> [65] gtable_0.3.6
#> [67] tibble_3.3.0
#> [69] rappdirs_0.3.3
#> [71] R6_2.6.1
#> [73] lattice_0.22-7
#> [75] Rsamtools_2.26.0
#> [77] fontLiberation_0.1.0
#> [79] Rcpp_1.1.0
#> [81] nlme_3.1-168
#> [83] MatrixGenerics_1.22.0
#> [85] pkgconfig_2.0.3

crayon_1.5.3
httr_1.4.7
ape_5.8-1
ggplotify_0.1.3
matrixStats_1.5.0
yulab.utils_0.2.1
jsonlite_2.0.0
bookdown_0.45
patchwork_1.3.2
tidyr_1.3.1
codetools_0.2-20
BiocIO_1.20.0
pillar_1.11.1
htmltools_0.5.8.1
evaluate_1.0.5
Biobase_2.70.0
cigarillo_1.0.0
ggfun_0.2.0
SparseArray_1.10.0
xfun_0.54
fs_1.6.6

18

References

Bhattacharyya, A. 1943. “On a Measure of Divergence Between Two Statistical Populations Defined by Their
Probability Distributions.” Bulletin of the Calcutta Mathematical Society 35: 99–109.

Grant, C. E., T. L. Bailey, and W. S. Noble. 2011. “FIMO: Scanning for Occurrences of a Given Motif.”
Bioinformatics 27: 1017–8.

Gupta, S., J. A. Stamatoyannopoulos, T. L. Bailey, and W. S. Noble. 2007. “Quantifying Similarity Between
Motifs.” Genome Biology 8: R24.

Hellinger, Ernst. 1909. “Neue Begründung Der Theorie Quadratischer Formen von Unendlichvielen Veränder-
lichen.” Journal Für Die Reine Und Angewandte Mathematik 136: 210–71.

Kullback, S., and R. A. Leibler. 1951. “On Information and Sufficiency.” The Annals of Mathematical
Statistics 22: 79–86.

Luehr, S., H. Hartmann, and J. Söding. 2012. “The XXmotif Web Server for EXhaustive, Weight MatriX-
Based Motif Discovery in Nucleotide Sequences.” Nucleic Acids Research 40: W104–W109.

Mahony, S., P. E. Auron, and P. V. Benos. 2007. “DNA Familial Binding Profiles Made Easy: Comparison
of Various Motif Alignment and Clustering Strategies.” PLoS Computational Biology 3 (3): e61.

Roepcke, S., S. Grossmann, S. Rahmann, and M. Vingron. 2005. “T-Reg Comparator: An Analysis Tool for
the Comparison of Position Weight Matrices.” Nucleic Acids Research 33: W438–W441.

Sandelin, A., and W. W. Wasserman. 2004. “Constrained Binding Site Diversity Within Families of
Transcription Factors Enhances Pattern Discovery Bioinformatics.” Journal of Molecular Biology 338 (2):
207–15.

Wang, T., and G. D. Stormo. 2003. “Combining Phylogenetic Data with Co-Regulated Genes to Identify
Motifs.” Bioinformatics 19 (18): 2369–80.

19

