# primalbedtools CWL Generation Report

## primalbedtools_remap

### Tool Description
Remap IDs in a BED file based on an MSA.

### Metadata
- **Docker Image**: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ChrisgKent/primalbedtools
- **Package**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/ChrisgKent/primalbedtools
- **Stars**: N/A
### Original Help Text
```text
usage: primalbedtools remap [-h] --bed BED --msa MSA --from_id FROM_ID
                            --to_id TO_ID

options:
  -h, --help         show this help message and exit
  --bed BED          Input BED file
  --msa MSA          Input MSA
  --from_id FROM_ID  The ID to remap from
  --to_id TO_ID      The ID to remap to
```


## primalbedtools_sort

### Tool Description
Sort a BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ChrisgKent/primalbedtools
- **Package**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: primalbedtools sort [-h] bed

positional arguments:
  bed         Input BED file

options:
  -h, --help  show this help message and exit
```


## primalbedtools_update

### Tool Description
Update BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ChrisgKent/primalbedtools
- **Package**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: primalbedtools update [-h] bed

positional arguments:
  bed         Input BED file

options:
  -h, --help  show this help message and exit
```


## primalbedtools_amplicon

### Tool Description
Primertrim the amplicons

### Metadata
- **Docker Image**: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ChrisgKent/primalbedtools
- **Package**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: primalbedtools amplicon [-h] [-t] bed

positional arguments:
  bed               Input BED file

options:
  -h, --help        show this help message and exit
  -t, --primertrim  Primertrim the amplicons
```


## primalbedtools_merge

### Tool Description
Merge overlapping intervals in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ChrisgKent/primalbedtools
- **Package**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: primalbedtools merge [-h] bed

positional arguments:
  bed         Input BED file

options:
  -h, --help  show this help message and exit
```


## primalbedtools_fasta

### Tool Description
Convert BED file to FASTA format

### Metadata
- **Docker Image**: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ChrisgKent/primalbedtools
- **Package**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: primalbedtools fasta [-h] bed

positional arguments:
  bed         Input BED file

options:
  -h, --help  show this help message and exit
```


## primalbedtools_validate_bedfile

### Tool Description
Validate a BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ChrisgKent/primalbedtools
- **Package**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: primalbedtools validate_bedfile [-h] bed

positional arguments:
  bed         Input BED file

options:
  -h, --help  show this help message and exit
```


## primalbedtools_validate

### Tool Description
Validate a BED file against a reference FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ChrisgKent/primalbedtools
- **Package**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: primalbedtools validate [-h] bed fasta

positional arguments:
  bed         Input BED file
  fasta       Input reference file

options:
  -h, --help  show this help message and exit
```


## primalbedtools_downgrade

### Tool Description
Downgrades a BED file to a simpler format.

### Metadata
- **Docker Image**: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ChrisgKent/primalbedtools
- **Package**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: primalbedtools downgrade [-h] [--merge-alts] bed

positional arguments:
  bed           Input BED file

options:
  -h, --help    show this help message and exit
  --merge-alts  Should alt primers be merged?
```


## primalbedtools_format

### Tool Description
Format a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ChrisgKent/primalbedtools
- **Package**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: primalbedtools format [-h] bed

positional arguments:
  bed         Input BED file

options:
  -h, --help  show this help message and exit
```


## primalbedtools_csv

### Tool Description
Convert a BED file to CSV format.

### Metadata
- **Docker Image**: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ChrisgKent/primalbedtools
- **Package**: https://anaconda.org/channels/bioconda/packages/primalbedtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: primalbedtools csv [-h] [--no-headers] [--use-header-aliases] bed

positional arguments:
  bed                   Input BED file

options:
  -h, --help            show this help message and exit
  --no-headers          Remove the header row from the CSV
  --use-header-aliases  Should header aliases be used.
```

