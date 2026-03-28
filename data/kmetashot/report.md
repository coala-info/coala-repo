# kmetashot CWL Generation Report

## kmetashot_kMetaShot_test.py

### Tool Description
kMetaShot installation test

### Metadata
- **Docker Image**: quay.io/biocontainers/kmetashot:2.0--pyh7e72e81_1
- **Homepage**: https://github.com/gdefazio/kMetaShot
- **Package**: https://anaconda.org/channels/bioconda/packages/kmetashot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kmetashot/overview
- **Total Downloads**: 306
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/gdefazio/kMetaShot
- **Stars**: N/A
### Original Help Text
```text
usage: kMetaShot_test.py [-h] -r REFERENCE

kMetaShot installation test

options:
  -h, --help            show this help message and exit
  -r, --reference REFERENCE
                        Path to HDF5 file containing reference
```


## kmetashot_kMetaShot_classifier_NV.py

### Tool Description
kMetaShot is able to taxonomically classiy bins/MAGs and long reads by using an alignment free and k-mer/minimizer based approach.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmetashot:2.0--pyh7e72e81_1
- **Homepage**: https://github.com/gdefazio/kMetaShot
- **Package**: https://anaconda.org/channels/bioconda/packages/kmetashot/overview
- **Validation**: PASS

### Original Help Text
```text
################################################
                           #        kMetaShot Classifier Algorithm        #
                           #                  Version 2.0                 #
                           #               Defazio G. et al.              #
                           ################################################

usage: kMetaShot_classifier_NV.py [-h] -b BINS_DIR -r REFERENCE [-a ASS2REF]
                                  -p PROCESSES [-o OUT_DIR]

kMetaShot is able to taxonomically classiy bins/MAGs and long reads by using
an alignment free and k-mer/minimizer based approach.

options:
  -h, --help            show this help message and exit
  -b, --bins_dir BINS_DIR
                        Path to directory containing bins or path to multi-
                        fasta file
  -r, --reference REFERENCE
                        Path to HDF5 file containing reference
  -a, --ass2ref ASS2REF
                        Classification filtering based on ass2ref parameter
                        ranging between 0 and 1. Default 0.
  -p, --processes PROCESSES
                        Multiprocess parallelism. Warning: high parallelism
                        <==> high RAM usage
  -o, --out_dir OUT_DIR
                        Output file path name
```


## Metadata
- **Skill**: generated
