# Code example from 'rgsepd' vignette. See references/ for full tutorial.

## ----setup_latex, include=FALSE, cache=FALSE, echo=FALSE----------------------
Sys.setenv(TEXINPUTS=getwd(),
           BIBINPUTS=getwd(),
           BSTINPUTS=getwd())
library(xtable)

## ----dataload-----------------------------------------------------------------
library(rgsepd)
set.seed(1000) #fixed randomness
data("IlluminaBodymap" , package="rgsepd")
data("IlluminaBodymapMeta" , package="rgsepd")

## ----MyT1CodeBlock, echo = FALSE, results = 'hide'----------------------------
T1 <- head(IlluminaBodymap,n=10L)[,c(1,2,3,4,5,9,13)]
T2 <- head(IlluminaBodymapMeta)

## ----MyLaTeXT1Caption, echo = FALSE, results = 'asis'-------------------------
xT<-xtable(T1, caption ="First few rows of the included IlluminaBodymap dataset. See \\texttt{?IlluminaBodymap} for more details.", label = 'MyT1')
print.xtable(xT, scalebox=0.75)
xtable(T2, caption ="First few rows of the included IlluminaBodymapMeta dataset. See \\texttt{?IlluminaBodymapMeta} for more details. These are easy to build with a spreadsheet, saved to csv and R's builtin \\texttt{?read.csv}", label = 'MyT2')

## ----setup--------------------------------------------------------------------
isoform_ids <- Name_to_RefSeq(c("GAPDH","HIF1A","EGFR","MYH7","CD33","BRCA2"))
rows_of_interest <- unique( c( isoform_ids ,
                    sample(rownames(IlluminaBodymap),
                    size=5000,replace=FALSE)))
G <- GSEPD_INIT(Output_Folder="OUT",
          finalCounts=round(IlluminaBodymap[rows_of_interest , ]),
          sampleMeta=IlluminaBodymapMeta,
            COLORS=c(blue="#4DA3FF",black="#000000",gold="#FFFF4D"))
G <- GSEPD_ChangeConditions( G, c("A","B"))

## ----ParameterChanging, cache=FALSE-------------------------------------------
  G$MAX_Genes_for_Heatmap <- 30
  G$MAX_GOs_for_Heatmap <- 25
  G$MaxGenesInSet <- 12
  G$LIMIT$LFC <- log( 2.50 , 2 )
  G$LIMIT$HARD <- FALSE

## ----GSEPD_Process, cache=FALSE-----------------------------------------------
  G <- GSEPD_Process( G )

## ----GSEPD_Heatmap_-_PCA------------------------------------------------------
  print(isoform_ids)
  GSEPD_Heatmap(G,isoform_ids)
  GSEPD_PCA_Plot(G)

## ----MyT3---------------------------------------------------------------------
Annotated_Filtered <- read.csv("OUT/DESEQ.RES.Ax4.Bx8.Annote_Filter.csv",
                      header=TRUE,as.is=TRUE)

## ----MyLaTeXT3Caption, echo = FALSE, results = 'asis'-------------------------
xT<-xtable(head(Annotated_Filtered, n=10L),
           caption ="First few rows of OUT/DESEQ.RES.Ax4.Bx8.Annote\\_Filter.csv which contains the DESeq results, cropped for significant results, and annotated with gene names (the HGNC Symbol).", label = 'Table_Annote')
print(xT, scalebox=0.70, include.rownames=FALSE)

## ----MyLaTeXT5Caption, echo = FALSE, results = 'asis'-------------------------
Merge_File <- read.csv("OUT/GSEPD.RES.Ax4.Bx8.MERGE.csv",
                      header=TRUE,as.is=TRUE, nrows=20)
xT<-xtable(head(Merge_File, n=15L),
           caption ="First few rows of OUT/GSEPD.RES.Ax4.Bx8.MERGE.csv showing enriched GO Terms, and each terms' underlying gene expression averages per group. This data is central to the rgsepd package, defining the group centroids per GO-Term. It consists of the cross-product of the GO enrichment statistics and the DESeq differential expression and summarization. ", label = 'MyT5')
print(xT, scalebox=0.50, include.rownames=FALSE)

## ----AlphaBetaTables, echo = FALSE, results = 'asis'--------------------------
Alpha_File <- read.csv("OUT/GSEPD.Alpha.Ax4.Bx8.csv",
                      header=TRUE,as.is=TRUE, nrows=20, row.names=1)
