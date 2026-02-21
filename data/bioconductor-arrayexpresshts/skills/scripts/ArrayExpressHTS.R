# Code example from 'ArrayExpressHTS' vignette. See references/ for full tutorial.

### R code from vignette source 'ArrayExpressHTS.Rnw'

###################################################
### code chunk number 1: prepareReference (eval = FALSE)
###################################################
## 
## # create directory
## #
## # Please note, tempdir() is used for automatic test 
## # execution. Select directory more appropriate and 
## # suitable for keeping reference data.
## #
## referencefolder = paste(tempdir(), "/reference", sep = "")
## 
## dir.create(referencefolder)
## 
## # download and prepare reference
## prepareReference("Homo_sapiens", version = "GRCh37.61", 
##         type = "genome", aligner = "bowtie", location = referencefolder )
## prepareReference("Homo_sapiens", version = "GRCh37.61", 
##         type = "transcriptome", aligner = "bowtie", location = referencefolder )
## prepareReference("Mus_musculus", version = "current", 
##         type = "genome", location = referencefolder )
## prepareReference("Mus_musculus", version = "current", 
##         type = "transcriptome", location = referencefolder )
## 


###################################################
### code chunk number 2: prepareAnnotation (eval = FALSE)
###################################################
## 
## # download and prepare annotation
## prepareAnnotation("Homo_sapiens", "current", location = referencefolder )
## prepareAnnotation("Mus_musculus", "NCBIM37.61", location = referencefolder )


###################################################
### code chunk number 3: ArrayExpressHTSRCloud (eval = FALSE)
###################################################
## library("ArrayExpressHTS")
## aehts <- ArrayExpressHTS("E-GEOD-16190")


###################################################
### code chunk number 4: ArrayExpressHTSFolders (eval = FALSE)
###################################################
## dir.create("testExperiment")
## dir.create("testExperiment/data")


###################################################
### code chunk number 5: constructSDRF (eval = FALSE)
###################################################
## 
## # "Sample"           "Organism"     "Base.Length"
## #  sampleHomo001     Homo sapiens     260
## #  sampleHomo002     Homo sapiens     260
## #  sampleHomo003     Homo sapiens     260
## #  sampleMus001      Mus musculus     0
## #  sampleMus002      Mus musculus     0
## 
## 
## dir.create("testExperiment")
## dir.create("testExperiment/data")
## 
## mysdrf = data.frame(
##         "Sample" = c(
##                 "sampleHomo001", 
##                 "sampleHomo002", 
##                 "sampleHomo003", 
##                 "sampleMus001", 
##                 "sampleMus002"), 
##         "Organism" = c(
##                 "Homo sapiens", 
##                 "Homo sapiens", 
##                 "Homo sapiens", 
##                 "Mus musculus", 
##                 "Mus musculus"), 
##         "Base.Length" = c(
##                 180, 180, 180, 
##                 260, 260))
## 
## write.table(mysdrf, 
##         file = "testExperiment/data/experiment.sdrf.txt", 
##         sep="\t", quote = FALSE, 
##         row.names = FALSE);


###################################################
### code chunk number 6: ArrayExpressHTSFastQRCloud (eval = FALSE)
###################################################
## 
## # In ArrayExpressHTS/expdata there is testExperiment, which is
## # a very short version of E-GEOD-16190 experiment, placed there 
## # for testing.
## #
## # Experiment in ArrayExpress:
## # http://www.ebi.ac.uk/arrayexpress/experiments/E-GEOD-16190
## #
## # The following piece of code will take ~1.5 hours to compute
## # on local PC and ~10 minutes on R Cloud
## #
## # Create a temporary folder where experiment will be copied.
## # If experiment is computed in the package folder it may cause 
## # issues with file permissions and unwanted failures.
## # 
## #
## srcfolder <- system.file("expdata", "testExperiment", 
##         package="ArrayExpressHTS");
## 
## dstfolder <- tempdir();
## 
## file.copy(srcfolder, dstfolder, recursive = TRUE);
## 
## # run the pipeline
## #
## aehts = ArrayExpressHTSFastQ(accession = "testExperiment", 
##         organism = "Homo_sapiens", dir = dstfolder);
## 
## # load the expression set object
## loadednames = load(paste(dstfolder, 
##                 "/testExperiment/eset_notstd_rpkm.RData", sep=""));
## loadednames;
## 
## get('library')(Biobase);
## 
## # print out the expression values
## #
## head(assayData(eset)$exprs);
## 
## # print out the experiment meta data 
## experimentData(eset);
## pData(eset);
## 
## # figure out if there's valuable data
## all(exprs(eset) == 0)
## 
## # locate it
## head(which(exprs(eset) != 0))
## 
## # print it
## exprs(eset)[ head(which(exprs(eset) != 0)) ]
## 


###################################################
### code chunk number 7: ArrayExpressHTSWithRCloudOptions (eval = FALSE)
###################################################
## library("ArrayExpressHTS")
## aehts <- ArrayExpressHTS("E-GEOD-16190", 
##         rcloudoptions = list(
##                 "nnodes"   = "automatic", 
##                 "pool"     = "16G", 
##                 "nretries" = 10))


###################################################
### code chunk number 8: configTools (eval = FALSE)
###################################################
## 
## # setup tools
## setPipelineOptions("ArrayExpressHTS.bowtie" 
##         = "/path/to/tools/bowtie-0.12.7")
## setPipelineOptions("ArrayExpressHTS.cufflinks" 
##         = "/path/to/tools/cufflinks-1.1.0.Linux_x86_64")
## setPipelineOptions("ArrayExpressHTS.tophat" 
##         = "/path/to/tools/tophat-1.3.2.Linux_x86_64")
## setPipelineOptions("ArrayExpressHTS.samtools" 
##         = "/path/to/tools/samtools-0.1.18")
## 


###################################################
### code chunk number 9: ArrayExpressHTSLocal (eval = FALSE)
###################################################
## library("ArrayExpressHTS")
## aehts <- ArrayExpressHTS("E-GEOD-16190", usercloud = FALSE)


###################################################
### code chunk number 10: ArrayExpressHTSFastQLocal (eval = FALSE)
###################################################
## 
## aehts = ArrayExpressHTSFastQ(accession = "testExperiment", 
##         organism = "Homo_sapiens", dir = dstfolder, usercloud = FALSE);


###################################################
### code chunk number 11: ArrayExpressHTSWithOptions (eval = FALSE)
###################################################
## library("ArrayExpressHTS")
## aehts <- ArrayExpressHTS("E-GEOD-16190", 
##         options = list(
##                 "insize" = 200, 
##                 "count_method" = "mmseq", 
##                 "aligner" = "bwa", 
##                 "aligner_options" = "-t 16 -M 10"))


