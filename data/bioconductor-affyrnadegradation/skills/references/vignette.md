The AffyRNADegradation Package

Mario Fasold

October 29, 2025

Affymetrix 3’ expression arrays employ a specific experimental protocol and
a specific probe design that allows assessment of RNA integrity based on probe
signal data. Problems of RNA integrity are primarily governed to the degra-
dation of the target transcripts. We have shown in Fasold and Binder (2012)
that

(i) degradation leads to a probe positional bias that needs to be corrected in
order to compare expression of samples with varying degree of degradation,
and

(ii) it is possible to estimate a robust and accurate measure of RNA integrity
from the probe signals that, for example, can be used to study degradation
within the large number of available microarray data.

The rationale and further analysis are described in the accompanying publica-
tion by Fasold and Binder. We here show how to utilize this package for both
problems.

1 Basic RNA Degradation Analysis

We here show how to use the package for the analysis of RNA degradation. Let
us first load exemplar data provided by the AmpAffyExample package into the
environment.

> library(AffyRNADegradation)
> library(AmpAffyExample)
> data(AmpData)
> AmpData

AffyBatch object
size of arrays=712x712 features (22 kb)
cdf=HG-U133A (22283 affyids)
number of samples=6
number of genes=22283
annotation=hgu133a
notes=

1

Figure 1: The tongs plot shows that the intensity difference between 3’ and
5’ probes increases with Σ = ⟨log I⟩. ⟨⟩ here denotes either averaging over all
probes within the probeset, or averaging over the 3’ or 5’ subset of probes in
Σsubset.

Every transcript is measured by a set of 11-16 probes. The log-average
intensity difference between probes located closer to the 3’ end of the target
transcripts and those located further away constitutes the probe positional bias.
It can be visualized using the tongs plot.

> tongs <- GetTongs(AmpData, chip.idx = 4)
> PlotTongs(tongs)

Figure 1 shows that the bias relates to the expression level of the transcripts.
As this can vary from sample to sample, it must be considered in estimating of
RNA degradation.

The function RNADegradation performs the basal analysis of RNA degrada-
tion based on raw probe intensities stored in an AffyBatch object. The result is
an AffyDegradationBatch object that contains the corrected probe intensities
as well as several statistical parameters.

> rna.deg <- RNADegradation(AmpData, location.type = "index")

2

2.02.22.42.62.83.03.2−0.3−0.2−0.10.00.10.20.3Tongs plotSSsubset-S5' subset3' subsetFigure 2: Probe degradation plot. The points show the average probe intensity
of expressed genes for each index x = 1, ..11 relative to the average intensity at
position x = 1. The lines are a fitted decay function.

We can visualize the probe positional bias using the PlotDx function.

> plotDx(rna.deg)

Figure 2 shows the results. Different degradation between different samples are
observed.

To access the parameter d, which provides a robust, sample-wise measure

for the degree of RNA degradation, one can use the function

5_Std_TB_75-6 13r_Amp_TB_75-6 14_Amp_TB_75-6
0.4462438

0.6129885

0.3804619

> d(rna.deg)

1_Std_TB_75-6
0.6161481
17_Amp_TB_75-6
0.3710109

2_Std_TB_75-6
0.6339041

3

2468100.20.40.60.81.01.2xD(x)1_Std_TB_75−62_Std_TB_75−65_Std_TB_75−613r_Amp_TB_75−614_Amp_TB_75−617_Amp_TB_75−62 Using Absolute Probe Locations

Instead of using the probe index within the probeset as argument of the degra-
dation degree, one can use the actual probe locations within the transcript.
We have pre-computed the distance of each probe to the 3’ end of its target
transcript for all Affymetrix 3’ expression arrays. These probe location files
are available under the URL http://www.izbi.uni-leipzig.de/downloads_
links/programs/rna_integrity.php.

In order to perform the analysis and correction using absolute probe loca-
tions, one must first download the probe location file for the used chip type.
You can then start the analysis using RNADegradation, as above, but selecting
absolute as location.type. The parameter location.file.dir must specify
the download directory of the probe location file.

3 Creating Custom Probe Location Files

It is possible to use custom probe locations, for example if one wishes to analyze
custom built microarrays or if one relies on alternative probe annotations. For
this, one has to create a probe location file similar to the pre-built ones used in
the previous section.

