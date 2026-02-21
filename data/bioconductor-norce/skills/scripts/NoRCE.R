# Code example from 'NoRCE' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results="asis", message=FALSE, warnings = FALSE-------
knitr::opts_chunk$set(tidy = FALSE,
                      warning = FALSE,
                      message = FALSE,fig.width=6, fig.height=6 )

## ----Install, eval=FALSE, echo=TRUE, include=TRUE-----------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("NoRCE")

## ----load, eval=FALSE, echo=TRUE, include=TRUE--------------------------------
# library(NoRCE)

## ----change parameters, eval=FALSE, echo=TRUE, include=TRUE-------------------
# type <- c('downstream','upstream')
# 
# value <- c(2000,30000)
# setParameters(type,value)
# 
# #To change the single parameter
# setParameters("pathwayType","reactome")

## ----gene, eval=FALSE---------------------------------------------------------
# #Set the neighbourhood region as exon
# ncGO<-geneGOEnricher(gene = brain_disorder_ncRNA, org_assembly='hg19', near=TRUE, genetype = 'Ensembl_gene')
# 

## ----lysis, eval=FALSE--------------------------------------------------------
# #Set the neighbourhood region as exon
# setParameters("searchRegion", "exon")
# 
# #NoRCE automatically consider only the exon of the genes
# ncGO<-geneGOEnricher(gene = brain_disorder_ncRNA, org_assembly='hg19', near=TRUE, genetype = 'Ensembl_gene')
# 

## ----region_go, eval=FALSE----------------------------------------------------
# #Change back to all search regions
# setParameters("searchRegion", "all")
# 
# #Import the gene set regions
# regions<-system.file("extdata", "ncRegion.txt", package = "NoRCE")
# regionNC <- rtracklayer::import(regions, format = "BED")
# 
# #Perform the analysis on the gene regions
# regionGO<-geneRegionGOEnricher(region = regionNC, org_assembly= 'hg19', near = TRUE)
# 

## ----Intersection of the nearest genes of the input gene set and the potential target set is carries out for enrichment analysis, eval=FALSE----
# mirGO<-mirnaGOEnricher(gene = brain_mirna, org_assembly='hg19', near=TRUE, target=TRUE)
# 

## ----Enrichment based on TAD cellline, eval=FALSE-----------------------------
# mirGO<-mirnaGOEnricher(gene = brain_mirna, org_assembly='hg19', near=TRUE, isTADSearch = TRUE, TAD = tad_hg19)
# 

## ----eval=FALSE---------------------------------------------------------------
# # Read the custom TAD boundaries
# cus_TAD<-system.file("extdata", "DER-18_TAD_adultbrain.txt", package = "NoRCE")
# tad_custom <- rtracklayer::import(cus_TAD, format = 'bed')
# 
# # Use custom TAD boundaries for enrichment
# ncGO_tad <- geneGOEnricher(gene = brain_disorder_ncRNA, org_assembly = 'hg19', genetype = 'Ensembl_gene', isTADSearch = TRUE, TAD = tad_custom)
# 

## ----Retrieve list of cell-line , eval=FALSE----------------------------------
# a<-listTAD(TADName = tad_hg19)

## ----corr tcga, eval=FALSE----------------------------------------------------
# ncGO_tad <- geneGOEnricher(gene = brain_disorder_ncRNA, org_assembly = 'hg19', genetype = 'Ensembl_gene',near = TRUE, express = TRUE, databaseFile = '\\miRCancer\\miRCancer.db', cancer = 'GBMLGG')
# 

## ----corr analiz, eval=FALSE--------------------------------------------------
# 
# # miRNA targets and custom RNAseq expression of miRNA and mRNA are used
# miGO1 <- mirnaGOEnricher(gene = brain_mirna, org_assembly = 'hg19', target = TRUE, express = TRUE, isCustomExp = TRUE, exp1 = mirna, exp2 = mrna)
# 

## ----corr union analiz, eval=FALSE--------------------------------------------
# 
# # Union of miRNA targets and custom RNAseq expression of miRNA and mRNA is utilized for enrichment analysis
# miGO1 <- mirnaGOEnricher(gene = brain_mirna, org_assembly = 'hg19', target = TRUE, express = TRUE, isCustomExp = TRUE, exp1 = mirna, exp2 = mrna, isUnionCorGene = TRUE)

