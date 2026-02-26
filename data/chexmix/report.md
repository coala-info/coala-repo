# chexmix CWL Generation Report

## chexmix

### Tool Description
ChExMix is a tool for identifying and characterizing binding events and subtypes from ChIP-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/chexmix:0.52--hdfd78af_0
- **Homepage**: http://mahonylab.org/software/chexmix/
- **Package**: https://anaconda.org/channels/bioconda/packages/chexmix/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chexmix/overview
- **Total Downloads**: 13.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
ChExMix version 0.52


Copyright (C) Naomi Yamada 2018
Further documentation: <http://mahonylab.org/software/chexmix>

ChExMix comes with ABSOLUTELY NO WARRANTY.  This is free software, and you
are welcome to redistribute it under certain conditions.  See the MIT license 
for details.

 OPTIONS:
 General:
	--out <output file prefix>
	--threads <number of threads to use (default=1)>
	--verbose [flag to print intermediate files and extra output]
	--config <config file: all options here can be specified in a name<space>value text file, over-ridden by command-line args>
 Genome:
	--geninfo <genome info file> AND --seq <fasta seq directory reqd if finding motif>
	--back <Markov background model file reqd if finding motif>
 Loading Data:
	--expt <file name> AND --format <SAM/BED/IDX>
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
 Running ChExMix:
	--round <max. model update rounds (default=3)>
	--bmwindowmax <max. window size for running a mixture model over binding events (default=2000)>
	--nomodelupdate [flag to turn off binding model updates]
	--minmodelupdateevents <minimum number of events to support an update using read distributions (default=100)>
	--prlogconf <Poisson log threshold for potential region scanning (default=-6)>
	--fixedalpha <binding events must have at least this number of reads (default: set automatically)>
	--alphascale <alpha scaling factor; increase for stricter event calls (default=1.0)>
	--betascale <beta scaling factor; sparse prior on subtype assignment (default=0.05)>
	--epsilonscale <epsilon scaling factor; increase for more weight on motif in subtype assignment (default=0.2)>
	--minsubtypefrac <subtypes must have at least this percentage of associated binding events; increase for fewer subtypes (default=0.05)>
	--peakf <file of peaks to initialize component positions>
	--exclude <file of regions to ignore> OR --excludebed <file of regions to ignore in bed format>
	--galaxyhtml [flag to produce a html output appropreate for galaxy]
 Binding event reporting mode (which events to put into .events file):
	--standard [report events that pass significance threshold in condition as a whole (default mode)]
	--lenient [report events that pass significance in >=1 replicate *or* the condition as a whole.]
	--lenientplus [report events that pass significance in condition OR (>=1 replicate AND no signif diff between replicates)]
 Finding ChExMix subtypes using motif:
	--motfile <file of motifs in transfac format to initialize subtype motifs>
	--memepath <path to the meme bin dir (default: meme is in $PATH)>
	--nomotifs [flag to turn off motif-finding & motif priors]
	--nomotifprior [flag to turn off motif priors only]
	--memenmotifs <number of motifs MEME should find for each condition (default=3)>
	--mememinw <minw arg for MEME (default=6)>
	--mememaxw <maxw arg for MEME (default=18)>
	--memeargs <additional args for MEME (default=  -dna -mod zoops -revcomp -nostatus)>
	--minroc <minimum motif ROC value (default=0.7)>
	--minmodelupdaterefs <minimum number of motif reference to support an subtype distribution update (default=50)>
	--noupdateinitmotifs [flag to leave initial motifs (provided by --motfile) fixed]
	--seqrmthres <Filter out sequences with motifs below this threshold for recursively finding motifs (default=0.1)>
	--motifpccthres <motif length adjusted similarity threshold for merging subtypes using motifs; decrease for fewer subtypes (default=0.95)>
 Finding ChExMix subtypes using read distribution clustering:
	--noclustering [flag to turn off read distribution clustering]
	--pref <preference value for read distribution clustering (default=-0.1)>
	--numcomps <number of components to cluster (default=500)>
	--win <window size of read profiles (default=150)>
	--kldivergencethres <KL divergence dissimilarity threshold for merging subtypes using read distributions; increase for fewer subtypes (default=-10)>
 Reporting binding events:
	--q <Q-value minimum (default=0.01)>
	--minfold <minimum event fold-change vs scaled control (default=1.5)>
```

