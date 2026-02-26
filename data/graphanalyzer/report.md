# graphanalyzer CWL Generation Report

## graphanalyzer_graphanalyzer.py

### Tool Description
This script automatically parse vConTACT2 outputs when using INPHARED as database.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphanalyzer:1.6.0--hdfd78af_0
- **Homepage**: https://github.com/lazzarigioele/graphanalyzer
- **Package**: https://anaconda.org/channels/bioconda/packages/graphanalyzer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/graphanalyzer/overview
- **Total Downloads**: 12.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lazzarigioele/graphanalyzer
- **Stars**: N/A
### Original Help Text
```text
usage: graphanalyzer.py --graph FILEPATH --csv FILEPATH --metas FILEPATH
                        [-o PATH] [-p STRING] [-s STRING] [-t INT]
                        [-l FILEPATH] [-w STRING] [-v] [-h]

This script automatically parse vConTACT2 outputs when using INPHARED as
database.

Required named arguments:
  --graph FILEPATH      The c1.ntw output file from vConTACT2.
  --csv FILEPATH        The genome_by_genome_overview.csv output file from
                        vConTACT2.
  --metas FILEPATH      The data_excluding_refseq.tsv file from INPHARED.

Optional named arguments:
  -o PATH, --output PATH
                        Path to the output directory (default: "./").
  -p STRING, --prefix STRING
                        Prefix of the header of each conting representing a
                        vOTU (default: "vOTU").
  -s STRING, --suffix STRING
                        Suffix to append to every file produced in the output
                        directory (default: "assemblerX").
  -t INT, --threads INT
                        Define how many threads to use for the generation of
                        the interactive subgraphs (default: 4).
  -l FILEPATH, --pickle FILEPATH
                        Filepath to the pickle object, needed to enter
                        directly to the interactive plots generation step
                        (default: None).
  -w STRING, --view STRING
                        Whether to produce interactive subgraphs in 2 ('2d')
                        or 3 dimensions ('3d') (default: '2d').

Conventional arguments:
  -v, --version         Show program's version number and exit.
  -h, --help            Show this help message and exit.
```

