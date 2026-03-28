# datafunk CWL Generation Report

## datafunk_repair_names

### Tool Description
Repair FASTA headers using a phylogenetic tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cov-ert/datafunk
- **Stars**: N/A
### Original Help Text
```text
usage: datafunk repair_names --fasta <fasta> --tree <tree> --out <outfile>

optional arguments:
  -h, --help     show this help message and exit
  --fasta FASTA
  --tree TREE
  --out OUT
```


## datafunk_remove_fasta

### Tool Description
Removes sequences from a FASTA file based on a filter file.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/datafunk", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/site-packages/datafunk/__main__.py", line 1051, in main
    args.func(args)
  File "/usr/local/lib/python3.8/site-packages/datafunk/subcommands/remove_fasta.py", line 4, in run
    filter_dictionary = filter_list(options.filter_file)
  File "/usr/local/lib/python3.8/site-packages/datafunk/remove_fasta.py", line 5, in filter_list
    with open(input_filter,"r") as filter_file:
TypeError: expected str, bytes or os.PathLike object, not NoneType
```


## datafunk_clean_names

### Tool Description
Cleans trait names in a metadata file.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/datafunk", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/site-packages/datafunk/__main__.py", line 1051, in main
    args.func(args)
  File "/usr/local/lib/python3.8/site-packages/datafunk/subcommands/clean_names.py", line 4, in run
    clean_name(options.input_metadata,options.trait,options.output_metadata)
  File "/usr/local/lib/python3.8/site-packages/datafunk/clean_names.py", line 7, in clean_name
    metadata = pd.read_csv(input_file)
  File "/usr/local/lib/python3.8/site-packages/pandas/io/parsers.py", line 610, in read_csv
    return _read(filepath_or_buffer, kwds)
  File "/usr/local/lib/python3.8/site-packages/pandas/io/parsers.py", line 462, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "/usr/local/lib/python3.8/site-packages/pandas/io/parsers.py", line 819, in __init__
    self._engine = self._make_engine(self.engine)
  File "/usr/local/lib/python3.8/site-packages/pandas/io/parsers.py", line 1050, in _make_engine
    return mapping[engine](self.f, **self.options)  # type: ignore[call-arg]
  File "/usr/local/lib/python3.8/site-packages/pandas/io/parsers.py", line 1867, in __init__
    self._open_handles(src, kwds)
  File "/usr/local/lib/python3.8/site-packages/pandas/io/parsers.py", line 1362, in _open_handles
    self.handles = get_handle(
  File "/usr/local/lib/python3.8/site-packages/pandas/io/common.py", line 558, in get_handle
    ioargs = _get_filepath_or_buffer(
  File "/usr/local/lib/python3.8/site-packages/pandas/io/common.py", line 371, in _get_filepath_or_buffer
    raise ValueError(msg)
ValueError: Invalid file path or buffer object type: <class 'NoneType'>
```


## datafunk_merge_fasta

### Tool Description
Merges multiple FASTA files into a single FASTA file based on a metadata file.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/datafunk", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/site-packages/datafunk/__main__.py", line 1051, in main
    args.func(args)
  File "/usr/local/lib/python3.8/site-packages/datafunk/subcommands/merge_fasta.py", line 4, in run
    merge_fasta(options.folder, options.input_metadata, options.output_fasta)
  File "/usr/local/lib/python3.8/site-packages/datafunk/merge_fasta.py", line 11, in merge_fasta
    with open(metafile) as csv_file:
TypeError: expected str, bytes or os.PathLike object, not NoneType
```


## datafunk_duplicates

### Tool Description
Subcommand for datafunk. The provided help text indicates 'duplicates' is an invalid choice, suggesting it might be a placeholder or an incorrect subcommand name. The valid subcommands are listed.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'duplicates' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_filter_fasta_by_covg_and_length

### Tool Description
Filters a FASTA file based on coverage and length thresholds.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk filter_fasta_by_covg_and_length -i <input_fasta> -t <threshold> [-o <output_fasta>]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FASTA, --input-fasta INPUT_FASTA
                        Input FASTA
  --min-covg MIN_COVG   Integer representing the minimum coverage percentage
                        threshold. Sequences with coverage (strictly) less
                        than this will be excluded from the filtered file.
  --min-length MIN_LENGTH
                        Integer representing the minimum length threshold.
                        Sequences with length (strictly) less than this will
                        be excluded from the filtered file. Default: ?
  -o OUTPUT_FASTA, --output-fasta OUTPUT_FASTA
                        Output file name for resulting filtered FASTA (default
                        adds .filtered to input file name)
  -v, --verbose         Run with high verbosity (debug level logging)
```


