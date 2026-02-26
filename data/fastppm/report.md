# fastppm CWL Generation Report

## fastppm_fastppm-cli

### Tool Description
FastPPM CLI

### Metadata
- **Docker Image**: quay.io/biocontainers/fastppm:1.1.1--py39h2de1943_0
- **Homepage**: https://github.com/elkebir-group/fastppm
- **Package**: https://anaconda.org/channels/bioconda/packages/fastppm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastppm/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-12-05
- **GitHub**: https://github.com/elkebir-group/fastppm
- **Stars**: N/A
### Original Help Text
```text
Unknown argument: --h
Usage: fastppm [--help] --variant VAR [--version] --total VAR [--weights VAR] --tree VAR --output VAR [--format VAR] [--loss VAR] [--precision VAR] [--segments VAR]

Optional arguments:
  -h, --help       shows help message and exits 
  -v, --variant    Path to the variant read matrix file [required]
  --version        prints version information and exits 
  -d, --total      Path to the total read matrix file [required]
  -w, --weights    Path to the weights matrix file [nargs=0..1] [default: ""]
  -t, --tree       Path to the tree file [required]
  -o, --output     Path to the output file [required]
  -f, --format     Output format, either 'concise' or 'verbose' [nargs=0..1] [default: "concise"]
  -l, --loss       Loss function L_i(.) to use for optimization [nargs=0..1] [default: "l2"]
  -s, --precision  Precision parameter, only used when loss function is 'beta_binomial*' [nargs=0..1] [default: 10]
  -K, --segments   Number of segments, only used when loss function is '*_pla' or '*_ppla' [nargs=0..1] [default: 10]
```

