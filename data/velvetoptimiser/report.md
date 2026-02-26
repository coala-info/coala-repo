# velvetoptimiser CWL Generation Report

## velvetoptimiser

### Tool Description
Velvet optimiser assembly optimisation function can be built from the following variables.

### Metadata
- **Docker Image**: biocontainers/velvetoptimiser:v2.2.6-2-deb_cv1
- **Homepage**: https://github.com/tseemann/VelvetOptimiser
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/velvetoptimiser/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/tseemann/VelvetOptimiser
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/bin/velvetoptimiser [options] -f 'velveth input line'
  --help          This help.
  --version!      Print version to stdout and exit. (default '0').
  --v|verbose+    Verbose logging, includes all velvet output in the logfile. (default '0').
  --s|hashs=i     The starting (lower) hash value (default '19').
  --e|hashe=i     The end (higher) hash value (default '31').
  --x|step=i      The step in hash search..  min 2, no odd numbers (default '2').
  --f|velvethfiles=s The file section of the velveth command line. (default '0').
  --a|amosfile!   Turn on velvet's read tracking and amos file output. (default '0').
  --o|velvetgoptions=s Extra velvetg options to pass through.  eg. -long_mult_cutoff -max_coverage etc (default '').
  --t|threads=i   The maximum number of simulataneous velvet instances to run. (default '20').
  --g|genomesize=f The approximate size of the genome to be assembled in megabases.
			Only used in memory use estimation. If not specified, memory use estimation
			will not occur. If memory use is estimated, the results are shown and then program exits. (default '0').
  --k|optFuncKmer=s The optimisation function used for k-mer choice. (default 'n50').
  --c|optFuncCov=s The optimisation function used for cov_cutoff optimisation. (default 'Lbp').
  --m|minCovCutoff=f The minimum cov_cutoff to be used. (default '0').
  --p|prefix=s    The prefix for the output filenames, the default is the date and time in the format DD-MM-YYYY-HH-MM_. (default 'auto').
  --d|dir_final=s The name of the directory to put the final output into. (default '.').
  --z|upperCovCutoff=f The maximum coverage cutoff to consider as a multiplier of the expected coverage. (default '0.8').

Advanced!: Changing the optimisation function(s)

Velvet optimiser assembly optimisation function can be built from the following variables.
	LNbp = The total number of Ns in large contigs
	Lbp = The total number of base pairs in large contigs
	Lcon = The number of large contigs
	max = The length of the longest contig
	n50 = The n50
	ncon = The total number of contigs
	tbp = The total number of basepairs in contigs
Examples are:
	'Lbp' = Just the total basepairs in contigs longer than 1kb
	'n50*Lcon' = The n50 times the number of long contigs.
	'n50*Lcon/tbp+log(Lbp)' = The n50 times the number of long contigs divided
		by the total bases in all contigs plus the log of the number of bases
		in long contigs.
```

