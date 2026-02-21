# Code example from 'cgdsrMigration' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(cache = TRUE)

## ----load_libs, include=TRUE,results="hide",message=FALSE,warning=FALSE-------
library(cBioPortalData)

## ----cbioportal_setup, comment=FALSE, warning=FALSE, message=FALSE------------
cbio <- cBioPortal(
    hostname = "www.cbioportal.org",
    protocol = "https",
    api. = "/api/v2/api-docs"
)
getStudies(cbio)

## ----studyId_head-------------------------------------------------------------
head(getStudies(cbio)[["studyId"]])

## ----cgdsr_setup, eval=FALSE--------------------------------------------------
# library(cgdsr)
# cgds <- CGDS("http://www.cbioportal.org/")
# getCancerStudies.CGDS(cgds)

## ----sample_lists-------------------------------------------------------------
samps <- sampleLists(cbio, "gbm_tcga_pub")
samps[, c("category", "name", "sampleListId")]

## ----samples_in_sample_lists--------------------------------------------------
samplesInSampleLists(
    api = cbio,
    sampleListIds = c(
        "gbm_tcga_pub_expr_classical", "gbm_tcga_pub_expr_mesenchymal"
    )
)

## ----get_sample_info----------------------------------------------------------
getSampleInfo(api = cbio,  studyId = "gbm_tcga_pub", projection = "SUMMARY")

## ----get_case_lists, eval=FALSE-----------------------------------------------
# clist1 <-
#     getCaseLists.CGDS(cgds, cancerStudy = "gbm_tcga_pub")[1, "case_list_id"]
# 
# getClinicalData.CGDS(cgds, clist1)

## ----clinical_data------------------------------------------------------------
clinicalData(cbio, "gbm_tcga_pub")

## ----get_sample_id------------------------------------------------------------
clist1 <- "gbm_tcga_pub_all"
samplist <- samplesInSampleLists(cbio, clist1)
onesample <- samplist[["gbm_tcga_pub_all"]][1]
onesample

## ----clin_data_sample---------------------------------------------------------
cbio$getAllClinicalDataOfSampleInStudyUsingGET(
    sampleId = onesample, studyId = "gbm_tcga_pub"
)

## ----clinical_cgds, eval = FALSE----------------------------------------------
# getClinicalData.CGDS(x = cgds,
#     caseList = "gbm_tcga_pub_expr_classical"
# )

## ----search_clinical----------------------------------------------------------
searchOps(cbio, "clinical")

## ----molecular_profiles-------------------------------------------------------
molecularProfiles(api = cbio, studyId = "gbm_tcga_pub")

## ----gen_prof_cgds, eval=FALSE------------------------------------------------
# getGeneticProfiles.CGDS(cgds, cancerStudy = "gbm_tcga_pub")

## ----genetab------------------------------------------------------------------
genetab <- queryGeneTable(cbio,
    by = "hugoGeneSymbol",
    genes = c("NF1", "TP53", "ABL1")
)
genetab
entrez <- genetab[["entrezGeneId"]]

## -----------------------------------------------------------------------------
allsamps <- samplesInSampleLists(cbio, "gbm_tcga_pub_all")

## ----prof_data_cgds, eval=FALSE-----------------------------------------------
# getProfileData.CGDS(x = cgds,
#     genes = c("NF1", "TP53", "ABL1"),
#     geneticProfiles = "gbm_tcga_pub_mrna",
#     caseList = "gbm_tcga_pub_all"
# )

## ----mol_data-----------------------------------------------------------------
molecularData(cbio, "gbm_tcga_pub_mrna",
    entrezGeneIds = entrez, sampleIds = unlist(allsamps))

## ----get_data_by_genes--------------------------------------------------------
getDataByGenes(
    api =  cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_mrna"
)

## ----main_cbioportaldata------------------------------------------------------
gbm_pub <- cBioPortalData(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"), by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_mrna"
)

assay(gbm_pub[["gbm_tcga_pub_mrna"]])[, 1:4]

## ----mutation_data------------------------------------------------------------
mutationData(
    api = cbio,
    molecularProfileIds = "gbm_tcga_pub_mutations",
    entrezGeneIds = entrez,
    sampleIds = unlist(allsamps)
)

## ----get_data_by_genes_mutation-----------------------------------------------
getDataByGenes(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_mutations"
)

## ----mutation_cgds, eval=FALSE------------------------------------------------
# getMutationData.CGDS(
#     x = cgds,
#     caseList = "getMutationData",
#     geneticProfile = "gbm_tcga_pub_mutations",
#     genes = c("NF1", "TP53", "ABL1")
# )

## ----cna_data-----------------------------------------------------------------
getDataByGenes(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_cna_rae"
)

## ----cna_cbioportaldata-------------------------------------------------------
cBioPortalData(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_cna_rae"
)

## ----cna_cgds, eval=FALSE-----------------------------------------------------
# getProfileData.CGDS(
#     x = cgds,
#     genes = c("NF1", "TP53", "ABL1"),
#     geneticProfiles = "gbm_tcga_pub_cna_rae",
#     caseList = "gbm_tcga_pub_cna"
# )

## ----get_data_by_genes_methylation--------------------------------------------
getDataByGenes(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_methylation_hm27"
)

## ----cbioportaldata_methylation-----------------------------------------------
cBioPortalData(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_methylation_hm27"
)

## ----methylation_cgds, eval=FALSE---------------------------------------------
# getProfileData.CGDS(
#     x = cgds,
#     genes = c("NF1", "TP53", "ABL1"),
#     geneticProfiles = "gbm_tcga_pub_methylation_hm27",
#     caseList = "gbm_tcga_pub_methylation_hm27"
# )

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

