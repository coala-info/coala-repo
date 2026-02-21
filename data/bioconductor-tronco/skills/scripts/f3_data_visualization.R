# Code example from 'f3_data_visualization' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(TRONCO)
data(aCML)
data(crc_maf)
data(crc_gistic)
data(crc_plain)

## -----------------------------------------------------------------------------
view(aCML)

## -----------------------------------------------------------------------------
as.genotypes(aCML)[1:10,5:10]

## -----------------------------------------------------------------------------
as.events(aCML)[1:5, ]
as.events.in.sample(aCML, sample = 'patient 2')

## -----------------------------------------------------------------------------
as.genes(aCML)[1:8]

## -----------------------------------------------------------------------------
as.types(aCML)
as.colors(aCML)

## -----------------------------------------------------------------------------
head(as.gene(aCML, genes='SETBP1'))

## -----------------------------------------------------------------------------
as.samples(aCML)[1:10]

## -----------------------------------------------------------------------------
which.samples(aCML, gene='TET2', type='Nonsense point')

## -----------------------------------------------------------------------------
dataset = as.alterations(aCML)

## -----------------------------------------------------------------------------
view(dataset)

## -----------------------------------------------------------------------------
ngenes(aCML)
nevents(aCML)
nsamples(aCML)
ntypes(aCML)
npatterns(aCML)

## ----fig.width=6, fig.height=5, fig.cap="This plot gives a graphical visualization of the events that are in the dataset -- with a color per event type. It sorts samples to enhance exclusivity patterns among the events"----
oncoprint(aCML)

## ----fig.width=5, fig.height=5, fig.cap="This plot gives a graphical visualization of the events that are in the dataset -- with a color per event type. It it clusters samples/events"----
oncoprint(aCML, 
    legend = FALSE, 
    samples.cluster = TRUE, 
    gene.annot = list(one = list('NRAS', 'SETBP1'), two = list('EZH2', 'TET2')),
    gene.annot.color = 'Set2',
    genes.cluster = TRUE)

## -----------------------------------------------------------------------------
stages = c(rep('stage 1', 32), rep('stage 2', 32))
stages = as.matrix(stages)
rownames(stages) = as.samples(aCML)
dataset = annotate.stages(aCML, stages = stages)
has.stages(aCML)
head(as.stages(dataset))

## -----------------------------------------------------------------------------
head(as.stages(dataset))

## ----fig.width=6, fig.height=5------------------------------------------------
oncoprint(dataset, legend = FALSE)

## ----fig.width=6, fig.height=5, fig.cap="Example \texttt{oncoprint} output for aCML data with randomly annotated stages, in left, and samples clustered by group assignment in right -- for simplicity the group variable is again the stage annotation."----
oncoprint(dataset, group.samples = as.stages(dataset))

## -----------------------------------------------------------------------------
pathway = as.pathway(aCML,
    pathway.genes = c('SETBP1', 'EZH2', 'WT1'),
    pathway.name = 'MyPATHWAY',
    pathway.color = 'red',
    aggregate.pathway = FALSE)

## ----onco-pathway, fig.width=6.5, fig.height=2, fig.cap="Oncoprint output of a custom pathway called MyPATHWAY involving genes SETBP1, EZH2 and WT1; the genotype of each event is shown."----
oncoprint(pathway, title = 'Custom pathway',  font.row = 8, cellheight = 15, cellwidth = 4)

## ----fig.width=6.5, fig.height=1.8, fig.cap="Oncoprint output of a custom pair of pathways, with events shown"----
pathway.visualization(aCML, 
    pathways=list(P1 = c('TET2', 'IRAK4'),  P2=c('SETBP1', 'KIT')),        
    aggregate.pathways=FALSE,
    font.row = 8)

## ----fig.width=6.5, fig.height=1, fig.cap="Oncoprint output of a custom pair of pathways, with events hidden"----
pathway.visualization(aCML, 
    pathways=list(P1 = c('TET2', 'IRAK4'),  P2=c('SETBP1', 'KIT')),
    aggregate.pathways = TRUE,
    font.row = 8)

## ----eval=FALSE---------------------------------------------------------------
# library(rWikiPathways)
# # quotes inside query to require both terms
# my.pathways <- findPathwaysByText('SETBP1 EZH2 TET2 IRAK4 SETBP1 KIT')
# human.filter <- lapply(my.pathways, function(x) x$species == "Homo sapiens")
# my.hs.pathways <- my.pathways[unlist(human.filter)]
# # collect pathways idenifiers
# my.wpids <- sapply(my.hs.pathways, function(x) x$id)
# 
# pw.title<-my.hs.pathways[[1]]$name
# pw.genes<-getXrefList(my.wpids[1],"H")

## ----wikipathways, eval=FALSE-------------------------------------------------
# browseURL(getPathwayInfo(my.wpids[1])[2])
# browseURL(getPathwayInfo(my.wpids[2])[2])
# browseURL(getPathwayInfo(my.wpids[3])[2])

