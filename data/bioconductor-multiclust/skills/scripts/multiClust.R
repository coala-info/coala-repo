# Code example from 'multiClust' vignette. See references/ for full tutorial.

## ----eval=TRUE, message=FALSE-------------------------------------------------
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

## ----eval=FALSE, message=FALSE------------------------------------------------
# # Obtain GSE series matrix file from GEO website using getGEO function
# gse <- getGEO(GEO="GSE2034")
# 
# # Save the gene expression matrix as an object
# data.gse <- exprs(gse[[1]])
# 
# # Save the patient clinical data to an object
# pheno <- pData(phenoData(gse[[1]]))
# 
# # Write the gene expression and clinical data to text files
# WriteMatrixToFile(tmpMatrix=data.gse, tmpFileName="GSE2034.expression.txt",
#     blnRowNames=TRUE, blnColNames=TRUE)
# 
# WriteMatrixToFile(tmpMatrix=pheno, tmpFileName="GSE2034.clinical.txt",
#     blnRowNames=TRUE, blnColNames=TRUE)
# 

## ----eval=FALSE---------------------------------------------------------------
# # Obtain GSE series matrix file from GEO website using getGEO function
# gse <- getGEO(filename="GSE2034_series_matrix.txt.gz")
# 
# # Save the gene expression matrix as an object
# data.gse <- exprs(gse[[1]])
# 
# # Save the patient clinical data to an object
# pheno <- pData(phenoData(gse[[1]]))
# 
# # Write the gene expression and clinical data to text files
# WriteMatrixToFile(tmpMatrix=data.gse, tmpFileName="GSE2034.expression.txt",
#     blnRowNames=TRUE, blnColNames=TRUE)
# 
# WriteMatrixToFile(tmpMatrix=pheno, tmpFileName="GSE2034.clinical.txt",
#     blnRowNames=TRUE, blnColNames=TRUE)
# 

## ----eval=FALSE---------------------------------------------------------------
# # Obtain GSE series matrix file from GEO website using getGEo function
# gse <- getGEO(GEO="GSE2034")
# 
# # Save the gene expression matrix as an object
# data.gse <- exprs(gse)
# 
# # Quantile normalization of the dataset
# data.norm <- normalize.quantiles(data.gse, copy=FALSE)
# 
# # shift data before log scaling to prevent errors from log scaling
#     # negative numbers
# if (min(data.norm)> 0) {
#     }
#     else {
#         mindata.norm=abs(min(data.norm)) + .001
#         data.norm=data.norm + mindata.norm
#     }
# 
# # Log2 scaling of the dataset
# data.log <- t(apply(data.norm, 1, log2))
# 
# # Write the gene expression and clinical data to text files
# WriteMatrixToFile(tmpMatrix=data.log,
#     tmpFileName="GSE2034.normalized.expression.txt",
#     blnRowNames=TRUE, blnColNames=TRUE)
# 

## ----eval=TRUE----------------------------------------------------------------
# Obtain clinical outcome file
clin_file <- system.file("extdata", "GSE2034-RFS-clinical-outcome.txt",
    package="multiClust")

# Load in survival information file
clinical <- read.delim2(file=clin_file, header=TRUE)

# Display first few rows of the file
clinical[1:5, 1:2]

# Column one represents the survival time in months
# Column two represents the relapse free survival (RFS) event 


## ----eval=TRUE----------------------------------------------------------------
# Obtain gene expression matrix
exp_file <- system.file("extdata", "GSE2034.normalized.expression.txt", package= "multiClust")

# Load the gene expression matrix 
data.exprs <- input_file(input=exp_file)

# View the first few rows and columns of the matrix
data.exprs[1:4,1:4]

## ----eval=TRUE----------------------------------------------------------------
# Example 1: Choosing a fixed gene or probe number

# Obtain gene expression matrix
exp_file <- system.file("extdata", "GSE2034.normalized.expression.txt",
    package="multiClust")

gene_num <- number_probes(input=exp_file,
    data.exp=data.exprs, Fixed=300,
    Percent=NULL, Poly=NULL, Adaptive=NULL)


