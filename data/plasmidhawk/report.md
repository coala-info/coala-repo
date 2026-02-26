# plasmidhawk CWL Generation Report

## plasmidhawk_annotate

### Tool Description
Annotates plasmid metadata based on fragment metadata and plasmid ordering information.

### Metadata
- **Docker Image**: quay.io/biocontainers/plasmidhawk:1.0.3--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/plasmidhawk
- **Package**: https://anaconda.org/channels/bioconda/packages/plasmidhawk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plasmidhawk/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: plasmidhawk annotate [-h] [-o OUTPUT] frag-metadata plasmid-metadata

positional arguments:
  frag-metadata         The TSV metadata generated from plaster
  plasmid-metadata      File containing information on which labs ordered
                        which plasmids

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        output file prefix
```


## plasmidhawk_predict

### Tool Description
Choose prediction mode (max, supermax, correct), default max. supermax is max mode, but output top 50 labs

### Metadata
- **Docker Image**: quay.io/biocontainers/plasmidhawk:1.0.3--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/plasmidhawk
- **Package**: https://anaconda.org/channels/bioconda/packages/plasmidhawk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plasmidhawk predict [-h] [-o OUTPUT] [-s] [-w WORK_DIR] [-t THREAD]
                           [-d IDENTITY] [-v]
                           [{max,supermax,correct}] input-pangenome-fasta
                           input-pangenome-annotated-meta input-files
                           [input-files ...]

positional arguments:
  {max,supermax,correct}
                        Choose prediction mode (max, supermax, correct),
                        default max. supermax is max mode, but output top 50
                        labs
  input-pangenome-fasta
                        input pan-genome fasta file
  input-pangenome-annotated-meta
                        Lab ownership metadata file
  input-files           a list of input fasta file names. If there is one file
                        and it ends with a non-fasta suffix it is assumed that
                        this file contains a list of input files separated by
                        a newline

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        output lab-of-origin prediction
  -s, --skip            Use nucmer results already present in work-dir instead
                        of rerunning
  -w WORK_DIR, --work-dir WORK_DIR
                        output lab-of-origin prediction
  -t THREAD, --thread THREAD
                        Number of threads, default 20
  -d IDENTITY, --identity IDENTITY
                        Minimum alignment identity [0,100], default 0
  -v, --verbose         Print verbose output
```


## Metadata
- **Skill**: generated

## plasmidhawk

### Tool Description
PlasmidHawk: A tool for plasmid analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/plasmidhawk:1.0.3--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/plasmidhawk
- **Package**: https://anaconda.org/channels/bioconda/packages/plasmidhawk/overview
- **Validation**: PASS
### Original Help Text
```text
usage: plasmidhawk [-h] {annotate,predict} ...

positional arguments:
  {annotate,predict}  sub-command help
    annotate          Create annotation file which maps labs to fragments
    predict           Predict lab of origin of input sequences

optional arguments:
  -h, --help          show this help message and exit
```

