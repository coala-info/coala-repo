Package ‘BufferedMatrixMethods’

Type Package

Title Microarray Data related methods that utlize BufferedMatrix

February 9, 2026

objects

Version 1.74.0

Date 2012-09-14

Author Ben Bolstad <bmb@bmbolstad.com>

Maintainer Ben Bolstad <bmb@bmbolstad.com>

Depends R (>= 2.6.0), BufferedMatrix (>= 1.3.0), methods

Suggests affyio, affy

LinkingTo BufferedMatrix

LazyLoad Yes

Description Microarray analysis methods that use BufferedMatrix objects

License GPL (>= 2)

URL https://github.bom/bmbolstad/BufferedMatrixMethods

biocViews Infrastructure

git_url https://git.bioconductor.org/packages/BufferedMatrixMethods

git_branch RELEASE_3_22

git_last_commit e42f5a3

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-09

Contents

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
BufferedMatrix.justRMA .
BufferedMatrix.read.celfiles
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
BufferedMatrix.read.probematrix . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
RMA preprocess BufferedMatrix . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

.

Index

1

2
3
3
4

6

2

BufferedMatrix.justRMA

BufferedMatrix.justRMA

Use BufferedMatrix objects to facilitate RMA computation with low
memory overhead

Description

Read CEL data into BufferedMatrix objects.

Usage

BufferedMatrix.justRMA(..., filenames=character(0),celfile.path=NULL,

phenoData=new("AnnotatedDataFrame"),
description=NULL,
notes="",
verbose=FALSE, background=TRUE, normalize=TRUE,
cdfname = NULL)

Arguments

...

file names separated by comma.

filenames

file names in a character vector.

celfile.path

path where CEL files are located

phenoData

a AnnotatedDataFrame object

description

a MIAME object

notes

verbose

notes

verbosity flag

normalize

logical value. If TRUE normalize data using quantile normalization

background

logical value. If TRUE background correct using RMA background correction

cdfname

Used to specify the name of an alternative cdf package. If set to NULL, the usual
cdf package based on Affymetrix’ mappings will be used.

Value

An ExpressionSet object, containing expression values identical to what one would get from
running rma on an AffyBatch.

Author(s)

Ben Bolstad <bmb@bmbolstad.com>

See Also

BufferedMatrix, BufferedMatrix.read.probematrix

BufferedMatrix.read.celfiles

3

BufferedMatrix.read.celfiles

Read CEL file data into PM or MM BufferedMatrix

Description

Read CEL data into BufferedMatrix objects.

Usage

BufferedMatrix.read.celfiles(..., filenames = character(0),celfile.path=NULL)

Arguments

...

file names separated by comma.

filenames

file names in a character vector.

celfile.path

path where CEL files are located

Value

A BufferedMatrix object containing the CEL file intensities.

Author(s)

Ben Bolstad <bmb@bmbolstad.com>

See Also

BufferedMatrix, BufferedMatrix.read.probematrix

BufferedMatrix.read.probematrix

Read CEL file data into PM or MM BufferedMatrix

Description

Read CEL data into BufferedMatrix objects.

Usage

BufferedMatrix.read.probematrix(..., filenames = character(0),celfile.path=NULL,rm.mask = FALSE, rm.outliers = FALSE, rm.extra = FALSE, verbose = FALSE,which="pm",cdfname = NULL)

4

Arguments

RMA preprocess BufferedMatrix

...

file names separated by comma.

filenames

file names in a character vector.

celfile.path

path where CEL files are located

rm.mask

should the spots marked as ’MASKS’ set to NA ?

rm.outliers

should the spots marked as ’OUTLIERS’ set to NA

rm.extra

verbose

which

cdfname

Value

if TRUE, overrides what is in rm.mask and rm.oultiers

verbosity flag

should be either "pm", "mm" or "both"

Used to specify the name of an alternative cdf package. If set to NULL, the usual
cdf package based on Affymetrix’ mappings will be used.

A list of one or two BufferedMatrix objects. Each BufferedMatrix objects is either PM or MM
data. No AffyBatch is created.

Author(s)

Ben Bolstad <bmb@bmbolstad.com>

See Also

AffyBatch, read.affybatch

RMA preprocess BufferedMatrix

RMA preprocessing functions that work on BufferedMatrix objects

Description

This group of functions can be used to apply the RMA background correction, Quantile normaliza-
tion and Median polish summarization to data stored in a BufferedMatrix object.

Usage

bg.correct.BufferedMatrix(x, copy=TRUE)
normalize.BufferedMatrix.quantiles(x, copy=TRUE)
BufferedMatrix.bg.correct.normalize.quantiles(x, copy=TRUE)

Arguments

x

copy

a BufferedMatrix containing data to be processed

should the BufferedMatrix be copied or should the input object be changed on
output

RMA preprocess BufferedMatrix

5

Value

In the case of normalize.BufferedMatrix.quantiles and bg.correct.BufferedMatrix a BufferedMatrix
is returned. The function median.polish.summarize returns a matrix.

The function BufferedMatrix.bg.correct.normalize.quantiles carries out both pre-processing
steps with a single command.

Author(s)

B. M. Bolstad <bmb@bmbolstad.com>

See Also

rma

Index

∗ manip

RMA preprocess BufferedMatrix, 4

AffyBatch, 2, 4
AnnotatedDataFrame, 2

bg.correct.BufferedMatrix (RMA

preprocess BufferedMatrix), 4

BufferedMatrix, 2–5
BufferedMatrix.bg.correct.normalize.quantiles

(RMA preprocess
BufferedMatrix), 4
BufferedMatrix.justRMA, 2
BufferedMatrix.read.celfiles, 3
BufferedMatrix.read.probematrix, 2, 3, 3

matrix, 5
median.polish.summarize (RMA

preprocess BufferedMatrix), 4
median.polish.summarize,BufferedMatrix-method

(RMA preprocess
BufferedMatrix), 4

MIAME, 2

normalize.BufferedMatrix.quantiles

(RMA preprocess
BufferedMatrix), 4

read.affybatch, 4
rma, 2, 5
RMA preprocess BufferedMatrix, 4

6

