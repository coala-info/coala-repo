# starcatpy CWL Generation Report

## starcatpy_starcat

### Tool Description
A tool for analyzing gene expression patterns.

### Metadata
- **Docker Image**: quay.io/biocontainers/starcatpy:1.0.9--pyh7e72e81_0
- **Homepage**: https://github.com/immunogenomics/starCAT
- **Package**: https://anaconda.org/channels/bioconda/packages/starcatpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/starcatpy/overview
- **Total Downloads**: 658
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/immunogenomics/starCAT
- **Stars**: N/A
### Original Help Text
```text
usage: starcat [-h] [-r REFERENCE] [-c COUNTS] [--output-dir [OUTPUT_DIR]]
               [--name [NAME]] [-s SCORES]

options:
  -h, --help            show this help message and exit
  -r, --reference REFERENCE
                        File containing a reference set of GEPs by genes
                        (*.tsv/.csv/.txt) OR the name of a default reference
                        to use (ex. TCAT.V1).
  -c, --counts COUNTS   Input (cell x gene) counts matrix as df.npz, tab
                        delimited text file, or anndata file (h5ad)
  --output-dir [OUTPUT_DIR]
                        Output directory. All output will be placed in
                        [output-dir]/[name]...
  --name [NAME]         Name for analysis. All output will be placed in
                        [output-dir]/[name]...
  -s, --scores SCORES   Optional path to yaml file for calculating score add-
                        ons. Not necessary for pre-built references
```

