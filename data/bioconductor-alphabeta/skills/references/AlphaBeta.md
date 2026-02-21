AlphaBeta

Y.Shahryary, Rashmi Hazarika, Frank Johannes

2025-10-29

Contents

1 Introduction

1.1 Experimental systems
1.2 DNA methylation sampling strategies

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Input files

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.1 Pedigree files of MA lineages
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Pedigree files of Trees
2.3 Methylome files . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3.1 Cytosine-level calls . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3.2 Region-level calls . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . .
2.3.3 Tips for converting files from alternative callers and/or technologies

3 Building pedigree

3.1 Building MA-lines Pedigree . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Building Tree Pedigree . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Diagnostic plots

4.1 Plotting pedigrees

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.1.1 Pedigree of MA-lines . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.1.2 Tree pedigrees
. . . . . . . . . . . . . . . . . . . .

4.2 Plotting divergence time (delta.t) versus methylome divergence (D.value)

5 Epimutation rate estimation in selfing-systems

5.1 Run Models . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.1.1 Run Model with no selection (ABneutral) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.1.2 Run model with selection against spontaneous gain of methylation (ABselectMM)
. . . . . . . . . . .
5.1.3 Run model with selection against spontaneous loss of methylation (ABselectUU) . . . . . . . . . . . .
5.1.4 Run model that considers no accumulation of epimutations (ABnull) . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2.1 Testing ABneutral vs. ABnull . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2.2 Testing ABselectMM vs.ABneutral . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2.3 Testing ABselectUU vs.ABneutral
. . . . . . . . . . . . . . . . . . . . . . . . . . .

5.3 Bootstrap analysis with the best fitting model(BOOTmodel)

5.2 Comparison of different models and selection of best model

6 Epimutation rate estimation in clonal, asexual and somatic systems

6.1 Run Models . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.1.1 Run Model with no selection (ABneutralSOMA) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.1.2 Run model with selection against spontaneous gain of methylation (ABselectMMSOMA)
. . . . . . .
. . . . . . . .
6.1.3 Run model with selection against spontaneous loss of methylation (ABselectUUSOMA)
6.2 Bootstrap analysis with the best fitting model (BOOTmodel) . . . . . . . . . . . . . . . . . . . . . . . . . . .

7 R session info

1

2
2
2

3
3
4
5
5
6
6

6
6
7

7
7
7
8
9

9
9
9
11
11
11
12
12
12
12
12

13
13
13
14
14
14

15

1 Introduction

AlphaBeta is a computational method for estimating epimutation rates and spectra from high-throughput DNA methylation
data in plants. The method can be generally applied to study ‘germline’ epimuations in mutation accumulation lines (MA-lines),
as well as ‘somatic’ epimutations in long-lived perennials, such as trees. Details regarding the inference approach and example
applications can be found in Shahryary et al. 2020.

1.1 Experimental systems

A key challenge in studying epimutational proceses in multi-generational experiments is to be able to distinguish ’germline’
epimutations from other types of methylation changes, such as those that are associated with segregating genetic variation or
transient environmental perturbations. Mutation accumulation lines (MA-lines) grown in controlled laboratory conditions are
a powerful experimental system to achieve this. MA-lines are derived from a single isogenic founder and are independently
propagated for a large number of generations. The lines can be advanced either clonally or sexually, i.e. self-fertilization or
sibling mating (Fig. 1A). In clonally produced MA lines the isogenicity of the founder is not required because the genome is
’fixed’ due to the lack of genetic segregation.

The kinship among the different MA lineages can be presented as a pedigree (Fig. 1A). The structure (or topology) of these
pedigrees is typically known, a priori, as the branch-point times and the branch lengths are deliberately chosen as part of the
experimental design. In conjunction with multi-generational methylome measurements MA lines therefore permit ‘real-time’
observations of ’germline’ epimutations against a nearly invariant genomic background, and can facilitate estimates of the per
generation epimutation rates.

