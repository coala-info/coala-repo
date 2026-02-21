# Code example from 'HCAExplorer' vignette. See references/ for full tutorial.

## ----init, results='hide', echo=FALSE, warning=FALSE, message=FALSE------
library(knitr)
opts_chunk$set(warning=FALSE, message=FALSE)
BiocStyle::markdown()

## ----install_bioc, eval=FALSE--------------------------------------------
#  if (!require("BiocManager"))
#      install.packages("BiocManager")
#  BiocManager::install('HCAExplorer')

## ----libraries, message=FALSE--------------------------------------------
library(HCAExplorer)

## ----createHCA-----------------------------------------------------------
hca <- HCAExplorer(url = 'https://service.explore.data.humancellatlas.org', per_page = 15)
hca

## ----results-------------------------------------------------------------
results(hca)

## ----select--------------------------------------------------------------
hca <- hca %>% select('projects.projectTitle', 'samples.organ')
hca

## ----resetSelect---------------------------------------------------------
hca <- resetSelect(hca)
hca

## ----activate------------------------------------------------------------
## The HCAExplorer object is activated here by 'samples'
hca <- hca %>% activate('samples')
hca

## Revert back to showing projects with 'projects'
hca <- hca %>% activate('projects')
hca

## ----nextResults---------------------------------------------------------
hca <- nextResults(hca)
hca

## ----fields--------------------------------------------------------------
hca <- HCAExplorer()
fields(hca)

## ----valuess-------------------------------------------------------------
values(hca, 'organ')

## ----firstFilter---------------------------------------------------------
hca2 <- hca %>% filter(organ == c('blood', 'brain'))
hca <- hca %>% filter(organ %in% c('blood', 'brain'))
hca

## ----second_values-------------------------------------------------------
values(hca, 'disease')

## ----multiFilter---------------------------------------------------------
hca <- hca %>% filter(disease == 'normal')
hca <- undoQuery(hca, n = 2L)

hca <- hca %>% filter(organ %in% c('Brain', 'brain'), disease == 'normal')
hca <- resetQuery(hca)

hca <- hca %>% filter(organ %in% c('Brain', 'brain') & disease == 'normal')
hca

## ----subsetting----------------------------------------------------------
hca <- hca[1:2,]
hca

## ----getManifestFileFormats----------------------------------------------
formats <- getManifestFileFormats(hca)
formats

## ----getManifest---------------------------------------------------------
manifest <- getManifest(hca, fileFormat = formats[1])
manifest

## ----sessionInfo---------------------------------------------------------
sessionInfo()

