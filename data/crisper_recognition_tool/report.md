# crisper_recognition_tool CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| crisper_recognition_tool_crt | PASS |  |

## Metadata
- **Skill**: generated

## crisper_recognition_tool_crt

### Tool Description
Finds CRISPR repeat arrays in a FASTA genome sequence (run as crt crt [options] inputFile [outputFile]).

### Metadata
- **Docker Image**: quay.io/biocontainers/crisper_recognition_tool:1.2--py35_0
- **Homepage**: http://www.room220.com/crt/
- **Package**: https://anaconda.org/channels/bioconda/packages/crisper_recognition_tool/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  crt [options] inputFile [outputFile]

example:  crt ecoli.fna
example:  crt -minNR 4 -minRL 21 ecoli.fna a.out

OPTIONS
	-minNR		minimum number of repeats a CRISPR must contain; default 3
	-minRL		minimum length of a CRISPR's repeated region;  default 19
	-maxRL		maximum length of a CRISPR's repeated region;  default 38
	-minSL		minimum length of a CRISPR's non-repeated region (or spacer region);  default 19
	-maxSL		maximum length of a CRISPR's non-repeated region (or spacer region);  default 48
	-screen		print results to the screen, instead of a file; (range: 0-1); default 0
	-searchWL	length of search window used to discover CRISPRs; (range: 6-9); default 8
```
