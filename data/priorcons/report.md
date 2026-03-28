# priorcons CWL Generation Report

## priorcons_build-priors

### Tool Description
Build empirical priors from alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/priorcons:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/GERMAN00VP/priorcons
- **Package**: https://anaconda.org/channels/bioconda/packages/priorcons/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/priorcons/overview
- **Total Downloads**: 51
- **Last updated**: 2025-10-27
- **GitHub**: https://github.com/GERMAN00VP/priorcons
- **Stars**: N/A
### Original Help Text
```text
usage: priorcons [-h] -i INPUT -r REF -o OUTPUT [--win WIN]
                 [--overlap OVERLAP]

Build empirical priors from alignment

options:
  -h, --help           show this help message and exit
  -i, --input INPUT    Input alignment FASTA file
  -r, --ref REF        Reference sequence ID
  -o, --output OUTPUT  Output file (.parquet)
  --win WIN            Window size (default=100)
  --overlap OVERLAP    Window overlap (default=50)
```


## priorcons_integrate-consensus

### Tool Description
Integrates prior information into consensus sequence generation.

### Metadata
- **Docker Image**: quay.io/biocontainers/priorcons:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/GERMAN00VP/priorcons
- **Package**: https://anaconda.org/channels/bioconda/packages/priorcons/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Ellipsis [-h] --input INPUT --ref REF --prior PRIOR
                --output_dir OUTPUT_DIR

options:
  -h, --help            show this help message and exit
  --input INPUT         Path to input alignment file (.aln)
  --ref REF             Reference sequence ID present in the alignment file
  --prior PRIOR         Path to prior parquet file
  --output_dir OUTPUT_DIR
                        Output directory to write results
```


## Metadata
- **Skill**: generated
