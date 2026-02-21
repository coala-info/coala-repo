# Code example from 'zebrafish' vignette. See references/ for full tutorial.

## ----warning=FALSE, message=FALSE, results='hide'-----------------------------
library(FELLA)

library(igraph)
library(magrittr)

set.seed(1)
# Filter the dre01100 overview pathway, as in the article
graph <- buildGraphFromKEGGREST(
    organism = "dre", 
    filter.path = c("01100"))

tmpdir <- paste0(tempdir(), "/my_database")
# Make sure the database does not exist from a former vignette build
# Otherwise the vignette will rise an error 
# because FELLA will not overwrite an existing database
unlink(tmpdir, recursive = TRUE)  
buildDataFromGraph(
    keggdata.graph = graph, 
    databaseDir = tmpdir, 
    internalDir = FALSE, 
    matrices = "none", 
    normality = "diffusion", 
    niter = 100)

## ----warning=FALSE, message=FALSE, results='hide'-----------------------------
fella.data <- loadKEGGdata(
    databaseDir = tmpdir, 
    internalDir = FALSE, 
    loadMatrix = "none"
)

## -----------------------------------------------------------------------------
fella.data

## -----------------------------------------------------------------------------
cpd.liver <- c(
    "C12623", 
    "C01179", 
    "C05350", 
    "C05598", 
    "C01586"
)

analysis.liver <- enrich(
    compounds = cpd.liver, 
    data = fella.data, 
    method = "diffusion", 
    approx = "normality")

## -----------------------------------------------------------------------------
analysis.liver %>% 
    getInput %>% 
    getName(data = fella.data)

## ----fig.width=8, fig.height=8------------------------------------------------
plot(
    analysis.liver, 
    method = "diffusion", 
    data = fella.data, 
    nlimit = 250,  
    plotLegend = FALSE)

## -----------------------------------------------------------------------------
g.liver <-  generateResultsGraph(
    object = analysis.liver, 
    data = fella.data, 
    method = "diffusion")

tab.liver <- generateResultsTable(
    object = analysis.liver, 
    data = fella.data, 
    method = "diffusion")

## -----------------------------------------------------------------------------
g.liver

## -----------------------------------------------------------------------------
path.fig2 <- "dre00360" # Phenylalanine metabolism
path.fig2 %in% V(g.liver)$name

## -----------------------------------------------------------------------------
tab.liver[tab.liver$Entry.type == "pathway", ]

## -----------------------------------------------------------------------------
cpd.liver %in% V(g.liver)$name

## -----------------------------------------------------------------------------
cpd.fig2 <- c(
    "C00079", # Phenylalanine
    "C00082"  # Tyrosine
)
cpd.fig2 %in% V(g.liver)$name

## -----------------------------------------------------------------------------
cpd.plasma <- c(
    "C16323", 
    "C00740", 
    "C08323", 
    "C00623", 
    "C00093", 
    "C06429", 
    "C16533", 
    "C00740", 
    "C06426", 
    "C06427", 
    "C07289", 
    "C01879"
) %>% unique

analysis.plasma <- enrich(
    compounds = cpd.plasma, 
    data = fella.data, 
    method = "diffusion", 
    approx = "normality")

## -----------------------------------------------------------------------------
analysis.plasma %>% 
    getInput %>% 
    getName(data = fella.data)

## ----fig.width=8, fig.height=8------------------------------------------------
plot(
    analysis.plasma, 
    method = "diffusion", 
    data = fella.data, 
    nlimit = 250,  
    plotLegend = FALSE)

## -----------------------------------------------------------------------------
g.plasma <-  generateResultsGraph(
    object = analysis.plasma, 
    data = fella.data, 
    method = "diffusion")

tab.plasma <- generateResultsTable(
    object = analysis.plasma, 
    data = fella.data, 
    method = "diffusion")

## -----------------------------------------------------------------------------
g.plasma

## -----------------------------------------------------------------------------
tab.plasma[tab.plasma$Entry.type == "pathway", ]

## -----------------------------------------------------------------------------
path.fig3 <- c(
    "dre00591", # Linoleic acid metabolism
    "dre01040", # Biosynthesis of unsaturated fatty acids
    "dre00592", # alpha-Linolenic acid metabolism
    "dre00564", # Glycerophospholipid metabolism
    "dre00480", # Glutathione metabolism
    "dre00260"  # Glycine, serine and threonine metabolism
)
path.fig3 %in% V(g.plasma)$name

## -----------------------------------------------------------------------------
cpd.plasma %in% V(g.plasma)$name

## -----------------------------------------------------------------------------
cpd.fig3 <- c(
    "C01595", # Linoleic acid
    "C00157", # Phosphatidylcholine
    "C00037"  # Glycine
) 
cpd.fig3 %in% V(g.plasma)$name

## -----------------------------------------------------------------------------
sessionInfo()

## -----------------------------------------------------------------------------
cat(getInfo(fella.data))

## -----------------------------------------------------------------------------
date()

## -----------------------------------------------------------------------------
tempfile(pattern = "vignette_dre_", fileext = ".RData") %T>% 
    message("Saving workspace to ", .) %>% 
    save.image(compress = "xz")