## datafunk_Removes

### Tool Description
A command-line tool with various subcommands for data manipulation and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'Removes' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_falls

### Tool Description
Subcommand 'falls' is not a valid subcommand for datafunk. Please choose from the available subcommands.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'falls' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_process_gisaid_sequence_data

### Tool Description
Process raw sequence data in fasta or json format

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk process_gisaid_sequence_data -i <input.json OR input.fasta> [-o <output.fasta>] [-e file1 -e file2 ...] [--stdout]

Process raw sequence data in fasta or json format

required arguments:
  -i GISAID.fasta OR GISAID.json, --input GISAID.fasta OR GISAID.json
                        Sequence data in FASTA/json format

optional arguments:
  -o OUTPUT.fasta, --output-fasta OUTPUT.fasta
                        FASTA format file to write, print to stdout if
                        unspecified
  -e FILE, --exclude FILE
                        A file that contains (anywhere) EPI_ISL_###### IDs to
                        exclude (can provide many files, e.g. -e FILE1 -e
                        FILE2 ...)
  --exclude-uk          Removes all GISAID entries with containing England,
                        Ireland, Scotland or Wales
  --exclude-undated     Removes all GISAID entries with an incomplete date
```


## datafunk_Process

### Tool Description
Process GISAID sequence data

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'Process' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_sam_2_fasta

### Tool Description
aligned sam -> fasta (with optional trim to user-defined (reference) co-ordinates)

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk sam_2_fasta -s <input.sam> -r <reference.fasta> [-o <output.fasta>] [-t [INT]:[INT]] [--prefix-ref] [--stdout]

aligned sam -> fasta (with optional trim to user-defined (reference) co-
ordinates)

required arguments:
  -s in.sam, --sam in.sam
                        samfile
  -r reference.fasta, --reference reference.fasta
                        reference

optional arguments:
  -o out.fasta, --output-fasta out.fasta
                        FASTA format file to write. Prints to stdout if not
                        specified
  -t [[start]:[end]], --trim [[start]:[end]]
                        trim the alignment to these coordinates (0-based,
                        half-open)
  --pad                 if --trim, pad trimmed ends with Ns, to retain
                        reference length
  --prefix-ref          write the reference sequence at the beginning of the
                        file
  --log-inserts         log non-singleton insertions relative to the reference
  --log-all-inserts     log all (including singleton) insertions relative to
                        the reference
  --log-deletions       log non-singleton deletions relative to the reference
  --log-all-deletions   log all (including singleton) deletions relative to
                        the reference
  --stdout              Overides -o/--output-fasta if present and prints
                        output to stdout
```


## datafunk_phylotype_consensus

### Tool Description
Splits a fasta file into phylotypes based on metadata and clade definitions, and generates consensus sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk phylotype_consensus -i <input_fasta> -m <input_metadata> -c <clade_file> -o <output_folder>

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FASTA, --input-fasta INPUT_FASTA
                        Fasta file for splitting into phylotypes
  -m INPUT_METADATA, --input-metadata INPUT_METADATA
                        Input metadata (csv) with phylotype information
  -c CLADE_FILE, --clade-file CLADE_FILE
                        Clade file stating the phylotypes needed to be grouped
  -o OUTPUT_FOLDER, --output-folder OUTPUT_FOLDER
                        Output folder for the phylotype fasta files and
                        consensus file
  -v, --verbose         Run with high verbosity (debug level logging)
