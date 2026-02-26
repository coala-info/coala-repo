# prosampler CWL Generation Report

## prosampler_ProSampler

### Tool Description
ProSampler is a tool for motif discovery in DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/prosampler:1.5--h9948957_2
- **Homepage**: https://github.com/zhengchangsulab/ProSampler
- **Package**: https://anaconda.org/channels/bioconda/packages/prosampler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prosampler/overview
- **Total Downloads**: 11.5K
- **Last updated**: 2025-08-06
- **GitHub**: https://github.com/zhengchangsulab/ProSampler
- **Stars**: N/A
### Original Help Text
```text
Error: The number of input parameters is wrong. Please check the input parameters again.

=================================================================================================================================================================
Usage: ./ProSampler [options]

Parameters:
-i: Name of the input file in FASTA format
-b: Name of the background file in FASTA format or order of the Markov model to generate background sequences (default: 3; 3rd order Markov model)
-d: The cutoff of Hamming Distance between any two k-mers in a PWM (default: 1)
-o: Prefix of the names of output files
-m: Number of motifs to be output (default: All)
-f: Number of cycles of Gibbs Sampling to find  each preliminary motif (default: 100)
-k: Length of preliminary motifs (default: 9)
-l: Length of the flanking l-mers (default: 6)
-c: Cutoff of Hamming distance to merge similar k-mers (default: 1)
-r: Cutoff of Hamming distance to delete redundant motifs basedn on consensus (default: 1)
-p: Number(1 or 2) of strands to be considered(default: 2)
-t: Cutoff of z-value to choose significant k-mers (default: 8.00)
-w: Cutoff of z-value to choose sub-significant k-mers (default: 4.50)
-z: Cutoff of z-value to extend preliniary motifs(default: 1.96)
-s: Cutoff of SW score to construct graph (default: 1.80)
-h: Print this message (default: 0)
=================================================================================================================================================================
```

