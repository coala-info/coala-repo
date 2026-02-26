# predex CWL Generation Report

## predex_design

### Tool Description
Design experiment based on input count matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/predex:0.9.3--pyh5e36f6f_0
- **Homepage**: https://github.com/tomkuipers1402/predex
- **Package**: https://anaconda.org/channels/bioconda/packages/predex/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/predex/overview
- **Total Downloads**: 8.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tomkuipers1402/predex
- **Stars**: N/A
### Original Help Text
```text
usage: predex design [-h] -i INPUT [-o OUTPUT]

optional arguments:
  -h, --help                  show this help message and exit

required arguments:
  -i INPUT, --input INPUT     Input files (count matrix, e.g., HTSeq)
  -o OUTPUT, --output OUTPUT  Output directory (default = current)
```


## predex_annotation

### Tool Description
Perform annotation using predex.

### Metadata
- **Docker Image**: quay.io/biocontainers/predex:0.9.3--pyh5e36f6f_0
- **Homepage**: https://github.com/tomkuipers1402/predex
- **Package**: https://anaconda.org/channels/bioconda/packages/predex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: predex annotation [-h] [-t THREADS] -f FASTA -g GTF [-o OUTPUT]

optional arguments:
  -h, --help                     show this help message and exit
  -t THREADS, --threads THREADS  Number of threads (default = 1)

required arguments:
  -f FASTA, --fasta FASTA        Fasta file input
  -g GTF, --gtf GTF              GTF file input
  -o OUTPUT, --output OUTPUT     Output directory (default = current)
```


## predex_comparison

### Tool Description
Perform comparisons between samples based on a design matrix and a specified column.

### Metadata
- **Docker Image**: quay.io/biocontainers/predex:0.9.3--pyh5e36f6f_0
- **Homepage**: https://github.com/tomkuipers1402/predex
- **Package**: https://anaconda.org/channels/bioconda/packages/predex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: predex comparison [-h] -d DESIGN -c COLUMN [-o OUTPUT]

optional arguments:
  -h, --help                  show this help message and exit

required arguments:
  -d DESIGN, --design DESIGN  Design matrix with sample data
  -c COLUMN, --column COLUMN  Column name to make comparisons with
  -o OUTPUT, --output OUTPUT  Output directory (default = current)
```


## predex_ipa

### Tool Description
Input dir with IPA downloaded table

### Metadata
- **Docker Image**: quay.io/biocontainers/predex:0.9.3--pyh5e36f6f_0
- **Homepage**: https://github.com/tomkuipers1402/predex
- **Package**: https://anaconda.org/channels/bioconda/packages/predex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: predex ipa [-h] -i INPUT [-o OUTPUT] [-e EXTENSION]

optional arguments:
  -h, --help                           show this help message and exit

required arguments:
  -i INPUT, --input INPUT              Input dir with IPA downloaded table
  -o OUTPUT, --output OUTPUT           Output dir to write processed data to
                                       (default = current)
  -e EXTENSION, --extension EXTENSION  Extension of IPA files (default = .txt)
```


## Metadata
- **Skill**: generated
