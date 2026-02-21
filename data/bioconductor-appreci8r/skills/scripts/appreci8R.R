# Code example from 'appreci8R' vignette. See references/ for full tutorial.

### R code from vignette source 'appreci8R.Rnw'

###################################################
### code chunk number 1: appreci8R.Rnw:21-22
###################################################
options(width=100)


###################################################
### code chunk number 2: 2installing (eval = FALSE)
###################################################
## BiocManager::install("appreci8R")


###################################################
### code chunk number 3: 3loading
###################################################
library(appreci8R)


###################################################
### code chunk number 4: 4
###################################################
output_folder<-""
target<-data.frame(chr = c("2","4","12","17","21","X"),
                   start = c(25469500,106196950,12046280,7579470,36164400,15838363),
                   end = c(25469510,106196960,12046350,7579475,36164410,15838366))
target
caller_folder <- system.file("extdata", package = "appreci8R")

#Input data Sample1:
read.table(paste(caller_folder, "/Sample1.rawMutations.vcf", sep=""),
           header = FALSE, sep = "\t", stringsAsFactors = FALSE)

#Input data Sample2:
read.table(paste(caller_folder,"/Sample2.rawMutations.vcf",sep=""),
           header = FALSE, sep = "\t", stringsAsFactors = FALSE)

filterTarget(output_folder, "GATK", caller_folder, ".rawMutations",
             ".vcf", TRUE, "", "", targetRegions = target)


###################################################
### code chunk number 5: 5
###################################################
output_folder <- ""
caller_name <- ""
sample1 <- data.frame(SampleID = c("Sample1","Sample1","Sample1"),
                      Chr = c("2","17","X"),
                      Pos = c(25469502,7579472,15838366),
                      Ref = c("CAG","G","C"),
                      Alt = c("TAT","C","T,A"),
                      stringsAsFactors = FALSE)
sample2 <- data.frame(SampleID = c("Sample2","Sample2","Sample2","sample2"),
                      Chr = c("4","12","12","21"),
                      Pos = c(106196951,12046289,12046341,36164405),
                      Ref = c("A","C","A","GGG"),
                      Alt = c("G","+AAAG","G","TGG"),
                      stringsAsFactors = FALSE)
#Input:
input <- list(sample1, sample2)
input

normalized <- appreci8R::normalize(output_folder, caller_name, input,
                                   TRUE, TRUE)
normalized


###################################################
### code chunk number 6: 6
###################################################
library(GenomicRanges)
output_folder <- ""
caller_name <- ""
input <- GRanges(seqnames = c("2","X","4","21"),
                 ranges = IRanges(start = c (25469504,15838366,106196951,36164405),
                                  end = c (25469504,15838366,106196951,36164405)),
                 SampleID = c("Sample1","Sample1","Sample2","Sample2"),
                 Ref = c("G","C","A","G"),
                 Alt = c("T","A","G","T"))
#Input:
input

library(GO.db)
library(org.Hs.eg.db)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(Biostrings)
annotated <- annotate(output_folder, caller_name, input,
             locations = c("coding","spliceSite"),
             consequences = c("nonsynonymous","frameshift","nonsense"))
annotated


###################################################
### code chunk number 7: 7
###################################################
output_folder <- ""
caller_name <- ""

#Input:
gatk <- annotated[c(1,3),]
varscan <- annotated[c(2,3),]
annotated<-GRangesList()
annotated[[1]]<-gatk
annotated[[2]]<-varscan
annotated

combined<-combineOutput("", c("GATK","VarScan"), annotated)
combined


###################################################
### code chunk number 8: 8
###################################################
output_folder <- ""
bam_folder <- system.file("extdata", package = "appreci8R")
bam_folder <- paste(bam_folder, "/", sep="")

#Input:
combined

filtered<-evaluateCovAndBQ(output_folder, combined, bam_folder, bq_diff = 20,
                           vaf = 0.001)
filtered


###################################################
### code chunk number 9: 9
###################################################
output_folder <- ""

#Input:
filtered

characteristics <- determineCharacteristics(output_folder, filtered,
                                            predict = "Provean")
characteristics


###################################################
### code chunk number 10: 10
###################################################
output_folder <- ""

#Input:
filtered
characteristics
combined

final<-finalFiltration(output_folder, frequency_calls = filtered,
                       database_calls = characteristics,
                       combined_calls = combined, damaging_safe = -3,
                       tolerated_safe = -1.5, overlapTools = c("VarScan"),
                       bq_diff = 20,vaf = 0.001)
final


###################################################
### code chunk number 11: 11 (eval = FALSE)
###################################################
## appreci8Rshiny()


