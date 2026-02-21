# Decoding T- and B-cell receptor repertoires with ClustIRR

#### 29 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 ClustIRR algorithm](#clustirr-algorithm)
  + [3.1 Input](#input)
  + [3.2 Algorithm](#algorithm)
  + [3.3 **Step 1.** Compute TCR clonotype similarities in a repertoire with `cluster_irr`](#step-1.-compute-tcr-clonotype-similarities-in-a-repertoire-with-cluster_irr)
  + [3.4 **Step 2-3.** Construct TCR repertoire graphs and join them into \(J\)](#step-2-3.-construct-tcr-repertoire-graphs-and-join-them-into-j)
  + [3.5 Run steps 1-3 with `clustirr`](#run-steps-1-3-with-clustirr)
    - [3.5.1 Inspect the content of `clust_irrs`](#inspect-the-content-of-clust_irrs)
    - [3.5.2 Inspect graphs with `plot_graph`](#inspect-graphs-with-plot_graph)
    - [3.5.3 You can evaluate \(J\) with igraph](#you-can-evaluate-j-with-igraph)
  + [3.6 **Step 4.** community detection with `detect_communities`](#step-4.-community-detection-with-detect_communities)
    - [3.6.1 Inspecting the outputs of `detect_communities`](#inspecting-the-outputs-of-detect_communities)
    - [3.6.2 Visualizing community abundance matrices with `get_honeycombs`](#visualizing-community-abundance-matrices-with-get_honeycombs)
    - [3.6.3 Special functions: decoding communities with `decode_community`](#special-functions-decoding-communities-with-decode_community)
  + [3.7 **Step 5.** differential community occupancy (DCO) with `dco`](#step-5.-differential-community-occupancy-dco-with-dco)
  + [3.8 **Step 6.** Inspect results](#step-6.-inspect-results)
    - [3.8.1 Visualizing the distribution of \(\beta\) with `get_beta_violins`](#visualizing-the-distribution-of-beta-with-get_beta_violins)
    - [3.8.2 Compare \(\beta\)s of clonotypes specific for *CMV*, *EBV*, *flu* or *MLANA*?](#compare-betas-of-clonotypes-specific-for-cmv-ebv-flu-or-mlana)
    - [3.8.3 Posterior predictive checks](#posterior-predictive-checks)
    - [3.8.4 Differential community abundance results \(\rightarrow\) par. \(\delta\)](#differential-community-abundance-results-rightarrow-par.-delta)
  + [3.9 Conclusion: you can also use **custom** community occupancy matrix for DCO!](#conclusion-you-can-also-use-custom-community-occupancy-matrix-for-dco)

```
library(knitr)
library(ClustIRR)
library(igraph)
library(ggplot2)
theme_set(new = theme_bw(base_size = 10))
library(ggrepel)
library(patchwork)
options(digits=2)
```

# 1 Introduction

Adaptive immunity employs diverse immune receptor repertoires (IRRs; B-
and T-cell receptors) to combat evolving pathogens including viruses,
bacteria, and cancers. Receptor diversity arises through V(D)J
recombination - combinatorial assembly of germline genes generating
unique sequences. Each naive lymphocyte consequently expresses a
distinct receptor, enabling broad antigen recognition.

B cells engage antigens directly via BCR complementarity-determining
regions (CDRs), while T cells recognize peptide-MHC complexes through
TCR CDRs. Antigen recognition triggers clonal expansion, producing
effector populations that mount targeted immune responses.

High-throughput sequencing (HT-seq) enables tracking of TCR/BCR community
dynamics across biological conditions (e.g., pre-/post-treatment), offering
insights into responses to immunotherapy and vaccination. However, two key
challenges complicate this approach if the unit of analysis are **clonotype**:

1. **Extreme diversity and privacy**: TCRs/BCRs are highly
   personalized, with incomplete sampling particularly problematic in
   clinical settings where sample volumes are limited. Even
   comprehensive sampling reveals minimal repertoire overlap in terms of
   clonotypes between individuals.
2. **Similar TCRs/BCRs recognize similar antigens**

This vignette introduces *[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)*, a computational method
that addresses these challenges by: (1) Identifying
specificity-associated receptor communities through sequence clustering,
and (2) Applying Bayesian models to quantify differential community
abundance across conditions.

# 2 Installation

*[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* is freely available as part of Bioconductor,
filling the gap that currently exists in terms of software for
quantitative analysis of IRRs.

To install *[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* please start R and enter:

```
if(!require("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("ClustIRR")
```

# 3 ClustIRR algorithm

![](data:image/png;base64...)

## 3.1 Input

The main input of *[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* is a repertoire (`s`), which
should be provided as data.frame. The rows in the data.frame correspond
to **clonotype** (clonotype = group of cells derived from a common parent
cell by clonal expansion). We use the following data from each clonotype:

* **CDR3 amino acid sequences** from one/both chains (e.g.
  CDR3\(\alpha\) and CDR3\(\beta\) from TCR\(\alpha\beta\)s).
* **Clone size**, which refers to the frequency of cells that belong
  to the clonotype.

In a typical scenario, the user will have more than one repertoire (see
workflow). For instance, the user will analyze longitudinal repertoire
data, i.e., two or three repertoires taken at different time points; or
across different biological conditions.

Let’s look at dataset `D1` that is provided within
*[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)*. `D1` contains three TCR\(\alpha\beta\)
repertoires: \(a\), \(b\), and \(c\) and their metadata: `ma`, `mb` and `mc`.

```
data("D1", package = "ClustIRR")
str(D1)
```

```
List of 6
 $ a :'data.frame': 500 obs. of  4 variables:
  ..$ CDR3a     : chr [1:500] "CASSLRGAHNEQFF" "CASGLRQGYGYTF" "CSAGGFRETQYF" "CGSSLSQGSEQYF" ...
  ..$ CDR3b     : chr [1:500] "CASTVTSGSNEKLFF" "CASSLTGTGYTF" "CSALTPGLIYNEQFF" "CSARASWGTNEKLFF" ...
  ..$ sample    : chr [1:500] "a" "a" "a" "a" ...
  ..$ clone_size: num [1:500] 3 2 2 5 3 5 5 5 3 4 ...
 $ b :'data.frame': 500 obs. of  4 variables:
  ..$ CDR3a     : chr [1:500] "CASSLRGAHNEQFF" "CASGLRQGYGYTF" "CSAGGFRETQYF" "CGSSLSQGSEQYF" ...
  ..$ CDR3b     : chr [1:500] "CASTVTSGSNEKLFF" "CASSLTGTGYTF" "CSALTPGLIYNEQFF" "CSARASWGTNEKLFF" ...
  ..$ sample    : chr [1:500] "b" "b" "b" "b" ...
  ..$ clone_size: num [1:500] 3 2 2 7 4 5 5 7 3 4 ...
 $ c :'data.frame': 500 obs. of  4 variables:
  ..$ CDR3a     : chr [1:500] "CASSLRGAHNEQFF" "CASGLRQGYGYTF" "CSAGGFRETQYF" "CGSSLSQGSEQYF" ...
  ..$ CDR3b     : chr [1:500] "CASTVTSGSNEKLFF" "CASSLTGTGYTF" "CSALTPGLIYNEQFF" "CSARASWGTNEKLFF" ...
  ..$ sample    : chr [1:500] "c" "c" "c" "c" ...
  ..$ clone_size: num [1:500] 3 2 2 9 5 5 5 9 3 4 ...
 $ ma:'data.frame': 500 obs. of  8 variables:
  ..$ clone_id: int [1:500] 1 2 3 4 5 6 7 8 9 10 ...
  ..$ cell    : chr [1:500] "CD8" "CD4" "CD8" "CD8" ...
  ..$ HLA_A   : chr [1:500] "HLA-A∗24" "HLA-A∗24" "HLA-A∗24" "HLA-A∗24" ...
  ..$ age     : num [1:500] 24 24 24 24 24 24 24 24 24 24 ...
  ..$ TRAV    : chr [1:500] "TRAV27" "TRAV27" "TRAV20-1" "TRAV7-7" ...
  ..$ TRAJ    : chr [1:500] "TRAJ2-1" "TRAJ1-2" "TRAJ2-5" "TRAJ2-7" ...
  ..$ TRBV    : chr [1:500] "TRBV6-8" "TRBV7-3" "TRBV20-1" "TRBV20-1" ...
  ..$ TRBJ    : chr [1:500] "TRBJ1-4" "TRBJ1-2" "TRBJ2-1" "TRBJ1-4" ...
 $ mb:'data.frame': 500 obs. of  8 variables:
  ..$ clone_id: int [1:500] 1 2 3 4 5 6 7 8 9 10 ...
  ..$ cell    : chr [1:500] "CD8" "CD4" "CD4" "CD4" ...
  ..$ HLA_A   : chr [1:500] "HLA-A∗02" "HLA-A∗02" "HLA-A∗02" "HLA-A∗02" ...
  ..$ age     : num [1:500] 30 30 30 30 30 30 30 30 30 30 ...
  ..$ TRAV    : chr [1:500] "TRAV27" "TRAV27" "TRAV20-1" "TRAV7-7" ...
  ..$ TRAJ    : chr [1:500] "TRAJ2-1" "TRAJ1-2" "TRAJ2-5" "TRAJ2-7" ...
  ..$ TRBV    : chr [1:500] "TRBV6-8" "TRBV7-3" "TRBV20-1" "TRBV20-1" ...
  ..$ TRBJ    : chr [1:500] "TRBJ1-4" "TRBJ1-2" "TRBJ2-1" "TRBJ1-4" ...
 $ mc:'data.frame': 500 obs. of  8 variables:
  ..$ clone_id: int [1:500] 1 2 3 4 5 6 7 8 9 10 ...
  ..$ cell    : chr [1:500] "CD8" "CD8" "CD8" "CD8" ...
  ..$ HLA_A   : chr [1:500] "HLA-A∗11" "HLA-A∗11" "HLA-A∗11" "HLA-A∗11" ...
  ..$ age     : num [1:500] 40 40 40 40 40 40 40 40 40 40 ...
  ..$ TRAV    : chr [1:500] "TRAV27" "TRAV27" "TRAV20-1" "TRAV7-7" ...
  ..$ TRAJ    : chr [1:500] "TRAJ2-1" "TRAJ1-2" "TRAJ2-5" "TRAJ2-7" ...
  ..$ TRBV    : chr [1:500] "TRBV6-8" "TRBV7-3" "TRBV20-1" "TRBV20-1" ...
  ..$ TRBJ    : chr [1:500] "TRBJ1-4" "TRBJ1-2" "TRBJ2-1" "TRBJ1-4" ...
```

Extract the data.frames for each TCR repertoire and their metadata:

We will merge three TCR repertoires into the data.frame tcr\_reps.

```
tcr_reps <- rbind(D1$a, D1$b, D1$c)
```

We will do the same for the metadata

```
meta <- rbind(D1$ma, D1$mb, D1$mc)
```

## 3.2 Algorithm

*[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* performs the following steps.

1. Compute similarities between T-cell clonotypes within each TCR
   repertoire
2. Construct a graph from each TCR repertoire
3. Construct a joint similarity graph (\(J\))
4. Detect communities in \(J\)
5. Analyze Differential Community Occupancy (DCO)

   a. Between individual TCR repertoires with model \(M\)

   b. Between groups of TCR repertoires from biological conditions
   with model \(M\_h\)
6. Inspect results

## 3.3 **Step 1.** Compute TCR clonotype similarities in a repertoire with `cluster_irr`

*[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* aims to quantify the similarity between pairs of
TCR clonotypes based on the similarities of their CDR3s sequences. For this
it employs Basic Local-Alignment Search Tool (BLAST) via the R-package
*[blaster](https://CRAN.R-project.org/package%3Dblaster)*. Briefly, a protein database is constructed from
all CDR3 sequences, and each CDR3 sequence is used as a query. This
enables fast sequence similarity searches. Furthermore, only CDR3
sequences matches with \(\geq\) 80% sequence identity to the query are
retained. This step reduces the computational and memory requirements,
without impacting downstream community analyses, as CDR3 sequences with
lower typically yield low similarity scores.

For matched CDR3 pair, an alignment score (\(\omega\)) is computed using
BLOSUM62 substitution scores with gap opening penalty of -10 and gap
extension penalty of -4. \(\omega\) is the sum of substitution scores and
gap penalties in the alignment. Identical or highly similar CDR3
sequence pairs receive large positive \(\omega\) scores, while dissimilar
pairs receive low or negative \(\omega\). To normalize \(\omega\) for
alignment length, *[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* computes
\(\bar{\omega} = \omega/l\), where \(l\) is the alignment length yielding
normalized alignment score \(\bar{\omega}\). This normalization, also used
in iSMART (Zhang, 2020), ensures comparability across CDR3 pairs of
varying lengths.

*[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* also computes alignment scores for the CDR3
**core** regions (\(\omega^c\) and \(\bar{\omega}^c\)). The CDR3 core,
representing the central loop region with high antigen-contact
probability (Glanville, 2017), is generated by trimming three residues
from each end of the CDR3 sequence. Comparing \(\bar{\omega}^c\) and
\(\bar{\omega}\) allows assessment of whether sequence similarity is
concentrated in the core or flanking regions.

## 3.4 **Step 2-3.** Construct TCR repertoire graphs and join them into \(J\)

Next, *[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* builds a graph for each TCR repertoire.
The graphs have *nodes* and *weighted edges*:

* nodes: clonotypes from each TCR repertoire. Each clonotype attribute
  (clone size, CDR3 sequences, etc.) is provided as node attribute
* edges: undirected edges connecting pairs of nodes based on
  CDR3\(\alpha\) and CDR3\(\beta\) similarity scores (\(\bar{\omega}\) and
  \(\bar{\omega}^c\)) in each TCR repertoire (computed in step 1.)

Then the graphs are joined together: edges between TCR clonotypes from
different TCR repertoires are computed using the same procedure outlined
in step 1. The joint graph \(J\) is stored as an `igraph` object.

## 3.5 Run steps 1-3 with `clustirr`

Step 1. involves calling the function `clust_irr` which returns an S4
object of class `clust_irr`.

```
cl <- clustirr(s = tcr_reps, meta = meta, control = list(gmi = 0.8))
```

The output **complex** list with three elements:

1. `graph` = the joint graph \(J\)
2. `clust_irrs` = list with S4 `clust_irr` objects one for each TCR
   repertoire
3. `multigraph` = logical value which tell us whether \(J\) contains
   multiple or a single TCR repertoire

### 3.5.1 Inspect the content of `clust_irrs`

We can look at the similarity scores between CDR3 sequences of TCR
repertoire `a`. Each row is a pair of CDR3 sequences from the repertoire
annotated with the following metrics:

* `max_len`: length of the longer CDR3 sequence in the pair
* `max_clen`: length of the longer CDR3 core sequence in the pair
* `weight`: \(\omega\) = BLOSUM62 score of the **complete** CDR3
  alignment
* `cweight`= \(\omega\_c\): BLOSUM62 score of CDR3 **cores**
* `nweight` = \(\bar{\omega}\): normalized `weight` by `max_len`
* `ncweight` = \(\bar{\omega}\_c\): normalized `cweight` by `max_clen`

The results for CDR3\(\alpha\) sequence pairs from repertoire `a`:

```
kable(head(cl$clust_irrs[["a"]]@clust$CDR3a), digits = 2)
```

| from\_cdr3 | to\_cdr3 | weight | cweight | nweight | ncweight | max\_len | max\_clen |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CASRRGGYNEQFF | CSVRRGGYNEQFF | 117 | 68 | 9.0 | 9.7 | 13 | 7 |
| CASSLSSGNTIYF | CASSLSISGNTIYF | 105 | 47 | 7.5 | 5.9 | 14 | 8 |
| CASSLSSGNTIYF | CASSRGHSSGNTIYF | 95 | 37 | 6.3 | 4.1 | 15 | 9 |
| CASSQGSRGSTEAFF | CASSLISRGGTEAFF | 116 | 59 | 7.7 | 6.6 | 15 | 9 |
| CASSEVSGRTYEQYF | CASSQVDGTYEQYF | 110 | 51 | 7.3 | 5.7 | 15 | 9 |
| CSARGSTGELFF | CSARGGWTGELFF | 94 | 37 | 7.2 | 5.3 | 13 | 7 |

… the same table for CDR3\(\beta\) sequence pairs from repertoire `a`:

```
kable(head(cl$clust_irrs[["a"]]@clust$CDR3b), digits = 2)
```

| from\_cdr3 | to\_cdr3 | weight | cweight | nweight | ncweight | max\_len | max\_clen |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CASGLNVNTEAFF | CASSLNRVNTEAFF | 101 | 44 | 7.2 | 5.5 | 14 | 8 |
| CASGLNVNTEAFF | CASGLVGNTEAFF | 105 | 48 | 8.1 | 6.9 | 13 | 7 |
| CASSLEGPVTDTQYF | CASSLGGSTDTQYF | 104 | 45 | 6.9 | 5.0 | 15 | 9 |
| CATSRPGGEWETQYF | CATSRPLGEETQYF | 111 | 51 | 7.4 | 5.7 | 15 | 9 |
| CASSLGPGVYEQYF | CASSLGTSGVRYEQYF | 98 | 39 | 6.1 | 3.9 | 16 | 10 |
| CASSLGTAPNQPQHF | CASSLGQGGNQPQHF | 125 | 65 | 8.3 | 7.2 | 15 | 9 |

Notice that very similar CDR3\(\alpha\) or CDR3\(\beta\) pairs have high
normalized alignment scores (\(\bar{\omega}\)). We have similar tables for
repertoire `b` and `c`. These are used internally to construct graphs in
the next step.

### 3.5.2 Inspect graphs with `plot_graph`

We can use the function `plot_graph` for interactive visualization of
relatively small graphs.

The function `clust_irr` performs automatic annotation of TCR clonotypes
based on multiple databases (DBs), including: VDJdb, TCR3d, McPAS-TCR.
Each TCR clonotype recieves two types of annotations (per chain and per
database):

* **Ag\_species**: the name of the antigen species recognized by the
  clonotype’s CDR3
* **Ag\_gene**: the name of the antigen gene recognized by clonotype’s CDR3

Hence, in the plot we can highlight TCR clonotypes that recognize certain
antigenic species or genes (see dropdown menu), or use the hoovering
function to look at the CDR3 sequences of nodes.

Do this now!

```
plot_graph(cl, select_by = "Ag_species", as_visnet = TRUE)
```

Notice that even in this small case study–where each TCR repertoire
contains **only 500 TCR clonotypes**–we observe that the **joint graph is
complex**! This complexity makes qualitative analyses impractical. To
address this, *[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* focuses on **quantitative
analyses** (see the next steps).

### 3.5.3 You can evaluate \(J\) with igraph

We can use igraph functions to inspect various properties of the graph
in `cl$graph`. For instance, below, we extract the edge attributes and
visualize the distributions of the edge attributes `ncweight` and
`nweight` for all CDR3\(\alpha\) and CDR3\(\beta\) sequence pairs.

```
# data.frame of edges and their attributes
e <- igraph::as_data_frame(x = cl$graph, what = "edges")
```

```
ggplot(data = e)+
  geom_density(aes(ncweight, col = chain))+
  geom_density(aes(nweight, col = chain), linetype = "dashed")+
  xlab(label = "edge weight (solid = ncweight, dashed = nweight)")+
  theme(legend.position = "top")
```

![](data:image/png;base64...)

Can you guess why we observe **trimodal** distributions?

* *Top mode: weights of identical CDR3 sequence pairs from the
  different TCR repertoires*
* *Middle mode: weights of CDR3 sequences with same lengths*
* *Bottom mode: weights of CDR3 sequences with different lengths ->
  scores penalized by gap cost*

## 3.6 **Step 4.** community detection with `detect_communities`

*[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* employs graph-based community detection (GCD)
algorithms, such as Louvain, Leiden or InfoMap, to identify
**communities** of nodes that have high density of edges among each
other, and low density of edges with nodes outside the community.

First, the similarity score between T-cell clonotypes \(i\) and \(j\) is
defined as the average CDR3\(\alpha\) and CDR3\(\beta\) alignment scores:

\[\begin{align}
\omega(i,j) = \dfrac{{\bar{\omega}}\_\alpha + {\bar{\omega}}\_\beta}{2}
\end{align}\]

where \(\bar{\omega}\_\alpha\) and \(\bar{\omega}\_\beta\) are the alignment
scores for the CDR3\(\alpha\) and CDR3\(\beta\), respectively. If a chain is
missing, its alignment score is set to 0.

The user has the following options:

* `algorithm`: “leiden” (default) “louvain”, or “infomap”
* `resolution`: GCD resolution = 1 (default)
* `iterations`: number of clustering iterations (default = 100) to
  ensure robust results
* `weight`: “ncweight” (default) or “nweight”
* `chains`: “CDR3a” or “CDR3b” or c(“CDR3a”, “CDR3b”)

```
gcd <- detect_communities(graph = cl$graph,
                          algorithm = "leiden",
                          metric = "average",
                          resolution = 1,
                          iterations = 100,
                          weight = "ncweight",
                          chains = c("CDR3a", "CDR3b"))
```

### 3.6.1 Inspecting the outputs of `detect_communities`

The function `detect_communities` generates a complex output. Lets
investigate its elements:

```
names(gcd)
```

```
[1] "community_occupancy_matrix" "community_summary"
[3] "node_summary"               "graph"
[5] "graph_structure_quality"    "input_config"
```

The main element is `community_occupancy_matrix`, which contains the
number of T-cells in each community (row) and repertoire (column). Here
we have three repertoires (three columns) and over 400 communities.
This matrix is the main input of the function `dco` (step 5.), to detect
differences in the community occupancy between repertoires.

```
dim(gcd$community_occupancy_matrix)
```

```
[1] 422   3
```

```
head(gcd$community_occupancy_matrix)
```

```
  a b c
1 3 3 3
2 2 2 2
3 2 2 2
4 5 7 9
5 3 4 5
6 5 5 5
```

### 3.6.2 Visualizing community abundance matrices with `get_honeycombs`

```
honeycomb <- get_honeycombs(com = gcd$community_occupancy_matrix)
```

In the **honeycomb plots** shown below, several communities (black dots)
appear **far** from the diagonal. This indicates that these communities
contain more cells in repertoires b and c (y-axes in panels A and B)
compared to repertoire a (x-axes in panels A and B). Meanwhile, the same
points are generally close to the diagonal in panel C but remain
slightly more abundant in repertoire c (y-axis) compared to b (x-axis).

In step 5, *[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* will provide a quantitative answer to
the question: *Which communities are differentially abundant between
pairs of repertoires?*

Importantly, the color of the hexagons encodes the density of
communities in the 2D scatterplots: **dark hexagons** indicate high a
frequency of communities, while **light hexagons** represent sparsely
populated regions.

```
wrap_plots(honeycomb, nrow = 1)+
    plot_annotation(tag_levels = 'A')
```

![](data:image/png;base64...)

Also see `community_summary`. In the data.frame `wide` we provide
community summaries in each community across all TCR repertoires,
including:

* `clones_a`, `clone_b`, `clone_c`, `clones_n`: the frequency of
  clonotypes in the community coming from repertoire `a`, `b`, `c` and in
  total (n)
* `cells_a`, `cells_b`, `cells_c`, `cells_n`: the frequency of cell in
  the community coming from repertoires `a`, `b`, `c` and in total (n)
* `w`: average inter-clonotype similarity
* `ncweight_CDR3a/b`, `nweight_CDR3a/b`: raw and normalized similarity
  for CDR3\(\alpha\) and CDR3\(\beta\) sequences
* `n_CDR3a`, `n_CDR3b`: number of edges between CDR3\(\alpha\) and
  CDR3\(\beta\) sequences

```
kable(head(gcd$community_summary$wide), digits = 1, row.names = FALSE)
```

| community | clones\_a | clones\_b | clones\_c | clones\_n | cells\_a | cells\_b | cells\_c | cells\_n | w | ncweight\_CDR3a | ncweight\_CDR3b | nweight\_CDR3a | nweight\_CDR3b | n\_CDR3a | n\_CDR3b |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 1 | 1 | 1 | 3 | 3 | 3 | 3 | 9 | 9.1 | NaN | 9.1 | NaN | 9.3 | 3 | 3 |
| 2 | 1 | 1 | 1 | 3 | 2 | 2 | 2 | 6 | 9.3 | NaN | 9.3 | NaN | 9.6 | 3 | 3 |
| 3 | 1 | 1 | 1 | 3 | 2 | 2 | 2 | 6 | 9.4 | NaN | 9.4 | NaN | 9.6 | 3 | 3 |
| 4 | 1 | 1 | 1 | 3 | 5 | 7 | 9 | 21 | 9.1 | NaN | 9.1 | NaN | 9.5 | 3 | 3 |
| 5 | 1 | 1 | 1 | 3 | 3 | 4 | 5 | 12 | 9.6 | NaN | 9.6 | NaN | 9.8 | 3 | 3 |
| 6 | 1 | 1 | 1 | 3 | 5 | 5 | 5 | 15 | 9.6 | NaN | 9.6 | NaN | 9.8 | 3 | 3 |

In the data.frame `tall` we provide community and repertoire summaries
in each row.

```
kable(head(gcd$community_summary$tall), digits = 1, row.names = FALSE)
```

| community | sample | clones | cells | w | ncweight\_CDR3a | ncweight\_CDR3b | nweight\_CDR3a | nweight\_CDR3b | n\_CDR3a | n\_CDR3b |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | a | 1 | 3 | 9.1 | NaN | 9.1 | NaN | 9.3 | 3 | 3 |
| 1 | b | 1 | 3 | 9.1 | NaN | 9.1 | NaN | 9.3 | 3 | 3 |
| 1 | c | 1 | 3 | 9.1 | NaN | 9.1 | NaN | 9.3 | 3 | 3 |
| 112 | a | 3 | 11 | 5.2 | 1.8 | 4.0 | 2 | 4.4 | 18 | 18 |
| 112 | b | 3 | 12 | 5.2 | 1.8 | 4.0 | 2 | 4.4 | 18 | 18 |
| 112 | c | 3 | 13 | 5.2 | 1.8 | 4.0 | 2 | 4.4 | 18 | 18 |

Node-specific (TCR clonotype-specific) summaries are provided in
`node_summary`

```
kable(head(gcd$node_summary), digits = 1, row.names = FALSE)
```

| name | clone\_id | Ag\_gene | Ag\_species | info\_tcr3d\_CDR3a | db\_tcr3d\_CDR3a | info\_tcr3d\_CDR3b | db\_tcr3d\_CDR3b | info\_mcpas\_CDR3a | db\_mcpas\_CDR3a | info\_mcpas\_CDR3b | db\_mcpas\_CDR3b | info\_vdjdb\_CDR3a | db\_vdjdb\_CDR3a | info\_vdjdb\_CDR3b | db\_vdjdb\_CDR3b | clone\_size | sample | CDR3b | CDR3a | cell | HLA\_A | age | TRAV | TRAJ | TRBV | TRBJ | id | community |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| a|1 | 1 |  |  | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | 3 | a | CASTVTSGSNEKLFF | CASSLRGAHNEQFF | CD8 | HLA-A∗24 | 24 | TRAV27 | TRAJ2-1 | TRBV6-8 | TRBJ1-4 | 1 | 1 |
| a|2 | 2 |  |  | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | 2 | a | CASSLTGTGYTF | CASGLRQGYGYTF | CD4 | HLA-A∗24 | 24 | TRAV27 | TRAJ1-2 | TRBV7-3 | TRBJ1-2 | 2 | 2 |
| a|3 | 3 |  |  | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | 2 | a | CSALTPGLIYNEQFF | CSAGGFRETQYF | CD8 | HLA-A∗24 | 24 | TRAV20-1 | TRAJ2-5 | TRBV20-1 | TRBJ2-1 | 3 | 3 |
| a|4 | 4 |  |  | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | 5 | a | CSARASWGTNEKLFF | CGSSLSQGSEQYF | CD8 | HLA-A∗24 | 24 | TRAV7-7 | TRAJ2-7 | TRBV20-1 | TRBJ1-4 | 4 | 4 |
| a|5 | 5 |  |  | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | 3 | a | CASSVREAENQPQHF | CSPRGPYGYTF | CD8 | HLA-A∗24 | 24 | TRAV20-1 | TRAJ1-2 | TRBV4-1 | TRBJ1-5 | 5 | 5 |
| a|6 | 6 |  |  | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | NA | 0 | 5 | a | CASCTVGNQPQHF | CSLGPSKSQYF | CD8 | HLA-A∗24 | 24 | TRAV29-1 | TRAJ2-3 | TRBV19 | TRBJ1-5 | 6 | 6 |

### 3.6.3 Special functions: decoding communities with `decode_community`

Community with ID=8 contains 9 TCR clonotypes. These are connected based on
their CDR3\(\beta\) sequences.

```
ns_com_8 <- gcd$node_summary[gcd$node_summary$community == 8, ]

table(ns_com_8$sample)
```

```
a b c
3 3 3
```

We can extract it and visualize it using igraph:

```
par(mai = c(0,0,0,0))
plot(subgraph(graph = gcd$graph, vids = which(V(gcd$graph)$community == 8)))
```

![](data:image/png;base64...)

Furthermore, we can “decompose” this graph using `decode_community`
based on the attributes of the edges (`edge_filter`) and nodes
(`node_filter`).

```
# we can pick from these edge attributes
edge_attr_names(graph = gcd$graph)
```

```
[1] "nweight"  "ncweight" "chain"    "w"
```

The following edge-filter will instruct ClustIRR to keep edges with with
edge attributes: nweight \(>=\) 8 **AND** ncweight \(>=\) 8

```
edge_filter <- rbind(data.frame(name = "nweight", value = 8, operation = ">="),
                     data.frame(name = "ncweight", value = 8, operation = ">="))
```

```
# we can pick from these node attributes
vertex_attr_names(graph = gcd$graph)
```

```
 [1] "name"             "clone_id"         "Ag_gene"          "Ag_species"
 [5] "info_tcr3d_CDR3a" "db_tcr3d_CDR3a"   "info_tcr3d_CDR3b" "db_tcr3d_CDR3b"
 [9] "info_mcpas_CDR3a" "db_mcpas_CDR3a"   "info_mcpas_CDR3b" "db_mcpas_CDR3b"
[13] "info_vdjdb_CDR3a" "db_vdjdb_CDR3a"   "info_vdjdb_CDR3b" "db_vdjdb_CDR3b"
[17] "clone_size"       "sample"           "CDR3b"            "CDR3a"
[21] "cell"             "HLA_A"            "age"              "TRAV"
[25] "TRAJ"             "TRBV"             "TRBJ"             "id"
[29] "community"
```

The following node-filter will instruct ClustIRR to retain edges between
nodes that have shared node attributed with respect to **ALL** of the
following node attributes:

```
node_filter <- data.frame(name = c("TRBV", "TRAV"))
```

```
c8 <- decode_community(community_id = 8,
                         graph = gcd$graph,
                         edge_filter = edge_filter,
                         node_filter = node_filter)
```

```
par(mar = c(0, 0, 0, 0))
plot(c8$community, vertex.size = 10)
```

![](data:image/png;base64...)

```
kable(as_data_frame(x = c8$community, what = "vertices")
      [, c("name", "component_id", "CDR3b", "TRBV",
           "TRBJ", "CDR3a", "TRAV", "TRAJ")],
      row.names = FALSE)
```

| name | component\_id | CDR3b | TRBV | TRBJ | CDR3a | TRAV | TRAJ |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a|8 | 2 | CASSGRGGDNEQFF | TRBV7-9 | TRBJ2-1 | CASGTLSYNEQFF | TRAV19 | TRAJ2-1 |
| b|8 | 2 | CASSGRGGDNEQFF | TRBV7-9 | TRBJ2-1 | CASGTLSYNEQFF | TRAV19 | TRAJ2-1 |
| c|8 | 2 | CASSGRGGDNEQFF | TRBV7-9 | TRBJ2-1 | CASGTLSYNEQFF | TRAV19 | TRAJ2-1 |
| a|59 | 3 | CASSGQGGYYNEQFF | TRBV9 | TRBJ2-1 | CSARDGDSSSYEQYF | TRAV20-1 | TRAJ2-7 |
| b|59 | 3 | CASSGQGGYYNEQFF | TRBV9 | TRBJ2-1 | CSARDGDSSSYEQYF | TRAV20-1 | TRAJ2-7 |
| c|59 | 3 | CASSGQGGYYNEQFF | TRBV9 | TRBJ2-1 | CSARDGDSSSYEQYF | TRAV20-1 | TRAJ2-7 |
| a|344 | 1 | CASSERGGGSNEQFF | TRBV7-8 | TRBJ2-1 | CSAREITEAFF | TRAV20-1 | TRAJ1-1 |
| b|344 | 1 | CASSERGGGSNEQFF | TRBV7-8 | TRBJ2-1 | CSAREITEAFF | TRAV20-1 | TRAJ1-1 |
| c|344 | 1 | CASSERGGGSNEQFF | TRBV7-8 | TRBJ2-1 | CSAREITEAFF | TRAV20-1 | TRAJ1-1 |

… or we can summarize the properties of each component in the next
table as rows with:

* component id, community id (=8 in this example because this is what
  we selected)
* mean edge weights (for all core and complete CDR3 pairs)
* number of nodes, number of edges and expected number edges if the
  component were a clique
* diameter of the component

```
kable(c8$component_stats, row.names = FALSE)
```

| component\_id | community | mean\_ncweight | mean\_nweight | n\_nodes | n\_edges | n\_clique\_edges | diameter |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 8 | 9.0 | 9.3 | 3 | 3 | 3 | 1 |
| 2 | 8 | 9.4 | 9.5 | 3 | 3 | 3 | 1 |
| 3 | 8 | 9.5 | 9.6 | 3 | 3 | 3 | 1 |

## 3.7 **Step 5.** differential community occupancy (DCO) with `dco`

Do we see **expanding** or **contracting** communities in a given
repertoire?

We employ a Bayesian model to quantify the relative abundance
(occupancy) of individual communities in each repertoire.

The model output for repertoire \(a\) is the parameter vector
\(\beta^a=\beta^a\_1,\beta^a\_2,\ldots,\beta^a\_k\), which describes the
effect of repertoire \(a\) on the relative occupancy in each community.

Given two repertoires, \(a\) and \(b\), we can quantify the differential
community occupancy (DCO):

\[\begin{align}
\delta^{a-b}\_i = \beta^a\_i - \beta^b\_i
\end{align}\]

```
d <- dco(community_occupancy_matrix = gcd$community_occupancy_matrix,
         mcmc_control = list(mcmc_warmup = 300,
                             mcmc_iter = 600,
                             mcmc_chains = 2,
                             mcmc_cores = 1,
                             mcmc_algorithm = "NUTS",
                             adapt_delta = 0.9,
                             max_treedepth = 10))
```

```
SAMPLING FOR MODEL 'dm' NOW (CHAIN 1).
Chain 1:
Chain 1: Gradient evaluation took 0.000622 seconds
Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 6.22 seconds.
Chain 1: Adjust your expectations accordingly!
Chain 1:
Chain 1:
Chain 1: Iteration:   1 / 600 [  0%]  (Warmup)
Chain 1: Iteration:  60 / 600 [ 10%]  (Warmup)
Chain 1: Iteration: 120 / 600 [ 20%]  (Warmup)
Chain 1: Iteration: 180 / 600 [ 30%]  (Warmup)
Chain 1: Iteration: 240 / 600 [ 40%]  (Warmup)
Chain 1: Iteration: 300 / 600 [ 50%]  (Warmup)
Chain 1: Iteration: 301 / 600 [ 50%]  (Sampling)
Chain 1: Iteration: 360 / 600 [ 60%]  (Sampling)
Chain 1: Iteration: 420 / 600 [ 70%]  (Sampling)
Chain 1: Iteration: 480 / 600 [ 80%]  (Sampling)
Chain 1: Iteration: 540 / 600 [ 90%]  (Sampling)
Chain 1: Iteration: 600 / 600 [100%]  (Sampling)
Chain 1:
Chain 1:  Elapsed Time: 21.733 seconds (Warm-up)
Chain 1:                15.007 seconds (Sampling)
Chain 1:                36.74 seconds (Total)
Chain 1:

SAMPLING FOR MODEL 'dm' NOW (CHAIN 2).
Chain 2:
Chain 2: Gradient evaluation took 0.000371 seconds
Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 3.71 seconds.
Chain 2: Adjust your expectations accordingly!
Chain 2:
Chain 2:
Chain 2: Iteration:   1 / 600 [  0%]  (Warmup)
Chain 2: Iteration:  60 / 600 [ 10%]  (Warmup)
Chain 2: Iteration: 120 / 600 [ 20%]  (Warmup)
Chain 2: Iteration: 180 / 600 [ 30%]  (Warmup)
Chain 2: Iteration: 240 / 600 [ 40%]  (Warmup)
Chain 2: Iteration: 300 / 600 [ 50%]  (Warmup)
Chain 2: Iteration: 301 / 600 [ 50%]  (Sampling)
Chain 2: Iteration: 360 / 600 [ 60%]  (Sampling)
Chain 2: Iteration: 420 / 600 [ 70%]  (Sampling)
Chain 2: Iteration: 480 / 600 [ 80%]  (Sampling)
Chain 2: Iteration: 540 / 600 [ 90%]  (Sampling)
Chain 2: Iteration: 600 / 600 [100%]  (Sampling)
Chain 2:
Chain 2:  Elapsed Time: 21.88 seconds (Warm-up)
Chain 2:                14.902 seconds (Sampling)
Chain 2:                36.782 seconds (Total)
Chain 2:
```

## 3.8 **Step 6.** Inspect results

### 3.8.1 Visualizing the distribution of \(\beta\) with `get_beta_violins`

```
beta_violins <- get_beta_violin(node_summary = gcd$node_summary,
                                beta = d$posterior_summary$beta,
                                ag = "",
                                ag_species = TRUE,
                                db = "vdjdb")
```

```
beta_violins
```

![](data:image/png;base64...)

### 3.8.2 Compare \(\beta\)s of clonotypes specific for *CMV*, *EBV*, *flu* or *MLANA*?

```
beta_violins <- get_beta_violin(node_summary = gcd$node_summary,
                                beta = d$posterior_summary$beta,
                                ag = "CMV",
                                ag_species = TRUE,
                                db = "vdjdb")
```

```
beta_violins
```

![](data:image/png;base64...)

### 3.8.3 Posterior predictive checks

Before we can start interpreting the model results, we have to make sure
that the model is valid. One standard approach is to check whether our
model can retrodict the observed data (community occupancy matrix) which
was used to fit model parameters.

General idea of posterior predictive checks:

1. fit model based on data \(y\)
2. simulate new data \(\hat{y}\)
3. compare \(y\) and \(\hat{y}\)

*[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* provides \(y\) and \(\hat{y}\) of each repertoire,
which we can visualize with ggplot:

```
ggplot(data = d$posterior_summary$y_hat)+
  facet_wrap(facets = ~sample, nrow = 1, scales = "free")+
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", col = "gray")+
  geom_errorbar(aes(x = y_obs, y = mean, ymin = L95, ymax = H95),
                col = "darkgray", width=0)+
  geom_point(aes(x = y_obs, y = mean), size = 0.8)+
  xlab(label = "observed y")+
  ylab(label = "predicted y (and 95% HDI)")
```

![](data:image/png;base64...)

### 3.8.4 Differential community abundance results \(\rightarrow\) par. \(\delta\)

Given two repertoires, \(a\) and \(b\), we can quantify the differential
community occupancy (DCO):

\[\begin{align}
\delta^{a-b}\_i = \beta^a\_i - \beta^b\_i
\end{align}\]

Importantly, *[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* always computes both contrasts (\(a\)
vs. \(b\) and \(b\) vs. \(a\)): \(\delta^{a-b}\_i\) and \(\delta^{b-a}\_i\).

```
ggplot(data = d$posterior_summary$delta)+
    facet_wrap(facets = ~contrast, ncol = 2)+
    geom_errorbar(aes(x = community, y = mean, ymin = L95, ymax = H95),
                  col = "lightgray", width = 0)+
    geom_point(aes(x = community, y = mean), shape = 21, fill = "black",
               stroke = 0.4, col = "white", size = 1.25)+
    theme(legend.position = "top")+
    ylab(label = expression(delta))+
    scale_x_continuous(expand = c(0,0))
```

![](data:image/png;base64...)

Given two repertoires, \(a\) and \(b\), *[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* also
quantifies absolute differences in community probabilities:

\[\begin{align}
\epsilon^{a-b} = \mathrm{softmax}(\alpha + \beta^a) -
\mathrm{softmax}(\alpha + \beta^b)
\end{align}\]

Again, both contrasts are computed: \(\epsilon^{a-b}\_i\) and
\(\epsilon^{b-a}\_i\).

```
ggplot(data = d$posterior_summary$epsilon)+
    facet_wrap(facets = ~contrast, ncol = 2)+
    geom_errorbar(aes(x = community, y = mean, ymin = L95, ymax = H95),
                  col = "lightgray", width = 0)+
    geom_point(aes(x = community, y = mean), shape = 21, fill = "black",
               stroke = 0.4, col = "white", size = 1.25)+
    theme(legend.position = "top")+
    ylab(label = expression(epsilon))+
    scale_x_continuous(expand = c(0,0))
```

![](data:image/png;base64...)

## 3.9 Conclusion: you can also use **custom** community occupancy matrix for DCO!

The function `dco` takes as its main input a community occupancy matrix.
This enables users who are accustomed to using complementary algorithm
for detecting specificity groups, such as, GLIPH, TCRdist3, GIANA, and
iSMART, to skip steps 1-4 of the *[ClustIRR](https://bioconductor.org/packages/3.22/ClustIRR)* workflow, and
to proceed with analysis for DCO.