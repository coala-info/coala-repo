# dupre CWL Generation Report

## dupre

### Tool Description
duplicate rate estimation from small subsamples

### Metadata
- **Docker Image**: quay.io/biocontainers/dupre:0.1--py35_0
- **Homepage**: https://bitbucket.org/genomeinformatics/dupre/
- **Package**: https://anaconda.org/channels/bioconda/packages/dupre/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dupre/overview
- **Total Downloads**: 7.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: dupre [-h] [--observed OCCUPANCY [OCCUPANCY ...]] [--target TARGET]
             [--truth OCCUPANCY [OCCUPANCY ...]] [--subsample SUBSAMPLE]
             [--verbose] [--complexity] [--K0 INT] [--zwidth STDDEVs]
             [--Zwidth STDDEVs] [--name NAME] [--histogram] [--stripnames]
             [--version]

dupre: duplicate rate estimation from small subsamples

optional arguments:
  -h, --help            show this help message and exit
  --observed OCCUPANCY [OCCUPANCY ...], -o OCCUPANCY [OCCUPANCY ...]
                        observed occupancy vector (space-separated ints, or a
                        filename)
  --target TARGET, -N TARGET
                        target size, relative (ends with x) or absolute
                        (integer), e.g. '5x' or '1000000')
  --truth OCCUPANCY [OCCUPANCY ...], --full OCCUPANCY [OCCUPANCY ...], -a OCCUPANCY [OCCUPANCY ...]
                        true occupancy vector of the full dataset (space-
                        separated ints, or a filename)
  --subsample SUBSAMPLE, -n SUBSAMPLE
                        subsample size, relative (ends with x) or absolute
                        (integer), e.g. '0.01x' or '10000'
  --verbose, -v         verbose output
  --complexity, -c      output complexity instead of duplication rate
  --K0 INT, -K INT      occupancy number above which to use the heuristic [25]
  --zwidth STDDEVs, -z STDDEVs
                        allowed standard deviation for each expected occupancy
  --Zwidth STDDEVs, -Z STDDEVs
                        allowed standard deviation of sum of most significant
                        terms
  --name NAME           name of this problem instance
  --histogram, -H       instance data is given as PRESEQ histogram file(s)
  --stripnames          strip instance names of observed occupancy vector of
                        last component for lookup
  --version             show program's version number and exit

In development. Use at your own Risk.
```

