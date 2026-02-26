# muset CWL Generation Report

## muset

### Tool Description
a pipeline for building an abundance unitig matrix from a list of FASTA/FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/muset:0.5.1--h22625ea_0
- **Homepage**: https://github.com/CamilaDuitama/muset
- **Package**: https://anaconda.org/channels/bioconda/packages/muset/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/muset/overview
- **Total Downloads**: 224
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CamilaDuitama/muset
- **Stars**: N/A
### Original Help Text
```text
muset v0.5.1

DESCRIPTION
  a pipeline for building an abundance unitig matrix from a list of FASTA/FASTQ files.

USAGE
  muset [--file <FILE>] [-i/--in-matrix <FILE>] [-o/--out-dir <DIR>] [-k/--kmer-size <INT>] 
        [-m/--mini-size <INT>] [-a/--min-abundance <INT>] [-l/--min-unitig-length <INT>] 
        [-r/--min-utg-frac <FLOAT>] [-f/--min-frac-absent <FLOAT>] 
        [-F/--min-frac-present <FLOAT>] [-n/--min-nb-absent <FLOAT>] 
        [-N/--min-nb-present <FLOAT>] [-t/--threads <INT>] [-s/--write-seq] [--out-frac] 
        [-u/--logan] [--keep-temp] [-h/--help] [-v/--version] 

OPTIONS
  [main options]
       --file              - kmtricks-like input file, see README.md. 
    -i --in-matrix         - input matrix (text file or kmtricks directory). 
    -o --out-dir           - output directory. {output}
    -k --kmer-size         - k-mer size. [8, 63]. {31}
    -m --mini-size         - minimizer size. [4, 15]. {15}
    -a --min-abundance     - minimum abundance to keep a k-mer. {2}
    -l --min-unitig-length - minimum unitig length. {2k-1}
    -r --min-utg-frac      - minimum k-mer fraction to set unitig average abundance [0,1]. {0.0}
    -s --write-seq         - write the unitig sequence instead of the identifier in the output matrix [⚑]
       --out-frac          - output an additional matrix containing k-mer fractions. [⚑]
    -u --logan             - input samples consist of Logan unitigs (i.e., with abundance). [⚑]

  [filtering options]
    -f --min-frac-absent  - fraction of samples from which a k-mer should be absent. [0.0, 1.0] {0.1}
    -F --min-frac-present - fraction of samples in which a k-mer should be present. [0.0, 1.0] {0.1}
    -n --min-nb-absent    - minimum number of samples from which a k-mer should be absent (overrides -f). {0}
    -N --min-nb-present   - minimum number of samples in which a k-mer should be present (overrides -F). {0}

  [other options]
       --keep-temp - keep temporary files. [⚑]
    -t --threads   - number of threads. {4}
    -h --help      - show this message and exit. [⚑]
    -v --version   - show version and exit. [⚑]
```

