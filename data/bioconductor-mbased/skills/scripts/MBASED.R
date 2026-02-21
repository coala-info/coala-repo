# Code example from 'MBASED' vignette. See references/ for full tutorial.

### R code from vignette source 'MBASED.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: example1s_sim_phased
###################################################
set.seed(988482)
library(MBASED)
##a quick look at the main function
args(runMBASED)
## create GRanges object for SNVs of interest.
## note: the only required column is 'aseID'
mySNVs <- GRanges(
  seqnames=c('chr1', 'chr2', 'chr2', 'chr2'),
  ranges=IRanges(start=c(100, 1000, 1100, 1200), width=1),
  aseID=c('gene1', rep('gene2', 3)),
  allele1=c('G', 'A', 'C', 'A'),
  allele2=c('T', 'C', 'T', 'G')	
)
names(mySNVs) <- c('gene1_SNV1', 'gene2_SNV1', 'gene2_SNV2', 'gene2_SNV3')
## create input RangedSummarizedExperiment object
mySample <- SummarizedExperiment(
  assays=list(
    lociAllele1Counts=matrix(
      c(25, 10, 22, 14),
      ncol=1,
      dimnames=list(
       names(mySNVs), 
       'mySample'
      )
    ),
    lociAllele2Counts=matrix(
      c(20,16,15,16),
      ncol=1, 
      dimnames=list(
       names(mySNVs), 
       'mySample'
      )
    )
  ),
  rowRanges=mySNVs
)

##example of use
ASEresults_1s_haplotypesKnown <- runMBASED(
  ASESummarizedExperiment=mySample,
  isPhased=TRUE,
  numSim=10^6,
  BPPARAM = SerialParam()
)

## explore the return object
class(ASEresults_1s_haplotypesKnown)
names(assays(ASEresults_1s_haplotypesKnown))
assays(ASEresults_1s_haplotypesKnown)$majorAlleleFrequency
assays(ASEresults_1s_haplotypesKnown)$pValueASE
assays(ASEresults_1s_haplotypesKnown)$pValueHeterogeneity
rowRanges(ASEresults_1s_haplotypesKnown)
names(metadata(ASEresults_1s_haplotypesKnown))
class(metadata(ASEresults_1s_haplotypesKnown)$locusSpecificResults)
names(assays(metadata(ASEresults_1s_haplotypesKnown)$locusSpecificResults))
assays(metadata(ASEresults_1s_haplotypesKnown)$locusSpecificResults)$allele1IsMajor
assays(metadata(ASEresults_1s_haplotypesKnown)$locusSpecificResults)$MAF
rowRanges(metadata(ASEresults_1s_haplotypesKnown)$locusSpecificResults)

## define function to print out the summary of ASE results
summarizeASEResults_1s <- function(MBASEDOutput) {
  geneOutputDF <- data.frame(
   majorAlleleFrequency=assays(MBASEDOutput)$majorAlleleFrequency[,1],
   pValueASE=assays(MBASEDOutput)$pValueASE[,1],  
   pValueHeterogeneity=assays(MBASEDOutput)$pValueHeterogeneity[,1]
  )   
  lociOutputGR <- rowRanges(metadata(MBASEDOutput)$locusSpecificResults)
  lociOutputGR$allele1IsMajor <- assays(metadata(MBASEDOutput)$locusSpecificResults)$allele1IsMajor[,1]
  lociOutputGR$MAF <- assays(metadata(MBASEDOutput)$locusSpecificResults)$MAF[,1]
  lociOutputList <- split(lociOutputGR, factor(lociOutputGR$aseID, levels=unique(lociOutputGR$aseID))) 
  return(
   list(
     geneOutput=geneOutputDF,
     locusOutput=lociOutputList
   )
  )
}
summarizeASEResults_1s(ASEresults_1s_haplotypesKnown)


###################################################
### code chunk number 3: example1s_sim_unphased
###################################################
summarizeASEResults_1s(
  runMBASED(
    ASESummarizedExperiment=mySample,
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM = SerialParam()
  )
)


###################################################
### code chunk number 4: example1s_noSim
###################################################

##re-run analysis without simulations
summarizeASEResults_1s(
  runMBASED(
    ASESummarizedExperiment=mySample,
    isPhased=FALSE,
    numSim=0,
    BPPARAM = SerialParam()
  )
)$geneOutput



