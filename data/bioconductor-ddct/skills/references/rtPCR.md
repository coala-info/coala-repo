ddCt method for qRT–PCR data analysis

Jitao David Zhang, Markus Ruschhaupt and Rudolf Biczok

October 29, 2025

Abstract

Here we describe the 2−∆∆CT algorithm implemented in the ddCt package. The package
is designed for the data analysis of quantitative real–time PCR (qRT–PCR) experiemtns in
Bioconductor. With the ddCt package, one can acquire the relative expression of the target
gene in different samples. This vignette mainly dicusses the principles of the ddCt algorithm
and demonstrates the functionality of the package with a compact example. Another vignette
in the package, rtPCR-usage, gives instructions to call the script for end–to–end analysis.

Both absolute and relative quantification have been used to analyse the data from the quantita-
tive real–time PCR (qRT–PCR, or RT–PCR for short) experiments. The 2−∆∆CT algorithm, also
known as the the delta-delta-Ct or ddCt algorithm, is a convenient method to analyze the relative
changes in gene expression [2]. It requires the assignment of one or more housekeeping genes,
which are assumed to be uniformly and constantly expressed in all samples, as well as one or
more reference samples. The expression of other samples is then compared to that in the reference
sample1.

1 RT–PCR

[1] and [5]. There are many
Rich background knowledge about RT–PCR can be found at [3],
variations in the experimental processes. Here we shortly summarize the general key steps in the
TaqMan®assay to help the understanding of following discussions.

1. RNA preparation: total or specific type of RNA are extracted from cell lines, tissues, biop-

sies, etc.

2. RNA is Reversed Transcribed into DNA, which is also known as the RT-reaction.

3. qPCR probes (sometimes also known as ’primers’) are added to the transcribed cDNA sam-
ple and the polymerase chain reaction takes place. This probe is an oligonucleotide with a

1The qpcrNorm package in the Bioconductor repository introduces the data–driven normalization method for high–
throughput qPCR data, which does not depend on the house–keeping genes but makes extra assumptions. See the help
pages and the vignette of the qpcrNorm package for further information

1

reporter dye attached to the 5’ end and a quencher dye attached to the 3’ end. Till the time
the probe is not hydrolized, the quencher and the fluorophore remain in proximity to each
other, which does not completely quench the flourescence of the reporter dye and therefore
only a background flourescence is observed.

4. During PCR, the probe anneals specifically between the forward and reverse primer to an
internal region of the PCR product. The polymerase then carries out the extension of the
primer and replicates the template to which the TaqMan®is bound. The 5’ exonuclease
activity of the polymerase cleaves the probe, releasing the reporter molecule away from the
close vicinity of the quencher. The fluorescence intensity of the reporter dye, as a result
increases. This process repeats in every cycle.

5. As the cycle number increases, the detected fluorescence also increases. And when the
fluorescence crosses an arbitrary line, the device recodes the cycle number until then, which
is known as the CT value.

In princple one could also report the CT values of the housekeeping gene and the sample gene(s)
in the form of barplots to show their relative relation. However, this has two main drawbacks:

• This is only applicable in cases where more than one genes are compared in the same sam-
ple. In case of mutilple samples one has to calculate the relative expression to a specified
reference sample

• CT value is exponential. In case of a ideal amplification efficiency of 1, increase of the CT
value by 1 indicates a two–fold expression. Therefore, it maybe misleading to illustrate the
expression with the raw CT value.

2 The ddCt Algorithm

The ddCt method was one of the first methods used to to calculate real–time PCR results. Different
the standard curve [3] and the Pfaffl method [4], ddCt is an approximation method and makes
various assumptions. However, it reduces lot of experiment effort by making these assumptions and
is easy to implement, and in many cases they return results similarly to other non-approximation
methods [2].

2.1 Deviation

The exponential amplification of the polymerase chain reaction (PCR) can be described by the
equation 1.

Xn = X0 × (1 + EX )n

(1)

where Xn is the number of target molecules at cycle n of the reaction, and X0 is the number of
target molecules initially. Ex is the amplification efficiency of target amplification, and n is the

2

number of cycles. The threshold value (CT ) records the fractional cycle number at which the
fluorescence reaches a fixed threshold (see section 1). Therefore

XT = X0 × (1 + EX )CT,X = KX

(2)

where XT is the threshold number of target molecules, CT,X is the readout CT value, and KX
is a constant. Similarly we can express the equation 2 for the endogenous reference gene (house-
keeping genes) as

RT = R0 × (1 + ER)CT,R = KR

(3)

where RT is the threshold number of the reference molecules, R0 is the initial number of reference
molecules. ER is the efficiency of reference amplification, CT,R is the CT readout for the reference,
and KR is a constant.

Combining equation 2 and 3 we get

XT
RT

=

X0 × (1 + EX )CT,X
R0 × (1 + ER)CT,R

=

KX
KR

= K

(4)

For qRT–PCR using TaqMan®probes, the exact values of XT and RT depend on several factors
including the chemistry of reporter dye, the sequence context effects on the fluorescence properties
of the probe, the fficiency of probe cleavage, purity of the probe, and the setting of the fluorescence
threshold [2]. Therefor, the constant K does not have to be equal to one.
Assuming efficiencies of the target and the reference are the same,

or

EX = ER = E
× (1 + E)CT,X −CT,R = K

X0
R0

XN × (1 + E)∆CT = K

(5)

(6)

where XN is equal to the normalized amount of target (X0/R0) and the dCT is equal to the differ-
ence in the CT for target and reference (CT,X − CT,R).

Equation 6 can be rearranged as

XN = K × (1 + E)−∆CT

(7)

The final step is to divide the XN in the equation 7 for any sample q by the reference sample

