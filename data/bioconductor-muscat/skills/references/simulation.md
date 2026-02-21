# Simulating complex design scRNA-seq data with `muscat`

Helena L Crowell1,2\*, Charlotte Soneson1,3, Pierre-Luc Germain1,2 and Mark D Robinson1,2

1Institute for Molecular Life Sciences, University of Zurich, Zurich, Switzerland
2Swiss Institute of Bioinformatics (SIB), Zurich, Switzerland
3Present address: Friedrich Miescher Institute Basel, Switzerland
 & Swiss Institute of Bioinformatics (SIB), Basel, Switzerland

\*helena.crowell@uzh.ch

#### October 30, 2025

#### Abstract

`muscat`: **mu**lti-sample **mu**lti-group **sc**RNA-seq **a**nalysis **t**ools (**???**) provides a straightforward but effective simulation framework that is anchored to a labeled multi-sample multi-subpopulation scRNA-seq reference dataset, uses (non-zero-inflated) negative binomial (NB) as the canonical distribution for droplet scRNA-seq datasets, and exposes various parameters to modulate: the number of subpopulations and samples simulated, the number of cells per subpopulation (and sample), and the type and magnitude of a wide range of patterns of differential expression.

This vignette serves to provide the underlying theoretical background, to thoroughly describe the various input arguments, and to demonstrate the simulation framework’s current capabilities using some illustrative (not necessarily realistic) examples.

#### Package

muscat 1.24.0

# Contents

