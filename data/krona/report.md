# krona CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| krona_ktClassifyBLAST | Not completed | has no -tax option, so it needs the taxonomy database inside the image, which is missing (Taxonomy not found); cannot be tested |
| krona_ktGetContigMagnitudes | PASS | real ACE file from a CAP3 assembly of real reads; contig magnitudes 3, 5, 2, 2, 2, 2 match the file header |
| krona_ktGetLCA | PASS | full NCBI taxonomy built from taxdump; accession plus taxon 562 give 562; streaming mode also run |
| krona_ktGetTaxIDFromAcc | PASS | full NCBI taxonomy and a small accession list; MT192765.1 gives 2697049, NC_000913.3 gives 511145; stdin, -f and -p also run |
| krona_ktGetTaxInfo | PASS | full NCBI taxonomy and a small accession list; SARS-CoV-2 and Homo sapiens lineage lines correct; stdin, -f and -a also run |
| krona_ktImportBLAST | PASS | BLAST table made with blastn from real reads; tiny taxonomy and accession file |
| krona_ktImportDiskUsage | PASS | small test folder; chart lists the folder, sub-folder and files with their sizes |
| krona_ktImportEC | PASS | 25 real E. coli EC numbers from UniProt; counts match per EC class (for example 8 transferases); also run with column options |
| krona_ktImportFCP | PASS | synthetic data: planted FCP table with real taxon names; counts 12, 8, 5 and 3 match |
| krona_ktImportGalaxy | PASS | synthetic data: planted Galaxy taxonomic representation with real taxon names; counts match |
| krona_ktImportKrona | PASS | real BLAST Krona chart re-imported; renamed root shows 50 reads |
| krona_ktImportMGRAST | PASS | synthetic data: planted MG-RAST table export (live MG-RAST service did not answer); abundances 40 and 25 match |
| krona_ktImportPhymmBL | PASS | synthetic data: planted PhymmBL results.03 table; counts 6 and 4 match |
| krona_ktImportRDP | PASS | real RDP Classifier output for three NCBI 16S rRNA sequences; E. coli, Bacillus and Pseudomonas genera found; also run with minimum confidence |
| krona_ktImportTaxonomy | PASS | taxonomy database was the tiny nf-core krona_taxonomy.tab |
| krona_ktImportText | PASS |  |
| krona_ktImportXML | PASS | XML taken from a real BLAST Krona chart; chart has root with 50 reads and the SARS-CoV-2 lineage |
| krona_ktUpdateTaxonomy.sh | Not completed | needs download of the NCBI taxonomy (large, network); baseCommand fixed to ktUpdateTaxonomy.sh |

## krona_ktUpdateTaxonomy.sh

### Tool Description
Update the Krona taxonomy database.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Total Downloads**: 136.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marbl/Krona
- **Stars**: N/A
### Original Help Text
```text
updateTaxonomy.sh [options...] [/custom/dir]

   [/custom/dir]  Taxonomy will be built in this directory instead of the
                  directory specified during installation. This custom
                  directory can be referred to with -tax in import scripts.

   --only-fetch   Only download source files; do not build.

   --only-build   Assume source files exist; do not fetch.

   --preserve     Do not remove source files after build.
```


## krona_ktImportText

### Tool Description
Creates a Krona chart from text files listing quantities and lineages.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
_________________________________
__________________________________________/ KronaTools 2.8.1 - ktImportText \___

Creates a Krona chart from text files listing quantities and lineages.
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportText \
   [options] \
   text_1[,name_1] \
   [text_2[,name_2]] \
   ...

   text  Tab-delimited text file. Each line should be a number followed by a
         list of wedges to contribute to (starting from the highest level). If
         no wedges are listed (and just a quantity is given), it will
         contribute to the top level. If the same lineage is listed more than
         once, the values will be added. Quantities can be omitted if -q is
         specified. Lines beginning with "#" will be ignored. By default,
         separate datasets will be created for each input (see [-c]).

   name  A name to show in the list of datasets in the Krona chart (if
         multiple input files are present and [-c] is not specified). By
         default, the basename of the file will be used.
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]  Output file name. [Default: 'text.krona.html']

   [-n <string>]  Name of the highest level. [Default: 'all']

   [-q]           Files do not have a field for quantity.

   [-c]           Combine data from each file, rather than creating separate
                  datasets within the chart.

   [-u <string>]  URL of Krona resources to use instead of bundling them with
                  the chart (e.g. "http://krona.sourceforge.net"). Reduces size
                  of charts and allows updates, though charts will not work
                  without access to this URL.
