# infernal CWL Generation Report

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
