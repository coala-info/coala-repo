# aprfinder CWL Generation Report

## aprfinder

### Tool Description
tool for a-phased repeat search.

### Metadata
- **Docker Image**: quay.io/biocontainers/aprfinder:1.5--h7b50bb2_3
- **Homepage**: https://github.com/jaroslav-kubin/aprfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/aprfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aprfinder/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jaroslav-kubin/aprfinder
- **Stars**: N/A
### Original Help Text
```text
aprfinder v1.4.1 - tool for a-phased repeat search.
Usage:
aprfinder [--help] [--input=<string>] [--output=<string>] [--upper-bound=<int>] [--lower-bound=<int>]
          [--max-AT=<int>] [--min-AT=<int>] [--max-tracks=<int>] [--min-tracks=<int>] [--memory-size=<int>]
          [--exact-bound=<int>] [--exact-tracks=<int>] [--exact-AT=<int>]
options:
--help              	Prints information about the software.
--input <string>    	Input FASTA or MULTIFASTA file.
--output <string>   	Defines output file name. Note that <string> should be in format <name>.gff.
                    	If not defined, output is set to result.gff. (Be carefull - running multiple times
                    	without this option can overwrite the previous result)
--upper-bound <int> 	Maximum size of spacer.
--lower-bound <int> 	Minimum size of spacer.
--exact-bound <int> 	Sets lower-bound and upper-bound to the same value.
--max-AT <int>      	Maximum number of consecutive A/T nucleotides.
--min-AT <int>      	Minimum number of consecutive A/T nucleotides.
--exact-AT <int>    	Sets max-AT and min-AT to the same value.
--min-tracks <int>  	Minimum number of tracks to consider a sequence to be an a-phased repeat.
--max-tracks <int>  	Minimum number of tracks to consider a sequence to be an a-phased repeat.
--exact-tracks <int>	Sets min-tracks and max-tracks to the same value.
```


## Metadata
- **Skill**: generated
