# subread CWL Generation Report

## Metadata
- **Skill**: generated

## subread_subread-buildindex

### Tool Description
Build an index for the reference genome for Subread aligners.

### Metadata
- **Docker Image**: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
- **Homepage**: https://subread.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/subread/overview
- **Validation**: PASS

### Original Help Text
```text
Version 2.1.1

Usage:

 ./subread-buildindex [options] -o <basename> {FASTA[.gz] file1}\
      [FASTA[.gz] file2] ...

Required arguments:

    -o <basename>   base name of the index to be created

Optional arguments:

    -F              build a full index for the reference genome. 16bp subreads
                    will be extracted from every position of the reference
                    genome. Size of the index is typically 3 times the size of
                    index built from using the default setting.

    -B              create one block of index. The built index will not be split
                    into multiple pieces. This makes the largest amount of
                    memory be requested when running alignments, but it enables
                    the maximum mapping speed to be achieved. This option
                    overrides -M when it is provided as well.

    -M <int>        size of requested memory(RAM) in megabytes, 8000 by default.

    -f <int>        specify the threshold for removing uninformative subreads
                    (highly repetitive 16mers in the reference). 100 by default.

    -c              build a color-space index.

    -v              output version of the program.

For more information about these arguments, please refer to the User Manual.
```
