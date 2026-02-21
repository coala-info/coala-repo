# Code example from 'Extending_the_RCX_Data_Model' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(tidy.opts=list(width.cutoff=75,
                              args.newline = TRUE,
                              arrow = TRUE),
               tidy=TRUE)

## ----loadLib------------------------------------------------------------------
library(RCX)

## ----create, tidy=FALSE-------------------------------------------------------
createNetworkProvenance <- function(
  id = NULL, 
  time, 
  action, 
  nodes, 
  source = NULL, 
  comment = NULL){
  
  ## generate id if not provided  
  if(is.null(id)){
    id = 0:(length(name) -1)
  }
  
  ## create aspect with default values
  res = data.frame(
    id = id,
    time = time,
    action = action,
    nodes = NA,
    source = NA,
    comment = NA,
    stringsAsFactors=FALSE, check.names=FALSE
  )
  
  ## add nodes
  if(!is.list(nodes)) nodes <- list(nodes)
  res$nodes = nodes
  
  
  ## add source if provided
  if(!is.null(source)){
    res$source <- source
  }
  
  ## add comment if provided
  if(!is.null(comment)){
    res$comment <- comment
  }
  
  ## add a class name
  class(res) <- append("NetworkProvenanceAspect", class(res))
  return(res)
}

## ----createExample, tidy=FALSE------------------------------------------------
networkProvenance <- createNetworkProvenance(
  id = c(1,2,3), 
  time = c(1445437740, 1445437770, 1445437799), 
  action = c("created", "merged", "filtered"), 
  nodes = list(
    c(1, 2, 3, 4, 5, 6),
    c(7, 8, 9, 10),
    c()
  ),
  source = c(
    "https://www.ndexbio.org/viewer/networks/66a902f5-2022-11e9-bb6a-0ac135e8bacf",
    "https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE33075",
    NA
  ), 
  comment = c(NA, NA, "Some manual filtering was performed")
)

networkProvenance

## ----updateUseMethod----------------------------------------------------------
updateNetworkProvenance = function(x, aspect){
    UseMethod("updateNetworkProvenance", x)
}

## ----updateAspect-------------------------------------------------------------
updateNetworkProvenance.NetworkProvenanceAspect = function(x, aspect){
    res = plyr::rbind.fill(x, aspect)
    
    if(! "NetworkProvenanceAspect" %in% class(res)){
      class(res) = append("NetworkProvenanceAspect", class(res))
    }
    return(res)
}

## ----updateAspectExample, tidy=FALSE------------------------------------------
## Split the original example
## Create first part
np1 <- createNetworkProvenance(
  id = c(1,2), 
  time = c(1445437740, 1445437770), 
  action = c("created", "merged"),  
  nodes = list(
    c(1, 2, 3, 4, 5, 6),
    c(7, 8, 9, 10)
  ),
  source = c(
    "https://www.ndexbio.org/viewer/networks/66a902f5-2022-11e9-bb6a-0ac135e8bacf",
    "https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE33075"
  )
)

## Create second part
np2 <- createNetworkProvenance(
  id = 3, 
  time = 1445437799, 
  action = "filtered",
  nodes = c(),
  comment = "Some manual filtering was performed"
)

## Merge the parts
networkProvenance <- updateNetworkProvenance(np1, np2)

networkProvenance

## ----updateRCX----------------------------------------------------------------
updateNetworkProvenance.RCX = function(x, aspect){
    rcxAspect = x$networkProvenance
    if(! is.null(rcxAspect)){
      aspect = updateNetworkProvenance(rcxAspect, aspect)
    }
    
    x$networkProvenance = aspect
    
    x = updateMetaData(x)
    
    return(x)
}

## ----updateRCXExample---------------------------------------------------------
## Prepare an RCX object
rcx = createRCX(
  nodes = createNodes(
    name = LETTERS[1:10]
  ),
  edges = createEdges(
    source=c(1,2),
    target = c(2,3)
  )
)

## Add the first part of network provenance
rcx = updateNetworkProvenance(rcx, np1)

## Add the second part
rcx = updateNetworkProvenance(rcx, np2)

rcx

## ----aspectClasses, tidy=FALSE------------------------------------------------
aspectClasses = getAspectClasses()

aspectClasses["networkProvenance"] <- "NetworkProvenanceAspect"

updateAspectClasses(aspectClasses)

getAspectClasses()

## ----updateMetadata-----------------------------------------------------------
rcx = updateMetaData(rcx)
rcx$metaData

rcx = updateMetaData(rcx, aspectClasses=aspectClasses)
rcx$metaData

## ----updateRCXwithMetadata----------------------------------------------------
updateNetworkProvenance.RCX = function(x, aspect){
    rcxAspect = x$networkProvenance
    if(! is.null(rcxAspect)){
      aspect = updateNetworkProvenance(rcxAspect, aspect)
    }
    
    x$networkProvenance = aspect
    
    x = updateMetaData(x, aspectClasses=aspectClasses)
    
    return(x)
}