Beyond experimentally-derived MA lines, natural mutation accumulation systems can also be found in the context of plant
development and aging. An instructive example are long-lived perennials, such as trees, whose branching structure can be
interpreted as a pedigree (or phylogeny) of somatic lineages that carry information about the epimutational history of each
branch. In this case, the branch-point times and the branch lengths can be determined ad hoc using coring data, or other
types of dating methods (Fig. 1B). By combining this information with contemporary leaf methylome measurements it is
possible to infer the rate of somatic epimutations as a function of age (see Hofmeister et al.).

Figure 1: Experimental systems

1.2 DNA methylation sampling strategies

In the analysis of selfing or clonally-derived MA-lines, DNA methylation samples are typically obtained from the final generation
(Fig. 2, endpoint sampling) and/or from intermediate generations (Fig. 2, intermediate sampling). With intermediate
sampling, the samples can be obtained either directly from the progenitors of each generation (progenitor design, Fig. 2) or
else from siblings of those progenitors (sibling design, Fig. 2). The sibling design is feasible in plants as seeds from early
generations can be stored and grown out later. This is advantageous because plant material from all generations can be
sampled simultaneously under identical conditions. An advantage of the progenitor design is that the methylation status of
the pedigree founder is known, and that the methylation status of individual cytosines can be traced back in time through the
entire pedigree. However, progenitor samples are taken in real-time (i.e. at selected generations) and thus growth conditions
may vary over the experiment and introduce unwanted sources of noise. In the analysis of trees, DNA methylation samples
come from contemporary leafs, as the methylomes of earlier developmental time-points are inaccessible (at least not easily
accessible). Endpoint sampling is therefore the most obvious sampling strategy.

2

Irregardless of sampling design, AlphaBeta interprets the underlying pedigree as a sparse directed network. The nodes of the
network correspond to ‘individuals’ whose methylomes have been sampled (i.e. type S* nodes), or of the common ancestors of
these individuals, whose methylomes have typically not been sampled (i.e. type S nodes) (Fig.2).

Figure 2: Pedigrees and DNA methylation sampling strategies. S* denotes sampled individuals and S are their (typically
unsampled) most recent ancestors.

2 Input files

2.1 Pedigree files of MA lineages

To be able to re-construct the topology of the underlying pedigree, AlphaBeta requires two types of input files: “nodeslist.fn”
and “edgelist.fn”. The structure of these files follows the standard file format required by the R network package igraph.
# Load 'nodelist.fn' file
sampleFile <- system.file("extdata/vg", "nodelist.fn", package = "AlphaBeta")

“nodelist.fn” has the following structure

gen

node

filename
<char>
-
1:
-
2:
3:
-
4: /data/methylome_GSE64463_MA1_1_G3_26_r1.txt
5: /data/methylome_GSE64463_MA1_1_G3_87_r1.txt
6: /data/methylome_GSE64463_MA1_1_G3_87_r2.txt
7:
8:
9:
10:

meth
<char> <int> <char>
N
N
N
Y
Y
Y
N
N
N
N

0_0
2_26_r1
2_87_r1
3_26_r1
3_87_r1
3_87_r2
- 30_29_r1
- 30_39_r1
- 30_49_r1
- 30_59_r1

0
2
2
3
3
3
30
30
30
30

filename: Lists the filenames corresponding to nodes (S and S* ). Filenames of type S* nodes should be identical
with the names of their corresponding methylome files (see below). Type S nodes lacking corresponding methylome
measurements, and should be designated by (-).

node: An arbitrary but unique name given to each node.

gen: Specifies the generation time of the nodes in the underlying pedigree.

meth: Indicates if methylome measurements are available for a given node (Y = yes, N = no).

3

Progenitor designFigure2:PedigreesandDNAmethylationsamplingstrategies.S*denotessampledindividualsandSaretheir(typicallyunsampled)mostrecentancestors.Sibling designS*S*S*S*SSSS*S*S*S*S*S*S*SSSSSS*S*S*SSSSendpoint samplingintermediate samplingThe “edgelist.fn” file specifies the ancestral (i.e. lineages) relationship between nodes.
# Load 'edgelist.fn' file
edgesFile <- system.file("extdata/vg", "edgelist.fn", package = "AlphaBeta")

“edgelist.fn” has the following structure

