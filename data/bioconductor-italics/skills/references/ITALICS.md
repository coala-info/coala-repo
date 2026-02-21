ITALICS package : GeneChip Mapping 100K and 500K
Set Normalization

Guillem Rigaill a,b,c, Philippe Hupé a,b,c,d, Emmanuel Barillot a,b,c

October 30, 2025

a. Institut Curie, 26 rue d’Ulm, Paris, 75248 cedex 05, France
b. INSERM, U900, Paris, F-75248 France
c. Ecole des Mines de Paris, ParisTech, Fontainebleau, F-77300 France
d. CNRS UMR144, Paris, F-75248 France
italics@curie.fr
http://bioinfo.curie.fr

Contents

1 Overview

2 The ITALICS method

3 Normalization of Affymetrix GeneChip Human Mapping chips

3.1 How to run ITALICS . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
ITALICS options . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2
3.3 The profileCGH class . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Parameter tuning for ITALICS and sensitivity analysis to GLAD parameters

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.1 Tested parameters
4.2 Results and recommendations . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

References

1 Overview

1

1

3
3
4
6

7
7
7

9

This document presents an overview of the ITALICS package. This package is devoted to the nor-
malisation of GeneChip Mapping 100K and 500K Set (Kennedy et al., 2003) and implements the
methodology described in (Rigaill et al., 2008).

2 The ITALICS method

Affymetrix GeneChip Human Mapping 100K and 500K Set allows the DNA copy number mea-
surement of respectively 2× 50K and 2× 250K SNPs along the genome. Their high density allows
a precise localization of genomic alterations and makes them a powerful tool for cancer and copy
number polymorphism study. As any other microarray technology, it is influenced by non-relevant
sources of variation which need to be corrected. Moreover, the amplitude of variation induced by

1

the biologically relevant effect (i.e. the true copy number) and the non-relevant effects are simi-
lar, making it hard to correctly estimate the non-relevant effects without knowing the biologically
relevant effect.

To address this problem, we have developed ITALICS, a normalization method that estimates
both the biological and the non-relevant effects in an alternative and iterative way to accurately
remove the non-relevant effects. We have compared our normalization with other existing and
available methods (CNAT (Affymetrix Copy Number Analysis Tool), CNAG Nannya et al. (2005)
and GIM Komura et al. (2006)). Our results based on several in-house datasets and one public
dataset show that ITALICS outperforms these other methods (Rigaill et al., 2008).

Technology

Affymetrix GeneChip Human Mapping 100K: These chips allow the detection of DNA copy
number alterations with a 25 Kb resolution. Two Affymetrix GeneChip Human Mapping 50K
Set chips are available corresponding to the XbaI and HindIII restriction enzymes. HindIII and
XbaI chips share no SNPs in common and their combination provides the DNA copy number
of more than 115,000 SNPs.

Affymetrix GeneChip Human Mapping 500K: These chips allow the detection of DNA copy
number alterations with a 5 Kb resolution. Two Affymetrix GeneChip Human Mapping 250K
Set chips are available corresponding to the Sty and Nsp restriction enzymes. Sty and Nsp
chips share no SNPs in common and their combination provides the DNA copy number of
more than 500,000 SNPs.

Each allele of each SNP is represented by 10 perfect match (PM) probes and 10 mismatch (MM)
probes. Probes may be forward- or reverse-oriented and they may be centered on the SNP position
or offset by -4 to +4 base pairs. Therefore, all 10 PM probes of a SNP allele have a different DNA
sequence. Probes are grouped by four in probe quartets: a PM and a MM probe for allele A and a
PM and a MM probe for allele B. These four probes share the same orientation and offset.

The Affymetrix GeneChip Human Mapping assay is as follows. Genomic DNA is digested with
a restriction endonuclease: either XbaI , HindIII, Sty or Nsp. Adaptors are ligated to all fragments.
These fragments are amplified by PCR and then fragmented, biotin labeled and hybridized on the
chip.

Non-relevant sources of variation

