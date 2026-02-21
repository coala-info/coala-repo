# Code example from 'ADAM' vignette. See references/ for full tutorial.

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
suppressMessages(library(ADAM))

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
data("ExpressionAedes")
head(ExpressionAedes)

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
Comparison <- c("control1,experiment1","control2,experiment2")

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
Minimum <- 3
Maximum <- 20

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
SeedBootstrap <- 1049
StepsBootstrap <- 1000

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
CutoffValue <- 0.05
MethodCorrection <- "fdr"

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
data("KeggPathwaysAedes")
head(KeggPathwaysAedes)

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
Domain <- "own"
Nomenclature <- "geneStableID"

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
Wilcoxon <- TRUE
Fisher <- TRUE

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
ResultAnalysis <- suppressMessages(GFAGAnalysis(ComparisonID = Comparison, 
                            ExpressionData = ExpressionAedes,
                            MinGene = Minimum,
                            MaxGene = Maximum,
                            SeedNumber = SeedBootstrap, 
                            BootstrapNumber = StepsBootstrap,
                            PCorrection = CutoffValue,
                            DBSpecies = KeggPathwaysAedes, 
                            PCorrectionMethod = MethodCorrection,
                            WilcoxonTest = Wilcoxon,
                            FisherTest = Fisher,
                            AnalysisDomain = Domain, 
                            GeneIdentifier = Nomenclature))

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
head(ResultAnalysis[[1]])

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
DT::datatable(as.data.frame(ResultAnalysis[[2]][1]), width = 800,
            options = list(scrollX = TRUE))
DT::datatable(as.data.frame(ResultAnalysis[[2]][2]), width = 800, 
            options = list(scrollX = TRUE))

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
suppressMessages(library(ADAM))
data("ExpressionAedes")
data("KeggPathwaysAedes")

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
Comparison <- c("control1,experiment1")
Minimum <- 3
Maximum <- 100

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
SpeciesID <- "KeggPathwaysAedes"

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
Domain <- "own"
Nomenclature <- "geneStableID"

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
ResultAnalysis <- suppressMessages(ADAnalysis(ComparisonID = Comparison, 
                            ExpressionData = ExpressionAedes,
                            MinGene = Minimum,
                            MaxGene = Maximum,
                            DBSpecies = KeggPathwaysAedes, 
                            AnalysisDomain = Domain, 
                            GeneIdentifier = Nomenclature))

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
head(ResultAnalysis[[1]])

## ----eval=TRUE, out.height.px=6, out.width.px=6-------------------------------
DT::datatable(as.data.frame(ResultAnalysis[[2]][1]), width = 800, 
            options = list(scrollX = TRUE))

## ----eval=TRUE, out.height.px=6, out.width.px=6, label='Session information', , echo=FALSE----
sessionInfo()

