# cryptkeeper CWL Generation Report

## cryptkeeper

### Tool Description
Pipeline for predicting cryptic gene expression

### Metadata
- **Docker Image**: quay.io/biocontainers/cryptkeeper:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/barricklab/cryptkeeper
- **Package**: https://anaconda.org/channels/bioconda/packages/cryptkeeper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cryptkeeper/overview
- **Total Downloads**: 268
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/barricklab/cryptkeeper
- **Stars**: N/A
### Original Help Text
```text
usage: cryptkeeper [-h] -i I [-c] -o O [-j J] [-p] [-n NAME]
                   [--rbs-score-cutoff RBS_SCORE_CUTOFF] [-t TICK_FREQUENCY]
                   [--no-vis] [--show-small]

Pipeline for predicting cryptic gene expression

options:
  -h, --help            show this help message and exit
  -i I, --input I       input fasta file
  -c, --circular        The input file is circular. (Note: Increases runtime)
  -o O, --output O      output file prefix
  -j J, -threads J      Number of threads/processes to use
  -p, --plot-only       plot mode, assumes output files all exist
  -n NAME, --name NAME  name of sample (if not provided the filename is used)
  --rbs-score-cutoff RBS_SCORE_CUTOFF
                        Minimum score that is graphed and output to final
                        files (all are used in calculating burden)
  -t TICK_FREQUENCY     Y axis tick frequency (default 1000)
  --no-vis              Skip visualization
  --show-small          Show small ORFs on visualization
```

