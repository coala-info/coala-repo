# sylph CWL Generation Report

## sylph_sketch

### Tool Description
Sketch sequences into samples (reads) and databases (genomes). Each sample.fq -> sample.sylsp. All *.fa -> *.syldb

### Metadata
- **Docker Image**: quay.io/biocontainers/sylph:0.9.0--ha6fb395_0
- **Homepage**: https://github.com/bluenote-1577/sylph
- **Package**: https://anaconda.org/channels/bioconda/packages/sylph/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sylph/overview
- **Total Downloads**: 22.1K
- **Last updated**: 2025-10-14
- **GitHub**: https://github.com/bluenote-1577/sylph
- **Stars**: N/A
### Original Help Text
```text
sylph-sketch 
Sketch sequences into samples (reads) and databases (genomes). Each sample.fq -> sample.sylsp. All
*.fa -> *.syldb

USAGE:
    sylph sketch [OPTIONS] [--] [FILES]...

OPTIONS:
        --debug         Debug output
    -h, --help          Print help information
    -t <THREADS>        Number of threads [default: 3]
        --trace         Trace output (caution: very verbose)

INPUT:
    -l, --list <LIST_SEQUENCE>
            Newline delimited file with inputs; fastas -> database, fastq -> sample

        --lS <LIST_SAMPLE_NAMES>
            Newline delimited file; read sketches are renamed to given sample names

    -S, --sample-names <SAMPLE_NAMES>...
            Read sketches are renamed to given sample names

    <FILES>...
            fasta/fastq files; gzip optional. Default: fastq file produces a sample sketch (*.sylsp)
            while fasta files are combined into a database (*.syldb).

OUTPUT:
    -d, --sample-output-directory <SAMPLE_OUTPUT_DIR>
            Output directory for sample sketches [default: ./]

    -o, --out-name-db <DB_OUT_NAME>
            Output name for database sketch (with .syldb appended) [default: database]

GENOME INPUT:
    -g, --genomes <GENOMES>...    Genomes in fasta format
        --gl <LIST_GENOMES>       Newline delimited file; inputs assumed genomes
    -i, --individual-records      Use individual records (contigs) for database construction

SINGLE-END INPUT:
    -r, --reads <READS>...    Single-end fasta/fastq reads

PAIRED-END INPUT:
    -1, --first-pairs <FIRST_PAIR>...
            First pairs for paired end reads

    -2, --second-pairs <SECOND_PAIR>...
            Second pairs for paired end reads

        --l1 <LIST_FIRST_PAIR>
            Newline delimited file; inputs are first pair of PE reads

        --l2 <LIST_SECOND_PAIR>
            Newline delimited file; inputs are second pair of PE reads

ALGORITHM:
    -c <C>
            Subsampling rate [default: 200]

        --fpr <FPR>
            False positive rate for read deduplicate hashing; valid values in [0,1). [default:
            0.0001]

    -k <K>
            Value of k. Only k = 21, 31 are currently supported [default: 31]

        --min-spacing <MIN_SPACING_KMER>
            Minimum spacing between selected k-mers on the genomes [default: 30]

        --no-dedup
            Disable read deduplication procedure. Reduces memory; not recommended for illumina data
```


## sylph_profile

### Tool Description
Species-level taxonomic profiling with abundances and ANIs

### Metadata
- **Docker Image**: quay.io/biocontainers/sylph:0.9.0--ha6fb395_0
- **Homepage**: https://github.com/bluenote-1577/sylph
- **Package**: https://anaconda.org/channels/bioconda/packages/sylph/overview
- **Validation**: PASS

### Original Help Text
```text
sylph-profile 
Species-level taxonomic profiling with abundances and ANIs

USAGE:
    sylph profile [OPTIONS] [--] [FILES]...

ARGS:
    <FILES>...    Pre-sketched *.syldb/*.sylsp files. Raw single-end fastq/fasta are allowed and
                  will be automatically sketched to .sylsp/.syldb

OPTIONS:
        --debug
            Debug output

    -h, --help
            Print help information

        --log-reassignments
            Output information for how k-mers for genomes are reassigned during `profile`. Caution:
            can be verbose and slows down computation.

    -s, --sample-threads <SAMPLE_THREADS>
            Number of samples to be processed concurrently. Default: (# of total threads / 3) + 1
            for profile, 1 for query

    -t <THREADS>
            Number of threads [default: 3]

        --trace
            Trace output (caution: very verbose)

INPUT/OUTPUT:
    -l, --list <FILE_LIST>               Newline delimited file of file inputs
    -o, --output-file <OUT_FILE_NAME>    Output to this file (TSV format). [default: stdout]

ALGORITHM:
        --estimate-read-counts
            Very roughly estimate read counts in the 'Sequence_abundance' column instead of relative
            abundance. This forces `-u`, which may have caveats for long reads and complex
            environments.

    -I, --read-seq-id <SEQ_ID>
            Sequence identity (%) of reads. Only used in -u option and overrides automatic
            detection.

    -m, --minimum-ani <MINIMUM_ANI>
            Minimum adjusted ANI to consider (0-100). Default is 90 for query and 95 for profile.
            Smaller than 95 for profile will give inaccurate results.

    -M, --min-number-kmers <MIN_NUMBER_KMERS>
            Exclude genomes with less than this number of sampled k-mers [default: 50]

        --min-count-correct <MIN_COUNT_CORRECT>
            Minimum k-mer multiplicity needed for coverage correction. Higher values gives more
            precision but lower sensitivity [default: 3]

    -u, --estimate-unknown
            Estimate true coverage and scale sequence abundance in `profile` by estimated unknown
            sequence percentage

SKETCHING:
    -r, --reads <READS>...
            Single-end raw reads (fastx/gzip)

    -1, --first-pairs <FIRST_PAIR>...
            First pairs for raw paired-end reads (fastx/gzip)

    -2, --second-pairs <SECOND_PAIR>...
            Second pairs for raw paired-end reads (fastx/gzip)

    -c <C>
            Subsampling rate. Does nothing for pre-sketched files [default: 200]

    -i, --individual-records
            Use individual records (e.g. contigs) for database construction instead. Does nothing
            for pre-sketched files

    -k <K>
            Value of k. Only k = 21, 31 are currently supported. Does nothing for pre-sketched files
            [default: 31]

        --min-spacing <MIN_SPACING_KMER>
            Minimum spacing between selected k-mers on the database genomes. Does nothing for
            pre-sketched files [default: 30]
```


