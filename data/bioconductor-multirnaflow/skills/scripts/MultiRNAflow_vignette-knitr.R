# Code example from 'MultiRNAflow_vignette-knitr' vignette. See references/ for full tutorial.

## ----styleSweave, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex(use.unsrturl=TRUE)

## ----include=FALSE---------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance=TRUE
)

## ----options, echo=FALSE---------------------------------------------------
options(prompt=" ", continue=" ")

## ----CranPck, eval=TRUE, echo=TRUE-----------------------------------------
Cran.pck <- c("reshape2", "ggplot2", "ggrepel", "ggalluvial",
              "FactoMineR", "factoextra",
              "plot3D", "plot3Drgl", "ggplotify", "UpSetR", "gprofiler2")

## ----installCranPck, eval=FALSE, echo=TRUE---------------------------------
# Select.package.CRAN <- "FactoMineR"
# if (!require(package=Select.package.CRAN,
#              quietly=TRUE, character.only=TRUE, warn.conflicts=FALSE)) {
#     install.packages(pkgs=Select.package.CRAN, dependencies=TRUE)
# }# if(!require(package=Cran.pck[i], quietly=TRUE, character.only=TRUE))

## ----BioconductorPck, eval=TRUE, echo=TRUE---------------------------------
Bioconductor.pck <- c("SummarizedExperiment", "S4Vectors", "DESeq2",
                      "Mfuzz", "ComplexHeatmap")

## ----BiocManagerPck, eval=FALSE, echo=TRUE---------------------------------
# if (!require(package="BiocManager",
#              quietly=TRUE, character.only=TRUE, warn.conflicts=FALSE)) {
#     install.packages("BiocManager")
# }# if(!require(package="BiocManager", quietly=TRUE, character.only=TRUE))

## ----BiocconductorVersion, eval=FALSE, echo=TRUE---------------------------
# BiocManager::install(version="3.18")

## ----installBioconductorpck, eval=FALSE, echo=TRUE-------------------------
# Select.package.Bioc <- "DESeq2"
# if(!require(package=Select.package.Bioc,
#             quietly=TRUE, character.only=TRUE, warn.conflicts=FALSE)){
#   BiocManager::install(pkgs=Select.package.Bioc)
# }## if(!require(package=Select.package.Bioc, quietly=TRUE, character.only=TRUE))

## ----library, eval=TRUE, echo=TRUE-----------------------------------------
library(MultiRNAflow)

## ----LoadMus1, echo=TRUE, eval=TRUE----------------------------------------
data("RawCounts_Antoszewski2022_MOUSEsub500")

## ----LoadFission, echo=TRUE, eval=TRUE-------------------------------------
data("RawCounts_Leong2014_FISSIONsub500wt")

## ----LoadLeuk, echo=TRUE, eval=TRUE----------------------------------------
data("RawCounts_Schleiss2021_CLLsub500")

## ----LoadMus2, echo=TRUE, eval=TRUE----------------------------------------
data("RawCounts_Weger2021_MOUSEsub500")

## ----ColnamesExample, echo=TRUE, eval=TRUE---------------------------------
data("RawCounts_Leong2014_FISSIONsub500wt")
colnames(RawCounts_Leong2014_FISSIONsub500wt)

## ----ExampleParametersData, echo=FALSE, eval=TRUE--------------------------
data("RawCounts_Leong2014_FISSIONsub500wt")

## ----ExampleParameters, echo=TRUE, eval=TRUE-------------------------------
resSEexample <- DATAprepSE(RawCounts=RawCounts_Leong2014_FISSIONsub500wt,
                           Column.gene=1,
                           Group.position=NULL,
                           Time.position=2,
                           Individual.position=3)

## ----DATAprepSEleuk, eval=TRUE---------------------------------------------
SEresleuk500 <- DATAprepSE(RawCounts=RawCounts_Schleiss2021_CLLsub500,
                           Column.gene=1,
                           Group.position=2,
                           Time.position=4,
                           Individual.position=3,
                           VARfilter=0,
                           SUMfilter=0,
                           RNAlength=NULL)

## ----DATAprepSEleuk_res, eval=TRUE-----------------------------------------
names(S4Vectors::metadata(SEresleuk500))
str(S4Vectors::metadata(SEresleuk500)$Results)

## ----NormalizationLeukemia, eval=TRUE--------------------------------------
SEresNORMleuk500 <- DATAnormalization(SEres=SEresleuk500,
                                      Normalization="vst",
                                      Blind.rlog.vst=FALSE,
                                      Plot.Boxplot=FALSE,
                                      Colored.By.Factors=TRUE,
                                      Color.Group=NULL,
                                      path.result=NULL)