from
<char>

<char>
0_0 2_26_r1
1:
2:
0_0 2_87_r1
3: 2_26_r1 3_26_r1
4: 2_87_r1 3_87_r1
5: 2_87_r1 3_87_r2
0_0 30_29_r1
6:
0_0 30_39_r1
7:
0_0 30_49_r1
8:
0_0 30_59_r1
9:
0_0 30_79_r1
10:

to gendiff group
<int> <char>
A
A
A
A
A
B
B
B
B
B

1
1
1
1
1
30
30
30
30
30

from and to: Specifies the network edges, which are any direct connections between type S and S* nodes in the
pedigree. Only unique pairs of nodes need to be supplied (Fig.1). These 2 columns are mandatory.

gendiff (optional): Specifies the number of generations that separate the two nodes. This column is useful only
for plotting purpose and it can be omitted for epimutation rate estimation. However, we recommend that this
column be supplied because it is useful for accurately scaling the edge lengths when plotting certain pedigrees with
progenitor.endpoint and sibling design (see 4.1).

group (optional): Along with “gendiff” column, groupings supplied in this column will help in scaling the edge lengths
when plotting the pedigree.

2.2 Pedigree files of Trees

# Load 'SOMA_nodelist.fn' file
treeSamples <- system.file("extdata/soma", "SOMA_nodelist2.fn", package = "AlphaBeta")

“SOMA_nodelist.fn” has the following structure

filename

node Branchpoint_date

-
1:
2:
-
3: data/myfile
4:
-
5: data/myfile
6:
-
7: data/myfile
8:
-
9: data/myfile
-

<char> <char>
330
113
13_5
72
13_3
44
13_2
31
13_1
115

10:

meth
<int> <char>
N
N
Y
N
Y
N
Y
N
Y
N

0
217
297
258
328
286
327
299
328
215

filename: Lists the filenames corresponding to nodes S. Type S nodes lacking corresponding methylome measurements,
and should be designated by (-).

node: An arbitrary but unique name given to each node.

Branchpoint_date: Specifies the branchpoint time of the nodes in the underlying pedigree.

meth: Indicates if methylome measurements are available for a given node (Y = yes, N = no).

4

The “SOMA_edgelist.fn” file specifies the ancestral (i.e. lineages) relationship between nodes.

treeEdges <- system.file("extdata/soma", "SOMA_edgelist2.fn", package = "AlphaBeta")

“SOMA_edgelist.fn” has the following structure

from

to Stem
<int> <char> <int>
13
13
13
13
13
13
13
13
14
14

113
13_5
72
13_3
44
13_2
31
13_1
115
14_2

330
113
113
72
72
44
44
31
330
115

1:
2:
3:
4:
5:
6:
7:
8:
9:
10:

from and to: Specifies the network edges, which are any direct connections between type nodes in the pedigree. Only
unique pairs of nodes need to be supplied. These 2 columns are mandatory.

stem (optional): To be provided only for trees with 2 or more stems (as.in our example). This column should be left
blank for a tree with a single stem.

2.3 Methylome files

Type S* nodes in the pedigree have corresponding methylome data. In its current implementation, AlphaBeta expects
methylome files that have been produced by methimpute Methimpute package. methimpute is a HMM-based methylation
state caller for whole-genome bisulphite sequencing (WGBS) data. It can produce cytosine-level methylation state as well as
region-level methylation methylation state calls. The former calls are required to obtain cytosine-level epimutation rates,
while the latter calls are required to obtain region-level epimuation rates. Methylome files from alternative callers and/or
measurement technologies are possible but should be converted to the methimpute file structure (see below).

2.3.1 Cytosine-level calls

“cytosine-level methylome files” have the following structure

seqnames, start and strand: Chromosome coordinates

context: Sequence context of cytosine i.e CG,CHG,CHH

counts.methylated: Counts for methylated reads at each position

counts.total: Counts for total reads at each position

posteriorMax: Posterior value of the methylation state call

status : Methylation status

rc.meth.lvl: Recalibrated methylation level calculated from the posteriors and fitted parameters

5

