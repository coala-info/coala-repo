|  |
| --- |
| title: “Introduction to the XINA pagkage” |
| author: “Lang Ho Lee, Sasha A. Singh” |
| date: “February 6, 2019” |
| vignette: > |
| % |
| % |
| % |
| output: |
| knitr:::html\_vignette: |
| df\_print: kable |
| toc: true |
| number\_sections: true |

### 1. Introduction

Quantitative proteomics experiments, using for instance isobaric tandem mass tagging approaches, are conducive to measuring changes in protein abundance over multiple time points in response to one or more conditions or stimulations. The aim of XINA is to determine which proteins exhibit similar patterns within and across experimental conditions, since proteins with co-abundance patterns may have common molecular functions. XINA imports multiple datasets, tags dataset in silico, and combines the data for subsequent subgrouping into multiple clusters. The result is a single output depicting the variation across all conditions. XINA, not only extracts co-abundance profiles within and across experiments, but also incorporates protein-protein interaction databases and integrative resources such as KEGG to infer interactors and molecular functions, respectively, and produces intuitive graphical outputs.

#### 1-1. Main contribution

An easy-to-use software for non-expert users of clustering and network analyses.

#### 1-2. Data inputs

Any type of quantitative proteomics data, labeled or label-free

### 2. XINA websites

<https://cics.bwh.harvard.edu/software> <http://bioconductor.org/packages/XINA/> <https://github.com/langholee/XINA/>

### 3. XINA installation

XINA requires R>=3.5.0.

```
# Install from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("XINA")

# Install from Github
install.packages("devtools")
library(devtools)
install_github("langholee/XINA")
```

The first step is to call XINA

```
library(XINA)
```

To follow this vignette, you may need the following packages

```
install.packages("igraph")
install.packages("ggplot2")
BiocManager::install("STRINGdb")
```

### 4. Example theoretical dataset

We generated an example dataset to show how XINA can be used for your research. To demonstrate XINA functions and allow users to perform similar exercises, we included a module that can generate multiplexed time-series datasets using theoretical data. This data consists of three treatment conditions, ‘Control’, ‘Stimulus1’ and ‘Stimulus2’. Each condition has time series data from 0 hour to 72 hours. As an example, we chose the mTOR pathway to be differentially regulated across the three conditions.

```
# Generate random multiplexed time-series data
random_data_info <- make_random_xina_data()

# The number of proteins
random_data_info$size
```

```
## [1] 500
```

```
# Time points
random_data_info$time_points
```

```
## [1] "0hr"  "2hr"  "6hr"  "12hr" "24hr" "48hr" "72hr"
```

```
# Three conditions
random_data_info$conditions
```

```
## [1] "Control"   "Stimulus1" "Stimulus2"
```

Read and check the randomly generated data

```
Control <- read.csv("Control.csv", check.names=FALSE, stringsAsFactors = FALSE)
Stimulus1 <- read.csv("Stimulus1.csv", check.names=FALSE, stringsAsFactors = FALSE)
Stimulus2 <- read.csv("Stimulus2.csv", check.names=FALSE, stringsAsFactors = FALSE)

head(Control)
```

```
##   Accession                      Description 0hr    2hr    6hr   12hr   24hr   48hr   72hr
## 1      NOA1        nitric oxide associated 1 0.5 0.5856 0.6421 0.2250 0.2535 0.2919 0.4171
## 2      NGFR     nerve growth factor receptor 0.5 0.2732 0.5818 0.4942 0.6939 0.0536 0.2404
## 3      USP3   ubiquitin specific peptidase 3 0.5 0.1212 0.5385 0.0879 0.6023 0.0793 0.7449
## 4    TRIM50   tripartite motif containing 50 0.5 0.0512 0.7441 0.4288 0.3874 0.7012 0.3004
## 5     TDRD3        tudor domain containing 3 0.5 0.1797 0.9943 0.1785 0.5979 0.3265 0.4273
## 6     PEX13 peroxisomal biogenesis factor 13 0.5 0.5222 0.6820 0.6323 0.7239 0.1677 0.8764
```

```
head(Stimulus1)
```

```
##   Accession                      Description 0hr    2hr    6hr   12hr   24hr   48hr   72hr
## 1      NOA1        nitric oxide associated 1 0.5 0.2420 0.5711 0.5917 0.7677 0.4046 0.3541
## 2      NGFR     nerve growth factor receptor 0.5 0.9770 0.2395 0.8964 0.6228 0.2239 0.0487
## 3      USP3   ubiquitin specific peptidase 3 0.5 0.2242 0.7592 0.4395 0.8724 0.0667 0.7786
## 4    TRIM50   tripartite motif containing 50 0.5 0.2096 0.7971 0.1934 0.5031 0.5545 0.1510
## 5     TDRD3        tudor domain containing 3 0.5 0.4983 0.8293 0.3283 0.1004 0.2850 0.9333
## 6     PEX13 peroxisomal biogenesis factor 13 0.5 0.2004 0.9382 0.2524 0.9687 0.9466 0.2373
```

