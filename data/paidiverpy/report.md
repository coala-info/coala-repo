# paidiverpy CWL Generation Report

## paidiverpy

### Tool Description
Paidiverpy image preprocessing

### Metadata
- **Docker Image**: quay.io/biocontainers/paidiverpy:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/paidiver/paidiverpy
- **Package**: https://anaconda.org/channels/bioconda/packages/paidiverpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/paidiverpy/overview
- **Total Downloads**: 266
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/paidiver/paidiverpy
- **Stars**: N/A
### Original Help Text
```text
usage: paidiverpy [-h] [-c CONFIGURATION_FILE] [-bt BENCHMARK_TEST] [-v]
                  [-gui [GUI ...]]

Paidiverpy image preprocessing

options:
  -h, --help            show this help message and exit
  -c CONFIGURATION_FILE, --configuration_file CONFIGURATION_FILE
                        Path to the configuration file 'config.yml'
  -bt BENCHMARK_TEST, --benchmark_test BENCHMARK_TEST
                        OPTIONAL: ONLY FOR BENCHMARK TESTING. Information for
                        benchmark tests as a JSON string. E.g.,
                        '{"cluster_type": "slurm", "cores": [1,2,4,8,16,32],
                        "processes": [1,2,4,8,16,32], "memory":
                        [1,2,4,8,16,32,64], "scale": [1,2,4,8] }'
  -v, --validate        OPTIONAL: ONLY FOR CONFIGURATION FILE CHECKING. Check
                        the configuration file.
  -gui [GUI ...], --gui [GUI ...]
                        OPTIONAL: ONLY FOR RUNNING THE GRAPHICAL USER
                        INTERFACE (GUI) OF PAIDIVERPY.
```

