# kraken CWL Generation Report

## kraken

### Tool Description
Need to specify input filenames!

### Metadata
- **Docker Image**: biocontainers/kraken:v1.1-3-deb_cv1
- **Homepage**: http://ccb.jhu.edu/software/kraken/
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kraken/overview
- **Total Downloads**: 84.8K
- **Last updated**: 2025-09-30
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Need to specify input filenames!
Usage: kraken [options] <filename(s)>

Options:
  --db NAME               Name for Kraken DB
                          (default: none)
  --threads NUM           Number of threads (default: 1)
  --fasta-input           Input is FASTA format
  --fastq-input           Input is FASTQ format
  --fastq-output          Output in FASTQ format
  --gzip-compressed       Input is gzip compressed
  --bzip2-compressed      Input is bzip2 compressed
  --quick                 Quick operation (use first hit or hits)
  --min-hits NUM          In quick op., number of hits req'd for classification
                          NOTE: this is ignored if --quick is not specified
  --unclassified-out FILENAME
                          Print unclassified sequences to filename
  --classified-out FILENAME
                          Print classified sequences to filename
  --out-fmt FORMAT        Format for [un]classified sequence output. supported 
                          options are: {legacy, paired, interleaved}
  --output FILENAME       Print output to filename (default: stdout); "-" will
                          suppress normal output
  --only-classified-output
                          Print no Kraken output for unclassified sequences
  --preload               Loads DB into memory before classification
  --paired                The two filenames provided are paired-end reads
  --check-names           Ensure each pair of reads have names that agree
                          with each other; ignored if --paired is not specified
  --help                  Print this message
  --version               Print version information

If none of the *-input or *-compressed flags are specified, and the 
file is a regular file, automatic format detection is attempted.
```

