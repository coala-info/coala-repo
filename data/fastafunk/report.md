# fastafunk CWL Generation Report

## fastafunk_consensus

### Tool Description
Generates consensus sequences from a FASTA file based on metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Total Downloads**: 14.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cov-ert/fastafunk
- **Stars**: N/A
### Original Help Text
```text
usage: fastafunk consensus [-h] [-v] [--log-file <filename>]
                           [--in-fasta <filename>] --in-metadata <filename>
                           --index-field <field> [--index-column <column>]
                           [--lineage LINEAGE [LINEAGE ...]]
                           [--out-fasta <filename>]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-fasta <filename>
                        One FASTA files of sequences (else reads from stdin)
  --in-metadata <filename>
                        CSV of metadata with same naming convention as fasta
                        file
  --index-field <field>
                        Field(s) in the fasta header to match the metadata
                        (else matches column names)
  --index-column <column>
                        Column(s) in the metadata file to use to match to the
                        sequence
  --lineage LINEAGE [LINEAGE ...]
                        Specific list of lineages to split by with others
                        collpasing to nearest lineage.
  --out-fasta <filename>
                        A FASTA file (else writes to stdout)
```


## fastafunk_extract

### Tool Description
Extracts sequences from FASTA files based on metadata and tree information.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk extract [-h] [-v] [--log-file <filename>] --in-fasta
                         <filename> [<filename> ...]
                         [--in-metadata <filename> [<filename> ...]]
                         [--in-tree <filename> [<filename> ...]]
                         [--out-fasta <filename>] [--reject-fasta <filename>]
                         [--low-memory]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-fasta <filename> [<filename> ...]
                        One or more FASTA files of sequences (else reads from
                        stdin)
  --in-metadata <filename> [<filename> ...]
                        One or more CSV or TSV tables of metadata
  --in-tree <filename> [<filename> ...]
                        One or more tree files in either nexus or newick
                        format
  --out-fasta <filename>
                        A FASTA file (else writes to stdout)
  --reject-fasta <filename>
                        A FASTA file to write the omitted sequences
  --low-memory          Extracts tip labels from trees using text wrangling
                        instead of dendropy
```


## fastafunk_merge

### Tool Description
Merge FASTA files and associated metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk merge [-h] [-v] [--log-file <filename>]
                       [--in-fasta <filename> [<filename> ...]] --in-metadata
                       <filename> [<filename> ...] --index-column <column>
                       --out-metadata <filename> [--out-fasta <filename>]
                       [--low-memory]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-fasta <filename> [<filename> ...]
                        One or more FASTA files of sequences (else reads from
                        stdin)
  --in-metadata <filename> [<filename> ...]
                        One or more CSV or TSV tables of metadata
  --index-column <column>
                        Column in the metadata file to use to match to the
                        sequence
  --out-metadata <filename>
                        A CSV file (else writes to stdout)
  --out-fasta <filename>
                        A FASTA file (else writes to stdout)
  --low-memory          Assumes no duplicate sequences within a FASTA so can
                        use SeqIO index
```


## fastafunk_remove

### Tool Description
Removes sequences from FASTA files based on metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk remove [-h] [-v] [--log-file <filename>] --in-fasta
                        <filename> [<filename> ...] --in-metadata <filename>
                        [<filename> ...] [--out-fasta <filename>]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-fasta <filename> [<filename> ...]
                        One or more FASTA files of sequences (else reads from
                        stdin)
  --in-metadata <filename> [<filename> ...]
                        One or more CSV or TSV tables of metadata
  --out-fasta <filename>
                        A FASTA file (else writes to stdout)
```


## fastafunk_split

### Tool Description
Split a FASTA file into multiple FASTA files based on metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk split [-h] [-v] [--log-file <filename>] --in-fasta <filename>
                       --in-metadata <filename> [--index-column <column>]
                       --index-field <field> [--lineage LINEAGE [LINEAGE ...]]
                       [--lineage-csv LINEAGE_CSV] [--aliases ALIASES]
                       [--out-folder <filename>]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-fasta <filename>
                        One FASTA files of sequences (else reads from stdin)
  --in-metadata <filename>
                        One CSV of metadata
  --index-column <column>
                        Column(s) in the metadata file to use to match to the
                        sequence
  --index-field <field>
                        Field(s) in the fasta header to match the metadata
                        (else matches column names)
  --lineage LINEAGE [LINEAGE ...]
                        Specific list of lineages to split by with others
                        collpasing to nearest lineage.
  --lineage-csv LINEAGE_CSV
                        CSV with lineage and outgroup columns defining the
                        lineages to split by.
  --aliases ALIASES     JSON with aliases for lettered lineages.
  --out-folder <filename>
                        A directory for output FASTA files
```


## fastafunk_count

