CellTrails: Reconstruction, visualization, and analysis of branching
trajectories from single-cell expression data

Daniel Christian Ellwanger
Stanford University School of Medicine
Stanford, California, USA
dc.ellwanger.dev@gmail.com

7/26/2018

Abstract

High-throughput single-cell technologies facilitate the generation of -omic readouts from thousands of
cells captured at different cellular maturation stages during development, or other normal or pathological
processes with unprecedented resolution. A single snapshot of an asynchronously developing specimen,
for example, constitutes a time series in which individual cells represent distinct time points along a
continuum. However, recoding of valuable cell-specific information, such as a cell’s developmental age, its
location in a tissue, or its functional phenotype is limited during sample preparation, and remains hidden
in high dimensional cellular expression profiles. This formulates the computational challenge to infer
the latent internal time axis of the biological process from the obtained expression matrix alone, while
considering common parameters of single-cell measurements, such as noise, dropouts and redundancy.
In other words, biological samples need to be placed by means of hidden information onto a non-linear
trajectory, which might constitute of branching processes towards distinct functional cell types.

CellTrails is an R package for the de novo chronological ordering, visualization and analysis of single-
cell expression data. CellTrails makes use of a geometrically motivated concept of lower-dimensional
manifold learning, which exhibits a multitude of virtues that counteract intrinsic noise of single cell data
caused by drop-outs, technical variance, and redundancy of predictive variables. CellTrails enables the
reconstruction of branching trajectories and provides an intuitive graphical representation of expression
patterns along all branches simultaneously. It allows the user to define and infer the expression dynamics
of individual and multiple pathways towards distinct phenotypes.

Before ready to use, the CellTrails libraries must be loaded into the R environment:

library(CellTrails)

Please refer to https://dcellwanger.github.io/CellTrails-handbook/ for detailed information on
CellTrails’s features and how to utilize them.

1