## ----eval=TRUE----------------------------------------------------------------
# Example 2: Choosing 50% of the total selected gene probes in a dataset
# Obtain gene expression matrix
exp_file <- system.file("extdata", "GSE2034.normalized.expression.txt",
    package="multiClust")

gene_num <- number_probes(input=exp_file, 
    data.exp=data.exprs, Fixed=NULL,
    Percent=50, Poly=NULL, Adaptive=NULL)


## ----eval=TRUE----------------------------------------------------------------
# Example 3: Choosing the polynomial selected gene probes in a dataset
# Obtain gene expression matrix
exp_file <- system.file("extdata", "GSE2034.normalized.expression.txt",
    package="multiClust")

gene_num <- number_probes(input=exp_file, 
    data.exp=data.exprs, Fixed=NULL,
    Percent=NULL, Poly=TRUE, Adaptive=NULL)


## ----eval=FALSE---------------------------------------------------------------
# # Example 4: Choosing the Adaptive Gaussian Mixture Modeling method
# 
# gene_num <- number_probes(input=exp_file,
#     data.exp=data.exprs, Fixed=NULL,
#     Percent=NULL, Poly=NULL, Adaptive=TRUE)
# 

## ----eval=TRUE----------------------------------------------------------------

# Obtain gene expression matrix
exp_file <- system.file("extdata", "GSE2034.normalized.expression.txt",
    package="multiClust")

# Load the gene expression matrix 
data.exprs <- input_file(input=exp_file)

# Call probe_ranking function
# Select for 500 probes
# Choose genes using the SD_Rank method
ranked.exprs <- probe_ranking(input=exp_file,
    probe_number=300, 
    probe_num_selection="Fixed_Probe_Num",
    data.exp=data.exprs, 
    method="SD_Rank")

# Display the first few columns and rows of the matrix
ranked.exprs[1:4,1:4]


## ----eval=TRUE----------------------------------------------------------------

# Call the number_clusters function
# data.exp is the original expression matrix object outputted from
# the input_file function
# User specifies that samples will be separated into 3 clusters 
# with the "Fixed" argument
cluster_num <- number_clusters(data.exp=data.exprs, Fixed=3,
    gap_statistic=NULL)


## ----eval=FALSE---------------------------------------------------------------
# 
# # Call the number_clusters function
# # data.exp is the original expression matrix object ouputted from
# # the input_file function
# # User chooses the gap_statistic option by making gap_statistic equal TRUE
# # The Fixed argument is also set to NULL
# cluster_num <- number_clusters(data.exp=data.exprs, Fixed=NULL,
#     gap_statistic=TRUE)
# 

## ----eval=TRUE, fig.show='hold', warning=FALSE--------------------------------

# Call the cluster_analysis function
hclust_analysis <- cluster_analysis(sel.exp=ranked.exprs,
    cluster_type="HClust",
    distance="euclidean", linkage_type="ward.D2", 
    gene_distance="correlation",
    num_clusters=3, data_name="GSE2034 Breast", 
    probe_rank="SD_Rank", probe_num_selection="Fixed_Probe_Num",
    cluster_num_selection="Fixed_Clust_Num")

# Display the first few columns and rows of the object
head(hclust_analysis)


## ----eval=TRUE, echo=FALSE, fig.show='hold', fig.width=8, fig.height=8, fig.align='center', warning=FALSE----
# retrieve file path for image
fpath <- system.file("extdata", "GSE2034_Breast.SD_Rank.ward.D2.Fixed_Probe_Num.Fixed_Clust_Num.jpg", package="multiClust")
knitr::include_graphics(path = fpath)

## ----eval=TRUE, echo=FALSE, fig.show='hold', fig.width=8, fig.height=8, fig.align='center', warning=FALSE----
# Produce a sample dendrogram using the selected gene/probe expression object
# In the function, cluster_analysis the dendrogram is not displayed in
# the console. 

# Make the selected expression object numeric
colname <- colnames(ranked.exprs)
ranked.exprs <- t(apply(ranked.exprs, 1,as.numeric))
colnames(ranked.exprs) <- colname

