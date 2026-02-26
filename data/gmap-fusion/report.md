# gmap-fusion CWL Generation Report

## gmap-fusion_GMAP-fusion

### Tool Description
GMAP-Fusion is a tool for detecting gene fusions from RNA-Seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gmap-fusion:0.4.0--hdfd78af_3
- **Homepage**: https://github.com/GMAP-fusion/GMAP-fusion
- **Package**: https://anaconda.org/channels/bioconda/packages/gmap-fusion/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gmap-fusion/overview
- **Total Downloads**: 11.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/GMAP-fusion/GMAP-fusion
- **Stars**: N/A
### Original Help Text
```text
############################################################################################################
#
#  Required:
#
#  --transcripts|T <string>        :transcript fasta file
#
#  --genome_lib_dir <string>             directory containing genome lib (see http://FusionFilter.github.io for details)
#
#  --left_fq <string>              :Illumina paired-end reads /1
#
#  --right_fq <string>             :Illumina paired-end reads /2
#
#  Optional:
#
#  --CPU <int>                     :number threads for GMAP (default 4)
#
#  --min_chim_len|L <int>            :minimum length for a chimeric alignment (default: 30)
#
#  --output|o <string>             :output directory name (default: GMAP_Fusion)
#
#   
#  --min_J|J <int>                 :minimum number of junction frags (default: 1)  
#
#  --min_sumJS|S <int>             :minimum sum (junction + spanning) frags (default: 2)
#
#  --min_novel_junction_support <int>   :minimum number of junction reads required for novel (non-reference) exon-exon junction support.
#                                        (default: 3)
#  --split_breakpoint_extend_length <int>   :in assessing breakpoint quality, the length to extend each split sequence beyond
#                                           the proposed breakpoint. (default: 25)
#
#  --max_fuzzy_overlap <int>               :maximum allowed overlap of extended length from breakpoint (default: 12)
#
#  --max_promiscuity <int>               maximum number of partners allowed for a given fusion. Default: 3
#
#  -E <float>                            E-value threshold for blast searches (default: 0.001)
#
#  --version                             report version (v0.3.0)
#
##############################################################################################################
```

