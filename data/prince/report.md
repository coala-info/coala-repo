# prince CWL Generation Report

## prince

### Tool Description
Prince Options.

### Metadata
- **Docker Image**: quay.io/biocontainers/prince:2.3--py_0
- **Homepage**: https://github.com/WGS-TB/PythonPrince
- **Package**: https://anaconda.org/channels/bioconda/packages/prince/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prince/overview
- **Total Downloads**: 26.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/WGS-TB/PythonPrince
- **Stars**: N/A
### Original Help Text
```text
usage: prince [-h] [-bo BOOST_OUTPUT] [-to TARGET_OUTPUT] [-tmp TEMPLATES]
              [-tf TARGET_FILE] [-bf BOOSTING_FILE] [-k K] [-cn COPYNUMBER]
              [-p PRIMERS] [-np NUM_PROCS] [-v]

Prince Options.

optional arguments:
  -h, --help            show this help message and exit
  -bo BOOST_OUTPUT, --boost_output BOOST_OUTPUT
                        output file for training data / training data used to
                        predict copy numbers for queries
  -to TARGET_OUTPUT, --target_output TARGET_OUTPUT
                        output file for query copy number predictions
  -tmp TEMPLATES, --templates TEMPLATES
                        VNTR templates. Default is for M.TB
  -tf TARGET_FILE, --target_file TARGET_FILE
                        target genome names in a text file
  -bf BOOSTING_FILE, --boosting_file BOOSTING_FILE
                        training genome file names in a text file
  -k K, --k K           Kmer size used during read recruitment.
  -cn COPYNUMBER, --copynumber COPYNUMBER
                        Copy number for training genome.
  -p PRIMERS, --primers PRIMERS
                        Flanking sequences used in coverage adjustments
  -np NUM_PROCS, --num_procs NUM_PROCS
                        Number of cores for parallel processing.
  -v, --version         show program's version number and exit
```

