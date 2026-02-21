# Code example from 'preciseTADhub' vignette. See references/ for full tutorial.

## ----set-options, echo=FALSE, cache=FALSE-------------------------------------
knitr::opts_chunk$set(warnings = FALSE, message = FALSE)

## -----------------------------------------------------------------------------
#if (!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install(c("ExperimentHub"), version = "3.12")

library(ExperimentHub)
library(preciseTAD)
library(preciseTADhub)

## -----------------------------------------------------------------------------
#Initialize ExperimentHub
hub <- ExperimentHub()
query(hub, "preciseTADhub")
myfiles <- query(hub, "preciseTADhub")

CHR22_GM12878_5kb_Arrowhead <- readEH(chr = "CHR22", cl = "GM12878", gt = "Arrowhead", source = myfiles)

## -----------------------------------------------------------------------------
data("tfbsList")

# Restrict the data matrix to include only SMC3, RAD21, CTCF, and ZNF143
tfbsList_filt <- tfbsList[names(tfbsList) %in% c("Gm12878-Ctcf-Broad", 
                                            "Gm12878-Rad21-Haib",
                                            "Gm12878-Smc3-Sydh",
                                            "Gm12878-Znf143-Sydh")]
names(tfbsList_filt) <- c("Ctcf", "Rad21", "Smc3", "Znf143")


# Run preciseTAD
set.seed(123)
pt <- preciseTAD(genomicElements.GR = tfbsList_filt,
                featureType         = "distance",
                CHR                 = "CHR22",
                chromCoords         = list(18000000, 19000000),
                tadModel            = CHR22_GM12878_5kb_Arrowhead,
                threshold           = 1.0,
                verbose             = FALSE,
                parallel            = NULL,
                DBSCAN_params       = list(30000, 3))
                # flank               = 5000)
                # genome              = "hg19")

pt

