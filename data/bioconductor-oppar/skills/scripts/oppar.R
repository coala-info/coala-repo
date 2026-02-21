# Code example from 'oppar' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
require(knitr)
knitr::opts_chunk$set(message = FALSE, 
											library(oppar), 
											suppressPackageStartupMessages(library(Biobase)),
											suppressPackageStartupMessages(library(limma)),
											suppressPackageStartupMessages(library(GO.db)),
											suppressPackageStartupMessages(library(org.Hs.eg.db))
											)


## -----------------------------------------------------------------------------
data(Tomlins) # loads processed Tomlins data

# the first 21 samples are Normal samples, and the rest of 
# the samples are our cases (metastatic). We, thus, generate a group
# variable for the samples based on this knowledge.

g <- factor(c(rep(0,21),rep(1,ncol(exprs(eset)) - 21)))
g


# Apply opa on Tomlins data, to detect outliers relative to the
# lower 10% (lower.quantile = 0.1) and upper 5% (upper.quantile = 0.95 -- Default) of 
# gene expressions.
tomlins.opa <- opa(eset, group = g, lower.quantile = 0.1)
tomlins.opa


## -----------------------------------------------------------------------------
tomlins.opa$profileMatrix[1:6,1:5]
tomlins.opa$upper.quantile
tomlins.opa$lower.quantile

## -----------------------------------------------------------------------------
getSampleOutlier(tomlins.opa, c(1,5))


## -----------------------------------------------------------------------------

outlier.list <- getSubtypeProbes(tomlins.opa, 1:ncol(tomlins.opa$profileMatrix))

## -----------------------------------------------------------------------------
# gene set testing with limma::mroast
#BiocManager::install(org.Hs.eg.db)
library(org.Hs.eg.db)
library(limma)
org.Hs.egGO2EG
go2eg <- as.list(org.Hs.egGO2EG)
head(go2eg)

# Gene Set analysis using rost from limma

# need to subset gene express data based on up outliers
up.mtrx <- exprs(eset)[fData(eset)$ID %in% outlier.list[["up"]], ]
# get Entrez gene IDs for genes in up.mtrx

entrez.ids.up.mtrx <- fData(eset)$Gene.ID[fData(eset)$ID %in% rownames(up.mtrx)]

# find the index of genes in GO gene set in the gene expression matrix
gset.idx <- lapply(go2eg, function(x){
	match(x, entrez.ids.up.mtrx)
})

# remove missing values
gset.idx <- lapply(gset.idx, function(x){
	x[!is.na(x)]
})

# removing gene sets with less than 10 elements
gset.ls <- unlist(lapply(gset.idx, length))
gset.idx <- gset.idx[which(gset.ls > 10)]

# need to define a model.matrix for mroast
design <- model.matrix(~ g)
up.mroast <- mroast(up.mtrx, index = gset.idx, design = design) 
head(up.mroast, n=5)

## -----------------------------------------------------------------------------
go.terms <- rownames(up.mroast[1:10,])
#BiocManager::install(GO.db)
library(GO.db)
columns(GO.db)
keytypes(GO.db)

r2tab <- select(GO.db, keys=go.terms,
                columns=c("GOID","TERM"), 
                keytype="GOID")
r2tab

## -----------------------------------------------------------------------------
library(org.Hs.eg.db)
library(limma)
org.Hs.egGO2EG
go2eg <- as.list(org.Hs.egGO2EG)
head(go2eg)
# subsetting gene expression matrix based on down outliers
down_mtrx <- exprs(eset)[fData(eset)$ID %in% outlier.list[["down"]], ]
entrez_ids_down_mtrx <- fData(eset)$Gene.ID[fData(eset)$ID %in% rownames(down_mtrx)]

gset_idx_down <- lapply(go2eg, function(x){
	match(x, entrez_ids_down_mtrx)
})

# remove missing values
gset_idx_down <- lapply(gset_idx_down, function(x){
	x[!is.na(x)]
})

# removing gene sets with less than 10 elements
gset_ls_down <- unlist(lapply(gset_idx_down, length))
gset_idx_down <- gset_idx_down[which(gset_ls_down > 10)]

# apply mroast
down_mroast <- mroast(down_mtrx, gset_idx_down, design) 
head(down_mroast, n=5)

## -----------------------------------------------------------------------------

go_terms_down <- rownames(down_mroast[1:10,])

dr2tab <- select(GO.db, keys=go_terms_down,
                columns=c("GOID","TERM"), 
                keytype="GOID")
dr2tab


## -----------------------------------------------------------------------------
data("Maupin")
names(maupin)
head(maupin$data)
head(maupin$sig)

geneSet<- maupin$sig$EntrezID    #Symbol  ##EntrezID # both up and down genes:

up_sig<- maupin$sig[maupin$sig$upDown == "up",]
d_sig<- maupin$sig[maupin$sig$upDown == "down",]
u_geneSet<- up_sig$EntrezID   #Symbol   # up_sig$Symbol  ## EntrezID
d_geneSet<- d_sig$EntrezID

enrichment_scores <- gsva(maupin$data, list(up = u_geneSet, down= d_geneSet), mx.diff=1,
               verbose=TRUE, abs.ranking=FALSE, is.gset.list.up.down=TRUE, parallel.sz = 1 )$es.obs
			


head(enrichment_scores)

## calculating enrichment scores using ssgsea method
# es.dif.ssg <- gsva(maupin, list(up = u_geneSet, down= d_geneSet),
# 														 verbose=TRUE, abs.ranking=FALSE, is.gset.list.up.down=TRUE,
# 														 method = "ssgsea")

## ----fig.width= 6, fig.height= 5, fig.align= "center"-------------------------
hist(enrichment_scores, main = "enrichment scores", xlab="es")
lines(density(enrichment_scores[,1:3]), col = "blue") # control samples
lines(density(enrichment_scores[,4:6]), col = "red") # TGFb samples
legend("topleft", c("Control","TGFb"), lty = 1, col=c("blue","red"), cex = 0.6)



