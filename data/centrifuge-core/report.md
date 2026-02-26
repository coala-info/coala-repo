# centrifuge-core CWL Generation Report

## centrifuge-core_centrifuge-build

### Tool Description
Builds a Centrifuge index from reference sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
- **Homepage**: https://github.com/infphilo/centrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/centrifuge-core/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/centrifuge-core/overview
- **Total Downloads**: 10.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/infphilo/centrifuge
- **Stars**: N/A
### Original Help Text
```text
No input sequence or sequence file specified!
Centrifuge version 1.0.4 by the Centrifuge developer team (centrifuge.metagenomics@gmail.com)
Usage: centrifuge-build [options]* --conversion-table <table file> --taxonomy-tree <taxonomy tree file> <reference_in> <cf_index_base>
    reference_in            comma-separated list of files with ref sequences
    centrifuge_index_base          write cf data to files with this dir/basename
Options:
    -c                      reference sequences given on cmd line (as
                            <reference_in>)
    -a/--noauto             disable automatic -p/--bmax/--dcv memory-fitting
    --bmax <int>            max bucket sz for blockwise suffix-array builder
    --bmaxdivn <int>        max bucket sz as divisor of ref len (default: 4)
    --dcv <int>             diff-cover period for blockwise (default: 1024)
    --nodc                  disable diff-cover (algorithm becomes quadratic)
    -r/--noref              don't build .3/.4.bt2 (packed reference) portion
    -3/--justref            just build .3/.4.bt2 (packed reference) portion
    -o/--offrate <int>      SA is sampled every 2^offRate BWT chars (default: 4)
    -t/--ftabchars <int>    # of chars consumed in initial lookup (default: 10)
    --conversion-table <file name>  a table that converts any id to a taxonomy id
    --taxonomy-tree    <file name>  taxonomy tree
    --name-table       <file name>  names corresponding to taxonomic IDs
    --size-table       <file name>  table of contig (or genome) sizes
    --seed <int>            seed for random number generator
    -q/--quiet              verbose output (for debugging)
    -p/--threads <int>      number of alignment threads to launch (1)
    --kmer-count <int>      k size for counting the number of distinct k-mer
    -h/--help               print detailed description of tool and its options
    --usage                 print this usage message
    --version               print version information and quit
```


## centrifuge-core_centrifuge

### Tool Description
Centrifuge version 1.0.4 by the Centrifuge developer team (centrifuge.metagenomics@gmail.com)

### Metadata
- **Docker Image**: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
- **Homepage**: https://github.com/infphilo/centrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/centrifuge-core/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/centrifuge-class: option '--h' is ambiguous; possibilities: '--help' '--hadoopout' '--host-taxids'
Centrifuge version 1.0.4 by the Centrifuge developer team (centrifuge.metagenomics@gmail.com)
Usage: 
  centrifuge [options]* -x <cf-idx> {-1 <m1> -2 <m2> | -U <r> | --sample-sheet <s> } [-S <filename>] [--report-file <report>]

  <cf-idx>   Index filename prefix (minus trailing .X.cf).
  <m1>       Files with #1 mates, paired with files in <m2>.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <m2>       Files with #2 mates, paired with files in <m1>.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <r>        Files with unpaired reads.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <s>        A TSV file where each line represents a sample.
  <filename>      File for classification output (default: stdout)
  <report>   File for tabular report output (default: centrifuge_report.tsv)

  <m1>, <m2>, <r> can be comma-separated lists (no whitespace) and can be
  specified many times.  E.g. '-U file1.fq,file2.fq -U file3.fq'.

Options (defaults in parentheses):

 Input:
  -q                 query input files are FASTQ .fq/.fastq (default)
  --qseq             query input files are in Illumina's qseq format
  -f                 query input files are (multi-)FASTA .fa/.mfa
  -r                 query input files are raw one-sequence-per-line
  -c                 <m1>, <m2>, <r> are sequences themselves, not files
  -s/--skip <int>    skip the first <int> reads/pairs in the input (none)
  -u/--upto <int>    stop after first <int> reads/pairs (no limit)
  -5/--trim5 <int>   trim <int> bases from 5'/left end of reads (0)
  -3/--trim3 <int>   trim <int> bases from 3'/right end of reads (0)
  --phred33          qualities are Phred+33 (default)
  --phred64          qualities are Phred+64
  --int-quals        qualities encoded as space-delimited integers
  --ignore-quals     treat all quality values as 30 on Phred scale (off)
  --nofw             do not align forward (original) version of read (off)
  --norc             do not align reverse-complement version of read (off)

