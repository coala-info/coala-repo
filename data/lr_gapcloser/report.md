# lr_gapcloser CWL Generation Report

## lr_gapcloser_LR_Gapcloser.sh

### Tool Description
Close gaps in scaffolds using long reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/lr_gapcloser:1.0--pl5321hdfd78af_0
- **Homepage**: https://github.com/CAFS-bioinformatics/LR_Gapcloser
- **Package**: https://anaconda.org/channels/bioconda/packages/lr_gapcloser/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lr_gapcloser/overview
- **Total Downloads**: 62
- **Last updated**: 2025-11-24
- **GitHub**: https://github.com/CAFS-bioinformatics/LR_Gapcloser
- **Stars**: N/A
### Original Help Text
```text
Usage:sh LR_Gapcloser.sh -i Scaffold_file -l Corrected-PacBio-read_file
  -i    the scaffold file that contains gaps, represented by a string of N          [         required ]
  -l    the raw and error-corrected long reads used to close gaps. The file should                      
        be fasta format.                                                               [         required ]
  -s    sequencing platform: pacbio [p] or nanopore [n]                             [ default:       p ]
  -t    number of threads (for machines with multiple processors), used in the bwa                      
        mem alignment processes and the following coverage filteration.             [ default:       5 ]
  -c    the coverage threshold to select high-quality alignments                    [ default:     0.8 ]
  -a    the deviation between gap length and filled sequence length                 [ default:     0.2 ]
  -m    to select the reliable tags for gap-closure, the maximal allowed                                
        distance from alignment region to gap boundary (bp)                         [ default:     600 ]
  -n    the number of files that all tags were divided into                         [ default:       5 ]
  -g    the length of tags that a long read would be divided into (bp)              [ default:     300 ]
  -v    the minimal tag alignment length around each boundary of a gap (bp)         [ default:     300 ]
  -r    number of iteration                                                         [ default:       3 ]
  -o    name of output directory                                                    [ default: ./Output]
```

