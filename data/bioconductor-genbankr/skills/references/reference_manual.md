Package ‘genbankr’

April 11, 2018

Version 1.6.1

Title Parsing GenBank ﬁles into semantically useful objects

Description Reads Genbank ﬁles.

Copyright Genentech, Inc.
Maintainer Gabriel Becker <becker.gabriel@gene.com>
License Artistic-2.0

Depends methods

Imports BiocGenerics, IRanges, GenomicRanges(>= 1.23.24),

GenomicFeatures, Biostrings, VariantAnnotation, rtracklayer,
S4Vectors, GenomeInfoDb, Biobase

Suggests RUnit, rentrez (>= 1.2.1), knitr, rmarkdown, BiocStyle

VignetteBuilder knitr

RoxygenNote 5.0.1.9000

biocViews Infrastructure, DataImport

NeedsCompilation no

Author Gabriel Becker [aut, cre],
Michael Lawrence [aut]

R topics documented:

.

.
.
.
.

.
.
.
.

2
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
cds,GenBankRecord-method .
3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
GBAccession-class .
3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
gbk-speciﬁc-api .
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
GenBankFile-class
.
.
5
GenBankRecord-class .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
5
import,GenBankFile,ANY,ANY-method . . . . . . . . . . . . . . . . . . . . . . . . . .
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
intergenic .
. .
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
makeTxDbFromGenBank .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
make_gbrecord .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
.
otherFeatures .
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
.
parseGenBank .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
.
readGenBank .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
. .
.
.
.
variants

.
.
.
.
.

.
.
.
.
.

.
.
.
.
.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

Index

12

1

2

cds,GenBankRecord-method

cds,GenBankRecord-method

Annotation extraction api

Description

Accessor functions shared with the larger Bioconductor ecosystem.

Usage

## S4 method for signature 'GenBankRecord'
cds(x)

## S4 method for signature 'GenBankRecord'
exons(x)

## S4 method for signature 'GenBankRecord'
genes(x)

## S4 method for signature 'GenBankRecord'
transcripts(x)

## S4 method for signature 'GenBankRecord'
getSeq(x, ...)

## S4 method for signature 'GenBankFile'
getSeq(x, ...)

## S4 method for signature 'GBAccession'
getSeq(x, ...)

## S4 method for signature 'GenBankRecord'
cdsBy(x, by = c("tx", "gene"))

## S4 method for signature 'GenBankRecord'
exonsBy(x, by = c("tx", "gene"))

## S4 method for signature 'GenBankRecord'
isCircular(x)

## S4 method for signature 'GenBankRecord'
seqinfo(x)

Arguments

x

...

by

The object containing the annotations

unused.

character. Factor to group the resulting GRanges by.

GBAccession-class

Value

3

The expected types, GenomicRanges for most functions, a DNAStrimgSet for getSeq

Examples

gb = readGenBank(system.file("sample.gbk", package="genbankr"))
cds(gb)
exons(gb)
genes(gb)

GBAccession-class

GBAccession ID class

Description

A class representing the (versioned) GenBank accession

Usage

GBAccession(id)

Arguments

id

Value

A versioned GenBank Accession id

a GBAccession object.

Examples

id = GBAccession("U49845.1")
## Not run: gb = readGenBank(id)

gbk-specific-api

genbankr speciﬁc api

Description

Accessor functions speciﬁc to genbankr objects.

GenBankFile-class

4

Usage

accession(x, ...)

## S4 method for signature 'GenBankRecord'
accession(x)

definition(x, ...)

## S4 method for signature 'GenBankRecord'
definition(x)

locus(x, ...)

## S4 method for signature 'GenBankRecord'
locus(x)

vers(x, ...)

## S4 method for signature 'GenBankRecord'
vers(x)

sources(x, ...)

## S4 method for signature 'GenBankRecord'
sources(x)

Arguments

x
...

Value

A genbank annotation object
unused.

Character vectors for accession and vers

Examples

gb = readGenBank(system.file("sample.gbk", package="genbankr"))
accession(gb)
vers(gb)

