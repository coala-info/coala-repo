healthyFlowData: A healthy dataset with 20
flow cytometry samples used by the flowMatch
package

Ariful Azad

November 4, 2025

aazad@purdue.edu

Contents

1 Data Introduction

2 Loading the data

1 Data Introduction

1

1

This package provides a lightweight dataset for those wishing to try out the
examples within the flowFIt package.

Peripheral blood mononuclear cells (PBMC) were collected from four healthy
individuals. Each sample was divided five repplicates and each replicate was
stained using labeled antibodies against CD3, CD4, CD8, and CD19 protein
markers. Therefore we have total 20 samples from four healthy subjects. Each
sample was compensated and transformed in order to stabilize per-channel vari-
ance. Each sample is then gated on the forward and side scatter to identify
lymphocites. Hence the samples contain only lymphocites cells.

This is a part of a larger dataset consisting of 65 samples. Please ask the

author if you would like to obtain the complete dataset.

2 Loading the data

The healthy donor (HD) dataset can be loaded using the data function.

> library(healthyFlowData)
> data(hd)
> hd.flowSet

1

A flowSet with 20 experiments.

An object of class 'AnnotatedDataFrame'
rowNames: A_1 A_2 ... D_5 (20 total)
varLabels: subject replicate Name
varMetadata: labelDescription

column names(4): CD4 CD8 CD3 CD19

>

2