## ----NormalizationLeukemia_res, eval=TRUE----------------------------------
## Save 'Results' of the metadata in an object
resleuk500 <- S4Vectors::metadata(SEresNORMleuk500)$Results

## Save the results of Normalization in an object
resNORMleuk500 <- resleuk500[[1]][[1]]
###
names(S4Vectors::metadata(SEresNORMleuk500))
str(resleuk500, max.level=2)

## ----NormalizationLeukemia_metadata, eval=TRUE-----------------------------
resNORMleuk500$normMethod
print(resNORMleuk500$normBoxplot)

## ----NormalizationLeukemia_data, eval=TRUE---------------------------------
normData <- SummarizedExperiment::assays(SEresNORMleuk500)
names(SummarizedExperiment::assays(SEresNORMleuk500))

## ----NormalizationCLLcolor, eval=TRUE--------------------------------------
colorLeuk <- data.frame(Name=c("NP", "P"),
                        Col=c("black", "red"))

## ----PCALeukemia, warning=FALSE, message=FALSE, eval=TRUE------------------
SEresPCALeuk500 <- PCAanalysis(SEresNorm=SEresNORMleuk500,
                               gene.deletion=NULL,
                               sample.deletion=NULL,
                               Plot.PCA=FALSE,
                               Mean.Accross.Time=FALSE,
                               Color.Group=NULL,
                               Cex.label=0.9, Cex.point=0.8, epsilon=0.2,
                               Phi=25, Theta=140,
                               motion3D=FALSE,
                               path.result=NULL, Name.folder.pca=NULL)

## ----PCALeukemia_res, warning=FALSE, message=FALSE, eval=TRUE--------------
## Save 'Results' of the metadata in an object
resleuk500 <- S4Vectors::metadata(SEresPCALeuk500)$Results

## Save the results of normalization in an object
resPCALeuk500 <- resleuk500[[1]][[2]]
###
names(S4Vectors::metadata(SEresPCALeuk500))
str(resleuk500, max.level=2, give.attr=FALSE)
names(resPCALeuk500)

## ----NormalizationLeukemia_PCA2d_temporalLinks, eval=TRUE------------------
print(resPCALeuk500$PCA_2DtemporalLinks)

## ----NormalizationLeukemia_PCA3d_temporalLinks, eval=TRUE------------------
print(resPCALeuk500$PCA_3DtemporalLinks)

## ----NormalizationLeukemia_PCA3d_temporalLinks_P, eval=TRUE----------------
print(resPCALeuk500$PCA_BiologicalCondition_P$PCA_3DtemporalLinks)

## ----PCAleukColor, warning=FALSE, message=FALSE, eval=TRUE-----------------
colorLeuk <- data.frame(Name=c("NP","P"),
                        Col=c("black","red"))

## ----HCPCleukemia, warning=FALSE, message=FALSE, eval=TRUE-----------------
SEresHCPCLeuk500 <- HCPCanalysis(SEresNorm=SEresPCALeuk500,
                                 gene.deletion=NULL,
                                 sample.deletion=NULL,
                                 Plot.HCPC=FALSE,
                                 Phi=25,Theta=140,
                                 Cex.point=0.7,
                                 epsilon=0.2,
                                 Cex.label=0.9,
                                 motion3D=FALSE,
                                 path.result=NULL,
                                 Name.folder.hcpc=NULL)

## ----HCPCleukemia_res, warning=FALSE, message=FALSE, eval=TRUE-------------
## Save 'Results' of the metadata in an object
resleuk500 <- S4Vectors::metadata(SEresHCPCLeuk500)$Results

## Save the results of HCPC in an object
resHCPCLeuk500 <- resleuk500[[1]][[3]]
###
names(S4Vectors::metadata(SEresHCPCLeuk500))
str(resleuk500, max.level=2, give.attr=FALSE)
names(resHCPCLeuk500)

## ----NormalizationLeukemia_Dendrogram, eval=TRUE---------------------------
print(resHCPCLeuk500$Dendrogram)

## ----NormalizationLeukemia_SampleDistribution, eval=TRUE-------------------
print(resHCPCLeuk500$Cluster_SampleDistribution)

## ----NormalizationLeukemia_PCA3d_HCPC, eval=TRUE---------------------------
print(resHCPCLeuk500$PCA3DclustersHCPC)

## ----MfuzzLeuk, warning=FALSE, message=FALSE, eval=TRUE--------------------
SEresMfuzzLeuk500 <- MFUZZanalysis(SEresNorm=SEresHCPCLeuk500,
                                   DataNumberCluster=NULL,
                                   Method="hcpc",
                                   Membership=0.7,
                                   Min.std=0.1,
                                   Plot.Mfuzz=FALSE,
                                   path.result=NULL,
                                   Name.folder.mfuzz=NULL)

