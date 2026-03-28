# naf CWL Generation Report

## naf_ennaf

### Tool Description
ennaf

### Metadata
- **Docker Image**: quay.io/biocontainers/naf:1.3.0--h3c26d10_0
- **Homepage**: https://github.com/KirillKryukov/naf
- **Package**: https://anaconda.org/channels/bioconda/packages/naf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/naf/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/KirillKryukov/naf
- **Stars**: N/A
### Original Help Text
```text
Usage: ennaf [OPTIONS] [infile]
Options:
  -o FILE            - Write compressed output to FILE
  -c                 - Write to standard output
  -#, --level #      - Use compression level # (from -131072 to 22, default: 1)
  --long N           - Use window of size 2^N for sequence stream (from 10 to 31)
  --temp-dir DIR     - Use DIR as temporary directory
  --name NAME        - Use NAME as prefix for temporary files
  --title TITLE      - Store TITLE as dataset title
  --fasta            - Input is in FASTA format
  --fastq            - Input is in FASTQ format
  --dna              - Input sequence is DNA (default)
  --rna              - Input sequence is RNA
  --protein          - Input sequence is protein
  --text             - Input sequence is text
  --strict           - Fail on unexpected input characters
  --line-length N    - Override line length to N
  --verbose          - Verbose mode
  --keep-temp-files  - Keep temporary files
  --no-mask          - Don't store mask
  -h, --help         - Show help
  -V, --version      - Show version
```


## naf_unnaf

### Tool Description
Decompress NAF files

### Metadata
- **Docker Image**: quay.io/biocontainers/naf:1.3.0--h3c26d10_0
- **Homepage**: https://github.com/KirillKryukov/naf
- **Package**: https://anaconda.org/channels/bioconda/packages/naf/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: unnaf [OUTPUT-TYPE] [file.naf]
Options for selecting output type:
  --format        - File format version
  --part-list     - List of parts
  --sizes         - Part sizes
  --number        - Number of sequences
  --title         - Dataset title
  --ids           - Sequence ids (accession numbers)
  --names         - Full sequence names (including ids)
  --lengths       - Sequence lengths
  --total-length  - Sum of sequence lengths
  --mask          - Masked region lengths
  --4bit          - 4bit-encoded nucleotide sequence (binary data)
  --seq           - Continuous concatenated sequence
  --sequences     - One sequence per line, no names
  --fasta         - FASTA-formatted sequences
  --fastq         - FASTQ-formatted sequences
Other options:
  -o FILE         - Decompress into FILE
  -c              - Write to standard output
  --line-length N - Use lines of width N for FASTA output
  --no-mask       - Ignore mask
  --binary-stdout - Set stdout stream to binary mode.
  --binary-stderr - Set stderr stream to binary mode.
  --binary        - Shortcut for "--binary-stdout --binary-stderr"
  -h, --help      - Show help
  -V, --version   - Show version
```


## Metadata
- **Skill**: generated
