# edlib-aligner CWL Generation Report

## edlib-aligner

### Tool Description
Align sequences from queries.fasta to target.fasta

### Metadata
- **Docker Image**: biocontainers/edlib-aligner:v1.2.4-1-deb_cv1
- **Homepage**: https://github.com/Martinsos/edlib/
- **Package**: https://anaconda.org/channels/bioconda/packages/edlib/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/edlib-aligner/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/Martinsos/edlib
- **Stars**: N/A
### Original Help Text
```text
Usage: edlib-aligner [options...] <queries.fasta> <target.fasta>
Options:
	-s  If specified, there will be no score or alignment output (silent mode).
	-m HW|NW|SHW  Alignment mode that will be used. [default: NW]
	-n N  Score will be calculated only for N best sequences (best = with smallest score). If N = 0 then all sequences will be calculated. Specifying small N can make total calculation much faster. [default: 0]
	-k K  Sequences with score > K will be discarded. Smaller k, faster calculation. If -1, no sequences will be discarded. [default: -1]
	-p  If specified, alignment path will be found and printed. This may significantly slow down the calculation.
	-l  If specified, start locations will be found and printed. Each start location corresponds to one end location. This may somewhat slow down the calculation, but is still faster then finding alignment path and does not consume any extra memory.
	-f NICE|CIG_STD|CIG_EXT  Format that will be used to print alignment path, can be used only with -p. NICE will give visually attractive format, CIG_STD will  give standard cigar format and CIG_EXT will give extended cigar format. [default: NICE]
	-r N  Core part of calculation will be repeated N times. This is useful only for performance measurement, when single execution is too short to measure. [default: 1]
```


## Metadata
- **Skill**: generated
