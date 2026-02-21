# Code example from 'SubCellBarCode' vignette. See references/ for full tutorial.

## ----install,eval = FALSE-----------------------------------------------------
# if (!requireNamespace("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("SubCellBarCode")

## ----Loadpackage--------------------------------------------------------------
library(SubCellBarCode)

## ----exampleData--------------------------------------------------------------
head(hcc827Ctrl)

## ----markerdata---------------------------------------------------------------
head(markerProteins)

## ----loadData-----------------------------------------------------------------
df <- loadData(protein.data = hcc827Ctrl)

## ----printDimData-------------------------------------------------------------
cat(dim(df))
head(df)

## ----convertID----------------------------------------------------------------
##Run if you have another identifier than gene symbols.
##Function will convert UNIPROT identifier to gene symbols.
##Deafult id is "UNIPROT", make sure you change it if you use another.

#df <- convert2symbol(df = df, id = "UNIPROT")

## ----subset data--------------------------------------------------------------
set.seed(2)
df <- df[sample(nrow(df), 6000),]

## ----coverageMarkers, fig = TRUE----------------------------------------------
c.prots <- calculateCoveredProtein(proteinIDs = rownames(df), 
                        markerproteins = markerProteins[,1]) 

## ----markerQC-----------------------------------------------------------------
r.markers <- markerQualityControl(coveredProteins = c.prots,protein.data = df)
r.markers[1:5]

## ----finalCoverage, fig = TRUE------------------------------------------------
## uncomment the function when running 
# f.prots <- calculateCoveredProtein(r.markers, markerProteins[,1])

## ----tsneparameter------------------------------------------------------------
#Default parameters
#Run the broad-range parameters to optimize well !!!
#Output dimensionality
#dims = 3
#Speed/accuracy trade-off (increase for less accuracy) 
#theta = c(0.1, 0.2, 0.3, 0.4, 0.5)
#Perplexity parameter
#perplexity = c(5, 10, 20, 30, 40, 50, 60) 

## ----tsnedim3, fig = TRUE, fig.width = 6.5, fig.height = 6.5------------------
set.seed(6)
tsne.map <- tsneVisualization(protein.data = df, 
                    markerProteins = r.markers, 
                    dims = 3, 
                    theta = c(0.1), 
                    perplexity = c(60)) 

## ----tsnedim2, fig = TRUE-----------------------------------------------------
set.seed(9)
tsne.map2 <- tsneVisualization(protein.data = df, 
                    markerProteins = r.markers, 
                    dims = 2, 
                    theta = c(0.5), 
                    perplexity = c(60))

## ----buildSVM-----------------------------------------------------------------
set.seed(4)
cls <- svmClassification(markerProteins = r.markers, 
                                    protein.data = df, 
                                    markerprot.df = markerProteins)

## ----testdata-----------------------------------------------------------------
# testing data predictions for replicate A and B
test.A <- cls[[1]]$svm.test.prob.out
test.B <- cls[[2]]$svm.test.prob.out
head(test.A)

## ----allPred------------------------------------------------------------------
# all predictions for replicate A and B
all.A <- cls[[1]]$all.prot.pred
all.B <- cls[[2]]$all.prot.pred

## ----compartmentThreshold-----------------------------------------------------
t.c.df <- computeThresholdCompartment(test.repA = test.A, test.repB = test.B)

## ----headcompartmentThreshold-------------------------------------------------
head(t.c.df)

## ----applycompartmentThreshold------------------------------------------------
c.cls.df <- applyThresholdCompartment(all.repA = all.A, all.repB = all.B,
                                    threshold.df = t.c.df)

## ----headcompartmentCls-------------------------------------------------------
head(c.cls.df)

## ----neighborhoodThreshold----------------------------------------------------
t.n.df <- computeThresholdNeighborhood(test.repA = test.A, test.repB = test.B)

## ----headneighborhoodThreshold------------------------------------------------
head(t.n.df)

## ----applyNeighborhoodThreshold-----------------------------------------------
n.cls.df <- applyThresholdNeighborhood(all.repA = all.A, all.repB = all.B, 
                                    threshold.df = t.n.df)

## ----headNeighborhoodCls------------------------------------------------------
head(n.cls.df)

## ----mergecls-----------------------------------------------------------------
cls.df <- mergeCls(compartmentCls = c.cls.df, neighborhoodCls = n.cls.df)

## ----headmerge----------------------------------------------------------------
head(cls.df)

## ----hcc827psmcount-----------------------------------------------------------
head(hcc827CtrlPSMCount)

