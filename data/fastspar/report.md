# fastspar CWL Generation Report

## fastspar

### Tool Description
c++ implementation of SparCC

### Metadata
- **Docker Image**: quay.io/biocontainers/fastspar:1.0.0--h1b620e3_6
- **Homepage**: https://github.com/scwatts/fastspar
- **Package**: https://anaconda.org/channels/bioconda/packages/fastspar/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastspar/overview
- **Total Downloads**: 24.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/scwatts/fastspar
- **Stars**: N/A
### Original Help Text
```text
Program: FastSpar (c++ implementation of SparCC)
Version 1.0.0
Contact: Stephen Watts (s.watts2@student.unimelb.edu.au)

Usage:
  fastspar [options] --otu_table <path> --correlation <path> --covariance <path>

  -c <path>, --otu_table <path>
                OTU input OTU count table
  -r <path>, -correlation <path>
                Correlation output table
  -a <path>, --covariance <path>
                Covariance output table

Options:
  -i <int>, --iterations <int>
                Number of interations to perform (default: 50)
  -x <int>, --exclusion_iterations <int>
                Number of exclusion interations to perform (default: 10)
  -e <float>, --threshold <float>
                Correlation strength exclusion threshold (default: 0.1)
  -t <int>, --threads <int>
                Number of threads (default: 1)
  -s <int>, --seed <int>
                Random number generator seed (default: 1)
  -y, --yes
                Assume yes for prompts (default: unset)

Other:
  -h        --help
                Display this help and exit
  -v        --version
                Display version information and exit

fastspar: error: option -c/--otu_table, -r/--correlation, and -a/--covariance are required
```