```
head(Stimulus2)
```

```
##   Accession                      Description 0hr    2hr    6hr   12hr   24hr   48hr   72hr
## 1      NOA1        nitric oxide associated 1 0.5 0.3020 0.6135 0.5906 0.4751 0.5712 0.6851
## 2      NGFR     nerve growth factor receptor 0.5 0.8562 0.9725 0.5392 0.0944 0.7913 0.6450
## 3      USP3   ubiquitin specific peptidase 3 0.5 0.3621 0.0962 0.7640 0.4586 0.0198 0.7426
## 4    TRIM50   tripartite motif containing 50 0.5 0.0587 0.4913 0.8301 0.8616 0.5527 0.3116
## 5     TDRD3        tudor domain containing 3 0.5 0.1963 0.2483 0.2495 0.5918 0.8162 0.3798
## 6     PEX13 peroxisomal biogenesis factor 13 0.5 0.3509 0.6016 0.1953 0.2181 0.8386 0.5692
```

Since XINA needs to know which columns have the kinetics data matrix, the user should give a vector containing column names of the kinetics data matrix. These column names have to be the same in all input datasets (Control input, Stimulus1 input and Stimulus2 input).

```
head(Control[random_data_info$time_points])
```

```
##   0hr    2hr    6hr   12hr   24hr   48hr   72hr
## 1 0.5 0.5856 0.6421 0.2250 0.2535 0.2919 0.4171
## 2 0.5 0.2732 0.5818 0.4942 0.6939 0.0536 0.2404
## 3 0.5 0.1212 0.5385 0.0879 0.6023 0.0793 0.7449
## 4 0.5 0.0512 0.7441 0.4288 0.3874 0.7012 0.3004
## 5 0.5 0.1797 0.9943 0.1785 0.5979 0.3265 0.4273
## 6 0.5 0.5222 0.6820 0.6323 0.7239 0.1677 0.8764
```

### 5. Package features

XINA is an R package and can examine, but is not limited to, time-series omics data from multiple experiment conditions. It has three modules: 1. Model-based clustering analysis, 2. coregulation analysis, and 3. Protein-protein interaction network analysis (we used STRING DB for this practice).

#### 5.1 Clustering analysis using model-based clustering or k-means clustering algorithm

XINA implements model-based clustering to classify features (genes or proteins) depending on their expression profiles. The model-based clustering optimizes the number of clusters at minimum Bayesian information criteria (BIC). Model-based clustering is fulfilled by the ‘mclust’ R package [<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5096736/>], which was used by our previously developed tool mIMT-visHTS [<https://www.ncbi.nlm.nih.gov/pubmed/26232111>]. By default, XINA performs sum-normalization for each gene/protein time-series profile [<https://www.ncbi.nlm.nih.gov/pubmed/19861354>]. This step is done to standardize all datasets. Most importantly, XINA assigns an electronic tag to each dataset’s proteins (similar to TMT) in order to combine the multiple datasets (Super dataset) for subsequent clustering.

XINA uses the ‘mclust’ package for the model-based clustering. ‘mclust’ requires the fixed random seed to get reproducible clustering results.

```
set.seed(0)
```

‘nClusters’ is the number of desired clusters. ‘mclust’ will choose the most optimized number of clusters by considering the Bayesian information criteria (BIC). BIC of ‘mclust’ is the negative of normal BIC, thus the higher BIC, the more optimized clustering scheme in ‘mclust’, while lowest BIC is better in statistics.

```
# Data files
data_files <- paste(random_data_info$conditions, ".csv", sep='')
data_files
```

```
## [1] "Control.csv"   "Stimulus1.csv" "Stimulus2.csv"
```

```
# time points of the data matrix
data_column <- random_data_info$time_points
data_column
```

```
## [1] "0hr"  "2hr"  "6hr"  "12hr" "24hr" "48hr" "72hr"
```

Run the model-based clustering

```
# Run the model-based clusteirng
clustering_result <- xina_clustering(data_files, data_column=data_column, nClusters=20)
```

![](data:image/png;base64...)

XINA also supports k-means clustering as well as the model-based clustering

```
clustering_result_km <- xina_clustering(data_files, data_column=data_column, nClusters=20, chosen_model='kmeans')
```

For visualizing clustering results, XINA draws line graphs of the clustering results using ‘plot\_clusters’.

```
library(ggplot2)
theme1 <- theme(title=element_text(size=8, face='bold'),
                axis.text.x = element_text(size=7),
                axis.text.y = element_blank(),
                axis.ticks.x = element_blank(),
                axis.ticks.y = element_blank(),
                axis.title.x = element_blank(),
                axis.title.y = element_blank())
plot_clusters(clustering_result, ggplot_theme=theme1)
```

![](data:image/png;base64...)

XINA calculates sample condition composition, for example the sample composition in the cluster 28 is higher than 95% for Stimulus2. ‘plot\_condition\_composition’ plots these compositions as pie-charts. Sample composition information is insightful because we can find which specific patterns are closely related with each stimulus.

```
theme2 <- theme(legend.key.size = unit(0.3, "cm"),
                legend.text=element_text(size=5),
                title=element_text(size=7, face='bold'))
condition_composition <- plot_condition_compositions(clustering_result, ggplot_theme=theme2)
```

![](data:image/png;base64...)

```
tail(condition_composition)
```

```
##    Cluster Condition  N Percent_ratio
## 47      16 Stimulus2 25         34.25
## 48      17   Control 57         89.06
## 49      17 Stimulus2  7         10.94
## 50      18   Control  1          1.67
## 51      18 Stimulus1 57         95.00
## 52      18 Stimulus2  2          3.33
```

#### 5.2 coregulation analysis

XINA supposes that proteins that comigrate between clusters in response to a given condition are more likely to be coregulated at the biological level than other proteins within the same clusters. For this module, at least two datasets to be compared are needed. XINA supposes features assigned to the same cluster in an experiment condition as a coregulated group. XINA traces the comigrated proteins in different experiment conditions and finds signficant trends by 1) the number of member features (proteins) and 2) the enrichment test using the Fishers exact test. The comigrations are displayed via an alluvial plot. In XINA the comigration is defined as a condition of proteins that show the same expression pattern, classified and evaluated by XINA clustering, in at least two dataset conditions. If there are proteins that are assigned to the same cluster in more than two datasets, XINA considers those proteins to be comigrated. XINA’s ‘alluvial\_enriched’ is designed to find these comigrations and draws alluvial plots for visualizing the found comigrations.