GenBankFile-class

GenBank File

Description

A resource class for use within the rtracklayer framework

Create a GenBankFile object.

Usage

GenBankFile(fil)

GenBankRecord-class

5

Arguments

fil

Value

character. Path to the genbank ﬁle

A GenBankFile object

Examples

fil = GenBankFile(system.file("sample.gbk", package="genbankr"))
gb = import(fil)

GenBankRecord-class

GenBank data objects

Description

These objects represent GenBank annotations

Examples

gb = readGenBank(system.file("sample.gbk", package="genbankr"))
gb

import,GenBankFile,ANY,ANY-method

Import genbank ﬁle

Description

Import a genbank ﬁle using the rtracklayer API.

Usage

## S4 method for signature 'GenBankFile,ANY,ANY'
import(con, format, text, ...)

Arguments

con

format

text

...

Value

See import docs.

See import docs.

See import docs.
Arguments passed to readGenBank

A GenBankRecord object.

6

makeTxDbFromGenBank

intergenic

Extract intergenic regions from processed GenBank annotations

Description

Extract the intergenic regions from a set of GenBank annotations.

Usage

## S4 method for signature 'GenBankRecord'
intergenic(x)

Arguments

x

Value

A GenBankRecord object

A GRanges for the intergenic regions, deﬁned as regions not overlapping any genes deﬁned in the
annotations on either strand.

Examples

gb = readGenBank(system.file("sample.gbk", package="genbankr"))
intergenic(gb)

makeTxDbFromGenBank

Create a TxDb from a GenBank record

Description

Create a TxDb object from a GenBankRecord.

Usage

makeTxDbFromGenBank(gbr, reassign.ids = FALSE)

## S4 method for signature 'GenBankRecord'
makeTxDbFromGenBank(gbr, reassign.ids = FALSE)

## S4 method for signature 'GBAccession'
makeTxDbFromGenBank(gbr, reassign.ids = FALSE)

Arguments

gbr

reassign.ids

Value

A TxDb object

A GenBankRecord or GBAccession object
logical. Passed down to makeTxDb

make_gbrecord

Examples

7

thing = readGenBank(system.file("unitTests/compjoin.gbk", package="genbankr"))
tx = makeTxDbFromGenBank(thing)

make_gbrecord

GenBank object constructors

Description

Constructors for GenBankRecord objects.

Usage

make_gbrecord(rawgbk, verbose = FALSE)

Arguments

rawgbk

verbose

Value

list. The output of parseGenBank
logical. Should informative messages be shown

A GenBankRecord object

Examples

prsed = parseGenBank(system.file("sample.gbk", package="genbankr"))
gb = make_gbrecord(prsed)

otherFeatures

Retrieve ’other’ features

Description

Retrieve the other features (not covered by a different accessor) from the set of annotations

Usage

otherFeatures(x)

## S4 method for signature 'GenBankRecord'
otherFeatures(x)

Arguments

x

Value

a GenBankRecord object

A GRanges containing the features which don’t fall into another category (ie not gene, exon, tran-
script, cds, or variant) annotated in the source ﬁle

8

Examples

gb = readGenBank(system.file("sample.gbk", package="genbankr"))
otherFeatures(gb)

parseGenBank

parseGenBank

Parse raw genbank ﬁle content

Description

Parse genbank content and return a low-level list object containing each component of the ﬁle.

Usage

parseGenBank(file, text = readLines(file), partial = NA, verbose = FALSE,

ret.anno = TRUE, ret.seq = TRUE)

Arguments

file

text

partial

verbose

ret.anno

ret.seq

Value

character. The ﬁle to be parsed. Ignored if text is speciﬁed

character. The text to be parsed.

logical. If TRUE, features with non-exact boundaries will be included. Oth-
erwise, non-exact features are excluded, with a warning if partial is NA (the
default).

logical. Should informative messages be printed to the console as the ﬁle is
being processed.

logical. Should the annotations in the GenBank ﬁle be parsed and included in
the returned object. (Defaults to TRUE)