Classification:
  --min-hitlen <int>    minimum length of partial hits (default 22, must be greater than 15)
  -k <int>              report upto <int> distinct, primary assignments for each read or pair
  --host-taxids <taxids> comma-separated list of taxonomic IDs that will be preferred in classification
  --exclude-taxids <taxids> comma-separated list of taxonomic IDs that will be excluded in classification

 Output:
  --out-fmt <str>       define output format, either 'tab' or 'sam' (tab)
  --tab-fmt-cols <str>  columns in tabular format, comma separated 
                          default: readID,seqID,taxID,score,2ndBestScore,hitLength,queryLength,numMatches
  -t/--time             print wall-clock time taken by search phases
  --un <path>           write unpaired reads that didn't align to <path>
  --al <path>           write unpaired reads that aligned at least once to <path>
  --un-conc <path>      write pairs that didn't align concordantly to <path>
  --al-conc <path>      write pairs that aligned concordantly at least once to <path>
  (Note: for --un, --al, --un-conc, or --al-conc, add '-gz' to the option name, e.g.
  --un-gz <path>, to gzip compress output, or add '-bz2' to bzip2 compress output.)
  --quiet               print nothing to stderr except serious errors
  --met-file <path>     send metrics to file at <path> (off)
  --met-stderr          send metrics to stderr (off)
  --met <int>           report internal counters & metrics every <int> secs (1)

 Performance:
  -p/--threads <int> number of alignment threads to launch (1)
  --mm               use memory-mapped I/O for index; many instances can share

 Other:
  --qc-filter        filter out reads that are bad according to QSEQ filter
  --seed <int>       seed for random number generator (0)
  --non-deterministic seed rand. gen. arbitrarily instead of using read attributes
  --version          print version information and quit
  -h/--help          print this usage message
Error: Encountered internal Centrifuge exception (#1)
Command: /usr/local/bin/centrifuge-class --wrapper basic-0 --h 
(ERR): centrifuge-class exited with value 1
```


## centrifuge-core_centrifuge-kreport

### Tool Description
centrifuge-kreport creates Kraken-style reports from centrifuge out files.

### Metadata
- **Docker Image**: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
- **Homepage**: https://github.com/infphilo/centrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/centrifuge-core/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: centrifuge-kreport -x <index name> OPTIONS <centrifuge output file(s)>

centrifuge-kreport creates Kraken-style reports from centrifuge out files.

Options:
    -x INDEX            (REQUIRED) Centrifuge index

    --no-lca             Do not report the LCA of multiple assignments, but report count fractions at the taxa.
    --show-zeros         Show clades that have zero reads, too
    --is-count-table     The format of the file is 'taxID<tab>COUNT' instead of the standard
                         Centrifuge output format

    --min-score SCORE    Require a minimum score for reads to be counted
    --min-length LENGTH  Require a minimum alignment length to the read
```


## centrifuge-core_centrifuge-download

### Tool Description
Download sequence databases for Centrifuge.

### Metadata
- **Docker Image**: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
- **Homepage**: https://github.com/infphilo/centrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/centrifuge-core/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified

centrifuge-download [<options>] <database>

ARGUMENT
 <database>        One of refseq, genbank, contaminants or taxonomy:
                     - use refseq or genbank for genomic sequences,
                     - contaminants gets contaminant sequences from UniVec and EmVec,
                     - taxonomy for taxonomy mappings.

COMMON OPTIONS
 -o <directory>         Folder to which the files are downloaded. Default: '.'.
 -P <# of threads>      Number of processes when downloading (uses xargs). Default: '1'

WHEN USING database refseq OR genbank:
 -d <domain>            What domain to download. One or more of bacteria, viral, archaea, fungi, protozoa, invertebrate, plant, vertebrate_mammalian, vertebrate_other (comma separated).
 -a <assembly level>    Only download genomes with the specified assembly level. Default: 'Complete Genome'. Use 'Any' for any assembly level.
 -c <refseq category>   Only download genomes in the specified refseq category. Default: any.
 -t <taxids>            Only download the specified taxonomy IDs, comma separated. Default: any.
 -g <program>           Download using program. Options: rsync, curl, wget. Default wget (auto-detected).
 -r                     Download RNA sequences, too.
 -u                     Filter unplaced sequences.
 -m                     Mask low-complexity regions using dustmasker. Default: off.
 -l                     Modify header to include taxonomy ID. Default: off.
 -v                     Verbose mode
```


## centrifuge-core_centrifuge-RemoveN.pl

### Tool Description
Removes Ns from sequences in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
- **Homepage**: https://github.com/infphilo/centrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/centrifuge-core/overview
- **Validation**: PASS

### Original Help Text
```text
readline() on closed filehandle FP1 at /usr/local/bin/centrifuge-RemoveN.pl line 13.
```

