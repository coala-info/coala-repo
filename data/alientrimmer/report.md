# alientrimmer CWL Generation Report

## alientrimmer

### Tool Description
Fast trimming to filter out non-confident nucleotides and alien oligo-nucleotide sequences (adapters, primers) in both 5' and 3' read ends

### Metadata
- **Docker Image**: quay.io/biocontainers/alientrimmer:2.1--hdfd78af_0
- **Homepage**: https://gitlab.pasteur.fr/GIPhy/AlienTrimmer
- **Package**: https://anaconda.org/channels/bioconda/packages/alientrimmer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/alientrimmer/overview
- **Total Downloads**: 349
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
AlienTrimmer v.2.1.201124ac   Copyright (C) 2013-2020  Institut Pasteur

 Fast trimming to  filter out  non-confident  nucleotides and alien  oligo-nucleotide sequences
 (adapters, primers) in both 5' and 3' read ends
 Criscuolo and Brisse (2013) doi:10.1016/j.ygeno.2013.07.011

 USAGE:  AlienTrimmer  [options]

 OPTIONS:
    -i <infile>   [SE] FASTQ-formatted input file; filename should end with .gz when gzipped
    -1 <infile>   [PE] FASTQ-formatted R1 input file; filename should end with .gz when gzipped
    -2 <infile>   [PE] FASTQ-formatted R2 input file; filename should end with .gz when gzipped
    -a <infile>   [SE/PE] input file name containing alien sequence(s);  one line per sequence;
                  lines starting with '>', '%' or '#' are not considered
  --a1 <infile>   [PE] same as -a for only R1 reads
  --a2 <infile>   [PE] same as -a for only R2 reads
    -o <name>     outfile basename: [SE] <name>.fastq[.gz]  or  [PE] <name>.{1,2,S}.fastq[.gz];
                  .gz is added when using option -z
    -k [5-15]     k-mer length k for alien sequence occurence searching; must lie between 5 and
                  15 (default: 10)
    -q [0-40]     Phred quality score  cutoff to define  low-quality bases;  must lie between 0
                  and 40 (default: 13)
    -m <int>      maximum no. allowed successive  non-troublesome bases in the 5'/3' regions to
                  be trimmed (default: k-1)
    -l <int>      minimum allowed read length (default: 50)
    -p [0-100]    maximum allowed percentage of low-quality bases per read (default: 50)
 --p64            Phred+64 FASTQ input file(s) (default: Phred+33)
    -z            gzipped output files (default: not set)
    -v            verbose mode (default: not set)

 EXAMPLES:
  [SE]  AlienTrimmer -i reads.fq -c aliens.fa -o trim -l 30 -p 20
  [SE]  AlienTrimmer -i reads.fq.gz -c aliens.txt -o trim -k 9 -q 13
  [PE]  AlienTrimmer -1 r1.fq -2 r2.fq -c aliens.fa -o trim -m 8 -p 25 -v
  [PE]  AlienTrimmer -1 r2.fq.gz -2 r2.fq.gz --a1 fwd.fa --a2 rev.fa -o trim -z
```


## Metadata
- **Skill**: not generated
