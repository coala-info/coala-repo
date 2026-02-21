# Code example from 'recountmethylation_search_index' vignette. See references/ for full tutorial.

## ----chunk_settings, eval = TRUE, echo = FALSE, warning = FALSE, message = FALSE----
libv <- c("recountmethylation", "basilisk", "reticulate", "HDF5Array", "ggplot2")
sapply(libv, library, character.only = TRUE)
knitr::opts_chunk$set(eval = FALSE, echo = TRUE, warning = FALSE, message = FALSE)

## ----setup, echo = F----------------------------------------------------------
# si.dpath <- system.file("extdata", "sitest", package = "recountmethylation")
# # get object paths
# bval.fpath <- file.path(si.dpath, "bval_100.csv")
# fhtable.fpath <- file.path(si.dpath, "bval_100_fh10.csv")
# md.fpath <- file.path(si.dpath, "mdf_sitest.rda")
# # load objects
# bval <- read.csv(bval.fpath)
# fhtable <- read.csv(fhtable.fpath)
# md <- get(load(md.fpath))

## ----eval = FALSE-------------------------------------------------------------
# recountmethylation:::setup_sienv(env.name = "dnam_si_vignette")

## ----eval = FALSE-------------------------------------------------------------
# gr.fname <- "gr-noob_h5se_hm450k-epic-merge_0-0-3"
# gr <- HDF5Array::loadHDF5SummarizedExperiment(gr.fname)
# md <- as.data.frame(colData(gr)) # get sample metadata

## -----------------------------------------------------------------------------
# # identify samples from metadata
# gseid <- "GSE67393"
# gsmv <- md[md$gse == gseid,]$gsm # get study samples
# gsmv <- gsmv[sample(length(gsmv), 10)]

## -----------------------------------------------------------------------------
# # get random samples by group label
# set.seed(1)
# mdf <- md[md$blood.subgroup=="PBMC",]
# gsmv <- c(gsmv, mdf[sample(nrow(mdf), 20),]$gsm)
# mdf <- md[md$blood.subgroup=="whole_blood",]
# gsmv <- c(gsmv, mdf[sample(nrow(mdf), 20),]$gsm)

## ----eval = FALSE-------------------------------------------------------------
# # norm bvals for probe subset
# num.cg <- 100
# grf <- gr[,gr$gsm %in% gsmv]; dim(grf)
# bval <- getBeta(grf[sample(nrow(grf), num.cg),])
# bval <- t(bval) # get transpose
# rownames(bval) <- gsub("\\..*", "", rownames(bval)) # format rownames

## -----------------------------------------------------------------------------
# # save bval table
# bval.fpath <- paste0("bval_",num.cg,".csv")
# write.csv(bval, file = bval.fpath)

## ----eval = FALSE-------------------------------------------------------------
# # get example table and labels
# num.dim <- 10 # target reduced dimensions
# fhtable.fpath <- "bval_100_fh10.csv"
# recountmethylation:::get_fh(csv_savepath = fhtable.fpath,
#                             csv_openpath = bval.fpath,
#                             ndim = num.dim)

## -----------------------------------------------------------------------------
# # set file paths
# si.fname.str <- "new_search_index"
# si.fpath <- file.path(si.dpath, paste0(si.fname.str, ".pickle"))
# sidict.fpath <- file.path(si.dpath, paste0(si.fname.str, "_dict.pickle"))
# # make the new search index
# recountmethylation:::make_si(fh_csv_fpath = fhtable.fpath,
#                              si_fname = si.fpath,
#                              si_dict_fname = sidict.fpath)

## -----------------------------------------------------------------------------
# query.gsmv <- c("GSM1506297", "GSM1646161", "GSM1646175", "GSM1649753", "GSM1649758", "GSM1649762")

## -----------------------------------------------------------------------------
# lkval <- c(1, 5, 10, 20) # vector of query k values

## -----------------------------------------------------------------------------
# si_fpath <- system.file("extdata", "sitest", package = "recountmethylation")
# dfnn <- recountmethylation:::query_si(sample_idv = query.gsmv,
#                                       fh_csv_fpath = fhtable.fpath,
#                                       si_fname = "new_search_index",
#                                       si_fpath = si_fpath,
#                                       lkval = lkval)

## -----------------------------------------------------------------------------
# dim(dfnn)

## -----------------------------------------------------------------------------
# colnames(dfnn)

## -----------------------------------------------------------------------------
# unlist(strsplit(dfnn[1,"k=1"], ";"))

## -----------------------------------------------------------------------------
# unlist(strsplit(dfnn[1,"k=5"], ";"))

## -----------------------------------------------------------------------------
# unlist(strsplit(dfnn[1,"k=10"], ";"))

## -----------------------------------------------------------------------------
# gsmvi <- unlist(strsplit(dfnn[1, "k=5"], ";"))
# blood.typev <- md[gsmvi,]$blood.subgroup

## -----------------------------------------------------------------------------
# dist.wb <- unlist(lapply(seq(nrow(dfnn)), function(ii){
#   gsmvi <- unlist(strsplit(dfnn[ii,"k=20"], ";"))
#   length(which(md[gsmvi,]$blood.subgroup=="whole_blood"))
# }))

## -----------------------------------------------------------------------------
# dfp <- data.frame(num.samples = dist.wb)
# dfp$perc.samples <- 100*dfp$num.samples/20
# dfp$type <- "whole_blood"
# ggplot(dfp, aes(x = type, y = perc.samples)) +
#   geom_violin() + geom_boxplot(width = 0.2) + theme_bw() +
#   ylab("Percent of neighbors") + theme(axis.title.x = element_blank()) +
#   scale_y_continuous(labels = scales::percent_format(scale = 1))

## -----------------------------------------------------------------------------
# # function to get samples by label
# get_dfgrp <- function(md, ugroupv = c("whole_blood", "PBMC", "other/NOS")){
#   do.call(rbind, lapply(c("whole_blood", "PBMC", "other/NOS"), function(ugroupi){
#     num.grp <- length(which(md[ugroupv,]$blood.subgroup==ugroupi))
#     data.frame(num.samples = num.grp, type = ugroupi)
#   }))
# }

## -----------------------------------------------------------------------------
# # get samples by label across queries
# dfp <- do.call(rbind, lapply(seq(nrow(dfnn)), function(ii){
#   get_dfgrp(md = md, unlist(strsplit(dfnn[ii,"k=20"], ";")))
# }))

## -----------------------------------------------------------------------------
# # format dfp variables for plots
# dfp$perc.samples <- 100*dfp$num.samples/20
# # reorder on medians
# medianv <- unlist(lapply(c("whole_blood", "PBMC", "other/NOS"), function(groupi){
#   median(dfp[dfp$type==groupi,]$perc.samples)}))
# # define legend groups
# dfp$`Sample\ntype` <- factor(dfp$type, levels = c("whole_blood", "PBMC", "other/NOS")[order(medianv)])

## -----------------------------------------------------------------------------
# # make new composite plot
# ggplot(dfp, aes(x = `Sample\ntype`, y = perc.samples, fill = `Sample\ntype`)) +
#   geom_violin() + geom_boxplot(width = 0.2) + theme_bw() +
#   ylab("Percent of neighbors") + theme(axis.title.x = element_blank()) +
#   scale_y_continuous(labels = scales::percent_format(scale = 1))

## ----eval = TRUE--------------------------------------------------------------
utils::sessionInfo()

