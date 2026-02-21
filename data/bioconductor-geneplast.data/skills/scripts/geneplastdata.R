# Code example from 'geneplastdata' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
#  library('AnnotationHub')
#  ah <- AnnotationHub()
#  meta <- query(ah, "geneplast")
#  head(meta)

## ----eval=FALSE---------------------------------------------------------------
#  # Dataset derived from STRING database v11.0
#  load(meta[["AH83116"]])

## -----------------------------------------------------------------------------
species <- data.frame (
    label = c("sp01", "sp02", "sp03", "sp04", "sp05", "sp06", "sp07", "sp08", "sp09", "sp10", "sp11", "sp12", "sp13", "sp14", "sp15"),
                scientific_name = c("Homo sapiens", "Pan troglodytes", "Gorilla gorilla gorilla", "Macaca mulatta", "Papio anubis", "Rattus norvegicus", "Mus musculus", "Canis lupus familiaris", "Marmosa mexicana", "Monodelphis domestica", "Gallus gallus", "Meleagris gallopavo", "Xenopus tropicalis", "Latimeria chalumnae", "Danio rerio"),
                taxon_id = c("9606", "9598", "9595", "9544", "9555", "10116", "10090", "9615", "225402", "13616", "9031", "9103", "8364", "7897", "7955")
)
species

## -----------------------------------------------------------------------------
og1 <- expand.grid(cog_id = "OG1", 
                   protein_id = c(
    "sp01.prot1a", "sp01.prot1b", "sp01.prot1c", "sp01.prot1d", "sp01.prot1e", "sp01.prot1f", "sp01.prot1g", 
    "sp02.prot1a", "sp02.prot1b", "sp02.prot1c", "sp02.prot1d", "sp02.prot1e", "sp02.prot1f", 
    "sp03.prot1a", "sp03.prot1b", "sp03.prot1c", 
    "sp04.prot1a", "sp04.prot1b", "sp04.prot1c", "sp04.prot1d", 
    "sp05.prot1a", "sp05.prot1b", "sp05.prot1c", "sp05.prot1d", "sp05.prot1e",
    "sp06.prot1a", "sp06.prot1b",
    "sp07.prot1a", "sp07.prot1b", "sp07.prot1c",
    "sp08.prot1a", "sp08.prot1b",
    "sp11.prot1a", "sp11.prot1b", "sp11.prot1c",
    "sp12.prot1a", "sp12.prot1b", "sp12.prot1c",
    "sp13.prot1a", "sp13.prot1b",
    "sp14.prot1",
    "sp15.prot1a", "sp15.prot1b"
    )
)
og2 <- expand.grid(cog_id = "OG2", 
                   protein_id = c(
    "sp01.prot2a", "sp01.prot2b", "sp01.prot2c", "sp01.prot2d", "sp01.prot2e", "sp01.prot2f",
    "sp02.prot2a", "sp02.prot2b", "sp02.prot2c",
    "sp03.prot2a", "sp03.prot2b", "sp03.prot2c", "sp03.prot2d",
    "sp04.prot2a", "sp04.prot2b", "sp04.prot2c",
    "sp05.prot2a", "sp05.prot2b", "sp05.prot2c", "sp05.prot2d",
    "sp06.prot2",
    "sp08.prot2a", "sp08.prot2b"
    )
)
og3 <- expand.grid(cog_id = "OG3", 
                   protein_id = c(
    "sp01.prot3a", "sp01.prot3b", "sp01.prot3c", "sp01.prot3d", 
    "sp02.prot3a", "sp02.prot3b", "sp02.prot3c",
    "sp03.prot3",
    "sp10.prot3"
    )
)

## -----------------------------------------------------------------------------
library(tibble)
library(stringi)
library(dplyr)
# Bind OGs into a single object
cogdata <- rbind(og1, og2, og3)
# Create a dictionary to map species labels to taxon IDs
species_taxid_lookup <- species |> dplyr::select(label, taxon_id) |> tibble::deframe()
species_name_lookup <- species |> dplyr::select(taxon_id, scientific_name) |> tibble::deframe()
# Add the required ssp_id column
cogdata[["ssp_id"]] <- species_taxid_lookup[stri_split_fixed(cogdata[["protein_id"]], pattern = ".", n = 2, simplify = T)[,1]]
head(cogdata)

