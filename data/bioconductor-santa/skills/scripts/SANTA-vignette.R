# Code example from 'SANTA-vignette' vignette. See references/ for full tutorial.

## options(width = 75)
## options(useFancyQuotes=FALSE)
## 

## # generate the simulated network
## require(SANTA, quietly=TRUE)
## require(igraph, quietly=TRUE)
## set.seed(1) # for reproducibility
## g <- barabasi.game(n=500, power=1, m=1, directed=FALSE)

## # measure the distance between pairs of vertices in g
## dist.method <- "shortest.paths"
## D <- DistGraph(g, dist.method=dist.method, verbose=FALSE)

## # place the distances into discreet bins
## B <- BinGraph(D, verbose=FALSE)

## cluster.size <- 5
## s.to.use <- c(10, 20, 50, 100, 500)
## n.trials <- 10
## pvalues <- array(0, dim=c(n.trials, length(s.to.use)),
##     dimnames=list(NULL, as.character(s.to.use)))
## 
## # run the trials for each value of s
## for (s in s.to.use) {    	
##     for (i in 1:n.trials) {
##         # generate the hit set
##         seed.vertex <- sample(vcount(g), 1) # identify seed
##         sample.set <- order(D[seed.vertex, ])[1:s]
##         hit.set <- sample(sample.set, cluster.size)
## 
##         # measure the stength of association
##         g <- set.vertex.attribute(g, name="hits",
##             value=as.numeric(1:vcount(g) %in% hit.set))
##         pvalues[i, as.character(s)] <- Knet(g, nperm=100,
##             dist.method=dist.method, vertex.attr="hits",
##             B=B, verbose=FALSE)$pval
##     }
## }

## boxplot(-log10(pvalues), xlab="cutoff", ylab="-log10(p-value)")

## # cleanup
## rm(B, D, g)

## # create the network
## n.nodes <- 12
## edges <- c(1,2, 1,3, 1,4, 2,3, 2,4, 3,4, 1,5, 5,6,
##            2,7, 7,8, 4,9, 9,10, 3,11, 11,12)
## weights1 <- weights2 <- rep(0, n.nodes)
## weights1[c(1,2)] <- 1
## weights2[c(5,6)] <- 1
## 
## g <- graph.empty(n.nodes, directed=FALSE)
## g <- add.edges(g, edges)
## g <- set.vertex.attribute(g, "weights1", value=weights1)
## g <- set.vertex.attribute(g, "weights2", value=weights2)

## par(mfrow=c(1,2))
## 
## colors <- rep("grey", n.nodes)
## colors[which(weights1 == 1)] <- "red"
## g <- set.vertex.attribute(g, "color", value=colors)
## plot(g)
## 
## colors <- rep("grey", n.nodes)
## colors[which(weights2 == 1)] <- "red"
## g <- set.vertex.attribute(g, "color", value=colors)
## plot(g)
## 
## par(mfrow=c(1,1))
## g <- remove.vertex.attribute(g, "color")

## # set 1
## Knet(g, nperm=100, vertex.attr="weights1", verbose=FALSE)$pval
## Compactness(g, nperm=100, vertex.attr="weights1", verbose=FALSE)$pval
## 
## # set 2
## Knet(g, nperm=100, vertex.attr="weights2", verbose=FALSE)$pval
## Compactness(g, nperm=100, vertex.attr="weights2", verbose=FALSE)$pval

## # load igraph objects
## data(g.costanzo.raw)
## data(g.costanzo.cor)
## networks <- list(raw=g.costanzo.raw, cor=g.costanzo.cor)
## network.names <- names(networks)
## network.genes <- V(networks$raw)$name
## # genes identical across networks

## # obtain the GO term associations from org.Sc.sgd.db package
## library(org.Sc.sgd.db, quietly=TRUE)
## xx <- as.list(org.Sc.sgdGO2ALLORFS)
## go.terms <- c("GO:0000082", "GO:0003682", "GO:0007265",
##               "GO:0040008", "GO:0090329")
## # apply the GO terms to the networks
## for (name in network.names) {
##     for (go.term in go.terms) {
##         networks[[name]] <- set.vertex.attribute(
##             networks[[name]], name=go.term,
##             value=as.numeric(network.genes %in% xx[[go.term]]))
##     }
## }

## results <- list()
## for (name in network.names) {
##     results[[name]] <- Knet(networks[[name]], nperm=10,
##         vertex.attr=go.terms, edge.attr="distance", verbose=FALSE)
##     results[[name]] <- sapply(results[[name]],
##         function(res) res$pval)
## }