```


## krona_ktImportBLAST

### Tool Description
Creates a Krona chart of taxonomic classifications computed from tabular BLAST results.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
__________________________________
_________________________________________/ KronaTools 2.8.1 - ktImportBLAST \___

Creates a Krona chart of taxonomic classifications computed from tabular BLAST
results.
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportBLAST \
   [options] \
   blast_output_1[:magnitudes_1][,name_1] \
   [blast_output_2[:magnitudes_2][,name_2]] \
   ...

   blast_output  File containing BLAST results in tabular format ("Hit table
                 (text)" when downloading from NCBI). If running BLAST locally,
                 subject IDs in the local database must contain accession
                 numbers, either bare or in the fourth field of the
                 pipe-separated ("gi|12345|xx|ABC123.1|") format. By default,
                 separate datasets will be created for each input (see [-c]).

   magnitudes    Optional file listing query IDs with magnitudes, separated by
                 tabs. This can be used to account for read length or contig
                 depth to obtain a more accurate representation of abundance.
                 By default, query sequences without specified magnitudes will
                 be assigned a magnitude of 1. Magnitude files for assemblies
                 in ACE format can be created with ktGetContigMagnitudes.

   name          A name to show in the list of datasets in the Krona chart (if
                 multiple input files are present and [-c] is not specified).
                 By default, the basename of the file will be used.
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]    Output file name. [Default: 'blast.krona.html']

   [-n <string>]    Name of the highest level. [Default: 'Root']

   [-t <number>]    Threshold for bit score differences when determining
                    "best" hits. Hits with scores that are within this distance
                    of the highest score will be included when computing the
                    lowest common ancestor (or picking randomly if -r is
                    specified). [Default: '3']

   [-i]             Include a wedge for queries with no hits.

   [-f]             If any best hits have unknown accessions, force
                    classification to root instead of ignoring them.

   [-r]             Pick from the best hits randomly instead of finding the
                    lowest common ancestor.

   [-p]             Use percent identity for average scores instead of log[10]
                    e-value.

   [-b]             Use bit score for average scores instead of log[10]
                    e-value.

   [-c]             Combine data from each file, rather than creating separate
                    datasets within the chart.

   [-d <integer>]   Maximum depth of wedges to include in the chart.

   [-k]             Show the "cellular organisms" taxon (collapsed by
                    default).

   [-K]             Collapse assignments to taxa with ranks labeled "no rank"
                    by moving up to parent.

   [-x <integer>]   Hue (0-360) for "bad" scores. [Default: '0']

   [-y <integer>]   Hue (0-360) for "good" scores. [Default: '120']

   [-u <string>]    URL of Krona resources to use instead of bundling them
                    with the chart (e.g. "http://krona.sourceforge.net").
                    Reduces size of charts and allows updates, though charts
                    will not work without access to this URL.

   [-qp <string>]   Url to send query IDs to (instead of listing them) for
                    each wedge. The query IDs will be sent as a comma separated
                    list in the POST variable "queries", with the current
                    dataset index (from 0) in the POST variable "dataset". The
                    url can include additional variables encoded via GET.

   [-tax <string>]  Path to directory containing a taxonomy database to use.
                    [Default: '/usr/local/opt/krona/taxonomy']

   [-e <number>]    E-value factor for determining "best" hits. A bit score
                    difference threshold (-t) is recommended instead to avoid
                    comparing e-values that BLAST reports as 0 due to floating
                    point underflow. However, an e-value factor should be used
                    if the input is a concatination of BLASTs against different
                    databases.
```


## krona_ktImportTaxonomy

### Tool Description
Creates a Krona chart based on taxonomy IDs and, optionally, magnitudes and scores. Taxonomy IDs corresponding to a rank of "no rank" in the database will be assigned to their parents to make the hierarchy less cluttered (e.g. "Cellular organisms" will be assigned to "root").

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
_____________________________________
______________________________________/ KronaTools 2.8.1 - ktImportTaxonomy \___

