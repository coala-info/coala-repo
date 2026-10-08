# extract_fasta_seq CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| extract_fasta_seq | PASS |  |

## extract_fasta_seq

### Tool Description
To extract specific fasta sequences from a fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/extract_fasta_seq:0.0.1--py_0
- **Homepage**: https://github.com/linzhi2013/extract_fasta_seq
- **Package**: https://anaconda.org/channels/bioconda/packages/extract_fasta_seq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: extract_fasta_seq [-h] [-q <str> [<str> ...]] [-f <query file>]
                         [-s [<subject file>]] [-s1 <pattern>] [-s2 <pattern>]
                         [-d1 [<int>]] [-d2 [<int>]] [-o [<outfile>]] [-v]
                         [-V] [--lazy] [--version]

To extract specific fasta sequences from a fasta file. By Guanliang MENG, see
https://github.com/linzhi2013/extract_fasta_seq

optional arguments:
  -h, --help            show this help message and exit
  -q <str> [<str> ...]  query list. "-s1" and "-d1" have no effect on this
                        option.
  -f <query file>       query list file, one line should contain only one
                        queryid! (but can be mixed with others, and we can use
                        "-s1" and "-d1" option to extract the queryid)
  -s [<subject file>]   subject file [stdin]
  -s1 <pattern>         query file sep_pattern [\s+]
  -s2 <pattern>         subject file sep_pattern [\s+]
  -d1 [<int>]           which field in the query_file is to used? [0]
  -d2 [<int>]           which field in the subject_file is to used? useful for
                        finding out all sequences in the subject_file whose
                        seqids equal to the queryids [0]
  -o [<outfile>]        outfile [stdout]
  -v                    invert the output [False]
  -V                    verbose output
  --lazy                Stop searching once each required seqid has at least
                        one sequence found, which can be problems if some
                        required seqids have more than sequences! Works only
                        for non-invert mode. [False]
  --version             show program's version number and exit
```

