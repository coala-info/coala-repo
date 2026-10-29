# ssu-align CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ssu-align | PASS | Staged input writable and put options before arguments; four real rRNA sequences (E. coli, B. subtilis, archaeon, yeast) sorted into bacteria 2, archaea 1, eukarya 1 |
| ssu-align_ssu-build | PASS | New CWL for ssu-build; built a covariance model from the default archaea seed alignment and from a Stockholm alignment |
| ssu-align_ssu-draw | PASS | New CWL for ssu-draw; made PostScript structure diagrams and drawtab files (no PDF because ps2pdf is not in the image) |
| ssu-align_ssu-mask | PASS | New CWL for ssu-mask; default masks made masked alignments for archaea, bacteria and eukarya, and -a --stk2afa made aligned FASTA |
| ssu-align_ssu-merge | PASS | New CWL for ssu-merge; merged two bacteria alignments with --list (the ssu-prep directory mode was not run) |
| ssu-align_ssu-prep | PASS | New CWL for ssu-prep; split four rRNA sequences into two job files and wrote the job shell script |

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

## ssu-align_ssu-build

### Tool Description
Build SSU rRNA covariance models from a Stockholm alignment or a default ssu-align seed alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/ssu-align/
- **Package**: https://anaconda.org/channels/bioconda/packages/ssu-align/overview
- **Validation**: PASS

### Original Help Text
```text
# _ssu-build :: build SSU rRNA covariance models
# SSU-ALIGN 0.1.1 (Feb 2016)
# Copyright (C) 2016 Howard Hughes Medical Institute
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# command: _ssu-build -h 
# date:    Thu Oct 22 16:30:01 2026
Usage: ssu-build [-options] <Stockholm alignment file to build CM from>
Usage: ssu-build [-options] -d <name of default ssu-align-0.1 seed alignment>
                                  ('archaea' or 'bacteria' or 'eukarya')

where general options are:
  -h            : show brief help on version and usage
  -d            : command-line argument is a default ssu-align-0.1 seed alignment
  -f            : force; allow overwriting of CM file
  -o <s>        : name the CM *file* <s>
  -n <s>        : name the CM <s>
  --append <s>  : append this model to CM file <s>
  --key-out <s> : add <s> to all output file names, before the suffix

option for building a model from a truncated version of the alignment:
  --trunc <s> : only include consensus columns from <x> to <y> (where <s> ="<x>-<y>")

options for reformatting input alignments (no model will be built):
  --num : output alignment with consensus columns numbered
  -i    : output alignment in interleaved Stockholm (not 1 line/seq)

options for defining consensus columns:
  (if -d is enabled: --rf is default, otherwise: --gapthresh is default)
  --rf            : use consensus column (#=GC RF) annotation in alignment
  --gapthresh <x> : define consensus columns as those with gap frequency <= <x> [df: 0.8]

options for output of structure diagram, only relevant with -d and --trunc:
  --ps2pdf <s> : command for converting ps to pdf is <s> (not "ps2pdf")
  --ps-only    : only save postscript secondary structure diagram, no pdf

expert options for model construction:
  --eent          : use 'entropy weighting' method to achieve target relative entropy
  --ere <x>       : with --eent, set target relative entropy as <x>
```

## ssu-align_ssu-draw

### Tool Description
Draw SSU rRNA secondary structure diagrams of ssu-align alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/ssu-align/
- **Package**: https://anaconda.org/channels/bioconda/packages/ssu-align/overview
- **Validation**: PASS

