# panchip CWL Generation Report

## panchip_init

### Tool Description
Initialization of the PanChIP library

### Metadata
- **Docker Image**: quay.io/biocontainers/panchip:3.0.14--py312h7e72e81_0
- **Homepage**: https://github.com/hanjunlee21/PanChIP
- **Package**: https://anaconda.org/channels/bioconda/packages/panchip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/panchip/overview
- **Total Downloads**: 33
- **Last updated**: 2025-12-16
- **GitHub**: https://github.com/hanjunlee21/PanChIP
- **Stars**: N/A
### Original Help Text
```text
usage: panchip init [-h] library_directory

Initialization of the PanChIP library

positional arguments:
  library_directory  Directory wherein PanChIP library will be stored. > 13.6
                     GB of storage required.

options:
  -h, --help         show this help message and exit
```


## panchip_analysis

### Tool Description
Analysis of a list peak sets

### Metadata
- **Docker Image**: quay.io/biocontainers/panchip:3.0.14--py312h7e72e81_0
- **Homepage**: https://github.com/hanjunlee21/PanChIP
- **Package**: https://anaconda.org/channels/bioconda/packages/panchip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panchip analysis [-h] [-t THREADS] [-r REPEATS]
                        library_directory input_directory output_directory

Analysis of a list peak sets

positional arguments:
  library_directory  Directory wherein PanChIP library was stored.
  input_directory    Input directory wherein peak sets in the format of .bed
                     files are located.
  output_directory   Output directory wherein output files will be stored.

options:
  -h, --help         show this help message and exit
  -t THREADS         Number of threads to use. (default: 1)
  -r REPEATS         Number of repeats to perform. (default: 1)
```


## panchip_filter

### Tool Description
Filtering library for quality control

### Metadata
- **Docker Image**: quay.io/biocontainers/panchip:3.0.14--py312h7e72e81_0
- **Homepage**: https://github.com/hanjunlee21/PanChIP
- **Package**: https://anaconda.org/channels/bioconda/packages/panchip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: panchip filter [-h] [-t THREADS]
                      library_directory input_file output_directory

Filtering library for quality control

positional arguments:
  library_directory  Directory wherein PanChIP library was stored.
  input_file         Path to the input .bed file.
  output_directory   Output directory wherein output files will be stored.

options:
  -h, --help         show this help message and exit
  -t THREADS         Number of threads to use. (default: 1)
```


## Metadata
- **Skill**: generated
