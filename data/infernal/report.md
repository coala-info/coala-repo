# infernal CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| infernal_cmalign | PASS |  |
| infernal_cmbuild | PASS |  |
| infernal_cmcalibrate | PASS |  |
| infernal_cmconvert | PASS |  |
| infernal_cmemit | PASS |  |
| infernal_cmfetch | PASS |  |
| infernal_cmpress | PASS |  |
| infernal_cmscan | PASS |  |
| infernal_cmsearch | PASS |  |
| infernal_cmstat | PASS |  |

## infernal_cmsearch

### Tool Description
search CM(s) against a sequence database

### Metadata
- **Docker Image**: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
- **Homepage**: http://eddylab.org/infernal
- **Package**: https://anaconda.org/channels/bioconda/packages/infernal/overview
- **Validation**: PASS

### Original Help Text
```text
# cmsearch :: search CM(s) against a sequence database
# INFERNAL 1.1.5 (Sep 2023)
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: cmsearch [options] <cmfile> <seqdb>

Basic options:
  -h        : show brief help on version and usage
  -g        : configure CM for glocal alignment [default: local]
  -Z <x>    : set search space size in *Mb* to <x> for E-value calculations  (x>0)
  --devhelp : show list of otherwise hidden developer/expert options

Options directing output:
  -o <f>       : direct output to file <f>, not stdout
  -A <f>       : save multiple alignment of all significant hits to file <s>
  --tblout <f> : save parseable table of hits to file <s>
  --fmt <n>    : set hit table format to <n>  (1<=n<=3)
  --acc        : prefer accessions over names in output
  --noali      : don't output alignments, so output is smaller
  --notextw    : unlimit ASCII text output line width
  --textw <n>  : set max width of ASCII text output lines  [120]  (n>=120)
  --verbose    : report extra information; mainly useful for debugging
  --nomiss     : with -A, do not mark truncated hits with missing (~) chars

Options controlling reporting thresholds:
  -E <x> : report sequences <= this E-value threshold in output  [10.0]  (x>0)
  -T <x> : report sequences >= this score threshold in output

Options controlling inclusion (significance) thresholds:
  --incE <x> : consider sequences <= this E-value threshold as significant  [0.01]
  --incT <x> : consider sequences >= this score threshold as significant

Options controlling model-specific reporting thresholds:
  --cut_ga : use CM's GA gathering cutoffs as reporting thresholds
  --cut_nc : use CM's NC noise cutoffs as reporting thresholds
  --cut_tc : use CM's TC trusted cutoffs as reporting thresholds

Options controlling acceleration heuristics*:
  --max      : turn all heuristic filters off (slow)
  --nohmm    : skip all HMM filter stages, use only CM (slow)
  --mid      : skip first two HMM filter stages (SSV & Vit)
  --default  : default: run search space size-dependent pipeline  [default]
  --rfam     : set heuristic filters at Rfam-level (fast)
  --hmmonly  : use HMM only, don't use a CM at all
  --FZ <x>   : set filters to defaults used for a search space of size <x> Mb
  --Fmid <x> : with --mid, set P-value threshold for HMM stages to <x>  [0.02]

Other options*:
  --notrunc     : do not allow truncated hits at sequence termini
  --anytrunc    : allow full+truncated hits at terminii and anywhere within seqs
  --nonull3     : turn off the NULL3 post hoc additional null model
  --mxsize <x>  : set max allowed alnment mx size to <x> Mb [df: autodetermined]
  --smxsize <x> : set max allowed size of search DP matrices to <x> Mb  [128.]
  --cyk         : use scanning CM CYK algorithm, not Inside in final stage
  --acyk        : align hits with CYK, not optimal accuracy
  --wcx <x>     : set W (expected max hit len) as <x> * cm->clen (model len)
  --toponly     : only search the top strand
  --bottomonly  : only search the bottom strand
  --tformat <s> : assert target <seqdb> is in format <s>: no autodetection
  --cpu <n>     : number of parallel CPU workers to use for multithreads  [4]

*Use --devhelp to show additional expert options.
```

