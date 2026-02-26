# tadlib CWL Generation Report

## tadlib_hitad

### Tool Description
A highly sensitive and reproducible hierarchical domain caller.

### Metadata
- **Docker Image**: quay.io/biocontainers/tadlib:0.4.5.post1--pyhdfd78af_1
- **Homepage**: https://github.com/XiaoTaoWang/TADLib/
- **Package**: https://anaconda.org/channels/bioconda/packages/tadlib/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tadlib/overview
- **Total Downloads**: 784
- **Last updated**: 2025-06-11
- **GitHub**: https://github.com/XiaoTaoWang/TADLib
- **Stars**: N/A
### Original Help Text
```text
usage: hitad <-d datasets -O output> [options]

A highly sensitive and reproducible hierarchical domain caller.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit
  -O OUTPUT, --output OUTPUT
                        Output file name. (default: None)
  -d DATASETS, --datasets DATASETS
                        Metadata file describing Hi-C datasets. Refer to our
                        online documentation for more details. (default: None)
  -W WEIGHT_COL, --weight-col WEIGHT_COL
                        Name of the column in .cool to be used to construct
                        the normalized matrix. Specify "-W RAW" if you want to
                        run with the raw matrix. (default: weight)
  --exclude [EXCLUDE ...]
                        List of chromosomes to exclude. (default: ['chrY',
                        'chrM'])
  --minimum-chrom-size MINIMUM_CHROM_SIZE
                        Minimum chromosome size. Only chromosomes with a size
                        greater than this value will be considered. (default:
                        1000000)
  --maxsize MAXSIZE     Maximum domain size in base-pair unit. (default:
                        4000000)
  -D DI_COL, --DI-col DI_COL
                        Name of the column in .cool to output the DI track
                        (default: DIs)
  -p CPU_CORE, --cpu-core CPU_CORE
                        Number of processes to launch. (default: 1)
  --removeCache         Remove cache data before exiting. (default: False)
  --logFile LOGFILE     Logging file name. (default: hitad.log)
```


## tadlib_domaincaller

### Tool Description
Detect minimum domains using adaptive DI

### Metadata
- **Docker Image**: quay.io/biocontainers/tadlib:0.4.5.post1--pyhdfd78af_1
- **Homepage**: https://github.com/XiaoTaoWang/TADLib/
- **Package**: https://anaconda.org/channels/bioconda/packages/tadlib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: domaincaller <--uri cool -O output> [options]

Detect minimum domains using adaptive DI

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit
  --uri URI             Cool URI. (default: None)
  -O OUTPUT, --output OUTPUT
  -D DI_OUTPUT, --DI-output DI_OUTPUT
  -W WEIGHT_COL, --weight-col WEIGHT_COL
                        Name of the column in .cool to be used to construct
                        the normalized matrix. Specify "-W RAW" if you want to
                        run with the raw matrix. (default: weight)
  --exclude [EXCLUDE ...]
                        List of chromosomes to exclude. (default: ['chrY',
                        'chrM'])
  -p CPU_CORE, --cpu-core CPU_CORE
                        Number of processes to launch. (default: 1)
  --removeCache         Remove cache data before exiting. (default: False)
  --logFile LOGFILE     Logging file name. (default: domaincaller.log)
```

