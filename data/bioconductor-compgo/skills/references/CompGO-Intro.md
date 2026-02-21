CompGO Introduction

Sam D. Bassett, Ashley J. Waardenberg

Developmental and Stem Cell Biology Lab,
Victor Chang Cardiac Research Institute,
Darlinghurst, Sydney, Australia

1 Introduction

This package contains functions to accomplish several tasks relating to gene ontology en-
It interfaces
richment comparison and visualisation given either .bed ﬁles or gene lists.
with rtracklayer and VariantAnnotation to easily annotate .bed ﬁles with genes, and with
RDAVIDWebService to generate functional annotation charts based on these gene lists.
From here, we provide several methods for comparative visualisation, including viewing
the GO term hierarchy in two samples using a directed acyclic graph (DAG), performing
z-score standardisation (approximately normal using a log odds-ratio (OR) - Equation 1
and 2) of GO terms returned from DAVID and comparing enrichment via pairwise scatter-
plots with linear ﬁt and Jaccard metrics (Equation 3). We also provide functions to enable
large-scale clustering.

Z ∼ N (log(OR), σ2)

zi =

log(OR)
SE(OR)

(1)

(2)

A ∩ B
A ∪ B
Please see full vignette for usage instructions, or the user manual for function deﬁnitions.

Jc =

(3)

> # Not run because it spawns processes at compile time
> #library(CompGO)
> #help.start()
> # Then navigate to CompGO, click on "Package vignettes and other information", and open CompGO-vignette.pdf

1

