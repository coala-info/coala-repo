# Code example from 'PPInfer' vignette. See references/ for full tutorial.

### R code from vignette source 'PPInfer.Rnw'

###################################################
### code chunk number 1: PPInfer.Rnw:22-23
###################################################
options(prompt = " ", continue = " ")


###################################################
### code chunk number 2: PPInfer.Rnw:66-73
###################################################
library(PPInfer)
data(litG)
litG <- igraph.from.graphNEL(litG)
summary(litG)
sg <- decompose(litG, min.vertices = 50)
sg <- sg[[1]]           # largest subgraph
summary(sg)


###################################################
### code chunk number 3: PPInfer.Rnw:78-83
###################################################
V(sg)$color <- "green"
V(sg)$label.font <- 3
V(sg)$label.cex <- 1
V(sg)$label.color <- "black"
V(sg)[1:10]$color <- "blue"


###################################################
### code chunk number 4: PPInfer.Rnw:89-90
###################################################
plot(sg, layout = layout.kamada.kawai(sg), vertex.size = 10)


###################################################
### code chunk number 5: PPInfer.Rnw:98-104
###################################################
K <- net.kernel(sg)
set.seed(123)
litG.infer <- net.infer(names(V(sg))[1:10], K, top = 20, cross = 10)
litG.infer$CVerror
index <- match(litG.infer$top,names(V(sg)))
V(sg)[index]$color <- "red"


###################################################
### code chunk number 6: PPInfer.Rnw:110-111
###################################################
plot(sg, layout = layout.kamada.kawai(sg), vertex.size = 10)


###################################################
### code chunk number 7: PPInfer.Rnw:119-123
###################################################
litG.infer <- try(net.infer(names(V(sg))[1:50], K, top = 20))
cat(litG.infer)
litG.infer <- net.infer(names(V(sg))[1:40], K, top = 20)
litG.infer$top


###################################################
### code chunk number 8: PPInfer.Rnw:130-141
###################################################
data(examplePathways)
data(exampleRanks)
geneNames <- names(exampleRanks)

set.seed(1)
gene.names <- sample(geneNames, length(V(sg)))
rownames(K) <- gene.names
myInterestingGenes <- sample(gene.names, 10)

infer <- net.infer(myInterestingGenes, K)
gene.id <- infer$top


###################################################
### code chunk number 9: PPInfer.Rnw:145-147
###################################################
# ORA
result.ORA <- ORA(examplePathways, gene.id[1:10])


###################################################
### code chunk number 10: PPInfer.Rnw:153-156
###################################################
ORA.barplot(result.ORA, category = "Category", size = "Size",
            count = "Count", pvalue = "pvalue", sort = "pvalue") +
            scale_colour_gradient(low = 'red', high = 'gray', limits=c(0, 0.1))


###################################################
### code chunk number 11: PPInfer.Rnw:163-171
###################################################
# GSEA
index <- !is.na(infer$score)
gene.id <- infer$top[index]
scores <- infer$score[index]
scaled.scores <- as.numeric(scale(scores))
names(scaled.scores) <- gene.id
set.seed(1)
result.GSEA <- fgsea(examplePathways, scaled.scores, nperm=1000)


###################################################
### code chunk number 12: PPInfer.Rnw:178-180
###################################################
GSEA.barplot(result.GSEA, category = 'pathway', score = 'NES', pvalue = 'pval',
             numChar = 50, sort = 'NES', decreasing = TRUE)


###################################################
### code chunk number 13: PPInfer.Rnw:190-195
###################################################
enrich.net(result.GSEA, examplePathways, node.id = 'pathway',
           pvalue = 'pval', pvalue.cutoff = 0.25, degree.cutoff = 0,
           n = 100, vertex.label.cex = 0.75, show.legend = FALSE,
           edge.width = function(x) {5*sqrt(x)},
           layout=igraph::layout.kamada.kawai)


###################################################
### code chunk number 14: PPInfer.Rnw:225-237 (eval = FALSE)
###################################################
## library(GOstats)
## 
## # load kernel matrix
## K.9606 <- readRDS("K9606.rds")
## 
## # remove prefix
## rownames(K.9606) <- sub(".*\\.", "", rownames(K.9606))
## 
## # load target class from KEGG apoptosis pathway
## data(apopGraph)
## list.proteins <- nodes(apopGraph)
## head(list.proteins)


