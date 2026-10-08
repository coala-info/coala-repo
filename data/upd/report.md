# upd CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| upd_regions | PASS |  |
| upd_sites | PASS |  |

## upd_regions

### Tool Description
Call UPD regions

### Metadata
- **Docker Image**: quay.io/biocontainers/upd:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/bjhall/upd
- **Package**: https://anaconda.org/channels/bioconda/packages/upd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/upd/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bjhall/upd
- **Stars**: N/A
### Original Help Text
```text
Usage: upd [OPTIONS] COMMAND [ARGS]...

  Simple software to call UPD regions from germline exome/wgs trios

Options:
  --vcf PATH                      [required]
  --proband TEXT                  ID of proband in VCF  [required]
  --mother TEXT                   ID of mother in VCF  [required]
  --father TEXT                   ID of father in VCF  [required]
  --af-tag TEXT                   Which field to use for population frequency
                                  filtering  [default: MAX_AF]
  --vep                           If af-tag is in VEP annotation
  --min-af FLOAT                  Minimum SNP frequency  [default: 0.05]
  --min-gq INTEGER                Minimum GQ score  [default: 30]
  --loglevel [DEBUG|INFO|WARNING|ERROR|CRITICAL]
                                  Set the level of log output.  [default:
                                  INFO]
  --version
  --help                          Show this message and exit.

Commands:
  regions  Call UPD regions
  sites    Prints the sites that are informative for UPD
Usage: upd regions [OPTIONS]

  Call UPD regions

Options:
  --min-sites INTEGER  Minimum UPD informative sites required to call a region
                       [default: 3]
  --min-size INTEGER   Minimum size (bp) required to call a region  [default:
                       1000]
  -o, --out PATH       Output bed file of all informative sites
  --iso-het-pct FLOAT  Ratio iso/het for determening UPD type  [default: 0.01]
  --help               Show this message and exit.
```


## upd_sites

### Tool Description
Prints the sites that are informative for UPD

### Metadata
- **Docker Image**: quay.io/biocontainers/upd:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/bjhall/upd
- **Package**: https://anaconda.org/channels/bioconda/packages/upd/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: upd [OPTIONS] COMMAND [ARGS]...

  Simple software to call UPD regions from germline exome/wgs trios

Options:
  --vcf PATH                      [required]
  --proband TEXT                  ID of proband in VCF  [required]
  --mother TEXT                   ID of mother in VCF  [required]
  --father TEXT                   ID of father in VCF  [required]
  --af-tag TEXT                   Which field to use for population frequency
                                  filtering  [default: MAX_AF]
  --vep                           If af-tag is in VEP annotation
  --min-af FLOAT                  Minimum SNP frequency  [default: 0.05]
  --min-gq INTEGER                Minimum GQ score  [default: 30]
  --loglevel [DEBUG|INFO|WARNING|ERROR|CRITICAL]
                                  Set the level of log output.  [default:
                                  INFO]
  --version
  --help                          Show this message and exit.

Commands:
  regions  Call UPD regions
  sites    Prints the sites that are informative for UPD
Usage: upd sites [OPTIONS]

  Prints the sites that are informative for UPD

Options:
  -o, --out PATH  Output bed file of all informative sites
  --help          Show this message and exit.
```


## Metadata
- **Skill**: generated
