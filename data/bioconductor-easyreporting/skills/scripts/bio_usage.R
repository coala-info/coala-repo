# Code example from 'bio_usage' vignette. See references/ for full tutorial.

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
proj.path <- file.path(tempdir(), "bioinfo_report")
bioEr <- easyreporting(filenamePath=proj.path, title="bioinfo_report",
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

## -----------------------------------------------------------------------------
mkdTitle(bioEr, title="Loading Counts Data")
mkdCodeChunkComplete(object=bioEr, code=quote(geneCounts <- importData(
      system.file("extdata/GSE134118_Table_S3.xlsx", package="easyreporting"))), 
      sourceFilesList=system.file("script/importFunctions.R", package="easyreporting"))


## -----------------------------------------------------------------------------
mkdTitle(bioEr, title="Plot PCA on count data", level=2)
mkdCodeChunkComplete(bioEr, 
                        code=quote(EDASeq::plotPCA(as.matrix(geneCounts))))

## -----------------------------------------------------------------------------
mkdTitle(bioEr, "Differential Expression Analysis")
mkdCodeChunkCommented(bioEr, 
    code="degList <- applyEdgeRExample(counts=geneCounts, 
                    samples=colnames(geneCounts), contrast='Pleura - Broth')", 
    comment=paste0("As we saw from the PCA, the groups are well separated",
        ", so we can perform a Differential Expression analysis with edgeR."),
    sourceFilesList=system.file("script/geneFunctions.R", 
                                package="easyreporting"))

## -----------------------------------------------------------------------------
mkdTitle(bioEr, "MD Plot of DEGs", level=2)
mkdCodeChunkComplete(bioEr, code="limma::plotMD(degList$test)")

## ----eval=FALSE---------------------------------------------------------------
# compile(bioEr)

## ----tidy=TRUE----------------------------------------------------------------
sessionInfo()

