# Code example from 'sitadela' vignette. See references/ for full tutorial.

## ----install-0, eval=FALSE, echo=TRUE-----------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("sitadela")

## ----load-0, eval=TRUE, echo=FALSE, tidy=FALSE, message=FALSE, warning=FALSE----
library(sitadela)

## ----example-1, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
library(sitadela)

buildDir <- file.path(tempdir(),"test_anndb")
dir.create(buildDir)

# The location of the custom database
myDb <- file.path(buildDir,"testann.sqlite")

# Since we are using Ensembl, we can also ask for a version
organisms <- list(mm10=100)
sources <- ifelse(.Platform$OS.type=="unix",c("ensembl","refseq"),"ensembl")

# If the example is not running in a multicore system, rc is ignored
addAnnotation(organisms,sources,forceDownload=FALSE,db=myDb,rc=0.5)

## Alternatively
# setDbPath(myDb)
# addAnnotation(organisms,sources,forceDownload=FALSE,rc=0.5)

## ----example-2, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
# Load standard annotation based on gene body coordinates
genes <- loadAnnotation(genome="mm10",refdb="ensembl",type="gene",db=myDb)
genes

# Load standard annotation based on 3' UTR coordinates
utrs <- loadAnnotation(genome="mm10",refdb="ensembl",type="utr",db=myDb)
utrs

# Load summarized exon annotation based used with RNA-Seq analysis
sumEx <- loadAnnotation(genome="mm10",refdb="ensembl",type="exon",
    summarized=TRUE,db=myDb)
sumEx

## Load standard annotation based on gene body coordinates from RefSeq
#if (.Platform$OS.type=="unix") {
#    refGenes <- loadAnnotation(genome="mm10",refdb="refseq",type="gene",
#        db=myDb)
#    refGenes
#}

## ----example-3, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
# Load standard annotation based on gene body coordinates
genes <- loadAnnotation(genome="mm10",refdb="ensembl",type="gene",db=myDb,
    asdf=TRUE)
head(genes)

## ----example-4, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
gtf <- system.file(package="sitadela","extdata",
    "gadMor1_HE567025.gtf.gz")
chrom <- system.file(package="sitadela","extdata",
    "gadMor1_HE567025.txt.gz")
chromInfo <- read.delim(chrom,header=FALSE,row.names=1)
names(chromInfo) <- "length"
metadata <- list(
    organism="gadMor1_HE567025",
    source="sitadela_package",
    chromInfo=chromInfo
)
tmpdb <- tempfile()

addCustomAnnotation(gtfFile=gtf,metadata=metadata,db=tmpdb)

# Try to retrieve some data
g <- loadAnnotation(genome="gadMor1_HE567025",refdb="sitadela_package",
    type="gene",db=tmpdb)
g

# Delete the temporary database
unlink(tmpdb)

## ----example-5, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
gtf <- system.file(package="sitadela","extdata",
    "eboVir3_KM034562v1.gtf.gz")
chrom <- system.file(package="sitadela","extdata",
    "eboVir3_KM034562v1.txt.gz")
chromInfo <- read.delim(chrom,header=FALSE,row.names=1)
names(chromInfo) <- "length"
metadata <- list(
    organism="gadMor1_HE567025",
    source="sitadela_package",
    chromInfo=chromInfo
)
tmpdb <- tempfile()

addCustomAnnotation(gtfFile=gtf,metadata=metadata,db=tmpdb)

# Try to retrieve some data
g <- loadAnnotation(genome="gadMor1_HE567025",refdb="sitadela_package",
    type="gene",db=tmpdb)
g

# Delete the temporary database
unlink(tmpdb)

