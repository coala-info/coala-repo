# A Guide to multiClust

#### Nathan Lawlor

#### 2025-10-30

* [Introduction](#introduction)
* [1. Getting Started](#getting-started)
  + [1.1 Obtaining a Gene Expression Dataset and Clinical Information](#obtaining-a-gene-expression-dataset-and-clinical-information)
    - [1.2 Normalization of Gene Expression Datasets](#normalization-of-gene-expression-datasets)
    - [1.3 Formatting the Patient Clinical Information](#formatting-the-patient-clinical-information)
* [2. Loading Your Gene Probe Expression Dataset into R](#loading-your-gene-probe-expression-dataset-into-r)
  + [2.1 Loading Text Files Containing Gene Expression Matrix](#loading-text-files-containing-gene-expression-matrix)
* [3. Gene Selection Algorithms](#gene-selection-algorithms)
  + [3.1 Determining the Number of Desired Probes or Genes](#determining-the-number-of-desired-probes-or-genes)
    - [3.2 Choosing a Gene Selection Algorithm](#choosing-a-gene-selection-algorithm)
* [4. Cluster Analysis of Selected Genes and Samples](#cluster-analysis-of-selected-genes-and-samples)
  + [4.1 Determining the Number of Clusters to Divide Samples Into](#determining-the-number-of-clusters-to-divide-samples-into)
    - [4.2 Kmeans or Hierarchical Clustering of Genes/Probes and Samples](#kmeans-or-hierarchical-clustering-of-genesprobes-and-samples)
* [5. Obtaining the Average Expression for Each Gene/Probe in Each Cluster](#obtaining-the-average-expression-for-each-geneprobe-in-each-cluster)
* [6. Clinical Analysis of Selected Gene Probes and Samples](#clinical-analysis-of-selected-gene-probes-and-samples)
* [7. References](#references)

## Introduction

Whole transcriptomic profiles are useful for studying the expression levels of thousands of genes across samples. Clustering algorithms are used to identify patterns in these profiles to determine clinically relevant subgroups. Feature selection is a critical integral part of the process. Currently, there are many feature selection and clustering methods to identify the relevant genes and perform clustering of samples. However, choosing the appropriate methods is difficult as recent work demonstrates that no method is the clear winner. Hence, we present an R-package called `multiClust` that allows researchers to experiment with the choice of combination of methods for gene selection and clustering with ease. In addition, using multiClust, we present the merit of gene selection and clustering methods in the context of clinical relevance of clustering, specifically clinical outcome.

Our integrative R-package contains:

1. A function to read in gene expression data and format appropriately for analysis in R.
2. Four different ways to select the number of genes a. Fixed b. Percent c. Poly d. GMM
3. Four gene ranking options that order genes based on different statistical criteria a. CV\_Rank b. CV\_Guided c. SD\_Rank d. Poly
4. Two ways to determine the cluster number a. Fixed b. Gap Statistic
5. Two clustering algorithms a. Hierarchical clustering b. K-means clustering
6. A function to calculate average gene expression in each sample cluster
7. A function to correlate sample clusters with clinical outcome

**Function Workflow**

The seven functions listed below should be used in the following order:

1. `input_file`, a function to read-in a text file containing the matrix of gene probes and samples to analyze.
2. `number_probes`, a function to determine the number of gene probes to select for in the feature selection process.
3. `probe_ranking`, a function to rank and select for probes using one of the available ranking options.
4. `number_clusters`, a function to determine the number of clusters to be used to cluster gene probes and samples.
5. `cluster_analysis`, a function to perform Kmeans or Hierarchical clustering analysis of the selected gene probe expression data.
6. `avg_probe_exp`, a function to produce a matrix containing the average expression of each gene probe within each sample cluster.
7. `surv_analysis`, a function to produce Kaplan-Meier Survival Plots after the discretization of samples into different clusters.

**Other Functions Included**

* `WriteMatrixToFile`, a function to write a data matrix to a text file.
* `nor.min.max`, a function to that uses feature scaling to normalize values in a matrix between 0 and 1.

---

## 1. Getting Started

In order to use `multiClust`, the user will need two text files.

* The first file is a gene probe expression dataset. This file should be a matrix with columns being the samples and the rows being genes or probes.
* The second file contains the patient clinical parameters. This file should be a matrix consisting of two columns. The first column contains the patient survival time and the second column contains the patient survival event occurrence. Survival time should be recorded in months. Survival event occurrence should be indicated by a 0 or 1. A 0 indicates censorship and a 1 indicates an event has occurred.

### 1.1 Obtaining a Gene Expression Dataset and Clinical Information

In this example, a gene expression dataset, GSE2034, will be obtained from the Gene Expression Omnibus (GEO) website <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=gse2034>.

The following code can be used to extract the gene expression data and clinical information from the series matrix text zip file. When using this code, be sure that you have a strong internet connection. The GSE datasets are very large!

```
# Load GEO and biobase libraries
library(GEOquery)
library(Biobase)
library(multiClust)
library(preprocessCore)
library(ctc)
library(gplots)
library(dendextend)
library(graphics)
library(grDevices)
library(amap)
library(survival)
```

```
# Obtain GSE series matrix file from GEO website using getGEO function
gse <- getGEO(GEO="GSE2034")

# Save the gene expression matrix as an object
data.gse <- exprs(gse[[1]])

# Save the patient clinical data to an object
pheno <- pData(phenoData(gse[[1]]))

# Write the gene expression and clinical data to text files
WriteMatrixToFile(tmpMatrix=data.gse, tmpFileName="GSE2034.expression.txt",
    blnRowNames=TRUE, blnColNames=TRUE)

WriteMatrixToFile(tmpMatrix=pheno, tmpFileName="GSE2034.clinical.txt",
    blnRowNames=TRUE, blnColNames=TRUE)
```

In the event that an error is produced when trying to obtain GSE datasets from the NCBI GEO FTP site, please use this alternative method:

1. On the NCBI GEO website (<http://www.ncbi.nlm.nih.gov/geo/>), simply search for the desired dataset (e.g.“GSE2034”) and scroll down to the “Analyze with GEO2R” section and click on “Series Matrix Files”.
2. From there, download the series matrix txt.gz file to your computer.
3. Move the zipped file to a folder of your choice.
4. In R, set your working directory to the directory with the GSE file.
5. In R, read in the downloaded GSE series matrix file.

After downloading the GSE series matrix file and moving it to a directory the following code can be used.

```
# Obtain GSE series matrix file from GEO website using getGEO function
gse <- getGEO(filename="GSE2034_series_matrix.txt.gz")

# Save the gene expression matrix as an object
data.gse <- exprs(gse[[1]])

# Save the patient clinical data to an object
pheno <- pData(phenoData(gse[[1]]))

# Write the gene expression and clinical data to text files
WriteMatrixToFile(tmpMatrix=data.gse, tmpFileName="GSE2034.expression.txt",
    blnRowNames=TRUE, blnColNames=TRUE)

WriteMatrixToFile(tmpMatrix=pheno, tmpFileName="GSE2034.clinical.txt",
    blnRowNames=TRUE, blnColNames=TRUE)
```

#### 1.2 Normalization of Gene Expression Datasets

Some datasets on GEO are already normalized using Robust Multichip Average (RMA) procedure available in the ‘affy’ R pacakge or quantile normalization and log2 scaling using the ‘preprocessCore’ R package.

For datasets that are not normalized, the following code can be used to extract the gene expression matrix from the series matrix text file, quantile normalize the data, log2 scale the data, and lastly write the data to a text file.

```
# Obtain GSE series matrix file from GEO website using getGEo function
gse <- getGEO(GEO="GSE2034")

# Save the gene expression matrix as an object
data.gse <- exprs(gse)

# Quantile normalization of the dataset
data.norm <- normalize.quantiles(data.gse, copy=FALSE)

# shift data before log scaling to prevent errors from log scaling
    # negative numbers
if (min(data.norm)> 0) {
    }
    else {
        mindata.norm=abs(min(data.norm)) + .001
        data.norm=data.norm + mindata.norm
    }

# Log2 scaling of the dataset
data.log <- t(apply(data.norm, 1, log2))

# Write the gene expression and clinical data to text files
WriteMatrixToFile(tmpMatrix=data.log,
    tmpFileName="GSE2034.normalized.expression.txt",
    blnRowNames=TRUE, blnColNames=TRUE)
```

#### 1.3 Formatting the Patient Clinical Information

As mentioned in the beginning of this section, the patient survival information file should be a matrix consisting of two columns. However, when the patient clinical information is written to a text file, it is generally a matrix of more than two columns with all of the clinical parameters.

It is recommended that this text file be loaded in R or Microsoft Excel to obtain the two columns of survival information needed. Below is an example of what the patient survival information file should look like:

```
# Obtain clinical outcome file
clin_file <- system.file("extdata", "GSE2034-RFS-clinical-outcome.txt",
    package="multiClust")

# Load in survival information file
clinical <- read.delim2(file=clin_file, header=TRUE)

# Display first few rows of the file
clinical[1:5, 1:2]
```

```
##   RFS_time RFS
## 1    77.88   0
## 2    49.32   1
## 3    130.2   0
## 4     82.8   0
## 5   144.96   0
```

```
# Column one represents the survival time in months
# Column two represents the relapse free survival (RFS) event
```

---

## 2. Loading Your Gene Probe Expression Dataset into R

The first function of `multiClust` is used to load a gene expression dataset into R and format the matrix so that the probe or gene names are the rownames of the matrix.

### 2.1 Loading Text Files Containing Gene Expression Matrix

In this example, the GSE2034 dataset is loaded into the R console using the `input_file` function.

**Function Arguments**

* This function has one variable called “input” which is the string name of the gene expression text file to load.

**Example**

```
# Obtain gene expression matrix
exp_file <- system.file("extdata", "GSE2034.normalized.expression.txt", package= "multiClust")

# Load the gene expression matrix
data.exprs <- input_file(input=exp_file)
```

```
## [1] "The gene expression matrix has been loaded"
```

```
# View the first few rows and columns of the matrix
data.exprs[1:4,1:4]
```

```
##              GSM36777    GSM36778    GSM36779    GSM36780
## 1007_s_at 10.65626945 10.82617907 11.12609748 10.47785521
## 1053_at   6.293524052 6.105409137 6.239483636 6.628974931
## 117_at    6.785154455 6.446397235 6.779564325 6.673216272
## 121_at    8.147451246 8.757777784 8.530315085 8.499970427
```

In this example, the gene expression matrix is stored into the object “data.exprs”.

---

## 3. Gene Selection Algorithms

### 3.1 Determining the Number of Desired Probes or Genes

The second function of this package, `number_probes` is a function used to specify the number of desired probes or genes the user would like to select for in their gene selection analysis.

**Function Arguments**

* This function has multiple arguments. The first argument “input” represents the string name of the expression matrix text file to be loaded into R.
* The second argument “data.exp” is the object containing the expression matrix
* The last four arguments “Fixed”, “Percent”, “Poly”, and “Adaptive” are the four different methods that determine how the number of genes are selected. The default option in the function is set to “Fixed”.

1. **Fixed** is an option where the user provides a positive integer to specify desired number of genes or probes to select for. The default value of “Fixed” is set to 1000. If the user writes:

```
# Example 1: Choosing a fixed gene or probe number

# Obtain gene expression matrix
exp_file <- system.file("extdata", "GSE2034.normalized.expression.txt",
    package="multiClust")

gene_num <- number_probes(input=exp_file,
    data.exp=data.exprs, Fixed=300,
    Percent=NULL, Poly=NULL, Adaptive=NULL)
```

```
## [1] "The fixed gene probe number is: 300"
```

As a result, 300 genes from the dataset will be selected during the gene or probe selection process.

2. **Percent** is another option where the user provides a positive integer between 0 and 100 indicating the percentage of total genes or probes to select from the dataset. For example, if the dataset has 20,000 total probes and the user specifies:

```
# Example 2: Choosing 50% of the total selected gene probes in a dataset
# Obtain gene expression matrix
exp_file <- system.file("extdata", "GSE2034.normalized.expression.txt",
    package="multiClust")

gene_num <- number_probes(input=exp_file,
    data.exp=data.exprs, Fixed=NULL,
    Percent=50, Poly=NULL, Adaptive=NULL)
```

```
## [1] "The percent gene probe number is: 150"
```

As a result, 50% of the total dataset probes, or 300 probes, will be selected.

3. **Poly** is the third option which fits three second degree polynomial functions to the gene expression dataset based on the dataset’s mean and standard deviation. When the user specifies:

```
# Example 3: Choosing the polynomial selected gene probes in a dataset
# Obtain gene expression matrix
exp_file <- system.file("extdata", "GSE2034.normalized.expression.txt",
    package="multiClust")

gene_num <- number_probes(input=exp_file,
    data.exp=data.exprs, Fixed=NULL,
    Percent=NULL, Poly=TRUE, Adaptive=NULL)
```

```
## [1] "The poly gene probe number is: 19"
```

4. **Adaptive** is the last option which implements Gaussian mixture modeling (GMM) to determine the appropriate number of genes or probes to select for. When the user specifies:

```
# Example 4: Choosing the Adaptive Gaussian Mixture Modeling method

gene_num <- number_probes(input=exp_file,
    data.exp=data.exprs, Fixed=NULL,
    Percent=NULL, Poly=NULL, Adaptive=TRUE)
```

The “Mclust” function from the package mclust <https://cran.r-project.org/web/packages/mclust/mclust.pdf> is used to apply Gaussian mixture modeling to the inputted gene expression matrix. In addition, files containing information about the dataset’s mean, variance, mixing proportion, and gaussian assignment are also outputted.

It should be noted that when choosing one of the three methods of gene or probe number selection, the other methods should be set equal to “NULL”. Furthermore, the **Adaptive** option has a very long computational time.

**Function Output**

This function returns an object containing the number of genes/probes to select for during the feature selection process.

#### 3.2 Choosing a Gene Selection Algorithm

The third function of this package, `probe_ranking` is used to select the most informative gene probes within a dataset. This function allows the user choose from one of four different probe ranking algorithms.

**Function Arguments**

* This function has multiple arguments. The first argument “input” represents the string name of the expression matrix text file to be loaded into R.
* The second argument “probe\_number” is an output of the `number probes` function. For this argument, the user specifies the number of genes to select for.
* The third argument “probe\_num selection” is a string specifying which type of probe number selection method was used for the `number_probes` function.
* The fourth argument “data.exp” is the object containing the expression matrix.
* The last argument “method” is a string that specifies which of the four probe ranking methods to use.

**List of the Five Probe Ranking Methods**

1. **CV\_Rank** is a gene probe ranking method that selects for probes using the coefficient of variation of the entire dataset (CV).
2. **CV\_Guided** is a gene probe ranking method that uses the coefficient of variation (CV) for each probe to select for probes.
3. **SD\_Rank** is a gene probe ranking method that selects for probes with the highest standard deviation within the dataset.
4. **Poly** is a ranking method that fits three second degree polynomial functions of mean and standard deviation to the dataset to select the most variable probes in the dataset. This is the only method that does not use a probe number input from the `number_probes` function. When using this ranking method “probe\_num” can be set to NULL.

**Example**

Below is an example of how to use the `probe_ranking` function:

```
# Obtain gene expression matrix
exp_file <- system.file("extdata", "GSE2034.normalized.expression.txt",
    package="multiClust")

# Load the gene expression matrix
data.exprs <- input_file(input=exp_file)
```

```
## [1] "The gene expression matrix has been loaded"
```

```
# Call probe_ranking function
# Select for 500 probes
# Choose genes using the SD_Rank method
ranked.exprs <- probe_ranking(input=exp_file,
    probe_number=300,
    probe_num_selection="Fixed_Probe_Num",
    data.exp=data.exprs,
    method="SD_Rank")
```

```
## [1] "The selected SD_Rank Gene Expression text file has been written"
```

```
# Display the first few columns and rows of the matrix
ranked.exprs[1:4,1:4]
```

```
##             GSM36777 GSM36778 GSM36779 GSM36780
## 1405_i_at   2.663816 2.992651 1.833091 3.793433
## 200656_s_at 5.616488 2.372672 7.134110 5.639419
## 200641_s_at 4.165681 2.922955 4.397136 4.934420
## 200670_at   7.606198 6.223078 8.604945 7.279471
```

**Function Outputs**

The output of this function is a text file containing a selected gene or probe expression matrix. In addition, the selected expression matrix is stored into the chosen variable “ranked.exprs”.

---

## 4. Cluster Analysis of Selected Genes and Samples

### 4.1 Determining the Number of Clusters to Divide Samples Into

The fourth function is this package, `number_clusters`, is a function used to designate the number of clusters that samples will be assigned to.

**Function Arguments**

1. The “data.exp” argument represents an object containing the original gene expression matrix to be used for clustering of genes and samples. This object is an output of the `input_file` function.
2. The “Fixed” argument is a positive integer used to represent the number of clusters the samples and probes will be divided into.
3. The “gap\_statistic” argument is a logical indicating whether to calculate the optimal number of clusters to divide the samples into using a gap statistic function `clus_Gap` from the package `cluster`.

**Note**

The user should only choose either the “Fixed” or “gap\_statistic” option, not both. When using the gap\_statistic option, change the argument to TRUE and “Fixed” to NULL.

**Fixed Cluster Number Example**

Below is an example of how to use the `number_clusters` function with a fixed number of clusters:

```
# Call the number_clusters function
# data.exp is the original expression matrix object outputted from
# the input_file function
# User specifies that samples will be separated into 3 clusters
# with the "Fixed" argument
cluster_num <- number_clusters(data.exp=data.exprs, Fixed=3,
    gap_statistic=NULL)
```

```
## [1] "The fixed cluster number is: 3"
```

The output from this example will be the object “cluster\_num” with a value of 3.

**Gap statistic Example**

The `number_clusters` function can be called in a similar way to use the gap\_statistic option:

```
# Call the number_clusters function
# data.exp is the original expression matrix object ouputted from
# the input_file function
# User chooses the gap_statistic option by making gap_statistic equal TRUE
# The Fixed argument is also set to NULL
cluster_num <- number_clusters(data.exp=data.exprs, Fixed=NULL,
    gap_statistic=TRUE)
```

The gap\_statistic option has a very long computational time and can take up to several hours. The output of this function will be a positive integer indicating the optimal number of clusters to divide samples into.

#### 4.2 Kmeans or Hierarchical Clustering of Genes/Probes and Samples

The fifth function in this package, `cluster_analysis` is a function used to perform Kmeans or Hierarchical clustering analysis of genes/probes and samples after undergoing a feature selection process in the `probe_ranking` function.

**Function Arguments:**

1. The first argument “sel.exp”, is an object containing the numeric selected gene expression matrix. This object is an output of the `probe_ranking` function.
2. The second argument “cluster\_type” is a string indicating the type of clustering method to use. *Kmeans* or *HClust* are the two options.
3. The third argument “distance” is a string describing the distance metric to use for Hierarchical clustering via the `dist` function. `dist` uses a default distance metric of Euclidean distance. Options include one of “euclidean”, “maximum”, manhattan“,”canberra“,”binary“, or”minkowski". Kmeans does not use a distance metric.
4. The fourth argument, “linkage\_type” is a string describing the linkage metric to be used for hierarchical clustering in the `hclust` function. The default is “ward.D2”, however other options include “average”, “complete”, “median”, “centroid”, “single”, and “mcquitty”. Kmeans does not use a linkage metric.
5. The fifth argument, “gene\_distance” is a string describing the distance measure to be used for the `Dist` function when performing hierarchical clustering of genes. Options include one of “euclidean”, “maximum”, “manhattan”, “canberra”, “binary”, “pearson”, “abspearson”, “correlation”, “abscorrelation”, “spearman” or “kendall”. The default of gene\_distance is set to “correlation”. The argument can be set to NULL when Kmeans clustering is used.
6. The sixth argument “num\_clusters” is a positive integer to specify the number of clusters samples will be divided into. This number is determined by the `number_clusters` function.
7. The seventh argument “data\_name” is a string indicating the cancer type and/or name of the dataset being analyzed. This name will be used to label the sample dendrograms and heatmap files.
8. The eighth argument “probe\_rank” is a string indicating the feature selection method used in the `probe_ranking` function. Options include “CV\_Rank”, “CV\_Guided”, “SD\_Rank”, and “Poly”.
9. The ninth argument “probe\_num\_selection” is a string indicating the way in which probes were selected in the `number_probes` function. Options include “Fixed\_Probe\_Num”, “Percent\_Probe\_Num”, “Poly\_Probe\_Num”, and “Adaptive\_Probe\_Num”.
10. The tenth argument, “cluster\_num\_selection” is a string indicating how the number of clusters were determined in the number\_clusters function. Options include “Fixed\_Clust\_Num” and “Gap\_Statistic”.

**Function Outputs**

* A CSV file containing the sample names and their respective cluster. An object containing a vector of the sample names and their cluster number is returned.
* When hierarchical clustering is chosen as the cluster method, a pdf file of the sample dendrogram as well as atr, gtr, and cdt files for viewing in Java TreeView are outputted. In the Java TreeView heatmap, the samples are clustered by the method indicated by the “linkage\_type” argument while genes are clustered by the method indicated by the “gene\_distance” argument. The default of sample clustering for the Java TreeView heatmap is “ward.D2” and the default for gene clustering is centered pearson “correlation”.

**Hierarchical Clustering Example**

Below is an example of how to use the `cluster_analysis` function using the Hierarchical clustering option:

```
# Call the cluster_analysis function
hclust_analysis <- cluster_analysis(sel.exp=ranked.exprs,
    cluster_type="HClust",
    distance="euclidean", linkage_type="ward.D2",
    gene_distance="correlation",
    num_clusters=3, data_name="GSE2034 Breast",
    probe_rank="SD_Rank", probe_num_selection="Fixed_Probe_Num",
    cluster_num_selection="Fixed_Clust_Num")
```

```
## [1] "Your HClust Sample Dendrogram has been outputted"
```

```
## [1] "Your atr, gtr, and cdt files have been outputted for viewing in Java TreeView"
## [1] "A CSV file has been produced containing your sample and cluster assignment information"
```

```
# Display the first few columns and rows of the object
head(hclust_analysis)
```

```
## GSM36777 GSM36778 GSM36779 GSM36780 GSM36781 GSM36782
##        1        3        1        1        1        2
```

**Function Outputs**

The outputs from this example would be an object “hclust\_analysis” containing a vector of the sample names and cluster number. In addition, a sample dendrogram pdf file would be written. Lastly, the atr, gtr, and cdt files are outputted to view a heatmap of the genes and samples in Java TreeView.

**Note**

The `cluster_analysis` function does not display the sample dendrogram and heatmap in the console. To show what these images would look like, the following examples are provided below.

**Java TreeView Heatmap Example**

Below is an example of a heatmap produced in Java TreeView from the atr, gtr, abnd cdt files produced by this function. In this heatmap, rows represent genes and columns represent samples.

![](data:image/jpeg;base64...)

**Sample Dendrogram Example**

Below is an example of a sample dendrogram outputted by this function:

![](data:image/png;base64...)

**Kmeans Clustering Example**

Below is an example of how to use the `cluster_analysis` function using the Kmeans clustering option:

```
# Call the cluster_analysis function
 kmeans_analysis <- cluster_analysis(sel.exp=ranked.exprs,
    cluster_type="Kmeans",
    distance=NULL, linkage_type=NULL,
    gene_distance=NULL, num_clusters=3,
    data_name="GSE2034 Breast", probe_rank="SD_Rank",
    probe_num_selection="Fixed_Probe_Num",
    cluster_num_selection="Fixed_Clust_Num")
```

```
## [1] "A CSV file has been produced containing your sample and cluster assignment information"
```

```
 # Display the first few rows and columns of the object
 head(kmeans_analysis)
```

```
## GSM36777 GSM36778 GSM36779 GSM36780 GSM36781 GSM36782
##        2        1        2        3        3        2
```

**Function Outputs**

The output from this example would solely be an object “kmeans\_analysis” containing the vector of sample names and cluster number. There would be no sample dendrogram file.

---

## 5. Obtaining the Average Expression for Each Gene/Probe in Each Cluster

The sixth function in this package `avg_probe_exp` is used to determine the average expression of each gene/probe for the samples in a particular cluster.

**Function Arguments**

1. The first argument “sel.exp” is an object containing the numeric selected gene/prone expression matrix. This object is an output of the `probe_ranking` function.
2. The second argument “samp\_cluster” is an object vector containing the samples and the cluster number they belong to. This is an output of the `cluster_analysis` function.
3. The third argument “data\_name” is a string indicating the cancer type and name of the dataset being analyzed.
4. The fourth argument “cluster\_type” is a string indicating the type of clustering method used in the `cluster_analysis` function. “Kmeans” or “HClust” are the two options.
5. The fifth argument “distance” is a string describing the distance metric used for HClust in the `cluster_analysis` function. Options include one of “euclidean”, “maximum”, manhattan“,”canberra“,”binary“, or”minkowski".
6. The sixth argument “linkage\_type” is a string describing the linkage metric used in the HClust method in the `cluster_analysis` function. Options include “ward.D2”, “average”, “complete”, “median”, “centroid”, “single”, and “mcquitty”.
7. The seventh argument “probe\_rank” is a string indicating the feature selection method used in the `probe_ranking` function. Options include “CV\_Rank”, “CV\_Guided”, “SD\_Rank”, and “Poly”.
8. The eighth argument “probe\_num\_selection” is a string indicating the way in which probes were selected in the `number_probes` function. Examples include “Fixed\_Probe\_Num”, “Percent\_Probe\_Num”, “Poly\_Probe\_Num”, and “Adaptive\_Probe\_Num”.
9. The ninth argument “cluster\_num\_selection” is a string indicating how the number of clusters were determined in the `number_clusters` function. Examples include “Fixed\_Clust\_Num” and “Gap\_Statistic”.

**Example**

Below is an example of how to use the `avg_probe_exp` function after performing Kmeans clustering analysis with the `cluster_analysis` function:

```
# Call the avg_probe_exp function
avg_matrix <- avg_probe_exp(sel.exp=ranked.exprs,
    samp_cluster=kmeans_analysis,
    data_name="GSE2034 Breast", cluster_type="Kmeans", distance=NULL,
    linkage_type=NULL, probe_rank="SD_Rank",
    probe_num_selection="Fixed_Probe_Num",
    cluster_num_selection="Fixed_Clust_Num")
```

```
## [1] "Your matrix containing the average gene probe expression in each cluster is finished"
```

```
# Display the first few rows and columns of the matrix
head(avg_matrix)
```

```
##             Cluster 1 Cluster 2 Cluster 3
## 1405_i_at    3.444507  3.295349  3.325252
## 200656_s_at  3.824532  4.635851  5.794335
## 200641_s_at  3.116710  4.061541  5.177569
## 200670_at    6.648387  7.571051  7.107753
## 200632_s_at  5.995347  5.470008  6.080703
## 200605_s_at  3.659888  5.028460  5.137496
```

**Function Outputs**

The outputs from this function are a text file containing the matrix of average expression of each probe/gene in each of the different clusters. In addition the object “avg\_matrix” would also contain the average expression matrix.

---

## 6. Clinical Analysis of Selected Gene Probes and Samples

After dividing the selected gene probes and samples into their respective clusters, the `surv_analysis` function can be used to produce Kaplan-Meier Survival Plots. This function uses a Cox Proportional Hazard Model to portray the survival probabilities of the patients within each cluster over time.

**Function Arguments**

1. The first argument “samp\_cluster” is an object vector containing the samples and the cluster number they belong to. This object is an output of the `cluster_analysis` function.
2. The second argument “clinical” is a string indicating the name of the text file containing patient clinical information. This file should be a matrix consisting of two columns. The first column contains the patient survival time information in months. The second column indicates the occurrence of a censorship (0) or an event (1).
3. The third argument “survival\_type” is a string specifying the type of survival event being analyzed. Examples include “Disease-free survival (DFS)”, “Overall Survival (OS)”, “Relapse-free survival (RFS)”, etc.
4. The fourth argument “data\_name” is a string indicating the name to be used to label the Kaplan-Meier Survival Plot.
5. The fifth argument “cluster\_type” is a string indicating the type of clustering method used in the `cluster_analysis` function. “Kmeans” or “HClust” are the two options.
6. The sixth argument “distance” is a string describing the distance metric uses for HClust in the `cluster_analysis` function. Options include one of “euclidean”, “maximum”, manhattan“,”canberra“,”binary“, or”minkowski".
7. The seventh argument “linkage\_type” is a string describing the linkage metric used in the `cluster_analysis` function. Options include “ward.D2”, “average”, “complete”, “median”, “centroid”, “single”, and “mcquitty”.
8. The eighth argument “probe\_rank” is a string indicating the feature selection method used in the `probe_ranking` function. Options include “CV\_Rank”, “CV\_Guided”, “SD\_Rank”, and “Poly”.

The ninth argument “probe\_num\_selection” is a string indicating the way in which probes were selected in the `number_probes` function. Options include “Fixed\_Probe\_Num”, “Percent\_Probe\_Num”, “Poly\_Probe\_Num”, and “Adaptive\_Probee\_Num”.

The tenth argument “cluster\_num\_selection” is a string indicating how the number of clusters were determined in the `number_clusters` function. Options include “Fixed\_Clust\_Num” and “Gap\_Statistic”.

Below is an example of how to use the `surv_analysis` function:

**Example**

```
# Obtain clinical outcome file
clin_file <- system.file("extdata", "GSE2034-RFS-clinical-outcome.txt",
    package="multiClust")

# Call the avg_probe_exp function
surv <- surv_analysis(samp_cluster=kmeans_analysis, clinical=clin_file,
    survival_type="RFS", data_name="GSE2034 Breast",
    cluster_type="Kmeans", distance=NULL,
    linkage_type=NULL, probe_rank="SD_Rank",
    probe_num_selection="Fixed_Probe_Num",
    cluster_num_selection="Fixed_Clust_Num")
```

```
## [1] "Your Kaplan Meier Survival Plot has been finished"
```

```
# Display the survival P value
surv
```

```
##    pvalue
## 0.4061254
```

**Function Outputs**

This function outputs a pdf Kaplan-Meier Survival Plot of the patient survival time in months vs. the survival probability. In this example, the object “surv” will also contain the Cox Survival P value.

**Note**

The `surv_analysis` function also does not display the Kaplan-Meier plot in the console, but rather outputs the plot as a pdf file. Below is an example of what the plots would look like.

**Kaplan-Meier Survival Plot**

![](data:image/png;base64...)

---

## 7. References

1. Davis, S. and Meltzer, P. S. GEOquery: a bridge between the Gene Expression Omnibus (GEO) and BioConductor. Bioinformatics, 2007, 14, 1846-1847
2. Orchestrating high-throughput genomic analysis with Bioconductor. W. Huber, V.J. Carey, R. Gentleman, …, M. Morgan Nature Methods, 2015:12, 115.
3. Benjamin Milo Bolstad. preprocessCore: A collection of pre-processing functions. R package version 1.30.0.
4. Chris Fraley, Adrian E. Raftery, T. Brendan Murphy, and Luca Scrucca (2012) mclust Version 4 for R: Normal Mixture Modeling for Model-Based Clustering, Classification, and Density Estimation Technical Report No. 597, Department of Statistics, University of Washington
5. Antoine Lucas and Laurent Gautier (2005). ctc: Cluster and Tree Conversion.. R package version 1.42.0. <http://antoinelucas.free.fr/ctc>
6. Gregory R. Warnes, Ben Bolker, Lodewijk Bonebakker, Robert Gentleman, Wolfgang Huber Andy Liaw, Thomas Lumley, Martin Maechler, Arni Magnusson, Steffen Moeller, Marc Schwartz and Bill Venables (2015). gplots: Various R Programming Tools for Plotting Data. R package version 2.17.0. [http://CRAN.R-project.org/package=gplots](http://CRAN.R-project.org/package%3Dgplots)
7. Therneau T (2015). \_A Package for Survival Analysis in S. version 2.38, <URL: [http://CRAN.R-project.org/package=survival](http://CRAN.R-project.org/package%3Dsurvival)>.
8. Maechler, M., Rousseeuw, P., Struyf, A., Hubert, M., Hornik, K.(2015). cluster: Cluster Analysis Basics and Extensions. R package version 2.0.3.
9. Tal Galili (2015). dendextend: Extending R’s Dendrogram Functionality. R package version 1.0.1. [http://CRAN.R-project.org/package=dendextend](http://CRAN.R-project.org/package%3Ddendextend)
10. R Core Team (2015). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL <https://www.R-project.org/>.
11. Saldanha, A. J. “Java Treeview–extensible Visualization of Microarray Data.”Bioinformatics 20.17 (2004): 3246-248.
12. Antoine Lucas (2014). amap: Another Multidimensional Analysis Package. R package version 0.8-14. [http://CRAN.R-project.org/package=amap](http://CRAN.R-project.org/package%3Damap)