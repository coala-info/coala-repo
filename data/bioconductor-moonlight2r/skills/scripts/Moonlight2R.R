# Code example from 'Moonlight2R' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(dpi = 72)
knitr::opts_chunk$set(cache=FALSE)

## ----fig.width=3, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
knitr::include_graphics("Moonlight2_pipeline_upd.png")

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("Moonlight2R")

## ----eval = FALSE-------------------------------------------------------------
# install.packages("devtools")
# library(devtools)

## ----eval = FALSE-------------------------------------------------------------
# devtools::install_github(repo = "ELELAB/Moonlight2R")

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("BiocStyle")

## ----eval = FALSE-------------------------------------------------------------
# devtools::install_github(repo = "ELELAB/Moonlight2R", build_vignettes = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# vignette( "Moonlight2R", package="Moonlight2R")

## ----eval = TRUE--------------------------------------------------------------
library(Moonlight2R)
library(magrittr)
library(dplyr)

## ----eval = TRUE--------------------------------------------------------------
data(DEGsmatrix)
data(dataFilt)
data(dataMAF)
data(GEO_TCGAtab)
data(LOC_transcription)
data(LOC_translation)
data(LOC_protein)
data(Oncogenic_mediators_mutation_summary)
data(DEG_Mutations_Annotations)
data(dataMethyl)
data(DEG_Methylation_Annotations)
data(Oncogenic_mediators_methylation_summary)
data(MetEvidenceDriver)
data(LUAD_sample_anno)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
knitr::kable(GEO_TCGAtab, digits = 2,
       caption = "Table with GEO data set matched to one
       of the 18 given TCGA cancer types ",
       row.names = TRUE)

## ----eval = TRUE, echo = TRUE, results='hide', warning = FALSE, message = FALSE----
dataFilt_GEO <- getDataGEO(GEOobject = "GSE20347", platform = "GPL571")

## ----eval = TRUE, echo = TRUE, results='hide', warning = FALSE, message = FALSE----
dataFilt_GEO <- getDataGEO(TCGAtumor = "ESCA")

## ----eval = TRUE, echo = TRUE, results='hide'---------------------------------
data(DEGsmatrix)
data(DiseaseList)
data(EAGenes)
dataFEA <- FEA(DEGsmatrix = DEGsmatrix)

## ----eval = TRUE, echo = TRUE, message=FALSE, results='hide', warning=FALSE----
plotFEA(dataFEA = dataFEA, additionalFilename = "_exampleVignette", height = 10, width = 20)

## ----fig.width=3, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
knitr::include_graphics("FEAplot.gif")

## ----eval = TRUE--------------------------------------------------------------
data(DEGsmatrix)
data(dataFilt)
dataGRN <- GRN(DEGsmatrix = DEGsmatrix, TFs = sample(rownames(DEGsmatrix), 100), normCounts = dataFilt,
	               nGenesPerm = 5, kNearest = 3, nBoot = 5, DiffGenes = TRUE)

## ----eval = TRUE, echo = TRUE, results='hide'---------------------------------
data(dataGRN)
data(DEGsmatrix)
data(DiseaseList)
data(EAGenes)

dataFEA <- FEA(DEGsmatrix = DEGsmatrix)

BPselected <- dataFEA$Diseases.or.Functions.Annotation[1:5]
dataURA <- URA(dataGRN = dataGRN,
               DEGsmatrix = DEGsmatrix,
               BPname = BPselected,
               nCores=1)

## ----eval = TRUE--------------------------------------------------------------
data(dataURA)
data(tabGrowBlock)
data(knownDriverGenes)
dataPRA <- PRA(dataURA = dataURA,
               BPname = c("apoptosis","proliferation of cells"),
               thres.role = 0)

## ----eval = FALSE-------------------------------------------------------------
# data(dataPRA)
# data(dataMAF)
# data(DEGsmatrix)
# data(LOC_transcription)
# data(LOC_translation)
# data(LOC_protein)
# data(NCG)
# data(EncodePromoters)
# dataDMA <- DMA(dataMAF = dataMAF,
#                dataDEGs = DEGsmatrix,
#                dataPRA = dataPRA,
#                results_folder = "DMAresults",
#                coding_file = "css_coding.vcf.gz",
#                noncoding_file = "css_noncoding.vcf.gz")

