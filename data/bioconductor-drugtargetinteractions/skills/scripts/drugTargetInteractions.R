# Code example from 'drugTargetInteractions' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'--------------------------------------------------------
BiocStyle::markdown()
options(width=100, max.print=1000)
knitr::opts_chunk$set(
    eval=as.logical(Sys.getenv("KNITR_EVAL", "TRUE")),
    cache=as.logical(Sys.getenv("KNITR_CACHE", "TRUE")))

## ----pkg_install_bioc, eval=FALSE-----------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("drugTargetInteractions")

## ----pkg_install_github, eval=FALSE---------------------------------------------------------------
# devtools::install_github("girke-lab/drugTargetInteractions", build_vignettes=TRUE) # Installs from github

## ----package load, eval=TRUE, warning=FALSE-------------------------------------------------------
library("drugTargetInteractions") # Loads the package

## ----documentation, eval=FALSE, warning=FALSE-----------------------------------------------------
# library(help="drugTargetInteractions") # Lists package info
# vignette(topic="drugTargetInteractions", package="drugTargetInteractions") # Opens vignette

## ----dir_env, eval=TRUE---------------------------------------------------------------------------
chembldb <- system.file("extdata", "chembl_sample.db", package="drugTargetInteractions")
resultsPath <- system.file("extdata", "results", package="drugTargetInteractions")
config <- genConfig(chemblDbPath=chembldb, resultsPath=resultsPath)

## ----data_setup, eval=TRUE------------------------------------------------------------------------
downloadUniChem(config=config)
cmpIdMapping(config=config)

## ----getUniprotIDs1, eval=FALSE, message=FALSE, warning=FALSE-------------------------------------
# keys <- c("ENSG00000145700", "ENSG00000135441", "ENSG00000120071")
# res_list90 <- getUniprotIDs(taxId=9606, kt="ENSEMBL", keys=keys, seq_cluster="UNIREF90")

## ----load_res_list90, echo = FALSE, results = 'asis'----------------------------------------------
res_list90 <- readRDS(system.file("extdata", "res_list90.rds", package="drugTargetInteractions"))

## ----getUniprotIDs2, eval=TRUE, message=FALSE-----------------------------------------------------
library(DT)
datatable(res_list90[[1]], options = list(scrollX=TRUE, scrollY="600px", autoWidth = TRUE))

## ----getUniprotIDs3, eval=TRUE--------------------------------------------------------------------
sapply(res_list90, dim, simplify=FALSE)
sapply(names(res_list90), function(x) unique(na.omit(res_list90[[x]]$ID)))

## ----getParalogs1, eval=FALSE---------------------------------------------------------------------
# queryBy <- list(molType="gene", idType="external_gene_name", ids=c("ANKRD31", "BLOC1S1", "KANSL1"))
# queryBy <- list(molType="gene", idType="ensembl_gene_id", ids=c("ENSG00000145700", "ENSG00000135441", "ENSG00000120071"))
# res_list <- getParalogs(queryBy)

## ----getParalogs1_load, eval=TRUE,echo=FALSE------------------------------------------------------
res_list <- readRDS(system.file("extdata", "paralogs1_res_list.rds", package="drugTargetInteractions"))

## ----getParalogs2, eval=TRUE, message=FALSE-------------------------------------------------------
library(DT)
datatable(res_list[[1]], options = list(scrollX = TRUE, scrollY="400px", autoWidth = TRUE))

## ----getParalogs3, eval=TRUE----------------------------------------------------------------------
sapply(res_list, dim, simplify=FALSE)
sapply(names(res_list), function(x) unique(na.omit(res_list[[x]]$ID_up_sp)))

## ----drugTargetQuery1cmp, eval=TRUE---------------------------------------------------------------
queryBy <- list(molType="cmp", idType="chembl_id", ids=c("CHEMBL17", "CHEMBL19", "CHEMBL1201117", "CHEMBL25", "nomatch", "CHEMBL1742471"))
qresult1 <- drugTargetAnnot(queryBy, config=config)

## ----cmp_query_result1, eval=TRUE, message=FALSE--------------------------------------------------
library(DT)
datatable(qresult1, options = list(scrollX = TRUE, scrollY="600px", autoWidth = TRUE))

## ----drugTargetQuery1protein, eval=TRUE-----------------------------------------------------------
queryBy <- list(molType="protein", idType="UniProt_ID", ids=c("P43166", "P00915"))
qresult2 <- drugTargetAnnot(queryBy, config=config)

