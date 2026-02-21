# Code example from 'ClusterJudge-intro' vignette. See references/ for full tutorial.

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
devtools::load_all('.')

## ----warning=FALSE, message=FALSE---------------------------------------------
library('yeastExpData')

## ----echo=TRUE----------------------------------------------------------------
data(ccyclered)
head(ccyclered)

## -----------------------------------------------------------------------------
clusters <- ccyclered$Cluster
###  convert from Gene names to the new standard of Saccharomyces Genome Database (SGD) gene ids
ccyclered$SGDID <- sub('^S','S00',ccyclered$SGDID)
names(clusters) <- ccyclered$SGDID
str(clusters)

## ----fig.show='hold', echo=TRUE-----------------------------------------------
data(Yeast.GO.assocs);
str(Yeast.GO.assocs);
head(Yeast.GO.assocs);
validate_association(Yeast.GO.assocs)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# library(biomaRt)
# rn <-  useDataset("rnorvegicus_gene_ensembl", mart=useMart("ensembl"))
# rgd.symbol=c("As3mt", "Borcs7", "Cyp17a1", "Wbp1l", "Sfxn2", "Arl3") ### exemplify for a limited set of  genes
# entity.attr  <- getBM(attributes=c('rgd_symbol','go_id'), filters='rgd_symbol', values=rgd.symbol, mart=rn)

## ----fig.width=6, fig.height=4------------------------------------------------
entities_attribute_stats(Yeast.GO.assocs) ### shows number of entities per attribute distribution
Yeast.GO.assocs.cons1 <- consolidate_entity_attribute(
       entity.attribute = Yeast.GO.assocs
     , min.entities.per.attr =3  ### keep only attributes associated to 3 or more entities
     , mut.inf=FALSE
     )

dim(Yeast.GO.assocs)
dim(Yeast.GO.assocs.cons1) ### shows reduction in the number of associations

## ----fig.width=6, fig.height=4------------------------------------------------
data(mi.GO.Yeast)
Yeast.GO.assocs.cons <- consolidate_entity_attribute(
     entity.attribute = Yeast.GO.assocs
   , min.entities.per.attr =3
   , mut.inf=mi.GO.Yeast   ### use precalculated mutual information
   , U.limit = c(0.1, 0.001) ### calculate consolidated association for these uncertainty levels
   ) ### shows distribution of the number of pairs of attributes by Uncertainty 
str(Yeast.GO.assocs.cons)                                                   

## -----------------------------------------------------------------------------
data(Yeast.GO.assocs) 
### because it takes time, we use a small sampled subset of associations
entity.attribute.sampled <- Yeast.GO.assocs[sample(1:nrow(Yeast.GO.assocs),100),]
mi.GO.Yeast.sampled <- attribute_mut_inf(
    entity.attribute = entity.attribute.sampled
  , show.progress    = FALSE  ## for this small example do not print progress
  )  
str(mi.GO.Yeast.sampled)

## ----fig.width=6, fig.height=4------------------------------------------------
mi.by.swaps<-clusterJudge(
    clusters = clusters
  , entity.attribute=Yeast.GO.assocs.cons[["0.001"]]
  , plot.notes='Yeast clusters judged at uncertainty level 0.001 - Ref: Tavazoie S,& all 
`Systematic determination of genetic network architecture. Nat Genet. 1999`'
, plot.saveRDS.file= 'cj.rds') ### save the plot for later use  

p <- readRDS('cj.rds') ### retrieve the previous plot
pdf('cj.pdf'); plot(p); dev.off() ### plot on another device

