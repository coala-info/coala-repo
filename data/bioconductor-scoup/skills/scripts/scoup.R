# Code example from 'scoup' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
    BiocStyle::markdown()

## ----eval=FALSE---------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("scoup")

## ----eval=TRUE----------------------------------------------------------------
# Make package accessible in R session
library(scoup)

# Number of extant taxa
leaves <- 8

# Number of codon sites
sSize <- 15

# Number of data replications for each parameter combination
sims <- 1

# OU reversion parameter (Theta) value
eThta <- c(0.01)

# OU asymptotic variance value
eVary <- c(0.0001)

# OU landscape shift parameters
hbrunoStat <- hbInput(c(vNvS=1, nsynVar=0.01))

# Sequence alignment size information
seqStat <- seqDetails(c(nsite=sSize, ntaxa=leaves))

# Iterate over all listed OU variance values
for(g in seq(1,length(eVary))){

    # Iterate over all listed OU reversion parameter values
    for(h in seq(1,length(eThta))){

        # Create appropriate simulation function ("ou") object
        adaptStat <- ouInput(c(eVar=eVary[g],Theta=eThta[h]))

        # Iterate over the specified number of replicates
        for(i in seq(1,sims)){

            # Execute simulation
            simData <- alignsim(adaptStat, seqStat, hbrunoStat, NULL)
        }
    }
}
# Print simulated alignment
seqCOL(simData)

## ----eval=TRUE----------------------------------------------------------------
# Make package accessible in R session
library(scoup)

# Number of extant taxa
xtant <- 8

# Number of codon sites
siteSize <- 15

# Number of data replications for each parameter combination
simSize <- 1

# Variance of the non-synonymous selection coefficients
nsynVary <- c(0.001)

# Ratio of the variance of the non-synonymous to synonymous coeff.
vNvSvec <- c(1)

# Sequence alignment size information
seqStat <- seqDetails(c(nsite=siteSize, ntaxa=xtant))

# Iterate over all listed coefficient variance ratios
for(a in seq(1,length(vNvSvec))){

    # Iterate over all listed non-synonymous coefficients variance
    for(b in seq(1,length(nsynVary))){

        # Create appropriate simulation function ("omega") object
        adaptData <- wInput(list(vNvS=vNvSvec[a],nsynVar=nsynVary[b]))
        
        # Iterate over the specified number of replicates
        for(i in seq(1,simSize)){

            # Execute simulation
            simulateSeq <- alignsim(adaptData, seqStat, NA)
        }
    }
}
# Print simulated alignment
cseq(simulateSeq)

## ----eval=TRUE----------------------------------------------------------------
# Make package accessible in R session
library(scoup)

# Number of codon sites
sitesize<- 15

# Variance of non-synonymous selection coefficients
nsynVary <- 0.01

# Number of extant taxa
## Commented value was used for results presented in article
taxasize <- 8

# Sequence alignment size information
seqsEntry <- seqDetails(c(nsite=sitesize, ntaxa=taxasize))

# Create the applicable ("ou") object for simulation function
## eVar= OU asymptotic variance, Theta=OU reversion parameter
adaptEntry <- ouInput(c(eVar=0.1,Theta=1))

# Ratio of the variance of the non-synonymous to synonymous coeff.
sratio <- c(1e-06)

# Iterate over all listed coefficient variance ratios
for(a0 in seq(1,length(sratio))){

    # OU landscape shift parameters
    mValues <- hbInput(c(vNvS=sratio[a0], nsynVar=nsynVary))
    
    # Execute simulation
    simSeq <- alignsim(adaptEntry, seqsEntry, mValues, NA)
}
# Print simulated codon sequence
cseq(simSeq)

## ----eval=TRUE----------------------------------------------------------------
# Make package accessible in R session
library(scoup)

# Number of internal nodes on the desired balanced tree
iNode <- 3

# Number of required codon sites
siteCount <- 15

# Variance of non-synonymous selection coefficients
nsnV <- 0.01

# Number of data replications for each parameter combination
nsim <- 1

# Ratio of the variance of the non-synonymous to synonymous coeff.
vNvSvec <- c(1e-06)

# Sequence alignment size information
seqsBwise <- seqDetails(c(nsite=siteCount, blength=0.10))

# Iterate over all listed coefficient variance ratios
for(h in seq(1,length(vNvSvec))){

    # Iterate over the specified number of replicates
    for(i in seq(1,nsim)){

        # Create the parameter set applicable at each internal tree node
        scInput <- rbind(vNvS=c(rep(0,iNode-1),vNvSvec[h]),
                        nsynVar=rep(nsnV,iNode))
        
        # Create the applicable ("discrete") object for simulation function
        adaptBranch <- discreteInput(list(p02xnodes=scInput))
        
        # Execute simulation
        genSeq <- alignsim(adaptBranch, seqsBwise, NULL)
    }
}
# Print simulated sequence data
seqCOL(genSeq)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

