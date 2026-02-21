Statistical analysis of tissue-scale lifetime ratios

Erika Donà, Joseph D. Barry, Guillaume Valentin, Charlotte Quirin,
Anton Khmelinskii, Andreas Kunze, Sevi Durdu, Lionel R. Newton,
Ana Fernandez-Minan, Wolfgang Huber, Michael Knop, Darren Gilmour

November 4, 2025

Contents

1 Introduction

2 Load and inspect data

3 Statistical tests

4 Normality

5 Alternative tests

1 Introduction

1

1

2

4

5

In this vignette we present the statistical analysis that was performed on the tissue-scale lifetime ratios in the main
paper.

2 Load and inspect data

The data was compiled into a table containing median whole-tissue ratios for each primordium.

> data("statsTable", package="DonaPLLP2013")
> x <- statsTable
> dim(x)

[1] 216

2

> head(x)

ratio condition
WT
WT
WT
WT
WT
WT

1 0.2923994
2 0.2386834
3 0.1966154
4 0.2129015
5 0.2100342
6 0.1991967

In total we had 6 conditions:

> table(x$condition)

Cxcl12a-/-
35
WT
45

Cxcr4b-/-
46
mem-tFT
34

Cxcr7-/- Cxcr7-/-Cxcl12aMo
21

35

1

1. wild-type (WT),
2. a mutant of the tagged receptor cxcr4b-/- (Cxcr4b-/-),
3. a mutant of the rear ligand-sequestering receptor cxcr7-/- (Cxcr7-/-),
4. a cxcr7-/- mutant with an additional morpholino knockdown of the signalling ligand cxcl12a (Cxcr7-/-

Cxcl12aMo),

5. a mutant of the signalling ligand cxcl12a, also known as sdf1a (Cxcl12a-/-), and
6. a membrane-tethered control protein tagged with the fluorescent timer (mem-tFT).

> splitByCond <-split(x$ratio, x$condition)
> plotOrder <- c("WT", "Cxcr4b-/-", "Cxcr7-/-", "Cxcr7-/-Cxcl12aMo", "Cxcl12a-/-",
+
> splitByCond <- splitByCond[plotOrder]
> stripchart(splitByCond, vertical=TRUE, xlab="Condition", ylab="Lifetime Ratio (-)",
+

group.names=1:length(splitByCond))

"mem-tFT")

For 1-5, the readout was the lifetime-ratio from a cxcr4b receptor tagged with the fluorescent timer, which
was expressed from a bacterial artificial chromosome. For 6, the readout was the lifetime-ratio from a different,
membrane-tethered control protein.

3 Statistical tests

We performed two-sided t-tests for each of the following comparisons of interest.

1. WT to Cxcr4b-/-
2. WT to Cxcr7-/-
3. WT to Cxcl12a-/-
4. WT to mem-tFT
5. Cxcr7-/- to Cxcr7-/-Cxcl12aMo

2

1234560.00.51.01.5ConditionLifetime Ratio (−)6. Cxcr4b-/- to Cxcr7-/-

matrix(nr=6, data=c("WT", "WT", "WT",

> compareConds <- as.data.frame(
+
+
+
+
+
> colnames(compareConds) <- c("condition 1", "condition 2")

"WT", "Cxcr7-/-", "Cxcr7-/-",
"Cxcr4b-/-", "Cxcr7-/-", "Cxcl12a-/-",

), stringsAsFactors=FALSE)

"mem-tFT", "Cxcr7-/-Cxcl12aMo", "Cxcr4b-/-")

Results from the t-tests were appended to our table.

res <- t.test(x$ratio[x$condition == compareConds[i,1]],
x$ratio[x$condition == compareConds[i,2]])

> for (i in seq_len(nrow(compareConds))) {
+
+
+
+
+
+
+
+
+
+ }
> compareConds

compareConds[i, "t"] <- res$statistic
compareConds[i, "df"] <- res$parameter
compareConds[i, "mean 1"] <- res$estimate[1]
compareConds[i, "mean 2"] <- res$estimate[2]
compareConds[i, "difference in means"] <- res$estimate[2]-res$estimate[1]
compareConds[i, "p.value"] <- res$p.value
compareConds[i, "method"] <- res$method

condition 1
WT
WT
WT
WT

condition 2
Cxcr4b-/-
Cxcr7-/-
Cxcl12a-/-

mean 2
4.907150 58.85822 0.3182417 0.2005986
9.079875 56.46167 0.3182417 0.1028506
-3.599910 73.09063 0.3182417 0.4389546
mem-tFT -11.643242 44.59746 0.3182417 0.9844275
Cxcr7-/- Cxcr7-/-Cxcl12aMo -9.901493 25.21075 0.1028506 0.3537685
-7.778590 78.68026 0.1028506 0.2005986
Cxcr7-/-

Cxcr4b-/-

mean 1

df

t

difference in means