### Original Help Text
```text
# _ssu-draw :: draw SSU rRNA secondary structure diagrams
# SSU-ALIGN 0.1.1 (Feb 2016)
# Copyright (C) 2016 Howard Hughes Medical Institute
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# command: _ssu-draw -h 
# date:    Thu Oct 22 16:30:03 2026
Usage: ssu-draw [-options] <directory created by ssu-align (includes >= 1 alignment file(s))>
Usage: ssu-draw [-options] -a <Stockholm alignment file>

where general options are:
  -h     : show brief help on version and usage
  -a     : the command-line argument is a stockholm alignment, not a directory
  -f     : force; w/--indi, draw all seqs, even if predicted output >100 Mb
  -d     : display default ssu-align-0.1 masks on drawings
  -s <f> : display single mask in file <f> for single alignment (requires -a)
  -k <s> : display masks from files named <modelname>.<s>.mask on drawings
           (<modelname> might be 'archaea', 'bacteria' or 'eukarya')
  -m <f> : CM file <f> created the alignment(s) (with ssu-align -m <f>)
  -t <f> : use template file <f>, not the default template file
  -i     : -i used with ssu-align, alignments are interleaved

miscellaneous input/output options:
  --ps2pdf <s>  : <s> (!= "ps2pdf") is the command for converting ps to pdf
  --ps-only     : only save postscript secondary structure diagrams, no pdfs
  --ifile <s>   : insert info for alignment is in <s> (requires -a)
  --key-out <s> : add <s> to all output file names, before the suffix
  --no-mask     : do not use ssu-mask created '.mask' files in the aln dir
  --mask-key    : display masks from files named <dir>.<modelname>.<s>.mask on drawings
                  (typically used after running 'ssu-mask --key-out <s>')

options for 1-page alignment summary diagrams (by default, all are drawn):
  --info    : draw sequence information content per position    (save as *.info.pdf)
  --mutinfo : draw mutual information per position              (save as *.mutinfo.pdf)
  --ifreq   : draw frequency of insertions per position         (save as *.ifreq.pdf)
  --iavglen : draw average length of insertions per position    (save as *.iavglen.pdf)
  --dall    : draw frequency of deletions per position          (save as *.dall.pdf)
  --dint    : draw frequency of internal deletions per position (save as *.dint.pdf)
  --prob    : draw average posterior probability per position   (save as *.prob.pdf)
  --span    : draw fraction of seqs that span each position     (save as *.span.pdf)
  --cnt     : draw consensus nucleotides on alignment summary diagrams
  --no-aln  : do not create multi-page pdf with all alignment stats

options for drawing structure diagrams for individual sequences:
  (WARNING: files can get very large: ~1 Mb/20 seqs (pdf); ~1 Mb/2 seqs (postscript)
  --indi  : draw sequence and probability diagrams for all aligned sequences
  --cons  : draw alignment consensus sequence       (save as *.cons.pdf)
  --rf    : draw model reference (#=GC RF) sequence (save as *.rf.pdf)
  --no-pp : with --indi, omit probability diagrams
  --no-bp : w/--indi,--rf or --cons, do not color nts based on basepair type
  --no-ol : w/--indi, do not outline nts that are not most common nt

options for omitting sections of the diagrams:
  --no-leg  : do not draw legends
  --no-head : do not draw headers
  --no-foot : do not draw footers
```

## ssu-align_ssu-mask

### Tool Description
Mask SSU rRNA alignments, convert them to aligned FASTA, or list and remove sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/ssu-align/
- **Package**: https://anaconda.org/channels/bioconda/packages/ssu-align/overview
- **Validation**: PASS

### Original Help Text
```text
# _ssu-mask :: mask SSU rRNA alignments
# SSU-ALIGN 0.1.1 (Feb 2016)
# Copyright (C) 2016 Howard Hughes Medical Institute
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# command: _ssu-mask -h 
# date:    Thu Oct 22 16:30:05 2026
Usage: ssu-mask [-options] <directory created by ssu-align (includes >= 1 alignment file(s))>
Usage: ssu-mask [-options] -a <Stockholm alignment file>

where general options are:
  -h     : show brief help on version and usage
  -a     : the command-line argument is a stockholm alignment, not a directory
  -d     : use default ssu-align-0.1 masks
  -s <f> : use single mask in existing file <f> to mask single alignment
  -k <s> : use mask file named <modelname>.<s>.mask for masking
           (<modelname> might be 'archaea', 'bacteria' or 'eukarya')
  -m <f> : CM file <f> created the alignment(s) (with ssu-align -m <f>)
  -t <f> : for structure diagrams, use template file <f>, not the default
  -i     : -i used with ssu-align, alignments are interleaved

options controlling mask construction:
  --pf <x>        : include columns w/<x> fraction of seqs w/prob >= --pt <y> [df: 0.95]
  --pt <y>        : set probability threshold as <y> [default=0.95]
  --rfonly        : exclude insert (gap in RF) columns only
  --gapthresh <x> : only consider columns with <= <x> fraction gaps
  --gaponly       : do not consider posterior probabilities, only gap frequencies

miscellaneous output options:
  --afa         : output aligned FASTA (.afa) alignments, not Stockholm ones
  --dna         : output alignments as DNA, default is RNA (even if input is DNA)
  --key-out <s> : add <s> to all output file names, before the suffix

options for creating secondary structure diagrams displaying masks
  (diagrams are created only if default models were used for alignment):
  --ps2pdf <s> : <s> (!= "ps2pdf") is the command for converting ps to pdf
  --ps-only    : save postscript secondary structure diagrams, don't convert to pdf
  --no-draw    : do not draw mask diagrams

options for listing, converting, or removing sequences (no masking will be done):
  --list      : output list file(s) of sequence names in alignment(s)
  --stk2afa   : convert Stockholm alignment(s) to aligned FASTA
  --seq-k <f> : with -a, remove all sequences *except* those listed in file <f>
  --seq-r <f> : with -a, remove sequences with names listed in file <f>
```

## ssu-align_ssu-merge

### Tool Description
Merge SSU rRNA alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/ssu-align/
- **Package**: https://anaconda.org/channels/bioconda/packages/ssu-align/overview
- **Validation**: PASS