###################################################
### code chunk number 15: PPInfer.Rnw:242-265 (eval = FALSE)
###################################################
## # find top 100 proteins
## apoptosis.infer <- ppi.infer.human(list.proteins, K.9606, output="entrezgene", 100)
## gene.id <- apoptosis.infer$top
## head(gene.id)
## 
## # GO terms
## params <- new("GOHyperGParams", geneIds = gene.id,annotation = "org.Hs.eg.db",
##              ontology = "BP", pvalueCutoff = 0.001, conditional = FALSE,
##              testDirection = "over")
## (hgOver <- hyperGTest(params))
## 
## # Top 10 biological functions related to apoptosis by using GO terms
## ORA.barplot(summary(hgOver), category = "Term", size = "Size",
##             count = "Count", pvalue = "Pvalue", p.adjust.methods = 'fdr')
## 
## # KEGG pathway
## params <- new("KEGGHyperGParams", geneIds = gene.id, annotation = "org.Hs.eg.db",
##               pvalueCutoff = 0.05, testDirection = "over")
## (hgOver <- hyperGTest(params))
## 
## # Top 10 biological functions related to apoptosis by using KEGG pathways
## ORA.barplot(summary(hgOver), category = "Term", size = "Size",
##             count = "Count", pvalue = "Pvalue", p.adjust.methods = 'fdr')


###################################################
### code chunk number 16: PPInfer.Rnw:273-328 (eval = FALSE)
###################################################
## library(KEGG.db)
## library(limma)
## 
## # load target class for p53
## mget('p53 signaling pathway', KEGGPATHNAME2ID)
## kegg.hsa <- getGeneKEGGLinks(species.KEGG='hsa')
## index <- which(kegg.hsa[,2] == 'path:hsa04115')
## path.04115 <- kegg.hsa[index,1]
## head(path.04115)
## 
## # find top 100 proteins
## hsa04115.infer <- ppi.infer.human(path.04115, K.9606, input = "entrezgene",
##                              output = "entrezgene", nrow(K.9606))
## gene.id <- data.frame(hsa04115.infer$top)[,1]
## head(gene.id)
## rm(K.9606)
## 
## index <- !is.na(hsa04115.infer$score)
## gene.id <- hsa04115.infer$top[index]
## scores <- hsa04115.infer$score[index]
## scaled.scores <- as.numeric(scale(scores))
## names(scaled.scores) <- gene.id
## 
## # GO terms
## library(org.Hs.eg.db)
## xx <- as.list(org.Hs.egGO2EG)
## 
## set.seed(1)
## fgseaRes <- fgsea(xx, scaled.scores, nperm = 1000)
## 
## # Top 10 biological functions related to p53 signaling pathway by using GO terms
## GSEA.barplot(data.frame(fgseaRes, select(GO.db, fgseaRes$pathway, "TERM")),
##             category = 'TERM', score = 'NES', pvalue = 'padj',
##             sort = 'NES', decreasing = TRUE)
## 
## # KEGG pathways
## pathway.id <- unique(kegg.hsa[,2])
## 
## yy <- list()
## for(i in 1:length(pathway.id))
## {
##   index <- which(kegg.hsa[,2] == pathway.id[i])
##   yy[[i]] <- kegg.hsa[index,1]
## }
## 
## library(Category)
## names(yy) <- getPathNames(sub("[[:alpha:]]+....", "", pathway.id))
## yy[which(names(yy) == 'NA')] <- NULL
## 
## set.seed(1)
## fgseaRes <- fgsea(yy, scaled.scores, nperm=1000)
## 
## # Top 10 biological functions related to p53 signaling pathway by using KEGG pathways
## GSEA.barplot(fgseaRes, category = 'pathway', score = 'NES', pvalue = 'padj',
##              sort = 'NES', decreasing = TRUE)


