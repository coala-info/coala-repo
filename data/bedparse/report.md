# bedparse CWL Generation Report

## bedparse_3putr

### Tool Description
A tool for parsing and manipulating BED files, with various sub-commands for specific operations.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedparse:0.2.3--py_0
- **Homepage**: https://github.com/tleonardi/bedparse
- **Package**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tleonardi/bedparse
- **Stars**: N/A
### Original Help Text
```text
usage: bedparse [-h] [--version]
                {3pUTR,5pUTR,cds,promoter,introns,filter,join,gtf2bed,bed12tobed6,convertChr,validateFormat}
                ...
bedparse: error: argument sub-command: invalid choice: '3putr' (choose from '3pUTR', '5pUTR', 'cds', 'promoter', 'introns', 'filter', 'join', 'gtf2bed', 'bed12tobed6', 'convertChr', 'validateFormat')
```


## bedparse_5putr

### Tool Description
bedparse: error: argument sub-command: invalid choice: '5putr' (choose from '3pUTR', '5pUTR', 'cds', 'promoter', 'introns', 'filter', 'join', 'gtf2bed', 'bed12tobed6', 'convertChr', 'validateFormat')

### Metadata
- **Docker Image**: quay.io/biocontainers/bedparse:0.2.3--py_0
- **Homepage**: https://github.com/tleonardi/bedparse
- **Package**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bedparse [-h] [--version]
                {3pUTR,5pUTR,cds,promoter,introns,filter,join,gtf2bed,bed12tobed6,convertChr,validateFormat}
                ...
bedparse: error: argument sub-command: invalid choice: '5putr' (choose from '3pUTR', '5pUTR', 'cds', 'promoter', 'introns', 'filter', 'join', 'gtf2bed', 'bed12tobed6', 'convertChr', 'validateFormat')
```


## bedparse_cds

### Tool Description
Report the CDS of each coding transcript (i.e. transcripts with distinct
values of thickStart and thickEnd). Transcripts without CDS are not reported.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedparse:0.2.3--py_0
- **Homepage**: https://github.com/tleonardi/bedparse
- **Package**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bedparse cds [-h] [--ignoreCDSonly] [bedfile]

Report the CDS of each coding transcript (i.e. transcripts with distinct
values of thickStart and thickEnd). Transcripts without CDS are not reported.

positional arguments:
  bedfile          Path to the BED file.

optional arguments:
  -h, --help       show this help message and exit
  --ignoreCDSonly  Ignore transcripts that only consist of CDS.
```


## bedparse_promoter

### Tool Description
Report the promoter of each transcript, defined as a fixed interval around its start.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedparse:0.2.3--py_0
- **Homepage**: https://github.com/tleonardi/bedparse
- **Package**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bedparse promoter [-h] [--up UP] [--down DOWN] [--unstranded] [bedfile]

Report the promoter of each transcript, defined as a fixed interval around its
start.

positional arguments:
  bedfile       Path to the BED file.

optional arguments:
  -h, --help    show this help message and exit
  --up UP       Get this many nt upstream of each feature.
  --down DOWN   Get this many nt downstream of each feature.
  --unstranded  Do not consider strands.
```


## bedparse_introns

### Tool Description
Report BED12 lines corresponding to the introns of each transcript. Unspliced transcripts are not reported.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedparse:0.2.3--py_0
- **Homepage**: https://github.com/tleonardi/bedparse
- **Package**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bedparse introns [-h] [bedfile]

Report BED12 lines corresponding to the introns of each transcript. Unspliced
transcripts are not reported.

positional arguments:
  bedfile     Path to the BED file.

optional arguments:
  -h, --help  show this help message and exit
```


## bedparse_filter

### Tool Description
Filters a BED file based on an annotation. BED entries with a name (i.e. col4) that appears in the specified column of the annotation are printed to stdout. For efficiency reasons this command doesn't perform BED validation.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedparse:0.2.3--py_0
- **Homepage**: https://github.com/tleonardi/bedparse
- **Package**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bedparse filter [-h] --annotation ANNOTATION [--column COLUMN]
                       [--inverse]
                       [bedfile]

Filters a BED file based on an annotation. BED entries with a name (i.e. col4)
that appears in the specified column of the annotation are printed to stdout.
For efficiency reasons this command doesn't perform BED validation.

positional arguments:
  bedfile               Path to the BED file.

optional arguments:
  -h, --help            show this help message and exit
  --annotation ANNOTATION, -a ANNOTATION
                        Path to the annotation file.
  --column COLUMN, -c COLUMN
                        Column of the annotation file (1-based, default=1).
  --inverse, -v         Only report BED entries absent from the annotation
                        file.
```


## bedparse_join

### Tool Description
Adds the content of an annotation file to a BED file as extra columns. The two files are joined by matching the BED Name field (column 4) with a user-specified field of the annotation file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedparse:0.2.3--py_0
- **Homepage**: https://github.com/tleonardi/bedparse
- **Package**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bedparse join [-h] --annotation ANNOTATION [--column COLUMN]
                     [--separator SEPARATOR] [--empty EMPTY] [--noUnmatched]
                     [bedfile]

Adds the content of an annotation file to a BED file as extra columns. The two
files are joined by matching the BED Name field (column 4) with a user-
specified field of the annotation file.

positional arguments:
  bedfile               Path to the BED file.

optional arguments:
  -h, --help            show this help message and exit
  --annotation ANNOTATION, -a ANNOTATION
                        Path to the annotation file.
  --column COLUMN, -c COLUMN
                        Column of the annotation file (1-based, default=1).
  --separator SEPARATOR, -s SEPARATOR
                        Field separator for the annotation file (default tab)
  --empty EMPTY, -e EMPTY
                        String to append to empty records (default '.').
  --noUnmatched, -n     Do not print unmatched lines.
```