context.trinucleotide: Trinucleotide context of the cytosine context

2.3.2 Region-level calls

“region-level methylome files” have the following structure

seqnames, start and strand: Chromosome coordinates

posteriorMax: Posterior value of the methylation state call

status : Methylation status

rc.meth.lvl: Recalibrated methylation level calculated from the posteriors and fitted parameters

context: Sequence context of cytosine i.e CG,CHG,CHH

2.3.3 Tips for converting files from alternative callers and/or technologies

Methylome files generated by alternative callers and/or measurement technologies should be converted to meet the methimpute
file structure. We have the following tentative recommendations.

NGS-based technologies: For NGS-based technologies including whole-genome bisulphite sequencing (WGBS), reduced
presentation bisulphite sequencing (RRBS) and epigenotyping by sequencing (epiGBS), columns seqnames, start, strand,
context, counts.methylated, counts.toal and status are typically available as they are part of standard outputs of BS-seq
aligment software, such as Bismark and BSseeker. In this case, we recommend removing all rows where counts.total = 0, and
set posteriorMax = 1, rc.meth.lvl = counts.methylated/counts.total, context.trinucleotide = NA.

Array-based technologies: Although we have not directly tested this, it should also be possible to convert methylome data
from array-based technologies, including MeDIP-chip, to the methylome file structure required by AlphaBeta. In this case,
we recommend to set seqnames = probe chromosome position, start = probe start position, strand = arbitrarily fix to (+),
context = arbitrarily fix to context “CG”, counts.methylated = NA, count.total = NA, posteriorMax = 1, rc.meth.lvl = array
methylation signal, context.trinucleotide = NA.

3 Building pedigree

The function “buildPedigree” builds the pedigree from the input files. Divergence time (delta.t) is calculated as follows: delta.t
= t1 + t2 - 2*t0, where t1 is the time of sample 1 (in generations), t2 is the time of sample 2 (in generations) and t0 is the
time (in generations) of the most recent common founder of samples 1 and 2.

3.1 Building MA-lines Pedigree

output <- buildPedigree(nodelist = sampleFile, edgelist = edgesFile, cytosine = "CG",

posteriorMaxFilter = 0.99)

Divergence values (D.value):

head(output$Pdata)

time0 time1 time2 D.value
3 0.00551
3 0.00585
31 0.01210
31 0.01266
31 0.01206
31 0.01235

0
0
0
0
0
0

3
3
3
3
3
3

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

6

time 1: Generation time of sample i

time 2: Generation time of sample j

time 0: Generation time of most recent common ancestor of samples i and j

D.value: Mean absolute divergence in DNA methylation states between samples i and j

3.2 Building Tree Pedigree

outputTree <- buildPedigree(nodelist = treeSamples, edgelist = treeEdges, cytosine = "CG",

posteriorMaxFilter = 0.99)

Divergence values (D.value):

head(outputTree$Pdata)

time0 time1 time2

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

0
0
0
0
0
0

297
297
327
297
328
328

D.value
287 0.003796614
324 0.003974756
287 0.003995156
287 0.004040671
287 0.004046553
287 0.004048672

4 Diagnostic plots

The correct specification of the pedigree topology and the removal of influential outlier data points are critical aspects for
epimutation rate estimation. Visual inspection of the pedigree is provided through the function “plotPedigree”.

4.1 Plotting pedigrees

4.1.1 Pedigree of MA-lines

## Progenitor-endpoint design
plotPedigree(nodelist = sampleFile, edgelist = edgesFile, sampling.design = "progenitor.endpoint",
output.dir = out.dir, plot.width = 5, plot.height = 5, aspect.ratio = 1, vertex.size = 6,
vertex.label = FALSE, out.pdf = "MA1_1")

## Sibling design
plotPedigree(nodelist = system.file("extdata/vg", "nodelist_MA2_3.fn", package = "AlphaBeta"),

edgelist = system.file("extdata/vg", "edgelist_MA2_3.fn", package = "AlphaBeta"),
sampling.design = "sibling", output.dir = out.dir, plot.width = 5, plot.height = 5,
aspect.ratio = 2.5, vertex.size = 12, vertex.label = FALSE, out.pdf = "MA2_3")

