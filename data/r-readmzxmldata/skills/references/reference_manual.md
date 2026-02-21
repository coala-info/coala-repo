Package ‘readMzXmlData’

October 17, 2025

Version 2.8.4

Date 2025-10-17

Title Reads Mass Spectrometry Data in mzXML Format

Depends R (>= 4.2.0)

Imports base64enc, digest, XML

Description Functions for reading mass spectrometry data in mzXML format.

License GPL (>= 3)

URL https://strimmerlab.github.io/software/maldiquant/

https://codeberg.org/sgibb/readMzXmlData/

BugReports https://codeberg.org/sgibb/readMzXmlData/issues/

LazyLoad yes

RoxygenNote 7.3.2

Encoding UTF-8

NeedsCompilation no

Author Sebastian Gibb [aut, cre]

Maintainer Sebastian Gibb <mail@sebastiangibb.de>

Repository CRAN

Date/Publication 2025-10-17 07:10:03 UTC

Contents

readMzXmlData-package .
.
.
readMzXmlDir
.
readMzXmlFile .

.
.

.
.

.
.

.
.

Index

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.

2
2
4

6

1

2

readMzXmlDir

readMzXmlData-package The readMzXmlData Package

Description

The package reads mass spectrometry data in mzXML format.

Details

Main functions:

readMzXmlFile: Reads mass spectrometry data in mzXML format.

readMzXmlDir: Reads recursively mass spectrometry data in mzXML format in a specific directory.

mqReadMzXml: Reads mass spectrometry data into MALDIquant.

Author(s)

Sebastian Gibb <mail@sebastiangibb.de>

References

See website: https://strimmerlab.github.io/software/maldiquant/

See Also

readMzXmlDir, readMzXmlFile

readMzXmlDir

Reads recursively mass spectrometry data in mzXML format.

Description

Reads recursively all mass spectrometry data in mzXML format in a specified directory.

Usage

readMzXmlDir(
mzXmlDir,
removeCalibrationScans = TRUE,
removeMetaData = FALSE,
rewriteNames = TRUE,
fileExtension = "mzXML",
verbose = FALSE

)

readMzXmlDir

Arguments

3

mzXmlDir
removeCalibrationScans

character, path to directory which should be read recursively.

logical, if TRUE all scans in directories called “[Cc]alibration” will be ignored.

removeMetaData logical, to save memory metadata could be deleted.

rewriteNames

logical, if TRUE all list elements get an unique name from metadata otherwise
file path is used.

fileExtension

character, file extension of mzXML formatted files. The directory is only
searched for fileExtension files.
In most cases it would be “"mzXML"” but
sometimes you have to use “xml”.

verbose

logical, verbose output?

Details

See readMzXmlFile.

Value

A list of spectra.

[[1]]spectrum$mass:

[[1]]spectrum$intensity:

A vector of calculated mass.

A vector of intensity values.

[[1]]metaData: A list of metaData depending on read spectrum.

Author(s)

Sebastian Gibb <mail@sebastiangibb.de>

See Also

readMzXmlFile, importMzXml

Examples

## load library
library("readMzXmlData")

## get examples directory
exampleDirectory <- system.file("Examples", package="readMzXmlData")

## read example spectra
spec <- readMzXmlDir(exampleDirectory)

## plot spectra
plot(spec[[1]]$spectrum$mass, spec[[1]]$spectrum$intensity, type="n")

l <- length(spec)

4

readMzXmlFile

legendStr <- character(l)
for (i in seq(along=spec)) {

lines(spec[[i]]$spectrum$mass, spec[[i]]$spectrum$intensity, type="l",

col=rainbow(l)[i])

legendStr[i] <- basename(spec[[i]]$metaData$file)

}

## draw legend
legend(x="topright", legend=legendStr, col=rainbow(l), lwd=1)

readMzXmlFile

Reads mass spectrometry data in mzXML format.

Description

Reads mass spectrometry data in mzXML format defined in http://tools.proteomecenter.
org/wiki/index.php?title=Formats:mzXML

Usage

readMzXmlFile(mzXmlFile, removeMetaData = FALSE, verbose = FALSE)

Arguments

mzXmlFile

character, path to mzXML file which should be read.

removeMetaData logical, to save memory metadata could be deleted.

verbose

logical, verbose output?

Value

A list of spectra and metadata.

spectrum$mass: A vector of calculated mass.
spectrum$intensity:

A vector of intensity values.

metaData:

A list of metaData depending on read spectrum.

Author(s)

Sebastian Gibb <mail@sebastiangibb.de>

References

Definition of mzXML format: http://tools.proteomecenter.org/wiki/index.php?title=Formats:
mzXML

5

readMzXmlFile

See Also

readMzXmlDir, importMzXml

Examples

## load library
library("readMzXmlData")

## get examples directory
exampleDirectory <- system.file("Examples", package="readMzXmlData")

## read example spectrum
spec <- readMzXmlFile(file.path(exampleDirectory, "A1-0_A1.mzXML"))

## print metaData
print(spec$metaData)

## plot spectrum
plot(spec$spectrum$mass, spec$spectrum$intensity, type="l")

Index

∗ IO

readMzXmlData-package, 2
readMzXmlDir, 2
readMzXmlFile, 4

importMzXml, 3, 5

mqReadMzXml, 2

readMzXmlData (readMzXmlData-package), 2
readMzXmlData-package, 2
readMzXmlDir, 2, 2, 5
readMzXmlFile, 2, 3, 4

6

