paircompviz: An R Package for Visualization of Multiple
Pairwise Comparison Test Results

Michal Burda
University of Ostrava

Abstract

The aim of this paper is to describe an R package for visualization of the results of
multiple pairwise comparison tests. Having data that capture some treatments, multiple
comparisons test for differences between all pairs of them. The paircompviz package pro-
vides a function for visualization of such results in Hasse diagram, a graph with significant
differences as directed edges between vertices representing the treatments.

Keywords: multiple, pairwise, comparison, test, visualization, Hasse diagram, R.

>

library(paircompviz)

1. Introduction

Visualization is an important tool for exploration, analysis and presentation of data. A clear
and vivid figure or diagram can improve significantly the readibility of the presented facts. In
this paper, an implementation of a novel technique for visualization of multiple comparison
test results is presented. Multiple comparison tests (or pairwise tests) occur in testing for
differences between all pairs of k treatments (Hsu 1996).
It is a common fact that for k
(cid:1) = k(k−1)
treatments, a batch of (cid:0)k
2
Typically, the pairwise comparison tests are performed on treatment means, but they may be
also applied on other statistics such as variances, quantiles, or proportions.

tests has to be performed to compare all pairs.

2

Multiple comparison procedure usually results in a triangular matrix M of p-values, where the
cell mij of matrix M has p-value of test for difference between treatments i and j. Comparisons
with p-value below some given threshold α (usually α = 0.05) are considered statistically
significant.

Even for as small number of treatments (e.g. k = 5), it is rather inconvenient to perceive the
results directly. An appropriate visualization may significantly improve the understandability.
A common approach for visualization of multiple comparisons is a line or letter diagram
(Gramm, Guo, H¨uffner, Niedermeier, Piepho, and Schmid 2007; Ennis, Fayle, and Ennis
2009).

The main ideas of these diagrams are briefly described on the following example. Assume
treatments T1, . . . , T5 such that T1 and T5 is the only significantly different pair. The line
diagram is constructed as follows: (1) Sort the treatments accordingly to their tested values

2

paircompviz: Multiple Comparison Tests Visualization

T1 T2 T3 T4 T5

T1 T2 T3 T4 T5
a
a
b

a
b

a
b

b

(a) Line diagram

(b) Letter diagram

Figure 1: Diagrams of treatments T1, . . . , T5 such that only treatments T1 and T5 are signifi-
cantly different, i.e. treatments underlined with the same line or sharing a common letter are
not (significantly) different.

T1 T2 T3 T4 T5
a
b

a

b

c

c
d

c
d

d

Figure 2: An example of letter diagram for which the corresponding line diagram can not be
constructed.

(e.g. mean) into increasing order. (2) Draw a line under all largest groups of treatments
such that no pair of treatments in that group is significantly different. Since there are two
groups of pairwise-non-significant treatments, the resulting line diagram contains two lines –
see Figure 1(a).

Some authors (e.g. Piepho (2000)) prefer to use letters instead of lines, because it is sometimes
not possible to represent all statements of significance by a diagram with non-interrupted lines.
The general idea is to replace each line of the line diagram with a letter – see letter diagram
in Figure 1(b) that is equivalent to line diagram in Figure 1(a).

Consider now the only significant treatments be pairs (T1, T5), (T1, T3), (T2, T4). A correspond-
ing letter diagram is depicted in Figure 2. For that case, a line diagram does not exist since it
is not possible to draw all lines without interrupting them (Piepho 2000; Gramm et al. 2007).

Letter diagrams can be quite complicated even for such simple setting as in the previous
example. Since letter diagrams visualize groups of non-significant treatments, it may be
sometimes hard to immediately determine the significantly different pairs of treatments.

Therefore the package paircompviz, a novel R implementation of the visualization technique
based on Hasse diagrams, is presented in this paper. Unlike letter diagrams, Hasse diagrams
explicitly depict the significant pairs in an easy-understandable way. Moreover, additional
visual information can be introduced within the diagrams, such as treatment means, sample
sizes or p-values. The author believes that Hasse diagrams provide a vivid and easily under-
standable alternative to letter diagrams for visualization of the all-pairwise comparison test
results.

