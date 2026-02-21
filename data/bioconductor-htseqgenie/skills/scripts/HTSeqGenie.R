# Code example from 'HTSeqGenie' vignette. See references/ for full tutorial.

### R code from vignette source 'HTSeqGenie.Rnw'

###################################################
### code chunk number 1: fastq
###################################################
library("HTSeqGenie")
library("LungCancerLines")


###################################################
### code chunk number 2: tp53Genome
###################################################
tp53Genome <- TP53Genome()
tp53GenomicFeatures <- TP53GenomicFeatures()


###################################################
### code chunk number 3: cpars
###################################################
rtp53 <- list(
              ## aligner
              path.gsnap_genomes=path(directory(tp53Genome)),
              alignReads.genome=genome(tp53Genome),
              
              ## gene model
              path.genomic_features=dirname(tp53GenomicFeatures),
              countGenomicFeatures.gfeatures=basename(tp53GenomicFeatures)
              )


###################################################
### code chunk number 4: runPipeline
###################################################
H1993dir <- do.call(runPipeline, 
                    c(## RNASeq TP53genome parameters
                      rtp53, 
                      
                      ## input
                      input_file=LungCancerFastqFiles()[["H1993.first"]],
                      input_file2=LungCancerFastqFiles()[["H1993.last"]],
                      paired_ends=TRUE,
                      quality_encoding="illumina1.8",
                      
                      ## output
                      save_dir="H1993",
                      prepend_str="H1993",
                      alignReads.sam_id="H1993",
                      overwrite_save_dir="erase"
                      ))

H2073dir <- do.call(runPipeline, 
                    c(## RNASeq TP53genome parameters
                      rtp53, 
                      
                      ## input
                      input_file=LungCancerFastqFiles()[["H2073.first"]],
                      input_file2=LungCancerFastqFiles()[["H2073.last"]],
                      paired_ends=TRUE,
                      quality_encoding="illumina1.8",
                      
                      ## output
                      save_dir="H2073",
                      prepend_str="H2073",
                      alignReads.sam_id="H2073",
                      overwrite_save_dir="erase"
                      ))


###################################################
### code chunk number 5: genecounts
###################################################
library("org.Hs.eg.db")
gc1 <- getTabDataFromFile(H1993dir, "counts_gene")
gc2 <- getTabDataFromFile(H2073dir, "counts_gene")
entrez <- as.character(gc1$name)
hgnc <- unlist(as.list(org.Hs.egSYMBOL)[entrez])
hgnc <- hgnc[entrez]
data.frame(entrez=entrez, hgnc=hgnc, H1993.count=gc1$count, H2073.count=gc2$count, row.names=NULL)


###################################################
### code chunk number 6: sessionInfo
###################################################
toLatex(sessionInfo())


