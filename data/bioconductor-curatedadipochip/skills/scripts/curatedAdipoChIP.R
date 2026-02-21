# Code example from 'curatedAdipoChIP' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install_biocmanager,eval=FALSE-------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("curatedAdipoChIP")

## ----loading_libraries, message=FALSE-----------------------------------------
# loading required libraries
library(ExperimentHub)
library(SummarizedExperiment)
library(S4Vectors)
library(fastqcr)
library(DESeq2)
library(dplyr)
library(tidyr)
library(ggplot2)

## ----loading_data-------------------------------------------------------------
# query package resources on ExperimentHub
eh <- ExperimentHub()
query(eh, "curatedAdipoChIP")

# load data from ExperimentHub
peak_counts <- query(eh, "curatedAdipoChIP")[[1]]

# print object
peak_counts

## ----peak_counts--------------------------------------------------------------
# print count matrix
assay(peak_counts)[1:5, 1:5]

## ----colData------------------------------------------------------------------
# names of the coldata object
names(colData(peak_counts))

# table of times column
table(colData(peak_counts)$time)

# table of stage column
table(colData(peak_counts)$stage)

# table of factor column
table(colData(peak_counts)$factor)

## ----rowRanges----------------------------------------------------------------
# print GRanges object
rowRanges(peak_counts)

## ----metadata, message=FALSE--------------------------------------------------
# print data of first study
metadata(peak_counts)$studies[1,]

## ----summary_table,echo=FALSE-------------------------------------------------
# generate a study summary table
colData(peak_counts)[, c(-2, -12)] %>%
  as_tibble() %>%
  filter(!is.na(control_id)) %>%
  group_by(study) %>%
  summarise(pmid = unique(pmid),
            nsamples = n(),
            time = paste(unique(time), collapse = '/ '),
            stages = paste(unique(stage), collapse = '/'),
            factor = paste(unique(factor), collapse = '/ ')) %>%
  knitr::kable(align = 'cccccc',
               col.names = c('GEO series ID', 'PubMed ID', 'Num. of Samples',
                             'Time (hr)', 'Differentiation Stage', 'Factor'))

## ----control_samples----------------------------------------------------------
# show the number of control samples
table(is.na(peak_counts$control_id))

## ----subset object------------------------------------------------------------
# subset peaks_count object
# select samples for the factor CEBPB and stage 0 and 1
sample_ind <- (peak_counts$factor == 'CEBPB') & (peak_counts$stage %in% c(0, 1))
sample_ids <- colnames(peak_counts)[sample_ind]

# select peaks from the selected samples
peak_ind <- lapply(mcols(peak_counts)$peak, function(x) sum(sample_ids %in% x))
peak_ind <- unlist(peak_ind) > 2

# subset the object
se <- peak_counts[peak_ind, sample_ind]

# show the number of samples in each group
table(se$stage)

# show the number of peak in each sample
table(unlist(mcols(se)$peak))[sample_ids]

## ----filtering_samples--------------------------------------------------------
# check the number of files in qc
qc <- se$qc
table(lengths(qc))

# flattening qc list
qc <- unlist(qc, recursive = FALSE)
length(qc)

## ----per_base_scores----------------------------------------------------------
# extracting per_base_sequence_quality
per_base <- lapply(qc, function(x) {
  df <- x[['per_base_sequence_quality']]
  df %>%
    dplyr::select(Base, Mean) %>%
    transform(Base = strsplit(as.character(Base), '-')) %>%
    unnest(Base) %>%
    mutate(Base = as.numeric(Base))
}) %>%
  bind_rows(.id = 'run')

## ----score_summary------------------------------------------------------------
# a quick look at quality scores
summary(per_base)

## ----finding_low_scores,fig.align='centre',fig.height=4,fig.width=4-----------
# find low quality runs
per_base <- per_base %>%
  group_by(run) %>%
  mutate(run_average = mean(Mean) > 34)

# plot average per base quality
per_base %>%
  ggplot(aes(x = Base, y = Mean, group = run, color = run_average)) +
  geom_line() +
  lims(y = c(0,40))

## ----remove_lowscore----------------------------------------------------------
# get run ids of low quality samples
bad_runs <- unique(per_base$run[per_base$run_average == FALSE])
bad_samples <- lapply(se$runs, function(x) sum(x$run %in% bad_runs))

# subset the counts object
se2 <- se[, unlist(bad_samples) == 0]

# show remaining samples by stage
table(se2$stage) 

## ----remove_low_counts--------------------------------------------------------
# filtering low count genes
low_counts <- apply(assay(se2), 1, function(x) length(x[x>10])>=2)
table(low_counts)

# subsetting the count object
se3 <- se2[low_counts,]

## ----sampel_correlations,fig.align='centre',fig.height=6,fig.width=7----------
# plot scatters of samples from each group
par(mfrow = c(2,3))
lapply(split(colnames(se3), se3$stage), function(x) {
  # get counts of three samples
  y1 <- assay(se3)[, x[1]]
  y2 <- assay(se3)[, x[2]]
  y3 <- assay(se3)[, x[3]]
  
  # plot scatters of pairs of samples
  plot(log10(y1 + 1), log10(y2 + 1), xlab = x[1], ylab = x[2])
  plot(log10(y1 + 1), log10(y3 + 1), xlab = x[1], ylab = x[3])
  plot(log10(y2 + 1), log10(y3 + 1), xlab = x[2], ylab = x[3])
})

## ----differential_binding-----------------------------------------------------
# differential binding analysis
colData(se3) <- colData(se3)[, -2]
se3$stage <- factor(se3$stage)
dds <- DESeqDataSet(se3, ~stage)
dds <- DESeq(dds)
res <- results(dds)
table(res$padj < .1)

## ----pca,fig.align='centre',fig.height=4,fig.width=4--------------------------
# explaining variabce 
plotPCA(rlog(dds), intgroup = 'stage')
plotPCA(rlog(dds), intgroup = 'study')

## ----studies_keys-------------------------------------------------------------
# keys of the studies in this subset of the data
unique(se3$bibtexkey)

## ----citation, warning=FALSE--------------------------------------------------
# citing the package
citation("curatedAdipoChIP")

## ----session_info-------------------------------------------------------------
devtools::session_info()

