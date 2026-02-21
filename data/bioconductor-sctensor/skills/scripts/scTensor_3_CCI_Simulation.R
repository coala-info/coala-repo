# Code example from 'scTensor_3_CCI_Simulation' vignette. See references/ for full tutorial.

## ----cellCellSimulate_Default, echo=TRUE--------------------------------------
suppressPackageStartupMessages(library("scTensor"))
sim <- cellCellSimulate()

## ----cellCellSimulate_Setting, echo=TRUE--------------------------------------
# Default parameters
params <- newCCSParams()
str(params)

# Setting different parameters
# No. of genes : 1000
setParam(params, "nGene") <- 1000
# 3 cell types, 20 cells in each cell type
setParam(params, "nCell") <- c(20, 20, 20)
# Setting for Ligand-Receptor pair list
setParam(params, "cciInfo") <- list(
    nPair=500, # Total number of L-R pairs
    # 1st CCI
    CCI1=list(
        LPattern=c(1,0,0), # Only 1st cell type has this pattern
        RPattern=c(0,1,0), # Only 2nd cell type has this pattern
        nGene=50, # 50 pairs are generated as CCI1
        fc="E10"), # Degree of differential expression (Fold Change)
    # 2nd CCI
    CCI2=list(
        LPattern=c(0,1,0),
        RPattern=c(0,0,1),
        nGene=30,
        fc="E100")
    )
# Degree of Dropout
setParam(params, "lambda") <- 10
# Random number seed
setParam(params, "seed") <- 123

# Simulation data
sim <- cellCellSimulate(params)

## ----input, echo=TRUE---------------------------------------------------------
dim(sim$input)
sim$input[1:2,1:3]

## ----LR, echo=TRUE------------------------------------------------------------
dim(sim$LR)
sim$LR[1:10,]
sim$LR[46:55,]
sim$LR[491:500,]

## ----celltypes, echo=TRUE-----------------------------------------------------
length(sim$celltypes)
head(sim$celltypes)
table(names(sim$celltypes))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

