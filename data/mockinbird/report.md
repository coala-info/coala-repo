# mockinbird CWL Generation Report

## mockinbird_preprocess

### Tool Description
start preprocessing pipeline using a config script

### Metadata
- **Docker Image**: quay.io/biocontainers/mockinbird:1.0.0a1--py38he5da3d1_7
- **Homepage**: https://github.com/soedinglab/mockinbird
- **Package**: https://anaconda.org/channels/bioconda/packages/mockinbird/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mockinbird/overview
- **Total Downloads**: 12.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/soedinglab/mockinbird
- **Stars**: N/A
### Original Help Text
```text
usage: mockinbird preprocess [-h] [--log_level {debug,info,warn,error}]
                             [--version]
                             parclip_fastq output_dir prefix config_file

start preprocessing pipeline using a config script

positional arguments:
  parclip_fastq         path to PAR-CLIP fastq reads
  output_dir            output directory - will be created if it does not
                        exist
  prefix                filename prefix for newly created files
  config_file           path to preprocessing config file

optional arguments:
  -h, --help            show this help message and exit
  --log_level {debug,info,warn,error}
                        verbosity level of the logger (default: info)
  --version, -v         show program's version number and exit
```


## mockinbird_postprocess

### Tool Description
start postprocessing pipeline using a config script

### Metadata
- **Docker Image**: quay.io/biocontainers/mockinbird:1.0.0a1--py38he5da3d1_7
- **Homepage**: https://github.com/soedinglab/mockinbird
- **Package**: https://anaconda.org/channels/bioconda/packages/mockinbird/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mockinbird postprocess [-h] [--prefix PREFIX]
                              [--log_level {debug,info,warn,error}]
                              [--version]
                              preprocess_dir output_dir config_file

start postprocessing pipeline using a config script

positional arguments:
  preprocess_dir        folder to files created by the preprocessing
  output_dir            output directory - will be created if it does not
                        exist
  config_file           path to the postprocessing config file

optional arguments:
  -h, --help            show this help message and exit
  --prefix PREFIX       preprocessing filename prefix - only required if there
                        are multiple table files in the specified preprocess
                        directory (default: None)
  --log_level {debug,info,warn,error}
                        verbosity level of the logger (default: info)
  --version, -v         show program's version number and exit
```


## mockinbird_flip_mate

### Tool Description
flip the strand of the second read. Used for generating a normalizing pileup from a paired-end sequenced library

### Metadata
- **Docker Image**: quay.io/biocontainers/mockinbird:1.0.0a1--py38he5da3d1_7
- **Homepage**: https://github.com/soedinglab/mockinbird
- **Package**: https://anaconda.org/channels/bioconda/packages/mockinbird/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mockinbird flip_mate [-h] input_bam output_bam

flip the strand of the second read. Used for generating a normalizing pileup
from a paired-end sequenced library

positional arguments:
  input_bam   path to paired-end bam file
  output_bam  path to output bam file

optional arguments:
  -h, --help  show this help message and exit
```


## Metadata
- **Skill**: not generated