## infernal_cmscan

### Tool Description
search sequence(s) against a CM database

### Metadata
- **Docker Image**: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
- **Homepage**: http://eddylab.org/infernal
- **Package**: https://anaconda.org/channels/bioconda/packages/infernal/overview
- **Validation**: PASS

### Original Help Text
```text
# cmscan :: search sequence(s) against a CM database
# INFERNAL 1.1.5 (Sep 2023)
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: cmscan [-options] <cmdb> <seqfile>

Basic options:
  -h        : show brief help on version and usage
  -g        : configure CM for glocal alignment [default: local]
  -Z <x>    : set search space size in *Mb* to <x> for E-value calculations  (x>0)
  --devhelp : show list of otherwise hidden developer/expert options

Options directing output:
  -o <f>       : direct output to file <f>, not stdout
  --tblout <f> : save parseable table of hits to file <s>
  --fmt <n>    : set hit table format to <n>  (1<=n<=3)
  --acc        : prefer accessions over names in output
  --noali      : don't output alignments, so output is smaller
  --notextw    : unlimit ASCII text output line width
  --textw <n>  : set max width of ASCII text output lines  [120]  (n>=120)
  --verbose    : report extra information; mainly useful for debugging

Options controlling reporting thresholds:
  -E <x> : report sequences <= this E-value threshold in output  [10.0]  (x>0)
  -T <x> : report sequences >= this score threshold in output

Options controlling inclusion (significance) thresholds:
  --incE <x> : consider sequences <= this E-value threshold as significant  [0.01]
  --incT <x> : consider sequences >= this score threshold as significant

Options controlling model-specific reporting thresholds:
  --cut_ga : use CM's GA gathering cutoffs as reporting thresholds
  --cut_nc : use CM's NC noise cutoffs as reporting thresholds
  --cut_tc : use CM's TC trusted cutoffs as reporting thresholds

Options controlling acceleration heuristics*:
  --max      : turn all heuristic filters off (slow)
  --nohmm    : skip all HMM filter stages, use only CM (slow)
  --mid      : skip first two HMM filter stages (SSV & Vit)
  --default  : default: run search space size-dependent pipeline  [default]
  --rfam     : set heuristic filters at Rfam-level (fast)
  --hmmonly  : use HMM only, don't use a CM at all
  --FZ <x>   : set filters to defaults used for a search space of size <x> Mb
  --Fmid <x> : with --mid, set P-value threshold for HMM stages to <x>  [0.02]

Other options*:
  --notrunc     : do not allow truncated hits at sequence termini
  --anytrunc    : allow full+truncated hits at terminii and anywhere within seqs
  --nonull3     : turn off the NULL3 post hoc additional null model
  --mxsize <x>  : set max allowed alnment mx size to <x> Mb [df: autodetermined]
  --smxsize <x> : set max allowed size of search DP matrices to <x> Mb  [128.]
  --cyk         : use scanning CM CYK algorithm, not Inside in final stage
  --acyk        : align hits with CYK, not optimal accuracy
  --wcx <x>     : set W (expected max hit len) as <x> * cm->clen (model len)
  --toponly     : only search the top strand
  --bottomonly  : only search the bottom strand
  --qformat <s> : assert query <seqfile> is in format <s>: no autodetection
  --glist <f>   : configure CMs listed in file <f> in glocal mode, others in local
  --clanin <f>  : read clan information from file <f>
  --oclan       : w/'--fmt 2' and '--tblout', only mark overlaps within clans
  --oskip       : w/'--fmt 2' and '--tblout', do not output lower scoring overlaps
  --cpu <n>     : number of parallel CPU workers to use for multithreads  [4]

*Use --devhelp to show additional expert options.
```

## infernal_cmalign

### Tool Description
align sequences to a CM

