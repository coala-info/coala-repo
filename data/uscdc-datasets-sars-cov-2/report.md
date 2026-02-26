# uscdc-datasets-sars-cov-2 CWL Generation Report

## uscdc-datasets-sars-cov-2_GenFSGopher.pl

### Tool Description
Reads a standard dataset spreadsheet and downloads its data

### Metadata
- **Docker Image**: quay.io/biocontainers/uscdc-datasets-sars-cov-2:0.7.2--hdfd78af_0
- **Homepage**: https://github.com/CDCgov/datasets-sars-cov-2
- **Package**: https://anaconda.org/channels/bioconda/packages/uscdc-datasets-sars-cov-2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/uscdc-datasets-sars-cov-2/overview
- **Total Downloads**: 17.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CDCgov/datasets-sars-cov-2
- **Stars**: N/A
### Original Help Text
```text
GenFSGopher.pl: Reads a standard dataset spreadsheet and downloads its data

  Usage: GenFSGopher.pl -o outdir spreadsheet.dataset.tsv
  PARAM        DEFAULT  DESCRIPTION
  --outdir     <req'd>  The output directory
  --compressed          Compress files in the output directory
  --format     tsv      The input format. Default: tsv. No other format
                        is accepted at this time.
  --layout     onedir   onedir   - Everything goes into one directory
                        hashsums - Like 'onedir', but will recalculate hashsums
                                   and will ignore hashsum warnings.
                                   (deprecated in favor of adjustHashsums.pl)
                        byrun    - Each genome run gets its separate directory
                        byformat - Fastq files to one dir, assembly to another, etc
                        cfsan    - Reference and samples in separate directories with
                                   each sample in a separate subdirectory
  --shuffled   <NONE>   Output the reads as interleaved instead of individual
                        forward and reverse files.
  --norun      <NONE>   Do not run anything; just create a Makefile.
  --numcpus    1        How many jobs to run at once. Be careful of disk I/O.
  --citation            Print the recommended citation for this script and exit
  --version             Print the version and exit
  --tempdir    ''       Choose a different temp directory than the system default
  --help                Print the usage statement and exit
```

