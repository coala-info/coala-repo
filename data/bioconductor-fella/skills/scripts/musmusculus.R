# Code example from 'musmusculus' vignette. See references/ for full tutorial.

## ----warning=FALSE, message=FALSE, results='hide'-----------------------------
library(FELLA)
library(org.Mm.eg.db)
library(KEGGREST)

library(igraph)
library(magrittr)

set.seed(1)
# Filter overview pathways
graph <- buildGraphFromKEGGREST(
    organism = "mmu", 
    filter.path = c("01100", "01200", "01210", "01212", "01230"))

tmpdir <- paste0(tempdir(), "/my_database")
# Mke sure the database does not exist from a former vignette build
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
alias2entrez <- as.list(org.Mm.eg.db::org.Mm.egSYMBOL2EG)
entrez2ec <- KEGGREST::keggLink("enzyme", "mmu")
entrez2path <- KEGGREST::keggLink("pathway", "mmu")

fella.data <- loadKEGGdata(
    databaseDir = tmpdir, 
    internalDir = FALSE, 
    loadMatrix = "none"
)

## -----------------------------------------------------------------------------
fella.data

## -----------------------------------------------------------------------------
id.cpd <- getCom(fella.data, level = 5, format = "id") %>% names
id.rx <- getCom(fella.data, level = 4, format = "id") %>% names
id.ec <- getCom(fella.data, level = 3, format = "id") %>% names

## -----------------------------------------------------------------------------
cpd.nafld <- c(
    "C00020", # AMP
    "C00719", # Betaine
    "C00114", # Choline
    "C00037", # Glycine
    "C00160", # Glycolate
    "C01104"  # Trimethylamine-N-oxide
)

analysis.nafld <- enrich(
    compounds = cpd.nafld, 
    data = fella.data, 
    method = "diffusion", 
    approx = "normality")

## -----------------------------------------------------------------------------
analysis.nafld %>% 
    getInput %>% 
    getName(data = fella.data)

## -----------------------------------------------------------------------------
getExcluded(analysis.nafld) 

## ----fig.width=8, fig.height=8------------------------------------------------
plot(
    analysis.nafld, 
    method = "diffusion", 
    data = fella.data, 
    nlimit = 250,  
    plotLegend = FALSE)

## -----------------------------------------------------------------------------
g.nafld <-  generateResultsGraph(
    object = analysis.nafld, 
    data = fella.data, 
    method = "diffusion")

pscores.nafld <- getPscores(
    object = analysis.nafld, 
    method = "diffusion")

## -----------------------------------------------------------------------------
cpd.nafld.suggestive <- c(
    "C00008", # ADP
    "C00791", # Creatinine
    "C00025", # Glutamate
    "C01026", # N,N-dimethylglycine
    "C00079", # Phenylalanine
    "C00299"  # Uridine
)
getName(cpd.nafld.suggestive, data = fella.data)

## -----------------------------------------------------------------------------
V(g.nafld)$name %>% 
    intersect(cpd.nafld.suggestive) %>% 
    getName(data = fella.data)

## -----------------------------------------------------------------------------
cpd.new.fig6 <- c(
    "C00101", # THF
    "C00440", # 5-CH3-THF
    "C00143", # 5,10-CH3-THF
    "C00073", # Methionine
    "C00019", # SAM
    "C00021", # SAH
    "C00155", # Homocysteine
    "C02291", # Cystathione
    "C00097"  # Cysteine
)
getName(cpd.new.fig6, data = fella.data)

## -----------------------------------------------------------------------------
cpd.new.fig6 %in% V(g.nafld)$name

## -----------------------------------------------------------------------------
wilcox.test(
    x = pscores.nafld[cpd.new.fig6], # metabolites from fig6
    y = pscores.nafld[setdiff(id.cpd, cpd.new.fig6)], # rest of metabolites
    alternative = "less")

## -----------------------------------------------------------------------------
ec.cbs <- entrez2ec[[paste0("mmu:", alias2entrez[["Cbs"]])]] %>% 
    gsub(pattern = "ec:", replacement = "")

getName(fella.data, ec.cbs)

## -----------------------------------------------------------------------------
rx.cbs <- "R01290"

getName(fella.data, rx.cbs)

## -----------------------------------------------------------------------------
c(rx.cbs, ec.cbs) %in% V(g.nafld)$name

## -----------------------------------------------------------------------------
# enzyme
pscores.nafld[ec.cbs]
mean(pscores.nafld[id.ec] <= pscores.nafld[ec.cbs])

# reaction
pscores.nafld[rx.cbs]
mean(pscores.nafld[id.rx] <= pscores.nafld[rx.cbs])

## -----------------------------------------------------------------------------
ec.bhmt <- entrez2ec[[paste0("mmu:", alias2entrez[["Bhmt"]])]] %>% 
    gsub(pattern = "ec:", replacement = "")

getName(fella.data, ec.bhmt)

## -----------------------------------------------------------------------------
ec.bhmt %in% V(g.nafld)$name
"R02821" %in% V(g.nafld)$name

## -----------------------------------------------------------------------------
entrez.slc22a5 <- alias2entrez[["Slc22a5"]]
entrez.slc22a5 %in% names(entrez2ec)

## -----------------------------------------------------------------------------
path.slc22a5 <- entrez2path[paste0("mmu:", entrez.slc22a5)] %>% 
    gsub(pattern = "path:", replacement = "")

getName(fella.data, path.slc22a5)

## -----------------------------------------------------------------------------
path.slc22a5 %in% V(g.nafld)$name

## -----------------------------------------------------------------------------
symbol.fig3 <- c(
    "Cd36",
    "Scd2", 
    "Apoa4", 
    "Lcn2", 
    "Apom")

entrez.fig3 <- alias2entrez[symbol.fig3] %>% unlist %>% unique
ec.fig3 <- entrez2ec[paste0("mmu:", entrez.fig3)] %T>% 
    print %>%
    unlist %>% 
    unique %>% 
    na.omit %>% 
    gsub(pattern = "ec:", replacement = "")

getName(fella.data, ec.fig3)

## -----------------------------------------------------------------------------
ec.fig3 %in% V(g.nafld)$name

## -----------------------------------------------------------------------------
pscores.nafld[ec.fig3]
mean(pscores.nafld[id.ec] <= pscores.nafld[ec.fig3])

## -----------------------------------------------------------------------------
symbol.tableS2 <- c(
    "Mat1a",
    "Ahcyl2", 
    "Cbs",
    "Mat2b",  
    "Mtr")
entrez.tableS2 <- alias2entrez[symbol.tableS2] %>% unlist %>% unique
ec.tableS2 <- entrez2ec[paste0("mmu:", entrez.tableS2)] %T>%
    print %>%
    unlist %>% 
    unique %>% 
    na.omit %>% 
    gsub(pattern = "ec:", replacement = "")

## -----------------------------------------------------------------------------
ec.tableS2 %in% V(g.nafld)$name

## -----------------------------------------------------------------------------
wilcox.test(
    x = pscores.nafld[ec.tableS2], # enzymes from table S2
    y = pscores.nafld[setdiff(id.ec, ec.tableS2)], # rest of enzymes
    alternative = "less")

## -----------------------------------------------------------------------------
sessionInfo()

## -----------------------------------------------------------------------------
cat(getInfo(fella.data))

## -----------------------------------------------------------------------------
date()

## -----------------------------------------------------------------------------
tempfile(pattern = "vignette_mmu_", fileext = ".RData") %T>% 
    message("Saving workspace to ", .) %>% 
    save.image(compress = "xz")

