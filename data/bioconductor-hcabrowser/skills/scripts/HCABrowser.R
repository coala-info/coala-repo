# Code example from 'HCABrowser' vignette. See references/ for full tutorial.

## ----init, results='hide', echo=FALSE, warning=FALSE, message=FALSE------
library(knitr)
opts_chunk$set(warning=FALSE, message=FALSE)
BiocStyle::markdown()

## ----install_bioc, eval=FALSE--------------------------------------------
#  if (!require("BiocManager"))
#      install.packages("BiocManager")
#  BiocManager::install('HCABrowser')

## ----libraries, message=FALSE--------------------------------------------
library(HCABrowser)

## ----createHCA-----------------------------------------------------------
hca <- HCABrowser(url = 'https://dss.data.humancellatlas.org/v1', per_page = 10)
hca

## ----results-------------------------------------------------------------
results(hca)

## ----activate------------------------------------------------------------
## Bundles are diaplyed be default
nrow(results(hca))

## The HCABrowser object is activated here by 'files'
hca <- hca %>% activate('files')
hca
nrow(results(hca))

## Revert back to showing bundles with 'bundles'
hca <- hca %>% activate('bundles')

## ----per_page------------------------------------------------------------
#hca2 <- hca %>% per_page(n = 5)
#hca2

## ----nextResults---------------------------------------------------------
hca <- nextResults(hca)
hca

## ----fields--------------------------------------------------------------
hca <- HCABrowser()
hca %>% fields

## ----valuess-------------------------------------------------------------
hca %>% values(c('organ.text', 'library_construction_approach.text'))

## ----availabeOrgan-------------------------------------------------------
hca %>% values('organ.text')

## ----firstFilter---------------------------------------------------------
hca2 <- hca %>% filter(organ.text == c('Brain', 'brain'))
hca2 <- hca %>% filter(organ.text %in% c('Brain', 'brain'))
hca2 <- hca %>% filter(organ.text == Brain | organ.text == brain)
hca2

## ----multiFilter---------------------------------------------------------
hca2 <- hca %>% filter(organ.text %in% c('Brain', 'brain')) %>%
                filter('specimen_from_organism_json.biomaterial_core.ncbi_taxon_id' == 10090)
hca2 <- hca %>% filter(organ.text %in% c('Brain', 'brain'),
                       'specimen_from_organism_json.biomaterial_core.ncbi_taxon_id' == 10090)
hca <- hca %>% filter(organ.text %in% c('Brain', 'brain') &
                      'specimen_from_organism_json.biomaterial_core.ncbi_taxon_id' == 10090)
hca

## ----complexFilter-------------------------------------------------------
hca2 <- hca %>% filter((!organ.text %in% c('Brain', 'blood')) & 
                       (files.specimen_from_organism_json.genus_species.text == "Homo sapiens" |
                        library_preparation_protocol_json.library_construction_approach.text == 'Smart-seq2')
                )
hca2

## ----undoQuery-----------------------------------------------------------
hca <- hca %>% filter(organ.text == heart)
hca <- hca %>% filter(organ.text != brain)
hca <- hca %>% undoEsQuery(n = 2)
hca

## ----select--------------------------------------------------------------
hca2 <- hca %>% select('paired_end', 'organ.ontology')
#hca2 <- hca %>% select(paired_end, organ.ontology)
hca2 <- hca %>% select(c('paired_end', 'organ.ontology'))
hca2

## ----jsonQuery-----------------------------------------------------------


## ----downloadHCA---------------------------------------------------------
res <- hca %>% results(n = 36)
res

## ----pullBundles---------------------------------------------------------
bundle_fqids <- hca %>% pullBundles(n = 1)
bundle_fqids

## ----showBundles---------------------------------------------------------
hca <- hca %>% showBundles(bundle_fqids = bundle_fqids)
hca

## ----sessionInfo---------------------------------------------------------
sessionInfo()