Here is how to generate such a file. First, create a data frame with the name
probeDists containing the five columns Probe.Set.Name, Probe.X, Probe.Y,
Probe.Distance and Target.Length. Probe.Set.Name is of class character
and contains the Affymetrix probe set id. The remaining variables are of class
integer.

Probe.X and Probe.Y denote the coordinates of the probe on the microarray.
These are important because the coordinates are used to map the probes to the
AffyBatch object using the xy2indices function from the affy package. This
implies that the ordering of the table rows can be of any kind. It is however
important that this information can be mapped to every probe pair in the
AffyBatch intensity array (as for example shown in the affy::pm function).

Probe.Distance contains the probe location: the number of nucleotides
counted between the designated 3’-end of the transcript and the first (i.e. near-
est) base of the 25meric probe sequence. The last column Target.Length con-
tains the length of the target in base bairs - it is not used in this package and can
be set to any value. The following table shows an example of the probeDists
data frame:

Probe.Set.Name Probe.X Probe.Y Probe.Distance Target.Length
3938
181
1007_s_at
3938
299
1007_s_at
3938
557
1007_s_at
..
...
...

608
495
426
...

467
531
86
...

1
2
3
...

4

This table is then stored in an R binary object file. The filename must be
set to the chip type identifier as given by the affy::cdfName function with the
file ending .Rd:

> filename = paste(cdfName(AmpData), ".Rd", sep="")
> save(probeDists, file = filename)

To use the custom probe locations, start the analysis using RNADegradation,
as above with location.type=absolute and location.file.dir set to the
directory containing the custom probe location file.

4 Correction of the Bias and Integration into the

Microarray Calibration Pipeline

The correction of the probe positional bias is performed within the AffyRNA-
Degradation function. The result is a new AffyBatch object with corrected
probe level intensities. It can be accessed using the afbatch function

> afbatch(rna.deg)

It is possible to replace the original raw data with this data corrected for probe
positional bias, before performing further microarray normalization and sum-
marization (e.g. using RMA).

Alternatively, the correction can be performed after probe-level normaliza-
tion. The following example shows how to first apply the VSN normalization
method, then correct for probe positional bias to finally get summarized expres-
sion measures

> library(vsn)
> affydata.vsn <- do.call(affy:::normalize, c(alist(AmpData, "vsn"), NULL))
> affydata.vsn <- afbatch(RNADegradation(affydata.vsn))
> expr <- computeExprSet(affydata.vsn, summary.method="medianpolish", pmcorrect.method="pmonly")

5 Citing AffyRNADegradation

Please cite (Fasold and Binder, 2013) when using the package.

6 Details

This document was written using:

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu

5

Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats

graphics

grDevices utils

datasets

methods

base

other attached packages:
[1] hgu133acdf_2.18.0
[3] AffyRNADegradation_1.56.0 affy_1.88.0
[5] Biobase_2.70.0
[7] generics_0.1.4

BiocGenerics_0.56.0

AmpAffyExample_1.49.0

loaded via a namespace (and not attached):

[1] crayon_1.5.3
[4] cli_3.6.5
[7] png_0.1-8

vctrs_0.6.5
rlang_1.1.6
bit_4.6.0
stats4_4.5.1
fastmap_1.2.0
BiocManager_1.30.26

[10] Biostrings_2.78.0
[13] Seqinfo_1.0.0
[16] memoise_2.0.1
[19] preprocessCore_1.72.0 RSQLite_2.4.3
[22] XVector_0.50.0
[25] tools_4.5.1
[28] affyio_1.80.0

R6_2.6.1
bit64_4.6.0-1

httr_1.4.7
DBI_1.2.3
S4Vectors_0.48.0
KEGGREST_1.50.0
IRanges_2.44.0
compiler_4.5.1
blob_1.2.4
AnnotationDbi_1.72.0
cachem_1.1.0

References

Mario Fasold and Hans Binder. Estimating RNA-quality using GeneChip mi-

croarrays. BMC Genomics, 13:186, 2012.

Mario Fasold and Hans Binder. AffyRNADegradation: Control and correc-
tion of RNA quality effects in GeneChip expression data. Bioinformat-

6

ics, 29(1):129–131, 2013. doi: 10.1093/bioinformatics/bts629. URL http:
//bioinformatics.oxfordjournals.org/content/29/1/129.abstract.

7

