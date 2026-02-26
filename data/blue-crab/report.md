# blue-crab CWL Generation Report

## blue-crab_p2s

### Tool Description
Convert POD5 -> SLOW5/BLOW5

### Metadata
- **Docker Image**: quay.io/biocontainers/blue-crab:0.4.0--pyh05cac1d_1
- **Homepage**: https://github.com/Psy-Fer/blue-crab
- **Package**: https://anaconda.org/channels/bioconda/packages/blue-crab/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blue-crab/overview
- **Total Downloads**: 184
- **Last updated**: 2025-07-31
- **GitHub**: https://github.com/Psy-Fer/blue-crab
- **Stars**: N/A
### Original Help Text
```text
error: the following arguments are required: POD5
usage: blue-crab p2s [-h] [-d OUT_DIR | -o S/BLOW5] [-c {zlib,zstd,none}]
                     [-s {svb-zd,ex-zd,none}] [-p IOP] [-t THREADS]
                     [-K BATCHSIZE] [--retain]
                     POD5 [POD5 ...]

Convert POD5 -> SLOW5/BLOW5

positional arguments:
  POD5                  pod5 file/s or directories to convert

options:
  -h, --help            show this help message and exit
  -d OUT_DIR, --out-dir OUT_DIR
                        output to directory (default: None)
  -o S/BLOW5, --output S/BLOW5
                        output to FILE (default: None)
  -c {zlib,zstd,none}, --compress {zlib,zstd,none}
                        record compression method (only for .blow5 format)
                        (default: zlib)
  -s {svb-zd,ex-zd,none}, --sig-compress {svb-zd,ex-zd,none}
                        signal compression method (only for .blow5 format)
                        (default: svb-zd)
  -p IOP, --iop IOP     number of I/O processes to use during conversion of
                        multiple files (default: 4)
  -t THREADS, --threads THREADS
                        number of threads used for encoding S/BLOW5 records in
                        a single process (default: 8)
  -K BATCHSIZE, --batchsize BATCHSIZE
                        batch size used for encoding S/BLOW5 records in a
                        single process (default: 1000)
  --retain              retain the same directory structure in the converted
                        output as the input (experimental) (default: False)
```


## blue-crab_s2p

### Tool Description
Convert SLOW5/BLOW5 -> POD5

### Metadata
- **Docker Image**: quay.io/biocontainers/blue-crab:0.4.0--pyh05cac1d_1
- **Homepage**: https://github.com/Psy-Fer/blue-crab
- **Package**: https://anaconda.org/channels/bioconda/packages/blue-crab/overview
- **Validation**: PASS

### Original Help Text
```text
error: the following arguments are required: SLOW5
usage: blue-crab s2p [-h] [-d OUT_DIR | -o POD5] [-p IOP] [--retain]
                     SLOW5 [SLOW5 ...]

Convert SLOW5/BLOW5 -> POD5

positional arguments:
  SLOW5                 s/blow5 file to convert

options:
  -h, --help            show this help message and exit
  -d OUT_DIR, --out-dir OUT_DIR
                        output to directory (default: None)
  -o POD5, --output POD5
                        output to FILE (default: None)
  -p IOP, --iop IOP     number of I/O processes to use during conversion of
                        multiple files (default: 4)
  --retain              retain the same directory structure in the converted
                        output as the input (experimental) (default: False)
```

