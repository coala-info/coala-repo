# Code example from 'BOBaFIT' vignette. See references/ for full tutorial.

## ----style, eval=TRUE, echo = FALSE, results = 'asis'----------------------
BiocStyle::latex()

## ----load data, echo=FALSE, message=FALSE, paged.print=FALSE, results='asis'----
library(BOBaFIT)
data("TCGA_BRCA_CN_segments")


## ----computeNormalChromosome, fig.show='hide', include=FALSE, results='hide'----
chr_list <- computeNormalChromosomes(segments = TCGA_BRCA_CN_segments, 
				     tolerance_val = 0.25)

## ----chr_list, results='asis'----------------------------------------------
chr_list

## ----chrlist plot, echo=FALSE, fig.height=10, fig.width=16-----------------
chr_list <- computeNormalChromosomes(segments = TCGA_BRCA_CN_segments, 
				     tolerance_val = 0.25)

## ----DRrefit, eval=FALSE---------------------------------------------------
# results <- DRrefit (segments_chort = TCGA_BRCA_CN_segments, chrlist = chr_list)
# 

## ----DRrefit_test,include=FALSE--------------------------------------------
library(dplyr)
samples <- TCGA_BRCA_CN_segments$ID %>% unique()
sample_test <- samples[1:5]
test <- TCGA_BRCA_CN_segments %>% filter(ID %in% sample_test)
results <- DRrefit (segments_chort = test, chrlist = chr_list)

## ----call output PlotChrCluster code 1, eval=FALSE-------------------------
# results$corrected_segments[1,]

## ----Call segments DRrefit 1, echo=FALSE, paged.print=TRUE-----------------
table <- results$corrected_segments[1,] %>% select(chr,start,end, ID, arm, chrarm,CN,CN_corrected)
knitr::kable(table,digits = 3)


## ----call output PlotChrCluster code 2, eval=FALSE-------------------------
# results$report[1,]

## ----Call report DRrefit 2, echo=FALSE, paged.print=TRUE-------------------
knitr::kable(results$report[1,]) 


## ----DRrefit res-----------------------------------------------------------
corrected_segments <- results$corrected_segments
report <- results$report

## ----DRrefit_plot, eval=FALSE----------------------------------------------
# # the plot is diplayed on the R viewer
# DRrefit_plot(corrected_segments = corrected_segments,
#              DRrefit_report = report,
#              plot_viewer = TRUE,
#              plot_save = FALSE )
# 
# # how to save the plot
# DRrefit_plot(corrected_segments = corrected_segments,
#              DRrefit_report = report,
#              plot_save = TRUE, plot_format = "pdf", plot_path = "/my_path" )

## ----DRrefit_plot 1, echo=FALSE, fig.height=7, fig.width=18----------------
report_s <- report[report$sample == "01428281-1653-4839-b5cf-167bc62eb147",]
seg <- corrected_segments[corrected_segments$ID == "01428281-1653-4839-b5cf-167bc62eb147",]
DRrefit_plot(corrected_segments = seg,
             DRrefit_report = report, 
             plot_viewer = T )

## ----DRrefit_plot 2, echo=FALSE, fig.height=7, fig.width=18----------------
report_s <- report[report$sample == "0941a978-c8aa-467b-8464-9f979d1f0418",]
seg <- corrected_segments[corrected_segments$ID == "0941a978-c8aa-467b-8464-9f979d1f0418",]
DRrefit_plot(corrected_segments = seg,
             DRrefit_report = report, 
             plot_viewer = T )

## ----PlotChrCluster, eval=FALSE--------------------------------------------
# Cluster <- PlotChrCluster(segs = TCGA_BRCA_CN_segments,
#                        clust_method = "ward.D2",
#                        plot_output= TRUE)

## ----PlotChrCluster_test, include=FALSE------------------------------------
Cluster <- PlotChrCluster(segs = test,
                       clust_method = "ward.D2",
                       plot_output= T)


## ----call output PlotChrCluster code, eval=FALSE---------------------------
# head(Cluster$report)
# 
# #select plot table per sample
# head(Cluster$plot_tables$`01428281-1653-4839-b5cf-167bc62eb147`)

## ----Call report PlotChrCluster 3------------------------------------------
knitr::kable(head(Cluster$report)) 

#select plot table per sample
knitr::kable(head(Cluster$plot_tables$`01428281-1653-4839-b5cf-167bc62eb147`)) 

## ----sessionInfo,echo=FALSE------------------------------------------------
sessionInfo()

