# scGPS introduction

#### Quan Nguyen and Michael Thompson

#### 2025-10-30

# 1. Installation instruction

```
# To install scGPS from github (Depending on the configuration of the local
# computer or HPC, possible custom C++ compilation may be required - see
# installation trouble-shootings below)
devtools::install_github("IMB-Computational-Genomics-Lab/scGPS")

# for C++ compilation trouble-shooting, manual download and installation can be
# done from github

git clone https://github.com/IMB-Computational-Genomics-Lab/scGPS

# then check in scGPS/src if any of the precompiled (e.g.  those with *.so and
# *.o) files exist and delete them before recompiling

# then with the scGPS as the R working directory, manually install and load
# using devtools functionality
# Install the package
devtools::install()
#load the package to the workspace
library(scGPS)
```

# 2. A simple workflow of the scGPS:

The purpose of this workflow is to solve the following task:

* Given a mixed population with known subpopulations, estimate transition scores between these subpopulation.

## 2.1 Create scGPS objects

```
# load mixed population 1 (loaded from day_2_cardio_cell_sample dataset,
# named it as day2)
library(scGPS)

day2 <- day_2_cardio_cell_sample
mixedpop1 <- new_scGPS_object(ExpressionMatrix = day2$dat2_counts,
    GeneMetadata = day2$dat2geneInfo, CellMetadata = day2$dat2_clusters)

# load mixed population 2 (loaded from day_5_cardio_cell_sample dataset,
# named it as day5)
day5 <- day_5_cardio_cell_sample
mixedpop2 <- new_scGPS_object(ExpressionMatrix = day5$dat5_counts,
    GeneMetadata = day5$dat5geneInfo, CellMetadata = day5$dat5_clusters)
```

## 2.2 Run prediction

```
# select a subpopulation
c_selectID <- 1
# load gene list (this can be any lists of user selected genes)
genes <- training_gene_sample
genes <- genes$Merged_unique
# load cluster information
cluster_mixedpop1 <- colData(mixedpop1)[,1]
cluster_mixedpop2 <- colData(mixedpop2)[,1]
#run training (running nboots = 3 here, but recommend to use nboots = 50-100)
LSOLDA_dat <- bootstrap_prediction(nboots = 3, mixedpop1 = mixedpop1,
    mixedpop2 = mixedpop2, genes = genes, c_selectID  = c_selectID,
    listData = list(), cluster_mixedpop1 = cluster_mixedpop1,
    cluster_mixedpop2 = cluster_mixedpop2, trainset_ratio = 0.7)
names(LSOLDA_dat)
#> [1] "Accuracy"          "ElasticNetGenes"   "Deviance"
#> [4] "ElasticNetFit"     "LDAFit"            "predictor_S1"
#> [7] "ElasticNetPredict" "LDAPredict"        "cell_results"
```

## 2.3 Summarise results

```
# summary results LDA
sum_pred_lda <- summary_prediction_lda(LSOLDA_dat = LSOLDA_dat, nPredSubpop = 4)
# summary results Lasso to show the percent of cells
# classified as cells belonging
sum_pred_lasso <- summary_prediction_lasso(LSOLDA_dat = LSOLDA_dat,
    nPredSubpop = 4)
# plot summary results
plot_sum <-function(sum_dat){
    sum_dat_tf <- t(sum_dat)
    sum_dat_tf <- na.omit(sum_dat_tf)
    sum_dat_tf <- apply(sum_dat[, -ncol(sum_dat)],1,
        function(x){as.numeric(as.vector(x))})
    sum_dat$names <- gsub("ElasticNet for subpop","sp",  sum_dat$names )
    sum_dat$names <- gsub("in target mixedpop","in p",  sum_dat$names)
    sum_dat$names <- gsub("LDA for subpop","sp",  sum_dat$names )
    sum_dat$names <- gsub("in target mixedpop","in p",  sum_dat$names)
    colnames(sum_dat_tf) <- sum_dat$names
    boxplot(sum_dat_tf, las=2)
}
plot_sum(sum_pred_lasso)
```

![](data:image/png;base64...)

```
plot_sum(sum_pred_lda)
```

![](data:image/png;base64...)

