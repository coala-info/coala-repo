# Code example from 'PairwiseWholeGenomeAlignment' vignette. See references/ for full tutorial.

## ----code, echo = FALSE-------------------------------------------------------
code <- function(...) {
    cat(paste(..., sep = "\n"))
}

date = "`r doc_date()`"
pkg = "`r pkg_ver('BiocStyle')`"

## ----lastz, eval=FALSE, echo=TRUE---------------------------------------------
# ## lastz aligner
# assemblyDir <- "/Users/gtan/OneDrive/Project/CSC/CNEr/2bit"
# axtDir <- "/Users/gtan/OneDrive/Project/CSC/CNEr/axt"
# assemblyTarget <- file.path(system.file("extdata",
#                             package="BSgenome.Drerio.UCSC.danRer10"),
#                             "single_sequences.2bit")
# assemblyQuery <- file.path(system.file("extdata",
#                                        package="BSgenome.Hsapiens.UCSC.hg38"),
#                            "single_sequences.2bit")
# lavs <- lastz(assemblyTarget, assemblyQuery,
#               outputDir=axtDir,
#               chrsTarget=c("chr1", "chr2", "chr3"),
#               chrsQuery=c("chr1", "chr2", "chr3"),
#               distance="far", mc.cores=4)
# 
# ## lav files to psl files conversion
# psls <- lavToPsl(lavs, removeLav=FALSE, binary="lavToPsl")

## ----last, eval=FALSE, echo=TRUE----------------------------------------------
# ## Build the lastdb index
# system2(command="lastdb", args=c("-c", file.path(assemblyDir, "danRer10"),
#                                  file.path(assemblyDir, "danRer10.fa")))
# 
# ## Run last aligner
# lastal(db=file.path(assemblyDir, "danRer10"),
#        queryFn=file.path(assemblyDir, "hg38.fa"),
#        outputFn=file.path(axtDir, "danRer10.hg38.maf"),
#        distance="far", binary="lastal", mc.cores=4L)
# 
# ## maf to psl
# psls <- file.path(axtDir, "danRer10.hg38.psl")
# system2(command="maf-convert", args=c("psl",
#                                       file.path(axtDir, "danRer10.hg38.maf"),
#                                       ">", psls))

## ----chain, eval=FALSE, echo=TRUE---------------------------------------------
# ## Join close alignments
# chains <- axtChain(psls, assemblyTarget=assemblyTarget,
#                    assemblyQuery=assemblyQuery, distance="far",
#                    removePsl=FALSE, binary="axtChain")
# 
# ## Sort and combine
# allChain <- chainMergeSort(chains, assemblyTarget, assemblyQuery,
#               allChain=file.path(axtDir,
#                          paste0(sub("\\.2bit$", "", basename(assemblyTarget),
#                                     ignore.case=TRUE), ".",
#                                 sub("\\.2bit$", "", basename(assemblyQuery),
#                                     ignore.case=TRUE), ".all.chain")),
#                            removeChains=FALSE, binary="chainMergeSort")

## ----netting, eval=FALSE, echo=TRUE-------------------------------------------
# ## Filtering out chains
# allPreChain <- chainPreNet(allChain, assemblyTarget, assemblyQuery,
#                            allPreChain=file.path(axtDir,
#                                       paste0(sub("\\.2bit$", "",
#                                                  basename(assemblyTarget),
#                                                  ignore.case = TRUE), ".",
#                                              sub("\\.2bit$", "",
#                                                  basename(assemblyQuery),
#                                                  ignore.case = TRUE),
#                                                  ".all.pre.chain")),
#                            removeAllChain=FALSE, binary="chainPreNet")
# 
# ## Keep the best chain and add synteny information
# netSyntenicFile <- chainNetSyntenic(allPreChain, assemblyTarget, assemblyQuery,
#                      netSyntenicFile=file.path(axtDir,
#                                                paste0(sub("\\.2bit$", "",
#                                                       basename(assemblyTarget),
#                                                       ignore.case = TRUE), ".",
#                                                       sub("\\.2bit$", "",
#                                                       basename(assemblyQuery),
#                                                       ignore.case = TRUE),
#                                                ".noClass.net")),
#                      binaryChainNet="chainNet", binaryNetSyntenic="netSyntenic")

## ----axtNet, eval=FALSE, echo=TRUE--------------------------------------------
# netToAxt(netSyntenicFile, allPreChain, assemblyTarget, assemblyQuery,
#          axtFile=file.path(axtDir,
#                            paste0(sub("\\.2bit$", "",
#                                       basename(assemblyTarget),
#                                       ignore.case = TRUE), ".",
#                                   sub("\\.2bit$", "",
#                                       basename(assemblyQuery),
#                                       ignore.case = TRUE),
#                                   ".net.axt")),
#              removeFiles=FALSE,
#              binaryNetToAxt="netToAxt", binaryAxtSort="axtSort")
# 

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

