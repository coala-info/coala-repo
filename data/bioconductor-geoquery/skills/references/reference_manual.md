Package ‘GEOquery’

February 13, 2026

Type Package

Title Get data from NCBI Gene Expression Omnibus (GEO)

Version 2.78.0

Date 2025-09-03

BugReports https://github.com/seandavi/GEOquery/issues/new

Depends methods, Biobase

Imports readr (>= 1.3.1), xml2, dplyr, data.table, tidyr, magrittr,

limma, curl, rentrez, R.utils, stringr, SummarizedExperiment,
S4Vectors, rvest, httr2

Suggests knitr, rmarkdown, BiocGenerics, testthat, covr, markdown,

quarto, DropletUtils, SingleCellExperiment

VignetteBuilder quarto

URL https://github.com/seandavi/GEOquery,

http://seandavi.github.io/GEOquery,
http://seandavi.github.io/GEOquery/

biocViews Microarray, DataImport, OneChannel, TwoChannel, SAGE

Description The NCBI Gene Expression Omnibus (GEO) is a public repository of microar-

ray data. Given the rich and varied nature of this resource, it is only natural to want to apply Bio-
Conductor tools to these data. GEOquery is the bridge between GEO and BioConductor.

License MIT + file LICENSE

Encoding UTF-8

RoxygenNote 7.3.2

Roxygen list(markdown = TRUE)

git_url https://git.bioconductor.org/packages/GEOquery

git_branch RELEASE_3_22

