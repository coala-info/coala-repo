# livekraken CWL Generation Report

## livekraken

### Tool Description
Need to specify input filenames!

### Metadata
- **Docker Image**: quay.io/biocontainers/livekraken:1.0--pl5321h9948957_12
- **Homepage**: https://gitlab.com/SimonHTausch/LiveKraken
- **Package**: https://anaconda.org/channels/bioconda/packages/livekraken/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/livekraken/overview
- **Total Downloads**: 11.3K
- **Last updated**: 2025-08-14
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Need to specify input filenames!
Usage: livekraken [options] <filename(s)>

Options:
  --db NAME               Name for Kraken DB
                          (default: none)
  --threads NUM           Number of threads (default: 1)
  --fasta-input           Input is FASTA format
  --fastq-input           Input is FASTQ format
  --bcl-input             Input is BCL format
  --bcl-length NUM        Number of sequencing cycles
  --bcl-start NUM         First analysis cycle (>31)
  --bcl-spacing NUM       Spacing between classification
  --bcl-lanes NUM NUM ..  The lanes to analyse (e.g. 1 3 4)
                          Default: Analyse all lanes found.
  --bcl-tiles NUM NUM ..  The tiles to analyse (e.g. 1101 2115 2304)
                          Default: 96 tiles (2 sides -> 3 swaths -> 16 tiles).
  --bcl-max-tile NUM      Maximum tile to analyse, in XYZZ tile format.
                          Default: Up to tile 2316 (for 96 tiles.)
                          If this option is used, --bcl-tiles is ignored.
  --gzip-compressed       Input is gzip compressed
  --bzip2-compressed      Input is bzip2 compressed
  --quick                 Quick operation (use first hit or hits)
  --min-hits NUM          In quick op., number of hits req'd for classification
                          NOTE: this is ignored if --quick is not specified
  --unclassified-out FILENAME
                          Print unclassified sequences to filename
  --classified-out FILENAME
                          Print classified sequences to filename
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