## ----eval = TRUE--------------------------------------------------------------
data("dataMethyl")
data("dataFilt")
data("dataPRA")
data("DEGsmatrix")
data("LUAD_sample_anno")
data("NCG")
data("EncodePromoters")
data("MetEvidenceDriver")

# Subset column names (sample names) in expression data to patient level
pattern <- "^(.{4}-.{2}-.{4}-.{2}).*"
colnames(dataFilt) <- sub(pattern, "\\1", colnames(dataFilt))

dataGMA <- GMA(dataMET = dataMethyl, dataEXP = dataFilt,
               dataPRA = dataPRA, dataDEGs = DEGsmatrix,
               sample_info = LUAD_sample_anno, met_platform = "HM450",
               prevalence_filter = NULL,
               output_dir = "./GMAresults", cores = 1, roadmap.epigenome.ids = "E096",
               roadmap.epigenome.groups = NULL)

## ----eval = TRUE--------------------------------------------------------------
genes_query <- "BRCA1"
dataGLS <- GLS(genes = genes_query,
	       query_string = "AND cancer AND driver")
head(dataGLS)

## ----eval = TRUE--------------------------------------------------------------

mavisp_db_location <- system.file('extdata', 'mavisp_db', package='Moonlight2R')

specific_protein <- loadMAVISp(mavispDB = mavisp_db_location,
                               mode = 'simple',
                               proteins_of_interest = c('RUNX1'))

all_proteins <- loadMAVISp(mavispDB = mavisp_db_location,
                           mode = 'simple')

ensemble <- loadMAVISp(mavispDB = mavisp_db_location,
                       mode = 'ensemble',
                       ensemble = 'cabsflex')

## ----eval = TRUE--------------------------------------------------------------
data(dataPRA)
data(DEGsmatrix)
data(dataTRRUST)
data(dataMAF)
data(dataMAVISp)

TFresults <- TFinfluence(dataTRRUST = dataTRRUST,
            dataMAF = dataMAF,
            dataDEGs = DEGsmatrix,
            dataPRA = dataPRA,
            dataMAVISp = dataMAVISp,
            stabClassMAVISp = 'rasp')

## -----------------------------------------------------------------------------
knitr::kable(LOC_transcription)

## -----------------------------------------------------------------------------
knitr::kable(LOC_translation)

## -----------------------------------------------------------------------------
knitr::kable(LOC_protein)

## ----eval = TRUE, echo = TRUE, results='hide', warning = FALSE, message = FALSE----
data(knownDriverGenes)
data(dataGRN)
plotNetworkHive(dataGRN, knownDriverGenes, 0.55)

## ----eval = TRUE, warning = FALSE, message = FALSE, include=TRUE--------------
data(dataDMA)
data(DEG_Mutations_Annotations)
data(Oncogenic_mediators_mutation_summary)
plotDMA(DEG_Mutations_Annotations,
        Oncogenic_mediators_mutation_summary,
        type = 'complete', additionalFilename = "")

## ----fig.width=3, fig.height=4, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
knitr::include_graphics("heatmap_complete.gif")

## ----eval = TRUE, echo = TRUE, results='hide', warning = FALSE, message = FALSE----
data(DEG_Mutations_Annotations)
data(Oncogenic_mediators_mutation_summary)
data(dataURA_plot)
plotMoonlight(DEG_Mutations_Annotations,
        Oncogenic_mediators_mutation_summary,
        dataURA_plot, gene_type = "drivers", n = 50)

## ----fig.width=3, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
knitr::include_graphics("moonlight_heatmap.gif")

## ----eval = TRUE, warning = FALSE, message = FALSE, include = TRUE------------
data("DEG_Methylation_Annotations")
data("Oncogenic_mediators_methylation_summary")
genes <- c("ACAN", "ACE2", "ADAM19", "AFAP1L1")
plotGMA(DEG_Methylation_Annotations = DEG_Methylation_Annotations,
        Oncogenic_mediators_methylation_summary = Oncogenic_mediators_methylation_summary,
        type = "genelist", genelist = genes,
        additionalFilename = "./GMAresults/")

## ----fig.width=3, fig.height=4, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
knitr::include_graphics("heatmap_genelist_met.gif")

