# sem CWL Generation Report

## sem

### Tool Description
SEM (Subnucleosomal Ensemble Mapping) for nucleosome detection and fragment size distribution analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/sem:1.2.3--hdfd78af_0
- **Homepage**: https://github.com/YenLab/SEM
- **Package**: https://anaconda.org/channels/bioconda/packages/sem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sem/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/YenLab/SEM
- **Stars**: N/A
### Original Help Text
```text
WARNING: please provide chromosome length information in a genome info file (option --geninfo). MultiGPS will attempt to estimate chromosome lengths from data, but this may not work or may not be accurate.

███████╗███████╗███╗   ███╗
██╔════╝██╔════╝████╗ ████║
███████╗█████╗  ██╔████╔██║
╚════██║██╔══╝  ██║╚██╔╝██║
███████║███████╗██║ ╚═╝ ██║
╚══════╝╚══════╝╚═╝     ╚═╝
                           

Copyright (C) Jianyu Yang 2019-2023

version 1.2.3

SEM comes with ABSOLUTELY NO WARRANTY.  This is free software, and you
are welcome to redistribute it under certain conditions.  See the MIT license 
for details.

For detailed input format description and usage, please refer to <https://github.com/YenLab/SEM>,
also feel free to open new issues on features or bugs!

 OPTIONS:
 Required:
	--out <output file prefix>
	--geninfo <genome info file> AND --seq <fasta seq directory reqd if using motif prior>
	--expt <file name> AND --format <SAM/BED/SCIDX>
	OR
	--design <experiment design file name to use instead of --expt and --ctrl; see website for format>
 General:
	--threads <number of threads to use (default=1)>
	--verbose [flag to print intermediate files and extra output]
	--config <config file: all options here can be specified in a name<space>value text file, over-ridden by command-line args>
 Genome:
	--providedPotenialRegions <bed file to restrict nucleosome detection regions>
 Loading Data:
	--nonunique [flag to use non-unique reads]
	--mappability <fraction of the genome that is mappable for these experiments (default=0.8)>
	--nocache [flag to turn off caching of the entire set of experiments (i.e. run slower with less memory)]
 Detecting nucleosome type:
	--numClusters <number of nucleosome types> 
		number of clusters for finite GMM on fragment size distribution, if set -1, GMM with Dirichlet prior will be used to determine number of types
	--providedBindingSubtypes <custom binding subtypes (format: mean variance weight, sum of weights = 1)>
	--onlyGMM <only Run GMM without the following nucleosome calling steps, use it to optimize nucleosome subtype parameters> Running SEM:
	--r <max. model update rounds, default=3>
	--alphascale <alpha scaling factor(default=1.0>
	--fixedalpha <minimum number of fragments a nucleosome should have (default=1, must >= 1)>
	--exclude <file of regions to ignore>
	--consensusExclusion <consensus exclusion zone>
 Miscellaneous:
	--bmanalysiswindowmax <Preferred potential region length, default=50000>
```

