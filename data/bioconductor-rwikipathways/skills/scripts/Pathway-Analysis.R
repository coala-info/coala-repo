# Code example from 'Pathway-Analysis' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
  eval=FALSE
)

## -----------------------------------------------------------------------------
# if(!"rWikiPathways" %in% installed.packages()){
#     if (!requireNamespace("BiocManager", quietly = TRUE))
#         install.packages("BiocManager")
#     BiocManager::install("rWikiPathways", update = FALSE)
# }
# library(rWikiPathways)

## -----------------------------------------------------------------------------
# load.libs <- c(
#   "DOSE",
#   "GO.db",
#   "GSEABase",
#   "org.Hs.eg.db",
#   "clusterProfiler",
#   "dplyr",
#   "tidyr",
#   "ggplot2",
#   "stringr",
#   "RColorBrewer",
#   "rWikiPathways",
#   "RCy3")
# options(install.packages.check.source = "no")
# options(install.packages.compile.from.source = "never")
# if (!require("pacman")) install.packages("pacman"); library(pacman)
# p_load(load.libs, update = TRUE, character.only = TRUE)
# status <- sapply(load.libs,require,character.only = TRUE)
# if(all(status)){
#     print("SUCCESS: You have successfully installed and loaded all required libraries.")
# } else{
#     cat("ERROR: One or more libraries failed to install correctly. Check the following list for FALSE cases and try again...\n\n")
#     status
# }

## -----------------------------------------------------------------------------
# cytoscapePing()  #this will tell you if you're able to successfully connect to Cytoscape or not

## -----------------------------------------------------------------------------
# installApp('WikiPathways')
# installApp('CyTargetLinker')
# installApp('stringApp')
# installApp('enrichmentMap')

## -----------------------------------------------------------------------------
# lung.expr <- read.csv(system.file("extdata","data-lung-cancer.csv", package="rWikiPathways"),stringsAsFactors = FALSE)
# nrow(lung.expr)
# head(lung.expr)

## -----------------------------------------------------------------------------
# up.genes <- lung.expr[lung.expr$log2FC > 1 & lung.expr$adj.P.Value < 0.05, 1]
# dn.genes <- lung.expr[lung.expr$log2FC < -1 & lung.expr$adj.P.Value < 0.05, 1]
# bkgd.genes <- lung.expr[,1]

## -----------------------------------------------------------------------------
# up.genes.entrez <- clusterProfiler::bitr(up.genes,fromType = "ENSEMBL",toType = "ENTREZID",OrgDb = org.Hs.eg.db)
# cat("\n\nWhich column contains my new Entrez IDs?\n")
# head(up.genes.entrez)

## -----------------------------------------------------------------------------
# keytypes(org.Hs.eg.db)

## -----------------------------------------------------------------------------
# dn.genes.entrez <- bitr(dn.genes,fromType = "ENSEMBL",toType = "ENTREZID",OrgDb = org.Hs.eg.db)
# bkgd.genes.entrez <- bitr(bkgd.genes,fromType = "ENSEMBL",toType = "ENTREZID",OrgDb = org.Hs.eg.db)

## -----------------------------------------------------------------------------
# egobp <- clusterProfiler::enrichGO(
#         gene     = up.genes.entrez[[2]],
#         universe = bkgd.genes.entrez[[2]],
#         OrgDb    = org.Hs.eg.db,
#         ont      = "BP",
#         pAdjustMethod = "fdr",
#         pvalueCutoff = 0.05, #p.adjust cutoff (https://github.com/GuangchuangYu/clusterProfiler/issues/104)
#         readable = TRUE)
# 
# head(egobp,10)

## -----------------------------------------------------------------------------
# barplot(egobp, showCategory = 20)
# dotplot(egobp, showCategory = 20)
# goplot(egobp)

## -----------------------------------------------------------------------------
# ggplot(egobp[1:20], aes(x=reorder(Description, -pvalue), y=Count, fill=-p.adjust)) +
#     geom_bar(stat = "identity") +
#     coord_flip() +
#     scale_fill_continuous(low="blue", high="red") +
#     labs(x = "", y = "", fill = "p.adjust") +
#     theme(axis.text=element_text(size=11))

