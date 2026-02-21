# Code example from 'mirIntegrator' vignette. See references/ for full tutorial.

### R code from vignette source 'mirIntegrator.Rnw'

###################################################
### code chunk number 1: mirIntegrator.Rnw:115-116
###################################################
 set.seed(42L)


###################################################
### code chunk number 2: mirIntegrator.Rnw:120-126
###################################################
 require("mirIntegrator")
 data(kegg_pathways)
 data(mirTarBase)
 kegg_pathways <- kegg_pathways[18:20] #delete this for augmenting all pathways.
 augmented_pathways <- integrate_mir(kegg_pathways, mirTarBase)
 head(augmented_pathways)


###################################################
### code chunk number 3: mirIntegrator.Rnw:138-139
###################################################
 augmented_pathways$"path:hsa04122"


###################################################
### code chunk number 4: mirIntegrator.Rnw:157-161
###################################################
  data(names_pathways)
plot_augmented_pathway(kegg_pathways$"path:hsa04122", 
                       augmented_pathways$"path:hsa04122",
                       names_pathways["path:hsa04122"] )


###################################################
### code chunk number 5: mirIntegrator.Rnw:167-170
###################################################
  plot_augmented_pathway(kegg_pathways$"path:hsa04122", 
                         augmented_pathways$"path:hsa04122",
                         names_pathways["path:hsa04122"] )


###################################################
### code chunk number 6: mirIntegrator.Rnw:189-193
###################################################
  data(augmented_pathways)
  data(kegg_pathways)
  data(names_pathways)
  plot_change(kegg_pathways,augmented_pathways, names_pathways)


###################################################
### code chunk number 7: mirIntegrator.Rnw:198-199
###################################################
  plot_change(kegg_pathways,augmented_pathways, names_pathways, sizeT = 10)


###################################################
### code chunk number 8: mirIntegrator.Rnw:209-214
###################################################
  data(augmented_pathways)
  data(kegg_pathways)
  data(names_pathways)
  pathways2pdf(kegg_pathways[18:20],augmented_pathways[18:20],
               names_pathways[18:20], "three_pathways.pdf")


###################################################
### code chunk number 9: mirIntegrator.Rnw:238-240
###################################################
  data(GSE43592_miRNA)
  data(GSE43592_mRNA)


###################################################
### code chunk number 10: mirIntegrator.Rnw:254-285
###################################################
  require(graph)
  require(ROntoTools)
  data(GSE43592_mRNA)
  data(GSE43592_miRNA)
  data(augmented_pathways)
  data(names_pathways)
  lfoldChangeMRNA <- GSE43592_mRNA$logFC
  names(lfoldChangeMRNA) <- GSE43592_mRNA$entrez
  
  lfoldChangeMiRNA <- GSE43592_miRNA$logFC
  names(lfoldChangeMiRNA) <- GSE43592_miRNA$entrez
  
  keggGenes <- unique(unlist( lapply(augmented_pathways,nodes) ) )
  interGMi <- intersect(keggGenes, GSE43592_miRNA$entrez)
  interGM <- intersect(keggGenes, GSE43592_mRNA$entrez)
  ## For real-world analysis, nboot should be >= 2000
  peRes <- pe(x= c(lfoldChangeMRNA, lfoldChangeMiRNA ),
              graphs=augmented_pathways, nboot = 200, verbose = FALSE)
  message(paste("There are ", length(unique(GSE43592_miRNA$entrez)),
                "miRNAs meassured and",length(interGMi), 
                "of them were included in the analysis."))
  message(paste("There are ", length(unique(GSE43592_mRNA$entrez)),
                "mRNAs meassured and", length(interGM),
                "of them were included in the analysis."))
  
  summ <- Summary(peRes)
  rankList <- data.frame(summ,path.id = row.names(summ))
  tableKnames <- data.frame(path.id = names(names_pathways),names_pathways)
  rankList <- merge(tableKnames, rankList, by.x = "path.id", by.y = "path.id")
  rankList <- rankList[with(rankList, order(pAcc.fdr)), ] 
  head(rankList)


