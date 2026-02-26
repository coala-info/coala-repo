# dipper CWL Generation Report

## dipper_dipper_cpu

### Tool Description
DIPPER Command Line Arguments

### Metadata
- **Docker Image**: quay.io/biocontainers/dipper:0.1.3--h6bb9b41_0
- **Homepage**: https://github.com/TurakhiaLab/DIPPER
- **Package**: https://anaconda.org/channels/bioconda/packages/dipper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dipper/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2026-01-24
- **GitHub**: https://github.com/TurakhiaLab/DIPPER
- **Stars**: N/A
### Original Help Text
```text
[31mthe option '--input-file' is required but missing[0m
DIPPER Command Line Arguments:

Required Options:
  -i [ --input-format ] arg   Input format:
                                d - distance matrix in PHYLIP format
                                r - unaligned sequences in FASTA format
                                m - aligned sequences in FASTA format
  -I [ --input-file ] arg     Input file path:
                                PHYLIP format for distance matrix
                                FASTA format for aligned or unaligned sequences
  -O [ --output-file ] arg    Output file path

Optional Options:
  -o [ --output-format ] arg  Output format:
                                t - phylogenetic tree in Newick format 
                              (default)
                                d - distance matrix in PHYLIP format (coming 
                              soon)
  -m [ --algorithm ] arg      Algorithm selection:
                                0 - default mode
                                1 - force placement
                                2 - force conventional NJ
                                3 - force divide-and-conquer
  -K [ --K-closest ] arg      Placement mode:
                                -1 - exact mode
                                10 - default
  -k [ --kmer-size ] arg      K-mer size:
                                Valid range: 2-15 (default: 15)
  -s [ --sketch-size ] arg    Sketch size (default: 1000)
  -d [ --distance-type ] arg  Distance type to calculate:
                                1 - uncorrected
                                2 - JC (default)
                                3 - Tajima-Nei
                                4 - K2P
                                5 - Tamura
                                6 - Jinnei
  -a [ --add ]                Add query to backbone using k-closest placement
  -t [ --input-tree ] arg     Input backbone tree (Newick format), required 
                              with --add option
  -T [ --threads ] arg        Number of CPU threads. Default: all available 
                              threads.
  --no-shuffle                Disable random shuffling to ensure deterministic 
                              and reproducible results.
  -h [ --help ]               Print this help message
  -v [ --version ]            Print DIPPER version
```

