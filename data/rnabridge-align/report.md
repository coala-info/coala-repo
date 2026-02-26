# rnabridge-align CWL Generation Report

## rnabridge-align

### Tool Description
Aligns RNA sequencing reads to a reference genome, identifying bridging reads to infer structural variations.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnabridge-align:1.0.1--h5ca1c30_9
- **Homepage**: https://github.com/Shao-Group/rnabridge-align
- **Package**: https://anaconda.org/channels/bioconda/packages/rnabridge-align/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnabridge-align/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-09-30
- **GitHub**: https://github.com/Shao-Group/rnabridge-align
- **Stars**: N/A
### Original Help Text
```text
rnabridge-align v1.0.1 (c) 2020 Mingfu Shao, The Pennsylvania State University

Usage: rnabridge-align -i <input-bam-file> -o <output-bam-file> [-r <refernece>] [options]

Options:
 --help                                      print usage of rnabridge-align and exit
 --version                                   print current version of rnabridge-align and exit
 --preview                                   determine fragment-length-range and library-type and exit
 --library_type <first, second, unstranded>  library type of the sample, default: unstranded
 --min_bridging_score <double>               the minimized bottleneck weight in bridging path, default: 0.5
 --dp_solution_size <integer>                candidate number of bridgign paths, default: 10
 --dp_stack_size <integer>                   number of weights maintained for each bridging path, default: 5
 --max_clustring_flank <integer>             maximized basepair difference for being in an equivalent class, default: 30
 --flank_tiny_length <integer>               maximized length for reconsidering error correction, default:  10
 --flank_tiny_ratio <integer>                maximized ratio for reconsidering error correction, default:  0.4
 --min_splice_bundary_hits <integer>         minimum number of spliced reads required for a junction, default: 1
 --max_num_cigar <integer>                   ignore reads with CIGAR size larger than this value, default: 1000
```

