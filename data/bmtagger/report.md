# bmtagger CWL Generation Report

## bmtagger_bmtagger.sh

### Tool Description
Identify and tag sequences that match a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/bmtagger:3.101--3
- **Homepage**: https://github.com/movingpictures83/BMTagger
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bmtagger/overview
- **Total Downloads**: 37.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/movingpictures83/BMTagger
- **Stars**: N/A
### Original Help Text
```text
usage: bmtagger [-hV] [-q 0|1] [-C config] -1 input.fa [-2 matepairs.fa] -b genome.wbm -d genome-seqdb -x srindex [-o blacklist] [-T tmpdir] [-X]
usage: bmtagger [-hV] [-q 0|1] [-C config] -1 input.fa [-2 matepairs.fa] --ref=reference [-o blacklist] [-T tmpdir] [-X]
usage: bmtagger [-hV] [-q 0|1] [-C config] -A accession [--ref=reference] [-b genome.wbm] [-d genome-seqdb] [-x srindex] [-T tmpdir]
use --ref=name to point to .wbm, seqdb and srprism index if they have the same path and basename
use --extract or -X to generate fasta or fastq files which will NOT contain tagged sequences (-o required)
use --debug to leave temporary data on exit
use --old-srprism to use options for older version of srprism (interferes with config file)
```


## bmtagger_bmtool

### Tool Description
Build word mask for subject database

### Metadata
- **Docker Image**: quay.io/biocontainers/bmtagger:3.101--3
- **Homepage**: https://github.com/movingpictures83/BMTagger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
bmtool
Build word mask for subject database
where options are:
[general]
  --help                 -h     Print help
  --version              -V     Print version
  --quiet                -q     Do not show progress indicators [off]
[files]
  --fasta-file=''        -d ''  Input fasta or blastdb file
  --output-file=''       -o ''  Output word bitmask file
  --gi-list=''           -l ''  Set gi list for blastdb file
  --input-file=''        -i ''  Set word bitmask file as input
  --fasta-parse-ids=0           Parse FASTA ids (becomes broken if ranges are used)
[hashing parameters]
  --word-size=18         -w 18  Word size to use
  --word-step=1          -S 1   Step (stride size) to use
  --max-amb=0            -A 0   Maximal number of ambiguities to count
  --pattern=0            -p 0   Set pattern to use with discontiguous words, 0x or 0b prefix may be used for hex or bin (-w## will be ignored)
  --max-word-count=0     -W 0   Do not include words counted more than this value (for 16-mers or less)
[output]
  --version=2            -v 2   Create this version of file (0-2)
  --compress             -z     Compress bitmask (requires version 2) [off]
  --extra-compress       -Z     Compress bitmask (requires version 2) looking for duplicate extension sets [off]
  --pack-prefix-bits=26         Bits to use for compression prefix
  --pack-offset-bits=34         Number of bits in table to use for data segment offset
  --pack-count-bits=10          Number of bits to reserve for entry count within segment
[other]
  --mmap                        Memory map source file instead of reading [off]
  --diff                        Diff source and result before writing, repport differences [off]
  --slow                        Slow copy (using query API - to check query api [off]
  --bit-test                    Test bit operations [off]
```

