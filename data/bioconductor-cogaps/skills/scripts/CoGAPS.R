# Code example from 'CoGAPS' vignette. See references/ for full tutorial.

## ----include=FALSE, cache=FALSE-----------------------------------------------
library(CoGAPS)
library(BiocParallel)

## ----current version----------------------------------------------------------
packageVersion("CoGAPS")

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("FertigLab/CoGAPS")
# 
# # To install via BioConductor:
# install.packages("BiocManager")
# BiocManager::install("FertigLab/CoGAPS")

## ----library------------------------------------------------------------------
library(CoGAPS)

## ----modsim-------------------------------------------------------------------
data('modsimdata')
# input to CoGAPS
modsimdata

## ----modsim params------------------------------------------------------------
# create new parameters object
params <- new("CogapsParams", nPatterns=6)

# view all parameters
params

# get the value for a specific parameter
getParam(params, "nPatterns")

# set the value for a specific parameter
params <- setParam(params, "nPatterns", 3)
getParam(params, "nPatterns")

## ----cogaps on modsim---------------------------------------------------------
# run CoGAPS with specified parameters
cogapsresult <- CoGAPS(modsimdata, params, outputFrequency = 10000)

## ----modsim result------------------------------------------------------------
cogapsresult
cogapsresult@sampleFactors
cogapsresult@featureLoadings

# check reference result:
data('modsimresult')

## ----load single cell data from zenodo----------------------------------------
# OPTION: download data object from Zenodo
options(timeout=50000) # adjust this if you're getting timeout downloading the file
bfc <- BiocFileCache::BiocFileCache()
pdac_url <- "https://zenodo.org/record/7709664/files/inputdata.Rds"
pdac_data <- BiocFileCache::bfcrpath(bfc, pdac_url)
pdac_data <- readRDS(pdac_data)
pdac_data

## ----extract counts matrix, eval=FALSE----------------------------------------
# pdac_epi_counts <- as.matrix(pdac_data@assays$originalexp@counts)
# norm_pdac_epi_counts <- log1p(pdac_epi_counts)
# 
# head(pdac_epi_counts, n=c(5L, 2L))
# head(norm_pdac_epi_counts, n=c(5L, 2L))

## ----set params---------------------------------------------------------------
library(CoGAPS)
pdac_params <- CogapsParams(nIterations=50000, # 50000 iterations
               	seed=42, # for consistency across stochastic runs
               	nPatterns=8, # each thread will learn 8 patterns
                sparseOptimization=TRUE, # optimize for sparse data
                distributed="genome-wide") # parallelize across sets

pdac_params

## ----distributed params-------------------------------------------------------
pdac_params <- setDistributedParams(pdac_params, nSets=7)
pdac_params

## ----run CoGAPS on single-cell data, eval=FALSE-------------------------------
# startTime <- Sys.time()
# 
# pdac_epi_result <- CoGAPS(pdac_epi_counts, pdac_params)
# endTime <- Sys.time()
# 
# saveRDS(pdac_epi_result, "../data/pdac_epi_cogaps_result.Rds")
# 
# # To save as a .csv file, use the following line:
# toCSV(pdac_epi_result, "../data")

## ----load precomputed from zenodo---------------------------------------------
# OPTION: download precomputed CoGAPS result object from Zenodo
#caches download of the hosted file
cogapsresult_url <- "https://zenodo.org/record/7709664/files/cogapsresult.Rds"
cogapsresult <- BiocFileCache::bfcrpath(bfc, cogapsresult_url)
cogapsresult <- readRDS(cogapsresult)


## ----load saved, eval=FALSE---------------------------------------------------
# library(CoGAPS)
# cogapsresult <- readRDS("../data/pdac_epi_cogaps_result.Rds")

## ----pattern assay, eval=FALSE------------------------------------------------
# library(Seurat)
# # make sure pattern matrix is in same order as the input data
# patterns_in_order <-t(cogapsresult@sampleFactors[colnames(pdac_data),])
# 
# # add CoGAPS patterns as an assay
# pdac_data[["CoGAPS"]] <- CreateAssayObject(counts = patterns_in_order)

## ----pattern UMAP, eval=FALSE-------------------------------------------------
# DefaultAssay(pdac_data) <- "CoGAPS"
# pattern_names = rownames(pdac_data@assays$CoGAPS)
# 
# library(viridis)
# color_palette <- viridis(n=10)
# 
# FeaturePlot(pdac_data, pattern_names, cols=color_palette, reduction = "umap") & NoLegend()

## ----pattern markers----------------------------------------------------------
pm <- patternMarkers(cogapsresult)