(also known as the calibrator, cb):

XN,q
XN,cb

=

K × (1 + E)−∆CT,q
K × (1 + E)−∆CT,cb

= (1 + E)−∆∆CT

(8)

Here −∆∆CT = −(∆CT,q − ∆CT,cb).

3

For amplicons designed to be less than 150 basepairs and for which the primer and M g2+
concentration have been optimized, the efficiency E is close to one. Therefore, the amount of
target, normalized to the endogenous reference and relative to a reference sample, is given by

amount of target = 2−∆∆CT

(9)

Attention: Note that for the ddCT calculation to be valid, the amplification efficiencies of the

target and reference must be approximately equal.

3 Application example

Here we show how to use the ddCt package by a short example.

3.1 File I/O setup

We have attached two SDS output files, ’Experiment1.txt’ and ’Experiment2.txt’, in the package
directory. The sample annotation information is also provided as the tab-delimited text file ’sam-
pleData.txt’. Any warning information (for example Undetermined in reference sample) is saved
as a text file specified by the parameter ’warningFile’.

> library(Biobase)
> library(lattice)
> library(RColorBrewer)
> library(ddCt)
> datadir <- function(x) system.file("extdata", x, package="ddCt")
> savedir <- function(x) file.path(tempdir(), x)
> file.names <- c(datadir("Experiment1.txt"),datadir("Experiment2.txt"))
> info <- datadir("sampleData.txt")
> warningFile <- savedir("warnings.txt")

3.2 Reference sample and housekeeping gene

For the sake of simplicity, we choose Sample1 and Sample2 as reference samples (calibrators), and
Gene2 as the reference gene (housekeeping gene) respectively. This could happen, for example, if
the Sample1 and Sample2 are untreated samples while the Sample3 has been treated with certain
drugs. And Gene2 is a housekeeping gene which we assume is expressed constantly in all the
samples.

> name.reference.sample <- c("Sample1", "Sample2")
> name.reference.gene <- c("Gene2")

Note that more than one reference sample or renference gene can be specified.

4

3.3 Read in data

SDMFrame function is called to read in experiment data.Optionally one could also read in the
sample annotation, which is the sampleInformation object in the example.

> library(Biobase)
> CtData <- SDMFrame(file.names)
> sampleInformation <- read.AnnotatedDataFrame(info,header=TRUE, row.names=NULL)

Note that SDMFrame is able to accept one or more files as input.

3.4 Apply the ddCt method

Next step we call ddCtExpression to perform ddCt method on the data.

> result <- ddCtExpression(CtData,
+
+
+
+

calibrationSample=name.reference.sample,
housekeepingGene=name.reference.gene,
sampleInformation=sampleInformation,
warningStream=warningFile)

Please refer to the help page of ddCtExpression-class for the methods to access all the
values calculated by the ddCt method. For example the error (either standard deviation or median
absolute deviation) of all replicates are accessible through

> CtErr(result)

Sample

Detector

Sample1

Sample3
Gene1 0.72107613 0.1657458 0.45246203
Gene2 0.06299529 0.0954406 0.03288257
Gene3 0.44017062 0.6452858 0.17610413

Sample2

Sample

Detector

Sample4
Gene1 0.05064879
Gene2 0.03057597
NA
Gene3

3.5 Visualization

errBarchart provides a simple way to visualize the experiment results with the modified
barchart from the lattice package, as seen in the figure 1

5

> br <- errBarchart(result)
> print(br)

Figure 1: Barchart with error bars to visualize the expression fold change of target genes in samples.
Each panel represents one target gene (Gene 1, 2 and 3 in this case), and the expression level in
each sample is indicated by the height of bars. If one gene is not detected in one sample, a ’NA’
symbol in grey will appear in the position of the bar (Gene3 in Sample4), which helps to differ
from the situations where the expression is very low but not yet undetectable (for instance Gene3
in Sample3). See the help page of errBarchart for more details.

6

SampleExpression fold change0.00.51.01.52.02.53.0Sample1Sample2Sample3Sample48–2Gene1Sample1Sample2Sample3Sample4Gene20.00.51.01.52.02.53.0NDGene33.6 Write result to text file

Finally we can save the results as tab-delimited text files.

> elistWrite(result,file=savedir("allValues.txt"))

4 Acknowledgement

We thank Florian Hahne, Wolfgang Huber, Andreas Buness and Stefan Wiemann for their sug-
gestion and comments during the development of the package. The example data has been kindly
provided by Ute Ernst and was produced in the Division of Molecular Genome Analysis, DKFZ
Heidelberg, Germany.

7

5 Session Info

The script has been running in the following session:

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: Biobase 2.70.0, BiocGenerics 0.56.0, RColorBrewer 1.1-3, ddCt 1.66.0,

generics 0.1.4, lattice 0.22-7

• Loaded via a namespace (and not attached): compiler 4.5.1, grid 4.5.1, tools 4.5.1,

xtable 1.8-4

References

[1] Applied Biosystems. RT-PCR: The basics. http://www.ambion.com/techlib/

basics/rtpcr/index.html.

[2] Kenneth J. Livak and Thomas D. Schmittgen. Analysis of Relative Gene Expression Data
Using Real-Time Quantitative PCR and the 2-[Delta][Delta]CT Method. Methods, 25(4):402
– 408, 2001.

[3] Hunt Margaret. Microbiology and immunology online, university of south carolina, school of

medicine. http://pathmicro.med.sc.edu/pcr/realtime-home.htm.

[4] Michael W. Pfaffl. A new mathematical model for relative quantification real–time PCR. Nu-

cleic Acids Research, 29(9):2002 – 2007, 2001.

[5] Roche. Taqman principles. http://www.med.unc.edu/anclinic/Tm.htm.

8