2. Hasse Diagrams

Before describing the proposed visualization technique, some important notions have to be
defined.

Michal Burda

3

Figure 3: An illustrative Hasse diagram (see the example in section 2).

A partial order is a binary relation Q ⊆ P × P , which is reflexive, antisymmetric, and
transitive. A partially ordered set is a set P equipped with a partial order relation Q.

Hasse diagram is a simple picture of a finite partially ordered set. It is a graph with each
member of a set P being represented as a vertex. A directed edge is drawn downwards
from vertex y to vertex x if and only if (x, y) ∈ Q, x ̸= y, and there is no such z that
(x, z) ∈ Q ∧ (z, y) ∈ Q. Each edge must be connected to exactly two vertices:
its two
endpoints. In other words, x, y ∈ Q iff y is positioned above x and there exists a path from
y to x.

Example. Consider Hasse diagram in Fig. 3. As can be seen, node A is greater than all other
nodes except H, because there exists a path from A to any other node except H. Nodes
C and D are incomparable, although they are both greater than E, F and G. Node H is
(B, A), (C, B),
incomparable with any other node. The whole partial order relation is:
(C, A), (D, A), (E, C), (E, B), (E, A), (E, D), (F, E), (F, C), (F, B), (F, A), (F, D), (G, E),
(cid:111)
.
(G, C), (G, B), (G, A), (G, D), (A, A), (B, B), (C, C), (D, D), (E, E), (F, F ), (G, G), (H, H)

(cid:110)

3. Visualization of All-Pairwise Comparison Tests

Consider now an all-pairwise comparison test τ of statistic ψ on k treatments T1, . . . , Tk. Let
ψ(Ti) denote a value of statistic ψ on treatment Ti. For instance, if ψ would be a mean, then
ψ(Ti) would denote the mean value of treatment Ti. Let τ (Ti, Tj) < α denote statistically
significant difference between treatments Ti and Tj at the significance level α (e.g. τ could
be a two sample Student’s t–test).

       A              B              C              D              E              F              G              H       4

paircompviz: Multiple Comparison Tests Visualization

If a relation

(cid:26)

H =

(Ti, Tj) | i = j ∨

(cid:16)

ψ(Ti) < ψ(Tj) ∧ τ (Ti, Tj) < α

(cid:17)(cid:27)

(1)

is a partial order on {T1, . . . , Tk}, it can be depicted as a Hasse diagram.
Function paircomp of the paircompviz package is intended to create Hasse diagrams from the
result H of multiple comparisons. Graph rendering is performed with the Rgraphviz package
(Gentry, Long, Gentleman, Falcon, Hahne, Sarkar, and Hansen 2013).

As an example, consider a cholesterol dataset from the multcomp package by Hothorn,
Bretz, and Westfall (2008a). It contains measures of cholesterol response (cholesterol$response)
to 5 treatments (cholesterol$trt).

>
>

library(multcomp)
head(cholesterol)

trt response
3.8612
1 1time
2 1time 10.3868
5.9059
3 1time
3.0609
4 1time
7.7204
5 1time
2.7139
6 1time

Let us perform a pairwise Student’s t test on response grouped by trt:

>

pairwise.t.test(cholesterol$response, cholesterol$trt)

Pairwise comparisons using t tests with pooled SD

data: cholesterol$response and cholesterol$trt

1time

2times 4times drugD

-
2times 0.06400 -
-
4times 0.00023 0.06870 -
-
drugD 2.8e-07 0.00053 0.06870 -
drugE 1.1e-12 2.1e-09 2.7e-06 0.00139

P value adjustment method: holm

We can see many statistically significant results (for significance level α = 0.05), however, it
is not immediately clear, which group response is greater than other etc. Let us depict the
results in a Hasse diagram (see Fig. 4):

