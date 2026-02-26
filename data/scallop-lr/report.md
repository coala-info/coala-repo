# scallop-lr CWL Generation Report

## scallop-lr

### Tool Description
Scallop-LR v0.9.2 (c) 2018 Mingfu Shao, Carl Kingsford, and Carnegie Mellon University

### Metadata
- **Docker Image**: quay.io/biocontainers/scallop-lr:0.9.2--h503566f_10
- **Homepage**: https://github.com/Kingsford-Group/lrassemblyanalysis
- **Package**: https://anaconda.org/channels/bioconda/packages/scallop-lr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scallop-lr/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Kingsford-Group/lrassemblyanalysis
- **Stars**: N/A
### Original Help Text
```text
Scallop-LR v0.9.2 (c) 2018 Mingfu Shao, Carl Kingsford, and Carnegie Mellon University

Usage: scallop-lr -i <bam-file> -o <gtf-file> -c <ccs-header-file> [options]

Options:
 --help                                      print usage of Scallop and exit
 --version                                   print current version of Scallop and exit
 --verbose <0, 1, 2>                         0: quiet; 1: one line for each graph; 2: with details, default: 1
 --library_type <first, second, unstranded>  library type of the sample, default: unstranded
 --min_transcript_coverage <float>           minimum coverage required for a multi-exon transcript, default: 1.01
 --min_single_exon_coverage <float>          minimum coverage required for a single-exon transcript, default: 10
 --min_transcript_length_increase <integer>  default: 50
 --min_transcript_length_base <integer>      default: 100, minimum length of a transcript would be
                                             --min_transcript_length_base + --min_transcript_length_increase * num-of-exons
 --min_mapping_quality <integer>             ignore reads with mapping quality less than this value, default: 1
 --min_bundle_gap <integer>                  minimum distances required to start a new bundle, default: 50
 --min_num_hits_in_bundle <integer>          minimum number of reads required in a bundle, default: 1
 --min_splice_hits <integer>                 minimum number of spliced reads required for a junction, default: 1
 --min_boundary_hits <integer>               minimum number of reads with 5'/3' primes required for a boundary, default: 3

      ___           ___           ___                                       ___           ___    
     /  /\         /  /\         /  /\                                     /  /\         /  /\   
    /  /:/_       /  /:/        /  /::\                                   /  /::\       /  /::\  
   /  /:/ /\     /  /:/        /  /:/\:\    ___     ___   ___     ___    /  /:/\:\     /  /:/\:\ 
  /  /:/ /::\   /  /:/  ___   /  /:/~/::\  /__/\   /  /\ /__/\   /  /\  /  /:/  \:\   /  /:/~/:/ 
 /__/:/ /:/\:\ /__/:/  /  /\ /__/:/ /:/\:\ \  \:\ /  /:/ \  \:\ /  /:/ /__/:/ \__\:\ /__/:/ /:/  
 \  \:\/:/~/:/ \  \:\ /  /:/ \  \:\/:/__\/  \  \:\  /:/   \  \:\  /:/  \  \:\ /  /:/ \  \:\/:/   
  \  \::/ /:/   \  \:\  /:/   \  \::/        \  \:\/:/     \  \:\/:/    \  \:\  /:/   \  \::/    
   \__\/ /:/     \  \:\/:/     \  \:\         \  \::/       \  \::/      \  \:\/:/     \  \:\    
     /__/:/       \  \::/       \  \:\         \__\/         \__\/        \  \::/       \  \:\   
     \__\/         \__\/         \__\/                                     \__\/         \__\/
```


## Metadata
- **Skill**: generated