## ----eval=FALSE---------------------------------------------------------------
#  library(geneplast.data)
#  cogdata <- geneplast.data::make.cogdata(file = "path/to/orthogroups.tsv")

## -----------------------------------------------------------------------------
library(geneplast.data)
phyloTree <- geneplast.data::make.phyloTree(sspids = species$taxon_id)
phyloTree

## ----eval=FALSE---------------------------------------------------------------
#  # Create from a user's predefined newick file
#  phyloTree <- geneplast.data::make.phyloTree(newick = "path/to/newick_tree.nwk")

## -----------------------------------------------------------------------------
library(geneplast)
phyloTree <- geneplast:::rotatePhyloTree(phyloTree, "9606")
phyloTree$edge.length <- NULL
phyloTree$tip.label <- species_name_lookup[phyloTree$tip.label]
plot(phyloTree, type = "cladogram")

## ----eval=FALSE---------------------------------------------------------------
#  library(geneplast)
#  ogr <- groot.preprocess(cogdata=cogdata, phyloTree=phyloTree, spid="9606")
#  ogr <- groot(ogr, nPermutations=1, verbose=TRUE)
#  
#  library(RedeR)
#  library(igraph)
#  library(RColorBrewer)
#  data(ppi.gs)
#  g <- ogr2igraph(ogr, cogdata, ppi.gs, idkey = "ENTREZ")
#  pal <- brewer.pal(9, "RdYlBu")
#  color_col <- colorRampPalette(pal)(37) #set a color for each root!
#  g <- att.setv(g=g, from="Root", to="nodeColor", cols=color_col, na.col = "grey80", breaks = seq(1,37))
#  g <- att.setv(g = g, from = "SYMBOL", to = "nodeAlias")
#  E(g)$edgeColor <- "grey80"
#  V(g)$nodeLineColor <- "grey80"
#  rdp <- RedPort()
#  calld(rdp)
#  resetd(rdp)
#  addGraph(rdp, g)
#  addLegend.color(rdp, colvec=g$legNodeColor$scale, size=15, labvec=g$legNodeColor$legend, title="Roots inferred from geneplast")
#  g1  <- induced_subgraph(g=g, V(g)$name[V(g)$Apoptosis==1])
#  g2  <- induced_subgraph(g=g, V(g)$name[V(g)$GenomeStability==1])
#  myTheme <- list(nestFontSize=25, zoom=80, isNest=TRUE, gscale=65, theme=2)
#  addGraph(rdp, g1, gcoord=c(25, 50), theme = c(myTheme, nestAlias="Apoptosis"))
#  addGraph(rdp, g2, gcoord=c(75, 50), theme = c(myTheme, nestAlias="Genome Stability"))
#  relax(rdp, p1=50, p2=50, p3=50, p4=50, p5= 50, ps = TRUE)

## ----eval=FALSE---------------------------------------------------------------
#  load(meta[["AH83117"]])
#  cogdata$cog_id <- paste0("OMA", cogdata$cog_id)
#  cogids$cog_id <- paste0("OMA", cogids$cog_id)
#  
#  human_entrez_2_oma_Aug2020 <- read_delim("processed_human.entrez_2_OMA.Aug2020.tsv",
#      delim = "\t", escape_double = FALSE,
#      col_names = FALSE, trim_ws = TRUE)
#  names(human_entrez_2_oma_Aug2020) <- c("protein_id", "gene_id")
#  cogdata <- cogdata %>% left_join(human_entrez_2_oma_Aug2020)
#  ogr <- groot.preprocess(cogdata=cogdata, phyloTree=phyloTree, spid="9606")
#  ogr <- groot(ogr, nPermutations=1, verbose=TRUE)
#  
#  g <- ogr2igraph(ogr, cogdata, ppi.gs, idkey = "ENTREZ")
#  pal <- brewer.pal(9, "RdYlBu")
#  color_col <- colorRampPalette(pal)(37) #set a color for each root!
#  g <- att.setv(g=g, from="Root", to="nodeColor", cols=color_col, na.col = "grey80", breaks = seq(1,37))
#  g <- att.setv(g = g, from = "SYMBOL", to = "nodeAlias")
#  E(g)$edgeColor <- "grey80"
#  V(g)$nodeLineColor <- "grey80"
#  # rdp <- RedPort()
#  # calld(rdp)
#  resetd(rdp)
#  addGraph(rdp, g)
#  addLegend.color(rdp, colvec=g$legNodeColor$scale, size=15, labvec=g$legNodeColor$legend, title="Roots inferred from geneplast")
#  g1  <- induced_subgraph(g=g, V(g)$name[V(g)$Apoptosis==1])
#  g2  <- induced_subgraph(g=g, V(g)$name[V(g)$GenomeStability==1])
#  myTheme <- list(nestFontSize=25, zoom=80, isNest=TRUE, gscale=65, theme=2)
#  addGraph(rdp, g1, gcoord=c(25, 50), theme = c(myTheme, nestAlias="Apoptosis"))
#  addGraph(rdp, g2, gcoord=c(75, 50), theme = c(myTheme, nestAlias="Genome Stability"))
#  relax(rdp, p1=50, p2=50, p3=50, p4=50, p5= 50, ps = TRUE)