## Progenitor-intermediate design
plotPedigree(nodelist = system.file("extdata/vg", "nodelist_MA3.fn", package = "AlphaBeta"),

edgelist = system.file("extdata/vg", "edgelist_MA3.fn", package = "AlphaBeta"),
sampling.design = "progenitor.intermediate", output.dir = out.dir, plot.width = 5,
plot.height = 8, aspect.ratio = 2.5, vertex.size = 13, vertex.label = FALSE,
out.pdf = "MA3")

7

Figure 3: Pedigrees of MA lines with progenitor.endpoint (left), sibling (middle) and progenitor.intermediate design (right)

4.1.2 Tree pedigrees

plotPedigree(nodelist = treeSamples, edgelist = treeEdges, sampling.design = "tree",

output.dir = out.dir, plot.width = 5, plot.height = 5, aspect.ratio = 1, vertex.size = 8,
vertex.label = FALSE, out.pdf = "Tree")

nodelist: file containing list of nodes

edgelist: files containing list of edges

sampling.design: set sampling design according to pedigree

output.dir: set output directory path

plot.width, plot.height: set width and height of the output pdf

aspect.ratio, vertex.size: for adjusting the ratio of height to width of the pedigree plot

vertex.label: vertex labels can be printed with either TRUE or FALSE

out.pdf : set NULL to print plot on screen or set name to output as pdf

Figure 4: Pedigree of a tree with 2 stems (left) and a single stem (right)

8

4.2 Plotting divergence time (delta.t) versus methylome divergence (D.value)

This is an interactive plot for inspecting the divergence data and removing outlier samples (if any):

pedigree <- output$Pdata
dt <- pedigree[, 2] + pedigree[, 3] - 2 * pedigree[, 1]
plot(dt, pedigree[, "D.value"], ylab = "Divergence value", xlab = expression(paste(Delta,

" t")))

5 Epimutation rate estimation in selfing-systems

Models ABneutral, ABselectMM, ABselectUU and ABnull can be used to estimate the rate of spontaneous epimutations in
selfing-derived MA-lines. The models are currently restricted to diploids.

5.1 Run Models

5.1.1 Run Model with no selection (ABneutral)

ABneutral fits a neutral epimutation model. The model assumes that epimutation accumulation is under no selective constraint.
Returned are estimates of the methylation gain and loss rates and the proportion of epi-heterozygote loci in the pedigree
founder genome.

Initial proportions of unmethylated cytosines:

p0uu_in <- output$tmpp0
p0uu_in

[1] 0.7435119

pedigree <- output$Pdata

# output directory
output.data.dir <- paste0(getwd())

output <- ABneutral(pedigree.data = pedigree, p0uu = p0uu_in, eqp = p0uu_in, eqp.weight = 1,
Nstarts = 2, out.dir = output.data.dir, out.name = "ABneutral_CG_global_estimates")

Progress: 0.5

Progress: 1

NOTE: it is recommended to use at least 50 Nstarts to achieve best solutions

9

01020304050600.0050.0100.015D tDivergence valueShowing summary output of only output:

summary(output)

estimates
estimates.flagged
pedigree
settings
model
for.fit.plot

20
20
2457
2
1
315

head(output$pedigree)

Length Class

Mode
data.frame list
data.frame list
-none-
data.frame list
-none-
-none-

numeric

character
numeric

time0 time1 time2 div.obs delta.t div.pred residual
NA
NA
NA
NA
NA
NA

3 0.00551
3 0.00585
31 0.01210
31 0.01266
31 0.01206
31 0.01235

NA
NA
NA
NA
NA
NA

6
6
34
34
34
34

0
0
0
0
0
0

3
3
3
3
3
3

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

Plot estimates of ABneutral model:

ABfile <- system.file("extdata/models/", "ABneutral_CG_global_estimates.Rdata", package = "AlphaBeta")
# In 'ABplot' function you can set parameters to customize the pdf output.
ABplot(pedigree.names = ABfile, output.dir = getwd(), out.name = "ABneutral", plot.height = 8,

plot.width = 11)