xT<-xtable(head(Alpha_File, n=10L)[,c(1,2,3,4,5,9,13)],
           caption ="First ten rows of OUT/GSEPD.Alpha.Ax4.Bx8.csv showing the group projection scores for each sample, these directly correspond to the colors in the HMA file. Where the HMA displays only significant sets, the Alpha table continues for all tested GO Terms. Both the Alpha table and Beta table are summarized in Figure \\ref{fig:HMA}.", label = 'TableAlpha')
print(xT, scalebox=0.80, include.rownames=TRUE)
Beta_File <- read.csv("OUT/GSEPD.Beta.Ax4.Bx8.csv",
                      header=TRUE,as.is=TRUE, nrows=20, row.names=1)
xT<-xtable(head(Beta_File, n=10L)[,c(1,2,3,4,5,9,13)],
           caption ="First ten rows of OUT/GSEPD.Beta.Ax4.Bx8.csv showing the linear divergence (distance to axis) for each sample, high values here would be annotated with white dots on the HMA file to indicate that a sample is not falling on the axis. Non-tested samples are expected to frequently have high values here, the C group was not part of the A vs B comparison.  Where the HMA displays only significant sets, the Beta table continues for all tested GO Terms. Both the Alpha table and Beta table are summarized in Figure \\ref{fig:HMA}.", label = 'TableBeta')
print(xT, scalebox=0.80, include.rownames=TRUE)
Gamma1_File <- read.csv("OUT/GSEPD.HMG1.Ax4.Bx8.csv",
                      header=TRUE,as.is=TRUE, nrows=20, row.names=1)
xT<-xtable(head(Gamma1_File, n=10L)[,c(1,2,3,4,5,9,13)],
           caption ="First ten rows of OUT/GSEPD.HMG1.Ax4.Bx8.csv showing the z-scaled distance to the Group1 centroid for each sample, these directly correspond to the colors in the HMG file. Where the HMG displays only significant sets, the Gamma table continues for all tested GO Terms. Both the Gamma1 and Gamma2 tables are summarized in Figure \\ref{fig:HMG}. Distance is normalized to dimensionality by scaling between the centroids. Thus a score of 0 means the sample resides on the centroid, and a score of 1 means it resides on the opposite class centroid, or equidistant.", label = 'TableGamma1')
print(xT, scalebox=0.80, include.rownames=TRUE)
Gamma2_File <- read.csv("OUT/GSEPD.HMG2.Ax4.Bx8.csv",
                      header=TRUE,as.is=TRUE, nrows=20, row.names=1)
xT<-xtable(head(Gamma2_File, n=10L)[,c(1,2,3,4,5,9,13)],
           caption ="First ten rows of OUT/GSEPD.HMG2.Ax4.Bx8.csv showing the z-scaled distance to the Group2 centroid for each sample, these directly correspond to the colors in the HMG file. Where the HMG displays only significant sets, the Gamma table continues for all tested GO Terms. Both the Gamma1 and Gamma2 tables are summarized in Figure \\ref{fig:HMG}. Distance is normalized to dimensionality by scaling between the centroids. Thus a score of 0 means the sample resides on the centroid, and a score of 1 means it resides on the opposite class centroid, or equidistant.", label = 'TableGamma2')
print(xT, scalebox=0.80, include.rownames=TRUE)

## ----FindFiles, echo = FALSE, results = 'asis'--------------------------------
HM_File <- list.files("OUT",pattern="HM.A")
PScatter_File <- list.files("OUT//SCGO",pattern="Scatter.Ax")[1]
PGSEPD_File <- list.files("OUT//SCGO",pattern="GSEPD.Ax")[1]
PPairs_File <- list.files("OUT//SCGO",pattern="Pairs.Ax")[1]
#trim the .PDF
HM_File <- substring(HM_File,0,nchar(HM_File)-4)
PScatter_File <- substring(PScatter_File,0,nchar(PScatter_File)-4)
PGSEPD_File <- substring(PGSEPD_File,0,nchar(PGSEPD_File)-4)
PPairs_File <- substring(PPairs_File,0,nchar(PPairs_File)-4)


## ----sessionInfo--------------------------------------------------------------
  sessionInfo()