## ----MFUZZleukemia_res, warning=FALSE, message=FALSE, eval=TRUE------------
## Save 'Results' of the metadata in an object
resleuk500 <- S4Vectors::metadata(SEresMfuzzLeuk500)$Results

## Save the results of Mfuzz in an object
resMfuzzLeuk500 <- resleuk500[[1]][[4]]
###
names(S4Vectors::metadata(SEresMfuzzLeuk500))
str(resleuk500, max.level=2, give.attr=FALSE)
names(resMfuzzLeuk500)

## ----MfuzzLeukemia_ClusterPlot, eval=TRUE----------------------------------
print(resMfuzzLeuk500$ClustersNumbers)

## ----MfuzzLeukemia_Mfuzz_P, eval=TRUE--------------------------------------
print(resMfuzzLeuk500$Mfuzz.Plots.Group_P)

## ----DATAplotExpressionGenesLeukemia, warning=FALSE, message=FALSE, eval=TRUE----
SEresEVOleuk500 <- DATAplotExpressionGenes(SEresNorm=SEresMfuzzLeuk500,
                                           Vector.row.gene=c(25, 30),
                                           Color.Group=NULL,
                                           Plot.Expression=FALSE,
                                           path.result=NULL,
                                           Name.folder.profile=NULL)

## ----DEleukemia_res, warning=FALSE, message=FALSE, eval=TRUE---------------
## Save 'Results' of the metadata in an object
resleuk500 <- S4Vectors::metadata(SEresEVOleuk500)$Results

## Save the results of DE analysis in an object
resEVOleuk500 <- resleuk500[[1]][[5]]
###
names(S4Vectors::metadata(SEresEVOleuk500))
str(resleuk500, max.level=2, give.attr=FALSE)
names(resEVOleuk500)

## ----MfuzzLeukemia_Profile1gene, eval=TRUE---------------------------------
print(resEVOleuk500$ARL4C_profile)

## ----ProfileCLLcolor, warning=FALSE, message=FALSE, eval=TRUE--------------
colorLeuk <- data.frame(Name=c("NP", "P"), Col=c("black", "red"))

## ----DELeuk, warning=FALSE, message=FALSE, eval=TRUE-----------------------
SEresDELeuk500 <- DEanalysisGlobal(SEres=SEresEVOleuk500,
                                   pval.min=0.05,
                                   pval.vect.t=NULL,
                                   log.FC.min=1,
                                   LRT.supp.info=FALSE,
                                   Plot.DE.graph=FALSE,
                                   path.result=NULL,
                                   Name.folder.DE=NULL)

## data("Results_DEanalysis_sub500")
## SEresDELeuk500 <- Results_DEanalysis_sub500$DE_Schleiss2021_CLLsub500

## ----DEresultsLeukemia, warning=FALSE, message=FALSE, eval=TRUE------------
DEsummaryLeuk <- SummarizedExperiment::rowData(SEresDELeuk500)

## ----GlossaryLeukemia, warning=FALSE, message=FALSE, eval=TRUE-------------
resDELeuk500 <- S4Vectors::metadata(SEresDELeuk500)$Results[[2]][[2]]
resGlossaryLeuk <- resDELeuk500$Glossary

## ----DEleukAlluvium, warning=FALSE, message=FALSE, eval=TRUE---------------
print(resDELeuk500$DEplots_TimePerGroup$Alluvial.graph.Group_P)

## ----DEleukLineTemporalGroup, warning=FALSE, message=FALSE, eval=TRUE------
print(resDELeuk500$DEplots_TimePerGroup$NumberDEgenes.acrossTime.perTemporalGroup.Group_P)

## ----DEleukUpDownBarplot, warning=FALSE, message=FALSE, eval=TRUE----------
print(resDELeuk500$DEplots_TimePerGroup$NumberDEgenes_UpDownRegulated_perTimeperGroup)

## ----DEleukVennBarplot, warning=FALSE, message=FALSE, eval=TRUE------------
print(resDELeuk500$DEplots_TimePerGroup$VennBarplot.withNumberUpRegulated.Group_P)

## ----DEleukAlluvium1tmin, warning=FALSE, message=FALSE, eval=TRUE----------
print(resDELeuk500$DEplots_TimePerGroup$AlluvialGraph_DE.1tmin_perGroup)

## ----DEleukSpecificBarplot, warning=FALSE, message=FALSE, eval=TRUE--------
print(resDELeuk500$DEplots_GroupPerTime$NumberSpecificGenes_UpDownRegulated_perBiologicalCondition)

## ----DEleukSignatureBarplot, warning=FALSE, message=FALSE, eval=TRUE-------
print(resDELeuk500$DEplots_TimeAndGroup$Number_DEgenes_SignatureGenes_UpDownRegulated_perTimeperGroup)

