# bakdrive CWL Generation Report

## bakdrive_interaction

### Tool Description
Performs interaction analysis based on taxonomic classification and metabolic models.

### Metadata
- **Docker Image**: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/bakdrive
- **Package**: https://anaconda.org/channels/bioconda/packages/bakdrive/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bakdrive/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: bakdrive interaction [-h] [-m MEDIUM] [-d MODEL] [-p PERCENTAGE]
                            [-f FLAG] [-o OUTPUT]
                            input_file

positional arguments:
  input_file            Input file of a list of taxonomic classification file
                        addresses

optional arguments:
  -h, --help            show this help message and exit
  -m MEDIUM, --medium MEDIUM
                        Medium CSV file, default medium.csv
  -d MODEL, --model MODEL
                        Metabolic model database, default dbs
  -p PERCENTAGE, --percentage PERCENTAGE
                        Percentage of species removed, default 0.1
  -f FLAG, --flag FLAG  Calculate growth rate, default True
  -o OUTPUT, --output OUTPUT
                        output folder, default output_interaction
```


## bakdrive_driver

### Tool Description
Input folder of bacteria interaction networks

### Metadata
- **Docker Image**: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/bakdrive
- **Package**: https://anaconda.org/channels/bioconda/packages/bakdrive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bakdrive driver [-h] [-s STRENGTH] [-p PREFIX] [-o OUTPUT] input_folder

positional arguments:
  input_folder          Input folder of bacteria interaction networks

optional arguments:
  -h, --help            show this help message and exit
  -s STRENGTH, --strength STRENGTH
                        Threshold of interaction strength, default 0.2
  -p PREFIX, --prefix PREFIX
                        Output file prefix, default driver_nodes
  -o OUTPUT, --output OUTPUT
                        Output file folder, default output_driver
```


## bakdrive_fmt_donor

### Tool Description
Input disease and donor sample file addresses

### Metadata
- **Docker Image**: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/bakdrive
- **Package**: https://anaconda.org/channels/bioconda/packages/bakdrive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bakdrive fmt_donor [-h] [-m MEDIUM] [-d MODEL] [-p PERCENTAGE]
                          [-s STRENGTH] [-o OUTPUT]
                          input_file

positional arguments:
  input_file            Input disease and donor sample file addresses

optional arguments:
  -h, --help            show this help message and exit
  -m MEDIUM, --medium MEDIUM
                        Medium CSV file, default medium.csv
  -d MODEL, --model MODEL
                        Metabolic model database, default dbs
  -p PERCENTAGE, --percentage PERCENTAGE
                        Percentage of species removed, default 0.1
  -s STRENGTH, --strength STRENGTH
                        Threshold of interaction strength, default 0.2
  -o OUTPUT, --output OUTPUT
                        Output file folder, default fmt_output
```


## bakdrive_fmt_driver

### Tool Description
Format driver species and their interactions for metabolic modeling.

### Metadata
- **Docker Image**: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/bakdrive
- **Package**: https://anaconda.org/channels/bioconda/packages/bakdrive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bakdrive fmt_driver [-h] [-i DRIVER] [-a AMOUNT] [-m MEDIUM] [-d MODEL]
                           [-p PERCENTAGE] [-s STRENGTH] [-o OUTPUT]
                           input_file

positional arguments:
  input_file            Input a list of disease sample file addresses

optional arguments:
  -h, --help            show this help message and exit
  -i DRIVER, --driver DRIVER
                        Input Driver Species
  -a AMOUNT, --amount AMOUNT
                        Input amount of driver species, default 40g
  -m MEDIUM, --medium MEDIUM
                        Medium CSV file, default medium.csv
  -d MODEL, --model MODEL
                        Metabolic model database, default dbs
  -p PERCENTAGE, --percentage PERCENTAGE
                        Percentage of species removed, default 0.1
  -s STRENGTH, --strength STRENGTH
                        Threshold of Interaction Strength, default 0.2
  -o OUTPUT, --output OUTPUT
                        Output file folder, default fmt_driver_output
```


## bakdrive_fmt_only

### Tool Description
Format input files for bakdrive.

### Metadata
- **Docker Image**: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/bakdrive
- **Package**: https://anaconda.org/channels/bioconda/packages/bakdrive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bakdrive fmt_only [-h] [-s STRENGTH] [-p PREFIX] [-o OUTPUT] input-file

positional arguments:
  input-file            Input file prefix

optional arguments:
  -h, --help            show this help message and exit
  -s STRENGTH, --strength STRENGTH
                        Threshold of Interaction Strength, default 0.2
  -p PREFIX, --prefix PREFIX
                        Output file prefix
  -o OUTPUT, --output OUTPUT
                        Output file prefix
```


## Metadata
- **Skill**: not generated

## bakdrive

### Tool Description
Bacterial interaction inference using MICOM, Driver nodes detection using MDSM, After-FMT community construction and simulation following the GLV model, Afte-driver species transplantation (ADT) community consturction and simulation following the GLV model, After-FMT or ADT simulation following the GLV model

### Metadata
- **Docker Image**: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/bakdrive
- **Package**: https://anaconda.org/channels/bioconda/packages/bakdrive/overview
- **Validation**: PASS
### Original Help Text
```text
usage: bakdrive [-h] {interaction,driver,fmt_donor,fmt_driver,fmt_only} ...

positional arguments:
  {interaction,driver,fmt_donor,fmt_driver,fmt_only}
                        sub-command help
    interaction         Bacterial interaction inference using MICOM
    driver              Driver nodes detection using MDSM
    fmt_donor           After-FMT community construction and simulation
                        following the GLV model
    fmt_driver          Afte-driver species transplantation (ADT) community
                        consturction and simulation following the GLV model
    fmt_only            After-FMT or ADT simulation following the GLV model

optional arguments:
  -h, --help            show this help message and exit
```

