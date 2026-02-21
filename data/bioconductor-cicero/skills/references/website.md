# Single Cell ATAC-seq Analysis with Cicero

#### Hannah Pliner

#### 2025-10-29

* [Introduction:](#introduction)
* [Installing Cicero](#installing-cicero)
* [Constructing cis-regulatory networks](#constructing-cis-regulatory-networks)
  + [Running Cicero](#running-cicero)
    - [The CellDataSet class](#the-celldataset-class)
    - [Create a Cicero CDS](#create-a-cicero-cds)
    - [Run Cicero](#run-cicero)
  + [Visualizing Cicero Connections](#visualizing-cicero-connections)
  + [Comparing Cicero connections to other datasets](#comparing-cicero-connections-to-other-datasets)
  + [Finding Cis-Coaccessibility Networks (CCANS)](#finding-cis-coaccessibility-networks-ccans)
  + [Cicero gene activity scores](#cicero-gene-activity-scores)
* [Single-cell accessibility trajectories](#single-cell-accessibility-trajectories)
  + [Constructing trajectories with accessibility data](#constructing-trajectories-with-accessibility-data)
    - [Aggregation: the primary method for addressing sparsity](#aggregation-the-primary-method-for-addressing-sparsity)
  + [Choose sites for dimensionality reduction](#choose-sites-for-dimensionality-reduction)
    - [Choosing sites that define progress](#choosing-sites-that-define-progress)
    - [Reduce the dimensionality of the data and order cells](#reduce-the-dimensionality-of-the-data-and-order-cells)
  + [Differential Accessibility Analysis](#differential-accessibility-analysis)
    - [Visualizing accessibility across pseudotime](#visualizing-accessibility-across-pseudotime)
    - [Running differentialGeneTest with single-cell chromatin accessibility data](#running-differentialgenetest-with-single-cell-chromatin-accessibility-data)
* [References](#references)
* [Citation](#citation)
* [Session Info](#session-info)

This vignette is a condensed version of the documentation pages on the [Cicero website](https://cole-trapnell-lab.github.io/cicero-release). Please check out the website for more details.

# Introduction:

The main purpose of Cicero is to use single-cell chromatin accessibility data to predict regions of the genome that are more likely to be in physical proximity in the nucleus. This can be used to identify putative enhancer-promoter pairs, and to get a sense of the overall stucture of the cis-architecture of a genomic region.

Because of the sparsity of single-cell data, cells must be aggregated by similarity to allow robust correction for various technical factors in the data.

Ultimately, Cicero provides a “Cicero co-accessibility” score between -1 and 1 between each pair of accessible peaks within a user defined distance where a higher score indicates higher co-accessibility.

In addition, the Cicero package provides an extension toolkit for analyzing single-cell ATAC-seq experiments using the framework provided by the single-cell RNA-seq analysis software, [Monocle](https://cole-trapnell-lab.github.io/monocle-release). This vignette provides an overview of a single-cell ATAC-Seq analysis workflow with Cicero. For further information and more options, please see the manual pages for the Cicero R package, the [Cicero website](https://cole-trapnell-lab.github.io/cicero-release) and our publications.

Cicero can help you perform two main types of analysis:

* **Constructing and analyzing cis-regulatory networks.** Cicero analyzes co-accessibility to identify putative cis-regulatory interactions, and uses various techniques to visualize and analyze them.
* **General single-cell chromatin accessibility analysis.** Cicero also extends the software package Monocle to allow for identification of differential accessibility, clustering, visualization, and trajectory reconstruction using single-cell chromatin accessibility data.

# Installing Cicero

1. Download the package from Bioconductor.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
 BiocManager::install("cicero")
```

Or install the development version of the package from Github.

```
BiocManager::install(cole-trapnell-lab/cicero)
```

2. Load the package into R session.

```
 library(cicero)
```

# Constructing cis-regulatory networks

## Running Cicero

### The CellDataSet class

Cicero holds data in objects of the CellDataSet (CDS) class. The class is derived from the Bioconductor ExpressionSet class, which provides a common interface familiar to those who have analyzed microarray experiments with Bioconductor. Monocle provides detailed documentation about how to generate an input CDS [here](http://cole-trapnell-lab.github.io/monocle-release/docs/#the-celldataset-class).

To modify the CDS object to hold chromatin accessibility rather than expression data, Cicero uses peaks as its feature data fData rather than genes or transcripts. Specifically, many Cicero functions require peak information in the form chr1\_10390134\_10391134. For example, an input fData table might look like this:

|  | site\_name | chromosome | bp1 | bp2 |
| --- | --- | --- | --- | --- |
| chr10\_100002625\_100002940 | chr10\_100002625\_100002940 | 10 | 100002625 | 100002940 |
| chr10\_100006458\_100007593 | chr10\_100006458\_100007593 | 10 | 100006458 | 100007593 |
| chr10\_100011280\_100011780 | chr10\_100011280\_100011780 | 10 | 100011280 | 100011780 |
| chr10\_100013372\_100013596 | chr10\_100013372\_100013596 | 10 | 100013372 | 100013596 |
| chr10\_100015079\_100015428 | chr10\_100015079\_100015428 | 10 | 100015079 | 100015428 |

The Cicero package includes a small dataset called cicero\_data as an example.

```
data(cicero_data)
```

For convenience, Cicero includes a function called make\_atac\_cds. This function takes as input a data.frame or a path to a file in a sparse matrix format. Specifically, this file should be a tab-delimited text file with three columns. The first column is the peak coordinates in the form “chr10\_100013372\_100013596”, the second column is the cell name, and the third column is an integer that represents the number of reads from that cell overlapping that peak. The file should not have a header line.

For example:

|  |  |  |
| --- | --- | --- |
| chr10\_100002625\_100002940 | cell1 | 1 |
| chr10\_100006458\_100007593 | cell2 | 2 |
| chr10\_100006458\_100007593 | cell3 | 1 |
| chr10\_100013372\_100013596 | cell2 | 1 |
| chr10\_100015079\_100015428 | cell4 | 3 |

The output of make\_atac\_cds is a valid CDS object ready to be input into downstream Cicero functions.

```
input_cds <- make_atac_cds(cicero_data, binarize = TRUE)
```

### Create a Cicero CDS

Because single-cell chromatin accessibility data is extremely sparse, accurate estimation of co-accessibility scores requires us to aggregate similar cells to create more dense count data. Cicero does this using a k-nearest-neighbors approach which creates overlapping sets of cells. Cicero constructs these sets based on a reduced dimension coordinate map of cell similarity, for example, from a tSNE or DDRTree map.

You can use any dimensionality reduction method to base your aggregated CDS on. We will show you how to create two versions, tSNE and DDRTree (below). Both of these dimensionality reduction methods are available from [Monocle](http://cole-trapnell-lab.github.io/monocle-release/) (and loaded by Cicero).

Once you have your reduced dimension coordinate map, you can use the function make\_cicero\_cds to create your aggregated CDS object. The input to make\_cicero\_cds is your input CDS object, and your reduced dimension coordinate map. The reduced dimension map reduced\_coordinates should be in the form of a data.frame or a matrix where the row names match the cell IDs from the pData table of your CDS. The columns of reduced\_coordinates should be the coordinates of the reduced dimension object, for example:

|  | ddrtree\_coord1 | ddrtree\_coord2 |
| --- | --- | --- |
| cell1 | -0.7084047 | -0.7232994 |
| cell2 | -4.4767964 | 0.8237284 |
| cell3 | 1.4870098 | -0.4723493 |

Here is an example of both dimensionality reduction and creation of a Cicero CDS. Using Monocle as a guide, we first find tSNE coordinates for our input\_cds:

```
set.seed(2017)
input_cds <- detectGenes(input_cds)
input_cds <- estimateSizeFactors(input_cds)
input_cds <- reduceDimension(input_cds, max_components = 2, num_dim=6,
                        reduction_method = 'tSNE', norm_method = "none")
```

For more information on the above code, see the [Monocle](http://cole-trapnell-lab.github.io/monocle-release/) website section on clustering cells.

Next, we access the tSNE coordinates from the input CDS object where they are stored by Monocle and run make\_cicero\_cds:

```
tsne_coords <- t(reducedDimA(input_cds))
row.names(tsne_coords) <- row.names(pData(input_cds))
cicero_cds <- make_cicero_cds(input_cds, reduced_coordinates = tsne_coords)
```

### Run Cicero

The main function of the Cicero package is to estimate the co-accessiblity of sites in the genome in order to predict cis-regulatory interactions. There are two ways to get this information:

* **run\_cicero, get Cicero outputs with all defaults** The function run\_cicero will call each of the relevant pieces of Cicero code using default values, and calculating best-estimate parameters as it goes. For most users, this will be the best place to start.
* **Call functions separately, for more flexibility** For users wanting more flexibility in the parameters that are called, and those that want access to intermediate information, Cicero allows you to call each of the component parts separately. More information about running function separately is available on the package manual pages and on the [Cicero website](https://cole-trapnell-lab.github.io/cicero-release).

The easiest way to get Cicero co-accessibility scores is to run run\_cicero. To run run\_cicero, you need a cicero CDS object (created above) and a genome coordinates file, which contains the lengths of each of the chromosomes in your organism. The human hg19 coordinates are included with the package and can be accessed with data(“human.hg19.genome”). Here is an example call, continuing with our example data:

```
data("human.hg19.genome")
sample_genome <- subset(human.hg19.genome, V1 == "chr18")
sample_genome$V2[1] <- 10000000
conns <- run_cicero(cicero_cds, sample_genome, sample_num = 2) # Takes a few minutes to run
head(conns)
```

## Visualizing Cicero Connections

The Cicero package includes a general plotting function for visualizing co-accessibility called plot\_connections. This function uses the Gviz framework for plotting genome browser-style plots. We have adapted a function from the Sushi R package for mapping connections. plot\_connections has many options, some detailed in the Advanced Visualization section on the [Cicero website](https://cole-trapnell-lab.github.io/cicero-release), but to get a basic plot from your co-accessibility table is quite simple:

```
data(gene_annotation_sample)
plot_connections(conns, "chr18", 8575097, 8839855,
                 gene_model = gene_annotation_sample,
                 coaccess_cutoff = .25,
                 connection_width = .5,
                 collapseTranscripts = "longest" )
```

## Comparing Cicero connections to other datasets

Often, it is useful to compare Cicero connections to other datasets with similar kinds of links. For example, you might want to compare the output of Cicero to ChIA-PET ligations. To do this, Cicero includes a function called compare\_connections. This function takes as input two data frames of connection pairs, conns1 and conns2, and returns a logical vector of which connections from conns1 are found in conns2. The comparison in this function is conducted using the GenomicRanges package, and uses the max\_gap argument from that package to allow slop in the comparisons.

For example, if we wanted to compare our Cicero predictions to a set of (made-up) ChIA-PET connections, we could run:

```
chia_conns <-  data.frame(Peak1 = c("chr18_10000_10200", "chr18_10000_10200",
                                    "chr18_49500_49600"),
                          Peak2 = c("chr18_10600_10700", "chr18_111700_111800",
                                    "chr18_10600_10700"))

conns$in_chia <- compare_connections(conns, chia_conns)
```

You may find that this overlap is too strict when comparing completely distinct datasets. Looking carefully, the 2nd line of the ChIA-PET data matches fairly closely to the last line shown of conns. The difference is only ~67 base pairs, which could be a matter of peak-calling. This is where the max\_gap parameter can be useful:

```
conns$in_chia_100 <- compare_connections(conns, chia_conns, maxgap=100)

head(conns)
```

In addition, Cicero’s plotting function has a way to compare datasets visually. To do this, use the comparison\_track argument. The comparison data frame must include a third columns beyond the first two peak columns called “coaccess”. This is how the plotting function determines the height of the plotted connections. This could be a quantitative measure, like the number of ligations in ChIA-PET, or simply a column of 1s. More info on plotting options in manual pages ?plot\_connections and in the Advanced Visualization section of the [Cicero website](https://cole-trapnell-lab.github.io/cicero-release).

```
# Add a column of 1s called "coaccess"
chia_conns <-  data.frame(Peak1 = c("chr18_10000_10200", "chr18_10000_10200",
                                    "chr18_49500_49600"),
                          Peak2 = c("chr18_10600_10700", "chr18_111700_111800",
                                    "chr18_10600_10700"),
                          coaccess = c(1, 1, 1))

plot_connections(conns, "chr18", 10000, 112367,
                 gene_model = gene_annotation_sample,
                 coaccess_cutoff = 0,
                 connection_width = .5,
                 comparison_track = chia_conns,
                 include_axis_track = FALSE,
                 collapseTranscripts = "longest")
```

## Finding Cis-Coaccessibility Networks (CCANS)

In addition to pairwise co-accessibility scores, Cicero also has a function to find Cis-Co-accessibility Networks (CCANs), which are modules of sites that are highly co-accessible with one another. We use the Louvain community detection algorithm (Blondel et al., 2008) to find clusters of sites that tend to be co-accessible. The function generate\_ccans takes as input a connection data frame and outputs a data frame with CCAN assignments for each input peak. Sites not included in the output data frame were not assigned a CCAN.

The function generate\_ccans has one optional input called coaccess\_cutoff\_override. When coaccess\_cutoff\_override is NULL, the function will determine and report an appropriate co-accessibility score cutoff value for CCAN generation based on the number of overall CCANs at varying cutoffs. You can also set coaccess\_cutoff\_override to be a numeric between 0 and 1, to override the cutoff-finding part of the function. This option is useful if you feel that the cutoff found automatically was too strict or loose, or for speed if you are rerunning the code and know what the cutoff will be, since the cutoff finding procedure can be slow.

```
CCAN_assigns <- generate_ccans(conns)

head(CCAN_assigns)
```

## Cicero gene activity scores

We have found that often, accessibility at promoters is a poor predictor of gene expression. However, using Cicero links, we are able to get a better sense of the overall accessibility of a promoter and it’s associated distal sites. This combined score of regional accessibility has a better concordance with gene expression. We call this score the Cicero gene activity score, and it is calculated using two functions.

The initial function is called build\_gene\_activity\_matrix. This function takes an input CDS and a Cicero connection list, and outputs an unnormalized table of gene activity scores. **IMPORTANT**: the input CDS must have a column in the fData table called “gene” which indicates the gene if that peak is a promoter, and NA if the peak is distal. One way to add this column is demonstrated below.

The output of build\_gene\_activity\_matrix is unnormalized. It must be normalized using a second function called normalize\_gene\_activities. If you intend to compare gene activities across different datasets of subsets of data, then all gene activity subsets should be normalized together, by passing in a list of unnormalized matrices. If you only wish to normalized one matrix, simply pass it to the function on its own. normalize\_gene\_activities also requires a named vector of of total accessible sites per cell. This is easily found in the pData table of your CDS, called “num\_genes\_expressed”. See below for an example.

```
#### Add a column for the pData table indicating the gene if a peak is a promoter ####
# Create a gene annotation set that only marks the transcription start sites of
# the genes. We use this as a proxy for promoters.
# To do this we need the first exon of each transcript
pos <- subset(gene_annotation_sample, strand == "+")
pos <- pos[order(pos$start),]
pos <- pos[!duplicated(pos$transcript),] # remove all but the first exons per transcript
pos$end <- pos$start + 1 # make a 1 base pair marker of the TSS

neg <- subset(gene_annotation_sample, strand == "-")
neg <- neg[order(neg$start, decreasing = TRUE),]
neg <- neg[!duplicated(neg$transcript),] # remove all but the first exons per transcript
neg$start <- neg$end - 1

gene_annotation_sub <- rbind(pos, neg)

# Make a subset of the TSS annotation columns containing just the coordinates
# and the gene name
gene_annotation_sub <- gene_annotation_sub[,c(1:3, 8)]

# Rename the gene symbol column to "gene"
names(gene_annotation_sub)[4] <- "gene"

input_cds <- annotate_cds_by_site(input_cds, gene_annotation_sub)

head(fData(input_cds))

#### Generate gene activity scores ####
# generate unnormalized gene activity matrix
unnorm_ga <- build_gene_activity_matrix(input_cds, conns)

# remove any rows/columns with all zeroes
unnorm_ga <- unnorm_ga[!Matrix::rowSums(unnorm_ga) == 0, !Matrix::colSums(unnorm_ga) == 0]

# make a list of num_genes_expressed
num_genes <- pData(input_cds)$num_genes_expressed
names(num_genes) <- row.names(pData(input_cds))

# normalize
cicero_gene_activities <- normalize_gene_activities(unnorm_ga, num_genes)

# if you had two datasets to normalize, you would pass both:
# num_genes should then include all cells from both sets
unnorm_ga2 <- unnorm_ga
cicero_gene_activities <- normalize_gene_activities(list(unnorm_ga, unnorm_ga2), num_genes)
```

# Single-cell accessibility trajectories

The second major function of the Cicero package is to extend Monocle 2 for use with single-cell accessibility data. The main obstacle to overcome with chromatin accessibility data is the sparsity, so most of the extensions and methods are designed to address that.

## Constructing trajectories with accessibility data

We strongly recommend that you consult the Monocle website, especially [this section](http://cole-trapnell-lab.github.io/monocle-release/docs/#constructing-single-cell-trajectories) prior to reading about Cicero’s extension of the Monocle analysis described. Briefly, Monocle infers pseudotime trajectories in three steps:

1. Choosing sites that define progress
2. Reducing the dimensionality of the data
3. Ordering cells in pseudotime

We will describe how each piece is modified for use with sparse single-cell chromatin accessibility data.

### Aggregation: the primary method for addressing sparsity

The primary way that the Cicero package deals with the sparsity of single-cell chromatin accessibility data is through aggregation. Aggregating the counts of either single cells or single peaks allows us to produce a “consensus” count matrix, reducing noise and allowing us to move out of the binary regime. Under this grouping, the number of cells in which a particular site is accessible can be modeled with a binomial distribution or, for sufficiently large groups, the corresponding Gaussian approximation. Modeling grouped accessibility counts as normally distributed allows Cicero to easily adjust them for arbitrary technical covariates by simply fitting a linear model and taking the residuals with respect to it as the adjusted accessibility score for each group of cells. We demonstrate how to apply this grouping practically below.

#### aggregate\_nearby\_peaks

The primary aggregation used for trajectory reconstruction is between nearby peaks. This keeps single cells separate while aggregating regions of the genome and looking for chromatin accessibility within them. The function aggregate\_nearby\_peaks finds sites within a certain distance of each other and aggregates them together by summing their counts. Depending on the density of your data, you may want to try different distance parameters. In published work we have used 1,000 and 10,000.

```
data("cicero_data")
input_cds <- make_atac_cds(cicero_data)

# Add some cell meta-data
data("cell_data")
pData(input_cds) <- cbind(pData(input_cds), cell_data[row.names(pData(input_cds)),])
pData(input_cds)$cell <- NULL

agg_cds <- aggregate_nearby_peaks(input_cds, distance = 10000)
#> 'as(<dgCMatrix>, "dgTMatrix")' is deprecated.
#> Use 'as(., "TsparseMatrix")' instead.
#> See help("Deprecated") and help("Matrix-deprecated").
agg_cds <- detectGenes(agg_cds)
agg_cds <- estimateSizeFactors(agg_cds)
agg_cds <- estimateDispersions(agg_cds)
#> Warning: `group_by_()` was deprecated in dplyr 0.7.0.
#> ℹ Please use `group_by()` instead.
#> ℹ See vignette('programming') for more help
#> ℹ The deprecated feature was likely used in the monocle package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: `select_()` was deprecated in dplyr 0.7.0.
#> ℹ Please use `select()` instead.
#> ℹ The deprecated feature was likely used in the monocle package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Removing 37 outliers
```

## Choose sites for dimensionality reduction

### Choosing sites that define progress

There are several options for choosing the sites to use during dimensionality reduction. Monocle has a discussion about the options [here](http://cole-trapnell-lab.github.io/monocle-release/docs/#alternative-choices-for-ordering-genes). Any of these options could be used with your new aggregated CDS, depending on the information you have a available in your dataset. Here, we will show two examples:

#### Choose sites by differential analysis

If your data has defined beginning and end points, you can determine which sites define progress by a differential accessibility test. We use Monocle’s differentialGeneTest function looking for sites that are different in the timepoint groups.

```
# This takes a few minutes to run
diff_timepoint <- differentialGeneTest(agg_cds,
                      fullModelFormulaStr="~timepoint + num_genes_expressed")

# We chose a very high q-value cutoff because there are
# so few sites in the sample dataset, in general a q-value
# cutoff in the range of 0.01 to 0.1 would be appropriate
ordering_sites <- row.names(subset(diff_timepoint, qval < .5))
length(ordering_sites)
#> [1] 255
```

#### Choose sites by dpFeature

Alternatively, you can choose sites for dimensionality reduction by using Monocle’s dpFeature method. dpFeature chooses sites based on how they differ among clusters of cells. Here, we give some example code reproduced from Monocle, for more information, see the Monocle description.

```
plot_pc_variance_explained(agg_cds, return_all = FALSE) #Choose 2 PCs
agg_cds <- reduceDimension(agg_cds,
                              max_components = 2,
                              norm_method = 'log',
                              num_dim = 2,
                              reduction_method = 'tSNE',
                              verbose = TRUE)

agg_cds <- clusterCells(agg_cds, verbose = FALSE)

plot_cell_clusters(agg_cds, color_by = 'as.factor(Cluster)') + theme(text = element_text(size=8))
clustering_DA_sites <- differentialGeneTest(agg_cds[1:10,], #Subset for example only
                                             fullModelFormulaStr = '~Cluster')

# Not run because using Option 1 to continue
# ordering_sites <-
#  row.names(clustering_DA_sites)[order(clustering_DA_sites$qval)][1:1000]
```

### Reduce the dimensionality of the data and order cells

However you choose your ordering sites, the first step of dimensionality reduction is to use setOrderingFilter to mark the sites you want to use for dimesionality reduction. In the following figures, we are using the ordering\_sites from “Choose sites by differential analysis” above.

```
agg_cds <- setOrderingFilter(agg_cds, ordering_sites)
```

Next, we use DDRTree to reduce dimensionality and then order the cells along the trajectory. Importantly, we use num\_genes\_expressed in our residual model formula to account for overall assay efficiency.

```
agg_cds <- reduceDimension(agg_cds, max_components = 2,
          residualModelFormulaStr="~num_genes_expressed",
          reduction_method = 'DDRTree')

# skipped due to monocle bug
# agg_cds <- suppressWarnings(orderCells(agg_cds))

plot_cell_trajectory(agg_cds, color_by = "timepoint")
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the monocle package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the monocle package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the monocle package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

Once you have a cell trajectory, you need to make sure that pseudotime proceeds how you expect. In our example, we want pseudotime to start where most of the time 0 cells are located and proceed towards the later timepoints. Further information on this can be found [here](http://cole-trapnell-lab.github.io/monocle-release/docs/#constructing-single-cell-trajectories) on the Monocle website. We first color our trajectory plot by State, which is how Monocle assigns segments of the tree.

```
# skipped due to monocle bug
#plot_cell_trajectory(agg_cds, color_by = "State")
```

From this plot, we can see that the beginning of pseudotime should be from state 4. We now reorder cells setting the root state to 4. We can then check that the ordering makes sense by coloring the plot by Pseudotime.

```
# skipped due to monocle bug
#agg_cds <- suppressWarnings(orderCells(agg_cds, root_state = 4))
#plot_cell_trajectory(agg_cds, color_by = "Pseudotime")
```

Now that we have Pseudotime values for each cell (pData(agg\_cds)$Pseudotime), we need to assign these values back to our original CDS object. In addition, we will assign the State information back to the original CDS.

```
# skipped due to monocle bug
#pData(input_cds)$Pseudotime <- pData(agg_cds)[colnames(input_cds),]$Pseudotime
#pData(input_cds)$State <- pData(agg_cds)[colnames(input_cds),]$State
```

## Differential Accessibility Analysis

Once you have your cells ordered in pseudotime, you can ask where in the genome chromatin accessibility is changing across time. If you know of specific sites that are important to your system, you may want to visualize the accessibility at those sites across pseudotime.

### Visualizing accessibility across pseudotime

For simplicity, we will exclude the branch in our trajectory to make our trajectory linear.

```
# skipped due to monocle bug
#input_cds_lin <- input_cds[,row.names(subset(pData(input_cds), State  != 5))]

#plot_accessibility_in_pseudotime(input_cds_lin[c("chr18_38156577_38158261",
#                                                 "chr18_48373358_48374180",
#                                                 "chr18_60457956_60459080")])
```

### Running differentialGeneTest with single-cell chromatin accessibility data

In the previous section, we used aggregation of sites to discover cell-level information (cell pseudotime). In this section, we are interested in a site-level statistic (whether a site is changing in pseudotime), so we will aggregate similar cells. To do this, Cicero has a useful function called aggregate\_by\_cell\_bin.

#### aggregate\_by\_cell\_bin

We use the function aggregate\_by\_cell\_bin to aggregate our input CDS object by a column in the pData table. In this example, we will assign cells to bins by cutting the pseudotime trajectory into 10 parts.

```
# skipped due to monocle bug
#pData(input_cds_lin)$cell_subtype <- cut(pData(input_cds_lin)$Pseudotime, 10)
#binned_input_lin <- aggregate_by_cell_bin(input_cds_lin, "cell_subtype")
```

We are now ready to run Monocle’s differentialGeneTest function to find sites that are differentially accessible across pseudotime. In this example, we include num\_genes\_expressed as a covariate to subtract its effect.

```
# skipped due to monocle bug
#diff_test_res <- differentialGeneTest(binned_input_lin[1:10,], #Subset for example only
#    fullModelFormulaStr="~sm.ns(Pseudotime, df=3) + sm.ns(num_genes_expressed, df=3)",
#    reducedModelFormulaStr="~sm.ns(num_genes_expressed, df=3)", cores=1)

#head(diff_test_res)
```

# References

Blondel, V.D., Guillaume, J.-L., Lambiotte, R., and Lefebvre, E. (2008). Fast unfolding of communities in large networks.

Dekker, J., Marti-Renom, M.A., and Mirny, L.A. (2013). Exploring the three-dimensional organization of genomes: interpreting chromatin interaction data. Nat. Rev. Genet. 14, 390–403.

Sanborn, A.L., Rao, S.S.P., Huang, S.-C., Durand, N.C., Huntley, M.H., Jewett, A.I., Bochkov, I.D., Chinnappan, D., Cutkosky, A., Li, J., et al. (2015). Chromatin extrusion explains key features of loop and domain formation in wild-type and engineered genomes. . Proc. Natl. Acad. Sci. U. S. A. 112, E6456–E6465.

Sexton, T., Yaffe, E., Kenigsberg, E., Bantignies, F., Leblanc, B., Hoichman, M., Parrinello, H., Tanay, A., and Cavalli, G. (2012). Three-Dimensional Folding and Functional Organization Principles of the Drosophila Genome. . Cell 148:3, 458-472.

# Citation

```
citation("cicero")
#> To cite package 'cicero' in publications use:
#>
#>   Hannah A. Pliner, Jay Shendure & Cole Trapnell et. al. (2018). Cicero
#>   Predicts cis-Regulatory DNA Interactions from Single-Cell Chromatin
#>   Accessibility Data. Molecular Cell, 71, 858-871.e8.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Article{,
#>     title = {Cicero Predicts cis-Regulatory DNA Interactions from Single-Cell Chromatin Accessibility Data},
#>     journal = {Molecular Cell},
#>     volume = {71},
#>     number = {5},
#>     pages = {858 - 871.e8},
#>     year = {2018},
#>     issn = {1097-2765},
#>     doi = {https://doi.org/10.1016/j.molcel.2018.06.044},
#>     author = {Hannah A. Pliner and Jonathan S. Packer and José L. McFaline-Figueroa and Darren A. Cusanovich and Riza M. Daza and Delasa Aghamirzaie and Sanjay Srivatsan and Xiaojie Qiu and Dana Jackson and Anna Minkina and Andrew C. Adey and Frank J. Steemers and Jay Shendure and Cole Trapnell},
#>   }
```

# Session Info

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
#>  [1] grid      splines   stats4    stats     graphics  grDevices utils
#>  [8] datasets  methods   base
#>
#> other attached packages:
#>  [1] cicero_1.28.0        Gviz_1.54.0          GenomicRanges_1.62.0
#>  [4] Seqinfo_1.0.0        IRanges_2.44.0       S4Vectors_0.48.0
#>  [7] monocle_2.38.0       DDRTree_0.1.5        irlba_2.3.5.1
#> [10] VGAM_1.1-13          ggplot2_4.0.0        Biobase_2.70.0
#> [13] BiocGenerics_0.56.0  generics_0.1.4       Matrix_1.7-4
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0              magrittr_2.0.4
#>   [5] GenomicFeatures_1.62.0      farver_2.1.2
#>   [7] rmarkdown_2.30              BiocIO_1.20.0
#>   [9] vctrs_0.6.5                 memoise_2.0.1
#>  [11] fastICA_1.2-7               Rsamtools_2.26.0
#>  [13] RCurl_1.98-1.17             base64enc_0.1-3
#>  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
#>  [17] progress_1.2.3              curl_7.0.0
#>  [19] SparseArray_1.10.0          Formula_1.2-5
#>  [21] sass_0.4.10                 bslib_0.9.0
#>  [23] HSMMSingleCell_1.29.0       htmlwidgets_1.6.4
#>  [25] plyr_1.8.9                  httr2_1.2.1
#>  [27] cachem_1.1.0                GenomicAlignments_1.46.0
#>  [29] igraph_2.2.1                lifecycle_1.0.4
#>  [31] pkgconfig_2.0.3             R6_2.6.1
#>  [33] fastmap_1.2.0               MatrixGenerics_1.22.0
#>  [35] digest_0.6.37               colorspace_2.1-2
#>  [37] AnnotationDbi_1.72.0        Hmisc_5.2-4
#>  [39] RSQLite_2.4.3               labeling_0.4.3
#>  [41] filelock_1.0.3              httr_1.4.7
#>  [43] abind_1.4-8                 compiler_4.5.1
#>  [45] proxy_0.4-27                bit64_4.6.0-1
#>  [47] withr_3.0.2                 htmlTable_2.4.3
#>  [49] S7_0.2.0                    backports_1.5.0
#>  [51] BiocParallel_1.44.0         viridis_0.6.5
#>  [53] DBI_1.2.3                   biomaRt_2.66.0
#>  [55] rappdirs_0.3.3              DelayedArray_0.36.0
#>  [57] rjson_0.2.23                tools_4.5.1
#>  [59] foreign_0.8-90              nnet_7.3-20
#>  [61] glue_1.8.0                  restfulr_0.0.16
#>  [63] checkmate_2.3.3             Rtsne_0.17
#>  [65] cluster_2.1.8.1             reshape2_1.4.4
#>  [67] gtable_0.3.6                BSgenome_1.78.0
#>  [69] ensembldb_2.34.0            data.table_1.17.8
#>  [71] hms_1.1.4                   XVector_0.50.0
#>  [73] RANN_2.6.2                  pillar_1.11.1
#>  [75] stringr_1.5.2               limma_3.66.0
#>  [77] dplyr_1.1.4                 BiocFileCache_3.0.0
#>  [79] lattice_0.22-7              deldir_2.0-4
#>  [81] rtracklayer_1.70.0          bit_4.6.0
#>  [83] biovizBase_1.58.0           tidyselect_1.2.1
#>  [85] Biostrings_2.78.0           knitr_1.50
#>  [87] gridExtra_2.3               ProtGenerics_1.42.0
#>  [89] SummarizedExperiment_1.40.0 xfun_0.53
#>  [91] statmod_1.5.1               matrixStats_1.5.0
#>  [93] pheatmap_1.0.13             leidenbase_0.1.35
#>  [95] stringi_1.8.7               UCSC.utils_1.6.0
#>  [97] lazyeval_0.2.2              yaml_2.3.10
#>  [99] evaluate_1.0.5              codetools_0.2-20
#> [101] cigarillo_1.0.0             interp_1.1-6
#> [103] tibble_3.3.0                cli_3.6.5
#> [105] rpart_4.1.24                jquerylib_0.1.4
#> [107] dichromat_2.0-0.1           Rcpp_1.1.0
#> [109] GenomeInfoDb_1.46.0         dbplyr_2.5.1
#> [111] png_0.1-8                   XML_3.99-0.19
#> [113] parallel_4.5.1              assertthat_0.2.1
#> [115] blob_1.2.4                  prettyunits_1.2.0
#> [117] jpeg_0.1-11                 latticeExtra_0.6-31
#> [119] AnnotationFilter_1.34.0     bitops_1.0-9
#> [121] viridisLite_0.4.2           slam_0.1-55
#> [123] VariantAnnotation_1.56.0    scales_1.4.0
#> [125] crayon_1.5.3                combinat_0.0-8
#> [127] rlang_1.1.6                 KEGGREST_1.50.0
```