### Tool Description
Count sequences based on metadata groupings.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk count [-h] [-v] [--log-file <filename>] --in-metadata
                       <filename> [<filename> ...] --group-column <column>
                       [<column> ...]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-metadata <filename> [<filename> ...]
                        One or more CSV or TSV tables of metadata
  --group-column <column> [<column> ...]
                        Column(s) in the metadata file to define groupings
```


## fastafunk_subsample

### Tool Description
Subsample FASTA files based on metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk subsample [-h] [-v] [--log-file <filename>]
                           [--in-fasta <filename> [<filename> ...]]
                           --in-metadata <filename> [<filename> ...]
                           [--index-field <field> [<field> ...]]
                           --index-column <column> --group-column <column>
                           [<column> ...] [--where-field <field>=<regex>]
                           [--out-fasta <filename>]
                           [--out-metadata <filename>]
                           [--target-file <filename>]
                           [--select-by-max-column <column>]
                           [--select-by-min-column <column>]
                           [--sample-size <int>] [--exclude-uk] [--low-memory]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-fasta <filename> [<filename> ...]
                        One or more FASTA files of sequences (else reads from
                        stdin)
  --in-metadata <filename> [<filename> ...]
                        One or more CSV or TSV tables of metadata
  --index-field <field> [<field> ...]
                        Field(s) in the fasta header to match the metadata
                        (else matches column names)
  --index-column <column>
                        Column in the metadata file to use to match to the
                        sequence
  --group-column <column> [<column> ...]
                        Column(s) in the metadata file to define groupings
  --where-field <field>=<regex>
                        Additional matches to header fields
  --out-fasta <filename>
                        A FASTA file (else writes to stdout)
  --out-metadata <filename>
                        A metadata file
  --target-file <filename>
                        CSV file of target numbers per group e.g. an edited
                        version of the count output
  --select-by-max-column <column>
                        Column in the metadata file maximize over when
                        subsetting
  --select-by-min-column <column>
                        Column in the metadata file minimize over when
                        subsetting
  --sample-size <int>   The number of samples per group to select if not
                        specified by target file
  --exclude-uk          Includes all UK samples in subsample, and additionally
                        keeps the target number of non-UK samples per group
  --low-memory          Assumes no duplicate sequences within a FASTA so can
                        use SeqIO index
```


## fastafunk_annotate

### Tool Description
Annotates FASTA sequences with metadata based on matching IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk annotate [-h] [-v] [--log-file <filename>]
                          [--in-fasta <filename> [<filename> ...]]
                          [--in-metadata <filename> [<filename> ...]]
                          [--index-field <field> [<field> ...]] --index-column
                          <column> [--out-fasta <filename>]
                          [--out-metadata <filename>]
                          [--header-delimiter <symbol>] [--add-cov-id]
                          [--low-memory]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-fasta <filename> [<filename> ...]
                        One or more FASTA files of sequences (else reads from
                        stdin)
  --in-metadata <filename> [<filename> ...]
                        One or more CSV or TSV tables of metadata
  --index-field <field> [<field> ...]
                        Field(s) in the fasta header to match the metadata
                        (else matches column names)
  --index-column <column>
                        Column in the metadata file to use to match to the
                        sequence
  --out-fasta <filename>
                        A FASTA file (else writes to stdout)
  --out-metadata <filename>
                        A metadata file
  --header-delimiter <symbol>
                        Header delimiter
  --add-cov-id          Parses header for COG or GISAID unique id and stores
  --low-memory          Assumes no duplicate sequences within a FASTA so can
                        use SeqIO index
```


## fastafunk_unwrap

### Tool Description
Unwraps multi-line FASTA files into single-line sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk unwrap [-h] [-v] [--log-file <filename>] --in-fasta
                        <filename> [<filename> ...] [--out-fasta <filename>]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-fasta <filename> [<filename> ...]
                        One or more FASTA files of sequences (else reads from
                        stdin)
  --out-fasta <filename>
                        A FASTA file (else writes to stdout)
```


## fastafunk_strip

### Tool Description
Strip sequences from FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk strip [-h] [-v] [--log-file <filename>] --in-fasta <filename>
                       [<filename> ...] [--gap] [--ambiguity] [--missing]
                       [--keep-alignment] [--front] [--back]
                       [--out-fasta <filename>]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-fasta <filename> [<filename> ...]
                        One or more FASTA files of sequences (else reads from
                        stdin)
  --gap                 Remove gaps from sequences (Default:False)
  --ambiguity           Remove ambiguous sites from sequences ("N")
                        (Default:False)
  --missing             Remove missing sites from sequences ("?")
                        (Default:False)
  --keep-alignment      Remove gaps shared by all sequences at the same site
                        (Default:False)
  --front               Remove only from the front of the sequence
                        (Default:False)
  --back                Remove only from the back of the sequence
                        (Default:False)
  --out-fasta <filename>
                        A FASTA file (else writes to stdout)
