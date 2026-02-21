# Code example from 'Creating_RCX_from_scratch' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(tidy.opts=list(width.cutoff=75,
                              args.newline = TRUE,
                              arrow = TRUE),
               tidy=TRUE)

## ----eval=FALSE, include=FALSE------------------------------------------------
# output:
#  html_vignette:
#    toc: true
# output:
#  pdf_document:
#    latex_engine: xelatex
#    toc: true

## ----echo=FALSE, message=FALSE------------------------------------------------
library(RCX)

## ----nodes, tidy=FALSE--------------------------------------------------------
nodes <- createNodes(
  name = c(
    "RCX",
    "metaData", "name", "version", "idCounter", "elementCount", "consistencyGroup", "properties",
    "nodes", "id", "name", "represents",
    "edges", "id", "source", "target", "interaction",
    "nodeAttributes", "propertyOf", "name", "value", "dataType", "isList", "subnetworkId",
    "edgeAttributes", "propertyOf", "name", "value", "dataType", "isList", "subnetworkId",
    "networkAttribute", "name", "value", "dataType", "isList", "subnetworkId",
    "cartesianLayout", "node", "x", "y", "z", "view",
    "cySubNetworks", "id", "nodes", "edges",
    "cyGroups", "id", "name", "nodes", "externalEdges", "internalEdges", "collapsed",
    "cyHiddenAttributes", "name", "value", "dataType", "isList", "subnetworkId",
    "cyNetworkRelations", "child", "parent", "name", "isView",
    "cyTableColum", "appliesTo", "name", "dataType", "isList", "subnetworkId",
    "cyVisualProperties", "network", "nodes", "edges", "defaultNodes", "defaultEdges",
    "cyVisualProperty", "properties", "dependencies", "mappings", "appliesTo", "view",
    "cyVisualPropertyProperties", "value", "name",
    "cyVisualPropertyDependencies", "value", "name",
    "cyVisualPropertyMappings", "type", "definition", "name",
    "status", "sucess", "error"
  )
)

head(nodes)

## ----edges--------------------------------------------------------------------
edges = createEdges(
  source = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 78, 79, 80, 81, 82, 84, 85, 87, 88, 90, 91, 92, 93, 94, 95, 14, 15, 18, 23, 25, 30, 36, 38, 42, 45, 46, 50, 51, 52, 59, 61, 62, 70, 72, 73, 74, 75, 76, 78, 79, 80, 81, 82),
  target = c(0, 1, 1, 1, 1, 1, 1, 0, 8, 8, 8, 0, 12, 12, 12, 12, 0, 17, 17, 17, 17, 17, 17, 0, 24, 24, 24, 24, 24, 24, 0, 31, 31, 31, 31, 31, 0, 37, 37, 37, 37, 37, 0, 43, 43, 43, 0, 47, 47, 47, 47, 47, 47, 0, 54, 54, 54, 54, 54, 0, 60, 60, 60, 60, 0, 65, 65, 65, 65, 65, 0, 71, 71, 71, 71, 71, 77, 77, 77, 77, 77, 83, 83, 86, 86, 89, 89, 89, 0, 93, 93, 9, 9, 9, 44, 13, 44, 44, 9, 44, 9, 13, 9, 13, 13, 44, 44, 44, 44, 77, 77, 77, 77, 77, 83, 86, 89, 44, 44),
  interaction = c("aspectOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "propertyOf", "aspectOf", "propertyOf", "propertyOf", "references", "references", "references", "references", "references", "references", "references", "references", "references", "references", "references", "references", "references", "references", "references", "references", "references", "references", "contains", "contains", "contains", "contains", "contains", "contains", "contains", "contains", "references", "references")
)

head(edges)

## ----rcx----------------------------------------------------------------------
rcx = createRCX(nodes = nodes, edges = edges)

## ----rcxSummary---------------------------------------------------------------
summary(rcx)

## ----rcxMetadata--------------------------------------------------------------
rcx$metaData

## ----visualize1, eval=FALSE---------------------------------------------------
# visualize(rcx, layout = c(name="cose"))

