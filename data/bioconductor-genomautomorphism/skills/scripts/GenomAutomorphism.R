# Code example from 'GenomAutomorphism' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----set-options, echo=FALSE, cache=FALSE-----------------------------------------------------------------------------
options(width = 120)

## ----inst-dep, eval=FALSE---------------------------------------------------------------------------------------------
# if (!requireNamespace("BiocManager"))
#     install.packages("BiocManager")
# 
# BiocManager::install(c("Biostrings", "GenomicRanges", "S4Vectors",
#         "BiocParallel", "Seqinfo", "BiocGenerics", "numbers", "devtools",
#         "doParallel", "data.table", "foreach","parallel"), dependencies = TRUE)

## ----inst, eval = FALSE-----------------------------------------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("GenomAutomorphism")

## ----inst-git, eval=FALSE---------------------------------------------------------------------------------------------
# BiocManager::install('genomaths/GenomAutomorphism')

## ----inst-git2, eval=FALSE--------------------------------------------------------------------------------------------
# BiocManager::install('genomaths/GenomAutomorphism_beta')

## ----lib,results="hide",warning=FALSE,message=FALSE-------------------------------------------------------------------
library(Biostrings)
library(GenomAutomorphism)

## ----fasta, message=FALSE---------------------------------------------------------------------------------------------
data(covid_aln, package = "GenomAutomorphism")
covid_aln

## ----int--------------------------------------------------------------------------------------------------------------
base2int("ACGT", group = "Z4", cube = "ACGT")

## ----int2-------------------------------------------------------------------------------------------------------------
base2int("ACGT", group = "Z5", cube = "ACGT")

## ----url, message=FALSE-----------------------------------------------------------------------------------------------
codons <- codon_coord(
                    codon = covid_aln, 
                    cube = "ACGT", 
                    group = "Z64", 
                    chr = 1L,
                    strand = "+",
                    start = 1,
                    end = 750)
codons

## ----bp---------------------------------------------------------------------------------------------------------------
x0 <- c("ACG", "TGC")
x1 <- DNAStringSet(x0)
x1

## ----bp_coord---------------------------------------------------------------------------------------------------------
x2 <- base_coord(x1, cube = "ACGT")
x2

x2. <- base_coord(x1, cube = "TGCA")
x2.

## ----bp_sum.----------------------------------------------------------------------------------------------------------
## cube "ACGT"
(x2$coord1 + x2$coord2) %% 4   

## cube "TGCA"
(x2.$coord1 + x2.$coord2) %% 4   

## ----bp_sum-----------------------------------------------------------------------------------------------------------
## Codon ACG
(x2$coord1 + x2.$coord1) %% 4 

## Codon TGC
(x2$coord2 + x2.$coord2) %% 4 

## ----codons-----------------------------------------------------------------------------------------------------------
## cube ACGT
x3 <- codon_coord(codon = x2, group = "Z64") 
x3

## cube TGCA
x3. <- codon_coord(codon = x2., group = "Z64") 
x3.

## ----bp_sum2----------------------------------------------------------------------------------------------------------
## cube "ACGT"
(as.numeric(x3$coord1) + as.numeric(x3$coord2)) %% 64  

## cube "TGCA"
(as.numeric(x3.$coord1) + as.numeric(x3.$coord2)) %% 64   

## ----bp_sum3----------------------------------------------------------------------------------------------------------
## Codon ACG
(as.numeric(x3$coord1) + as.numeric(x3.$coord1)) %% 64 

## Codon TGC
(as.numeric(x3$coord2) + as.numeric(x3.$coord2)) %% 64 

## ----aut--------------------------------------------------------------------------------------------------------------
autm <- automorphisms(
                    seqs = covid_aln,
                    group = "Z64",
                    cube = c("ACGT", "TGCA"),
                    cube_alt = c("CATG", "GTAC"),
                    start = 1,
                    end = 750, 
                    verbose = FALSE)
autm

## ----range------------------------------------------------------------------------------------------------------------
aut_range <- automorphismByRanges(autm)
aut_range

## ----aut_1, eval=FALSE------------------------------------------------------------------------------------------------
# ## Do not need to run it.
# covid_autm <- automorphisms(
#                     seq = covid_aln,
#                     group = "Z64",
#                     cube = c("ACGT", "TGCA"),
#                     cube_alt = c("CATG", "GTAC"),
#                     verbose = FALSE)

## ----dat--------------------------------------------------------------------------------------------------------------
data(covid_autm, package = "GenomAutomorphism")
covid_autm

## ----range_2----------------------------------------------------------------------------------------------------------
aut_range <- automorphismByRanges(covid_autm)
aut_range

## ----non-aut----------------------------------------------------------------------------------------------------------
idx = which(covid_autm$cube == "Trnl")
covid_autm[ idx ]

## ----range_3----------------------------------------------------------------------------------------------------------
idx = which(aut_range$cube == "Trnl")
aut_range[ idx ]

## ----indels-----------------------------------------------------------------------------------------------------------
data.frame(aut_range[idx])

## region width
width(aut_range[ idx ])

## ----barplot, fig.height = 5, fig.width = 6---------------------------------------------------------------------------
counts <- table(covid_autm$cube[ covid_autm$autm != 1 | 
                                    is.na(covid_autm$autm) ])

