# Code example from 'SBGNview.Vignette' vignette. See references/ for full tutorial.

## ----echo = FALSE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
library(knitr)

## ----echo = TRUE,   message = FALSE, warning = FALSE--------------------------
library(SBGNview)

## ----echo = TRUE,   message = FALSE, warning = FALSE--------------------------
ls("package:SBGNview")

## ----echo = TRUE,   message = FALSE, warning = FALSE--------------------------
data("sbgn.xmls")

## ----echo = TRUE,   message = FALSE, warning = FALSE--------------------------
data("pathways.info", "pathways.stats")
head(pathways.info)
pathways.stats

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
pathways <- findPathways(c("bile acid","bile salt"))
head(pathways)
pathways.local.file <- downloadSbgnFile(pathways$pathway.id[1:3])
pathways.local.file

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
pathways <- findPathways(c("tp53","Trp53"),keyword.type = "SYMBOL")
head(pathways)
pathways <- findPathways(c("K04451","K10136"),keyword.type = "KO")
head(pathways)

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
data("gse16873.d")
head(gse16873.d)

## ----echo = TRUE, message = FALSE, warning = FALSE----------------------------
# select a subset of data for later use
gse16873 <- gse16873.d[,1:3]
# gene data to demonstrate ID convertion
gene.data <- gse16873
head(gene.data[,1:2])

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
gene.data <- changeDataId(data.input.id = gene.data,
                          input.type = "entrez",
                          output.type = "pathwayCommons",
                          mol.type = "gene",
                          sum.method = "sum")

## ----echo = TRUE, message = FALSE, warning = FALSE----------------------------
head(gene.data[,1:2])

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
SBGNview.obj <- SBGNview(gene.data = gene.data,
                         input.sbgn = "P00001",
                         output.file = "test_output",
                         gene.id.type = "pathwayCommons",
                         output.formats =  c("png", "pdf", "ps"))
SBGNview.obj

## ----figGeneData, echo = FALSE,fig.cap="\\label{fig:figGeneData}Visualization of gene expression data."----
include_graphics("test_output_P00001.svg")

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
cpd.data <- sim.mol.data(mol.type = "cpd", 
                         id.type = "KEGG COMPOUND accession", 
                         nmol = 50000, 
                         nexp = 2)
head(cpd.data)

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
cpd.data1 <- changeDataId(data.input.id = cpd.data,
                         input.type = "kegg",
                         output.type = "pathwayCommons",
                         mol.type = "cpd",
                         sum.method = "sum")
head(cpd.data1)

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
SBGNview.obj <- SBGNview(cpd.data = cpd.data1,
                         input.sbgn = "P00001",
                         output.file = "test_output.cpd",
                         cpd.id.type = "pathwayCommons",
                         output.formats =  c("png", "pdf", "ps"))
SBGNview.obj

## ----figCpdData, echo = FALSE,fig.cap="\\label{fig:figCpdData}Visualization of compound abundance data."----
include_graphics("test_output.cpd_P00001.svg")

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
SBGNview.obj <- SBGNview(gene.data = gse16873,
                         cpd.data = cpd.data,
                         input.sbgn = "P00001",
                         output.file = "test_output.gene.compound",
                         gene.id.type = "entrez",
                         cpd.id.type = "kegg",
                         output.formats =  c("svg"))
SBGNview.obj

## ----figGeneAndCpdData, echo = FALSE,fig.cap="\\label{fig:figGeneAndCpdData}Visualization of both gene expression and compound abundance data."----
include_graphics("test_output.gene.compound_P00001.svg")

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
pathway.1.data <- SBGNview.obj$data[[1]]
names(pathway.1.data)
glyphs <- pathway.1.data$glyphs.list
arcs <- pathway.1.data$arcs.list
str(glyphs[[1]])
str(arcs[[1]])
global.pars <- pathway.1.data$global.parameters.list
names(global.pars)

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
outputFile(SBGNview.obj)
outputFile(SBGNview.obj) <- "test.change.output.file"
outputFile(SBGNview.obj)
SBGNview.obj
outputFile(SBGNview.obj) <- "test.print"
outputFile(SBGNview.obj)
print(SBGNview.obj)


## ----echo = TRUE, eval = FALSE, results = 'hide', message = FALSE, warning = FALSE----
# print(SBGNview.obj$output.formats)
# SBGNview.obj$output.formats <- c("png", "pdf")

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
# Here we set argument "node.set" to select all nodes to be highlighted
highlight.all.nodes.sbgn.obj <-  SBGNview.obj + highlightNodes(node.set = "all",
                                                               stroke.width = 4, 
                                                               stroke.color = "green")
outputFile(highlight.all.nodes.sbgn.obj) <- "highlight.all.nodes"
print(highlight.all.nodes.sbgn.obj)

## ----highlightAllNodes, echo = FALSE,fig.cap="\\label{fig:highlightAllNodes}Highlight all nodes."----
include_graphics("highlight.all.nodes_P00001.svg")

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
# Here we set argument "select.glyph.class" to select and highlight macromolecule nodes
highlight.macromolecule.sbgn.obj <-  SBGNview.obj + 
                                        highlightNodes(select.glyph.class = "macromolecule",
                                                       stroke.width = 4, 
                                                       stroke.color = "green")
