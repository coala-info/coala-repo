# Code example from 'introduction' vignette. See references/ for full tutorial.

### R code from vignette source 'introduction.rnw'

###################################################
### code chunk number 1: tPR
###################################################
library(pageRank)
set.seed(1)
graph1 <- igraph::erdos.renyi.game(100, 0.01, directed = TRUE)
igraph::V(graph1)$name <- 1:100
#the 1st graph with name as vertex attributes
set.seed(2)
graph2 <- igraph::erdos.renyi.game(100, 0.01, directed = TRUE)
igraph::V(graph2)$name <- 1:100
#the 2nd graph with name as vertex attributes
diff_graph(graph1, graph2)


###################################################
### code chunk number 2: mPR
###################################################
set.seed(1)
graph1 <- igraph::erdos.renyi.game(100, 0.01, directed = TRUE)
igraph::V(graph1)$name <- 1:100
igraph::V(graph1)$pagerank <- igraph::page_rank(graph1)$vector
#the base graph with pagerank and name as vertex attributes.
set.seed(2)
graph2 <- igraph::erdos.renyi.game(100, 0.01, directed = TRUE)
igraph::V(graph2)$name <- 1:100
igraph::V(graph2)$pagerank <- igraph::page_rank(graph2)$vector
#the supplemental graph with pagerank and name as vertex attributes.
multiplex_page_rank(graph1, graph2)


###################################################
### code chunk number 3: clean_graph
###################################################
set.seed(1)
graph <- igraph::erdos.renyi.game(100, 0.01, directed = TRUE)
igraph::V(graph)$name <- 1:100
igraph::V(graph)$pagerank <- igraph::page_rank(graph)$vector
#the graph to be cleaned, with pagerank and name as vertex attributes.
clean_graph(graph, size=5)


###################################################
### code chunk number 4: adjust_graph
###################################################
set.seed(1)
graph <- igraph::erdos.renyi.game(100, 0.01, directed = TRUE)
igraph::V(graph)$name <- 1:100
igraph::V(graph)$pagerank <- igraph::page_rank(graph, damping=0.85)$vector
#the graph to be adjusted, with pagerank and name as vertex attributes.
adjust_graph(graph, damping=0.1)


###################################################
### code chunk number 5: aracne_network
###################################################
library(bcellViper)
data(bcellViper)
head(aracne_network(regulon[1:10]))


###################################################
### code chunk number 6: accessibility_network
###################################################
table <- data.frame(Chr=c("chr1", "chr1"), Start=c(713689, 856337), End=c(714685, 862152),
                    row.names=c("A", "B"), stringsAsFactors=FALSE)
regulators=c("FOXF2", "MZF1")
#peaks and regulators to be analyzed

library(GenomicRanges)
library(GenomicFeatures)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)
library(annotate)
promoter <- promoters(genes(TxDb.Hsapiens.UCSC.hg19.knownGene))
names(promoter) <- getSYMBOL(names(promoter), data="org.Hs.eg")
promoter <- promoter[!is.na(names(promoter))]
#get promoter regions

library(JASPAR2018)
library(TFBSTools)
library(motifmatchr)
pfm <- getMatrixSet(JASPAR2018, list(species="Homo sapiens"))
pfm <- pfm[unlist(lapply(pfm, function(x) name(x))) %in% regulators]
#get regulator position frequency matrix (PFM) list

library(BSgenome.Hsapiens.UCSC.hg19)
accessibility_network(table, promoter, pfm, "BSgenome.Hsapiens.UCSC.hg19")


###################################################
### code chunk number 7: conformation_network
###################################################
table <- data.frame(Chr1=c("chr1", "chr1"), Position1=c(569265, 713603), Strand1=c("+", "+"),
                    Chr2=c("chr4", "chr1"), Position2=c(206628, 715110), Strand2=c("+", "-"),
                    row.names=c("A", "B"), stringsAsFactors=FALSE)
regulators=c("FOXF2", "MZF1")
#peaks and regulators to be analyzed

promoter <- promoters(genes(TxDb.Hsapiens.UCSC.hg19.knownGene))
names(promoter) <- getSYMBOL(names(promoter), data="org.Hs.eg")
promoter <- promoter[!is.na(names(promoter))]
#get promoter regions

pfm <- getMatrixSet(JASPAR2018, list(species="Homo sapiens"))
pfm <- pfm[unlist(lapply(pfm, function(x) name(x))) %in% regulators]
#get regulator position frequency matrix (PFM) list

conformation_network(table, promoter, pfm, "BSgenome.Hsapiens.UCSC.hg19")


###################################################
### code chunk number 8: P_graph
###################################################
dset <- exprs(dset)
net <- do.call(rbind, lapply(1:10, function(i, regulon){
  data.frame(reg=rep(names(regulon)[i], 10),
             target=names(regulon[[i]][[1]])[1:10],
             stringsAsFactors = FALSE)}, regulon=regulon))
P_graph(dset, net, method="difference", null=NULL, threshold=0.05)


###################################################
### code chunk number 9: session_information
###################################################
sessionInfo()