```


## datafunk_Split

### Tool Description
Split a fasta file into multiple files based on padding.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'Split' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_consensus

### Tool Description
Subcommand for datafunk, specifically 'consensus'. The available subcommands for datafunk are: 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap'.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'consensus' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_gisaid_json_2_metadata

### Tool Description
Add the info from a Gisaid json dump to an existing metadata table (or create a new one)

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk gisaid_json_2_metadata [-h] -n gisaid.json -c <OLD_metadata.csv / False> -o NEW_metadata.csv -e omissions.txt

Add the info from a Gisaid json dump to an existing metadata table (or create
a new one)

required arguments:
  -n gisaid.json, --new gisaid.json
                        Most recent Gisaid json dump
  -c <OLD_metadata.csv / False>, --csv <OLD_metadata.csv / False>
                        Last metadata table (csv format), or 'False' if you
                        really want (but you will lose date stamp information
                        from previous dumps)
  -o NEW_metadata.csv, --output-metadata NEW_metadata.csv
                        New csv file to write
  -e omissions.txt, --exclude omissions.txt
                        A file that contains (anywhere) EPI_ISL_###### IDs to
                        exclude (can provide more than one file, e.g. -e FILE1
                        -e FILE2 ...)

optional arguments:
  -l lineages.csv, --lineages lineages.csv
                        csv file of ineages to include
```


## datafunk_Add

### Tool Description
A collection of bioinformatics tools for sequence data processing.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'Add' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_metadata

### Tool Description
A collection of bioinformatics tools for data processing and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'metadata' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_set_uniform_header

### Tool Description
Set uniform headers for FASTA and metadata files.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options> set_uniform_header [-h] --input-fasta
                                                          INPUT_FASTA
                                                          --input-metadata
                                                          INPUT_METADATA
                                                          --output-fasta
                                                          OUTPUT_FASTA
                                                          --output-metadata
                                                          OUTPUT_METADATA
                                                          [--gisaid]
                                                          [--cog-uk]
                                                          [--log LOG_FILE]
                                                          [--column-name COLUMN_NAME]
                                                          [--index-column INDEX_COLUMN]
                                                          [--extended]

optional arguments:
  -h, --help            show this help message and exit
  --input-fasta INPUT_FASTA
                        Input FASTA
  --input-metadata INPUT_METADATA
                        Input CSV or TSV
  --output-fasta OUTPUT_FASTA
                        Input FASTA
  --output-metadata OUTPUT_METADATA
                        Input CSV or TSV
  --gisaid              Input data is from GISAID
  --cog-uk              Input data is from COG-UK
  --log LOG_FILE        Log file to use (otherwise uses stdout)
  --column-name COLUMN_NAME
                        Name of column in metadata corresponding to fasta
                        header
  --index-column INDEX_COLUMN
                        Name of column in metadata to parse for string
                        matching with fasta header
  --extended            Longer fasta name
```


## datafunk_fasta

### Tool Description
A collection of bioinformatics tools for sequence data manipulation and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'fasta' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_add_epi_week

### Tool Description
Add epidemiological week and day columns to metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk add_epi_week -i <input_metadata> -o <output_metadata> --date_column <column> [--epi-column-name <column>]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_METADATA, --input-metadata INPUT_METADATA
                        Input CSV or TSV
  -o OUTPUT_METADATA, --output-metadata OUTPUT_METADATA
                        Input CSV or TSV
  --date-column DATE_COLUMN
                        Column name to convert to epi week
  --epi-week-column-name EPI_WEEK_COLUMN_NAME
                        Column name for epi week column
  --epi-day-column-name EPI_DAY_COLUMN_NAME
                        Column name for epi day column
```


## datafunk_optionally

### Tool Description
A collection of bioinformatics tools for sequence data processing and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'optionally' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_process_gisaid_data

### Tool Description
Gisaid json (+ metadata) -> (new) gisaid.fasta + metadata

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk process_gisaid_data --input-json <export.json> --input-metadata <in.csv>
                 --output-fasta <out.fa> --output-metadata <out.csv> --exclude-file <omissions.txt> --exclude-uk --exclude-undated

Gisaid json (+ metadata) -> (new) gisaid.fasta + metadata

required arguments:
  --input-json gisaid.json
                        Gisaid json data
  --input-metadata metadata.in.csv
                        previous metadata (can be 'False')

optional arguments:
  --output-fasta output.fasta
                        fasta format file to write.
  --output-metadata metadata.out.csv
                        metadata file to write.
  --exclude-file FILE   A file that contains (anywhere) EPI_ISL_###### IDs to
                        exclude (can provide many files, e.g. -e FILE1 -e
                        FILE2 ...)
  --exclude-uk          Excludes GISAID entries from England, Ireland,
                        Scotland or Wales from being written to fasta (default
                        is to include them)
  --exclude-undated     Excludes GISAID entries with an incomplete date from
                        being written to fasta (default is to include them)
  --include-subsampled  Write GISAID entries previously flagged as duplicated
                        to fasta (default is to exclude them)
  --include-omitted-file
                        Write GISAID entries excluded in --exclude-file FILE
                        to fasta (default is to exclude them)
