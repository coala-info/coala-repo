# sadie-antibody CWL Generation Report

## sadie-antibody_sadie

### Tool Description
SADIE Antibody Analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
- **Homepage**: https://sadie.jordanrwillis.com
- **Package**: https://anaconda.org/channels/bioconda/packages/sadie-antibody/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sadie-antibody/overview
- **Total Downloads**: 105
- **Last updated**: 2025-08-28
- **GitHub**: https://github.com/jwillis0720/sadie
- **Stars**: N/A
### Original Help Text
```text
Usage: sadie [OPTIONS] COMMAND [ARGS]...

Options:
  --version      Show the version and exit.
  -v, --verbose  Vebosity level, ex. -vvvvv for debug level logging
  --help         Show this message and exit.

Commands:
  airr         Run the AIRR annotation pipeline from the command line on...
  make-all     Comprehensive database generation for SADIE AIRR analysis
  reference
  renumbering
```


## sadie-antibody_sadie airr

### Tool Description
Run the AIRR annotation pipeline from the command line on a single file or a directory of abi files.

  if you give a directory of abi files, it will combine all the records into a
  single file and annotate that.

  if you do not provide an output, the default is airr .tsv file

### Metadata
- **Docker Image**: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
- **Homepage**: https://sadie.jordanrwillis.com
- **Package**: https://anaconda.org/channels/bioconda/packages/sadie-antibody/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sadie airr [OPTIONS] INPUT_PATH [OUTPUT_PATH]

  Run the AIRR annotation pipeline from the command line on a single file or a
  directory of abi files.

  if you give a directory of abi files, it will combine all the records into a
  single file and annotate that.

  if you do not provide an output, the default is airr .tsv file

Options:
  -n, --name [se09|rat|human|macaque|dog|rabbit|clk|mouse]
                                  Species to annotate
  --skip-igl                      Skip the igl assignment
  --skip-mutation                 Skip the somewhat time instansive mutational
                                  analysis
  --help                          Show this message and exit.
```


## sadie-antibody_sadie renumbering

### Tool Description
Renumber antibody sequences based on specified schemes and regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
- **Homepage**: https://sadie.jordanrwillis.com
- **Package**: https://anaconda.org/channels/bioconda/packages/sadie-antibody/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sadie renumbering [OPTIONS]

Options:
  -v, --verbose                   Vebosity level, ex. -vvvvv for debug level
                                  logging
  -q, --query PATH                The input file can be compressed or
                                  uncompressed file of fasta
  -i, --seq TEXT                  The input seq
  -s, --scheme [imgt|kabat|chothia]
                                  The numbering scheme to use.  [default:
                                  imgt]
  -r, --region [imgt|kabat|chothia|abm|contact|scdr]
                                  The framework and cdr defition to use
                                  [default: imgt]
  -a, --allowed-species TEXT      A comma seperated list of species to align
                                  against  [default: human,mouse,rat,rabbit,rh
                                  esus,pig,alpaca,dog,cat]
  -c, --allowed-chains TEXT       A comma seperated list of species to align
                                  against  [default: H,K,L,A,B,G,D]
  -o, --out PATH                  The output file, type is inferred from
                                  extensions
  -z, --compress [gz|bz2]         opitonal file compression on output
  -f, --file-format [json|csv|feather]
                                  output file type format
  --help                          Show this message and exit.
```