### Original Help Text
```text
# _ssu-merge :: merge SSU rRNA alignments
# SSU-ALIGN 0.1.1 (Feb 2016)
# Copyright (C) 2016 Howard Hughes Medical Institute
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# command: _ssu-merge -h 
# date:    Thu Oct 22 16:30:07 2026
Usage: ssu-merge [-options] <output dir created by ssu-prep>
Usage: ssu-merge [-options] --list <file listing n>1 alns to merge> <name for merged aln>

where general options are:
  -h        : show brief help on version and usage
  -f        : force; allow file clobbering
  --rfonly  : when merging alignments, only keep consensus (non-gap RF) columns
  --keep    : don't remove original files after they have been merged

options that only work with --list:
  -i        : input alignments are interleaved Stockholm format (not 1 line/seq)
  --dna     : output alignments as DNA, default is RNA (even if input is DNA)
```

## ssu-align_ssu-prep

### Tool Description
Split a sequence file and write a shell script that runs ssu-align jobs in parallel.

### Metadata
- **Docker Image**: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
- **Homepage**: http://eddylab.org/software/ssu-align/
- **Package**: https://anaconda.org/channels/bioconda/packages/ssu-align/overview
- **Validation**: PASS

### Original Help Text
```text
# _ssu-prep :: prepare SSU rRNA sequences for parallel ssu-align jobs
# SSU-ALIGN 0.1.1 (Feb 2016)
# Copyright (C) 2016 Howard Hughes Medical Institute
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# command: _ssu-prep -h 
# date:    Thu Oct 22 16:30:09 2026
Usage: ssu-prep    [-options] <seqfile> <output dir> <num jobs> <prefix/suffix file>
Usage: ssu-prep -x [-options] <seqfile> <output dir> <num jobs>
Usage: ssu-prep -y [-options] <seqfile> <output dir> <num jobs>

ssu-prep splits up <seqfile> into <num jobs> smaller files and creates a shell
script that will execute <num jobs> ssu-align jobs in parallel, each processing
one of the small sequence files. The results of all jobs will automatically be
merged together by the final job, giving the same results as if a single
ssu-align job was run for the complete <seqfile>.

The 3 different usages control how the prefix and suffix are defined for the jobs
in the output shell script, allowing, for example, the user to wrap the ssu-align
commands in a cluster submission command (such as Sun Grid Engine's "qsub"):

Default: (neither -x nor -y enabled) prefix and suffix for ssu-align jobs in
         output shell script are defined in <prefix/suffix file>. First line is
         the prefix, second line is the suffix.
With -x: do not specify <prefix/suffix file>; output shell script will run all
         <num jobs> jobs in parallel on one machine with <num jobs> cores/cpus.
With -y: do not specify <prefix/suffix file>; user will manually add the desired
         prefix/suffix to ssu-align commands after ssu-prep finishes.

where general options are:
  -h           : show brief help on version and usage
  -f           : force; if dir named <output dir> already exists, empty it first
  -q           : third command line arg is number of seqs per job, not number of jobs
  -e           : split seqs so each job has an equal number of seqs, not nucleotides
  --no-bash    : write generic shell script instead of a bash-specific one
  --no-merge   : do not have final ssu-align job automatically merge all jobs
  --keep-merge : have final ssu-align job not remove small files as they are merged

general options to use for ssu-align jobs:
  -m <f> : use CM file <f> instead of the default CM file
  -b <x> : set minimum bit score of a surviving subsequence as <x> [default: 50]
  -l <n> : set minimum length    of a surviving subsequence as <n> [default: 1]
  -i     : output alignments in interleaved Stockholm format (not 1 line/seq)
  -n <s> : only search with and align to single CM named <s> in CM file
           (default CM file includes 'archaea', 'bacteria', 'eukarya')

miscellaneous output options for ssu-align jobs:
  --dna      : output alignments as DNA, default is RNA (even if input is DNA)
  --rfonly   : discard inserts, only keep consensus (nongap RF) columns in alignments
               (alignments will be fixed width but won't include all target nucleotides)

options for skipping the 1st (search) stage or 2nd (alignment) stage in ssu-align:
  --no-align  : only search target sequence file for hits, skip alignment step
  --no-search : only align  target sequence file, skip initial search step

expert options for tuning the initial search stage in ssu-align jobs:
  --toponly  : only search the top strand [default: search both strands]
  --forward  : use the HMM forward algorithm for searching, not HMM viterbi
  --global   : search with globally configured HMM [default: local]
  --keep-int : keep intermediate files which are normally removed

expert options for tuning the alignment stage in ssu-align jobs:
  --aln-one <s> : only align best-matching sequences to the CM named <s> in CM file
  --no-trunc    : do not truncate seqs to HMM predicted start/end, align full seqs
  --no-prob     : do not append posterior probabilities to alignments
  --mxsize <f>  : increase mx size for cmalign to <f> Mb [default: 4096]
```

