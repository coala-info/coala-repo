# fastkit CWL Generation Report

## fastkit_format

### Tool Description
Reformat FASTA files in preparation for tool execution.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastkit:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/neoformit/fastkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastkit/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/neoformit/fastkit
- **Stars**: N/A
### Original Help Text
```text
usage: fastkit format [-h] [--strip-header-space] [--uppercase] [--headless]
                      filename

Reformat FASTA files in preparation for tool execution.

Available filters:
- Strip spaces from FASTA headers
- Convert sequence characters to uppercase
- Create FASTA from headless sequence

**Escape Galaxy text input** - THIS IS LIKELY UNNECESSARY
  - see https://docs.galaxyproject.org/en/latest/dev/schema.html#id63

positional arguments:
  filename              A filename to parse and correct.

options:
  -h, --help            show this help message and exit
  --strip-header-space  Strip spaces from title and replace with underscore
  --uppercase           Transform all sequence characters to uppercase
  --headless            Create a single FASTA sequence from a headless FASTA file
```


## fastkit_validate

### Tool Description
Validate FASTA files in preparation for tool execution.

These functions should not alter contents but only raise exceptions or return
boolean values to communicate validity of data.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastkit:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/neoformit/fastkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastkit validate [-h] [--protein] [--dna] [--no-unknown]
                        [--sequence-count SEQUENCE_COUNT]
                        [--min-length MIN_LENGTH] [--max-length MAX_LENGTH]
                        filename

Validate FASTA files in preparation for tool execution.

These functions should not alter contents but only raise exceptions or return
boolean values to communicate validity of data.

Available validators:
- dna
- protein
- no-unknown
- sequence-count
- min-length
- max-length

positional arguments:
  filename              A filename to parse and correct.

options:
  -h, --help            show this help message and exit
  --protein             Validate as IUPAC protein sequence
  --dna                 Validate as IUPAC DNA sequence
  --no-unknown          Prohibit unknown IUPAC characters (X/N) - requires --dna or --protein
  --sequence-count SEQUENCE_COUNT
                        [int] Maximum number of sequences that are permitted
  --min-length MIN_LENGTH
                        [int] Minimum length of sequence permitted (per-sequence)
  --max-length MAX_LENGTH
                        [int] Maximum length of sequence permitted (per-sequence)
```


## Metadata
- **Skill**: generated