```
classes <- as.vector(clustering_result$condition)
classes
```

```
## [1] "Control"   "Stimulus1" "Stimulus2"
```

```
all_cor <- alluvial_enriched(clustering_result, classes)
```

```
## [1] "length(selected_conditions) > 2, so XINA can't apply the enrichment filter\n            Can't apply the enrichment filter, so pval_threshold is ignored"
```

![](data:image/png;base64...)

```
head(all_cor)
```

```
##   Control Stimulus1 Stimulus2 Comigration_size RowNum PValue Pvalue.adjusted TP FP FN TN Alluvia_color
## 1       0         0         1                9      1     NA              NA NA NA NA NA       #BEBEBE
## 2       0         0         2                8      2     NA              NA NA NA NA NA       #BEBEBE
## 3       0         0         3                7      3     NA              NA NA NA NA NA       #BEBEBE
## 4       0         0         4                3      4     NA              NA NA NA NA NA       #BEBEBE
## 5       0         0         5                3      5     NA              NA NA NA NA NA       #BEBEBE
## 6       0         0         6                1      6     NA              NA NA NA NA NA       #BEBEBE
```

You can narrow down comigrations by using the size (the number of comigrated proteins) filter.

```
cor_bigger_than_5 <- alluvial_enriched(clustering_result, classes, comigration_size=5)
```

```
## [1] "length(selected_conditions) > 2, so XINA can't apply the enrichment filter\n            Can't apply the enrichment filter, so pval_threshold is ignored"
```

![](data:image/png;base64...)

```
head(cor_bigger_than_5)
```

```
##   Control Stimulus1 Stimulus2 Comigration_size RowNum PValue Pvalue.adjusted TP FP FN TN Alluvia_color
## 1       0         0         1                9      1     NA              NA NA NA NA NA       #BEBEBE
## 2       0         0         2                8      2     NA              NA NA NA NA NA       #BEBEBE
## 3       0         0         3                7      3     NA              NA NA NA NA NA       #BEBEBE
## 7       0         0         7                6      7     NA              NA NA NA NA NA       #BEBEBE
## 8       0         0         8                6      8     NA              NA NA NA NA NA       #BEBEBE
## 9       0         0         9                6      9     NA              NA NA NA NA NA       #BEBEBE
```

#### 5.3 Network analysis

XINA conducts protein-protein interaction (PPI) network analysis through implementing ‘igraph’ and ‘STRINGdb’ R packages. XINA constructs PPI networks for comigrated protein groups as well as individual clusters of a specific experiment (dataset) condition. In the constructed networks, XINA finds influential players by calculating various network centrality calculations including betweenness, closeness and eigenvector scores. For the selected comigrated groups, XINA can calculate an enrichment test based on gene ontology and KEGG pathway terms to help understanding comigrated groups.

XINA’s example dataset is from human gene names, so download human PPI database from STRING DB and run XINA PPI network analysis.

```
library(STRINGdb)
string_db <- STRINGdb$new( version="10", species=9606, score_threshold=0, input_directory="" )
string_db

xina_result <- xina_analysis(clustering_result, string_db)
```

You can draw PPI networks of all the XINA clusters using ‘xina\_plots’ function easily. PPI network plots will be stored in the working directory

```
# XINA network plots labeled gene names
xina_plot_all(xina_result, clustering_result)
```

If you want to see more, please check “README.md” of our Github XINA repository.