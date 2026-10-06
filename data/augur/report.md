# augur CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| augur_align | PASS |  |
| augur_ancestral | PASS |  |
| augur_clades | PASS |  |
| augur_curate_abbreviate-authors | PASS |  |
| augur_curate_apply-geolocation-rules | PASS |  |
| augur_curate_apply-record-annotations | PASS |  |
| augur_curate_format-dates | PASS |  |
| augur_curate_normalize-strings | PASS |  |
| augur_curate_parse-genbank-location | PASS |  |
| augur_curate_passthru | PASS |  |
| augur_curate_rename | PASS |  |
| augur_curate_titlecase | PASS |  |
| augur_curate_transform-strain-name | PASS |  |
| augur_distance | PASS |  |
| augur_export_v1 | PASS |  |
| augur_export_v2 | PASS |  |
| augur_filter | PASS |  |
| augur_frequencies | PASS |  |
| augur_import_beast | PASS |  |
| augur_index | PASS |  |
| augur_lbi | PASS |  |
| augur_mask | PASS |  |
| augur_measurements_concat | PASS |  |
| augur_measurements_export | PASS |  |
| augur_merge | PASS |  |
| augur_parse | PASS |  |
| augur_read-file | PASS |  |
| augur_reconstruct-sequences | PASS |  |
| augur_refine | PASS |  |
| augur_sequence-traits | PASS |  |
| augur_subsample | PASS |  |
| augur_titers_sub | PASS |  |
| augur_titers_tree | PASS |  |
| augur_traits | PASS |  |
| augur_translate | PASS |  |
| augur_tree | PASS |  |
| augur_write-file | PASS |  |

## augur_parse

### Tool Description
Parse delimited fields from FASTA sequence names into a TSV and FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A
### Original Help Text
```text
usage: augur parse [-h] --sequences SEQUENCES
                   --output-sequences OUTPUT_SEQUENCES
                   --output-metadata OUTPUT_METADATA
                   [--output-id-field OUTPUT_ID_FIELD]
                   --fields FIELDS [FIELDS ...]
                   [--prettify-fields PRETTIFY_FIELDS [PRETTIFY_FIELDS ...]]
                   [--separator SEPARATOR] [--fix-dates {dayfirst,monthfirst}]

Parse delimited fields from FASTA sequence names into a TSV and FASTA file.

options:
  -h, --help            show this help message and exit
  --sequences, -s SEQUENCES
                        sequences in fasta or VCF format (default: None)
  --output-sequences OUTPUT_SEQUENCES
                        output sequences file (default: None)
  --output-metadata OUTPUT_METADATA
                        output metadata file (default: None)
  --output-id-field OUTPUT_ID_FIELD
                        The record field to use as the sequence identifier in
                        the FASTA output. If not provided, this will use the
                        first available of ('strain', 'name'). If none of
                        those are available, this will use the first field in
                        the fasta header. (default: None)
  --fields FIELDS [FIELDS ...]
                        fields in fasta header (default: None)
  --prettify-fields PRETTIFY_FIELDS [PRETTIFY_FIELDS ...]
                        apply string prettifying operations (underscores to
                        spaces, capitalization, etc) to specified metadata
                        fields (default: None)
  --separator SEPARATOR
                        separator of fasta header (default: |)
  --fix-dates {dayfirst,monthfirst}
                        attempt to parse non-standard dates and output them in
                        standard YYYY-MM-DD format (default: None)
```

## augur_merge

### Tool Description
Merge two or more datasets into one. Datasets can consist of metadata and/or sequence files. If both are provided, the order and file contents are used independently.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur merge [-h] [--metadata NAME=FILE [NAME=FILE ...]]
                   [--metadata-id-columns [TABLE=]COLUMN [[TABLE=]COLUMN ...]]
                   [--metadata-delimiters [TABLE=]CHARACTER [[TABLE=]CHARACTER ...]]
                   [--sequences FILE [FILE ...]]
                   [--skip-input-sequences-validation]
                   [--output-metadata FILE] [--source-columns TEMPLATE]
                   [--no-source-columns] [--output-sequences FILE] [--quiet]
                   [--nthreads N]

Merge two or more datasets into one. Datasets can consist of metadata and/or
sequence files. If both are provided, the order and file contents are used
independently. **Metadata** Metadata tables must be given unique names to
identify them in the output and are merged in the order given. Rows are joined
by id (e.g. "strain" or "name" or other --metadata-id-columns), and ids must
be unique within an input table (i.e. tables cannot contain duplicate ids).
All rows are output, even if they appear in only a single table (i.e. a full
outer join in SQL terms). Columns are combined by name, either extending the
combined table with a new column or overwriting values in an existing column.
For columns appearing in more than one table, non-empty values on the right
hand side overwrite values on the left hand side. The first table's id column
name is used as the output id column name. Non-id columns in other input
tables that would conflict with this output id column name are not allowed and
if present will cause an error. One generated column per input table may be
optionally appended to the end of the output table to identify the source of
each row's data. Column names are generated with the template given to
--source-columns where "{NAME}" in the template is replaced by the table name
given to --metadata. Values in each column are 1 or 0 for present or absent in
that input table. By default no source columns are generated. You may make
this behaviour explicit with --no-source-columns. Metadata tables of arbitrary
size can be handled, limited only by available disk space. Tables are not
required to be entirely loadable into memory. The transient disk space
required is approximately the sum of the uncompressed size of the inputs.
SQLite is used behind the scenes to implement the merge, but this should be
considered an implementation detail that may change in the future. The SQLite
3 CLI, sqlite3, must be available. If it's not on PATH (or you want to use a
version different from what's on PATH), set the SQLITE3 environment variable
to path of the desired sqlite3 executable. **Sequences** Sequence files are
unnamed and are merged in the order given. Sequence ids with more than one
entry within a sequence file results in an error. Sequence ids with more than
one entry across multiple sequences files is handled by keeping the entry from
the rightmost file based on the given order. SeqKit is used behind the scenes
to implement the merge, but this should be considered an implementation detail
that may change in the future. The CLI program seqkit must be available. If
it's not on PATH (or you want to use a version different from what's on PATH),
set the SEQKIT environment variable to path of the desired seqkit executable.

options:
  -h, --help            show this help message and exit

inputs:
  options related to input

  --metadata NAME=FILE [NAME=FILE ...]
                        Metadata table names and file paths. Names are
                        arbitrary monikers used solely for referring to the
                        associated input file in other arguments and in output
                        column names. Paths must be to seekable files, not
                        unseekable streams. Compressed files are supported.
  --metadata-id-columns [TABLE=]COLUMN [[TABLE=]COLUMN ...]
                        Possible metadata column names containing identifiers,
                        considered in the order given. Columns will be
                        considered for all metadata tables by default. Table-
                        specific column names may be given using the same
                        names assigned in --metadata. Only one ID column will
                        be inferred for each table. (default: strain name)
  --metadata-delimiters [TABLE=]CHARACTER [[TABLE=]CHARACTER ...]
                        Possible field delimiters to use for reading metadata
                        tables, considered in the order given. Delimiters will
                        be considered for all metadata tables by default.
                        Table-specific delimiters may be given using the same
                        names assigned in --metadata. Only one delimiter will
                        be inferred for each table. (default: , $'\t')
  --sequences FILE [FILE ...]
                        Sequence files in FASTA format. Compressed files are
                        supported.
  --skip-input-sequences-validation
                        Skip validation of --sequences (checking for no
                        duplicates) to improve run time. Note that this may
                        result in unexpected behavior in cases where
                        validation would fail. (default: False)

outputs:
  options related to output

  --output-metadata FILE
                        Merged metadata as TSV. Compressed files are
                        supported.
  --source-columns TEMPLATE
                        Template with which to generate names for the columns
                        (described above) identifying the source of each row's
                        data. Must contain a literal placeholder, {NAME},
                        which stands in for the metadata table names assigned
                        in --metadata. (default: disabled)
  --no-source-columns   Suppress generated columns (described above)
                        identifying the source of each row's data. This is the
                        default behaviour, but it may be made explicit or used
                        to override a previous --source-columns.
  --output-sequences FILE
                        Merged sequences as FASTA. Compressed files are
                        supported.
  --quiet               Suppress informational and warning messages normally
                        written to stderr. (default: disabled)

other:
  other options

  --nthreads N          Number of CPUs/cores/threads/jobs to utilize at once.
                        (default: 1)
```

## augur_index

### Tool Description
Count occurrence of bases in a set of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur index [-h] --sequences SEQUENCES --output OUTPUT [--verbose]

Count occurrence of bases in a set of sequences.

options:
  -h, --help            show this help message and exit
  --sequences, -s SEQUENCES
                        sequences in FASTA or VCF formats. Augur will
                        summarize the content of FASTA sequences and only
                        report the names of strains found in a given VCF.
                        (default: None)
  --output, -o OUTPUT   tab-delimited file containing the number of bases per
                        sequence in the given file. Output columns include
                        strain, length, and counts for A, C, G, T, N, other
                        valid IUPAC characters, ambiguous characters ('?' and
                        '-'), and other invalid characters. (default: None)
  --verbose, -v         print index statistics to stdout (default: False)
```

## augur_filter

### Tool Description
Filter and subsample a sequence set. SeqKit is used behind the scenes to handle FASTA files, but this should be considered an implementation detail that may change in the future. The CLI program seqkit must be available. If it's not on PATH (or you want to use a version different from what's on PATH), set the SEQKIT environment variable to path of the desired seqkit executable. VCFtools is used behind the scenes to handle VCF files, but this should be considered an implementation detail that may change in the future. The CLI program vcftools must be available on PATH.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur filter [-h] --metadata FILE [--sequences SEQUENCES]
                    [--sequence-index SEQUENCE_INDEX]
                    [--metadata-chunk-size METADATA_CHUNK_SIZE]
                    [--metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]]
                    [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                    [--skip-checks] [--query QUERY]
                    [--query-columns QUERY_COLUMNS [QUERY_COLUMNS ...]]
                    [--min-date MIN_DATE] [--max-date MAX_DATE]
                    [--exclude-ambiguous-dates-by {any,day,month,year}]
                    [--exclude EXCLUDE [EXCLUDE ...]]
                    [--exclude-where EXCLUDE_WHERE [EXCLUDE_WHERE ...]]
                    [--exclude-all] [--include INCLUDE [INCLUDE ...]]
                    [--include-where INCLUDE_WHERE [INCLUDE_WHERE ...]]
                    [--min-length MIN_LENGTH] [--max-length MAX_LENGTH]
                    [--non-nucleotide] [--group-by GROUP_BY [GROUP_BY ...]]
                    [--sequences-per-group SEQUENCES_PER_GROUP |
                    --subsample-max-sequences SUBSAMPLE_MAX_SEQUENCES]
                    [--probabilistic-sampling | --no-probabilistic-sampling]
                    [--group-by-weights FILE] [--priority PRIORITY]
                    [--subsample-seed SUBSAMPLE_SEED]
                    [--output-sequences OUTPUT_SEQUENCES]
                    [--output-metadata OUTPUT_METADATA]
                    [--output-strains OUTPUT_STRAINS]
                    [--output-log OUTPUT_LOG]
                    [--output-group-by-sizes OUTPUT_GROUP_BY_SIZES]
                    [--empty-output-reporting {error,warn,silent}]
                    [--nthreads N] [--output FILE] [-o FILE]

Filter and subsample a sequence set. SeqKit is used behind the scenes to
handle FASTA files, but this should be considered an implementation detail
that may change in the future. The CLI program seqkit must be available. If
it's not on PATH (or you want to use a version different from what's on PATH),
set the SEQKIT environment variable to path of the desired seqkit executable.
VCFtools is used behind the scenes to handle VCF files, but this should be
considered an implementation detail that may change in the future. The CLI
program vcftools must be available on PATH.

options:
  -h, --help            show this help message and exit

inputs:
  metadata and sequences to be filtered

  --metadata FILE       sequence metadata (default: None)
  --sequences, -s SEQUENCES
                        sequences in FASTA or VCF format. For large inputs,
                        consider using --sequence-index in addition to this
                        option. (default: None)
  --sequence-index SEQUENCE_INDEX
                        sequence composition report generated by augur index.
                        If not provided, an index will be created on the fly.
                        This should be generated from the same file as
                        --sequences. (default: None)
  --metadata-chunk-size METADATA_CHUNK_SIZE
                        maximum number of metadata records to read into memory
                        at a time. Increasing this number can speed up
                        filtering at the cost of more memory used. (default:
                        100000)
  --metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]
                        names of possible metadata columns containing
                        identifier information, ordered by priority. Only one
                        ID column will be inferred. (default: ('strain',
                        'name'))
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        delimiters to accept when reading a metadata file.
                        Only one delimiter will be inferred. (default: (',',
                        '\t'))
  --skip-checks         use this option to skip checking for duplicates in
                        sequences and whether ids in metadata have a sequence
                        entry. Can improve performance on large files. Note
                        that this should only be used if you are sure there
                        are no duplicate sequences or mismatched ids since
                        they can lead to errors in downstream Augur commands.
                        (default: False)

metadata filters:
  filters to apply to metadata

  --query QUERY         Filter sequences by attribute. Uses `Pandas DataFrame
                        query syntax`__. (e.g., "country == 'Colombia'" or
                        "(country == 'USA' & (division == 'Washington'))") __
                        https://pandas.pydata.org/pandas-
                        docs/stable/user_guide/indexing.html#indexing-query
                        (default: None)
  --query-columns QUERY_COLUMNS [QUERY_COLUMNS ...]
                        Use alongside query to specify columns and data types
                        in the format 'column:type', where type is one of
                        (bool,float,int,str). Automatic type inference will be
                        attempted on all unspecified columns used in the
                        query. Example: region:str coverage:float. (default:
                        None)
  --min-date MIN_DATE   Minimal cutoff for date (inclusive). Supported
                        formats: 1. an Augur-style numeric date with the year
                        as the integer part (e.g. 2020.42) or 2. a date in ISO
                        8601 date format (i.e. YYYY-MM-DD) (e.g. '2020-06-04')
                        or 3. a backwards-looking relative date in ISO 8601
                        duration format with optional P prefix (e.g. '1W',
                        'P1W') (default: None)
  --max-date MAX_DATE   Maximal cutoff for date (inclusive). Supported
                        formats: 1. an Augur-style numeric date with the year
                        as the integer part (e.g. 2020.42) or 2. a date in ISO
                        8601 date format (i.e. YYYY-MM-DD) (e.g. '2020-06-04')
                        or 3. a backwards-looking relative date in ISO 8601
                        duration format with optional P prefix (e.g. '1W',
                        'P1W') (default: None)
  --exclude-ambiguous-dates-by {any,day,month,year}
                        Exclude ambiguous dates by day (e.g., 2020-09-XX),
                        month (e.g., 2020-XX-XX), year (e.g., 200X-10-01), or
                        any date fields. An ambiguous year makes the
                        corresponding month and day ambiguous, too, even if
                        those fields have unambiguous values (e.g.,
                        "201X-10-01"). Similarly, an ambiguous month makes the
                        corresponding day ambiguous (e.g., "2010-XX-01").
                        (default: None)
  --exclude EXCLUDE [EXCLUDE ...]
                        File(s) with list of strains to exclude. (default:
                        None)
  --exclude-where EXCLUDE_WHERE [EXCLUDE_WHERE ...]
                        Exclude sequences matching these conditions. Ex:
                        "host=rat" or "host!=rat". Multiple values are
                        processed as OR (matching any of those specified will
                        be excluded), not AND. (default: None)
  --exclude-all         Exclude all strains by default. Use this with the
                        include arguments to select a specific subset of
                        strains. (default: False)
  --include INCLUDE [INCLUDE ...]
                        File(s) with list of strains to include regardless of
                        priorities, subsampling, or absence of an entry in
                        sequences. (default: None)
  --include-where INCLUDE_WHERE [INCLUDE_WHERE ...]
                        Include sequences with these values. ex: host=rat.
                        Multiple values are processed as OR (having any of
                        those specified will be included), not AND. This rule
                        is applied last and ensures any strains matching these
                        rules will be included regardless of priorities,
                        subsampling, or absence of an entry in sequences.
                        (default: None)

