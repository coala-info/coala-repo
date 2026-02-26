# ibdseq CWL Generation Report

## ibdseq

### Tool Description
Calculates Identity By Descent (IBD) segments between individuals in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibdseq:r1206--1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ibdseq/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
ibdseq r1206
usage: java -jar ibdseq.jar [parameters]

Data Parameters: 
  gt=<VCF file with GT field>                       (required)
  out=<output file prefix>                          (required)
  excludesamples=<excluded samples file>            (optional)
  excludemarkers=<excluded markers file>            (optional)
  chrom=<[chrom]:[start]-[end]>                     (optional)
  minalleles=<minimum minor allele count>           (default=2)

Algorithm Parameters: 
  ibdlod=<min LOD score for reported IBD>           (default=3.0)
  ibdtrim=<LOD score to trim from segment ends>     (default=0.3)
  errormax=<max allele error rate>                  (default=0.001)
  errorprop=<allele error as proportion of MAF>     (default=0.25)
  r2window=<window-size when checking marker R2>    (default=500)
  r2max=<max R2 permitted between markers>          (default=0.15)
  nthreads=<number of threads to use>               (default=1)
```


## Metadata
- **Skill**: generated

## ibdseq

### Tool Description
Calculates Identity By Descent (IBD) segments between individuals in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibdseq:r1206--1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
ibdseq r1206
usage: java -jar ibdseq.jar [parameters]

Data Parameters: 
  gt=<VCF file with GT field>                       (required)
  out=<output file prefix>                          (required)
  excludesamples=<excluded samples file>            (optional)
  excludemarkers=<excluded markers file>            (optional)
  chrom=<[chrom]:[start]-[end]>                     (optional)
  minalleles=<minimum minor allele count>           (default=2)

Algorithm Parameters: 
  ibdlod=<min LOD score for reported IBD>           (default=3.0)
  ibdtrim=<LOD score to trim from segment ends>     (default=0.3)
  errormax=<max allele error rate>                  (default=0.001)
  errorprop=<allele error as proportion of MAF>     (default=0.25)
  r2window=<window-size when checking marker R2>    (default=500)
  r2max=<max R2 permitted between markers>          (default=0.15)
  nthreads=<number of threads to use>               (default=1)
```

