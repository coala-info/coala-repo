# graphbin2 CWL Generation Report

## graphbin2

### Tool Description
Refined and Overlapped Binning of Metagenomic Contigs Using Assembly Graphs GraphBin2 is a tool which refines the binning results obtained from existing tools and, is able to assign contigs to multiple bins. GraphBin2 uses the connectivity and coverage information from assembly graphs to adjust existing binning results on contigs and to infer contigs shared by multiple species.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphbin2:1.3.3--pyh7e72e81_0
- **Homepage**: https://github.com/metagentools/GraphBin2
- **Package**: https://anaconda.org/channels/bioconda/packages/graphbin2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/graphbin2/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/metagentools/GraphBin2
- **Stars**: N/A
### Original Help Text
```text
Usage: graphbin2 [OPTIONS]

  GraphBin2: Refined and Overlapped Binning of Metagenomic Contigs Using
  Assembly Graphs GraphBin2 is a tool which refines the binning results
  obtained from existing tools and, is able to assign contigs to multiple
  bins. GraphBin2 uses the connectivity and coverage information from assembly
  graphs to adjust existing binning results on contigs and to infer contigs
  shared by multiple species.

Options:
  --assembler [spades|megahit|sga|flye]
                                  name of the assembler used. (Supports
                                  SPAdes, SGA, MEGAHIT and Flye)  [required]
  --graph PATH                    path to the assembly graph file  [required]
  --contigs PATH                  path to the contigs file  [required]
  --paths PATH                    path to the contigs.paths (metaSPAdes) or
                                  assembly.info (metaFlye) file
  --abundance PATH                path to the abundance file  [required]
  --binned PATH                   path to the .csv file with the initial
                                  binning output from an existing toole
                                  [required]
  --output PATH                   path to the output folder  [required]
  --prefix TEXT                   prefix for the output file
  --depth INTEGER                 maximum depth for the breadth-first-search.
                                  [default: 5]
  --threshold FLOAT               threshold for determining inconsistent
                                  vertices.  [default: 1.5]
  --delimiter [,|;|$'\t'|" "]     delimiter for output results. Supports a
                                  comma (,), a semicolon (;), a tab ($'\t'), a
                                  space (" ") and a pipe (|) .  [default: ,]
  --nthreads INTEGER              number of threads to use.  [default: 8]
  -v, --version                   Show the version and exit.
  --help                          Show this message and exit.
```

