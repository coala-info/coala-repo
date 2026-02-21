# Code example from 'FELLA' vignette. See references/ for full tutorial.

### R code from vignette source 'FELLA.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: 01_graph
###################################################
library(FELLA)
set.seed(1)
# Filter overview pathways
graph <- buildGraphFromKEGGREST(
    organism = "hsa", 
    filter.path = c("01100", "01200", "01210", "01212", "01230"))


###################################################
### code chunk number 3: 01_database
###################################################
tmpdir <- paste0(tempdir(), "/my_database")
# Mke sure the database does not exist from a former vignette build
# Otherwise the vignette will rise an error 
# because FELLA will not overwrite an existing database
unlink(tmpdir, recursive = TRUE)  
buildDataFromGraph(
    keggdata.graph = graph, 
    databaseDir = tmpdir, 
    internalDir = FALSE, 
    matrices = "diffusion", 
    normality = "diffusion", 
    niter = 50)


###################################################
### code chunk number 4: 01_loadkegg
###################################################
fella.data <- loadKEGGdata(
    databaseDir = tmpdir, 
    internalDir = FALSE, 
    loadMatrix = "diffusion"
)


###################################################
### code chunk number 5: 01_summary
###################################################
fella.data


###################################################
### code chunk number 6: 01_info
###################################################
cat(getInfo(fella.data))


###################################################
### code chunk number 7: 02_compounds
###################################################
compounds.epithelial <- c(
    "C02862", "C00487", "C00025", "C00064", 
    "C00670", "C00073", "C00588", "C00082", "C00043")


###################################################
### code chunk number 8: 02_mapcompounds
###################################################
analysis.epithelial <- defineCompounds(
    compounds = compounds.epithelial, 
    data = fella.data)


###################################################
### code chunk number 9: 02_mapped
###################################################
getInput(analysis.epithelial)
getExcluded(analysis.epithelial)


###################################################
### code chunk number 10: 02_print
###################################################
analysis.epithelial


###################################################
### code chunk number 11: 03_enrich
###################################################
analysis.epithelial <- runDiffusion(
    object = analysis.epithelial, 
    data = fella.data, 
    approx = "normality")


###################################################
### code chunk number 12: 03_summary
###################################################
analysis.epithelial


###################################################
### code chunk number 13: 03_plot
###################################################
nlimit <- 150
vertex.label.cex <- .5
plot(
    analysis.epithelial, 
    method = "diffusion", 
    data = fella.data, 
    nlimit = nlimit, 
    vertex.label.cex = vertex.label.cex)


###################################################
### code chunk number 14: 04_graph
###################################################
g <- generateResultsGraph(
    object = analysis.epithelial, 
    method = "diffusion", 
    nlimit = nlimit, 
    data = fella.data)
g


###################################################
### code chunk number 15: 04_go
###################################################
# GO:0005739 is the term for mitochondrion
g.go <- addGOToGraph(
    graph = g, 
    GOterm = "GO:0005739", 
    godata.options = list(
        OrgDb = "org.Hs.eg.db", ont = "CC"), 
    mart.options = list(
        biomart = "ensembl", dataset = "hsapiens_gene_ensembl"))
g.go


###################################################
### code chunk number 16: 04_plot_go
###################################################
plotGraph(
    g.go, 
    vertex.label.cex = vertex.label.cex)


###################################################
### code chunk number 17: 04_table
###################################################
tab.all <- generateResultsTable(
    method = "diffusion", 
    nlimit = 100, 
    object = analysis.epithelial, 
    data = fella.data)
# Show head of the table
knitr::kable(head(tab.all), format = "latex")


###################################################
### code chunk number 18: 04_enzyme
###################################################
tab.enzyme <- generateEnzymesTable(
    method = "diffusion", 
    nlimit = 100, 
    object = analysis.epithelial, 
    data = fella.data)
# Show head of the table
knitr::kable(head(tab.enzyme, 10), format = "latex")


###################################################
### code chunk number 19: 04_file
###################################################
tmpfile <- tempfile()
exportResults(
    format = "csv", 
    file = tmpfile, 
    method = "diffusion", 
    object = analysis.epithelial, 
    data = fella.data)


###################################################
### code chunk number 20: 04_pajek
###################################################
tmpfile <- tempfile()
exportResults(
    format = "pajek", 
    file = tmpfile, 
    method = "diffusion", 
    object = analysis.epithelial, 
    data = fella.data)


###################################################
### code chunk number 21: 05
###################################################
compounds.ovarian <- c(
    "C00275", "C00158", "C00042", 
    "C00346", "C00122", "C06468")
analysis.ovarian <- enrich(
    compounds = compounds.ovarian, 
    data = fella.data, 
    methods = "diffusion")

plot(
    analysis.ovarian, 
    method = "diffusion", 
    data = fella.data, 
    nlimit = 150, 
    vertex.label.cex = vertex.label.cex, 
    plotLegend = FALSE)


###################################################
### code chunk number 22: 06
###################################################
compounds.malaria <- c(
    "C05471", "C14831", "C02686", "C06462", "C00735", "C14833", 
    "C18175", "C00550", "C01124", "C05474", "C05469")

analysis.malaria <- enrich(
    compounds = compounds.malaria, 
    data = fella.data, 
    methods = "diffusion")

plot(
    analysis.malaria, 
    method = "diffusion", 
    data = fella.data, 
    nlimit = 50, 
    vertex.label.cex = vertex.label.cex, 
    plotLegend = FALSE)


###################################################
### code chunk number 23: sessioninfo
###################################################
toLatex(sessionInfo())


