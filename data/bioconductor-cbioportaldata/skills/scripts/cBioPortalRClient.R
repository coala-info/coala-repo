# Code example from 'cBioPortalRClient' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(cache = TRUE)

## ----installation, include=TRUE,results="hide",message=FALSE,warning=FALSE----
library(cBioPortalData)
library(AnVIL)

## ----cbioportal_client--------------------------------------------------------
(cbio <- cBioPortal())

## ----tags---------------------------------------------------------------------
tags(cbio)
head(tags(cbio)$operation)

## ----search_ops---------------------------------------------------------------
searchOps(cbio, "clinical")

## ----get_studies--------------------------------------------------------------
getStudies(cbio)

## ----clinical_data------------------------------------------------------------
clinicalData(cbio, "acc_tcga")

## ----molecular_profiles-------------------------------------------------------
mols <- molecularProfiles(cbio, "acc_tcga")
mols[["molecularProfileId"]]

## ----molecular_data-----------------------------------------------------------
molecularData(cbio, molecularProfileIds = "acc_tcga_rna_seq_v2_mrna",
    entrezGeneIds = c(1, 2),
    sampleIds = c("TCGA-OR-A5J1-01",  "TCGA-OR-A5J2-01")
)

## ----gene_table---------------------------------------------------------------
geneTable(cbio)

## ----gene_panels--------------------------------------------------------------
genePanels(cbio)
getGenePanel(cbio, "IMPACT341")

## ----gene_panel_molecular-----------------------------------------------------
gprppa <- genePanelMolecular(cbio,
    molecularProfileId = "acc_tcga_rppa",
    sampleListId = "acc_tcga_all")
gprppa

## ----get_gene_panel_molecular-------------------------------------------------
getGenePanelMolecular(cbio,
    molecularProfileIds = c("acc_tcga_rppa", "acc_tcga_gistic"),
    sampleIds = allSamples(cbio, "acc_tcga")$sampleId
)

## ----get_data_by_genes--------------------------------------------------------
getDataByGenes(cbio, "acc_tcga", genePanelId = "IMPACT341",
    molecularProfileIds = "acc_tcga_rppa", sampleListId = "acc_tcga_rppa")

## ----sample_lists-------------------------------------------------------------
sampleLists(cbio, "acc_tcga")

## ----samples_in_sample_list---------------------------------------------------
samplesInSampleLists(cbio, "acc_tcga_cna")

## ----samples_cna--------------------------------------------------------------
samplesInSampleLists(cbio, c("acc_tcga_cna", "acc_tcga_cnaseq"))

## ----all_samples--------------------------------------------------------------
allSamples(cbio, "acc_tcga")

## ----sample_info--------------------------------------------------------------
getSampleInfo(cbio, studyId = "acc_tcga",
    sampleListIds = c("acc_tcga_rppa", "acc_tcga_cna"))

## ----cbio_getGeneUsingGET-----------------------------------------------------
cbio$getGeneUsingGET

## ----cbio_getGeneUsingGET_example---------------------------------------------
(resp <- cbio$getGeneUsingGET("BRCA1"))

## ----translate_response-------------------------------------------------------
httr::content(resp)

## ----clear_cache, eval=FALSE--------------------------------------------------
# unlink("~/.cache/cBioPortalData/")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

