# Code example from 'Path2PPI-tutorial' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo = FALSE, results = 'asis', warning=FALSE----
suppressPackageStartupMessages({
    library("Path2PPI")
})
BiocStyle::markdown()

## -----------------------------------------------------------------------------
data(ai) #Load test data set
ls() #"ai" contains six data objects

## -----------------------------------------------------------------------------
human.ai.proteins
yeast.ai.proteins

## ----echo=FALSE---------------------------------------------------------------
names(human.ai.proteins)

## ----eval=FALSE---------------------------------------------------------------
# str(human.ai.irefindex)
# str(yeast.ai.irefindex)

## -----------------------------------------------------------------------------
head(pa2yeast.ai.homologs)
head(pa2human.ai.homologs)

## -----------------------------------------------------------------------------
ppi <- Path2PPI("Autophagy induction", "Podospora anserina", "5145")

## -----------------------------------------------------------------------------
ppi

## -----------------------------------------------------------------------------
ppi <- addReference(ppi, "Homo sapiens", "9606", human.ai.proteins, 
                    human.ai.irefindex, pa2human.ai.homologs)

## -----------------------------------------------------------------------------
ppi <- addReference(ppi, "Saccharomyces cerevisiae (S288c)", "559292", 
                    yeast.ai.proteins, yeast.ai.irefindex, 
                    pa2yeast.ai.homologs) 

## -----------------------------------------------------------------------------
showReferences(ppi)

## -----------------------------------------------------------------------------
interactions <- showReferences(ppi, species="9606", 
                               returnValue="interactions")
head(interactions)

## -----------------------------------------------------------------------------
ppi <- predictPPI(ppi,h.range=c(1e-60,1e-20))

## -----------------------------------------------------------------------------
ppi #show(ppi)

## -----------------------------------------------------------------------------
set.seed(12) #Set random seed
coordinates <- plot(ppi, return.coordinates=TRUE)

## -----------------------------------------------------------------------------
plot(ppi,multiple.edges=TRUE,vertices.coordinates=coordinates)

## -----------------------------------------------------------------------------
set.seed(40)
target.labels<-c("B2AE79"="PaTOR","B2AXK6"="PaATG1", 
                 "B2AUW3"="PaATG17","B2AM44"="PaATG11",
                 "B2AQV0"="PaATG13","B2B5M3"="PaVAC8")
species.colors <- c("5145"="red","9606"="blue","559292"="green")
plot(ppi,type="hybrid",species.colors=species.colors,
     protein.labels=target.labels)

## -----------------------------------------------------------------------------
showInteraction(ppi,interaction=c("B2AT71","B2AE79"))

## -----------------------------------------------------------------------------
showInteraction(ppi,interaction=c("B2AT71","B2AE79"),mode="detailed",
                verbose=FALSE)

## -----------------------------------------------------------------------------
ref.interaction <- showInteraction(ppi,interaction=c("B2AT71","B2AE79"),
                                   mode="references.detailed",verbose=FALSE)

## -----------------------------------------------------------------------------
ref.interaction[ref.interaction$irigid=="742389",
                c("author","pmids","sourcedb")]

## -----------------------------------------------------------------------------
my.ppi <- getPPI(ppi)
my.ppi

## -----------------------------------------------------------------------------
my.hybrid <- getHybridNetwork(ppi)
my.hybrid

## ----sessionInfo, print=TRUE, eval=TRUE---------------------------------------
sessionInfo()

