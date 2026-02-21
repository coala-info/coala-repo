# hmmer CWL Generation Report

## hmmer_hmmbuild

### Tool Description
profile HMM construction from multiple sequence alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
- **Homepage**: http://hmmer.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hmmer/overview
- **Total Downloads**: 1.9M
- **Last updated**: 2025-04-30
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# hmmbuild :: profile HMM construction from multiple sequence alignments
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: hmmbuild [-options] <hmmfile_out> <msafile>

Basic options:
  -h     : show brief help on version and usage
  -n <s> : name the HMM <s>
  -o <f> : direct summary output to file <f>, not stdout
  -O <f> : resave annotated, possibly modified MSA to file <f>

Options for selecting alphabet rather than guessing it:
  --amino : input alignment is protein sequence data
  --dna   : input alignment is DNA sequence data
  --rna   : input alignment is RNA sequence data

Alternative model construction strategies:
  --fast           : assign cols w/ >= symfrac residues as consensus  [default]
  --hand           : manual construction (requires reference annotation)
  --symfrac <x>    : sets sym fraction controlling --fast construction  [0.5]
  --fragthresh <x> : if L <= x*alen, tag sequence as a fragment  [0.5]

Alternative relative sequence weighting strategies:
  --wpb     : Henikoff position-based weights  [default]
  --wgsc    : Gerstein/Sonnhammer/Chothia tree weights
  --wblosum : Henikoff simple filter weights
  --wnone   : don't do any relative weighting; set all to 1
  --wgiven  : use weights as given in MSA file
  --wid <x> : for --wblosum: set identity cutoff  [0.62]  (0<=x<=1)

Alternative effective sequence weighting strategies:
  --eent       : adjust eff seq # to achieve relative entropy target  [default]
  --eclust     : eff seq # is # of single linkage clusters
  --enone      : no effective seq # weighting: just use nseq
  --eset <x>   : set eff seq # for all models to <x>
  --ere <x>    : for --eent: set minimum rel entropy/position to <x>
  --esigma <x> : for --eent: set sigma param to <x>  [45.0]
  --eid <x>    : for --eclust: set fractional identity cutoff to <x>  [0.62]

Alternative prior strategies:
  --pnone    : don't use any prior; parameters are frequencies
  --plaplace : use a Laplace +1 prior

Handling single sequence inputs:
  --singlemx    : use substitution score matrix for single-sequence inputs
  --mx <s>      : substitution score matrix (built-in matrices, with --singlemx)
  --mxfile <f>  : read substitution score matrix from file <f> (with --singlemx)
  --popen <x>   : force gap open prob. (w/ --singlemx, aa default 0.02, nt 0.031)
  --pextend <x> : force gap extend prob. (w/ --singlemx, aa default 0.4, nt 0.75)

Control of E-value calibration:
  --EmL <n> : length of sequences for MSV Gumbel mu fit  [200]  (n>0)
  --EmN <n> : number of sequences for MSV Gumbel mu fit  [200]  (n>0)
  --EvL <n> : length of sequences for Viterbi Gumbel mu fit  [200]  (n>0)
  --EvN <n> : number of sequences for Viterbi Gumbel mu fit  [200]  (n>0)
  --EfL <n> : length of sequences for Forward exp tail tau fit  [100]  (n>0)
  --EfN <n> : number of sequences for Forward exp tail tau fit  [200]  (n>0)
  --Eft <x> : tail mass for Forward exponential tail tau fit  [0.04]  (0<x<1)

Other options:
  --cpu <n>          : number of parallel CPU workers for multithreads  [2]
  --mpi              : run as an MPI parallel program
  --stall            : arrest after start: for attaching debugger to process
  --informat <s>     : assert input alifile is in format <s> (no autodetect)
  --seed <n>         : set RNG seed to <n> (if 0: one-time arbitrary seed)  [42]
  --w_beta <x>       : tail mass at which window length is determined
  --w_length <n>     : window length 
  --maxinsertlen <n> : pretend all inserts are length <= <n>
```


## hmmer_hmmsearch

### Tool Description
search profile(s) against a sequence database

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
- **Homepage**: http://hmmer.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmer/overview
- **Validation**: PASS

### Original Help Text
```text
# hmmsearch :: search profile(s) against a sequence database
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: hmmsearch [options] <hmmfile> <seqdb>

