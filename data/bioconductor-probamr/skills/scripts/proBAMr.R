# Code example from 'proBAMr' vignette. See references/ for full tutorial.

### R code from vignette source 'proBAMr.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=70)


###################################################
### code chunk number 2: loadpkg
###################################################
library(proBAMr)


###################################################
### code chunk number 3: PrepareAnno
###################################################
gtfFile <- system.file("extdata", "test.gtf", package="proBAMr")
CDSfasta <- system.file("extdata", "coding_seq.fasta", package="proBAMr") 
pepfasta <- system.file("extdata", "pro_seq.fasta", package="proBAMr") 
annotation_path <- tempdir()
PrepareAnnotationGENCODE(gtfFile, CDSfasta, pepfasta, 
                annotation_path, dbsnp=NULL, 
                splice_matrix=FALSE, COSMIC=FALSE)  


###################################################
### code chunk number 4: PSMstab
###################################################
passedPSM <- read.table(system.file("extdata", "passedPSM.tab", 
    package="proBAMr"), sep='\t', header=TRUE)
passedPSM[1:3, ]


###################################################
### code chunk number 5: PSMs2SAM
###################################################
load(system.file("extdata/GENCODE", "exon_anno.RData", package="proBAMr"))
load(system.file("extdata/GENCODE", "proseq.RData", package="proBAMr"))
load(system.file("extdata/GENCODE", "procodingseq.RData", package="proBAMr"))
options(stringsAsFactors=FALSE)
passedPSM <- read.table(system.file("extdata", "passedPSM.tab", 
    package="proBAMr"), sep='\t', header=TRUE)
SAM <- PSMtab2SAM(passedPSM, XScolumn='mvh', exon, proteinseq, 
    procodingseq)
write.table(SAM, file=paste(tempdir(), '/test.sam', sep=''), 
        sep='\t', quote=FALSE, row.names=FALSE, col.names=FALSE)
dim(SAM)
SAM[20:27, ]


###################################################
### code chunk number 6: SAM2BAM
###################################################
paste('cat header test.sam > test_header.sam')
paste('samtools view -S -b test_header.sam > test_header.bam')
paste('samtools sort test_header.bam > test_header_sort')
paste('samtools index test_header_sort')


###################################################
### code chunk number 7: SessionInfo
###################################################
sessionInfo()