sequence filters:
  filters to apply to sequence data

  --min-length MIN_LENGTH
                        Minimal length of the sequences, only counting
                        standard nucleotide characters A, C, G, or T (case-
                        insensitive). (default: None)
  --max-length MAX_LENGTH
                        Maximum length of the sequences, only counting
                        standard nucleotide characters A, C, G, or T (case-
                        insensitive). (default: None)
  --non-nucleotide      Exclude sequences that contain illegal characters.
                        (default: False)

subsampling:
  options to subsample filtered data

  --group-by GROUP_BY [GROUP_BY ...]
                        Grouping columns for subsampling. Notes: (1) Grouping
                        by ['month', 'week', 'year'] is only supported when
                        there is a 'date' column in the metadata. (2) 'week'
                        uses the ISO week numbering system, where a week
                        starts on a Monday and ends on a Sunday. (3) 'month'
                        and 'week' grouping cannot be used together. (4)
                        Custom columns ['month', 'week', 'year'] in the
                        metadata are ignored for grouping. Please rename them
                        if you want to use their values for grouping.
                        (default: [])
  --sequences-per-group SEQUENCES_PER_GROUP
                        Select no more than this number of sequences per
                        category. (default: None)
  --subsample-max-sequences SUBSAMPLE_MAX_SEQUENCES
                        Select no more than this number of sequences (i.e.
                        total sample size). Can be used without grouping
                        columns. (default: None)
  --probabilistic-sampling
                        Allow probabilistic sampling during subsampling. This
                        is useful when there are more groups than requested
                        sequences. This option only applies when a total
                        sample size is provided. (default: True)
  --no-probabilistic-sampling
  --group-by-weights FILE
                        TSV file defining weights for grouping. Requirements:
                        (1) Lines starting with '#' are treated as comment
                        lines. (2) The first non-comment line must be a header
                        row. (3) There must be a numeric ``weight`` column
                        (weights can take on any non-negative values). (4)
                        Other columns must be a subset of grouping columns,
                        with combinations of values covering all combinations
                        present in the metadata. (5) This option only applies
                        when grouping columns and a total sample size are
                        provided. (6) This option can only be used when
                        probabilistic sampling is allowed. Notes: (1) Any
                        grouping columns absent from this file will be given
                        equal weighting across all values *within* groups
                        defined by the other weighted columns. (2) An entry
                        with the value ``default`` under all columns will be
                        treated as the default weight for specific groups
                        present in the metadata but missing from the weights
                        file. If there is no default weight and the metadata
                        contains rows that are not covered by the given
                        weights, augur filter will exit with an error.
                        (default: None)
  --priority PRIORITY   tab-delimited file with list of priority scores for
                        strains (e.g., "<strain>\t<priority>") and no header.
                        When scores are provided, Augur converts scores to
                        floating point values, sorts strains within each
                        subsampling group from highest to lowest priority, and
                        selects the top N strains per group where N is the
                        calculated or requested number of strains per group.
                        Higher numbers indicate higher priority. Since
                        priorities represent relative values between strains,
                        these values can be arbitrary. (default: None)
  --subsample-seed SUBSAMPLE_SEED
                        random number generator seed to allow reproducible
                        subsampling (with same input data). (default: None)

outputs:
  options related to outputs, at least one of the possible representations
  of filtered data (--output-sequences, --output-metadata, --output-strains)
  is required

  --output-sequences OUTPUT_SEQUENCES
                        filtered sequences in FASTA format (default: None)
  --output-metadata OUTPUT_METADATA
                        metadata for strains that passed filters (default:
                        None)
  --output-strains OUTPUT_STRAINS
                        list of strains that passed filters (no header)
                        (default: None)
  --output-log OUTPUT_LOG
                        tab-delimited file with one row for each filtered
                        strain and the reason it was filtered. Keyword
                        arguments used for a given filter are reported in JSON
                        format in a `kwargs` column. (default: None)
  --output-group-by-sizes OUTPUT_GROUP_BY_SIZES
                        tab-delimited file one row per group with target size.
                        (default: None)
  --empty-output-reporting {error,warn,silent}
                        How should empty outputs be reported when no strains
                        pass filtering and/or subsampling. (default: error)

other:
  other options

  --nthreads N          Number of CPUs/cores/threads/jobs to utilize at once.
                        (default: 1)

deprecated:
  options to be removed in a future major version

  --output FILE         alias to --output-sequences
  -o FILE               alias to --output-sequences
```

## augur_subsample

### Tool Description
Subsample sequences from an input dataset. The input dataset can consist of a metadata file, a sequences file, or both. See documentation page for details on configuration.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur subsample [-h] [--metadata FILE] [--sequences FILE]
                       [--sequence-index FILE] [--metadata-chunk-size N]
                       [--metadata-id-columns COLUMN [COLUMN ...]]
                       [--metadata-delimiters CHARACTER [CHARACTER ...]]
                       [--skip-checks] --config FILE
                       [--config-section KEY [KEY ...]]
                       [--search-paths DIR [DIR ...]] [--nthreads N]
                       [--seed N] [--output-metadata FILE]
                       [--output-sequences FILE] [--output-log OUTPUT_LOG]

Subsample sequences from an input dataset. The input dataset can consist of a
metadata file, a sequences file, or both. See documentation page for details
on configuration.

options:
  -h, --help            show this help message and exit

Input options:
  options related to input files

  --metadata FILE       sequence metadata
  --sequences FILE      sequences in FASTA or VCF format. For large inputs,
                        consider using --sequence-index in addition to this
                        option.
  --sequence-index FILE
                        sequence composition report generated by augur index.
                        If not provided, an index will be created on the fly.
                        This should be generated from the same file as
                        --sequences.
  --metadata-chunk-size N
                        maximum number of metadata records to read into memory
                        at a time. Increasing this number can reduce run times
                        at the cost of more memory used. (default: 100000)
  --metadata-id-columns COLUMN [COLUMN ...]
                        names of possible metadata columns containing
                        identifier information, ordered by priority. Only one
                        ID column will be inferred. (default: ('strain',
                        'name'))
  --metadata-delimiters CHARACTER [CHARACTER ...]
                        delimiters to accept when reading a metadata file.
                        Only one delimiter will be inferred. (default: (',',
                        '\t'))
  --skip-checks         use this option to skip checking for duplicates in
                        sequences and whether ids in metadata have a sequence
                        entry. Can improve performance on large files. Note
                        that this should only be used if you are sure there
                        are no duplicate sequences or mismatched ids since
                        they can lead to errors in downstream Augur commands.
                        (default: False)

Configuration options:
  options related to configuration

  --config FILE         augur subsample config file. The expected config
                        options must be defined at the top level, or within a
                        specific section using --config-section.
  --config-section KEY [KEY ...]
                        Use a section of the file given to --config by listing
                        the keys leading to the section. Provide one or more
                        keys. (default: use the entire file)
  --search-paths, --search-path DIR [DIR ...]
                        One or more directories to search for relative
                        filepaths specified in the config file. If a file
                        exists in multiple directories, only the file from the
                        first directory will be used. This can also be set via
                        the environment variable 'AUGUR_SEARCH_PATHS'.
                        Specified directories will be considered before the
                        defaults, which are: (1) directory containing the
                        config file (2) current working directory
  --nthreads N          Number of CPUs/cores/threads/jobs to utilize at once.
                        For augur subsample, this means the number of samples
                        to run simultaneously. Individual samples are limited
                        to a single thread. The final augur filter call can
                        take advantage of multiple threads. (default: 1)
  --seed N              random number generator seed for reproducible outputs
                        (with same input data).

Output options:
  options related to output files

  --output-metadata FILE
                        output metadata file
  --output-sequences FILE
                        output sequences file
  --output-log OUTPUT_LOG
                        Tab-delimited file to debug sequence inclusion in
                        samples. All sequences have a row with
                        filter=filter_by_exclude_all. The sequences included
                        in the output each have an additional row per sample
                        that included it (there may be multiple). These rows
                        have filter=force_include_strains with kwargs pointing
                        to a temporary file that hints at the intermediate
                        sample it came from.
```

## augur_mask

### Tool Description
Mask specified sites from a VCF or FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur mask [-h] --sequences SEQUENCES [--mask MASK_FILE]
                  [--mask-from-beginning MASK_FROM_BEGINNING]
                  [--mask-from-end MASK_FROM_END] [--mask-invalid]
                  [--mask-sites MASK_SITES [MASK_SITES ...]] [--output OUTPUT]
                  [--no-cleanup]

Mask specified sites from a VCF or FASTA file.

options:
  -h, --help            show this help message and exit
  --sequences, -s SEQUENCES
                        sequences in VCF or FASTA format (default: None)
  --mask MASK_FILE      locations to be masked in either BED file format, DRM
                        format, or one 1-indexed site per line. (default:
                        None)
  --mask-from-beginning MASK_FROM_BEGINNING
                        FASTA Only: Number of sites to mask from beginning
                        (default: 0)
  --mask-from-end MASK_FROM_END
                        FASTA Only: Number of sites to mask from end (default:
                        0)
  --mask-invalid        FASTA Only: Mask invalid nucleotides (default: False)
  --mask-sites MASK_SITES [MASK_SITES ...]
                        1-indexed list of sites to mask (default: None)
  --output, -o OUTPUT   output file (default: None)
  --no-cleanup          Leave intermediate files around. May be useful for
                        debugging (default: True)
```

## augur_align

### Tool Description
Align multiple nucleotide sequences from FASTA. The "N" character is treated as missing or ambiguous sites, so aligning amino acid sequences is not supported.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur align [-h] --sequences FASTA [FASTA ...] [--output OUTPUT]
                   [--nthreads NTHREADS] [--method {mafft}]
                   [--reference-name NAME] [--reference-sequence PATH]
                   [--remove-reference] [--fill-gaps]
                   [--existing-alignment FASTA] [--debug]

Align multiple nucleotide sequences from FASTA. The "N" character is treated
as missing or ambiguous sites, so aligning amino acid sequences is not
supported.

options:
  -h, --help            show this help message and exit
  --sequences, -s FASTA [FASTA ...]
                        sequences to align (default: None)
  --output, -o OUTPUT   output file (default: alignment.fasta)
  --nthreads NTHREADS   number of threads to use; specifying the value 'auto'
                        will cause the number of available CPU cores on your
                        system, if determinable, to be used (default: 1)
  --method {mafft}      alignment program to use (default: mafft)
  --reference-name NAME
                        strip insertions relative to reference sequence; use
                        if the reference is already in the input sequences
                        (default: None)
  --reference-sequence PATH
                        Add this reference sequence to the dataset & strip
                        insertions relative to this. Use if the reference is
                        NOT already in the input sequences (default: None)
  --remove-reference    remove reference sequence from the alignment (default:
                        False)
  --fill-gaps           If gaps represent missing data rather than true
                        indels, replace by N after aligning. (default: False)
  --existing-alignment FASTA
                        An existing alignment to which the sequences will be
                        added. The ouput alignment will be the same length as
                        this existing alignment. (default: False)
  --debug               Produce extra files (e.g. pre- and post-aligner files)
                        which can help with debugging poor alignments.
                        (default: False)
```

## augur_tree

### Tool Description
Build a tree using a variety of methods. IQ-TREE specific: Strain names with spaces are modified to remove all characters after (and including) the first space.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur tree [-h] --alignment ALIGNMENT
                  [--method {fasttree,raxml,iqtree}] [--output OUTPUT]
                  [--substitution-model SUBSTITUTION_MODEL]
                  [--nthreads NTHREADS] [--vcf-reference VCF_REFERENCE]
                  [--exclude-sites EXCLUDE_SITES]
                  [--tree-builder-args TREE_BUILDER_ARGS]
                  [--override-default-args]

Build a tree using a variety of methods. IQ-TREE specific: Strain names with
spaces are modified to remove all characters after (and including) the first
space.

options:
  -h, --help            show this help message and exit
  --alignment, -a ALIGNMENT
                        alignment in fasta or VCF format (default: None)
  --method {fasttree,raxml,iqtree}
                        tree builder to use (default: iqtree)
  --output, -o OUTPUT   file name to write tree to (default: None)
  --substitution-model SUBSTITUTION_MODEL
                        substitution model to use. Specify 'auto' to run
                        ModelTest. Currently, only available for IQ-TREE.
                        (default: GTR)
  --nthreads NTHREADS   maximum number of threads to use; specifying the value
                        'auto' will cause the number of available CPU cores on
                        your system, if determinable, to be used (default: 1)
  --vcf-reference VCF_REFERENCE
                        fasta file of the sequence the VCF was mapped to
                        (default: None)
  --exclude-sites EXCLUDE_SITES
                        file name of one-based sites to exclude for raw tree
                        building (BED format in .bed files, second column in
                        tab-delimited files, or one position per line)
                        (default: None)
  --tree-builder-args TREE_BUILDER_ARGS
                        arguments to pass to the tree builder either
                        augmenting or overriding the default arguments (except
                        for input alignment path, number of threads, and
                        substitution model). Use the assignment operator
                        (e.g., --tree-builder-args="--polytomy" for IQ-TREE)
                        to avoid unexpected errors. FastTree defaults: "-nt
                        -nosupport". RAxML defaults: "-f d -m GTRCAT -c 25 -p
                        235813". IQ-TREE defaults: "--ninit 2 -n 2 --epsilon
                        0.05 -T AUTO --redo". Note that IQ-TREE will rewrite
                        certain characters in FASTA deflines. In order to
                        prevent this from breaking downstream analysis steps,
                        `augur tree` preemptively rewrites conflicting
                        deflines, and then restores them later. Unfortunately,
                        this breaks the use of certain IQ-TREE options (e.g.,
                        `-g`) which rely on matching names between the FASTA
                        and other input files. (default: None)
  --override-default-args
                        override default tree builder arguments with the
                        values provided by the user in `--tree-builder-args`
                        instead of augmenting the existing defaults. (default:
                        False)