Basic options:
  -h : show brief help on version and usage

Options directing output:
  -o <f>           : direct output to file <f>, not stdout
  -A <f>           : save multiple alignment of all hits to file <f>
  --tblout <f>     : save parseable table of per-sequence hits to file <f>
  --domtblout <f>  : save parseable table of per-domain hits to file <f>
  --pfamtblout <f> : save table of hits and domains to file, in Pfam format <f>
  --acc            : prefer accessions over names in output
  --noali          : don't output alignments, so output is smaller
  --notextw        : unlimit ASCII text output line width
  --textw <n>      : set max width of ASCII text output lines  [120]  (n>=120)

Options controlling reporting thresholds:
  -E <x>     : report sequences <= this E-value threshold in output  [10.0]  (x>0)
  -T <x>     : report sequences >= this score threshold in output
  --domE <x> : report domains <= this E-value threshold in output  [10.0]  (x>0)
  --domT <x> : report domains >= this score cutoff in output

Options controlling inclusion (significance) thresholds:
  --incE <x>    : consider sequences <= this E-value threshold as significant
  --incT <x>    : consider sequences >= this score threshold as significant
  --incdomE <x> : consider domains <= this E-value threshold as significant
  --incdomT <x> : consider domains >= this score threshold as significant

Options controlling model-specific thresholding:
  --cut_ga : use profile's GA gathering cutoffs to set all thresholding
  --cut_nc : use profile's NC noise cutoffs to set all thresholding
  --cut_tc : use profile's TC trusted cutoffs to set all thresholding

Options controlling acceleration heuristics:
  --max    : Turn all heuristic filters off (less speed, more power)
  --F1 <x> : Stage 1 (MSV) threshold: promote hits w/ P <= F1  [0.02]
  --F2 <x> : Stage 2 (Vit) threshold: promote hits w/ P <= F2  [1e-3]
  --F3 <x> : Stage 3 (Fwd) threshold: promote hits w/ P <= F3  [1e-5]
  --nobias : turn off composition bias filter

Other expert options:
  --nonull2     : turn off biased composition score corrections
  -Z <x>        : set # of comparisons done, for E-value calculation
  --domZ <x>    : set # of significant seqs, for domain E-value calculation
  --seed <n>    : set RNG seed to <n> (if 0: one-time arbitrary seed)  [42]
  --tformat <s> : assert target <seqfile> is in format <s>: no autodetection
  --cpu <n>     : number of parallel CPU workers to use for multithreads  [2]
  --stall       : arrest after start: for debugging MPI under gdb
  --mpi         : run as an MPI parallel program
```


## hmmer_hmmscan

### Tool Description
search sequence(s) against a profile database

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
- **Homepage**: http://hmmer.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmer/overview
- **Validation**: PASS

### Original Help Text
```text
# hmmscan :: search sequence(s) against a profile database
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: hmmscan [-options] <hmmdb> <seqfile>

Basic options:
  -h : show brief help on version and usage

Options controlling output:
  -o <f>           : direct output to file <f>, not stdout
  --tblout <f>     : save parseable table of per-sequence hits to file <f>
  --domtblout <f>  : save parseable table of per-domain hits to file <f>
  --pfamtblout <f> : save table of hits and domains to file, in Pfam format <f>
  --acc            : prefer accessions over names in output
  --noali          : don't output alignments, so output is smaller
  --notextw        : unlimit ASCII text output line width
  --textw <n>      : set max width of ASCII text output lines  [120]  (n>=120)

Options controlling reporting thresholds:
  -E <x>     : report models <= this E-value threshold in output  [10.0]  (x>0)
  -T <x>     : report models >= this score threshold in output
  --domE <x> : report domains <= this E-value threshold in output  [10.0]  (x>0)
  --domT <x> : report domains >= this score cutoff in output

Options controlling inclusion (significance) thresholds:
  --incE <x>    : consider models <= this E-value threshold as significant
  --incT <x>    : consider models >= this score threshold as significant
  --incdomE <x> : consider domains <= this E-value threshold as significant
  --incdomT <x> : consider domains >= this score threshold as significant

