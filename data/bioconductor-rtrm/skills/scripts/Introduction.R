# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, message=FALSE-----------------------------------------
library(ggplot2)
library(knitr)
library(rTRM)
library(org.Mm.eg.db)

## ----fig.wide=TRUE, echo=FALSE, fig.cap="Workflow for the identification of TRMs. Steps 1-3 can be performed with standard Bioconductor approaches. rTRM implements a method to perform step 4."----
knitr::include_graphics("workflow.pdf")

## ----fig.small=TRUE, fig.cap = "Identification of a TRM 1from a test network (left). In the resulting TRM (right) dark blue indicates the target node light blue are query nodes and white nodes are bridge nodes"----
# load the rTRM package
library(rTRM)

# load network example.
load(system.file(package = "rTRM", "extra/example.rda"))

# plot network
plot(g, vertex.size = 20, vertex.label.cex = .8, layout = layout.graphopt)

# define target and query nodes:
target <- "N6"
query <- c("N7", "N12", "N28")

# find TRM:
s <- findTRM(g, target = target, query = query, method = "nsa", max.bridge = 1)

# annotate nodes:
V(s)$color <- "white"
V(s)[ name %in% query]$color <- "steelblue2"
V(s)[ name %in% target]$color <- "steelblue4"

# plot:
plot(s,vertex.size=20,vertex.label.cex=.8)

## -----------------------------------------------------------------------------
pwm <- getMatrices()
head(pwm, 1)

## -----------------------------------------------------------------------------
ann <- getAnnotations()
head(ann)

## -----------------------------------------------------------------------------
map <- getMaps()
head(map)

## -----------------------------------------------------------------------------
o <- getOrthologs(organism = "mouse")
head(o)

## -----------------------------------------------------------------------------
getOrthologFromMatrix("MA0009.1", organism="human")
getOrthologFromMatrix("MA0009.1", organism="mouse")

## -----------------------------------------------------------------------------
# check statistics about the network.
biogrid_mm()
# load mouse PPI network:
data(biogrid_mm)

## ----eval=FALSE---------------------------------------------------------------
# # obtain dataset.
# db <- getBiogridData() # retrieves latest release.
# # db = getBiogridData("3.2.96") # to get a specific release.
# 
# # check release:
# db$release
# db$data
# 
# # process PPI data for different organisms (currently supported human and mouse):
# biogrid_hs <- processBiogrid(db, org = "human")
# biogrid_mm <- processBiogrid(db, org = "mouse")

## ----eval=FALSE---------------------------------------------------------------
# library(PSICQUIC)
# psicquic <- PSICQUIC()
# providers(psicquic)
# 
# # obtain BioGrid human PPIs (as data.frame):
# tbl <- interactions(psicquic, species="9606",provider="BioGrid")
# 
# # the target and source node information needs to be polished (i.e. must be Entrez gene id only)
# biogrid_hs <- data.frame(source=tbl$A,target=tbl$B)
# biogrid_hs$source <- sub(".*locuslink:(.*)\\|BIOGRID:.*","\\1", biogrid_hs$source)
# biogrid_hs$target <- sub(".*locuslink:(.*)\\|BIOGRID:.*","\\1", biogrid_hs$target)
# 
# # create graph.
# library(igraph)
# biogrid_hs <- graph.data.frame(biogrid_hs,directed=FALSE)
# biogrid_hs <- simplify(biogrid_hs)
# 
# # annotate with symbols.
# library(org.Hs.eg.db)
# V(biogrid_hs)$label <- select(org.Hs.eg.db,keys=V(biogrid_hs)$name,columns=c("SYMBOL"))$SYMBOL

## -----------------------------------------------------------------------------
# read motif enrichment results.
motif_file <- system.file("extra/sox2_motif_list.rda", package = "rTRM")
load(motif_file)
length(motif_list)
head(motif_list)

## -----------------------------------------------------------------------------
# get the corresponding gene.
tfs_list <- getOrthologFromMatrix(motif_list, organism = "mouse")
tfs_list <- unique(unlist(tfs_list, use.names = FALSE))
length(tfs_list)
head(tfs_list)

## -----------------------------------------------------------------------------
# load expression data.
eg_esc_file <- system.file("extra/ESC-expressed.txt", package = "rTRM")
eg_esc <- scan(eg_esc_file, what = "")
length(eg_esc)
head(eg_esc)

tfs_list_esc <- tfs_list[tfs_list %in% eg_esc]
length(tfs_list_esc)
head(tfs_list_esc)

## -----------------------------------------------------------------------------
# load and process PPI data.
biogrid_mm()
data(biogrid_mm)
ppi <- biogrid_mm
vcount(ppi)
ecount(ppi)

# remove outliers.
f <- c("Ubc", "Sumo1", "Sumo2", "Sumo3")
f <- select(org.Mm.eg.db, keys = f, columns = "ENTREZID", keytype = "SYMBOL")$ENTREZID
f

ppi <- removeVertices(ppi, f)
vcount(ppi)
ecount(ppi)

# filter by expression.
ppi_esc <- induced.subgraph(ppi, V(ppi)[ name %in% eg_esc ])
vcount(ppi_esc)
ecount(ppi_esc)

# ensure a single component.
ppi_esc <- getLargestComp(ppi_esc)
vcount(ppi_esc)
ecount(ppi_esc)

## -----------------------------------------------------------------------------
# define target.
target <- select(org.Mm.eg.db,keys="Sox2",columns="ENTREZID",keytype="SYMBOL")$ENTREZID
target

# find TRM.
s <- findTRM(ppi_esc, target, tfs_list_esc, method = "nsa", max.bridge = 1)
vcount(s)
ecount(s)