### Metadata
- **Docker Image**: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
- **Homepage**: http://eddylab.org/infernal
- **Package**: https://anaconda.org/channels/bioconda/packages/infernal/overview
- **Validation**: PASS

### Original Help Text
```text
# cmalign :: align sequences to a CM
# INFERNAL 1.1.5 (Sep 2023)
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: cmalign [-options] <cmfile> <seqfile>

Basic options:
  -h     : show brief help on version and usage
  -o <f> : output the alignment to file <f>, not stdout
  -g     : configure CM for global alignment [default: local]

Options controlling alignment algorithm:
  --optacc   : use the Holmes/Durbin optimal accuracy algorithm  [default]
  --cyk      : use the CYK algorithm
  --sample   : sample alignment of each seq from posterior distribution
  --seed <n> : w/--sample, set RNG seed to <n> (if 0: one-time arbitrary seed)
  --notrunc  : do not use truncated alignment algorithm
  --sub      : build sub CM for columns b/t HMM predicted start/end points

Options controlling speed and memory requirements:
  --hbanded    : accelerate using CM plan 9 HMM derived bands  [default]
  --tau <x>    : set tail loss prob for HMM bands to <x>  [1e-7]  (1e-18<x<1)
  --mxsize <x> : set maximum allowable DP matrix size to <x> Mb  [1024.0]  (x>0.)
  --fixedtau   : do not adjust tau (tighten bands) until mx size is < limit
  --maxtau <x> : set max tau <x> when tightening HMM bands  [0.05]  (0<x<0.5)
  --nonbanded  : do not use HMM bands for faster alignment
  --small      : use small memory divide and conquer (d&c) algorithm

Optional output files:
  --sfile <f>  : dump alignment score information to file <f>
  --tfile <f>  : dump individual sequence parsetrees to file <f>
  --ifile <f>  : dump information on per-sequence inserts to file <f>
  --elfile <f> : dump information on per-sequence EL inserts to file <f>

Other options:
  --mapali <f>       : include alignment in file <f> (same ali that CM came from)
  --mapstr           : include structure (w/pknots) from <f> from --mapali <f>
  --noss             : cmbuild --noss option was used w/aln from --mapali <f>
  --informat <s>     : assert <seqfile> is in format <s>: no autodetection
  --outformat <s>    : output alignment in format <s>  [Stockholm]
  --dnaout           : output alignment as DNA (not RNA) sequence data
  --noprob           : do not include posterior probabilities in the alignment
  --matchonly        : include only match columns in output alignment
  --miss             : mark seqs w/terminal gaps as fragments w/missing (~) chars
  --ileaved          : force output in interleaved Stockholm format
  --flanktoins <x>   : change transition probs into ROOT_IL/IR to <x> (e.g. 0.1)
  --flankselfins <x> : change self transit probs for ROOT_IL/IR to <x> (e.g. 0.8)
  --regress <f>      : save regression test data to file <f>
  --verbose          : report extra information; mainly useful for debugging
  --cpu <n>          : number of parallel CPU workers to use for multithreads  [4]

Sequence input formats:   FASTA, GenBank
Alignment output formats: Stockholm, Pfam, AFA (aligned FASTA), A2M, Clustal, PHYLIP
```

## infernal_cmemit

### Tool Description
sample sequences from a covariance model

### Metadata
- **Docker Image**: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
- **Homepage**: http://eddylab.org/infernal
- **Package**: https://anaconda.org/channels/bioconda/packages/infernal/overview
- **Validation**: PASS