Options for model-specific thresholding:
  --cut_ga : use profile's GA gathering cutoffs to set all thresholding
  --cut_nc : use profile's NC noise cutoffs to set all thresholding
  --cut_tc : use profile's TC trusted cutoffs to set all thresholding

Options controlling acceleration heuristics:
  --max    : Turn all heuristic filters off (less speed, more power)
  --F1 <x> : MSV threshold: promote hits w/ P <= F1  [0.02]
  --F2 <x> : Vit threshold: promote hits w/ P <= F2  [1e-3]
  --F3 <x> : Fwd threshold: promote hits w/ P <= F3  [1e-5]
  --nobias : turn off composition bias filter

Other expert options:
  --nonull2     : turn off biased composition score corrections
  -Z <x>        : set # of comparisons done, for E-value calculation
  --domZ <x>    : set # of significant seqs, for domain E-value calculation
  --seed <n>    : set RNG seed to <n> (if 0: one-time arbitrary seed)  [42]
  --qformat <s> : assert input <seqfile> is in format <s>: no autodetection
  --cpu <n>     : number of parallel CPU workers to use for multithreads  [0]
  --stall       : arrest after start: for debugging MPI under gdb
  --mpi         : run as an MPI parallel program
```


## hmmer_hmmpress

### Tool Description
prepare an HMM database for faster hmmscan searches

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
- **Homepage**: http://hmmer.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmer/overview
- **Validation**: PASS

### Original Help Text
```text
# hmmpress :: prepare an HMM database for faster hmmscan searches
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: hmmpress [-options] <hmmfile>

Options:
  -h : show brief help on version and usage
  -f : force: overwrite any previous pressed files
```


## hmmer_phmmer

### Tool Description
search a protein sequence against a protein database

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
- **Homepage**: http://hmmer.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmer/overview
- **Validation**: PASS

### Original Help Text
```text
# phmmer :: search a protein sequence against a protein database
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: phmmer [-options] <seqfile> <seqdb>

Basic options:
  -h : show brief help on version and usage

Options directing output:
  -o <f>           : direct output to file <f>, not stdout
  -A <f>           : save multiple alignment of hits to file <f>
  --tblout <f>     : save parseable table of per-sequence hits to file <f>
  --domtblout <f>  : save parseable table of per-domain hits to file <f>
  --pfamtblout <f> : save table of hits and domains to file, in Pfam format <f>
  --acc            : prefer accessions over names in output
  --noali          : don't output alignments, so output is smaller
  --notextw        : unlimit ASCII text output line width
  --textw <n>      : set max width of ASCII text output lines  [120]  (n>=120)

Options controlling scoring system:
  --popen <x>   : gap open probability
  --pextend <x> : gap extend probability
  --mx <s>      : substitution score matrix choice (of some built-in matrices)
  --mxfile <f>  : read substitution score matrix from file <f>

Options controlling reporting thresholds:
  -E <x>     : report sequences <= this E-value threshold in output  [10.0]  (x>0)
  -T <x>     : report sequences >= this score threshold in output
  --domE <x> : report domains <= this E-value threshold in output  [10.0]  (x>0)
  --domT <x> : report domains >= this score cutoff in output

Options controlling inclusion (significance) thresholds:
  --incE <x>    : consider sequences <= this E-value threshold as significant
  --incT <x>    : consider sequences >= this score threshold as significant
  --incdomE <x> : consider domains <= this E-value threshold as significant
  --incdomT <x> : consider domains >= this score threshold as significant

Options controlling acceleration heuristics:
  --max    : Turn all heuristic filters off (less speed, more power)
  --F1 <x> : Stage 1 (MSV) threshold: promote hits w/ P <= F1  [0.02]
  --F2 <x> : Stage 2 (Vit) threshold: promote hits w/ P <= F2  [1e-3]
  --F3 <x> : Stage 3 (Fwd) threshold: promote hits w/ P <= F3  [1e-5]
  --nobias : turn off composition bias filter