Creates a Krona chart based on taxonomy IDs and, optionally, magnitudes and
scores. Taxonomy IDs corresponding to a rank of "no rank" in the database will
be assigned to their parents to make the hierarchy less cluttered (e.g.
"Cellular organisms" will be assigned to "root").
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportTaxonomy \
   [options] \
   taxonomy_1[:magnitudes_1][,name_1] \
   [taxonomy_2[:magnitudes_2][,name_2]] \
   ...

   taxonomy    Tab-delimited file with taxonomy IDs and (optionally) query
               IDs, magnitudes and scores. By default, query IDs, taxonomy IDs
               and scores will be taken from columns 1, 2 and 3, respectively
               (see -q, -t, -s, and -m). Lines beginning with "#" will be
               ignored. By default, separate datasets will be created for each
               input (see [-c]).

   magnitudes  Optional file listing query IDs with magnitudes, separated by
               tabs. This can be used to account for read length or contig
               depth to obtain a more accurate representation of abundance. By
               default, query sequences without specified magnitudes will be
               assigned a magnitude of 1. Magnitude files for assemblies in ACE
               format can be created with ktGetContigMagnitudes.

   name        A name to show in the list of datasets in the Krona chart (if
               multiple input files are present and [-c] is not specified). By
               default, the basename of the file will be used.
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]    Output file name. [Default: 'taxonomy.krona.html']

   [-n <string>]    Name of the highest level. [Default: 'Root']

   [-i]             Include a wedge for queries with no hits.

   [-c]             Combine data from each file, rather than creating separate
                    datasets within the chart.

   [-q <integer>]   Column of input files to use as query ID. Required if
                    magnitude files are specified. [Default: '1']

   [-t <integer>]   Column of input files to use as taxonomy ID. [Default:
                    '2']

   [-s <integer>]   Column of input files to use as score. [Default: '3']

   [-m <integer>]   Column of input files to use as magnitude. If magnitude
                    files are specified, their magnitudes will override those
                    in this column.

   [-d <integer>]   Maximum depth of wedges to include in the chart.

   [-k]             Show the "cellular organisms" taxon (collapsed by
                    default).

   [-K]             Collapse assignments to taxa with ranks labeled "no rank"
                    by moving up to parent.

   [-x <integer>]   Hue (0-360) for "bad" scores. [Default: '0']

   [-y <integer>]   Hue (0-360) for "good" scores. [Default: '120']

   [-u <string>]    URL of Krona resources to use instead of bundling them
                    with the chart (e.g. "http://krona.sourceforge.net").
                    Reduces size of charts and allows updates, though charts
                    will not work without access to this URL.

   [-qp <string>]   Url to send query IDs to (instead of listing them) for
                    each wedge. The query IDs will be sent as a comma separated
                    list in the POST variable "queries", with the current
                    dataset index (from 0) in the POST variable "dataset". The
                    url can include additional variables encoded via GET.

   [-tax <string>]  Path to directory containing a taxonomy database to use.
                    [Default: '/usr/local/opt/krona/taxonomy']
```


## krona_ktImportXML

### Tool Description
Creates a Krona chart from xml data describing each node and how the chart should look.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
________________________________
___________________________________________/ KronaTools 2.8.1 - ktImportXML \___

Creates a Krona chart from xml data describing each node and how the chart
should look.
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportXML [options] <XML_file>

   XML_file  A file containing XML tags that specify chart attributes and
             describe the node hierarchy. An XML header is not necessary. For a
             complete description of XML tags, see:
             https://sourceforge.net/p/krona/wiki/KronaTools/
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]  Output file name. [Default: 'xml.krona.html']

   [-u <string>]  URL of Krona resources to use instead of bundling them with
                  the chart (e.g. "http://krona.sourceforge.net"). Reduces size
                  of charts and allows updates, though charts will not work
                  without access to this URL.
```

## krona_ktImportKrona

### Tool Description
Creates a Krona chart from the data in other Krona charts.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
__________________________________
_________________________________________/ KronaTools 2.8.1 - ktImportKrona \___

