# ostir CWL Generation Report

## ostir

### Tool Description
OSTIR (Open Source Translation Initiation Rates) version 1.1.1

### Metadata
- **Docker Image**: quay.io/biocontainers/ostir:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/barricklab/rbs-calculator
- **Package**: https://anaconda.org/channels/bioconda/packages/ostir/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ostir/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/barricklab/rbs-calculator
- **Stars**: N/A
### Original Help Text
```text
usage: ostir [-h] [-i str/filepath] [-o filepath] [-v int] [-s int] [-e int]
             [-a str] [-p] [-c] [-q] [-j int] [-t [string|csv|fasta]]
             [--version]

OSTIR (Open Source Translation Initiation Rates) version 1.1.1

options:
  -h, --help            show this help message and exit
  -i str/filepath, --input str/filepath
                        Input filename (FASTA/CSV) or DNA/RNA sequence. For
                        CSV input files, there must be a 'seq' or 'sequence'
                        column. Other columns will override any options
                        provided at the command line if they are present:
                        'name/id', 'start', 'end', 'anti-Shine-Dalgarno'
  -o filepath, --output filepath
                        Output file path. If not provided, results will output
                        to the console
  -v int, --versity int
                        Sets the verbosity level. Default 0 is quiet, 1 is
                        normal, 2 is verbose
  -s int, --start int   Most 5' nucleotide position to consider a start codon
                        beginning (1-indexed)
  -e int, --end int     Most 3' nucleotide position to consider a start codon
                        beginning (1-indexed)
  -a str, --anti-Shine-Dalgarno str
                        anti-Shine-Dalgarno sequence: the 9 bases located at
                        the 3' end of 16S rRNA. May be provided as DNA or RNA.
                        Defaults to that of E. coli (ACCTCCTTA).
  -p, --print-sequence  Include the input mRNA sequence in output CSV files
  -c, --circular        Flag the input as circular
  -q, --print-anti-Shine-Dalgarno
                        Include the anti-Shine-Dalgarno sequence in output CSV
                        files
  -j int, --threads int
                        Number of threads for multiprocessing
  -t [string|csv|fasta], --type [string|csv|fasta]
                        Input type (overrides autodetection)
  --version             Print version and quit.
```

