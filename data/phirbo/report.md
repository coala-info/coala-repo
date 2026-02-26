# phirbo CWL Generation Report

## phirbo

### Tool Description
Phirbo (v1.0) predicts hosts from phage (meta)genomic data

### Metadata
- **Docker Image**: quay.io/biocontainers/phirbo:1.0--hdfd78af_1
- **Homepage**: https://github.com/aziele/phirbo
- **Package**: https://anaconda.org/channels/bioconda/packages/phirbo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phirbo/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aziele/phirbo
- **Stars**: N/A
### Original Help Text
```text
usage: phirbo [-h] [--p P] [--k K] [--t NUM_THREADS] [--version]
              virus_dir host_dir output_file

Phirbo (v1.0) predicts hosts from phage (meta)genomic data

positional arguments:
  virus_dir        Input directory w/ ranked lists for viruses
  host_dir         Input directory w/ ranked lists for hosts
  output_file      Output file name

optional arguments:
  -h, --help       show this help message and exit
  --p P            RBO parameter in range (0, 1) determines the degree of top-
                   weightedness of RBO measure. High p implies strong emphasis
                   on top ranked items [default = 0.75]
  --k K            Truncate all ranked lists to the first `k` rankings to
                   calculate RBO. To disable the truncation use --k 0 [default
                   = 30]
  --t NUM_THREADS  Number of threads (CPUs) [default = 20]
  --version        Show tool's version number and exit
```

