# Code example from 'index' vignette. See references/ for full tutorial.

## ---- eval = FALSE-------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("TCGAbiolinksGUI", dependencies = TRUE)

## ---- eval = FALSE-------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  deps <- c("devtools")
#  BiocManager::install("devtools", dependencies = TRUE)
#  devtools::install_github("BioinformaticsFMRP/TCGAbiolinksGUI.data",ref = "R_3.4")
#  devtools::install_github("BioinformaticsFMRP/TCGAbiolinksGUI")

## ---- eval = FALSE-------------------------------------------------------
#  library(TCGAbiolinksGUI)
#  TCGAbiolinksGUI()

## ----table2, echo=FALSE, message=FALSE, warnings=FALSE, results='asis'----
tabl <- "  
| Menu                    | Sub-menu                          | Button             | Data input  | Example Input |
|---------------------------------|-----------------------------------|------------------------------------|-------------------------------------------------------------------------------------------|----------------------------|
| Clinical analysis       | Survival Plot                     | Select file        | A table with at least the following columns: days_to_death, days_to_last_followup and one column with a group | [Example input](https://drive.google.com/open?id=1pWYEZsojafQMav8v3MrRVTIkFKyCSGfY) |
| Epigenetic analysis     | Differential methylation analysis | Select data (.rda) | A summarizedExperiment object | [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.met.rda) |
| Epigenetic analysis     | Volcano Plot                      | Select results     | A CSV file with the following pattern: DMR_results_GroupCol_group1_group2_pcut_0.01_meancut_0.5.csv  (Where GroupCol, group1, group2 are the names of the columns selected in the  DMR steps. | [Example input](https://drive.google.com/open?id=1lUS2hEJHP4PC6vfeO-ckLbLe-6xx0ddQ)  in which diffmean.group1.group2= mean group 2 - mean group 1 |
| Epigenetic analysis     | Heatmap plot                      | Select file        | A summarizedExperiment object  |  [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.met.rda) |
| Epigenetic analysis     | Heatmap plot                      | Select results     | Same as Epigenetic analysis >Volcano Plot > Select results ||
| Epigenetic analysis     | Mean DNA methylation              | Select file        | A summarizedExperiment object |  [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.met.rda) |
| Transcriptomic Analysis | Volcano Plot                      | Select results     | A CSV file with the following pattern: DEA_results_GroupCol_group1_group2_pcut_0.01_logFC.cut_2.csv (Where GroupCol, group1, group2 are the names of the columns selected in the DEA steps. |  [Example input](https://drive.google.com/open?id=1lUS2hEJHP4PC6vfeO-ckLbLe-6xx0ddQ) ) in which logFC= loag( group 2/ group1)|
| Transcriptomic Analysis | Heatmap plot                      | Select file        | A summarizedExperiment object  | [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.met.rda)|
| Transcriptomic Analysis | Heatmap plot                      | Select results        | A CSV file with results of the DMR or DEA  |  [Example input](https://drive.google.com/open?id=1lUS2hEJHP4PC6vfeO-ckLbLe-6xx0ddQ)  in which diffmean.group1.group2= mean group 2 - mean group 1 |
| Transcriptomic Analysis | OncoPrint plot                      | Select MAF file        | A MAF file (columns needed: Hugo_Symbol,Tumor_Sample_Barcode,Variant_Type) |  Deafult GDC MAF files ||
| Transcriptomic Analysis | OncoPrint plot                      | Select Annotation file        | A file with at least the following columns: bcr_patient_barcode  | [Example input](https://drive.google.com/open?id=1pWYEZsojafQMav8v3MrRVTIkFKyCSGfY|
|  Integrative analysis   | Starburst plot                      | DMR result        | A CSV file with the following pattern: DMR_results_GroupCol_group1_group2_pcut_0.01_meancut_0.55.csv (Where GroupCol, group1, group2 are the names of the columns selected in the DMR steps. | [Example input](https://drive.google.com/open?id=1lUS2hEJHP4PC6vfeO-ckLbLe-6xx0ddQ)  in which diffmean.group1.group2= mean group 2 - mean group 1 |
|  Integrative analysis   | Starburst plot                      | DEA result        | A CSV file with the following pattern: DEA_results_GroupCol_group1_group2_pcut_0.01_FC.cut_2.csv (Where GroupCol, group1, group2 are the names of the columns selected in the DEA steps.|  [Example input](https://drive.google.com/open?id=1lUS2hEJHP4PC6vfeO-ckLbLe-6xx0ddQ) ) in which logFC= loag( group 2/ group1)|
|  Integrative analysis   | ELMER                      | Create MAE  > Select DNA methylation object         | An rda file with a summarized Experiment object |  [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.met.rda) | 
|  Integrative analysis   | ELMER                      | Create MAE  > Select expression object         |  An rda file with the RNAseq data frame |   [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.exp.rda) |
|  Integrative analysis   | ELMER                      | Select MAE         | An rda file with a MAE object |  [Example input](https://drive.google.com/open?id=17ovzQ-czPfsAjZ1JJLjLPvdm1aN2_C8r)|   
|  Integrative analysis   | ELMER                      | Select results         | An rda file with the results of the ELMER analysis | [Example input](https://drive.google.com/open?id=1OP8BKoFfkH5knTVjvAHq2lLjfmpub9ei)|   
"
cat(tabl) 