outputFile(highlight.macromolecule.sbgn.obj) <- "highlight.macromolecule"
print(highlight.macromolecule.sbgn.obj)

## ----highlightMacromolecule, echo = FALSE,fig.cap="\\label{fig:highlightMacromolecule}Highlight macromolecule nodes."----
include_graphics("highlight.macromolecule_P00001.svg")

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
# Here we set argument "show.glyph.id" to display node ID instead of the original label
highlight.all.nodes.sbgn.obj <-  SBGNview.obj + highlightNodes(node.set = "(+-)-epinephrine", 
                                                               stroke.width = 4, 
                                                               stroke.color = "green",
                                                               show.glyph.id = TRUE,
                                                               label.font.size = 10)
outputFile(highlight.all.nodes.sbgn.obj) = "highlight.all.id.nodes"
print(highlight.all.nodes.sbgn.obj)

## ----highlightNodes, echo = FALSE,fig.cap="\\label{fig:highlightNodes}Highlight nodes using node IDs."----
include_graphics("highlight.all.id.nodes_P00001.svg")

## ----echo = TRUE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
# Node labels can be customized by a named vector. The names of the vector are the IDs assigned to argument "node.set". Values of the vector are the new labels for display.  
my.labels <- c("Tyr","epinephrine")
names(my.labels) <- c("tyrosine", "(+-)-epinephrine")
SBGNview.obj.adjust.label <-  SBGNview.obj + 
                                  highlightNodes(node.set = c("tyrosine", "(+-)-epinephrine"),
                                                 stroke.width = 4,
                                                 stroke.color = "green",
                                                 label.x.shift = 0,
                                                 # Labels are moved up a little bit
                                                 label.y.shift = -20,
                                                 label.color = "red",
                                                 label.font.size = 30,
                                                 label.spliting.string = "",
                                                 labels = my.labels)
outputFile(SBGNview.obj.adjust.label) <- "adjust.label"
print(SBGNview.obj.adjust.label)

## ----changeLabel, echo = FALSE,fig.cap="\\label{fig:changeLabel}Modify node labels."----
include_graphics("adjust.label_P00001.svg")

## ----echo = TRUE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
SBGNview.obj.change.label.wrapping <-  SBGNview.obj + 
                                        highlightNodes(node.set = c("tyrosine", "(+-)-epinephrine"),
                                                       stroke.width = 4,
                                                       stroke.color = "green",
                                                       show.glyph.id = TRUE,
                                                       label.x.shift = 10,
                                                       label.y.shift = 20,
                                                       label.color = "red",
                                                       label.font.size = 10,
                                                       label.spliting.string = "any")
outputFile(SBGNview.obj.change.label.wrapping) = "change.label.wrapping"
print(SBGNview.obj.change.label.wrapping)

## ----changeWrapping, echo = FALSE,fig.cap="\\label{fig:changeWrapping}Change how labels are wrapped."----
include_graphics("change.label.wrapping_P00001.svg")

## ----echo = TRUE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
# When "label.spliting.string" is set to a string that is not in the label (including an empty string ""), the label will not be wrapped into multiple lines.    
test.show.glyph.id <- SBGNview.obj + highlightNodes(node.set = c("tyrosine", "(+-)-epinephrine"), 
                                                    stroke.width = 4,
                                                    stroke.color = "green", 
                                                    show.glyph.id = TRUE,
                                                    label.x.shift = 10,
                                                    label.y.shift = 20,
                                                    label.color = "red",
                                                    label.font.size = 10,
                                                    label.spliting.string = "")
outputFile(test.show.glyph.id) <- "test.show.glyph.id"
print(test.show.glyph.id)

## ----displayNodeIds, echo = FALSE,fig.cap="\\label{fig:displayNodeIds}Show node IDs of mapped nodes."----
include_graphics("test.show.glyph.id_P00001.svg")

## ----echo = TRUE, results = 'hide', eval = TRUE, message = FALSE, warning = FALSE----
input.pathways <- findPathways("Adrenaline and noradrenaline biosynthesis")
input.pathway.ids <- input.pathways$pathway.id
mapping <- changeIds(input.ids = c("tyrosine", "(+-)-epinephrine"),
                     input.type = "compound.name",
                     output.type = "pathwayCommons",
                     mol.type = "cpd",
                     limit.to.pathways = input.pathway.ids[1])

## ----echo = TRUE, eval = TRUE, message = FALSE, warning = FALSE---------------
mapping

## ----echo =TRUE---------------------------------------------------------------
outputFile(SBGNview.obj) <- "highlight.by.node.id"