>

paircomp(obj=cholesterol$response, grouping=cholesterol$trt, test="t")

The obj argument is for a response vector and grouping is for a grouping factor.

Michal Burda

5

Figure 4: Hasse diagram from pairwise t test on the cholesterol data

The test argument specifies the type of pairwise tests. Possible values are: "t", "prop", and
"wilcox", for t test, proportion test and Wilcoxon rank sum test, respectively. See also stats
package functions pairwise.t.test, pairwise.prop.test and pairwise.wilcox.test for
details.

Other function arguments are: level, main, visualize, result, draw and compress. The
last argument is described separately in section 3.2.

The level argument is for setting the significance threshold α (default is 0.05), main specifies
the diagram title. If result is TRUE, the test statistics are also returned from the paircomp
function. Diagram drawing can be disabled by setting draw to FALSE.
The visualize argument is a vector of string flags that enable drawing of some additional
graphical information into the diagram. The meaning of the flags depends on the type of
the test being used (t test, Wilcoxon test, or proportion test).
If "position" is present
in the vector, the vertices background color is derived from mean, median, or proportion,
respectively, "size" enables vertices sizes to correspond to sample sizes, and finally, the
presence of "pvalue" enables p-value labels along with edges as well as varying edge thickness
corresponding to p-value of the comparison test.

There may be also other arguments passed to the paircomp function. They are transpar-
ently forwarded to the underlying pairwise comparison tests functions (pairwise.t.test,
pairwise.prop.test, or pairwise.wilcox.test). For instance, a different p-value adjust-
ment method may be required. For that, a p.adjust.method argument exists in the under-
lying functions:

>
+

paircomp(InsectSprays$count, InsectSprays$spray, test="t",

compress=TRUE, p.adjust.method="bonferroni")

     1time         2times        4times         drugD          drugE     2.293e−042.824e−075.289e−042.689e−061.393e−03Pairwise comparisons on cholesterol$response by cholesterol$trt using t tests with pooled SD and holm p−value adjustment6

paircompviz: Multiple Comparison Tests Visualization

See help pages for more details.

3.1. Displaying Pairwise Comparisons Provided by the multcomp Package

Another method for pairwise comparisons is provided by the multcomp package (Hothorn
et al. 2008a). Moreover, that package allows to depict box-plots enriched with compact letter
display that was discussed in section 1. The multcomp package provides Tukey’s test for
multiple comparisons by the glht function. Results from that function may also be passed to
paircomp in order to generate a Hasse diagram from it. An example on car90 dataset from
the rpart package (Therneau, Atkinson, and Ripley 2013) follows:

>
>
>
>
>

# for car90 dataset
# for glht() and cld() functions

library(rpart)
library(multcomp)
aovR <- aov(Price ~ Type, data = car90)
glhtR <- glht(aovR, linfct = mcp(Type = "Tukey"))
paircomp(glhtR, compress=FALSE)

Compare Hasse diagram in Fig. 5 with compact letter display in Fig. 6:

>
>
>

cldR <- cld(glhtR)
par(mar=c(4, 3, 5, 1))
plot(cldR)

3.2. Edge Compression

Sometimes, the pairwise comparison tests may yield in such bipartite setting that each pair
of nodes of some two node subsets is inter-connected (without any intra-edge between nodes
of the same subset).
More specifically, let U , V be non-empty sets of vertices, U ∪ V ⊆ {T1, T2, . . . , Tn}, U ∩ V = ∅,
such that for each u ∈ U and v ∈ V there exists an edge from u to v. (The number of such
edges equals |U | · |V |.) Starting from |U | > 2 and |V | > 2, the Hasse diagram may become too
complicated and hence confusing. Therefore, a compress argument exists in the paircomp
function that enables “compression” of the edges in such a way that a new “dot” node w is
introduced and |U | · |V | edges between sets U and V are replaced with |U | + |V | edges from
set U to node w and from node w to set V . See figures 7 and 8 for resulting diagrams of the
following commands:

