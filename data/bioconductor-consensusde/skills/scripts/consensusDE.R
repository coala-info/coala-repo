# Code example from 'consensusDE' vignette. See references/ for full tutorial.

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
# load consensusDE
library(consensusDE)

# load airway and dm3/Hs transcript database for example annotation
library(airway)
library(TxDb.Dmelanogaster.UCSC.dm3.ensGene)
library(EnsDb.Hsapiens.v86)
library(org.Hs.eg.db)

data("airway")

## ----echo=TRUE----------------------------------------------------------------
# build a design table that lists the files and their grouping
file_list <- list.files(system.file("extdata", package="GenomicAlignments"), 
                        recursive = TRUE, 
                        pattern = "*bam$", 
                        full = TRUE)

# Prepare a sample table to be used with buildSummarized()
# must be comprised of a minimum of two columns, named "file" and "group", 
# with one additional column: "pairs" if the data is paired

sample_table <- data.frame("file" = basename(file_list),
                           "group" = c("treat", "untreat"))

# extract the path to the bam directory - where to search for files listed in "sample_table"
bam_dir <- as.character(gsub(basename(file_list)[1], "", file_list[1]))


## ----echo=TRUE, warning=FALSE-------------------------------------------------
# NB. force_build = TRUE, is set to allow the Summarized Experiment to be built.
# This will report a Warning message that less than two replicates are present 
# in the sample_table.

summarized_dm3 <- buildSummarized(sample_table = sample_table,
                                  bam_dir = bam_dir,
                                  tx_db = TxDb.Dmelanogaster.UCSC.dm3.ensGene,
                                  read_format = "paired",
                                  force_build = TRUE)


## ----echo=TRUE----------------------------------------------------------------
summarized_dm3

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
# for compatability for DE analysis, add "group" and "file" columns
colData(airway)$group <- colData(airway)$dex
colData(airway)$file <- rownames(colData(airway))

# filter low count data
airway_filter <- buildSummarized(summarized = airway,
                                 filter = TRUE)

# for illustration, we only use sa random sample of 1000 transcripts
set.seed(1234)
airway_filter <- sample(airway_filter, 1000)

# call multi_de_pairs()
all_pairs_airway <- multi_de_pairs(summarized = airway_filter,
                                   paired = "unpaired",
                                   ruv_correct = FALSE)


## ----echo=TRUE----------------------------------------------------------------
# To view all the comparisons conducted:
names(all_pairs_airway$merged)
# [1] "untrt-trt"

# to access data of a particular comparison
head(all_pairs_airway$merged[["untrt-trt"]])

## ----echo=TRUE, message=FALSE-------------------------------------------------
# first ensure annotation database in installed
#library(org.Hs.eg.db)
#library(EnsDb.Hsapiens.v86)

# Preloaded summarized file did not contain meta-data of the tx_db. This is important if you want to extract chromosome coordinates. This can be easily updated by rerunning buildSummarized with the tx_db of choice.
airway_filter <- buildSummarized(summarized = airway_filter,
                                 tx_db = EnsDb.Hsapiens.v86,
                                 filter = FALSE)

# call multi_de_pairs(), 
# set ensembl_annotate argument to org.Hs.eg.db
all_pairs_airway <- multi_de_pairs(summarized = airway_filter,
                                   paired = "unpaired",
                                   ruv_correct = FALSE,
                                   ensembl_annotate = org.Hs.eg.db)

# to access data of a particular comparison
head(all_pairs_airway$merged[["untrt-trt"]])

## ----echo=TRUE, message=FALSE, warning=TRUE-----------------------------------

# call multi_de_pairs()
all_pairs_airway_ruv <- multi_de_pairs(summarized = airway_filter,
                                       paired = "unpaired",
                                       ruv_correct = TRUE)

# access the summarized experiment (now including the residuals under the "W_1" column)
all_pairs_airway_ruv$summarized@phenoData@data