## ----echo = TRUE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
SBGNview.obj + highlightNodes(node.set = c("tyrosine", "(+-)-epinephrine"),
                              stroke.width = 4, 
                              stroke.color = "red") + 
               highlightPath(from.node = "SmallMolecule_96737c854fd379b17cb3b7715570b733",
                             to.node = "SmallMolecule_7753c3822ee83d806156d21648c931e6",
                             node.set.id.type = "pathwayCommons",
                             from.node.color = "green",
                             to.node.color = "blue",
                             shortest.paths.cols = c("purple"),
                             input.node.stroke.width = 6,
                             path.node.stroke.width = 3,
                             path.node.color = "purple",
                             path.stroke.width = 5,
                             tip.size = 10)

## ----highlightNodesById, echo = FALSE,fig.cap="\\label{fig:highlightNodesById}Highlight nodes and shortest path using node IDs."----
include_graphics("highlight.by.node.id_P00001.svg")

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
new.layout.file.path <- paste(path.package("SBGNview"), "extdata", sep = "/")
SBGNview(gene.data = gse16873, 
         gene.id.type = "entrez",
         input.sbgn = "P00001.new.layout.sbgn",
         sbgn.dir =  new.layout.file.path,
         sbgn.gene.id.type = "pathwayCommons",
         output.file = "test.different.layout",
         output.formats =  c("svg"))


## ----differentLayout, echo = FALSE,fig.cap="\\label{fig:differentLayoutFig}Graph with different layout."----
include_graphics("test.different.layout_P00001.new.layout.sbgn.svg")

## ----echo = TRUE, message = FALSE, warning = FALSE----------------------------
data("mapped.ids")

## ----echo = TRUE, results = 'hide',message = FALSE, warning = FALSE-----------
mapping <- changeIds(input.ids = c("tyrosine", "(+-)-epinephrine"),
                     input.type = "compound.name",
                     output.type = "pathwayCommons",
                     mol.type = "cpd",
                     limit.to.pathways = "P00001")

## ----echo = TRUE,message = FALSE, warning = FALSE-----------------------------
head(mapping)

## ----echo = TRUE, results = 'hide',message = FALSE, warning = FALSE-----------
mapping <- changeIds(input.ids = c("tyrosine", "(+-)-epinephrine"),
                     input.type = "compound.name",
                     output.type = "chebi",
                     mol.type = "cpd")

## ----echo = TRUE,message = FALSE, warning = FALSE-----------------------------
head(mapping)

## ----echo = TRUE, results='hide', message = FALSE, warning = FALSE------------
mol.list <- sbgn.gsets(database = "metacrop",
                       id.type = "ENZYME",
                       species = "ath",
                       output.pathway.name = FALSE,
                       truncate.name.length = 50)

## ----echo = TRUE, message = FALSE, warning = FALSE----------------------------
mol.list[[1]]

## ----echo = TRUE, results='hide', message = FALSE, warning = FALSE------------
mol.list <- sbgn.gsets(database = "pathwayCommons",
                       id.type = "ENTREZID",
                       species = "hsa")

## ----echo = TRUE, message = FALSE, warning = FALSE----------------------------
mol.list[[1]]

## ----echo = TRUE, results='hide', message = FALSE, warning = FALSE------------
mol.list <- sbgn.gsets(database = "pathwayCommons",
                       id.type = "ENTREZID",
                       species = "mmu")

## ----echo = TRUE, message = FALSE, warning = FALSE----------------------------
mol.list[[1]]

## ----echo = TRUE, results='hide', message = FALSE, warning = FALSE------------
mol.list <- sbgn.gsets(database = "MetaCyc",
                       id.type = "KO",
                       species = "eco")

## ----echo = TRUE, message = FALSE, warning = FALSE----------------------------
mol.list[[3]]

## ----echo = TRUE, results='hide', message = FALSE, warning = FALSE------------
mol.list <- sbgn.gsets(database = "pathwayCommons",
                       id.type = "chebi",
                       mol.type = "cpd")

## ----echo = TRUE, message = FALSE, warning = FALSE----------------------------
mol.list[[2]]

## ----echo = TRUE,results = 'hide', message = FALSE, warning = FALSE-----------
is.reactome <- pathways.info[,"sub.database"]== "reactome"
reactome.ids <- pathways.info[is.reactome ,"pathway.id"]
SBGNview.obj <- SBGNview(gene.data = gse16873,
                         gene.id.type = "entrez",
                         input.sbgn =  reactome.ids[1:2],
                         output.file = "demo.reactome",
                         output.formats =  c("svg"))
SBGNview.obj

## ----echo = TRUE,results = 'hide', message = FALSE, warning = FALSE-----------
reference.cards <- c("AF_Reference_Card.sbgn", "PD_Reference_Card.sbgn", "ER_Reference_Card.sbgn") 
downloadSbgnFile(reference.cards)
SBGNview.obj <- SBGNview(gene.data = c(),
                         input.sbgn = reference.cards,
                         sbgn.gene.id.type ="glyph",
                         output.file = "./test.refcards",
                         output.formats = c("pdf"),
                         font.size = 1,
                         logic.node.font.scale = 10,
                         status.node.font.scale = 10)
SBGNview.obj

## ----eval = FALSE, echo = TRUE,results = 'hide', message = FALSE, warning = FALSE----
# SBGNview(key.pos = "none")

## -----------------------------------------------------------------------------
sessionInfo()

