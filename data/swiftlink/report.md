# swiftlink CWL Generation Report

## swiftlink

### Tool Description
SwiftLink is a tool for linkage analysis and ELOD calculation.

### Metadata
- **Docker Image**: quay.io/biocontainers/swiftlink:1.0--1
- **Homepage**: https://github.com/ajm/swiftlink
- **Package**: https://anaconda.org/channels/bioconda/packages/swiftlink/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/swiftlink/overview
- **Total Downloads**: 6.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ajm/swiftlink
- **Stars**: N/A
### Original Help Text
```text
Usage: swiftlink [OPTIONS] -p pedfile -m mapfile -d datfile
       swiftlink [OPTIONS] -p pedfile --elod

Input files:
  -p pedfile, --pedigree=pedfile
  -m mapfile, --map=mapfile
  -d datfile, --dat=datfile

Output files:
  -o outfile, --output=outfile            (default = 'swiftlink.out')

MCMC options:
  -i NUM,     --iterations=NUM            (default = 50000)
  -b NUM,     --burnin=NUM                (default = 50000)
  -s NUM,     --sequentialimputation=NUM  (default = 1000)
  -x NUM,     --scoringperiod=NUM         (default = 10)
  -l FLOAT,   --lsamplerprobability=FLOAT (default = 0.5)
  -n NUM,     --lodscores=NUM             (default = 5)
  -R NUM,     --runs=NUM                  (default = 1)

MCMC diagnostic options:
  -T,         --trace
  -P PREFIX,  --traceprefix=PREFIX        (default = 'trace')

ELOD options:
  -e          --elod
  -f FLOAT    --frequency=FLOAT           (default = 1.0e-04)
  -w FLOAT    --separation=FLOAT          (default = 0.0500)
  -k FLOAT,FLOAT,FLOAT --penetrance=FLOAT,FLOAT,FLOAT(default = 0.00,0.00,1.00)
  -u NUM      --replicates=NUM            (default = 1000000)

Runtime options:
  -c NUM,     --cores=NUM                 (default = 1)
  -g,         --gpu                       [UNAVAILABLE, COMPILED WITHOUT CUDA]

Misc:
  -X,         --sexlinked
  -a,         --affectedonly
  -q NUM,     --peelseqiter=NUM           (default = 1000000)
  -r seedfile,--randomseeds=seedfile
  -v,         --verbose
  -h,         --help
```