## ----DEleukSummaryDE, warning=FALSE, message=FALSE, eval=TRUE--------------
print(resDELeuk500$DEplots_TimeAndGroup$Number_DEgenes1TimeMinimum_Specific1TimeMinimum_Signature1TimeMinimum_perBiologicalCondition)

## ----VolcanoMA_CLL, warning=FALSE, message=FALSE, eval=TRUE----------------
SEresVolcanoMAleuk <- DEplotVolcanoMA(SEresDE=SEresDELeuk500,
                                      NbGene.plotted=2,
                                      SizeLabel=3,
                                      Display.plots=FALSE,
                                      Save.plots=FALSE)

## ----Volcanoleukemia_res, warning=FALSE, message=FALSE, eval=TRUE----------
## Save 'Results' of the metadata in an object
resleuk500 <- S4Vectors::metadata(SEresVolcanoMAleuk)$Results

## Save the results of DEplotVolcanoMA in an object
resVolMAleuk500 <- resleuk500[[2]][[3]]
###
names(S4Vectors::metadata(SEresVolcanoMAleuk))
str(resleuk500, max.level=2, give.attr=FALSE)
names(resVolMAleuk500)

## ----Leuk_namesVolcanoMA, eval=TRUE----------------------------------------
str(resVolMAleuk500$Volcano, max.level=1, give.attr=FALSE)

## ----Leuk_VolcanoP_t2t0, eval=TRUE-----------------------------------------
print(resVolMAleuk500$Volcano$P$P_t2_vs_t0)

## ----Leuk_MA_P_t2t0, eval=TRUE---------------------------------------------
print(resVolMAleuk500$MA$P$P_t2_vs_t0)

## ----Heatmaps_CCL, warning=FALSE, message=FALSE, eval=TRUE-----------------
SEresHeatmapLeuk <- DEplotHeatmaps(SEresDE=SEresVolcanoMAleuk,
                                   ColumnsCriteria=c(18, 19),
                                   Set.Operation="union",
                                   NbGene.analysis=20,
                                   SizeLabelRows=5,
                                   SizeLabelCols=5,
                                   Display.plots=FALSE,
                                   Save.plots=FALSE)

## ----Heatmapleukemia_res, warning=FALSE, message=FALSE, eval=TRUE----------
## Save 'Results' of the metadata in an object
resleuk500 <- S4Vectors::metadata(SEresHeatmapLeuk)$Results

## Save the results of DEplotHeatmaps in an object
resHeatmapLeuk <- resleuk500[[2]][[4]]
###
names(S4Vectors::metadata(SEresHeatmapLeuk))
str(resleuk500, max.level=2, give.attr=FALSE)
names(resHeatmapLeuk)

## ----Leuk_Heatmaps, eval=TRUE----------------------------------------------
print(resHeatmapLeuk$Heatmap_Correlation)
print(resHeatmapLeuk$Heatmap_Zscore)

## ----GSEAquickAnalysis_CLL, warning=FALSE, message=FALSE, eval=TRUE--------
SEresgprofiler2Leuk <- GSEAQuickAnalysis(Internet.Connection=FALSE,
                                         SEresDE=SEresHeatmapLeuk,
                                         ColumnsCriteria=c(18),
                                         ColumnsLog2ordered=NULL,
                                         Set.Operation="union",
                                         Organism="hsapiens",
                                         MaxNumberGO=20,
                                         Background=FALSE,
                                         Display.plots=FALSE,
                                         Save.plots=FALSE)
##
## head(SEresgprofiler2Leuk$GSEAresults)

## ----GSEAprepro_CLL, warning=FALSE, message=FALSE, eval=TRUE---------------
SEresPreprocessingLeuk <- GSEApreprocessing(SEresDE=SEresDELeuk500,
                                            ColumnsCriteria=c(18, 19),
                                            Set.Operation="union",
                                            Rnk.files=FALSE,
                                            Save.files=FALSE)

## ----DATAprepSEmus1, echo=TRUE, eval=TRUE----------------------------------
SEresPrepMus1 <- DATAprepSE(RawCounts=RawCounts_Antoszewski2022_MOUSEsub500,
                            Column.gene=1,
                            Group.position=1,
                            Time.position=NULL,
                            Individual.position=2)

## ----NormalizationMouse1, echo=TRUE, eval=TRUE-----------------------------
SEresNormMus1 <- DATAnormalization(SEres=SEresPrepMus1,
                                   Normalization="rle",
                                   Blind.rlog.vst=FALSE,
                                   Plot.Boxplot=TRUE,
                                   Colored.By.Factors=TRUE,
                                   Color.Group=NULL,
                                   path.result=NULL)

## ----NormalizationMouseColor, eval=TRUE------------------------------------
colMus1 <- data.frame(Name=c("N1wtT1wt", "N1haT1wt", "N1haT1ko", "N1wtT1ko"),
                      Col=c("black", "red", "green", "blue"))

