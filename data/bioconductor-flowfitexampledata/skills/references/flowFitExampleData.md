Example data for use with the ﬂowFit package

Davide Rambaldi

November 1, 2018

Contents

1 Data Introduction

2 Loading the data

3 Data creation

1 Data Introduction

1

1

2

This package provides two lightweight datasets for those wishing to try out the examples
within the ﬂowFIt package.

The package contains two datasets:

1. PKH26data

2. QuahAndParish

2 Loading the data

The example datasets can be loaded using the data function.

> library(flowFitExampleData)
> data(PKH26data)
> PKH26data

1

A flowSet with 2 experiments.

An object of class

AnnotatedDataFrame

rowNames: NONPROL.FCS PROL.FCS
varLabels: PatientID GroupID ... name (6 total)
varMetadata: labelDescription

column names:
FSC-Height SSC-Height FL1-Height LOG FL2-Height LOG

> data(QuahAndParish)
> QuahAndParish

A flowSet with 4 experiments.

An object of class

AnnotatedDataFrame

’

’

’

’

rowNames: Fig 2a All CD4 T Nonstim.fcs Fig 2a CFSE CD4 T
Stim.fcs Fig 2a CPD CD4 T Stim.fcs Fig 2a CTV CD4 T
Stim.fcs

varLabels: Filename SampleType Stain CellType
varMetadata: labelDescription

column names:
FSC-A FSC-H FSC-W SSC-A SSC-H SSC-W <FITC-A> <PE-A> <PE-Cy5-A> <Alexa Fluor 405-A> <Alexa Fluor 430-A> <APC-A> <APC-Cy7-A>

>

3 Data creation

The following commands were used to create the QuahAndParish data included with
this package.

> require(flowCore)
> flowData <- read.flowSet(path = ".", phenoData = "annotationfig2.txt", transformation=FALSE)
> wf <- workFlow(flowData, name = "FACSCANTO LOG workflow")
> trunTrans <- truncateTransform(transformationId="truncate", a=1)
> tr <- transformList(c("<FITC-A>","<PE-A>", "<PE-Cy5-A>", "<Alexa Fluor 405-A>", "<Alexa Fluor 430-A>", "<APC-A>", "<APC-Cy7-A>"), trunTrans, transformationId = "truncate")
> add(wf,tr)
> logTrans <- logTransform(transformationId="log10-transformation", logbase=10, r=1, d=1)

2

> tf <- transformList(c("<FITC-A>","<PE-A>", "<PE-Cy5-A>", "<Alexa Fluor 405-A>", "<Alexa Fluor 430-A>", "<APC-A>", "<APC-Cy7-A>"), logTrans, transformationId = "log")
> add(wf, tf, parent="truncate")
> mDataLog <- Data(wf[["log"]])
>

3