### Original Help Text
```text
# cmemit :: sample sequences from a covariance model
# INFERNAL 1.1.5 (Sep 2023)
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: cmemit [-options] <cmfile>

Basic options:
  -h     : show brief help on version and usage
  -o <f> : send sequence output to file <f>, not stdout
  -N <n> : generate <n> sequences  [10]
  -u     : write generated sequences as unaligned FASTA  [default]
  -a     : write generated sequences as an alignment
  -c     : generate a single "consensus" sequence only
  -e <n> : embed emitted sequences within larger random sequences of length <n>
  -l     : local; emit from a locally configured model [default: global]

Options for truncating sequences:
  --u5p     : truncate unaligned sequences 5', choosing a random start posn
  --u3p     : truncate unaligned sequences 3', choosing a random end   posn
  --a5p <n> : truncate aln 5', start at match column <n> (use 0 for random posn)
  --a3p <n> : truncate aln 3', end   at match column <n> (use 0 for random posn)

Other options:
  --seed <n>      : set RNG seed to <n> [default: one-time arbitrary seed]  [0]
  --iid           : with -e, generate larger sequences as 25% ACGU (iid) 
  --rna           : output as RNA sequence data  [default]
  --dna           : output as DNA sequence data
  --idx <n>       : start sequence numbering at <n>  [1]
  --outformat <s> : w/-a output alignment in format <s>  [Stockholm]
  --tfile <f>     : dump parsetrees to file <f>
  --exp <x>       : exponentiate CM probabilities by <x> before emitting
  --hmmonly       : emit from filter HMM, not from CM
  --nohmmonly     : always emit from CM, even for models with 0 basepairs

Alignment output formats (-a) include: Stockholm, Pfam, AFA (aligned FASTA), A2M, Clustal, PHYLIP
```

## infernal_cmstat

### Tool Description
display summary statistics for CMs

### Metadata
- **Docker Image**: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
- **Homepage**: http://eddylab.org/infernal
- **Package**: https://anaconda.org/channels/bioconda/packages/infernal/overview
- **Validation**: PASS

### Original Help Text
```text
# cmstat :: display summary statistics for CMs
# INFERNAL 1.1.5 (Sep 2023)
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: cmstat [-options] <cmfile>

Options:
  -h          : show brief help on version and usage
  -E <x>      : print bit scores that correspond to E-value threshold of <x>
  -P <x>      : print bit scores that correspond to E-value threshold of <x>
  -T <x>      : print E-values that correspond to bit score threshold of <x>
  -Z <x>      : set database size in *Mb* to <x> for E-value calculations  [10]
  --cut_ga    : print E-values that correspond to GA bit score thresholds
  --cut_nc    : print E-values that correspond to NC bit score thresholds
  --cut_tc    : print E-values that correspond to TC bit score thresholds
  --key <s>   : only print statistics for CM with name or accession <s>
  --hmmonly   : print filter HMM bit scores/E-values, not CM ones
  --nohmmonly : print CM bit scores/E-values, even for models with 0 basepairs
```

## infernal_cmconvert

### Tool Description
convert CM file to a different Infernal format

### Metadata
- **Docker Image**: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
- **Homepage**: http://eddylab.org/infernal
- **Package**: https://anaconda.org/channels/bioconda/packages/infernal/overview
- **Validation**: PASS

### Original Help Text
```text
# cmconvert :: convert CM file to a different Infernal format
# INFERNAL 1.1.5 (Sep 2023)
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: cmconvert [-options] <cmfile>

Options:
  -h      : show brief help on version and usage
  -a      : ascii:  output models in INFERNAL 1.1 ASCII format  [default]
  -b      : binary: output models in INFERNAL 1.1 binary format
  -1      : output backward compatible Infernal v0.7-->v1.0.2 ASCII format
  -o <f>  : save CM file to file <f>, not stdout
  --mlhmm : output maximum likelihood HMM for CM in HMMER3 format
  --fhmm  : output filter HMM for CM in HMMER3 format
```

## infernal_cmfetch

### Tool Description
retrieve CMs from a file

### Metadata
- **Docker Image**: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
- **Homepage**: http://eddylab.org/infernal
- **Package**: https://anaconda.org/channels/bioconda/packages/infernal/overview
- **Validation**: PASS