For example, to build a tree with IQ-TREE, use the following format: augur
tree --method iqtree --alignment <alignment> --substitution-model <model>
--output <tree> --tree-builder-args="<extra arguments>"
```

## augur_refine

### Tool Description
Refine an initial tree using sequence metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur refine [-h] [--alignment ALIGNMENT] --tree TREE [--metadata FILE]
                    [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                    [--metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]]
                    [--output-tree OUTPUT_TREE]
                    [--output-node-data OUTPUT_NODE_DATA] [--use-fft]
                    [--max-iter MAX_ITER] [--timetree]
                    [--coalescent COALESCENT] [--gen-per-year GEN_PER_YEAR]
                    [--clock-rate CLOCK_RATE] [--clock-std-dev CLOCK_STD_DEV]
                    [--root ROOT [ROOT ...]] [--keep-root] [--remove-outgroup]
                    [--covariance] [--no-covariance] [--keep-polytomies |
                    --stochastic-resolve | --greedy-resolve]
                    [--precision {0,1,2,3}] [--date-format DATE_FORMAT]
                    [--date-confidence] [--date-inference {joint,marginal}]
                    [--branch-length-inference {auto,joint,marginal,input}]
                    [--clock-filter-iqd CLOCK_FILTER_IQD] [--keep-ids FILE]
                    [--vcf-reference VCF_REFERENCE]
                    [--year-bounds YEAR_BOUNDS [YEAR_BOUNDS ...]]
                    [--divergence-units {mutations,mutations-per-site}]
                    [--seed SEED] [--verbosity VERBOSITY]

Refine an initial tree using sequence metadata.

options:
  -h, --help            show this help message and exit
  --alignment, -a ALIGNMENT
                        alignment in fasta or VCF format (default: None)
  --tree, -t TREE       prebuilt Newick (default: None)
  --metadata FILE       sequence metadata (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        delimiters to accept when reading a metadata file.
                        Only one delimiter will be inferred. (default: (',',
                        '\t'))
  --metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]
                        names of possible metadata columns containing
                        identifier information, ordered by priority. Only one
                        ID column will be inferred. (default: ('strain',
                        'name'))
  --output-tree OUTPUT_TREE
                        file name to write tree to (default: None)
  --output-node-data OUTPUT_NODE_DATA
                        file name to write branch lengths as node data
                        (default: None)
  --use-fft             produce timetree using FFT for convolutions (default:
                        False)
  --max-iter MAX_ITER   maximal number of iterations TreeTime uses for
                        timetree inference (default: 2)
  --timetree            produce timetree using treetime, requires tree where
                        branch length is in units of average number of
                        nucleotide or protein substitutions per site (and
                        branch lengths do not exceed 4) (default: False)
  --coalescent COALESCENT
                        coalescent time scale in units of inverse clock rate
                        (float), optimize as scalar ('opt'), or skyline
                        ('skyline') (default: None)
  --gen-per-year GEN_PER_YEAR
                        number of generations per year, relevant for skyline
                        output('skyline') (default: 50)
  --clock-rate CLOCK_RATE
                        fixed clock rate (default: None)
  --clock-std-dev CLOCK_STD_DEV
                        standard deviation of the fixed clock_rate estimate
                        (default: None)
  --root ROOT [ROOT ...]
                        rooting mechanism ('best', 'least-squares', 'min_dev',
                        'oldest', 'mid_point') OR node to root by OR two nodes
                        indicating a monophyletic group to root by. Run
                        treetime -h for definitions of rooting methods.
                        (default: ['best'])
  --keep-root           do not reroot the tree; use it as-is. Overrides
                        anything specified by --root. (default: False)
  --remove-outgroup     Remove the outgroup supplied via '--root'This is only
                        valid when a single strain name has been supplied as
                        the root. (default: False)
  --covariance          Account for covariation when estimating rates and/or
                        rerooting. Use --no-covariance to turn off. (default:
                        True)
  --no-covariance
  --keep-polytomies     Do not attempt to resolve polytomies (default: False)
  --stochastic-resolve  Resolve polytomies via stochastic subtree building
                        rather than greedy optimization (default: False)
  --greedy-resolve
  --precision {0,1,2,3}
                        precision used by TreeTime to determine the number of
                        grid points that are used for the evaluation of the
                        branch length interpolation objects. Values range from
                        0 (rough) to 3 (ultra fine) and default to 'auto'.
                        (default: None)
  --date-format DATE_FORMAT
                        date format (default: %Y-%m-%d)
  --date-confidence     calculate confidence intervals for node dates
                        (default: False)
  --date-inference {joint,marginal}
                        assign internal nodes to their marginally most likely
                        dates, not jointly most likely (default: joint)
  --branch-length-inference {auto,joint,marginal,input}
                        branch length mode of treetime to use (default: auto)
  --clock-filter-iqd CLOCK_FILTER_IQD
                        clock-filter: remove tips that deviate more than n_iqd
                        interquartile ranges from the root-to-tip vs time
                        regression (default: None)
  --keep-ids FILE       file containing ids to keep in tree regardless of
                        clock filtering (one per line) (default: None)
  --vcf-reference VCF_REFERENCE
                        fasta file of the sequence the VCF was mapped to
                        (default: None)
  --year-bounds YEAR_BOUNDS [YEAR_BOUNDS ...]
                        specify min or max & min prediction bounds for samples
                        with XX in year (default: None)
  --divergence-units {mutations,mutations-per-site}
                        Units in which sequence divergences is exported.
                        (default: mutations-per-site)
  --seed SEED           seed for random number generation (default: None)
  --verbosity VERBOSITY
                        treetime verbosity, between 0 and 6 (higher values
                        more output) (default: 1)
```

## augur_ancestral

### Tool Description
Infer ancestral sequences based on a tree. The ancestral sequences are inferred using TreeTime. Each internal node gets assigned a nucleotide sequence that maximizes a likelihood on the tree given its descendants and its parent node. Each node then gets assigned a list of nucleotide mutations for any position that has a mismatch between its own sequence and its parent's sequence. The node sequences and mutations are output to a node-data JSON file. If amino acid options are provided, the ancestral amino acid sequences for each requested gene are inferred with the same method as the nucleotide sequences described above. The inferred amino acid mutations will be included in the output node-data JSON file, with the format equivalent to the output of augur translate. The nucleotide and amino acid sequences are inferred separately in this command, which can potentially result in mismatches between the nucleotide and amino acid mutations. If you want amino acid mutations based on the inferred nucleotide sequences, please use augur translate. .. note:: The mutation positions in the node-data JSON are one-based.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur ancestral [-h] --tree TREE [--alignment ALIGNMENT]
                       [--vcf-reference FASTA | --root-sequence FASTA/GenBank]
                       [--inference {joint,marginal}] [--seed SEED]
                       [--keep-ambiguous | --infer-ambiguous]
                       [--keep-overhangs] [--annotation ANNOTATION]
                       [--genes GENES [GENES ...]]
                       [--translations TRANSLATIONS]
                       [--output-node-data OUTPUT_NODE_DATA]
                       [--output-sequences OUTPUT_SEQUENCES]
                       [--output-translations OUTPUT_TRANSLATIONS]
                       [--output-vcf OUTPUT_VCF]
                       [--validation-mode {error,warn,skip}]
                       [--skip-validation]

Infer ancestral sequences based on a tree. The ancestral sequences are
inferred using `TreeTime
<https://academic.oup.com/ve/article/4/1/vex042/4794731>`_. Each internal node
gets assigned a nucleotide sequence that maximizes a likelihood on the tree
given its descendants and its parent node. Each node then gets assigned a list
of nucleotide mutations for any position that has a mismatch between its own
sequence and its parent's sequence. The node sequences and mutations are
output to a node-data JSON file. If amino acid options are provided, the
ancestral amino acid sequences for each requested gene are inferred with the
same method as the nucleotide sequences described above. The inferred amino
acid mutations will be included in the output node-data JSON file, with the
format equivalent to the output of `augur translate`. The nucleotide and amino
acid sequences are inferred separately in this command, which can potentially
result in mismatches between the nucleotide and amino acid mutations. If you
want amino acid mutations based on the inferred nucleotide sequences, please
use `augur translate`. .. note:: The mutation positions in the node-data JSON
are one-based.

options:
  -h, --help            show this help message and exit

inputs:
  Tree and sequences to use for ancestral reconstruction

  --tree, -t TREE       prebuilt Newick (default: None)
  --alignment, -a ALIGNMENT
                        alignment in FASTA or VCF format (default: None)
  --vcf-reference FASTA
                        [VCF alignment only] file of the sequence the VCF was
                        mapped to. Differences between this sequence and the
                        inferred root will be reported as mutations on the
                        root branch. (default: None)
  --root-sequence FASTA/GenBank
                        [FASTA alignment only] file of the sequence that is
                        used as root for mutation calling. Differences between
                        this sequence and the inferred root will be reported
                        as mutations on the root branch. (default: None)

global options:
  Options to configure reconstruction of both nucleotide and amino acid
  sequences

  --inference {joint,marginal}
                        calculate joint or marginal maximum likelihood
                        ancestral sequence states (default: joint)
  --seed SEED           seed for random number generation (default: None)

nucleotide options:
  Options to configure reconstruction of ancestral nucleotide sequences

  --keep-ambiguous      do not infer nucleotides at ambiguous (N) sites on tip
                        sequences (leave as N). (default: False)
  --infer-ambiguous     infer nucleotides at ambiguous (N,W,R,..) sites on tip
                        sequences and replace with most likely state.
                        (default: True)
  --keep-overhangs      do not infer nucleotides for gaps (-) on either side
                        of the alignment (default: False)

amino acid options:
  Options to configure reconstruction of ancestral amino acid sequences. All
  arguments are required for ancestral amino acid sequence reconstruction.

  --annotation ANNOTATION
                        GenBank or GFF file containing the annotation
                        (default: None)
  --genes GENES [GENES ...]
                        genes to translate (list or file containing list)
                        (default: None)
  --translations TRANSLATIONS
                        translated alignments for each CDS/Gene. Currently
                        only supported for FASTA-input. Specify the file name
                        via a template like 'aa_sequences_%GENE.fasta' where
                        %GENE will be replaced by the gene name. (default:
                        None)

outputs:
  Outputs supported for reconstructed ancestral sequences

  --output-node-data OUTPUT_NODE_DATA
                        name of JSON file to save mutations and ancestral
                        sequences to (default: None)
  --output-sequences OUTPUT_SEQUENCES
                        name of FASTA file to save ancestral nucleotide
                        sequences to (FASTA alignments only) (default: None)
  --output-translations OUTPUT_TRANSLATIONS
                        name of the FASTA file(s) to save ancestral amino acid
                        sequences to. Specify the file name via a template
                        like 'ancestral_aa_sequences_%GENE.fasta' where %GENE
                        will be replaced bythe gene name. (default: None)
  --output-vcf OUTPUT_VCF
                        name of output VCF file which will include ancestral
                        seqs (default: None)

general:
  --validation-mode {error,warn,skip}
                        Control if optional validation checks are performed
                        and what happens if they fail. 'error' and 'warn'
                        modes perform validation and emit messages about
                        failed validation checks. 'error' mode causes a non-
                        zero exit status if any validation checks failed,
                        while 'warn' does not. 'skip' mode performs no
                        validation. Note that some validation checks are non-
                        optional and as such are not affected by this setting.
                        (default: error)
  --skip-validation     Skip validation of input/output files, equivalent to
                        --validation-mode=skip. Use at your own risk!
                        (default: None)
```

## augur_translate

### Tool Description
Translate gene regions from nucleotides to amino acids. Translates nucleotide
sequences of nodes in a tree to amino acids for gene regions of the annotated
features of the provided reference sequence. Each node then gets assigned a
list of amino acid mutations for any position that has a mismatch between its
own amino acid sequence and its parent's sequence. The reference amino acid
sequences, genome annotations, and node amino acid mutations are output to a
node-data JSON file. .. note:: The mutation positions in the node-data JSON
are one-based.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur translate [-h] --tree TREE
                       --ancestral-sequences ANCESTRAL_SEQUENCES
                       --reference-sequence REFERENCE_SEQUENCE
                       [--genes GENES [GENES ...]]
                       [--output-node-data OUTPUT_NODE_DATA]
                       [--alignment-output ALIGNMENT_OUTPUT]
                       [--validation-mode {error,warn,skip}]
                       [--skip-validation] [--vcf-reference VCF_REFERENCE]
                       [--vcf-reference-output VCF_REFERENCE_OUTPUT]

Translate gene regions from nucleotides to amino acids. Translates nucleotide
sequences of nodes in a tree to amino acids for gene regions of the annotated
features of the provided reference sequence. Each node then gets assigned a
list of amino acid mutations for any position that has a mismatch between its
own amino acid sequence and its parent's sequence. The reference amino acid
sequences, genome annotations, and node amino acid mutations are output to a
node-data JSON file. .. note:: The mutation positions in the node-data JSON
are one-based.

options:
  -h, --help            show this help message and exit
  --tree TREE           prebuilt Newick -- no tree will be built if provided
                        (default: None)
  --ancestral-sequences ANCESTRAL_SEQUENCES
                        JSON (fasta input) or VCF (VCF input) containing
                        ancestral and tip sequences (default: None)
  --reference-sequence REFERENCE_SEQUENCE
                        GenBank or GFF file containing the annotation
                        (default: None)
  --genes GENES [GENES ...]
                        genes to translate (list or file containing list)
                        (default: None)
  --output-node-data OUTPUT_NODE_DATA
                        name of JSON file to save aa-mutations to (default:
                        None)
  --alignment-output ALIGNMENT_OUTPUT
                        write out translated gene alignments. If a VCF-input,
                        a .vcf or .vcf.gz will be output here (depending on
                        file ending). If fasta-input, specify the file name
                        like so: 'my_alignment_%GENE.fasta', where '%GENE'
                        will be replaced by the name of the gene (default:
                        None)
  --validation-mode {error,warn,skip}
                        Control if optional validation checks are performed
                        and what happens if they fail. 'error' and 'warn'
                        modes perform validation and emit messages about
                        failed validation checks. 'error' mode causes a non-
                        zero exit status if any validation checks failed,
                        while 'warn' does not. 'skip' mode performs no
                        validation. Note that some validation checks are non-
                        optional and as such are not affected by this setting.
                        (default: error)
  --skip-validation     Skip validation of input/output files, equivalent to
                        --validation-mode=skip. Use at your own risk!
                        (default: None)

VCF specific:
  These arguments are only applicable if the input (--ancestral-sequences)
  is in VCF format.

  --vcf-reference VCF_REFERENCE
                        fasta file of the sequence the VCF was mapped to
                        (default: None)
  --vcf-reference-output VCF_REFERENCE_OUTPUT
                        fasta file where reference sequence translations for
                        VCF input will be written (default: None)
```

## augur_reconstruct-sequences

### Tool Description
Reconstruct alignments from mutations inferred on the tree

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur reconstruct-sequences [-h] --tree TREE [--gene GENE]
                                   --mutations MUTATIONS
                                   [--vcf-aa-reference VCF_AA_REFERENCE]
                                   [--internal-nodes] [--output OUTPUT]

Reconstruct alignments from mutations inferred on the tree

options:
  -h, --help            show this help message and exit
  --tree TREE           tree as Newick file (default: None)
  --gene GENE           gene to translate (list or file containing list)
                        (default: None)
  --mutations MUTATIONS
                        json file containing mutations mapped to each branch
                        and the sequence of the root. (default: None)
  --vcf-aa-reference VCF_AA_REFERENCE
                        fasta file of the reference gene translations for VCF
                        format (default: None)
  --internal-nodes      include sequences of internal nodes in output
                        (default: False)
  --output OUTPUT
