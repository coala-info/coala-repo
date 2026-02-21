# Code example from 'ImpulseDE' vignette. See references/ for full tutorial.

## ----chunk1--------------------------------------------------------------
# (Install package longitudinal) and load it
library(longitudinal)
# attach T cell data
data(tcell)
# check dimension of data matrix of interest
dim(tcell.10)

## ----chunk2--------------------------------------------------------------
# generate annotation table with columns "Time" and "Condition"
annot <- as.data.frame(cbind("Time" =
   sort(rep(get.time.repeats(tcell.10)$time,10)),
   "Condition" = "activated"), stringsAsFactors = FALSE)
# Time columns must be numeric
annot$Time <- as.numeric(annot$Time)
# rownames of annotation table must appear in data table
rownames(annot) = rownames(tcell.10)
head(annot)

## ----chunk3, fig.height = 3, fig.width = 6-------------------------------
# load package
library(ImpulseDE)
# start analysis
impulse_results <- impulse_DE(t(tcell.10)[1:20,], annot, "Time", "Condition",
   n_iter = 10, n_randoms = 10, n_process = 1, new_device = FALSE) 

## ----chunk4, fig.show = 'hold', fig.height = 7---------------------------
genes = c("SIVA","CD69","ZNFN1A1","JUND","ITGAM","SMN1","PCNA")
plot_impulse(gene_IDs = genes, data_table = t(tcell.10), data_annotation = annot,
    imp_fit_genes = impulse_results$impulse_fit_results,
    file_name_part = "four_NV_genes", new_device = FALSE)

## ----chunk5--------------------------------------------------------------
# impute expression value for time point 60 for gene "JUND"
(imp_results <- 
     calc_impulse(impulse_results$impulse_fit_results$impulse_parameters_case[
         "JUND",1:6], 60))

## ----chunk6--------------------------------------------------------------
# split dataset into two halfs
case_data <-  t(tcell.10)[,seq(1,ncol(t(tcell.10)),2)]
control_data <-  t(tcell.10)[,seq(2,ncol(t(tcell.10)),2)]
# add some random values to "control_data" to make data different
control_data <- control_data + t(apply(control_data,1,function(x) 
    runif(length(x),0,0.5)*sample(c(-1,1),length(x), replace = TRUE)
    + sample(c(seq(-2,2,0.5)),1)))
tcell_2tk <- cbind(case_data, control_data)


## ----chunk7--------------------------------------------------------------
annot_2tk <- annot[colnames(tcell_2tk),]
annot_2tk[51:100,"Condition"] = "control"
head(annot_2tk)
tail(annot_2tk)


## ----chunk8, fig.height = 3, fig.width = 6-------------------------------
# load package
library(ImpulseDE)
# start analysis
impulse_results <- impulse_DE(tcell_2tk[1:20,], annot_2tk, "Time", "Condition",
    TRUE, "control", n_iter = 10, n_randoms = 10, n_process = 1, new_device = FALSE)

## ----chunk9, fig.show='hold', fig.height = 7-----------------------------
genes = c("SIVA","ZNFN1A1","IL4R","MAP2K4","ITGAM","SMN1","CASP8","E2F4","PCNA")
plot_impulse(gene_IDs = genes, data_table = tcell_2tk, data_annotation = 
    annot_2tk, imp_fit_genes = impulse_results$impulse_fit_results, 
    control_timecourse = TRUE,
    control_name = "control", file_name_part = "four_NV_genes_2tk", new_device = FALSE)

## ----chunk10-------------------------------------------------------------
# impute expression value for time point 60 for gene "JUND"
# case data
(imp_results <- 
     calc_impulse(impulse_results$impulse_fit_results$impulse_parameters_case[
         "JUND",1:6], 60))
# control data
(imp_results <- 
    calc_impulse(impulse_results$impulse_fit_results$impulse_parameters_control[
    "JUND",1:6], 60))

