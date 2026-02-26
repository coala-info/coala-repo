# verifyidintensity CWL Generation Report

## verifyidintensity_verifyIDintensity

### Tool Description
Command description message

### Metadata
- **Docker Image**: quay.io/biocontainers/verifyidintensity:0.0.1--h077b44d_6
- **Homepage**: https://genome.sph.umich.edu/wiki/VerifyIDintensity
- **Package**: https://anaconda.org/channels/bioconda/packages/verifyidintensity/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/verifyidintensity/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
USAGE: 

   verifyIDintensity  [-t <float>] -m <int> -n <int> [-b <string>] [-s
                      <string>] -i <string> [-v] [-p] [--] [--version]
                      [-h]


Where: 

   -t <float>,  --threshold <float>
     Minimum allele frequency for likelihood estimation, default is 0.01

   -m <int>,  --marker <int>
     (required)  Number of markers

   -n <int>,  --number <int>
     (required)  Number of samples

   -b <string>,  --abf <string>
     Allele frequency file (ABF), which is a plain text file with SNP_ID
     and Allele_B frequency

   -s <string>,  --stat <string>
     Statistics file (created if not exist)

   -i <string>,  --in <string>
     (required)  Input intensity (.adpc.bin) file

   -v,  --verbose
     Turn on verbose mode

   -p,  --persample
     Do per-sample analysis, default is per-marker analysis

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.


   Command description message
```