git_last_commit 3a4b52d

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12
Author Sean Davis [aut, cre] (ORCID: <https://orcid.org/0000-0002-8991-6458>)
Maintainer Sean Davis <seandavi@gmail.com>

1

2

Contents

browseGEOAccession

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

2
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
browseGEOAccession .
3
browseWebsiteRNASeqSearch . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3
coercion .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4
extractFilenameFromDownloadURL . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
GDS-class .
5
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
GEOData-accessors .
6
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
GEOData-class .
.
.
6
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
GEODataTable-class
6
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
getDirListing .
7
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
getGEO .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
getGEOfile
9
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
.
getGEOSeriesFileListing .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
.
getGEOSuppFiles .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
.
.
getGEOSuppFileURL .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
getGSEDataTables
.
.
.
getGSEDownloadPageURLs .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
getRNAQuantAnnotationURL . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
getRNAQuantRawCountsURL . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
getRNASeqData .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
getRNASeqQuantGenomeInfo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
getRNASeqQuantResults .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
.
GPL-class .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
.
.
.
GSE-class .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
GSM-class .
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
hasRNASeqQuantifications .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
.
.
.
parseGEO .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
parseGSEMatrix .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
readRNAQuantAnnotation .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
readRNAQuantRawCounts .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
.
searchFieldsGEO .
searchGEO .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
.
urlExtractRNASeqQuantGenomeInfo . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
urlForAccession .

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

24

browseGEOAccession

Open the GEO page for a given accession

Description

Sometimes, you just need to see the GEO website page for a GEO accession. This function opens
the GEO page for a given accession number in the default browser.

Usage

browseGEOAccession(geo)

Arguments

geo

A GEO accession number

browseWebsiteRNASeqSearch

3

See Also

urlForAccession

Examples

## Not run:
browseGEOAccession("GSE262484")

## End(Not run)

browseWebsiteRNASeqSearch

Browse GEO search website for RNA-seq datasets

Description

This function opens a browser window to the NCBI GEO website with a search for RNA-seq
datasets. It is included as a convenience function to remind users of how to search for RNA-seq
datasets using the NCBI GEO website and an "rnaseq counts" filter.

Usage

browseWebsiteRNASeqSearch()

Examples

## Not run:
browseWebsiteRNASeqSearch()

## End(Not run)

coercion

Convert a GDS data structure to a BioConductor data structure

Description

Functions to take a GDS data structure from getGEO and coerce it to limma MALists or Expres-
sionSets.

Arguments

GDS

do.log2

GPL

The GDS datastructure returned by getGEO

Boolean, should the data in the GDS be log2 transformed before inserting into
the new data structure

Either a GPL data structure (from a call to getGEO) or NULL. If NULL, this will
cause a call to getGEO to produce a GPL. The gene information from the GPL
is then used to construct the genes slot of the resulting limma MAList object or
the featureData slot of the ExpressionSet instance.

4

AnnotGPL

getGPL

Details

extractFilenameFromDownloadURL

In general, the annotation GPL files will be available for GDS records, so the
default is to use these files over the user-submitted GPL files

A boolean defaulting to TRUE as to whether or not to download and include
GPL information when converting to ExpressionSet or MAList. You may want
to set this to FALSE if you know that you are going to annotate your featureData
using Bioconductor tools rather than relying on information provided through
NCBI GEO. Download times can also be greatly reduced by specifying FALSE.

This function just rearranges one data structure into another. For GDS, it also deals appropriately
with making the ’targets’ list item for the limma data structure and the phenoData slot of Expres-
sionSets.

A limma MAList

An ExpressionSet object

Value

GDS2MA

GDS2eSet

Author(s)

Sean Davis

References

See the limma and ExpressionSet help in the appropriate packages

Examples

## Not run: gds505 <- getGEO('GDS505')
## Not run: MA <- GDS2MA(gds505)
## Not run: eset <- GDS2eSet(gds505)

extractFilenameFromDownloadURL

Extract filename from a GEO download URL

Description

This function extracts the filename from a GEO download URL. The filename is expected to be a
query parameter called "file". If the query parameter is not found, the function returns NULL.

Usage

extractFilenameFromDownloadURL(url)

Arguments

url

A GEO download URL

GDS-class

Details

5

The idea is to use this function to extract filenames that contain important metadata from the GEO
RNA-seq quantification.

In particular, the filename is expected to contain the genome build and species information that we
can attach to the SummarizedExperiment.

Value

A character vector with the filename

GDS-class

Class ’GDS’

Description

A class describing a GEO GDS entity

Objects from the Class

Objects can be created by calls of the form new('GDS', ...)

Author(s)

Sean Davis

See Also

GEOData-class

GEOData-accessors

Generic functions for GEOquery

Description

The main documentation is in the Class documentation

Author(s)

Sean Davis

See Also

GEOData-class

6

getDirListing

GEOData-class

Class ’GEOData’

Description

A virtual class for holding GEO samples, platforms, and datasets

Objects from the Class

Objects can be created by calls of the form new('GEOData', ...).

Author(s)

Sean Davis

See Also

GDS-class, GPL-class, GSM-class, GEODataTable-class,

GEODataTable-class

Class ’GEODataTable’

Description

Contains the column descriptions and data for the datatable part of a GEO object

Objects from the Class

Objects can be created by calls of the form new('GEODataTable', ...).

Author(s)

Sean Davis

getDirListing

get a directory listing from NCBI GEO

Description

This one makes some assumptions about the structure of the HTML response returned.

Usage

getDirListing(url)

Arguments

url

A URL, assumed to return an NCBI-formatted index page

getGEO

7

getGEO

Get a GEO object from NCBI or file

Description

This function is the main user-level function in the GEOquery package. It directs the download (if
no filename is specified) and parsing of a GEO SOFT format file into an R data structure specifically
designed to make access to each of the important parts of the GEO SOFT format easily accessible.

Usage

getGEO(

GEO = NULL,
filename = NULL,
destdir = tempdir(),
GSElimits = NULL,
GSEMatrix = TRUE,
AnnotGPL = FALSE,
getGPL = TRUE,
parseCharacteristics = TRUE

)

Arguments

GEO

filename

destdir

GSElimits

GSEMatrix

AnnotGPL

A character string representing a GEO object for download and parsing. (eg.,
’GDS505’,’GSE2’,’GSM2’,’GPL96’)

The filename of a previously downloaded GEO SOFT format file or its gzipped
representation (in which case the filename must end in .gz). Either one of GEO
or filename may be specified, not both. GEO series matrix files are also handled.
Note that since a single file is being parsed, the return value is not a list of esets,
but a single eset when GSE matrix files are parsed.

The destination directory for any downloads. Defaults to the architecture-dependent
tempdir. You may want to specify a different directory if you want to save the
file for later use. Doing so is a good idea if you have a slow connection, as some
of the GEO files are HUGE!

This argument can be used to load only a contiguous subset of the GSMs from
a GSE. It should be specified as a vector of length 2 specifying the start and end
(inclusive) GSMs to load. This could be useful for splitting up large GSEs into
more manageable parts, for example.

A boolean telling GEOquery whether or not to use GSE Series Matrix files from
GEO. The parsing of these files can be many orders-of-magnitude faster than
parsing the GSE SOFT format files. Defaults to TRUE, meaning that the SOFT
format parsing will not occur; set to FALSE if you for some reason need other
columns from the GSE records.

A boolean defaulting to FALSE as to whether or not to use the Annotation GPL
information. These files are nice to use because they contain up-to-date infor-
mation remapped from Entrez Gene on a regular basis. However, they do not
exist for all GPLs; in general, they are only available for GPLs referenced by a
GDS

8

getGPL

getGEO

A boolean defaulting to TRUE as to whether or not to download and include
GPL information when getting a GSEMatrix file. You may want to set this
to FALSE if you know that you are going to annotate your featureData using
Bioconductor tools rather than relying on information provided through NCBI
GEO. Download times can also be greatly reduced by specifying FALSE.

parseCharacteristics

A boolean defaulting to TRUE as to whether or not to parse the characteris-
tics information (if available) for a GSE Matrix file. Set this to FALSE if you
experience trouble while parsing the characteristics.

Details

getGEO functions to download and parse information available from NCBI GEO (http://www.
ncbi.nlm.nih.gov/geo). Here are some details about what is avaible from GEO. All entity types
are handled by getGEO and essentially any information in the GEO SOFT format is reflected in the
resulting data structure.

From the GEO website:

The Gene Expression Omnibus (GEO) from NCBI serves as a public repository for a wide range
of high-throughput experimental data. These data include single and dual channel microarray-
based experiments measuring mRNA, genomic DNA, and protein abundance, as well as non-array
techniques such as serial analysis of gene expression (SAGE), and mass spectrometry proteomic
data. At the most basic level of organization of GEO, there are three entity types that may be
supplied by users: Platforms, Samples, and Series. Additionally, there is a curated entity called a
GEO dataset.

A Platform record describes the list of elements on the array (e.g., cDNAs, oligonucleotide probe-
sets, ORFs, antibodies) or the list of elements that may be detected and quantified in that experiment
(e.g., SAGE tags, peptides). Each Platform record is assigned a unique and stable GEO accession
number (GPLxxx). A Platform may reference many Samples that have been submitted by multiple
submitters.

A Sample record describes the conditions under which an individual Sample was handled, the ma-
nipulations it underwent, and the abundance measurement of each element derived from it. Each
Sample record is assigned a unique and stable GEO accession number (GSMxxx). A Sample entity
must reference only one Platform and may be included in multiple Series.

A Series record defines a set of related Samples considered to be part of a group, how the Samples
are related, and if and how they are ordered. A Series provides a focal point and description of the
experiment as a whole. Series records may also contain tables describing extracted data, summary
conclusions, or analyses. Each Series record is assigned a unique and stable GEO accession number
(GSExxx).

GEO DataSets (GDSxxx) are curated sets of GEO Sample data. A GDS record represents a col-
lection of biologically and statistically comparable GEO Samples and forms the basis of GEO’s
suite of data display and analysis tools. Samples within a GDS refer to the same Platform, that is,
they share a common set of probe elements. Value measurements for each Sample within a GDS
are assumed to be calculated in an equivalent manner, that is, considerations such as background
processing and normalization are consistent across the dataset. Information reflecting experimental
design is provided through GDS subsets.

Value

An object of the appropriate class (GDS, GPL, GSM, or GSE) is returned. If the GSEMatrix option
is used, then a list of ExpressionSet objects is returned, one for each SeriesMatrix file associated

getGEOfile

9

with the GSE accesion. If the filename argument is used in combination with a GSEMatrix file,
then the return value is a single ExpressionSet.

Warning

Some of the files that are downloaded, particularly those associated with GSE entries from GEO are
absolutely ENORMOUS and parsing them can take quite some time and memory. So, particularly
when working with large GSE entries, expect that you may need a good chunk of memory and that
coffee may be involved when parsing....

Author(s)

Sean Davis

See Also

getGEOfile

Examples

gds <- getGEO('GDS10')
gds

gse <- getGEO('GSE10')
# Returns a list, so look at first item

gse[[1]]

getGEOfile

Download a file from GEO soft file to the local machine

Description

This function simply downloads a SOFT format file associated with the GEO accession number
given.

Usage

getGEOfile(

GEO,
destdir = tempdir(),
AnnotGPL = FALSE,
amount = c("full", "brief", "quick", "data")

)

Arguments

GEO

Character string, the GEO accession for download (eg., GDS84, GPL96, GSE2553,
or GSM10)

destdir

Directory in which to store the resulting downloaded file. Defaults to tempdir()

10

AnnotGPL

amount

Details

getGEOSeriesFileListing

A boolean defaulting to FALSE as to whether or not to use the Annotation GPL
information. These files are nice to use because they contain up-to-date infor-
mation remapped from Entrez Gene on a regular basis. However, they do not
exist for all GPLs; in general, they are only available for GPLs referenced by a
GDS

Amount of information to pull from GEO. Only applies to GSE, GPL, or GSM.
See details...

This function downloads GEO SOFT files based on accession number. It does not do any parsing.
The first two arguments should be fairly self-explanatory, but the last is based on the input to the
acc.cgi url at the geo website. In the default ’full’ mode, the entire SOFT format file is downloaded.
Both ’brief’ and ’quick’ offer shortened versions of the files, good for ’peeking’ at the file before
a big download on a slow connection. Finally, ’data’ downloads only the data table part of the
SOFT file and is good for downloading a simple EXCEL-like file for use with other programs (a
convenience).

Value

Invisibly returns the full path of the downloaded file.

Author(s)

Sean Davis

References

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi

See Also

getGEO

Examples

# myfile <- getGEOfile('GDS10')

getGEOSeriesFileListing

GSE Supplemental file listing

Description

The GEO Series records often have one or more supplemental files. In most cases, those files are
archived as ’.tar’ files, the contents of which are only available in a file listing file not present on the
website for download.

Usage

getGEOSeriesFileListing(GSE)

getGEOSuppFiles

Arguments

GSE

Details

character(1) the GSE accession

This function reads that file listing file and returns the results as a data.frame.

11

Value

A data.frame with 5 columns. See example.

Examples

getGEOSeriesFileListing('GSE288770')

getGEOSuppFiles

Get Supplemental Files from GEO

Description

NCBI GEO allows supplemental files to be attached to GEO Series (GSE), GEO platforms (GPL),
and GEO samples (GSM). This function ’knows’ how to get these files based on the GEO accession.
No parsing of the downloaded files is attempted, since the file format is not generally knowable by
the computer.

Usage

getGEOSuppFiles(

GEO,
makeDirectory = TRUE,
baseDir = getwd(),
fetch_files = TRUE,
filter_regex = NULL

)

Arguments

GEO

makeDirectory

baseDir

fetch_files

filter_regex

A GEO accession number such as GPL1073 or GSM1137

Should a ’subdirectory’ for the downloaded files be created? Default is TRUE.
If FALSE, the files will be downloaded directly into the baseDir.

The base directory for the downloads. Default is the current working directory.

logical(1). If TRUE, then actually download the files. If FALSE, just return the
filenames that would have been downloaded. Useful for testing and getting a list
of files without actual download.

A character(1) regular expression that will be used to filter the filenames from
GEO to limit those files that will be downloaded. This is useful to limit to, for
example, bed files only.

12

Details

Again, just a note that the files are simply downloaded.

Value

getGEOSuppFileURL

If fetch_files=TRUE, a data frame is returned invisibly with rownames representing the full path
of the resulting downloaded files and the records in the data.frame the output of file.info for each
downloaded file. If fetch_files=FALSE, a data.frame of URLs and filenames is returned.

Author(s)

Sean Davis sdavis2@mail.nih.gov

Examples

a <- getGEOSuppFiles('GSM1137', fetch_files = FALSE)
a

# with a set of single-cell RNA-seq data
a <- getGEOSuppFiles('GSE161228', fetch_files = FALSE)
a

getGEOSuppFileURL

Get GEO supplemental file URL for a given GEO accession

Description

Get GEO supplemental file URL for a given GEO accession

Usage

getGEOSuppFileURL(GEO)

Arguments

GEO

Examples

# an example of a GEO supplemental file URL
# with a set of single-cell RNA-seq data
url = getGEOSuppFileURL("GSE161228")
url

## Not run:

browseURL(url)

## End(Not run)

getGSEDataTables

13

getGSEDataTables

Get GSE data tables from GEO into R data structures.

Description

In some cases, instead of individual sample records (GSM) containing information regarding sam-
ple phenotypes, the GEO Series contains that information in an attached data table. And example
is given by GSE3494 where there are two data tables with important information contained within
them. Using getGEO with the standard parameters downloads the GSEMatrix file which, unfor-
tunately, does not contain the information in the data tables. This function simply downloads the
“header” information from the GSE record and parses out the data tables into R data.frames.

Usage

getGSEDataTables(GSE)

Arguments

GSE

Value

The GSE identifier, such as “GSE3494”.

A list of data.frames.

Author(s)

Sean Davis sdavis2@mail.nih.gov

See Also

getGEO

Examples

dfl = getGSEDataTables('GSE3494')
lapply(dfl,head)

getGSEDownloadPageURLs

get all download links from a GEO accession

Description

This function gets all download links from a GEO accession number.

Usage

getGSEDownloadPageURLs(gse)

14

Arguments

gse

Value

GEO accession number

A character vector with all download links

getRNAQuantRawCountsURL

getRNAQuantAnnotationURL

Get the RNA-seq quantification annotation link

Description

This function extracts the link to the RNA-seq quantification annotation file from a geoDownload-
Links object.

Usage

getRNAQuantAnnotationURL(links)

Arguments

links

Value

A geoDownloadLinks object

A character vector with the link to the annotation file

getRNAQuantRawCountsURL

Get the link to the raw counts file from GEO

Description

This function extracts the link to the raw counts file from a geoDownloadLinks object.

Usage

getRNAQuantRawCountsURL(links)

Arguments

links

Value

A geoDownloadLinks object

A character vector with the link to the raw counts file

getRNASeqData

15

getRNASeqData

Get GEO RNA-seq quantifications as a SummarizedExperiment object

Description

For human and mouse GEO datasets, NCBI GEO attempts to process the raw data and provide
quantifications in the form of raw counts and an annotation file. This function downloads the raw
counts and annotation files from GEO and merges that with the metadata from the GEO object to
create a SummarizedExperiment.

Usage

getRNASeqData(accession)

Arguments

accession

GEO accession number

Details

A major barrier to fully exploiting and reanalyzing the massive volumes of public RNA-seq data
archived by SRA is the cost and effort required to consistently process raw RNA-seq reads into
concise formats that summarize the expression results. To help address this need, the NCBI SRA
and GEO teams have built a pipeline that precomputes RNA-seq gene expression counts and de-
livers them as count matrices that may be incorporated into commonly used differential expression
analysis and visualization software.

The pipeline processes RNA-seq data from SRA using the HISAT2 aligner and and then generates
gene expression counts using the featureCounts program.

See the GEO documentation for more details.

Value

A SummarizedExperiment object with the raw counts as the counts assay, the annotation as the
rowData, and the metadata from GEO as the colData.

Examples

se <- getRNASeqData("GSE164073")
se

16

getRNASeqQuantResults

getRNASeqQuantGenomeInfo

Extract genome build and species for GEO RNA-seq quantification

Description

This function extracts the genome build and species information for a GEO RNA-seq quantification.

Usage

getRNASeqQuantGenomeInfo(gse)

Arguments

gse

Value

GEO accession number

A character vector with the genome build and species information

Examples

getRNASeqQuantGenomeInfo("GSE164073")

getRNASeqQuantResults Get RNA-seq quantification and annotation from GEO

Description

This function downloads the raw counts and annotation files from GEO for a given GEO accession
number.

Usage

getRNASeqQuantResults(gse)

Arguments

gse

Value

GEO accession number

A list with two elements: quants (a matrix of raw counts) and annotation (a data frame of annotation
information).

GPL-class

17

GPL-class

Class ’GPL’

Description

Contains a full GEO Platform entity

Objects from the Class

Objects can be created by calls of the form new('GPL', ...).

Author(s)

Sean Davis

See Also

GEOData-class

GSE-class

Class ’GSE’

Description

Contains a GEO Series entity

Objects from the Class

Objects can be created by calls of the form new('GSE', ...).

Author(s)

Sean Davis

See Also

GPL-class,GSM-class

18

hasRNASeqQuantifications

GSM-class

Class ’GSM’

Description

A class containing a GEO Sample entity

Objects from the Class

Objects can be created by calls of the form new('GSM', ...).

Author(s)

Sean Davis

See Also

GEOData-class

hasRNASeqQuantifications

Does a GEO accession have RNA-seq quantifications?

Description

This function checks if a GEO accession number has RNA-seq quantifications available. It does
this by checking if the GEO accession number has a "RNA-Seq raw counts" link available on the
GEO download page.

Usage

hasRNASeqQuantifications(accession)

Arguments

accession

GEO accession number

Value

TRUE if the GEO accession number has RNA-seq quantifications available, FALSE otherwise.

Examples

hasRNASeqQuantifications("GSE164073")

parseGEO

19

parseGEO

Parse GEO text

Description

Workhorse GEO parsers.

Usage

parseGEO(
fname,
GSElimits,
destdir = tempdir(),
AnnotGPL = FALSE,
getGPL = TRUE

)

Arguments

fname

GSElimits

destdir

AnnotGPL

getGPL

Details

The filename of a SOFT format file. If the filename ends in .gz, a gzfile() con-
nection is used to read the file directly.

Used to limit the number of GSMs parsed into the GSE object; useful for mem-
ory management for large GSEs.

The destination directory into which files will be saved (to be used for caching)

Fetch the annotation GPL if available

Fetch the GPL associated with a GSEMatrix entity (should remain TRUE for all
normal use cases)

These are probably not useful to the end-user. Use getGEO to access these functions. parseGEO
simply delegates to the appropriate specific parser. There should be no reason to use the parseGPL,
parseGDS, parseGSE, or parseGSM functions directly.

Value

parseGEO returns an object of the associated type. For example, if it is passed the text from a GDS
entry, a GDS object is returned.

Author(s)

Sean Davis

See Also

getGEO

20

readRNAQuantAnnotation

parseGSEMatrix

Parse a GSE mstrix file

Description

Not meant for user calling, but parses a single GSEMatrix file.

Usage

parseGSEMatrix(

fname,
AnnotGPL = FALSE,
destdir = tempdir(),
getGPL = TRUE,
parseCharacteristics = TRUE

)

Arguments

fname

AnnotGPL

destdir

filename

set to TRUE to get the annotation GPL version

the destdination directory for download

getGPL
parseCharacteristics

whether or not to get the GPL associated

Whether or not to do full ’characteristic’ parsing

readRNAQuantAnnotation

Read RNA-seq quantification annotation from GEO

Description

This function reads the annotation file from a GEO link. The annotation file is expected to be a tab-
separated file with the first column containing the gene IDs and the remaining columns containing
the annotation information.

Usage

readRNAQuantAnnotation(link)

Arguments

link

Value

A link to the annotation file

A data frame of annotation information with gene IDs as row names

readRNAQuantRawCounts

21

readRNAQuantRawCounts Read raw counts from GEO

Description

This function reads the raw counts from a GEO link. The raw counts are expected to be in a tab-
separated file with the first column containing the gene IDs and the remaining columns containing
the raw counts.

Usage

readRNAQuantRawCounts(link)

Arguments

link

Details

A link to the raw counts file

This function reads the raw counts and returns a matrix with the gene IDs as the row names, ready
for use in creating a SummarizedExperiment.

Value

A matrix of raw counts with gene IDs as row names

searchFieldsGEO

Provide a list of possible search fields for GEO search

Description

Provide a list of possible search fields for GEO search

Usage

searchFieldsGEO()

Value

a data.frame with names of possible search fields for GEO search as well as descriptions, data types,
etc. for each field. Fields are in rows and their properties are in columns.

See Also

searchGEO

Examples

searchFieldsGEO()

22

searchGEO

searchGEO

Search GEO database

Description

This function searches the GDS database, and return a data.frame for all the search results.

Usage

searchGEO(query, step = 500L)

Arguments

query

step

Details

character, the search term. The NCBI uses a search term syntax which can be
associated with a specific search field with square brackets. So, for instance
"Homo sapiens[ORGN]" denotes a search for Homo sapiens in the “Organism”
field. Details see https://www.ncbi.nlm.nih.gov/geo/info/qqtutorial.
html. The names and definitions of these fields can be identified using search-
FieldsGEO.

the number of records to fetch from the database each time. You may choose a
smaller value if failed.

The NCBI allows users to access more records (10 per second) if they register for and use an API
key. set_entrez_key function allows users to set this key for all calls to rentrez functions during a
particular R session. You can also set an environment variable ENTREZ_KEY by Sys.setenv. Once this
value is set to your key rentrez will use it for all requests to the NCBI. Details see https://docs.
ropensci.org/rentrez/articles/rentrez_tutorial.html#rate-limiting-and-api-keys

Value

a data.frame contains the search results

See Also

searchFieldsGEO

Examples

## Not run:
searchGEO("diabetes[ALL] AND Homo sapiens[ORGN] AND GSE[ETYP]")

## End(Not run)

urlExtractRNASeqQuantGenomeInfo

23

urlExtractRNASeqQuantGenomeInfo

Extract genome build and species from a GEO download URL

Description

This function extracts the genome build and species information from a GEO download URL. The
genome build and species information is expected to be in the filename of the download URL.

Usage

urlExtractRNASeqQuantGenomeInfo(url)

Arguments

url

Value

A GEO annotation file download URL

A character vector with the genome build and species information

urlForAccession

The URL for a GEO accession

Description

Sometimes, you just need the URL for a GEO accession. This function returns the URL for a given
GEO accession number that can be used to access the GEO page for that accession.

Usage

urlForAccession(geo)

Arguments

geo

Value

A GEO accession number

A character vector with the URL for the GEO accession

See Also

browseGEOAccession

Examples

urlForAccession("GSE262484")

Index

∗ IO

coercion, 3
GEOData-accessors, 5
getGEO, 7
getGEOfile, 9
getGEOSuppFiles, 11
getGSEDataTables, 13
parseGEO, 19

∗ classes

GDS-class, 5
GEOData-class, 6
GEODataTable-class, 6
GPL-class, 17
GSE-class, 17
GSM-class, 18

∗ database

getGEOSuppFiles, 11

∗ internal

extractFilenameFromDownloadURL, 4
getGSEDownloadPageURLs, 13
getRNAQuantAnnotationURL, 14
getRNAQuantRawCountsURL, 14
getRNASeqQuantResults, 16
parseGSEMatrix, 20
readRNAQuantAnnotation, 20
readRNAQuantRawCounts, 21
urlExtractRNASeqQuantGenomeInfo,

23

Accession (GEOData-accessors), 5
Accession,GEOData-method
(GEOData-class), 6

Accession,GEODataTable-method
(GEODataTable-class), 6

browseGEOAccession, 2, 23
browseWebsiteRNASeqSearch, 3

coercion, 3
Columns (GEOData-accessors), 5
Columns,GEOData-method (GEOData-class),

6

Columns,GEODataTable-method

(GEODataTable-class), 6

dataTable (GEOData-accessors), 5
dataTable,GEOData-method
(GEOData-class), 6

dataTable,GEODataTable-method
(GEODataTable-class), 6

extractFilenameFromDownloadURL, 4

GDS-class, 5
GDS2eSet (coercion), 3
GDS2MA (coercion), 3
GEOData-accessors, 5
GEOData-class, 6
GEODataTable-class, 6
getDirListing, 6
getGEO, 7, 10, 13, 19
getGEOfile, 9, 9
getGEOSeriesFileListing, 10
getGEOSuppFiles, 11
getGEOSuppFileURL, 12
getGSEDataTables, 13
getGSEDownloadPageURLs, 13
getRNAQuantAnnotationURL, 14
getRNAQuantRawCountsURL, 14
getRNASeqData, 15
getRNASeqQuantGenomeInfo, 16
getRNASeqQuantResults, 16
GPL (GPL-class), 17
GPL,GDS-method (GPL-class), 17
GPL-class, 17
GPLList (GEOData-accessors), 5
GPLList,GSE-method (GSE-class), 17
GSE-class, 17
GSM-class, 18
GSMList (GEOData-accessors), 5
GSMList,GSE-method (GSE-class), 17

hasRNASeqQuantifications, 18

Meta (GEOData-accessors), 5
Meta,GEOData-method (GEOData-class), 6
Meta,GEODataTable-method

(GEODataTable-class), 6
Meta,GSE-method (GSE-class), 17

24

25

INDEX

parseGDS (parseGEO), 19
parseGEO, 19
parseGPL (parseGEO), 19
parseGSE (parseGEO), 19
parseGSEMatrix, 20
parseGSM (parseGEO), 19

readRNAQuantAnnotation, 20
readRNAQuantRawCounts, 21

searchFieldsGEO, 21, 22
searchGEO, 21, 22
set_entrez_key, 22
show,GEOData-method (GEOData-class), 6
show,GEODataTable-method

(GEODataTable-class), 6

Sys.setenv, 22

Table (GEOData-accessors), 5
Table,GEOData-method (GEOData-class), 6
Table,GEODataTable-method

(GEODataTable-class), 6

urlExtractRNASeqQuantGenomeInfo, 23
urlForAccession, 3, 23