###################################################
### code chunk number 17: PPInfer.Rnw:341-387 (eval = FALSE)
###################################################
## # load kernel matrix
## K.10090 <- readRDS("K10090.rds")
## # remove prefix
## rownames(K.10090) <- sub(".*\\.", "", rownames(K.10090))
## 
## # load target class
## mget('Acute myeloid leukemia', KEGGPATHNAME2ID)
## kegg.mmu <- getGeneKEGGLinks(species.KEGG='mmu')
## index <- which(kegg.mmu[,2] == 'path:mmu05221')
## path.05221 <- kegg.mmu[index,1]
## head(path.05221)
## 
## # find top 100 proteins
## path.05221.infer <- ppi.infer.mouse(path.05221, K.10090, input="entrezgene",
##                                     output="entrezgene", nrow(K.10090))
## gene.id <- path.05221.infer$top
## head(gene.id)
## 
## # ORA
## params <- new("GOHyperGParams", geneIds = gene.id[1:100],
##              annotation = "org.Mm.eg.db",
##              ontology = "BP", pvalueCutoff = 0.001,
##              conditional = FALSE, testDirection = "over")
## (hgOver <- hyperGTest(params))
## 
## # Top 10 biological functions related to Acute myeloid leukemia
## ORA.barplot(summary(hgOver), category = "Term", size = "Size",
##             count = "Count", pvalue = "Pvalue", p.adjust.methods = 'fdr')
## 
## # GSEA
## library(org.Mm.eg.db)
## xx <- as.list(org.Mm.egGO2EG)
## 
## index <- !is.na(path.05221.infer$score)
## gene.id <- path.05221.infer$top[index]
## scores <- path.05221.infer$score[index]
## scaled.scores <- as.numeric(scale(scores))
## names(scaled.scores) <- gene.id
## 
## set.seed(1)
## fgseaRes <- fgsea(xx, scaled.scores, nperm=1000)
## 
## # Top 10 biological functions related to Acute myeloid leukemia
## GSEA.barplot(na.omit(data.frame(fgseaRes, select(GO.db, fgseaRes$pathway, 'TERM'))),
##              category = 'TERM', score = 'NES', pvalue = 'padj',
##              sort = 'NES', decreasing = TRUE)


###################################################
### code chunk number 18: PPInfer.Rnw:394-443 (eval = FALSE)
###################################################
## # load target class
## mget('Ras signaling pathway', KEGGPATHNAME2ID)
## kegg.mmu <- getGeneKEGGLinks(species.KEGG='mmu')
## index <- which(kegg.mmu[,2] == 'path:mmu04014')
## path.04014 <- kegg.mmu[index,1]
## head(path.04014)
## 
## # find top 100 proteins
## path.04014.infer <- ppi.infer.mouse(path.04014, K.10090,
##                                  input="entrezgene",output="entrezgene", nrow(K.10090))
## gene.id <- data.frame(path.04014.infer$top)[,1]
## head(gene.id)
## rm(K.10090)
## 
## # ORA
## params <- new("KEGGHyperGParams", geneIds = gene.id[1:100],
##               annotation = "org.Mm.eg.db", pvalueCutoff = 0.05, testDirection = "over")
## (hgOver <- hyperGTest(params))
## 
## # Top 10 biological functions related to Ras signaling pathway
## ORA.barplot(summary(hgOver), category = "Term", size = "Size",
##             count = "Count", pvalue = "Pvalue", p.adjust.methods = 'fdr')
## 
## # GSEA
## kegg.mmu <- getGeneKEGGLinks(species.KEGG='mmu')
## head(kegg.mmu)
## pathway.id <- unique(kegg.mmu[,2])
## 
## yy <- list()
## for(i in 1:length(pathway.id))
## {
##   index <- which(kegg.mmu[,2] == pathway.id[i])
##   yy[[i]] <- kegg.mmu[index,1]
## }
## 
## names(yy) <- getPathNames(sub("[[:alpha:]]+....", "", pathway.id))
## yy[which(names(yy) == 'NA')] <- NULL
## 
## index <- !is.na(path.04014.infer$score)
## gene.id <- path.04014.infer$top[index]
## scores <- path.04014.infer$score[index]
## scaled.scores <- as.numeric(scale(scores))
## names(scaled.scores) <- gene.id
## 
## set.seed(1)
## fgseaRes <- fgsea(yy, scaled.scores, nperm = 1000)
## 
## # Top 10 biological functions related to Ras signaling pathway
## GSEA.barplot(fgseaRes, category = 'pathway', score = 'NES', pvalue = 'padj')