Options controlling E value calibration:
  --EmL <n> : length of sequences for MSV Gumbel mu fit  [200]  (n>0)
  --EmN <n> : number of sequences for MSV Gumbel mu fit  [200]  (n>0)
  --EvL <n> : length of sequences for Viterbi Gumbel mu fit  [200]  (n>0)
  --EvN <n> : number of sequences for Viterbi Gumbel mu fit  [200]  (n>0)
  --EfL <n> : length of sequences for Forward exp tail tau fit  [100]  (n>0)
  --EfN <n> : number of sequences for Forward exp tail tau fit  [200]  (n>0)
  --Eft <x> : tail mass for Forward exponential tail tau fit  [0.04]  (0<x<1)

Other expert options:
  --nonull2     : turn off biased composition score corrections
  -Z <x>        : set # of comparisons done, for E-value calculation
  --domZ <x>    : set # of significant seqs, for domain E-value calculation
  --seed <n>    : set RNG seed to <n> (if 0: one-time arbitrary seed)  [42]
  --qformat <s> : assert query <seqfile> is in format <s>: no autodetection
  --tformat <s> : assert target <seqdb> is in format <s>>: no autodetection
  --cpu <n>     : number of parallel CPU workers to use for multithreads  [2]
  --stall       : arrest after start: for debugging MPI under gdb
  --mpi         : run as an MPI parallel program
```


## hmmer_jackhmmer

### Tool Description
iteratively search a protein sequence against a protein database

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
- **Homepage**: http://hmmer.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmer/overview
- **Validation**: PASS

### Original Help Text
```text
# jackhmmer :: iteratively search a protein sequence against a protein database
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: jackhmmer [-options] <seqfile> <seqdb>

Basic options:
  -h     : show brief help on version and usage
  -N <n> : set maximum number of iterations to <n>  [5]  (n>0)

Options directing output:
  -o <f>          : direct output to file <f>, not stdout
  -A <f>          : save multiple alignment of hits to file <f>
  --tblout <f>    : save parseable table of per-sequence hits to file <f>
  --domtblout <f> : save parseable table of per-domain hits to file <f>
  --chkhmm <f>    : save HMM checkpoints to files <f>-<iteration>.hmm
  --chkali <f>    : save alignment checkpoints to files <f>-<iteration>.sto
  --acc           : prefer accessions over names in output
  --noali         : don't output alignments, so output is smaller
  --notextw       : unlimit ASCII text output line width
  --textw <n>     : set max width of ASCII text output lines  [120]  (n>=120)

Options controlling scoring system in first iteration:
  --popen <x>   : gap open probability
  --pextend <x> : gap extend probability
  --mx <s>      : substitution score matrix choice (of some built-in matrices)
  --mxfile <f>  : read substitution score matrix from file <f>

Options controlling reporting thresholds:
  -E <x>     : report sequences <= this E-value threshold in output  [10.0]  (x>0)
  -T <x>     : report sequences >= this score threshold in output
  --domE <x> : report domains <= this E-value threshold in output  [10.0]  (x>0)
  --domT <x> : report domains >= this score cutoff in output

Options controlling significance thresholds for inclusion in next round:
  --incE <x>    : consider sequences <= this E-value threshold as significant
  --incT <x>    : consider sequences >= this score threshold as significant
  --incdomE <x> : consider domains <= this E-value threshold as significant
  --incdomT <x> : consider domains >= this score threshold as significant

Options controlling acceleration heuristics:
  --max    : Turn all heuristic filters off (less speed, more power)
  --F1 <x> : Stage 1 (MSV) threshold: promote hits w/ P <= F1  [0.02]
  --F2 <x> : Stage 2 (Vit) threshold: promote hits w/ P <= F2  [1e-3]
  --F3 <x> : Stage 3 (Fwd) threshold: promote hits w/ P <= F3  [1e-5]
  --nobias : turn off composition bias filter

Options controlling model construction after first iteration:
  --fragthresh <x> : if L <= x*alen, tag sequence as a fragment  [0.5]  (0<=x<=1)

Options controlling relative weights in models after first iteration:
  --wpb     : Henikoff position-based weights  [default]
  --wgsc    : Gerstein/Sonnhammer/Chothia tree weights
  --wblosum : Henikoff simple filter weights
  --wnone   : don't do any relative weighting; set all to 1
  --wid <x> : for --wblosum: set identity cutoff  [0.62]  (0<=x<=1)