# Normalization of the selected expression matrix before clustering
norm.sel.exp <- t(apply(ranked.exprs, 1, nor.min.max))

hc <- hclust(dist(x=t(norm.sel.exp), method="euclidean"), method="ward.D2")
dc <- as.dendrogram(hc)

# Portray the samples in each cluster as a different color
dc <- set(dc, "branches_k_color", value=1:3, k=3)

# Make a vector filled with blank spaces to replace sample names with
    # blank space
vec <- NULL
len <- length(labels(dc))
for (i in 1:len) {
  i <- ""
  vec <- c(vec, i)
}

# Remove sample labels from dendrogram
dc <- dendextend::set(dc, "labels", vec)

# Plot the sample dendrogram
plot(dc, main=paste("GSE2034 Breast", "Sample Dendrogram", sep=" "))

# Display orange lines on the plot to clearly separate each cluster
rect.dendrogram(dc, k=3, border='orange')


## ----eval=TRUE----------------------------------------------------------------

# Call the cluster_analysis function
 kmeans_analysis <- cluster_analysis(sel.exp=ranked.exprs,
    cluster_type="Kmeans",
    distance=NULL, linkage_type=NULL, 
    gene_distance=NULL, num_clusters=3,
    data_name="GSE2034 Breast", probe_rank="SD_Rank",
    probe_num_selection="Fixed_Probe_Num",
    cluster_num_selection="Fixed_Clust_Num")
 
 # Display the first few rows and columns of the object
 head(kmeans_analysis)


## ----eval=TRUE----------------------------------------------------------------

# Call the avg_probe_exp function
avg_matrix <- avg_probe_exp(sel.exp=ranked.exprs,
    samp_cluster=kmeans_analysis,
    data_name="GSE2034 Breast", cluster_type="Kmeans", distance=NULL,
    linkage_type=NULL, probe_rank="SD_Rank",
    probe_num_selection="Fixed_Probe_Num",
    cluster_num_selection="Fixed_Clust_Num")

# Display the first few rows and columns of the matrix
head(avg_matrix)


## ----eval=TRUE, fig.show='hold'-----------------------------------------------
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

# Display the survival P value
surv


## ----eval=TRUE, echo=FALSE, fig.show='hold', fig.width=8, fig.height=8, fig.align='center', warning=FALSE----

# Obtain clinical outcome file
clin_file <- system.file("extdata", "GSE2034-RFS-clinical-outcome.txt",
    package="multiClust")

# Produce a Kaplan-Meier plot using the sample cluster information
# from the cluster_analysis function

# Read in survival data text file
sample.anns <- read.delim2(file=clin_file, 
    header=TRUE, stringsAsFactors=FALSE)
time <- sample.anns[,1]
event <- sample.anns[,2]
time <- as.numeric(time)
event <- as.numeric(event)
event_type <- "RFS"
time_type <- 'Months'

# Determine max number of clusters in samp_cluster
samp_cluster <- kmeans_analysis
Number_Clusters <- max(samp_cluster)

# Produce Kaplan Meier survival plots
lev <- '1'
for(i in 2:Number_Clusters) {
    lev <- c(lev, paste('',i, sep=''))
}

groupfac <- factor(samp_cluster, levels=lev)
cox <- coxph(Surv(time, event==1) ~ groupfac)
csumm <- summary(cox)
cox.p.value <- c(csumm$logtest[3])
p <- survfit(Surv(time,event==1)~strata(samp_cluster))

plot (p,xlab= time_type ,ylab='Survival Probability',conf.int=FALSE, 
    xlim=c(0,100), col=1:Number_Clusters, 
    main=paste("GSE2034 Breast", "Kmeans", "SD_Rank", "RFS", sep =' '))

legend('bottomleft',legend=levels(strata(samp_cluster)),lty=1,
    col=1:Number_Clusters, text.col=1:Number_Clusters, title='clusters')

legend('topright', paste('Pvalue =', signif(csumm$logtest[3],digits=2),
    sep =''))


