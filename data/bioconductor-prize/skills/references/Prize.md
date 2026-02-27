Prize: an R package for prioritization estimation
based on analytic hierarchy process

Daryanaz Dargahi

October 30, 2017

daryanazdargahi@gmail.com

Contents

1 Licensing

2 Overview

3 Relative AHP

3.1 Deﬁning the problem and determining the criteria, subcriteria,
and alternatives . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Structuring the decision hierarchy . . . . . . . . . . . . . . . . .
. . . . . . . . . . . .
3.3 Constructing pairwise comparison matrices
3.3.1 Aggregating individual judgments into a group judgment
3.4 Estimating and visualizing priorities . . . . . . . . . . . . . . . .

4 Rating AHP

4.1 Deﬁning a rating scale and obtaining alternatives priorities

. . .

2

2

3

3
3
4
6
8

13
13

1

1 Licensing

Under the Artistic License, you are free to use and redistribute this software.

2 Overview

The high throughput studies often produce large amounts of numerous genes
and proteins of interest. While it is diﬃcult to study and validate all of them.
In order to narrow down such lists, one approach is to use a series of criteria to
rank and prioritize the potential candidates based on how well they meet the
research goal. Analytic hierarchy process (AHP) [1] is one of the most popular
group decision-making techniques for ranking and prioritizing alternatives when
multiple criteria must be considered. It provides a comprehensive and rational
framework to address complicated decisions by modeling the problem in a hi-
erarchical structure, showing the relationships of the goal, objectives (criteria
and subcriteria), and alternatives. AHP has unique advantages when commu-
nication among team members is impeded by their diﬀerent specializations or
perspectives. It also enables decision makers to evaluate decision alternatives
when important elements of the decision are diﬃcult to quantify or compare.

The AHP technique uses pairwise comparisons to measure the impact of
items on one level of the hierarchy on the next higher level. It has two models for
arriving at a ranking of alternatives. (A) The relative model, where alternatives
are compared in a pairwise manner regarding their ability to achieve each of the
criteria. (B) The rating model is often used when the number of alternatives
is large, or if the possibility of adding or deleting alternatives exists [2]. This
model requires establishing a series of rating scales (categories) for each criterion.
These scales must be pairwise compared to determine the relative importance
of each rating category, and then alternatives are evaluated one at a time by
selecting the appropriate rating category for each criterion.

Here, we introduce an R package for AHP, ”Prize”. Prize oﬀers the im-
plementation of both relative and rating AHP models. In order to rank and
prioritize a set of alternatives with AHP, decision makers must take four steps:

1. Deﬁne the problem and determine the criteria, subcriteria, and alterna-

tives

2. Structure the decision hierarchy

3. Construct pairwise comparison matrices

4. Estimate and visualize priorities

In the following, we describe a brief example use case for Prize in transla-

tional oncology.

2

3 Relative AHP

3.1 Deﬁning the problem and determining the criteria,

subcriteria, and alternatives

Assume a scenario that a group of scientists identiﬁed 10 genes that are being
diﬀerentially expressed (DE) in tumor tissues in comparison to healthy tissues.
They are interested in ranking and prioritizing these genes based on their po-
tential role as a tumor marker or therapeutic target. They decide to consider
the (1) gene expression proﬁle in tumor tissue, (2) gene expression proﬁle in
healthy tissue, (3) frequency of being DE, and (4) epitopes as the criteria for
making their decision. They also subdivide the epitope criterion into the size
and number of extracellular regions.

3.2 Structuring the decision hierarchy

The scientists form their decision hierarchy as follows;

> require(Prize)
> require(diagram)

’

’

> mat <- matrix(nrow = 7, ncol = 2, data = NA)
’
4.2
,
> mat[,1] <- c(
’
> mat[,2] <- c(
,
+
> mat

,
3
0
Prioritization_of_DE_genes
’
Frequency

Epitopes

’
’
’

4.1

’
’

,

,

,

1

2

,

,

4

,

’

’

’

’

’

’

’

’

’

’

’

’

)

Tumor_expression
,

Number_of_epitopes

’

,
’

Normal_expression
)

Size_of_epitopes

’

’

’

’

,

[,1] [,2]

"Prioritization_of_DE_genes"
[1,] "0"
"Tumor_expression"
[2,] "1"
"Normal_expression"
[3,] "2"
"Frequency"
[4,] "3"
[5,] "4"
"Epitopes"
[6,] "4.1" "Number_of_epitopes"
[7,] "4.2" "Size_of_epitopes"