Options controlling effective seq number in models after first iteration:
  --eent       : adjust eff seq # to achieve relative entropy target
  --eentexp    : adjust eff seq # to reach rel. ent. target using exp scaling
  --eclust     : eff seq # is # of single linkage clusters
  --enone      : no effective seq # weighting: just use nseq
  --eset <x>   : set eff seq # for all models to <x>
  --ere <x>    : for --eent[exp]: set minimum rel entropy/position to <x>
  --esigma <x> : for --eent[exp]: set sigma param to <x>
  --eid <x>    : for --eclust: set fractional identity cutoff to <x>

Options controlling prior strategy in models after first iteration:
  --pnone    : don't use any prior; parameters are frequencies
  --plaplace : use a Laplace +1 prior

Options controlling E value calibration:
  --EmL <n> : length of sequences for MSV Gumbel mu fit  [200]  (n>0)
  --EmN <n> : number of sequences for MSV Gumbel mu fit  [200]  (n>0)
  --EvL <n> : length of sequences for Viterbi Gumbel mu fit  [200]  (n>0)
  --EvN <n> : number of sequences for Viterbi Gumbel mu fit  [200]  (n>0)
  --EfL <n> : length of sequences for Forward exp tail tau fit  [100]  (n>0)
  --EfN <n> : number of sequences for Forward exp tail tau fit  [200]  (n>0)
  --Eft <x> : tail mass for Forward exponential tail tau fit  [0.04]  (0<x<1)

Other expert options:
  --nonull2     : turn off biased composition score corrections
  -Z <x>        : set # of comparisons done, for E-value calculation
  --domZ <x>    : set # of significant seqs, for domain E-value calculation
  --seed <n>    : set RNG seed to <n> (if 0: one-time arbitrary seed)  [42]
  --qformat <s> : assert query <seqfile> is in format <s>: no autodetection
  --tformat <s> : assert target <seqdb> is in format <s>>: no autodetection
  --cpu <n>     : number of parallel CPU workers to use for multithreads  [2]
  --stall       : arrest after start: for debugging MPI under gdb
  --mpi         : run as an MPI parallel program
```


## hmmer_nhmmer

### Tool Description
search a DNA model, alignment, or sequence against a DNA database

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
- **Homepage**: http://hmmer.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmer/overview
- **Validation**: PASS

### Original Help Text
```text
# nhmmer :: search a DNA model, alignment, or sequence against a DNA database
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: nhmmer [options] <query hmmfile|alignfile|seqfile> <target seqfile>

Basic options:
  -h : show brief help on version and usage

Options directing output:
  -o <f>             : direct output to file <f>, not stdout
  -A <f>             : save multiple alignment of all hits to file <f>
  --tblout <f>       : save parseable table of hits to file <f>
  --dfamtblout <f>   : save table of hits to file, in Dfam format <f>
  --aliscoresout <f> : save scores for each position in each alignment to <f>
  --hmmout <f>       : if input is alignment(s), write produced hmms to file <f>
  --acc              : prefer accessions over names in output
  --noali            : don't output alignments, so output is smaller
  --notextw          : unlimit ASCII text output line width
  --textw <n>        : set max width of ASCII text output lines  [120]  (n>=120)

Options controlling scoring system:
  --singlemx    : use substitution score matrix w/ single-sequence MSA-format inputs
  --popen <x>   : gap open probability  [0.03125]  (0<=x<0.5)
  --pextend <x> : gap extend probability  [0.75]  (0<=x<1)
  --mxfile <f>  : read substitution score matrix from file <f>

Options controlling reporting thresholds:
  -E <x> : report sequences <= this E-value threshold in output  [10.0]  (x>0)
  -T <x> : report sequences >= this score threshold in output

Options controlling inclusion (significance) thresholds:
  --incE <x> : consider sequences <= this E-value threshold as significant  [0.01]  (x>0)
  --incT <x> : consider sequences >= this score threshold as significant

Options controlling model-specific thresholding:
  --cut_ga : use profile's GA gathering cutoffs to set all thresholding
  --cut_nc : use profile's NC noise cutoffs to set all thresholding
  --cut_tc : use profile's TC trusted cutoffs to set all thresholding

