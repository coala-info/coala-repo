# Code example from 'gmapR' vignette. See references/ for full tutorial.

### R code from vignette source 'gmapR.Rnw'

###################################################
### code chunk number 1: create_GmapGenome (eval = FALSE)
###################################################
## library(gmapR)
## 
## if (!suppressWarnings(require(BSgenome.Dmelanogaster.UCSC.dm3))) {
##   if (!requireNamespace("BiocManager", quietly=TRUE))
##       install.packages("BiocManager")
##   BiocManager::install("BSgenome.Dmelanogaster.UCSC.dm3")
##   library(BSgenome.Dmelanogaster.UCSC.dm3)
## }
## 
## gmapGenomePath <- file.path(getwd(), "flyGenome")
## gmapGenomeDirectory <- GmapGenomeDirectory(gmapGenomePath, create = TRUE)
## ##> gmapGenomeDirectory
## ##GmapGenomeDirectory object
## ##path: /reshpcfs/home/coryba/projects/gmapR2/testGenome 
## 
## gmapGenome <- GmapGenome(genome=Dmelanogaster,
##                          directory=gmapGenomeDirectory,
##                          name="dm3",
##                          create=TRUE,
##                          k = 12L)
## ##> gmapGenome
## ##GmapGenome object
## ##genome: dm3 
## ##directory: /reshpcfs/home/coryba/projects/gmapR2/testGenome 


###################################################
### code chunk number 2: get_TP53_coordinates
###################################################
library("org.Hs.eg.db")
library("TxDb.Hsapiens.UCSC.hg19.knownGene")
eg <- org.Hs.eg.db::org.Hs.egSYMBOL2EG[["TP53"]]
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
tx <- transcripts(txdb, filter = list(gene_id = eg))
roi <- range(tx) + 1e6
strand(roi) <- "*"


###################################################
### code chunk number 3: get_TP53_seq
###################################################
library("BSgenome.Hsapiens.UCSC.hg19")
library("gmapR")
p53Seq <- getSeq(BSgenome.Hsapiens.UCSC.hg19::Hsapiens, roi,
                 as.character = FALSE) 
names(p53Seq) <- "TP53"
gmapGenome <- GmapGenome(genome = p53Seq, 
                         name = paste0("TP53_demo_", 
                           packageVersion("TxDb.Hsapiens.UCSC.hg19.knownGene")), 
                         create = TRUE, 
                         k = 12L)


###################################################
### code chunk number 4: set_TP53_splicesites
###################################################
exons <- gmapR:::subsetRegion(exonsBy(txdb), roi, "TP53")
spliceSites(gmapGenome, "knownGene") <- exons


###################################################
### code chunk number 5: get_lung_cancer_fastqs
###################################################
library("LungCancerLines")
fastqs <- LungCancerFastqFiles()


###################################################
### code chunk number 6: create_gsnapParam
###################################################
##specify how GSNAP should behave using a GsnapParam object
gsnapParam <- GsnapParam(genome=gmapGenome,
                         unique_only=FALSE,
                         suboptimal_levels=2L, 
                         npaths=10L,
                         novelsplicing=TRUE,
                         splicing="knownGene",
                         indel_penalty=1L,
                         distant_splice_penalty=1L,
                         clip_overlap=TRUE)


###################################################
### code chunk number 7: align_with_gsnap (eval = FALSE)
###################################################
## gsnapOutput <- gsnap(input_a=fastqs["H1993.first"],
##                      input_b=fastqs["H1993.last"],
##                      params=gsnapParam)
## 
## ##gsnapOutput
## ##An object of class "GsnapOutput"
## ##Slot "path":
## ##[1] "/local/Rtmporwsvr"
## ##
## ##Slot "param":
## ##A GsnapParams object
## ##genome: dm3 (/reshpcfs/home/coryba/projects/gmapR2/testGenome)
## ##part: NULL
## ##batch: 2
## ##max_mismatches: NULL
## ##suboptimal_levels: 0
## ##snps: NULL
## ##mode: standard
## ##nthreads: 1
## ##novelsplicing: FALSE
## ##splicing: NULL
## ##npaths: 10
## ##quiet_if_excessive: FALSE
## ##nofails: FALSE
## ##split_output: TRUE
## ##extra: list()
## ##
## ##Slot "version":
## ## [1] NA NA NA NA NA NA NA NA NA NA NA NA
## ##


###################################################
### code chunk number 8: get_gsnap_bam_files (eval = FALSE)
###################################################
## ##> dir(path(gsnapOutput), full.names=TRUE, pattern="\\.bam$")
## ##[1] "/local/Rtmporwsvr/file1cbc73503e9.1.nomapping.bam"        
## ##[2] "/local/Rtmporwsvr/file1cbc73503e9.1.unpaired_mult.bam"    
## ##[3] "/local/Rtmporwsvr/file1cbc73503e9.1.unpaired_transloc.bam"
## ##[4] "/local/Rtmporwsvr/file1cbc73503e9.1.unpaired_uniq.bam"    


###################################################
### code chunk number 9: TP53Genome_accessor
###################################################
genome <- TP53Genome()


###################################################
### code chunk number 10: run_bamtally (eval = FALSE)
###################################################
## bam_file <- system.file("extdata/H1993.analyzed.bam", 
##                         package="LungCancerLines", mustWork=TRUE)
## breaks <- c(0L, 15L, 60L, 75L)
## bqual <- 56L
## mapq <- 13L
## param <- BamTallyParam(genome,
##                        minimum_mapq = mapq,
##                        concordant_only = FALSE, unique_only = FALSE,
##                        primary_only = FALSE,
##                        min_depth = 0L, variant_strand = 1L,
##                        ignore_query_Ns = TRUE,
##                        indels = FALSE, include_soft_clips = 1L, xs=TRUE,
##                        min_base_quality = 23L)
## tallies <-bam_tally(bam_file,
##                     param)
## variantSummary(tallies)


###################################################
### code chunk number 11: create_GmapGenomePackge (eval = FALSE)
###################################################
## makeGmapGenomePackage(gmapGenome=gmapGenome,
##                       version="1.0.0",
##                       maintainer="<your.name@somewhere.com>",
##                       author="Your Name",
##                       destDir="myDestDir",
##                       license="Artistic-2.0",
##                       pkgName="GmapGenome.Dmelanogaster.UCSC.dm3")


###################################################
### code chunk number 12: create_hg19_GmapGenome (eval = FALSE)
###################################################
## if (!suppressWarnings(require(BSgenome.Hsapiens.UCSC.hg19))) {
##   if (!requireNamespace("BiocManager", quietly=TRUE))
##       install.packages("BiocManager")
##   BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")
##   library(BSgenome.Hsapiens.UCSC.hg19)
## }
## gmapGenome <- GmapGenome(genome=Hsapiens,
##                          directory = "Hsapiens",
##                          name = "hg19",
##                          create = TRUE)
## destDir <- "HsapiensGmapGenome"
## pkgName <- "GmapGenome.Hsapiens.UCSC.hg19"
## makeGmapGenomePackage(gmapGenome=gmapGenome,
##                       version="1.0.0",
##                       maintainer="<your.name@somewhere.com>",
##                       author="Your Name",
##                       destDir=destDir,
##                       license="Artistic-2.0",
##                       pkgName="GmapGenome.Hsapiens.UCSC.hg19")


###################################################
### code chunk number 13: SessionInfo
###################################################
sessionInfo()


