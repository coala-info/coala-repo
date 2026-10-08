# disulfinder CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| disulfinder | PASS |  |

## disulfinder

### Tool Description
Predicts disulfide bonding state and connectivity from protein sequences.

### Metadata
- **Docker Image**: biocontainers/disulfinder:v1.2.11-8-deb_cv1
- **Homepage**: https://github.com/ajvenkat/disulfinder-test
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/disulfinder/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/ajvenkat/disulfinder-test
- **Stars**: N/A
### Original Help Text
```text
usage: disulfinder ...
	-f --fasta: input in fasta format, either as single file or directory
	-p --psi2: input in psi2 format, either a single file or a directory
	-i --input: file containing list of input files from directory
	            (assumes -p or -f specify a directory)
	-a --alternatives: alternative connectivity patterns (default=3)
	-F --format: output format type (ascii or html default=ascii)
	-o --output: output dir where predictions will be saved (default=PWD)
	-r --rootdir: predictor working directory (default=~/disulfinder)
	-k --pkgdatadir: predictor data directory (default=/usr/share/disulfinder)
	-d --blastdb: blastpgp -d option (default=/data/sp+trembl)
	-c --cleanpred: cleanup intermediate prediction files (default=false)
	-P --usepssm: use pssm instead of counts for profiles (default=false)
	-C --knownbondingstate: assume bonding state is known
	     (one file for each chain in directory <rootdir>/Predictions/Bondstate/Viterbi)	     (default=false)
	-v --version: disulfinder version
	-?, --help: this message
```


## Metadata
- **Skill**: not generated