## ----PCAMouse1, eval=TRUE--------------------------------------------------
SEresPCAMus1 <- PCAanalysis(SEresNorm=SEresNormMus1,
                            sample.deletion=NULL,
                            gene.deletion=NULL,
                            Plot.PCA=TRUE,
                            Mean.Accross.Time=FALSE,
                            Color.Group=NULL,
                            Cex.label=0.8,
                            Cex.point=0.7, epsilon=0.2,
                            Phi=25,Theta=140,
                            motion3D=FALSE,
                            path.result=NULL)

## ----PCAMouseColor, eval=TRUE----------------------------------------------
colMus1 <- data.frame(Name=c("N1wtT1wt", "N1haT1wt", "N1haT1ko", "N1wtT1ko"),
                      Col=c("black", "red", "green", "blue"))
colMus1

## ----HCPCmouse1, warning=FALSE, message=FALSE, eval=TRUE-------------------
SEresHCPCMus1 <- HCPCanalysis(SEresNorm=SEresNormMus1,
                              gene.deletion=NULL,
                              sample.deletion=NULL,
                              Plot.HCPC=FALSE,
                              Cex.label=0.8, Cex.point=0.7, epsilon=0.2,
                              Phi=25, Theta=140,
                              motion3D=FALSE,
                              path.result=NULL)

## ----DATAplotExpressionGenesMouse, warning=FALSE, message=FALSE, eval=TRUE----
resEVOmus1500 <- DATAplotExpressionGenes(SEresNorm=SEresNormMus1,
                                         Vector.row.gene=c(10),
                                         Color.Group=NULL,
                                         Plot.Expression=TRUE,
                                         path.result=NULL)

## ----ProfileMouseColor, warning=FALSE, message=FALSE, eval=TRUE------------
colMus1 <- data.frame(Name=c("N1wtT1wt", "N1haT1wt", "N1haT1ko", "N1wtT1ko"),
                      Col=c("black", "red", "green", "blue"))

## ----DEmouse, warning=FALSE, message=FALSE, eval=TRUE----------------------
SEresDEMus1 <- DEanalysisGlobal(SEres=SEresPrepMus1,
                                pval.min=0.05,
                                pval.vect.t=NULL,
                                log.FC.min=1,
                                LRT.supp.info=FALSE,
                                Plot.DE.graph=FALSE,
                                path.result=NULL,
                                Name.folder.DE=NULL)
## data("Results_DEanalysis_sub500")
## SEresDEMus1 <- Results_DEanalysis_sub500$DE_Antoszewski2022_MOUSEsub500

## ----DEresultsMouse1, warning=FALSE, message=FALSE, eval=TRUE--------------
DEsummaryMus1 <- SummarizedExperiment::rowData(SEresDEMus1)

## ----GlossaryMouse1, warning=FALSE, message=FALSE, eval=TRUE---------------
resDEMus1 <- S4Vectors::metadata(SEresDEMus1)$Results[[2]][[2]]
resGlossaryMus1 <- resDEMus1$Glossary

## ----VennBarplotMouse1, warning=FALSE, message=FALSE, eval=TRUE------------
print(resDEMus1$VennBarplot)

## ----SpecificAndNoSpecificMouse1, warning=FALSE, message=FALSE, eval=TRUE----
print(resDEMus1$NumberDEgenes_SpecificAndNoSpecific)

## ----SpecificGenesMouse1, warning=FALSE, message=FALSE, eval=TRUE----------
print(resDEMus1$NumberDEgenes_SpecificGenes)

## ----VolcanoMAMus1, warning=FALSE, message=FALSE, eval=TRUE----------------
SEresVolcanoMAMus1 <- DEplotVolcanoMA(SEresDE=SEresDEMus1,
                                      NbGene.plotted=2,
                                      SizeLabel=3,
                                      Display.plots=FALSE,
                                      Save.plots=FALSE)

## ----HeatmapsMus1, warning=FALSE, message=FALSE, eval=TRUE-----------------
SEresVolcanoMAMus1 <- DEplotHeatmaps(SEresDE=SEresDEMus1,
                                     ColumnsCriteria=2,#c(2,4),
                                     Set.Operation="union",
                                     NbGene.analysis=20,
                                     SizeLabelRows=5,
                                     SizeLabelCols=5,
                                     Display.plots=FALSE,
                                     Save.plots=FALSE)

## ----GSEAquickAnalysis_Mus, warning=FALSE, message=FALSE, eval=TRUE--------
SEresgprofiler2Mus1 <- GSEAQuickAnalysis(Internet.Connection=FALSE,
                                         SEresDE=SEresDEMus1,
                                         ColumnsCriteria=2,
                                         ColumnsLog2ordered=NULL,
                                         Set.Operation="union",
                                         Organism="mmusculus",
                                         MaxNumberGO=10,
                                         Background=FALSE,
                                         Display.plots=FALSE,
                                         Save.plots=FALSE)