> ahplot(mat, fontsize = 0.7, cradx = 0.11 ,sradx = 0.12, cirx= 0.18, ciry = 0.07)

3

3.3 Constructing pairwise comparison matrices

Each scientist (decision maker) investigates the values of the decision elements
in the hierarchy, and incorporates their judgments by performing a pairwise
comparison of these elements. Each decision element in the upper level is used
to compare the elements of an immediate inferior level of the hierarchy with
respect to the former. That is, the alternatives are compared with respect to
the subcriteria, the subcriteria are compared with respect to the criteria and
the criteria are compared with respect to the goal. Therefore, each decision
maker constructs a set of pairwise comparison matrices reﬂecting how impor-
tant decision elements are to them with respect to the goal. Pairwise comparison
matrices are built from the comparison between elements, based on the Saaty
fundamental scale [3].

4

Prioritization_of_DE_genesTumor_expressionNormal_expressionFrequencyEpitopesNumber_of_epitopesSize_of_epitopesTable 1: Saaty fundamental scale for pairwise comparison [3]

Intensity of
importance
1

3

5

7

9

Deﬁnition

Explanation

Equal importance

Moderate
tance

impor-

Strong importance

Very strong impor-
tance

Extreme
tance

impor-

Two elements contribute equally
to the objective
Experience
judgement
and
slightly favor one element over
an other
judgement
and
Experience
strongly favor one element over
an other
One element
favored very
is
strongly over an other, its dom-
inance is demonstrated in prac-
tice
The evidence favoring one ele-
ment over another is of the high-
est possible order of aﬃrmation

Intensities of 2,4,6, and 8 can be used to express intermediate values.
Intensitise 1.1, 1.2, 1.3, etc. can be used for elements that are very close
in importance

For instance, to pairwise compare the criteria a total of six comparisons
must be done, including Tumor expression/Normal expression, Tumor expres-
sion/Frequency, Tumor expression/Epitope, Normal expression/Frequency, Nor-
mal expression/Epitope, and Frequency/Epitope. The criteria pairwise compar-
ison matrix (PCM) is shown below.

> pcm <- read.table(system.file(
+
> pcm

sep =

\t

’

’

’

extdata

’

’

,

ind1.tsv

’

,package =

’

’

Prize

),

, header = TRUE, row.names = 1)

Tumor_expression
Normal_expression
Frequency
Epitopes

Tumor_expression Normal_expression Frequency Epitopes
5
4
2
1

1
NA
NA
NA

4
3
1
NA

2
1
NA
NA

The ahmatrix function completes a pairwise comparison matrix by convert-
ing the triangular matrix into a square matrix, where diagonal values are equal
1 and pcm[j,i] = 1/pcm[i,j].

5

> pcm <- ahmatrix(pcm)
> ahp_matrix(pcm)

Tumor_expression
Normal_expression
Frequency
Epitopes

Tumor_expression Normal_expression Frequency Epitopes
5
4
2
1

2.0000000
1.0000000
0.3333333
0.2500000

1.00
0.50
0.25
0.20

4.0
3.0
1.0
0.5

3.3.1 Aggregating individual judgments into a group judgment

Once the individual PCMs are available, gaggregate function could be used
to combine the opinions of various decision makers into an overall opinion for
the group. gaggregate oﬀers two aggregation methods including aggregation
of individual judgments (AIJ - geometric mean) and aggregation of individual
priorities (AIP - using arithmetic mean) [4]. If decision makers have diﬀerent
expertise or perspectives, in order to reﬂect that in the group judgment, one
can use a weighted AIJ or AIP, by simply providing a weight for each decision
maker.

’
’
’
’

> mat = matrix(nrow = 4, ncol = 1, data = NA)
ind1.tsv
> mat[,1] = c(system.file(
ind2.tsv
system.file(
+
ind3.tsv
system.file(
+
ind4.tsv
system.file(
+
’
’
ind1
> rownames(mat) = c(
,
’
individual_judgement
> colnames(mat) = c(
> # non-weighted AIJ
> res = gaggregate(srcfile = mat, method =

extdata
extdata
extdata
extdata
’
,
ind2

,
,
,
,
ind3

’
’
’
’
’

’
’
’
’

)

,

’

’

’

’

’

’
’
’
’

’

ind4

)

,package =
,package =
,package =
,package =

’
’
’
’

’
’
’
’

Prize
Prize
Prize
Prize

),
),
),
))

geometric

, simulation = 500)

