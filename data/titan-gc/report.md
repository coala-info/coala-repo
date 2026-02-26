# titan-gc CWL Generation Report

## titan-gc

### Tool Description
Run Titan GC on a set of samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/titan-gc:1.5.3--hdfd78af_1
- **Homepage**: https://github.com/theiagen/public_health_viral_genomics
- **Package**: https://anaconda.org/channels/bioconda/packages/titan-gc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/titan-gc/overview
- **Total Downloads**: 11.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/theiagen/public_health_viral_genomics
- **Stars**: N/A
### Original Help Text
```text
Unknown parameter passed: -help
usage: titan-gc [-h] [-i STR] [--inputs STR] [-o STR] [--outdir STR] [--options STR] [--quiet]

titan-gc - Run Titan GC on a set of samples.

required arguments:
  -i STR, --inputs STR  The JSON file to be used with Cromwell for inputs.
  -o STR, --outdir STR  Output directory to store the final results in.

optional arguments:
  -h, --help              Show this help message and exit
  -v, --version           Print the version
  --options STR           JSON file containing Cromwell options
  --profile STR           The backend profile to use [options: docker, singularity]
  --config STR            Custom backend profile to use
  --cromwell_jar STR      Path to cromwell.jar (Default use conda install)
  --quiet                 Silence all STDOUT from Cromwell and titan-gc-organize
```

