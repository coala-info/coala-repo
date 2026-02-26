# rock CWL Generation Report

## rock

### Tool Description
Reducing Over-Covering K-mers within FASTQ file(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/rock:2.0--h4ac6f70_2
- **Homepage**: https://gitlab.pasteur.fr/vlegrand/ROCK
- **Package**: https://anaconda.org/channels/bioconda/packages/rock/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rock/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
You must provide filename via -i or arguments to indicate ROCK what to filter.

ROCK 2.0                    Copyright (C) 2016-2022 Institut Pasteur

Reducing Over-Covering K-mers within FASTQ file(s)

USAGE: rock [options] [files]

OPTIONS:
 -i <file>  file containing the name(s)  of the input FASTQ file(s) to
            process;  single-end: one file name per line;  paired-end:
            two file names  per line  separated by  a comma;  up to 15
            FASTQ file  names can  be specified;  of note,  input file
            name(s) can also be specified as program argument(s)
 -o <file>  file containing the  name(s) of the  output FASTQ file(s);
            FASTQ file name(s) should be structured in the same way as
            the file specified in option -i.
 -k <int>   k-mer length (default 25)
 -c <int>   lower-bound k-mer coverage depth threshold (default: 0)
 -C <int>   upper-bound k-mer coverage depth threshold (default: 70)
 -l <int>   number of hashing function(s) (default: 4)
 -n <int>   expected total number of  distinct k-mers within the input
            read sequences; not compatible with option -l.
 -f <float> maximum expected false positive probability when computing
            the optimal number of hashing functions from the number of
            distinct k-mers specified with option -n (default: 0.05).
 -p         process PE reads separately. This allows the selection of 
            more reads which in some cases gives better assembly results.
 -q <int>   sets as valid  only k-mers  made  up  of  nucleotides with
            Phred score (+33 offset) above this cutoff (default: 0)
 -m <int>   minimum number of  valid k-mer(s) to  consider a read;
 -v         verbose mode
 -h         prints this message and exit
```


## Metadata
- **Skill**: generated
