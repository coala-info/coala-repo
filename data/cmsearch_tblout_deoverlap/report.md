# cmsearch_tblout_deoverlap CWL Generation Report

## cmsearch_tblout_deoverlap_cmsearch-deoverlap.pl

### Tool Description
Remove overlapping hits from cmsearch, cmscan, nhmmer, or hmmsearch tblout files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cmsearch_tblout_deoverlap:0.09--pl5321hdfd78af_0
- **Homepage**: https://github.com/nawrockie/cmsearch_tblout_deoverlap
- **Package**: https://anaconda.org/channels/bioconda/packages/cmsearch_tblout_deoverlap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cmsearch_tblout_deoverlap/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nawrockie/cmsearch_tblout_deoverlap
- **Stars**: N/A
### Original Help Text
```text
cmsearch-deoverlap v0.09 [Aug 2023]

Usage:

cmsearch-deoverlap.pl    [OPTIONS] <tblout file>
	OR
cmsearch-deoverlap.pl -l [OPTIONS] <list of tblout files>

	OPTIONS:
		-l               : single command line argument is a list of tblout files, not a single tblout file
		-s               : sort hits by bit score [default: sort by E-value]
		-d               : run in debugging mode (prints extra info)
		-v               : run in verbose mode (prints all removed and kept hits)
		--noverlap <n>   : define an overlap as >= <n> or more overlapping residues [1]
		--nhmmer         : tblout files are from nhmmer v3.x
		--hmmsearch      : tblout files are from hmmsearch v3.x
		--cmscan         : tblout files are from cmscan v1.1x, not cmsearch
		--fcmsearch      : assert tblout files are cmsearch not cmscan
		--besthmm        : with --hmmsearch, sort by evalue/score of *best* single hit not evalue/score of full seq
		--clanin <s>     : only remove overlaps within clans, read clan info from file <s> [default: remove all overlaps]
		--invclan        : w/--clanin, invert clan behavior: do not remove overlaps within clans, remove all other overlaps
		--maxkeep        : keep hits that only overlap with other hits that are not kept [default: remove all hits with higher scoring overlap]
		--overlapout <s> : create new tabular file with overlap information in <s>
		--mdllenin <s>   : w/--overlapout, read model lengths from two-token-per-line-file <s>
		--dirty          : keep intermediate files (sorted tblout files)
```

