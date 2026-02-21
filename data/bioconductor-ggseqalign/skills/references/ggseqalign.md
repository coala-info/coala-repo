# Quickstart Guide to ggseqalign

Simeon Lim Rossmann1\*

1Norwegian University of Life Sciences (NMBU)

\*simeon.rossmann@nmbu.no

#### 30 October 2025

#### Abstract

Provides basic instructions to create minimal visualizations of pairwise
alignments from various inputs.

#### Package

ggseqalign 1.4.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Basics](#basics)
* [4 Hide mismatches](#hide-mismatches)
* [5 Styling with ggplot2](#styling-with-ggplot2)
* [6 Alignment parameters](#alignment-parameters)
* [7 Session info](#session-info)
* [8 Credit](#credit)

![ggseqalign hexlogo](data:image/png;base64...)

# 1 Introduction

Showing small differences between two long strings, such as DNA or AA
sequences is challenging, especially in R. Typically, DNA or AA sequence
alignments show all characters in a sequence. The package
*[ggmsa](https://bioconductor.org/packages/3.22/ggmsa)* does this really well and is compatible with
ggplot2. However, this is not viable for sequences over a certain
length.
Alternatively, top level visualizations may, for example, represent
degree of variation over the length in a line plot, making it possible
to gauge how strongly sequences differ, but not the quality of the
difference. The intention with this package is to provide a way to
visualize sequence alignments over the whole length of arbitrarily long
sequences without losing the ability to show small differences, see
figure [1](#fig:showcase).

![Example of ggseqalign visualization. Showcase of the package's capability to highlight differences between 2000 bp long DNA sequences.](data:image/png;base64...)

Figure 1: Example of ggseqalign visualization
Showcase of the package’s capability to highlight differences between 2000 bp long DNA sequences.

# 2 Installation

`ggseqalign` can be installed from Bioconductor.

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ggseqalign")
```

See the *[BiocManager](https://bioconductor.org/packages/3.22/BiocManager)* vignette for instructions on using
multiple versions of Bioconductor.

`ggseqalign` can also be installed from it’s original source on GitHub
(requires `devtools`)

```
devtools::install_git("https://github.com/simeross/ggseqalign.git")
```

# 3 Basics

This package relies on two core functions, `alignment_table()` and
`plot_sequence_alignment()`. At its core, the former uses
`PairwiseAlignment()`, previously in *[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)*, now in
*[pwalign](https://bioconductor.org/packages/3.22/pwalign)*, to align one or several query strings to a
subject string to parse all information on mismatches, insertions and
deletions into a table that is used as the input for plotting with
`plot_sequence_alignment()`.

A minimal example:

```
library(ggseqalign)
library(ggplot2)

query_strings <- (c("boo", "fibububuzz", "bozz", "baofuzz"))
subject_string <- "boofizz"

alignment <- alignment_table(query_strings, subject_string)

plot_sequence_alignment(alignment) +
    theme(text = element_text(size = 15))
```

![Output of the minimal example code](data:image/png;base64...)

Figure 2: Output of the minimal example code

This package is fully compatible with `DNAStringSet`and `AAStringSet`
classes from *[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)*, an efficient and powerful way to
handle sequence data. The two examples below use
example data from the *[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)* package and requires it
to be installed. To install *[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)*, enter

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("Biostrings")
```

This chunk demonstrates reading sequence data from
a FASTA file into a `DNAStringSet`-class object and aligning it to a
manually created `DNAStringSet`-class object.

```
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
```

![](data:image/png;base64...)

# 4 Hide mismatches

The plots that `plot_sequence_alignment()` generates can become hard to
read if there are too many differences, see fig. [3](#fig:noisefig).
The package allows to hide character mismatches to preserve legibility
of structural differences (fig. [4](#fig:noisefignolab)).

```
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
```

![Example of a case where ggseqalign fails. If there are too many differences, the mismatches overlap each other and become noisy.](data:image/png;base64...)

Figure 3: Example of a case where ggseqalign fails
If there are too many differences, the mismatches overlap each other and become noisy.

```
plot_sequence_alignment(alignment_table(q, s), hide_mismatches = TRUE) +
    theme(text = element_text(size = 15))
```

![Hiding mismatches. Hiding character mismatches reduces visual noise if alignments have many character mismatches and preserves structural information.](data:image/png;base64...)

Figure 4: Hiding mismatches
Hiding character mismatches reduces visual noise if alignments have many character mismatches and preserves structural information.

# 5 Styling with ggplot2

Since `plot_sequence_alignment()` produces a ggplot-class object, all
aspects of the plots can be modified with *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)*
functions, such as `theme()`. As an example, let’s recreate and modify
figure [1](#fig:showcase).

```
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
```

![Styling with ggplot2. In this example, text size was increased, axis labels were added, x-axis text rotated and the color scheme changed.](data:image/png;base64...)

Figure 5: Styling with ggplot2
In this example, text size was increased, axis labels were added, x-axis text rotated and the color scheme changed.

Some modifications may require digging into the plot object layers, this
can get finicky but is possible. We can use `pl$layers` to get a summary
of the object’s layers. In this case, the geom\_point layers that plot
the dots for mismatches are entry 8 in the layer list, the white bar
that indicates deletions is usually in layer 2. You may want to change
the deletion bar’s color if you use another plot background color. This
code chunk modifies the `pl` object from the previous chunk; the above
chunk has to be run prior to this one.

```
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
```

![Modifying ggplot2 layers. In this example, deletion bars were adjusted to match background color and mismatch indicators were modified using plot layer modification](data:image/png;base64...)

Figure 6: Modifying ggplot2 layers
In this example, deletion bars were adjusted to match background color and mismatch indicators were modified using plot layer modification

# 6 Alignment parameters

Any additional parameters to `alignment_table()` are passed on to
`pwalign::pairwiseAlignment()`, check
*[pwalign](https://bioconductor.org/packages/3.22/pwalign/vignettes/PairwiseAlignments.pdf)* for a
comprehensive overview over the available options. As a simple example,
we may increase gap penalties for the alignment in
[2](#fig:minimal-example).

```
library(ggseqalign)
library(ggplot2)

query_strings <- (c("boo", "fibububuzz", "bozz", "baofuzz"))
subject_string <- "boofizz"

alignment <- alignment_table(query_strings, subject_string, gapOpening = 20)

plot_sequence_alignment(alignment) +
    theme(text = element_text(size = 15))
```

![Modified alignment parameters.](data:image/png;base64...)

Figure 7: Modified alignment parameters

# 7 Session info

The output in this vignette was produced under the following conditions:

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ggplot2_4.0.0       ggseqalign_1.4.0    Biostrings_2.78.0
##  [4] Seqinfo_1.0.0       XVector_0.50.0      IRanges_2.44.0
##  [7] S4Vectors_0.48.0    BiocGenerics_0.56.0 generics_0.1.4
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        jsonlite_2.0.0      dplyr_1.1.4
##  [4] compiler_4.5.1      BiocManager_1.30.26 crayon_1.5.3
##  [7] Rcpp_1.1.0          tinytex_0.57        tidyselect_1.2.1
## [10] magick_2.9.0        dichromat_2.0-0.1   jquerylib_0.1.4
## [13] scales_1.4.0        yaml_2.3.10         fastmap_1.2.0
## [16] R6_2.6.1            labeling_0.4.3      knitr_1.50
## [19] tibble_3.3.0        bookdown_0.45       RColorBrewer_1.1-3
## [22] bslib_0.9.0         pillar_1.11.1       rlang_1.1.6
## [25] cachem_1.1.0        pwalign_1.6.0       xfun_0.53
## [28] S7_0.2.0            sass_0.4.10         viridisLite_0.4.2
## [31] cli_3.6.5           withr_3.0.2         magrittr_2.0.4
## [34] digest_0.6.37       grid_4.5.1          lifecycle_1.0.4
## [37] vctrs_0.6.5         evaluate_1.0.5      glue_1.8.0
## [40] farver_2.1.2        rmarkdown_2.30      tools_4.5.1
## [43] pkgconfig_2.0.3     htmltools_0.5.8.1
```

# 8 Credit

The research and data generation that was a major motivation for me to
finally create this package has received funding from the Norwegian
Financial Mechanism 2014-2021, [project DivGene:
UMO-2019/34/H/NZ9/00559](https://eeagrants.org/archive/2014-2021/projects/PL-Basic%20Research-0012)