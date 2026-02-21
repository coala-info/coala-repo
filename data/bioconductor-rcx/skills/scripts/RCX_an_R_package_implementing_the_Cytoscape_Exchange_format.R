# Code example from 'RCX_an_R_package_implementing_the_Cytoscape_Exchange_format' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(tidy.opts=list(width.cutoff=75,
                              args.newline = TRUE,
                              arrow = TRUE),
               tidy=TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if(!"remotes" %in% installed.packages()){
#   install.packages("remotes")
# }
# if(!"RCX" %in% installed.packages()){
#   remotes::install_github("frankkramer-lab/RCX")
# }
# library(RCX)

## ----eval=FALSE---------------------------------------------------------------
# if(!"devtools" %in% installed.packages()){
#   install.packages("devtools")
# }
# if(!"RCX" %in% installed.packages()){
#   devtools::install_github("frankkramer-lab/RCX")
# }
# library(RCX)

## ----installBioconductor, eval=FALSE, include=FALSE---------------------------
# if(!"BiocManager" %in% installed.packages()){
#   install.packages("BiocManager")
# }
# if(!"RCX" %in% installed.packages()){
#   BiocManager::install("RCX")
# }
# library(RCX)

## ----echo=FALSE, message=FALSE------------------------------------------------
library(RCX)

## ----readRCX, tidy=FALSE------------------------------------------------------
cxFile <- system.file(
  "extdata", 
  "Imatinib-Inhibition-of-BCR-ABL-66a902f5-2022-11e9-bb6a-0ac135e8bacf.cx", 
  package = "RCX"
)

rcx = readCX(cxFile)

## ----eval=FALSE, include=FALSE------------------------------------------------
# # Alternatively, the Bioconductor package [ndexr](https://doi.org/doi:10.18129/B9.bioc.ndexr) can be used to download the network from NDEx:
# 
# # ```{r eval=FALSE, include=FALSE}
# library(ndexr)
# 
# ## UUID of the network
# networkId = "66a902f5-2022-11e9-bb6a-0ac135e8bacf"
# 
# ## Establish a server connection
# ndexcon = ndex_connect()
# 
# ## Get the network data
# rcx = ndex_get_network(ndexcon, networkId)

## ----writeCX, eval=FALSE------------------------------------------------------
# writeCX(rcx, "path/to/some-file.cx")

## ----readJSON-----------------------------------------------------------------
json = readJSON(cxFile)

substr(json, 1,77)

## ----parseJSON----------------------------------------------------------------
aspectList = parseJSON(json)

str(aspectList, 2)

## ----processCX----------------------------------------------------------------
rcx = processCX(aspectList)

## ----readRCXverbose-----------------------------------------------------------
rcx = readCX(cxFile, verbose = TRUE)

## ----printRCX, eval=FALSE-----------------------------------------------------
# print(rcx)
# ## OR:
# rcx

## ----printMetaData------------------------------------------------------------
rcx$metaData

## ----summaryRCX---------------------------------------------------------------
summary(rcx$nodeAttributes)

## ----uniqueNodeAttributes-----------------------------------------------------
unique(rcx$nodeAttributes$name)

## ----visualizeRCX, eval=FALSE-------------------------------------------------
# visualize(rcx)

## ----writeHTML, eval=FALSE----------------------------------------------------
# writeHTML(rcx, "path/to/some-file.html")

## ----deleteLayout-------------------------------------------------------------
## save them for later
originalVisualProperties = rcx$cyVisualProperties

## and delete them from the RCX network
rcx$cyVisualProperties = NULL
rcx = updateMetaData(rcx)

rcx$metaData

## ----visualizeNoCVP, eval=FALSE-----------------------------------------------
# visualize(
#   rcx,
#   layout = c(name="cose")
# )

## ----createVP, tidy=FALSE-----------------------------------------------------
cyMapping <- createCyVisualPropertyMappings(
  name= "NODE_LABEL" ,
  type = "PASSTHROUGH",
  definition = "COL=label,T=string"
)

cyVisualProperties <- createCyVisualProperties(
  defaultNodes = createCyVisualProperty(
    mappings = cyMapping
  )
)

rcx <- updateCyVisualProperties(rcx, cyVisualProperties)

## ----visualizeRCXlayout, eval=FALSE, tidy=FALSE-------------------------------
# visualize(
#   rcx,
#   layout = c(
#     name="cose",
#     idealEdgeLength="80",
#     edgeElasticity="250"),
#   openExternal = TRUE)

## ----validate-----------------------------------------------------------------
validate(rcx)

## ----validationError----------------------------------------------------------
nodes = rcx$nodes
nodes$id[1] = nodes$id[2]

test = validate(nodes)
test

## ----elementsAll--------------------------------------------------------------
countElements(rcx)

## ----elementsSet--------------------------------------------------------------
countElements(rcx$nodes)

## ----hasId--------------------------------------------------------------------
hasIds(rcx$nodes)

## ----madId--------------------------------------------------------------------
maxId(rcx$nodes)
maxId(rcx)

## ----idProperty---------------------------------------------------------------
idProperty(rcx$nodes)

## ----referredBy---------------------------------------------------------------
referredBy(rcx)

## ----refersTo-----------------------------------------------------------------
refersTo(rcx$edges)

## ----aspectClassName----------------------------------------------------------
## all classes
aspectClasses

## class of nodes
aspectName2Class("nodes")

## accession name of NodesAspect
aspectClass2Name("NodesAspect")

## back and forth
class(rcx[[aspectClass2Name("NodesAspect")]])

## ----toIgraph-----------------------------------------------------------------
library(igraph)
ig = toIgraph(rcx)
summary(ig)

## ----fromIgraph---------------------------------------------------------------
rcxFromIg = fromIgraph(ig)

## ----fromIgVisualProperty-----------------------------------------------------
rcxFromIg = updateCyVisualProperties(rcxFromIg, originalVisualProperties)

## ----visualizeIg, eval=FALSE--------------------------------------------------
# visualize(rcxFromIg)

## ----multiFix-----------------------------------------------------------------
dubEdges = duplicated(rcx$edges[c("source","target")])

s = rcx$edges$source
rcx$edges$source[dubEdges] = rcx$edges$target[dubEdges]
rcx$edges$target[dubEdges] = s[dubEdges]

gNel = toGraphNEL(rcx, directed = TRUE)
rcxBack = fromGraphNEL(gNel)

## ----rcxToGraphNel------------------------------------------------------------
gNel = toGraphNEL(rcx, directed = TRUE)
gNel

## ----rcxFromGraphNel----------------------------------------------------------
rcxBack = fromGraphNEL(gNel)
rcxBack$metaData

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