## # cleanup
## rm(g.costanzo.cor, g.costanzo.raw, network.genes, networks, xx)

## # load igraph objects
## data(g.bandyopadhyay.treated)
## data(g.bandyopadhyay.untreated)
## networks <- list(
##     treated=g.bandyopadhyay.treated,
##     untreated=g.bandyopadhyay.untreated
## )
## network.names <- names(networks)

## # obtain GO term associations
## library(org.Sc.sgd.db, quietly=TRUE)
## xx <- as.list(org.Sc.sgdGO2ALLORFS)
## # change to use alternative GO terms
## associated.genes <- xx[["GO:0006974"]]
## associations <- sapply(networks, function(g)
##     as.numeric(V(g)$name %in% associated.genes),
##     simplify=FALSE)
## networks <- sapply(network.names, function(name)
##     set.vertex.attribute(networks[[name]], "rdds",
##     value=associations[[name]]), simplify=FALSE)

## results <- sapply(networks, function(g) Knet(g, nperm=10,
##     dist.method="shortest.paths", vertex.attr="rdds",
##     edge.attr="distance"), simplify=FALSE)
## p.values <- sapply(results, function(res) res$pval)
## p.values

## # cleanup
## rm(xx, networks, g.bandyopadhyay.treated, g.bandyopadhyay.untreated, associated.genes)

## # laod igraph object
## data(g.srivas.high)
## data(g.srivas.untreated)
## networks <- list(
##     high=g.srivas.high,
##     untreated=g.srivas.untreated
## )
## network.names <- names(networks)

## # obtain GO term associations
## library(org.Sc.sgd.db, quietly=TRUE)
## xx <- as.list(org.Sc.sgdGO2ALLORFS)
## associated.genes <- xx[["GO:0000725"]]
## associations <- sapply(networks, function(g)
##     as.numeric(V(g)$name %in% associated.genes),
##     simplify=FALSE)
## networks <- sapply(network.names, function(name)
##     set.vertex.attribute(networks[[name]], "dsbr",
##     value=associations[[name]]), simplify=FALSE)

## p.values <- sapply(networks, function(g)
##        Knet(g, nperm=10, dist.method="shortest.paths",
##        vertex.attr="dsbr", edge.attr="distance")$pval)
## p.values

## # cleanup
## rm(xx, networks, g.srivas.high, g.srivas.untreated)

## # import and convert RNAi data
## data(rnai.cheung)
## rnai.cheung <- -log10(rnai.cheung)
## rnai.cheung[!is.finite(rnai.cheung)] <- max(rnai.cheung[is.finite(rnai.cheung)])
## rnai.cheung[rnai.cheung < 0] <- 0

## # import and create IntAct network
## data(edgelist.intact)
## g.intact <- graph.edgelist(as.matrix(edgelist.intact),
##     directed=FALSE)
## 
## # import data and create HumanNet network
## data(edgelist.humannet)
## g.humannet <- graph.edgelist(as.matrix(edgelist.humannet)[,1:2],
##     directed=FALSE)
## g.humannet <- set.edge.attribute(g.humannet, "distance",
##     value=edgelist.humannet$distance)
## networks <- list(intact=g.intact, humannet=g.humannet)

## network.names <- names(networks)
## network.genes <- sapply(networks, get.vertex.attribute,
##     name="name", simplify=FALSE)
## rnai.cheung.genes <- rownames(rnai.cheung)
## cancers <- colnames(rnai.cheung)
## 
## for (cancer in cancers) {
##     for (name in network.names) {
##         vertex.weights <-rep(NA, vcount(networks[[name]]))
##         names(vertex.weights) <- network.genes[[name]]
##         common.genes <- rnai.cheung.genes[rnai.cheung.genes
##             %in% network.genes[[name]]]
##         vertex.weights[common.genes] <- rnai.cheung[common.genes, cancer]
##         networks[[name]] <- set.vertex.attribute(networks[[name]],
##             cancer, value=vertex.weights)
##     }
## }

## knet.res <- sapply(networks, Knet, nperm=10,
##    dist.method="shortest.paths", vertex.attr=cancers,
##    edge.attr="distance", simplify=FALSE)
## p.values <- sapply(knet.res, function(i) sapply(i,
##    function(j) j$pval))
## p.values

## # cleanup
## rm(rnai.cheung, rnai.cheung.genes, networks, network.genes, edgelist.humannet, edgelist.intact, common.genes, g.humannet, g.intact)

## sessionInfo()
