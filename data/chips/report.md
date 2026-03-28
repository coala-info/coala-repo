# chips CWL Generation Report

## chips_simreads

### Tool Description
Simulate ChIP-seq reads for a set of peaks.

### Metadata
- **Docker Image**: quay.io/biocontainers/chips:2.4--h43eeafb_7
- **Homepage**: https://github.com/gymreklab/chips
- **Package**: https://anaconda.org/channels/bioconda/packages/chips/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chips/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gymreklab/chips
- **Stars**: N/A
### Original Help Text
```text
*****ERROR: Unrecognized parameter: -help *****

****** ERROR: Must specify peaks with -p unless using -t wce ******
****** ERROR: Must specify reffa with -f ******
****** ERROR: Must specify outprefix with -o ******
****** ERROR: Must specify peakfiletype with -t ******

Tool:    chips simreads
Version: 2.4
Summary: Simulate ChIP-seq reads for a set of peaks.

Usage:   chips simreads -p peaks.bed -f ref.fa -o outprefix [OPTIONS] 

[Required arguments]: 
     -p <peaks.bed>: BED file with peak regions
     -t <str>: The file format of your input peak file. Only `homer` or `bed` are supported. You can use -t wce with no BED file to simulate whole cell extract control data.
     -f <ref.fa>: FASTA file with reference genome
     -o <outprefix>: Prefix for output files

[Experiment parameters]: 
     --numcopies <int>: Number of copies of the genome to simulate
                        Default: 100
     --numreads <int> : Number of reads (or read pairs) to simulate
                        Default: 1000000
     --readlen <int>  : Read length to generate
                        Default: 36
     --paired         : Simulate paired-end reads
                        Default: false 

[Model parameters]: 
     --model <str>               : JSON file with model parameters (e.g. from running learn
                                   Setting parameters below overrides anything in the JSON file
     --gamma-frag <float>,<float>: Parameters for fragment length distribution (alpha, beta).
                                   Default: 15.67,15.49
     --spot <float>              : SPOT score (fraction of reads in peaks) 
                                   Default: 0.17594
     --frac <float>              : Fraction of the genome that is bound 
                                   Default: 0.03713
     --recomputeF                : Recompute --frac param based on input peaks.
     --pcr_rate <float>          : The rate of geometric distribution for PCR simulation
                                   Default: 1

[Peak scoring: choose one]: 
     -b <reads.bam>              : Read BAM file used to score each peak
                                 : Default: None (use the scores from the peak file)
     -c <int>                    : The index of the BED file column used to score each peak (index starting from 1). Required if -b not used.
                                 : Default: -1
     --noscale                   : Don't scale peak scores by the max score.
     --scale-outliers            : Set all peaks with scores >2*median score to have binding prob 1. Recommended with real peak files

[Other options]: 
     --seed <unsigned>           : the seed for initiating randomization opertions
                                   Default or 0: current time 
     --region <str>              : Only simulate reads from this region chrom:start-end
                                   Default: genome-wide 
     --binsize <int>             : Consider bins of this size when simulating
                                 : Default: 100000
     --thread <int>              : Number of threads used for computing
                                 : Default: 1
     --sequencer <std>           : Sequencing error values
                                 : Default: None (no sequencing errors)
     --sub <float>               : Customized substitution value in sequecing
     --ins <float>               : Customized insertion value in sequecing
     --del <float>               : Customized deletion value in sequecing

[ General help ]:
    --help        Print this help menu.
```


## chips_learn

### Tool Description
Learn parameters from a ChIP dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/chips:2.4--h43eeafb_7
- **Homepage**: https://github.com/gymreklab/chips
- **Package**: https://anaconda.org/channels/bioconda/packages/chips/overview
- **Validation**: PASS

### Original Help Text
```text
******ERROR: Unrecognized parameter: -help ******

****** ERROR: Must specify peaks file with -p ******
****** ERROR: Must specify outprefix with -o ******
****** ERROR: Must specify peakfiletype with -t ******
****** ERROR: Must specify a bam file with -b ******

Tool:    chips learn
Version: 2.4
Summary: Learn parameters from a ChIP dataset.

Usage:   chips learn -b reads.bam -p peak.bed -o outprefix [OPTIONS] 

[Required arguments]: 
         -b <reads.bam>:     BAM file with ChIP reads (.bai index required)
         -p <peaks.bed>:     BED file with peak regions (Homer format or BED format)
         -t <peakfile_type>: File type of the input peak file. Only `homer` or `bed` supported.
         -o <outprefix>:     Prefix for output files
         -c <int>:           The index of the BED file column used to score each peak (index starting from 1)
[Optional arguments]: 
         -r <float>:         Ratio of high score peaks to ignore
                             Default: 0
         --noscale:          Don't scale peak scores by the max score.
                             Default: false
         --scale-outliers:   Set all peaks with scores >2*median score to have binding prob 1. Recommended with real data.
                             Default: false
         --region <str>:     Only consider peaks from this region chrom:start-end
                             Default: genome-wide 
[BAM-file arguments]: 
         --paired:           Loading paired-end reads
                             Default: false
[Fragment length estimation arguments]: 
 (only relevant for single-end data) 
         --est <int>:        The estimated fragment length. Please set this number as the loose upper-bound of your estimated fragment length.
                             This can result in more robust estimates especially for data with narrow peaks.
                             Default: 300
         --thres <float>:    Absolute threshold for peak scores. Only consider peaks with at least this score.
                             ChIPs applies `--thres` or `--thres-scale` whichever is stricter.
                             Default: 100
         --thres-scale <float>: Scale threshold for peak scores. Only consider peaks with at least this score.
                                after scaling scores to be between 0-1.
                                ChIPs applies `--thres` or `--thres-scale` whichever is stricter.
                                Default: 0

[ General help ]:
    --help        Print this help menu.
```


## Metadata
- **Skill**: generated
