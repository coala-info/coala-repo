# parallel-meta-suite CWL Generation Report

## parallel-meta-suite_PM-pipeline

### Tool Description
Parallel-Meta Suite Pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Stars**: N/A
### Original Help Text
```text
Welcome to Parallel-Meta Suite Pipeline
Version: 3.7Alpha
Usage: 
PM-pipeline [Option] Value
Options: 

	-D (upper) ref database, Empty database
	-m Meta data file [Required]

	[Input options, required]
	  -i Sequence files list, pair-ended sequences are supported [Conflicts with -l]
	  -p List file path prefix [Optional for -i]
	or
	  -l Taxonomic analysis results list [Conflicts with -i]
	  -p List file path prefix [Optional for -l]
	or
	  -T (upper) Input OTU count table (*.OTU.Count) [Conflicts with -i]

	[Output options]
	  -o Output path, default is "default_out"

	[Profiling parameters]
	  -M (upper) Sequence type, T (Shotgun) or F (rRNA), default is F
	  -r rRNA copy number correction, T(rue) or F(alse), default is T
	  -a rRNA length threshold of rRNA extraction. 0 is disabled, default is 0 [optional for -M T]
	  -k Sequence format check, T(rue) or F(alse), default is F
	  -f Functional analysis, T(rue) or F(alse), default is T
	  -v ASV denoising, T(rue) or F(alse), default is T [optional for -i]
	  -c Chimera removal, T(rue) or F(alse), default is T [optional for -i]
	  -d Sequence alignment threshold (float value 0~1), default is 0.99 for ASV enabled and 0.97 for ASV disabled (-v F) [optional for -i]

	[Statistic parameters]
	  -L (upper) Taxonomical levels (1-6: Phylum - Species). Multiple levels are accepted
	  -w Taxonomical distance type, 0: weighted, 1: unweigthed, 2: both, default is 2
	  -F (upper) Functional levels (Level 1, 2, 3 or 4 (KO number)). Multiple levels are accepted
	  -s Sequence number normalization depth, 0 is disabled, default is disable
	  -b Bootstrap for sequence number normalization, default is 200, maximum is 1000
	  -R (upper) Rarefaction curve, T(rue) or F(alse), default is F
	  -E (upper) If the samples are paired, T(rue) or F(alse), default is F
	  -C (upper) Cluster number, default is 2
	  -G (upper) Network analysis edge threshold, default is 0.5

	[Other options]
	  -t Number of thread, default is auto
	  -h help
```