ITALICS deals with known systematic sources of variation such as the GC-content of the QuartetsP M
(QGCij), the PCR amplified fragment length (F Li) and the GC-content of the PCR amplified frag-
ment (F GCi) (Nannya et al., 2005; Komura et al., 2006). It also takes into account what we call
the QuartetP M effect (Qij) and corresponds to the fact that some QuartetsP M systematically have
a small intensity while others tend to have a high intensity.

We also noticed that some Affymetrix GeneChip Human Mapping chips suffer from spatial

artifacts as it was already described by Neuvial et al. (2006) on array CGH data.

Therefore, in order to eliminate most of the non-relevant effects while preserving most of the
biological information, we propose an iterative and alternative estimation of the biological signal
and non-relevant effects to normalize the data. During each iteration, ITALICS:

1. estimates the biological signal CopyN bi using the GLAD algorithm (Hupé et al., 2004),

2. assuming the biological signal as known, it estimates the non-relevant effects N onRelij on raw

data using a multiple linear regression.

2

After the last iteration, QuartetsP M whose signal is poorly predicted by the multiple linear
regression are flagged out. These QuartetsP M correspond therefore to QuartetsP M with abnormal
values and are excluded from the final step where ITALICS estimates the biological effect CopyN bi
using GLAD on the remaining normalized QuartetsP M .

Estimation of the QuartetP M effect

The QuartetP M effect was calculated as the mean of each QuartetP M on the 64 female chips of the
Affymetrix reference data set (Matsuzaki et al., 2004).

3 Normalization of Affymetrix GeneChip Human Mapping chips

3.1 How to run ITALICS

To normalise a chip, you first need to load the chip. The ITALICS package reads a .CEL file. In the
following example, we will read the HF0844_Xba.CEL of a public data set (Kotliarov et al., 2006).

> ITALICSDataPATH <- attr(as.environment(match("package:ITALICSData",search())),"path")
> filename <- paste(ITALICSDataPATH,"/extdata/HF0844_Xba.CEL", sep="")
> headdetails <- readCelHeader(filename[1])
> pkgname <- cleanPlatformName(headdetails[["chiptype"]])
> quartetEffectFile <- paste(ITALICSDataPATH,"/extdata/Xba.QuartetEffect.csv", sep="")
> quartetEffect <- read.table(quartetEffectFile, sep=";", header=TRUE)

snpInfo <- getSnpInfo(pkgname)
quartet <- getQuartet(pkgname, snpInfo)
tmpExprs <- readCelIntensities(filename, indices=quartet$fid)
quartet$quartetInfo$quartetLogRatio <- readQuartetCopyNb(tmpExprs)
quartet$quartetInfo <- addInfo(quartet, quartetEffect)
snpInfo <- fromQuartetToSnp(cIntensity="quartetLogRatio",

quartetInfo=quartet$quartetInfo, snpInfo=snpInfo)

Now, you can use the ITALICS function as follows. By default, this will iterate ITALICS twice.
During each iteration, both the copy number and the non-relevant effects are estimated. After each
estimation of the non-relevant effects, observed quartet values are corrected. After the final iteration,
badly predicted quartets are flagged. Then the normalized genomic profile is analyzed using GLAD.

> profilSNPXba <- ITALICS(quartet$quartetInfo, snpInfo,
+

formule="Smoothing+QuartetEffect+FL+I(FL^2)+I(FL^3)+GC+I(GC^2)+I(GC^3)")

####### FIRST ROUND #######
[1] "Smoothing for each Chromosome"
[1] "Optimization of the Breakpoints and DNA copy number calling"
[1] "Check Breakpoints Position"
[1] "Results Preparation"
Bias Estimation
####### FINAL ROUND
[1] "Smoothing for each Chromosome"
[1] "Optimization of the Breakpoints and DNA copy number calling"
[1] "Check Breakpoints Position"
[1] "Results Preparation"

#######

3

