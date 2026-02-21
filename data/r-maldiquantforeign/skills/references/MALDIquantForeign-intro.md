MALDIquantForeign: Import/Export
routines for MALDIquant

Sebastian Gibb∗

January 22, 2024

Abstract

MALDIquantForeign provides routines for importing/exporting dif-

ferent file formats into/from MALDIquant.
This vignette describes the usage of the MALDIquantForeign package.

∗mail@sebastiangibb.de

1

Contents

1 Introduction

2 Setup

3 Import

4 Export

5 Analyse Mass Spectrometry Data

6 Session Information

Foreword

2

3

3

6

7

7

MALDIquantForeign is free and open source software for the R (R Core Team,
2014) environment and under active development. If you use it, please sup-
port the project by citing it in publications:

Gibb, S. and Strimmer, K. (2012). MALDIquant: a versatile R
package for the analysis of mass spectrometry data. Bioinformat-
ics, 28(17):2270–2271

If you have any questions, bugs, or suggestions do not hesitate to contact

me (mail@sebastiangibb.de).
Please visit http://strimmerlab.org/software/maldiquant/.

1

Introduction

MALDIquant should be device and platform independent. That’s why it has
not any import/export functions.
MALDIquantForeign fills this gap and provides import/export routines for
various file formats:

> supportedFileFormats()

2

$import

[1] "txt"
[7] "mzml"

$export
[1] "tab"

"tab"
"imzml"

"csv"
"analyze"

"fid"
"cdf"

"ciphergen" "mzxml"
"msd"

"csv"

"msd"

"mzml"

"imzml"

2 Setup

After starting R we could install MALDIquant and MALDIquantForeign di-
rectly from CRAN using install.packages:

> install.packages(c("MALDIquant", "MALDIquantForeign"))

Before we can use MALDIquant and MALDIquantForeign we have to load

the packages.

> library("MALDIquant")
> library("MALDIquantForeign")

3

Import

MALDIquantForeign provides an import function that tries to auto-detect
the correct file type. Because this would never be perfect MALDIquantForeign
offers also many import* functions like importBrukerFlex, importMzMl, etc.
Please see the manual page of import for a complete list (?import).

First we try to import some example data in Bruker Daltonics *flex-series

file format using the import function.

> ## get the example directory
> exampleDirectory <- system.file("exampledata",
+
>

package="MALDIquantForeign")

3

> spectra <- import(file.path(exampleDirectory,
+
+
> spectra[[1]]

verbose=FALSE)

"brukerflex"),

: MassSpectrum
: 5
: 226.762 - 230.51

S4 class type
Number of m/z values
Range of m/z values
Range of intensity values: 1e+00 - 5e+00
Memory usage
Name
File

: 8.859 KiB
: brukerflex.
: /tmp/RtmpHovc2p/Rinst199464e1bc746/MALDIquantForeign/exampledata/brukerflex/0_A1/1/1SLin/fid

Next we use the importBrukerFlex function (the result is the same as

above).

> spectra <- importBrukerFlex(file.path(exampleDirectory,
+
+
> spectra[[1]]

"brukerflex"),

verbose=FALSE)

: MassSpectrum
: 5
: 226.762 - 230.51

S4 class type
Number of m/z values
Range of m/z values
Range of intensity values: 1e+00 - 5e+00
Memory usage
Name
File

: 8.859 KiB
: brukerflex.
: /tmp/RtmpHovc2p/Rinst199464e1bc746/MALDIquantForeign/exampledata/brukerflex/0_A1/1/1SLin/fid

MALDIquantForeign supports compressed files, too (zip, tar.{bz2, gz,xz}).

> spectra <- importCsv(file.path(exampleDirectory, "compressed",
+
> spectra[[1]]

"csv.tar.gz"), verbose=FALSE)

S4 class type
Number of m/z values

: MassSpectrum
: 5

4

Range of m/z values
Range of intensity values: 6 - 10
Memory usage
File

: 1 - 5

: 1.492 KiB
: /tmp/Rtmpc6zZWe/MALDIquantForeign_uncompress/csv_199845dfbfcaa/csv1.csv

> spectra <- importCsv(file.path(exampleDirectory, "compressed",
+
> spectra[[1]]

"csv.zip"), verbose=FALSE)

