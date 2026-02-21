# Code example from 'similarity-metrics-evaluation' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.width = 7,
    fig.height = 7
)

## ----setup--------------------------------------------------------------------
library(mosbi)

## -----------------------------------------------------------------------------
# Bray-Curtis similarity
bray_curtis <- function(s1, s2, overlap) {
    return(((2 * overlap) / (s1 + s2)))
}

# Jaccard index
jaccard <- function(s1, s2, overlap) {
    return(((overlap) / (s1 + s2 - overlap)))
}

# overlap coefficient
overlap <- function(s1, s2, overlap) {
    return((overlap / min(s1, s2)))
}

# Fowlkes–Mallows index
folkes_mallows <- function(s1, s2, overlap) {
    tp <- choose(overlap, 2)
    fp <- choose(s1 - overlap, 2)
    fn <- choose(s2 - overlap, 2)

    return(sqrt((tp / (tp + fp)) * (tp / (tp + fn))))
}

## -----------------------------------------------------------------------------
# Scenario 1 - two biclusters of the same size
size1_1 <- rep(1000, 1000)
size2_1 <- rep(1000, 1000)
overlap_1 <- seq(1, 1000)

# Scenario 2 - two biclusters one of size 500, the other of size 1000
size1_2 <- rep(1000, 500)
size2_2 <- rep(500, 500)
overlap_2 <- seq(1, 500)

## -----------------------------------------------------------------------------
plot(overlap_1, bray_curtis(size1_1, size2_1, overlap_1),
    col = "red", type = "l", xlab = "Overlap", ylab = "Similarity", 
    ylim = c(0, 1)
)
lines(overlap_1, jaccard(size1_1, size2_1, overlap_1), col = "blue")
lines(overlap_1, overlap(size1_1, size2_1, overlap_1), col = "green", lty = 2)
lines(overlap_1, folkes_mallows(size1_1, size2_1, overlap_1), col = "orange")
legend(
    x = .8, legend = c("Bray-Curtis", "Jaccard", "Overlap", "Fowlkes–Mallows"),
    col = c("red", "blue", "green", "orange"),
    lty = 1, cex = 0.8, title = "Similarity metrics"
)

## -----------------------------------------------------------------------------
plot(overlap_2, bray_curtis(size1_2, size2_2, overlap_2),
    col = "red", type = "l", xlab = "Overlap", ylab = "Similarity", 
    ylim = c(0, 1)
)
lines(overlap_2, jaccard(size1_2, size2_2, overlap_2), col = "blue")
lines(overlap_2, overlap(size1_2, size2_2, overlap_2), col = "green")
lines(overlap_2, folkes_mallows(size1_2, size2_2, overlap_2), col = "orange")
legend(
    x = .8, legend = c("Bray-Curtis", "Jaccard", "Overlap", "Fowlkes–Mallows"),
    col = c("red", "blue", "green", "orange"),
    lty = 1, cex = 0.8, title = "Similarity metrics"
)

## -----------------------------------------------------------------------------
sessionInfo()