```
# summary accuracy to check the model accuracy in the leave-out test set
summary_accuracy(object = LSOLDA_dat)
#> [1] 63.25581 64.01869 63.38028
# summary maximum deviance explained by the model
summary_deviance(object = LSOLDA_dat)
#> $allDeviance
#> [1] "8.08"  "8.13"  "12.92"
#>
#> $DeviMax
#>          dat_DE$Dfd          Deviance           DEgenes
#> 1                 0              8.13    genes_cluster1
#> 2                 1              8.13    genes_cluster1
#> 3                 2              8.13    genes_cluster1
#> 4                 3              8.13    genes_cluster1
#> 5 remaining DEgenes remaining DEgenes remaining DEgenes
#>
#> $LassoGenesMax
#> NULL
```

# 3. A complete workflow of the scGPS:

The purpose of this workflow is to solve the following task:

* Given an unknown mixed population, find clusters and estimate relationship between clusters

## 3.1 Identify clusters in a dataset using CORE

(skip this step if clusters are known)

```
# find clustering information in an expresion data using CORE
day5 <- day_5_cardio_cell_sample
cellnames <- colnames(day5$dat5_counts)
cluster <-day5$dat5_clusters
cellnames <-data.frame("Cluster"=cluster, "cellBarcodes" = cellnames)
mixedpop2 <-new_scGPS_object(ExpressionMatrix = day5$dat5_counts,
                    GeneMetadata = day5$dat5geneInfo, CellMetadata = cellnames)

CORE_cluster <- CORE_clustering(mixedpop2, remove_outlier = c(0), PCA=FALSE)

# to update the clustering information, users can ...
key_height <- CORE_cluster$optimalClust$KeyStats$Height
optimal_res <- CORE_cluster$optimalClust$OptimalRes
optimal_index = which(key_height == optimal_res)

clustering_after_outlier_removal <- unname(unlist(
 CORE_cluster$Cluster[[optimal_index]]))
corresponding_cells_after_outlier_removal <- CORE_cluster$cellsForClustering
original_cells_before_removal <- colData(mixedpop2)[,2]
corresponding_index <- match(corresponding_cells_after_outlier_removal,
                            original_cells_before_removal )
# check the matching
identical(as.character(original_cells_before_removal[corresponding_index]),
         corresponding_cells_after_outlier_removal)
#> [1] TRUE
# create new object with the new clustering after removing outliers
mixedpop2_post_clustering <- mixedpop2[,corresponding_index]
colData(mixedpop2_post_clustering)[,1] <- clustering_after_outlier_removal
```

## 3.2 Identify clusters in a dataset using SCORE (Stable Clustering at Optimal REsolution)

(skip this step if clusters are known)

(SCORE aims to get stable subpopulation results by introducing bagging aggregation and bootstrapping to the CORE algorithm)

```
# find clustering information in an expresion data using SCORE
day5 <- day_5_cardio_cell_sample
cellnames <- colnames(day5$dat5_counts)
cluster <-day5$dat5_clusters
cellnames <-data.frame("Cluster"=cluster, "cellBarcodes" = cellnames)
mixedpop2 <-new_scGPS_object(ExpressionMatrix = day5$dat5_counts,
                    GeneMetadata = day5$dat5geneInfo, CellMetadata = cellnames )

SCORE_test <- CORE_bagging(mixedpop2, remove_outlier = c(0), PCA=FALSE,
                                bagging_run = 20, subsample_proportion = .8)
```

## 3.3 Visualise all cluster results in all iterations

```
dev.off()
#> null device
#>           1
##3.2.1 plot CORE clustering
p1 <- plot_CORE(CORE_cluster$tree, CORE_cluster$Cluster,
    color_branch = c("#208eb7", "#6ce9d3", "#1c5e39", "#8fca40", "#154975",
        "#b1c8eb"))
p1
#> $mar
#> [1] 1 5 0 1
#extract optimal index identified by CORE
key_height <- CORE_cluster$optimalClust$KeyStats$Height
optimal_res <- CORE_cluster$optimalClust$OptimalRes
optimal_index = which(key_height == optimal_res)
#plot one optimal clustering bar
plot_optimal_CORE(original_tree= CORE_cluster$tree,
                 optimal_cluster = unlist(CORE_cluster$Cluster[optimal_index]),
                 shift = -2000)
#> Ordering and assigning labels...
#> 2
#> 162335NA
#> 3
#> 162335423
#> Plotting the colored dendrogram now....
#> Plotting the bar underneath now....

##3.2.2 plot SCORE clustering
#plot all clustering bars
plot_CORE(SCORE_test$tree, list_clusters = SCORE_test$Cluster)
#plot one stable optimal clustering bar
plot_optimal_CORE(original_tree= SCORE_test$tree,
                 optimal_cluster = unlist(SCORE_test$Cluster[
                    SCORE_test$optimal_index]),
                 shift = -100)
#> Ordering and assigning labels...
#> 2
#> 24112NANANANANA
#> 3
#> 24112250NANANANA
#> 4
#> 24112250335NANANA
#> 5
#> 24112250335367NANA
#> 6
#> 24112250335367414NA
#> 7
#> 24112250335367414470
#> Plotting the colored dendrogram now....
#> Plotting the bar underneath now....
```

