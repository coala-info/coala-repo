# Code example from 'HCAMatrixBrowser' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE)
#      install.packages("BiocManager")
#  
#  BiocManager::install("HCABrowser")
#  BiocManager::install("HCAMatrixBrowser")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(HCABrowser)
library(HCAMatrixBrowser)

## ----eval=FALSE---------------------------------------------------------------
#  hcabrowser <- HCABrowser::HCABrowser()
#  
#  res <- hcabrowser %>% filter(
#      library_construction_approach.ontology == "EFO:0008931" &
#      paired_end == True &
#      specimen_from_organism_json.biomaterial_core.ncbi_taxon_id == 9606
#  )
#  
#  (bundle_fqids <- res %>% pullBundles)

## -----------------------------------------------------------------------------
bundle_fqids <-
    c("ffd3bc7b-8f3b-4f97-aa2a-78f9bac93775.2019-05-14T122736.345000Z",
    "f69b288c-fabc-4ac8-b50c-7abcae3731bc.2019-05-14T120110.781000Z",
    "f8ba80a9-71b1-4c15-bcfc-c05a50660898.2019-05-14T122536.545000Z",
    "fd202a54-7085-406d-a92a-aad6dd2d3ef0.2019-05-14T121656.910000Z",
    "fffe55c1-18ed-401b-aa9a-6f64d0b93fec.2019-05-17T233932.932000Z")

## -----------------------------------------------------------------------------
hca <- HCAMatrix()

## -----------------------------------------------------------------------------
(lex <- loadHCAMatrix(hca, bundle_fqids = bundle_fqids,
    format = "loom"))

## -----------------------------------------------------------------------------
head(colnames(lex))

## -----------------------------------------------------------------------------
hca1 <- filter(hca, bundle_uuid == "ffd3bc7b-8f3b-4f97-aa2a-78f9bac93775")

## -----------------------------------------------------------------------------
filters(hca1)

## -----------------------------------------------------------------------------
loadHCAMatrix(hca1, format = "loom")

## -----------------------------------------------------------------------------
hca2 <- filter(hca, dss_bundle_fqid %in% bundle_fqids)

## -----------------------------------------------------------------------------
filters(hca2)

## -----------------------------------------------------------------------------
loadHCAMatrix(hca2)

