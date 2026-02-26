# fast5seek CWL Generation Report

## fast5seek

### Tool Description
Outputs paths of all the fast5 files from a given directory that are contained within a fastq or BAM/SAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fast5seek:0.1.1--py35_0
- **Homepage**: https://github.com/mbhall88/fast5seek
- **Package**: https://anaconda.org/channels/bioconda/packages/fast5seek/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fast5seek/overview
- **Total Downloads**: 12.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mbhall88/fast5seek
- **Stars**: N/A
### Original Help Text
```text
usage: fast5seek [-h] -i FAST5_DIR [FAST5_DIR ...] -r REFERENCE
                 [REFERENCE ...] [-o OUTPUT] [-m] [--log_level {0,1,2,3,4,5}]
                 [--no_progress_bar]

Outputs paths of all the fast5 files from a given directory that are contained within a fastq or BAM/SAM file.

Please see the github page for more detailed instructions.
https://github.com/mbhall88/fast5seek/

Contributors:
Michael Hall (github@mbhall88)
Darrin Schultz (github@conchoecia)

optional arguments:
  -h, --help            show this help message and exit
  -i FAST5_DIR [FAST5_DIR ...], --fast5_dir FAST5_DIR [FAST5_DIR ...]
                        Directory of fast5 files you want to query. Program
                        will walk recursively through subdirectories.
  -r REFERENCE [REFERENCE ...], --reference REFERENCE [REFERENCE ...]
                        Fastq or BAM/SAM file(s).
  -o OUTPUT, --output OUTPUT
                        Filename to write fast5 paths to. If nothing is
                        entered, it will write the paths to STDOUT.
  -m, --mapped          Only extract read ids for mapped reads in BAM/SAM
                        files.
  --log_level {0,1,2,3,4,5}
                        Level of logging. 0 is none, 5 is for debugging.
                        Default is 4 which will report info, warnings, errors,
                        and critical information.
  --no_progress_bar     Do not display progress bar.
```

