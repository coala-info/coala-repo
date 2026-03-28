# pispino CWL Generation Report

## pispino_pispino_createreadpairslist

### Tool Description
makes a read_pairs_list.

### Metadata
- **Docker Image**: quay.io/biocontainers/pispino:1.1--py35_0
- **Homepage**: https://github.com/hsgweon/pispino
- **Package**: https://anaconda.org/channels/bioconda/packages/pispino/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pispino/overview
- **Total Downloads**: 14.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hsgweon/pispino
- **Stars**: N/A
### Original Help Text
```text
usage: makes a read_pairs_list. [-h] -i <DIR> [-o <FILE>]
                                [--label-add-c-end <TXT>]
                                [--label-add-c-front <TXT>]
                                [--label-reindex-c <TXT>] [-f]

optional arguments:
  -h, --help            show this help message and exit
  -i <DIR>              [REQUIRED] Directory with your raw sequences in
                        gzipped FASTQ
  -o <FILE>             Name of output list file.
  --label-add-c-end <TXT>
                        Add a label to the END of each sample ids in the
                        output file. N.B. "_" is not allowed
  --label-add-c-front <TXT>
                        Add a label to the FRONT of each sample ids in the
                        output file. N.B. "_" is not allowed
  --label-reindex-c <TXT>
                        Rename samples with the given label. It will
                        automatically add 001, 002 etc. at the end of each
                        name. N.B. "_" is not allowed
  -f                    Ignore name clash and create a mapping file anyway.
```


## pispino_pispino_seqprep

### Tool Description
reindex, join, quality filter, convert and merge!

### Metadata
- **Docker Image**: quay.io/biocontainers/pispino:1.1--py35_0
- **Homepage**: https://github.com/hsgweon/pispino
- **Package**: https://anaconda.org/channels/bioconda/packages/pispino/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pispino_seqprep [-h] -i <DIR> [-o <DIR>] [-l <FILE>] [--FASTX-q <INT>]
                       [--FASTX-p <INT>] [--FASTX-n] [-b <INT>]
                       [--joiner_method {VSEARCH,PEAR,FASTQJOIN}]
                       [--PEAR_options= <STR>] [-r] [-v] [-t <INT>]
                       [--forwardreadsonly]

pispino_seqprep: reindex, join, quality filter, convert and merge!

optional arguments:
  -h, --help            show this help message and exit
  -i <DIR>              [REQUIRED] Directory with raw sequences in gzipped
                        FASTQ
  -o <DIR>              [REQUIRED] Directory to output results
  -l <FILE>             Tap separated file with three columns for sample ids,
                        forward-read filename and reverse-read filename. Only
                        the files listed in this file will be processed.
  --FASTX-q <INT>       FASTX FASTQ_QUALITY_FILTER - Minimum quality score to
                        keep [default: 30]
  --FASTX-p <INT>       FASTX FASTQ_QUALITY_FILTER - Minimum percent of bases
                        that must have q quality [default: 80]
  --FASTX-n             FASTX FASTQ_TO_FASTA - remove sequences with unknown
                        (N) nucleotides [default: false]
  -b <INT>              Base PHRED quality score [default: 33]
  --joiner_method {VSEARCH,PEAR,FASTQJOIN}
                        Joiner method: "PEAR" and "FASTQJOIN" [default:
                        VSEARCH]
  --PEAR_options= <STR>
                        User customisable parameter: You can add/change PEAR
                        parameters. Please use "--PEAR_options=" followed by
                        custom parameters wrapped around them. E.g.
                        --PEAR_options="-v 8 -t 2". Note that if you put two
                        same parameters such as "-v 8 -v 15", PEAR will use
                        the later.
  -r                    Retain intermediate files (Beware intermediate files
                        use excessive disk space!)
  -v                    Verbose mode
  -t <INT>              Number of Threads [default: 1]
  --forwardreadsonly    Do NOT join paired-end sequences, but just use the
                        forward reads.
```


## Metadata
- **Skill**: generated
