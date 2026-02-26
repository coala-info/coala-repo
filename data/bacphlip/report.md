# bacphlip CWL Generation Report

## bacphlip

### Tool Description
BACPHLIP is a tool for identifying prophages in bacterial genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/bacphlip:0.9.6--py_0
- **Homepage**: https://github.com/adamhockenberry/bacphlip
- **Package**: https://anaconda.org/channels/bioconda/packages/bacphlip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bacphlip/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/adamhockenberry/bacphlip
- **Stars**: N/A
### Original Help Text
```text
usage: bacphlip [-h] -i INPUT_FILE [-f] [--multi_fasta]
                [--local_hmmsearch LOCAL_HMMSEARCH]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input_file INPUT_FILE
                        Should be a valid path to a single genome (nucleotide)
                        FASTA file containing only 1 record/contig.
  -f, --force_overwrite
                        Whether to overwrite all existing files that will be
                        created if they exist. Default is False
  --multi_fasta         By default, BACPHLIP assumes that the input file
                        contains one genome (nucleotide) sequence record.
                        Users providing a multi_fasta input file must use this
                        flag. Note that each record should be uniquely named
                        and should contain complete genomes for different
                        phages. BACPHLIP should not be run on incomplete /
                        fragmented genomes spanning mulitple records.
  --local_hmmsearch LOCAL_HMMSEARCH
                        By default, BACPHLIP assumes a system install of
                        "hmmsearch". Use this flag to provide a custom path to
                        a local install of hmmsearch if necessary.
```

