# chip-r CWL Generation Report

## chip-r_chipr

### Tool Description
Combine multiple ChIP-seq files and return a union of all peak locations and a set confident, reproducible peaks as determined by rank product analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/chip-r:1.2.0--pyh3252c3a_0
- **Homepage**: https://github.com/rhysnewell/ChIP-R
- **Package**: https://anaconda.org/channels/bioconda/packages/chip-r/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chip-r/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rhysnewell/ChIP-R
- **Stars**: N/A
### Original Help Text
```text
usage: chipr [-h] -i INPUT [INPUT ...] [-o OUTPUT] [-m MINENTRIES]
             [--rankmethod RANKMETHOD] [--fragment]
             [--duphandling DUPHANDLING] [--seed RANDOM_SEED] [-a ALPHA]
             [-s SIZE]

Combine multiple ChIP-seq files and return a union of all peak locations and a
set confident, reproducible peaks as determined by rank product analysis

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        ChIP-seq input files. These files must be in either
                        narrowPeak, broadPeak, or regionPeak format. Multiple
                        inputs are separeted by a single space
  -o OUTPUT, --output OUTPUT
                        ChIP-seq output filename prefix
  -m MINENTRIES, --minentries MINENTRIES
                        The minimum peaks between replicates required to form
                        an intersection of the peaks Default: 1
  --rankmethod RANKMETHOD
                        The ranking method used to rank peaks within
                        replicates. Options: 'signalvalue', 'pvalue',
                        'qvalue'. Default: pvalue
  --fragment            Specifies whether the input peaks will be subject to
                        high levels of fragmentation
  --duphandling DUPHANDLING
                        Specifies how to handle entries that are ranked
                        equally within a replicate Can either take the
                        'average' ranks or a 'random' rearrangement of the
                        ordinal ranks Options: 'average', 'random' Default:
                        'average'
  --seed RANDOM_SEED    Specify a seed to be used in conjunction with the
                        'random' option for -duphandling Must be between 0 and
                        1 Default: 0.5
  -a ALPHA, --alpha ALPHA
                        Alpha specifies the user cut-off value for set of
                        reproducible peaks The analysis will still produce
                        results including peaks within the threshold
                        calculatedusing the binomial method Default: 0.05
  -s SIZE, --size SIZE  Sets the default minimum peak size when peaks are
                        reconnected after fragmentation. Usually the minimum
                        peak size is determined by the size of surrounding
                        peaks, but in the case that there are no surrounding
                        peaks this value will be used Default: 20
```


## chip-r_ChIP-R

### Tool Description
Combine multiple ChIP-seq files and return a union of all peak locations and a set confident, reproducible peaks as determined by rank product analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/chip-r:1.2.0--pyh3252c3a_0
- **Homepage**: https://github.com/rhysnewell/ChIP-R
- **Package**: https://anaconda.org/channels/bioconda/packages/chip-r/overview
- **Validation**: PASS

### Original Help Text
```text
usage: chipr [-h] -i INPUT [INPUT ...] [-o OUTPUT] [-m MINENTRIES]
             [--rankmethod RANKMETHOD] [--fragment]
             [--duphandling DUPHANDLING] [--seed RANDOM_SEED] [-a ALPHA]
             [-s SIZE]

Combine multiple ChIP-seq files and return a union of all peak locations and a
set confident, reproducible peaks as determined by rank product analysis

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        ChIP-seq input files. These files must be in either
                        narrowPeak, broadPeak, or regionPeak format. Multiple
                        inputs are separeted by a single space
  -o OUTPUT, --output OUTPUT
                        ChIP-seq output filename prefix
  -m MINENTRIES, --minentries MINENTRIES
                        The minimum peaks between replicates required to form
                        an intersection of the peaks Default: 1
  --rankmethod RANKMETHOD
                        The ranking method used to rank peaks within
                        replicates. Options: 'signalvalue', 'pvalue',
                        'qvalue'. Default: pvalue
  --fragment            Specifies whether the input peaks will be subject to
                        high levels of fragmentation
  --duphandling DUPHANDLING
                        Specifies how to handle entries that are ranked
                        equally within a replicate Can either take the
                        'average' ranks or a 'random' rearrangement of the
                        ordinal ranks Options: 'average', 'random' Default:
                        'average'
  --seed RANDOM_SEED    Specify a seed to be used in conjunction with the
                        'random' option for -duphandling Must be between 0 and
                        1 Default: 0.5
  -a ALPHA, --alpha ALPHA
                        Alpha specifies the user cut-off value for set of
                        reproducible peaks The analysis will still produce
                        results including peaks within the threshold
                        calculatedusing the binomial method Default: 0.05
  -s SIZE, --size SIZE  Sets the default minimum peak size when peaks are
                        reconnected after fragmentation. Usually the minimum
                        peak size is determined by the size of surrounding
                        peaks, but in the case that there are no surrounding
                        peaks this value will be used Default: 20
```


## Metadata
- **Skill**: generated