’

> # aggregated group judgement using non-weighted AIJ
> AIJ(res)

Tumor_expression
Normal_expression
Frequency
Epitopes

Tumor_expression Normal_expression Frequency Epitopes
2.0000000 3.4641016 5.143687
1.0000000 3.6628415 5.383563
0.2730121 1.0000000 1.681793
0.1857506 0.5946036 1.000000

1.0000000
0.5000000
0.2886751
0.1944131

> # consistency ratio of the aggregated group judgement
> GCR(res)

[1] 0.0288733

The distance among individual and group judgments can be visualized us-
ing the dplot function. dplot uses a classical multidimensional scaling (MDS)
approach [5] to compute the distance among individual and group priorities.

6

> require(ggplot2)

> # Distance between individual opinions and the aggregated group judgement
> dplot(IP(res))

The consistency ratio of individual judgments can be visualized using the
crplot function. If the consistency ratio is equal or smaller than 0.1, then the
decision is considered to be consistent.

> # Consistency ratio of individal opinions
> crplot(ICR(res), angle = 45)

7

lllllind1ind2ind3ind4Group judgement−0.02−0.010.000.010.020.03−0.2−0.10.00.10.2Coordinate 1Coordinate 23.4 Estimating and visualizing priorities

In order to obtain the priorities of decision elements to generate the ﬁnal alter-
natives priorities, local and global priorities are required to be obtained from the
comparison matrices. Local priorities are determined by computing the maxi-
mum eigenvalue of the PCMs. The local priorities are then used to ponder the
priorities of the immediately lower level for each element. The global priorities
are obtained by multiplying the local priorities of the elements by the global
priority of their above element. The total priorities of the alternatives are found
by the addition of alternatives global prioritiese.

The pipeline function computes local and global priorities, as well as ﬁnal
prioritization values. P ipeline can simply be called by a matrix including the

8

0.0000.0250.0500.0750.100ind1ind2ind3ind4IDICRConditionPassproblem hierarchy and group PCMs. The scientists use the following matrix
(mat) to call the pipeline function;

> require(stringr)

’

’

’

’

’

’

’

’

’

’

’

’

,

4

2

,

1

,

,

)

’
’

4.1

’
’
’

0
,
3
Prioritization_of_DE_genes
’
Frequency