>
+

>
+

paircomp(InsectSprays$count, InsectSprays$spray, test="t",

compress=FALSE)

paircomp(InsectSprays$count, InsectSprays$spray, test="t",

compress=TRUE)

4. Notes on Partial Orderness of Multiple Comparisons

The ability of visualizing all-pairwise comparisons in Hasse diagram relies on whether relation

Michal Burda

7

Figure 5: Hasse diagram from results of the glht function. Corresponding compact letter
display is depicted in Fig. 6 below.

Figure 6: Box-plot with compact letter display on top, as generated by the multcomp package.
Please compare with the equivalent Hasse diagram in Fig. 5.

    Compact         Large         Medium         Small         Sporty          Van      1.617e−024.745e−055.668e−045.767e−035.630e−039.997e−04Pairwise comparisons on Price by Type using two sided Tukey testCompactLargeMediumSmallSportyVan10000200003000040000TypePricea     a b     b       c a     a   c 8

paircompviz: Multiple Comparison Tests Visualization

Figure 7: Hasse diagram without compressed edges, i.e. generated by function paircomp with
argument compress=FALSE (compare with Fig. 8)

Figure 8: Hasse diagram with edges being compressed by introducing a “dot” edge, i.e. gen-
erated by function paircomp with argument compress=TRUE (compare with Fig. 8)

       A              B              C              D              E              F       8.720e−106.872e−072.479e−081.191e−109.702e−083.584e−094.192e−124.036e−091.371e−10Pairwise comparisons on InsectSprays$count by InsectSprays$spray using t tests with pooled SD and holm p−value adjustment       A              B              C              D              E              F       .Pairwise comparisons on InsectSprays$count by InsectSprays$spray using t tests with pooled SD and holm p−value adjustmentMichal Burda

9

H (see equation 1) is a partial order. Generally, it is not true for all possible data. For instance,
consider artificial data, brokentrans1, that is a part of the paircompviz package:

>
>

data("brokentrans")
tapply(brokentrans$x, brokentrans$g, mean)

1

3
8.240625 42.215852 95.239536

2

>

pairwise.t.test(brokentrans$x, brokentrans$g, pool.sd=FALSE)

Pairwise comparisons using t tests with non-pooled SD

data: brokentrans$x and brokentrans$g

1

2
2 1.3e-11 -
3 3.5e-09 3.3e-10

P value adjustment method: holm

For level argument set to α = 10−9, we obtain H = {(1, 2), (2, 3), (1, 1), (2, 2), (3, 3)}, which
is clearly not a partial order because of broken transitivity between 1 and 3. The paircomp
function would stop with an error, in this case.

Although there do theoretically exist data such that its pairwise comparisons does not form
a partial order and thus are not viewable in Hasse diagrams, it is rational to estimate the
frequency of such settings in real life. For that purpose, a simple experiment was performed
by utilizing datasets from packages cluster (Maechler, Rousseeuw, Struyf, Hubert, and Hornik
2012), coin (Hothorn, Hornik, van de Wiel, and Zeileis 2008b), datasets (R Core Team 2013),
lattice (Sarkar 2008), MASS (Venables and Ripley 2002), multcomp (Hothorn et al. 2008a),
party, reshape2 (Wickham 2007), rpart (Therneau et al. 2013), strucchange (Zeileis, Leisch,
Hornik, and Kleiber 2002), survival (Therneau 2012) and vcd (Meyer, Zeileis, and Hornik
2012).

From that packages, all datasets were added to the experiment, if they contained a factor
column with at least 3 levels. For all combinations of factor and numeric columns, various
multiple comparison tests were performed and the cases with broken transitivity condition
counted. Table 1 summarizes the frequencies of the numbers of grouping levels of datasets
used in the experiment.

As can be seen in table 2, among 3150 different test cases, only 3 of them, all made with the
Wilcoxon rank sum test, suffered from broken transitivity that prevented the resulting Hasse
diagram to exist. Table 3 provides details about that datasets.