par(family = "serif", cex = 0.9, font = 2, mar=c(4,6,4,4))
barplot(counts, main="Automorphism distribution",
        xlab="Genetic-code cube representation",
        ylab="Fixed mutational events",
        col=c("darkblue","red", "darkgreen"), 
        border = NA, axes = FALSE, 
        cex.lab = 2, cex.main = 1.5, cex.names = 2)
axis(2, at = c(0, 200, 400, 600, 800), cex.axis = 1.5)
mtext(side = 1,line = -1.5, at = c(0.7, 1.9, 3.1, 4.3, 5.5),
    text = paste0( counts ), cex = 1.4,
    col = c("white","yellow", "black"))

## ----autby------------------------------------------------------------------------------------------------------------
autby_coef <- automorphism_bycoef(covid_autm)
autby_coef <- autby_coef[ autby_coef$autm != 1 & autby_coef$autm != -1  ]

## ----barplot_2, fig.height = 12, fig.width = 14-----------------------------------------------------------------------
post_prob <- automorphism_prob(autby_coef)
counts <-  post_prob$frequency
names(counts) <- post_prob$Codon
counts <- counts[counts > 2]


par(family = "serif", cex.axis = 2, font = 2, las = 1, 
    cex.main = 2.2, mar = c(6,2,4,4))
barplot(counts, main="Automorphism distribution per Mutation type",
        col = colorRampPalette(c("red", "yellow", "blue"))(36), 
        border = NA, axes = FALSE,las=2)
axis(side = 2,  cex.axis = 2, line = -1.8 )


## ----freq-table-------------------------------------------------------------------------------------------------------
post_prob <- post_prob[post_prob$Posterior_Probability > 0.003,]
post_prob

## ----prob, fig.height = 12, fig.width = 14, warning=FALSE-------------------------------------------------------------
probs <- post_prob$Posterior_Probability
names(probs) <- post_prob$Codon

par(family = "serif", cex.axis = 2, font = 2, las = 1, 
    cex.main = 2.1, mar = c(7,2,4,2))
barplot(probs, main="Automorphism Probaility per Mutation type",
        col = colorRampPalette(c("red", "yellow", "blue"))(36), 
        border = NA, axes = FALSE,las = 2, hadj = 0.8)
axis(side = 2,  cex.axis = 2.1, line = -1.8, hadj = 0.9 )

## ----conserved_regions------------------------------------------------------------------------------------------------
conserv <- conserved_regions(covid_autm)
conserv

## ----uniq-------------------------------------------------------------------------------------------------------------
conserv_unique <- conserved_regions(covid_autm, output = "unique")
conserv_unique

## ----aut_2, eval=FALSE------------------------------------------------------------------------------------------------
# autm_z125 <- automorphisms(
#                     seq = covid_aln,
#                     group = "Z125",
#                     cube = c("ACGT", "TGCA"),
#                     cube_alt = c("CATG", "GTAC"),
#                     verbose = FALSE)

## ----autm_z125--------------------------------------------------------------------------------------------------------
data(autm_z125, package = "GenomAutomorphism")
autm_z125

## ----range_4----------------------------------------------------------------------------------------------------------
aut_range_2 <- automorphismByRanges(autm_z125)
aut_range_2

## ----barplot_3, fig.height = 5, fig.width = 3-------------------------------------------------------------------------
counts <- table(autm_z125$cube[ autm_z125$autm != 1 ])

par(family = "serif", cex = 1, font = 2)
barplot(counts, main="Automorphism distribution",
        xlab="Genetic-code cube representation",
        ylab="Fixed mutational events",
        col=c("darkblue","red"), 
        ylim = c(0, 1300),
        border = NA, axes = TRUE)
mtext(side = 1,line = -2, at = c(0.7, 1.9, 3.1),
    text = paste0( counts ), cex = 1.4,
    col = c("white","red"))

## ----aut_3, eval=FALSE------------------------------------------------------------------------------------------------
# autm_3d <- automorphisms(
#                     seq = covid_aln,
#                     group = "Z5^3",
#                     cube = c("ACGT", "TGCA"),
#                     cube_alt = c("CATG", "GTAC"),
#                     verbose = FALSE)

## ----autm_3d----------------------------------------------------------------------------------------------------------
data(autm_3d, package = "GenomAutomorphism")
autm_3d

## ----autby_3----------------------------------------------------------------------------------------------------------
autby_coef_3d <- automorphism_bycoef(autm_3d)
autby_coef_3d <- autby_coef_3d[ autby_coef_3d$autm != "1,1,1" ]
autby_coef_3d

## ----conserved_regions_3----------------------------------------------------------------------------------------------
conserv <- conserved_regions(autm_3d)
conserv

## ----barplot_4, fig.height = 5, fig.width = 3-------------------------------------------------------------------------
counts <- table(autby_coef_3d$cube[ autby_coef_3d$autm != "1,1,1"])

par(family = "serif", cex = 1, font = 2, cex.main = 1)
barplot(counts, main="Automorphism distribution",
        xlab="Genetic-code cube representation",
        ylab="Fixed mutational events",
        col=c("darkblue","red"), 
        ylim = c(0, 1300), 
        border = NA, axes = TRUE)
mtext(side = 1,line = -2, at = c(0.7, 1.9),
    text = paste0( counts ), cex = 1.4,
    col = c("white"))

## ----sessionInfo, echo=FALSE------------------------------------------------------------------------------------------
sessionInfo()