##
## head(4Vectors::metadata(SEresgprofiler2Mus1)$Rgprofiler2$GSEAresults)

## ----GSEAprepro_Mus1, warning=FALSE, message=FALSE, eval=TRUE--------------
SEresPreprocessingMus1 <- GSEApreprocessing(SEresDE=SEresDEMus1,
                                            ColumnsCriteria=2,
                                            Set.Operation="union",
                                            Rnk.files=FALSE,
                                            Save.files=FALSE)

## ----DATAprepSEfission, echo=TRUE, eval=TRUE-------------------------------
SEresPrepFission <- DATAprepSE(RawCounts=RawCounts_Leong2014_FISSIONsub500wt,
                               Column.gene=1,
                               Group.position=NULL,
                               Time.position=2,
                               Individual.position=3)

## ----NormalizationFission, eval=TRUE---------------------------------------
SEresNormYeast <- DATAnormalization(SEres=SEresPrepFission,
                                    Normalization="rlog",
                                    Blind.rlog.vst=FALSE,
                                    Plot.Boxplot=FALSE,
                                    Colored.By.Factors=TRUE,
                                    Color.Group=NULL,
                                    Plot.genes=FALSE,
                                    path.result=NULL)

## ----PCAfission, warning=FALSE, message=FALSE, eval=TRUE-------------------
SEresPCAyeast <- PCAanalysis(SEresNorm=SEresNormYeast,
                             gene.deletion=NULL,
                             sample.deletion=NULL,
                             Plot.PCA=FALSE,
                             Mean.Accross.Time=FALSE,
                             Cex.label=0.8, Cex.point=0.7, epsilon=0.3,
                             Phi=25,Theta=140,
                             motion3D=FALSE,
                             path.result=NULL)

## ----HCPCfission, warning=FALSE, message=FALSE, eval=TRUE------------------
SEresHCPCyeast <- HCPCanalysis(SEresNorm=SEresNormYeast,
                               gene.deletion=NULL,
                               sample.deletion=NULL,
                               Plot.HCPC=FALSE,
                               Cex.label=0.9,
                               Cex.point=0.7,
                               epsilon=0.2,
                               Phi=25,Theta=140,
                               motion3D=FALSE,
                               path.result=NULL)

## ----MfuzzFission, warning=FALSE, message=FALSE, eval=TRUE-----------------
SEresMfuzzYeast <- MFUZZanalysis(SEresNorm=SEresNormYeast,
                                 DataNumberCluster=NULL,
                                 Method="hcpc",
                                 Membership=0.5,
                                 Min.std=0.1,
                                 Plot.Mfuzz=FALSE,
                                 path.result=NULL)

## ----DATAplotExpressionGenesFission, warning=FALSE, message=FALSE, eval=TRUE----
SEresEVOyeast <- DATAplotExpressionGenes(SEresNorm=SEresNormYeast,
                                         Vector.row.gene=c(17),
                                         Plot.Expression=TRUE,
                                         path.result=NULL)

## ----DEanalysisFISSION, warning=FALSE, message=FALSE, eval=TRUE------------
# DEyeastWt <- DEanalysisGlobal(SEres=SEresPrepFission, log.FC.min=1,
#                               pval.min=0.05, pval.vect.t=NULL,
#                               LRT.supp.info=FALSE, Plot.DE.graph =FALSE,
#                               path.result=NULL, Name.folder.DE=NULL)
data("Results_DEanalysis_sub500")
DEyeastWt <- Results_DEanalysis_sub500$DE_Leong2014_FISSIONsub500wt

## ----DEresultsFission, warning=FALSE, message=FALSE, eval=TRUE-------------
DEsummaryFission <- SummarizedExperiment::rowData(DEyeastWt)

## ----GlossaryFission, warning=FALSE, message=FALSE, eval=TRUE--------------
resDEyeast <- S4Vectors::metadata(DEyeastWt)$Results[[2]][[2]]
resGlossaryFission <- resDEyeast$Glossary

## ----VolcanoMA_FISSION, warning=FALSE, message=FALSE, eval=TRUE------------
SEresVolcanoMAFission <- DEplotVolcanoMA(SEresDE=DEyeastWt,
                                         NbGene.plotted=2,
                                         SizeLabel=3,
                                         Display.plots=FALSE,
                                         Save.plots=TRUE)