## ----eval=FALSE---------------------------------------------------------------
#  load(meta[["AH83118"]])
#  cogdata$cog_id <- paste0("ODB", cogdata$cog_id)
#  cogids$cog_id <- paste0("ODB", cogids$cog_id)
#  
#  human_entrez_2_odb <- read_delim("odb10v1_genes-human-entrez.tsv",
#      delim = "\t", escape_double = FALSE,
#      col_names = FALSE, trim_ws = TRUE)
#  names(human_entrez_2_odb) <- c("protein_id", "gene_id")
#  cogdata <- cogdata %>% left_join(human_entrez_2_odb)
#  ogr <- groot.preprocess(cogdata=cogdata, phyloTree=phyloTree, spid="9606")
#  ogr <- groot(ogr, nPermutations=1, verbose=TRUE)
#  
#  g <- ogr2igraph(ogr, cogdata, ppi.gs, idkey = "ENTREZ")
#  pal <- brewer.pal(9, "RdYlBu")
#  color_col <- colorRampPalette(pal)(37) #set a color for each root!
#  g <- att.setv(g=g, from="Root", to="nodeColor", cols=color_col, na.col = "grey80", breaks = seq(1,37))
#  g <- att.setv(g = g, from = "SYMBOL", to = "nodeAlias")
#  E(g)$edgeColor <- "grey80"
#  V(g)$nodeLineColor <- "grey80"
#  rdp <- RedPort()
#  calld(rdp)
#  resetd(rdp)
#  addGraph(rdp, g)
#  addLegend.color(rdp, colvec=g$legNodeColor$scale, size=15, labvec=g$legNodeColor$legend, title="Roots inferred from geneplast")
#  g1  <- induced_subgraph(g=g, V(g)$name[V(g)$Apoptosis==1])
#  g2  <- induced_subgraph(g=g, V(g)$name[V(g)$GenomeStability==1])
#  myTheme <- list(nestFontSize=25, zoom=80, isNest=TRUE, gscale=65, theme=2)
#  addGraph(rdp, g1, gcoord=c(25, 50), theme = c(myTheme, nestAlias="Apoptosis"))
#  addGraph(rdp, g2, gcoord=c(75, 50), theme = c(myTheme, nestAlias="Genome Stability"))
#  relax(rdp, p1=50, p2=50, p3=50, p4=50, p5= 50, ps = TRUE)

## ----eval=FALSE---------------------------------------------------------------
#  library(AnnotationHub)
#  library(dplyr)
#  library(geneplast)
#  library(tictoc)
#  
#  ah <- AnnotationHub()
#  meta <- query(ah, "geneplast")
#  load(meta[["AH83116"]])
#  writeLines(paste("geneplast input data loaded from", meta["AH83116"]$title))
#  
#  tic("total time")
#  tic("preprocessing")
#  ogr <- groot.preprocess(cogdata=cogdata, phyloTree=phyloTree, spid="9606")
#  toc()
#  tic("rooting")
#  ogr <- groot(ogr)
#  toc()
#  toc()

## -----------------------------------------------------------------------------
sessionInfo()

