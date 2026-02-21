FAQ

1

Frequently Asked Questions

1.1 align_mQTL() aborted the processing with the error
message "Peak validation threshold exceeds spec-
trum maximum and minimum value"

The mQTL.NMR package suggests default values optimized through extensive
experimental setup and during several NMR studies for alignment using the
RSPA approach. However, these parameters might not be well adapted for the
data under consideration due to several factors (intrinsic data structure, inap-
propriate normalisation/scaling). For this reason we have made available the
function setupRSPA() enabling a simple modiﬁcation of diﬀerent parameters.
In particular, the error message "Peak validation threshold exceeds spectrum
maximum and minimum value" indicates that the peak amplitude threshold pa-
rameter (ampThr) deﬁned inside the peakParam structure is not well optimized
for the considered data.
In such a case we advise the user to try one of the
following solutions:

I- Try a diﬀerent normalization/scaling method: in some cases normal-
ization/scaling step aﬀect drastically the structure of data and more adapted
methods should be selected.
II- Modify the alignment parameters through the function setupRSPA():
In this speciﬁc case the user have two options:

• Manual: by a careful optimization of alignment parameters with the re-

spect to the characteristics of his data.

• Automated: but less optimal approach concerns the use of the function
getAmpThr() available already in the mQTL.NMR package (and accessi-
ble by mQTL.NMR:::getAmpThr) which allows to estimate automatically
this parameter.
In this speciﬁc case, the user needs only to discard the
assignment instruction (of PeakParam$ampThr) from the list of parame-
ters deﬁned inside the function setupRSPA(). The estimation process of
the parameter will be then launched automatically upon call.

In order to perform one of the two options mentioned in the solution (II),
the user needs ﬁrst to retrieve the original function setupRSPA() in his
workspace and rename it in order to modify the values of parameters ac-

1

FAQ

cordingly. Once the parameter modiﬁcation ﬁnished the original function
should be exchanged by the modiﬁed one (e.g. MysetupRSPA) in the
package namespace by using the following script:

>

>

>

+

>

>

>

## Exchange the function setupRSPA()in the namespace of the mQTL.NMR package

unlockBinding("setupRSPA", as.environment("package:mQTL.NMR"))

assignInNamespace("setupRSPA", MysetupRSPA, ns="mQTL.NMR",

envir=as.environment("package:mQTL.NMR"))

assign("setupRSPA", MysetupRSPA, as.environment("package:mQTL.NMR"))

lockBinding("setupRSPA", as.environment("package:mQTL.NMR"))

ppmToPt<-mQTL.NMR:::ppmToPt

1.2 I want to use the package only for the prepro-
cessing of my NMR data and do not have neither
genomic nor clinical data

Only some macro functions require the simultaneous use of metabolomic
and genomic data. The user can perform the preprocessing steps using
the micro functions provided also by the mQTL.NMR package (e.g. for
normalization use simply the function normalise()) which handles only R
objects (data frames and matrices).

1.3 align_mQTL() aborted the processing with the
error message "Error in if (step >= splength)...missing
value where TRUE/FALSE needed"

The error is likely due to the inappropriate format of the input ﬁles. Please
make sure that the adopted format is supported by the mQTL.NMR pack-
age.

2

Session Information

The version number of R and packages loaded for generating the vignette
were:

R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)

2

FAQ

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
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

attached base packages:

[1] stats

graphics grDevices utils

datasets

methods

base

loaded via a namespace (and not attached):
[1] compiler_3.4.2 backports_1.1.1 magrittr_1.5
htmltools_0.3.6 tools_3.4.2
[5] rprojroot_1.2
stringi_1.1.5
[9] Rcpp_0.12.13
digest_0.6.12
[13] stringr_1.2.0

rmarkdown_1.6
evaluate_0.10.1

BiocStyle_2.6.0
yaml_2.1.14
knitr_1.17

3