## 3.4 Compare clustering results with other dimensional reduction methods (e.g., tSNE)

```
t <- tSNE(expression.mat=assay(mixedpop2))
#> Preparing PCA inputs using the top 1500 genes ...
#> Computing PCA values...
#> Running tSNE ...
p2 <-plot_reduced(t, color_fac = factor(colData(mixedpop2)[,1]),
                      palletes =1:length(unique(colData(mixedpop2)[,1])))
#> Warning: `qplot()` was deprecated in ggplot2 3.4.0.
#> ℹ The deprecated feature was likely used in the scGPS package.
#>   Please report the issue at
#>   <https://github.com/IMB-Computational-Genomics-Lab/scGPS/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The dot-dot notation (`..count..`) was deprecated in ggplot2 3.4.0.
#> ℹ Please use `after_stat(count)` instead.
#> ℹ The deprecated feature was likely used in the cowplot package.
#>   Please report the issue at <https://github.com/wilkelab/cowplot/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: Use of `reduced_dat_toPlot$Dim1` is discouraged.
#> ℹ Use `Dim1` instead.
#> Warning: Use of `reduced_dat_toPlot$Dim2` is discouraged.
#> ℹ Use `Dim2` instead.
p2
```

![](data:image/png;base64...)

## 3.5 Find gene markers and annotate clusters

```
#load gene list (this can be any lists of user-selected genes)
genes <-training_gene_sample
genes <-genes$Merged_unique

#the gene list can also be objectively identified by differential expression
#analysis cluster information is requied for find_markers. Here, we use
#CORE results.

#colData(mixedpop2)[,1] <- unlist(SCORE_test$Cluster[SCORE_test$optimal_index])

suppressMessages(library(locfit))

DEgenes <- find_markers(expression_matrix=assay(mixedpop2),
                            cluster = colData(mixedpop2)[,1],
                            selected_cluster=unique(colData(mixedpop2)[,1]))

#the output contains dataframes for each cluster.
#the data frame contains all genes, sorted by p-values
names(DEgenes)
#> [1] "baseMean"       "log2FoldChange" "lfcSE"          "stat"
#> [5] "pvalue"         "padj"           "id"

#you can annotate the identified clusters
DEgeneList_1vsOthers <- DEgenes$DE_Subpop1vsRemaining$id

#users need to check the format of the gene input to make sure they are
#consistent to the gene names in the expression matrix

#the following command saves the file "PathwayEnrichment.xlsx" to the
#working dir
#use 500 top DE genes
suppressMessages(library(DOSE))
suppressMessages(library(ReactomePA))
suppressMessages(library(clusterProfiler))
genes500 <- as.factor(DEgeneList_1vsOthers[seq_len(500)])
enrichment_test <- annotate_clusters(genes, pvalueCutoff=0.05, gene_symbol=TRUE)

#the enrichment outputs can be displayed by running
clusterProfiler::dotplot(enrichment_test, showCategory=10, font.size = 6)
```

![](data:image/png;base64...)

# 4. Relationship between clusters within one sample or between two samples

The purpose of this workflow is to solve the following task:

* Given one or two unknown mixed population(s) and clusters in each mixed population, estimate
* Visualise relationship between clusters\*

## 4.1 Start the scGPS prediction to find relationship between clusters

```
#select a subpopulation, and input gene list
c_selectID <- 1
#note make sure the format for genes input here is the same to the format
#for genes in the mixedpop1 and mixedpop2
genes = DEgenes$id[1:500]

#run the test bootstrap with nboots = 2 runs

cluster_mixedpop1 <- colData(mixedpop1)[,1]
cluster_mixedpop2 <- colData(mixedpop2)[,1]

LSOLDA_dat <- bootstrap_prediction(nboots = 2, mixedpop1 = mixedpop1,
                             mixedpop2 = mixedpop2, genes = genes,
                             c_selectID  = c_selectID,
                             listData = list(),
                             cluster_mixedpop1 = cluster_mixedpop1,
                             cluster_mixedpop2 = cluster_mixedpop2)
```

