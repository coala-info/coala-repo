# clove CWL Generation Report

## clove

### Tool Description
CLOVE: Structural variant classification tool

### Metadata
- **Docker Image**: quay.io/biocontainers/clove:0.17--hdfd78af_2
- **Homepage**: https://github.com/PapenfussLab/clove
- **Package**: https://anaconda.org/channels/bioconda/packages/clove/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clove/overview
- **Total Downloads**: 7.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PapenfussLab/clove
- **Stars**: N/A
### Original Help Text
```text
Options (all mandatory -- input can be specified more than once):
	-i <list of breakpoints> <algorithm (Socrates/Delly/Delly2/Crest/Gustaf/BEDPE/GRIDSS)>
	-b <BAM file> 
	-c <mean coverage> <coverage>
	-o <output filename> [default: CLOVE.vcf]
	-r Do not perform read depth check. This option will lead all deletions and tandem 
	   duplications to fail, but runs a lot faster. Use to get an idea about complex 
	   variants only.
```

