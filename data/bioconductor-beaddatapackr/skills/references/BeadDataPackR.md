BeadDataPackR: Compression Tools for Raw
Illumina Beadarray Data

Mike L. Smith and Andy G. Lynch

October 29, 2025

Introduction

Raw Illumina BeadArray data consists of .tif images produced by the scanner, accompanied
by .txt and .locs files containing details of bead locations and their intensities within the
image. For a single channel human expression array these data typically occupy ≈ 125MB of
storage. The size of these files can prove a hinderance to both their storage and distribution.
Whilst the images can be compressed using a variety of common tools, the BeadDataPackR
package aims to provide tools for the efficient compression of the .txt and .locs files.

Disclaimer: BeadDataPackR has been tested on data from a variety of Illumina BeadArray
platforms and, to the best of our knowledge, data compressed using lossless settings has
always been restored successfully. However, we cannot take responsibility for any loss or
damage to data that results from its use.

Citing the package

If you make use of BeadDataPackR to ease distribution of your data please cite the following
paper:

BeadDataPackR: A Tool to Facilitate the Sharing of Raw Data from Illumina BeadArray
Studies. Cancer Informatics, 9:217-227, 2010.

iScan Data

Bead-level data from Illumina’s iScan system comes in a different format to that from the
older BeadScan system. The primary difference is that for each array section two images and
accompanying .locs files are produced, labelled Swath1 and Swath2, along with a single .txt.
BeadDataPackR is currently unable to compress data in this format.

Compressing Data

The first step before using any of the functionality is to load the package. For the purpose of
this vignette we also get the path to the example data that is distributed with the package.

library(BeadDataPackR)

dataPath <- system.file("extdata", package = "BeadDataPackR")

tempPath <- tempdir()

BeadDataPackR: Compression Tools for Raw Illumina Beadarray Data

BeadDataPackR has two primary functions, namely to compress raw Illumina data, or de-
compress a file already created with the package. We’ll begin with file compression, which is
carried out using the following commands:

compressBeadData(txtFile = "example.txt", locsGrn = "example_Grn.locs",

outputFile = "example.bab", path = tempPath, nBytes = 4,

nrow = 326, ncol = 4)

The txtFile and locsGrn arguments specify the names of the files to be compressed. For
two channel data there is an additional argument, locsRed, giving the name of the .locs file
for the red channel. These files should be found within the directory specified in the path
argument. A future revision of the package will hopefully alter this behaviour, so all arrays
within a specified folder will be automatically identified and compressed.

The argument nBytes specifies how many bytes should be used to store the fractional parts
of the bead coordinates. For a single channel array the maximum value is 4 (8 for a two
If the maximum value is used the coordinates are stored in the .bab file as
channel array).
single precision floating point numbers, as they are in the .locs files. If a value smaller than
the maximum is choosen then the integer parts of each coordinate are stored seperately. The
requested number of bytes are then used to store the fractional parts, with a corresponding
loss of precision as the number of bytes decreases.

The nrow and ncol arguments can normally be left blank. They specify the dimensions of
each grid segment on the array and, if left blank, can normally be infered from the grid
coordinates. However, this can fail for particularly small grids or cases of misregistration
where segments overlap. If one wants or needs to specify them explicitly, these values can be
found in the .sdf which accompanies the bead level output from the scanner. The number of
columns and rows per segment can be found within the tags <SizeGridX> and <SizeGridY>
respectively.

Decompressing Data

To decompress a .bab file that was created by BeadDataPackR, use the following function:

decompressBeadData(inputFile = "example.bab", inputPath = tempPath,

outputMask = "restored", outputPath = tempPath,

outputNonDecoded = FALSE, roundValues = TRUE )

The inputFile argument specifies the name of the .bab that should be decompressed. This
file should be located in the folder indicated by inputPath, which by default is the current
working directory.

When an array is compressed its name is stored in the resulting .bab file. By default when
it is decompressed this name is used for the restored files. However, this can be troublesome
if you don’t want to overwrite an exisiting file. The outputMask argument allows the user
to define the names of the restored .txt and .locs files.
In this case the restored files will
be named ‘restored.txt’ and ‘restored_Grn.locs’. If this was two channel data a further file,
‘restored_Red.locs’, would also be produced. The files are created in the location specified
by the outputPath argument. If this is left blank the current working directory is used.

The .txt file that are produced by Illumina’s scanner do not included the locations of beads
that failed their decoding process. Since their location are retained in the .locs file, we have to
option of including them in the restored files. outputNonDecoded toggles whether to include

2

BeadDataPackR: Compression Tools for Raw Illumina Beadarray Data

them or not. Illumina’s .txt files also give the bead centre coordinates to 7 significant figures,
resulting in a different number of decimal places as we move across the array, rather than the
single precision values held in the .locs files. roundValues allows the user to choose between
mimicing this behaviour when recreating the .txt files or ouputing the maximum available
precision. The default for both these arguments is to reproduce the original Illumina files.

Extracting data directly

Rather than decompressing the .bab file into the two original files, it may be useful to extract
data directly from it. This can be achieved in the following way:

readCompressedData(inputFile = "example.bab", path = tempPath,

probeIDs = c(10008, 10010) )

This function takes a .bab file found in the directory specified by the path argument. In this
case it extracts the data relating to the beads with IDs 10008 and 10010, which is returned
as a matrix in the same format as the .txt file that would be created if the file were to be
decompressed. If the probeIDs argument is left NULL then a matrix containing data for every
probe on the array is returned (including the non-decoded beads). This mechanism is used
within the beadarray package, from version 2.1.11, to read compressed data directly from
.bab file into beadarray for analysis.

Similarly, we can extract the information contained in the original .locs file, i.e. the bead
centre coordinates in .locs file order, by using the following command:

locs <- extractLocsFile(inputFile = "example.bab", path = tempPath)

Using coordinates in the grid order provided by the .locs can be useful for quickly determining
neighbouring beads and is used in several instances by the beadarray package.

3

BeadDataPackR: Compression Tools for Raw Illumina Beadarray Data

Session Info

Here is the output of sessionInfo on the system on which this document was compiled:

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:

##

##

##

##

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

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

##

## attached base packages:

## [1] stats

graphics grDevices utils

datasets

methods

base

##

## other attached packages:
## [1] BeadDataPackR_1.62.0
##

##

##

## loaded via a namespace (and not attached):
[1] BiocManager_1.30.26 compiler_4.5.1
[4] BiocStyle_2.38.0
[7] tools_4.5.1
##
## [10] highr_0.11
## [13] xfun_0.53

cli_3.6.5
yaml_2.3.10
knitr_1.50
rlang_1.1.6

fastmap_1.2.0
htmltools_0.5.8.1
rmarkdown_2.30
digest_0.6.37
evaluate_1.0.5

4