## 4.2 Display summary results for the prediction

```
#get the number of rows for the summary matrix
row_cluster <-length(unique(colData(mixedpop2)[,1]))

#summary results LDA to to show the percent of cells classified as cells
#belonging by LDA classifier
summary_prediction_lda(LSOLDA_dat=LSOLDA_dat, nPredSubpop = row_cluster )
#>                 V1               V2                                names
#> 1 12.2994652406417 87.1657754010695 LDA for subpop 1 in target mixedpop2
#> 2 72.1428571428571 97.1428571428571 LDA for subpop 2 in target mixedpop2
#> 3 14.2857142857143 67.6691729323308 LDA for subpop 3 in target mixedpop2
#> 4               35               85 LDA for subpop 4 in target mixedpop2

#summary results Lasso to show the percent of cells classified as cells
#belonging by Lasso classifier
summary_prediction_lasso(LSOLDA_dat=LSOLDA_dat, nPredSubpop = row_cluster)
#>                 V1               V2                                      names
#> 1 17.6470588235294 45.4545454545455 ElasticNet for subpop1 in target mixedpop2
#> 2 98.5714285714286              100 ElasticNet for subpop2 in target mixedpop2
#> 3 99.2481203007519 84.9624060150376 ElasticNet for subpop3 in target mixedpop2
#> 4             97.5             97.5 ElasticNet for subpop4 in target mixedpop2

# summary maximum deviance explained by the model during the model training
summary_deviance(object = LSOLDA_dat)
#> $allDeviance
#> [1] "34.11" "54.86"
#>
#> $DeviMax
#>           dat_DE$Dfd          Deviance           DEgenes
#> 1                  0             54.86    genes_cluster1
#> 2                  1             54.86    genes_cluster1
#> 3                  2             54.86    genes_cluster1
#> 4                  3             54.86    genes_cluster1
#> 5                  6             54.86    genes_cluster1
#> 6                  9             54.86    genes_cluster1
#> 7                 11             54.86    genes_cluster1
#> 8                 12             54.86    genes_cluster1
#> 9                 15             54.86    genes_cluster1
#> 10                17             54.86    genes_cluster1
#> 11                18             54.86    genes_cluster1
#> 12                22             54.86    genes_cluster1
#> 13                23             54.86    genes_cluster1
#> 14 remaining DEgenes remaining DEgenes remaining DEgenes
#>
#> $LassoGenesMax
#> NULL

# summary accuracy to check the model accuracy in the leave-out test set
summary_accuracy(object = LSOLDA_dat)
#> [1] 68.75000 63.39286
```

## 4.3 Plot the relationship between clusters in one sample

Here we look at one example use case to find relationship between clusters within one sample or between two sample

