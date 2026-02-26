# krakenhll CWL Generation Report

## krakenhll

### Tool Description
Classify sequences using KrakenHLL

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
- **Homepage**: https://github.com/fbreitwieser/krakenhll
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenhll/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/krakenhll/overview
- **Total Downloads**: 26.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fbreitwieser/krakenhll
- **Stars**: N/A
### Original Help Text
```text
Need to specify input filenames!
Usage: krakenhll --report-file FILENAME [options] <filename(s)>

Options:
  --db NAME               Name for Kraken DB (default: none)
  --threads NUM           Number of threads (default: 1)
  --fasta-input           Input is FASTA format
  --fastq-input           Input is FASTQ format
  --gzip-compressed       Input is gzip compressed
  --bzip2-compressed      Input is bzip2 compressed
  --precision INT         Precision for unique k-mer counting, between 10 and 18 (default: 12)
  --quick                 Quick operation (use first hit or hits)
  --min-hits NUM          In quick op., number of hits req'd for classification
                          NOTE: this is ignored if --quick is not specified
  --unclassified-out FILENAME
                          Print unclassified sequences to filename
  --classified-out FILENAME
                          Print classified sequences to filename
  --output FILENAME       Print output to filename (default: stdout); "off" will
                          suppress normal output
  --only-classified-output
                          Print no Kraken output for unclassified sequences
  --preload               Loads DB into memory before classification
  --paired                The two filenames provided are paired-end reads
  --check-names           Ensure each pair of reads have names that agree
                          with each other; ignored if --paired is not specified
  --help                  Print this message
  --version               Print version information

Experimental:
  --uid-mapping           Map using UID database

If none of the *-input or *-compressed flags are specified, and the 
file is a regular file, automatic format detection is attempted.
```

