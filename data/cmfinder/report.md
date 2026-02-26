# cmfinder CWL Generation Report

## cmfinder

### Tool Description
learning motif covariance model for unaligned sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/cmfinder:0.4.1.9--pl5.22.0_1
- **Homepage**: https://sourceforge.net/projects/weinberg-cmfinder/
- **Package**: https://anaconda.org/channels/bioconda/packages/cmfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cmfinder/overview
- **Total Downloads**: 19.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
cmfinder: learning motif covariance model for unaligned sequences

					   Usage: cmfinder [-options] <seqfile in> <cmfile output> 
					   where options are:
					   -c <candidate file>: the candidate file 
					   -a <align file>    : the initial motif alignment 
					   -i <cm file>       : the initial covariance model
					   -o <align file>    : the output motif structural alignment in stockholm format 
					   -v verbose         : print intermediate alignments 
						   -h                 : print short help and version info
					   
						Expert, in development, or infrequently used options are:
								--g <gap threshold> : the gap threshold to determine the conserved column
						--hmm               : apply HMM filter 
						--cmzasha           : apply cmzasha filter 
										--update            : Update instead of scanning for new candidates at each iteration 
						--informat <s>: specify that input alignment is in format <s>
						--fragmentary : account for fragmentary input sequences
```


## Metadata
- **Skill**: not generated