### Original Help Text
```text
# cmfetch :: retrieve CMs from a file
# Easel 0.49 (Aug 2023)
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: cmfetch [options] <cmfile> <key>         (retrieves CM named <key>)
Usage: cmfetch [options] -f <cmfile> <keyfile>  (retrieves all CMs in <keyfile>)
Usage: cmfetch [options] --index <cmfile>       (indexes <cmfile>)

 where options are:
  -h      : help; show brief info on version and usage
  -f      : second cmdline arg is a file of names to retrieve
  -o <f>  : output CM to file <f> instead of stdout
  -O      : output CM to file named <key>
  --index : index the <cmfile>, creating <cmfile>.ssi
```

## Metadata
- **Skill**: generated

## infernal_cmbuild

### Tool Description
covariance model construction from multiple sequence alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
- **Homepage**: http://eddylab.org/infernal
- **Package**: https://anaconda.org/channels/bioconda/packages/infernal/overview
- **Validation**: PASS

### Original Help Text
```text
# cmbuild :: covariance model construction from multiple sequence alignments
# INFERNAL 1.1.5 (Sep 2023)
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: cmbuild [-options] <cmfile_out> <msafile>

Basic options:
  -h        : show brief help on version and usage
  -n <s>    : name the CM(s) <s>, (only if single aln in file)
  -F        : force; allow overwriting of <cmfile_out>
  -o <f>    : direct summary output to file <f>, not stdout
  -O <f>    : resave consensus/insert column annotated MSA to file <f>
  --devhelp : show list of otherwise hidden developer/expert options

Alternative model construction strategies:
  --fast           : assign cols w/ >= symfrac residues as consensus
  --hand           : use reference coordinate annotation to specify consensus
  --symfrac <x>    : fraction of non-gaps to require in a consensus column [0..1]
  --fragthresh <x> : if aligned seq spans <= x*alen, tag seq as a fragment
  --fragnrfpos <n> : w/--hand, seqs w/ > <n> 5' or 3' consensus gaps are fragments
  --fraggiven      : use fragment info, if any, in input MSA, don't infer frags
  --noss           : ignore secondary structure annotation in input alignment
  --rsearch <f>    : use RSEARCH parameterization with RIBOSUM matrix file <f>
  --consrf         : with --hand, rewrite RF line with consensus sequence

Other model construction options*:
  --null <f>  : read null (random sequence) model from file <f>
  --prior <f> : read priors from file <f>

Alternative relative sequence weighting strategies:
  --wpb     : Henikoff position-based weights  [default]
  --wgsc    : Gerstein/Sonnhammer/Chothia tree weights
  --wnone   : don't do any relative weighting; set all to 1
  --wgiven  : use weights as given in MSA file
  --wblosum : Henikoff simple filter weights
  --wid <x> : for --wblosum: set identity cutoff  [0.62]  (0<=x<=1)

Alternative effective sequence weighting strategies:
  --eent        : adjust eff seq # to achieve relative entropy target  [default]
  --enone       : no effective seq # weighting: just use nseq
  --ere <x>     : for --eent: set CM target relative entropy to <x>
  --eset <x>    : set eff seq # for all models to <x>
  --eminseq <x> : for --eent: set minimum effective sequence number to <x>  [0.1]
  --emaxseq <x> : for --eent: set maximum effective sequence number to <x>
  --ehmmre <x>  : for --eent: set minimum HMM relative entropy to <x>
  --esigma <x>  : for --eent: set sigma param to <x>  [45.0]

Options for HMM filter construction*:
  --p7ere <x> : for the filter p7 HMM, set minimum rel entropy/posn to <x>
  --p7ml      : define the filter p7 HMM as the ML p7 HMM

Options for HMM filter calibration*:
  --EmN <n>  : number of sampled seqs to use for p7 local MSV calibration  [200]
  --EvN <n>  : number of sampled seqs to use for p7 local Vit calibration  [200]
  --ElfN <n> : number of sampled seqs to use for p7 local Fwd calibration  [200]
  --EgfN <n> : number of sampled seqs to use for p7 glocal Fwd calibration  [200]

Options for refining the input alignment*:
  --refine <f> : refine input aln w/Expectation-Maximization, save to <f>
  -l           : w/--refine, configure model for local alignment [default: global]
  --gibbs      : w/--refine, use Gibbs sampling instead of EM
  --seed <n>   : w/--gibbs, set RNG seed to <n> (if 0: one-time arbitrary seed)
  --cyk        : w/--refine, use CYK instead of optimal accuracy
  --notrunc    : w/--refine, do not use truncated alignment algorithm
  --miss       : w/--refine, mark seqs w/terminal gaps as fragments

*Use --devhelp to show additional expert options.
```
## infernal_cmcalibrate

