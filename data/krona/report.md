# krona CWL Generation Report

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

