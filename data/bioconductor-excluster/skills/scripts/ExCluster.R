# Code example from 'ExCluster' vignette. See references/ for full tutorial.

### R code from vignette source 'ExCluster.Rnw'

###################################################
### code chunk number 1: ExCluster.Rnw:186-191
###################################################
library(ExCluster)
# load the sub-sampled GTF file path from the ExCluster package
GTF_file <- system.file("extdata","sub_gen.v23.gtf", package = "ExCluster")
# now run GTF\_file without assigning a GFF\_file to write out, assigning the results to the GFF object
GFF <- GFF_convert(GTF.File=GTF_file)


###################################################
### code chunk number 2: ExCluster.Rnw:198-206
###################################################
# specify the path to the ExCluster package
ExClust_Path <- system.file(package="ExCluster")
# now find the bam files within that folder
bamFiles <- list.files(ExClust_Path,recursive=TRUE,pattern="*.bam",full.names=TRUE)
# assign sample names (only 2 replicates per condition in this example)
sampleNames <- c("iPSC_cond1_rep1","iPSC_cond1_rep2","iPSC_cond2_rep1","iPSC_cond2_rep2")
# now run processCounts, with paired.Reads=TRUE because we are counting paired-end data
normCounts <- processCounts(bam.Files=bamFiles, sample.Names=sampleNames, annot.GFF=GFF, paired.Reads=TRUE)


###################################################
### code chunk number 3: ExCluster.Rnw:213-219
###################################################
# assign condition numbers to your samples (we have 4 samples, 2 replicates per condition)
condNums <- c(1,1,2,2)
# now we run ExCluster, assigning its output to the ExClustResults variable
# we are not writing out the ExClustResults table, nor are we plotting exons
# we also use combine.Exons=FALSE to discover one 'significant' gene for example plot purposes
ExClust_Results <- ExCluster(exon.Counts=normCounts,cond.Nums=condNums,annot.GFF=GFF, combine.Exons=FALSE)


###################################################
### code chunk number 4: ExCluster.Rnw:226-231
###################################################
# now we must specify a directory to write images to
# here we use tempdir, but you may substitute another folder path if you wish
outDir <- paste(tempdir(),"/Images/",sep="")
# now we can run our exon log2FC plotting function
plotExonlog2FC(results.Data=ExClust_Results, out.Dir=outDir, plot.Type="PNG")


###################################################
### code chunk number 5: ExCluster.Rnw:243-244
###################################################
GRanges.ExClustResults <- GRangesFromExClustResults(results.ExClust=ExClust_Results)