Bias Estimation
Elimination of badly predicted probes
####### ANALYSIS #######
[1] "Smoothing for each Chromosome"
[1] "Optimization of the Breakpoints and DNA copy number calling"
[1] "Check Breakpoints Position"
[1] "Results Preparation"

>

The normalized and analyzed profile can then be seen using the plotProfile function from the GLAD
package.

> data(cytoband)
> plotProfile(profilSNPXba, Smoothing="Smoothing", cytoband=cytoband)

Figure 1: Result of the ITALICS methodology on the HF08444 Xba chip.

3.2

ITALICS options

confidence the prediction interval used to flag quartets. A quartet with a value outside this pre-

diction interval will be flagged.

iteration the number of ITALICS iteration.

formule a symbolic description of the term of the model. By default, it is : Smoothing + Quartet
+ FL + I(FL^2) + I(FL^3) + GC + I(GC^2) + I(GC^3) ). Smoothing corresponds to the
copy number estimation, Quartet to the quartet effect, FL to the PCR amplified fragment
length, GC to the quartet GC-content. For example if you don’t want to take into account

4

1p36.31p34.11p221q121q251q412p252p212p11.22q14.32q312q353p263p213p11.13q223q26.34p164p124q224q31.14q355p15.35p125q145q235q346p256p21.16q156q237p227p137q217q328p238q11.18q21.28q24.29p249p11.19q229q3410p1510q11.210q2311p1511p11.111q2112p1312q1312q2213p1313q1413q3114p1314q2114q3115p1315q1515q2516p13.316q11.216q2417p1317q2218p11.318q2119p13.319q13.220p1320q13.121p1322p1322q1323p22.323p11.323q2123q26−2−1012LogRatiothe PCR amplified fragment length effect, you should set formule to Smoothing + Quartet +
GC + I(GC^2) + I(GC^3)).

amplicon see the amplicon parameter in the daglad function

deletion see the deletion parameter in the daglad function

deltaN see the deltaN parameter in the daglad function

forceGL see the forceGL parameter in the daglad function

... other daglad function parameters

5

3.3 The profileCGH class

As in the GLAD package this class stores synthetic values related to each clone available onto the
arrayCGH. Objects profileCGH are composed of a list with the first element profileValues which is
a data.frame with the following columns names:

LogRatio Test over Reference log-ratio.

PosOrder The rank position of each clone on the genome.

PosBase The base position of each clone on the genome.

Chromosome Chromosome name.

Clone The name of the corresponding clone.

... Other elements can be added.

LogRatio, Chromosome and PosOrder are compulsory.
To create those objects you can use the function as.profileCGH.

6

4 Parameter tuning for ITALICS and sensitivity analysis to GLAD

parameters

4.1 Tested parameters

ITALICS uses the GLAD algorithm (Hupé et al. 2004) to estimate the biological signal (the DNA
copy number). Therefore, ITALICS is influenced by the choice of GLAD parameters. In GLAD,
the three important parameters for the segmentation process and therefore the biological signal
estimation are:

param: the penalty term used in the kernel function. Decreasing this parameter will lead to a higher
number of identified breakpoints. For arrays experiments with very small signal-to-noise ratio,
it is recommended to use a small value of param like "d = 2" or even less.

qlambda: the relative importance of geographical and statistical proximity in the segmentation pro-
cess. A higher qlambda will give more importance to the geographical proximity and therefore
will allow the detection of smaller DNA copy number alterations.

bandwidth: the number of iterations performed in the GLAD algorithm. The smaller the number of
iterations, the faster GLAD runs. However, with less iterations the quality of the segmentation
process is lower.

To test how these three parameters influence ITALICS, we randomly selected 50 Xba chips among
those that show DNA copy number alterations from the Kotliarov et al. (2006) dataset. We then
normalized those 50 chips using various sets of parameters and then compared the quality criteria
(see Rigaill et al. (2008), supplementary information)

4.2 Results and recommendations