S4 class type
Number of m/z values
Range of m/z values
Range of intensity values: 6 - 10
Memory usage
File

: MassSpectrum
: 5
: 1 - 5

: 1.492 KiB
: /tmp/Rtmpc6zZWe/MALDIquantForeign_uncompress/csv_199843a660558/csv1.csv

Remote files are supported as well. Data are taken from Tan et al. (2006).

> spectra <- import(paste0("http://www.meb.ki.se/",
+
+

centroided=FALSE, verbose=TRUE)

"~yudpaw/papers/spikein_xml.zip"),

If you want to read peak lists (centroided data) instead of spectra data

you have to set centroided=TRUE.

> peaks <- import(file.path(exampleDirectory, "ascii.txt"),
+
> peaks

centroided=TRUE, verbose=FALSE)

[[1]]
S4 class type
Number of m/z values
Range of m/z values
Range of intensity values: 6 - 10
Range of snr values
Memory usage
File

: MassPeaks
: 5
: 1 - 5

: NA - NA
: 1.695 KiB
: /tmp/RtmpHovc2p/Rinst199464e1bc746/MALDIquantForeign/exampledata/ascii.txt

5

4 Export

The export routines in MALDIquantForeign are very similar to the import
routines. Please see manual page of export for a complete list of supported
export routines (?export).

First we create a simple list of MassSpectrum objects using createMassSpectrum.

> spectra <- list(
+
+

createMassSpectrum(mass=1:5, intensity=1:5),
createMassSpectrum(mass=1:5, intensity=6:10))

Now we want to export the first spectrum into a CSV file.

> export(spectra[[1]], file="spectrum1.csv")
> import("spectrum1.csv")

[[1]]
: MassSpectrum
S4 class type
: 5
Number of m/z values
: 1 - 5
Range of m/z values
Range of intensity values: 1 - 5
Memory usage
File

: 1.492 KiB
: /tmp/RtmpHovc2p/Rbuild1994667887b9f/MALDIquantForeign/vignettes/spectrum1.csv

Exporting every file by hand is cumbersome. We want to export the
whole list of spectra. Instead of file we use path now to specify a directory.
Please note that we have to add the file type/format information now (we
can use the type argument or the corresponding export* function). If the
path doesn’t exists we will get an error. To force export to create/overwrite
the given path, we set the argument force=TRUE.

> export(spectra, type="csv", path="spectra", force=TRUE)
> list.files("spectra")

[1] "1.csv" "2.csv"

6

5 Analyse Mass Spectrometry Data

Please have a look at the corresponding vignette shipped with MALDIquant
and the MALDIquant website: http://strimmerlab.org/software/maldiquant/.

> vignette(topic="MALDIquant", package="MALDIquant")

6 Session Information

• R Under development (unstable) (2024-01-22 r85820),

x86_64-pc-linux-gnu

• Running under: Debian GNU/Linux 12 (bookworm)

• Matrix products: default

• BLAS: /home/sebastian/opt/R/lib/R/lib/libRblas.so

• LAPACK:

/usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.11.0

• Base packages: base, datasets, grDevices, graphics, methods, stats,

utils

• Other packages: MALDIquant 1.22.1, MALDIquantForeign 0.14.1,

knitr 1.45

• Loaded via a namespace (and not attached): XML 3.99-0.16.1,
base64enc 0.1-3, compiler 4.4.0, digest 0.6.34, evaluate 0.23,
highr 0.10, parallel 4.4.0, readBrukerFlexData 1.9.1,
readMzXmlData 2.8.3, tools 4.4.0, xfun 0.41

References

Gibb, S. and Strimmer, K. (2012). MALDIquant: a versatile R package for
the analysis of mass spectrometry data. Bioinformatics, 28(17):2270–2271.

7

R Core Team (2014). R: A Language and Environment for Statistical Com-

puting. R Foundation for Statistical Computing, Vienna, Austria.

Tan, C. S., Ploner, A., Quandt, A., Lehti¨o, J., and Pawitan, Y. (2006). Find-
ing regions of significance in SELDI measurements for identifying protein
biomarkers. Bioinformatics, 22(12):1515–1523.

8

