# ssu-align CWL Generation Report

## ssu-align

### Tool Description
align SSU rRNA sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/ssu-align/
- **Package**: https://anaconda.org/channels/bioconda/packages/ssu-align/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ssu-align/overview
- **Total Downloads**: 9.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# _ssu-align :: align SSU rRNA sequences
# SSU-ALIGN 0.1.1 (Feb 2016)
# Copyright (C) 2016 Howard Hughes Medical Institute
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# command: _ssu-align -h 
# date:    Wed Feb 25 12:39:58 2026
Usage: ssu-align [-options] <sequence file> <output dir>

where general options are:
  -h     : show brief help on version and usage
  -f     : force; if dir named <output dir> already exists, empty it first
  -m <f> : use CM file <f> instead of the default CM file
  -b <x> : set minimum bit score of a surviving subsequence as <x> [default: 50]
  -l <n> : set minimum length    of a surviving subsequence as <n> [default: 1]
  -i     : output alignments in interleaved Stockholm format (not 1 line/seq)
  -n <s> : only search with and align to single CM named <s> in CM file
           (default CM file includes 'archaea', 'bacteria', 'eukarya')

miscellaneous output options:
  --dna      : output alignments as DNA, default is RNA (even if input is DNA)
  --rfonly   : discard inserts, only keep consensus (nongap RF) columns in alignments
               (alignments will be fixed width but won't include all target nucleotides)

options for skipping the 1st (search) stage or 2nd (alignment) stage:
  --no-align  : only search target sequence file for hits, skip alignment step
  --no-search : only align  target sequence file, skip initial search step

expert options for tuning the initial search stage:
  --toponly  : only search the top strand [default: search both strands]
  --forward  : use the HMM forward algorithm for searching, not HMM viterbi
  --global   : search with globally configured HMM [default: local]
  --keep-int : keep intermediate files which are normally removed

expert options for tuning the alignment stage:
  --aln-one <s> : only align best-matching sequences to the CM named <s> in CM file
  --no-trunc    : do not truncate seqs to HMM predicted start/end, align full seqs
  --no-prob     : do not append posterior probabilities to alignments
  --mxsize <f>  : increase mx size for cmalign to <f> Mb [default: 4096]
```

