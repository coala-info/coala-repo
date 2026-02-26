# covid-spike-classification CWL Generation Report

## covid-spike-classification

### Tool Description
Classify COVID spike protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/covid-spike-classification:0.6.4--pyhdfd78af_0
- **Homepage**: https://github.com/kblin/covid-spike-classification/
- **Package**: https://anaconda.org/channels/bioconda/packages/covid-spike-classification/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/covid-spike-classification/overview
- **Total Downloads**: 33.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kblin/covid-spike-classification
- **Stars**: N/A
### Original Help Text
```text
usage: covid-spike-classification [-h] [-r REFERENCE] [-i {ab1,fasta,fastq}]
                                  [-o OUTDIR] [-q] [-s] [-d]
                                  [--show-unexpected] [--silence-warnings]
                                  [-z]
                                  reads

positional arguments:
  reads                 A zip file or directory containing the ab1 files to
                        call variants on.

optional arguments:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        Reference FASTA file to use (default:
                        /ref/NC_045512.fasta).
  -i {ab1,fasta,fastq}, --input-format {ab1,fasta,fastq}
                        Select which input format to expect. Choices: ab1,
                        fasta, fastq. default: ab1
  -o OUTDIR, --outdir OUTDIR
                        File to write result CSV and fastq files to (default:
                        2026-02-25).
  -q, --quiet           Suppress noisy output from the tools run
  -s, --stdout          Print results to stdout in addition to writing them to
                        disk
  -d, --debug           Debug mode: Keep bam file around when the parsing
                        crashes
  --show-unexpected     Show unexpected mutations instead of reporting 'no
                        known mutation'
  --silence-warnings    Silence D614G warnings.
  -z, --zip-results     Create a zipfile from the output directory instead of
                        the output directory.
```