###################################################
### code chunk number 5: example1s_parallel (eval = FALSE)
###################################################
## ##re-run analysis while parallelizing computations
## ## results are same as before 
## ## with some random flactuations due to simulations
## summarizeASEResults_1s(
##   runMBASED(
##     ASESummarizedExperiment=mySample,
##     isPhased=FALSE,
##     numSim=10^6,
##     BPPARAM = MulticoreParam()
##   )
## )$geneOutput
## 
## ## Number of seconds it takes to run results without parallelizing:
## system.time(runMBASED(
##   ASESummarizedExperiment=mySample,
##   isPhased=FALSE,
##   numSim=10^6,
##   BPPARAM = SerialParam()
## ))['elapsed'] ## ~ 15 sec on our machine
## ## Number of seconds it takes to run results with parallelizing:
## system.time(runMBASED(
##  ASESummarizedExperiment=mySample,
##   isPhased=FALSE,
##   numSim=10^6,                        
##   BPPARAM = MulticoreParam()
## ))['elapsed'] ## ~9 sec on our machine
## 


###################################################
### code chunk number 6: binomTestIllustration
###################################################
binom.test(25, 45, 0.5, 'two.sided')$p.value


###################################################
### code chunk number 7: isoform_specific
###################################################
isoSpecificExampleSNVs <- mySNVs[2:4,]	
## create input RangedSummarizedExperiment object
isoSpecificExample <- SummarizedExperiment(
  assays=list(
    lociAllele1Counts=matrix(
      c(23, 65, 30),
      ncol=1,
      dimnames=list(
       names(isoSpecificExampleSNVs), 
       'mySample'
      )
    ),
    lociAllele2Counts=matrix(
      c(26,25,70),
      ncol=1, 
      dimnames=list(
       names(isoSpecificExampleSNVs), 
       'mySample'
      )
    )
  ),
  rowRanges=isoSpecificExampleSNVs
)

summarizeASEResults_1s(
  runMBASED(
    ASESummarizedExperiment=isoSpecificExample,
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM = MulticoreParam()
  )
)



###################################################
### code chunk number 8: example2s
###################################################
mySNVs_2s <- GRanges(
  seqnames=c('chr1', 'chr2', 'chr2', 'chr2', 'chr3'),
  ranges=IRanges(start=c(100, 1000, 1100, 1200, 2000), width=1),
  aseID=c('gene1', rep('gene2', 3), 'gene3'),
  allele1=c('G', 'A', 'C', 'A', 'T'),
  allele2=c('T', 'C', 'T', 'G', 'G')	
)
names(mySNVs_2s) <- c('gene1_SNV1', 'gene2_SNV1', 'gene2_SNV2', 'gene2_SNV3', 'gene3_SNV1')
## create input RangedSummarizedExperiment object
myTumorNormalExample <- SummarizedExperiment(
  assays=list(
    lociAllele1Counts=matrix(
      c(
        c(25,10,35,14,35),
        c(18,17,21,25,40)
      ),
      ncol=2,
      dimnames=list(
       names(mySNVs_2s), 
       c('tumor', 'normal')
      )
    ),
    lociAllele2Counts=matrix(
      c(
        c(20,29,15,40,9),
        c(23,19,24,31,10)
      ),
      ncol=2, 
      dimnames=list(
       names(mySNVs_2s), 
       c('tumor', 'normal')
      )
    )
  ),
  rowRanges=mySNVs_2s
)

##example of use
ASEresults_2s <- runMBASED(
  ASESummarizedExperiment=myTumorNormalExample,
  isPhased=FALSE,
  numSim=10^6,
  BPPARAM = SerialParam()
)

## explore the return object
class(ASEresults_2s)
names(assays(ASEresults_2s))
assays(ASEresults_2s)$majorAlleleFrequencyDifference
assays(ASEresults_2s)$pValueASE
assays(ASEresults_2s)$pValueHeterogeneity
rowRanges(ASEresults_2s)
names(metadata(ASEresults_2s))
class(metadata(ASEresults_2s)$locusSpecificResults)
names(assays(metadata(ASEresults_2s)$locusSpecificResults))
assays(metadata(ASEresults_2s)$locusSpecificResults)$allele1IsMajor
assays(metadata(ASEresults_2s)$locusSpecificResults)$MAFDifference
rowRanges(metadata(ASEresults_2s)$locusSpecificResults)