logical. Should the origin sequence (if present) in the GenBank ﬁle be included
in the returned object. (Defaults to TRUE)

if ret.anno is TRUE, a list containing the parsed contents of the ﬁle, suitable for passing to make_gbrecord.
If ret.anno is FALSE, a DNAStringSet object containing the origin sequence.

Note

This is a low level function not intended for common end-user use. In nearly all cases, end-users
(and most developers) should call readGenBank or create a GenBankFile object and call import
instead.

Examples

prsd = parseGenBank(system.file("sample.gbk", package="genbankr"))

readGenBank

9

readGenBank

Read a GenBank File

Description

Read a GenBank ﬁle from a local ﬁle, or retrieve and read one based on an accession number. See
Details for exact behavior.

Usage

readGenBank(file, text = readLines(file), partial = NA, ret.seq = TRUE,

verbose = FALSE)

Arguments

file

text

partial

ret.seq

verbose

Details

character or GBAccession. The path to the ﬁle, or a GBAccession object con-
taining Nuccore versioned accession numbers. Ignored if text is speciﬁed.
character. The text of the ﬁle. Defaults to text within file
logical. If TRUE, features with non-exact boundaries will be included. Oth-
erwise, non-exact features are excluded, with a warning if partial is NA (the
default).

logical. Should an object containing the raw ORIGIN sequence be created and
returned. Defaults to TRUE. If FALSE, the sequence slot is set to NULL. See NOTE.
logical. Should informative messages be printed to the console as the ﬁle is
processed. Defaults to FALSE.

If a a GBAccession object is passed to file, the rentrez package is used to attempt to fetch full
GenBank records for all ids in the

Often times, GenBank ﬁles don’t contain exhaustive annotations. For example, ﬁles including
CDS annotations often do not have separate transcript features. Furthermore, chromosomes are not
always named, particularly in organisms that have only one. The details of how genbankr handles
such cases are as follows:

In ﬁles where CDSs are annotated but individual exons are not, ’approximate exons’ are deﬁned
as the individual contiguous elements within each CDS. Currently, no mixing of approximate and
explicitly annotated exons is performed, even in cases where, e.g., exons are not annotated for some
genes with CDS annotations.

In ﬁles where transcripts are not present, ’approximate transcripts’ deﬁned by the ranges spanned
by groups of exons are used. Currently, we do not support generating approximate transcripts from
CDSs in ﬁles that contain actual transcript annotations, even if those annotations do not cover all
genes with CDS/exon annotations.

