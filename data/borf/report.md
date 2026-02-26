# borf CWL Generation Report

## borf

### Tool Description
Get orf predicitions from a nucleotide fasta file

### Metadata
- **Docker Image**: quay.io/biocontainers/borf:1.2--py_0
- **Homepage**: https://github.com/betsig/borf
- **Package**: https://anaconda.org/channels/bioconda/packages/borf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/borf/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/betsig/borf
- **Stars**: N/A
### Original Help Text
```text
usage: borf [-h] [-o OUTPUT_PATH] [-s] [-a] [-l ORF_LENGTH]
            [-u UPSTREAM_INCOMPLETE_LENGTH] [-b BATCH_SIZE] [-f]
            fasta_file

Get orf predicitions from a nucleotide fasta file

positional arguments:
  fasta_file            fasta file to predict ORFs

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_PATH, --output_path OUTPUT_PATH
                        path to write output files. [OUTPUT_PATH].pep and
                        [OUTPUT_PATH].txt (default: input .fa file name)
  -s, --strand          Predict orfs for both strands
  -a, --all_orfs        Return all ORFs for each sequence longer than the
                        cutoff
  -l ORF_LENGTH, --orf_length ORF_LENGTH
                        Minimum ORF length (AA). (default: 100)
  -u UPSTREAM_INCOMPLETE_LENGTH, --upstream_incomplete_length UPSTREAM_INCOMPLETE_LENGTH
                        Minimum length (AA) of uninterupted sequence upstream
                        of ORF to be included for incomplete_5prime
                        transcripts (default: 50)
  -b BATCH_SIZE, --batch_size BATCH_SIZE
                        Number of fasta records to read in in each batch
  -f, --force_overwrite
                        Force overwriting of output files?
```

