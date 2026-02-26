# multigps CWL Generation Report

## multigps

### Tool Description
MultiGPS version 0.74

Copyright (C) Shaun Mahony 2012-2016
<http://mahonylab.org/software/multigps>

MultiGPS comes with ABSOLUTELY NO WARRANTY.  This is free software, and you
are welcome to redistribute it under certain conditions.  See the MIT license 
for details.

### Metadata
- **Docker Image**: quay.io/biocontainers/multigps:0.74--r3.3.1_0
- **Homepage**: https://github.com/shaunmahony/multigps-archive
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/multigps/overview
- **Total Downloads**: 29.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shaunmahony/multigps-archive
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/multigps: line 3: iGPS: command not found
MultiGPS version 0.74


Copyright (C) Shaun Mahony 2012-2016
<http://mahonylab.org/software/multigps>

MultiGPS comes with ABSOLUTELY NO WARRANTY.  This is free software, and you
are welcome to redistribute it under certain conditions.  See the MIT license 
for details.

 OPTIONS:
 General:
	--out <output file prefix>
	--threads <number of threads to use (default=1)>
	--verbose [flag to print intermediate files and extra output]
	--config <config file: all options here can be specified in a name<space>value text file, over-ridden by command-line args>
 Genome:
	--geninfo <genome info file> AND --seq <fasta seq directory reqd if using motif prior>
 Loading Data:
	--expt <file name> AND --format <SAM/BED/SCIDX>
	--ctrl <file name (optional argument. must be same format as expt files)>
	--design <experiment design file name to use instead of --expt and --ctrl; see website for format>
	--fixedpb <fixed per base limit (default: estimated from background model)>
	--poissongausspb <filter per base using a Poisson threshold parameterized by a local Gaussian sliding window>
	--nonunique [flag to use non-unique reads]
	--mappability <fraction of the genome that is mappable for these experiments (default=0.8)>
	--nocache [flag to turn off caching of the entire set of experiments (i.e. run slower with less memory)]
Scaling control vs signal counts:
	--noscaling [flag to turn off auto estimation of signal vs control scaling factor]
	--medianscale [flag to use scaling by median ratio (default = scaling by NCIS)]
	--regressionscale [flag to use scaling by regression (default = scaling by NCIS)]
	--sesscale [flag to use scaling by SES (default = scaling by NCIS)]
	--fixedscaling <multiply control counts by total tag count ratio and then by this factor (default: NCIS)>
	--scalewin <window size for scaling procedure (default=10000)>
	--plotscaling [flag to plot diagnostic information for the chosen scaling method]
 Running MultiGPS:
	--d <binding event read distribution file>
	--r <max. model update rounds, default=3>
	--nomodelupdate [flag to turn off binding model updates]
	--minmodelupdateevents <minimum number of events to support an update (default=500)>
	--nomodelsmoothing [flag to turn off binding model smoothing]
	--splinesmoothparam <spline smoothing parameter (default=30)>
	--gaussmodelsmoothing [flag to turn on Gaussian model smoothing (default = cubic spline)]
	--gausssmoothparam <Gaussian smoothing std dev (default=3)>
	--jointinmodel [flag to allow joint events in model updates (default=do not)]
	--fixedmodelrange [flag to keep binding model range fixed to inital size (default: vary automatically)]
	--prlogconf <Poisson log threshold for potential region scanning(default=-6)>
	--alphascale <alpha scaling factor(default=1.0>
	--fixedalpha <impose this alpha (default: set automatically)>
	--mlconfignotshared [flag to not share component configs in the ML step]
	--exclude <file of regions to ignore>
 MultiGPS priors:
	--noposprior [flag to turn off inter-experiment positional prior (default=on)]
	--probshared <probability that events are shared across conditions (default=0.9)>
	--nomotifs [flag to turn off motif-finding & motif priors]
	--nomotifprior [flag to turn off motif priors only]
	--memepath <path to the meme bin dir (default: meme is in $PATH)>
	--memenmotifs <number of motifs MEME should find for each condition (default=3)>
	--mememinw <minw arg for MEME (default=6)>
	--mememaxw <maxw arg for MEME (default=18)>
	--memeargs <additional args for MEME (default=  -dna -mod zoops -revcomp -nostatus)>
	--meme1proc [flag to enforce non-parallel version of MEME]
 Reporting binding events:
	--q <Q-value minimum (default=0.001)>
	--minfold <minimum event fold-change vs scaled control (default=1.5)>
	--nodifftests [flag to turn off differential enrichment tests]
	--rpath <path to the R bin dir (default: R is in $PATH). Note that you need to install edgeR separately>
	--edgerod <EdgeR overdispersion parameter (default=0.15)>
	--diffp <minimum p-value for reporting differential enrichment (default=0.01)>
	--eventsaretxt [add .txt to events file extension]
```


## Metadata
- **Skill**: generated
