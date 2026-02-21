# Code example from 'QuickBSgenomeForge' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("BSgenomeForge")

## ----message=FALSE------------------------------------------------------------
library(BSgenomeForge)

## -----------------------------------------------------------------------------
forgeBSgenomeDataPkgFromNCBI(assembly_accession="GCA_009729545.1",
                             pkg_maintainer="Jane Doe <janedoe@gmail.com>",
                             organism="Acidianus infernus")

## -----------------------------------------------------------------------------
forgeBSgenomeDataPkgFromNCBI(assembly_accession="GCA_008369605.1",
                             pkg_maintainer="Jane Doe <janedoe@gmail.com>",
                             organism="Vibrio cholerae",
                             circ_seqs=c("1", "2", "unnamed"))

## -----------------------------------------------------------------------------
forgeBSgenomeDataPkgFromUCSC(
    genome="wuhCor1",
    organism="Severe acute respiratory syndrome coronavirus 2",
    pkg_maintainer="Jane Doe <janedoe@gmail.com>"
)

## -----------------------------------------------------------------------------
devtools::build("./BSgenome.Ainfernus.NCBI.ASM972954v1")

## ----eval=FALSE---------------------------------------------------------------
# devtools::check_built("BSgenome.Ainfernus.NCBI.ASM972954v1_1.0.0.tar.gz")

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_local("BSgenome.Ainfernus.NCBI.ASM972954v1_1.0.0.tar.gz")

## -----------------------------------------------------------------------------
sessionInfo()

