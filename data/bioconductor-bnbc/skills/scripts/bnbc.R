# Code example from 'bnbc' vignette. See references/ for full tutorial.

## ----dependencies, warning=FALSE, message=FALSE-------------------------------
library(bnbc)
library(HiCBricks)
library(BSgenome.Hsapiens.UCSC.hg19)

hg19 <- BSgenome.Hsapiens.UCSC.hg19

## ----dataLoad-----------------------------------------------------------------
data(cgEx)
cgEx

## ----create-------------------------------------------------------------------
cgEx <- ContactGroup(rowData=rowData(cgEx),
                     contacts=contacts(cgEx),
                     colData=colData(cgEx))

## ----print--------------------------------------------------------------------
cgEx

## ----contactTriang------------------------------------------------------------
mat <- matrix(1:9, nrow = 3, ncol = 3)
mat[lower.tri(mat)] <- 0
mat
## Now we fill in the lower triangular matrix with the upper triangular
mat[lower.tri(mat)] <- mat[upper.tri(mat)]
mat

## ----data_to_bnbc, eval=FALSE, echo=TRUE--------------------------------------
# ## Example not run
# ## Convert upper triangles to symmetry matrix
# MatsList <- lapply(upper.mats.list, function(M) {
#     M[lower.tri(M)] <- M[upper.tri(M)]
# })
# ## Use ContactGroup constructor method
# cg <- ContactGroup(rowData = LociData, contacts = MatsList, colData = SampleData)

## ----cooler_get_genome_index--------------------------------------------------
coolerDir <- system.file("cooler", package = "bnbc")
cools <- list.files(coolerDir, pattern="mcool$", full.names=TRUE)

step <- 4e4

ixns <- bnbc:::getChrIdx(seqlengths(hg19)["chr22"], "chr22", step)

## ----cooler_get_cg------------------------------------------------------------
dir.create("tmp")

cool.cg <- bnbc:::getChrCGFromCools(files = cools,
                                    chr = "chr22",
                                    step = step,
                                    index.gr = ixns,
                                    work.dir = "tmp",
                                    exp.name = "example",
                                    coldata = colData(cgEx)[1:2,])
all.equal(contacts(cgEx)[[1]], contacts(cool.cg)[[1]])

## ----band_example-------------------------------------------------------------
mat.1 <- contacts(cgEx)[[1]]
mat.1[1000:1005, 1000:1005]
b1 <- band(mat=mat.1, band.no=2)
band(mat=mat.1, band.no=2) <- b1 + 1
mat.1[1000:1005, 1000:1005]

## ----logcpm-------------------------------------------------------------------
cgEx.cpm <- logCPM(cgEx)

## ----smoothing----------------------------------------------------------------
cgEx.smooth <- boxSmoother(cgEx.cpm, h=5)
## or
## cgEx.smooth <- gaussSmoother(cgEx.cpm, radius=3, sigma=4)

## ----bnbc---------------------------------------------------------------------
cgEx.bnbc <- bnbc(cgEx.smooth, batch=colData(cgEx.smooth)$Batch,
                  threshold=1e7, step=4e4, nbands=11, verbose=FALSE)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