###################################################
### code chunk number 19: PPInfer.Rnw:459-655 (eval = FALSE)
###################################################
## ############################## E. coli
## string.db.511145 <- STRINGdb$new(version = '11', species = 511145)
## string.db.511145.graph <- string.db.511145$get_graph()
## K.511145 <- net.kernel(string.db.511145.graph)
## rownames(K.511145) <- sub("[[:digit:]]+.", "", rownames(K.511145))
## 
## # load target class (DNA replication)
## kegg.eco <- getGeneKEGGLinks(species.KEGG='eco')
## index <- which(kegg.eco[,2] == 'path:eco03030')
## path.03030 <- kegg.eco[index,1]
## head(path.03030)
## 
## sce03030.infer <- net.infer(path.03030, K.511145, top = 100)
## gene.id <- data.frame(sce03030.infer$top)[,1]
## head(gene.id)
## rm(K.511145)
## 
## 
## ############################## yeast
## # string.db.4932 <- STRINGdb$new(version = '11', species = 4932)
## # string.db.4932.graph <- string.db.4932$get_graph()
## # K.4932 <- net.kernel(string.db.4932.graph)
## # saveRDS(K.4932, 'K4932.rds')
## K.4932 <- readRDS("K4932.rds")
## dim(K.4932)
## rownames(K.4932) <- sub("[[:digit:]]+.", "", rownames(K.4932))
## 
## # load target class (Cell cycle)
## kegg.sce <- getGeneKEGGLinks(species.KEGG='sce')
## index <- which(kegg.sce[,2] == 'path:sce04111')
## path.04111 <- kegg.sce[index,1]
## head(path.04111)
## 
## sce04111.infer <- net.infer(path.04111, K.4932, top = 100)
## gene.id <- data.frame(sce04111.infer$top)[,1]
## head(gene.id)
## rm(K.4932)
## 
## # functional enrichment
## params <- new("GOHyperGParams", geneIds = gene.id, annotation = "org.Sc.sgd.db",
##               ontology = "BP",pvalueCutoff = 0.001, conditional = FALSE,
##               testDirection = "over")
## (hgOver <- hyperGTest(params))
## 
## # Top 10 biological functions related to Cell cycle
## ORA.barplot(summary(hgOver), category = "Term", size = "Size",
##             count = "Count", pvalue = "Pvalue", p.adjust.methods = 'fdr')
## 
## 
## ############################## C. elegans
## # string.db.6239 <- STRINGdb$new(version = '11', species = 6239)
## # string.db.6239.graph <- string.db.6239$get_graph()
## # K.6239 <- net.kernel(string.db.6239.graph)
## # saveRDS(K.6239, 'K6239.rds')
## K.6239 <- readRDS("K6239.rds")
## dim(K.6239)
## rownames(K.6239) <- sub("[[:digit:]]+.", "", rownames(K.6239))
## 
## # load target class (DNA replication)
## kegg.cel <- getGeneKEGGLinks(species.KEGG='cel')
## index <- which(kegg.cel[,2] == 'path:cel03030')
## path.03030 <- kegg.cel[index,1]
## path.03030 <- sub('.*\\_', '', path.03030)
## head(path.03030)
## 
## cel03030.infer <- net.infer(path.03030, K.6239, top=100)
## gene.id <- data.frame(cel03030.infer$top)[,1]
## head(gene.id)
## rm(K.6239)
## 
## library(org.Ce.eg.db)
## gene.id2 <- as.vector(na.omit(select(org.Ce.eg.db,
##                         keys=as.character(gene.id), "ENTREZID",
##                         keytype = 'SYMBOL')[,2]))
## 
## # functional enrichment
## params <- new("GOHyperGParams", geneIds = gene.id2, annotation = "org.Ce.eg.db",
##               ontology = "BP", pvalueCutoff = 0.001, conditional = FALSE,
##               testDirection = "over")
## (hgOver <- hyperGTest(params))
## 
## # Top 10 biological functions related to DNA replication
## ORA.barplot(summary(hgOver), category = "Term", size = "Size",
##             count = "Count", pvalue = "Pvalue", p.adjust.methods = 'fdr')
## 
## 
## ############################## Drosophila melanogaster
## # string.db.7227 <- STRINGdb$new(version = '11', species = 7227)
## # string.db.7227.graph <- string.db.7227$get_graph()
## # K.7227 <- net.kernel(string.db.7227.graph)
## # saveRDS(K.7227, 'K7227.rds')
## K.7227 <- readRDS("K7227.rds")
## dim(K.7227)
## rownames(K.7227) <- sub("[[:digit:]]+.", "", rownames(K.7227))
## 
## # load target class (Proteasome)
## kegg.dme <- getGeneKEGGLinks(species.KEGG='dme')
## index <- which(kegg.dme[,2] == 'path:dme03050')
## path.03050 <- kegg.dme[index,1]
## path.03050 <- sub('.*\\_', '', path.03050)
## head(path.03050)
## 
## library(org.Dm.eg.db)
## path2.03050 <- select(org.Dm.eg.db, keys = path.03050,
##                       "FLYBASEPROT", keytype = 'ALIAS')[,2]
## 
## dme03050.infer <- net.infer(path2.03050, K.7227, top = 100)
## gene.id <- data.frame(dme03050.infer$top)[,1]
## head(gene.id)
## rm(K.7227)
## 
## gene.id2 <- as.vector(na.omit(select(org.Dm.eg.db,
##                           keys=as.character(gene.id), "ENTREZID",
##                           keytype = 'FLYBASEPROT')[,2]))
## 
## # functional enrichment
## params <- new("GOHyperGParams", geneIds = gene.id2, annotation = "org.Dm.eg.db",
##               ontology = "BP", pvalueCutoff = 0.001, conditional = FALSE,
##               testDirection="over")
## (hgOver <- hyperGTest(params))
## 
## # Top 10 biological functions related to Proteasome
## ORA.barplot(summary(hgOver), category = "Term", size = "Size",
##             count = "Count", pvalue = "Pvalue", p.adjust.methods = 'fdr')
## 
## 
## ############################## Arabidopsis thaliana
## # string.db.3702 <- STRINGdb$new(version = '11', species = 3702)
## # string.db.3702.graph <- string.db.3702$get_graph()
## # K.3702 <- net.kernel(string.db.3702.graph)
## # saveRDS(K.3702, 'K3702.rds')
## K.3702 <- readRDS("K3702.rds")
## dim(K.3702)
## rownames(K.3702) <- sub("[[:digit:]]+.", "", rownames(K.3702))
## rownames(K.3702) <- gsub("\\..*", "", rownames(K.3702))
## 
## # load target class (Photosynthesis)
## kegg.ath <- getGeneKEGGLinks(species.KEGG = 'ath')
## index <- which(kegg.ath[,2] == 'path:ath00195')
## path.00195 <- kegg.ath[index,1]
## path.00195 <- sub('.*\\_', '', path.00195)
## head(path.00195)
## 
## ath00195.infer <- net.infer(path.00195, K.3702, top = 100)
## gene.id <- data.frame(ath00195.infer$top)[,1]
## head(gene.id)
## rm(K.3702)
## 
## # functional enrichment
## params <- new("GOHyperGParams", geneIds = gene.id, annotation = "org.At.tair.db",
##               ontology = "BP",pvalueCutoff = 0.001,conditional = FALSE,
##               testDirection="over")
## (hgOver <- hyperGTest(params))
## 
## # Top 10 biological functions related to Photosynthesis
## ORA.barplot(summary(hgOver), category = "Term", size = "Size",
##             count = "Count", pvalue = "Pvalue", p.adjust.methods = 'fdr')
## 
## 
## ############################## Zebra fish
## # string.db.7955 <- STRINGdb$new(version = '11', species = 7955)
## # string.db.7955.graph <- string.db.7955$get_graph()
## # K.7955 <- net.kernel(string.db.7955.graph)
## # saveRDS(K.7955, 'K7955.rds')
## K.7955 <- readRDS("K7955.rds")
## dim(K.7955)
## rownames(K.7955) <- sub("[[:digit:]]+.", "", rownames(K.7955))
## 
## # load target class (ErbB signaling pathway)
## kegg.dre <- getGeneKEGGLinks(species.KEGG = 'dre')
## index <- which(kegg.dre[,2] == 'path:dre04012')
## path.04012 <- kegg.dre[index,1]
## path.04012 <- sub('.*\\_', '', path.04012)
## head(path.04012)
## 
## library(org.Dr.eg.db)
## path2.04012 <- select(org.Dr.eg.db, path.04012, c("ENSEMBLPROT"))[,2]
## 
## dre04012.infer <- net.infer(path2.04012, K.7955, top = 100)
## gene.id <- data.frame(dre04012.infer$top)[,1]
## head(gene.id)
## rm(K.7955)
## 
## gene.id2 <- as.vector(na.omit(select(org.Dr.eg.db,
##                                      keys = as.character(gene.id), "ENTREZID",
##                                      keytype = 'ENSEMBLPROT')[,2]))
## 
## # functional enrichment
## params <- new("GOHyperGParams", geneIds = gene.id2, annotation = "org.Dr.eg.db",
##               ontology = "BP",pvalueCutoff = 0.001, conditional = FALSE,
##               testDirection = "over")
## (hgOver <- hyperGTest(params))
## 
## # Top 10 biological functions related to ErbB signaling pathway
## ORA.barplot(summary(hgOver), category = "Term", size = "Size",
##             count = "Count", pvalue = "Pvalue", p.adjust.methods = 'fdr')


###################################################
### code chunk number 20: PPInfer.Rnw:664-665
###################################################
sessionInfo()


