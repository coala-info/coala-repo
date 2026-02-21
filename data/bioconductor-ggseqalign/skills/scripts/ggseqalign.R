# Code example from 'ggseqalign' vignette. See references/ for full tutorial.

## ----showcase, fig.cap="Example of ggseqalign visualization. Showcase of the package's capability to highlight differences between 2000 bp long DNA sequences.", echo=FALSE, warning=FALSE, message=FALSE----
### This chunk dynamically creates fig:showcase but is hidden in the vignette.
# It is meant to give an initial impression of a real use case without 
# presenting overwhelming code at the start. This chunk is recreated in 
# 'ggplot-mod' in its entirety aside from the global figure output setting.

library(Biostrings)
library(ggseqalign)
library(ggplot2)

knitr::opts_chunk$set(fig.dim = c(6, 4))

dna <- readDNAStringSet(system.file("extdata", "dm3_upstream2000.fa.gz",
    package = "Biostrings"
))

q <- dna[2:4]
s <- dna[5]

q[1] <- as(
    replaceLetterAt(q[[1]], c(5, 200, 400), "AGC"),
    "DNAStringSet"
)
q[2] <- as(
    c(substr(q[[2]], 300, 1500), substr(q[[2]], 1800, 2000)),
    "DNAStringSet"
)
q[3] <- as(
    replaceAt(
        q[[3]], 1500,
        paste(rep("A", 1000), collapse = "")
    ),
    "DNAStringSet"
)
names(q) <- c("mismatches", "deletions", "insertion")
names(s) <- "reference"

plot_sequence_alignment(alignment_table(q, s)) +
    theme(text = element_text(size = 15))

## ----installbioc, eval = FALSE------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ggseqalign")

## ----installgit, eval = FALSE-------------------------------------------------
# devtools::install_git("https://github.com/simeross/ggseqalign.git")

## ----minimal-example, fig.cap="Output of the minimal example code", warning=FALSE----
library(ggseqalign)
library(ggplot2)

query_strings <- (c("boo", "fibububuzz", "bozz", "baofuzz"))
subject_string <- "boofizz"

alignment <- alignment_table(query_strings, subject_string)

plot_sequence_alignment(alignment) +
    theme(text = element_text(size = 15))

## ----read-in-fasta, message= FALSE, warning=FALSE-----------------------------
library(ggseqalign)
library(Biostrings)
library(ggplot2)

query_sequences <- Biostrings::readDNAStringSet(system.file("extdata",
    "fastaEx.fa",
    package = "Biostrings"
))
subject_sequence <- DNAStringSet(paste0("AAACGATCGATCGTAGTCGACTGATGT",
                                        "AGTATATACGTCGTACGTAGCATCGTC",
                                        "AGTTACTGCATGCCGG"))

alignment <- alignment_table(query_sequences, subject_sequence)

plot_sequence_alignment(alignment) +
    theme(text = element_text(size = 15))

## ----noisefig, fig.cap="Example of a case where ggseqalign fails. If there are too many differences, the mismatches overlap each other and become noisy.", echo=TRUE, warning=FALSE----
# load
dna <- Biostrings::readDNAStringSet(system.file("extdata",
    "dm3_upstream2000.fa.gz",
    package = "Biostrings"
))
q <- as(
    c(substr(dna[[1]], 100, 300)),
    "DNAStringSet"
)
s <- as(
    c(substr(dna[[2]], 100, 300)),
    "DNAStringSet"
)
names(q) <- c("noisy alignment")
names(s) <- "reference"

plot_sequence_alignment(alignment_table(q, s)) +
    theme(text = element_text(size = 15))

## ----noisefignolab, fig.cap="Hiding mismatches. Hiding character mismatches reduces visual noise if alignments have many character mismatches and preserves structural information.", echo=TRUE, warning=FALSE----
plot_sequence_alignment(alignment_table(q, s), hide_mismatches = TRUE) +
    theme(text = element_text(size = 15))

## ----ggplot-mod, fig.cap="Styling with ggplot2. In this example, text size was increased, axis labels were added, x-axis text rotated and the color scheme changed.", warning=FALSE----
library(ggseqalign)
library(ggplot2)
library(Biostrings)

dna <- readDNAStringSet(system.file("extdata", "dm3_upstream2000.fa.gz",
    package = "Biostrings"
))

q <- dna[2:4]
s <- dna[5]

q[1] <- as(
    replaceLetterAt(q[[1]], c(5, 200, 400), "AGC"),
    "DNAStringSet"
)
q[2] <- as(
    c(substr(q[[2]], 300, 1500), substr(q[[2]], 1800, 2000)),
    "DNAStringSet"
)
q[3] <- as(
    replaceAt(
        q[[3]], 1500,
        paste(rep("A", 1000), collapse = "")
    ),
    "DNAStringSet"
)
names(q) <- c("mismatches", "deletions", "insertion")
names(s) <- "reference"

pl <- plot_sequence_alignment(alignment_table(q, s))

pl <- pl +
    ylab("Sequence variants") +
    xlab("Length in bp") +
    scale_color_viridis_d() +
    theme(
        text = element_text(size = 20),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
        axis.title = element_text()
    )

pl

## ----ggplot-layer-mod, fig.cap="Modifying ggplot2 layers. In this example, deletion bars were adjusted to match background color and mismatch indicators were modified using plot layer modification", warning=FALSE----
# Define background color
bg <- "grey90"

# Change plot background
pl <- pl + theme(panel.background = element_rect(
    fill = bg,
    colour = bg
))

# Match deletion to background
pl$layers[[2]]$aes_params$colour <- bg
# Increase mismatch indicator size and change shape
pl$layers[[8]]$aes_params$size <- 2
pl$layers[[8]]$aes_params$shape <- 4
pl$layers[[8]]$aes_params$colour <- "black"

pl

## ----minimal-example-mod, fig.cap="Modified alignment parameters.", warning=FALSE----
library(ggseqalign)
library(ggplot2)

query_strings <- (c("boo", "fibububuzz", "bozz", "baofuzz"))
subject_string <- "boofizz"

alignment <- alignment_table(query_strings, subject_string, gapOpening = 20)

plot_sequence_alignment(alignment) +
    theme(text = element_text(size = 15))

## ----session------------------------------------------------------------------
sessionInfo()

