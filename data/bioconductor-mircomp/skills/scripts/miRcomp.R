# Code example from 'miRcomp' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width=12, fig.height=8, 
                      warning=FALSE, message=FALSE)

## ----load_miRcomp-------------------------------------------------------------
## Load libraries
library('miRcomp')

## ----load_example_data--------------------------------------------------------
data(lifetech)
data(qpcRdefault)

## ----data_str-----------------------------------------------------------------
str(lifetech)
str(qpcRdefault)

## ----colnames-----------------------------------------------------------------
colnames(lifetech$ct)

## ----quality_scatter----------------------------------------------------------
qualityAssessment(lifetech, plotType="scatter", label1="LifeTech AmpScore")

## ----quality_boxplot----------------------------------------------------------
qualityAssessment(lifetech, plotType="boxplot", label1="LifeTech AmpScore")

## ----quality_scatter2---------------------------------------------------------
qualityAssessment(lifetech, object2=qpcRdefault, cloglog2=TRUE, plotType="scatter", label1="LifeTech AmpScore", label2="qpcR R-squared")

## ----quality_boxplot_na-------------------------------------------------------
qualityAssessment(lifetech, plotType="boxplot", na.rm=TRUE, label1="LifeTech AmpScore")

## ----complete_features--------------------------------------------------------
completeFeatures(lifetech, qcThreshold1=1.25, label1="LifeTech")

## ----complete_features2-------------------------------------------------------
completeFeatures(lifetech, qcThreshold1=1.25, object2=qpcRdefault, qcThreshold2=0.99, label1="LifeTech", label2="qpcR")

## ----complete_features3-------------------------------------------------------
completeFeatures(lifetech, qcThreshold1=1.25, object2=lifetech, qcThreshold2=1.4, label1="LT 1.25", label2="LT 1.4")

## ----limit_detect_boxplot-----------------------------------------------------
par(mar=c(6,6,2,2))
boxes <- limitOfDetection(lifetech, qcThreshold=1.25, plotType="boxplot")
str(boxes)

## ----limit_detect_scatter-----------------------------------------------------
par(mfrow=c(1,3))
lods <- limitOfDetection(lifetech, qcThreshold=1.25, plotType="scatter")

## ----limit_detect_maplot------------------------------------------------------
par(mfrow=c(1,3))
lods <- limitOfDetection(lifetech, qcThreshold=1.25, plotType="MAplot")
print(round(lods,digits=2))

## ----titration_response-------------------------------------------------------
titrationResponse(lifetech, qcThreshold1=1.25)

## ----titration_response2------------------------------------------------------
titrationResponse(lifetech, qcThreshold1=1.25, object2=qpcRdefault, qcThreshold2=0.99, label1="LifeTech", label2="qpcR")

## ----titration_response3------------------------------------------------------
titrationResponse(lifetech, qcThreshold1=1.25, object2=qpcRdefault, qcThreshold2=0.99, commonFeatures=FALSE, label1="LifeTech", label2="qpcR")

## ----titration_response4------------------------------------------------------
titrationResponse(lifetech, qcThreshold1=1.25, object2=lifetech, qcThreshold2=1.4, commonFeatures=FALSE, label1="AmpScore 1.25", label2="AmpScore 1.4")

## ----accuracy-----------------------------------------------------------------
accuracy(lifetech, qcThreshold1=1.25)

## ----accuracy2----------------------------------------------------------------
accuracy(lifetech, qcThreshold1=1.25, object2=qpcRdefault, qcThreshold2=0.99, label1="LifeTech", label2="qpcR")

## ----accuracy3----------------------------------------------------------------
accuracy(lifetech, qcThreshold1=1.25, object2=qpcRdefault, qcThreshold2=0.99, commonFeatures=FALSE, label1="LifeTech", label2="qpcR")

## ----accuracy4----------------------------------------------------------------
accuracy(lifetech, qcThreshold1=1.25, object2=lifetech, qcThreshold2=1.4, commonFeatures=FALSE, label1="AmpScore 1.25", label2="AmpScore 1.4")

## ----precision_sd-------------------------------------------------------------
boxes <- precision(lifetech, qcThreshold1=1.25, statistic="sd")
str(boxes)

## ----precision_cv-------------------------------------------------------------
boxes <- precision(lifetech, qcThreshold1=1.25, statistic="cv", bins=4)
str(boxes)

## ----precision_sd2------------------------------------------------------------
boxes <- precision(lifetech, qcThreshold1=1.25, object2=qpcRdefault, qcThreshold2=0.99, scale="log", label1="LifeTech", label2="qpcR")
str(boxes)

## ----precision_cv2------------------------------------------------------------
boxes <- precision(lifetech, qcThreshold1=1.25, object2=qpcRdefault, qcThreshold2=0.99, statistic="cv", scale="log10", label1="LifeTech", label2="qpcR")
str(boxes)

## ----precision_cv3------------------------------------------------------------
boxes <- precision(lifetech, qcThreshold1=1.25, object2=qpcRdefault, qcThreshold2=0.99, commonFeatures=FALSE, statistic="cv", scale="log10", label1="LifeTech", label2="qpcR")
str(boxes)

## ----precision_cv4------------------------------------------------------------
boxes <- precision(lifetech, qcThreshold1=1.25, object2=lifetech, qcThreshold2=1.4, commonFeatures=FALSE, statistic="cv", scale="log10", label1="AmpScore 1.25", label2="AmpScore 1.4")
str(boxes)

## ----load_raw_data------------------------------------------------------------
library(miRcompData)
data(miRcompData)

## ----show_raw_data------------------------------------------------------------
str(miRcompData)

## ----session_info-------------------------------------------------------------
sessionInfo()

