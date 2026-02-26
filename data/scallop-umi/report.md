# scallop-umi CWL Generation Report

## scallop-umi

### Tool Description
Scallop-UMI v1.1.0 (c) 2021 Qimin Zhang and Mingfu Shao, The Pennsylvania State University

### Metadata
- **Docker Image**: quay.io/biocontainers/scallop-umi:1.1.0--hbce0939_0
- **Homepage**: https://github.com/Shao-Group/scallop-umi
- **Package**: https://anaconda.org/channels/bioconda/packages/scallop-umi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scallop-umi/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Shao-Group/scallop-umi
- **Stars**: N/A
### Original Help Text
```text
Scallop-UMI v1.1.0 (c) 2021 Qimin Zhang and Mingfu Shao, The Pennsylvania State University

Usage: scallop-umi -i <bam-file> -o <gtf-file> [options]

Options:
 --help                                      print usage of Scallop and exit
 --version                                   print current version of Scallop and exit
 --preview                                   determine fragment-length-range and library-type and exit
 --verbose <0, 1, 2>                         0: quiet; 1: one line for each graph; 2: with details, default: 1
 --library_type <first, second, unstranded>  library type of the sample, default: unstranded
 --min_transcript_coverage <float>           minimum coverage required for a multi-exon transcript, default: 0.5
 --min_single_exon_coverage <float>          minimum coverage required for a single-exon transcript, default: 20
 --min_transcript_length_increase <integer>  default: 50
 --min_transcript_length_base <integer>      default: 150, minimum length of a transcript would be
                                             --min_transcript_length_base + --min_transcript_length_increase * num-of-exons
 --min_mapping_quality <integer>             ignore reads with mapping quality less than this value, default: 1
 --max_num_cigar <integer>                   ignore reads with CIGAR size larger than this value, default: 1000
 --min_bundle_gap <integer>                  minimum distances required to start a new bundle, default: 100
 --min_num_hits_in_bundle <integer>          minimum number of reads required in a bundle, default: 10
 --min_flank_length <integer>                minimum match length in each side for a spliced read, default: 3
```