```
#run prediction for 3 clusters
cluster_mixedpop1 <- colData(mixedpop1)[,1]
cluster_mixedpop2 <- colData(mixedpop2)[,1]
#cluster_mixedpop2 <- as.numeric(as.vector(colData(mixedpop2)[,1]))

c_selectID <- 1
#top 200 gene markers distinguishing cluster 1
genes = DEgenes$id[1:200]

LSOLDA_dat1 <- bootstrap_prediction(nboots = 2, mixedpop1 = mixedpop2,
                        mixedpop2 = mixedpop2, genes=genes, c_selectID,
                        listData =list(),
                        cluster_mixedpop1 = cluster_mixedpop2,
                        cluster_mixedpop2 = cluster_mixedpop2)

c_selectID <- 2
genes = DEgenes$id[1:200]

LSOLDA_dat2 <- bootstrap_prediction(nboots = 2,mixedpop1 = mixedpop2,
                        mixedpop2 = mixedpop2, genes=genes, c_selectID,
                        listData =list(),
                        cluster_mixedpop1 = cluster_mixedpop2,
                        cluster_mixedpop2 = cluster_mixedpop2)

c_selectID <- 3
genes = DEgenes$id[1:200]
LSOLDA_dat3 <- bootstrap_prediction(nboots = 2,mixedpop1 = mixedpop2,
                        mixedpop2 = mixedpop2, genes=genes, c_selectID,
                        listData =list(),
                        cluster_mixedpop1 = cluster_mixedpop2,
                        cluster_mixedpop2 = cluster_mixedpop2)

c_selectID <- 4
genes = DEgenes$id[1:200]
LSOLDA_dat4 <- bootstrap_prediction(nboots = 2,mixedpop1 = mixedpop2,
                        mixedpop2 = mixedpop2, genes=genes, c_selectID,
                        listData =list(),
                        cluster_mixedpop1 = cluster_mixedpop2,
                        cluster_mixedpop2 = cluster_mixedpop2)

#prepare table input for sankey plot

LASSO_C1S2  <- reformat_LASSO(c_selectID=1, mp_selectID = 2,
                             LSOLDA_dat=LSOLDA_dat1,
                             nPredSubpop = length(unique(colData(mixedpop2)
                                [,1])),
                             Nodes_group ="#7570b3")

LASSO_C2S2  <- reformat_LASSO(c_selectID=2, mp_selectID =2,
                             LSOLDA_dat=LSOLDA_dat2,
                             nPredSubpop = length(unique(colData(mixedpop2)
                                [,1])),
                             Nodes_group ="#1b9e77")

LASSO_C3S2  <- reformat_LASSO(c_selectID=3, mp_selectID =2,
                             LSOLDA_dat=LSOLDA_dat3,
                             nPredSubpop = length(unique(colData(mixedpop2)
                                [,1])),
                             Nodes_group ="#e7298a")

LASSO_C4S2  <- reformat_LASSO(c_selectID=4, mp_selectID =2,
                             LSOLDA_dat=LSOLDA_dat4,
                             nPredSubpop = length(unique(colData(mixedpop2)
                                [,1])),
                             Nodes_group ="#00FFFF")

combined <- rbind(LASSO_C1S2,LASSO_C2S2,LASSO_C3S2, LASSO_C4S2 )
combined <- combined[is.na(combined$Value) != TRUE,]

nboots = 2
#links: source, target, value
#source: node, nodegroup
combined_D3obj <-list(Nodes=combined[,(nboots+3):(nboots+4)],
                     Links=combined[,c((nboots+2):(nboots+1),ncol(combined))])

library(networkD3)

Node_source <- as.vector(sort(unique(combined_D3obj$Links$Source)))
Node_target <- as.vector(sort(unique(combined_D3obj$Links$Target)))
Node_all <-unique(c(Node_source, Node_target))

#assign IDs for Source (start from 0)
Source <-combined_D3obj$Links$Source
Target <- combined_D3obj$Links$Target

for(i in 1:length(Node_all)){
   Source[Source==Node_all[i]] <-i-1
   Target[Target==Node_all[i]] <-i-1
}
#
combined_D3obj$Links$Source <- as.numeric(Source)
combined_D3obj$Links$Target <- as.numeric(Target)
combined_D3obj$Links$LinkColor <- combined$NodeGroup

#prepare node info
node_df <-data.frame(Node=Node_all)
node_df$id <-as.numeric(c(0, 1:(length(Node_all)-1)))

suppressMessages(library(dplyr))
Color <- combined %>% count(Node, color=NodeGroup) %>% select(2)
node_df$color <- Color$color

suppressMessages(library(networkD3))
p1<-sankeyNetwork(Links =combined_D3obj$Links, Nodes = node_df,
                 Value = "Value", NodeGroup ="color", LinkGroup = "LinkColor",
                 NodeID="Node", Source="Source", Target="Target", fontSize = 22)
p1
```

```
#saveNetwork(p1, file = paste0(path,'Subpopulation_Net.html'))
```

## 4.3 Plot the relationship between clusters in two samples

Here we look at one example use case to find relationship between clusters within one sample or between two sample