```


## datafunk_Gisaid

### Tool Description
Process GISAID sequence data

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'Gisaid' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_pad_alignment

### Tool Description
Pads a FASTA alignment with gaps on the left and/or right.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'pad_alignment' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_pad

### Tool Description
Pad an alignment with gaps

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'pad' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_exclude_uk_seqs

### Tool Description
exclude UK sequences from fasta

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk exclude_uk_seqs -i <input.fasta> -o <output.fasta>

exclude UK sequences from fasta

required arguments:
  -i input.fasta, --input-fasta input.fasta
                        Fasta file to read
  -o output.fasta, --output-fasta output.fasta
                        Fasta file to write
```


## datafunk_get_CDS

### Tool Description
Extracts CDS from alignments in Wuhan-Hu-1 coordinates

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk get_CDS -i <input.fasta> -o <output.fasta> [--translate]

Extracts CDS from alignments in Wuhan-Hu-1 coordinates

required arguments:
  -i input.fasta, --input-fasta input.fasta
                        Fasta file to read

optional arguments:
  -o output.fasta, --output-fasta output.fasta
                        Fasta file to write. Prints to stdout if not specified
  --translate           output amino acid sequence (default is nucleotides)
```


## datafunk_distance_to_root

### Tool Description
calculates per sample genetic distance to WH04 and writes it to 'distances.tsv'

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk distance_to_root --input-fasta <file> --input-metadata <file>

calculates per sample genetic distance to WH04 and writes it to
'distances.tsv'

required arguments:
  --input-fasta input.fasta
                        Fasta file to read. Must be aligned to Wuhan-Hu-1
  --input-metadata input.csv
                        Metadata to read. Must contain epi week information
```


## datafunk_writes

### Tool Description
A tool with various subcommands for data processing.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'writes' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_mask

### Tool Description
mask regions of a fasta file using information in an external file

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk mask -i <file.fasta> -m <mask.txt> -o <file.masked.fasta>

mask regions of a fasta file using information in an external file

required arguments:
  -i input.fasta, --input-fasta input.fasta
                        Fasta file to mask
  -o output.fasta, --output-fasta output.fasta
                        Fasta file to write
  -m, mask.txt, --mask-file mask.txt
                        File with mask instructions to parse
```


## datafunk_external

### Tool Description
External subcommand for datafunk. The provided help text indicates an error and lists available subcommands.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'external' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_curate_lineages

### Tool Description
Find new lineages, merge ones that need merging, split ones that need splitting

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk curate_lineages -i <input_directory>

Find new lineages, merge ones that need merging, split ones that need
splitting

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_DIRECTORY, --input-directory INPUT_DIRECTORY
                        Path to input directory containing traits.csv files
  -o OUTPUT_FILE, --output_file OUTPUT_FILE
                        Name of output CSV
```


## datafunk_ones

### Tool Description
A command-line tool for various bioinformatics data processing tasks.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'ones' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_snp_finder

