# srprism CWL Generation Report

## srprism_help

### Tool Description
Fast Short Read Aligner

### Metadata
- **Docker Image**: quay.io/biocontainers/srprism:2.4.24--hd6d6fdc_6
- **Homepage**: https://github.com/ncbi/SRPRISM
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/srprism/overview
- **Total Downloads**: 43.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ncbi/SRPRISM
- **Stars**: N/A
### Original Help Text
```text
Fast Short Read Aligner 

version 2.4.24-alpha

USAGE:

	srprism cmd [--trace-level <min_level>] [--log-file <file-name>]

COMMON PARAMETERS:

        cmd [required]

            Action to perform. Possible values are:

                * help           - get usage help;

                * search         - search for occurrences of the queries in 
                    the database;

                * mkindex        - create index from a source database.

        --trace-level <min_level> [default: warning]

            Minimum message level to report to the log stream. Possible 
            values are "debug", "info", "warning", "error", "quiet".

        --log-file <file-name> [optional]

            File for storing diagnostic messages. Default is standard 
            error.



./options_parser_priv.hpp:140 [1] options parser error (unknown key help)
ERROR:   ./options_parser_priv.hpp:140 [1] options parser error (unknown key help) <srprism.cpp:850>
```


## srprism_search

### Tool Description
Fast Short Read Aligner

### Metadata
- **Docker Image**: quay.io/biocontainers/srprism:2.4.24--hd6d6fdc_6
- **Homepage**: https://github.com/ncbi/SRPRISM
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Fast Short Read Aligner 

version 2.4.24-alpha

USAGE:

	srprism cmd [--trace-level <min_level>] [--log-file <file-name>] [--index <basename>] [--input <input-file(s)>] [--output <output-stream>] [--mode <search-mode>] [--errors <max-errors>] [--pair-distance <target-pair-distance>] [--pair-distance-fuzz <fuzz-value>] [--max-query-length <bases>] [--input-format <format-name>] [--input-compression <compression-type>] [--memory <megabytes>] [--batch <batch_size>] [--batch-start <first batch>] [--batch-end <last batch>] [--no-qids] [--no-sids] [--tmpdir <dir-name>] [--plog <file-name>] [--paired <search-type>] [--skip-unmapped <true|false>] [--repeat-threshold <intval>] [--result-conf <result_configuration_spec>] [--sa-start <seeding_area_start_pos>] [--sa-end <seeding_area_end_pos>] [--extra-tags <string>] [--sam-header <file_name>] [--results <max-results>] [--output-format <format-name>]

COMMON PARAMETERS:

        cmd [required]

            Action to perform. Possible values are:

                * help           - get usage help;

                * search         - search for occurrences of the queries in 
                    the database;

                * mkindex        - create index from a source database.

        --trace-level <min_level> [default: warning]

            Minimum message level to report to the log stream. Possible 
            values are "debug", "info", "warning", "error", "quiet".

        --log-file <file-name> [optional]

            File for storing diagnostic messages. Default is standard 
            error.

SEARCH PARAMETERS:

        --index|-I <basename> [required]

            Base name for database index files.

        --input|-i <input-file(s)> [required]

            Specifies the source of the queries. The exact format depends 
            on the value of "--input-format" option. If the input format 
            allows for just one input stream, then the queries can be read 
            from standard input, in the case this option is not present.

        --output|-o <output-stream> [optional]

            File name for program output. By default the standard output 
            stream will be used.

        --mode|-m <search-mode> [default: min-err]

            Search mode; possible values are "min-err", "bound-err", 
            "sum-err", "partial".

        --errors|-n <max-errors> [default: 0]

            Search for alignments with at most this many errors.

        --pair-distance|-s <target-pair-distance> [default: 200]

            For paired search, the target distance between pair alignments 
            in bases.

        --pair-distance-fuzz|-f <fuzz-value> [default: 100]

            Maximum acceptable radius (in bases) around the target 
            distance between paired alignments. If d is the value of 
            "--pair-distance" option and f is the value of the 
            "--pair-distance-fuzz" option than the distance between the 
            alignments in a pair should be in the interval [d-f,d+f] for 
            the pair to be reported.

        --max-query-length <bases> [default: 112]

            Maximum query length. Queries longer than the value specified 
            by this parameter will be truncated.

        --input-format|-F <format-name> [default: fasta]

            The input format name. The possible values are "fasta", 
            "fastq", "cfasta", "cfastq", "sam". See the software 
            documentation for the details of different supported input 
            formats.

            In the case of paired queries some formats use two files that 
            are read in parallel by srprizm. In this case reading from 
            standard input is impossible. Also, in this case, the value of 
            "--input <name>" option is interpreted as follows:

                * if name is of the form "<name1>,<name2>" then name1 and 
                name2 are assumed to be the files containing respectivel first 
                and second members of the pairs.

            Both files have to contain the same number of sequences and 
            the ids of of the corresponding sequences should be identical.

            The formats that have the above restriction are "fasta", 
            "fastq", "cfasta", "cfastq".

            For formats "fasta", "fastq", "cfasta", "cfastq", if a paired 
                search is requested but only a single input file is specified, 
                    then that file has to contain even number of entries, with 
                    each consequtive pair considered one paired-end query.

        --input-compression <compression-type> [default: auto]

            Compression type used for input. The possible values are 
            "auto" (default), "none", "gzip", and "bzip2". If the value 
            given is "auto" then the type of compression is guessed from 
            the file extension.

        --memory|-M <megabytes> [default: 2048]

            Do not use more than this many megabytes of memory for 
            internal dynamic data structures. This number does not include 
            the footprint of the executable code, static data, or stack.

        --batch|-b <batch_size> [optional]

            Process input in batches of at most this many queries.

        --batch-start <first batch> [optional]

            First batch to process.

        --batch-end <last batch> [optional]

            Last batch to process.

        --no-qids|-D [flag]

            Do not report ids for queries. Use their ordinal number 
            instead.

        --no-sids [flag]

            Do not report ids for database sequences. Use their ordinal 
            number instead.

        --tmpdir|-T <dir-name> [default: .]

            Directory to store temporary files.

        --plog <file-name> [optional]

            File name where the ordinal ids of queries participating in 
            paired search passes are written.

        --paired|-p <search-type> [required]

            If "true", force paired search; if "false", force unpaired 
            search.

        --skip-unmapped|-S <true|false> [default: true]

            If "true", do not generate records for unmapped queries in SAM 
            output.

        --repeat-threshold|-R <intval> [default: 0]

            Process queries that start with 16-mers that appear at most 
            this many times in the database.

        --result-conf|-c <result_configuration_spec> [default: 0100]

            Select which paired result configurations should be reported.

            Selection is specified as a sequence of 4 digits from {0,1}, 
            where i-th digit is 1 if the i-th configuration is selected. 
            Configurations are encoded by the second mate direction and 
            position in the result relative to the first mate, assuming 
            that the first mate is matched in forward direction.

            Configurations are encoded via the following table:

                0 - the second mate is forward aligned to the right of the 
                first mate;

                1 - the second mate is reverse aligned to the right of the 
                first mate;

                2 - the second mate is forward aligned to the left of the 
                first mate;

                3 - the second mate is reverse aligned to the left of the 
                first mate.

            The following aliases are supported:

                illumina = 0100

                454      = 0100

                solid    = 0010

        --sa-start <seeding_area_start_pos> [default: 1]

            Make sure that the seeding area is selected so that it starts 
            at or after this query position.

        --sa-end <seeding_area_end_pos> [default: 8096]

            Make sure that the seeding area is selected so that it ends at 
            or before this query position.

        --extra-tags <string> [default: ]

            String (normally fixed extra tags) to add to each SAM output 
            record.

        --sam-header <file_name> [default: ]

            Append the content of the file as header to SAM output.

        --results|-r <max-results> [default: 10]

            Maximum number of results to report per query.

        --output-format|-O <format-name> [default: tabular]

            The output format name. The possible values are "tabular", 
            "sam". See the software documentation for the details of 
            different supported output formats.