p.value

method
-0.11764313 7.661584e-06 Welch Two Sample t-test
-0.21539114 1.244956e-12 Welch Two Sample t-test
0.12071291 5.765433e-04 Welch Two Sample t-test
0.66618575 4.098828e-15 Welch Two Sample t-test
0.25091794 3.588092e-10 Welch Two Sample t-test
0.09774801 2.404200e-11 Welch Two Sample t-test

1
2
3
4
5
6

1
2
3
4
5
6

Multiple testing correction was performed using the method of Bonferroni. We noted that since the p-values

are so small, this was not a critical step.

> compareConds[, "p.adjusted"] <- p.adjust(compareConds[, "p.value"],
+

method="bonferroni")

We preferred to view the table in decreasing order of the change in stability.

> compareConds[order(compareConds[, "condition 1"],
+

compareConds[, "difference in means"], decreasing=TRUE), ]

4
3
1
2
5
6

t

condition 2

condition 1
WT
WT
WT
WT

mean 2
mem-tFT -11.643242 44.59746 0.3182417 0.9844275
-3.599910 73.09063 0.3182417 0.4389546
4.907150 58.85822 0.3182417 0.2005986
9.079875 56.46167 0.3182417 0.1028506
Cxcr7-/- Cxcr7-/-Cxcl12aMo -9.901493 25.21075 0.1028506 0.3537685
-7.778590 78.68026 0.1028506 0.2005986
Cxcr7-/-
p.adjusted

Cxcl12a-/-
Cxcr4b-/-
Cxcr7-/-

difference in means

Cxcr4b-/-

p.value

mean 1

method

df

3

4
3
1
2
5
6

0.66618575 4.098828e-15 Welch Two Sample t-test 2.459297e-14
0.12071291 5.765433e-04 Welch Two Sample t-test 3.459260e-03
-0.11764313 7.661584e-06 Welch Two Sample t-test 4.596950e-05
-0.21539114 1.244956e-12 Welch Two Sample t-test 7.469737e-12
0.25091794 3.588092e-10 Welch Two Sample t-test 2.152855e-09
0.09774801 2.404200e-11 Welch Two Sample t-test 1.442520e-10

4 Normality

To assess whether the data were consistent with assumptions of normal distribution, we generated QQ-plots for
each condition individually.

qqnorm(residuals, main=main)
qqline(residuals)

> myPlotQQ <- function(residuals, main) {
+
+
+ }
> standardize <- function(x) {(x-mean(x, na.rm=TRUE))/sd(x, na.rm=TRUE)}
> par(mfrow=c(3, 2))
> for (c in unique(x$condition)) {
+
+
+ }

dataPts <- standardize(x[x$condition == c, "ratio"])
myPlotQQ(dataPts, c)

4

−2−1012−10123WTTheoretical QuantilesSample Quantiles−2−1012−1012Cxcl12a−/−Theoretical QuantilesSample Quantiles−2−1012−2−1012Cxcr4b−/−Theoretical QuantilesSample Quantiles−2−1012−2−1012Cxcr7−/−Theoretical QuantilesSample Quantiles−2−1012−2−1012Cxcr7−/−Cxcl12aMoTheoretical QuantilesSample Quantiles−2−1012−2−101mem−tFTTheoretical QuantilesSample QuantilesThe QQ plots indicated that the data was sufficiently close to being normally distributed.

5 Alternative tests

We also verified that an alternative, non-parametric test, the two-sided Mann-Whitney test (a two-sample Wilcoxon
test), returned equivalent results.

res <- wilcox.test(x$ratio[x$condition == compareCondsMW[i, 1]],
x$ratio[x$condition == compareCondsMW[i, 2]])

> compareCondsMW <- compareConds[, c("condition 1", "condition 2")]
> for (i in seq_len(nrow(compareCondsMW))) {
+
+
+
+
+
+ }
> compareCondsMW

compareCondsMW[i, "W"] <- res$statistic
compareCondsMW[i, "p.value"] <- res$p.value
compareCondsMW[i, "method"] <- res$method

condition 1
WT
WT
WT
WT

condition 2

W

p.value

method
Cxcr4b-/- 1583 7.594851e-06 Wilcoxon rank sum exact test
Cxcr7-/- 1515 2.281662e-16 Wilcoxon rank sum exact test
419 2.695266e-04 Wilcoxon rank sum exact test
45 4.265137e-17 Wilcoxon rank sum exact test
6 4.455117e-14 Wilcoxon rank sum exact test
163 2.184994e-11 Wilcoxon rank sum exact test

Cxcl12a-/-
mem-tFT
Cxcr7-/- Cxcr7-/-Cxcl12aMo
Cxcr4b-/-
Cxcr7-/-

1
2
3
4
5
6

We saw that the p-values were extremely similar to those generated by t-tests. Therefore the biological inter-

pretation of our results was identical in both cases.

5

