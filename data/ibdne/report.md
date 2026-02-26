# ibdne CWL Generation Report

## ibdne

### Tool Description
Calculates Identity By Descent (IBD) segments between individuals.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibdne:04Sep15.e78--0
- **Homepage**: https://github.com/hennlab/AS-IBDNe
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ibdne/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hennlab/AS-IBDNe
- **Stars**: N/A
### Original Help Text
```text
Program: ibdne.04Sep15.e78.jar
Copyright (C) 2015 Brian L. Browning

usage: cat [ibd] | java -jar ibdne.04Sep15.e78.jar [args]

where: 
  [ibd]  = a space-separated list of Beagle-format IBD files
  [args] = a space-separated list of algorithm parameters

Algorithm Parameters: 

  map=<PLINK-format genetic map with cM distances>  (required)
  out=<output file prefix>                          (required)

  minibd=<min cM length of an IBD segment>          (default=4.0)
  minregion=<min cM length of a continuous region>  (default=50.0)
  filtersamples=<true/false>                        (default=true)
  trim=<cM to trim from ends of each region>        (default=0.2)

  nits=<number of iterations>                       (default=50)
  nstarts=<number of random starts>                 (default=50)
  nboots<number of bootstrap samples>               (default=80)
  gmax=<max number of generations before present>   (default=[depends on minibd])

  seed=<seed for random number generator>           (default=-99999)
  nthreads=<number of computational threads>        (default=1)
```

