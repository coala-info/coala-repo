# scallop CWL Generation Report

## scallop

### Tool Description
Scallop v0.10.5 (c) 2017 Mingfu Shao, Carl Kingsford, and Carnegie Mellon University

### Metadata
- **Docker Image**: quay.io/biocontainers/scallop:0.10.5--hea69786_9
- **Homepage**: https://github.com/Kingsford-Group/scallop
- **Package**: https://anaconda.org/channels/bioconda/packages/scallop/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scallop/overview
- **Total Downloads**: 16.7K
- **Last updated**: 2025-10-02
- **GitHub**: https://github.com/Kingsford-Group/scallop
- **Stars**: N/A
### Original Help Text
```text
Scallop v0.10.5 (c) 2017 Mingfu Shao, Carl Kingsford, and Carnegie Mellon University

Usage: scallop -i <bam-file> -o <gtf-file> [options]

Options:
 --help                                      print usage of Scallop and exit
 --version                                   print current version of Scallop and exit
 --verbose <0, 1, 2>                         0: quiet; 1: one line for each graph; 2: with details, default: 1
 --library_type <first, second, unstranded>  library type of the sample, default: unstranded
 --min_transcript_coverage <float>           minimum coverage required for a multi-exon transcript, default: 1.01
 --min_single_exon_coverage <float>          minimum coverage required for a single-exon transcript, default: 20
 --min_transcript_length_increase <integer>  default: 50
 --min_transcript_length_base <integer>      default: 150, minimum length of a transcript would be
                                             --min_transcript_length_base + --min_transcript_length_increase * num-of-exons
 --min_mapping_quality <integer>             ignore reads with mapping quality less than this value, default: 1
 --max_num_cigar <integer>                   ignore reads with CIGAR size larger than this value, default: 7
 --min_bundle_gap <integer>                  minimum distances required to start a new bundle, default: 50
 --min_num_hits_in_bundle <integer>          minimum number of reads required in a bundle, default: 20
 --min_flank_length <integer>                minimum match length in each side for a spliced read, default: 3
 --min_splice_bundary_hits <integer>         minimum number of spliced reads required for a junction, default: 1

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

