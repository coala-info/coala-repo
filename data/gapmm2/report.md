# gapmm2 CWL Generation Report

## gapmm2

### Tool Description
gapped alignment with minimap2. Performs minimap2/mappy alignment with splice options and refines terminal alignments with edlib.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapmm2:25.8.12--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/gapmm2
- **Package**: https://anaconda.org/channels/bioconda/packages/gapmm2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gapmm2/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-08-18
- **GitHub**: https://github.com/nextgenusfs/gapmm2
- **Stars**: N/A
### Original Help Text
```text
tput: No value for $TERM and no -T specified
usage: gapmm2 [-o] [-f] [-t] [-m] [-i] [-d] [-n] [-h] [--version]
              reference query

[1mgapmm2: gapped alignment with minimap2.[0m Performs minimap2/mappy
alignment with splice options and refines terminal alignments with edlib.

Positional arguments:
  reference           reference genome (FASTA)
  query               transcipts in FASTA or FASTQ

Optional arguments:
  -o , --out          output in PAF format (default: stdout)
  -f , --out-format   output format [paf,gff3] (default: paf)
  -t , --threads      number of threads to use with minimap2 (default: 3)
  -m , --min-mapq     minimum map quality value (default: 1)
  -i , --max-intron   max intron length, controls terminal search space
                      (default: 500)
  -d, --debug         write some debug info to stderr (default: False)
  -n, --no-refine     do not refine mappy alignment with edlib (default: True)

Help:
  -h, --help          Show this help message and exit
  --version           Show program's version number and exit
```

