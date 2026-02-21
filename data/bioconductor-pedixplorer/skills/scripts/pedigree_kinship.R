# Code example from 'pedigree_kinship' vignette. See references/ for full tutorial.

## ----kinship_algo, eval=FALSE---------------------------------------------------------------------
# for (g in 1:max(depth)) {
#     indx <- which(depth == g)
#     kmat[indx, ] <- (kmat[mother[indx], ] + kmat[father[indx], ]) / 2
#     kmat[, indx] <- (kmat[, mother[indx]] + kmat[, father[indx], ]) / 2
#     for (j in indx) kmat[j, j] <- (1 + kmat[mother[j], father[j]]) / 2
# }

## ----kinship--------------------------------------------------------------------------------------
library(Pedixplorer)
data(sampleped)
pedi <- Pedigree(sampleped[, -16]) # Remove adoption field
kinship(pedi)[35:48, 35:48]

## ----kinship_twins, fig.alt = "Monozygotic twins", fig.align = 'center'---------------------------
df <- data.frame(
    id = c(1, 2, 3, 4, 5, 6, 7, 8),
    dadid = c(4, 4, 4, NA, 4, 4, 4, NA),
    momid = c(8, 8, 8, NA, 8, 8, 8, NA),
    sex = c(1, 1, 1, 1, 2, 2, 1, 2)
)
rel <- data.frame(
    id1 = c(1, 3, 6, 7),
    id2 = c(2, 2, 5, 3),
    code = c(1, 1, 1, 1)
)
pedi <- Pedigree(df, rel)
plot(pedi)
twins <- c(1, 2, 3, 7, 5, 6)
kinship(pedi)[twins, twins]

## -------------------------------------------------------------------------------------------------
sessionInfo()