## ----eval = TRUE, warning = FALSE, message = FALSE, include = TRUE------------
data("DEG_Methylation_Annotations")
data("Oncogenic_mediators_methylation_summary")
data("dataURA_plot")
genes <- c("ACAN", "ACE2", "ADAM19", "AFAP1L1")
plotMoonlightMet(DEG_Methylation_Annotations = DEG_Methylation_Annotations,
                 Oncogenic_mediators_methylation_summary = Oncogenic_mediators_methylation_summary,
                 dataURA = dataURA_plot,
                 genes = genes,
                 additionalFilename = "./GMAresults/")

## ----fig.width=3, fig.height=4, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
knitr::include_graphics("moonlight_heatmap_met.gif")

## ----eval = TRUE, warning = FALSE, message = FALSE, include = TRUE------------
data("EpiMix_Results_Regular")
data("dataMethyl")
data("dataFilt")

# Subset column names (sample names) in expression data to patient level
pattern <- "^(.{4}-.{2}-.{4}-.{2}).*"
colnames(dataFilt) <- sub(pattern, "\\1", colnames(dataFilt))

plotMetExp(EpiMix_results = EpiMix_Results_Regular,
           probe_name = "cg03035704",
           dataMET = dataMethyl,
           dataEXP = dataFilt,
           gene_of_interest = "ACVRL1",
           additionalFilename = "./GMAresults/")

## ----fig.width=3, fig.height=4, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
knitr::include_graphics("plotMetExp.png")

## ----eval = TRUE,echo=TRUE,message=FALSE,warning=FALSE, results='hide'--------
data(DEGsmatrix)
data(dataFilt)
data(DiseaseList)
data(EAGenes)
data(tabGrowBlock)
data(knownDriverGenes)

dataFEA <- FEA(DEGsmatrix = DEGsmatrix)

dataGRN <- GRN(TFs = sample(rownames(DEGsmatrix), 100),
               DEGsmatrix = DEGsmatrix,
               DiffGenes = TRUE,
               normCounts = dataFilt,
               nGenesPerm = 5,
               nBoot = 5,
	       kNearest = 3)

dataURA <- URA(dataGRN = dataGRN,
              DEGsmatrix = DEGsmatrix,
              BPname = c("apoptosis",
                         "proliferation of cells"))

dataDual <- PRA(dataURA = dataURA,
               BPname = c("apoptosis",
                          "proliferation of cells"),
               thres.role = 0)

oncogenic_mediators <- list("TSG"=names(dataDual$TSG), "OCG"=names(dataDual$OCG))


## ----eval = TRUE,message=FALSE,warning=FALSE, results='hide'------------------
data(dataURA)
plotURA(dataURA = dataURA, additionalFilename = "_exampleVignette")

## ----fig.width=3, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
knitr::include_graphics("URAplot.gif")

## ----eval = FALSE,echo=TRUE,message=FALSE,warning=FALSE-----------------------
# data(dataFilt)
# data(DEGsmatrix)
# data(dataMAF)
# data(DiseaseList)
# data(EAGenes)
# data(tabGrowBlock)
# data(knownDriverGenes)
# data(LOC_transcription)
# data(LOC_translation)
# data(LOC_protein)
# data(NCG)
# data(EncodePromoters)
# 
# listMoonlight <- moonlight(dataDEGs = DEGsmatrix,
#                            dataFilt = dataFilt,
#                            nTF = 100,
#                            DiffGenes = TRUE,
# 			   nGenesPerm = 5,
#                            nBoot = 5,
#                            BPname = c("apoptosis","proliferation of cells"),
#                            dataMAF = dataMAF,
#                            path_cscape_coding = "css_coding.vcf.gz",
#                            path_cscape_noncoding = "css_noncoding.vcf.gz")
# save(listMoonlight, file = paste0("listMoonlight_ncancer4.Rdata"))
# 
# 

## ----eval = TRUE, echo = TRUE, results='hide', warning = FALSE, message = FALSE----
data(listMoonlight)
plotCircos(listMoonlight = listMoonlight, additionalFilename = "_ncancer5")

## ----fig.width=3, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
knitr::include_graphics("circos_ocg_tsg_ncancer5.gif")