```
#run prediction for 3 clusters
cluster_mixedpop1 <- colData(mixedpop1)[,1]
cluster_mixedpop2 <- colData(mixedpop2)[,1]
row_cluster <-length(unique(colData(mixedpop2)[,1]))

c_selectID <- 1
#top 200 gene markers distinguishing cluster 1
genes = DEgenes$id[1:200]
LSOLDA_dat1 <- bootstrap_prediction(nboots = 2, mixedpop1 = mixedpop1,
                        mixedpop2 = mixedpop2, genes=genes, c_selectID,
                        listData =list(),
                        cluster_mixedpop1 = cluster_mixedpop1,
                        cluster_mixedpop2 = cluster_mixedpop2)

c_selectID <- 2
genes = DEgenes$id[1:200]
LSOLDA_dat2 <- bootstrap_prediction(nboots = 2,mixedpop1 = mixedpop1,
                        mixedpop2 = mixedpop2, genes=genes, c_selectID,
                        listData =list(),
                        cluster_mixedpop1 = cluster_mixedpop1,
                        cluster_mixedpop2 = cluster_mixedpop2)

c_selectID <- 3
genes = DEgenes$id[1:200]
LSOLDA_dat3 <- bootstrap_prediction(nboots = 2,mixedpop1 = mixedpop1,
                        mixedpop2 = mixedpop2, genes=genes, c_selectID,
                        listData =list(),
                        cluster_mixedpop1 = cluster_mixedpop1,
                        cluster_mixedpop2 = cluster_mixedpop2)

#prepare table input for sankey plot

LASSO_C1S1  <- reformat_LASSO(c_selectID=1, mp_selectID = 1,
                             LSOLDA_dat=LSOLDA_dat1, nPredSubpop = row_cluster,
                             Nodes_group = "#7570b3")

LASSO_C2S1  <- reformat_LASSO(c_selectID=2, mp_selectID = 1,
                             LSOLDA_dat=LSOLDA_dat2, nPredSubpop = row_cluster,
                             Nodes_group = "#1b9e77")

LASSO_C3S1  <- reformat_LASSO(c_selectID=3, mp_selectID = 1,
                             LSOLDA_dat=LSOLDA_dat3, nPredSubpop = row_cluster,
                             Nodes_group = "#e7298a")

combined <- rbind(LASSO_C1S1,LASSO_C2S1,LASSO_C3S1)

nboots = 2
#links: source, target, value
#source: node, nodegroup
combined_D3obj <-list(Nodes=combined[,(nboots+3):(nboots+4)],
                     Links=combined[,c((nboots+2):(nboots+1),ncol(combined))])
combined <- combined[is.na(combined$Value) != TRUE,]

library(networkD3)

Node_source <- as.vector(sort(unique(combined_D3obj$Links$Source)))
Node_target <- as.vector(sort(unique(combined_D3obj$Links$Target)))
Node_all <-unique(c(Node_source, Node_target))

#assign IDs for Source (start from 0)
Source <-combined_D3obj$Links$Source
Target <- combined_D3obj$Links$Target

for(i in 1:length(Node_all)){
   Source[Source==Node_all[i]] <-i-1
   Target[Target==Node_all[i]] <-i-1
}

combined_D3obj$Links$Source <- as.numeric(Source)
combined_D3obj$Links$Target <- as.numeric(Target)
combined_D3obj$Links$LinkColor <- combined$NodeGroup

#prepare node info
node_df <-data.frame(Node=Node_all)
node_df$id <-as.numeric(c(0, 1:(length(Node_all)-1)))

suppressMessages(library(dplyr))
n <- length(unique(node_df$Node))
getPalette = colorRampPalette(RColorBrewer::brewer.pal(9, "Set1"))
Color = getPalette(n)
node_df$color <- Color
suppressMessages(library(networkD3))
p1<-sankeyNetwork(Links =combined_D3obj$Links, Nodes = node_df,
                 Value = "Value", NodeGroup ="color", LinkGroup = "LinkColor",
                 NodeID="Node", Source="Source", Target="Target", fontSize = 22)
p1
```

```
#saveNetwork(p1, file = paste0(path,'Subpopulation_Net.html'))
```