* [Load packages](#load-packages)
* [Data description](#data-description)
* [1 Simulation framework](#simulation-framework)
  + [1.1 `prepSim`: Preparing data for simulation](#prepsim-preparing-data-for-simulation)
  + [1.2 `simData`: Simulating complex designs](#simdata-simulating-complex-designs)
    - [1.2.1 `p_dd`: Simulating differential distributions](#p_dd-simulating-differential-distributions)
    - [1.2.2 `rel_lfc`: Simulating cluster-specific state changes](#rel_lfc-simulating-cluster-specific-state-changes)
    - [1.2.3 `p_type`: Simulating *type* features](#p_type-simulating-type-features)
  + [1.3 Simulation a hierarchical cluster structure](#simulation-a-hierarchical-cluster-structure)
    - [1.3.1 `p_type`: Introducing *type* features](#p_type-introducing-type-features)
    - [1.3.2 `phylo_tree`: Introducing a cluster phylogeny](#phylo_tree-introducing-a-cluster-phylogeny)
  + [1.4 Simulating batch effects](#simulating-batch-effects)
* [2 Quality control](#quality-control)
* [3 Method benchmarking](#method-benchmarking)
* [Session info](#session-info)
* [References](#references)

---

For details on the concepts presented here, consider having a look at our publication:

> Crowell HL, Soneson C\*, Germain P-L\*, Calini D,

# Load packages

```
library(dplyr)
library(muscat)
library(purrr)
library(scater)
library(reshape2)
library(patchwork)
library(cowplot)
library(SingleCellExperiment)
```

# Data description

To demonstrate *[muscat](https://bioconductor.org/packages/3.22/muscat)*’s simulation framework, we will use a *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* (SCE) containing 10x droplet-based scRNA-seq PBCM data from 8 Lupus patients obtained befor and after 6h-treatment with IFN-\(\beta\) (Kang et al. [2018](#ref-Kang2018-demuxlet)). The complete raw data, as well as gene and cell metadata is available through the NCBI GEO, accession number [GSE96583](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE96583).

# 1 Simulation framework

*[muscat](https://bioconductor.org/packages/3.22/muscat)*’s simulation framework comprises: i) estimation of negative binomial (NB) parameters from a reference multi-subpopulation, multi-sample dataset; ii) sampling of gene and cell parameters to use for simulation; and, iii) simulation of gene expression data as NB distributions of mixtures thereof. See Fig. [1](#fig:1a).

Let \(Y = (y\_{gc})\in\mathbb{N}\_0^{G\times C}\) denote the count matrix of a multi-sample multi-subpopulation reference dataset with genes \(\mathcal{G} = \{ g\_1, \ldots, g\_G \}\) and sets of cells \(\mathcal{C}\_{sk} = \{ c^{sk}\_1, ..., c^{sk}\_{C\_{sk}} \}\) for each sample \(s\) and subpopulation \(k\) (\(C\_{sk}\) is the number of cells for sample \(s\), subpopulation \(k\)). For each gene \(g\), we fit a model to estimate sample-specific means \(\beta\_g^s\), for each sample \(s\), and dispersion parameters \(\phi\_g\) using ’s function with default parameters. Thus, we model the reference count data as NB distributed:

\[Y\_{gc} \sim NB(\mu\_{gc}, \phi\_g)\]

for gene \(g\) and cell \(c\), where the mean \(\mu\_{gc} = \exp(\beta\_{g}^{s(c)}) \cdot \lambda\_c\). Here, \(\beta\_{g}^{s(c)}\) is the relative abundance of gene \(g\) in sample \(s(c)\), \(\lambda\_c\) is the library size (total number of counts), and \(\phi\_g\) is the dispersion.

![](data:image/png;base64...)

Figure 1: Schematic overview of muscat’s simulation framework
Given a count matrix of features by cells and, for each cell, pre-determined subpopulation identifiers as well as sample labels (0), dispersion and sample-wise means are estimated from a negative binomial distribution for each gene (for each subpopulation) (1.1); and library sizes are recorded (1.2). From this set of parameters (dispersions, means, library sizes), gene expression is sampled from a negative binomial distribution. Here, genes are selected to be “type” (subpopulation-specifically expressed; e.g., via marker genes), “state” (change in expression in a condition-specific manner) or equally expressed (relatively) across all samples (2). The result is a matrix of synthetic gene expression data (3).

For each subpopulation, we randomly assign each gene to a given *differential distribution* (DD) category (Korthauer et al. [2016](#ref-Korthauer2016-scDD)) according to a probability vector `p_dd` \(=(p\_{EE},p\_{EP},p\_{DE},p\_{DP},p\_{DM},p\_{DB})\). For each gene and subpopulation, we draw a vector of fold changes (FCs) from a Gamma distribution with shape parameter \(\alpha=4\) and rate \(\beta=4/\mu\_\text{logFC}\), where \(\mu\_\text{logFC}\) is the desired average logFC across all genes and subpopulations specified via argument `lfc`. The direction of differential expression is randomized for each gene, with equal probability of up- and down-regulation.

Next, we split the cells in a given subpopulations into two sets (representing treatment groups), \(\mathcal{T}\_A\) and \(\mathcal{T}\_B\), which are in turn split again into two sets each (representing subpopulations within the given treatment group.), \(\mathcal{T}\_{A\_1}/\mathcal{T}\_{A\_2}\) and \(\mathcal{T}\_{B\_1}/\mathcal{T}\_{B\_2}\).

For EE genes, counts for \(\mathcal{T}\_A\) and \(\mathcal{T}\_B\) are drawn using identical means.For EP genes, we multiply the effective means for identical fractions of cells per group by the sample FCs, i.e., cells are split such that \(\dim\mathcal{T}\_{A\_1} = \dim\mathcal{T}\_{B\_1}\) and \(\dim\mathcal{T}\_{A\_2} = \dim\mathcal{T}\_{B\_2}\). For DE genes, the means of one group, \(A\) or \(B\), are multiplied with the samples FCs. DP genes are simulated analogously to EP genes with \(\dim\mathcal{T}\_{A\_1} = a\cdot\dim\mathcal{T}\_A\) and \(\dim\mathcal{T}\_{B\_1} = b\cdot\dim\mathcal{T}\_B\), where \(a+b=1\) and \(a\neq b\). For DM genes, 50% of cells from one group are simulated at \(\mu\cdot\text{logFC}\). For DB genes, all cells from one group are simulated at \(\mu\cdot\text{logFC}/2\), and the second group is split into equal proportions of cells simulated at \(\mu\) and \(\mu\cdot\text{logFC}\), respectively. See Fig. [2](#fig:1b).

![](data:image/png;base64...)

Figure 2: Schematic of the various types of *differential distributions* supported by `muscat`’s simulation framework
Differential distributions are simulated from a NB distribution or mixtures thereof, according to the definitions of random variables X, Y and Z.

## 1.1 `prepSim`: Preparing data for simulation

To prepare a reference *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* (SCE) for simulation of multi-sample multi-group scRNA-seq data, `prepSim` will

1. perform basic filtering of genes and cells
2. (optionally) filter for subpopulation-sample instances with a threshold number of cells to assure accurate parameter estimation
3. estimate cell (library sizes) and gene parameters (dispersions and sample-specific means)

Importantly, we want to introduce *known* changes in states across conditions; thus, only replicates from a single condition should go into the simulation. The group to be kept for simulation may be specified via `group_keep`, in which case samples from all other groups (`sce$group_id != group_keep`) will be dropped. By default (`group_keep = NULL`), `prepSim` will select the first group available as reference.

Arguments `min_count`, `min_cells`, `min_genes` and `min_size` are used to tune the filtering of genes, cells and subpopulation-instances as follows:

* only genes with a count `> min_count` in `>= min_cells` will be retained
* only cells with a count `> 0` in `>= min_genes` will be retained
* only subpopulation-sample instances with `>= min_size` cells will be retained; `min_size = NULL` will skip this step

```
# estimate simulation parameters
data(example_sce)
ref <- prepSim(example_sce, verbose = FALSE)
# only samples from `ctrl` group are retained
table(ref$sample_id)
```

```
##
## ctrl101 ctrl107
##     200     200
```

```
# cell parameters: library sizes
sub <- assay(example_sce[rownames(ref), colnames(ref)])
all.equal(exp(ref$offset), as.numeric(colSums(sub)))
```

```
## [1] "names for target but not for current"
## [2] "Mean relative difference: 0.4099568"
```

```
# gene parameters: dispersions & sample-specific means
head(rowData(ref))
```

```
## DataFrame with 6 rows and 4 columns
##                  ENSEMBL      SYMBOL                           beta      disp
##              <character> <character>                    <DataFrame> <numeric>
## ISG15    ENSG00000187608       ISG15 -7.84590:-0.24669929:-1.039483 4.6746813
## AURKAIP1 ENSG00000175756    AURKAIP1 -7.84851: 0.00756976:-1.171916 0.1763071
## MRPL20   ENSG00000242485      MRPL20 -8.31434:-0.58682699:-0.304807 0.6395511
## SSU72    ENSG00000160075       SSU72 -8.05174:-0.17111561:-0.793157 0.0417819
## RER1     ENSG00000157916        RER1 -7.75328: 0.10736552:-1.261843 0.5033909
## RPL22    ENSG00000116251       RPL22 -8.03549:-0.03354337: 0.143460 0.1999982
```

## 1.2 `simData`: Simulating complex designs

Provided with a reference SCE as returned by `prepSim`, a variery of simulation scenarios can be generated using the `simData` function, which will again return an SCE containg the following elements:

* `assay` `counts` containing the simulated count data
* `colData` columns `cluster/sample/group_id` containing each cells cluster, sample, and group ID (A or B).
* `metadata$gene_info` containing a `data.frame` listing, for each gene and cluster
  + the simulationed DD `category`
  + the sampled `logFC`; note that this will only approximate `log2(sim_mean.B/sim_mean.A)` for genes of the `de` category as other types of state changes use mixtures for NBs, and will consequently not exhibit a shift in means of the same magnitude as `logFC`
  + the reference `sim_gene` from which dispersion `sim_disp` and sample-specific means `beta.<sample_id>` were used
  + the simulated expression means `sim_mean.A/B` for each group

In the code chunk that follows, we run a simple simulation with

* `p_dd = c(1,0,...0)`, i.e., 10% of EE genes
* `nk = 3` subpopulations and `ns = 3` replicates for each of 2 groups
* `ng = 1000` genes and `nc = 2000` cells, resulting in `2000/2/ns/nk` \(\approx111\) cells for 2 groups with 3 samples each and 3 subpopulations

```
# simulated 10% EE genes
sim <- simData(ref,
    nc = 2e3, ng = 1e3, force = TRUE,
    p_dd = diag(6)[1, ], nk = 3, ns = 3)
# number of cells per sample and subpopulation
table(sim$sample_id, sim$cluster_id)
```

```
##
##             cluster1 cluster2 cluster3
##   sample1.A      101       93      124
##   sample2.A      108      104      112
##   sample3.A       98      123      108
##   sample1.B      121      133      117
##   sample2.B       99      109      110
##   sample3.B      116      109      115
```

By default, we have drawn a random reference sample from `levels(ref$sample_id)` for every simulated sample in each group, resulting in an unpaired design:

```
metadata(sim)$ref_sids
```

```
##         A         B
## sample1 "ctrl101" "ctrl107"
## sample2 "ctrl101" "ctrl107"
## sample3 "ctrl101" "ctrl107"
```

Alternatively, we can re-run the above simulation with `paired = TRUE` such that both groups will use the same set of reference samples, resulting in a paired design:

```
# simulated paired design
sim <- simData(ref,
    nk = 3, ns = 3, paired = TRUE,
    nc = 2e3, ng = 1e3, force = TRUE)
# same set of reference samples for both groups
ref_sids <- metadata(sim)$ref_sids
all(ref_sids[, 1] == ref_sids[, 2])
```

```
## [1] TRUE
```

### 1.2.1 `p_dd`: Simulating differential distributions

Argument `p_dd` specifies the fraction of cells to simulate for each DD category. Its values should thus lie in \([0,1]\) and sum to 1. Expression densities for an exemplary set of genes simulated from the code below is shown in Fig. [3](#fig:densities).

```
# simulate genes from all DD categories
sim <- simData(ref,
    p_dd = c(0.5, rep(0.1, 5)),
    nc = 2e3, ng = 1e3, force = TRUE)
```

We can retrieve the category assigned to each gene in each cluster from the `gene_info` table stored in the output SCE’s `metadata`:

```
gi <- metadata(sim)$gene_info
table(gi$category)
```

```
##
##  ee  ep  de  dp  dm  db
## 914 224 210 240 196 216
```

![Expression densities for an exemplary set of 3 genes per *differential distribution* category. Each density corresponds to one sample, lines are colored by group ID, and panels are split by gene and subpopulation.](data:image/png;base64...)

Figure 3: Expression densities for an exemplary set of 3 genes per *differential distribution* category
Each density corresponds to one sample, lines are colored by group ID, and panels are split by gene and subpopulation.

### 1.2.2 `rel_lfc`: Simulating cluster-specific state changes

By default, for each gene and subpopulation, we draw a vector of fold changes (FCs) from a Gamma distribution with rate parameter \(\beta\propto\mu\_\text{logFC}\), where \(\mu\_\text{logFC}\) is the desired average logFC across all genes and subpopulations specified via argument `lfc`. This results in state changes that are of same magnitute for each subpopulation.

Now, suppose we wanted to have a subpopulation that does *not* exhibit any state changes across conditions, or vary the magnitute of changes across subpopulations. To this end, argument `rel_lfc` supplies a subpopulation-specific factor applied to the FCs sampled for subpopulation. Fig. [4](#fig:rel-lfc) demonstrates how this manifests in in two-dimensional embeddings of the cells: Here, we generate a set of 3 simulations with

1. equal magnitute of change for all subpopulations: `rel_lfc=c(1,1,1)`
2. stronger change for one cluster: `rel_lfc=c(1,1,3)`
3. cluster-specific FC factors with no change for one cluster: `rel_lfc=c(0,1,2)`

![t-SNEs of exemplary simulations demonstrating `rel_lfc`'s effect to induce cluster-specific state changes. Cells are colored by cluster ID (top-row) and group ID (bottom-row), respectively. From left to right: No cluster-specific changes, stronger change for `cluster3`, different logFC factors for all clusters with no change for `cluster1`.](data:image/png;base64...)

Figure 4: t-SNEs of exemplary simulations demonstrating `rel_lfc`’s effect to induce cluster-specific state changes
Cells are colored by cluster ID (top-row) and group ID (bottom-row), respectively. From left to right: No cluster-specific changes, stronger change for `cluster3`, different logFC factors for all clusters with no change for `cluster1`.

### 1.2.3 `p_type`: Simulating *type* features

The idea underlying *differential state* (DS) analysis to test for subpopulation-specific changes in expression across experimental conditions is based on the idea that we i) use stable moleculare signatures (i.e., *type* features) to group cells into meaningful subpopulations; and, ii) perform statistical tests on *state* features that are more transiently expression and may be subject to changes in expression upon, for example, treatment or during disease.

The fraction of type features introduced into each subpopulation is specified via argument `p_type`. Note that, without introducing any differential states, a non-zero fraction of type genes will result in separation of cells into clusters. Fig. [5](#fig:p-type) demonstrates how increasing values for `p_type` lead to more and more separation of the cells when coloring by cluster ID, but that the lack of state changes leads to homogenous mixing of cells when coloring by group ID.

![t-SNEs of exemplary simulations demonstrating `p_type`'s effect to introduce *type* features. Cells are colored by cluster ID (top-row) and group ID (bottom-row), respectively. The percentage of type features increases from left to right (1, 5, 10%). Simulations are pure EE, i.e., all genes are non-differential across groups.](data:image/png;base64...)

Figure 5: t-SNEs of exemplary simulations demonstrating `p_type`’s effect to introduce *type* features
Cells are colored by cluster ID (top-row) and group ID (bottom-row), respectively. The percentage of type features increases from left to right (1, 5, 10%). Simulations are pure EE, i.e., all genes are non-differential across groups.

## 1.3 Simulation a hierarchical cluster structure

`simData` contains three parameters that control how subpopulations relate to and differ from one another:

1. `p_type` determines the percentage of type genes exclusive to each cluster
2. `phylo_tree` represents a phylogenetic tree specifying of clusters relate to one another
3. `phylo_pars` controls how branch distances are to be interpreted

Note that, when supplied with a cluster phylogeny, argument `nk` is ignored and `simData` extracts the number of clusters to be simulated from `phylo_tree`.

### 1.3.1 `p_type`: Introducing *type* features

To exemplify the effect of the parameter `p_type`, we simulate a dataset with \(\approx5\%\) of type genes per cluster, and one group only via `probs = list(..., c(1, 0)` (i.e., \(\text{Prob}(\textit{cell is in group 2}) = 0\)):

```
# simulate 5% of type genes; one group only
sim <- simData(ref, p_type = 0.1,
    nc = 2e3, ng = 1e3, force = TRUE,
    probs = list(NULL, NULL, c(1, 0)))
# do log-library size normalization
sim <- logNormCounts(sim)
```

For visualizing the above simulation, we select for genes that are of class *type* (`rowData()$class == "type"`) and have a decent simulated expression mean. Furthermore, we sample a subset of cells for each cluster. The resulting heatmap (Fig. [6](#fig:heatmap-type)) shows that the 3 clusters separate well from one another, but that type genes aren’t necessarily expressed higher in a single cluster. This is the case because a gene selected as reference for a type gene in a given cluster may indeed have a lower expression than the gene used for the remainder of clusters.

```
# extract gene metadata & number of clusters
rd <- rowData(sim)
nk <- nlevels(sim$cluster_id)
# filter for type genes with high expression mean
is_type <- rd$class == "type"
is_high <- rowMeans(assay(sim, "logcounts")) > 1
gs <- rownames(sim)[is_type & is_high]
# sample 100 cells per cluster for plotting
cs <- lapply(split(seq_len(ncol(sim)), sim$cluster_id), sample, 100)
plotHeatmap(sim[, unlist(cs)], features = gs, center = TRUE,
    colour_columns_by = "cluster_id", cutree_cols = nk)
```

![Exemplary heatmap demonstrating the effect of `p_type` to introduce cluster-specific *type* genes. Included are type genes (= rows) with a simulated expression mean > 1, and a random subset of 100 cells (= columns) per cluster; column annotations represent cluster IDs. Bins are colored by expression scaled in row direction, and both genes and cells are hierarchically clustered.](data:image/png;base64...)

Figure 6: Exemplary heatmap demonstrating the effect of `p_type` to introduce cluster-specific *type* genes
Included are type genes (= rows) with a simulated expression mean > 1, and a random subset of 100 cells (= columns) per cluster; column annotations represent cluster IDs. Bins are colored by expression scaled in row direction, and both genes and cells are hierarchically clustered.

### 1.3.2 `phylo_tree`: Introducing a cluster phylogeny

The scenario illustrated above is arguably not very realistic. Instead, in a biology setting, subpopulations don’t differ from one another by a specific subset of genes, but may share some of the genes decisive for their biological role. I.e., the set *type* features is not exclusive for every given subpopulation, and some subpopulations are more similar to one another than others.

To introduce a more realistic subpopulation structure, `simData` can be supplied with a phylogenetic tree, `phylo_tree`, that specifies the relationship and distances between clusters. The tree should be written in Newick format as in the following example:

```
# specify cluster phylogeny
tree <- "(('cluster1':0.4,'cluster2':0.4):0.4,('cluster3':
    0.5,('cluster4':0.2,'cluster5':0.2,'cluster6':0.2):0.4):0.4);"
# visualize cluster tree
library(phylogram)
```

```
##
## Attaching package: 'phylogram'
```

```
## The following object is masked from 'package:generics':
##
##     prune
```

```
plot(read.dendrogram(text = tree))
```

![Exemplary phylogeny. The phylogenetic tree specified via `phylo` relates 3 clusters such that there are 2 main branches, and clusters 1 and 2 should be more similar to one another than cluster 3.](data:image/png;base64...)

Figure 7: Exemplary phylogeny
The phylogenetic tree specified via `phylo` relates 3 clusters such that there are 2 main branches, and clusters 1 and 2 should be more similar to one another than cluster 3.

```
# simulate 5% of type genes; one group only
sim <- simData(ref,
    phylo_tree = tree, phylo_pars = c(0.1, 1),
    nc = 800, ng = 1e3, dd = FALSE, force = TRUE)
# do log-library size normalization
sim <- logNormCounts(sim)
```

```
# extract gene metadata & number of clusters
rd <- rowData(sim)
nk <- nlevels(sim$cluster_id)
# filter for type & shared genes with high expression mean
is_type <- rd$class != "state"
is_high <- rowMeans(assay(sim, "logcounts")) > 1
gs <- rownames(sim)[is_type & is_high]
# sample 100 cells per cluster for plotting
cs <- lapply(split(seq_len(ncol(sim)), sim$cluster_id), sample, 50)
plotHeatmap(sim[, unlist(cs)], features = gs,
    center = TRUE, show_rownames = FALSE,
    colour_columns_by = "cluster_id")
```

![Exemplary heatmap demonstrating the effect of `phylo_tree` to introduce a hierarchical cluster structure. Included are 100 randomly sampled non-state, i.e. type or shared, genes (= rows) with a simulated expression mean > 1, and a random subset of 100 cells (= columns) per cluster; column annotations represent cluster IDs. Bins are colored by expression scaled in row direction, and both genes and cells are hierarchically clustered.](data:image/png;base64...)

Figure 8: Exemplary heatmap demonstrating the effect of `phylo_tree` to introduce a hierarchical cluster structure
Included are 100 randomly sampled non-state, i.e. type or shared, genes (= rows) with a simulated expression mean > 1, and a random subset of 100 cells (= columns) per cluster; column annotations represent cluster IDs. Bins are colored by expression scaled in row direction, and both genes and cells are hierarchically clustered.

## 1.4 Simulating batch effects

> under development.

# 2 Quality control

As is the case with any simulation, it is crutial to verify the qualitation of the simulated data; i.e., how well key characteristics of the reference data are captured in the simulation. While we have demonstrated that `muscat`s simulation framework is capable of reproducing key features of scRNA-seq dataset at both the single-cell and pseudobulk level (**???**), simulation quality will vary depending on the reference dataset and could suffer from too extreme simulation parameters. Therefore, we advise anyone interested in using the framework presented herein for any type of method evaluation or comparison to generate *[countsimQC](https://bioconductor.org/packages/3.22/countsimQC)* report (Soneson and Robinson [2018](#ref-Soneson2018-countsimQC)) as it is extremly simple to make and very comprehensive.

The code chunk below (not evaluated here) illustrates how to generate a report comparing an exemplary `simData` simulation with the reference data provided in `ref`. Runtimes are mainly determined by argument `maxNForCorr` and `maxNForDisp`, and computing a full-blown report can be *very* time intensive. We thus advice using a sufficient but low number of cells/genes for these steps.

```
# load required packages
library(countsimQC)
library(DESeq2)
# simulate data
sim <- simData(ref,
    ng = nrow(ref),
    nc = ncol(ref),
    dd = FALSE)
# construct 'DESeqDataSet's for both,
# simulated and reference dataset
dds_sim <- DESeqDataSetFromMatrix(
    countData = counts(sim),
    colData = colData(sim),
    design = ~ sample_id)
dds_ref <- DESeqDataSetFromMatrix(
    countData = counts(ref),
    colData = colData(ref),
    design = ~ sample_id)
dds_list <- list(sim = dds_sim, data = dds_ref)
# generate 'countsimQC' report
countsimQCReport(
    ddsList = dds_list,
    outputFile = "<file_name>.html",
    outputDir = "<output_path>",
    outputFormat = "html_document",
    maxNForCorr = 200,
    maxNForDisp = 500)
```

# 3 Method benchmarking

A variety of functions for calculation and visualizing performance metrics for evaluation of ranking and binary classification (assignment) methods is provided in the *[iCOBRA](https://bioconductor.org/packages/3.22/iCOBRA)* package (Soneson and Robinson [2016](#ref-Soneson2016-iCOBRA)).

We firstly define a wrapper that takes as input a `method` passed `pbDS` and reformats the results as a `data.frame` in tidy format, which is in turn `right_join`ed with simulation gene metadata. As each methods may return results for different subsets of gene-subpopulation instances, the latter steps assures that the dimensions of all method results will match.

```
# 'm' is a character string specifying a valid `pbDS` method
.run_method <- function(m) {
    res <- pbDS(pb, method = m, verbose = FALSE)
    tbl <- resDS(sim, res)
    left_join(gi, tbl, by = c("gene", "cluster_id"))
}
```

Having computed result `data.frame`s for a set of methods, we next define a wrapper that prepares the data for evaluation with `iCOBRA` using the `COBRAData` constructor, and calculates any performance measures of interest (specified via `aspects`) with `calculate_performance`:

```
# 'x' is a list of result 'data.frame's
.calc_perf <- function(x, facet = NULL) {
    cd <- COBRAData(truth = gi,
        pval = data.frame(bind_cols(map(x, "p_val"))),
        padj = data.frame(bind_cols(map(x, "p_adj.loc"))))
    perf <- calculate_performance(cd,
        binary_truth = "is_de", maxsplit = 1e6,
        splv = ifelse(is.null(facet), "none", facet),
        aspects = c("fdrtpr", "fdrtprcurve", "curve"))
}
```

Putting it all together, we can finally simulate some data, run a set of DS analysis methods, calculate their performance, and plot a variety of performance metrics depending on the `aspects` calculated by `.calc_perf`:

```
# simulation with all DD types
sim <- simData(ref,
    p_dd = c(rep(0.3, 2), rep(0.1, 4)),
    ng = 1e3, nc = 2e3, ns = 3, force = TRUE)
# aggregate to pseudobulks
pb <- aggregateData(sim)
# extract gene metadata
gi <- metadata(sim)$gene_info
# add truth column (must be numeric!)
gi$is_de <- !gi$category %in% c("ee", "ep")
gi$is_de <- as.numeric(gi$is_de)

# specify methods for comparison & run them
# (must set names for methods to show in visualizations!)
names(mids) <- mids <- c("edgeR", "DESeq2", "limma-trend", "limma-voom")
res <- lapply(mids, .run_method)

# calculate performance measures
# and prep. for plotting with 'iCOBRA'
library(iCOBRA)
perf <- .calc_perf(res, "cluster_id")
pd <- prepare_data_for_plot(perf)

# plot FDR-TPR curves by cluster
plot_fdrtprcurve(pd,
    linewidth = 0.8, pointsize = 2) +
    facet_wrap(~ splitval, nrow = 1) +
    scale_x_continuous(trans = "sqrt") +
    theme(aspect.ratio = 1)
```

![](data:image/png;base64...)

# Session info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] iCOBRA_1.38.0               phylogram_2.1.0
##  [3] reshape2_1.4.4              tidyr_1.3.1
##  [5] UpSetR_1.4.0                scater_1.38.0
##  [7] scuttle_1.20.0              muscData_1.23.0
##  [9] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           ExperimentHub_3.0.0
## [19] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [21] dbplyr_2.5.1                BiocGenerics_0.56.0
## [23] generics_0.1.4              purrr_1.1.0
## [25] muscat_1.24.0               limma_3.66.0
## [27] ggplot2_4.0.0               dplyr_1.1.4
## [29] cowplot_1.2.0               patchwork_1.3.2
## [31] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] bitops_1.0-9             httr_1.4.7               RColorBrewer_1.1-3
##   [4] doParallel_1.0.17        numDeriv_2016.8-1.1      tools_4.5.1
##   [7] sctransform_0.4.2        backports_1.5.0          R6_2.6.1
##  [10] DT_0.34.0                uwot_0.2.3               mgcv_1.9-3
##  [13] GetoptLong_1.0.5         withr_3.0.2              prettyunits_1.2.0
##  [16] gridExtra_2.3            fdrtool_1.2.18           cli_3.6.5
##  [19] Cairo_1.7-0              sandwich_3.1-1           labeling_0.4.3
##  [22] slam_0.1-55              sass_0.4.10              mvtnorm_1.3-3
##  [25] S7_0.2.0                 blme_1.0-6               dichromat_2.0-0.1
##  [28] parallelly_1.45.1        RSQLite_2.4.3            shape_1.4.6.1
##  [31] gtools_3.9.5             Matrix_1.7-4             ggbeeswarm_0.7.2
##  [34] abind_1.4-8              lifecycle_1.0.4          multcomp_1.4-29
##  [37] yaml_2.3.10              edgeR_4.8.0              gplots_3.2.0
##  [40] SparseArray_1.10.0       Rtsne_0.17               grid_4.5.1
##  [43] blob_1.2.4               promises_1.4.0           crayon_1.5.3
##  [46] shinydashboard_0.7.3     lattice_0.22-7           beachmat_2.26.0
##  [49] KEGGREST_1.50.0          magick_2.9.0             pillar_1.11.1
##  [52] knitr_1.50               ComplexHeatmap_2.26.0    rjson_0.2.23
##  [55] boot_1.3-32              estimability_1.5.1       corpcor_1.6.10
##  [58] future.apply_1.20.0      codetools_0.2-20         glue_1.8.0
##  [61] data.table_1.17.8        vctrs_0.6.5              png_0.1-8
##  [64] Rdpack_2.6.4             gtable_0.3.6             cachem_1.1.0
##  [67] xfun_0.53                rbibutils_2.3            S4Arrays_1.10.0
##  [70] mime_0.13                coda_0.19-4.1            reformulas_0.4.2
##  [73] survival_3.8-3           pheatmap_1.0.13          iterators_1.0.14
##  [76] tinytex_0.57             statmod_1.5.1            TH.data_1.1-4
##  [79] ROCR_1.0-11              nlme_3.1-168             pbkrtest_0.5.5
##  [82] bit64_4.6.0-1            progress_1.2.3           EnvStats_3.1.0
##  [85] filelock_1.0.3           RcppAnnoy_0.0.22         bslib_0.9.0
##  [88] TMB_1.9.18               irlba_2.3.5.1            vipor_0.4.7
##  [91] KernSmooth_2.23-26       otel_0.2.0               colorspace_2.1-2
##  [94] DBI_1.2.3                DESeq2_1.50.0            tidyselect_1.2.1
##  [97] emmeans_2.0.0            bit_4.6.0                compiler_4.5.1
## [100] curl_7.0.0               httr2_1.2.1              BiocNeighbors_2.4.0
## [103] DelayedArray_0.36.0      bookdown_0.45            scales_1.4.0
## [106] caTools_1.18.3           remaCor_0.0.20           rappdirs_0.3.3
## [109] stringr_1.5.2            digest_0.6.37            shinyBS_0.61.1
## [112] minqa_1.2.8              variancePartition_1.40.0 rmarkdown_2.30
## [115] aod_1.3.3                XVector_0.50.0           RhpcBLASctl_0.23-42
## [118] htmltools_0.5.8.1        pkgconfig_2.0.3          lme4_1.1-37
## [121] lpsymphony_1.38.0        fastmap_1.2.0            htmlwidgets_1.6.4
## [124] rlang_1.1.6              GlobalOptions_0.1.2      stageR_1.32.0
## [127] shiny_1.11.1             farver_2.1.2             jquerylib_0.1.4
## [130] IHW_1.38.0               zoo_1.8-14               jsonlite_2.0.0
## [133] BiocParallel_1.44.0      BiocSingular_1.26.0      magrittr_2.0.4
## [136] Rcpp_1.1.0               ape_5.8-1                viridis_0.6.5
## [139] stringi_1.8.7            MASS_7.3-65              plyr_1.8.9
## [142] parallel_4.5.1           listenv_0.9.1            ggrepel_0.9.6
## [145] Biostrings_2.78.0        splines_4.5.1            hms_1.1.4
## [148] circlize_0.4.16          locfit_1.5-9.12          ScaledMatrix_1.18.0
## [151] BiocVersion_3.22.0       evaluate_1.0.5           BiocManager_1.30.26
## [154] nloptr_2.2.1             foreach_1.5.2            httpuv_1.6.16
## [157] future_1.67.0            clue_0.3-66              rsvd_1.0.5
## [160] broom_1.0.10             xtable_1.8-4             fANCOVA_0.6-1
## [163] later_1.4.4              viridisLite_0.4.2        tibble_3.3.0
## [166] lmerTest_3.1-3           glmmTMB_1.1.13           memoise_2.0.1
## [169] beeswarm_0.4.0           AnnotationDbi_1.72.0     cluster_2.1.8.1
## [172] globals_0.18.0
```

# References

Kang, Hyun Min, Meena Subramaniam, Sasha Targ, Michelle Nguyen, Lenka Maliskova, Elizabeth McCarthy, Eunice Wan, et al. 2018. “Multiplexed Droplet Single-Cell RNA-sequencing Using Natural Genetic Variation.” *Nature Biotechnology* 36 (1): 89–94.

Korthauer, Keegan D, Li-Fang Chu, Michael A Newton, Yuan Li, James Thomson, Ron Stewart, and Christina Kendziorski. 2016. “A Statistical Approach for Identifying Differential Distributions in Single-Cell RNA-seq Experiments.” *Genome Biology* 17 (1): 222.

Soneson, Charlotte, and Mark D Robinson. 2016. “iCOBRA: Open, Reproducible, Standardized and Live Method Benchmarking.” *Nature Methods* 13 (4): 283.

———. 2018. “Towards Unified Quality Verification of Synthetic Count Data with countsimQC.” *Bioinformatics* 34 (4): 691–92.