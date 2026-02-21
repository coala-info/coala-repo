# Code example from 'splineTimeR' vignette. See references/ for full tutorial.

### R code from vignette source 'splineTimeR.Rnw'

###################################################
### code chunk number 1: splineTimeR.Rnw:62-66 (eval = FALSE)
###################################################
## #path1 <- "/Users/hbraselmann/R/Bioc3.4dev/library"
## #path2 <- "/Library/Frameworks/R.framework/Versions/3.3/Resources/library"
## #.libPaths(c(path1, path2))
## #.libPaths()


###################################################
### code chunk number 2: splineTimeR.Rnw:69-72
###################################################
library(splineTimeR)
data(TCsimData)
head(pData(TCsimData),8)


###################################################
### code chunk number 3: splineTimeR.Rnw:100-104
###################################################
diffExprs <- splineDiffExprs(eSetObject = TCsimData, df = 3,
                             cutoff.adj.pVal = 0.01, reference = "T1", 
                             intercept = TRUE)
head(diffExprs, 3)


###################################################
### code chunk number 4: splineTimeR.Rnw:112-114
###################################################
splinePlot(eSetObject = TCsimData, df = 3, 
           reference = "T1", toPlot = c("EEF2","OR5W2"))


###################################################
### code chunk number 5: splineTimeR.Rnw:138-155 (eval = FALSE)
###################################################
## ## Not run
## ## Download .gmt file 'c2.all.v5.0.symbols.gmt' (all curated gene sets,
## ## gene symbols) from the Broad,
## ## http://www.broad.mit.edu/gsea/downloads.jsp#msigdb, then
## geneSets <- getGmt("/path/to/c2.all.v5.0.symbols.gmt")
## 
## ## load ExpressionSet object containing simulated time-course data
## data(TCsimData)
## 
## ## check for differentially expressed genes
## diffExprs <- splineDiffExprs(eSetObject = TCsimData, df = 3, 
##                              cutoff.adj.pVal = 0.01, reference = "T1")
## 
## ## use differentially expressed genes for pathway enrichment analysis
## enrichPath <- pathEnrich(geneList = rownames(diffExprs), geneSets = geneSets, 
##                          universe = 6536)
## ## End(Not run)


###################################################
### code chunk number 6: splineTimeR.Rnw:160-171 (eval = FALSE)
###################################################
## ## Not run
## ## Download and unzip .gmt.zip file 'ReactomePathways.gmt.zip'
## ## ("Reactome Pathways Gene Set" under "Specialized data formats") from
## ## the Reactome website http://www.reactome.org/pages/download-data/, then
## geneSets <- getGmt("/path/to/ReactomePathways.gmt")
## data(TCsimData)
## diffExprs <- splineDiffExprs(eSetObject = TCsimData, df = 3, 
##                              cutoff.adj.pVal = 0.01, reference = "T1")
## enrichPath <- pathEnrich(geneList = rownames(diffExprs), geneSets = geneSets, 
##                          universe = 6536)
## ## End(Not run)


###################################################
### code chunk number 7: single_igr
###################################################
igr <- splineNetRecon(eSetObject = TCsimData, treatmentType = "T2", 
                      probesForNR = rownames(diffExprs), 
                      cutoff.ggm = 0.7, method = "dynamic")


###################################################
### code chunk number 8: plot_igr1
###################################################
plot(igr, vertex.label = NA, vertex.size = 3, main = "igraph_0.7")


###################################################
### code chunk number 9: two_igraphs
###################################################
igr <- splineNetRecon(eSetObject = TCsimData, treatmentType = "T2", 
                      probesForNR = rownames(diffExprs), 
                      cutoff.ggm = c(0.8,0.9), method = "dynamic")


###################################################
### code chunk number 10: plot_igrlist
###################################################
plot(igr[[1]], vertex.label = NA, vertex.size = 3, main = "igraph_0.8")
plot(igr[[2]], vertex.label = NA, vertex.size = 3, main = "igraph_0.9")


###################################################
### code chunk number 11: splineTimeR.Rnw:233-238 (eval = FALSE)
###################################################
## library(FIs)
## data(FIs)
## names(FIs)
## head(FIs$FIs_Reactome)
## head(FIs$FIs_BioGRID)


###################################################
### code chunk number 12: splineTimeR.Rnw:243-248
###################################################
igr <- splineNetRecon(eSetObject = TCsimData, treatmentType = "T2", 
                      probesForNR = rownames(diffExprs), 
                      cutoff.ggm = c(0.7,0.8,0.9), method = "dynamic")
scaleFreeProp <- networkProperties(igr)
head(scaleFreeProp)


