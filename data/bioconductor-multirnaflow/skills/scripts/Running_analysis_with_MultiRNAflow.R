# Code example from 'Running_analysis_with_MultiRNAflow' vignette. See references/ for full tutorial.

## ----setup, include = FALSE, results="hide"-----------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  tidy = FALSE,
  cache = FALSE,
  #dev = "cairo_pdf",
  message = FALSE, error = FALSE, warning = FALSE
)

## ----library, warning=FALSE, message=FALSE------------------------------------
library(MultiRNAflow)

## ----DataWeger2021------------------------------------------------------------
data("RawCounts_Weger2021_MOUSEsub500")

## ----ColnamesDataWeger2021----------------------------------------------------
head(colnames(RawCounts_Weger2021_MOUSEsub500), n=5)

## ----PreprocessingMouse2, eval=TRUE-------------------------------------------
resDATAprepSE <- DATAprepSE(RawCounts=RawCounts_Weger2021_MOUSEsub500,
                            Column.gene=1,
                            Group.position=1,
                            Time.position=2,
                            Individual.position=3)

## ----NormalizationMouse2, eval=TRUE-------------------------------------------
resNorm <- DATAnormalization(SEres=resDATAprepSE,
                             Normalization="vst",
                             Blind.rlog.vst=FALSE,
                             Plot.Boxplot=FALSE,
                             Colored.By.Factors=TRUE,
                             Color.Group=NULL,
                             path.result=NULL)

## ----PCAMus2, eval=TRUE-------------------------------------------------------
resPCA <- PCAanalysis(SEresNorm=resNorm,
                      DATAnorm=TRUE,
                      gene.deletion=NULL,
                      sample.deletion=NULL,
                      Plot.PCA=FALSE,
                      Mean.Accross.Time=FALSE,
                      Color.Group=NULL,
                      Cex.label=0.6,
                      Cex.point=0.7, epsilon=0.2,
                      Phi=25,Theta=140,
                      motion3D=FALSE,
                      path.result=NULL)

## ----HCPCmus2500, warning=FALSE, message=FALSE, eval=TRUE---------------------
resHCPC <- HCPCanalysis(SEresNorm=resNorm,
                        DATAnorm=TRUE,
                        gene.deletion=NULL,
                        sample.deletion=NULL,
                        Plot.HCPC=FALSE,
                        Phi=25,Theta=140,
                        Cex.point=0.6,
                        epsilon=0.2,
                        Cex.label=0.6,
                        motion3D=FALSE,
                        path.result=NULL)

## ----MfuzzMus2, eval=TRUE, results='hide', fig.show='hide'--------------------
resMFUZZ <- MFUZZanalysis(SEresNorm=resNorm,
                          DATAnorm=TRUE,
                          DataNumberCluster=NULL,
                          Method="hcpc",
                          Membership=0.5,
                          Min.std=0.1,
                          Plot.Mfuzz=FALSE,
                          path.result=NULL)

## ----DATAprofileGenesMusBmCrKoWt, eval=TRUE, results='hide', fig.show='hide'----
resEXPR <- DATAplotExpressionGenes(SEresNorm=resNorm,
                                   DATAnorm=TRUE,
                                   Vector.row.gene=c(17),
                                   Color.Group=NULL,
                                   Plot.Expression=FALSE,
                                   path.result=NULL)

## ----SubMusBmCrKoWt-----------------------------------------------------------
Sub3bc3T <- RawCounts_Weger2021_MOUSEsub500
Sub3bc3T <- Sub3bc3T[, seq_len(73)]
SelectTime <- grep("_t0_", colnames(Sub3bc3T))
SelectTime <- c(SelectTime, grep("_t1_", colnames(Sub3bc3T)))
SelectTime <- c(SelectTime, grep("_t2_", colnames(Sub3bc3T)))
Sub3bc3T <- Sub3bc3T[, c(1, SelectTime)]

resSEsub <- DATAprepSE(RawCounts=Sub3bc3T,
                       Column.gene=1,
                       Group.position=1,
                       Time.position=2,
                       Individual.position=3)

## ----DEMusBmCrKoWt, eval=TRUE, echo=TRUE--------------------------------------
resDE <- DEanalysisGlobal(SEres=resSEsub,
                          pval.min=0.05,
                          log.FC.min=1,
                          Plot.DE.graph=FALSE,
                          path.result=NULL)

## ----VolcanoMA_Mouse2, eval=TRUE, echo=TRUE-----------------------------------
resMAvolcano <- DEplotVolcanoMA(SEresDE=resDE,
                                NbGene.plotted=2,
                                SizeLabel=3,
                                Display.plots=FALSE,
                                Save.plots=FALSE)

## ----Heatmaps_Mouse2, eval=TRUE, echo=TRUE------------------------------------
resHEAT <- DEplotHeatmaps(SEresDE=resDE,
                          ColumnsCriteria=2,
                          Set.Operation="union",
                          NbGene.analysis=20,
                          SizeLabelRows=5,
                          SizeLabelCols=5,
                          Display.plots=FALSE,
                          Save.plots=TRUE)

## ----GSEAquickAnalysis_Mouse2, eval=TRUE--------------------------------------
resRgprofiler2 <- GSEAQuickAnalysis(Internet.Connection=FALSE,
                                    SEresDE=resDE,
                                    ColumnsCriteria=2,
                                    ColumnsLog2ordered=NULL,
                                    Set.Operation="union",
                                    Organism="mmusculus",
                                    MaxNumberGO=20,
                                    Background=FALSE,
                                    Display.plots=FALSE,
                                    Save.plots=TRUE)

## ----GSEAprepro_Mouse2, eval=TRUE---------------------------------------------
resGSEApreprocess <- GSEApreprocessing(SEresDE=resDE,
                                       ColumnsCriteria=2,
                                       Set.Operation="union",
                                       Rnk.files=FALSE,
                                       Save.files=FALSE)

## ----SessionInfo--------------------------------------------------------------
sessionInfo()

