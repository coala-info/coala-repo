# moni CWL Generation Report

## moni_valid

### Tool Description
moni: error: argument {build,ms,mems,extend}: invalid choice: 'valid' (choose from 'build', 'ms', 'mems', 'extend')

### Metadata
- **Docker Image**: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
- **Homepage**: https://github.com/maxrossi91/moni
- **Package**: https://anaconda.org/channels/bioconda/packages/moni/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/moni/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/maxrossi91/moni
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/moni:7: SyntaxWarning: invalid escape sequence '\/'
  Description = """
usage: moni [-h] [--version] {build,ms,mems,extend} ...
moni: error: argument {build,ms,mems,extend}: invalid choice: 'valid' (choose from 'build', 'ms', 'mems', 'extend')
```


## moni_additional

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
- **Homepage**: https://github.com/maxrossi91/moni
- **Package**: https://anaconda.org/channels/bioconda/packages/moni/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/bin/moni:7: SyntaxWarning: invalid escape sequence '\/'
  Description = """
usage: moni [-h] [--version] {build,ms,mems,extend} ...
moni: error: argument {build,ms,mems,extend}: invalid choice: 'additional' (choose from 'build', 'ms', 'mems', 'extend')
```


## moni_build

### Tool Description
Builds a reference index for the moni tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
- **Homepage**: https://github.com/maxrossi91/moni
- **Package**: https://anaconda.org/channels/bioconda/packages/moni/overview
- **Validation**: PASS

### Original Help Text
```text
usage: moni build [-h] -r REFERENCE [-o OUTPUT] [-w WSIZE] [-p MOD]
                  [-t THREADS] [-k] [-v] [-f] [-g GRAMMAR] [--parsing]
                  [--compress]

options:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        reference file name (default: None)
  -o OUTPUT, --output OUTPUT
                        output directory path (default: .)
  -w WSIZE, --wsize WSIZE
                        sliding window size (default: 10)
  -p MOD, --mod MOD     hash modulus (default: 100)
  -t THREADS, --threads THREADS
                        number of helper threads (default: 0)
  -k                    keep temporary files (default: False)
  -v                    verbose (default: False)
  -f                    read fasta (default: False)
  -g GRAMMAR, --grammar GRAMMAR
                        select the grammar [plain, shaped] (default: plain)
  --parsing             stop after the parsing phase (debug only) (default:
                        False)
  --compress            compress output of the parsing phase (debug only)
                        (default: False)
```


## moni_ms

### Tool Description
Moni tool for sequence matching

### Metadata
- **Docker Image**: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
- **Homepage**: https://github.com/maxrossi91/moni
- **Package**: https://anaconda.org/channels/bioconda/packages/moni/overview
- **Validation**: PASS

### Original Help Text
```text
usage: moni ms [-h] -i INDEX -p PATTERN [-o OUTPUT] [-t THREADS] [-g GRAMMAR]

options:
  -h, --help            show this help message and exit
  -i INDEX, --index INDEX
                        reference index folder (default: None)
  -p PATTERN, --pattern PATTERN
                        the input query (default: None)
  -o OUTPUT, --output OUTPUT
                        output file prefix (default: .)
  -t THREADS, --threads THREADS
                        number of helper threads (default: 1)
  -g GRAMMAR, --grammar GRAMMAR
                        select the grammar [plain, shaped] (default: plain)
```


## moni_mems

### Tool Description
Find maximal exact matches (MEMs) between a query and a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
- **Homepage**: https://github.com/maxrossi91/moni
- **Package**: https://anaconda.org/channels/bioconda/packages/moni/overview
- **Validation**: PASS

### Original Help Text
```text
usage: moni mems [-h] -i INDEX -p PATTERN [-o OUTPUT] [-e] [-s]
                 [-l MIN_LENGTH] [-t THREADS] [-g GRAMMAR]

options:
  -h, --help            show this help message and exit
  -i INDEX, --index INDEX
                        reference index folder (default: None)
  -p PATTERN, --pattern PATTERN
                        the input query (default: None)
  -o OUTPUT, --output OUTPUT
                        output file prefix (default: .)
  -e, --extended-output
                        output MEM occurrence in the reference (default:
                        False)
  -s, --sam-output      output MEM in a SAM formatted file. (default: False)
  -l MIN_LENGTH, --minimum-MEM-length MIN_LENGTH
                        minimum MEM length (default: 35)
  -t THREADS, --threads THREADS
                        number of helper threads (default: 1)
  -g GRAMMAR, --grammar GRAMMAR
                        select the grammar [plain, shaped] (default: plain)
```


## moni_extend

### Tool Description
Extend query patterns against a reference index.

### Metadata
- **Docker Image**: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
- **Homepage**: https://github.com/maxrossi91/moni
- **Package**: https://anaconda.org/channels/bioconda/packages/moni/overview
- **Validation**: PASS

### Original Help Text
```text
usage: moni extend [-h] -i INDEX -p PATTERN [-o OUTPUT] [-t THREADS]
                   [-b BATCH] [-g GRAMMAR] [-L EXTL] [-A SMATCH]
                   [-B SMISMATCH] [-O GAPO] [-E GAPE]

options:
  -h, --help            show this help message and exit
  -i INDEX, --index INDEX
                        reference index folder (default: None)
  -p PATTERN, --pattern PATTERN
                        the input query (default: None)
  -o OUTPUT, --output OUTPUT
                        output directory path (default: .)
  -t THREADS, --threads THREADS
                        number of helper threads (default: 1)
  -b BATCH, --batch BATCH
                        number of reads per thread batch (default: 100)
  -g GRAMMAR, --grammar GRAMMAR
                        select the grammar [plain, shaped] (default: plain)
  -L EXTL, --extl EXTL  length of reference substring for extension (default:
                        100)
  -A SMATCH, --smatch SMATCH
                        match score value (default: 2)
  -B SMISMATCH, --smismatch SMISMATCH
                        mismatch penalty value (default: 4)
  -O GAPO, --gapo GAPO  coma separated gap open penalty values (default: 4,13)
  -E GAPE, --gape GAPE  coma separated gap extension penalty values (default:
                        2,1)
```


## Metadata
- **Skill**: generated