## ----Heatmaps_FISSION, warning=FALSE, message=FALSE, eval=TRUE-------------
SEresHeatmapFission <- DEplotHeatmaps(SEresDE=DEyeastWt,
                                      ColumnsCriteria=2,
                                      Set.Operation="union",
                                      NbGene.analysis=20,
                                      Color.Group=NULL,
                                      SizeLabelRows=5,
                                      SizeLabelCols=5,
                                      Display.plots=TRUE,
                                      Save.plots=FALSE)

## ----GSEAquickAnalysis_Fission, warning=FALSE, message=FALSE, eval=TRUE----
SEresGprofiler2Fission <- GSEAQuickAnalysis(Internet.Connection=FALSE,
                                            SEresDE=DEyeastWt,
                                            ColumnsCriteria=2,
                                            ColumnsLog2ordered=NULL,
                                            Set.Operation="union",
                                            Organism="spombe",
                                            MaxNumberGO=20,
                                            Background=FALSE,
                                            Display.plots=FALSE,
                                            Save.plots=FALSE)
##
## head(SEresGprofiler2Fission$GSEAresults)

## ----GSEAprepro_Fission, warning=FALSE, message=FALSE, eval=TRUE-----------
SEresPreprocessingYeast <- GSEApreprocessing(SEresDE=DEyeastWt,
                                             ColumnsCriteria=2,
                                             Set.Operation="union",
                                             Rnk.files=FALSE,
                                             Save.files=FALSE)

## ----DATAprepSEmus22, eval=TRUE--------------------------------------------
SEresPrepMus2 <- DATAprepSE(RawCounts=RawCounts_Weger2021_MOUSEsub500,
                            Column.gene=1,
                            Group.position=1,
                            Time.position=2,
                            Individual.position=3)

## ----NormalizationMouse2, eval=TRUE----------------------------------------
SEresNormMus2 <- DATAnormalization(SEres=SEresPrepMus2,
                                   Normalization="vst",
                                   Blind.rlog.vst=FALSE,
                                   Plot.Boxplot=FALSE,
                                   Colored.By.Factors=TRUE,
                                   Color.Group=NULL,
                                   path.result=NULL)

## ----NormalizationMus2color, eval=TRUE-------------------------------------
colMus2 <- data.frame(Name=c("BmKo", "BmWt" ,"CrKo", "CrWt"),
                      Col=c("red", "blue", "orange", "darkgreen"))

## ----PCAMus2, warning=FALSE, message=FALSE, eval=TRUE----------------------
SEresPCAmus2 <- PCAanalysis(SEresNorm=SEresNormMus2,
                            gene.deletion=NULL,
                            sample.deletion=NULL,
                            Plot.PCA=FALSE, motion3D=FALSE,
                            Mean.Accross.Time=FALSE,
                            Color.Group=NULL,
                            Cex.label=0.6, Cex.point=0.7, epsilon=0.2,
                            Phi=25, Theta=140,
                            path.result=NULL,
                            Name.folder.pca=NULL)

## ----PCAmus2color, warning=FALSE, message=FALSE, eval=TRUE-----------------
colMus2 <- data.frame(Name=c("BmKo", "BmWt", "CrKo", "CrWt"),
                      Col=c("red", "blue", "orange", "darkgreen"))

## ----HCPCmus2500, warning=FALSE, message=FALSE, eval=TRUE------------------
SEresHCPCmus2 <- HCPCanalysis(SEresNorm=SEresNormMus2,
                              gene.deletion=NULL,
                              sample.deletion=NULL,
                              Plot.HCPC=FALSE,
                              Phi=25,Theta=140,
                              Cex.point=0.6,
                              epsilon=0.2,
                              Cex.label=0.6,
                              motion3D=FALSE,
                              path.result=NULL,
                              Name.folder.hcpc=NULL)

## ----MfuzzMus2, warning=FALSE, message=FALSE, eval=TRUE--------------------
SEresMfuzzLeuk500 <- MFUZZanalysis(SEresNorm=SEresNormMus2,
                                   DataNumberCluster=NULL,
                                   Method="hcpc",
                                   Membership=0.5,
                                   Min.std=0.1,
                                   Plot.Mfuzz=FALSE,
                                   path.result=NULL, Name.folder.mfuzz=NULL)

## ----DATAplotExpressionGenesMusBmCrKoWt, warning=FALSE, message=FALSE, eval=TRUE----
SEresEVOmus2 <- DATAplotExpressionGenes(SEresNorm=SEresNormMus2,
                                        Vector.row.gene=c(17),
                                        Color.Group=NULL,
                                        Plot.Expression=FALSE,
                                        path.result=NULL)

## ----PreprocessPCAHcpcMusBmCrKoWt, warning=FALSE, message=FALSE, eval=TRUE----
colMus2 <- data.frame(Name=c("BmKo", "BmWt", "CrKo", "CrWt"),
                      Col=c("red", "blue", "orange", "darkgreen"))