```

## augur_clades

### Tool Description
Assign clades to nodes in a tree based on amino-acid or nucleotide signatures. Nodes which are members of a clade are stored via <OUTPUT_NODE_DATA> → nodes → <node_name> → clade_membership and if this file is used in `augur export v2` these will automatically become a coloring. The basal nodes of each clade are also given a branch label which is stored via <OUTPUT_NODE_DATA> → branches → <node_name> → labels → clade. The keys "clade_membership" and "clade" are customisable via command line arguments.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur clades [-h] --tree TREE
                    --mutations NODE_DATA_JSON [NODE_DATA_JSON ...]
                    --clades TSV [--output-node-data NODE_DATA_JSON]
                    [--membership-name MEMBERSHIP_NAME]
                    [--label-name LABEL_NAME]
                    [--validation-mode {error,warn,skip}] [--skip-validation]

Assign clades to nodes in a tree based on amino-acid or nucleotide signatures.
Nodes which are members of a clade are stored via <OUTPUT_NODE_DATA> → nodes →
<node_name> → clade_membership and if this file is used in `augur export v2`
these will automatically become a coloring. The basal nodes of each clade are
also given a branch label which is stored via <OUTPUT_NODE_DATA> → branches →
<node_name> → labels → clade. The keys "clade_membership" and "clade" are
customisable via command line arguments.

options:
  -h, --help            show this help message and exit
  --tree TREE           prebuilt Newick -- no tree will be built if provided
                        (default: None)
  --mutations NODE_DATA_JSON [NODE_DATA_JSON ...]
                        JSON(s) containing ancestral and tip nucleotide and/or
                        amino-acid mutations (default: None)
  --clades TSV          TSV file containing clade definitions by amino-acid
                        (default: None)
  --output-node-data NODE_DATA_JSON
                        name of JSON file to save clade assignments to
                        (default: None)
  --membership-name MEMBERSHIP_NAME
                        Key to store clade membership under; use "None" to not
                        export this (default: clade_membership)
  --label-name LABEL_NAME
                        Key to store clade labels under; use "None" to not
                        export this (default: clade)
  --validation-mode {error,warn,skip}
                        Control if optional validation checks are performed
                        and what happens if they fail. 'error' and 'warn'
                        modes perform validation and emit messages about
                        failed validation checks. 'error' mode causes a non-
                        zero exit status if any validation checks failed,
                        while 'warn' does not. 'skip' mode performs no
                        validation. Note that some validation checks are non-
                        optional and as such are not affected by this setting.
                        (default: error)
  --skip-validation     Skip validation of input/output files, equivalent to
                        --validation-mode=skip. Use at your own risk!
                        (default: None)
```

## augur_traits

### Tool Description
Infer ancestral traits based on a tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur traits [-h] --tree TREE --metadata FILE
                    [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                    [--metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]]
                    [--weights WEIGHTS] --columns COLUMNS [COLUMNS ...]
                    [--confidence]
                    [--branch-labels COLUMN[=NAME] [COLUMN[=NAME] ...]]
                    [--branch-confidence COLUMN=CONFIDENCE [COLUMN=CONFIDENCE ...]]
                    [--sampling-bias-correction SAMPLING_BIAS_CORRECTION]
                    [--output-node-data OUTPUT_NODE_DATA]

Infer ancestral traits based on a tree.

options:
  -h, --help            show this help message and exit
  --tree, -t TREE       tree to perform trait reconstruction on (default:
                        None)
  --metadata FILE       table with metadata (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        delimiters to accept when reading a metadata file.
                        Only one delimiter will be inferred. (default: (',',
                        '\t'))
  --metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]
                        names of possible metadata columns containing
                        identifier information, ordered by priority. Only one
                        ID column will be inferred. (default: ('strain',
                        'name'))
  --weights WEIGHTS     tsv/csv table with equilibrium probabilities of
                        discrete states (default: None)
  --columns COLUMNS [COLUMNS ...]
                        metadata fields to perform discrete reconstruction on
                        (default: None)
  --confidence          record the distribution of subleading mugration states
                        (default: False)
  --branch-labels COLUMN[=NAME] [COLUMN[=NAME] ...]
                        Add branch labels where there is a change in trait
                        inferred for that column. You must supply this for
                        each column you would like to label. By default the
                        branch label key the same as the column name, but you
                        may customise this via the COLUMN=NAME syntax.
                        (default: [])
  --branch-confidence COLUMN=CONFIDENCE [COLUMN=CONFIDENCE ...]
                        Only label state changes where the confidence
                        percentage is above the specified value.Transitions to
                        lower confidence states will be represented by a
                        "uncertain" label. (default: [])
  --sampling-bias-correction SAMPLING_BIAS_CORRECTION
                        a rough estimate of how many more events would have
                        been observed if sequences represented an even sample.
                        This should be roughly the (1-sum_i p_i^2)/(1-sum_i
                        t_i^2), where p_i are the equilibrium frequencies and
                        t_i are apparent ones.(or rather the time spent in a
                        particular state on the tree) (default: None)
  --output-node-data OUTPUT_NODE_DATA
                        name of JSON file to save trait inferences to
                        (default: None)

Note that missing data must be represented by a `?` character. Missing data
will currently be inferred.
```

## augur_sequence-traits

### Tool Description
Annotate sequences based on amino-acid or nucleotide signatures.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur sequence-traits [-h] [--ancestral-sequences ANCESTRAL_SEQUENCES]
                             [--translations TRANSLATIONS]
                             [--vcf-reference VCF_REFERENCE]
                             [--vcf-translate-reference VCF_TRANSLATE_REFERENCE]
                             [--features FEATURES]
                             [--count {traits,mutations}] [--label LABEL]
                             [--output-node-data OUTPUT_NODE_DATA]

Annotate sequences based on amino-acid or nucleotide signatures.

options:
  -h, --help            show this help message and exit
  --ancestral-sequences ANCESTRAL_SEQUENCES
                        nucleotide alignment (VCF) to search for sequence
                        traits in (can be generated from 'ancestral' using '--
                        output-vcf') (default: None)
  --translations TRANSLATIONS
                        AA alignment to search for sequence traits in (can
                        include ancestral sequences) (default: None)
  --vcf-reference VCF_REFERENCE
                        fasta file of the sequence the nucleotide VCF was
                        mapped to (default: None)
  --vcf-translate-reference VCF_TRANSLATE_REFERENCE
                        fasta file of the sequence the translated VCF was
                        mapped to (default: None)
  --features FEATURES   file that specifies sites defining the features in a
                        tab-delimited format: "GENE SITE ALT DISPLAY_NAME
                        FEATURE". For nucleotide sites, GENE can be "nuc" (or
                        column excluded entirely for all-nuc sites).
                        "DISPLAY_NAME" can be blank or excluded entirely.
                        (default: None)
  --count {traits,mutations}
                        Whether to count traits (ex: # drugs resistant to) or
                        mutations (default: traits)
  --label LABEL         How to label the counts (ex: Drug_Resistance)
                        (default: # Traits)
  --output-node-data OUTPUT_NODE_DATA
                        name of JSON file to save sequence features to
                        (default: None)
```

## augur_lbi

### Tool Description
Calculate LBI for a given tree and one or more sets of parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur lbi [-h] --tree TREE --branch-lengths BRANCH_LENGTHS
                 --output OUTPUT
                 --attribute-names ATTRIBUTE_NAMES [ATTRIBUTE_NAMES ...]
                 --tau TAU [TAU ...] --window WINDOW [WINDOW ...]
                 [--no-normalization]

Calculate LBI for a given tree and one or more sets of parameters.

options:
  -h, --help            show this help message and exit
  --tree TREE           Newick tree (default: None)
  --branch-lengths BRANCH_LENGTHS
                        JSON with branch lengths and internal node dates
                        estimated by TreeTime (default: None)
  --output OUTPUT       JSON file with calculated distances stored by node
                        name and attribute name (default: None)
  --attribute-names ATTRIBUTE_NAMES [ATTRIBUTE_NAMES ...]
                        names to store distances associated with the
                        corresponding masks (default: None)
  --tau TAU [TAU ...]   tau value(s) defining the neighborhood of each clade
                        (default: None)
  --window WINDOW [WINDOW ...]
                        time window(s) to calculate LBI across (default: None)
  --no-normalization    disable normalization of LBI by the maximum value
                        (default: False)
```

## augur_distance

### Tool Description
Calculate the distance between sequences across entire genes or at a
predefined subset of sites. Distance calculations require selection of a
comparison method (to determine which sequences to compare) and a distance map
(to determine the weight of a mismatch between any two sequences).

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur distance [-h] --tree TREE --alignment ALIGNMENT [ALIGNMENT ...]
                      --gene-names GENE_NAMES [GENE_NAMES ...]
                      --attribute-name ATTRIBUTE_NAME [ATTRIBUTE_NAME ...]
                      --compare-to {root,ancestor,pairwise} [{root,ancestor,pairwise} ...]
                      --map MAP [MAP ...]
                      [--date-annotations DATE_ANNOTATIONS]
                      [--earliest-date EARLIEST_DATE]
                      [--latest-date LATEST_DATE] --output OUTPUT

Calculate the distance between sequences across entire genes or at a
predefined subset of sites. Distance calculations require selection of a
comparison method (to determine which sequences to compare) and a distance map
(to determine the weight of a mismatch between any two sequences).
**Comparison methods** Comparison methods include: #. root: the root and all
nodes in the tree (the previous default for all distances) #. ancestor: each
tip from a current season and its immediate ancestor (optionally, from a
previous season) #. pairwise: all tips pairwise (optionally, all tips from a
current season against all tips in previous seasons) Ancestor and pairwise
comparisons can be calculated with or without information about the current
season. When no dates are provided, the ancestor comparison calculates the
distance between each tip and its immediate ancestor in the given tree.
Similarly, the pairwise comparison calculates the distance between all pairs
of tips in the tree. When the user provides a "latest date", all tips sampled
after that date belong to the current season and all tips sampled on that date
or prior belong to previous seasons. When this information is available, the
ancestor comparison calculates the distance between each tip in the current
season and its last ancestor from a previous season. The pairwise comparison
only calculates the distances between tips in the current season and those
from previous seasons. When the user also provides an "earliest date",
pairwise comparisons exclude tips sampled from previous seasons prior to the
given date. These two date parameters allow users to specify a fixed time
interval for pairwise calculations, limiting the computationally complexity of
the comparisons. For all distance calculations, a consecutive series of gap
characters (`-`) counts as a single difference between any pair of sequences.
This behavior reflects the assumption that there was an underlying biological
process that produced the insertion or deletion as a single event as opposed
to multiple independent insertion/deletion events. **Distance maps** Distance
maps are defined in JSON format with two required top-level keys. The
`default` key specifies the numeric (floating point) value to assign to all
mismatches by default. The `map` key specifies a dictionary of weights to use
for distance calculations. These weights are indexed hierarchically by gene
name and one-based gene coordinate and are assigned in either a sequence-
independent or sequence-dependent manner. The simplest possible distance map
calculates Hamming distance between sequences without any site-specific
weights, as shown below: .. code-block:: json { "name": "Hamming distance",
"default": 1, "map": {} } To ignore specific characters such as gaps or
ambiguous nucleotides from the distance calculation, define a top-level
`ignored_characters` key with a list of characters to ignore. .. code-block::
json { "name": "Hamming distance", "default": 1, "ignored_characters": ["-",
"N"], "map": {} } By default, distances are floating point values whose
precision can be controlled with the `precision` key that defines the number
of decimal places to retain for each distance. The following example shows how
to specify a precision of two decimal places in the final output: .. code-
block:: json { "name": "Hamming distance", "default": 1, "map": {},
"precision": 2 } Distances can be reported as integer values by specifying an
`output_type` as `integer` or `int` as follows: .. code-block:: json { "name":
"Hamming distance", "default": 1, "map": {}, "output_type": "integer" }
Sequence-independent distances are defined by gene and position using a
numeric value of the same type as the default value (integer or float). The
following example is a distance map for antigenic amino acid substitutions
near influenza A/H3N2 HA's receptor binding sites. This map calculates the
Hamming distance between amino acid sequences only at seven positions in the
HA1 gene: .. code-block:: json { "name": "Koel epitope sites", "default": 0,
"map": { "HA1": { "145": 1, "155": 1, "156": 1, "158": 1, "159": 1, "189": 1,
"193": 1 } } } Sequence-dependent distances are defined by gene, position, and
sequence pairs where the `from` sequence in each pair is interpreted as the
ancestral state and the `to` sequence as the derived state. The following
example is a distance map that assigns asymmetric weights to specific amino
acid substitutions at a specific position in the influenza gene HA1: .. code-
block:: json { "default": 0.0, "map": { "HA1": { "112": [ { "from": "V", "to":
"I", "weight": 1.192 }, { "from": "I", "to": "V", "weight": 0.002 } ] } } }
The distance command produces a JSON output file in standard "node data"
format that can be passed to `augur export`. In addition to the standard
`nodes` field, the JSON includes a `params` field that describes the mapping
of attribute names to requested comparisons and distance maps and any date
parameters specified by the user. The following example JSON shows a sample
output when the distance command is run with multiple comparisons and distance
maps: .. code-block:: json { "params": { "attributes": ["ep", "ne", "ne_star",
"ep_pairwise"], "compare_to": ["root", "root", "ancestor", "pairwise"],
"map_name": [ "wolf_epitope", "wolf_nonepitope", "wolf_nonepitope",
"wolf_epitope" ], "latest_date": "2009-10-01" }, "nodes": {
"A/Afghanistan/AF1171/2008": { "ep": 7, "ne": 6, "ne_star": 1, "ep_pairwise":
{ "A/Aichi/78/2007": 1, "A/Argentina/3509/2006": 2 } } } }

options:
  -h, --help            show this help message and exit
  --tree TREE           Newick tree (default: None)
  --alignment ALIGNMENT [ALIGNMENT ...]
                        sequence(s) to be used, supplied as FASTA files
                        (default: None)
  --gene-names GENE_NAMES [GENE_NAMES ...]
                        names of the sequences in the alignment, same order
                        assumed (default: None)
  --attribute-name ATTRIBUTE_NAME [ATTRIBUTE_NAME ...]
                        name to store distances associated with the given
                        distance map; multiple attribute names are linked to
                        corresponding positional comparison method and
                        distance map arguments (default: None)
  --compare-to {root,ancestor,pairwise} [{root,ancestor,pairwise} ...]
                        type of comparison between samples in the given tree
                        including comparison of all nodes to the root (root),
                        all tips to their last ancestor from a previous season
                        (ancestor), or all tips from the current season to all
                        tips in previous seasons (pairwise) (default: None)
  --map MAP [MAP ...]   JSON providing the distance map between sites and,
                        optionally, sequences present at those sites; the
                        distance map JSON minimally requires a 'default' field
                        defining a default numeric distance and a 'map' field
                        defining a dictionary of genes and one-based
                        coordinates (default: None)
  --date-annotations DATE_ANNOTATIONS
                        JSON of branch lengths and date annotations from augur
                        refine for samples in the given tree; required for
                        comparisons to earliest or latest date (default: None)
  --earliest-date EARLIEST_DATE
                        earliest date at which samples are considered to be
                        from previous seasons (e.g., 2019-01-01). This date is
                        only used in pairwise comparisons. If omitted, all
                        samples prior to the latest date will be considered.
                        (default: None)
  --latest-date LATEST_DATE
                        latest date at which samples are considered to be from
                        previous seasons (e.g., 2019-01-01); samples from any
                        date after this are considered part of the current
                        season (default: None)
  --output OUTPUT       JSON file with calculated distances stored by node
                        name and attribute name (default: None)
```

## augur_frequencies

### Tool Description
infer frequencies of mutations or clades

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur frequencies [-h] --method {diffusion,kde} --metadata FILE
                         [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                         [--metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]]
                         [--regions REGIONS [REGIONS ...]]
                         [--pivot-interval PIVOT_INTERVAL]
                         [--pivot-interval-units {months,weeks}]
                         [--min-date MIN_DATE] [--max-date MAX_DATE]
                         [--tree TREE] [--include-internal-nodes]
                         [--alignments ALIGNMENTS [ALIGNMENTS ...]]
                         [--gene-names GENE_NAMES [GENE_NAMES ...]]
                         [--ignore-char IGNORE_CHAR]
                         [--minimal-frequency MINIMAL_FREQUENCY]
                         [--narrow-bandwidth NARROW_BANDWIDTH]
                         [--wide-bandwidth WIDE_BANDWIDTH]
                         [--proportion-wide PROPORTION_WIDE]
                         [--weights WEIGHTS]
                         [--weights-attribute WEIGHTS_ATTRIBUTE] [--censored]
                         [--minimal-clade-size MINIMAL_CLADE_SIZE]
                         [--minimal-clade-size-to-estimate MINIMAL_CLADE_SIZE_TO_ESTIMATE]
                         [--stiffness STIFFNESS] [--inertia INERTIA]
                         [--output-format {auspice,nextflu}] [--output OUTPUT]