Param, qlambda and bandwidth have very little influence on the quality criteria (see Rigaill et al.
(2008), supplementary information). Therefore the quality criteria are not sensitive to GLAD pa-
rameters. Nevertheless, it is important to point out the fact that the number of breakpoints is
influenced by the param value: as can be seen on figure 2, the number of detected breakpoints by
chip is a decreasing function of param. Qlambda and bandwidth do not influence the number of
breakpoints (data not shown). Thus, param does not impact the overall dynamic of the signal but
a smaller param will allow the detection of more alterations. For SNP chips with low signal-to-
noise ratio, we therefore recommend to set param to 2 or 1. Setting param to smaller values would
drastically increase the number of false positive alterations detected.

Here are the default parameters we use:

ITALICS(confidence=0.95, iteration=2,
amplicon=2.1, deletion=-3.5, deltaN=0.15, forceGL=c(-0.2,0.2))

param=c(d=2), nbsigma=1,

7

Figure 2: Centered number of breakpoints (i.e. number of breakpoints minus the mean number of
breakpoints over the 48 combinations by chip) detected as a function of the param value. We can
see that the number of detected breakpoints is a decreasing function of param. Therefore a smaller
param allow the detection of smaller alterations.

8

References

Hupé, P., Stransky, N., Thiery, J. P., Radvanyi, F., and Barillot, E. (2004). Analysis of array CGH

data: from signal ratio to gain and loss of DNA regions. Bioinformatics, 20:3413–3422.

Kennedy, G. C., Matsuzaki, H., Dong, S., Liu, W. M., Huang, J., Liu, G., Su, X., Cao, M., Chen, W.,
Zhang, J., Liu, W., Yang, G., Di, X., Ryder, T., He, Z., Surti, U., Phillips, M. S., Boyce-Jacino,
M. T., Fodor, S. P., and WJones, K. (2003). Large-scale genotyping of complex DNA. Nature
biotechnology., 21:1233–7.

Komura, D., Nishimura, K., Ishikawa, S., Panda, B., Huang, J., Nakamura, H., Ihara, S., Hirose,
M., Jones, K. W., and Aburatani, H. (2006). Noise reduction from genotyping microarrays using
probe level information. In Silico Biol, 6:79–92.

Kotliarov, Y., Steed, M. E., Christopher, N., Walling, J., Su, Q., Center, A., Heiss, J., Rosenblum,
M., Mikkelsen, T., Zenklusen, J. C., and Fine, H. A. (2006). High-resolution Global Genomic
Survey of 178 Gliomas Reveals Novel Regions of Copy Number Alteration and Allelic Imbalances.
Cancer Res, 66:9428–9436.

Matsuzaki, H., Dong, S., Loi, H., Di, X., Liu, G., Hubbell, E., Law, J., Berntsen, T., Chadha, M.,
Hui, H., Yang, G., Kennedy, G. C., Webster, T. A., Cawley, S., Walsh, P. S., Jones, K. W., Fodor,
S. P. A., and Mei, R. (2004). Genotyping over 100,000 SNPs on a pair of oligonucleotide arrays.
Nature Methods., 1(4):109–111.

Nannya, Y., Sanada, M., Nakazaki, K., Hosoya, N., Wang, L., Hangaishi, A., Kurokawa, M., Chiba,
S., Bailey, D. K., Kennedy, G. C., and Ogawa, S. (2005). A robust algorithm for copy number
detection using high-density oligonucleotide single nucleotide polymorphism genotyping arrays.
Cancer research., 65:6071–9.

Neuvial, P., Hupé, P., Brito, I., Liva, S., Manie, E., Brennetot, C., Radvanyi, F., Aurias, A., and

Barillot, E. (2006). Spatial normalization of array-CGH data. BMC Bioinformatics., 7:264.

Rigaill, G., Hupé, P., Almeida, A., Rosa, P. L., Meyniel, J., Decraenes, C., and Barillot, E. (2008).
ITALICS: an algorithm for normalization and DNA copy number calling for Affymetrix SNP
arrays. Bioinformatics.

9