> mat <- matrix(nrow = 7, ncol = 3, data = NA)
’
4.2
> mat[,1] <- c(
,
’
> mat[,2] <- c(
,
+
,
> mat[,3] <- c(system.file(
system.file(
+
system.file(
+
system.file(
+
system.file(
+
system.file(
+
system.file(
+

Epitopes
,
,
,
,
,
,
,

extdata
extdata
extdata
extdata
extdata
extdata
extdata

Number_of_epitopes
’

,
aggreg.judgement.tsv
tumor.PCM.tsv
normal.PCM.tsv
freq.PCM.tsv
epitope.PCM.tsv
epitopeNum.PCM.tsv
epitopeLength.PCM.tsv

’
’
’
’
’
’
’
’

Tumor_expression
,

,package =

’
’
’
’
’
’
’

’
’
’
’
’
’
’

,package =
’

,package =
’

,
’

’

’

’

’

’

’

’

’

,package =

’

,package =
’
Prize
’

’

),
’

Prize

),

’

Prize
’

),
Prize
’

,package =

,package =

’

),
Prize
’

’

),
Prize

’

))

Normal_expression
)

Size_of_epitopes
’
),

Prize

’

’

’

,

> # Computing alternatives priorities
> prioritization <- pipeline(mat, model =

’

relative

’

, simulation = 500)

The global priorities of decision elements can be visualized using the ahplot

function.

> ahplot(ahp_plot(prioritization), fontsize = 0.7, cradx = 0.11 ,sradx = 0.12,
+

cirx= 0.18, ciry = 0.07, dist = 0.06)

9

Contribution of decision elements in the ﬁnal priority estimation could also

be visualized using wplot.

> require(reshape2)

> wplot(weight_plot(prioritization)$criteria_wplot, type =
+

fontsize = 7, pcex = 3)

’

’

pie

,

10

Prioritization_of_DE_genesTumor_expressionNormal_expressionFrequencyEpitopesNumber_of_epitopesSize_of_epitopes0.470.3410.1160.0740.0090.064The rainbow function illustrates prioritized alternatives detailing the con-

tribution of each criterion in the ﬁnal priority score.

> rainbowplot(rainbow_plot(prioritization)$criteria_rainbowplot, xcex = 3)

11

47%34%12%7%CriteriaTumor_expressionNormal_expressionFrequencyEpitopesThe Carbonic anhydrase 9 (CA9) and Mucin-16 (MUC16) with a global
priority of 0.134 are the alternative that contribute the most to the goal of
choosing the optimal tumor marker/therapeutic target among the identiﬁed DE
genes. Drugs targeting CA9 and MUC16 are currently in pre-clinical and clinical
studies [6, 7].

> rainbow_plot(prioritization)$criteria_rainbowplot

Tumor_expression Normal_expression

BSG|682
CD44|960
CD38|952
CA9|768
MUC16|94025
CD9|928

0.061335201
0.061335201
0.017114410
0.061335201
0.061335201
0.061335201

12

Epitopes
Frequency
0.01248896 0.016786400 0.007461660
0.01248896 0.016786400 0.007461660
0.04853918 0.002480381 0.007461660
0.04853918 0.016786400 0.007461660
0.04853918 0.016786400 0.007461660
0.01248896 0.006816627 0.006950588

0.1340.1340.1120.0980.0980.0980.0980.0880.0760.064CA9|768MUC16|94025CD70|970BSG|682CD44|960EGFR|1956MUC1|4582CD9|928CD38|952FZD10|11211Total priority scoreAlternativeCriteriaTumor_expressionNormal_expressionFrequencyEpitopes0.01248896 0.016786400 0.007461660
0.08407232 0.003506147 0.007461660
0.01248896 0.016786400 0.007461660
0.04853918 0.002480381 0.006950588

EGFR|1956
CD70|970
MUC1|4582
FZD10|11211

BSG|682
CD44|960
CD38|952
CA9|768
MUC16|94025
CD9|928
EGFR|1956
CD70|970
MUC1|4582
FZD10|11211

0.061335201
0.017114410
0.061335201
0.006154539
total_priorities
0.09807222
0.09807222
0.07559563
0.13412244
0.13412244
0.08759138
0.09807222
0.11215454
0.09807222
0.06412469

4 Rating AHP

As the number of alternatives increase, the amount of pairwise comparison be-
comes large. Therefore, pairwise comparisons take much time and also the
possibility of inconsistency in the comparisons increases. Rating AHP over-
comes this problem by categorizing the criteria and/or subcriteria in order to
classify alternatives. In another words, rating AHP uses a set of categories that
serves as a base to evaluate the performance of the alternatives in terms of each
criterion and/or subcriterion. The rating procedure is also suitable when the
possibility of adding/removing alternatives exists. The rating AHP reduces the
number of judgments that decision makers are required to make.

The rating AHP diﬀers from the relative AHP in the evaluation and obtain-
ing the priority of alternatives. Hence, the decision markers deﬁne their decision
problem, structure the problem into a hierarchy, and collect PCM matrices for
each criteria/subcriteria similar to the relative AHP approach. Then, they use
a rating approach to evaluate alternatives.

4.1 Deﬁning a rating scale and obtaining alternatives pri-

orities

In the example scenario, the scientists would like to rank and prioritize 10 genes
based on their potential role as a tumor marker/therapeutic target. To build a
PCM matrix consisting of 10 alternatives 45 pairwise comparisons are required.
The large number of pairwise comparisons makes this step time consuming and
increase the possibility of inconsistency in the comparisons. Therefore, scientists
decide to use rating AHP by deﬁning a series of categories with respect to the
criteria and/or subcriteria to evaluate alternatives. They also compute a PCM
of these categories. For instance, they deﬁne two categories, single and multiple,
for the numberof epitopes subcriteria, and compute their PCM.

13

> category_pcm = read.table(system.file(
’
+
> category_pcm

, sep =

\t

’

’

’

’

extdata

number.tsv
, header = TRUE, row.names = 1)

, package =

,

’

’

’

Prize

)

Single
Multiple

Single Multiple
2
1

1
NA

Then, decision makers evaluate the alternatives against the deﬁned categories
and build an alternative matrix showing the category that each alternative be-
longs to.

> alt_mat = read.table(system.file(
+
> alt_mat

package =

’

’

’

’

’

,

’

’

extdata

numEpitope_alternative_category.tsv

,

Prize

), sep =

\t

, header = FALSE)

’

V2
V1
Single
BSG|682
1
Single
CD44|960
2
Single
CD38|952
3
Single
4
CA9|768
Single
5 MUC16|94025
CD9|928 Multiple
6
Single
7
Single
8
9
Single
10 FZD10|11211 Multiple

EGFR|1956
CD70|970
MUC1|4582

To compute the idealised priorities of alternatives, the rating functions can

be called by a category PCM and an alternative matrix.

> result = rating(category_pcm, alt_mat, simulation = 500)
> # rated alternatives
> RM(result)

scale_category idealised_priorities
"Single"
BSG|682
"Single"
CD44|960
"Single"
CD38|952
CA9|768
"Single"
MUC16|94025 "Single"
CD9|928
EGFR|1956
CD70|970
MUC1|4582
FZD10|11211 "Multiple"

"1"
"1"
"1"
"1"
"1"
"0.5"
"1"
"1"
"1"
"0.5"

"Multiple"
"Single"
"Single"
"Single"

The matrix of idealised priorities (rated alternatives) can be used to call

pipeline function to estimate ﬁnal priorities of alternatives.

14

’

’

’

’

’

’

’

’

’

’

’

’

’

)

