Introduction to “universalmotif”

Benjamin Jean-Marie Tremblay∗

17 October 2021

Installation

if (!requireNamespace("BiocManager", quietly = TRUE))

install.packages("BiocManager")

BiocManager::install("universalmotif")

Overview

For a brief explanation of sequence motifs, see the Introduction to sequence motifs vignette. This broadly
covers the different ‘types’ of motif representation, as well as establishes the nomenclature used by the
universalmotif package.
The capabilities of the universalmotif package can be divided into several general categories. These are
briefly demonstrated in the following vignettes:

• Motif import, export, and manipulation
• Sequence scanning and manipulation
• Motif comparisons and P-values

∗benjamin.tremblay@uwaterloo.ca

1

