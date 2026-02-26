# bronko CWL Generation Report

## bronko_build

### Tool Description
Create an bronko index of existing viral references for a given species

### Metadata
- **Docker Image**: quay.io/biocontainers/bronko:0.1.3--h4349ce8_0
- **Homepage**: https://github.com/treangenlab/bronko
- **Package**: https://anaconda.org/channels/bioconda/packages/bronko/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bronko/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2026-02-09
- **GitHub**: https://github.com/treangenlab/bronko
- **Stars**: N/A
### Original Help Text
```text
bronko v0.1.3
Developed by Ryan Doughty (Rice University)
Correspondence: rdd4@rice.edu, treangen@rice.edu

Create an bronko index of existing viral references for a given species

Usage: bronko build [OPTIONS]

Options:
  -t, --threads <THREADS>  Number of threads [default: 4]
      --debug              Debug output
      --verbose            Verbose output (warning: very verbose)
  -h, --help               Print help
  -V, --version            Print version

REFERENCE INPUT:
  -g, --genomes <GENOMES>...     Genome files to be built into index (fasta/gzip)
      --file-input <FILE_INPUT>  Path to .txt file containing paths to each file, one line per file, each containing a single genome

KMER:
  -k, --kmer-size <KMER>  Kmer size [default: 21]

OUTPUT:
  -o, --output <OUTPUT>  Name of index file (.bkdb will be added) [default: bronko]
```


## bronko_call

### Tool Description
Perform rapid viral variant calling of viral sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/bronko:0.1.3--h4349ce8_0
- **Homepage**: https://github.com/treangenlab/bronko
- **Package**: https://anaconda.org/channels/bioconda/packages/bronko/overview
- **Validation**: PASS

### Original Help Text
```text
bronko v0.1.3
Developed by Ryan Doughty (Rice University)
Correspondence: rdd4@rice.edu, treangen@rice.edu

Perform rapid viral variant calling of viral sequencing data

Usage: bronko call [OPTIONS]

Options:
  -t, --threads <THREADS>  Number of threads [default: 4]
      --debug              Debug output
      --verbose            Verbose output (warning: very verbose)
  -h, --help               Print help
  -V, --version            Print version

REFERENCE INPUT:
  -g, --genomes <GENOMES>...  Genome fasta(.gz) files to use as references (bronko build will be called)
  -d, --db <DB>               Use a prebuilt bronko db (.bkdb) of genomes of interest

READS INPUT:
  -r, --reads <READS>...                Input single-end reads (fastq/gzip)
  -1, --first-pairs <FIRST_PAIRS>...    First pairs for raw paired-end reads (fastq/gzip)
  -2, --second-pairs <SECOND_PAIRS>...  Second pairs for raw paired-end reads (fastq/gzip)
      --file-input <FILE_INPUT>         Path to .txt file containing paths to each fastq file, one line per file (paired end reads should be tab delimited on same line)

ALGORITHM:
  -k, --kmer-size <KMER>       Kmer size used for analysis [default: 21]
      --min-kmers <MIN_KMERS>  Minimum times a kmer must occur in sequencing data to be used [default: 3]
      --use-full-kmer          Use the entire kmer length for variant positions rather than having [--n-fixed] bases on each end
      --n-fixed <N_FIXED>      Number of fixed positions at the end of each kmer that cannot contribute to pileup [default: 2]

VARIANT CALLING PARAMETERS:
      --min-af <MIN_AF>
          Minimum minor allele frequency to be reported [default: 0.01]
      --no-end-filter
          Do not filter variants from beginning and end k bases of each segment
      --no-strand-filter
          Do not utilize SOR test to filter variants that are present on one strand but not the other
      --no-strand-balance-filter
          Allow variants with extreme strand disbalance pass without SOR check (will not matter if --no-strand-filter present)
      --balance-ratio <STRAND_BALANCE_RATIO>
          Percent of total depth that one strand must be under to be considered unbalanced (must be [0.0-1.0]) [default: 0.1]
      --n-per-strand <N_PER_STRAND>
          Min number of unique kmers to observe to call a variant at any site (needed on both strands if strand filter active) [default: 2]
      --strand_odds <STRAND_ODDS_MAX>
          Maximum strand odds ratio for a variant to pass strand filtering [default: 6]
      --min-depth <MIN_DEPTH>
          Minimum total depth at an allele to call a minor variant (default=100*min_kmers) [default: 300]
      --min-variant-depth <MIN_VARIANT_DEPTH>
          Minimum depth of a minor variant to be called present (default=min_kmers) [default: 3]
      --noise-multiplier <VARIANT_MULTIPLIER>
          How much greater (1x, 1.5x, etc) the minor allele frequency of a variant must be above estimated baseline noise in that region (must be > 1.0x). Note that for variants under 1%, multiplier will be increased exponentially up to +0.5 more [default: 1.5]

OUTPUT:
  -o, --output <OUTPUT>  Folder to output all resulting files [default: bronko_output]

EXTRA OUTPUT FILES:
      --pileup          Also output a tsv of the approximate pileup for each sample and reference
      --alignment       Output an multifasta containing the alignment of all samples to the reference and themselves (only major variant positions)
      --keep-kmer-info  Keep kmer count information and temporary files (deleted by default)
      --consensus       Return consensus sequences for each virus (.fasta format)
```

