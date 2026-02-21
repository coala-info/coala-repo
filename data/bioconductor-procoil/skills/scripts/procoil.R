# Code example from 'procoil' vignette. See references/ for full tutorial.

## ----LoadPackageToDetermineVersion,echo=FALSE,message=FALSE,results='hide'----
options(width=72)
knitr::opts_knit$set(width=72)
set.seed(0)
library(procoil, quietly=TRUE)
procoilVersion <- packageDescription("procoil")$Version
procoilDateRaw <- packageDescription("procoil")$Date
procoilDateYear <- as.numeric(substr(procoilDateRaw, 1, 4))
procoilDateMonth <- as.numeric(substr(procoilDateRaw, 6, 7))
procoilDateDay <- as.numeric(substr(procoilDateRaw, 9, 10))
procoilDate <- paste(month.name[procoilDateMonth], " ",
                     procoilDateDay, ", ",
                     procoilDateYear, sep="")

## ----InstallPrOCoil,eval=FALSE----------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("procoil")

## ----LoadPrOCoil,eval=FALSE-------------------------------------------
# library(procoil)

## ----PredictGCN4WildType----------------------------------------------
GCN4wt <- predict(PrOCoilModel,
                  "MKQLEDKVEELLSKNYHLENEVARLKKLV",
                  "abcdefgabcdefgabcdefgabcdefga")

## ----DisplayResultForGCN4WildType-------------------------------------
GCN4wt

## ----PlotResultForGCN4WildType,fig.width=7,fig.height=5,out.width='0.6\\textwidth'----
plot(GCN4wt)

## ----PredictMarcoilExample--------------------------------------------
res <- predict(PrOCoilModel,
"MGECDQLLVFMITSRVLVLSTLIIMDSRQVYLENLRQFAENLRQNIENVHSFLENLRADLENLRQKFPGKWYSAMPGRHG",
"-------------------------------abcdefgabcdefgabcdefgabcdefgabcdefg--------------")

## ----DisplayResultForMarcoilExample-----------------------------------
res

## ----PlotResultForMarcoilExample,fig.width=8,fig.height=5,out.width='0.7\\textwidth'----
plot(res[1])

## ----PredictGCN4Mutation----------------------------------------------
GCN4mSeq <- c("GCN4wt"        ="MKQLEDKVEELLSKNYHLENEVARLKKLV",
              "GCN4_N16Y_L19T"="MKQLEDKVEELLSKYYHTENEVARLKKLV",
              "GCN4_E22R_K27E"="MKQLEDKVEELLSKNYHLENRVARLEKLV",
              "GCN4_V23K_K27E"="MKQLEDKVEELLSKNYHLENEKARLEKLV")
GCN4mReg <- rep("abcdefgabcdefgabcdefgabcdefga", 4)

GCN4mut <- predict(PrOCoilModel, GCN4mSeq, GCN4mReg)
GCN4mut

## ----PlotGCN4Mutation,fig.width=7,fig.height=5,out.width='0.6\\textwidth'----
plot(GCN4mut[c(1, 2)])
plot(GCN4mut[c(1, 3)])
plot(GCN4mut[c(1, 4)])

## ----HeatmapGCN4Mutation,fig.width=8,fig.height=4.5,out.width='0.9\\textwidth'----
heatmap(GCN4mut)

## ----PlotResultForExampleWithHeptadIrregularity,fig.width=7,fig.height=5,out.width='0.6\\textwidth'----
plot(predict(PrOCoilModel,
             "LQDTLVRQERPIRKSIEDLRNTV",
             "defgabcdefgabcdabcdefga"))

## ----ReadModelFile,eval=FALSE-----------------------------------------
# URL <- "http://www.bioinf.jku.at/software/procoil/PrOCoilModel_v2.CCModel"
# myModel <- readCCModel(URL)

## ----CustomPlot,fig.width=7,fig.height=5,out.width='0.6\\textwidth'----
plot(GCN4mut[c(1, 2)], legend=c("wild type", "mutant N16Y,L19T"),
     col=c(rgb(0.7, 0, 0), rgb(0, 0, 0.8)), main="GCN4 Mutation Analysis",
     shades=c(rgb(0.77, 0.85, 0.95), rgb(0.99, 0.84, 0.71)))

## ----PlotProfileToGraphicsFile,eval=FALSE-----------------------------
# pdf(file="GCN4wt.pdf", height=6,
#     width=max(nchar(sequences(GCN4wt))) * 6 / 24)
# plot(GCN4wt)
# dev.off()
# 
# bmp(file="GCN4wt.bmp", height=480,
#     width=max(nchar(sequences(GCN4wt))) * 480 / 24)
# plot(GCN4wt)
# dev.off()

## ----GCN4CharacterExampleWithAttribute--------------------------------
GCN4wtSeq1 <- "MKQLEDKVEELLSKNYHLENEVARLKKLV"
attr(GCN4wtSeq1, "reg") <- "abcdefgabcdefgabcdefgabcdefga"
res <- predict(PrOCoilModel, GCN4wtSeq1)

## ----GCN4AAStringExampleWithMetadata----------------------------------
GCN4wtSeq2 <- AAString("MKQLEDKVEELLSKNYHLENEVARLKKLV")
metadata(GCN4wtSeq2)$reg <- "abcdefgabcdefgabcdefgabcdefga"
res <- predict(PrOCoilModel, GCN4wtSeq2)

## ----GCN4AAStringSetExampleWithAnnotationMetadata---------------------
GCN4mSeq2 <- AAStringSet(GCN4mSeq)
annotationMetadata(GCN4mSeq2, annCharset="abcdefg") <- GCN4mReg
res <- predict(PrOCoilModel, GCN4mSeq2)

## ----DisplayModels----------------------------------------------------
PrOCoilModel
weights(PrOCoilModel)["N..La..d"]
PrOCoilModelBA
weights(PrOCoilModelBA)["N..La..d"]

## ----DisplayWeights---------------------------------------------------
noP <- length(weights(PrOCoilModel))
names(weights(PrOCoilModel))[1:25]
names(weights(PrOCoilModel))[noP:(noP - 24)]

## ----DisplayBibTeXReference,eval=FALSE--------------------------------
# toBibtex(citation("procoil"))

