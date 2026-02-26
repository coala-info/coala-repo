# coral CWL Generation Report

## coral

### Tool Description
Coral v1.0.0 (c) 2019 Mingfu Shao, The Pennsylvania State University

### Metadata
- **Docker Image**: quay.io/biocontainers/coral:1.0.0--hf5e1fbb_1
- **Homepage**: https://github.com/Shao-Group/coral
- **Package**: https://anaconda.org/channels/bioconda/packages/coral/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coral/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Shao-Group/coral
- **Stars**: N/A
### Original Help Text
```text
Coral v1.0.0 (c) 2019 Mingfu Shao, The Pennsylvania State University

Usage: coral -i <input-bam-file> -o <output-bam-file> [-r <refernece>] [options]

Options:
 --help                                      print usage of Coral and exit
 --version                                   print current version of Coral and exit
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

