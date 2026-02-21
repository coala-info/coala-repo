# Code example from 'biodbKegg' vignette. See references/ for full tutorial.

## ---- eval=FALSE--------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install('biodbKegg')

## ---- results='hide'----------------------------------------------------------
mybiodb <- biodb::newInst()

## -----------------------------------------------------------------------------
kegg.comp.conn <- mybiodb$getFactory()$createConn('kegg.compound')

## -----------------------------------------------------------------------------
entries <- kegg.comp.conn$getEntry(c('C00133', 'C00751'))
entries

## -----------------------------------------------------------------------------
x <- mybiodb$entriesToDataframe(entries, compute=FALSE)
x

## -----------------------------------------------------------------------------
ids <- kegg.comp.conn$searchForEntries(list(monoisotopic.mass=list(value=64, delta=2.0)), max.results=10)
entries <- mybiodb$getFactory()$getEntry('kegg.compound', ids)

## ----Data frame with a column containing KEGG Compound IDs--------------------
kegg.comp.ids <- c('C06144', 'C06178', 'C02659')
mydf <- data.frame(kegg.ids=kegg.comp.ids)

## ----Calling addInfo()--------------------------------------------------------
kegg.comp.conn$addInfo(mydf, id.col='kegg.ids', org='mmu')

## -----------------------------------------------------------------------------
kegg.comp.ids <- c('C06144', 'C06178', 'C02659')
pathways <- kegg.comp.conn$getPathwayIds(kegg.comp.ids, 'mmu')
pathways

## -----------------------------------------------------------------------------
path.per.comp <- kegg.comp.conn$getPathwayIdsPerCompound(kegg.comp.ids, 'mmu')
fct <- function(i) {
    if (i %in% names(path.per.comp)) length(path.per.comp[[i]]) else 0
}
nb_mmu_gene_pathways <- vapply(kegg.comp.ids, fct, FUN.VALUE=0)
names(nb_mmu_gene_pathways) <- kegg.comp.ids

## -----------------------------------------------------------------------------
nb_mmu_gene_pathways

## ----Getting a connector to the KEGG Pathway database-------------------------
kegg.path.conn <- mybiodb$getFactory()$getConn('kegg.pathway')

## ----Building a pathway graph-------------------------------------------------
kegg.path.conn$buildPathwayGraph(pathways[[1]])

## ----Getting an igraph for the pathway----------------------------------------
ig <- kegg.path.conn$getPathwayIgraph(pathways[[1]])

## ----Plotting the pathway igraph----------------------------------------------
vert <- igraph::as_data_frame(ig, 'vertices')
shapes <- vapply(vert[['type']], function(x) if (x == 'reaction') 'rectangle'
                 else 'circle', FUN.VALUE='', USE.NAMES=FALSE)
colors <- vapply(vert[['type']], function(x) if (x == 'reaction') 'yellow' else
    'red', FUN.VALUE='', USE.NAMES=FALSE)
plot(ig, vertex.shape=shapes, vertex.color=colors, vertex.label.dist=1,
     vertex.size=4, vertex.size2=4)

## ----Getting the enzymes------------------------------------------------------
kegg.enz.ids <- mybiodb$entryIdsToSingleFieldValues(kegg.comp.ids,
                                                    db='kegg.compound',
                                                    field='kegg.enzyme.id')
kegg.enz.ids

## ----Attributing colors to entries--------------------------------------------
color2ids <- list(yellow=kegg.enz.ids, red=kegg.comp.ids)

## ----Creating a decorated pathway picture, message=FALSE----------------------
kegg.path.conn$getDecoratedGraphPicture(pathways[[1]],
	color2ids=color2ids)

## -----------------------------------------------------------------------------
mybiodb$terminate()

## -----------------------------------------------------------------------------
sessionInfo()