## -----------------------------------------------------------------------------
# ## extract a dataframe with results from object of type enrichResult
# egobp.results.df <- egobp@result
# 
# ## create a new column for term size from BgRatio
# egobp.results.df$term.size <- gsub("/(\\d+)", "", egobp.results.df$BgRatio)
# 
# ## filter for term size to keep only term.size => 3, gene count >= 5 and subset
# egobp.results.df <- egobp.results.df[which(egobp.results.df[,'term.size'] >= 3 & egobp.results.df[,'Count'] >= 5),]
# egobp.results.df <- egobp.results.df[c("ID", "Description", "pvalue", "qvalue", "geneID")]
# 
# ## format gene list column
# egobp.results.df$geneID <- gsub("/", ",", egobp.results.df$geneID)
# 
# ## add column for phenotype
# egobp.results.df <- cbind(egobp.results.df, phenotype=1)
# egobp.results.df <- egobp.results.df[, c(1, 2, 3, 4, 6, 5)]
# 
# ## change column headers
# colnames(egobp.results.df) <- c("Name","Description", "pvalue","qvalue","phenotype", "genes")
# 
# egobp.results.filename <-file.path(getwd(),paste("clusterprofiler_cluster_enr_results.txt",sep="_"))
# write.table(egobp.results.df,egobp.results.filename,col.name=TRUE,sep="\t",row.names=FALSE,quote=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# em_command = paste('enrichmentmap build analysisType=',"generic",
#                    'pvalue=',"0.05", 'qvalue=',"0.05",
#                    'similaritycutoff=',"0.25",
#                    'coefficients=',"JACCARD",
#                    'enrichmentsDataset1=',egobp.results.filename ,
#                    sep=" ")
# 
#   #enrichment map command will return the suid of newly created network.
#   em_network_suid <- commandsRun(em_command)
# 
#   renameNetwork("Cluster1_enrichmentmap_cp", network=as.numeric(em_network_suid))

## -----------------------------------------------------------------------------
# ewp.up <- clusterProfiler::enrichWP(
#     up.genes.entrez[[2]],
#     universe = bkgd.genes.entrez[[2]],
#     organism = "Homo sapiens",
#     pAdjustMethod = "fdr",
#     pvalueCutoff = 0.1, #p.adjust cutoff; relaxed for demo purposes
# )
# 
# head(ewp.up)

## -----------------------------------------------------------------------------
# ewp.up <- DOSE::setReadable(ewp.up, org.Hs.eg.db, keyType = "ENTREZID")
# head(ewp.up)

## -----------------------------------------------------------------------------
# barplot(ewp.up, showCategory = 20)
# dotplot(ewp.up, showCategory = 20)

## -----------------------------------------------------------------------------
# ewp.dn <- enrichWP(
#     dn.genes.entrez[[2]],
#     #universe = bkgd.genes[[2]],  #hint: comment out to get any results for demo
#     organism = "Homo sapiens",
#     pAdjustMethod = "fdr",
#     pvalueCutoff = 0.1, #p.adjust cutoff; relaxed for demo purposes
# )
# 
#  ewp.dn <- setReadable(ewp.dn, org.Hs.eg.db, keyType = "ENTREZID")
#  head(ewp.dn)
#  dotplot(ewp.dn, showCategory = 20)

## -----------------------------------------------------------------------------
# lung.expr$fcsign <- sign(lung.expr$log2FC)
# lung.expr$logfdr <- -log10(lung.expr$P.Value)
# lung.expr$sig <- lung.expr$logfdr/lung.expr$fcsign
# sig.lung.expr.entrez<-merge(lung.expr, bkgd.genes.entrez, by.x = "GeneID", by.y = "ENSEMBL")
# gsea.sig.lung.expr <- sig.lung.expr.entrez[,8]
# names(gsea.sig.lung.expr) <- as.character(sig.lung.expr.entrez[,9])
# gsea.sig.lung.expr <- sort(gsea.sig.lung.expr,decreasing = TRUE)
# 
# gwp.sig.lung.expr <- clusterProfiler::gseWP(
#     gsea.sig.lung.expr,
#     pAdjustMethod = "fdr",
#     pvalueCutoff = 0.05, #p.adjust cutoff
#     organism = "Homo sapiens"
# )
# 
# gwp.sig.lung.expr.df = as.data.frame(gwp.sig.lung.expr)
# gwp.sig.lung.expr.df[which(gwp.sig.lung.expr.df$NES > 1),] #pathways enriched for upregulated lung cancer genes
# gwp.sig.lung.expr.df[which(gwp.sig.lung.expr.df$NES < -1),] #pathways enriched for downregulated lung cancer genes

