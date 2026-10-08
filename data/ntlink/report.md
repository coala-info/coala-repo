# ntlink CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ntlink_ntLink | PASS |  |
| ntlink_ntLink_rounds | PASS |  |

## ntlink_ntLink

### Tool Description
ntLink: Scaffolding assemblies using long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/ntlink:1.3.11--py312h7896c42_1
- **Homepage**: https://github.com/bcgsc/ntLink
- **Package**: https://anaconda.org/channels/bioconda/packages/ntlink/overview
- **Validation**: PASS

### Original Help Text
```text
ntLink: Scaffolding assemblies using long reads
ntLink v1.3.11
Usage: ntLink scaffold target=<target scaffolds> reads='List of long read files'

To additionally run gap-filling (fill gap regions with raw read sequence):
Usage: ntLink scaffold gap_fill target=<target scaffolds> reads='List of long read files'

Options:
target			Target assembly to be scaffolded in fasta format
reads			List of long read files (separated by a space)
prefix			Prefix of intermediate output files [<target>.k<k>.w<w>.z<z>]
t			Number of threads [4]
k			K-mer size for minimizers [32]
w			Window size for minimizers [100]
n			Minimum graph edge weight [1]
g			Minimum gap size (bp) [20]
G			Maximum gap size (bp). -1 indicates no maximum [-1]
f			Maximum number of contigs in a run for full transitive edge addition [10]
a			Minimum number of anchored ONT reads required for an edge [1]
z			Minimum size of contig (bp) to scaffold [1000]
v			If 1, track time and memory for each step of the pipeline [0]
paf			If True, outputs read to contig mappings in PAF-like format [False]
overlap			If True, runs extra step to attempt to identify and trim overlapping joined sequences [True]
sensitive	        If True, runs mapping in sensitive mode [False]
soft_mask		If True, gaps are filled with lowercase bases [False]

Note: 
	- Ensure all assembly and read files are in the current working directory, making soft links if necessary
```

## ntlink_ntLink_rounds

### Tool Description
ntLink: Scaffolding assemblies using long reads - running iterative rounds of ntLink

### Metadata
- **Docker Image**: quay.io/biocontainers/ntlink:1.3.11--py312h7896c42_1
- **Homepage**: https://github.com/bcgsc/ntLink
- **Package**: https://anaconda.org/channels/bioconda/packages/ntlink/overview
- **Validation**: PASS

### Original Help Text
```text
ntLink: Scaffolding assemblies using long reads - running iterative rounds of ntLink
ntLink v1.3.11
Running rounds of ntLink - no gap-filling
Usage: ntLink_rounds run_rounds target=<target scaffolds> reads='List of long read files' rounds=<Number>

Running rounds of ntLink - with gap-filling
Usage: ntLink_rounds run_rounds_gaps target=<target scaffolds> reads='List of long read files' rounds=<Number>

Options:
rounds       Number of rounds of ntLink [5]

See main ntLink file for full additional options

Note: 
	- Ensure all assembly and read files are in the current working directory, making soft links if necessary
	- The prefix parameter can not be changed from default for running rounds with ntLink_rounds
```

## Metadata
- **Skill**: generated
