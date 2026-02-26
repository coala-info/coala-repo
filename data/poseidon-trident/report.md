# poseidon-trident CWL Generation Report

## poseidon-trident_trident

### Tool Description
trident is a management and analysis tool for Poseidon packages. Report issues
here: https://github.com/poseidon-framework/poseidon-hs/issues

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Total Downloads**: 27.7K
- **Last updated**: 2025-11-04
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
trident v1.6.7.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io

Usage: trident [--version] [--logMode MODE | --debug] [--errLength INT] 
               [--inPlinkPopName MODE] (COMMAND | COMMAND)

  trident is a management and analysis tool for Poseidon packages. Report issues
  here: https://github.com/poseidon-framework/poseidon-hs/issues

Available options:
  -h,--help                Show this help text
  --version                Show version number
  --logMode MODE           How information should be reported: NoLog, SimpleLog,
                           DefaultLog, ServerLog or VerboseLog.
                           (default: DefaultLog)
  --debug                  Short for --logMode VerboseLog.
  --errLength INT          After how many characters should a potential genotype
                           data parsing error message be truncated. "Inf" for no
                           truncation. (default: CharCount 1500)
  --inPlinkPopName MODE    Where to read the population/group name from the FAM
                           file in Plink-format. Three options are possible:
                           asFamily (default) | asPhenotype | asBoth.

Package creation and manipulation commands:
  init                     Create a new Poseidon package from genotype data
  fetch                    Download data from a remote Poseidon repository
  forge                    Select packages, groups or individuals and create a
                           new Poseidon package from them
  genoconvert              Convert the genotype data in a Poseidon package to a
                           different file format
  jannocoalesce            Coalesce information from one or multiple janno files
                           to another one
  rectify                  Adjust POSEIDON.yml files automatically to package
                           changes

Inspection commands:
  list                     List packages, groups or individuals from local or
                           remote Poseidon repositories
  summarise                Get an overview over the content of one or multiple
                           Poseidon packages
  survey                   Survey the degree of context information completeness
                           for Poseidon packages
  validate                 Check Poseidon packages or package components for
                           structural correctness
```

