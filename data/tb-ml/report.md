# tb-ml CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tb-ml | Not completed | framework that starts other tools as Docker containers (needs Docker inside Docker and large tool images and reads), skipped |

## tb-ml

### Tool Description
TB-ML: A framework for comparing AMR prediction in M. tuberculosis. Provide Docker image names and arguments like so: --container CONTR_NAME_1 "ARG_1 ARG_2" --container CONTR_NAME_2 "ARG_3" --container CONTR_NAME_3 "ARG_4 ARG_5" ...

### Metadata
- **Docker Image**: quay.io/biocontainers/tb-ml:0.1.1--pyh7cba7a3_0
- **Homepage**: https://github.com/jodyphelan/tb-ml
- **Package**: https://anaconda.org/channels/bioconda/packages/tb-ml/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tb-ml/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jodyphelan/tb-ml
- **Stars**: N/A
### Original Help Text
```text
usage: tb-ml [-h] --container STR STR

TB-ML: A framework for comparing AMR prediction in M. tuberculosis. Provide
Docker image names and arguments like so: --container CONTR_NAME_1 "ARG_1
ARG_2" --container CONTR_NAME_2 "ARG_3" --container CONTR_NAME_3 "ARG_4 ARG_5"
...

options:
  -h, --help           show this help message and exit
  --container STR STR  Name of Docker image and corresponding extra arguments
                       [required]
```