## -----------------------------------------------------------------------------
# findPathwayNamesByText("lung cancer")

## -----------------------------------------------------------------------------
# lc.pathways <- findPathwaysByText("lung cancer")  #quotes inside query to require both terms
# human.lc.pathways <- lc.pathways %>%
#   dplyr::filter(species == "Homo sapiens") # just the human lung cancer pathways
# human.lc.pathways$name # display the pathway titles

## -----------------------------------------------------------------------------
# lc.wpids <- human.lc.pathways$id
# lc.wpids

## -----------------------------------------------------------------------------
# ewp.up.wpids <- ewp.up$ID
# ewp.up.wpids

## -----------------------------------------------------------------------------
# url <- getPathwayInfo("WP179")$url
# browseURL(url)

## -----------------------------------------------------------------------------
# cytoscapePing()

## -----------------------------------------------------------------------------
# RCy3::commandsRun('wikipathways import-as-pathway id=WP179')

## -----------------------------------------------------------------------------
# toggleGraphicsDetails()

## -----------------------------------------------------------------------------
# loadTableData(lung.expr, data.key.column = "GeneID", table.key.column = "Ensembl")

## -----------------------------------------------------------------------------
# setNodeColorMapping("log2FC", colors=paletteColorBrewerRdBu,  style.name = "WikiPathways")

## -----------------------------------------------------------------------------
# lapply(ewp.up.wpids[1:5], function (x) {
#     commandsRun(paste0('wikipathways import-as-pathway id=',x))
#     loadTableData(lung.expr, data.key.column = "GeneID", table.key.column = "Ensembl")
#     toggleGraphicsDetails()
#     })

## -----------------------------------------------------------------------------
# lapply(lc.wpids, function (x){
#     commandsRun(paste0('wikipathways import-as-pathway id=',x))
#     loadTableData(lung.expr, data.key.column = "GeneID", table.key.column = "Ensembl")
#     toggleGraphicsDetails()
#     })

## -----------------------------------------------------------------------------
# commandsRun('wikipathways import-as-network id=WP179')
# loadTableData(lung.expr, data.key.column = "GeneID", table.key.column = "Ensembl")
# setNodeColorMapping("log2FC", data.values, node.colors, default.color = "#FFFFFF", style.name = "WikiPathways-As-Network")

## -----------------------------------------------------------------------------
# unzip(system.file("extdata","drugbank-5.1.0.xgmml.zip", package="rWikiPathways"), exdir = getwd())
# drugbank <- file.path(getwd(), "drugbank-5.1.0.xgmml")

## -----------------------------------------------------------------------------
# commandsRun(paste0('cytargetlinker extend idAttribute="Ensembl" linkSetFiles="', drugbank, '"') )
# commandsRun('cytargetlinker applyLayout network="current"')

## -----------------------------------------------------------------------------
# my.drugs <- selectNodes("drug", by.col = "CTL.Type", preserve = FALSE)$nodes #easy way to collect node SUIDs by column value
# clearSelection()
# setNodeColorBypass(my.drugs, "#DD99FF")
# setNodeShapeBypass(my.drugs, "hexagon")
# 
# drug.labels <- getTableColumns(columns=c("SUID","CTL.label"))
# drug.labels <- na.omit(drug.labels)
# mapply(function(x,y) setNodeLabelBypass(x,y), drug.labels$SUID, drug.labels$CTL.label)

## -----------------------------------------------------------------------------
# save(ewp.up, file = "lung_cancer_ewp_up.Rdata")
# save(ewp.dn, file = "lung_cancer_ewp_down.Rdata")

## -----------------------------------------------------------------------------
# saveSession('tutorial_session') #.cys

## -----------------------------------------------------------------------------
# exportImage('tutorial_image2', type='PDF') #.pdf
# exportImage('tutorial_image2', type='PNG', zoom=200) #.png; use zoom or width args to increase size/resolution
# ?exportImage

## -----------------------------------------------------------------------------
# sessionInfo()

