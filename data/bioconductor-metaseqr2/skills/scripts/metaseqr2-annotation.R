# Code example from 'metaseqr2-annotation' vignette. See references/ for full tutorial.

## ----install-0, eval=FALSE, echo=TRUE-----------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("metaseqR2")

## ----load-0, eval=TRUE, echo=FALSE, tidy=FALSE, message=FALSE, warning=FALSE----
library(metaseqR2)

## ----example-1, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
library(metaseqR2)

buildDir <- file.path(tempdir(),"test_anndb")
dir.create(buildDir)

# The location of the custom database
myDb <- file.path(buildDir,"testann.sqlite")

# Since we are using Ensembl, we can also ask for a version
organisms <- list(mm10=100)
sources <- ifelse(.Platform$OS.type=="unix",c("ensembl","refseq"),"ensembl")

# If the example is not running in a multicore system, rc is ignored
buildAnnotationDatabase(organisms,sources,forceDownload=FALSE,db=myDb,rc=0.5)

## ----example-2, eval=FALSE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
# # Load standard annotation based on gene body coordinates
# genes <- loadAnnotation(genome="mm10",refdb="ensembl",level="gene",type="gene",
#     db=myDb)
# genes
# 
# # Load standard annotation based on 3' UTR coordinates
# utrs <- loadAnnotation(genome="mm10",refdb="ensembl",level="gene",type="utr",
#     db=myDb)
# utrs
# 
# # Load summarized exon annotation based used with RNA-Seq analysis
# sumEx <- loadAnnotation(genome="mm10",refdb="ensembl",level="gene",type="exon",
#     summarized=TRUE,db=myDb)
# sumEx
# 
# # Load standard annotation based on gene body coordinates from RefSeq
# if (.Platform$OS.type=="unix") {
#     refGenes <- loadAnnotation(genome="mm10",refdb="refseq",level="gene",
#         type="gene",db=myDb)
#     refGenes
# }

## ----example-3, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
# Load standard annotation based on gene body coordinates
genes <- loadAnnotation(genome="mm10",refdb="ensembl",level="gene",type="gene",
    db=myDb,asdf=TRUE)
head(genes)

## ----example-4, eval=FALSE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
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
#     genePredToGtfEnv <- Sys.getenv("GENEPREDTOGTF_BINARY")
#     if (genePredToGtfEnv == "") {
#         genePredToGtf <- file.path(customDir,"genePredToGtf")
#     } else {
#         genePredToGtf <- file.path(genePredToGtfEnv)
#     }
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
#     buildCustomAnnotation(
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
#         level="gene",type="gene",db=myDb)
#     eboGenes
# }

## ----example-5, eval=FALSE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
# if (.Platform$OS.type == "unix") {
#     # Gene annotation dump
#     download.file(paste0(goldenPath,"gadMor1/database/augustusGene.txt.gz"),
#         file.path(customDir,"gadMori1_augustusGene.txt.gz"))
#     # Chromosome information
#     download.file(paste(goldenPath,"gadMor1/database/chromInfo.txt.gz",sep=""),
#         file.path(customDir,"gadMori1_chromInfo.txt.gz"))
# 
#     # Prepare the build
#     chromInfo <- read.delim(file.path(customDir,"gadMori1_chromInfo.txt.gz"),
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
#     gtfFile <- file.path(customDir,"gadMori1.gtf")
#     tmpName <- file.path(customDir,paste(format(Sys.time(),"%Y%m%d%H%M%S"),
#         "tgtf",sep="."))
#     command <- paste0(
#         "zcat ",file.path(customDir,"gadMori1_augustusGene.txt.gz"),
#         " | ","cut -f2- | ",genePredToGtf," file stdin ",tmpName,
#         " -source=gadMori1"," -utr && grep -vP '\t\\.\t\\.\t' ",tmpName," > ",
#         gtfFile
#     )
#     system(command)
# 
#     # Build with the metadata list filled (you can also provide a version)
#     buildCustomAnnotation(
#         gtfFile=gtfFile,
#         metadata=list(
#             organism="gadMor1_test",
#             source="ucsc_test",
#             chromInfo=chromInfo
#         ),
#         db=myDb
#     )
# 
#     # Try to retrieve some data
#     gadGenes <- loadAnnotation(genome="gadMor1_test",refdb="ucsc_test",
#         level="gene",type="gene",db=myDb)
#     gadGenes
# }

## ----example-6, eval=FALSE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
# # Gene annotation dump from Ensembl
# download.file(paste0("ftp://ftp.ensembl.org/pub/release-98/gtf/",
#     "dasypus_novemcinctus/Dasypus_novemcinctus.Dasnov3.0.98.gtf.gz"),
#     file.path(customDir,"Dasypus_novemcinctus.Dasnov3.0.98.gtf.gz"))
# 
# # Chromosome information will be provided from the following BAM file
# # available from Ensembl. We have noticed that when using Windows as the OS,
# # a remote BAM files cannot be opened by scanBamParam, so for this example,
# # chromosome length information will not be available when running in Windows.
# bamForInfo <- NULL
# if (.Platform$OS.type == "unix")
#     bamForInfo <- paste0("ftp://ftp.ensembl.org/pub/release-98/bamcov/",
#         "dasypus_novemcinctus/genebuild/Dasnov3.broad.Ascending_Colon_5.1.bam")
# 
# # Build with the metadata list filled (you can also provide a version)
# buildCustomAnnotation(
#     gtfFile=file.path(customDir,"Dasypus_novemcinctus.Dasnov3.0.98.gtf.gz"),
#     metadata=list(
#         organism="dasNov3_test",
#         source="ensembl_test",
#         chromInfo=bamForInfo
#     ),
#     db=myDb
# )
# 
# # Try to retrieve some data
# dasGenes <- loadAnnotation(genome="dasNov3_test",refdb="ensembl_test",
#     level="gene",type="gene",db=myDb)
# dasGenes

## ----example-7, eval=FALSE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
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
# sources <- c("ensembl","ucsc","refseq")
# 
# buildAnnotationDatabase(organisms,sources,forceDownload=FALSE,rc=0.5)

## ----pseudo-1, eval=TRUE, echo=TRUE, message=TRUE, warning=FALSE--------------
annotation <- list(
    gtf="PATH_TO_GTF",
    organism="ORGANISM_NAME",
    source="SOURCE_NAME",
    chromInfo="CHROM_INFO"
)

## ----si-1, eval=TRUE, echo=TRUE-----------------------------------------------
sessionInfo()

