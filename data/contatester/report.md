# contatester CWL Generation Report

## contatester

### Tool Description
Wrapper for the detection and determination of the presence of cross contaminant

### Metadata
- **Docker Image**: quay.io/biocontainers/contatester:1.0.0--py311r44he3b539c_4
- **Homepage**: https://github.com/CNRGH/contatester
- **Package**: https://anaconda.org/channels/bioconda/packages/contatester/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/contatester/overview
- **Total Downloads**: 10.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CNRGH/contatester
- **Stars**: N/A
### Original Help Text
```text
usage: contatester [-h] (-f FILE | -l LIST) [-o OUTDIR] [-e EXPERIMENT] [-r]
                   [-c] [-m MAIL] [-A ACCOUNTING] [-d DAGNAME] [-t THREAD]
                   [-s THRESHOLD]

Wrapper for the detection and determination of the presence of cross
contaminant

options:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  VCF file version 4.2 to process. If -f is used don't
                        use -l (Mandatory)
  -l LIST, --list LIST  input text file, one vcf by lane. If -l is used don't
                        use -f (Mandatory)
  -o OUTDIR, --outdir OUTDIR
                        folder for storing all output files (optional)
                        [default: current directory]
  -e EXPERIMENT, --experiment EXPERIMENT
                        Experiment type, could be WG for Whole Genome or EX
                        for Exome [default WG]
  -r, --report          create a pdf report for contamination estimation
                        [default: no report]
  -c, --check           enable contaminant check for each VCF provided if a
                        VCF is marked as contaminated
  -m MAIL, --mail MAIL  send an email at the end of the job
  -A ACCOUNTING, --accounting ACCOUNTING
                        msub option for calculation time imputation
  -d DAGNAME, --dagname DAGNAME
                        DAG file name for pegasus
  -t THREAD, --thread THREAD
                        number of threads used by job(optional) [default if
                        check enable|disable: 4|1]
  -s THRESHOLD, --threshold THRESHOLD
                        Threshold for contaminated status(optional) [default:
                        4 ]
```

