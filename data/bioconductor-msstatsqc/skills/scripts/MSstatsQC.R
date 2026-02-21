# Code example from 'MSstatsQC' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MSstatsQC")

## ----eval=TRUE----------------------------------------------------------------
#A typical multi peptide and multi metric system suitability dataset
#This dataset was generated during CPTAC Study 9.1 at Site 54
library(MSstatsQC)
data <- MSstatsQC::S9Site54

## ----eval=FALSE---------------------------------------------------------------
# MSnbaseToMSstatsQC(msfile)

## ----eval=TRUE----------------------------------------------------------------
data<-DataProcess(data)

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
#An X chart when a guide set (1-20 runs) is used to monitor the mean of retention time
XmRChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "BestRetentionTime", normalization = FALSE, ytitle = "X Chart : retention time", type = "mean", selectMean = NULL ,selectSD = NULL )
#An X chart when a guide set (1-20 runs) is used to monitor the mean of total peak area
XmRChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "TotalArea", normalization = FALSE, ytitle = "X Chart : peak area", type = "mean", selectMean = NULL ,selectSD = NULL )

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
#An mR chart when a guide set (1-20 runs) is used to monitor the variability of total peak area
XmRChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "TotalArea", normalization = TRUE, ytitle = "mR Chart : peak area", type = "variability", selectMean = NULL, selectSD = NULL )
#An mR chart when a guide set (1-20 runs) is used to monitor the variability of retention time
XmRChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "BestRetentionTime", normalization = TRUE, ytitle = "mR Chart : retention time", type = "variability", selectMean = NULL, selectSD = NULL )
#Mean and standard deviation of LVNELTEFAK is known
XmRChart( data, "LVNELTEFAK", metric = "BestRetentionTime", selectMean = 28.5, selectSD = 0.5 )

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
#Mean and standard deviation of LVNELTEFAK is known
XmRChart( data, "LVNELTEFAK", metric = "BestRetentionTime", selectMean = 28.5, selectSD = 0.5 )

## ----eval=TRUE, echo =FALSE, fig.width=8, fig.height=5------------------------
#A CUSUMm chart when a guide set (1-20 runs) is used to monitor the mean of retention time
CUSUMChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "BestRetentionTime", normalization = TRUE, ytitle = "CUSUMm Chart : retention time", type = "mean", referenceValue = 0.5, decisionInterval = 5, selectMean = NULL ,selectSD = NULL )
#A CUSUMm chart when a guide set (1-20 runs) is used to monitor the mean of total peak area
CUSUMChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "TotalArea", normalization = TRUE, ytitle = "CUSUMm Chart : peak area", type = "mean", referenceValue = 0.5, decisionInterval = 5, selectMean = NULL ,selectSD = NULL  )

## ----eval=TRUE, echo =FALSE, fig.width=8, fig.height=5------------------------
#A CUSUMv chart when a guide set (1-20 runs) is used to monitor the variability of retention time
CUSUMChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "BestRetentionTime", normalization = TRUE, ytitle = "CUSUMv Chart : retention time", type = "variability", referenceValue = 0.5, decisionInterval = 5, selectMean = NULL ,selectSD = NULL )
#A CUSUMv chart when a guide set (1-20 runs) is used to monitor the variability of total peak area
CUSUMChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "TotalArea", normalization = TRUE, ytitle = "CUSUMv Chart : peak area", type = "variability", referenceValue = 0.5, decisionInterval = 5, selectMean = NULL ,selectSD = NULL )

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
# Retention time >> first 20 observations are used as a guide set
XmRChart(data, "TAAYVNAIEK", metric = "BestRetentionTime", type="mean", L = 1, U = 20)
ChangePointEstimator(data, "TAAYVNAIEK", metric = "BestRetentionTime", type="mean", L = 1, U = 20)

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
# Retention time >> first 20 observations are used as a guide set
XmRChart(data, "YSTDVSVDEVK", metric = "BestRetentionTime", type="mean", L = 1, U = 20)
ChangePointEstimator(data, "YSTDVSVDEVK", metric = "BestRetentionTime", type="variability", L = 1, U = 20)

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
# Retention time >> first 20 observations are used as a guide set
RiverPlot(data = S9Site54, L = 1, U = 20, method = "XmR")
RiverPlot(data = S9Site54, L = 1, U = 20, method = "CUSUM")
RadarPlot(data = S9Site54, L = 1, U = 20, method = "XmR")
RadarPlot(data = S9Site54, L = 1, U = 20, method = "CUSUM")

## ----eval=TRUE,fig.width=10, fig.height=5-------------------------------------
# A decision map for Site 54 can be generated using the following script
# Retention time >> first 20 observations are used as a guide set
DecisionMap(data,method="XmR",peptideThresholdRed = 0.25,peptideThresholdYellow = 0.10,
                         L = 1, U = 20,type = "mean",title = "Decision map",listMean = NULL,listSD = NULL)

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
mydata<-DataProcess(MSstatsQC::QCloudDDA)
#Creating a missing data map
MissingDataMap(mydata)
XmRChart(mydata, "EACFAVEGPK", metric = "missing", type="mean", L = 1, U = 15)
mydata<-RemoveMissing(mydata)
RiverPlot(mydata[,-9], L=1, U=15, method="XmR")
RadarPlot(mydata[,-9], L=1, U=15, method="XmR")

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
mydata<-DataProcess(MSstatsQC::QCloudDDA)
#Creating a missing data map
MissingDataMap(mydata)

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
#Creating an X chart for missing counts
XmRChart(mydata, "EACFAVEGPK", metric = "missing", type="mean", L = 1, U = 15)

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
#Removing missing values and analyzing the data
mydata<-RemoveMissing(mydata)
RiverPlot(mydata[,-9], L=1, U=15, method="XmR")
RadarPlot(mydata[,-9], L=1, U=15, method="XmR")

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
#Checking missing values and analyzing the data
MissingDataMap(MSstatsQC::QuiCDIA)
RiverPlot(data = QuiCDIA, L = 1, U = 20, method = "XmR")
RadarPlot(data = QuiCDIA, L = 1, U = 20, method = "XmR")

## ----eval=TRUE, fig.width=8, fig.height=5-------------------------------------
#Checking missing values and analyzing the data
MissingDataMap(MSstatsQC::QCloudSRM)
RiverPlot(data = QCloudSRM, L = 1, U = 20, method = "CUSUM")
RadarPlot(data = QCloudSRM, L = 1, U = 20, method = "CUSUM")

## ----eval=FALSE---------------------------------------------------------------
# #Saving plots generated by plotly
# p<-XmRChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "BestRetentionTime", normalization = FALSE,
#                       ytitle = "X Chart : retention time", type = "mean", selectMean = NULL, selectSD = NULL )
# htmlwidgets::saveWidget(p, "Aplot.html")
# export(p, file = "Aplot.png")
# 
# #Saving plots generated by ggplot2
# p<-RiverPlot(data, L=1, U=20)
# ggsave(filename="Summary.pdf", plot=p)
# #or
# ggsave(filename="Summary.png", plot=p)

## ----si-----------------------------------------------------------------------
sessionInfo()