Creates a Krona chart from the data in other Krona charts.
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportKrona \
   [options] \
   krona_chart_1[:magnitudes_1][,name_1] \
   [krona_chart_2[:magnitudes_2][,name_2]] \
   ...

   krona_chart  Krona HTML file created with KronaTools or the Krona Excel
                Template By default, separate datasets will be created for each
                input (see [-c]).

   magnitudes   Optional file listing query IDs with magnitudes, separated by
                tabs. This can be used to account for read length or contig
                depth to obtain a more accurate representation of abundance. By
                default, query sequences without specified magnitudes will be
                assigned a magnitude of 1. Magnitude files for assemblies in
                ACE format can be created with ktGetContigMagnitudes.

   name         A name to show in the list of datasets in the Krona chart (if
                multiple input files are present and [-c] is not specified). By
                default, the basename of the file will be used.
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]   Output file name. [Default: 'krona.krona.html']

   [-n <string>]   Name of the highest level.

   [-c]            Combine data from each file, rather than creating separate
                   datasets within the chart.

   [-d <integer>]  Maximum depth of wedges to include in the chart.

   [-x <integer>]  Hue (0-360) for "bad" scores.

   [-y <integer>]  Hue (0-360) for "good" scores.

   [-u <string>]   URL of Krona resources to use instead of bundling them with
                   the chart (e.g. "http://krona.sourceforge.net"). Reduces
                   size of charts and allows updates, though charts will not
                   work without access to this URL.

   [-qp <string>]  Url to send query IDs to (instead of listing them) for each
                   wedge. The query IDs will be sent as a comma separated list
                   in the POST variable "queries", with the current dataset
                   index (from 0) in the POST variable "dataset". The url can
                   include additional variables encoded via GET.
```

## krona_ktImportDiskUsage

### Tool Description
Creates a Krona chart of disk usage of files and folders in the specified directory. Symbolic links and mount points within the directory are not followed. Small files or folders (that are less than 0.1% of the total size) will be grouped. The chart can be colored by log[10] of the number of days since each file or folder was modified.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
______________________________________
_____________________________________/ KronaTools 2.8.1 - ktImportDiskUsage \___

Creates a Krona chart of disk usage of files and folders in the specified
directory. Symbolic links and mount points within the directory are not
followed. Small files or folders (that are less than 0.1% of the total size)
will be grouped. The chart can be colored by log[10] of the number of days
since each file or folder was modified.
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportDiskUsage [options] <dir>
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]  Output file name. [Default: 'du.krona.html']

   [-u <string>]  URL of Krona resources to use instead of bundling them with
                  the chart (e.g. "http://krona.sourceforge.net"). Reduces size
                  of charts and allows updates, though charts will not work
                  without access to this URL.
```

## krona_ktImportEC

### Tool Description
Creates a Krona chart of abundances of EC (Enzyme Commission) numbers in tab-delimited files.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
_______________________________
____________________________________________/ KronaTools 2.8.1 - ktImportEC \___

Creates a Krona chart of abundances of EC (Enzyme Commission) numbers in
tab-delimited files.
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportEC \
   [options] \
   ec_numbers_1[:magnitudes_1][,name_1] \
   [ec_numbers_2[:magnitudes_2][,name_2]] \
   ...

   ec_numbers  Tab-delimited files with EC numbers and (optionally) query IDs,
               magnitudes and scores. By default, query IDs, EC numbers and
               scores will be taken from columns 1, 2 and 3, respectively (see
               -q, -e, -s, and -m). By default, separate datasets will be
               created for each input (see [-c]).

   magnitudes  Optional file listing query IDs with magnitudes, separated by
               tabs. This can be used to account for read length or contig
               depth to obtain a more accurate representation of abundance. By
               default, query sequences without specified magnitudes will be
               assigned a magnitude of 1. Magnitude files for assemblies in ACE
               format can be created with ktGetContigMagnitudes.

   name        A name to show in the list of datasets in the Krona chart (if
               multiple input files are present and [-c] is not specified). By
               default, the basename of the file will be used.
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]   Output file name. [Default: 'ec.krona.html']

   [-n <string>]   Name of the highest level. [Default: 'root']

   [-c]            Combine data from each file, rather than creating separate
                   datasets within the chart.

   [-q <integer>]  Column of input files to use as query ID. Required if
                   magnitude files are specified. [Default: '1']

   [-e <integer>]  Column of input files to use as EC number. [Default: '2']

   [-s <integer>]  Column of input files to use as score. [Default: '3']

   [-m <integer>]  Column of input files to use as magnitude. If magnitude
                   files are specified, their magnitudes will override those in
                   this column.

   [-i]            Include a wedge for queries with no hits.

   [-d <integer>]  Maximum depth of wedges to include in the chart.

   [-x <integer>]  Hue (0-360) for "bad" scores. [Default: '0']

   [-y <integer>]  Hue (0-360) for "good" scores. [Default: '120']

   [-u <string>]   URL of Krona resources to use instead of bundling them with
                   the chart (e.g. "http://krona.sourceforge.net"). Reduces
                   size of charts and allows updates, though charts will not
                   work without access to this URL.

   [-qp <string>]  Url to send query IDs to (instead of listing them) for each
                   wedge. The query IDs will be sent as a comma separated list
                   in the POST variable "queries", with the current dataset
                   index (from 0) in the POST variable "dataset". The url can
                   include additional variables encoded via GET.