Features (gene, cds, variant, etc) are assumed to be contained within the most recent previous source
feature (chromosome/physical piece of DNA). Chromosome name for source features (seqnames in
the resulting GRanges/VRanges is determined as follows:

1. The ’chromosome’ attribute, as is (e.g., "chr1");

2. the ’strain’ attribute, combined with auto-generated count (e.g., "VR1814:1");

3. the ’organism’ attribute, combined with auto-generated count (e.g. "Human herpesvirus 5:1".

10

variants

In ﬁles where no origin sequence is present, importing varation features is not currently supported,
as there is no easy/ self-contained way of determining the reference in those situations and the
features themselves list only alt. If variation features are present in a ﬁle without origin sequence,
those features are ignored with a warning.

Currently some information about from the header of a GenBank ﬁle, primarily reference and author
based information, is not captured and returned. Please contact the maintainer if you have a direct
use-case for this type of information.

Value

A GenBankRecord object containing (most, see detaisl) of the information within file/text Or a
list of GenBankRecord objects in cases where a GBAccession vector with more than one ID in it is
passed to file

Note

We have endeavored to make this parser as effcient as easily possible. On our local machines, a
19MB genbank ﬁle takes 2-3 minutes to be parsed. That said, this function is not tested and likely
not suitable for processing extremely large genbank ﬁles.

The origin sequence is always parsed when calling readGenBank, because it is necessary to generate
a VRanges from variant features. So currently ret.seq=FALSE will not reduce parsing time, or
maximum memory usage, though it will reduce memory usage by the ﬁnal GenBankRecord object.
The lower-level parseGenBank does skil parsing the sequence at all via ret.seq=FALSE, but variant
annotations will be excluded if make_gbrecord is called on the resulting parsed list.

Examples

gb = readGenBank(system.file("sample.gbk", package="genbankr"))

variants

Retrieve variantion features

Description

Extract the annotated variants from a GenBankRecord object

Usage

variants(x)

## S4 method for signature 'GenBankRecord'
variants(x)

Arguments

x

Value

a GenBankRecord object

A VRanges containing the variations annotated in the source ﬁle

variants

Examples

gb = readGenBank(system.file("sample.gbk", package="genbankr"))
variants(gb)

11

Index

accession (gbk-specific-api), 3
accession,GenBankRecord

(gbk-specific-api), 3

accession,GenBankRecord-method

(gbk-specific-api), 3

cds,GenBankRecord-method, 2
cdsBy,GenBankRecord

(cds,GenBankRecord-method), 2

cdsBy,GenBankRecord-method

(cds,GenBankRecord-method), 2

definition (gbk-specific-api), 3
definition,GenBankRecord

(gbk-specific-api), 3

definition,GenBankRecord-method

(gbk-specific-api), 3

exons,GenBankRecord-method

(cds,GenBankRecord-method), 2

exonsBy,GenBankRecord

(cds,GenBankRecord-method), 2

exonsBy,GenBankRecord-method

(cds,GenBankRecord-method), 2

GBAccession (GBAccession-class), 3
GBAccession-class, 3
GBFile-class (GenBankFile-class), 4
gbk-specific-api, 3
GBKFile-class (GenBankFile-class), 4
GenBankFile (GenBankFile-class), 4
GenBankFile-class, 4
GenBankRecord-class, 5
genes,GenBankRecord-method

(cds,GenBankRecord-method), 2

getSeq,GBAccession-method

(cds,GenBankRecord-method), 2

getSeq,GenBankFile-method

(cds,GenBankRecord-method), 2

getSeq,GenBankRecord-method

(cds,GenBankRecord-method), 2

import,GenBankFile

(import,GenBankFile,ANY,ANY-method),
5

12

import,GenBankFile,ANY,ANY-method, 5
intergenic, 6
intergenic,GenBankRecord-method
(intergenic), 6

isCircular,GenBankRecord

(cds,GenBankRecord-method), 2

isCircular,GenBankRecord-method

(cds,GenBankRecord-method), 2

locus (gbk-specific-api), 3
locus,GenBankRecord (gbk-specific-api),

3

locus,GenBankRecord-method

(gbk-specific-api), 3

make_gbrecord, 7
makeTxDbFromGenBank, 6
makeTxDbFromGenBank,GBAccession
(makeTxDbFromGenBank), 6
makeTxDbFromGenBank,GBAccession-method
(makeTxDbFromGenBank), 6

makeTxDbFromGenBank,GenBankRecord

(makeTxDbFromGenBank), 6
makeTxDbFromGenBank,GenBankRecord-method
(makeTxDbFromGenBank), 6

otherFeatures, 7
otherFeatures,GenBankRecord

(otherFeatures), 7
otherFeatures,GenBankRecord-method
(otherFeatures), 7

parseGenBank, 8

readGenBank, 9

seqinfo,GenBankRecord

(cds,GenBankRecord-method), 2

seqinfo,GenBankRecord-method

(cds,GenBankRecord-method), 2

sources (gbk-specific-api), 3
sources,GenBankRecord

(gbk-specific-api), 3
sources,GenBankRecord-method
(gbk-specific-api), 3

INDEX

13

transcripts,GenBankRecord-method

(cds,GenBankRecord-method), 2

variants, 10
variants,GenBankRecord (variants), 10
variants,GenBankRecord-method
(variants), 10

vers (gbk-specific-api), 3
vers,GenBankRecord (gbk-specific-api), 3
vers,GenBankRecord-method

(gbk-specific-api), 3

