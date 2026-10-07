# control-freec CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| control-freec_freec | PASS | Tumour/normal chr21 BAMs gave copy-number calls with the control used; the -control command-line option is ignored by freec 11.6, so the control is set via mateFile in the config. |

## control-freec_freec

### Tool Description
a method for automatic detection of copy number alterations, subclones and for accurate estimation of contamination and main ploidy using deep-sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/control-freec:11.6--hdbdd923_3
- **Homepage**: https://github.com/BoevaLab/FREEC
- **Package**: https://anaconda.org/channels/bioconda/packages/control-freec/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/control-freec/overview
- **Total Downloads**: 34.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BoevaLab/FREEC
- **Stars**: N/A
### Original Help Text
```text
Control-FREEC v11.6 : a method for automatic detection of copy number alterations, subclones and for accurate estimation of contamination and main ploidy using deep-sequencing data
Usage:

	freec -conf <config file>

	See config.txt for example
	or
	freec -conf <config file> -sample <mySample.bam> -control <myControl.bam>

	See config.txt for example
```

