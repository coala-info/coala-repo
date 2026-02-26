# strcount CWL Generation Report

## strcount_STRcount

### Tool Description
STRcount: A tool for counting short tandem repeats in sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/strcount:0.1.1--py310h7cba7a3_1
- **Homepage**: https://github.com/sabiqali/strcount
- **Package**: https://anaconda.org/channels/bioconda/packages/strcount/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/strcount/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sabiqali/strcount
- **Stars**: N/A
### Original Help Text
```text
usage: STRcount [-h] --reference REFERENCE --fastq FASTQ --config CONFIG
                --output OUTPUT [--min-identity MIN_IDENTITY]
                [--min-aligned-fraction MIN_ALIGNED_FRACTION]
                [--write-non-spanned]
                [--repeat_orientation REPEAT_ORIENTATION]
                [--prefix_orientation PREFIX_ORIENTATION]
                [--suffix_orientation SUFFIX_ORIENTATION] [--cleanup CLEANUP]
                [--output_directory OUTPUT_DIRECTORY]
                [--multiseed-DP MULTISEED_DP]
                [--precise-clipping PRECISE_CLIPPING]

options:
  -h, --help            show this help message and exit
  --reference REFERENCE
                        the reference from which the STR Graph will be
                        generated
  --fastq FASTQ         the baseaclled reads in fastq format
  --config CONFIG       the config file
  --output OUTPUT       the output file
  --min-identity MIN_IDENTITY
                        only use reads with identity greater than this
  --min-aligned-fraction MIN_ALIGNED_FRACTION
                        require alignments cover this proportion of the query
                        sequence
  --write-non-spanned   do not require the reads to span the prefix/suffix
                        region
  --repeat_orientation REPEAT_ORIENTATION
                        the orientation of the repeat string. + or -
  --prefix_orientation PREFIX_ORIENTATION
                        the orientation of the prefix, + or -
  --suffix_orientation SUFFIX_ORIENTATION
                        the orientation of the suffix, + or -
  --cleanup CLEANUP     do you want to clean up the temporary file?
  --output_directory OUTPUT_DIRECTORY
                        the output directory for all output and temporary
                        files
  --multiseed-DP MULTISEED_DP
                        Aligner option
  --precise-clipping PRECISE_CLIPPING
                        Aligner option: use arg as the identity threshold for
                        a valid alignment.
```

