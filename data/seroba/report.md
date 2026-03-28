# seroba CWL Generation Report

## seroba_getPneumocat

### Tool Description
Downlaods PneumoCat and build an tsv formated meta data file out of it

### Metadata
- **Docker Image**: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/sanger-pathogens/seroba
- **Package**: https://anaconda.org/channels/bioconda/packages/seroba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seroba/overview
- **Total Downloads**: 16.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/seroba
- **Stars**: N/A
### Original Help Text
```text
usage: seroba getPneumocat  <database dir>

Downlaods PneumoCat and build an tsv formated meta data file out of it

positional arguments:
  database_dir  output directory for PneumoCat Database

optional arguments:
  -h, --help    show this help message and exit
```


## seroba_downloads

### Tool Description
Seroba command-line tool

### Metadata
- **Docker Image**: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/sanger-pathogens/seroba
- **Package**: https://anaconda.org/channels/bioconda/packages/seroba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seroba <command> <options>
seroba: error: argument : invalid choice: 'downloads' (choose from 'getPneumocat', 'createDBs', 'runSerotyping', 'summary', 'version')
```


## seroba_createDBs

### Tool Description
Creates a Database for kmc and ariba

### Metadata
- **Docker Image**: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/sanger-pathogens/seroba
- **Package**: https://anaconda.org/channels/bioconda/packages/seroba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seroba createDBs  <database dir> <kmer size>

Creates a Database for kmc and ariba

positional arguments:
  out_dir     output directory for kmc and ariba Database
  kmer_size   kmer_size zou want to use for kmc , recommanded = 71

optional arguments:
  -h, --help  show this help message and exit
```


## seroba_runSerotyping

### Tool Description
identify serotype of your input data

### Metadata
- **Docker Image**: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/sanger-pathogens/seroba
- **Package**: https://anaconda.org/channels/bioconda/packages/seroba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seroba runSerotyping [options]  <read1> <read2> <prefix>

identify serotype of your input data

positional arguments:
  read1                 forward read file
  read2                 backward read file
  prefix                unique prefix

optional arguments:
  -h, --help            show this help message and exit

Other options:
  --databases DATABASES
                        path to database directory, default
                        /usr/local/share/seroba-1.0.2/database
  --noclean             Do not clean up intermediate files (assemblies, ariba
                        report)
  --coverage COVERAGE   threshold for k-mer coverage of the reference sequence
                        , default = 20
```


## seroba_indetify

### Tool Description
Seroba command-line tool

### Metadata
- **Docker Image**: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/sanger-pathogens/seroba
- **Package**: https://anaconda.org/channels/bioconda/packages/seroba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seroba <command> <options>
seroba: error: argument : invalid choice: 'indetify' (choose from 'getPneumocat', 'createDBs', 'runSerotyping', 'summary', 'version')
```


## seroba_summary

### Tool Description
writes all predictions in one tsv file

### Metadata
- **Docker Image**: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/sanger-pathogens/seroba
- **Package**: https://anaconda.org/channels/bioconda/packages/seroba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seroba summary  <output folder>

writes all predictions in one tsv file

positional arguments:
  out_dir     path to output folder with results from runSerotyping

optional arguments:
  -h, --help  show this help message and exit
```


## seroba_results

### Tool Description
Serotyping analysis tool

### Metadata
- **Docker Image**: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/sanger-pathogens/seroba
- **Package**: https://anaconda.org/channels/bioconda/packages/seroba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seroba <command> <options>
seroba: error: argument : invalid choice: 'results' (choose from 'getPneumocat', 'createDBs', 'runSerotyping', 'summary', 'version')
```


## Metadata
- **Skill**: generated
