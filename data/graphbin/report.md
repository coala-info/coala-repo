# graphbin CWL Generation Report

## graphbin

### Tool Description
Refined Binning of Metagenomic Contigs using Assembly Graphs

### Metadata
- **Docker Image**: quay.io/biocontainers/graphbin:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/Vini2/GraphBin
- **Package**: https://anaconda.org/channels/bioconda/packages/graphbin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/graphbin/overview
- **Total Downloads**: 7.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Vini2/GraphBin
- **Stars**: N/A
### Original Help Text
```text
Usage: graphbin [OPTIONS]

  GraphBin: Refined Binning of Metagenomic Contigs using Assembly Graphs

Options:
  --assembler [spades|sga|megahit|flye|canu|miniasm]
                                  name of the assembler used (SPAdes, SGA or
                                  MEGAHIT). GraphBin supports Flye, Canu and
                                  Miniasm long-read assemblies as well.
                                  [required]
  --graph PATH                    path to the assembly graph file  [required]
  --contigs PATH                  path to the contigs file  [required]
  --paths PATH                    path to the contigs.paths (metaSPAdes) or
                                  assembly.info (metaFlye) file
  --binned PATH                   path to the .csv file with the initial
                                  binning output from an existing tool
                                  [required]
  --output PATH                   path to the output folder  [required]
  --prefix TEXT                   prefix for the output file
  --max_iteration INTEGER         maximum number of iterations for label
                                  propagation algorithm  [default: 100]
  --diff_threshold FLOAT RANGE    difference threshold for label propagation
                                  algorithm  [default: 0.1; 0<=x<=1]
  --delimiter [,|;|$'\t'|" "]     delimiter for input/output results. Supports
                                  a comma (,), a semicolon (;), a tab ($'\t'),
                                  a space (" ") and a pipe (|)  [default: ,]
  -v, --version                   Show the version and exit.
  --help                          Show this message and exit.
```

