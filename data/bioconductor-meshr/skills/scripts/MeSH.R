# Code example from 'MeSH' vignette. See references/ for full tutorial.

## ----Access1, eval=FALSE------------------------------------------------------
# library("AnnotationHub")

## ----Access2, eval=FALSE------------------------------------------------------
# ah <- AnnotationHub()

## ----Access3, eval=FALSE------------------------------------------------------
# head(mcols(ah))

## ----Access4, eval=FALSE------------------------------------------------------
# mcols(query(ah, c("MeSHDb", "MeSH.db", "v002")))

## ----Access5, eval=FALSE------------------------------------------------------
# dbfile1 <- query(ah, c("MeSHDb", "MeSH.db", "v002"))[[1]]
# dbfile2 <- query(ah, c("MeSHDb", "MeSH.AOR.db", "v002"))[[1]]
# dbfile3 <- query(ah, c("MeSHDb", "MeSH.PCR.db", "v002"))[[1]]
# dbfile4 <- query(ah, c("MeSHDb", "Danio rerio", "v002"))[[1]]
# dbfile5 <- query(ah, c("MeSHDb", "Pseudomonas aeruginosa PAO1", "v002"))[[1]]

## ----Access6, eval=FALSE------------------------------------------------------
# library("MeSHDbi")
# MeSH.db <- MeSHDbi::MeSHDb(dbfile1)
# MeSH.AOR.db <- MeSHDbi::MeSHDb(dbfile2)
# MeSH.PCR.db <- MeSHDbi::MeSHDb(dbfile3)
# MeSH.Dre.eg.db <- MeSHDbi::MeSHDb(dbfile4)
# MeSH.Pae.PAO1.eg.db <- MeSHDbi::MeSHDb(dbfile5)

## ----EA1, eval=FALSE----------------------------------------------------------
# library("meshr")
# 
# # dummy geneids for demo
# geneid <- keys(MeSH.Pae.PAO1.eg.db, keytype="GENEID")
# set.seed(1234)
# sig.geneid <- sample(geneid, 500)
# 
# meshParams <- new("MeSHHyperGParams",
#     geneIds = sig.geneid,
#     universeGeneIds = geneid,
#     annotation = "MeSH.Pae.PAO1.eg.db",
#     meshdb = "MeSH.db", # Newly added parameter from BioC 3.14
#     category = "A",
#     database = "Escherichia coli str. K-12 substr. MG1655",
#     pvalueCutoff = 0.5, pAdjust = "BH")
# meshR <- meshHyperGTest(meshParams)

## ----EA2, eval=FALSE----------------------------------------------------------
# head(summary(meshR))

## ----EA3, eval=FALSE----------------------------------------------------------
# category(meshParams) <- "B"
# database(meshParams) <- "Bacillus subtilis subsp. subtilis str. 168"
# meshR <- meshHyperGTest(meshParams)
# head(summary(meshR))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