,

4

,

,

2

1

,

’
’

4.1

’
’
’

0
,
3
Prioritization_of_DE_genes
’
Frequency

> mat <- matrix(nrow = 7, ncol = 3, data = NA)
’
4.2
> mat[,1] <- c(
,
’
> mat[,2] <- c(
,
Epitopes
+
,
,
> mat[,3] <- c(system.file(
,
system.file(
+
,
system.file(
+
,
system.file(
+
,
system.file(
+
,
system.file(
+
+
,
system.file(
> # Computing alternatives priorities
> prioritization <- pipeline(mat, model =

extdata
extdata
extdata
extdata
extdata
extdata
extdata

’
’
’
’
’
’
’
’

’
’
’
’
’
’
’

’
’
’
’
’
’
’

Tumor_expression
,

Number_of_epitopes
’
’

,
aggreg.judgement.tsv
tumor_exp_rating.tsv
normal_exp_rating.tsv
freq_exp_rating.tsv
epitope.PCM.tsv
epitope_num_rating.tsv
epitope_size_rating.tsv

rating

’

’

’

’

’

’

,

’

’

’

,
’

Normal_expression
)

Size_of_epitopes
’
),
’
),
’

Prize
Prize
’

,package =
,package =
’

’
’

’

Prize

),

,package =
’

,package =

’

),

’

Prize
),
’

’

Prize
,package =
’

,package =

’

Prize
’

Prize

),
’

))

,package =

, simulation = 500)

References

[1] T.L. Saaty. A scaling method for priorities in hierarchical structures. Journal

of Mathematical Psychology, 15(3):234 – 281, 1977.

[2] T.L. Saaty. Rank from comparisons and from ratings in the analytic
hierarchy/network processes. European Journal of Operational Research,
168(2):557–570, January 2006.

[3] T.L. Saaty. The Analytic Hierarchy Process, Planning, Piority Setting, Re-

source Allocation. McGraw-Hill, New york, 1980.

[4] E. Forman and K. Peniwati. Aggregating individual judgments and prior-
ities with the analytic hierarchy process. European Journal of Operational
Research, 108(1):165 – 169, 1998.

[5] J.C. Gower. Some distance properties of latent root and vector methods

used in multivariate analysis. Biometrika, 53(3/4):325 – 338, 1966.

[6] M. Felder, A. Kapur, J. Gonzalez-Bosquet, S. Horibata, J. Heintz, R. Al-
brecht, L. Fass, J. Kaur, K. Hu, H. Shojaei, R. J. Whelan, and M. S.
Patankar. MUC16 (CA125): tumor biomarker to cancer therapy, a work
in progress. Mol. Cancer, 13:129, 2014.

[7] P. C. McDonald, J. Y. Winum, C. T. Supuran, and S. Dedhar. Recent
developments in targeting carbonic anhydrase IX for cancer therapeutics.
Oncotarget, 3(1):84–97, Jan 2012.

15

