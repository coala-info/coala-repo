# Code example from 'MMAPPR2' vignette. See references/ for full tutorial.

## ---- echo = FALSE---------------------------------------------------------
dataDir <- system.file('extdata', package = 'MMAPPR2data')
WTpileupFile <- file.path(dataDir, 'exwt.plp')
MTpileupFile <- file.path(dataDir, 'exmut.plp')
samtoolsScript <- file('/tmp/samtools', "a")
writeLines(c(
  'if [[ ${@:$#} == *"wt.bam"* ]];',
  'then',
  paste('cat', WTpileupFile),
  'else',
  paste('cat', MTpileupFile),
  'fi'
  ), samtoolsScript)
close(samtoolsScript)

origPath <- Sys.getenv('PATH')
Sys.setenv(PATH = paste(origPath, '/tmp', sep = ':')) 

## ----installVEP, eval=FALSE------------------------------------------------
#  git clone https://github.com/Ensembl/ensembl-vep.git
#  cd ensembl-vep
#  perl INSTALL.pl -a ac -s {my_species}

## ---- eval = FALSE---------------------------------------------------------
#  Sys.setenv(PATH=paste("/Path/to/Perlbrew", Sys.getenv("PATH"), sep=":"))

## ----param-----------------------------------------------------------------
BiocParallel::register(BiocParallel::MulticoreParam())  ## see below for explanation of BiocParallel
library(MMAPPR2, quietly = TRUE)
library(MMAPPR2data, quietly = TRUE)
library(Rsamtools, quietly = TRUE)

# This is normally configured automatically:
vepFlags <- ensemblVEP::VEPFlags(flags = list(
    format = 'vcf',  # <-- this is necessary
    vcf = FALSE,  # <-- as well as this
    species = 'danio_rerio',
    database = FALSE,  # <-- these three arguments allow us to run VEP offline,
    fasta = goldenFasta(),  # <-╯|  which you probably won't need
    gff = goldenGFF(),  # <------╯
    filter_common = TRUE,
    coding_only = TRUE  # assuming RNA-seq data
))

param <- MmapprParam(refFasta = goldenFasta(),
                     wtFiles = exampleWTbam(),
                     mutFiles = exampleMutBam(),
                     species = 'danio_rerio',
                     vepFlags = vepFlags,  ## optional
                     outputFolder = tempOutputFolder())  ## optional

## ----mmappr----------------------------------------------------------------
mmapprData <- mmappr(param)

## ----mmappr-steps----------------------------------------------------------
md <- new('MmapprData', param = param) ## calculateDistance() takes a MmapprData object
postCalcDistMD <- calculateDistance(md)
postLoessMD <- loessFit(postCalcDistMD)
postPrePeakMD <- prePeak(postLoessMD)
postPeakRefMD <- peakRefinement(postPrePeakMD)
postCandidatesMD <- generateCandidates(postPeakRefMD)
outputMmapprData(postCandidatesMD)

## ----recover-md------------------------------------------------------------
## Contents of output folder:
cat(paste(system2('ls', outputFolder(param(mmapprData)), stdout = TRUE)), sep = '\n')

mdFile <- file.path(outputFolder(param(mmapprData)), 'mmappr_data.RDS')
md <- readRDS(mdFile)
md

## ----results---------------------------------------------------------------
head(candidates(mmapprData)$`18`, n=2)

outputTsv <- file.path(outputFolder(param(mmapprData)), '18.tsv')
cat(paste(system2('head', outputTsv, stdout = TRUE)), sep = '\n')

## ----vepFlags--------------------------------------------------------------
library(ensemblVEP, quietly = TRUE)
vepFlags <- VEPFlags(flags = list(
    ### DEFAULT SETTINGS
    format = 'vcf',  # <-- this is necessary
    vcf = FALSE,  # <-- as well as this
    species = 'danio_rerio',
    database = FALSE,
    cache = TRUE,
    filter_common = TRUE,
    coding_only = TRUE  # assuming RNA-seq data
    ### YOU MAY FIND THESE INTERESTING:
    # everything = TRUE  # enables many optional analyses, such as Polyphen and SIFT
    # per_gene = TRUE  # will output only the most severe variant per gene
    # pick = TRUE  # will output only one consequence per variant
))

## ----bpparam---------------------------------------------------------------
library(BiocParallel, quietly = TRUE)
register(SerialParam())
register(MulticoreParam(progressbar=TRUE))
registered()

## ----refGenome, eval=FALSE-------------------------------------------------
#  refGenome <- gmapR::GmapGenome(goldenFasta(), name='slc24a5', create=TRUE)

## ----sessionInfo-----------------------------------------------------------
sessionInfo()

## ---- echo = FALSE---------------------------------------------------------
Sys.setenv(PATH=origPath)