./options_parser_priv.hpp:245 [3] argument missing (missing required option index)
ERROR:   ./options_parser_priv.hpp:245 [3] argument missing (missing required option index) <srprism.cpp:850>
```


## srprism_mkindex

### Tool Description
Fast Short Read Aligner

### Metadata
- **Docker Image**: quay.io/biocontainers/srprism:2.4.24--hd6d6fdc_6
- **Homepage**: https://github.com/ncbi/SRPRISM
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Fast Short Read Aligner 

version 2.4.24-alpha

USAGE:

	srprism cmd [--trace-level <min_level>] [--log-file <file-name>] [--input <input-file(s)>] [--input-list <file-name>] [--alt-loc <file-name>] [--output <output-stream>] [--input-format <format-name>] [--input-compression <compression-type>] [--output-format <format-name>] [--memory <megabytes>] [--seg-letters <bases>] [--al-extend <bases>]

COMMON PARAMETERS:

        cmd [required]

            Action to perform. Possible values are:

                * help           - get usage help;

                * search         - search for occurrences of the queries in 
                    the database;

                * mkindex        - create index from a source database.

        --trace-level <min_level> [default: warning]

            Minimum message level to report to the log stream. Possible 
            values are "debug", "info", "warning", "error", "quiet".

        --log-file <file-name> [optional]

            File for storing diagnostic messages. Default is standard 
            error.

MKINDEX PARAMETERS:

        --input|-i <input-file(s)> [optional]

            Source database (may be a comma-separated list of file names). 
            This options takes precedence over --input-list.

        --input-list|-l <file-name> [optional]

            Name of the file containing a list of input file names, one 
            name per line.

        --alt-loc|-a <file-name> [optional]

            Name of the alternative loci specification file.

        --output|-o <output-stream> [required]

            Base name for generated database index files.

        --input-format|-F <format-name> [default: fasta]

            The input format name. The possible values are "fasta", 
            "fastq", "cfasta", "cfastq".

        --input-compression <compression-type> [default: auto]

            Compression type used for input. The possible values are 
            "auto" (default), "none", "gzip", and "bzip2". If the value 
            given is "auto" then the type of compression is guessed from 
            the file extension.

        --output-format|-O <format-name> [default: standard]

            The output format name. The possible values are "standard".

        --memory|-M <megabytes> [default: 2048]

            Do not use more than this many megabytes of memory for 
            internal dynamic data structures. This number does not include 
            the footprint of the executable code, static data, or stack.

        --seg-letters <bases> [default: 8192]

            Number of letters in sequence store segment. It is recommended 
            that this value is set to less than half of length of a 
            typical sequence in the reference database. Each reference 
            sequence occupies at least one segment and the sequence store 
            can store at most 2^32 - 1 bases. If the reference has a large 
            number of very short sequence, decreasing this value can help 
            to pack more sequences into the sequence store and optimize 
            memory usage.

        --al-extend <bases> [default: 2000]

            Number of reference bases by which an alternate locus is 
            extended to the left (right) in the case of non-fuzzy left 
            (right) end.



./options_parser_priv.hpp:245 [3] argument missing (missing required option output)
ERROR:   ./options_parser_priv.hpp:245 [3] argument missing (missing required option output) <srprism.cpp:850>
```


## Metadata
- **Skill**: not generated
