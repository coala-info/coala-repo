# ale CWL Generation Report

## ale_ALE

### Tool Description
Assembly Likelihood Estimator for evaluating genome assemblies using read alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/ale:20180904--py27ha92aebf_0
- **Homepage**: https://github.com/sc932/ALE
- **Package**: https://anaconda.org/channels/bioconda/packages/ale/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ale/overview
- **Total Downloads**: 11.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sc932/ALE
- **Stars**: N/A
### Original Help Text
```text
Welcome to the Assembly Likelihood Estimator!
(C) 2010 Scott Clark

Usage: ALE [-options] alignments.[s|b]am assembly.fasta[.gz] ALEoutput.txt

Options: <i>nt <f>loat <s>tring [default]
-h or --help    : print out this help
--kmer <f>      : Kmer depth for kmer stats [4]
--qOff <i>      : Quality ascii offset (illumina) [33] or 64 (or 0)
--pl <s>        : placementOutputBAM
--pm <s>        : library parameter file (auto outputs .param)
--nout          : only output meta information (no per base) [off]
--minLL         : the minimum log Likelihood (-120)
--metagenome    : Evaluate each contig independently for depth & kmer metrics
--realign[=matchScore,misMatchPenalty,gapOpenPenalty,gapExtPenalty,minimumSoftClip (default: 1,3,11,4,8) ]
                   Realign reads with Striped-Smith-Waterman honoring ambiguous reference bases
                   and stacking homo-polymer indels
                   for PacBio, try --realign=1,5,2,1,20 (similar to BWA-SW recommendations)
--SNPreport <s> : Creates a new text file reporting all SNP phasing 
                   observed by a read against ambiguous bases in the reference
--minQual <i>   : Minimum quality score to use in Z-normalization (default 3).
                   Illumina quality scores can be unreliable below this threshold
```


## ale_ale2wiggle.py

### Tool Description
Converts ALE (Assembly Likelihood Evaluation) output files to Wiggle format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ale:20180904--py27ha92aebf_0
- **Homepage**: https://github.com/sc932/ALE
- **Package**: https://anaconda.org/channels/bioconda/packages/ale/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/ale2wiggle.py", line 85, in <module>
    sys.exit(main(sys.argv))
  File "/usr/local/bin/ale2wiggle.py", line 80, in main
    convertToWiggle(argv[1])
IndexError: list index out of range
```


## Metadata
- **Skill**: generated