## ----pathway biotype , eval=FALSE---------------------------------------------
# # KEGG enrichment is performed
# miPathway <- mirnaPathwayEnricher(gene = brain_mirna, org_assembly = 'hg19', near = TRUE, target = TRUE)

## ----reactome pathway, eval=FALSE---------------------------------------------
# # Change the pathway database
# setParameters("pathwayType","reactome")
# 
# nc2 <- genePathwayEnricher(gene = brain_disorder_ncRNA, org_assembly =  'hg19', near = TRUE, genetype = 'Ensembl_gene')
# 
# # Wiki pathway Enrichment
# 
# # Change the pathway database type and multiple testing correction method
# type <- c('pathwayType', 'pAdjust')
# value<-c('wiki', 'bonferroni')
# setParameters(type,value)
# nc2 <- genePathwayEnricher(gene = brain_disorder_ncRNA, org_assembly =  'hg19', near = TRUE, genetype = 'Ensembl_gene')

## ----custom pathway , eval=FALSE----------------------------------------------
# setParameters("pathwayType","other")
# 
# # Name of the gmt file in the local
# wp.gmt <- "custom.gmt"
# 
# # GMT file should be on the working directory
# ncGO_bader <- genePathwayEnricher(gene = brain_disorder_ncRNA, org_assembly = 'hg19',genetype = 'Ensembl_gene',gmtName = wp.gmt)

## ----extract biotype , eval=FALSE---------------------------------------------
# biotypes <- c('unprocessed_pseudogene','transcribed_unprocessed_pseudogene')
# 
# #Temp.gft is a subset of GENCODE Long non-coding RNA gene annotation
# fileImport<-system.file("extdata", "temp.gtf", package = "NoRCE")
# 
# extrResult <- filterBiotype(fileImport, biotypes)

## ----biotype process , eval=FALSE---------------------------------------------
# #Extract biotype gene interactions from the given GTF formatted file
# fileImport<-system.file("extdata", "temp.gtf", package = "NoRCE")
# 
# #Creates 2 dimensional input Gene-Biotype matrix
# gtf <- extractBiotype(gtfFile = fileImport)

## ----tabular, eval=FALSE------------------------------------------------------
# writeEnrichment(mrnaObject = ncGO,fileName = "result.txt",sept = "\t",type = "pvalue")
# 
# writeEnrichment(mrnaObject = ncGO,fileName = "result.txt",sept = "\t",type = "pvalue", n = 5)

## ----dot, eval=FALSE----------------------------------------------------------
# drawDotPlot(mrnaObject = ncGO, type = "pvalue", n = 25)

## ----network, eval=FALSE------------------------------------------------------
# createNetwork(mrnaObject = ncGO, type = 'pvalue', n = 2, isNonCode = TRUE)

## ----dag, eval=FALSE----------------------------------------------------------
# getGoDag(mrnaObject = ncGO,type = 'pvalue', n = 2,filename = 'dag.png', imageFormat = "png")

## ----kegg diagram, eval=FALSE-------------------------------------------------
# getKeggDiagram(mrnaObject = ncRNAPathway, org_assembly ='hg19', pathway = ncRNAPathway@ID[1])

## ----reactome diagram, eval=FALSE---------------------------------------------
# getReactomeDiagram(mrnaObject = ncRNAPathway, pathway = miGO1@ID[3], imageFormat = "png")

## ----targetmi, eval=FALSE-----------------------------------------------------
# target <- predictmiTargets(gene = brain_mirna[1:100,],
#                      org_assembly = 'hg19', type = "mirna")

## ----coexp, eval=FALSE--------------------------------------------------------
# corAnalysis<-calculateCorr(exp1 = mirna, exp2 = mrna )

## ----go annot, eval=FALSE-----------------------------------------------------
# geneList <- c("FOXP2","SOX4","HOXC6")
# 
# annot <- annGO(genes = geneList, GOtype = 'BP',org_assembly = 'hg19')[[2]]
# 

## ----closeby genes,  eval=FALSE-----------------------------------------------
# neighbour <- getUCSC(bedfile = regionNC,
#                     upstream = 1000,
#                     downstream = 1000,
#                     org_assembly = 'hg19')
# 