```

## krona_ktImportFCP

### Tool Description
Creates a Krona chart based on the results of FCP (Fragment Classification Package).

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
________________________________
___________________________________________/ KronaTools 2.8.1 - ktImportFCP \___

Creates a Krona chart based on the results of FCP (Fragment Classification
Package).
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportFCP \
   [options] \
   fcp_output_1[:magnitudes_1][,name_1] \
   [fcp_output_2[:magnitudes_2][,name_2]] \
   ...

   fcp_output  Results of running any FCP classification tool (except
               BLASTN.py, which only outputs raw BLAST results). By default,
               separate datasets will be created for each input (see [-c]).

   magnitudes  Optional file listing query IDs with magnitudes, separated by
               tabs. This can be used to account for read length or contig
               depth to obtain a more accurate representation of abundance. By
               default, query sequences without specified magnitudes will be
               assigned a magnitude of 1. Magnitude files for assemblies in ACE
               format can be created with ktGetContigMagnitudes.

   name        A name to show in the list of datasets in the Krona chart (if
               multiple input files are present and [-c] is not specified). By
               default, the basename of the file will be used.
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]   Output file name. [Default: 'fcp.krona.html']

   [-n <string>]   Name of the highest level. [Default: 'root']

   [-c]            Combine data from each file, rather than creating separate
                   datasets within the chart.

   [-d <integer>]  Maximum depth of wedges to include in the chart.

   [-u <string>]   URL of Krona resources to use instead of bundling them with
                   the chart (e.g. "http://krona.sourceforge.net"). Reduces
                   size of charts and allows updates, though charts will not
                   work without access to this URL.

   [-qp <string>]  Url to send query IDs to (instead of listing them) for each
                   wedge. The query IDs will be sent as a comma separated list
                   in the POST variable "queries", with the current dataset
                   index (from 0) in the POST variable "dataset". The url can
                   include additional variables encoded via GET.
```

## krona_ktImportGalaxy

### Tool Description
Creates a Krona chart based Galaxy taxonomic representations.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
___________________________________
________________________________________/ KronaTools 2.8.1 - ktImportGalaxy \___

Creates a Krona chart based Galaxy taxonomic representations.
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportGalaxy \
   [options] \
   tax_rep_1[,name_1] \
   [tax_rep_2[,name_2]] \
   ...

   tax_rep  Results from the "Fetch taxonomic representation" or "Find lowest
            diagnostic rank" tools in Galaxy. By default, separate datasets
            will be created for each input (see [-c]).

   name     A name to show in the list of datasets in the Krona chart (if
            multiple input files are present and [-c] is not specified). By
            default, the basename of the file will be used.
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]   Output file name. [Default: 'galaxy.krona.html']

   [-n <string>]   Name of the highest level. [Default: 'root']

   [-c]            Combine data from each file, rather than creating separate
                   datasets within the chart.

   [-d <integer>]  Maximum depth of wedges to include in the chart.

   [-u <string>]   URL of Krona resources to use instead of bundling them with
                   the chart (e.g. "http://krona.sourceforge.net"). Reduces
                   size of charts and allows updates, though charts will not
                   work without access to this URL.

   [-qp <string>]  Url to send query IDs to (instead of listing them) for each
                   wedge. The query IDs will be sent as a comma separated list
                   in the POST variable "queries", with the current dataset
                   index (from 0) in the POST variable "dataset". The url can
                   include additional variables encoded via GET.
