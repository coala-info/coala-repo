# fxtract CWL Generation Report

## fxtract

### Tool Description
Extracts reads from FASTQ files based on patterns.

### Metadata
- **Docker Image**: quay.io/biocontainers/fxtract:2.4--hc29b5fc_3
- **Homepage**: https://github.com/ctSkennerton/fxtract
- **Package**: https://anaconda.org/channels/bioconda/packages/fxtract/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fxtract/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ctSkennerton/fxtract
- **Stars**: N/A
### Original Help Text
```text
Usage: fxtract [options] {-f pattern_file | pattern} {<read1.fx> <read2.fx>}...
       fxtract [options] -I {-f pattern_file | pattern} <read12.fx>...
       fxtract [options] -S {-f pattern_file | pattern} <read.fx>...
	-H           Evaluate patterns in the context of headers (default: sequences)
	-Q           Evaluate patterns in the context of quality scores (default: sequences)
	-C           Evaluate patters in the context of comment strings - everything after
	             the first space on the header line of the record (default: sequences)
	-G           pattern is a posix basic regular expression (default: literal substring)
	-E           pattern is a posix extended regular expression (default: literal substring)
	-P           pattern is a perl compatable regular expression (default: literal substring)
	-X           pattern exactly matches the whole string (default: literal substring)
	-r           Match the reverse complement of a literal pattern. Not compatible with regular expressions
	-I           The read file is interleaved (both pairs in a single file)
	-S           The files do not contain pairs. Allows for multiple files to be given on the command line
	-v           Inverse the match criteria. Print pairs that do not contain matches
	-c           Print only the count of reads (or pairs) that were found
	-f <file>    File containing patterns, one per line
	-l           Print file names that contain matches
	-h           Print this help
	-V           Print version
```