```


## fastafunk_add_columns

### Tool Description
Add columns from one CSV table to another based on matching columns.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk add_columns [-h] [-v] [--log-file <filename>] --in-metadata
                             <filename> --in-data <filename> --index-column
                             <column> --join-on <column>
                             [--new-columns <column> [<column> ...]]
                             --out-metadata <filename>
                             [--where-column <column>=<regex> [<column>=<regex> ...]]
                             [--force-overwrite]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-metadata <filename>
                        ONE CSV table of metadata
  --in-data <filename>  One CSV table of additional data. Must have --index-
                        column in common with metadata
  --index-column <column>
                        Column in the metadata files used to match rows
  --join-on <column>    Column in the data file used to match rows
  --new-columns <column> [<column> ...]
                        Column(s) in the in_data file to add to the metadata,
                        if not provided, all columns added
  --out-metadata <filename>
                        A metadata file to write
  --where-column <column>=<regex> [<column>=<regex> ...]
                        Additional matches to columns e.g. if want to rename
  --force-overwrite     Overwrite even if new data is blank/None
```


## fastafunk_drop_columns

### Tool Description
Drop columns from a metadata table.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk drop_columns [-h] [-v] [--log-file <filename>] --in-metadata
                              <filename> [--columns <column> [<column> ...]]
                              --out-metadata <filename>

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-metadata <filename>
                        ONE CSV table of metadata
  --columns <column> [<column> ...]
                        Column(s) in the metadata to drop
  --out-metadata <filename>
                        A metadata file to write
```


## fastafunk_filter_column

### Tool Description
Filter metadata based on a column's value.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk filter_column [-h] [-v] [--log-file <filename>] --in-metadata
                               <filename> --column <column> --out-metadata
                               <filename> [--is_true] [--is_false]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-metadata <filename>
                        ONE table of metadata
  --column <column>     Column in the metadata to filter on
  --out-metadata <filename>
                        A metadata file to write
  --is_true             filter if column is true
  --is_false            filter if column is false
```


## fastafunk_new

### Tool Description
Create a new FASTA file and metadata table by filtering and merging input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk new [-h] [-v] [--log-file <filename>]
                     [--in-fasta <filename> [<filename> ...]] --in-metadata
                     <filename> [<filename> ...] --index-column <column>
                     --date-column <column> [--out-fasta <filename>]
                     [--out-metadata <filename>]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-fasta <filename> [<filename> ...]
                        One or more FASTA files of sequences (else reads from
                        stdin)
  --in-metadata <filename> [<filename> ...]
                        One or more CSV or TSV tables of metadata
  --index-column <column>
                        Column in the metadata file to use to match to the
                        sequence
  --date-column <column>
                        Column in the metadata file containing date values to
                        use for filtering
  --out-fasta <filename>
                        A FASTA file (else writes to stdout)
  --out-metadata <filename>
                        A metadata file
```


## fastafunk_fetch

### Tool Description
Fetches sequences and metadata based on specified criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk fetch [-h] [-v] [--log-file <filename>]
                       [--in-fasta <filename> [<filename> ...]] --in-metadata
                       <filename> --index-column <column>
                       [--filter-column <column> [<column> ...]]
                       [--where-column <column>=<regex> [<column>=<regex> ...]]
                       [--restrict] [--keep-omit-rows] [--low-memory]
                       [--out-fasta <filename>] [--out-metadata <filename>]

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-fasta <filename> [<filename> ...]
                        One or more FASTA files of sequences (else reads from
                        stdin)
  --in-metadata <filename>
                        CSV or TSV of metadata with same naming convention as
                        fasta file
  --index-column <column>
                        Column in the metadata file to use to match to the
                        sequence
  --filter-column <column> [<column> ...]
                        Metadata column name(s) to keep
  --where-column <column>=<regex> [<column>=<regex> ...]
                        Additional matches to columns e.g. if want to rename
  --restrict            Only outputs metadata rows with a corresponding fasta
                        entry
  --keep-omit-rows      Allows rows with with metadata saying omit to be kept
  --low-memory          Assumes no duplicate sequences within a FASTA so can
                        use SeqIO index
  --out-fasta <filename>
                        A FASTA file (else writes to stdout)
  --out-metadata <filename>
                        A metadata file
```


## fastafunk_shuffle

### Tool Description
Shuffle FASTA sequences based on metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/fastafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/fastafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastafunk shuffle [-h] [-v] [--log-file <filename>] --in-metadata
                         <filename> --out-metadata <filename>

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Run with high verbosity (debug level logging)
  --log-file <filename>
                        Log file to use (otherwise uses stdout, or stderr if
                        out-fasta to stdout)
  --in-metadata <filename>
                        CSV or TSV of metadata
  --out-metadata <filename>
                        CSV or TSV of metadata
```


## Metadata
- **Skill**: not generated