## ----example-5-1, eval=FALSE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
# # Setup a temporary directory to download files etc.
# customDir <- file.path(tempdir(),"test_custom")
# dir.create(customDir)
# 
# # Convert from GenePred to GTF - Unix/Linux only!
# if (.Platform$OS.type == "unix" && !grepl("^darwin",R.version$os)) {
#     # Download data from UCSC
#     goldenPath="http://hgdownload.cse.ucsc.edu/goldenPath/"
#     # Gene annotation dump
#     download.file(paste0(goldenPath,"eboVir3/database/ncbiGene.txt.gz"),
#         file.path(customDir,"eboVir3_ncbiGene.txt.gz"))
#     # Chromosome information
#     download.file(paste0(goldenPath,"eboVir3/database/chromInfo.txt.gz"),
#         file.path(customDir,"eboVir3_chromInfo.txt.gz"))
# 
#     # Prepare the build
#     chromInfo <- read.delim(file.path(customDir,"eboVir3_chromInfo.txt.gz"),
#         header=FALSE)
#     chromInfo <- chromInfo[,1:2]
#     rownames(chromInfo) <- as.character(chromInfo[,1])
#     chromInfo <- chromInfo[,2,drop=FALSE]
# 
#     # Coversion from genePred to GTF
#     genePredToGtf <- file.path(customDir,"genePredToGtf")
#     if (!file.exists(genePredToGtf)) {
#         download.file(
#         "http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/genePredToGtf",
#             genePredToGtf
#         )
#         system(paste("chmod 775",genePredToGtf))
#     }
#     gtfFile <- file.path(customDir,"eboVir3.gtf")
#     tmpName <- file.path(customDir,paste(format(Sys.time(),"%Y%m%d%H%M%S"),
#         "tgtf",sep="."))
#     command <- paste0(
#         "zcat ",file.path(customDir,"eboVir3_ncbiGene.txt.gz"),
#         " | ","cut -f2- | ",genePredToGtf," file stdin ",tmpName,
#         " -source=eboVir3"," -utr && grep -vP '\t\\.\t\\.\t' ",tmpName," > ",
#         gtfFile
#     )
#     system(command)
# 
#     # Build with the metadata list filled (you can also provide a version)
#     addCustomAnnotation(
#         gtfFile=gtfFile,
#         metadata=list(
#             organism="eboVir3_test",
#             source="ucsc_test",
#             chromInfo=chromInfo
#         ),
#         db=myDb
#     )
# 
#     # Try to retrieve some data
#     eboGenes <- loadAnnotation(genome="eboVir3_test",refdb="ucsc_test",
#         type="gene",db=myDb)
#     eboGenes
# }

## ----example-6, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
gtfFile <- system.file(package="sitadela","extdata",
    "gadMor1_HE567025.gtf.gz")
chromInfo <- read.delim(system.file(package="sitadela","extdata",
    "gadMor1_HE567025.txt.gz"),header=FALSE)

# Build with the metadata list filled (you can also provide a version)
addCustomAnnotation(
    gtfFile=gtfFile,
    metadata=list(
        organism="gadMor1_test",
        source="ucsc_test",
        chromInfo=chromInfo
    ),
    db=myDb
)

# Try to retrieve some data
gadGenes <- loadAnnotation(genome="gadMor1_test",refdb="ucsc_test",
    type="gene",db=myDb)
gadGenes

## ----example-7, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
gtfFile <- system.file(package="sitadela","extdata",
    "dasNov3_JH569334.gtf.gz")
chromInfo <- read.delim(system.file(package="sitadela",
    "extdata","dasNov3_JH569334.txt.gz"),header=FALSE)

# Build with the metadata list filled (you can also provide a version)
addCustomAnnotation(
    gtfFile=gtfFile,
    metadata=list(
        organism="dasNov3_test",
        source="ensembl_test",
        chromInfo=chromInfo
    ),
    db=myDb
)

# Try to retrieve some data
dasGenes <- loadAnnotation(genome="dasNov3_test",refdb="ensembl_test",
    type="gene",db=myDb)
dasGenes

## ----example-8, eval=FALSE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
# organisms <- list(
#     hg18=54,
#     hg19=75,
#     hg38=110:111,
#     mm9=54,
#     mm10=110:111,
#     rn5=77,
#     rn6=110:111,
#     dm3=77,
#     dm6=110:111,
#     danrer7=77,
#     danrer10=80,
#     danrer11=110:111,
#     pantro4=80,
#     pantro5=110:111,
#     susscr3=80,
#     susscr11=110:111,
#     equcab2=110:111
# )
# 
# sources <- c("ensembl","ucsc","refseq","ncbi")
# 
# addAnnotation(organisms,sources,forceDownload=FALSE,rc=0.5)

## ----pseudo-1, eval=TRUE, echo=TRUE, message=TRUE, warning=FALSE--------------
metadata <- list(
    organism="ORGANISM_NAME",
    source="SOURCE_NAME",
    chromInfo="CHROM_INFO"
)

## ----si-1, eval=TRUE, echo=TRUE-----------------------------------------------
sessionInfo()

