Monocle: Cell counting, differential expression, and
trajectory analysis for single-cell RNA-Seq experiments

Cole Trapnell

Davide Cacchiarelli

University of Washington,
Seattle, Washington, USA
coletrap@uw.edu

Harvard University,
Cambridge, Massachussetts, USA
davide@broadinstitute.org

Xiaojie Qiu

University of Washington,
Seattle, Washington, USA
xqiu@uw.edu

October 30, 2025

Abstract

Single cell gene expression studies enable profiling of transcriptional regulation during complex biological
processes and within highly hetergeneous cell populations. These studies allow discovery of genes that identify
In many
certain subtypes of cells, or that mark a particular intermediate states during a biological process.
single cell studies, individual cells are executing through a gene expression program in an unsynchronized
manner.
In effect, each cell is a snapshot of the transcriptional program under study. The package monocle
provides tools for analyzing single-cell expression experiments. Monocle introduced the strategy of ordering
single cells in pseudotime, placing them along a trajectory corresponding to a biological process such as cell
differentiation. Monocle learns this trajectory directly from the data, in either a fully unsupervised or a semi-
supervised manner. It also performs differential gene expression and clustering to identify important genes and
cell states. It is designed for RNA-Seq studies, but can be used with other assays. For more information on the
algorithm at the core of monocle, or to learn more about how to use single cell RNA-Seq to study a complex
biological process, see the original work by Trapnell and Cacchiarelli et al and more recent updates by Qiu et
al.

For information on Monocle’s features and how to utilize them, go to http://cole-trapnell-lab.github.io/monocle-

release/ and go to the "Documentation" tab displayed at the top of the page.

plot(1:10)

1

Monocle: Cell counting, differential expression, and trajectory analysis for single-cell RNA-Seq experiments