## ----protein_query_result1, eval=TRUE, message=FALSE----------------------------------------------
library(DT)
datatable(qresult2, options = list(scrollX = TRUE, scrollY="600px", autoWidth = TRUE))

## ----getUniprotIDs, eval=FALSE, message=FALSE-----------------------------------------------------
# keys <- c("ENSG00000120088", "ENSG00000135441", "ENSG00000120071")
# res_list90 <- getUniprotIDs(taxId=9606, kt="ENSEMBL", keys=keys, seq_cluster="UNIREF90")

## ----getUniprotIDs4, eval=TRUE, message=FALSE-----------------------------------------------------
id_list <- sapply(names(res_list90), function(x) unique(na.omit(res_list90[[x]]$ID)))

## ----drugTargetQuery2protein, eval=TRUE-----------------------------------------------------------
queryBy <- list(molType="protein", idType="UniProt_ID", ids=id_list[[2]])
qresultSSNN <- drugTargetAnnot( queryBy, config=config)
ensidsSSNN <- tapply(res_list90[[2]]$ENSEMBL, res_list90[[2]]$ID, paste, collapse=", ") 
qresultSSNN <- data.frame(Ensembl_IDs=ensidsSSNN[as.character(qresultSSNN$QueryIDs)], qresultSSNN)

## ----protein_query_result2, eval=TRUE, message=FALSE----------------------------------------------
library(DT)
datatable(qresultSSNN, options = list(scrollX = TRUE, scrollY="600px", autoWidth = TRUE))

## ----cmp_query2, eval=TRUE------------------------------------------------------------------------
id_mapping <- c(chembl="chembl_id", pubchem="PubChem_ID", uniprot="UniProt_ID", drugbank="DrugBank_ID")
queryBy <- list(molType="cmp", idType="pubchem", ids=c("2244", "65869", "2244"))
queryBy <- list(molType="protein", idType="uniprot", ids=c("P43166", "P00915", "P43166"))
queryBy <- list(molType="cmp", idType="drugbank", ids=c("DB00945", "DB01202"))
#qresult3 <- getDrugTarget(queryBy=queryBy, id_mapping=id_mapping, columns=c(1,5,8,16,17,39,46:53),config=config)
qresult3 <- getDrugTarget(queryBy=queryBy, id_mapping=id_mapping, columns=c(1,5,8,16,17),config=config)

## ----cmp_query_result2, eval=TRUE, message=FALSE--------------------------------------------------
library(DT)
datatable(qresult3, options = list(scrollX = TRUE, scrollY="600px", autoWidth = TRUE))

## ----protein_query2, eval=TRUE--------------------------------------------------------------------
queryBy <- list(molType="protein", idType="chembl", ids=c("CHEMBL25", "nomatch", "CHEMBL1742471"))
#qresult4 <- getDrugTarget(queryBy=queryBy, id_mapping, columns=c(1,5,8,16,17,39,46:52),config=config) 
qresult4 <- getDrugTarget(queryBy=queryBy, id_mapping=id_mapping, columns=c(1,5,8,16,17),config=config) 

## ----protein_query_result3, eval=TRUE, message=FALSE----------------------------------------------
library(DT)
datatable(qresult4, options = list(scrollX = TRUE, scrollY="600px", autoWidth = TRUE))

## ----bioassayQuery1cmp, eval=TRUE, warning=FALSE--------------------------------------------------
queryBy <- list(molType="cmp", idType="DrugBank_ID", ids=c("DB00945", "DB00316", "DB01050"))
qresultBAcmp <- drugTargetBioactivity(queryBy, config=config)

## ----cmpBA_query_result, eval=TRUE, message=FALSE-------------------------------------------------
library(DT)
datatable(qresultBAcmp, options = list(scrollX = TRUE, scrollY="600px", autoWidth = TRUE))

## ----bioassayQuery1protein, eval=TRUE, warning=FALSE----------------------------------------------
queryBy <- list(molType="protein", idType="uniprot", ids=id_list[[1]])                                                                                                             
qresultBApep <- drugTargetBioactivity(queryBy, config=config)                                                                                       
qresultBApep <- data.frame(Ensembl_IDs=ensidsSSNN[as.character(qresultBApep$UniProt_ID)], qresultBApep)