Options controlling acceleration heuristics:
  --max    : Turn all heuristic filters off (less speed, more power)
  --F1 <x> : Stage 1 (SSV) threshold: promote hits w/ P <= F1
  --F2 <x> : Stage 2 (Vit) threshold: promote hits w/ P <= F2  [3e-3]
  --F3 <x> : Stage 3 (Fwd) threshold: promote hits w/ P <= F3  [3e-5]
  --nobias : turn off composition bias filter

Options for selecting query alphabet rather than guessing it:
  --dna : input alignment is DNA sequence data
  --rna : input alignment is RNA sequence data

Options controlling seed search heuristic:
  --seed_max_depth <n>     : seed length at which bit threshold must be met  [15]
  --seed_sc_thresh <x>     : Default req. score for FM seed (bits)  [14]
  --seed_sc_density <x>    : seed must maintain this bit density from one of two ends  [0.75]
  --seed_drop_max_len <n>  : maximum run length with score under (max - [fm_drop_lim])  [4]
  --seed_drop_lim <x>      : in seed, max drop in a run of length [fm_drop_max_len]  [0.3]
  --seed_req_pos <n>       : minimum number consecutive positive scores in seed  [5]
  --seed_consens_match <n> : <n> consecutive matches to consensus will override score threshold  [11]
  --seed_ssv_length <n>    : length of window around FM seed to get full SSV diagonal  [100]

Other expert options:
  --qformat <s>      : assert query is in format <s> (can be seq or msa format)
  --qsingle_seqs     : force query to be read as individual sequences, even if in an msa format
  --tformat <s>      : assert target <seqdb> is in format <s>
  --nonull2          : turn off biased composition score corrections
  -Z <x>             : set database size (Megabases) to <x> for E-value calculations  (x>0)
  --seed <n>         : set RNG seed to <n> (if 0: one-time arbitrary seed)  [42]  (n>=0)
  --w_beta <x>       : tail mass at which window length is determined
  --w_length <n>     : window length - essentially max expected hit length
  --block_length <n> : length of blocks read from target database (threaded)   (n>=50000)
  --watson           : only search the top strand
  --crick            : only search the bottom strand
  --cpu <n>          : number of parallel CPU workers to use for multithreads  [2]  (n>=0)
```


## hmmer_hmmalign

### Tool Description
align sequences to a profile HMM

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
- **Homepage**: http://hmmer.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmer/overview
- **Validation**: PASS

### Original Help Text
```text
# hmmalign :: align sequences to a profile HMM
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: hmmalign [-options] <hmmfile> <seqfile>

Basic options:
  -h     : show brief help on version and usage
  -o <f> : output alignment to file <f>, not stdout

Less common options:
  --mapali <f>    : include alignment in file <f> (same ali that HMM came from)
  --trim          : trim terminal tails of nonaligned residues from alignment
  --amino         : assert <seqfile>, <hmmfile> both protein: no autodetection
  --dna           : assert <seqfile>, <hmmfile> both DNA: no autodetection
  --rna           : assert <seqfile>, <hmmfile> both RNA: no autodetection
  --informat <s>  : assert <seqfile> is in format <s>: no autodetection
  --outformat <s> : output alignment in format <s>  [Stockholm]

Sequence input formats include:   FASTA, EMBL, GenBank, UniProt
Alignment output formats include: Stockholm, Pfam, A2M, PSIBLAST
```


## hmmer_makehmmerdb

### Tool Description
build a HMMER binary-formatted database from an input sequence file

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
- **Homepage**: http://hmmer.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmer/overview
- **Validation**: PASS

### Original Help Text
```text
# makehmmerdb :: build a HMMER binary-formatted database from an input sequence file
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: makehmmerdb [options] <seqfile> <binaryfile>

Basic options:
  -h : show brief help on version and usage

Special options:
  --informat <s>   : specify that input file is in format <s>
  --bin_length <n> : bin length (power of 2;  32<=b<=4096)  [256]
  --sa_freq <n>    : suffix array sample rate (power of 2)  [8]
  --block_size <n> : input sequence broken into blocks this size (Mbases)  [50]
```


## Metadata
- **Skill**: generated
