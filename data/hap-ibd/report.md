# hap-ibd CWL Generation Report

## hap-ibd

### Tool Description
Finds segments of identity-by-descent (IBD) between individuals in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/hap-ibd:1.0.rev20May22.818--hdfd78af_0
- **Homepage**: https://github.com/browning-lab/hap-ibd
- **Package**: https://anaconda.org/channels/bioconda/packages/hap-ibd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hap-ibd/overview
- **Total Downloads**: 4.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/browning-lab/hap-ibd
- **Stars**: N/A
### Original Help Text
```text
hap-ibd.jar  [ version 1.0, 20May22.818 ]

Syntax: java -jar hap-ibd.jar [arguments in format: parameter=value]

Data Parameters: 
  gt=<VCF file with GT field>                         (required)
  map=<PLINK map file with cM units>                  (required)
  out=<output file prefix>                            (required)
  excludesamples=<excluded samples file>              (optional)

Algorithm Parameters: 
  min-seed=<min cM length of seed segment>            (default: 2.0)
  max-gap=<max base pairs in non-IBS gap>             (default: 1000)
  min-extend=<min cM length of extension segment>     (default: min(1.0, min-seed))
  min-output=<min cM length of output segment>        (default: 2.0)
  min-markers=<min markers in seed segment>           (default: 100)
  min-mac=<minimum minor allele count filter>         (default: 2)
  nthreads=<number of computational threads>          (default: all CPU cores)
```