## ----nodeAttributesType, tidy=FALSE-------------------------------------------
nodeAttributesType = createNodeAttributes(
  propertyOf = nodes$id,
  name = rep("type", length(nodes$id)),
  value = c(
    "object",
    "aspect", "property", "property", "property", "property", "property", "property", 
    "aspect", "property", "property", "property",
    "aspect", "property", "property", "property", "property",
    "aspect", "property", "property", "property", "property", "property", "property", 
    "aspect", "property", "property", "property", "property", "property", "property", 
    "aspect", "property", "property", "property", "property", "property", 
    "aspect", "property", "property", "property", "property", "property",
    "aspect", "property", "property", "property",
    "aspect", "property", "property", "property", "property", "property", "property", 
    "aspect", "property", "property", "property", "property", "property",
    "aspect", "property", "property", "property", "property",
    "aspect", "property", "property", "property", "property", "property",
    "aspect", "property", "property", "property", "property", "property",
    "subAspect", "property", "property", "property", "property", "property",
    "subAspect", "property", "property",
    "subAspect", "property", "property",
    "subAspect", "property", "property", "property",
    "aspect", "property", "property"
  )
)

rcx = updateNodeAttributes(rcx, nodeAttributesType)

## ----nodeAttributesRequired, tidy=FALSE---------------------------------------
nodesRequired <- c(
  0,	# RCX
  1,	# metaData
  2,	# metaData:name
  8,	# metaData:nodes
  9,	# metaData:id
  13,	# edge:id
  14,	# edge:source
  15,	# edge:target
  18,	# nodeAttributes:propertyOf
  19,	# nodeAttributes:name
  20,	# nodeAttributes:value
  25,	# edgeAttributes:propertyOf
  26,	# edgeAttributes:name
  27,	# edgeAttributes:value
  32,	# networkAttribute:name
  33,	# networkAttribute:value
  38,	# cartesianLayout:node
  39,	# cartesianLayout:x
  40,	# cartesianLayout:y
  44,	# cySubNetworks:id
  45,	# cySubNetworks:nodes
  46,	# cySubNetworks:edges
  48,	# cyGroups:id
  49,	# cyGroups:name
  55,	# cyHiddenAttributes:name
  56,	# cyHiddenAttributes:value
  61,	# cyNetworkRelations:child
  66,	# cyTableColum:appliesTo
  67,	# cyTableColum:name
  84,	# cyVisualPropertyProperties:value
  85,	# cyVisualPropertyProperties:name
  87,	# cyVisualPropertyDependencies:value
  88,	# cyVisualPropertyDependencies:name
  90,	# cyVisualPropertyMappings:type
  91,	# cyVisualPropertyMappings:definition
  92,	# cyVisualPropertyMappings:name
  93,	# status
  94,	# status:sucess
  95	# status:error
)

## ----nodeAttributesAuto, tidy=FALSE-------------------------------------------
nodesAuto <- c(
  1,	# metaData
  2,	# metaData:name
  4,	# metaData:idCounter
  5,	# metaData:elementCount
  9,	# nodes:id
  13,	# edges:id
  44,	# cySubNetworks:id
  48,	# cyGroups:id
  93,	# status
  94,	# status:sucess
  95	# status:error
)

## ----nodeAttributesAdd--------------------------------------------------------
nodeAttributesRequired = createNodeAttributes(
  propertyOf = nodesRequired,
  name = rep("required", length(nodesRequired)),
  value = rep(TRUE, length(nodesRequired))
)

nodeAttributesAuto = createNodeAttributes(
  propertyOf = nodesAuto,
  name = rep("auto", length(nodesAuto)),
  value = rep(TRUE, length(nodesAuto))
)

nodeAttributes = updateNodeAttributes(nodeAttributesRequired, nodeAttributesAuto)
rcx = updateNodeAttributes(rcx, nodeAttributes)

## nodeAttributesType was already in rcx, so save it all
nodeAttributes = rcx$nodeAttributes

## ----networkAttributes, tidy=FALSE--------------------------------------------


description <- paste0(
  '<h3>Figure 1: RCX data structure.</h3> 
  <p>An RCX object (green) is composed of several aspects (red), 
  which themself consist different properties (blue). 
  Some properties contain sub-properties (light red) that also hold properties. 
  Properties reference ID properties of other aspects.</p>'
  )

if(require(base64enc)){
  legendImgFile <- "RCX_Data_Structure_Legend.png"
  legendImgRaw <- readBin(
    legendImgFile, 
    "raw", 
    file.info(legendImgFile)[1, "size"]
    )
  legendImgBase64 <- base64enc::base64encode(legendImgRaw)
  description <- paste0(
    description,
    '<h4>Legend:</h4>
    <p>
    <img alt="Legend" style="width: 100%;" src="data:image/png;base64,',
    legendImgBase64,
    '" />
    </p>'
  )
}

networkAttributes <- createNetworkAttributes(
  name = c(
    "name",
    "author",
    "description"
  ),
  value = c(
    "RCX Data Structure", 
    "Florian J. Auer",
    description
  )
)

