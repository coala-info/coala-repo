# Code example from 'ModCon' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      dev = "png")

## ----eval=TRUE----------------------------------------------------------------
library(ModCon)

#CDS holding the respective donor site
cds <- paste0('ATGGAAGACGCCAAAAACATAAAGAAAGGCCCGGCGCCATTCTATCCGCTG',
              'GAAGATGGAACCGCTGGAGAGCAACTGCATAAGGCTATGAAGAGATACGCC',
              'CTGGTTCCTGGAACAATTGCTTTTACAGATGCACATATCGAGGTGGACATC',
              'ACTTACGCTGAGTACTTCGAA')

## Executing ModCon to increase the splice site HEXplorer weigth of 
## the splice donor at position 103
cdsSSHWincreased <- ModCon(cds, 103, nCores=1)
cdsSSHWincreased


## ----eval=TRUE----------------------------------------------------------------
## Executing ModCon to decrease the splice site HEXplorer weigth of 
## the splice donor at position 103
cdsSSHWdecreased <- ModCon(cds, 103, optimizeContext=FALSE, nCores=1)
cdsSSHWdecreased

## ----eval=TRUE----------------------------------------------------------------
## Executing ModCon to increase the splice site HEXplorer weigth of 
## the splice donor at position 103 to around 60% of the maximum
suppressMessages(cdsSSHWincreased <- ModCon(cds, 103, optiRate=60, nCores=1))
suppressMessages(cdsSSHWdecreased <- ModCon(cds, 103, optiRate=60, optimizeContext=FALSE, nCores=1))
cdsSSHWincreased
cdsSSHWdecreased

## ----eval=TRUE----------------------------------------------------------------
## Executing ModCon to increase the splice site HEXplorer weigth of 
## the splice donor at position 103 to around 60% of the maximum
suppressMessages(cdsSSHWincreased <- ModCon(cds, 103, 
                                sdMaximalHBS=10, acMaximalMaxent=4, optiRate=60,
                                nGenerations=5, parentSize=200, startParentSize=800,
                                bestRate=50, semiLuckyRate=10, luckyRate=5,
                                mutationRate=1e-03, nCores=1))

cdsSSHWincreased

## ----eval=TRUE----------------------------------------------------------------
## Executing ModCon to decrease the splice site HEXplorer weigth of 
## the splice donor at position 103
cdsSSHWdecreased <- ModCon(cds, 103, downChangeCodonsIn=20, upChangeCodonsIn=21, nCores=1)
cdsSSHWdecreased

## ----eval=TRUE----------------------------------------------------------------
## Decreaser HBond score of the splice donor at position 103
## by codon selection
cdsHBondDown <- decreaseGTsiteStrength(cds, 103)
cdsHBondUp <- increaseGTsiteStrength(cds, 103)
cdsHBondDown

## ----eval=TRUE----------------------------------------------------------------
library(data.table)
## Initiaing the Codons matrix plus corresponding amino acids
ntSequence <- 'TTTTCGATCGGGATTAGCCTCCAGGTAAGTATCTATCGATCTATGCGATAG'
## Create Codon Matrix by splitting up the sequence by 3nt
fanFunc <- createCodonMatrix(ntSequence)
cdsSDlow <- degradeSDs(fanFunc, maxhbs=10, increaseHZEI=TRUE)
cdsSAlow <- degradeSAs(fanFunc, maxhbs=10, maxME=4, increaseHZEI=TRUE)
cdsSDlow
cdsSAlow

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

