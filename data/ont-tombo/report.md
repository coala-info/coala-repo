# ont-tombo CWL Generation Report

## ont-tombo_tombo

### Tool Description
Tombo is a suite of tools primarily for the identification of modified nucleotides from nanopore sequencing data.
Tombo also provides tools for the analysis and visualization of raw nanopore signal.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Total Downloads**: 75.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nanoporetech/tombo
- **Stars**: N/A
### Original Help Text
```text
usage: tombo [-h] [-v]
             {resquiggle,preprocess,filter,detect_modifications,text_output,build_model,plot}
             ...

********** Tombo *********

Tombo is a suite of tools primarily for the identification of modified nucleotides from nanopore sequencing data.

Tombo also provides tools for the analysis and visualization of raw nanopore signal.

Tombo command groups (additional help available within each command group):
	resquiggle               Re-annotate raw signal with genomic alignment from existing basecalls.
	preprocess               Pre-process nanopore reads for Tombo processing.
	filter                   Apply filter to Tombo index file for specified criterion.
	detect_modifications     Perform statistical testing to detect non-standard nucleotides.
	text_output              Output Tombo results in text files.
	build_model              Create canonical and alternative base Tombo models.
	plot                     Save plots to visualize raw nanopore signal or testing results.

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show Tombo version and exit.
```

