# mavis CWL Generation Report

## mavis_annotate

### Tool Description
Annotates variants with MAVIS.

### Metadata
- **Docker Image**: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/bcgsc/mavis.git
- **Package**: https://anaconda.org/channels/bioconda/packages/mavis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mavis/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-06-24
- **GitHub**: https://github.com/bcgsc/mavis
- **Stars**: N/A
### Original Help Text
```text
usage: mavis annotate [-h] [-v] [--log LOG] [--log_level {INFO,DEBUG}]
                      --config FILEPATH -o OUTPUT -n FILEPATH [FILEPATH ...]
                      --library LIBRARY

required arguments:
  --library LIBRARY, -l LIBRARY
                        The library to run the current step on
  -n FILEPATH [FILEPATH ...], --inputs FILEPATH [FILEPATH ...]
                        path to the input files
  -o OUTPUT, --output OUTPUT
                        path to the output directory

optional arguments:
  --config FILEPATH, -c FILEPATH
                        path to the JSON config file
  --log LOG             redirect stdout to a log file (default: None)
  --log_level {INFO,DEBUG}
                        level of logging to output (default: INFO)
  -h, --help            show this help message and exit
  -v, --version         Outputs the version number
```


## mavis_validate

### Tool Description
Validate MAVIS inputs and outputs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/bcgsc/mavis.git
- **Package**: https://anaconda.org/channels/bioconda/packages/mavis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mavis validate [-h] [-v] [--log LOG] [--log_level {INFO,DEBUG}]
                      --config FILEPATH -o OUTPUT -n FILEPATH [FILEPATH ...]
                      --library LIBRARY

required arguments:
  --library LIBRARY, -l LIBRARY
                        The library to run the current step on
  -n FILEPATH [FILEPATH ...], --inputs FILEPATH [FILEPATH ...]
                        path to the input files
  -o OUTPUT, --output OUTPUT
                        path to the output directory

optional arguments:
  --config FILEPATH, -c FILEPATH
                        path to the JSON config file
  --log LOG             redirect stdout to a log file (default: None)
  --log_level {INFO,DEBUG}
                        level of logging to output (default: INFO)
  -h, --help            show this help message and exit
  -v, --version         Outputs the version number
```


## mavis_cluster

### Tool Description
Cluster MAVIS results

### Metadata
- **Docker Image**: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/bcgsc/mavis.git
- **Package**: https://anaconda.org/channels/bioconda/packages/mavis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mavis cluster [-h] [-v] [--log LOG] [--log_level {INFO,DEBUG}] --config
                     FILEPATH -o OUTPUT -n FILEPATH [FILEPATH ...] --library
                     LIBRARY

required arguments:
  --library LIBRARY, -l LIBRARY
                        The library to run the current step on
  -n FILEPATH [FILEPATH ...], --inputs FILEPATH [FILEPATH ...]
                        path to the input files
  -o OUTPUT, --output OUTPUT
                        path to the output directory

optional arguments:
  --config FILEPATH, -c FILEPATH
                        path to the JSON config file
  --log LOG             redirect stdout to a log file (default: None)
  --log_level {INFO,DEBUG}
                        level of logging to output (default: INFO)
  -h, --help            show this help message and exit
  -v, --version         Outputs the version number
```


## mavis_pairing

### Tool Description
Mavis pairing tool

### Metadata
- **Docker Image**: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/bcgsc/mavis.git
- **Package**: https://anaconda.org/channels/bioconda/packages/mavis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mavis pairing [-h] [-v] [--log LOG] [--log_level {INFO,DEBUG}] --config
                     FILEPATH -o OUTPUT -n FILEPATH [FILEPATH ...]

required arguments:
  -n FILEPATH [FILEPATH ...], --inputs FILEPATH [FILEPATH ...]
                        path to the input files
  -o OUTPUT, --output OUTPUT
                        path to the output directory

optional arguments:
  --config FILEPATH, -c FILEPATH
                        path to the JSON config file
  --log LOG             redirect stdout to a log file (default: None)
  --log_level {INFO,DEBUG}
                        level of logging to output (default: INFO)
  -h, --help            show this help message and exit
  -v, --version         Outputs the version number
