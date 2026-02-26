# ripcal CWL Generation Report

## ripcal

### Tool Description
RIPCAL help...

### Metadata
- **Docker Image**: quay.io/biocontainers/ripcal:2.0--hdfd78af_0
- **Homepage**: https://sourceforge.net/projects/ripcal
- **Package**: https://anaconda.org/channels/bioconda/packages/ripcal/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ripcal/overview
- **Total Downloads**: 946
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
RIPCAL help...
Options:
	-seq OR -s		input sequence file [fasta or clustalw format] (REQUIRED)
	-gff OR -g		input gff file
	-help OR -h		RIPCAL options help
	-command OR -c		use command line interface
	-type OR -t		RIP analysis type [align|index|scan] (Default: align)
	-model OR -m		Alignment model [gc|consensus|user] (default=gc)
	windowsize OR -z		Alignment RIP frequency graph window

If -fasta and -gff selected, the input is assumed to contain multiple repeat families
If -fasta only the input is assumed to contain a single repeat family.
If -m=user models are interpreted as the first sequence in the alignment for single family inputs
single repeat family, aligned RIP analysis also accepts prealigned input in FASTA OR CLUSTALW format


RIP index scan options (-type = scan):
	-l		Length of scanning subsequence (default = 300)
	-i		Scanning subsequence increment (default = 150)
	-q		TpA/ApT threshold (default >= 0.89)
	-w		CpA+TpG/ApC+GpT threshold (default <= 1.03)
	-e		CpA+TpG/TpA threshold (<=)
	-r		CpC+GpG/TpC+GpA threshold (<=)
	-y		CpG/TpG+CpA threshold (<=)
	-u		CpT+ApG/TpT+ApA threshold (<=)
	disable index options by setting to 0
```


## Metadata
- **Skill**: generated