From that we can conclude, that although theoretically possible, broken partial orderness of
multiple comparisons appears very seldom, in real data.

1brokentrans is an artificial dataset that was generated from random numbers in order to provide an

example of broken partial orderness with the t-test.

10

paircompviz: Multiple Comparison Tests Visualization

Table 1: The distribution of the numbers of grouping factors’ levels used in the experiment.

levels
frequency
levels
frequency

3
1428
12
51

4
1087
14
10

5
137
17
6

6
81
20
6

7
50
21
14

8
28
36
2

9
64
46
9

10
134
52
22

11
19
180
2

Table 2: Occurences of broken transitivity in multiple comparison tests performed on many
datasets from various R packages.

test
Tukey test
Wilcoxon rank sum test
pairwise comparisons for proportions
t-test with pooled SD
t-test without pooled SD

broken
0
3
0
0
0

ok
559
567
894
570
557

Table 3: Settings at which broken transitivity appeared in the experiment.

package dataset
vcd
vcd
MASS

obj
Bundesliga Year HomeTeam
Bundesliga Year AwayTeam
tax
Boston

grouping

rad

levels

test

52 Wilcoxon rank sum test
52 Wilcoxon rank sum test
9 Wilcoxon rank sum test

Michal Burda

11

5. Direct Hasse Diagram Plot

The paircompviz package also provides a function, hasse, for direct visualization of a Hasse
diagram defined by an adjacency matrix. Prior plotting, transitive edges have to be removed
from the adjacency matrix. That can be done by using transReduct function. For instance,
the Hasse diagram in Fig. 3 was generated by the subsequent code:

>
>
+
+
+
+
+
+
+
>
>
>
>

# create adjacency matrix
e <- matrix(c(0, 0, 0, 0, 0, 0, 0, 0,
1, 0, 0, 0, 0, 0, 0, 0,
1, 1, 0, 0, 0, 0, 0, 0,
1, 0, 0, 0, 0, 0, 0, 0,
1, 1, 1, 1, 0, 0, 0, 0,
1, 1, 1, 1, 1, 0, 0, 0,
1, 1, 1, 1, 1, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0), nrow=8)

# remove transitive edges
e <- transReduct(e)
# draw Hasse diagram
hasse(e, v=LETTERS[1:8], main="")

The only required argument, e, must be an adjacency matrix with non-zero value eij if there
has to be an edge from node i to node j. The values of matrix e are also used to determine
edge line thickness.

Argument v is a vector of node labels, elab is a vector of edge labels, ecol for edge label
colors, ebg for edge line colors, vcol and vbg for colors of node labels and background, vsize
for node sizes, fvlab, fvcol, fvbg fvsize for dot node label (defaults to "."), foreground
and background colors and size, febg and fesize set the color and size of edges starting or
ending in a dot node. There also may be a diagram title specified in the main argument.
Edge compression described in section 3 can be turned on by setting the compress argument
to TRUE.

6. Conclusion

The presented paircompviz package contains a function paircomp to draw a Hasse diagram
from the results of multiple pairwise comparison tests. Nodes of the graph represent treat-
ments, edges represent statistically significant difference. Optionally, the shape of the nodes
and thickness of the edges respectively depict the size of the samples and strength of the
differences.

The novel visualization method is compared to the existing compact letter display technique
that is provided by the multcomp package. For large set of treatments (say more than 3),
Hasse diagram combinded with box-plot and compact letter display provides clear and useful
additional visual information.

Hasse diagrams may be produced from the results of the t-test, Wilcoxon rank sum test
or proportion test, that is realized by the stats package (R Core Team 2013) functions

12

paircompviz: Multiple Comparison Tests Visualization

pairwise.t.test, pairwise.wilcox.test or pairwise.prop.test, respectively. For con-
venience, paircomp also accepts results from multcomp’s (Hothorn et al. 2008a) glht function
that performs Tukey’s test.