## define function to print out the summary of ASE results
summarizeASEResults_2s <- function(MBASEDOutput) {
  geneOutputDF <- data.frame(
   majorAlleleFrequencyDifference=assays(MBASEDOutput)$majorAlleleFrequencyDifference[,1],
   pValueASE=assays(MBASEDOutput)$pValueASE[,1],  
   pValueHeterogeneity=assays(MBASEDOutput)$pValueHeterogeneity[,1]
  )   
  lociOutputGR <- rowRanges(metadata(MBASEDOutput)$locusSpecificResults)
  lociOutputGR$allele1IsMajor <- assays(metadata(MBASEDOutput)$locusSpecificResults)$allele1IsMajor[,1]
  lociOutputGR$MAFDifference <- assays(metadata(MBASEDOutput)$locusSpecificResults)$MAFDifference[,1]
  lociOutputList <- split(lociOutputGR, factor(lociOutputGR$aseID, levels=unique(lociOutputGR$aseID))) 
  return(
   list(
     geneOutput=geneOutputDF,
     locusOutput=lociOutputList
   )
  )
}
summarizeASEResults_2s(ASEresults_2s)



###################################################
### code chunk number 9: two_sample_asymmetric
###################################################
## single-SNV gene with strong ASE in tumor (25 vs. 5 reads) 
## and no ASE in normal (22 vs. 23 reads):
mySNV <- GRanges(
  seqnames=c('chr1'),
  ranges=IRanges(start=c(100), width=1),
  aseID=c('gene1'),
  allele1=c('G'),
  allele2=c('T')	
)
names(mySNV) <- c('gene1_SNV1')
summarizeASEResults_2s(
  runMBASED(
    ASESummarizedExperiment=SummarizedExperiment(
      assays=list(
        lociAllele1Counts=matrix(
          c(
            c(25),
            c(22)
          ),
          ncol=2,
          dimnames=list(
           names(mySNV), 
           c('tumor', 'normal')
          )
        ),
        lociAllele2Counts=matrix(
          c(
            c(5),
            c(23)
          ),
          ncol=2, 
          dimnames=list(
           names(mySNV), 
           c('tumor', 'normal')
          )
        )
      ),
      rowRanges=mySNV
    ),
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM=SerialParam()
  )
)
## MBASED detects highly significant ASE.
##
## Now, suppose that the normal sample had the two allele counts 
## exchanged (due to chance variation), :
summarizeASEResults_2s(
  runMBASED(
    ASESummarizedExperiment=SummarizedExperiment(
      assays=list(
        lociAllele1Counts=matrix(
          c(
            c(25),
            c(23) ## used to be 22
          ),
          ncol=2,
          dimnames=list(
           names(mySNV), 
           c('tumor', 'normal')
          )
        ),
        lociAllele2Counts=matrix(
          c(
            c(5),
            c(22) ## used to be 23
          ),
          ncol=2, 
          dimnames=list(
           names(mySNV), 
           c('tumor', 'normal')
          )
        )
      ),
      rowRanges=mySNV
    ),
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM=SerialParam()
  )
)
## We get virtually the same results
##
## Now, suppose we treated normal as sample1 and tumor as sample2
## Let's use original normal sample allele counts
summarizeASEResults_2s(
  runMBASED(
    ASESummarizedExperiment=SummarizedExperiment(
      assays=list(
        lociAllele1Counts=matrix(
          c(
            c(22),
            c(25) 
          ),
          ncol=2,
          dimnames=list(
           names(mySNV), 
           c('normal', 'tumor')
          )
        ),
        lociAllele2Counts=matrix(
          c(
            c(23),
            c(5) 
          ),
          ncol=2, 
          dimnames=list(
           names(mySNV), 
           c('normal', 'tumor')
          )
        )
      ),
      rowRanges=mySNV
    ),
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM=SerialParam()
  )
)
## We appear to have recovered the same result: highly significant MAF difference
## (but note that allele2 is now 'major', since allele classification into 
## major/minor is based entirely on sample1)
## BUT: consider what happens if by chance the allelic
## ratio in the normal was 23/22 instead of 22/23:
summarizeASEResults_2s(
  runMBASED(
    ASESummarizedExperiment=SummarizedExperiment(
      assays=list(
        lociAllele1Counts=matrix(
          c(
            c(23), ## used to be 22
            c(25) 
          ),
          ncol=2,
          dimnames=list(
           names(mySNV), 
           c('normal', 'tumor')
          )
        ),
        lociAllele2Counts=matrix(
          c(
            c(22), ## used to be 23
            c(5) 
          ),
          ncol=2, 
          dimnames=list(
           names(mySNV), 
           c('normal', 'tumor')
          )
        )
      ),
      rowRanges=mySNV
    ),
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM=SerialParam()
  )
)
## MAF difference is large in size but negative and the finding is no longer 
## significant (MBASED uses a 1-tailed significance test).
##
## We therefore strongly emphasize that the proper way to detect normal-specific ASE
## would be to treat normal sample as sample1 and tumor sample as sample2.


