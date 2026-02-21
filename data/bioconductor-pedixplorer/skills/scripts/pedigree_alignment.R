# Code example from 'pedigree_alignment' vignette. See references/ for full tutorial.

## ----library_charge-------------------------------------------------------------------------------
library(Pedixplorer)

## ----setup, include = FALSE-----------------------------------------------------------------------
knitr::opts_chunk$set(
    echo = TRUE,
    fig.dim = c(8, 4),
    fig.align = "center",
    out.width = "600px",
    out.height = "400px"
)

## ----hint_usage, fig.alt="Hints usage"------------------------------------------------------------
id    <- c("A", "B", "C", "D", "E", "F", "G", "J", "I", "H")
dadid <- c("0", "0", "0", "A", "C", "C", "A", "F", "F", "F")
momid <- c("0", "0", "0", "B", "B", "B", "E", "G", "G", "G")
sex   <- c(1, 2, 1, 2, 2, 1, 2, 1, 1, 2)

pedi <- Pedigree(
    id, dadid, momid, sex, na_strings = "0"
)

# First pedigree with no reordering
plot(pedi, align_parents = FALSE, title = "1) Without reordering")

# Second pedigree with reordering
hints(pedi) <- auto_hint(pedi, align_parents = FALSE)
# Reorder siblings in opposite order
horder(hints(pedi))[c("H", "I", "J")] <- c(1, 2, 3)
# Set F individual on the right and set G as the anchor
spouse(hints(pedi)) <- data.frame(idl = "G", idr = "F", anchor = "left")
plot(pedi, align_parents = FALSE, title = "2) With ordering")

## ----auto_hint1, fig.alt="Comparison of auto_hint on a simple pedigree"---------------------------

# A simple Pedigree to illustrate autohint's code
test1 <- data.frame(id = 1:11,
    sex = c("m", "f")[c(1, 2, 1, 2, 1, 1, 2, 2, 1, 2, 1)],
    dadid = c(0, 0, 1, 1, 1, 0, 0, 6, 6, 6, 9),
    momid = c(0, 0, 2, 2, 2, 0, 0, 7, 7, 7, 4)
)
ped1 <- Pedigree(test1, missid = "0")

temp2 <- Pedigree(test1, missid = "0", hints = list(
    horder = setNames(
        c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11),
        1:11
    )
))

plot(temp2, title = "Before auto_hint")
plot(ped1, title = "After auto_hint")

## ----align2, fig.alt = "Comparison of auto_hint on a more complex pedigree"-----------------------
#
# The second, more complex test Pedigree
#
test2 <- data.frame(id = c(1:13, 21:41),
    dadid = c(0, 0, 1, 1, 1, 0, 0, 6, 6, 6, 0, 11, 11,
        0, 0, 0, 0, 0, 0, 21, 21, 21, 23, 23, 25, 28,
        28, 28, 28, 32, 32, 32, 32, 33
    ),
    momid = c(0, 0, 2, 2, 2, 0, 0, 7, 7, 7, 0, 5, 9,
        0, 0, 0, 0, 0, 0, 22, 22, 22, 24, 24, 26, 31,
        31, 31, 31, 29, 29, 29, 29, 13
    ),
    sex = c(1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1, 1, 2, 1,
        2, 1, 2, 1, 2, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2,
        1, 2, 1, 1, 2
    )
)
ped2 <- Pedigree(test2, missid = "0")
ped2a <- Pedigree(test2, missid = "0", hints = list(
    horder = setNames(seq_along(test2$id), test2$id)
))

plot(ped2a, title = "Before auto_hint")
plot(ped2, title = "After auto_hint")

## -------------------------------------------------------------------------------------------------
sessionInfo()