## ----eval = FALSE,echo=TRUE,message=FALSE,warning=FALSE-----------------------
# 
# data(DEGsmatrix)
# data(dataFilt)
# data(dataMAF)
# data(DiseaseList)
# data(EAGenes)
# data(tabGrowBlock)
# data(knownDriverGenes)
# data(LOC_transcription)
# data(LOC_translation)
# data(LOC_protein)
# data(NCG)
# data(EncodePromoters)
# 
# # Perform gene regulatory network analysis
# dataGRN <- GRN(TFs = rownames(DEGsmatrix),
# 	       DEGsmatrix = DEGsmatrix,
# 	       DiffGenes = TRUE,
#                normCounts = dataFilt,
#                nGenesPerm = 5,
#                kNearest = 3,
#                nBoot = 5)
# 
# # Perform upstream regulatory analysis
# # As example, we use apoptosis and proliferation of cells as the biological processes
# dataURA <- URA(dataGRN = dataGRN,
#                DEGsmatrix = DEGsmatrix,
#                BPname = c("apoptosis",
#                           "proliferation of cells"),
#                nCores = 1)
# 
# # Perform pattern recognition analysis
# dataPRA <- PRA(dataURA = dataURA,
#                BPname = c("apoptosis",
#                           "proliferation of cells"),
#                thres.role = 0)
# 
# # Perform driver mutation analysis
# dataDMA <- DMA(dataMAF = dataMAF,
#                dataDEGs = DEGsmatrix,
#                dataPRA = dataPRA,
#                results_folder = "DMAresults",
#                coding_file = "css_coding.vcf.gz",
#                noncoding_file = "css_noncoding.vcf.gz")
# 

## ----eval = TRUE--------------------------------------------------------------
data(Oncogenic_mediators_mutation_summary)
data(DEG_Mutations_Annotations)

# Extract oncogenic mediators that contain at least one driver mutation
# These are the driver genes
knitr::kable(Oncogenic_mediators_mutation_summary %>%
  filter(!is.na(CScape_Driver)))

# Extract mutation annotations of the predicted driver genes
driver_mut <- DEG_Mutations_Annotations %>%
  filter(!is.na(Moonlight_Oncogenic_Mediator),
         CScape_Mut_Class == "Driver")

# Extract driver genes with a predicted effect on the transcriptional level
transcription_mut <- Oncogenic_mediators_mutation_summary %>%
  filter(!is.na(CScape_Driver)) %>%
  filter(Transcription_mut_sum > 0)

# Extract mutation annotations of predicted driver genes that have a driver mutation
# in its promoter region with a potential effect on the transcriptional level
promoters <- DEG_Mutations_Annotations %>%
  filter(!is.na(Moonlight_Oncogenic_Mediator),
         CScape_Mut_Class == "Driver",
         Potential_Effect_on_Transcription == 1,
         Annotation == 'Promoter')

## ----eval = TRUE,echo=TRUE,message=FALSE,warning=FALSE,results='hide'---------

data(DEGsmatrix)
data(dataFilt)
data(dataMAF)
data(DiseaseList)
data(EAGenes)
data(tabGrowBlock)
data(knownDriverGenes)
data(LOC_transcription)
data(LOC_translation)
data(LOC_protein)
data(NCG)
data(EncodePromoters)
data(dataMethyl)
data(LUAD_sample_anno)
data(MetEvidenceDriver)

# Perform gene regulatory network analysis
dataGRN <- GRN(TFs = rownames(DEGsmatrix),
               DEGsmatrix = DEGsmatrix,
               DiffGenes = TRUE,
               normCounts = dataFilt,
               nGenesPerm = 5,
               kNearest = 3,
               nBoot = 5)

# Perform upstream regulatory analysis
# As example, we use apoptosis and proliferation of cells as the biological processes
dataURA <- URA(dataGRN = dataGRN,
               DEGsmatrix = DEGsmatrix,
               BPname = c("apoptosis",
                          "proliferation of cells"),
               nCores = 1)

# Perform pattern recognition analysis
dataPRA <- PRA(dataURA = dataURA,
               BPname = c("apoptosis",
                          "proliferation of cells"),
               thres.role = 0)

# Subset column names (sample names) in expression data to patient level
pattern <- "^(.{4}-.{2}-.{4}-.{2}).*"
colnames(dataFilt) <- sub(pattern, "\\1", colnames(dataFilt))

# Perform gene methylation analysis
dataGMA <- GMA(dataMET = dataMethyl, dataEXP = dataFilt,
               dataPRA = dataPRA, dataDEGs = DEGsmatrix,
               sample_info = LUAD_sample_anno, met_platform = "HM450",
               prevalence_filter = NULL,
               output_dir = "./GMAresults", cores = 1,
               roadmap.epigenome.ids = "E096",
               roadmap.epigenome.groups = NULL)


## ----sessionInfo--------------------------------------------------------------
sessionInfo()