## sylph_query

### Tool Description
Coverage-adjusted ANI querying between databases and samples

### Metadata
- **Docker Image**: quay.io/biocontainers/sylph:0.9.0--ha6fb395_0
- **Homepage**: https://github.com/bluenote-1577/sylph
- **Package**: https://anaconda.org/channels/bioconda/packages/sylph/overview
- **Validation**: PASS

### Original Help Text
```text
sylph-query 
Coverage-adjusted ANI querying between databases and samples

USAGE:
    sylph query [OPTIONS] [--] [FILES]...

ARGS:
    <FILES>...    Pre-sketched *.syldb/*.sylsp files. Raw single-end fastq/fasta are allowed and
                  will be automatically sketched to .sylsp/.syldb

OPTIONS:
        --debug
            Debug output

    -h, --help
            Print help information

        --log-reassignments
            Output information for how k-mers for genomes are reassigned during `profile`. Caution:
            can be verbose and slows down computation.

    -s, --sample-threads <SAMPLE_THREADS>
            Number of samples to be processed concurrently. Default: (# of total threads / 3) + 1
            for profile, 1 for query

    -t <THREADS>
            Number of threads [default: 3]

        --trace
            Trace output (caution: very verbose)

INPUT/OUTPUT:
    -l, --list <FILE_LIST>               Newline delimited file of file inputs
    -o, --output-file <OUT_FILE_NAME>    Output to this file (TSV format). [default: stdout]

ALGORITHM:
        --estimate-read-counts
            Very roughly estimate read counts in the 'Sequence_abundance' column instead of relative
            abundance. This forces `-u`, which may have caveats for long reads and complex
            environments.

    -I, --read-seq-id <SEQ_ID>
            Sequence identity (%) of reads. Only used in -u option and overrides automatic
            detection.

    -m, --minimum-ani <MINIMUM_ANI>
            Minimum adjusted ANI to consider (0-100). Default is 90 for query and 95 for profile.
            Smaller than 95 for profile will give inaccurate results.

    -M, --min-number-kmers <MIN_NUMBER_KMERS>
            Exclude genomes with less than this number of sampled k-mers [default: 50]

        --min-count-correct <MIN_COUNT_CORRECT>
            Minimum k-mer multiplicity needed for coverage correction. Higher values gives more
            precision but lower sensitivity [default: 3]

    -u, --estimate-unknown
            Estimate true coverage and scale sequence abundance in `profile` by estimated unknown
            sequence percentage

SKETCHING:
    -r, --reads <READS>...
            Single-end raw reads (fastx/gzip)

    -1, --first-pairs <FIRST_PAIR>...
            First pairs for raw paired-end reads (fastx/gzip)

    -2, --second-pairs <SECOND_PAIR>...
            Second pairs for raw paired-end reads (fastx/gzip)

    -c <C>
            Subsampling rate. Does nothing for pre-sketched files [default: 200]

    -i, --individual-records
            Use individual records (e.g. contigs) for database construction instead. Does nothing
            for pre-sketched files

    -k <K>
            Value of k. Only k = 21, 31 are currently supported. Does nothing for pre-sketched files
            [default: 31]

        --min-spacing <MIN_SPACING_KMER>
            Minimum spacing between selected k-mers on the database genomes. Does nothing for
            pre-sketched files [default: 30]
```


## sylph_inspect

### Tool Description
Inspect sketched .syldb and .sylsp files

### Metadata
- **Docker Image**: quay.io/biocontainers/sylph:0.9.0--ha6fb395_0
- **Homepage**: https://github.com/bluenote-1577/sylph
- **Package**: https://anaconda.org/channels/bioconda/packages/sylph/overview
- **Validation**: PASS

### Original Help Text
```text
sylph-inspect 
Inspect sketched .syldb and .sylsp files

USAGE:
    sylph inspect [OPTIONS] [FILES]...

ARGS:
    <FILES>...    Pre-sketched *.syldb/*.sylsp files.

OPTIONS:
    -h, --help                           Print help information
    -o, --output-file <OUT_FILE_NAME>    Output to this file (YAML format). [default: stdout]
```

