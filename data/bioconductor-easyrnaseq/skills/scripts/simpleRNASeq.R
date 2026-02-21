# Code example from 'simpleRNASeq' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----message=FALSE,warning=FALSE,results='hide',echo=FALSE--------------------
options(digits=2)

## ----library------------------------------------------------------------------
library(easyRNASeq)

## ----vignetteData, echo=FALSE-------------------------------------------------
vDir <- vignetteData()

## ----P trichocarpa annotation, eval=FALSE-------------------------------------
# download.file(url=paste0("ftp://ftp.plantgenie.org/Data/PopGenIE/",
#                          "Populus_trichocarpa/v3.0/v10.1/GFF3/",
#                          "Ptrichocarpa_210_v3.0_gene_exons.gff3.gz"),
#                   destfile=,"./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz")

## ----P trichocarpa annotation download, echo=FALSE----------------------------
file.copy(dir(vDir,pattern="*Ptrichocarpa_210_v3.0_gene_exons.gff3.gz",full.names = TRUE),
          "./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz")

## ----AnnotParam---------------------------------------------------------------
    annotParam <- AnnotParam(
        datasource="./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz")

## ----create synthetic transcripts---------------------------------------------
annotParam <- createSyntheticTranscripts(annotParam,verbose=FALSE)

## ----save the object----------------------------------------------------------
save(annotParam,
file="./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts_annotParam.rda")

## ----create synthetic transcripts as gI---------------------------------------
gI <- createSyntheticTranscripts(
    "./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz",
    verbose=FALSE)

## ----export the file----------------------------------------------------------
writeGff3(gI,
          file="./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts.gff3.gz")

## ----bam files, eval=FALSE----------------------------------------------------
# download.file(url=paste0("ftp://ftp.plantgenie.org/Tutorials/RnaSeqTutorial/",
#                          "data/star/md5.txt"),
#                   destfile="md5.txt")

## ----data, eval=FALSE---------------------------------------------------------
# data(RobinsonDelhomme2014)
# lapply(RobinsonDelhomme2014[1:6,"Filename"],function(f){
#     # BAM files
#     download.file(url=paste0("ftp://ftp.plantgenie.org/Tutorials/",
#                              "RnaSeqTutorial/data/star/",f),
#                   destfile=as.character(f))
#     # BAM index files
#     download.file(url=paste0("ftp://ftp.plantgenie.org/Tutorials/",
#                              "RnaSeqTutorial/data/star/",f,".bai"),
#                   destfile=as.character(paste0(f,".bai")))
# })

## ----data unit test, eval=TRUE, echo=FALSE------------------------------------
# THIS IS A subset of the data (chr 19 only) used to speed up
# the vignette creation while still testing capabilities
data(RobinsonDelhomme2014)
lapply(RobinsonDelhomme2014[1:6,"Filename"],function(f){
    # BAM files
    file.copy(
        dir(vDir,pattern=paste0(as.character(f),"$"),full.names=TRUE)
        ,file.path(".",f))
    # BAM index files
    file.copy(
        dir(vDir,pattern=paste0(as.character(f),".bai"),full.names=TRUE)
        ,file.path(".",paste0(f,".bai")))
})

## ----bamParam-----------------------------------------------------------------
bamParam <- BamParam(paired = TRUE,
                     stranded = FALSE)

## ----bamFiles-----------------------------------------------------------------
bamFiles <- getBamFileList(dir(".","*\\.bam$"),
                           dir(".","*\\.bai$"))

## ----rnaSeqParam--------------------------------------------------------------
rnaSeqParam <- RnaSeqParam(annotParam = annotParam,
                           bamParam = bamParam,
                           countBy = "genes",
                           precision = "read")

## ----simpleRS-----------------------------------------------------------------
sexp1 <- simpleRNASeq(bamFiles=bamFiles, 
                      param=rnaSeqParam,
                      verbose=TRUE)

## ----cleanup, echo=FALSE------------------------------------------------------
data(RobinsonDelhomme2014)
file.remove(c(
    "./Ptrichocarpa_210_v3.0_gene_exons.gff3.gz",
    "./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts_annotParam.rda",
    "./Ptrichocarpa_210_v3.0_gene_exons_synthetic-transcripts.gff3.gz",
    RobinsonDelhomme2014[1:6,"Filename"],
    paste0(RobinsonDelhomme2014[1:6,"Filename"],".bai")))

## ----session info, echo=FALSE-------------------------------------------------
sessionInfo()

