# Code example from 'GOstatsForUnsupportedOrganisms' vignette. See references/ for full tutorial.

## ----available Schemas, message=FALSE, warning=FALSE--------------------------
library("AnnotationForge")
available.dbschemas()

## ----Acquire annotation data, message=FALSE-----------------------------------
library("org.Hs.eg.db")
frame = toTable(org.Hs.egGO)
goframeData = data.frame(frame$go_id, frame$Evidence, frame$gene_id)
head(goframeData)

## ----transformGOFrame, message=FALSE, warning=FALSE---------------------------
goFrame=GOFrame(goframeData,organism="Homo sapiens")
goAllFrame=GOAllFrame(goFrame)

## ----Make GSC, message=FALSE--------------------------------------------------
library("GSEABase")
gsc <- GeneSetCollection(goAllFrame, setType = GOCollection())

## ----make parameter, message=FALSE--------------------------------------------
library("GOstats")
universe = Lkeys(org.Hs.egGO)
genes = universe[1:500]
params <- GSEAGOHyperGParams(name="My Custom GSEA based annot Params", 
                             geneSetCollection=gsc, 
                             geneIds = genes, 
                             universeGeneIds = universe, 
                             ontology = "MF", 
                             pvalueCutoff = 0.05, 
                             conditional = FALSE, 
                             testDirection = "over")

## ----call HyperGTest----------------------------------------------------------
Over <- hyperGTest(params)
head(summary(Over))

## ----KEGGFrame object---------------------------------------------------------
frame = toTable(org.Hs.egPATH)
keggframeData = data.frame(frame$path_id, frame$gene_id)
head(keggframeData)
keggFrame=KEGGFrame(keggframeData,organism="Homo sapiens")

## ----KEGG Parameters----------------------------------------------------------
gsc <- GeneSetCollection(keggFrame, setType = KEGGCollection())
universe = Lkeys(org.Hs.egGO)
genes = universe[1:500]
kparams <- GSEAKEGGHyperGParams(name="My Custom GSEA based annot Params", 
                               geneSetCollection=gsc, 
                               geneIds = genes, 
                               universeGeneIds = universe,  
                               pvalueCutoff = 0.05, 
                               testDirection = "over")
kOver <- hyperGTest(params)
head(summary(kOver))

## ----info---------------------------------------------------------------------
sessionInfo()