## bedparse_gtf2bed

### Tool Description
Converts a GTF file to BED12 format. This tool supports the Ensembl GTF
format, which uses features of type 'transcript' (field 3) to define
transcripts. In case the GTF file defines transcripts with a different feature
type, it is possible to provide the feature name from the command line. If the
GTF file also annotates 'CDS' 'start_codon' or 'stop_codon' these are used to
annotate the thickStart and thickEnd in the BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedparse:0.2.3--py_0
- **Homepage**: https://github.com/tleonardi/bedparse
- **Package**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bedparse gtf2bed [-h] [--extraFields EXTRAFIELDS]
                        [--filterKey FILTERKEY] [--filterType FILTERTYPE]
                        [--transcript_feature_name TRANSCRIPT_FEATURE_NAME]
                        [gtf]

Converts a GTF file to BED12 format. This tool supports the Ensembl GTF
format, which uses features of type 'transcript' (field 3) to define
transcripts. In case the GTF file defines transcripts with a different feature
type, it is possible to provide the feature name from the command line. If the
GTF file also annotates 'CDS' 'start_codon' or 'stop_codon' these are used to
annotate the thickStart and thickEnd in the BED file.

positional arguments:
  gtf                   Path to the GTF file.

optional arguments:
  -h, --help            show this help message and exit
  --extraFields EXTRAFIELDS
                        Comma separated list of extra GTF fields to be added
                        after col 12 (e.g. gene_id,gene_name).
  --filterKey FILTERKEY
                        GTF extra field on which to apply the filtering
  --filterType FILTERTYPE
                        Comma separated list of filterKey field values to
                        retain.
  --transcript_feature_name TRANSCRIPT_FEATURE_NAME
                        Transcript feature name. Features with this string in
                        field 3 of the GTF file will be considered
                        transcripts. (default 'transcript')
```


## bedparse_bed12tobed6

### Tool Description
Convert the BED12 format into BED6 by reporting a separate line for each block of the original record.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedparse:0.2.3--py_0
- **Homepage**: https://github.com/tleonardi/bedparse
- **Package**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bedparse bed12tobed6 [-h] [--appendExN] [--whichExon {all,first,last}]
                            [--keepIntrons]
                            [bedfile]

Convert the BED12 format into BED6 by reporting a separate line for each block
of the original record.

positional arguments:
  bedfile               Path to the GTF file.

optional arguments:
  -h, --help            show this help message and exit
  --appendExN           Appends the exon number to the transcript name.
  --whichExon {all,first,last}
                        Which exon to return. First and last respectively
                        report the first or last exon relative to the TSS
                        (i.e. taking strand into account).
  --keepIntrons         Add records for introns as well. Only allowed if
                        --whichExon all
```


## bedparse_convertchr

### Tool Description
bedparse: error: argument sub-command: invalid choice: 'convertchr' (choose from '3pUTR', '5pUTR', 'cds', 'promoter', 'introns', 'filter', 'join', 'gtf2bed', 'bed12tobed6', 'convertChr', 'validateFormat')

### Metadata
- **Docker Image**: quay.io/biocontainers/bedparse:0.2.3--py_0
- **Homepage**: https://github.com/tleonardi/bedparse
- **Package**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bedparse [-h] [--version]
                {3pUTR,5pUTR,cds,promoter,introns,filter,join,gtf2bed,bed12tobed6,convertChr,validateFormat}
                ...
bedparse: error: argument sub-command: invalid choice: 'convertchr' (choose from '3pUTR', '5pUTR', 'cds', 'promoter', 'introns', 'filter', 'join', 'gtf2bed', 'bed12tobed6', 'convertChr', 'validateFormat')
```


## bedparse_validateformat

### Tool Description
bedparse: error: argument sub-command: invalid choice: 'validateformat' (choose from '3pUTR', '5pUTR', 'cds', 'promoter', 'introns', 'filter', 'join', 'gtf2bed', 'bed12tobed6', 'convertChr', 'validateFormat')

### Metadata
- **Docker Image**: quay.io/biocontainers/bedparse:0.2.3--py_0
- **Homepage**: https://github.com/tleonardi/bedparse
- **Package**: https://anaconda.org/channels/bioconda/packages/bedparse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bedparse [-h] [--version]
                {3pUTR,5pUTR,cds,promoter,introns,filter,join,gtf2bed,bed12tobed6,convertChr,validateFormat}
                ...
bedparse: error: argument sub-command: invalid choice: 'validateformat' (choose from '3pUTR', '5pUTR', 'cds', 'promoter', 'introns', 'filter', 'join', 'gtf2bed', 'bed12tobed6', 'convertChr', 'validateFormat')
```


## Metadata
- **Skill**: generated