## ----fig.small=TRUE, fig.cap = "Sox2 specific TRM in ESCs."-------------------
# generate layout (order by cluster, then label)
cl <- getConcentricList(s, target, tfs_list_esc)
l <- layout.concentric(s, cl, order = "label")

# plot TRM.
plotTRM(s, layout = l, vertex.cex = 15, label.cex = .8)
plotTRMlegend(s, title = "ESC Sox2 TRM", cex = .8)

## -----------------------------------------------------------------------------
library(rTRM)
library(BSgenome.Mmusculus.UCSC.mm8.masked) # Sox2 peaks found against mm8
library(PWMEnrich)
registerCoresPWMEnrich(1) # register number of cores for parallelization in PWMEnrich
library(MotifDb)

# select mouse PWMs:
sel.mm <- values(MotifDb)$organism %in% c("Mmusculus")
pwm.mm <- MotifDb[sel.mm]

## -----------------------------------------------------------------------------
# generate logn background model of PWMs:
p <- as.list(pwm.mm)
p <- lapply(p, function(x) round(x * 100))
p <- lapply(p, function(x) t(apply(x, 1, as.integer)))

## ----eval=FALSE---------------------------------------------------------------
# pwm_logn <- makeBackground(p, Mmusculus, type = "logn")

## ----echo=FALSE---------------------------------------------------------------
load(system.file("extra/pwm_mm_logn.rda", package = "rTRM"))

## -----------------------------------------------------------------------------
sox2_bed <- read.table(system.file("extra/ESC_Sox2_peaks.txt", package = "rTRM"))

colnames(sox2_bed) <- c("chr", "start", "end")

sox2_seq <- getSequencesFromGenome(sox2_bed, Mmusculus, append.id="Sox2")

# PWMEnrich throws an error if the sequences are shorter than the motifs so we filter those sequences.
min.width <- max(sapply(p, ncol))
sox2_seq_filter <- sox2_seq[width(sox2_seq) >= min.width]

## ----eval=FALSE---------------------------------------------------------------
# # find enrichment:
# sox2_enr <- motifEnrichment(sox2_seq_filter, pwms=pwm_logn, group.only=TRUE)

## ----echo=FALSE---------------------------------------------------------------
load(system.file("extra/sox2_enr.rda", package = "rTRM"))

## ----fig.small=TRUE, fig.cap="Density of log2(raw.score) for group. The selected cutoff is indicated with a red line."----
res <- groupReport(sox2_enr)

plot(density(res$raw.score),main="",log="x",xlab="log(raw.score)")
abline(v=log2(5),col="red")
mtext(text="log2(5)",at=log2(5),side=3,cex=.8,col="red")

res.gene <- unique(values(MotifDb[res$id[res$raw.score > 5]])$geneId)
res.gene <- unique(na.omit(res.gene))

## ----fig.small=TRUE, fig.cap="Sox2 TRM identified using PWMEnrich for the motif enrichment."----
data(biogrid_mm)
ppi <- biogrid_mm
vcount(ppi)
ecount(ppi)

f <- c("Ubc", "Sumo1", "Sumo2", "Sumo3")
f <- select(org.Mm.eg.db,keys=f,columns="ENTREZID",keytype="SYMBOL")$ENTREZID
ppi <- removeVertices(ppi, f)
vcount(ppi)
ecount(ppi)

# filter by expression.
eg_esc <- scan(system.file("extra/ESC-expressed.txt", package = "rTRM"), what = "")
ppi_esc <- induced.subgraph(ppi, V(ppi)[ name %in% eg_esc ])
vcount(ppi_esc)
ecount(ppi_esc)

# ensure a single component.
ppi_esc <- getLargestComp(ppi_esc)
vcount(ppi_esc)
ecount(ppi_esc)

sox2.gene <- select(org.Mm.eg.db,keys="Sox2",columns="ENTREZID",keytype="SYMBOL")$ENTREZID
sox2_trm <- findTRM(ppi_esc, target=sox2.gene, query = res.gene)

cl <- getConcentricList(sox2_trm, t=sox2.gene,e=res.gene)
l <- layout.concentric(sox2_trm, concentric=cl, order="label")
plotTRM(sox2_trm, layout = l, vertex.cex = 15, label.cex = .8)
plotTRMlegend(sox2_trm, title = "ESC Sox2 TRM", cex = .8)

## ----fig.small=TRUE, fig.cap="Similarity between the TRMs predicted using motif enrichment information from PWMEnrich and HOMER."----
m <- getSimilarityMatrix(list(PWMEnrich = sox2_trm, HOMER = s))
m

d <- as.data.frame.table(m)
g <- ggplot(d, aes(x = Var1, y = Var2, fill = Freq)) + 
  geom_tile() +
  scale_fill_gradient2(
    limit = c(0, 100),
    low = "white",
    mid = "darkblue",
    high = "orange",
    guide = guide_legend("similarity", reverse = TRUE),
    midpoint = 50
  ) +
  labs(x = NULL, y = NULL) +
  theme(aspect.ratio = 1,
        axis.text.x = element_text(
          angle = 90,
          vjust = .5,
          hjust = 1
        ))

## ----fig.small=TRUE, fig.width=2.5,fig.height=2.5,fig.cap="Sox2 TRM obtained with PWMEnrich workflow and layout.concentric is shown in the left. Same TRM with layout.arc is shown in the right."----
plotTRM(sox2_trm, layout = l, vertex.cex = 15, label.cex = .7)
l=layout.arc(sox2_trm,target=sox2.gene,query=res.gene)
plotTRM(sox2_trm, layout=l,vertex.cex=15,label.cex=.7)

## -----------------------------------------------------------------------------
citation(package = "rTRM")

## -----------------------------------------------------------------------------
sessionInfo()