rcx <- updateNetworkAttributes(rcx, networkAttributes)

## ----attributesMetadata-------------------------------------------------------
rcx$metaData

## ----cartesianLayout, tidy=FALSE----------------------------------------------
posX <- c(
  1187, # RCX
  219, 430, 540, 650, 760, 870, 980, # metaData
  219, 1189, 431, 541, # nodes
  219, 1189, 545, 655, 765, # edges
  219, 435, 545, 655, 765, 875, 985, # nodeAttributes
  219, 435, 545, 655, 765, 875, 985, # edgeAttributes
  219, 435, 545, 655, 765, 875, # networkAttribute
  219, 435, 545, 655, 765, 875, # cartesianLayout
  219, 1201, 545, 655, # cySubNetworks
  219, 435, 545, 655, 765, 875, 985, # cyGroups
  219, 435, 545, 655, 765, 875, # cyHiddenAttributes
  219, 435, 545, 655, 765, # cyNetworkRelations
  219, 435, 545, 655, 765, 875, # cyTableColum
  219, 435, 545, 655, 765, 875, # cyVisualProperties
  655, 326, 656, 986, 1096, 1206, # cyVisualProperty
  326, 325, 435, # cyVisualPropertyProperties
  656, 655, 765, # cyVisualPropertyDependencies
  986, 985, 1095, 1205, # cyVisualPropertyMappings
  219, 435, 545 # status
)
 
posY <- c(
  596, # RCX
  595, 646, 646, 646, 646, 646, 646, # metaData
  692, 743, 743, 743, # nodes
  790, 836, 836, 836, 836, # edges
  889, 934, 934, 934, 934, 934, 934, # nodeAttributes
  985, 1031, 1031, 1031, 1031, 1031, 1031, # edgeAttributes
  1081, 1126, 1126, 1126, 1126, 1126, # networkAttribute
  1174, 1219, 1219, 1219, 1219, 1219, # cartesianLayout
  1270, 1316, 1316, 1316, # cySubNetworks
  1364, 1409, 1409, 1409, 1409, 1409, 1409, # cyGroups
  1460, 1506, 1506, 1506, 1506, 1506, # cyHiddenAttributes
  1557, 1602, 1602, 1602, 1602, # cyNetworkRelations
  1653, 1699, 1699, 1699, 1699, 1699, # cyTableColum
  1750, 1795, 1795, 1795, 1795, 1795, # cyVisualProperties
  1872, 1931, 1931, 1931, 1931, 1931, # cyVisualProperty
  2001, 2059, 2059, # cyVisualPropertyProperties
  2001, 2059, 2059, # cyVisualPropertyDependencies
  2001, 2059, 2059, 2059, # cyVisualPropertyMappings
  2136, 2182, 2182 # status
) 

cartesianLayout <- createCartesianLayout(
  nodes$id, 
  x=posX,
  y=posY)


rcx <- updateCartesianLayout(rcx, cartesianLayout)

## ----visualizeCartesian, eval=FALSE-------------------------------------------
# visualize(rcx)

## ----visualPropertiesNetwork, tidy=FALSE--------------------------------------
cyVisualPropertyPropertiesNetwork <- createCyVisualPropertyProperties(
  name = c(
    "NETWORK_BACKGROUND_PAINT",
    "NETWORK_EDGE_SELECTION",
    "NETWORK_NODE_SELECTION"
  ),
  value = c(
    "#FFFFFF",
    "true",
    "true"
  )
)

cyVisualPropertyNetwork <- createCyVisualProperty(
  properties = cyVisualPropertyPropertiesNetwork
)

## ----visualPropertiesPropertiesNodes, tidy=FALSE------------------------------
cyVisualPropertyPropertiesNodes <- createCyVisualPropertyProperties(
  name = c(
    "NODE_BORDER_PAINT",
    "NODE_BORDER_STROKE",
    "NODE_BORDER_TRANSPARENCY",
    "NODE_BORDER_WIDTH",
    "NODE_DEPTH",
    "NODE_FILL_COLOR",
    "NODE_HEIGHT",
    "NODE_LABEL_COLOR",
    "NODE_LABEL_FONT_FACE",
    "NODE_LABEL_FONT_SIZE",
    "NODE_LABEL_POSITION",
    "NODE_LABEL_TRANSPARENCY",
    "NODE_LABEL_WIDTH",
    "NODE_PAINT",
    "NODE_SELECTED",
    "NODE_SELECTED_PAINT",
    "NODE_SHAPE",
    "NODE_SIZE",
    "NODE_TRANSPARENCY",
    "NODE_VISIBLE",
    "NODE_WIDTH"
  ),
  value = c(
    "#CCCCCC",
    "SOLID",
    "255",
    "0.0",
    "0.0",
    "#89D0F5",
    "40.0",
    "#000000",
    "SansSerif.plain,plain,12",
    "14",
    "C,C,c,0.00,0.00",
    "255",
    "200.0",
    "#1E90FF",
    "false",
    "#FFFF00",
    "ROUND_RECTANGLE",
    "35.0",
    "255",
    "true",
    "90.0"
  )
)