```

## krona_ktImportMGRAST

### Tool Description
Creates a Krona chart from MG-RAST organism or functional analyses.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
___________________________________
________________________________________/ KronaTools 2.8.1 - ktImportMGRAST \___

Creates a Krona chart from MG-RAST organism or functional analyses.
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportMGRAST \
   [options] \
   mgrast_table_1[,name_1] \
   [mgrast_table_2[,name_2]] \
   ...

   mgrast_table  A table exported from MG-RAST. It can be from organism or
                 functional analysis, but all tables being imported should be
                 consistent. By default, separate datasets will be created for
                 each input (see [-c]).

   name          A name to show in the list of datasets in the Krona chart (if
                 multiple input files are present and [-c] is not specified).
                 By default, the basename of the file will be used.
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]   Output file name. [Default: 'mg-rast.krona.html']

   [-n <string>]   Name of the highest level. [Default: 'all']

   [-c]            Combine data from each file, rather than creating separate
                   datasets within the chart.

   [-d <integer>]  Maximum depth of wedges to include in the chart.

   [-x <integer>]  Hue (0-360) for "bad" scores. [Default: '0']

   [-y <integer>]  Hue (0-360) for "good" scores. [Default: '120']

   [-p]            Use percent identity for average scores instead of log[10]
                   e-value.

   [-u <string>]   URL of Krona resources to use instead of bundling them with
                   the chart (e.g. "http://krona.sourceforge.net"). Reduces
                   size of charts and allows updates, though charts will not
                   work without access to this URL.
```

## krona_ktImportPhymmBL

### Tool Description
Creates a Krona chart of Phymm or PhymmBL results. Note: Since confidence scores are not given for species/subspecies classifications, they inheret confidence scores from genus classifications.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
____________________________________
_______________________________________/ KronaTools 2.8.1 - ktImportPhymmBL \___

Creates a Krona chart of Phymm or PhymmBL results. Note: Since confidence
scores are not given for species/subspecies classifications, they inheret
confidence scores from genus classifications.
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportPhymmBL \
   [options] \
   phymmbl_results_1[:magnitudes_1][,name_1] \
   [phymmbl_results_2[:magnitudes_2][,name_2]] \
   ...

   phymmbl_results  PhymmBL results files (results.03.*). Results can also be
                    from Phymm alone (results.01.*), but [-p] must be
                    specified. By default, separate datasets will be created
                    for each input (see [-c]).

   magnitudes       Optional file listing query IDs with magnitudes, separated
                    by tabs. This can be used to account for read length or
                    contig depth to obtain a more accurate representation of
                    abundance. By default, query sequences without specified
                    magnitudes will be assigned a magnitude of 1. Magnitude
                    files for assemblies in ACE format can be created with
                    ktGetContigMagnitudes.

   name             A name to show in the list of datasets in the Krona chart
                    (if multiple input files are present and [-c] is not
                    specified). By default, the basename of the file will be
                    used.
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]   Output file name. [Default: 'phymm(bl).krona.html']

   [-n <string>]   Name of the highest level. [Default: 'all']

   [-m <number>]   Minimum confidence. Each query sequence will only be added
                   to taxa that were predicted with a confidence score of at
                   least this value.

   [-c]            Combine data from each file, rather than creating separate
                   datasets within the chart.

   [-d <integer>]  Maximum depth of wedges to include in the chart.

   [-x <integer>]  Hue (0-360) for "bad" scores. [Default: '0']

   [-y <integer>]  Hue (0-360) for "good" scores. [Default: '120']

   [-p]            Input is phymm only (no confidence scores).

   [-u <string>]   URL of Krona resources to use instead of bundling them with
                   the chart (e.g. "http://krona.sourceforge.net"). Reduces
                   size of charts and allows updates, though charts will not
                   work without access to this URL.

   [-qp <string>]  Url to send query IDs to (instead of listing them) for each
                   wedge. The query IDs will be sent as a comma separated list
                   in the POST variable "queries", with the current dataset
                   index (from 0) in the POST variable "dataset". The url can
                   include additional variables encoded via GET.
```

## krona_ktImportRDP

### Tool Description
Creates a Krona chart from RDP classifications.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
________________________________
___________________________________________/ KronaTools 2.8.1 - ktImportRDP \___

Creates a Krona chart from RDP classifications.
                                                                     _______
____________________________________________________________________/ Usage \___

ktImportRDP \
   [options] \
   rdp_details_1[,name_1] \
   [rdp_details_2[,name_2]] \
   ...

   rdp_details  RDP assignment details downloaded as text from the RDP
                Classifier web portal or output by the command line RDP
                Classifier or Multiclassifier. By default, separate datasets
                will be created for each input (see [-c]).

   name         A name to show in the list of datasets in the Krona chart (if
                multiple input files are present and [-c] is not specified). By
                default, the basename of the file will be used.
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]   Output file name. [Default: 'rdp.krona.html']

   [-n <string>]   Name of the highest level. [Default: 'root']

   [-c]            Combine data from each file, rather than creating separate
                   datasets within the chart.

   [-m <number>]   Minimum confidence. Each query sequence will only be added
                   to taxa that were predicted with a confidence score of at
                   least this value.

   [-d <integer>]  Maximum depth of wedges to include in the chart.

   [-x <integer>]  Hue (0-360) for "bad" scores. [Default: '0']

   [-y <integer>]  Hue (0-360) for "good" scores. [Default: '120']

   [-u <string>]   URL of Krona resources to use instead of bundling them with
                   the chart (e.g. "http://krona.sourceforge.net"). Reduces
                   size of charts and allows updates, though charts will not
                   work without access to this URL.

   [-qp <string>]  Url to send query IDs to (instead of listing them) for each
                   wedge. The query IDs will be sent as a comma separated list
                   in the POST variable "queries", with the current dataset
                   index (from 0) in the POST variable "dataset". The url can
                   include additional variables encoded via GET.
```

