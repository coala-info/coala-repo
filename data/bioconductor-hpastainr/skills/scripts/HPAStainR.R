# Code example from 'HPAStainR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval = FALSE------------------------------------------------------------
#  if(!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("HPAStainR")

## ---- download_data-----------------------------------------------------------
library(HPAStainR)

HPA_data <- HPA_data_downloader(tissue_type = "both", save_file = FALSE)

## ---- echo=FALSE, results='asis', normal_data---------------------------------
knitr::kable(head(HPA_data$hpa_dat, 10))

## ---- echo=FALSE, results='asis', cancer_data---------------------------------
knitr::kable(head(HPA_data$cancer_dat[,seq_len(7)], 10))

## ---- function_example--------------------------------------------------------
gene_list = c("PRSS1", "PNLIP","CELA3A", "PRL")

stainR_out <- HPAStainR::HPAStainR(gene_list = gene_list,
          hpa_dat = HPA_data$hpa_dat,
          cancer_dat = HPA_data$cancer_dat,
          cancer_analysis = "both",
          stringency = "normal")


head(stainR_out, 10)


## ---- summarydata-------------------------------------------------------------
hpa_summary <- HPA_summary_maker(hpa_dat = HPA_data$hpa_dat)

## ----eval=FALSE, shinyapp-----------------------------------------------------
#  shiny_HPAStainR(hpa_dat = HPA_data$hpa_dat,
#                  cancer_dat = HPA_data$cancer_dat,
#                  cell_type_data = hpa_summary)
#  
#  

## ---- session_info------------------------------------------------------------
sessionInfo()

