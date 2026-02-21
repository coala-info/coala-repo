The PDNN model for the aﬀy package

Laurent Gautier

April 24, 2017

1

Introduction

This package is our implementation of the PDNN model[?]. Whenever you use it, you can
aknowledge it by quoting our published work:

> citation(package="affypdnn")

Nielsen HB, Gautier L, Knudsen S. Implementation of a gene expression
index calculation method based on the PDNN model. Bioinformatics.
2005 Mar 1;21(5):687-8. PMID: 15509605

A BibTeX entry for LaTeX users is

@Article{,

author = {Henrik Bjorn Nielsen and Laurent Gautier and Steen Knudsen},
title = {Implementation of a gene expression index calculation method based on the PDNN model.},
journal = {Bioinformatics},
volume = {21},
number = {5},
year = {2005},
pages = {687--688},
publisher = {Oxford University Press},
address = {Oxford, UK},

}

This package is also brieﬂy described in Chapter ‘Preprocessing High-density Oligonu-

cleotide Arrays’ of the Bioconductor book.

The ﬁrst thing to do is to attach the package to the current R session.

> library(affypdnn)

Upon executing this command, the package and its dependencies will be attached (which

will cause few lines of text to appear on the console for your R session).

Throughout this presentation of the package, we will use ‘Dilution’ dataset. The reader

can replace it with an arbitrary instance of class AﬀyBatch.

1

> library(affydata)

Package

LibPath

Item

[1,] "affydata" "/home/biocbuild/bbs-3.5-bioc/R/library" "Dilution"

Title

[1,] "AffyBatch instance Dilution"

> data(Dilution)
> afbatch <- Dilution

We decomposed the model of Zhang et al. in such a way that it ﬁts the simple framework

for probe-level data processing implemented in the aﬀy package:

1. Chip type-speciﬁc parameters are computed

2. Experiment-speciﬁc parameters are computed

3. Transform the PM probe signal using the PDNN model (two ﬂavours:

‘pdnn’ and

‘pdnnpredict’).

4. Compute probeset-level expression indexes

2 Chip type-speciﬁc parameters

Chip type-speciﬁc parameters for U95Av2 are included with the package, mostly to make some
examples shorter to run:

> data(hgu95av2.pdnn.params)
> params.chiptype <- hgu95av2.pdnn.params

Here we are showing how to compute them.
Currently one needs an external data ﬁle, called ‘energy data ﬁle’. This ﬁle contains
parameters for all possible 16 dinucleotides (Eg and En), as well as other parameters (Wg and
Wn).

These ﬁles were downloaded, and there is currently no implementation to compute these

data in this R package. The ﬁles included within the package are:

> dir(system.file("exampleData", package="affypdnn"))

[1] "pdnn-energy-parameter_hg-u133a.txt" "pdnn-energy-parameter_hg-u95av2.txt"
[3] "pdnn-energy-parameter_mg-u74av2.txt"

The Dilution dataset is of chip-type HGU95Av2. We read the ‘energy data ﬁle’, then

compute the parameters (note that the probe package is needed):

energy.file <- system.file("exampleData",

"pdnn-energy-parameter_hg-u95av2.txt",
package = "affypdnn")

params.chiptype <- pdnn.params.chiptype(energy.file,

probes.pack = "hgu95av2probe")

2

3 Experiment-speciﬁc parameters

Parameters speciﬁc to an experiement, that is the probe-level values in a CEL ﬁle, can be
computed easily:

params <- find.params.pdnn(afbatch, hgu95av2.pdnn.params)

4 Transform the PM probe-level signal

Here we arbitrarily pick two probesets:

> ppset.name <- c("41206_r_at", "31620_at")
> ppset <- probeset(afbatch, ppset.name)

Computing the transformed the PM probe-level signals is then just a matter of calling one

of the functions:

(cid:136) pmcorrect.pdnnpredict

(cid:136) pmcorrect.pdnn

probes.pdnn <- pmcorrect.pdnnpredict(ppset[[i]], params,

params.chiptype = params.chiptype)

plot(ppset[[i]], main=paste(ppset.name[i], "\n(raw intensities)"))
matplotProbesPDNN(probes.pdnn,

> par(mfrow=c(2,2))
> for (i in 1:2) {
+
+
+
+
+
+
+
+ }

main = paste(ppset.name[i],

"\n(predicted intensities)"))

3

5 expressopdnn

Processing probe-level data can be done by using a modiﬁed1 version of the function expresso
in the aﬀy package.

Like its aﬀy counterpart, expressopdnn is a simple wrapper around a sequence of prepro-
cessing steps. The example below shows a typical usage of it; the documentation page can be
referred to for an exhaustive description of the parameters it accepts.

Here we take only ten probesets:

> ids <- ls(getCdfInfo(afbatch))[1:10]
> eset <- expressopdnn(afbatch,
+
+
+
+
+

give.warnings=FALSE),

summary.subset=ids)

bg.correct = FALSE,
normalize = FALSE,
findparams.param = list(params.chiptype = params.chiptype,

1The design of the function expresso showed its limitations with the requirements for this one package, and

a slightly modiﬁed version had to be written.

4

5101501000300041206_r_at (raw intensities)probesf(x)51015200060001000041206_r_at (predicted intensities)x51015200600100031620_at (raw intensities)probesf(x)5101501000250031620_at (predicted intensities)xllllPM/MM correction : pdnn
expression values: pdnn
initializing data structure...done.
dealing with CEL 1 :

step 1...done.
step 2...done.

dealing with CEL 2 :

step 1...done.
step 2...done.

dealing with CEL 3 :

step 1...done.
step 2...done.

dealing with CEL 4 :

step 1...done.
step 2...done.

10 ids to be processed
|
|
|####################|

One can note that we leave background correction and normalization aside, but it is obviously
possible to mix-and-match with any such method available.

5