## ----visualPropertiesMappingsNodes, tidy=FALSE--------------------------------
cyVisualPropertyMappingNodes <- createCyVisualPropertyMappings(
  name=c(
    "NODE_LABEL",
    "NODE_HEIGHT",
    "NODE_WIDTH",
    "NODE_FILL_COLOR",
    "NODE_BORDER_PAINT",
    "NODE_BORDER_WIDTH",
    "NODE_LABEL_FONT_FACE",
    "NODE_LABEL_FONT_SIZE"
  ),
  type = c(
    "PASSTHROUGH",
    "DISCRETE",
    "DISCRETE",
    "DISCRETE",
    "DISCRETE",
    "DISCRETE",
    "DISCRETE",
    "DISCRETE"
  ),
  definition = c(
    "COL=name,T=string",
    paste0("COL=type,T=string,",
           "K=0=aspect,V=0=50.0,",
           "K=1=object,V=1=80.0,"),
    paste0("COL=type,T=string,",
           "K=0=aspect,V=0=300.0,",
           "K=1=object,V=1=150.0,",
           "K=2=subAspect,V=2=300.0"),
    paste0("COL=type,T=string,",
           "K=0=aspect,V=0=#FF3300,",
           "K=1=property,V=1=#73A3F0,",
           "K=2=object,V=2=#33FF66,",
           "K=3=subAspect,V=3=#FF8465"),
    paste0("COL=required,T=boolean,",
           "K=0=true,V=0=#3F3F3F"),
    paste0("COL=required,T=boolean,",
           "K=0=true,V=0=10.0"),
    paste0("COL=auto,T=boolean,",
           "K=0=true,V=0=SansSerif.italic,,plain,,14"),
    paste0("COL=type,T=string,",
           "K=0=aspect,V=0=30,",
           "K=1=object,V=1=50,",
           "K=2=subAspect,V=2=20")
  )
)

## ----visualPropertiesDependenciesNodes, tidy=FALSE----------------------------
cyVisualPropertyDependenciesNodes <- createCyVisualPropertyDependencies(
  name = c(
    "nodeCustomGraphicsSizeSync",
    "nodeSizeLocked"
  ),
  value = c(
    "true",
    "false"
  )
)

## ----visualPropertyNodes, tidy=FALSE------------------------------------------
cyVisualPropertyNodes <- createCyVisualProperty(
  properties = cyVisualPropertyPropertiesNodes,
  mappings = cyVisualPropertyMappingNodes,
  dependencies = cyVisualPropertyDependenciesNodes
)

## ----visualPropertiesPropertiesEdges, tidy=FALSE------------------------------
cyVisualPropertyPropertiesEdges <- createCyVisualPropertyProperties(
  name = c(
    "EDGE_CURVED",
    "EDGE_LINE_TYPE",
    "EDGE_PAINT",
    "EDGE_SELECTED",
    "EDGE_SELECTED_PAINT",
    "EDGE_SOURCE_ARROW_SELECTED_PAINT",
    "EDGE_SOURCE_ARROW_SHAPE",
    "EDGE_SOURCE_ARROW_SIZE",
    "EDGE_SOURCE_ARROW_UNSELECTED_PAINT",
    "EDGE_STROKE_SELECTED_PAINT",
    "EDGE_STROKE_UNSELECTED_PAINT",
    "EDGE_TARGET_ARROW_SELECTED_PAINT",
    "EDGE_TARGET_ARROW_SHAPE",
    "EDGE_TARGET_ARROW_SIZE",
    "EDGE_TARGET_ARROW_UNSELECTED_PAINT",
    "EDGE_TRANSPARENCY",
    "EDGE_VISIBLE"
  ),
  value = c(
    "false",
    "SOLID",
    "#323232",
    "false",
    "#FFFF00",
    "#FFFF00",
    "NONE",
    "6.0",
    "#000000",
    "#FF0000",
    "#848484",
    "#FFFF00",
    "NONE",
    "6.0",
    "#000000",
    "255",
    "true"
  )
)

