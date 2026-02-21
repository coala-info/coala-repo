# Code example from 'curatedadiporna_vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----install_biocmanager,eval=FALSE-------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("curatedAdipoRNA")

## ----loading_libraries, message=FALSE-----------------------------------------
# loading required libraries
library(curatedAdipoRNA)
library(SummarizedExperiment)
library(S4Vectors)
library(fastqcr)
library(DESeq2)
library(dplyr)
library(tidyr)
library(ggplot2)

## ----loading_data-------------------------------------------------------------
# load data
data("adipo_counts")

# print object
adipo_counts

## ----adipo_counts-------------------------------------------------------------
# print count matrix
assay(adipo_counts)[1:5, 1:5]

## ----colData------------------------------------------------------------------
# names of the coldata object
names(colData(adipo_counts))

# table of times column
table(colData(adipo_counts)$time)

# table of stage column
table(colData(adipo_counts)$stage)

## ----rowRanges----------------------------------------------------------------
# print GRanges object
rowRanges(adipo_counts)

## ----qc-----------------------------------------------------------------------
# show qc data
adipo_counts$qc

# show the class of the first entry in qc
class(adipo_counts$qc[[1]][[1]])

## ----metadata, message=FALSE--------------------------------------------------
# print data of first study
metadata(adipo_counts)$studies[1,]

## ----summary_table,echo=FALSE-------------------------------------------------
# generate a study summary table
colData(adipo_counts) %>%
as.data.frame() %>%
  group_by(study_name) %>%
  summarise(pmid = unique(pmid),
            nsamples = n(),
            time = paste(unique(time), collapse = '/'),
            stages = paste(unique(stage), collapse = '/'),
            instrument_model = unique(instrument_model)) %>%
  knitr::kable(align = 'cccccc',
               col.names = c('GEO series ID', 'PubMed ID', 'Num. of Samples',
                             'Time (hr)', 'Differentiation Stage', 
                             'Instrument Model'))

## ----subset_object------------------------------------------------------------
# subsetting counts to 0 and 24 hours
se <- adipo_counts[, adipo_counts$time %in% c(0, 24)]

# showing the numbers of features, samples and time groups
dim(se)
table(se$time)

## ----filtering_samples--------------------------------------------------------
# filtering low quality samples
# chek the library layout
table(se$library_layout)

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
    select(Base, Mean) %>%
    transform(Base = strsplit(as.character(Base), '-')) %>%
    unnest(Base) %>%
    mutate(Base = as.numeric(Base))
}) %>%
  bind_rows(.id = 'run')

## ----score_summary------------------------------------------------------------
# a quick look at quality scores
summary(per_base)

## ----finding_low_scores,fig.align='centre',fig.height=3,fig.width=7-----------
# find low quality runs
per_base <- per_base %>%
  group_by(run) %>%
  mutate(length = max(Base) > 150,
         run_average = mean(Mean) > 34)

# plot average per base quality
per_base %>%
  ggplot(aes(x = Base, y = Mean, group = run, color = run_average)) +
  geom_line() +
  facet_wrap(~length, scales = 'free_x')

## ----remove_lowscore----------------------------------------------------------
# get run ids of low quality samples
bad_samples <- data.frame(samples = unique(per_base$run[per_base$run_average == FALSE]))
bad_samples <- separate(bad_samples, col = samples, into = c('id', 'run'), sep = '\\.')

# subset the counts object
se2 <- se[, !se$id %in% bad_samples$id]
table(se2$time)

## ----remove low_counts--------------------------------------------------------
# filtering low count genes
low_counts <- apply(assay(se2), 1, function(x) length(x[x>10])>=2)
table(low_counts)

# subsetting the count object
se3 <- se2[low_counts,]

## ----differential expression--------------------------------------------------
# differential expression analysis
se3$time <- factor(se3$time)
dds <- DESeqDataSet(se3, ~time)
dds <- DESeq(dds)
res <- results(dds)
table(res$padj < .1)

## ----pca,fig.align='centre',fig.height=4,fig.width=4--------------------------
# explaining variabce 
plotPCA(rlog(dds), intgroup = 'time')
plotPCA(rlog(dds), intgroup = 'library_layout')
plotPCA(rlog(dds), intgroup = 'instrument_model')

## ----studies_keys-------------------------------------------------------------
# keys of the studies in this subset of the data
unique(se3$bibtexkey)

## ----citation, warning=FALSE--------------------------------------------------
# citing the package
citation("curatedAdipoRNA")

## ----session_info-------------------------------------------------------------
devtools::session_info()