## ----UsbMusBmCrKoWt, warning=FALSE, message=FALSE, eval=TRUE---------------
Sub3bc3T <- RawCounts_Weger2021_MOUSEsub500[, seq_len(73)]
SelectTime <- grep("_t0_", colnames(Sub3bc3T))
SelectTime <- c(SelectTime, grep("_t1_", colnames(Sub3bc3T)))
SelectTime <- c(SelectTime, grep("_t2_", colnames(Sub3bc3T)))
Sub3bc3T <- Sub3bc3T[, c(1, SelectTime)]

SEresPrepMus23b3t <- DATAprepSE(RawCounts=Sub3bc3T,
                               Column.gene=1,
                               Group.position=1,
                               Time.position=2,
                               Individual.position=3)

## ----DEMusBmCrKoWt, warning=FALSE, message=FALSE, eval=TRUE----------------
SEresDE3tMus2 <- DEanalysisGlobal(SEres=SEresPrepMus23b3t,
                                  pval.min=0.05,
                                  pval.vect.t=NULL,
                                  log.FC.min=1,
                                  LRT.supp.info=FALSE,
                                  Plot.DE.graph=FALSE,
                                  path.result=NULL, Name.folder.DE=NULL)

## ----DEresultsMus2, warning=FALSE, message=FALSE, eval=TRUE----------------
DEsummaryMus2 <- SummarizedExperiment::rowData(SEresDE3tMus2)

## ----GlossaryMus2, warning=FALSE, message=FALSE, eval=TRUE-----------------
resDEmus2 <- S4Vectors::metadata(SEresDE3tMus2)$Results[[2]][[2]]
resGlossaryMus2 <- resDEmus2$Glossary

## ----DEgenesSpecificgenesMus2, warning=FALSE, message=FALSE, eval=TRUE-----
resDEmus2$DEplots_GroupPerTime$NumberDEgenes_SpecificAndNoSpecific_perBiologicalCondition

## ----SpecificgenesMus2, warning=FALSE, message=FALSE, eval=TRUE------------
resDEmus2$DEplots_GroupPerTime$NumberSpecificGenes_UpDownRegulated_perBiologicalCondition

## ----VennBarplotMus2, warning=FALSE, message=FALSE, eval=TRUE--------------
resDEmus2$DEplots_GroupPerTime$VennBarplot_BiologicalConditions_atTime.t1

## ----AlluvialSpe1minMus2, warning=FALSE, message=FALSE, eval=TRUE----------
resDEmus2$DEplots_GroupPerTime$AlluvialGraph_SpecificGenes1tmin_perBiologicalCondition

## ----AlluvialSignature1min, warning=FALSE, message=FALSE, eval=TRUE--------
print(resDEmus2$DEplots_TimeAndGroup$Alluvial_SignatureGenes_1TimeMinimum_perGroup)

## ----VolcanoMA_Mouse2, warning=FALSE, message=FALSE, eval=TRUE-------------
SEresVolcanoMAmus2 <- DEplotVolcanoMA(SEresDE=SEresDE3tMus2,
                                      NbGene.plotted=2,
                                      SizeLabel=3,
                                      Display.plots=FALSE,
                                      Save.plots=FALSE)

## ----Heatmaps_Mouse2, warning=FALSE, message=FALSE, eval=TRUE--------------
SEresHeatmapMus2 <- DEplotHeatmaps(SEresDE=SEresDE3tMus2,
                                   ColumnsCriteria=2:5,
                                   Set.Operation="union",
                                   NbGene.analysis=20,
                                   SizeLabelRows=5,
                                   SizeLabelCols=5,
                                   Display.plots=FALSE,
                                   Save.plots=FALSE)

## ----GSEAquickAnalysis_Mouse2, warning=FALSE, message=FALSE, eval=TRUE-----
SEresGprofiler2Mus2 <- GSEAQuickAnalysis(Internet.Connection=FALSE,
                                         SEresDE=SEresDE3tMus2,
                                         ColumnsCriteria=2:5,
                                         ColumnsLog2ordered=NULL,
                                         Set.Operation="union",
                                         Organism="mmusculus",
                                         MaxNumberGO=20,
                                         Background=FALSE,
                                         Display.plots=FALSE,
                                         Save.plots=FALSE)
##
## head(SEresGprofiler2Mus2$GSEAresults)

## ----GSEAprepro_Mouse2, warning=FALSE, message=FALSE, eval=TRUE------------
SEresPreprocessingMus2 <- GSEApreprocessing(SEresDE=SEresDE3tMus2,
                                            ColumnsCriteria=2:5,
                                            Set.Operation="union",
                                            Rnk.files=FALSE,
                                            Save.files=TRUE)

## ----sessionInfo, echo=FALSE, results="asis"-------------------------------
utils::toLatex(sessionInfo())

