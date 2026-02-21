# bloocoo CWL Generation Report

## bloocoo

### Tool Description
FAIL to generate CWL: bloocoo not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/bloocoo:1.0.7--h5b5514e_4
- **Homepage**: http://gatb.inria.fr/software/bloocoo/
- **Package**: https://anaconda.org/channels/bioconda/packages/bloocoo/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/bloocoo/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: bloocoo not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: bloocoo not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## bloocoo_Bloocoo

### Tool Description
Bloocoo is a k-mer based read error correction tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/bloocoo:1.0.7--h5b5514e_4
- **Homepage**: http://gatb.inria.fr/software/bloocoo/
- **Package**: https://anaconda.org/channels/bioconda/packages/bloocoo/overview
- **Validation**: PASS
### Original Help Text
```text
ERROR: Unknown parameter '--help'
ERROR: Option '-file' is mandatory

[bloocoo options]
       -nb-cores                        (1 arg) :    number of cores  [default '0']
       -verbose                         (1 arg) :    verbosity level  [default '1']
       -file                            (1 arg) :    reads file
       -kmer-size                       (1 arg) :    size of a kmer  [default '31']
       -abundance-min                   (1 arg) :    min abundance threshold for solid kmers  [default '3']
       -abundance-max                   (1 arg) :    max abundance threshold for solid kmers  [default '2147483647']
       -abundance-min-threshold         (1 arg) :    min abundance hard threshold (only used when min abundance is "auto")  [default '3']
       -histo-max                       (1 arg) :    max number of values in kmers histogram  [default '10000']
       -solidity-kind                   (1 arg) :    way to compute counts of several files (sum, min, max, one, all)  [default 'sum']
       -max-memory                      (1 arg) :    max memory (in MBytes)  [default '5000']
       -max-disk                        (1 arg) :    max disk   (in MBytes)  [default '0']
       -solid-kmers-out                 (1 arg) :    output file for solid kmers  [default '']
       -out                             (1 arg) :    output file  [default '']
       -out-dir                         (1 arg) :    output directory  [default '.']
       -out-tmp                         (1 arg) :    output directory for temporary files  [default '.']
       -out-compress                    (1 arg) :    output compression level (0:none, 9:best)  [default '0']

   [kmer count, advanced (developer) options]
          -minimizer-type   (1 arg) :    minimizer type (0=lexi, 1=freq)  [default '0']
          -minimizer-size   (1 arg) :    size of a minimizer  [default '8']
          -repartition-type (1 arg) :    minimizer repartition (0=unordered, 1=ordered)  [default '0']
       -high-recall      (0 arg) :    correct a lot but can introduce more mistakes
       -high-precision   (0 arg) :    correct safely, correct less but introduce less mistakes
       -slow             (0 arg) :    slower but better correction
       -ion              (0 arg) :    ion correction mode
       -err-tab          (0 arg) :    generate error tabs
       -max-trim         (1 arg) :    max number of bases that can be trimmed per read  [default '']
       -from-h5          (0 arg) :    do not re-compute kmer counts, suppose h5 file already computed (with previous run with -count-only)
       -count-only       (0 arg) :    do not correct, only count kmers
```

