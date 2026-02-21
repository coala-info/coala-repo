# Code example from 'DataQuality' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(Sconify)
wand.final$IL7.fraction.cond.2[1:10]
knitr::opts_chunk$set(fig.width=6, fig.height=4) 

## -----------------------------------------------------------------------------
# Visualization
MakeHist(wand.final, 30, "IL7.fraction.cond.2", "fraction IL7")

# Characteristics of the visualization
median(wand.final$IL7.fraction.cond.2)
sd(wand.final$IL7.fraction.cond.2)


## -----------------------------------------------------------------------------
# Compare to a coin toss distribution
# Flips a coin k number of times, n repetitions, and returns the vector 
# containing the per-k percent heads 
KFlip <- function(k, n) {
  # The result 
  result <- sapply(1:n, function(i) {
    # Get the fraction heads for n flips
    flips <- sample(c(0, 1), k, replace = TRUE)
    percent.heads <- sum(flips)/length(flips)
    return(percent.heads)
  })
}


coin.toss <- data.frame("binomial" = KFlip(30, 1000))
MakeHist(coin.toss, 30, "binomial", "fraction heads")
median(coin.toss$binomial)
sd(coin.toss$binomial)

## -----------------------------------------------------------------------------

# Raw per-cell IgM levels
TsneVis(wand.final, "IgM(Eu153)Di", "Raw IgM expression")
TsneVis(wand.final, "IL7.fraction.cond.2", "Fraction cells in Il7 condition")



## -----------------------------------------------------------------------------

# Before normalization
MakeHist(bz.gmcsf.final, 100, "fraction.cond2", "fraction GM-CSF")

# Characteristics of the visualization
median(bz.gmcsf.final$fraction.cond2)
sd(bz.gmcsf.final$fraction.cond2)

# After normalization
MakeHist(bz.gmcsf.final.norm.scale, 100, "fraction.cond2", "fraction GM-CSF")

# Characteristics of the visualization
median(bz.gmcsf.final.norm.scale$fraction.cond2)
sd(bz.gmcsf.final.norm.scale$fraction.cond2)


## -----------------------------------------------------------------------------
# t-SNE map colored by KNN-based fraction GM-CSF
TsneVis(bz.gmcsf.final, "fraction.cond2", "Fraction GM-CSF")

# t-SNE map colored by KNN-based fraction GM-CSF
TsneVis(bz.gmcsf.final.norm.scale, "fraction.cond2", "Fraction GM-CSF")

