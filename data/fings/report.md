# fings CWL Generation Report

## fings

### Tool Description
Filters for Next Generation Sequencing

### Metadata
- **Docker Image**: quay.io/biocontainers/fings:1.7.1--pyhb7b1952_0
- **Homepage**: https://github.com/cpwardell/FiNGS
- **Package**: https://anaconda.org/channels/bioconda/packages/fings/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fings/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cpwardell/FiNGS
- **Stars**: N/A
### Original Help Text
```text
usage: fings [-h] -v V -t T -n N [-r R] [-d D] [-p P] [-c C] [-m M] [-j J]
             [--ICGC] [--logging LOGGING] [--overwrite] [--PASSonlyin]
             [--PASSonlyout]

FiNGS: Filters for Next Generation Sequencing

optional arguments:
  -h, --help         show this help message and exit
  -v V               absolute path to VCF file (default: None)
  -t T               absolute path to tumor BAM (default: None)
  -n N               absolute path to normal BAM (default: None)
  -r R               absolute path to faidx indexed reference genome; required
                     if using 'repeats' filter (default: None)
  -d D               absolute path to output directory (default: results)
  -p P               absolute path to filtering parameters (default is
                     filter_parameters.txt (default: filter_parameters.txt)
  -c C               number of records to process per chunk (default: 100)
  -m M               maximum read depth to process (default: 1000)
  -j J               number of processors to use (default is -1, use all
                     available resources) (default: -1)
  --ICGC             Use filters identical to those recommended by the ICGC
                     (Alioto et al, 2015). Overrides '-p' flag (default:
                     False)
  --logging LOGGING  Set logging level (default is INFO, can be DEBUG for more
                     detail or NOTSET for silent) (default: INFO)
  --overwrite        Overwrite previous results if they exist (default: False)
  --PASSonlyin       Only use variants with that the original caller PASSed?
                     (default: False)
  --PASSonlyout      Only write PASS variants to the output VCF (default:
                     False)
```