###################################################
### code chunk number 10: example1s_refBias_no_adjustment
###################################################
mySNVs
## run MBASED with default values:
summarizeASEResults_1s(
  runMBASED(
    SummarizedExperiment(
      assays=list(
        lociAllele1Counts=matrix(
          c(20,17,15,20),
          ncol=1,
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        ),
        lociAllele2Counts=matrix(
          c(25,9,22,10),
          ncol=1, 
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        )
      ),
      rowRanges=mySNVs
    ),
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM=SerialParam()
  )
)
## we get the same results by explicitly specifying 50/50 pre-existing allelic probability
summarizeASEResults_1s(
  runMBASED(
    SummarizedExperiment(
      assays=list(
        lociAllele1Counts=matrix(
          c(20,17,15,20),
          ncol=1,
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        ),
        lociAllele2Counts=matrix(
          c(25,9,22,10),
          ncol=1, 
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        ),
        lociAllele1CountsNoASEProbs=matrix(
          rep(0.5, 4),
          ncol=1, 
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        )
      ),
      rowRanges=mySNVs
    ),
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM=SerialParam()
  )
)
 


###################################################
### code chunk number 11: example1s_refBias_adjustment
###################################################
##run the analysis adjusting for pre-existing allelic bias
summarizeASEResults_1s(
  runMBASED(
    SummarizedExperiment(
      assays=list(
        lociAllele1Counts=matrix(
          c(20,17,15,20),
          ncol=1,
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        ),
        lociAllele2Counts=matrix(
          c(25,9,22,10),
          ncol=1, 
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        ),
        lociAllele1CountsNoASEProbs=matrix(
          c(0.6, 0.6, 0.4, 0.6),
          ncol=1, 
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        )
      ),
      rowRanges=mySNVs
    ),
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM=SerialParam()
  )
)



###################################################
### code chunk number 12: overdispersion_example
###################################################
set.seed(5) ## we chose this seed to get a 'significant' result
totalAlleleCounts=c(45, 26, 37, 30)
## simulate allele1 counts
allele1Counts <- MBASED:::vectorizedRbetabinomMR(
  n=4,
  size=totalAlleleCounts,
  mu=rep(0.5, 4), 
  rho=rep(0.02, 4)
)
## run MBASED without accounting for overdispersion
summarizeASEResults_1s(
  runMBASED(
    SummarizedExperiment(
      assays=list(
        lociAllele1Counts=matrix(
          allele1Counts,
          ncol=1,
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        ),
        lociAllele2Counts=matrix(
          totalAlleleCounts-allele1Counts,
          ncol=1, 
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        )
      ),
      rowRanges=mySNVs
    ),
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM=SerialParam()
  )
)

## this is the same as explicitly setting dispersion parameters to 0.
summarizeASEResults_1s(
  runMBASED(
    SummarizedExperiment(
      assays=list(
        lociAllele1Counts=matrix(
          allele1Counts,
          ncol=1,
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        ),
        lociAllele2Counts=matrix(
          totalAlleleCounts-allele1Counts,
          ncol=1, 
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        ),
        lociCountsDispersions=matrix(
          rep(0, 4),
          ncol=1, 
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        )
      ),
      rowRanges=mySNVs
    ),
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM=SerialParam()
  )
)


## now re-run MBASED supplying the correct dispersion values:
summarizeASEResults_1s(
  runMBASED(
    SummarizedExperiment(
      assays=list(
        lociAllele1Counts=matrix(
          allele1Counts,
          ncol=1,
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        ),
        lociAllele2Counts=matrix(
          totalAlleleCounts-allele1Counts,
          ncol=1, 
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        ),
        lociCountsDispersions=matrix(
          rep(0.02, 4),
          ncol=1, 
          dimnames=list(
           names(mySNVs), 
           'mySample'
          )
        )
      ),
      rowRanges=mySNVs
    ),
    isPhased=FALSE,
    numSim=10^6,
    BPPARAM=SerialParam()
  )
)



###################################################
### code chunk number 13: session_info
###################################################
sessionInfo()


