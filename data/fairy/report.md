# fairy CWL Generation Report

## fairy_coverage

### Tool Description
Extremely fast species-level coverage calculation by k-mer sketching

### Metadata
- **Docker Image**: quay.io/biocontainers/fairy:0.5.8--hc1c3326_0
- **Homepage**: https://github.com/bluenote-1577/fairy
- **Package**: https://anaconda.org/channels/bioconda/packages/fairy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fairy/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bluenote-1577/fairy
- **Stars**: N/A
### Original Help Text
```text
fairy-coverage 
Extremely fast species-level coverage calculation by k-mer sketching

USAGE:
    fairy coverage [OPTIONS] [FILES]...

OPTIONS:
        --debug
            Debug output

    -h, --help
            Print help information

    -s, --sample-threads <SAMPLE_THREADS>
            Number of samples to be processed concurrently. Default: (# of total threads / 2) + 1

    -t <THREADS>
            Number of threads [default: 3]

        --trace
            Trace output (caution: very verbose)

INPUT:
    -l, --list <FILE_LIST>    Newline delimited file of file inputs
    <FILES>...            Pre-sketched *.bcsp files and raw fasta/gzip contig files

ALGORITHM:
    -m, --minimum-ani <MINIMUM_ANI>
            Minimum adjusted ANI to consider (0-100) for coverage calculation. Default is 95. Don't
            lower this unless you know what you're doing

    -M, --min-number-kmers <MIN_NUMBER_KMERS>
            Exclude genomes with less than this number of sampled k-mers [default: 8]

SKETCHING:
    -c <C>
            Subsampling rate. Does nothing for pre-sketched files [default: 50]

    -k <K>
            Value of k. Only k = 21, 31 are currently supported. Does nothing for pre-sketched files
            [default: 31]

        --min-spacing <MIN_SPACING_KMER>
            Minimum spacing between selected k-mers on the contigs. [default: 30]

OUTPUT:
        --aemb-format
            Strobealign --aemb format (default: MetaBAT2 format with variances)

    -F, --full-contig-name
            Use full contig name (including characters after the first space)

        --maxbin-format
            Remove contig length, average depth, and variance columns. (default: MetaBAT2 format
            with variances)

    -o, --output-file <OUT_FILE_NAME>
            Output to this file instead of stdout
```


## fairy_sketch

### Tool Description
Sketch (index) reads. Each sample.fq -> sample.bcsp

### Metadata
- **Docker Image**: quay.io/biocontainers/fairy:0.5.8--hc1c3326_0
- **Homepage**: https://github.com/bluenote-1577/fairy
- **Package**: https://anaconda.org/channels/bioconda/packages/fairy/overview
- **Validation**: PASS

### Original Help Text
```text
fairy-sketch 
Sketch (index) reads. Each sample.fq -> sample.bcsp

USAGE:
    fairy sketch [OPTIONS]

OPTIONS:
        --debug         Debug output
    -h, --help          Print help information
    -t <THREADS>        Number of threads [default: 3]
        --trace         Trace output (caution: very verbose)

OUTPUT:
    -d, --sample-output-directory <SAMPLE_OUTPUT_DIR>
            Output directory for sample sketches [default: ./]

        --lS <LIST_SAMPLE_NAMES>
            Newline delimited file; read sketches are renamed to given sample names

    -S, --sample-names <SAMPLE_NAMES>...
            Read sketches are renamed to given sample names as opposed to using the read file name

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
    -c <C>        Subsampling rate [default: 50]
    -k <K>        Value of k. Only k = 21, 31 are currently supported [default: 31]
```

