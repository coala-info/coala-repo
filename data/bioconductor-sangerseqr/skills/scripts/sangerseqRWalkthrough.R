# Code example from 'sangerseqRWalkthrough' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
  BiocStyle::markdown()

## ----include=FALSE------------------------------------------------------------
library(knitr, quietly=TRUE)
library(sangerseqR, quietly=TRUE)
library(Biostrings, quietly=TRUE)
opts_chunk$set(tidy=TRUE, tidy.opts=list(width.cutoff=70))

## -----------------------------------------------------------------------------
hetab1 <- read.abif(system.file("extdata", 
                                "heterozygous.ab1", 
                                package="sangerseqR"))
str(hetab1, list.len=20)

## -----------------------------------------------------------------------------
homoscf <- read.scf(system.file("extdata", 
                                "homozygous.scf", 
                                package="sangerseqR"))
str(homoscf)

## -----------------------------------------------------------------------------
#from a sequence file object
homosangerseq <- sangerseq(homoscf)

#directly from the file
hetsangerseq <- readsangerseq(system.file("extdata", 
                                          "heterozygous.ab1", 
                                          package="sangerseqR"))
str(hetsangerseq)

## -----------------------------------------------------------------------------
#default is to return a DNAString object
Seq1 <- primarySeq(homosangerseq)
reverseComplement(Seq1)

#can return as string
primarySeq(homosangerseq, string=TRUE)

## ----fig.height=10------------------------------------------------------------
chromatogram(hetsangerseq, width=80, height=3, trim5=50, trim3=100, 
             showcalls='both')

## -----------------------------------------------------------------------------
hetcalls <- makeBaseCalls(hetsangerseq, ratio=0.33)
hetcalls

## ----fig.height=10------------------------------------------------------------
chromatogram(hetcalls, width=80, height=3, trim5=50, trim3=100, 
             showcalls='both')

## -----------------------------------------------------------------------------
ref <- subseq(primarySeq(homosangerseq, string=TRUE), start=30, width=500)
hetseqalleles <- setAllelePhase(hetcalls, ref, trim5=50, trim3=300)
hetseqalleles

## -----------------------------------------------------------------------------
pa <- pairwiseAlignment(primarySeq(hetseqalleles)[1:400], 
                        secondarySeq(hetseqalleles)[1:400], 
                        type="global-local")
writePairwiseAlignments(pa)

