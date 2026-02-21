# Code example from 'standard_usage' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = FALSE,
  comment = "#>",
  eval=TRUE
)

## ----eval=FALSE---------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("easyreporting")

## -----------------------------------------------------------------------------
library("easyreporting")

## -----------------------------------------------------------------------------
proj.path <- file.path(tempdir(), "general_report")

er <- easyreporting(filenamePath=proj.path, title="example_report",
                  author=c(
                      person(given="Dario", family="Righelli", 
                          email="fake_email@gmail.com",
                          comment=c(ORCID="ORCIDNUMBER", 
                                    url="www.fakepersonalurl.com",
                                    affiliation="Institute of Applied Mathematics, CNR, Naples, IT", 
                                    affiliation_url="www.fakeurl.com")),
                    person(given="Claudia", family="Angelini",
                    comment=c(ORCID="ORCIDNUMBER",
                              url="www.fakepersonalurl.com",
                              affiliation="Institute of Applied Mathematics, CNR, Naples, IT",
                              affiliation_url="www.fakeurl.com"))
                    )
                  )
                    


er <- easyreporting(filenamePath=proj.path, title="example_report",
                        author=c("Dario Righelli"))

## -----------------------------------------------------------------------------
mkdTitle(er, title="Code Chunks", level=1)

mkdGeneralMsg(er, "A simple paragraph useful to describe my code chunk...")

## -----------------------------------------------------------------------------
mkdTitle(er, title="Manual code chunk", level=2)

mkdCodeChunkSt(er)
variable <- 1
mkdVariableAssignment(er, "variable", `variable`, show=TRUE)
mkdCodeChunkEnd(er)

## -----------------------------------------------------------------------------
optList <- makeOptionsList(echoFlag=TRUE, includeFlag=TRUE)
mkdCodeChunkSt(er, optionList=optList)
mkdCodeChunkEnd(er)

## -----------------------------------------------------------------------------
## moreover I can add a list of files to source in che code chunk
RFilesList <- list.files(system.file("script", package="easyreporting"), 
                        full.names=TRUE)
mkdCodeChunkSt(er, optionList=optList, sourceFilesList=RFilesList)
mkdGeneralMsg(er, message="(v <- fakeFunction(10))")
mkdCodeChunkEnd(er)

## -----------------------------------------------------------------------------
mkdCodeChunkComplete(er, code="v <- fakeFunction(11)")

## -----------------------------------------------------------------------------
optList <- makeOptionsList(includeFlag=TRUE, cacheFlag=TRUE)

mkdCodeChunkCommented(er, 
                comment="This is the comment of the following code chunk",
                code="v <- fakeFunction(12)",
                optionList=optList,
                sourceFilesList=NULL)

## ----eval=FALSE---------------------------------------------------------------
# compile(er)

## ----tidy=TRUE----------------------------------------------------------------
sessionInfo()