```


## mavis_summary

### Tool Description
Summarize MAVIS results.

### Metadata
- **Docker Image**: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/bcgsc/mavis.git
- **Package**: https://anaconda.org/channels/bioconda/packages/mavis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mavis summary [-h] [-v] [--log LOG] [--log_level {INFO,DEBUG}] --config
                     FILEPATH -o OUTPUT -n FILEPATH [FILEPATH ...]

required arguments:
  -n FILEPATH [FILEPATH ...], --inputs FILEPATH [FILEPATH ...]
                        path to the input files
  -o OUTPUT, --output OUTPUT
                        path to the output directory

optional arguments:
  --config FILEPATH, -c FILEPATH
                        path to the JSON config file
  --log LOG             redirect stdout to a log file (default: None)
  --log_level {INFO,DEBUG}
                        level of logging to output (default: INFO)
  -h, --help            show this help message and exit
  -v, --version         Outputs the version number
```


## mavis_convert

### Tool Description
Convert structural variant calls from various callers into a common format.

### Metadata
- **Docker Image**: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/bcgsc/mavis.git
- **Package**: https://anaconda.org/channels/bioconda/packages/mavis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mavis convert [-h] [-v] [--log LOG] [--log_level {INFO,DEBUG}]
                     --file_type
                     {arriba,breakdancer,breakseq,chimerascan,cnvnator,defuse,delly,manta,mavis,pindel,starfusion,straglr,strelka,transabyss,vcf}
                     [--strand_specific {True,False}]
                     [--assume_no_untemplated {True,False}] --outputfile
                     FILEPATH -n FILEPATH [FILEPATH ...]

required arguments:
  --file_type {arriba,breakdancer,breakseq,chimerascan,cnvnator,defuse,delly,manta,mavis,pindel,starfusion,straglr,strelka,transabyss,vcf}
                        Indicates the input file type to be parsed
  --outputfile FILEPATH, -o FILEPATH
                        path to the outputfile
  -n FILEPATH [FILEPATH ...], --inputs FILEPATH [FILEPATH ...]
                        path to the input files

optional arguments:
  --assume_no_untemplated {True,False}
  --log LOG             redirect stdout to a log file (default: None)
  --log_level {INFO,DEBUG}
                        level of logging to output (default: INFO)
  --strand_specific {True,False}
  -h, --help            show this help message and exit
  -v, --version         Outputs the version number
```


## mavis_overlay

### Tool Description
Draws a gene and its surrounding genomic context, including read depth plots and markers.

### Metadata
- **Docker Image**: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/bcgsc/mavis.git
- **Package**: https://anaconda.org/channels/bioconda/packages/mavis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mavis overlay [-h] [-v] [--log LOG] [--log_level {INFO,DEBUG}] --config
                     FILEPATH -o OUTPUT [--buffer_length INT]
                     [--read_depth_plot <axis name STR> <bam FILEPATH> [density FLOAT]
                     [ymax INT] [stranded BOOL]]
                     [--marker <label STR> <start INT> [end INT]]
                     gene_name

required arguments:
  gene_name             Gene ID or gene alias to be drawn
  -o OUTPUT, --output OUTPUT
                        path to the output directory

optional arguments:
  --buffer_length INT   minimum genomic length to plot on either side of the
                        target gene (default: 0)
  --config FILEPATH, -c FILEPATH
                        path to the JSON config file
  --log LOG             redirect stdout to a log file (default: None)
  --log_level {INFO,DEBUG}
                        level of logging to output (default: INFO)
  --marker <label STR> <start INT> [end INT]
                        Marker on the diagram given by genomic position, May
                        be a single position or a range. The label should be a
                        short descriptor to avoid overlapping labels on the
                        diagram (default: [])
  --read_depth_plot <axis name STR> <bam FILEPATH> [density FLOAT] [ymax INT] [stranded BOOL]
                        bam file to use as data for plotting read_depth
                        (default: [])
  -h, --help            show this help message and exit
  -v, --version         Outputs the version number
```


## mavis_setup

### Tool Description
Setup Mavis

### Metadata
- **Docker Image**: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/bcgsc/mavis.git
- **Package**: https://anaconda.org/channels/bioconda/packages/mavis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mavis setup [-h] [-v] [--log LOG] [--log_level {INFO,DEBUG}] --config
                   FILEPATH --outputfile FILEPATH

required arguments:
  --outputfile FILEPATH, -o FILEPATH
                        path to the outputfile

optional arguments:
  --config FILEPATH, -c FILEPATH
                        path to the JSON config file
  --log LOG             redirect stdout to a log file (default: None)
  --log_level {INFO,DEBUG}
                        level of logging to output (default: INFO)
  -h, --help            show this help message and exit
  -v, --version         Outputs the version number
```

