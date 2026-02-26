# mfold CWL Generation Report

## mfold

### Tool Description
Predicts RNA or DNA secondary structure using thermodynamic methods

### Metadata
- **Docker Image**: quay.io/biocontainers/mfold:3.6--h8537716_3
- **Homepage**: http://www.unafold.org/mfold/software/download-mfold.php
- **Package**: https://anaconda.org/channels/bioconda/packages/mfold/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mfold/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage is
mfold SEQ='file_name' with optional parameters:
    [ AUX='auxfile_name' ] [ RUN_TYPE=text (default) or html ]
    [ NA=RNA (default) or DNA ] [ LC=sequence type (default = linear) ]
    [ T=temperature (default = 37 deg C) ] [ P=percent (default = 5) ]
    [ NA_CONC=Na+ molar concentration (default = 1.0) ]
    [ MG_CONC=Mg++ molar concentration (default = 0.0) ]
    [ W=window parameter (default - set by sequence length) ]
    [ MAXBP=max base pair distance (default - no limit) ]
    [ MAX=maximum number of foldings to be computed (default 100) ]
    [ MAX_LP=maximum bulge/interior loop size (default 30) ]
    [ MAX_AS=maximum asymmetry of a bulge/interior loop (default 30) ]
    [ ANN=structure annotation type: none (default), p-num or ss-count ]
    [ MODE=structure display mode: auto (default), bases or lines ]
    [ LAB_FR=base numbering frequency ] [ ROT_ANG=structure rotation angle ]
    [ START=5' base # (default = 1)] [ STOP=3' base # (default = end) ]
    [ REUSE=NO/YES (default=NO) reuse existing .sav file ]
```

