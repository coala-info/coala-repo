# amap CWL Generation Report

## amap

### Tool Description
Align multiple protein sequences and print to standard output using sequence annealing alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/amap:2.2--h6bb024c_0
- **Homepage**: https://web.archive.org/web/20060902044446/http://bio.math.berkeley.edu/amap/
- **Package**: https://anaconda.org/channels/bioconda/packages/amap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amap/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mes5k/amap-align
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

AMAP version AMAP.2.2 - align multiple protein sequences and print to standard output
PROBCONS Written by Chuong Do
AMAP algorithm implemented by Ariel Schwartz

AMAP comes with ABSOLUTELY NO WARRANTY.  This is free software, and
you are welcome to redistribute it under certain conditions.  See the
files README and README.PROBCONS for details.

Usage:
       amap [OPTION]... [MFAFILE]...

Description:
       Align sequences in MFAFILE(s) and print result to standard output

       -clustalw
              use CLUSTALW output format instead of MFA

       -c, --consistency REPS
              use 0 <= REPS <= 5 (default: 0) passes of consistency transformation

       -ir, --iterative-refinement REPS
              use 0 <= REPS <= 1000 (default: 0) passes of iterative-refinement

       -pre, --pre-training REPS
              use 0 <= REPS <= 20 (default: 0) rounds of pretraining

       -pairs
              generate all-pairs pairwise alignments

       -viterbi
              use Viterbi algorithm to generate all pairs (automatically enables -pairs)

       -v, --verbose
              report progress while aligning (default: off)

       -annot FILENAME
              write annotation for multiple alignment to FILENAME

       -t, --train FILENAME
              compute EM transition probabilities, store in FILENAME (default: no training)

       -e, --emissions
              also reestimate emission probabilities (default: off)

       -p, --paramfile FILENAME
              read parameters from FILENAME (default: )

       -a, --alignment-order
              print sequences in alignment order rather than input order (default: off)

       -g, --gap-factor GF
              use GF as the gap-factor parameter, set to 0 for best sensitivity, higher values for better specificity (default: 1)

       -w, --edge-weight-threshold W
              stop the sequence annealing process when best edge has lower weight than W,
              set to 0 for best sensitivity, higher values for better specificity (default: 0)

       -prog, --progressive
              use progresive alignment instead of sequence annealing alignment (default: off)

       -noreorder, --no-edge-reordering
              disable reordring of edges during sequence annealing alignment (default: off)

       -maxstep, --use-max-stepsize
              use maximum improvement step size instead of tGf edge ranking (default: off)

       -print, --print-posteriors
              only print the posterior probability matrices (default: off)

       -gui [START] [STEP]
              print output for the AMAP Display Java based GUI (default: off) 
              starting at weight START (default: infinity) with step size STEP (default: 1)
```


## Metadata
- **Skill**: generated
