# Code example from 'createReposHtml' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# reposRoot <- "path/to/reposRoot"
# ## The names are essential
# contribPaths <- c(source="src/contrib",
#                    win.binary="bin/windows/contrib/4.0",
#                    mac.binary="bin/macosx/contrib/4.0")

## ----eval=FALSE---------------------------------------------------------------
# extractVignettes(reposRoot, contribPaths["source"])

## ----eval=FALSE---------------------------------------------------------------
# genReposControlFiles(reposRoot, contribPaths)

## ----eval=FALSE---------------------------------------------------------------
# ## Define classes like this for each logical document chunk
# setClass("pdAuthorMaintainerInfo", contains="PackageDetail")
# setClass("pdVignetteInfo", contains="PackageDetail")
# ## Then define a htmlValue method
# setMethod("htmlValue", signature(object="pdDescriptionInfo"),
#            function(object) {
#            node <- xmlNode("p", cleanText(object@Description),
#                             attrs=c(class="description"))
#            node
#          })
# ## Then you can make use of all this...
# ## Assume object contains a PackageDetail instance
# authorInfo <- as(object, "pdAuthorMaintainerInfo")
# dom$addNode(htmlValue(authorInfo))

## ----eval=FALSE---------------------------------------------------------------
# details <- list(heading=list(tag="h3", text="Details"),
#                 content="pdDetailsInfo")
# downloads <- list(heading=list(tag="h3", text="Download Package"),
#                  content="pdDownloadInfo")
# vignettes <- list(heading=list(tag="h3",
#                     text="Vignettes (Documentation)"),
#                  content="pdVignetteInfo")
# doSection <- function(sec) {
#    dom$addTag(sec$heading$tag, sec$heading$text)
#    secObj <- as(object, sec$content)
#    dom$addNode(htmlValue(secObj))
# }
# lapply(list(details, downloads, vignettes), doSection)

