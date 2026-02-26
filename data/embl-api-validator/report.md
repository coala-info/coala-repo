# embl-api-validator CWL Generation Report

## embl-api-validator

### Tool Description
Validates biological sequence data files.

### Metadata
- **Docker Image**: quay.io/biocontainers/embl-api-validator:1.1.180--1
- **Homepage**: http://www.ebi.ac.uk/ena/software/flat-file-validator
- **Package**: https://anaconda.org/channels/bioconda/packages/embl-api-validator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/embl-api-validator/overview
- **Total Downloads**: 14.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: ena_validator <files> [options]
 
  Options:    -assembly        genome assembly entries (default: false)
    -de              Additional Fix :Adds/Fixes DE line(optional) (default: false)
    -f               File format(optional) Values:'embl','genbank','gff3','assembly' (default: embl)
    -filter          -filter <prefix> Store entries in <prefix>_good.txt and <prefix>_bad.txt files in the working directory. Entries with errors are stored in the bad file and entries without errors are stored in the good file. (optional)(default :false)
    -fix             Fixes entries in input files. Stores input files in 'original_files' folder. (optional) (default: false)
    -fix_diagnose    Creates 'diagnose' folder in the current directory with original entries in <filename>_origin file and the fixed entries in <filename>_fixed file. Only fixed entries will be stored in these files.(optional)  (default: false)
    -help            Displays available options (default: false)
    -l               Log level(optional) Values : 0(Quiet), 1(Summary), 2(Verbose) (default: 1)
    -lowmemory       Runs in low memory usage mode. Writes error logs but does not show message summary(optional) (default: false)
    -min_gap_length  minimum gap length to generate assembly_gap/gap features, use assembly flag to add assembly_gap features (default: 0)
    -prefix          Adds prefix to report files
    -r               Remote, is this being run outside the EBI(optional) (default: false)
    -skip            -skip <errorcode1>,<errorcode2>,... Ignore specified errors.(optional)(default:false) 
    -version         Displays implementation version of Jar (default: false)
    -wrap            Turns on line wrapping in flat file writing (optional)  (default: false)

Return Codes: {0=SUCCESS, 1=INTERNAL ERROR, 2=INVALID INPUT, 3=VALIDATION ERROR}
```


## Metadata
- **Skill**: generated

## embl-api-validator

### Tool Description
Validates biological sequence data files.

### Metadata
- **Docker Image**: quay.io/biocontainers/embl-api-validator:1.1.180--1
- **Homepage**: http://www.ebi.ac.uk/ena/software/flat-file-validator
- **Package**: https://anaconda.org/channels/bioconda/packages/embl-api-validator/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: ena_validator <files> [options]
 
  Options:    -assembly        genome assembly entries (default: false)
    -de              Additional Fix :Adds/Fixes DE line(optional) (default: false)
    -f               File format(optional) Values:'embl','genbank','gff3','assembly' (default: embl)
    -filter          -filter <prefix> Store entries in <prefix>_good.txt and <prefix>_bad.txt files in the working directory. Entries with errors are stored in the bad file and entries without errors are stored in the good file. (optional)(default :false)
    -fix             Fixes entries in input files. Stores input files in 'original_files' folder. (optional) (default: false)
    -fix_diagnose    Creates 'diagnose' folder in the current directory with original entries in <filename>_origin file and the fixed entries in <filename>_fixed file. Only fixed entries will be stored in these files.(optional)  (default: false)
    -help            Displays available options (default: false)
    -l               Log level(optional) Values : 0(Quiet), 1(Summary), 2(Verbose) (default: 1)
    -lowmemory       Runs in low memory usage mode. Writes error logs but does not show message summary(optional) (default: false)
    -min_gap_length  minimum gap length to generate assembly_gap/gap features, use assembly flag to add assembly_gap features (default: 0)
    -prefix          Adds prefix to report files
    -r               Remote, is this being run outside the EBI(optional) (default: false)
    -skip            -skip <errorcode1>,<errorcode2>,... Ignore specified errors.(optional)(default:false) 
    -version         Displays implementation version of Jar (default: false)
    -wrap            Turns on line wrapping in flat file writing (optional)  (default: false)

Return Codes: {0=SUCCESS, 1=INTERNAL ERROR, 2=INVALID INPUT, 3=VALIDATION ERROR}
```