### Tool Description
Find SNPs from alignment files.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/datafunk", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/site-packages/datafunk/__main__.py", line 1051, in main
    args.func(args)
  File "/usr/local/lib/python3.8/site-packages/datafunk/subcommands/snp_finder.py", line 4, in run
    read_alignment_and_get_snps(options.a, options.snp, options.o)
  File "/usr/local/lib/python3.8/site-packages/datafunk/snp_finder.py", line 57, in read_alignment_and_get_snps
    alignment_file = os.path.join(cwd, alignment)
  File "/usr/local/lib/python3.8/posixpath.py", line 90, in join
    genericpath._check_arg_types('join', a, *p)
  File "/usr/local/lib/python3.8/genericpath.py", line 152, in _check_arg_types
    raise TypeError(f'{funcname}() argument must be str, bytes, or '
TypeError: join() argument must be str, bytes, or os.PathLike object, not 'NoneType'
```


## datafunk_del_finder

### Tool Description
Query an alignment position for deletions

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk del_finder -i <input.fasta> --deletions-file <deletions.csv> --genotypes-table <results.csv>

Query an alignment position for deletions

required arguments:
  -i input.fasta, --input-fasta input.fasta
                        Alignment (to Wuhan-Hu-1) in Fasta format to type
  --deletions-file deletions.csv
                        Input CSV file with deletions type. Format is: 1-based
                        start position of deletion,length of deletion (dont
                        include a header line), eg: 1605,3
  --genotypes-table results.csv
                        CSV file with deletion typing results to write.
                        Returns the genotype for each deletion in --deletions-
                        file for each sequence in --input-fasta: either "ref",
                        "del" or "X" (for missing data)

optional arguments:
  -o output.fasta, --output-fasta output.fasta
                        Fasta file to write
  --append-as-SNP       If invoked, then append the genotype of the deletion
                        as a SNP on the end of the alignment
```


## datafunk_add_header_column

### Tool Description
Add header column to metadata table corresponding to fasta record ids

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options> add_header_column [-h] --input-fasta
                                                         INPUT_FASTA
                                                         --input-metadata
                                                         INPUT_METADATA
                                                         --output-metadata
                                                         OUTPUT_METADATA
                                                         --output-fasta
                                                         OUTPUT_FASTA
                                                         [--gisaid] [--cog-uk]
                                                         [--log LOG_FILE]
                                                         [--column-name COLUMN_NAME]
                                                         [--columns COLUMNS [COLUMNS ...]]

Add header column to metadata table corresponding to fasta record ids

optional arguments:
  -h, --help            show this help message and exit
  --input-fasta INPUT_FASTA
                        Input FASTA
  --input-metadata INPUT_METADATA
                        Input CSV or TSV
  --output-metadata OUTPUT_METADATA
                        Output CSV
  --output-fasta OUTPUT_FASTA
                        Output FASTA
  --gisaid              Input data is from GISAID
  --cog-uk              Input data is from COG-UK
  --log LOG_FILE        Log file to use (otherwise uses stdout)
  --column-name COLUMN_NAME
                        Name of column in metadata corresponding to fasta
                        header
  --columns COLUMNS [COLUMNS ...]
                        List of columns in metadata to parse for string
                        matching with fasta header
```


## datafunk_extract_unannotated_seqs

### Tool Description
extract sequences with an empty cell in a specified cell in a metadata table

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk extract_unannotated_seqs --input-tree <file.tree> --input-metadata <file.csv> --output-tree <file.tree> --output-metadata <file.csv>

extract sequences with an empty cell in a specified cell in a metadata table

required arguments:
  --input-fasta input.fasta
                        fasta file to extract sequences from
  --input-metadata input.csv
                        metadata whose columns and rows will be checked
  --null-column NULL_COLUMN
                        metadata column which will be checked as empty
  --index-column INDEX_COLUMN
                        metadata column to match to fasta file
  --output-fasta output.fasta
                        fasta file to write
```


## datafunk_extract

### Tool Description
Extract unannotated sequences from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'extract' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_cell

### Tool Description
Subcommand for datafunk. The provided 'cell' is not a valid subcommand. Please choose from the available subcommands.

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk <subcommand> <options>
datafunk: error: argument : invalid choice: 'cell' (choose from 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap')
```


## datafunk_AA_finder

### Tool Description
Query a codon position for amino acids

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk AA_finder -i <input.fasta> --codons-file <codons.csv> --genotypes-table <results.csv>

Query a codon position for amino acids

required arguments:
  -i input.fasta, --input-fasta input.fasta
                        Alignment (to Wuhan-Hu-1) in Fasta format to type
  --codons-file codons.csv
                        Input CSV file with codon locations to parse. Format
                        is: name,1-based start position of codon (dont include
                        a header line), eg: d614g,23402
  --genotypes-table results.csv
                        CSV file with amino acid typing results to write.
                        Returns the amino acid at each position in --codons-
                        file for each sequence in --input-fasta, or "X" for
                        missing data
```


## datafunk_bootstrap

### Tool Description
bootstrap an alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/cov-ert/datafunk
- **Package**: https://anaconda.org/channels/bioconda/packages/datafunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: datafunk bootstrap -i <input.fasta> --output-prefix boot -n 100

bootstrap an alignment

required arguments:
  -i input.fasta, --input-fasta input.fasta
                        Alignment in fasta format to bootstrap

optional arguments:
  -p boot, --output-prefix boot
                        Prefix for output files (default is "bootstrap_")
  -n 1                  Number of bootstraps to generate (default is 1)
```


## Metadata
- **Skill**: generated