```
devtools::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package              * version    date (UTC) lib source
#>  abind                  1.4-8      2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi        * 1.72.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ape                    5.8-1      2024-12-16 [2] CRAN (R 4.5.1)
#>  aplot                  0.2.9      2025-09-12 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocParallel           1.44.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0      2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1    2025-01-16 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4      2023-03-17 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0      2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0      2024-05-16 [2] CRAN (R 4.5.1)
#>  caret                * 7.0-1      2024-12-10 [2] CRAN (R 4.5.1)
#>  class                  7.3-23     2025-01-01 [3] CRAN (R 4.5.1)
#>  cli                    3.6.5      2025-04-23 [2] CRAN (R 4.5.1)
#>  clusterProfiler      * 4.18.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  codetools              0.2-20     2024-03-31 [3] CRAN (R 4.5.1)
#>  cowplot                1.2.0      2025-07-07 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3      2024-06-20 [2] CRAN (R 4.5.1)
#>  data.table             1.17.8     2025-07-10 [2] CRAN (R 4.5.1)
#>  data.tree              1.2.0      2025-08-25 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3      2024-06-02 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dendextend             1.19.1     2025-07-15 [2] CRAN (R 4.5.1)
#>  DESeq2                 1.50.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  devtools               2.4.6      2025-10-03 [2] CRAN (R 4.5.1)
#>  dichromat              2.0-0.1    2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37     2024-08-19 [2] CRAN (R 4.5.1)
#>  DOSE                 * 4.4.0      2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dplyr                * 1.1.4      2023-11-17 [2] CRAN (R 4.5.1)
#>  dynamicTreeCut       * 1.63-1     2016-03-11 [2] CRAN (R 4.5.1)
#>  e1071                  1.7-16     2024-09-16 [2] CRAN (R 4.5.1)
#>  ellipsis               0.3.2      2021-04-29 [2] CRAN (R 4.5.1)
#>  enrichplot             1.30.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  evaluate               1.0.5      2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2      2024-05-13 [2] CRAN (R 4.5.1)
#>  fastcluster            1.3.0      2025-05-07 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0      2024-05-15 [2] CRAN (R 4.5.1)
#>  fastmatch              1.1-6      2024-12-23 [2] CRAN (R 4.5.1)
#>  fgsea                  1.36.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  fontBitstreamVera      0.1.1      2017-02-01 [2] CRAN (R 4.5.1)
#>  fontLiberation         0.1.0      2016-10-15 [2] CRAN (R 4.5.1)
#>  fontquiver             0.2.1      2017-02-01 [2] CRAN (R 4.5.1)
#>  foreach                1.5.2      2022-02-02 [2] CRAN (R 4.5.1)
#>  fs                     1.6.6      2025-04-12 [2] CRAN (R 4.5.1)
#>  future                 1.67.0     2025-07-29 [2] CRAN (R 4.5.1)
#>  future.apply           1.20.0     2025-06-06 [2] CRAN (R 4.5.1)
#>  gdtools                0.4.4      2025-10-06 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4      2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggforce                0.5.0      2025-06-18 [2] CRAN (R 4.5.1)
#>  ggfun                  0.2.0      2025-07-15 [2] CRAN (R 4.5.1)
#>  ggiraph                0.9.2      2025-10-07 [2] CRAN (R 4.5.1)
#>  ggplot2              * 4.0.0      2025-09-11 [2] CRAN (R 4.5.1)
#>  ggplotify              0.1.3      2025-09-20 [2] CRAN (R 4.5.1)
#>  ggraph                 2.2.2      2025-08-24 [2] CRAN (R 4.5.1)
#>  ggrepel                0.9.6      2024-09-07 [2] CRAN (R 4.5.1)
#>  ggtangle               0.0.7      2025-06-30 [2] CRAN (R 4.5.1)
#>  ggtree                 4.0.0      2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  glmnet                 4.1-10     2025-07-17 [2] CRAN (R 4.5.1)
#>  globals                0.18.0     2025-05-08 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0      2024-09-30 [2] CRAN (R 4.5.1)
#>  GO.db                  3.22.0     2025-10-08 [2] Bioconductor
#>  GOSemSim               2.36.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  gower                  1.0.2      2024-12-17 [2] CRAN (R 4.5.1)
#>  graph                  1.88.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  graphite               1.56.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  graphlayouts           1.2.2      2025-01-23 [2] CRAN (R 4.5.1)
#>  gridExtra              2.3        2017-09-09 [2] CRAN (R 4.5.1)
#>  gridGraphics           0.5-1      2020-12-13 [2] CRAN (R 4.5.1)
#>  gson                   0.1.0      2023-03-07 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6      2024-10-25 [2] CRAN (R 4.5.1)
#>  hardhat                1.4.2      2025-08-20 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1    2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4      2023-12-06 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7      2023-08-15 [2] CRAN (R 4.5.1)
#>  igraph                 2.2.1      2025-10-27 [2] CRAN (R 4.5.1)
#>  ipred                  0.9-15     2024-07-18 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iterators              1.0.14     2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4      2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0      2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50       2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3      2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice              * 0.22-7     2025-04-02 [3] CRAN (R 4.5.1)
#>  lava                   1.8.1      2025-01-12 [2] CRAN (R 4.5.1)
#>  lazyeval               0.2.2      2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle              1.0.4      2023-11-07 [2] CRAN (R 4.5.1)
#>  listenv                0.9.1      2024-01-29 [2] CRAN (R 4.5.1)
#>  locfit               * 1.5-9.12   2025-03-05 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4      2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4      2025-09-12 [2] CRAN (R 4.5.1)
#>  MASS                   7.3-65     2025-02-28 [3] CRAN (R 4.5.1)
#>  Matrix                 1.7-4      2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0      2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1      2021-11-26 [2] CRAN (R 4.5.1)
#>  ModelMetrics           1.2.2.2    2020-03-17 [2] CRAN (R 4.5.1)
#>  networkD3            * 0.4.1      2025-04-14 [2] CRAN (R 4.5.1)
#>  nlme                   3.1-168    2025-03-31 [3] CRAN (R 4.5.1)
#>  nnet                   7.3-20     2025-01-01 [3] CRAN (R 4.5.1)
#>  org.Hs.eg.db         * 3.22.0     2025-10-08 [2] Bioconductor
#>  parallelly             1.45.1     2025-07-24 [2] CRAN (R 4.5.1)
#>  patchwork              1.3.2      2025-08-25 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1     2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgbuild               1.4.8      2025-05-26 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3      2019-09-22 [2] CRAN (R 4.5.1)
#>  pkgload                1.4.1      2025-09-23 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9      2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8      2022-11-29 [2] CRAN (R 4.5.1)
#>  polyclip               1.10-7     2024-07-23 [2] CRAN (R 4.5.1)
#>  pROC                   1.19.0.1   2025-07-31 [2] CRAN (R 4.5.1)
#>  prodlim                2025.04.28 2025-04-28 [2] CRAN (R 4.5.1)
#>  proxy                  0.4-27     2022-06-09 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0      2025-07-10 [2] CRAN (R 4.5.1)
#>  qvalue                 2.42.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  R.methodsS3            1.8.2      2022-06-13 [2] CRAN (R 4.5.1)
#>  R.oo                   1.27.1     2025-05-02 [2] CRAN (R 4.5.1)
#>  R.utils                2.13.0     2025-02-24 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1      2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3      2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3      2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0      2025-07-02 [2] CRAN (R 4.5.1)
#>  RcppArmadillo          15.0.2-2   2025-09-19 [2] CRAN (R 4.5.1)
#>  RcppParallel           5.1.11-1   2025-08-27 [2] CRAN (R 4.5.1)
#>  reactome.db            1.94.0     2025-10-08 [2] Bioconductor
#>  ReactomePA           * 1.54.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  recipes                1.3.1      2025-05-21 [2] CRAN (R 4.5.1)
#>  remotes                2.5.0      2024-03-17 [2] CRAN (R 4.5.1)
#>  reshape2               1.4.4      2020-04-09 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6      2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30       2025-09-28 [2] CRAN (R 4.5.1)
#>  rpart                  4.1.24     2025-01-07 [3] CRAN (R 4.5.1)
#>  RSQLite                2.4.3      2025-08-20 [2] CRAN (R 4.5.1)
#>  Rtsne                  0.17       2023-12-07 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0      2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10     2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0      2025-04-24 [2] CRAN (R 4.5.1)
#>  scGPS                * 1.24.0     2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  Seqinfo              * 1.0.0      2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo            1.2.3      2025-02-05 [2] CRAN (R 4.5.1)
#>  shape                  1.4.6.1    2024-02-23 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment * 1.32.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  stringi                1.8.7      2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2      2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  survival               3.8-3      2024-12-17 [3] CRAN (R 4.5.1)
#>  systemfonts            1.3.1      2025-10-01 [2] CRAN (R 4.5.1)
#>  tibble                 3.3.0      2025-06-08 [2] CRAN (R 4.5.1)
#>  tidygraph              1.3.1      2024-01-30 [2] CRAN (R 4.5.1)
#>  tidyr                  1.3.1      2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1      2024-03-11 [2] CRAN (R 4.5.1)
#>  tidytree               0.4.6      2023-12-12 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0      2024-01-18 [2] CRAN (R 4.5.1)
#>  timeDate               4051.111   2025-10-17 [2] CRAN (R 4.5.1)
#>  treeio                 1.34.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tweenr                 2.0.3      2024-02-26 [2] CRAN (R 4.5.1)
#>  usethis                3.2.1      2025-09-06 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5      2023-12-01 [2] CRAN (R 4.5.1)
#>  viridis                0.6.5      2024-01-29 [2] CRAN (R 4.5.1)
#>  viridisLite            0.4.2      2023-05-02 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2      2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53       2025-08-19 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10     2024-07-26 [2] CRAN (R 4.5.1)
#>  yulab.utils            0.2.1      2025-08-19 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpGlxzV7/Rinst2ec89d452dfc7
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```