infer frequencies of mutations or clades

options:
  -h, --help            show this help message and exit
  --method {diffusion,kde}
                        method by which frequencies should be estimated
                        (default: None)
  --metadata FILE       metadata including dates for given samples (default:
                        None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        delimiters to accept when reading a metadata file.
                        Only one delimiter will be inferred. (default: (',',
                        '\t'))
  --metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]
                        names of possible metadata columns containing
                        identifier information, ordered by priority. Only one
                        ID column will be inferred. (default: ('strain',
                        'name'))
  --regions REGIONS [REGIONS ...]
                        region to filter to. Regions should match values in
                        the 'region' column of the metadata file if specifying
                        values other than the default 'global' region.
                        (default: ['global'])
  --pivot-interval PIVOT_INTERVAL
                        number of units between pivots (default: 3)
  --pivot-interval-units {months,weeks}
                        space pivots by months (default) or by weeks (default:
                        months)
  --min-date MIN_DATE   date to begin frequencies calculations; may be
                        specified as: 1. an Augur-style numeric date with the
                        year as the integer part (e.g. 2020.42) or 2. a date
                        in ISO 8601 date format (i.e. YYYY-MM-DD) (e.g.
                        '2020-06-04') or 3. a backwards-looking relative date
                        in ISO 8601 duration format with optional P prefix
                        (e.g. '1W', 'P1W') (default: None)
  --max-date MAX_DATE   date to end frequencies calculations; may be specified
                        as: 1. an Augur-style numeric date with the year as
                        the integer part (e.g. 2020.42) or 2. a date in ISO
                        8601 date format (i.e. YYYY-MM-DD) (e.g. '2020-06-04')
                        or 3. a backwards-looking relative date in ISO 8601
                        duration format with optional P prefix (e.g. '1W',
                        'P1W') (default: None)
  --tree, -t TREE       tree to estimate clade frequencies for (default: None)
  --include-internal-nodes
                        calculate frequencies for internal nodes as well as
                        tips (default: False)
  --alignments ALIGNMENTS [ALIGNMENTS ...]
                        alignments to estimate mutations frequencies for
                        (default: None)
  --gene-names GENE_NAMES [GENE_NAMES ...]
                        names of the sequences in the alignment, same order
                        assumed (default: None)
  --ignore-char IGNORE_CHAR
                        character to be ignored in frequency calculations
                        (default: )
  --minimal-frequency MINIMAL_FREQUENCY
                        minimal all-time frequencies for a trajectory to be
                        estimates (default: 0.05)
  --narrow-bandwidth NARROW_BANDWIDTH
                        the bandwidth for the narrow KDE (default:
                        0.08333333333333333)
  --wide-bandwidth WIDE_BANDWIDTH
                        the bandwidth for the wide KDE (default: 0.25)
  --proportion-wide PROPORTION_WIDE
                        the proportion of the wide bandwidth to use in the KDE
                        mixture model (default: 0.2)
  --weights WEIGHTS     a dictionary of key/value mappings in JSON format used
                        to weight KDE tip frequencies (default: None)
  --weights-attribute WEIGHTS_ATTRIBUTE
                        name of the attribute on each tip whose values map to
                        the given weights dictionary (default: None)
  --censored            calculate censored frequencies at each pivot (default:
                        False)
  --minimal-clade-size MINIMAL_CLADE_SIZE
                        minimal number of tips a clade must have for its
                        diffusion frequencies to be reported (default: 0)
  --minimal-clade-size-to-estimate MINIMAL_CLADE_SIZE_TO_ESTIMATE
                        minimal number of tips a clade must have for its
                        diffusion frequencies to be estimated by the diffusion
                        likelihood; all smaller clades will inherit
                        frequencies from their parents (default: 10)
  --stiffness STIFFNESS
                        parameter penalizing curvature of the frequency
                        trajectory (default: 10.0)
  --inertia INERTIA     determines how frequencies continue in absense of data
                        (inertia=0 -> go flat, inertia=1.0 -> continue current
                        trend) (default: 0.0)
  --output-format {auspice,nextflu}
                        format to export frequencies JSON depending on the
                        viewing interface (default: auspice)
  --output, -o OUTPUT   JSON file to save estimated frequencies to (default:
                        None)
```

## augur_read-file

### Tool Description
Read one or more files like Augur, with transparent optimized decompression and universal newlines. Supported compression formats: gzip (.gz), bzip2 (.bz2), xz (.xz), zstandard (.zst). Input is read from each given file path, as the compression format detection requires a seekable stream. A path may be "-" to explicitly read from stdin, but no decompression will be done. Output from each file is concatenated together and written to stdout. Universal newline translation is always performed, so \n, \r\n, and \r in the input are all translated to the system's native newlines (e.g. \n on Unix, \r\n on Windows) in the output. Additionally, each file is standardized to have trailing newlines.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
usage: augur read-file [-h] PATH [PATH ...]

Read one or more files like Augur, with transparent optimized decompression
and universal newlines. Supported compression formats: gzip (.gz), bzip2
(.bz2), xz (.xz), zstandard (.zst). Input is read from each given file path,
as the compression format detection requires a seekable stream. A path may be
"-" to explicitly read from stdin, but no decompression will be done. Output
from each file is concatenated together and written to stdout. Universal
newline translation is always performed, so \n, \r\n, and \r in the input are
all translated to the system's native newlines (e.g. \n on Unix, \r\n on
Windows) in the output. Additionally, each file is standardized to have
trailing newlines.

positional arguments:
  PATH        paths to files

options:
  -h, --help  show this help message and exit
```

## augur_write-file

### Tool Description
Writes data to a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.13/site-packages/treetime/merger_models.py:189: SyntaxWarning: invalid escape sequence '\k'
  in the Kingman model this is: :math:`\kappa(t) = (k(t)-1)/(2Tc(t))`
/usr/local/lib/python3.13/site-packages/treetime/merger_models.py:199: SyntaxWarning: invalid escape sequence '\l'
  in the Kingman model this is: :math:`\lambda(t) = k(t)(k(t)-1)/(2Tc(t))`
/usr/local/lib/python3.13/site-packages/treetime/merger_models.py:214: SyntaxWarning: invalid escape sequence '\l'
  :math:`-log(\lambda(t_n+ \\tau)^{(m-1)/m}) + \int_{t_n}^{t_n+ \\tau} \kappa(t) dt`, where m is the multiplicity
usage: augur write-file [-h] PATH
augur write-file: error: the following arguments are required: PATH
```

## augur_curate_abbreviate-authors

### Tool Description
Abbreviates a full list of authors to be '<first author> et al.' (augur curate)

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur curate abbreviate-authors [-h] [--metadata METADATA]
                                       [--id-column ID_COLUMN]
                                       [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                                       [--fasta FASTA]
                                       [--seq-id-column SEQ_ID_COLUMN]
                                       [--seq-field SEQ_FIELD]
                                       [--unmatched-reporting {error_first,error_all,warn,silent}]
                                       [--duplicate-reporting {error_first,error_all,warn,silent}]
                                       [--output-metadata OUTPUT_METADATA]
                                       [--output-fasta OUTPUT_FASTA]
                                       [--output-id-field OUTPUT_ID_FIELD]
                                       [--output-seq-field OUTPUT_SEQ_FIELD]
                                       [--authors-field AUTHORS_FIELD]
                                       [--default-value DEFAULT_VALUE]
                                       [--abbr-authors-field ABBR_AUTHORS_FIELD]

Abbreviates a full list of authors to be '<first author> et al.' Expects
NDJSON records from stdin and outputs modified records to stdout. Note: This
is a "best effort" approach and can potentially mangle the author name.

options:
  -h, --help            show this help message and exit
  --authors-field AUTHORS_FIELD
                        The field containing list of authors. (default:
                        authors)
  --default-value DEFAULT_VALUE
                        Default value to use if authors list is empty.
                        (default: ?)
  --abbr-authors-field ABBR_AUTHORS_FIELD
                        The field for the generated abbreviated authors. If
                        not provided, the original authors field will be
                        modified. (default: None)

INPUTS:
  Input options shared by all `augur curate` commands. If no input options
  are provided, commands will try to read NDJSON records from stdin.

  --metadata METADATA   Input metadata file. May be plain text (TSV, CSV) or
                        an Excel or OpenOffice spreadsheet workbook file. When
                        an Excel or OpenOffice workbook, only the first
                        visible worksheet will be read and initial empty
                        rows/columns will be ignored. Accepts '-' to read
                        plain text from stdin. (default: None)
  --id-column ID_COLUMN
                        Name of the metadata column that contains the record
                        identifier for reporting duplicate records. Uses the
                        first column of the metadata file if not provided.
                        Ignored if also providing a FASTA file input.
                        (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        Delimiters to accept when reading a plain text
                        metadata file. Only one delimiter will be inferred.
                        (default: (',', '\t'))
  --fasta FASTA         Plain or gzipped FASTA file. Headers can only contain
                        the sequence id used to match a metadata record. Note
                        that an index file will be generated for the FASTA
                        file as <filename>.fasta.fxi (default: None)
  --seq-id-column SEQ_ID_COLUMN
                        Name of metadata column that contains the sequence id
                        to match sequences in the FASTA file. (default: None)
  --seq-field SEQ_FIELD
                        The name to use for the sequence field when joining
                        sequences from a FASTA file. (default: None)
  --unmatched-reporting {error_first,error_all,warn,silent}
                        How unmatched records from combined metadata/FASTA
                        input should be reported. (default: error_first)
  --duplicate-reporting {error_first,error_all,warn,silent}
                        How should duplicate records be reported. (default:
                        error_first)

OUTPUTS:
  Output options shared by all `augur curate` commands. If no output options
  are provided, commands will output NDJSON records to stdout.

  --output-metadata OUTPUT_METADATA
                        Output metadata TSV file. Accepts '-' to output TSV to
                        stdout. (default: None)
  --output-fasta OUTPUT_FASTA
                        Output FASTA file. (default: None)
  --output-id-field OUTPUT_ID_FIELD
                        The record field to use as the sequence identifier in
                        the FASTA output. (default: None)
  --output-seq-field OUTPUT_SEQ_FIELD
                        The record field that contains the sequence for the
                        FASTA output. This field will be deleted from the
                        metadata output. (default: None)
```

## augur_curate_apply-geolocation-rules

