# vphaser2 CWL Generation Report

## vphaser2

### Tool Description
Phases variants in a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vphaser2:2.0--h2bd4fab_16
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vphaser2/overview
- **Total Downloads**: 28.2K
- **Last updated**: 2025-11-25
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
input BAM file is unspecified

--------------------------------------------------------
Usage: vphaser2
	-i  [input.bam] -- input sorted bam file
	-o	[output DIR] -- output directory
	-e	[1 or 2] -- default 1; 1: pileup + phasing; 2: pileup
	-w	-- default 500; alignment window size
	-ig	-- default 0; # of bases to ignore on both end of a read
	-delta	-- default 2; constrain PE distance by delta x fragsize_variation (auto measured by program)
	-ps	(0, 100] -- default 30; percentage of reads to sample to get stats.
	-dt	[0 or 1] -- default 1; 1: dinucleotide for err prob measure; 0: not
	-cy	[0 or 1] -- default 1; 1: read cycle for err calibr; 0: not
	-mp	[0 or 1] -- default 1; 1: mate-pair for err calibr; 0: not
	-qual [0, 40] -- default 20; quantile of qual for err calibr
	-a	-- default 0.05; significance value for stat test
----------------------------------------------------------
```


## Metadata
- **Skill**: generated