# view the results, now with RUV correction applied
head(all_pairs_airway_ruv$merged[["untrt-trt"]])

## ----echo=TRUE, message=FALSE-------------------------------------------------
# add "pairs" column to airway_filter summarized object
colData(airway_filter)$pairs <- as.factor(c("pair1", "pair1", "pair2", "pair2", "pair3", "pair3", "pair4", "pair4"))

# run multi_de_pairs in "paired" mode
all_pairs_airway_paired <- multi_de_pairs(summarized = airway_filter,
                                          paired = "paired",
                                          ruv_correct = TRUE)

head(all_pairs_airway_paired$merged[["untrt-trt"]])

## ----echo=TRUE, message=FALSE-------------------------------------------------
all_pairs_airway_paired$voom$fitted[[1]]$design

## ----echo=TRUE, message=FALSE-------------------------------------------------
diag_plots(se_in = airway_filter,
           name = "airway example data",
           mapped_reads = TRUE)

## ----echo=TRUE, message=FALSE-------------------------------------------------
diag_plots(se_in = airway_filter,
           name = "airway example data",
           rle = TRUE)

## ----echo=TRUE, message=FALSE-------------------------------------------------
diag_plots(se_in = airway_filter,
           name = "airway example data",
           pca = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# diag_plots(se_in = all_pairs_airway$summarized,
#            name = "airway example data",
#            residuals = TRUE)

## ----echo=TRUE, message=FALSE-------------------------------------------------
diag_plots(se_in = airway_filter,
           name = "airway example data",
           hclust = TRUE)

## ----echo=TRUE, message=FALSE-------------------------------------------------
diag_plots(se_in = airway_filter,
           name = "airway example data",
           density = TRUE)

## ----echo=TRUE, message=FALSE-------------------------------------------------
diag_plots(se_in = airway_filter,
           name = "airway example data",
           boxplot = TRUE)

## ----echo=TRUE----------------------------------------------------------------
# 1. View all the comparisons conducted
names(all_pairs_airway$merged)
# 2. Extract the data.frame of interest of a particular comparison
comparison <- all_pairs_airway$merged[["untrt-trt"]]

## ----eval=FALSE---------------------------------------------------------------
# # this will not work unless in a list and will stop, producing an error. E.g.
# diag_plots(merged_in = comparison,
#            name = "untrt-trt",
#            ma = TRUE)
# 
# # Error message:
# merged_in is not a list. If you want to plot with one comparison only,
# put the single dataframe into a list as follows. my_list <- list("name"=
# merged_in)

## ----echo=TRUE----------------------------------------------------------------
# 3. Put into a new list as instructed by the error
comparison_list <- list("untrt-trt" = comparison)

# this will not work unless the appropriate columns are labelled
# "ID", "AveExpr", and "Adj_PVal"

# 4. Relabel the columns for plotting
# inspecting the column names reveals that the "Adj_PVal" column needs to be specified.
colnames(comparison_list[["untrt-trt"]])

# Here, we will relabel "edger_adj_p" with "Adj_PVal" to use this p-value, using
# the "gsub" command as follows (however, we could also use one of the others or
# the p_max column)

colnames(comparison_list[["untrt-trt"]]) <- gsub("edger_adj_p", "Adj_PVal",
                                                 colnames(comparison_list[["untrt-trt"]]))

# after label
colnames(comparison_list[["untrt-trt"]])

## ----echo=TRUE, message=FALSE-------------------------------------------------
# 5. Plot MA
diag_plots(merged_in = comparison_list,
           name = "untrt-trt",
           ma = TRUE)

## ----echo=TRUE, message=FALSE-------------------------------------------------
diag_plots(merged_in = comparison_list,
           name = "untrt-trt",
           volcano = TRUE)

## ----echo=TRUE, message=FALSE-------------------------------------------------
diag_plots(merged_in = comparison_list,
           name = "untrt-trt",
           p_dist = TRUE)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
citation("consensusDE")

