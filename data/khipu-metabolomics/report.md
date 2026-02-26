# khipu-metabolomics CWL Generation Report

## khipu-metabolomics_khipu

### Tool Description
annotating metabolomics features to empCpds

### Metadata
- **Docker Image**: quay.io/biocontainers/khipu-metabolomics:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/shuzhao-li/khipu
- **Package**: https://anaconda.org/channels/bioconda/packages/khipu-metabolomics/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/khipu-metabolomics/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-07-30
- **GitHub**: https://github.com/shuzhao-li/khipu
- **Stars**: N/A
### Original Help Text
```text
~~~~~~~ Hello from Khipu (2.0.4) ~~~~~~~~~

usage: khipu [-h] [-v] [-m MODE] [--ppm PPM] [--rtol RTOL] [-i INPUT]
             [-s START] [-e END] [-o OUTPUT] [-r]

khipu, annotating metabolomics features to empCpds

options:
  -h, --help           show this help message and exit
  -v, --version        print version and exit
  -m, --mode MODE      mode of ionization, pos or neg
  --ppm PPM            mass precision in ppm (part per million), same as
                       mz_tolerance_ppm
  --rtol RTOL          tolerance of retention time match, arbitrary unit
                       dependent on preprocessing tool
  -i, --input INPUT    input file as feature table
  -s, --start START    start column for intensity in input table
  -e, --end END        end column for intensity in input table
  -o, --output OUTPUT  prefix of output files
  -r, --regular        toggle on if there is no isotopic labeled sample
```

