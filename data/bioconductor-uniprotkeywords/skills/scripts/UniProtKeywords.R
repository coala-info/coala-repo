# Code example from 'UniProtKeywords' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(UniProtKeywords)

## -----------------------------------------------------------------------------
UniProtKeywords

## -----------------------------------------------------------------------------
data(kw_terms)
length(kw_terms)
kw_terms[["Cell cycle"]]

## -----------------------------------------------------------------------------
data(kw_parents)
kw_parents[1:2]

data(kw_children)
kw_children[1:2]

data(kw_ancestors)
kw_ancestors[1:2]

data(kw_offspring)
kw_offspring[1:2]

## -----------------------------------------------------------------------------
gl = load_keyword_genesets(9606)
gl[3:4]  # because gl[1:2] has a very long output, here we print gl[3:4]

## -----------------------------------------------------------------------------
tb = load_keyword_genesets(9606, as_table = TRUE)
head(tb)

## -----------------------------------------------------------------------------
gl2 = load_keyword_genesets("mouse")
gl2[3:4]

## ----fig.width = 7, fig.height = 5--------------------------------------------
plot(table(sapply(gl, length)), log = "x", 
    xlab = "Size of keyword genesets",
    ylab = "Number of keywords"
)

## ----fig.width = 7, fig.height = 5--------------------------------------------
plot(table(sapply(gregexpr(" |-|/", names(gl)), length)), 
    xlab = "Number of words in keywords",
    ylab = "Number of keywords"
)

## ----fig.width = 7, fig.height = 5--------------------------------------------
plot(table(nchar(names(gl))), 
    xlab = "Number of characters in keywords",
    ylab = "Number of keywords"
)

## -----------------------------------------------------------------------------
sessionInfo()

