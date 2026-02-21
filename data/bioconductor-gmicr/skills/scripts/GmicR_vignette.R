# Code example from 'GmicR_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.align= "center",
  comment = "#>"
)

## ----Bioconductor installation, echo=TRUE, eval=FALSE-------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install('GmicR')

## ----downloading data, echo=TRUE----------------------------------------------
url <- "http://xcell.ucsf.edu/iris_u133a_expr.txt"

dat_download <- data.frame(read.delim(url),
row.names = 1, stringsAsFactors = FALSE, check.rows = FALSE)

# data are transposed for processing
datExpr0<-data.frame(t(dat_download))

## ----checking genes, message=FALSE, warning=FALSE-----------------------------
library(WGCNA)
gsg = goodSamplesGenes(datExpr0, verbose = 3) # columns must be genes
gsg$allOK

## ----checking samples---------------------------------------------------------
sampleTree = hclust(dist(datExpr0), method = "average");

par(cex = 0.6);
par(mar = c(0,4,2,0))
plot(sampleTree, main = "Sample Filtering", 
labels = FALSE)

# final expression set ----------------------------------------------------
datExpr = datExpr0


## ----saving expression data, echo=TRUE, eval = FALSE--------------------------
# Exps_for_xCell_analysis<-data.frame(t(datExpr), check.names = FALSE)
# 
# write.csv(Exps_for_xCell_analysis, file = "Exps_for_xCell_analysis.csv")

## ----xCell email screen shot, echo=FALSE, out.width = '80%'-------------------
xCell_email_dir<-system.file("extdata", "xCell_email.png", 
package = "GmicR", mustWork = TRUE)
knitr::include_graphics(xCell_email_dir)

## ----clearing environment and loading data, include=FALSE---------------------
remove(list = ls())
library(GmicR)
sample_dat_dir<-system.file("extdata", "sample_dat.Rdata", 
                            package = "GmicR", mustWork = TRUE)
load(sample_dat_dir)

## ----module detection, echo=TRUE, results=FALSE-------------------------------
library(GmicR)

GMIC_Builder<-Auto_WGCNA(sample_dat, 
  mergeCutHeight = 0.35, minModuleSize = 10,
  deepSplit = 4, networkType = "signed hybrid", TOMType = "unsigned",
  corFnc = "bicor",  sft_RsquaredCut = 0.85,
  reassignThreshold = 1e-06, maxBlockSize = 25000)


## ----modules, echo=TRUE, fig.height=5, fig.width=5----------------------------
GMIC_Builder$Input_Parameters

## ----plot1,, echo=TRUE, fig.height=5, fig.width=5-----------------------------
GMIC_Builder$Output_plots$soft_threshold_plot

## ----loading processed data, include=FALSE------------------------------------

GMIC_Builder_dir<-system.file("extdata", "GMIC_Builder.Rdata", 
                            package = "GmicR", mustWork = TRUE)
load(GMIC_Builder_dir)


## ----plot2, , echo=TRUE, fig.height=5, fig.width=5----------------------------
GMIC_Builder$Output_plots$module_clustering

## ----plot3, , echo=TRUE, fig.height=5, fig.width=5----------------------------
GMIC_Builder$Output_plots$net_dendrogram

## ----GO module annotations, echo=TRUE-----------------------------------------
# Module hubs and Gene influence
GMIC_Builder<-Query_Prep(GMIC_Builder,  
  calculate_intramodularConnectivity= TRUE,
  Find_hubs = TRUE)

head(GMIC_Builder$Query)

## ----GO enrichment, echo=TRUE-------------------------------------------------

GMIC_Builder<-GSEAGO_Builder(GMIC_Builder,
  species = "Homo sapiens", ontology = "BP", no_cores = 1)


## ----GO module names, echo=TRUE-----------------------------------------------
GMIC_Builder<-GO_Module_NameR(GMIC_Builder)

## ----GO_table-----------------------------------------------------------------
head(GMIC_Builder$GO_table, n = 4)

## ----GO_Query-----------------------------------------------------------------
head(GMIC_Builder$GO_Query, n = 4)

## ----cell signatures, echo=TRUE-----------------------------------------------
file_dir<-system.file("extdata", "IRIS_xCell_sig.txt", 
                      package = "GmicR", mustWork = TRUE)

## ----discretizing data--------------------------------------------------------
GMIC_Builder_disc<-Data_Prep(GMIC_Builder,  
  xCell_Signatures = file_dir, 
ibreaks=10, Remove_ME0 = TRUE)

head(GMIC_Builder_disc$disc_data[sample(seq(1,64),4)])


## ----loading processed network, message=FALSE, warning=FALSE, include=FALSE----

GMIC_net_dir<-system.file("extdata", "GMIC_net.Rdata", 
                            package = "GmicR", mustWork = TRUE)
load(GMIC_net_dir)


## ----bnlearning, eval=FALSE, echo=TRUE----------------------------------------
# 
# no_cores<-1 # multicore support
# cl<-parallel::makeCluster(1)
# 
# 
# GMIC_net<-bn_tabu_gen(GMIC_Builder_disc,
#   cluster = cl, debug = FALSE,
#   bootstraps_replicates = 50, score = "bds")
# 
# parallel::stopCluster(cl) # stop cluster

## ----detecting inverse relationships, echo=TRUE-------------------------------


GMIC_Final<-InverseARCs(GMIC_net, threshold = -0.3)


## ----Visualizing network, echo=TRUE-------------------------------------------
GMIC_Final_dir<-system.file("extdata", "GMIC_Final.Rdata", 
                          package = "GmicR", mustWork = TRUE)
load(GMIC_Final_dir)

if(interactive()){
Gmic_viz(GMIC_Final)
}

## ----screen shot1, echo=FALSE, out.width = '100%'-----------------------------
example_shiny_dir<-system.file("extdata", "example_shiny1.png", 
package = "GmicR", mustWork = TRUE)
knitr::include_graphics(example_shiny_dir)

## ----screen shot2, echo=FALSE, out.width = '100%'-----------------------------
example_shiny_dir<-system.file("extdata", "example_shiny2.png", 
package = "GmicR", mustWork = TRUE)
knitr::include_graphics(example_shiny_dir)

## ----screen shot3, echo=FALSE, out.width = '100%'-----------------------------
example_shiny_dir<-system.file("extdata", "example_shiny3.png", 
package = "GmicR", mustWork = TRUE)
knitr::include_graphics(example_shiny_dir)