Hasse diagram can be constructed for results that partially order the treatments. Since it is
theoretically not always the case, an experiment shows that pairwise comparisons violating
partial orderness occur very seldom, in reality. From 567 trials of pairwise Wilcoxon rank
sum test, partial order violation occured only 3 times. For other types of tests, the violation
did not occur in any of more than 500 trials at all.

Acknowledgment

This work was supported by the European Regional Development Fund in the IT4Innovations
Centre of Excellence project (CZ.1.05/1.1.00/02.0070).

References

Ennis JM, Fayle CM, Ennis DM (2009). “Reductions of letter displays.” IFPress Research

Papers.

Gentry J, Long L, Gentleman R, Falcon S, Hahne F, Sarkar D, Hansen KD (2013). Rgraphviz:

Provides plotting capabilities for R graph objects. R package version 2.4.0.

Gramm J, Guo J, H¨uffner F, Niedermeier R, Piepho HP, Schmid R (2007). “Algorithms
for compact letter displays: Comparison and evaluation.” Computational Statistics &
Data Analysis, 52(2), 725–736. URL http://www.sciencedirect.com/science/article/
B6V8V-4M524SJ-5/1/90030f70e3535bfc94af3604b41d8afc.

Hothorn T, Bretz F, Westfall P (2008a). “Simultaneous Inference in General Parametric

Models.” Biometrical Journal, 50(3), 346–363.

Hothorn T, Hornik K, van de Wiel MA, Zeileis A (2008b). “Implementing a Class of Per-
mutation Tests: The coin Package.” Journal of Statistical Software, 28(8), 1–23. URL
http://www.jstatsoft.org/v28/i08/.

Hsu J (1996). Multiple comparisons:

theory and methods. Chapman & Hall.

ISBN

9780412982811. URL http://www.google.com/books?id=8AK8PUbw3lsC.

Maechler M, Rousseeuw P, Struyf A, Hubert M, Hornik K (2012). cluster: Cluster Analysis
Basics and Extensions. R package version 1.14.3 — For new features, see the ’Changelog’
file (in the package source).

Meyer D, Zeileis A, Hornik K (2012). vcd: Visualizing Categorical Data. R package version

1.2-13.

Piepho H (2000). “Multiple treatment comparisons in linear models when the standard error

of a difference is not constant.” Biometrical Journal, 42, 823–835.

Michal Burda

13

R Core Team (2013). R: A Language and Environment for Statistical Computing. R Foun-
ISBN 3-900051-07-0, URL http:

dation for Statistical Computing, Vienna, Austria.
//www.R-project.org/.

Sarkar D (2008). Lattice: Multivariate Data Visualization with R. Springer, New York. ISBN

978-0-387-75968-5, URL http://lmdvr.r-forge.r-project.org.

Therneau T (2012). A Package for Survival Analysis in S. R package version 2.37-2, URL

http://CRAN.R-project.org/package=survival.

Therneau T, Atkinson B, Ripley B (2013). rpart: Recursive Partitioning. R package version

4.1-1, URL http://CRAN.R-project.org/package=rpart.

Venables WN, Ripley BD (2002). Modern Applied Statistics with S. Fourth edition. Springer,

New York. ISBN 0-387-95457-0, URL http://www.stats.ox.ac.uk/pub/MASS4.

Wickham H (2007). “Reshaping Data with the reshape Package.” Journal of Statistical

Software, 21(12), 1–20. URL http://www.jstatsoft.org/v21/i12/.

Zeileis A, Leisch F, Hornik K, Kleiber C (2002). “strucchange: An R Package for Testing for
Structural Change in Linear Regression Models.” URL http://www.jstatsoft.org/v07/
i02/.

Affiliation:

Michal Burda
Institute for Research and Applications of Fuzzy Modeling
Centre of Excellence IT4Innovations
Division University of Ostrava
30. dubna 22, 701 03 Ostrava, Czech Republic
E-mail: michal.burda@osu.cz