## ----setExtension, eval=FALSE-------------------------------------------------
# .onLoad <- function(libname, pkgname) {
#  RCX::setExtension(pkgname, "networkProvenance", "NetworkProvenanceAspect")
#  invisible()
# }

## ----idProperty---------------------------------------------------------------
hasIds.NetworkProvenanceAspect = function (aspect) {
  return(TRUE)
}

idProperty.NetworkProvenanceAspect = function (aspect) {
  return("id")
}

## ----idPropertyExample--------------------------------------------------------
rcx = updateMetaData(rcx, aspectClasses=aspectClasses)
rcx$metaData

## ----idPropertyTime-----------------------------------------------------------
idProperty.NetworkProvenanceAspect = function (aspect) {
  return("time")
}

rcx = updateMetaData(rcx, aspectClasses=aspectClasses)
rcx$metaData

## ----idPropertyBack-----------------------------------------------------------
idProperty.NetworkProvenanceAspect = function (aspect) {
  return("id")
}

## ----refersTo-----------------------------------------------------------------
refersTo.NetworkProvenanceAspect = function (aspect) {
  nodes = aspectClasses["nodes"]
  names(nodes) = NULL
  result = c(nodes=nodes)
  return(result)
}

refersTo(rcx$edges)
refersTo(rcx$networkProvenance)
referredBy(rcx)
referredBy(rcx, aspectClasses)

## ----print--------------------------------------------------------------------
print.NetworkProvenanceAspect = function(x, ...){
    cat("Network provenance:\n")
    class(x) = class(x)[! class(x) %in% "NetworkProvenanceAspect"]
    print(x, ...)
}

## ----further, eval=FALSE------------------------------------------------------
# summary.NetworkProvenanceAspect = function(object, ...){ ... }
# countElements.NetworkProvenanceAspect = function(x){ ... }

## ----validate, tidy=FALSE-----------------------------------------------------
validate.NetworkProvenanceAspect = function(x, verbose=TRUE){
    if(verbose) cat("Checking Network Provenance Aspect:\n")
    
    test = all(! is.na(x$id))
    if(verbose) cat(paste0("- Column (id) doesn't contain any NA values...",
                           ifelse(test, "OK", "FAIL"),
                           "\n"))
    pass = test
    
    test = length(x$id) == length(unique(x$id))
    if(verbose) cat(paste0("- Column (id) contains only unique values...",
                           ifelse(test, "OK", "FAIL"),
                           "\n"))
    pass = pass & test
    

    if(verbose) cat(paste0(">> Network Provenance Aspect: ",
                           ifelse(test, "OK", "FAIL"),
                           "\n"))
    invisible(pass)
}

validate(rcx, verbose = TRUE)

## ----rcxToJson----------------------------------------------------------------
rcxToJson.NetworkProvenanceAspect = function(aspect, verbose=FALSE, ...){
  if(verbose) cat("Convert network provenance to JSON...")
  
  ## rename id to @id
  colnames(aspect) = gsub("id","\\@id",colnames(aspect))
  
  ## convert to json
  json = jsonlite::toJSON(aspect, pretty = TRUE)
  
  ## empty nodes are converted to "nodes": {},
  ## the simplest fix is just replacing it
  json = gsub('"nodes": \\{\\},', '"nodes": \\[\\],', json)
  
  ## add the aspect name
  json = paste0('{"networkProvenance":',json,"}")
  
  if(verbose) cat("done!\n")
  return(json)
}

cat(rcxToJson(rcx$networkProvenance))

## ----writeCX------------------------------------------------------------------
tempCX = tempfile(fileext = ".cx")
writeCX(rcx, tempCX)

## ----jsonToRCX----------------------------------------------------------------
jsonToRCX.networkProvenance = function(jsonData, verbose){
  if(verbose) cat("Parsing network provenance...")
  data = jsonData$networkProvenance
  
  ids = sapply(data, function(d){d$`@id`})
  time = sapply(data, function(d){d$time})
  action = sapply(data, function(d){d$action})
  nodes = sapply(data, function(d){d$nodes})
  source = sapply(data, function(d){d$source})
  comment = sapply(data, function(d){d$comment})
  
  if(verbose) cat("create aspect...")
  result = createNetworkProvenance(
    id = ids,
    time = time,
    action = action,
    nodes = nodes,
    source = source,
    comment = comment
  )

  if(verbose) cat("done!\n")
  return(result)
}
rcxParsed = readCX(tempCX, aspectClasses = aspectClasses)

## ----fromCXfinal--------------------------------------------------------------
rcxParsed = updateMetaData(rcxParsed, aspectClasses=aspectClasses)
rcxParsed$metaData

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

