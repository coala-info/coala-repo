# kraken2 CWL Generation Report

## kraken2

### Tool Description
Classify sequences using the Kraken 2 algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/kraken2:2.17.1--pl5321h077b44d_0
- **Homepage**: http://ccb.jhu.edu/software/kraken/
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kraken2/overview
- **Total Downloads**: 174.6K
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/DerrickWood/kraken2
- **Stars**: N/A
### Original Help Text
```text
Need to specify input filenames!
Usage: kraken2 [options] <filename(s)>

Options:
  --db NAME               Name for Kraken 2 DB
                          (default: none)
  --threads NUM           Number of threads (default: 1)
  --quick                 Quick operation (use first hit or hits)
  --unclassified-out FILENAME
                          Print unclassified sequences to filename
  --classified-out FILENAME
                          Print classified sequences to filename
  --output FILENAME       Print output to filename (default: stdout); "-" will
                          suppress normal output
  --confidence FLOAT      Confidence score threshold (default: 0.0); must be
                          in [0, 1].
  --minimum-base-quality NUM
                          Minimum base quality used in classification (def: 0,
                          only effective with FASTQ input).
  --report FILENAME       Print a report with aggregrate counts/clade to file
  --use-mpa-style         With --report, format report output like Kraken 1's
                          kraken-mpa-report
  --report-zero-counts    With --report, report counts for ALL taxa, even if
                          counts are zero
  --report-minimizer-data With --report, report minimizer and distinct minimizer
                          count information in addition to normal Kraken report
  --memory-mapping        Avoids loading database into RAM
  --paired                The filenames provided have paired-end reads
  --use-names             Print scientific names instead of just taxids
  --gzip-compressed       Input files are compressed with gzip
  --bzip2-compressed      Input files are compressed with bzip2
  --minimum-hit-groups NUM
                          Minimum number of hit groups (overlapping k-mers
                          sharing the same minimizer) needed to make a call
                          (default: 2)
  --help                  Print this message
  --version               Print version information

If none of the *-compressed flags are specified, and the filename provided
is a regular file, automatic format detection is attempted.
```