### Tool Description
Applies user curated geolocation rules to the geolocation fields. (augur curate)

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur curate apply-geolocation-rules [-h] [--metadata METADATA]
                                            [--id-column ID_COLUMN]
                                            [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                                            [--fasta FASTA]
                                            [--seq-id-column SEQ_ID_COLUMN]
                                            [--seq-field SEQ_FIELD]
                                            [--unmatched-reporting {error_first,error_all,warn,silent}]
                                            [--duplicate-reporting {error_first,error_all,warn,silent}]
                                            [--output-metadata OUTPUT_METADATA]
                                            [--output-fasta OUTPUT_FASTA]
                                            [--output-id-field OUTPUT_ID_FIELD]
                                            [--output-seq-field OUTPUT_SEQ_FIELD]
                                            [--region-field REGION_FIELD]
                                            [--country-field COUNTRY_FIELD]
                                            [--division-field DIVISION_FIELD]
                                            [--location-field LOCATION_FIELD]
                                            [--geolocation-rules TSV]
                                            [--case-sensitive]
                                            [--no-default-rules]

Applies user curated geolocation rules to the geolocation fields.

options:
  -h, --help            show this help message and exit
  --region-field REGION_FIELD
                        Field that contains regions in NDJSON records.
                        (default: region)
  --country-field COUNTRY_FIELD
                        Field that contains countries in NDJSON records.
                        (default: country)
  --division-field DIVISION_FIELD
                        Field that contains divisions in NDJSON records.
                        (default: division)
  --location-field LOCATION_FIELD
                        Field that contains location in NDJSON records.
                        (default: location)
  --geolocation-rules TSV
                        TSV file of geolocation rules with the format:
                        '<raw_geolocation><tab><annotated_geolocation>' where
                        the raw and annotated geolocations are formatted as
                        '<region>/<country>/<division>/<location>'. If
                        creating a general rule, then the raw field value can
                        be substituted with '*'.Lines starting with '#' will
                        be ignored as comments.Trailing '#' will be ignored as
                        comments. Note that the raw geolocation matching is
                        case-insensitive unless the `--case-sensitive` flag is
                        provided. The rules defined in the provided file will
                        have precedence over the default rules in <https://git
                        hub.com/nextstrain/augur/blob/33.0.0/augur/data/geoloc
                        ation_rules.tsv>. (default: None)
  --case-sensitive      Use case-sensitive matching of raw geolocation fields
                        to geolocation rules. (default: False)
  --no-default-rules    Do not use Augur's default geolocation rules.
                        (default: False)

INPUTS:
  Input options shared by all `augur curate` commands. If no input options
  are provided, commands will try to read NDJSON records from stdin.

  --metadata METADATA   Input metadata file. May be plain text (TSV, CSV) or
                        an Excel or OpenOffice spreadsheet workbook file. When
                        an Excel or OpenOffice workbook, only the first
                        visible worksheet will be read and initial empty
                        rows/columns will be ignored. Accepts '-' to read
                        plain text from stdin. (default: None)
  --id-column ID_COLUMN
                        Name of the metadata column that contains the record
                        identifier for reporting duplicate records. Uses the
                        first column of the metadata file if not provided.
                        Ignored if also providing a FASTA file input.
                        (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        Delimiters to accept when reading a plain text
                        metadata file. Only one delimiter will be inferred.
                        (default: (',', '\t'))
  --fasta FASTA         Plain or gzipped FASTA file. Headers can only contain
                        the sequence id used to match a metadata record. Note
                        that an index file will be generated for the FASTA
                        file as <filename>.fasta.fxi (default: None)
  --seq-id-column SEQ_ID_COLUMN
                        Name of metadata column that contains the sequence id
                        to match sequences in the FASTA file. (default: None)
  --seq-field SEQ_FIELD
                        The name to use for the sequence field when joining
                        sequences from a FASTA file. (default: None)
  --unmatched-reporting {error_first,error_all,warn,silent}
                        How unmatched records from combined metadata/FASTA
                        input should be reported. (default: error_first)
  --duplicate-reporting {error_first,error_all,warn,silent}
                        How should duplicate records be reported. (default:
                        error_first)

OUTPUTS:
  Output options shared by all `augur curate` commands. If no output options
  are provided, commands will output NDJSON records to stdout.

  --output-metadata OUTPUT_METADATA
                        Output metadata TSV file. Accepts '-' to output TSV to
                        stdout. (default: None)
  --output-fasta OUTPUT_FASTA
                        Output FASTA file. (default: None)
  --output-id-field OUTPUT_ID_FIELD
                        The record field to use as the sequence identifier in
                        the FASTA output. (default: None)
  --output-seq-field OUTPUT_SEQ_FIELD
                        The record field that contains the sequence for the
                        FASTA output. This field will be deleted from the
                        metadata output. (default: None)
```

## augur_curate_apply-record-annotations

### Tool Description
Applies record annotations to overwrite field values. (augur curate)

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur curate apply-record-annotations [-h] [--metadata METADATA]
                                             [--id-column ID_COLUMN]
                                             [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                                             [--fasta FASTA]
                                             [--seq-id-column SEQ_ID_COLUMN]
                                             [--seq-field SEQ_FIELD]
                                             [--unmatched-reporting {error_first,error_all,warn,silent}]
                                             [--duplicate-reporting {error_first,error_all,warn,silent}]
                                             [--output-metadata OUTPUT_METADATA]
                                             [--output-fasta OUTPUT_FASTA]
                                             [--output-id-field OUTPUT_ID_FIELD]
                                             [--output-seq-field OUTPUT_SEQ_FIELD]
                                             --annotations TSV
                                             [--id-field ID_FIELD]

Applies record annotations to overwrite field values. This does not do any
additional transformations on top of the annotations.

options:
  -h, --help            show this help message and exit
  --annotations TSV     Manually curated annotations TSV file. The TSV should
                        not have a header and should have exactly three
                        columns: id to match existing metadata, field name,
                        and field value. If there are multiple annotations for
                        the same id and field, then the last value is used.
                        Lines starting with '#' are treated as comments. Any
                        '#' after the field value are treated as comments.
                        (default: None)
  --id-field ID_FIELD   The ID field in the metadata to use to merge with the
                        annotations. (default: accession)

INPUTS:
  Input options shared by all `augur curate` commands. If no input options
  are provided, commands will try to read NDJSON records from stdin.

  --metadata METADATA   Input metadata file. May be plain text (TSV, CSV) or
                        an Excel or OpenOffice spreadsheet workbook file. When
                        an Excel or OpenOffice workbook, only the first
                        visible worksheet will be read and initial empty
                        rows/columns will be ignored. Accepts '-' to read
                        plain text from stdin. (default: None)
  --id-column ID_COLUMN
                        Name of the metadata column that contains the record
                        identifier for reporting duplicate records. Uses the
                        first column of the metadata file if not provided.
                        Ignored if also providing a FASTA file input.
                        (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        Delimiters to accept when reading a plain text
                        metadata file. Only one delimiter will be inferred.
                        (default: (',', '\t'))
  --fasta FASTA         Plain or gzipped FASTA file. Headers can only contain
                        the sequence id used to match a metadata record. Note
                        that an index file will be generated for the FASTA
                        file as <filename>.fasta.fxi (default: None)
  --seq-id-column SEQ_ID_COLUMN
                        Name of metadata column that contains the sequence id
                        to match sequences in the FASTA file. (default: None)
  --seq-field SEQ_FIELD
                        The name to use for the sequence field when joining
                        sequences from a FASTA file. (default: None)
  --unmatched-reporting {error_first,error_all,warn,silent}
                        How unmatched records from combined metadata/FASTA
                        input should be reported. (default: error_first)
  --duplicate-reporting {error_first,error_all,warn,silent}
                        How should duplicate records be reported. (default:
                        error_first)

OUTPUTS:
  Output options shared by all `augur curate` commands. If no output options
  are provided, commands will output NDJSON records to stdout.

  --output-metadata OUTPUT_METADATA
                        Output metadata TSV file. Accepts '-' to output TSV to
                        stdout. (default: None)
  --output-fasta OUTPUT_FASTA
                        Output FASTA file. (default: None)
  --output-id-field OUTPUT_ID_FIELD
                        The record field to use as the sequence identifier in
                        the FASTA output. (default: None)
  --output-seq-field OUTPUT_SEQ_FIELD
                        The record field that contains the sequence for the
                        FASTA output. This field will be deleted from the
                        metadata output. (default: None)
```

## augur_curate_format-dates

### Tool Description
Format date fields to ISO 8601 dates (YYYY-MM-DD). (augur curate)

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur curate format-dates [-h] [--metadata METADATA]
                                 [--id-column ID_COLUMN]
                                 [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                                 [--fasta FASTA]
                                 [--seq-id-column SEQ_ID_COLUMN]
                                 [--seq-field SEQ_FIELD]
                                 [--unmatched-reporting {error_first,error_all,warn,silent}]
                                 [--duplicate-reporting {error_first,error_all,warn,silent}]
                                 [--output-metadata OUTPUT_METADATA]
                                 [--output-fasta OUTPUT_FASTA]
                                 [--output-id-field OUTPUT_ID_FIELD]
                                 [--output-seq-field OUTPUT_SEQ_FIELD]
                                 [--date-fields NAME [NAME ...]]
                                 [--expected-date-formats FORMAT [FORMAT ...]]
                                 [--failure-reporting {error_first,error_all,warn,silent}]
                                 [--no-mask-failure]

Format date fields to ISO 8601 dates (YYYY-MM-DD). If the provided
``--expected-date-formats`` represent incomplete dates then the incomplete
dates are masked with 'XX'. For example, providing ``%Y`` will allow year only
dates to be formatted as ``2023-XX-XX``.

options:
  -h, --help            show this help message and exit

INPUTS:
  Input options shared by all `augur curate` commands. If no input options
  are provided, commands will try to read NDJSON records from stdin.

  --metadata METADATA   Input metadata file. May be plain text (TSV, CSV) or
                        an Excel or OpenOffice spreadsheet workbook file. When
                        an Excel or OpenOffice workbook, only the first
                        visible worksheet will be read and initial empty
                        rows/columns will be ignored. Accepts '-' to read
                        plain text from stdin. (default: None)
  --id-column ID_COLUMN
                        Name of the metadata column that contains the record
                        identifier for reporting duplicate records. Uses the
                        first column of the metadata file if not provided.
                        Ignored if also providing a FASTA file input.
                        (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        Delimiters to accept when reading a plain text
                        metadata file. Only one delimiter will be inferred.
                        (default: (',', '\t'))
  --fasta FASTA         Plain or gzipped FASTA file. Headers can only contain
                        the sequence id used to match a metadata record. Note
                        that an index file will be generated for the FASTA
                        file as <filename>.fasta.fxi (default: None)
  --seq-id-column SEQ_ID_COLUMN
                        Name of metadata column that contains the sequence id
                        to match sequences in the FASTA file. (default: None)
  --seq-field SEQ_FIELD
                        The name to use for the sequence field when joining
                        sequences from a FASTA file. (default: None)
  --unmatched-reporting {error_first,error_all,warn,silent}
                        How unmatched records from combined metadata/FASTA
                        input should be reported. (default: error_first)
  --duplicate-reporting {error_first,error_all,warn,silent}
                        How should duplicate records be reported. (default:
                        error_first)

OUTPUTS:
  Output options shared by all `augur curate` commands. If no output options
  are provided, commands will output NDJSON records to stdout.

  --output-metadata OUTPUT_METADATA
                        Output metadata TSV file. Accepts '-' to output TSV to
                        stdout. (default: None)
  --output-fasta OUTPUT_FASTA
                        Output FASTA file. (default: None)
  --output-id-field OUTPUT_ID_FIELD
                        The record field to use as the sequence identifier in
                        the FASTA output. (default: None)
  --output-seq-field OUTPUT_SEQ_FIELD
                        The record field that contains the sequence for the
                        FASTA output. This field will be deleted from the
                        metadata output. (default: None)

REQUIRED:
  --date-fields NAME [NAME ...]
                        List of date field names in the record that need to be
                        standardized. (default: None)

OPTIONAL:
  --expected-date-formats FORMAT [FORMAT ...]
                        Custom date formats for values in the provided date
                        fields, defined by standard format codes available at
                        <https://docs.python.org/3/library/datetime.html#strft
                        ime-and-strptime-format-codes>. If a value matches
                        multiple formats, it will be parsed using the first
                        match. Use 'XX' to match masked parts of the date
                        (e.g. '%m/XX/%Y'). The following formats are builtin
                        and automatically used: '%Y-%m-%d', '%Y-%m-XX',
                        '%Y-XX-XX', 'XXXX-XX-XX'. User-provided values are
                        considered after the builtin formats. (default: None)
  --failure-reporting {error_first,error_all,warn,silent}
                        How should failed date formatting be reported.
                        (default: error_first)
  --no-mask-failure     Do not mask dates with 'XXXX-XX-XX' and return
                        original date string if date formatting failed.
                        (default: False)
```

## augur_curate_normalize-strings

### Tool Description
Normalize strings to a Unicode normalization form and strip leading and trailing whitespaces. (augur curate)

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur curate normalize-strings [-h] [--metadata METADATA]
                                      [--id-column ID_COLUMN]
                                      [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                                      [--fasta FASTA]
                                      [--seq-id-column SEQ_ID_COLUMN]
                                      [--seq-field SEQ_FIELD]
                                      [--unmatched-reporting {error_first,error_all,warn,silent}]
                                      [--duplicate-reporting {error_first,error_all,warn,silent}]
                                      [--output-metadata OUTPUT_METADATA]
                                      [--output-fasta OUTPUT_FASTA]
                                      [--output-id-field OUTPUT_ID_FIELD]
                                      [--output-seq-field OUTPUT_SEQ_FIELD]
                                      [--form {NFC,NFKC,NFD,NFKD}]

Normalize strings to a Unicode normalization form and strip leading and
trailing whitespaces. Strings need to be normalized for predictable string
comparisons, especially in cases where strings contain diacritics (see https:/
/web.archive.org/web/20250922031915/https://unicode.org/faq/normalization.html
).

options:
  -h, --help            show this help message and exit

INPUTS:
  Input options shared by all `augur curate` commands. If no input options
  are provided, commands will try to read NDJSON records from stdin.

  --metadata METADATA   Input metadata file. May be plain text (TSV, CSV) or
                        an Excel or OpenOffice spreadsheet workbook file. When
                        an Excel or OpenOffice workbook, only the first
                        visible worksheet will be read and initial empty
                        rows/columns will be ignored. Accepts '-' to read
                        plain text from stdin. (default: None)
  --id-column ID_COLUMN
                        Name of the metadata column that contains the record
                        identifier for reporting duplicate records. Uses the
                        first column of the metadata file if not provided.
                        Ignored if also providing a FASTA file input.
                        (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        Delimiters to accept when reading a plain text
                        metadata file. Only one delimiter will be inferred.
                        (default: (',', '\t'))
  --fasta FASTA         Plain or gzipped FASTA file. Headers can only contain
                        the sequence id used to match a metadata record. Note
                        that an index file will be generated for the FASTA
                        file as <filename>.fasta.fxi (default: None)
  --seq-id-column SEQ_ID_COLUMN
                        Name of metadata column that contains the sequence id
                        to match sequences in the FASTA file. (default: None)
  --seq-field SEQ_FIELD
                        The name to use for the sequence field when joining
                        sequences from a FASTA file. (default: None)
  --unmatched-reporting {error_first,error_all,warn,silent}
                        How unmatched records from combined metadata/FASTA
                        input should be reported. (default: error_first)
  --duplicate-reporting {error_first,error_all,warn,silent}
                        How should duplicate records be reported. (default:
                        error_first)

OUTPUTS:
  Output options shared by all `augur curate` commands. If no output options
  are provided, commands will output NDJSON records to stdout.

  --output-metadata OUTPUT_METADATA
                        Output metadata TSV file. Accepts '-' to output TSV to
                        stdout. (default: None)
  --output-fasta OUTPUT_FASTA
                        Output FASTA file. (default: None)
  --output-id-field OUTPUT_ID_FIELD
                        The record field to use as the sequence identifier in
                        the FASTA output. (default: None)
  --output-seq-field OUTPUT_SEQ_FIELD
                        The record field that contains the sequence for the
                        FASTA output. This field will be deleted from the
                        metadata output. (default: None)

OPTIONAL:
  --form {NFC,NFKC,NFD,NFKD}
                        Unicode normalization form to use for normalization.
                        (default: NFC)
```

## augur_curate_parse-genbank-location

### Tool Description
Parses GenBank's location field into 3 separate fields: 'country', 'division', and 'location'. (augur curate)

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur curate parse-genbank-location [-h] [--metadata METADATA]
                                           [--id-column ID_COLUMN]
                                           [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                                           [--fasta FASTA]
                                           [--seq-id-column SEQ_ID_COLUMN]
                                           [--seq-field SEQ_FIELD]
                                           [--unmatched-reporting {error_first,error_all,warn,silent}]
                                           [--duplicate-reporting {error_first,error_all,warn,silent}]
                                           [--output-metadata OUTPUT_METADATA]
                                           [--output-fasta OUTPUT_FASTA]
                                           [--output-id-field OUTPUT_ID_FIELD]
                                           [--output-seq-field OUTPUT_SEQ_FIELD]
                                           [--location-field LOCATION_FIELD]

Parses GenBank's location field into 3 separate fields: 'country', 'division',
and 'location'. Checks that a record is from GenBank by verifying that the
'database' field has a value of "GenBank" or "RefSeq".

options:
  -h, --help            show this help message and exit
  --location-field LOCATION_FIELD
                        The field containing the location, in the format
                        `<geo_loc_name>[:<region>][, <locality>]` (default:
                        geo_loc_name)

INPUTS:
  Input options shared by all `augur curate` commands. If no input options
  are provided, commands will try to read NDJSON records from stdin.

  --metadata METADATA   Input metadata file. May be plain text (TSV, CSV) or
                        an Excel or OpenOffice spreadsheet workbook file. When
                        an Excel or OpenOffice workbook, only the first
                        visible worksheet will be read and initial empty
                        rows/columns will be ignored. Accepts '-' to read
                        plain text from stdin. (default: None)
  --id-column ID_COLUMN
                        Name of the metadata column that contains the record
                        identifier for reporting duplicate records. Uses the
                        first column of the metadata file if not provided.
                        Ignored if also providing a FASTA file input.
                        (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        Delimiters to accept when reading a plain text
                        metadata file. Only one delimiter will be inferred.
                        (default: (',', '\t'))
  --fasta FASTA         Plain or gzipped FASTA file. Headers can only contain
                        the sequence id used to match a metadata record. Note
                        that an index file will be generated for the FASTA
                        file as <filename>.fasta.fxi (default: None)
  --seq-id-column SEQ_ID_COLUMN
                        Name of metadata column that contains the sequence id
                        to match sequences in the FASTA file. (default: None)
  --seq-field SEQ_FIELD
                        The name to use for the sequence field when joining
                        sequences from a FASTA file. (default: None)
  --unmatched-reporting {error_first,error_all,warn,silent}
                        How unmatched records from combined metadata/FASTA
                        input should be reported. (default: error_first)
  --duplicate-reporting {error_first,error_all,warn,silent}
                        How should duplicate records be reported. (default:
                        error_first)

OUTPUTS:
  Output options shared by all `augur curate` commands. If no output options
  are provided, commands will output NDJSON records to stdout.

  --output-metadata OUTPUT_METADATA
                        Output metadata TSV file. Accepts '-' to output TSV to
                        stdout. (default: None)
  --output-fasta OUTPUT_FASTA
                        Output FASTA file. (default: None)
  --output-id-field OUTPUT_ID_FIELD
                        The record field to use as the sequence identifier in
                        the FASTA output. (default: None)
  --output-seq-field OUTPUT_SEQ_FIELD
                        The record field that contains the sequence for the
                        FASTA output. This field will be deleted from the
                        metadata output. (default: None)
```

## augur_curate_passthru

### Tool Description
Pass through records without doing any data transformations. (augur curate)

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur curate passthru [-h] [--metadata METADATA]
                             [--id-column ID_COLUMN]
                             [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                             [--fasta FASTA] [--seq-id-column SEQ_ID_COLUMN]
                             [--seq-field SEQ_FIELD]
                             [--unmatched-reporting {error_first,error_all,warn,silent}]
                             [--duplicate-reporting {error_first,error_all,warn,silent}]
                             [--output-metadata OUTPUT_METADATA]
                             [--output-fasta OUTPUT_FASTA]
                             [--output-id-field OUTPUT_ID_FIELD]
                             [--output-seq-field OUTPUT_SEQ_FIELD]

Pass through records without doing any data transformations. Useful for
testing, troubleshooting, or just converting file formats.

options:
  -h, --help            show this help message and exit

INPUTS:
  Input options shared by all `augur curate` commands. If no input options
  are provided, commands will try to read NDJSON records from stdin.

  --metadata METADATA   Input metadata file. May be plain text (TSV, CSV) or
                        an Excel or OpenOffice spreadsheet workbook file. When
                        an Excel or OpenOffice workbook, only the first
                        visible worksheet will be read and initial empty
                        rows/columns will be ignored. Accepts '-' to read
                        plain text from stdin. (default: None)
  --id-column ID_COLUMN
                        Name of the metadata column that contains the record
                        identifier for reporting duplicate records. Uses the
                        first column of the metadata file if not provided.
                        Ignored if also providing a FASTA file input.
                        (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        Delimiters to accept when reading a plain text
                        metadata file. Only one delimiter will be inferred.
                        (default: (',', '\t'))
  --fasta FASTA         Plain or gzipped FASTA file. Headers can only contain
                        the sequence id used to match a metadata record. Note
                        that an index file will be generated for the FASTA
                        file as <filename>.fasta.fxi (default: None)
  --seq-id-column SEQ_ID_COLUMN
                        Name of metadata column that contains the sequence id
                        to match sequences in the FASTA file. (default: None)
  --seq-field SEQ_FIELD
                        The name to use for the sequence field when joining
                        sequences from a FASTA file. (default: None)
  --unmatched-reporting {error_first,error_all,warn,silent}
                        How unmatched records from combined metadata/FASTA
                        input should be reported. (default: error_first)
  --duplicate-reporting {error_first,error_all,warn,silent}
                        How should duplicate records be reported. (default:
                        error_first)

OUTPUTS:
  Output options shared by all `augur curate` commands. If no output options
  are provided, commands will output NDJSON records to stdout.

  --output-metadata OUTPUT_METADATA
                        Output metadata TSV file. Accepts '-' to output TSV to
                        stdout. (default: None)
  --output-fasta OUTPUT_FASTA
                        Output FASTA file. (default: None)
  --output-id-field OUTPUT_ID_FIELD
                        The record field to use as the sequence identifier in
                        the FASTA output. (default: None)
  --output-seq-field OUTPUT_SEQ_FIELD
                        The record field that contains the sequence for the
                        FASTA output. This field will be deleted from the
                        metadata output. (default: None)
```

## augur_curate_rename

### Tool Description
Renames fields / columns of the input data. (augur curate)

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur curate rename [-h] [--metadata METADATA] [--id-column ID_COLUMN]
                           [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                           [--fasta FASTA] [--seq-id-column SEQ_ID_COLUMN]
                           [--seq-field SEQ_FIELD]
                           [--unmatched-reporting {error_first,error_all,warn,silent}]
                           [--duplicate-reporting {error_first,error_all,warn,silent}]
                           [--output-metadata OUTPUT_METADATA]
                           [--output-fasta OUTPUT_FASTA]
                           [--output-id-field OUTPUT_ID_FIELD]
                           [--output-seq-field OUTPUT_SEQ_FIELD]
                           --field-map FIELD_MAP [FIELD_MAP ...] [--force]

Renames fields / columns of the input data

options:
  -h, --help            show this help message and exit

INPUTS:
  Input options shared by all `augur curate` commands. If no input options
  are provided, commands will try to read NDJSON records from stdin.

  --metadata METADATA   Input metadata file. May be plain text (TSV, CSV) or
                        an Excel or OpenOffice spreadsheet workbook file. When
                        an Excel or OpenOffice workbook, only the first
                        visible worksheet will be read and initial empty
                        rows/columns will be ignored. Accepts '-' to read
                        plain text from stdin. (default: None)
  --id-column ID_COLUMN
                        Name of the metadata column that contains the record
                        identifier for reporting duplicate records. Uses the
                        first column of the metadata file if not provided.
                        Ignored if also providing a FASTA file input.
                        (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        Delimiters to accept when reading a plain text
                        metadata file. Only one delimiter will be inferred.
                        (default: (',', '\t'))
  --fasta FASTA         Plain or gzipped FASTA file. Headers can only contain
                        the sequence id used to match a metadata record. Note
                        that an index file will be generated for the FASTA
                        file as <filename>.fasta.fxi (default: None)
  --seq-id-column SEQ_ID_COLUMN
                        Name of metadata column that contains the sequence id
                        to match sequences in the FASTA file. (default: None)
  --seq-field SEQ_FIELD
                        The name to use for the sequence field when joining
                        sequences from a FASTA file. (default: None)
  --unmatched-reporting {error_first,error_all,warn,silent}
                        How unmatched records from combined metadata/FASTA
                        input should be reported. (default: error_first)
  --duplicate-reporting {error_first,error_all,warn,silent}
                        How should duplicate records be reported. (default:
                        error_first)

OUTPUTS:
  Output options shared by all `augur curate` commands. If no output options
  are provided, commands will output NDJSON records to stdout.

  --output-metadata OUTPUT_METADATA
                        Output metadata TSV file. Accepts '-' to output TSV to
                        stdout. (default: None)
  --output-fasta OUTPUT_FASTA
                        Output FASTA file. (default: None)
  --output-id-field OUTPUT_ID_FIELD
                        The record field to use as the sequence identifier in
                        the FASTA output. (default: None)
  --output-seq-field OUTPUT_SEQ_FIELD
                        The record field that contains the sequence for the
                        FASTA output. This field will be deleted from the
                        metadata output. (default: None)

REQUIRED:
  --field-map FIELD_MAP [FIELD_MAP ...]
                        Rename fields/columns via
                        '{old_field_name}={new_field_name}'. If the new field
                        already exists, then the renaming of the old field
                        will be skipped. Multiple entries with the same
                        '{old_field_name}' will duplicate the field/column.
                        Skips the field if the old field name is the same as
                        the new field name (case-sensitive). (default: None)

OPTIONAL:
  --force               Force renaming of old field even if the new field
                        already exists. Please keep in mind this will
                        overwrite the value of the new field. (default: False)
```

## augur_curate_titlecase

### Tool Description
Applies titlecase to specified string fields. (augur curate)

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur curate titlecase [-h] [--metadata METADATA]
                              [--id-column ID_COLUMN]
                              [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                              [--fasta FASTA] [--seq-id-column SEQ_ID_COLUMN]
                              [--seq-field SEQ_FIELD]
                              [--unmatched-reporting {error_first,error_all,warn,silent}]
                              [--duplicate-reporting {error_first,error_all,warn,silent}]
                              [--output-metadata OUTPUT_METADATA]
                              [--output-fasta OUTPUT_FASTA]
                              [--output-id-field OUTPUT_ID_FIELD]
                              [--output-seq-field OUTPUT_SEQ_FIELD]
                              --titlecase-fields [TITLECASE_FIELDS ...]
                              [--articles [ARTICLES ...]]
                              [--abbreviations [ABBREVIATIONS ...]]
                              [--failure-reporting {error_first,error_all,warn,silent}]

Applies titlecase to specified string fields

options:
  -h, --help            show this help message and exit

INPUTS:
  Input options shared by all `augur curate` commands. If no input options
  are provided, commands will try to read NDJSON records from stdin.

  --metadata METADATA   Input metadata file. May be plain text (TSV, CSV) or
                        an Excel or OpenOffice spreadsheet workbook file. When
                        an Excel or OpenOffice workbook, only the first
                        visible worksheet will be read and initial empty
                        rows/columns will be ignored. Accepts '-' to read
                        plain text from stdin. (default: None)
  --id-column ID_COLUMN
                        Name of the metadata column that contains the record
                        identifier for reporting duplicate records. Uses the
                        first column of the metadata file if not provided.
                        Ignored if also providing a FASTA file input.
                        (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        Delimiters to accept when reading a plain text
                        metadata file. Only one delimiter will be inferred.
                        (default: (',', '\t'))
  --fasta FASTA         Plain or gzipped FASTA file. Headers can only contain
                        the sequence id used to match a metadata record. Note
                        that an index file will be generated for the FASTA
                        file as <filename>.fasta.fxi (default: None)
  --seq-id-column SEQ_ID_COLUMN
                        Name of metadata column that contains the sequence id
                        to match sequences in the FASTA file. (default: None)
  --seq-field SEQ_FIELD
                        The name to use for the sequence field when joining
                        sequences from a FASTA file. (default: None)
  --unmatched-reporting {error_first,error_all,warn,silent}
                        How unmatched records from combined metadata/FASTA
                        input should be reported. (default: error_first)
  --duplicate-reporting {error_first,error_all,warn,silent}
                        How should duplicate records be reported. (default:
                        error_first)

OUTPUTS:
  Output options shared by all `augur curate` commands. If no output options
  are provided, commands will output NDJSON records to stdout.

  --output-metadata OUTPUT_METADATA
                        Output metadata TSV file. Accepts '-' to output TSV to
                        stdout. (default: None)
  --output-fasta OUTPUT_FASTA
                        Output FASTA file. (default: None)
  --output-id-field OUTPUT_ID_FIELD
                        The record field to use as the sequence identifier in
                        the FASTA output. (default: None)
  --output-seq-field OUTPUT_SEQ_FIELD
                        The record field that contains the sequence for the
                        FASTA output. This field will be deleted from the
                        metadata output. (default: None)

REQUIRED:
  --titlecase-fields [TITLECASE_FIELDS ...]
                        List of fields to convert to titlecase. (default:
                        None)

OPTIONAL:
  --articles [ARTICLES ...]
                        List of articles that should not be converted to
                        titlecase. (default: None)
  --abbreviations [ABBREVIATIONS ...]
                        List of abbreviations that should not be converted to
                        titlecase, keeps uppercase. (default: None)
  --failure-reporting {error_first,error_all,warn,silent}
                        How should failed titlecase formatting be reported.
                        (default: error_first)
```

## augur_curate_transform-strain-name

### Tool Description
Verifies strain name pattern in the 'strain' field. (augur curate)

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur curate transform-strain-name [-h] [--metadata METADATA]
                                          [--id-column ID_COLUMN]
                                          [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                                          [--fasta FASTA]
                                          [--seq-id-column SEQ_ID_COLUMN]
                                          [--seq-field SEQ_FIELD]
                                          [--unmatched-reporting {error_first,error_all,warn,silent}]
                                          [--duplicate-reporting {error_first,error_all,warn,silent}]
                                          [--output-metadata OUTPUT_METADATA]
                                          [--output-fasta OUTPUT_FASTA]
                                          [--output-id-field OUTPUT_ID_FIELD]
                                          [--output-seq-field OUTPUT_SEQ_FIELD]
                                          [--strain-regex STRAIN_REGEX]
                                          [--backup-fields [BACKUP_FIELDS ...]]

Verifies strain name pattern in the 'strain' field. Adds a 'strain' field to
the record if it does not already exist.

options:
  -h, --help            show this help message and exit
  --strain-regex STRAIN_REGEX
                        Regex pattern for strain names. Strain names that do
                        not match the pattern will be dropped. (default: ^.+$)
  --backup-fields [BACKUP_FIELDS ...]
                        List of backup fields to use as strain name if the
                        value in 'strain' does not match the strain regex
                        pattern. If multiple fields are provided, will use the
                        first field that has a non-empty string. (default: [])

INPUTS:
  Input options shared by all `augur curate` commands. If no input options
  are provided, commands will try to read NDJSON records from stdin.

  --metadata METADATA   Input metadata file. May be plain text (TSV, CSV) or
                        an Excel or OpenOffice spreadsheet workbook file. When
                        an Excel or OpenOffice workbook, only the first
                        visible worksheet will be read and initial empty
                        rows/columns will be ignored. Accepts '-' to read
                        plain text from stdin. (default: None)
  --id-column ID_COLUMN
                        Name of the metadata column that contains the record
                        identifier for reporting duplicate records. Uses the
                        first column of the metadata file if not provided.
                        Ignored if also providing a FASTA file input.
                        (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        Delimiters to accept when reading a plain text
                        metadata file. Only one delimiter will be inferred.
                        (default: (',', '\t'))
  --fasta FASTA         Plain or gzipped FASTA file. Headers can only contain
                        the sequence id used to match a metadata record. Note
                        that an index file will be generated for the FASTA
                        file as <filename>.fasta.fxi (default: None)
  --seq-id-column SEQ_ID_COLUMN
                        Name of metadata column that contains the sequence id
                        to match sequences in the FASTA file. (default: None)
  --seq-field SEQ_FIELD
                        The name to use for the sequence field when joining
                        sequences from a FASTA file. (default: None)
  --unmatched-reporting {error_first,error_all,warn,silent}
                        How unmatched records from combined metadata/FASTA
                        input should be reported. (default: error_first)
  --duplicate-reporting {error_first,error_all,warn,silent}
                        How should duplicate records be reported. (default:
                        error_first)

OUTPUTS:
  Output options shared by all `augur curate` commands. If no output options
  are provided, commands will output NDJSON records to stdout.

  --output-metadata OUTPUT_METADATA
                        Output metadata TSV file. Accepts '-' to output TSV to
                        stdout. (default: None)
  --output-fasta OUTPUT_FASTA
                        Output FASTA file. (default: None)
  --output-id-field OUTPUT_ID_FIELD
                        The record field to use as the sequence identifier in
                        the FASTA output. (default: None)
  --output-seq-field OUTPUT_SEQ_FIELD
                        The record field that contains the sequence for the
                        FASTA output. This field will be deleted from the
                        metadata output. (default: None)
```

## augur_export_v1

### Tool Description
Export version 1 JSON schema (separate meta and tree JSONs) for visualization with Auspice.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur export v1 [-h] --tree TREE --metadata FILE
                       [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                       --node-data NODE_DATA [NODE_DATA ...]
                       [--output-tree OUTPUT_TREE] [--output-meta OUTPUT_META]
                       [--auspice-config AUSPICE_CONFIG] [--colors FILE]
                       [--lat-longs LAT_LONGS] [--tree-name TREE_NAME]
                       [--minify-json] [--output-sequence OUTPUT_SEQUENCE]
                       [--reference REFERENCE]
                       [--reference-translations REFERENCE_TRANSLATIONS]

Export version 1 JSON schema (separate meta and tree JSONs) for visualization
with Auspice

options:
  -h, --help            show this help message and exit

REQUIRED:
  --tree, -t TREE       tree to perform trait reconstruction on (default:
                        None)
  --metadata FILE       sequence metadata (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        delimiters to accept when reading a metadata file.
                        Only one delimiter will be inferred. (default: (',',
                        '\t'))
  --node-data NODE_DATA [NODE_DATA ...]
                        JSON files with meta data for each node (default:
                        None)
  --output-tree OUTPUT_TREE
                        JSON file name that is passed on to auspice (e.g.,
                        zika_tree.json). (default: None)
  --output-meta OUTPUT_META
                        JSON file name that is passed on to auspice (e.g.,
                        zika_meta.json). (default: None)
  --auspice-config AUSPICE_CONFIG
                        file with auspice configuration (default: None)

OPTIONS:
  --colors FILE         Custom color definitions, one per line in the format
                        `TRAIT_TYPE\tTRAIT_VALUE\tHEX_CODE` (default: None)
  --lat-longs LAT_LONGS
                        file latitudes and longitudes, overrides built in
                        mappings (default: None)
  --tree-name TREE_NAME
                        Tree name (needed for tangle tree functionality)
                        (default: False)
  --minify-json         export JSONs without indentation or line returns
                        (default: False)
  --output-sequence OUTPUT_SEQUENCE
                        JSON file name that is passed on to auspice (e.g.,
                        zika_seq.json). (default: None)
  --reference REFERENCE
                        reference sequence for export to browser, only vcf
                        (default: None)
  --reference-translations REFERENCE_TRANSLATIONS
                        reference translations for export to browser, only vcf
                        (default: None)
```

## augur_export_v2

### Tool Description
Export version 2 JSON schema for visualization with Auspice.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur export v2 [-h] --tree newick --output JSON
                       [--auspice-config JSON [JSON ...]] [--title title]
                       [--maintainers name [name ...]] [--build-url url]
                       [--description description.md] [--warning text or file]
                       [--geo-resolutions trait [trait ...]]
                       [--color-by-metadata trait [trait ...]]
                       [--metadata-columns METADATA_COLUMNS [METADATA_COLUMNS ...]]
                       [--panels panels [panels ...]]
                       [--node-data JSON [JSON ...]] [--metadata FILE]
                       [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                       [--metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]]
                       [--colors FILE] [--lat-longs TSV] [--minify-json |
                       --no-minify-json] [--include-root-sequence |
                       --include-root-sequence-inline]
                       [--validation-mode {error,warn,skip}]
                       [--skip-validation] [--output-auspice-config JSON]

Export version 2 JSON schema for visualization with Auspice

options:
  -h, --help            show this help message and exit

REQUIRED:
  --tree, -t newick     Phylogenetic tree, usually output from `augur refine`
                        (default: None)
  --output JSON         Output file (typically for visualisation in auspice)
                        (default: None)

DISPLAY CONFIGURATION:
  These control the display settings for auspice. Config JSON(s) allow
  customisation of all available options whereas individual command line
  arguments are more limited but great to get started. Supplying both is
  fine too, command line args will overrule what is set in the config file.
  Multiple JSONs will be merged together, and lists present in multiple
  configs will be merged by extending the original list.

  --auspice-config JSON [JSON ...]
                        Auspice configuration file(s) (default: [])
  --title title         Title to be displayed by auspice (default: None)
  --maintainers name [name ...]
                        Analysis maintained by, in format 'Name <URL>' 'Name2
                        <URL>', ... (default: None)
  --build-url url       Build URL/repository to be displayed by Auspice
                        (default: None)
  --description description.md
                        Markdown file with description of build and/or
                        acknowledgements to be displayed by Auspice (default:
                        None)
  --warning text or file
                        Text or file in Markdown format to be displayed as a
                        warning banner by Auspice (default: None)
  --geo-resolutions trait [trait ...]
                        Geographic traits to be displayed on map (default:
                        None)
  --color-by-metadata trait [trait ...]
                        Metadata columns to include as coloring options.
                        Ignores columns named 'none', so please rename them if
                        you would like to include them as colorings. (default:
                        None)
  --metadata-columns METADATA_COLUMNS [METADATA_COLUMNS ...]
                        Metadata columns to export in addition to columns
                        provided by --color-by-metadata or colorings in the
                        Auspice configuration file. These columns will not be
                        used as coloring options in Auspice but will be
                        visible in the tree. Ignores columns named 'none', so
                        please rename them if you would like to include them
                        as metadata fields. (default: None)
  --panels panels [panels ...]
                        Restrict panel display in auspice. Options are tree,
                        map, entropy, frequencies, measurements. Ignore this
                        option to display all available panels. (default:
                        None)

OPTIONAL INPUT FILES:
  --node-data JSON [JSON ...]
                        JSON files containing metadata for nodes in the tree.
                        Keys are automatically exported as colorings unless
                        special-cased. URLs for a key 'X' can be stored under
                        key 'X__url' and will be automatically exported.
                        (default: None)
  --metadata FILE       Additional metadata for strains in the tree. Columns
                        are not typically exported by default and must be
                        specified via arguments or within the config JSON.
                        URLs for a column 'X' can be stored in column 'X__url'
                        and will be automatically exported. (default: None)
  --metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]
                        delimiters to accept when reading a metadata file.
                        Only one delimiter will be inferred. (default: (',',
                        '\t'))
  --metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]
                        names of possible metadata columns containing
                        identifier information, ordered by priority. Only one
                        ID column will be inferred. (default: ('strain',
                        'name'))
  --colors FILE         Custom color definitions, one per line in the format
                        `TRAIT_TYPE\tTRAIT_VALUE\tHEX_CODE` (default: None)
  --lat-longs TSV       Latitudes and longitudes for geography traits. See
                        this file for the format: <https://github.com/nextstra
                        in/augur/blob/33.0.0/augur/data/lat_longs.tsv>. This
                        file provides the default set of latitudes and
                        longitudes. An additional file specified by this
                        option will extend the default set. Duplicates based
                        on the first two columns will be resolved by taking
                        the coordinates from the user-provided file. (default:
                        None)

OPTIONAL MINIFY SETTINGS:
  By default, output JSON files (both main and sidecar) are automatically
  minimized if the size of the un-minified main JSON file exceeds 5 MB. Use
  these options to override that behavior.

  --minify-json         Always export JSONs without indentation or line
                        returns. A truthy value (e.g. 1) in
                        :envvar:`AUGUR_MINIFY_JSON` has the same effect, but
                        it can be overridden by ``--no-minify-json``.
  --no-minify-json      Always export JSONs to be human readable. This
                        overrides :envvar:`AUGUR_MINIFY_JSON`.

OPTIONAL ROOT-SEQUENCE SETTINGS:
  The root-sequences describe the sequences (nuc + aa) for the parent of the
  tree's root-node. They may represent a reference sequence or the inferred
  sequence at the root node, depending on how they were generated. The data
  is taken directly from the `reference` key within the provided node-data
  JSONs. These arguments are mutually exclusive.

  --include-root-sequence
                        Export as an additional JSON. The filename will follow
                        the pattern of <OUTPUT>_root-sequence.json for a main
                        auspice JSON of <OUTPUT>.json (default: False)
  --include-root-sequence-inline
                        Export the root sequence within the dataset JSON. This
                        should only be used for small genomes for file size
                        reasons. (default: False)

OTHER OPTIONAL SETTINGS:
  --validation-mode {error,warn,skip}
                        Control if optional validation checks are performed
                        and what happens if they fail. 'error' and 'warn'
                        modes perform validation and emit messages about
                        failed validation checks. 'error' mode causes a non-
                        zero exit status if any validation checks failed,
                        while 'warn' does not. 'skip' mode performs no
                        validation. Note that some validation checks are non-
                        optional and as such are not affected by this setting.
                        (default: error)
  --skip-validation     Skip validation of input/output files, equivalent to
                        --validation-mode=skip. Use at your own risk!
                        (default: None)
  --output-auspice-config JSON
                        Write out the merged auspice configuration file for
                        debugging purposes etc. File is only written if you
                        provide multiple config files via --auspice-config.
                        (default: None)
```

## augur_import_beast

### Tool Description
Import beast analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur import beast [-h] --mcc MCC
                          [--most-recent-tip-date MOST_RECENT_TIP_DATE]
                          [--tip-date-regex TIP_DATE_REGEX]
                          [--tip-date-format TIP_DATE_FORMAT]
                          [--tip-date-delimeter TIP_DATE_DELIMETER]
                          [--verbose] [--recursion-limit RECURSION_LIMIT]
                          --output-tree OUTPUT_TREE
                          --output-node-data OUTPUT_NODE_DATA

Parse a BEAST MCC tree for further analysis in augur or export for auspice v2+
(using `augur export v2` or greater).

options:
  -h, --help            show this help message and exit
  --mcc MCC             BEAST MCC tree (default: None)
  --most-recent-tip-date MOST_RECENT_TIP_DATE
                        Numeric date of most recent tip in tree (--tip-date-
                        regex, --tip-date-format and --tip-date-delimeter are
                        ignored if this is set) (default: 0)
  --tip-date-regex TIP_DATE_REGEX
                        regex to extract dates from tip names (default:
                        [0-9]{4}(\-[0-9]{2})*(\-[0-9]{2})*$)
  --tip-date-format TIP_DATE_FORMAT
                        Format of date (if extracted by regex) (default:
                        %Y-%m-%d)
  --tip-date-delimeter TIP_DATE_DELIMETER
                        delimeter used in tip-date-format. Used to match
                        partial dates. (default: -)
  --verbose             Display verbose output. Only useful for debugging.
                        (default: False)
  --recursion-limit RECURSION_LIMIT
                        Set a custom recursion limit (dangerous!) (default:
                        False)
  --output-tree OUTPUT_TREE
                        file name to write tree to (default: None)
  --output-node-data OUTPUT_NODE_DATA
                        file name to write (temporal) branch lengths & BEAST
                        traits as node data (default: None)
```

## augur_measurements_concat

### Tool Description
Concatenate multiple measurements JSONs into a single JSON file.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur measurements concat [-h] --jsons JSONs [JSONs ...]
                                 --output-json JSON
                                 [--default-collection DEFAULT_COLLECTION]
                                 [--minify-json]

Concatenate multiple measurements JSONs into a single JSON file

options:
  -h, --help            show this help message and exit

REQUIRED:
  --jsons JSONs [JSONs ...]
                        Measurement JSON files to concatenate. (default: None)
  --output-json JSON    Output JSON file (default: None)

OPTIONAL SETTINGS:
  --default-collection DEFAULT_COLLECTION
                        The key of the default collection to display. If not
                        provided, the first collection of the first JSON file
                        will be displayed (default: None)
  --minify-json         Concatenate JSONs without indentation or line returns.
                        (default: False)
```

## augur_measurements_export

### Tool Description
Export a measurements JSON for a single collection.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur measurements export [-h] --collection TSV
                                 [--strain-column STRAIN_COLUMN]
                                 [--value-column VALUE_COLUMN]
                                 --output-json JSON [--collection-config JSON]
                                 [--grouping-column GROUPING_COLUMN [GROUPING_COLUMN ...]]
                                 [--key KEY] [--title TITLE]
                                 [--x-axis-label X_AXIS_LABEL]
                                 [--thresholds THRESHOLDS [THRESHOLDS ...]]
                                 [--filters FILTERS [FILTERS ...]]
                                 [--group-by GROUP_BY]
                                 [--measurements-display {raw,mean}]
                                 [--show-overall-mean] [--show-threshold]
                                 [--include-columns INCLUDE_COLUMNS [INCLUDE_COLUMNS ...]]
                                 [--minify-json]

Export a measurements JSON for a single collection

options:
  -h, --help            show this help message and exit

REQUIRED:
  --collection TSV      Collection of measurements and metadata in a TSV file.
                        Keep in mind duplicate columns will be renamed as 'X',
                        'X.1', 'X.2'...'X.N' (default: None)
  --strain-column STRAIN_COLUMN
                        Name of the column containing strain names. Provided
                        column will be renamed to `strain` so please make sure
                        no other columns are named `strain`. Strain names in
                        this column should match the strain names in the
                        corresponding Auspice dataset JSON. (default: strain)
  --value-column VALUE_COLUMN
                        Name of the column containing the numeric values to be
                        plotted for the given collection. Provided column will
                        be renamed to `value` so please make sure no other
                        columns are named `value`. (default: value)
  --output-json JSON    Output JSON file. The file name must follow the
                        Auspice sidecar file naming convention to be
                        recognized as a sidecar file. See Nextstrain data
                        format docs for more details. (default: None)

COLLECTION CONFIGURATION:
  These options control the configuration of the collection for Auspice. You
  can provide a config JSON (which includes all available options) or
  command line arguments (which are more limited). Command line arguments
  will override the values set in the config JSON.

  --collection-config JSON
                        Collection configuration file for advanced
                        configurations. (default: None)
  --grouping-column GROUPING_COLUMN [GROUPING_COLUMN ...]
                        Name of the column(s) that should be used as
                        grouping(s) for measurements. Note that if groupings
                        are provided via command line args, the default group-
                        by field in the config JSON will be dropped. (default:
                        None)
  --key KEY             A short key name of the collection for internal use
                        within Auspice. If not provided via config or command
                        line option, the collection TSV filename will be used.
                        (default: None)
  --title TITLE         The full title of the collection to display in the
                        measurements panel title. If not provided via config
                        or command line option, the panel's default title is
                        'Measurements'. (default: None)
  --x-axis-label X_AXIS_LABEL
                        The short label to display for the x-axis that
                        describles the value of the measurements. If not
                        provided via config or command line option, the
                        panel's default x-axis label is 'measurement values'.
                        (default: None)
  --thresholds THRESHOLDS [THRESHOLDS ...]
                        Measurements value threshold(s) to be displayed in the
                        measurements panel. (default: None)
  --filters FILTERS [FILTERS ...]
                        The columns that are to be used a filters for
                        measurements. If not provided, all columns will be
                        available as filters. (default: None)
  --group-by GROUP_BY   The default grouping column. If not provided, the
                        first grouping will be used. (default: None)
  --measurements-display {raw,mean}
                        The default display of the measurements (default:
                        None)
  --show-overall-mean, --hide-overall-mean
                        Show or hide the overall mean per group by default
                        (default: None)
  --show-threshold, --hide-threshold
                        Show or hide the threshold(s) by default. This will be
                        ignored if no threshold(s) are provided. (default:
                        None)

OPTIONAL SETTINGS:
  --include-columns INCLUDE_COLUMNS [INCLUDE_COLUMNS ...]
                        The columns to include from the collection TSV in the
                        measurements JSON. Be sure to list columns that are
                        used as groupings and/or filters. If no columns are
                        provided, then all columns will be included by
                        default. (default: None)
  --minify-json         Export JSON without indentation or line returns.
                        (default: False)
```

## augur_titers_sub

### Tool Description
Annotate titer drops onto substitutions with the substitution titer model.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur titers sub [-h] --titers TITERS [TITERS ...]
                        --alignment ALIGNMENT [ALIGNMENT ...]
                        --gene-names GENE_NAMES [GENE_NAMES ...] [--tree TREE]
                        [--allow-empty-model]
                        [--attribute-prefix ATTRIBUTE_PREFIX] --output OUTPUT

options:
  -h, --help            show this help message and exit
  --titers TITERS [TITERS ...]
                        file with titer measurements
  --alignment ALIGNMENT [ALIGNMENT ...]
                        sequence to be used in the substitution model,
                        supplied as fasta files
  --gene-names GENE_NAMES [GENE_NAMES ...]
                        names of the sequences in the alignment, same order
                        assumed
  --tree, -t TREE       optional tree to annotate fit titer model to
  --allow-empty-model   allow model to be empty
  --attribute-prefix ATTRIBUTE_PREFIX
                        prefix for node attributes in the JSON output
                        including cumulative titer drop ('cTiterSub') and per-
                        substitution titer drop ('dTiterSub'). Set a prefix to
                        disambiguate annotations from multiple substitution
                        model JSONs in the final Auspice JSON.
  --output, -o OUTPUT   JSON file to save titer model
```

## augur_titers_tree

### Tool Description
Annotate titer drops onto a tree with the tree titer model.

### Metadata
- **Docker Image**: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextstrain/augur
- **Package**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/augur/overview
- **Total Downloads**: 280.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/nextstrain/augur
- **Stars**: N/A

### Original Help Text
```text
usage: augur titers tree [-h] --titers TITERS [TITERS ...] --tree TREE
                         [--allow-empty-model]
                         [--attribute-prefix ATTRIBUTE_PREFIX] --output OUTPUT

options:
  -h, --help            show this help message and exit
  --titers TITERS [TITERS ...]
                        file with titer measurements
  --tree, -t TREE       tree to perform fit titer model to
  --allow-empty-model   allow model to be empty
  --attribute-prefix ATTRIBUTE_PREFIX
                        prefix for node attributes in the JSON output
                        including cumulative titer drop ('cTiter') and per-
                        branch titer drop ('dTiter'). Set a prefix to
                        disambiguate annotations from multiple tree model
                        JSONs in the final Auspice JSON.
  --output, -o OUTPUT   JSON file to save titer model
```

## Metadata
- **Skill**: generated