## ----plotbarcode, fig = TRUE, fig.width = 6, fig.height = 6-------------------
plotBarcode(sampleClassification = cls.df, protein = "NLRP4",
        s1PSM = hcc827CtrlPSMCount)

## ----multipleprots, fig = TRUE, fig.width= 10, fig.height = 8-----------------
# 26S proteasome complex (26s proteasome regulatory complex)
proteasome26s <- c("PSMA7", "PSMC3","PSMA4", "PSMB4", 
                    "PSMB6", "PSMB5", "PSMC2","PSMC4",
                    "PSMB3", "PSMA6","PSMC5","PSMC6")

plotMultipleProtein(sampleClassification = cls.df, proteinList = proteasome26s)

## ----headHCC827GEFCls---------------------------------------------------------
head(hcc827GEFClass)

## ----sankey, fig.width = 6, fig.height = 3------------------------------------
sankeyPlot(sampleCls1 = cls.df, sampleCls2 = hcc827GEFClass)

## ----headPSMCount-------------------------------------------------------------
head(hcc827CtrlPSMCount)

## ----relocation parameters----------------------------------------------------
##parameters
#sampleCls1 = sample 1 classification output
#s1PSM = sample 2 PSM count
#s1Quant = Sample 1 Quantification data
#sampleCls2 = sample 2 classification output
#s2PSM = sample 2 classification output
#sample2Quant = Sample 2 Quantification data
#min.psm = minumum psm count
#pearson.cor = perason correlation coefficient

## ----strongCandidates, fig = TRUE---------------------------------------------
candidate.df <- candidateRelocatedProteins(sampleCls1 = cls.df, 
                                s1PSM = hcc827CtrlPSMCount, 
                                s1Quant = hcc827Ctrl,
                                sampleCls2 = hcc827GEFClass,
                                s2PSM = hcc827GefPSMCount,
                                s2Quant = hcc827GEF,
                                min.psm = 2,
                                pearson.cor = 0.8)

## ----printdim-----------------------------------------------------------------
cat(dim(candidate.df))

## ----printhead----------------------------------------------------------------
head(candidate.df)

## ----strongCandidatesLabel, fig = TRUE----------------------------------------
candidate2.df <- candidateRelocatedProteins(sampleCls1 = cls.df,
                                s1PSM = hcc827CtrlPSMCount, 
                                s1Quant = hcc827Ctrl, 
                                sampleCls2 = hcc827GEFClass, 
                                s2PSM = hcc827GefPSMCount, 
                                s2Quant = hcc827GEF, 
                                annotation = TRUE, 
                                min.psm = 9, 
                                pearson.cor = 0.05) 

## ----head exon data-----------------------------------------------------------
head(hcc827exon)

## ----recall model-------------------------------------------------------------
##recall the models
modelA <- cls[[1]]$model
modelB <- cls[[2]]$model

## ----exon centric cls---------------------------------------------------------
exon.cls <- svmExternalData(df = hcc827exon, modelA = modelA, modelB= modelB)

## ----exon cls-----------------------------------------------------------------
exon.A <- exon.cls[[1]]
exon.B <- exon.cls[[2]]

## ----exon cls rep A-----------------------------------------------------------
head(exon.A)

## ----apply thresholds---------------------------------------------------------
exon.comp.cls <- applyThresholdCompartment(all.repA = exon.A[,2:17], 
                                    all.repB = exon.B[,2:17],
                                    threshold.df = t.c.df)

exon.neigh.cls <- applyThresholdNeighborhood(all.repA = exon.A[,2:17], 
                                    all.repB = exon.B[,2:17], 
                                    threshold.df = t.n.df)

exon.cls.df <- mergeCls(compartmentCls = exon.comp.cls, 
                        neighborhoodCls = exon.neigh.cls)

#same order
exon.cls.df <- exon.cls.df[rownames(exon.A),]

# we will add gene symbols as well as peptide count  
# (PSM count is also accepted) in case for comparing with 
# gene-centric classifications

exon.cls.df$GeneSymbol <- exon.A$Gene_Symbol
exon.cls.df$PeptideCount <- hcc827exon$PeptideCount

## ----head exon cls------------------------------------------------------------
head(exon.cls.df)

## ----compareCls---------------------------------------------------------------
comp.df <- compareCls(geneCls = cls.df, exonCls = exon.cls.df)

## ----head comp.df-------------------------------------------------------------
head(comp.df)

## -----------------------------------------------------------------------------
sessionInfo()

