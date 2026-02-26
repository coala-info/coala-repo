# ms2rescore CWL Generation Report

## ms2rescore

### Tool Description
Sensitive PSM rescoring with predicted features.

### Metadata
- **Docker Image**: quay.io/biocontainers/ms2rescore:3.2.1--pyhdfd78af_0
- **Homepage**: https://compomics.github.io/projects/ms2rescore/
- **Package**: https://anaconda.org/channels/bioconda/packages/ms2rescore/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ms2rescore/overview
- **Total Downloads**: 7.7K
- **Last updated**: 2026-02-13
- **GitHub**: https://github.com/compomics/ms2rescore
- **Stars**: N/A
### Original Help Text
```text
MS²Rescore (v3.2.1)
Developed at CompOmics, VIB / Ghent University, Belgium.
Please cite: Buur & Declercq et al. JPR (2024)

usage: ms2rescore [-h] [-v] [-p [FILE ...]] [-t STR] [-s FILE/DIR] [-c FILE]
                  [-o FILE] [-l STR] [-n INT] [-f FILE] [--write-report]
                  [--disable-update-check] [--profile]

MS²Rescore: Sensitive PSM rescoring with predicted features.

options:
  -h, --help                             show this help message and exit
  -v, --version                          show program's version number and
                                         exit
  -p [FILE ...], --psm-file [FILE ...]   path to PSM file (PIN, mzIdentML,
                                         MaxQuant msms, X!Tandem XML...)
  -t STR, --psm-file-type STR            PSM file type (default: 'infer')
  -s FILE/DIR, --spectrum-path FILE/DIR  path to MGF/mzML spectrum file or
                                         directory with spectrum files
                                         (default: derived from identification
                                         file)
  -c FILE, --config-file FILE            path to MS²Rescore configuration file
                                         (see README.md)
  -o FILE, --output-path FILE            Path and stem for output file names
                                         (default: derive from identification
                                         file)
  -l STR, --log-level STR                logging level (default: `info`)
  -n INT, --processes INT                number of parallel processes
                                         available to MS²Rescore
  -f FILE, --fasta-file FILE             path to FASTA file
  --write-report                         boolean whether to write an HTML
                                         report (default: True)
  --disable-update-check                 Disable automatic check for software
                                         updates (default: False)
  --profile                              Enable profiling with cProfile
```