### Tool Description
fit exponential tails for CM E-values

### Metadata
- **Docker Image**: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
- **Homepage**: http://eddylab.org/infernal
- **Package**: https://anaconda.org/channels/bioconda/packages/infernal/overview
- **Validation**: PASS

### Original Help Text
```text
# cmcalibrate :: fit exponential tails for CM E-values
# INFERNAL 1.1.5 (Sep 2023)
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: cmcalibrate [-options] <cmfile>

Basic options:
  -h     : show brief help on version and usage
  -L <x> : set random seq length to search in Mb to <x>  [1.6]  (0.01<=x<=160.)

Options for predicting running time and memory requirements:
  --forecast      : don't do calibration, predict running time and exit
  --nforecast <n> : w/--forecast, predict time with <n> processors (maybe for MPI)
  --memreq        : don't do calibration, print required memory and exit
  --noforecast    : do calibration, but skip running time prediction

Options controlling exponential tail fits:
  --gtailn <n> : fit the top <n> hits/Mb in histogram for glocal modes [df: 250]
  --ltailn <n> : fit the top <n> hits/Mb in histogram for  local modes [df: 750]
  --tailp <x>  : set fraction of histogram tail to fit to exp tail to <x>

Optional output files:
  --hfile <f>  : save fitted score histogram(s) to file <f>
  --sfile <f>  : save survival plot to file <f>
  --qqfile <f> : save Q-Q plot for score histograms to file <f>
  --ffile <f>  : save lambdas for different tail fit probs to file <f>
  --xfile <f>  : save scores in fit tail to file <f>

Options controlling split, partition and merge modes:
  --split     : prepare partitioned calibration
  --cfile <f> : with --split, save file with commands for each partition to <f>
  --cbash     : with --split, output commands as a bash for loop script
  --proot <s> : with --split or --merge, root for partition output files is <s>
  --part <n>  : this is partition number <n> (1..<n2> from --ptot <n2>)  (n>0)
  --ptot <n>  : total number of partitions is <n>  (n>0)
  --pfile <f> : with --part, save scores to file <f>
  --merge     : merge scores from multiple partitions for calibration

Other options:
  --seed <n>  : set RNG seed to <n> (if 0: one-time arbitrary seed)
  --beta <x>  : set tail loss prob for query dependent banding (QDB) to <x>
  --nonbanded : do not use QDB
  --nonull3   : turn OFF the NULL3 post hoc additional null model
  --random    : use GC content of random null background model of CM
  --gc <f>    : use GC content distribution from file <f>
  --cpu <n>   : number of parallel CPU workers to use for multithreads
```
## infernal_cmpress

### Tool Description
prepare an CM database for faster cmscan searches

### Metadata
- **Docker Image**: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
- **Homepage**: http://eddylab.org/infernal
- **Package**: https://anaconda.org/channels/bioconda/packages/infernal/overview
- **Validation**: PASS

### Original Help Text
```text
# cmpress :: prepare an CM database for faster cmscan searches
# INFERNAL 1.1.5 (Sep 2023)
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: cmpress [-options] <cmfile>

Options:
  -h : show brief help on version and usage
  -F : force: overwrite any previous pressed files
```
