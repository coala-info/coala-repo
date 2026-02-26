# poseidon-xerxes CWL Generation Report

## poseidon-xerxes_xerxes

### Tool Description
xerxes is an analysis tool for Poseidon packages. Report issues here:
  https://github.com/poseidon-framework/poseidon-analysis-hs/issues

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-xerxes:1.0.1.1--hf48d1a7_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-xerxes/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/poseidon-xerxes/overview
- **Total Downloads**: 9.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
xerxes v1.0.1.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io

Usage: xerxes [--version] [--logMode MODE] [--errLength INT] 
              [--inPlinkPopName MODE] (COMMAND | COMMAND)

  xerxes is an analysis tool for Poseidon packages. Report issues here:
  https://github.com/poseidon-framework/poseidon-analysis-hs/issues

Available options:
  -h,--help                Show this help text
  --version                Show version number
  --logMode MODE           How information should be reported: NoLog, SimpleLog,
                           DefaultLog, ServerLog or VerboseLog.
                           (default: DefaultLog)
  --errLength INT          After how many characters should a potential error
                           message be truncated. "Inf" for no truncation.
                           (default: CharCount 1500)
  --inPlinkPopName MODE    Where to read the population/group name from the FAM
                           file in Plink-format. Three options are possible:
                           asFamily (default) | asPhenotype | asBoth.

Analysis commands:
  fstats                   Compute f-statistics on groups and invidiuals within
                           and across Poseidon packages
  ras                      Compute RAS statistics on groups and individuals
                           within and across Poseidon packages

Artificial genotype generators:
  admixpops                Generate individuals with randomized genotype
                           profiles based on admixture proportions
                           (experimental)
```

