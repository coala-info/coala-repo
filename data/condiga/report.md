# condiga CWL Generation Report

## condiga

### Tool Description
ConDiGA: Contigs directed gene annotation for accurate protein sequence database construction in metaproteomics.

### Metadata
- **Docker Image**: quay.io/biocontainers/condiga:0.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/metagentools/ConDiGA
- **Package**: https://anaconda.org/channels/bioconda/packages/condiga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/condiga/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/metagentools/ConDiGA
- **Stars**: N/A
### Original Help Text
```text
Usage: condiga [OPTIONS]

  ConDiGA: Contigs directed gene annotation for accurate protein sequence
  database construction in metaproteomics.

Options:
  -c, --contigs PATH              path to the contigs file  [required]
  -ta, --taxa PATH                path to the taxanomic classification results
                                  file  [required]
  -g, --genes PATH                path to the genes file  [required]
  -cov, --coverages PATH          path to the contig coverages file
                                  [required]
  -as, --assembly-summary PATH    path to the assembly_summary.txt file
                                  [required]
  -ra, --rel-abundance FLOAT RANGE
                                  minimum relative abundance cut-off
                                  [default: 0.0001; 0<=x<=1]
  -gc, --genome-coverage FLOAT RANGE
                                  minimum genome coverage cut-off  [default:
                                  0.001; 0<=x<=1]
  -mt, --map-threshold FLOAT RANGE
                                  minimum mapping length threshold cut-off
                                  [default: 0.5; 0<=x<=1]
  -t, --nthreads INTEGER          number of threads to use  [default: 8]
  -o, --output PATH               path to the output folder  [required]
  -v, --version                   Show the version and exit.
  --help                          Show this message and exit.
```

