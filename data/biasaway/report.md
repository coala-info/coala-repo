# biasaway CWL Generation Report

## biasaway_Valid

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/biasaway:3.3.0--py_0
- **Homepage**: https://github.com/asntech/biasaway
- **Package**: https://anaconda.org/channels/bioconda/packages/biasaway/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/biasaway/overview
- **Total Downloads**: 35.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/asntech/biasaway
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: biasaway [-h] [-v] {k,w,g,c} ...

Background generator offering the possibility of using very
    different ways of generating backgrounds lying into two categories:
        - Creation of new random sequences (generators):
            - k-mer shuffling using the foreground sequences
                -> type: `biasaway k -h`
            - k-mer shuffling within a sliding window using foreground
              sequences
                -> type: `biasaway w -h`
        - Extraction of sequences from a set of possible background sequences
          (choosers):
            - respecting the %GC distribution of the foreground (using %GC
              bins)
                -> type: `biasaway g -h`
            - respecting the %GC distribution as in the previous item and also
              respecting the %GC composition within a sliding window for %GC
              bin
                -> type: `biasaway c -h`
    

optional arguments:
  -h, --help     show this help message and exit
  -v, --version  show program's version number and exit

Subcommands:
  Valid subcommands

  {k,w,g,c}
    k            k-mer shuffling generator
    w            k-mer shuffling within a sliding window generator
    g            %GC distribution-based background chooser
    c            %GC distribution and %GC composition within a sliding window
                 background chooser
```


## biasaway_background

### Tool Description
Background generator offering the possibility of using very
different ways of generating backgrounds lying into two categories:
    - Creation of new random sequences (generators):
        - k-mer shuffling using the foreground sequences
            -> type: `biasaway k -h`
        - k-mer shuffling within a sliding window using foreground
          sequences
            -> type: `biasaway w -h`
    - Extraction of sequences from a set of possible background sequences
      (choosers):
        - respecting the %GC distribution of the foreground (using %GC
          bins)
            -> type: `biasaway g -h`
        - respecting the %GC distribution as in the previous item and also
          respecting the %GC composition within a sliding window for %GC
          bin
            -> type: `biasaway c -h`

### Metadata
- **Docker Image**: quay.io/biocontainers/biasaway:3.3.0--py_0
- **Homepage**: https://github.com/asntech/biasaway
- **Package**: https://anaconda.org/channels/bioconda/packages/biasaway/overview
- **Validation**: PASS

### Original Help Text
```text
usage: biasaway [-h] [-v] {k,w,g,c} ...

Background generator offering the possibility of using very
    different ways of generating backgrounds lying into two categories:
        - Creation of new random sequences (generators):
            - k-mer shuffling using the foreground sequences
                -> type: `biasaway k -h`
            - k-mer shuffling within a sliding window using foreground
              sequences
                -> type: `biasaway w -h`
        - Extraction of sequences from a set of possible background sequences
          (choosers):
            - respecting the %GC distribution of the foreground (using %GC
              bins)
                -> type: `biasaway g -h`
            - respecting the %GC distribution as in the previous item and also
              respecting the %GC composition within a sliding window for %GC
              bin
                -> type: `biasaway c -h`
    

optional arguments:
  -h, --help     show this help message and exit
  -v, --version  show program's version number and exit

Subcommands:
  Valid subcommands

  {k,w,g,c}
    k            k-mer shuffling generator
    w            k-mer shuffling within a sliding window generator
    g            %GC distribution-based background chooser
    c            %GC distribution and %GC composition within a sliding window
                 background chooser
```