## krona_ktClassifyBLAST

### Tool Description
Assigns each query in tabular BLAST results to an NCBI taxonomy ID. If the results contain comment lines, queries with no hits will be included in the output (with taxonomy IDs of -1 for consistency with MEGAN).

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
____________________________________
_______________________________________/ KronaTools 2.8.1 - ktClassifyBLAST \___

Assigns each query in tabular BLAST results to an NCBI taxonomy ID. If the
results contain comment lines, queries with no hits will be included in the
output (with taxonomy IDs of -1 for consistency with MEGAN).
                                                                     _______
____________________________________________________________________/ Usage \___

ktClassifyBLAST \
   [options] \
   blast_output_1 \
   [blast_output_2] \
   ...

   blast_output  File containing BLAST results in tabular format ("Hit table
                 (text)" when downloading from NCBI). If running BLAST locally,
                 subject IDs in the local database must contain accession
                 numbers, either bare or in the fourth field of the
                 pipe-separated ("gi|12345|xx|ABC123.1|") format.
                                                                   _________
__________________________________________________________________/ Options \___

   [-o <string>]  Output file name. [Default: 'blast.taxonomy.tab']

   [-t <number>]  Threshold for bit score differences when determining "best"
                  hits. Hits with scores that are within this distance of the
                  highest score will be included when computing the lowest
                  common ancestor (or picking randomly if -r is specified).
                  [Default: '3']

   [-f]           If any best hits have unknown accessions, force
                  classification to root instead of ignoring them.

   [-r]           Pick from the best hits randomly instead of finding the
                  lowest common ancestor.

   [-p]           Use percent identity for average scores instead of log[10]
                  e-value.

   [-b]           Use bit score for average scores instead of log[10] e-value.

   [-s]           Summarize counts and average scores by taxonomy ID.

   [-e <number>]  E-value factor for determining "best" hits. A bit score
                  difference threshold (-t) is recommended instead to avoid
                  comparing e-values that BLAST reports as 0 due to floating
                  point underflow. However, an e-value factor should be used if
                  the input is a concatination of BLASTs against different
                  databases.

                                                                    ________
___________________________________________________________________/ Output \___

Default:          <queryID> <taxID> <score>

Summarized (-s):  <count> <taxID> <score>

   queryID  The query ID as it appears in the BLAST results.

   taxID    The NCBI taxonomy ID the query was assigned to (or -1 if it has no
            hits).

   score    The score of the assignment(s); by default, the average E-value of
            "best" hits (see -p, -b).

   count    The number of assignments.
```

## krona_ktGetContigMagnitudes

### Tool Description
Takes an ACE assembly file and writes a magnitude file for use with import scripts. The magnitude of each contig will be the total number of reads assigned to it.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
                                  __________________________________________
_________________________________/ KronaTools 2.8.1 - ktGetContigMagnitudes \___

Takes an ACE assembly file and writes a magnitude file for use with import
scripts.  The magnitude of each contig will be the total number of reads
assigned to it.

                                                                     _______
____________________________________________________________________/ Usage \___

ktGetContigMagnitudes <assembly.ace> <output>
```

## krona_ktGetLCA

### Tool Description
Computes the lowest common ancestor for accessions or taxonomy IDs (as arguments or from <stdin>). If an input is a number, it is assumed to be a taxonomy ID; otherwise it will be considered an accession or sequence ID containing an accession in the fourth field of pipe notation (e.g. "gi|12345|xx|ABC123.1|", ignoring fasta/fastq tag markers [>,@]). If using <stdin>, the LCA can be computed for the first fields of all input lines (default), or per input line, separated by whitespace (see -s).

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
Description:

   Computes the lowest common ancestor for accessions or taxonomy IDs (as
   arguments or from <stdin>). If an input is a number, it is assumed to be a
   taxonomy ID; otherwise it will be considered an accession or sequence ID
   containing an accession in the fourth field of pipe notation (e.g.
   "gi|12345|xx|ABC123.1|", ignoring fasta/fastq tag markers [>,@]). If using
   <stdin>, the LCA can be computed for the first fields of all input lines
   (default), or per input line, separated by whitespace (see -s).

Usage:

   ktGetLCA [options] [acc/tax_ID ...] [< acc/taxID_list] > LCA

Options:

   -s  Streaming mode. Each line is expected to be a whitespace-separated list 
       of inputs for a single lowest common ancestor computation. Taxonomy will
       be preloaded, allowing for faster computation after a small upfront time.
```

## krona_ktGetTaxIDFromAcc

### Tool Description
Translates accessions (from arguments or <stdin>) to NCBI taxonomy IDs. The accession can be bare or in the fourth field of pipe notation (e.g. "gi|12345|xx|ABC123.1|", ignoring fasta tag markers [">"]). Inputs that are bare numbers will be assumed to be taxonomy IDs already and preserved. Accessions with no taxonomy IDs in the database will return 0.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
Description:

   Translates accessions (from arguments or <stdin>) to NCBI taxonomy IDs. The
   accession can be bare or in the fourth field of pipe notation (e.g.
   "gi|12345|xx|ABC123.1|", ignoring fasta tag markers [">"]). Inputs that are
   bare numbers will be assumed to be taxonomy IDs already and preserved.
   Accessions with no taxonomy IDs in the database will return 0.

Usage:

   ktGetTaxIDFromAcc [options] [acc1 acc2 ...] [< acc_list] > tax_ID_list

   Command line example:
   
      ktGetTaxIDFromAcc A00001.1 A00002.1

   Fasta tag example:

      grep ">" sequence | ktGetTaxIDFromAcc > sequence.tax

Options:

   [-p]            Prepend tax IDs to the original lines (separated by tabs).
  
   [-a]            Append tax IDs to the original lines (separated by tabs).
   
   [-f] <integer>  Field of accessions. [Default: '1']
   
   [-tax <string>  Path to directory containing a taxonomy database to use.
```

## krona_ktGetTaxInfo

### Tool Description
Retrieves taxonomy information for accessions or taxonomy IDs (as arguments or the first field of <stdin>, separated by whitespace). If the input is a number, it is assumed to be a taxonomy ID; otherwise it will be considered an accession or sequence ID containing an accession in the fourth field of pipe notation (e.g. "gi|12345|xx|ABC123.1|", ignoring fasta/fastq tag markers [>,@]). If taxonomy information was not found for a given input line, the output line will be only the taxonomy ID, which will be 0 if it was looked up from an accession but not found. Output fields are: taxID, depth, parent, rank, name.

### Metadata
- **Docker Image**: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/marbl/Krona
- **Package**: https://anaconda.org/channels/bioconda/packages/krona/overview
- **Validation**: PASS

### Original Help Text
```text
Description:

   Retrieves taxonomy information for accessions or taxonomy IDs (as arguments
   or the first field of <stdin>, separated by whitespace). If the input is a
   number, it is assumed to be a taxonomy ID; otherwise it will be considered an
   accession or sequence ID containing an accession in the fourth field of pipe
   notation (e.g. "gi|12345|xx|ABC123.1|", ignoring fasta/fastq tag markers
   [>,@]). If taxonomy information was not found for a given input line, the
   output line will be only the taxonomy ID, which will be 0 if it was
   looked up from an accession but not found.
   
   Output fields are:
   taxID  depth  parent  rank  name

Usage:

   ktGetTaxInfo [IDs ...] [< ID_list] > tax_info

   Command line example:

      ktGetTaxInfo A00001.1 "gi|2|emb|A00002.1|" 9606

   Fasta tag example:

      grep ">" sequence.fasta | ktGetTaxInfo

Options:

   [-p]            Prepend tax info to the original lines (separated by tabs).
  
   [-a]            Append tax info to the original lines (separated by tabs).
   
   [-f] <integer>  Field of accessions. [Default: '1']

   [-tax <string>  Path to directory containing a taxonomy database to use.
```

## Metadata
- **Skill**: generated