## ----visualPropertiesMappingsEdges, tidy=FALSE--------------------------------
cyVisualPropertyMappingEdges <- createCyVisualPropertyMappings(
  name=c(
    "EDGE_LINE_TYPE",
    "EDGE_TARGET_ARROW_SHAPE",
    "EDGE_UNSELECTED_PAINT",
    "EDGE_WIDTH"
  ),
  type = c(
    "DISCRETE",
    "DISCRETE",
    "DISCRETE",
    "DISCRETE"
  ),
  definition = c(
    paste0("COL=interaction,T=string,",
           "K=0=references,V=0=SEPARATE_ARROW"),
    paste0("COL=interaction,T=string,",
           "K=0=contains,V=0=SQUARE,",
           "K=1=references,V=1=DELTA"),
    paste0("COL=interaction,T=string,",
           "K=0=propertyOf,V=0=#FFAD99,",
           "K=1=contains,V=1=#73A3F0,",
           "K=2=aspectOf,V=2=#CBFFD8,",
           "K=3=references,V=3=#0D377C"),
    paste0("COL=interaction,T=string,",
           "K=0=partOf,V=0=10.0,",
           "K=1=propertyOf,V=1=5.0,",
           "K=2=contains,V=2=5.0,",
           "K=3=aspectOf,V=3=7.0,",
           "K=4=references,V=4=3.0")
  )
)

## ----visualPropertiesDependenciesEdges, tidy=FALSE----------------------------
cyVisualPropertyDependenciesEdges <- createCyVisualPropertyDependencies(
  name = c(
    "arrowColorMatchesEdge"
  ),
  value = c(
    "true"
  )
)

## ----visualPropertyEdges, tidy=FALSE------------------------------------------
cyVisualPropertyEdges <- createCyVisualProperty(
  properties=cyVisualPropertyPropertiesEdges,
  mappings = cyVisualPropertyMappingEdges,
  dependencies = cyVisualPropertyDependenciesEdges
)

## ----visualProperties, tidy=FALSE---------------------------------------------
cyVisualProperties <- createCyVisualProperties(
  network = cyVisualPropertyNetwork,
  defaultNodes = cyVisualPropertyNodes,
  defaultEdges = cyVisualPropertyEdges
)

rcx <- updateCyVisualProperties(rcx, cyVisualProperties)

## ----tableColumn, tidy=FALSE--------------------------------------------------
cyTableColumn <- createCyTableColumn(
  name = c("name", "type", "required", "auto", 
           "name", "interaction", 
           "name", "author", "description"),
  appliesTo = c("nodes", "nodes", "nodes", "nodes", 
                "edges", "edges", 
                "networks", "networks", "networks"),
  dataType = c("string", "string", "boolean", "boolean", 
               "string", "string", 
               "string", "string", "string")
)

rcx <- updateCyTableColumn(rcx, cyTableColumn)

## ----visualizeRCX, eval=FALSE-------------------------------------------------
# visualize(rcx)

## ----reuseVisualProperties, eval=FALSE----------------------------------------
# newRcx = updateCyVisualProperties(newRCX, rcx$cyVisualProperties)

## ----metaData, tidy=FALSE-----------------------------------------------------
rcx <- updateMetaData(
  rcx, 
  version = c(
    nodes="1.1",
    edges="1.1",
    nodeAttributes="1.1",
    networkAttributes="1.1",
    cartesianLayout="1.1",
    cyVisualProperties="1.1",
    cyTableColumn="1.1"
  ),
  consistencyGroup = c(
    nodes=2,
    edges=2,
    nodeAttributes=2,
    networkAttributes=2,
    cartesianLayout=2,
    cyVisualProperties=2,
    cyTableColumn=2
  ))

rcx$metaData

## ----createRCX, tidy=FALSE----------------------------------------------------
rcx <- createRCX(
  nodes = nodes,
  edges = edges,
  nodeAttributes = nodeAttributes,
  networkAttributes = networkAttributes,
  cartesianLayout = cartesianLayout,
  cyVisualProperties = cyVisualProperties,
  cyTableColumn = cyTableColumn
)

## ----writeRDS, eval=FALSE-----------------------------------------------------
# saveRDS(rcx, "path/to/some-file.rds")

## ----writeCX, eval=FALSE------------------------------------------------------
# writeCX(rcx, "path/to/some-file.cx")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

