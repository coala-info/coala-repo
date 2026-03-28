# smafa CWL Generation Report

## smafa_makedb

### Tool Description
Generate a searchable database

### Metadata
- **Docker Image**: quay.io/biocontainers/smafa:0.8.0--hc1c3326_1
- **Homepage**: https://github.com/wwood/smafa
- **Package**: https://anaconda.org/channels/bioconda/packages/smafa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smafa/overview
- **Total Downloads**: 17.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wwood/smafa
- **Stars**: N/A
### Original Help Text
```text
Generate a searchable database

Usage: smafa makedb [OPTIONS] --input <FILE> --database <FILE>

Options:
  -i, --input <FILE>     Subject sequences to search against [required]
  -d, --database <FILE>  Output DB filename [required]
  -v, --verbose          Print extra debug logging information
      --quiet            Unless there is an error, do not print logging information
  -h, --help             Print help
```


## smafa_query

### Tool Description
This command searches a database for query sequences. The database must be generated with the `makedb` command. The query sequences can be in FASTA or FASTQ format. The output is a tab-separated file with the following columns:

1. Query sequence number (0-indexed)
2. Subject sequence number (0-indexed)
3. Divergence (number of nucleotides different between the two sequences
4. Subject sequence (with dashes and degenerate base symbols shown as Ns)

### Metadata
- **Docker Image**: quay.io/biocontainers/smafa:0.8.0--hc1c3326_1
- **Homepage**: https://github.com/wwood/smafa
- **Package**: https://anaconda.org/channels/bioconda/packages/smafa/overview
- **Validation**: PASS

### Original Help Text
```text
This command searches a database for query sequences. The database must be generated with the `makedb` command. The query sequences can be in FASTA or FASTQ format. The output is a tab-separated file with the following columns:

1. Query sequence number (0-indexed)
2. Subject sequence number (0-indexed)
3. Divergence (number of nucleotides different between the two sequences
4. Subject sequence (with dashes and degenerate base symbols shown as Ns)

Usage: smafa query [OPTIONS] --database <FILE> --query <FILE>

Options:
  -d, --database <FILE>
          Output from makedb [required]

  -q, --query <FILE>
          Query sequences to search with in FASTX format [required]

      --max-divergence <INT>
          Maximum divergence to report hits for, for each sequence [default: not used]

      --max-num-hits <INT>
          Maximum number of hits to report [default: 1]

      --limit-per-sequence <INT>
          Maximum number of hits to report per sequence. Requires --max-num-hits > 1 for now. [default: not used]

  -v, --verbose
          Print extra debug logging information

      --quiet
          Unless there is an error, do not print logging information

  -h, --help
          Print help (see a summary with '-h')
```


## smafa_cluster

### Tool Description
Cluster sequences by similarity

### Metadata
- **Docker Image**: quay.io/biocontainers/smafa:0.8.0--hc1c3326_1
- **Homepage**: https://github.com/wwood/smafa
- **Package**: https://anaconda.org/channels/bioconda/packages/smafa/overview
- **Validation**: PASS

### Original Help Text
```text
Cluster sequences by similarity

Usage: smafa cluster [OPTIONS] --input <FILE>

Options:
  -i, --input <FILE>          FASTA file to cluster [required]
  -d, --max-divergence <INT>  Maximum divergence to report hits for, for each sequence [default: not used]
  -v, --verbose               Print extra debug logging information
      --quiet                 Unless there is an error, do not print logging information
  -h, --help                  Print help
```


## smafa_count

### Tool Description
Print the number of reads/bases in a possibly gzipped FASTX file

### Metadata
- **Docker Image**: quay.io/biocontainers/smafa:0.8.0--hc1c3326_1
- **Homepage**: https://github.com/wwood/smafa
- **Package**: https://anaconda.org/channels/bioconda/packages/smafa/overview
- **Validation**: PASS

### Original Help Text
```text
Print the number of reads/bases in a possibly gzipped FASTX file

Usage: smafa count [OPTIONS] --input [<FILE>...]

Options:
  -i, --input [<FILE>...]  FASTQ file to count [required]
  -v, --verbose            Print extra debug logging information
      --quiet              Unless there is an error, do not print logging information
  -h, --help               Print help
```


## Metadata
- **Skill**: generated
