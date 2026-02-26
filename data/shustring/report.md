# shustring CWL Generation Report

## shustring

### Tool Description
compute shortest unique substrings

### Metadata
- **Docker Image**: quay.io/biocontainers/shustring:2.6--h7b50bb2_8
- **Homepage**: https://github.com/CaliforniaEvolutionInsititue/Shustringer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shustring/overview
- **Total Downloads**: 13.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CaliforniaEvolutionInsititue/Shustringer
- **Stars**: N/A
### Original Help Text
```text
# unknown argument: -
shustring version 2.6, copyright (c) 2005-2008 Bernhard Haubold & Thomas Wiehe
	distributed under the GNU General Public License
purpose: compute shortest unique substrings
usage: shustring [options]
options
  input/output
	[-i <FILE> input file; default: FILE=stdin]
	[-o <FILE> write output to FILE; default: FILE=stdout]
  suffix array mode
	[-l <PATTERN> - print local shustrings for PATTERN; default: global]
	[-M <NUM> shustring length <= NUM (with -l only); default: find all]
	[-m <NUM> shustring length >= NUM (with -l only); default: find all]
  hash mode
	[-a hash mode (requires -i, implies -n); default: suffix array mode]
	[-f <NUM> fixed word length NUM (with -a only); default: look for shortest]
  general
	[-q quiet - do not print shustrings; default: print shustrings]
	[-n nucleotide sequence (DNA); default: arbitrary ASCII strings]
	[-r include reverse complement (implies -n); default: only forward strand]
	[-u preserve IUPAC nomenclature in nucleotide sequences; default: convert to ACGT]
	[-p print information about program]
	[-h print this help message]
```


## Metadata
- **Skill**: generated