10

Figure 5: Divergence versus delta.t

5.1.2 Run model with selection against spontaneous gain of methylation (ABselectMM)

ABselectMM fits an epimutation model with selection. The model assumes that epimutation accumulation is in part shaped
by selection against spontaenous losses of cytosine methylation. Returned are estimates of the methylation gain and loss rates,
the selection coeficient, and the proportion of epi-heterozygote loci in the pedigree founder genome.

outputABselectMM <- ABselectMM(pedigree.data = pedigree, p0uu = p0uu_in, eqp = p0uu_in,

eqp.weight = 1, Nstarts = 2, out.dir = output.data.dir, out.name = "ABselectMM_CG_global_estimates")

Progress: 0.5

Progress: 1

5.1.3 Run model with selection against spontaneous loss of methylation (ABselectUU)

ABselectUU fits an epimutation model with selection. The model assumes that epimutation accumulation is in part shaped by
selection against spontaenous gains of cytosine methylation. Returned are estimates of the methylation gain and loss rates,
the selection coeficient, and the proportion of epi-heterozygote loci in the pedigree founder genome.

outputABselectUU <- ABselectUU(pedigree.data = pedigree, p0uu = p0uu_in, eqp = p0uu_in,

eqp.weight = 1, Nstarts = 2, out.dir = output.data.dir, out.name = "ABselectUU_CG_global_estimates")

Progress: 0.5

Progress: 1

5.1.4 Run model that considers no accumulation of epimutations (ABnull)

ABnull fits a model of no epimutation accumulation. This model serves as the Null model.

outputABnull <- ABnull(pedigree.data = pedigree, out.dir = output.data.dir, out.name = "ABnull_CG_global_estimates")

11

0.0000.0050.0100.0150.0200204060delta t (generations)methylation divergencecategoryCG5.2 Comparison of different models and selection of best model

5.2.1 Testing ABneutral vs. ABnull

file1 <- system.file("extdata/models/", "ABneutral_CG_global_estimates.Rdata", package = "AlphaBeta")
file2 <- system.file("extdata/models/", "ABnull_CG_global_estimates.Rdata", package = "AlphaBeta")

out <- FtestRSS(pedigree.select = file1, pedigree.null = file2)

out$Ftest

RSS_R
6.508955e-04 4.125201e-03

RSS_F

df_F
3.460000e+02

df_R
3.500000e+02

Fvalue

pvalue
4.617138e+02 2.703258e-137

5.2.2 Testing ABselectMM vs.ABneutral

file1 <- system.file("extdata/models/", "ABselectMM_CG_global_estimates.Rdata", package = "AlphaBeta")
file2 <- system.file("extdata/models/", "ABnull_CG_global_estimates.Rdata", package = "AlphaBeta")

out <- FtestRSS(pedigree.select = file1, pedigree.null = file2)

out$Ftest

RSS_R
6.507056e-04 4.125201e-03

RSS_F

df_F
3.460000e+02

df_R
3.500000e+02

Fvalue

pvalue
4.618738e+02 2.570279e-137

5.2.3 Testing ABselectUU vs.ABneutral

file1 <- system.file("extdata/models/", "ABselectUU_CG_global_estimates.Rdata", package = "AlphaBeta")
file2 <- system.file("extdata/models/", "ABnull_CG_global_estimates.Rdata", package = "AlphaBeta")

out <- FtestRSS(pedigree.select = file1, pedigree.null = file2)

out$Ftest

RSS_R
6.499228e-04 4.125201e-03

RSS_F

df_F
3.460000e+02

df_R
3.500000e+02

Fvalue

pvalue
4.625343e+02 2.087582e-137

5.3 Bootstrap analysis with the best fitting model(BOOTmodel)

i.e ABneutral in our case

NOTE: it is recommended to use at least 50 Nboot to achieve best solutions

inputModel <- system.file("extdata/models/", "ABneutral_CG_global_estimates.Rdata",

package = "AlphaBeta")

# Bootstrapping models CG