## ----pepBA_query_result, eval=TRUE, message=FALSE-------------------------------------------------
library(DT)
datatable(qresultBApep, options = list(scrollX = TRUE, scrollY="600px", autoWidth = TRUE))

## ----gene_name, eval=TRUE, message=FALSE----------------------------------------------------------
gene_name <- c("CA7", "CFTR")
idMap <- getSymEnsUp(EnsDb="EnsDb.Hsapiens.v86", ids=gene_name, idtype="GENE_NAME")
ens_gene_id <- idMap$ens_gene_id
ens_gene_id

## ----ens_gene_id, eval=TRUE, message=FALSE--------------------------------------------------------
ensembl_gene_id <- c("ENSG00000001626", "ENSG00000168748")
idMap <- getSymEnsUp(EnsDb="EnsDb.Hsapiens.v86", ids=ensembl_gene_id, idtype="ENSEMBL_GENE_ID")
ens_gene_id <- idMap$ens_gene_id

## ----ens_uniprot_id, eval=TRUE, message=FALSE-----------------------------------------------------
uniprot_id <- c("P43166", "P13569") 
idMap <- getSymEnsUp(EnsDb="EnsDb.Hsapiens.v86", ids=uniprot_id, idtype="UNIPROT_ID")
ens_gene_id <- idMap$ens_gene_id

## ----res_list_ens_gene_id_uniref, eval=FALSE, message=FALSE---------------------------------------
# res_list90 <- getUniprotIDs(taxId=9606, kt="ENSEMBL", keys=names(ens_gene_id), seq_cluster="UNIREF90", chunksize=1)
# sapply(res_list90, dim)

## ----res_list_ens_gene_id_paralog, eval=FALSE, message=FALSE--------------------------------------
# queryBy <- list(molType="gene", idType="ensembl_gene_id", ids=names(ens_gene_id))
# res_list <- getParalogs(queryBy)

## ----res_list_ens_gene_id_paralog_load , eval=TRUE,echo=FALSE-------------------------------------
res_list <- readRDS(system.file("extdata", "paralogs2_res_list.rds", package="drugTargetInteractions"))

## ----res_list_ens_gene_id_paralog_part2, eval=TRUE------------------------------------------------
sapply(res_list, dim)

## ----runDrugTarget_Annot_Bioassay, eval=TRUE, message=FALSE---------------------------------------
drug_target_list <- runDrugTarget_Annot_Bioassay(res_list=res_list, up_col_id="ID_up_sp", ens_gene_id, config=config) 
sapply(drug_target_list, dim)

## ----runDrugTarget_Annot_Bioassay_result1, eval=TRUE, message=FALSE-------------------------------
datatable(drug_target_list$Annotation, options = list(scrollX = TRUE, scrollY="600px", autoWidth = TRUE))

## ----runDrugTarget_Annot_Bioassay_result2, eval=TRUE, message=FALSE-------------------------------
datatable(drug_target_list$Bioassay[1:500,], options = list(scrollX = TRUE, scrollY="600px", autoWidth = TRUE))

## ----DrugTargetSummary, eval=TRUE, message=FALSE--------------------------------------------------
df <- drug_target_list$Annotation
df[,"GeneName"] <- gsub("Query_", "", as.character(df$GeneName))
stats <- tapply(df$CHEMBL_CMP_ID, as.factor(df$GeneName), function(x) unique(x))
stats <- sapply(names(stats), function(x) stats[[x]][nchar(stats[[x]]) > 0])
stats <- sapply(names(stats), function(x) stats[[x]][!is.na(stats[[x]])])
statsDF <- data.frame(GeneNames=names(stats), Drugs=sapply(stats, paste, collapse=", "), N_Drugs=sapply(stats, length))

## ----DrugTargetSummary2, eval=TRUE, message=FALSE-------------------------------------------------
datatable(statsDF, options = list(scrollX = TRUE, scrollY="150px", autoWidth = TRUE))

## ----export_annotation_bioassay, eval=FALSE, message=FALSE----------------------------------------
# write.table(drug_target_list$Annotation, "DrugTargetAnnotation.xls", row.names=FALSE, quote=FALSE, na="", sep="\t")
# write.table(drug_target_list$Bioassay, "DrugTargetBioassay.xls", row.names=FALSE, quote=FALSE, na="", sep="\t")
# write.table(statDF, "statDF.xls", row.names=FALSE, quote=FALSE, na="", sep="\t")

## ----sessionInfo----------------------------------------------------------------------------------
sessionInfo()