## ----get hallmarks------------------------------------------------------------
hallmark_ls <- list(
  "HALLMARK_ALLOGRAFT_REJECTION" = c(
    "AARS1","ABCE1","ABI1","ACHE","ACVR2A","AKT1","APBB1","B2M","BCAT1","BCL10","BCL3","BRCA1","C2","CAPG","CARTPT","CCL11","CCL13","CCL19","CCL2","CCL22","CCL4","CCL5","CCL7","CCND2","CCND3","CCR1","CCR2","CCR5","CD1D","CD2","CD247","CD28","CD3D","CD3E","CD3G","CD4","CD40","CD40LG","CD47","CD7","CD74","CD79A","CD80","CD86","CD8A","CD8B","CD96","CDKN2A","CFP","CRTAM","CSF1","CSK","CTSS","CXCL13","CXCL9","CXCR3","DARS1","DEGS1","DYRK3","EGFR","EIF3A","EIF3D","EIF3J","EIF4G3","EIF5A","ELANE","ELF4","EREG","ETS1","F2","F2R","FAS","FASLG","FCGR2B","FGR","FLNA","FYB1","GALNT1","GBP2","GCNT1","GLMN","GPR65","GZMA","GZMB","HCLS1","HDAC9","HIF1A","HLA-A","HLA-DMA","HLA-DMB","HLA-DOA","HLA-DOB","HLA-DQA1","HLA-DRA","HLA-E","HLA-G","ICAM1","ICOSLG","IFNAR2","IFNG","IFNGR1","IFNGR2","IGSF6","IKBKB","IL10","IL11","IL12A","IL12B","IL12RB1","IL13","IL15","IL16","IL18","IL18RAP","IL1B","IL2","IL27RA","IL2RA","IL2RB","IL2RG","IL4","IL4R","IL6","IL7","IL9","INHBA","INHBB","IRF4","IRF7","IRF8","ITGAL","ITGB2","ITK","JAK2","KLRD1","KRT1","LCK","LCP2","LIF","LTB","LY75","LY86","LYN","MAP3K7","MAP4K1","MBL2","MMP9","MRPL3","MTIF2","NCF4","NCK1","NCR1","NLRP3","NME1","NOS2","NPM1","PF4","PRF1","PRKCB","PRKCG","PSMB10","PTPN6","PTPRC","RARS1","RIPK2","RPL39","RPL3L","RPL9","RPS19","RPS3A","RPS9","SIT1","SOCS1","SOCS5","SPI1","SRGN","ST8SIA4","STAB1","STAT1","STAT4","TAP1","TAP2","TAPBP","TGFB1","TGFB2","THY1","TIMP1","TLR1","TLR2","TLR3","TLR6","TNF","TPD52","TRAF2","TRAT1","UBE2D1","UBE2N","WARS1","WAS","ZAP70"
    ),
  "HALLMARK_EPITHELIAL_MESENCHYMAL_TRANSITION" = c(
    "ABI3BP","ACTA2","ADAM12","ANPEP","APLP1","AREG","BASP1","BDNF","BGN","BMP1","CADM1","CALD1","CALU","CAP2","CAPG","CD44","CD59","CDH11","CDH2","CDH6","COL11A1","COL12A1","COL16A1","COL1A1","COL1A2","COL3A1","COL4A1","COL4A2","COL5A1","COL5A2","COL5A3","COL6A2","COL6A3","COL7A1","COL8A2","COMP","COPA","CRLF1","CCN2","CTHRC1","CXCL1","CXCL12","CXCL6","CCN1","DAB2","DCN","DKK1","DPYSL3","DST","ECM1","ECM2","EDIL3","EFEMP2","ELN","EMP3","ENO2","FAP","FAS","FBLN1","FBLN2","FBLN5","FBN1","FBN2","FERMT2","FGF2","FLNA","FMOD","FN1","FOXC2","FSTL1","FSTL3","FUCA1","FZD8","GADD45A","GADD45B","GAS1","GEM","GJA1","GLIPR1","COLGALT1","GPC1","GPX7","GREM1","HTRA1","ID2","IGFBP2","IGFBP3","IGFBP4","IL15","IL32","IL6","CXCL8","INHBA","ITGA2","ITGA5","ITGAV","ITGB1","ITGB3","ITGB5","JUN","LAMA1","LAMA2","LAMA3","LAMC1","LAMC2","P3H1","LGALS1","LOX","LOXL1","LOXL2","LRP1","LRRC15","LUM","MAGEE1","MATN2","MATN3","MCM7","MEST","MFAP5","MGP","MMP1","MMP14","MMP2","MMP3","MSX1","MXRA5","MYL9","MYLK","NID2","NNMT","NOTCH2","NT5E","NTM","OXTR","PCOLCE","PCOLCE2","PDGFRB","PDLIM4","PFN2","PLAUR","PLOD1","PLOD2","PLOD3","PMEPA1","PMP22","POSTN","PPIB","PRRX1","PRSS2","PTHLH","PTX3","PVR","QSOX1","RGS4","RHOB","SAT1","SCG2","SDC1","SDC4","SERPINE1","SERPINE2","SERPINH1","SFRP1","SFRP4","SGCB","SGCD","SGCG","SLC6A8","SLIT2","SLIT3","SNAI2","SNTB1","SPARC","SPOCK1","SPP1","TAGLN","TFPI2","TGFB1","TGFBI","TGFBR3","TGM2","THBS1","THBS2","THY1","TIMP1","TIMP3","TNC","TNFAIP3","TNFRSF11B","TNFRSF12A","TPM1","TPM2","TPM4","VCAM1","VCAN","VEGFA","VEGFC","VIM","WIPF1","WNT5A"
  )
)

hallmarks_ora <- getPatternGeneSet(cogapsresult,
                                   gene.sets = hallmark_ls,
                                   method = "overrepresentation")

## ----plot hallmarks-----------------------------------------------------------
pl_pattern7 <- plotPatternGeneSet(
  patterngeneset = hallmarks_ora, whichpattern = 7, padj_threshold = 0.05
)
pl_pattern7

## ----MANOVA variables---------------------------------------------------------
# create dataframe of interested variables 
interestedVariables <- cbind(pdac_data@meta.data[["nCount_RNA"]], pdac_data@meta.data[["nFeature_RNA"]])
# call cogaps manova wrapper
manova_results <- MANOVA(interestedVariables, cogapsresult)

