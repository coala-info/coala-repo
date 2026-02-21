# perl-fastx-reader CWL Generation Report

## perl-fastx-reader

### Tool Description
FAIL to generate CWL: perl-fastx-reader not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-fastx-reader:1.12.0--pl5321hdfd78af_0
- **Homepage**: https://github.com/telatin/FASTQ-Parser
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-fastx-reader/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-fastx-reader/overview
- **Total Downloads**: 56.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/telatin/FASTQ-Parser
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: perl-fastx-reader not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: perl-fastx-reader not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## perl-fastx-reader_fqc

### Tool Description
A FASTA/FASTQ sequence counter that parses a list of files and prints the number of sequences found in each.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-fastx-reader:1.12.0--pl5321hdfd78af_0
- **Homepage**: https://github.com/telatin/FASTQ-Parser
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-fastx-reader/overview
- **Validation**: PASS
### Original Help Text
```text
NAME
    fqc - A FASTA/FASTQ sequence counter

VERSION
    version 1.12.0

SYNOPSIS
      fqc [options] [FILE1 FILE2 FILE3...]

DESCRIPTION
    This program parses a list of FASTA/FASTQ files printing the number of
    sequences found in each file. Reads both uncompressed and GZipped files.
    Default output is the filename, tab, sequence count. Can be changed with
    options.

    The table "key" is the absolute path of each input file, but the printed
    name can be changed with options.

PARAMETERS
  FILE NAME
    *-a, --abspath*
        Print the absolute path of the filename (the absolute path is always
        the table key, but if relative paths are supplied, they will be
        printed).

    *-b, --basename*
        Print the filename without the path.

    *-d, --thousandsep*
        Print reads number with a "," used as thousand separator

  OUTPUT FORMAT
    Default output format is the filename and reads counts, tab separated.
    Options formatting either filename ("-a", "-b") and reads counts ("-d")
    will still work.

    *-t, --tsv* and *-c, --csv*
        Print a tabular output either tab separated (with "-t") or comma
        separated (with "-c").

    *-j, --json*
        Print full output in JSON format.

    *-p, --pretty*
        Same as JSON but in "pretty" format.

    *-x, --screen*
        This feature requires Term::ASCIITable. Print an ASCII-art table
        like:

          .---------------------------------------------------.
          | # | Name                     | Seqs | Gz | Parser |
          +---+--------------------------+------+----+--------+
          | 1 | data/comments.fasta      |    3 |  0 | FASTX  |
          | 2 | data/comments.fastq      |    3 |  0 | FASTQ  |
          | 3 | data/compressed.fasta.gz |    3 |  1 | FASTX  |
          | 4 | data/compressed.fastq.gz |    3 |  1 | FASTQ  |
          '---+--------------------------+------+----+--------'

  SORTING
    *-s, --sortby*
        Sort by field: 'order' (default, that is the order of the input
        files as supplied by the user), 'count' (number of sequences),
        'name' (filename). By default will be descending for numeric fields,
        ascending for 'path'. See "-r, --reverse".

    *-r, --reverse*
        Reverse the sorting order.

  OTHER
    *-f, --fastx*
        Force FASTX reader also for files ending by .fastq or .fq (by
        default would use getFastqRead() )

    *-v, --verbose*
        Increase verbosity

    *-h, --help*
        Display this help page

AUTHOR
    Andrea Telatin <andrea@telatin.com>

COPYRIGHT AND LICENSE
    This software is Copyright (c) 2019 by Andrea Telatin.

    This is free software, licensed under:

      The MIT (X11) License
```

