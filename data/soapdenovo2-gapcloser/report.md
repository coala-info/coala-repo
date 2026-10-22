# soapdenovo2-gapcloser CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| soapdenovo2-gapcloser_GapCloser | Not completed | CWL runs and writes outputs, but the tool closed no gap (finish gap count 0) on real SARS-CoV-2 reads with a planted gap, so the result is not confirmed; added library file staging and outputs |

## soapdenovo2-gapcloser_GapCloser

### Tool Description
GapCloser is a tool for closing gaps in assembled sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/soapdenovo2-gapcloser:1.12--h077b44d_3
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/soapdenovo2-gapcloser/overview
- **Total Downloads**: 9.0K
- **Last updated**: 2025-09-25
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
[Error] Can not open input file.

Version:
	1.12

Contact:
	soap@genomics.org.cn

Usage:
	GapCloser [options]
	-a	<string>	input scaffold file name, required.
	-b	<string>	input library info file name, required.
	-o	<string>	output file name, required.
	-l	<int>		maximum read length (<=155), default=100.
	-p	<int>		overlap param(<=31), default=25.
	-t	<int>		thread number, default=1.
	-h	-?		output help information.
```