Boutput <- BOOTmodel(pedigree.data = inputModel, Nboot = 2, out.dir = getwd(), out.name = "ABneutral_Boot_CG_global_estimates")

Bootstrap interation: 0.5

Bootstrap interation: 1

summary(Boutput)

Length Class

standard.errors 24
20
boot.base
2
settings
1
N.boots
1
N.good.boots
19
boot.results

Mode
numeric

-none-
data.frame list
data.frame list
-none-
-none-
data.frame list

numeric
numeric

12

model

1

-none-

character

SE

2.5%

97.5%
alpha
3.016954e-06 8.688019e-05 9.093348e-05
8.769875e-06 2.521911e-04 2.639734e-04
beta
beta/alpha 1.366574e-04 2.902745e+00 2.902928e+00
weight
4.867542e-03 3.177169e-02 3.831125e-02
intercept 4.570499e-04 2.129322e-03 2.743369e-03
1.793503e-05 2.559475e-01 2.559716e-01
PrMMinf
1.792676e-05 5.165133e-04 5.405979e-04
PrUMinf
8.267829e-09 7.435119e-01 7.435119e-01
PrUUinf

6 Epimutation rate estimation in clonal, asexual and somatic systems

Models ABneutralSOMA, ABselectMMSOMA and ABselectUUSOMA can be used to estimate the rate of spontaneous
epimutations from pedigree-based high-throughput DNA methylation data. The models are generally designed for pedigree
data arising from clonally or asexually propagated diploid species. The models can also be applied to long-lived perrenials,
such as trees, using leaf methylomes and coring data as input. In this case, the tree branching structure is treated as an
intra-organismal pedigree (or phylogeny) of somatic lineages.

6.1 Run Models

6.1.1 Run Model with no selection (ABneutralSOMA)

This model assumes that somatically heritable gains and losses in cytosine methylation are selectively neutral.

Initial proportions of unmethylated cytosines:

Tree_p0uu_in <- outputTree$tmpp0
Tree_p0uu_in

[1] 0.45245

pedigree.Tree <- outputTree$Pdata

outputABneutralSOMA <- ABneutralSOMA(pedigree.data = pedigree.Tree, p0uu = Tree_p0uu_in,

eqp = Tree_p0uu_in, eqp.weight = 0.001, Nstarts = 2, out.dir = getwd(), out.name = "ABneutralSOMA_CG_global_estimates")

Progress: 0.5

Progress: 1

summary(outputABneutralSOMA)

estimates
estimates.flagged
pedigree
settings
model
for.fit.plot

20
20
196
2
1
3275

Length Class

Mode
data.frame list
data.frame list
-none-
data.frame list
-none-
-none-

numeric

character
numeric

head(outputABneutralSOMA$pedigree)

time0 time1 time2

div.obs delta.t

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

0
0
0
0
0
0

297
297
327
297
328
328

287 0.003796614
324 0.003974756
287 0.003995156
287 0.004040671
287 0.004046553
287 0.004048672

Plot estimates of ABneutralSOMA model:

div.pred

residual
584 0.004002421 -2.058072e-04
621 0.004115551 -1.407947e-04
614 0.004094157 -9.900055e-05
3.824981e-05
584 0.004002421
615 0.004097214 -5.066110e-05
615 0.004097214 -4.854210e-05

ABfilesoma <- system.file("extdata/models/", "ABneutralSOMA_CG_global_estimates.Rdata",

package = "AlphaBeta")

13

ABplot(pedigree.names = ABfilesoma, output.dir = getwd(), out.name = "ABneutralSOMA",

plot.height = 8, plot.width = 11)

Figure 6: Divergence versus delta.t of Tree

6.1.2 Run model with selection against spontaneous gain of methylation (ABselectMMSOMA)

This model assumes that somatically heritable losses of cytosine methylation are under negative selection. The selection
parameter is estimated.

outputABselectMMSOMA <- ABselectMMSOMA(pedigree.data = pedigree.Tree, p0uu = Tree_p0uu_in,

eqp = Tree_p0uu_in, eqp.weight = 0.001, Nstarts = 2, out.dir = getwd(), out.name = "ABselectMMSOMA_CG_global_estimates")

