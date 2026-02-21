# Celaref Manual

#### Sarah Williams

#### 2025-10-29

* [Overview](#overview)
  + [Workflow](#workflow)
    - [Prepare dataset](#prepare-dataset)
    - [Within dataset differential expression](#within-dataset-differential-expression)
    - [Query-Reference comparison](#query-reference-comparison)
  + [Output](#output)
    - [Interpreting output](#interpreting-output)
    - [Assigning labels to clusters](#assigning-labels-to-clusters)
* [Using the package](#using-the-package)
  + [Installation](#installation)
  + [Quickstart](#quickstart)
  + [Prepare data](#input)
    - [Input data](#input-data)
      * [From tables or flat files](#from-tables-or-flat-files)
      * [From 10X pipeline output](#from-10x-pipeline-output)
      * [Directly with SummarizedExperiment objects](#directly-with-summarizedexperiment-objects)
      * [Handling large datasets](#handling-large-datasets)
      * [Reading microarray data](#reading-microarray-data)
    - [Input filtering and Pre-processing](#input-filtering-and-pre-processing)
      * [Filtering cells and low-expression genes](#filtering)
      * [Converting IDs](#converting-ids)
    - [Within-experiment differential expression](#prepare-data-with-within-experiment-differential-expression)
  + [Running comparisions](#Making-comparisons-to-reference-data)
    - [Compare groups to reference](#compare-groups-to-reference)
    - [Compare groups within a single dataset](#compare-groups-within-a-single-dataset)
    - [Make labels for groups](#make-labels-for-groups)
    - [Special case: Saving get\_the\_up\_genes\_for\_all\_possible\_groups output](#Special-case:-Saving-get_the_up_genes_for_all_possible_groups-output)
* [Example Analyses](#example-analyses)
  + [PBMCs - 10X vs Microarray Reference](#pbmcs---10x-vs-microarray-reference)
    - [Prepare 10X query dataset](#prepare-10x-query-dataset)
    - [Prepare reference microarray dataset](#prepare-reference-microarray-dataset)
    - [Compare 10X query PBMCs to to reference](#compare-10x-query-pbmcs-to-to-reference)
  + [Mouse tissues - Similar and different](#mouse-tissues---similar-and-different)
    - [Load and compare mouse brain datasets](#load-and-compare-mouse-brain-datasets)
    - [Load lacrimal gland dataset](#load-lacrimal-gland-dataset)
    - [Cross-tissue comparision](#cross-tissue-comparision)
* [Session Info](#session-info)
* [References](#references)

# Overview

Single cell RNA sequencing (scRNAseq) has made it possible to examine the cellular heterogeneity within a tissue or sample, and observe changes and characteristics in specific cell types. To do this, we need to group the cells into clusters and figure out what they are.

In a typical scRNAseq experiment the gene expression levels are first quantified to per-cell counts. Then, cells are clustered into related groups (or clusters) on the basis of transcriptional similarity. There are many different cell-clustering tools that can do this (Freytag et al. 2017).

Clustering tools generally define groups of similar cells - but do not offer explanation as to their biological contents. The annotation of the ‘cell type’ of each cluster is performed by a domain expert biologist - who can examine the known marker genes, or differential expression to understand what type of cell each cluster might describe. This can be a time-consuming semi-manual process, and must be performed before addressing the actual biological question of interest.

The celaref package aims to streamline this cell-type identification step, by suggesting cluster labels on the basis of similarity to an already-characterised reference dataset - whether that’s from a similar experiment performed previously in the same lab, or from a public dataset from a similar sample.

Celaref differs from other cell-type identification tools like scmap (Kiselev, Yiu, and Hemberg 2018) or (functions in) [MUDAN](https://github.com/JEFworks/MUDAN) in that it operates at the cluster-level.

Celaref requires a table of read counts per cell per gene, and a list of the cells belonging to each of the clusters, (for both test and reference data). It compares the reference sample rankings of the most distinctly enriched genes in each query group to match cell types.

## Workflow

A typical celaref workflow is below, characterising a query dataset’s cell clusters on the basis of transcriptomic similarity to a annotated reference dataset.

![](data:image/png;base64...)

### Prepare dataset

To compare scRNAseq datasets with celaref, two inputs are needed for each dataset:

1. A counts matrix of number of reads per gene, per cell.

| gene | Cell1 | cell2 | cell3 | cell4 | … | cell954 |
| --- | --- | --- | --- | --- | --- | --- |
| GeneA | 0 | 1 | 0 | 1 | … | 0 |
| GeneB | 0 | 3 | 0 | 2 | … | 2 |
| GeneC | 1 | 40 | 1 | 0 | … | 0 |

2. Cluster assignment for each cell.

| CellId | Cluster |
| --- | --- |
| cell1 | cluster1 |
| cell2 | cluster7 |
| … | … |
| cell954 | cluster8 |

See [Input](#input) for details.

Cell clusters might be defined by any cell-clustering technique, such as those implemented in tools such as Seurat (Satija et al. 2015), cellRanger (10X genomics), SC3(Kiselev et al. 2017), among many others.

### Within dataset differential expression

Every dataset, whether a query or a reference, is prepared the same way. For each cluster, cells within that cluster are compared to the rest of the cells pooled together, calculating differential gene expression using MAST (Finak et al. 2015). Because of the low counts and potential drop-out issues in single cell RNAseq data, only genes enriched in each cluster are considered. For every cluster – cells are ranked from most to least enriched according to their lower 95% CI of fold-change. Each gene is assigned a ‘rescaled rank’ from 0 (most enriched) to 1 (most absent).

That this step is the most time consuming, but only needs to be done once per dataset.

### Query-Reference comparison

A list of ‘Up’ genes are extracted for each query cluster – defined as those that have significantly higher expression in that cluster versus the rest of the sample (p<0.01 after BH multiple hypothesis correction). The ‘Up’ gene list is capped at the top 100 (ranked by lower 95% FC). Then, those genes are looked up in the ranking of genes in each reference cell cluster. The distribution of these ‘up gene’ ranks is plotted to evaluate similarity of the query cell-group to a reference cell-group.

Output plots are described [here](#output).

## Output

### Interpreting output

Typically, every cell cluster in the query data (each box) is plotted against everything in the reference data (X-axis). Each of the ‘up’ genes is represented by a tick mark, and the median generank is shown as a thick bar. A biased distribution near the top (i.e.. rescaled rank of 0) indicates similarity of the groups – essentially the same genes are representative of the clusters within their respective samples.

![](data:image/png;base64...)

* A median gene rank of 0.5 would indicate a completely random distribution. However, much lower values are common. The reciprocal nature of the within-dataset differential expression can cause this - what’s up in one cluster is down in another.
* A small or heterogeneous cell group will not have much statistical power to select many ‘top’ genes (few tick marks) and these distributions will not be particuarly informative. If there are no ‘top’ genes it won’t be plotted at all.
* Because ‘top’ genes are compared to total reference rankings - the comparison between two datasets is not symmetrical. In ambiguous cases, it might helpful to plot the reverse comparison from reference to query. Note that these receiprocal comparisons are considered in [Assigning labels to clusters](#assigning-labels-to-clusters). For instance - if a query cluster happens to be a mix of two reference cell groups, a reciprocal plot may make this more obvious.

### Assigning labels to clusters

Lastly, there is a function to suggest some semi-sensible query cluster labels.

The first 4 columns of output (below) are the most interesting, the rest are described at bottom of section. The suggested cluster label is in the **shortlab** column. e.g.

| test\_group | shortlab | pval | stepped\_pvals |
| --- | --- | --- | --- |
| cluster\_1 | cluster\_1:astrocytes\_ependymal | 2.98e-23 | astrocytes\_ependymal:2.98e-23,microglia:0.208,interneurons:0.1,pyramidal SS:0.455,endothelial-mural:0.0444,oligodendrocytes:NA |
| cluster\_2 | cluster\_2:endothelial-mural | 8.44e-10 | endothelial-mural:8.44e-10,microglia:2.37e-06,astrocytes\_ependymal:0.000818,interneurons:0.435,oligodendrocytes:0.245,pyramidal SS:NA |
| cluster\_3 | cluster\_3:no\_similarity | NA | astrocytes\_ependymal:0.41,microglia:0.634,oligodendrocytes:0.305,endothelial-mural:0.512,interneurons:0.204,pyramidal SS:NA |
| cluster\_4 | cluster\_4:microglia | 2.71e-19 | microglia:2.71e-19,interneurons:0.435,pyramidal SS:0.11,endothelial-mural:0.221,astrocytes\_ependymal:0.627,oligodendrocytes:NA |
| cluster\_5 | cluster\_5:pyramidal SS|interneurons | 3.49e-10 | pyramidal SS:0.362,interneurons:3.49e-10,endothelial-mural:0.09,astrocytes\_ependymal:0.0449,microglia:7.68e-19,oligodendrocytes:NA |
| cluster\_6 | cluster\_6:oligodendrocytes | 2.15e-28 | oligodendrocytes:2.15e-28,interneurons:0.624,astrocytes\_ependymal:0.207,endothelial-mural:0.755,microglia:0.0432,pyramidal SS:NA |

There can be none, one or multiple reference group similarities for the query group. This is expected when there are similar cell sub-populations in the reference data. This can be visualised throught the relative shapes of the top gene distribution for the reference group, and reference group similarity labels are calculated as follows:

These labels are based on the distributions of the ranks of the query cluster’s ‘top’ genes in each of the reference groups (as plotted in the [violin plots](#interpreting-output)), rescaled to be in the 0-1 range.

1. The median gene rank for the ‘top’ genes in each reference group is calculated.
2. Reference groups are ordered from most to least similar (ascending median rank).
3. Mann-Whitney U tests are calculated between the adjacent reference groups - ie. 1st-2nd most similar, 2nd-3rd, 3rd-4th e.t.c. These are the **stepped\_pvals** reported above - the last value will always be undefined NA. Essentially this is testing if the ‘top’ genes representative of the query group are significantly lower ranked (more similar) in one reference group vs the next most similar reference group. A genuine similarity of cell types should result in an abrupt change in these gene rank distributions.
4. Initial calls are made on which reference groups to include in the group label.

   * 1. If there is a significant difference (p < 0.01) between the first and second most similar groups - report on the top ranked reference group. The **pval** in this case will be the first stepped pvalue (which is significant).
   * 2. If there are no significant differences between any steps, report a lack of similarity. No p-value (NA) is reported - because no call could be made on what group(s) are more similar. Check the stepped\_pvals to look at borderline cases.
   * 3. Otherwise, start at the most similar reference group, and report everything up to the first signifcantly different ranking. Effectively, this reports multiple reference group similarities when a call can’t be made between them e.g. subtypes, or a mixed query group. Here the reported **pval** describes the ‘jump’ between the bottom ranked similar reference group, and the first of the other groups. e.g. the 2nd or 3rd stepped pvalue.
5. The group assignment from step 4 is checked to ensure that the (median of the) gene ranks is significantly above a random distribution. Ie. above the 0.5 halfway point in the violin plots.

   * The distribution of the ‘top’ genes in the matched group (or last-ranked matching group when there are multiple matches) is tested to see if its median rank is significantly above 0.5 (sign test, using one-tailed binomial test on ranks < 0.5). If this fails (<0.01), ‘No\_similarity’ will be reported, even if the p-value is significant. See Group1 and Group2 results in the quickstart example (occurs due to being only a 200 gene test). \*B: This means that a significant ‘pval’ column can sometime occur on a ‘No\_similarity’ label - but the pval\_vs\_random column (described below) will be non-significant.
   * This test exists for cases of significant difference from an ‘anti-some-other-celltype’ signature with genes distributed at the low end. That can occur when there are uneven gene cluster sizes and no genuine match for the query.
6. Reciprocal-only matches are added to cluster labels in brackets.

   * e.g. c1:celltypeA(celltypeB) or c2:(celltypeC)
   * The cluster groups are reciprocally tested against the query groups. All reciprocal matches are listed in the *reciprocal\_matches* column. If there is a recriprocal match that isn’t in the query->ref match list, its added on to the end of the cluster label.
   * Reciprocal matches reported in the cluster names might indicate a mixed query cell type. It woudl be a good idea to look at the reciprocalviolin plot of the reference dataset vs the query.

---

The full version of this table is:

| test\_group | shortlab | pval | stepped\_pvals | pval\_to\_random | matches | reciprocal\_matches | similar\_non\_match | similar\_non\_match\_detail | differences\_within |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| astrocytes | astrocytes:astrocytes\_ependymal | 2.98e-23 | astrocytes\_ependymal:2.98e-23,microglia:0.208,interneurons:0.1,pyramidal SS:0.455,endothelial-mural:0.0444,oligodendrocytes:NA | 1.00e-21 | astrocytes\_ependymal | astrocytes\_ependymal |  |  |  |
| endothelial | endothelial:endothelial-mural | 8.44e-10 | endothelial-mural:8.44e-10,microglia:2.37e-06,astrocytes\_ependymal:0.000818,interneurons:0.435,oligodendrocytes:0.245,pyramidal SS:NA | 3.55e-21 | endothelial-mural | endothelial-mural |  |  |  |
| hybrid | hybrid:No similarity |  | astrocytes\_ependymal:0.41,microglia:0.634,oligodendrocytes:0.305,endothelial-mural:0.512,interneurons:0.204,pyramidal SS:NA |  |  |  |  |  |  |
| microglia | microglia:microglia | 2.71e-19 | microglia:2.71e-19,interneurons:0.435,pyramidal SS:0.11,endothelial-mural:0.221,astrocytes\_ependymal:0.627,oligodendrocytes:NA | 3.54e-16 | microglia | microglia |  |  |  |
| neurons | neurons:pyramidal SS|interneurons | 3.49e-10 | pyramidal SS:0.362,interneurons:3.49e-10,endothelial-mural:0.09,astrocytes\_ependymal:0.0449,microglia:7.68e-19,oligodendrocytes:NA | 2.19e-12 | pyramidal SS|interneurons | interneurons|pyramidal SS |  |  |  |
| oligodendrocytes | oligodendrocytes:oligodendrocytes | 2.15e-28 | oligodendrocytes:2.15e-28,interneurons:0.624,astrocytes\_ependymal:0.207,endothelial-mural:0.755,microglia:0.0432,pyramidal SS:NA | 4.72e-20 | oligodendrocytes | oligodendrocytes |  |  |  |

The next few columns of the ouput describe some of the heuristics used in the cluster labelling.

* **pval\_to\_random** : P-value of test of median rank (of last matched reference group) < random, from binomial test on top gene ranks (<0.5). If this isn’t signiicant, ‘No similarity’ will be reported. A completely random distribution would have a median rank in the middle of the violin plots, at 0.5.
* **matches** : List of all reference groups that ‘match’, as described, except it also includes (rare) examples where pval\_to\_random is not significant. “|” separated, in descending order of match.
* **reciprocal\_matches** : List of all reference groups that flagged test group as a match when directon of comparison is reversed. (significant pval and pval\_to\_random). “|” separated, in descending order of match.

---

The last 3 columns of the output are usually empty. When defined they may indicate borderline labelling or edge cases - checking the violin plots is advised! Tests are again Mann-Whitney U, but on non-adjacently ranked groups.

* **similar\_non\_match** : This column lists any reference groups outside of the reported label match that are not signifcantly different to a reported match group. E.g If a query matches group A (because A is significantly different to the second-ranked B); if A is then not significantly different to the third -ranked C, then C will be reported here. This is more likely with smaller sets of ‘top genes’, for instance in Group3 of the quickstart example. Examples:
  + NA [Nothing]
  + C
  + microglia|interneurons
* **similar\_non\_match\_detail**: P-values for any details about similar\_non\_match results. These p-values will always be non-significant (but again may be borderline). Examples:
  + NA [Nothing]
  + A > C (p=0.0214,n.s)
  + dunno > Exciting (p=0.0104,n.s)
* **differences\_within**: This feild lists any pairs of matched groups (in shortlab) that are significantly different. This could happen if there are many matched groups listed in shortlab, that are all slightly different. Examples
  + NA [Nothing]
  + B > E (p=0.004)|C > E (p=0.009)

# Using the package

## Installation

The bioconductor landing page with information about this package is at <https://bioconductor.org/packages/celaref>

To install from bioconductor via BiocManager

```
# Installing BiocManager if necessary:
# install.packages("BiocManager")
BiocManager::install("celaref")
```

Or, to use the dev version from github

```
devtools::install_github("MonashBioinformaticsPlatform/celaref")
# Or
BiocManager::install("MonashBioinformaticsPlatform/celaref")
```

## Quickstart

Suppose there’s a new scRNAseq dataset (the query), whose cells have already been clustered into 4 groups : Groups 1-4. But we don’t know which group corresponds to which cell type yet.

Luckily, there’s an older dataset (the reference) of the same tissue type in which someone else has already determined the cell types. They very helpfully named them ‘Weird subtype’, ‘Exciting’, ‘Mystery cell type’ and ‘Dunno’.

This example uses the reference dataset to flag likely cell types in the new experiment.

It is a tiny simulated dataset (using splatter (Zappia, Phipson, and Oshlack 2017)) of 200 genes included in the package that can be copy-pasted, and will complete fairly quickly.

```
library(celaref)

# Paths to data files.
counts_filepath.query    <- system.file("extdata", "sim_query_counts.tab",    package = "celaref")
cell_info_filepath.query <- system.file("extdata", "sim_query_cell_info.tab", package = "celaref")
counts_filepath.ref      <- system.file("extdata", "sim_ref_counts.tab",      package = "celaref")
cell_info_filepath.ref   <- system.file("extdata", "sim_ref_cell_info.tab",   package = "celaref")

# Load data
toy_ref_se   <- load_se_from_files(counts_file=counts_filepath.ref, cell_info_file=cell_info_filepath.ref)
toy_query_se <- load_se_from_files(counts_file=counts_filepath.query, cell_info_file=cell_info_filepath.query)

# Filter data
toy_ref_se     <- trim_small_groups_and_low_expression_genes(toy_ref_se)
toy_query_se   <- trim_small_groups_and_low_expression_genes(toy_query_se)

# Setup within-experiment differential expression
de_table.toy_ref   <- contrast_each_group_to_the_rest(toy_ref_se,    dataset_name="ref")
de_table.toy_query <- contrast_each_group_to_the_rest(toy_query_se,  dataset_name="query")
```

```
# Plot
make_ranking_violin_plot(de_table.test=de_table.toy_query, de_table.ref=de_table.toy_ref)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the celaref package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `fun.y` argument of `stat_summary()` is deprecated as of ggplot2 3.3.0.
#> ℹ Please use the `fun` argument instead.
#> ℹ The deprecated feature was likely used in the celaref package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `fun.ymin` argument of `stat_summary()` is deprecated as of ggplot2 3.3.0.
#> ℹ Please use the `fun.min` argument instead.
#> ℹ The deprecated feature was likely used in the celaref package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `fun.ymax` argument of `stat_summary()` is deprecated as of ggplot2 3.3.0.
#> ℹ Please use the `fun.max` argument instead.
#> ℹ The deprecated feature was likely used in the celaref package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

```
# And get group labels
make_ref_similarity_names(de_table.toy_query, de_table.toy_ref)
```

| test\_group | shortlab | pval | stepped\_pvals | pval\_to\_random | matches | reciprocal\_matches | similar\_non\_match | similar\_non\_match\_detail | differences\_within |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Group1 | Group1:No similarity | 6.09e-03 | Weird subtype:0.00609,Dunno:0.173,Exciting:0.0301,Mystery celltype:NA | 3.12e-02 | Weird subtype |  | NA | NA | NA |
| Group2 | Group2:No similarity | 5.14e-03 | Exciting:0.00514,Weird subtype:0.115,Dunno:0.188,Mystery celltype:NA | 1.56e-02 | Exciting |  | NA | NA | NA |
| Group3 | Group3:Dunno | 1.20e-04 | Dunno:0.00012,Weird subtype:0.442,Exciting:0.00805,Mystery celltype:NA | 3.05e-05 | Dunno | Dunno | NA | NA | NA |
| Group4 | Group4:Mystery celltype | 7.94e-05 | Mystery celltype:7.94e-05,Weird subtype:0.17,Exciting:0.384,Dunno:NA | 4.88e-04 | Mystery celltype | Mystery celltype | NA | NA | NA |

NB: Groups1 and Group2 are not labelled due to the non-significant ‘pval\_to\_random’ (see section [Assigning labels to clusters](#assigning-labels-to-clusters) ). This happens here because its a small 200-gene toy dataset!

## Prepare data

The celaref package works with datasets in ‘SummarizedExperiment’ objects. While they can be constructed manually there are several functions (below) to create them in a format with all the required information.

The following pieces of information are needed to use a single cell RNAseq dataset with celaref.

1. **Counts Matrix** Number of gene tags per gene per cell.
2. **Cell information** A sample-sheet table of cell-level information. Only two fields are essential:
   * *cell\_sample*: A unique cell identifier
   * *group*: The cluster/group to which the cell has been assigned.
3. **Gene information** Optional. A table of extra gene-level information.
   * *ID*: A unique gene identifier

The cell information tables can contain whatever experimentally relevant data is desired, like treatment, batches, individual e.t.c

The celaref package doesn’t do any clustering itself - cells should have already been assigned to cluster groups on the basis of transcriptional similarity using one of the many single-cell clustering tools available (For a evaluation of some clustering tools: (Freytag et al. 2017)). Note that any cells not assigned to a group will not be processed.

For a querying dataset clusters will of course have arbitrary names like c1,c2,c3 e.t.c but for reference datasets they should be something meaningful (e.g. ‘macrophages’).

Providing gene-level information is entirely optional, because it can be taken from the counts matrix. It is useful for tracking multiple IDs, see [Converting IDs](#converting-ids)

### Input data

#### From tables or flat files

The simplest way to load data is with two files.

1. A tab-delimited counts matrix:

| gene | Cell1 | cell2 | cell3 | cell4 | … | cell954 |
| --- | --- | --- | --- | --- | --- | --- |
| GeneA | 0 | 1 | 0 | 1 | … | 0 |
| GeneB | 0 | 3 | 0 | 2 | … | 2 |
| GeneC | 1 | 40 | 1 | 0 | … | 0 |

2. And a tab-delimited cell info / sample-sheet file of cell-level information, including the group assignment for each cell (‘Cluster’), and any other useful information.

| CellId | Sample | Cluster |
| --- | --- | --- |
| cell1 | Control | cluster1 |
| cell2 | Control | cluster7 |
| … | … | … |
| cell954 | KO | cluster8 |

This example dataset would be loaded with *load\_se\_from\_files*:

```
dataset_se <- load_se_from_files(counts_matrix   = "counts_matrix_file.tab",
                                  cell_info_file = "cell_info_file.tab",
                                  group_col_name = "Cluster")
```

Note the specification of the ‘Cluster’ column as the *group\_col\_name*. Internally, (and throughout this doco), there are references to the ‘cell\_sample’ and ‘group’ columns. They can use these exact names in the input tables, or be assumed or specified when loaded.

The following command does exactly the same thing, but explicitly specifies the cell identifier as ‘CellId’. If *cell\_col\_name* is omitted, it is assumed to be the first column of the cell info table.

```
dataset_se <- load_se_from_files(counts_matrix   = "counts_matrix_file.tab",
                                  cell_info_file = "cell_info_file.tab",
                                  group_col_name  = "Cluster",
                                  cell_col_name   = "CellId" )
```

If cell information is missing (from cell info or from the counts), the cell will just be dropped from the analysis. This is useful when excluding cells or subsetting the analysis - it is enough to remove entries from the cell info table before loading. When this happens a warning message displays the number of cells kept.

---

Optionally, a third file, with gene-level information might be included.

| Gene | NiceName |
| --- | --- |
| GeneA | NiceNameA |
| GeneB | NiceNameB |
| GeneC | NiceNameC |

```
dataset_se <- load_se_from_files(counts_matrix   = "counts_matrix_file.tab",
                                  cell_info_file = "cell_info_file.tab",
                                  gene_info_file = "gene_info_file.tab",
                                  group_col_name = "Cluster")
```

If extra gene information is provided, the first column (or a column named ‘ID’) must be unique. Every gene in the counts matrix must have an entry in the gene info table, and vice versa.

---

Alternatively, if the data is already loaded into R, the *load\_se\_from\_tables* function will accept data frames instead of filenames. The *load\_se\_from\_files* function is just a wrapper for *load\_se\_from\_tables*.

```
dataset_se <- load_se_from_tables(counts_matrix   = counts_matrix,
                                  cell_info_table = cell_info_table,
                                  group_col_name  = "Cluster")
```

#### From 10X pipeline output

The 10X cellRanger pipelines produce a directory of output including the counts matrix files and several different clusters. This kind of output directory will contain sub-directories called ‘analysis’, ‘filtered\_gene\_bc\_matrices’

To read in a human (GRCh38) dataset using the ‘kmeans\_7\_clusters’ clustering:

```
dataset_se <- load_dataset_10Xdata('~/path/to/data/10X_mydata',
                                   dataset_genome = "GRCh38",
                                   clustering_set = "kmeans_7_clusters")
```

Note that the cell ranger pipelines seem to produce many different cluster sets, their names should be seen in the cell loupe browser, or listed in the 10X\_mydata/analysis/clustering directory.

NB: This function is quite basic and assumes the file at 10X\_mydata/filtered\_gene\_bc\_matrices/GRCh38/genes.csv will have columns `<ensemblID><GeneSymbol>`. See function doco if this is not the case. For more involved cases, the [cellrangerRkit](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/rkit) package may be necessary.

#### Directly with SummarizedExperiment objects

The data loading functions here are just convenient ways of making the SummarizedExperiment objects with the content that celaref functions expect, handling naming and checking uniqueness e.t.c. See [SummarizedExperiment doco](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html)

The minimum mandatory fields are described in section [Input data](#input-data), specifically:

* Within colData(dataset\_se): **cell\_sample** and **group** columns.
* Within rowData(dataset\_se): **ID** column.

Note that **group** needs to be a factor, but **cell\_sample** and **ID** should *not* be factors.

The colData (cell information) and rowData (gene information) should exactly match the columns and rows of the counts matrix.

The counts matrix should be a matrix of integer counts. If there are multiple assays present, the counts should be the first. Sparse matricies are ok, but hdf5-backed delayedArray matricies are not yet supported (as produced by save/loadHDF5SummarizedExperiment functions from HDF5Array package). See section [Handling large datasets](#handling-large-datasets) for alternatives.

#### Handling large datasets

Many (if not most) single cell datasets are too large to comforatably process using a basic dense matrix. (The default if using *load\_se\_from\_files*)

To process large datasets:

1. Supply a hdf5-backed delayedArray SummarizedExperiment object (via the save/loadHDF5SummarizedExperiment functions from HDF5Array package) Or, store the counts in a sparse Matrix (via capital M Matrix package), and use function *load\_se\_from\_tables*.

```
library(Matrix)
#a sparse big M Matrix.
dataset_se.1 <- load_se_from_tables(counts_matrix = my_sparse_Matrix,
                                  cell_info_table = cell_info_table,
                                  group_col_name  = "Cluster")

# A hdf5-backed SummarisedExperiment from elsewhere
dataset_se.2 <- loadHDF5SummarizedExperiment("a_SE_dir/")
```

Note however that this will evenutally be converted to a sparse matrix internally in the differential expression calculations - so large dataset might need subsetting (below…)

2. Use the n.group and n.others options in *contrast\_each\_group\_to\_the\_rest* to subset the dataset in each contrast. This will keep all of the ‘test’ group cells, and subsample the rest individually for each group’s differential expression calculations. Doing this separetly for each comparisons will maitain the relative proportions of cell types, which might be useful in cross-experiment comparisons.

```
# For consistant subsampling, use set.seed
set.seed(12)
de_table.demo_query.subset <-
   contrast_each_group_to_the_rest(demo_query_se, "subsetted_example",
                                   n.group = 100, n.other = 200)
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#> Randomly sub sampling cells for Group1 contrast.
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
#> Randomly sub sampling cells for Group2 contrast.
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
#> Randomly sub sampling cells for Group3 contrast.
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
#> Randomly sub sampling cells for Group4 contrast.
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
```

3. For very large datasets, it might be better to shrink the dataset upfront (losing the proportionality of cell types). The *subset\_cells\_by\_group* function will do this - here keeping 100 (or all) cell per group.

```
set.seed(12)
demo_query_se.subset <- subset_cells_by_group(demo_query_se, n.group = 100)
#> Randomly sub sampling100 cells per group.
```

#### Reading microarray data

Microarray datasets of purified cell-types can be used as references too. However, the analysis doesn’t use summarizedExperiment objects the same way, so it does the within-experiment differential expression directly.

Refer to section [Prepare data with within-experiment differential expression](#prepare-data-with-within-experiment-differential-expression) for details.

The [Limma](http://bioconductor.org/packages/release/bioc/html/limma.html) package needs to be installed to use this function. Limma is used to calculate the differential expression on the microarrays, rather than MAST which is used for the single-cell RNAseq data.

```
de_table.microarray <- contrast_each_group_to_the_rest_for_norm_ma_with_limma(
    norm_expression_table=demo_microarray_expr,
    sample_sheet_table=demo_microarray_sample_sheet,
    dataset_name="DemoSimMicroarrayRef",
    sample_name="cell_sample", group_name="group")
```

### Input filtering and Pre-processing

#### Filtering cells and low-expression genes

It is standard practice to remove uninformative low-expression genes before calculating differential expression. And in single-cell sequencing, low counts can indicate a problem cell - which can be dropped. Similarly, for the celaref package, very small cell groups will not have the statistical power to detect similarity.

The *trim\_small\_groups\_and\_low\_expression\_genes* function will remove cells and genes that don’t meet such thresholds. Defaults are fairly inclusive, and will require tweaking according to different experiments or technologies.

It can be helpful to check the number of genes and cells surviving *trim\_small\_groups\_and\_low\_expression\_genes* filtering with *dim(dataset\_se)*, and the number of cells per group with *table(dataset\_se$group)*.

```
# Default filtering
dataset_se <- trim_small_groups_and_low_expression_genes(dataset_se)

# Also defaults, but specified
dataset_se <- trim_small_groups_and_low_expression_genes(dataset_se,
                                    min_lib_size = 1000,
                                    min_group_membership = 5,
                                    min_detected_by_min_samples = 5)
```

Refer to function doco for exact definitions of these parameters.

#### Converting IDs

Converting one type of gene identifier to another gene identifier is annoying. Even with major identifiers like ensembl IDs (ENSG00000139618) or gene symbols (SYN1) there will be imperfect matching (missing ids, multiple matches).

If multiple gene IDs were provided when creating the summarizedExperiment object, (i.e. a gene info table/file), a convenience function *convert\_se\_gene\_ids* will allow a graceful conversion between them.

The function needs a tie-breaker for many-to-one gene relationships though - picking the one with higher read counts is a decent choice. Note that if both match, the choice is essentially arbitrary (consistency is not guaranteed).

The following code will convert from the original gene IDs (e.g.if ID is ensemblID), to ‘GeneSymbol’ (which should be a column name in rowData(dataset\_se))

It will:

* Define a genotype data level column *total\_count* with summed read counts per gene to use as the *eval\_col*.
* Remove any genes that have no GeneSymbol associated with the ensembl ID
* If the same GeneSymbol is assigned to multiple ensembl IDs - it looks up the *eval\_col* value and picks the bigger one.

```
# Count and store total reads/gene.
rowData(dataset_se)$total_count <- Matrix::rowSums(assay(dataset_se))
# rowData(dataset_se) must already list column 'GeneSymbol'
dataset_se <- convert_se_gene_ids(dataset_se, new_id='GeneSymbol', eval_col = 'total_count')
```

It can be helpful to check the number of genes before and after *convert\_se\_gene\_ids* with *dim(dataset\_se)*.

### Within-experiment differential expression

Once data is loaded into summarizedExperiment objects, the groups in each dataset need to be analysed within-dataset before any cross-dataset comparisons can be done. This is the most time consuming step, but only needs to be done once per dataset.

Essentially, we want to rank all genes from most to least ‘distinctive’ for each group in the dataset.

Differential expression is calculated for every group versus the rest of the dataset pooled together using MAST(Finak et al. 2015). This will provide relative expression for everything relative to the rest of the tissue or sample as background.An independent experiment will have its own biases, but with any luck the same genes should be ‘distinctive’ for the same cell type regardless. Since single cell RNAseq data can have many zeros and drop outs, celaref focuses on overrepresented genes. Genes are ranked from most to least overrepresented on the basis of their most conservative (‘inner’) 95% confidence interval of log2FC. This rank is a simple compromise between expected size-of-effect (log2FC - which can change over-dramatically for low-expression genes), and statistical power (from a p-value ranking).

This is done with the *contrast\_each\_group\_to\_the\_rest* function after [filtering](#filtering):

```
demo_query_se.filtered <- trim_small_groups_and_low_expression_genes(demo_query_se)
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')

de_table.demo_query <- contrast_each_group_to_the_rest(demo_query_se.filtered, "a_demo_query")
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
```

Reference datasets are prepared with the same command, there’s no difference in the result.

```
demo_ref_se.filtered <- trim_small_groups_and_low_expression_genes(demo_ref_se)
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
de_table.demo_ref   <- contrast_each_group_to_the_rest(demo_ref_se.filtered,   "a_demo_reference")
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
#> Found one, unnamed, assay in summarizedExperiment object. Assuming this is counts data ('counts')
#>
#> Done!
#> Combining coefficients and standard errors
#> Calculating log-fold changes
#> Calculating likelihood ratio tests
#> Refitting on reduced model...
#>
#> Done!
```

This object can be now passed to subsequent comparison functions - see section [Compare groups to reference](#Making-comparisons-to-reference-data).

---

For clarity, the results objects have names starting with de\_table, but they are simply tibble (data.frame-like) objects that look like this:

| ID | pval | log2FC | ci\_inner | ci\_outer | fdr | group | sig | sig\_up | gene\_count | rank | rescaled\_rank | dataset |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Gene84 | 0 | 3.020590 | 2.7127611 | 3.328419 | 0e+00 | Group1 | TRUE | TRUE | 200 | 1 | 0.005 | a\_demo\_query |
| Gene143 | 0 | 2.240433 | 1.9499389 | 2.530928 | 0e+00 | Group1 | TRUE | TRUE | 200 | 2 | 0.010 | a\_demo\_query |
| Gene4 | 0 | 2.017553 | 1.7331830 | 2.301923 | 0e+00 | Group1 | TRUE | TRUE | 200 | 3 | 0.015 | a\_demo\_query |
| Gene30 | 0 | 2.279577 | 1.6434328 | 2.915721 | 1e-07 | Group1 | TRUE | TRUE | 200 | 4 | 0.020 | a\_demo\_query |
| Gene197 | 0 | 1.969675 | 1.5975434 | 2.341806 | 0e+00 | Group1 | TRUE | TRUE | 200 | 5 | 0.025 | a\_demo\_query |
| Gene131 | 0 | 1.257196 | 0.7732667 | 1.741126 | 0e+00 | Group1 | TRUE | TRUE | 200 | 6 | 0.030 | a\_demo\_query |

As for what it contains, the important fields are:

* **ID** : Gene ID
* **fdr** : The multiple hypothesis corrected p-value (BH method)
* **log2FC** : Log2 fold-change of for this gene’s expression in the (test group) - (rest of sample)
* **ci\_inner** : The inner (most conservative/nearest 0) 95% confidence interval of **log2FC**. This is used to rank genes from most-to-least overrepresented in this group, with respect to the rest of the sample.
* **group** : Group being tested (all are tested by default)
* **sig\_up** : Is this gene significantly (**fdr** <=0.01) enriched (**log2FC** > 0) in this group.
* **rank** : Numerical rank of **ci\_inner** from most (1) to least (n).
* **rescaled\_rank** : Rank rescaled from most (0) to least (1) - used in analyses and plotting.
* **dataset** : Name of this dataset

---

This function is parallelised. Due to the differential expression calculations, this is a time-consuming step (e.g. a few hours, depending on data size). But the result can and should be saved and reused for any comparisons to other datasets. If *num\_cores* is specified, up to that many groups will be processed in parallel. This is highly recommended. For best results *num\_cores* should be set to the number of groups in the query so long as system resources permit.

---

Microarray reference data is treated differently, with function *contrast\_each\_group\_to\_the\_rest\_for\_norm\_ma\_with\_limma()* that both loads data and does within sample differential expression in one step. Its output is much the same. See [section on microarray input](#reading-microarray-data) for details.

```
de_table.microarray <- contrast_each_group_to_the_rest_for_norm_ma_with_limma(
    norm_expression_table=demo_microarray_expr,
    sample_sheet_table=demo_microarray_sample_sheet,
    dataset_name="DemoSimMicroarrayRef",
    sample_name="cell_sample", group_name="group")
```

## Running comparisions

### Compare groups to reference

Once the dataset has been compared to itself (see [Prepare data with within-experiment differential expression](#prepare-data-with-within-experiment-differential-expression)), the groups can be compared to the reference dataset.

The main output of celaref are the violin plots of the reference group rankings of query group ‘top’ genes. Each query group gets its own panel, with a violin plot of its ‘top’ gene rankings in each reference group. See section [Interpreting output](#interpreting-output) and the [overview diagram](#overview) full description of these plots.

To make that output, run function *make\_ranking\_violin\_plot*. (Note that *de\_table.test* and *de\_table.ref* parameters must be specified by name, not position.)

```
make_ranking_violin_plot(de_table.test=de_table.demo_query, de_table.ref=de_table.demo_ref)
```

![](data:image/png;base64...)

To pull together the data for this plot the *get\_the\_up\_genes\_for\_all\_possible\_groups* function is called internally. It can also be called by hand, see [Special case: Saving get\_the\_up\_genes\_for\_all\_possible\_groups output](#Special-case:-Saving-get_the_up_genes_for_all_possible_groups-output).

That *get\_the\_up\_genes\_for\_all\_possible\_groups* function will do two things

1. Identify ‘top’ genes for each group in the query dataset. i.e what is most distinctively high for this cell-type/group in the context of this tissue/sample. This is defined as up to the **first 100 genes with an inner log2FC 95% confidence interval >=1**.
2. Lookup the rescaled rankings (again from most to least log2FC inner 95% CI) of ‘top’ genes in each reference group.

NB: There is scope for the ranking criteria to be changed, but currently only the inner log2FC 95% confidence interval is implemented. Future work: Use of ‘topconfects’ is planned (Harrison et al. 2018).

### Compare groups within a single dataset

Its often useful to compare a dataset to itself. Just specify the same dataset for *de\_table.test* and *de\_table.ref*. This will show how similar the groups are. Clusters that can’t be distinguished from each other might be a sign that too many clusters were defined.

```
make_ranking_violin_plot(de_table.test=de_table.demo_query, de_table.ref=de_table.demo_query)
```

![](data:image/png;base64...)

### Make labels for groups

Lastly, celaref can parse these comparisons and suggest group names for the query groups.

The method for labelling used is described in section [Assigning labels to clusters](#assigning-labels-to-clusters). The name in ‘shortlab’ might make a good starting point for downstream characterisation. These labels should generally be interperented alongside the violin plots.

```
group_names_table <- make_ref_similarity_names(de_table.demo_query, de_table.demo_ref)
```

| test\_group | shortlab | pval | stepped\_pvals | pval\_to\_random | matches | reciprocal\_matches | similar\_non\_match | similar\_non\_match\_detail | differences\_within |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Group1 | Group1:No similarity | 6.09e-03 | Weird subtype:0.00609,Dunno:0.173,Exciting:0.0301,Mystery celltype:NA | 3.12e-02 | Weird subtype |  | NA | NA | NA |
| Group2 | Group2:No similarity | 5.14e-03 | Exciting:0.00514,Weird subtype:0.115,Dunno:0.188,Mystery celltype:NA | 1.56e-02 | Exciting |  | NA | NA | NA |
| Group3 | Group3:Dunno | 1.20e-04 | Dunno:0.00012,Weird subtype:0.442,Exciting:0.00805,Mystery celltype:NA | 3.05e-05 | Dunno | Dunno | NA | NA | NA |
| Group4 | Group4:Mystery celltype | 7.94e-05 | Mystery celltype:7.94e-05,Weird subtype:0.17,Exciting:0.384,Dunno:NA | 4.88e-04 | Mystery celltype | Mystery celltype | NA | NA | NA |

Its unusual to have anything other than NA in the ‘similar\_non\_match’ column. Explained in section [Assigning labels to clusters](#assigning-labels-to-clusters).

---

A note on the ‘num\_steps’ parameter.

Function *make\_ref\_similarity\_names* accepts an optional parameter ‘num\_steps’. It doesn’t affect the construction of the suggested labels in ‘shortlab’, only the extra ‘similar\_non\_match’ columns. Only pairs of reference groups *num\_steps*
away from each other when ranked by median generank are tested for difference - the nearer they are the more likely they’re similar.

It if is set too small though (e.g. 1), similar non-matched groups might be missed. Set to ‘NA’ for an exhastive test, but with many reference groups, this could be slow.

### Special case: Saving get\_the\_up\_genes\_for\_all\_possible\_groups output

Making the violin plots and cluster labels both use the *get\_the\_up\_genes\_for\_all\_possible\_groups* function internally.

It is possible to run this manually and pass the result through. For most analysis this is uncessary neccessary, unless you want to look at the top genes rankings directly e.t.c.

```
de_table.marked.query_vs_ref <- get_the_up_genes_for_all_possible_groups(
   de_table.test=de_table.demo_query ,
   de_table.ref=de_table.demo_ref)
# Have to do do the reciprocal table too for labelling.
de_table.marked.ref_vs_query<- get_the_up_genes_for_all_possible_groups(
   de_table.test=de_table.demo_ref ,
   de_table.ref=de_table.demo_query)

kable(head(de_table.marked.query_vs_ref))
```

| ID | pval | log2FC | ci\_inner | ci\_outer | fdr | group | sig | sig\_up | gene\_count | rank | rescaled\_rank | dataset | test\_group | test\_dataset |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Gene30 | 0.0000000 | 2.6779056 | 2.3862118 | 2.9695994 | 0.0000000 | Dunno | TRUE | TRUE | 200 | 6 | 0.03 | a\_demo\_reference | Group1 | a\_demo\_query |
| Gene84 | 0.0007185 | 0.3998519 | 0.1961379 | 0.6035659 | 0.0031933 | Dunno | TRUE | TRUE | 200 | 26 | 0.13 | a\_demo\_reference | Group1 | a\_demo\_query |
| Gene143 | 0.8477488 | -0.0036297 | 0.1893840 | -0.1966434 | 0.8876951 | Dunno | FALSE | FALSE | 200 | 28 | 0.14 | a\_demo\_reference | Group1 | a\_demo\_query |
| Gene4 | 0.7959082 | -0.0160703 | 0.1656789 | -0.1978195 | 0.8512388 | Dunno | FALSE | FALSE | 200 | 30 | 0.15 | a\_demo\_reference | Group1 | a\_demo\_query |
| Gene197 | 0.0565735 | -0.2937215 | -0.0465382 | -0.5409048 | 0.0838126 | Dunno | FALSE | FALSE | 200 | 168 | 0.84 | a\_demo\_reference | Group1 | a\_demo\_query |
| Gene30 | 0.0000000 | 1.6977256 | 1.3045379 | 2.0909133 | 0.0000000 | Exciting | TRUE | TRUE | 200 | 6 | 0.03 | a\_demo\_reference | Group1 | a\_demo\_query |

Equivalent plots and labels:

```
make_ranking_violin_plot(de_table.marked.query_vs_ref)
```

![](data:image/png;base64...)

```
#use make_ref_similarity_names_using_marked instead:
similarity_label_table <- make_ref_similarity_names_using_marked(de_table.marked.query_vs_ref, de_table.recip.marked=de_table.marked.ref_vs_query)
```

```
kable(similarity_label_table)
```

| test\_group | shortlab | pval | stepped\_pvals | pval\_to\_random | matches | reciprocal\_matches | similar\_non\_match | similar\_non\_match\_detail | differences\_within |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Group1 | Group1:No similarity | 6.09e-03 | Weird subtype:0.00609,Dunno:0.173,Exciting:0.0301,Mystery celltype:NA | 3.12e-02 | Weird subtype |  | NA | NA | NA |
| Group2 | Group2:No similarity | 5.14e-03 | Exciting:0.00514,Weird subtype:0.115,Dunno:0.188,Mystery celltype:NA | 1.56e-02 | Exciting |  | NA | NA | NA |
| Group3 | Group3:Dunno | 1.20e-04 | Dunno:0.00012,Weird subtype:0.442,Exciting:0.00805,Mystery celltype:NA | 3.05e-05 | Dunno | Dunno | NA | NA | NA |
| Group4 | Group4:Mystery celltype | 7.94e-05 | Mystery celltype:7.94e-05,Weird subtype:0.17,Exciting:0.384,Dunno:NA | 4.88e-04 | Mystery celltype | Mystery celltype | NA | NA | NA |

# Example Analyses

## PBMCs - 10X vs Microarray Reference

PBMCs from blood are an easily accessible heterogeneous cell sample with several similar yet distinct cell types.

10X genomics has several datasets available to download from their website, including the [pbmc4k dataset](https://support.10xgenomics.com/single-cell-gene-expression/datasets/2.1.0/pbmc4k), which contains PBMCs derived from a healthy individual. This example data is the direct output of 10X’s [cell-ranger](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger) pipeline, which includes the output of several different unsupervised cell-clustering analyses. This is the kind of data that might be initially provided by a sequencing facility.

These clustering algorithms produce a set of numbered cell clusters - *But what cell-types are in each cluster?*

This example will use a reference of PBMC cells to assign some biological cell types to these clusters.

A suitable PBMC reference (a ‘HaemAtlas’) has been published by Watkins et al. (2009). They purified populations of PBMC cell types and measured gene expression via microarray. The data used here was downloaded in a normalised table from the ‘haemosphere’ website (Graaf et al. 2016).

---

The cell-ranger pipeline produced several different clustering runs. None of which is likely to be perfect. This example use the kmeans k=7 set, but comparing different cluster-sets to a reference like this might help assess which is most appropriate.

For reference, here are the groups for this data colour-coded on a t-SNE plot in the cell-loupe viewer. The number in brackets after the cell group label is the number of cells in the group.

![](data:image/png;base64...)

### Prepare 10X query dataset

First, load the dataset into a SummarizedExperiment object and filter out genes with low expression, or groups that have too few members.

```
library(celaref)
datasets_dir <- "~/celaref_extra_vignette_data/datasets"

dataset_se.10X_pbmc4k_k7 <- load_dataset_10Xdata(
   dataset_path   = file.path(datasets_dir,'10X_pbmc4k'),
   dataset_genome = "GRCh38",
   clustering_set = "kmeans_7_clusters",
   id_to_use      = "GeneSymbol")
dataset_se.10X_pbmc4k_k7 <- trim_small_groups_and_low_expression_genes(dataset_se.10X_pbmc4k_k7)
```

Then prepare the datasets with the within-experiment comparisons. Setting the num-cores to 7 to let each group run in parallel (specify less to reduce RAM usage).

```
de_table.10X_pbmc4k_k7   <- contrast_each_group_to_the_rest(dataset_se.10X_pbmc4k_k7, dataset_name="10X_pbmc4k_k7", num_cores=7)
```

### Prepare reference microarray dataset

Next, do the same with the Watkins2009 reference data. However, because this is microarray data, it is a different process - the data loading and within-experiment comparisons are rolled into the single function *contrast\_each\_group\_to\_the\_rest\_for\_norm\_ma\_with\_limma*. That function needs two things:

* Logged, normalised expression values. Any low expression or poor quality measurements should have already been removed.
* Sample information (see *contrast\_each\_group\_to\_the\_rest\_for\_norm\_ma\_with\_limma* for details)

Note that for this to work, the arrays should be from the same experiment/study. The variation would probably be too much between samples pulled from different studies.

```
this_dataset_dir     <- file.path(datasets_dir,     'haemosphere_datasets','watkins')
norm_expression_file <- file.path(this_dataset_dir, "watkins_expression.txt")
samples_file         <- file.path(this_dataset_dir, "watkins_samples.txt")

norm_expression_table.full <- read.table(norm_expression_file, sep="\t", header=TRUE, quote="", comment.char="", row.names=1, check.names=FALSE)

samples_table              <- read_tsv(samples_file, col_types = cols())
samples_table$description  <- make.names( samples_table$description) # Avoid group or extra_factor names starting with numbers, for microarrays
```

From the sample table, can see that this dataset includes other tissues, but as a PBMC reference, we only want to consider the peripheral blood samples. Like the other data loading functions, to remove a sample (or cell) from the analysis, it is enough to remove it from the sample table.

```
samples_table        <- samples_table[samples_table$tissue == "Peripheral Blood",]
```

| sampleId | celltype | cell\_lineage | surface\_markers | tissue | description | notes |
| --- | --- | --- | --- | --- | --- | --- |
| 1674120023\_A | B lymphocyte | B Cell Lineage | NA | Peripheral Blood | X49.years.adult | NA |
| 1674120023\_B | granulocyte | Neutrophil Lineage | NA | Peripheral Blood | X49.years.adult | NA |
| 1674120023\_C | natural killer cell | NK Cell Lineage | NA | Peripheral Blood | X49.years.adult | NA |
| 1674120023\_D | Th lymphocyte | T Cell Lineage | NA | Peripheral Blood | X49.years.adult | NA |
| 1674120023\_E | Tc lymphocyte | T Cell Lineage | NA | Peripheral Blood | X49.years.adult | NA |
| 1674120023\_F | monocyte | Macrophage Lineage | NA | Peripheral Blood | X49.years.adult | NA |

As usually seems to be the case, the hardest part is formatting the input. Microarray expression values should be provided as *normalised, log-transformed data* using the *same IDs as the query datset*. Any probe or sample level filtering should also be performed beforehand. In this case, the data was normalised when acquired from the haemosphere website - but still need to match the IDs.

This data is from Illumina HumanWG-6 v2 Expression BeadChips, and gives expression at the probe level. These probes need to be converted to gene symbols to match the PBMC data.

NB: Converting between IDs is easier for single cell datasets using the *convert\_se\_gene\_ids* function. But that function expects a SummarizedExperiment object, which isn’t used for microarray data. So it has to be done manually here.

NB: Note that it doesn’t matter if IDs are only present in one or the other dataset - just that they are the same type of ID and most match!

```
library("tidyverse")
library("illuminaHumanv2.db")
probes_with_gene_symbol_and_with_data <- intersect(keys(illuminaHumanv2SYMBOL),rownames(norm_expression_table.full))

# Get mappings - non NA
probe_to_symbol <- select(illuminaHumanv2.db, keys=rownames(norm_expression_table.full), columns=c("SYMBOL"), keytype="PROBEID")
probe_to_symbol <- unique(probe_to_symbol[! is.na(probe_to_symbol$SYMBOL),])
# no multimapping probes
genes_per_probe <- table(probe_to_symbol$PROBEID) # How many genes a probe is annotated against?
multimap_probes <- names(genes_per_probe)[genes_per_probe  > 1]
probe_to_symbol <- probe_to_symbol[!probe_to_symbol$PROBEID %in% multimap_probes, ]

convert_expression_table_ids<- function(expression_table, the_probes_table, old_id_name, new_id_name){

    the_probes_table <- the_probes_table[,c(old_id_name, new_id_name)]
    colnames(the_probes_table) <- c("old_id", "new_id")

    # Before DE, just pick the top expresed probe to represent the gene
    # Not perfect, but this is a ranking-based analysis.
    # hybridisation issues aside, would expect higher epressed probes to be more relevant to Single cell data anyway.
    probe_expression_levels <- rowSums(expression_table)
    the_probes_table$avgexpr <- probe_expression_levels[as.character(the_probes_table$old_id)]

    the_genes_table <-  the_probes_table %>%
        group_by(new_id) %>%
        top_n(1, avgexpr)

    expression_table <- expression_table[the_genes_table$old_id,]
    rownames(expression_table) <- the_genes_table$new_id

    return(expression_table)
}

# Just the most highly expressed probe foreach gene.
norm_expression_table.genes <- convert_expression_table_ids(norm_expression_table.full,
                                                            probe_to_symbol, old_id_name="PROBEID", new_id_name="SYMBOL")
```

Now read the data and run the within-experiment contrast with *contrast\_each\_group\_to\_the\_rest\_for\_norm\_ma\_with\_limma*.

Because there is information on which individual each sample is from in the ‘description’ field, this is specified with *extra\_factor\_name*, and is included as a factor in the linear model for limma. This is optional, and only one extra factor can be added this way.

```
# Go...
de_table.Watkins2009PBMCs <- contrast_each_group_to_the_rest_for_norm_ma_with_limma(
                 norm_expression_table = norm_expression_table.genes,
                 sample_sheet_table    = samples_table,
                 dataset_name          = "Watkins2009PBMCs",
                 extra_factor_name     = 'description',
                 sample_name           = "sampleId",
                 group_name            = 'celltype')
```

### Compare 10X query PBMCs to to reference

Finally! Compare the single cell data to the purified PBMCs:

```
make_ranking_violin_plot(de_table.test=de_table.10X_pbmc4k_k7, de_table.ref=de_table.Watkins2009PBMCs)
```

![](data:image/png;base64...)

Hmm, there’s a few clusters where different the top genes are bunched near the top for a couple of different reference cell types.

Logging the plot will be more informative at the top end for this dataset.

```
make_ranking_violin_plot(de_table.test=de_table.10X_pbmc4k_k7, de_table.ref=de_table.Watkins2009PBMCs, log10trans = TRUE)
```

![](data:image/png;base64...)

Now get some some group labels.

As described in section [Assigning lables to clusters](#assigning-labels-to-clusters), multiple similarities will be reported (in descending order of median rank) unless a clear (significantly different) frontrunner can be flagged.

```
label_table.pbmc4k_k7_vs_Watkins2009PBMCs <- make_ref_similarity_names(de_table.10X_pbmc4k_k7, de_table.Watkins2009PBMCs)
```

| test\_group | shortlab | pval | stepped\_pvals | pval\_to\_random | matches | reciprocal\_matches | similar\_non\_match | similar\_non\_match\_detail | differences\_within |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 1:(Th lymphocyte) | NA | Tc lymphocyte:0.436,Th lymphocyte:0.13,natural killer cell:0.268,B lymphocyte:0.0468,monocyte:0.0183,granulocyte:NA | NA |  | Th lymphocyte | NA | NA | NA |
| 2 | 2:monocyte(granulocyte) | 1.90e-06 | monocyte:1.89e-06,granulocyte:5.72e-07,natural killer cell:0.216,B lymphocyte:0.047,Tc lymphocyte:0.000111,Th lymphocyte:NA | 0.000000 | monocyte | granulocyte|monocyte | NA | NA | NA |
| 3 | 3:natural killer cell|Tc lymphocyte | 3.96e-04 | natural killer cell:0.482,Tc lymphocyte:0.000396,Th lymphocyte:0.00134,granulocyte:0.00856,monocyte:0.213,B lymphocyte:NA | 0.001950 | natural killer cell|Tc lymphocyte | natural killer cell|Tc lymphocyte | NA | NA | NA |
| 4 | 4:B lymphocyte | 1.66e-04 | B lymphocyte:0.000166,monocyte:0.00916,natural killer cell:0.304,Tc lymphocyte:0.165,granulocyte:0.0999,Th lymphocyte:NA | 0.000122 | B lymphocyte | B lymphocyte | NA | NA | NA |
| 5 | 5:B lymphocyte | 7.24e-03 | B lymphocyte:0.00724,monocyte:0.18,granulocyte:0.369,natural killer cell:0.0169,Th lymphocyte:0.841,Tc lymphocyte:NA | 0.006330 | B lymphocyte |  | NA | NA | NA |
| 6 | 6:No similarity | NA | natural killer cell:0.381,Tc lymphocyte:0.401,Th lymphocyte:0.63,B lymphocyte:0.3,granulocyte:0.315,monocyte:NA | NA |  |  | NA | NA | NA |
| 7 | 7:natural killer cell | 0.00e+00 | natural killer cell:1.27e-08,Tc lymphocyte:0.886,B lymphocyte:0.625,granulocyte:0.0657,monocyte:1.11e-08,Th lymphocyte:NA | 0.000000 | natural killer cell |  | NA | NA | NA |

---

With a couple of (reciprocal-only matches) in the cluster names, it might be worth checking the reciprocal violin plots:

```
make_ranking_violin_plot(de_table.test=de_table.Watkins2009PBMCs, de_table.ref=de_table.10X_pbmc4k_k7, log10trans = TRUE)
```

![](data:image/png;base64...)

## Mouse tissues - Similar and different

In their paper *Cell types in the mouse cortex and hippocampus revealed by single-cell RNA-seq* Zeisel et al. (2015) performed single cell RNA sequencing in mouse, in two tissues (sscortex and ca1hippocampus).

Similarly, Farmer et al. (2017) have published a survey of cell types in the mouse lacrimal gland at two developmental stages. (*Defining epithelial cell dynamics and lineage relationships in the developing lacrimal gland*).

These cell types are have already been expertly described - so they don’t really need to be compared to any reference. Rather, these datasets are contrasted to visualise how real single cell datasets of similar and different tissue types look, with respect to a ‘known truth’.

### Load and compare mouse brain datasets

First, start by loading the brain cell data from (Zeisel et al. 2015):

```
datasets_dir <- "~/celaref_extra_vignette_data/datasets"
zeisel_cell_info_file <- file.path(datasets_dir, "zeisel2015", "zeisel2015_mouse_scs_detail.tab")
zeisel_counts_file    <- file.path(datasets_dir, "zeisel2015", "zeisel2015_mouse_scs_counts.tab")
```

Note the sample data in *zeisel2015\_mouse\_scs\_detail.tab* has the following information. They specify cell type groups at two different levels, and for this example, just going to use *level1class*. Also need to specify that *cell\_id* is, unsurprisingly, the cell identifier.

| tissue | total mRNA mol | well | sex | age | diameter | cell\_id | level1class | level2class |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| sscortex | 21580 | 11 | 1 | 21 | 0 | 1772071015\_C02 | interneurons | Int10 |
| sscortex | 21748 | 95 | -1 | 20 | 9.56 | 1772071017\_G12 | interneurons | Int10 |
| ca1hippocampus | 20389 | 66 | -1 | 23 | 10.9 | 1772067060\_B09 | interneurons | Int9 |
| ca1hippocampus | 22515 | 52 | 1 | 31 | 0 | 1772067082\_D07 | interneurons | Int2 |

```
dataset_se.zeisel <- load_se_from_files(zeisel_counts_file, zeisel_cell_info_file,
                                 group_col_name = "level1class",
                                 cell_col_name  = "cell_id" )
```

That dataset\_se object contains all the data, so subset it into two objects by tissue (its a SummarizedExperiment object). Then separately filter both for low-expression genes and groups with too few cells to analyse.

```
# Subset the summarizedExperiment object into two tissue-specific objects
dataset_se.cortex <- dataset_se.zeisel[,dataset_se.zeisel$tissue == "sscortex"]
dataset_se.hippo  <- dataset_se.zeisel[,dataset_se.zeisel$tissue == "ca1hippocampus"]

# And filter them
dataset_se.cortex  <- trim_small_groups_and_low_expression_genes(dataset_se.cortex )
dataset_se.hippo   <- trim_small_groups_and_low_expression_genes(dataset_se.hippo )
```

Next, need to do the within-dataset comparisons. There are 6 groups in each sample - so use 6 cores to run them all at once. This may take some time to finish, so be sure to save the result for reuse.

```
de_table.zeisel.cortex <- contrast_each_group_to_the_rest(dataset_se.cortex, dataset_name="zeisel_sscortex",       num_cores=6)
de_table.zeisel.hippo  <- contrast_each_group_to_the_rest(dataset_se.hippo,  dataset_name="zeisel_ca1hippocampus", num_cores=6)
```

Now compare the two:

```
make_ranking_violin_plot(de_table.test=de_table.zeisel.cortex, de_table.ref=de_table.zeisel.hippo)
```

![](data:image/png;base64...)

Perhaps unsurprisingly given they’re from the same experiment, the cell-type annotations do almost perfectly correlate one-to-one.

| test\_group | shortlab | pval | stepped\_pvals | pval\_to\_random | matches | reciprocal\_matches | similar\_non\_match | similar\_non\_match\_detail | differences\_within |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| astrocytes\_ependymal | astrocytes\_ependymal:astrocytes\_ependymal | 8.35e-22 | astrocytes\_ependymal:8.35e-22,microglia:0.00447,interneurons:0.155,endothelial-mural:0.0164,oligodendrocytes:0.00229,pyramidal CA1:NA | 1.02e-21 | astrocytes\_ependymal | astrocytes\_ependymal | NA | NA | NA |
| endothelial-mural | endothelial-mural:endothelial-mural | 6.31e-18 | endothelial-mural:6.31e-18,astrocytes\_ependymal:0.0673,microglia:0.000932,interneurons:0.0606,oligodendrocytes:0.264,pyramidal CA1:NA | 1.04e-16 | endothelial-mural | endothelial-mural | NA | NA | NA |
| interneurons | interneurons:interneurons | 1.64e-18 | interneurons:1.64e-18,microglia:0.033,endothelial-mural:0.0705,astrocytes\_ependymal:0.00614,oligodendrocytes:0.0231,pyramidal CA1:NA | 2.95e-19 | interneurons | interneurons | NA | NA | NA |
| microglia | microglia:microglia | 2.72e-28 | microglia:2.72e-28,interneurons:0.136,astrocytes\_ependymal:0.26,endothelial-mural:0.00148,pyramidal CA1:0.752,oligodendrocytes:NA | 1.29e-26 | microglia | microglia | NA | NA | NA |
| oligodendrocytes | oligodendrocytes:oligodendrocytes | 8.53e-34 | oligodendrocytes:8.53e-34,microglia:0.00016,interneurons:8.29e-06,endothelial-mural:0.934,astrocytes\_ependymal:1.26e-07,pyramidal CA1:NA | 7.89e-31 | oligodendrocytes | oligodendrocytes | NA | NA | NA |
| pyramidal SS | pyramidal SS:pyramidal CA1 | 1.54e-25 | pyramidal CA1:1.54e-25,microglia:0.000598,endothelial-mural:0.0868,interneurons:0.00391,astrocytes\_ependymal:0.00468,oligodendrocytes:NA | 6.26e-23 | pyramidal CA1 | pyramidal CA1 | NA | NA | NA |

### Load lacrimal gland dataset

Next, compare that to a dissimilar tissue - lacrimal gland from Farmer et al. (2017). Only the more mature P4 timepoint will be used here.

The format of this data that is a little more complicated. There was a MatrixMarket formatted file for the counts matrix, and cell assignment and cluster information are in separate files. So this data needs to be converted into the form that *load\_se\_from\_tables* expects.

```
library(Matrix)

Farmer2017lacrimal_dir  <- file.path(datasets_dir, "Farmer2017_lacrimal", "GSM2671416_P4")

# Counts matrix
Farmer2017lacrimal_matrix_file   <- file.path(Farmer2017lacrimal_dir, "GSM2671416_P4_matrix.mtx")
Farmer2017lacrimal_barcodes_file <- file.path(Farmer2017lacrimal_dir, "GSM2671416_P4_barcodes.tsv")
Farmer2017lacrimal_genes_file    <- file.path(Farmer2017lacrimal_dir, "GSM2671416_P4_genes.tsv")

counts_matrix <- readMM(Farmer2017lacrimal_matrix_file)
counts_matrix <- as.matrix(counts_matrix)
storage.mode(counts_matrix) <- "integer"

genes <- read.table(Farmer2017lacrimal_genes_file,    sep="", stringsAsFactors = FALSE)[,1]
cells <- read.table(Farmer2017lacrimal_barcodes_file, sep="", stringsAsFactors = FALSE)[,1]
rownames(counts_matrix) <- genes
colnames(counts_matrix) <- cells

# Gene info table
gene_info_table.Farmer2017lacrimal <- as.data.frame(read.table(Farmer2017lacrimal_genes_file, sep="", stringsAsFactors = FALSE), stringsAsFactors = FALSE)
colnames(gene_info_table.Farmer2017lacrimal) <- c("ensemblID","GeneSymbol") # ensemblID is first, will become ID

## Cell/sample info
Farmer2017lacrimal_cells2groups_file  <- file.path(datasets_dir, "Farmer2017_lacrimal", "Farmer2017_supps", paste0("P4_cellinfo.tab"))
Farmer2017lacrimal_clusterinfo_file   <- file.path(datasets_dir, "Farmer2017_lacrimal", "Farmer2017_supps", paste0("Farmer2017_clusterinfo_P4.tab"))

# Cells to cluster number (just a number)
Farmer2017lacrimal_cells2groups_table <- read_tsv(Farmer2017lacrimal_cells2groups_file, col_types=cols())
# Cluster info - number to classification
Farmer2017lacrimal_clusterinfo_table <- read_tsv(Farmer2017lacrimal_clusterinfo_file, col_types=cols())
# Add in cluster info
Farmer2017lacrimal_cells2groups_table <- merge(x=Farmer2017lacrimal_cells2groups_table, y=Farmer2017lacrimal_clusterinfo_table, by.x="cluster", by.y="ClusterNum")

# Cell sample2group
cell_sample_2_group.Farmer2017lacrimal <- Farmer2017lacrimal_cells2groups_table[,c("Cell identity","ClusterID", "nGene", "nUMI")]
colnames(cell_sample_2_group.Farmer2017lacrimal) <- c("cell_sample", "group", "nGene", "nUMI")
# Add -1 onto each of the names, that seems to be in the counts
cell_sample_2_group.Farmer2017lacrimal$cell_sample <- paste0(cell_sample_2_group.Farmer2017lacrimal$cell_sample, "-1")

# Create a summarised experiment object.
dataset_se.P4  <- load_se_from_tables(counts_matrix,
                                   cell_info_table = cell_sample_2_group.Farmer2017lacrimal,
                                   gene_info_table = gene_info_table.Farmer2017lacrimal )
```

After all that, the dataset has the cell information (colData):

|  | cell\_sample | group | nGene | nUMI |
| --- | --- | --- | --- | --- |
| AAACTTGATAGCCA-1 | AAACTTGATAGCCA-1 | Mes 1 | 1791 | 5351 |
| AAGCACTGACCTCC-1 | AAGCACTGACCTCC-1 | Mes 1 | 1495 | 3950 |
| AAGTTCCTTGACTG-1 | AAGTTCCTTGACTG-1 | Mes 1 | 2312 | 6107 |
| AATAAGCTCCTGTC-1 | AATAAGCTCCTGTC-1 | Mes 1 | 2375 | 7060 |
| AATTGTGAAGCCAT-1 | AATTGTGAAGCCAT-1 | Mes 1 | 2348 | 6340 |
| ACAAAGGATCGTTT-1 | ACAAAGGATCGTTT-1 | Mes 1 | 1985 | 5541 |

… and the gene information (rowData):

|  | ID | ensemblID | GeneSymbol |
| --- | --- | --- | --- |
| ENSMUSG00000051951 | ENSMUSG00000051951 | ENSMUSG00000051951 | Xkr4 |
| ENSMUSG00000089699 | ENSMUSG00000089699 | ENSMUSG00000089699 | Gm1992 |
| ENSMUSG00000102343 | ENSMUSG00000102343 | ENSMUSG00000102343 | Gm37381 |
| ENSMUSG00000025900 | ENSMUSG00000025900 | ENSMUSG00000025900 | Rp1 |
| ENSMUSG00000025902 | ENSMUSG00000025902 | ENSMUSG00000025902 | Sox17 |
| ENSMUSG00000104328 | ENSMUSG00000104328 | ENSMUSG00000104328 | Gm37323 |

Note that ‘ID’ is the ensembl gene id, and it needs to switch to the gene symbol to match the Zeisel data. Could equally well use ensembl ids for both.

Gene symbol to ID is *almost* a one to one mapping, so a few genes are lost in this step. Calculating the total read count for each gene is a simple way of producing a tie-breaker. This is also the reason why the data was loaded with ensemblID as the ID in *load\_se\_from\_tables*, because GeneSymbol is not unique.

```
rowData(dataset_se.P4)$total_count <- rowSums(assay(dataset_se.P4))
dataset_se.P4  <-  convert_se_gene_ids( dataset_se.P4,  new_id='GeneSymbol', eval_col='total_count')
```

Filter and do the within-experiment comparisons

```
dataset_se.P4 <- trim_small_groups_and_low_expression_genes(dataset_se.P4)
de_table.Farmer2017lacrimalP4  <- contrast_each_group_to_the_rest(dataset_se.P4,  dataset_name="Farmer2017lacrimalP4", num_cores = 4)
```

### Cross-tissue comparision

Now compare the mouse cortex samples to the lacrimal gland. Being completely different tissues there shouldn’t be many cell types in common.

```
make_ranking_violin_plot(de_table.test=de_table.zeisel.cortex, de_table.ref=de_table.Farmer2017lacrimalP4)
```

![](data:image/png;base64...)

```
label_table.cortex_vs_lacrimal <-
   make_ref_similarity_names(de_table.zeisel.cortex, de_table.Farmer2017lacrimalP4)
```

| test\_group | shortlab | pval | stepped\_pvals | pval\_to\_random | matches | reciprocal\_matches | similar\_non\_match | similar\_non\_match\_detail | differences\_within |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| astrocytes\_ependymal | astrocytes\_ependymal:No similarity | NA | Mast/Lymphocyte:0.2,Mes 1:0.594,Mes 3:0.286,Endothelial:0.439,Mes 4:0.591,Mes 2:0.257,Myoepithelial:0.43,Macrophage/Monocyte:0.245,Epithelial:NA | NA |  |  | NA | NA | NA |
| endothelial-mural | endothelial-mural:(Endothelial) | NA | Endothelial:0.226,Mes 3:0.0741,Mes 4:0.595,Myoepithelial:0.708,Mes 1:0.0331,Mast/Lymphocyte:0.69,Mes 2:0.022,Macrophage/Monocyte:0.344,Epithelial:NA | NA |  | Endothelial | NA | NA | NA |
| interneurons | interneurons:No similarity | NA | Mes 4:0.506,Mes 3:0.519,Mast/Lymphocyte:0.0835,Macrophage/Monocyte:0.7,Myoepithelial:0.469,Mes 1:0.602,Mes 2:0.179,Endothelial:0.193,Epithelial:NA | NA |  |  | NA | NA | NA |
| microglia | microglia:Macrophage/Monocyte | 2.83e-14 | Macrophage/Monocyte:2.83e-14,Mes 4:5.82e-05,Endothelial:1.25e-08,Myoepithelial:0.844,Mast/Lymphocyte:0.146,Mes 2:0.439,Mes 1:0.415,Mes 3:0.022,Epithelial:NA | 1.22e-17 | Macrophage/Monocyte | Macrophage/Monocyte | NA | NA | NA |
| oligodendrocytes | oligodendrocytes:No similarity | NA | Mast/Lymphocyte:0.595,Mes 4:0.332,Epithelial:0.45,Mes 3:0.355,Mes 2:0.613,Mes 1:0.574,Endothelial:0.0884,Macrophage/Monocyte:0.635,Myoepithelial:NA | NA |  |  | NA | NA | NA |
| pyramidal SS | pyramidal SS:No similarity | NA | Mes 4:0.36,Endothelial:0.177,Macrophage/Monocyte:0.586,Mes 2:0.679,Epithelial:0.175,Mast/Lymphocyte:0.674,Mes 3:0.392,Myoepithelial:0.0842,Mes 1:NA | NA |  |  | NA | NA | NA |

This cross-tissue comparison looks very different to the brain-brain contrast - as expected, most clusters have ‘no similarity’.

Not all though. The cortex ‘microglia’ have their similarity with the ‘Macrophage/Monocyte’ group highlighted. This makes sense - as they are biological similar cell types.

Interestingly, there’s also a reciprocal match from the Lacrimal gland endothelial cells to endothelial-mural cell in the brain sample.

# Session Info

This vignette built on session:

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> Random number generation:
#>  RNG:     Mersenne-Twister
#>  Normal:  Inversion
#>  Sample:  Rounding
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] celarefData_1.27.0          ExperimentHub_3.0.0
#>  [3] AnnotationHub_4.0.0         BiocFileCache_3.0.0
#>  [5] dbplyr_2.5.1                tibble_3.3.0
#>  [7] readr_2.1.5                 magrittr_2.0.4
#>  [9] dplyr_1.1.4                 ggplot2_4.0.0
#> [11] knitr_1.50                  celaref_1.28.0
#> [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [17] IRanges_2.44.0              S4Vectors_0.48.0
#> [19] BiocGenerics_0.56.0         generics_0.1.4
#> [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1            farver_2.1.2
#>  [3] blob_1.2.4                  Biostrings_2.78.0
#>  [5] filelock_1.0.3              S7_0.2.0
#>  [7] fastmap_1.2.0               SingleCellExperiment_1.32.0
#>  [9] digest_0.6.37               lifecycle_1.0.4
#> [11] KEGGREST_1.50.0             statmod_1.5.1
#> [13] RSQLite_2.4.3               compiler_4.5.1
#> [15] rlang_1.1.6                 sass_0.4.10
#> [17] progress_1.2.3              tools_4.5.1
#> [19] yaml_2.3.10                 data.table_1.17.8
#> [21] prettyunits_1.2.0           S4Arrays_1.10.0
#> [23] labeling_0.4.3              bit_4.6.0
#> [25] curl_7.0.0                  DelayedArray_0.36.0
#> [27] plyr_1.8.9                  RColorBrewer_1.1-3
#> [29] abind_1.4-8                 purrr_1.1.0
#> [31] withr_3.0.2                 grid_4.5.1
#> [33] scales_1.4.0                dichromat_2.0-0.1
#> [35] MAST_1.36.0                 cli_3.6.5
#> [37] rmarkdown_2.30              crayon_1.5.3
#> [39] httr_1.4.7                  reshape2_1.4.4
#> [41] tzdb_0.5.0                  DBI_1.2.3
#> [43] cachem_1.1.0                stringr_1.5.2
#> [45] AnnotationDbi_1.72.0        BiocManager_1.30.26
#> [47] XVector_0.50.0              vctrs_0.6.5
#> [49] Matrix_1.7-4                jsonlite_2.0.0
#> [51] hms_1.1.4                   bit64_4.6.0-1
#> [53] limma_3.66.0                jquerylib_0.1.4
#> [55] glue_1.8.0                  stringi_1.8.7
#> [57] gtable_0.3.6                BiocVersion_3.22.0
#> [59] pillar_1.11.1               rappdirs_0.3.3
#> [61] htmltools_0.5.8.1           R6_2.6.1
#> [63] httr2_1.2.1                 evaluate_1.0.5
#> [65] lattice_0.22-7              png_0.1-8
#> [67] memoise_2.0.1               bslib_0.9.0
#> [69] Rcpp_1.1.0                  SparseArray_1.10.0
#> [71] xfun_0.53                   pkgconfig_2.0.3
```

# References

Farmer, D’Juan T., Sara Nathan, Jennifer K. Finley, Kevin Shengyang Yu, Elaine Emmerson, Lauren E. Byrnes, Julie B. Sneddon, Michael T. McManus, Aaron D. Tward, and Sarah M. Knox. 2017. “Defining epithelial cell dynamics and lineage relationships in the developing lacrimal gland.” *Development* 144 (13): 2517–28. <https://doi.org/10.1242/dev.150789>.

Finak, Greg, Andrew McDavid, Masanao Yajima, Jingyuan Deng, Vivian Gersuk, Alex K. Shalek, Chloe K. Slichter, et al. 2015. “MAST: A flexible statistical framework for assessing transcriptional changes and characterizing heterogeneity in single-cell RNA sequencing data.” *Genome Biology* 16 (1): 1–13. <https://doi.org/10.1186/s13059-015-0844-5>.

Freytag, Saskia, Ingrid Lonnstedt, Milica Ng, and Melanie Bahlo. 2017. “Cluster Headache: Comparing Clustering Tools for 10X Single Cell Sequencing Data,” no. 4. <https://doi.org/10.1101/203752>.

Graaf, Carolyn A. de, Jarny Choi, Tracey M. Baldwin, Jessica E. Bolden, Kirsten A. Fairfax, Aaron J. Robinson, Christine Biben, et al. 2016. “Haemopedia: An Expression Atlas of Murine Hematopoietic Cells.” *Stem Cell Reports* 7 (3): 571–82. <https://doi.org/10.1016/j.stemcr.2016.07.007>.

Harrison, Paul, Andrew Pattison, David Powell, Traude Beilharz, and Co- Corresponding. 2018. “Topconfects: a package for confident effect sizes in differential expression analysis provides improved usability ranking genes of interest.” <https://doi.org/10.1101/343145>.

Kiselev, Vladimir Yu, Kristina Kirschner, Michael T. Schaub, Tallulah Andrews, Andrew Yiu, Tamir Chandra, Kedar N. Natarajan, et al. 2017. “SC3: Consensus clustering of single-cell RNA-seq data.” *Nature Methods* 14 (5): 483–86. <https://doi.org/10.1038/nmeth.4236>.

Kiselev, Vladimir Yu, Andrew Yiu, and Martin Hemberg. 2018. “scmap: projection of single-cell RNA-seq data across data sets.” *Nature Methods* 15 (5): 359–62. <https://doi.org/10.1038/nmeth.4644>.

Satija, Rahul, Jeffrey A Farrell, David Gennert, Alexander F Schier, and Aviv Regev. 2015. “Spatial reconstruction of single-cell gene expression data.” *Nature Biotechnology* 33 (5): 495–502. <https://doi.org/10.1038/nbt.3192>.

Watkins, Nicholas a, Arief Gusnanto, Bernard de Bono, Subhajyoti De, Diego Miranda-Saavedra, Debbie L Hardie, Will G J Angenent, et al. 2009. “A HaemAtlas: characterizing gene expression in differentiated human blood cells.” *Blood* 113 (19): e1–9. <https://doi.org/10.1182/blood-2008-06-162958>.

Zappia, Luke, Belinda Phipson, and Alicia Oshlack. 2017. “Splatter: Simulation of single-cell RNA sequencing data.” *Genome Biology* 18 (1): 1–15. <https://doi.org/10.1186/s13059-017-1305-0>.

Zeisel, A., A. B. M. Manchado, S. Codeluppi, P. Lonnerberg, G. La Manno, A. Jureus, S. Marques, et al. 2015. “Cell types in the mouse cortex and hippocampus revealed by single-cell RNA-seq.” *Science* 347 (6226): 1138–42. <https://doi.org/10.1126/science.aaa1934>.