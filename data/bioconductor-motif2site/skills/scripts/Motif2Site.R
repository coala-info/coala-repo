# Code example from 'Motif2Site' vignette. See references/ for full tutorial.

## ----results="hide", warning=FALSE, message=FALSE-----------------------------

library(GenomicRanges)
library(Motif2Site)
library(BSgenome.Scerevisiae.UCSC.sacCer3)
library(BSgenome.Ecoli.NCBI.20080805)


## ----warning=FALSE, message=FALSE, fig.width=10, fig.height=6-----------------

yeastExampleFile = 
  system.file("extdata", "YeastSampleMotif.bed", package="Motif2Site")
YeastRegionsChIPseq <- Bed2Granges(yeastExampleFile)
SequenceComparison <- 
  compareMotifs2UserProvidedRegions(
    givenRegion=YeastRegionsChIPseq,
    motifs = c("TGATTSCAGGANT", "TGATTCCAGGANT", "TGATWSCAGGANT"),
    mismatchNumbers = c(1,0,2),
    genome="Scerevisiae",
    genomeBuild="sacCer3"
    )
SequenceComparison


## ----warning=FALSE, message=FALSE, fig.width=8, fig.height=6------------------

# Yeast artificial dataset for comparison bed files

yeastExampleFile = 
  system.file("extdata", "YeastSampleMotif.bed", package="Motif2Site")
YeastRegionsChIPseq <- Bed2Granges(yeastExampleFile)
bed1 <- system.file("extdata", "YeastBedFile1.bed", package="Motif2Site")
bed2 <- system.file("extdata", "YeastBedFile2.bed", package="Motif2Site")
BedFilesVector <- c(bed1, bed2)
SequenceComparison <- 
  compareBedFiless2UserProvidedRegions(
    givenRegion=YeastRegionsChIPseq,
    bedfiles = BedFilesVector,
    motifnames = c("YeastBed1", "YeastBed2")
    )
SequenceComparison



## ----message=FALSE, warning=FALSE---------------------------------------------

# FUR candidate motifs in NC_000913 E. coli
FurMotifs = system.file("extdata", "FurMotifs.bed", package="Motif2Site")

# ChIP-seq FUR fe datasets binding sites from user provided bed file 
# ChIP-seq datasets in bed single end format

IPFe <- c(system.file("extdata", "FUR_fe1.bed", package="Motif2Site"),
          system.file("extdata", "FUR_fe2.bed", package="Motif2Site"))
Inputs <- c(system.file("extdata", "Input1.bed", package="Motif2Site"),
            system.file("extdata", "Input2.bed", package="Motif2Site"))
FURfeBedInputStats <- 
  DetectBindingSitesBed(BedFile=FurMotifs,
                        IPfiles=IPFe, 
                        BackgroundFiles=Inputs, 
                        genome="Ecoli",
                        genomeBuild="20080805",
                        DB="NCBI",
                        expName="FUR_Fe_BedInput",
                        format="BEDSE"
                        )
FURfeBedInputStats

# ChIP-seq FUR dpd datasets binding sites from user provided bed file 
# ChIP-seq datasets in bed single end format

IPDpd <- c(system.file("extdata", "FUR_dpd1.bed", package="Motif2Site"),
           system.file("extdata", "FUR_dpd2.bed", package="Motif2Site"))
FURdpdBedInputStats <- 
  DetectBindingSitesBed(BedFile=FurMotifs,
                        IPfiles=IPDpd, 
                        BackgroundFiles=Inputs, 
                        genome="Ecoli",
                        genomeBuild="20080805",
                        DB="NCBI",
                        expName="FUR_Dpd_BedInput",
                        format="BEDSE"
                        )
FURdpdBedInputStats


## ----message=FALSE, warning=FALSE---------------------------------------------


# Granages region for motif search           
NC_000913_Coordiante <- GRanges(seqnames=Rle("NC_000913"),
                                ranges = IRanges(1, 4639675))           

# ChIP-seq FUR fe datasets binding sites from user provided string motif
# ChIP-seq datasets in bed single end format
           
FURfeStringInputStats <- 
  DetectBindingSitesMotif(motif = "GWWTGAGAA",
                          mismatchNumber = 1,
                          IPfiles=IPFe, 
                          BackgroundFiles=Inputs, 
                          genome="Ecoli",
                          genomeBuild="20080805",
                          DB= "NCBI",
                          expName="FUR_Fe_StringInput",
                          format="BEDSE",
                          GivenRegion = NC_000913_Coordiante 
                          )
FURfeStringInputStats


## ----message=FALSE, warning=FALSE---------------------------------------------

# Combine FUR binding sites from bed input into one table 
corMAT <- recenterBindingSitesAcrossExperiments(
  expLocations=c("FUR_Fe_BedInput","FUR_Dpd_BedInput"),
  experimentNames=c("FUR_Fe","FUR_Dpd"),
  expName="combinedFUR"
  )
corMAT

FurTable <- 
  read.table(file.path("combinedFUR","CombinedMatrix"), 
             header = TRUE,
              check.names = FALSE
             )
FurBindingTotal <- 
  GRanges(seqnames=Rle(FurTable[,1]), 
          ranges = IRanges(FurTable[,2], FurTable[,3])
          )
FurFe <- FurBindingTotal[which((FurTable$FUR_Fe_binding =="Binding")==TRUE)]
FurDpd <- FurBindingTotal[which((FurTable$FUR_Dpd_binding =="Binding")==TRUE)]
findOverlaps(FurFe,FurDpd) 


## ----message=FALSE, warning=FALSE---------------------------------------------

# Differential binding sites across FUR conditions fe vs dpd
diffFUR <- pairwisDifferential(tableOfCountsDir="combinedFUR",
                              exp1="FUR_Fe",
                              exp2="FUR_Dpd",
                              FDRcutoff = 0.05,
                              logFCcuttoff = 1
                              )
FeUp <- diffFUR[[1]]
DpdUp <- diffFUR[[2]]
TotalComparison <- diffFUR[[3]]
head(TotalComparison)



## ----echo=FALSE, results='hide',message=FALSE---------------------------------

# Remove folders
unlink("FUR_Fe_BedInput", recursive = TRUE)
unlink("FUR_Dpd_BedInput", recursive = TRUE)
unlink("FUR_Fe_StringInput", recursive = TRUE)
unlink("combinedFUR", recursive = TRUE)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