Progress: 0.5

Progress: 1

6.1.3 Run model with selection against spontaneous loss of methylation (ABselectUUSOMA)

This model assumes that somatically heritable gains of cytosine methylation are under negative selection. The selection
parameter is estimated.

outputABselectUUSOMA <- ABselectUUSOMA(pedigree.data = pedigree.Tree, p0uu = Tree_p0uu_in,

eqp = Tree_p0uu_in, eqp.weight = 0.001, Nstarts = 2, out.dir = getwd(), out.name = "ABselectUUSOMA_CG_global_estimates")

Progress: 0.5

Progress: 1

6.2 Bootstrap analysis with the best fitting model (BOOTmodel)

inputModelSOMA <- system.file("extdata/models", "ABneutralSOMA_CG_global_estimates.Rdata",

package = "AlphaBeta")

14

0.00000.00250.00500.00750200400600delta t (generations)methylation divergencecategoryABneutralSOMA# Bootstrapping models CG

Boutput <- BOOTmodel(pedigree.data = inputModelSOMA, Nboot = 2, out.dir = getwd(),

out.name = "ABneutral_Boot_CG_global_estimates")

Bootstrap interation: 0.5

Bootstrap interation: 1

summary(Boutput)

Length Class

standard.errors 24
20
boot.base
2
settings
1
N.boots
1
N.good.boots
19
boot.results
1
model

Mode
numeric

-none-
data.frame list
data.frame list
-none-
-none-
data.frame list
-none-

numeric
numeric

character

SE

2.5%

97.5%
2.841913e-08 1.995744e-06 2.033925e-06
alpha
beta
5.839544e-08 4.100809e-06 4.179264e-06
beta/alpha 2.213868e-07 2.054778e+00 2.054778e+00
weight
3.330020e-03 4.835589e-02 5.282978e-02
intercept 1.140031e-05 2.171636e-03 2.186952e-03
1.553255e-08 1.071620e-01 1.071620e-01
PrMMinf
1.638339e-08 4.403881e-01 4.403881e-01
PrUMinf
3.191595e-08 4.524499e-01 4.524499e-01
PrUUinf

7 R session info

sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_MESSAGES=en_US.UTF-8
LC_TELEPHONE=C

LC_TIME=en_GB
LC_PAPER=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_COLLATE=C
LC_NAME=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats

graphics

grDevices utils

datasets

methods

base

other attached packages:
[1] ggplot2_4.0.0

igraph_2.2.1

data.table_1.17.8 AlphaBeta_1.24.0

loaded via a namespace (and not attached):

[1] plotly_4.11.0
[6] lattice_0.22-7

[11] grid_4.5.1
[16] tinytex_0.57

generics_0.1.4
pracma_2.4.6
RColorBrewer_1.1-3
formatR_1.14

tidyr_1.3.1
digest_0.6.37
fastmap_1.2.0
httr_1.4.7

gtools_3.9.5
magrittr_2.0.4
jsonlite_2.0.0
purrr_1.1.0

stringi_1.8.7
evaluate_1.0.5
Matrix_1.7-4
viridisLite_0.4.2

15

[21] scales_1.4.0
[26] rlang_1.1.6
[31] parallel_4.5.1
[36] png_0.1-8
[41] htmlwidgets_1.6.4
[46] xfun_0.53
[51] farver_2.1.2

codetools_0.2-20
expm_1.0-0
BiocParallel_1.44.0 nloptr_2.2.1
vctrs_0.6.5
pkgconfig_2.0.3
tibble_3.3.0
htmltools_0.5.8.1

R6_2.6.1
pillar_1.11.1
tidyselect_1.2.1
rmarkdown_2.30

yaml_2.3.10
dplyr_1.1.4
lifecycle_1.0.4
gtable_0.3.6
knitr_1.50
compiler_4.5.1

numDeriv_2016.8-1.1 lazyeval_0.2.2
withr_3.0.2

cli_3.6.5
tools_4.5.1
optimx_2025-4.9
stringr_1.5.2
glue_1.8.0
dichromat_2.0-0.1
S7_0.2.0

16

