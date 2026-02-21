FocalCall: An R package for the
annotation of focal copy number
aberrations.

Oscar Krijgsman

October 30, 2017

Department of Pathology VU University Medical Center the Netherlands
Current adres: Department of Molecular Oncology Netherlands Cancer
Institute the Netherlands

oscarkrijgsman@gmail.com o.krijgsman@nki.nl

Contents

1 Overview

2 Example

3 Session Information

1 Overview

1

2

7

To identify somatic focal copy number aberrations (CNAs) in cancer speci-
mens and distinguish them from germ-line copy number variations (CNVs)
we developed a software package named, focalCall. focalCall permits user-
deﬁned size cut-oﬀs to recognize focal aberrations and builds on established
array CGH segmentation and calling algorithms. To diﬀerentiate CNAs
from CNVs the algorithm can either make use of a matched normal ref-
erence signal or, if this is not available, an external CNV track.
focalCall
furthermore diﬀerentiates between homozygous and hemizygous deletions as
well as gains and ampliﬁcations and is applicable to high-resolution array
and sequencing data.

1

2 Example

In this section we will use focalCall to analyse the dataset previously pub-
lished by (Bierkens et al., 2013) Bierkens et al. (2013) and preprocessed
using (van de Wiel et al., 2007) by Wiel et al. (2007). The example set used
here only contains complete chromosome 2. For the other chromosomes only
a small portion of the CGH probes are included. The complete dataset can
be downloaded from the NCBI Gene Expression Omnibus (GEO), accession
number GSE34575. First, we load the required packages and the data:

> library(focalCall)
> data(BierkensCNA)

Next, we apply the focalCall function which:

(cid:136) detects all aberrations smaller than focalSize in Mb in the tumor

data (CGHset)

(cid:136) calculates peak regions for each genomic region where recurrent focal

CNAs are detected

(cid:136) compare each peak region to known copy number variants (CNVset)

(cid:136) returns calls object with calls for focal CNA included

(cid:136) report all focal CNAs as ﬁgures and tables

> calls_focals<-focalCall(CGHset, CNVset, focalSize = 3, minFreq=2)

Array resolution too low for calling aberrations smaller than 3MB.
Counted number of segments for each tumor sample
Generated matrix with detected aberrations < 3 Mb...
Start detection of peak regions...
Simple_ 1
Complex_ 2
Complex_ 3
Complex_ 4
Matching CNV list to copynumber data ...
Generating output files...
Written text file to workDir...
Written
FINISHED!
Total time: 0 minutes

focalCall.RData

to workDir...

’

’

2

A frequency plot of all aberrations and all focal aberrations can be generated
using FreqPlot and FreqPlotfocal.

> FreqPlot(calls_focals, header="FrequencyPlot all aberrations")

> FreqPlotfocal(calls_focals, header="FrequencyPlot all aberrations")

n

3

−100−50050100FrequencyPlot all aberrationsChromosomeFrequency (Percentage)12345678910111213141516171819202122234

−100−50050100FrequencyPlot all aberrationsChromosomeFrequency (Percentage)1234567891011121314151617181920212223Alternatively, we can generate ﬁles for visualisation in IGV with igvFiles.
The ﬁles will be written to the home directory and can be loaded in IGV
directly.

> igvFiles(calls_focals)

Generated .SEG file for loading in IGV
Generated .IGV file for loading in IGV
Generated .IGV file for loading in IGV

5

References

Bierkens, M., Krijgsman, O., Wilting, S., Bosch, L., Jaspers, A., Meijer,
G., Meijer, C., Snijders, P., Ylstra, B., and RD., S. (2013). Focal aberra-
tions indicate eya2 and hsa-mir-375 as oncogene and tumor suppressor in
cervical carcinogenesis. Genes Chromosomes Cancer, 52:56–68.

van de Wiel, M. A., Kim, K. I., Vosse, S. J., van Wieringen, W. N., Wilting,
S. M., and Ylstra, B. (2007). Calling aberrations for array CGH tumor
proﬁles. Bioinformatics, 23:892–894.

6

3 Session Information

The version number of R and packages loaded for generating the vignette
were:

> sessionInfo()

R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] parallel stats
[8] base

graphics grDevices utils

datasets methods

other attached packages:

[1] focalCall_1.12.0
[4] snow_0.4-2
[7] limma_3.34.0
[10] DNAcopy_1.52.0

CGHcall_2.40.0
CGHbase_1.38.0
Biobase_2.38.0
impute_1.52.0

loaded via a namespace (and not attached):
[1] compiler_3.4.2 tools_3.4.2

snowfall_1.84-6.1
marray_1.56.0
BiocGenerics_0.24.0

7

