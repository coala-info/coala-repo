# corset CWL Generation Report

## corset

### Tool Description
Corset clusters contigs and counts reads from de novo assembled transcriptomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/corset:1.09--h077b44d_6
- **Homepage**: https://github.com/Oshlack/Corset
- **Package**: https://anaconda.org/channels/bioconda/packages/corset/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/corset/overview
- **Total Downloads**: 17.2K
- **Last updated**: 2025-09-26
- **GitHub**: https://github.com/Oshlack/Corset
- **Stars**: N/A
### Original Help Text
```text
Running Corset Version 1.09

Corset clusters contigs and counts reads from de novo assembled transcriptomes.

Usage: corset [options] <input bam files>

Input bam files:
	 The input files should be multi-mapped bam files. They can be single, paired-end or mixed
	 and do not need to be indexed. A space separated list should be given.
	 e.g. corset sample1.bam sample2.bam sample3.bam
	 or just: corset sample*.bam

	 If you want to combine the results from different transcriptomes. i.e. the same reads have 
	 been mapped twice or more, you can used a comma separated list like below:
	 corset sample1_Trinity.bam,sample1_Oases.bam sample2_Trinity.bam,sample2_Oases.bam ...

Options are:

	 -d <double list> A comma separated list of distance thresholds. The range must be
	                  between 0 and 1. e.g -d 0.4,0.5. If more than one distance threshold
	                  is supplied, the output filenames will be of the form:
	                  counts-<threshold>.txt and clusters-<threshold>.txt 
	                  Default: 0.3

	 -D <double>      The value used for thresholding the log likelihood ratio. The default 
	                  value will depend on the number of degrees of freedom (which is the 
	                  number of groups -1). By default D = 17.5 + 2.5 * ndf, which corresponds 
	                  approximately to a p-value threshold of 10^-5, when there are fewer than
	                  10 groups.

	 -I               Switches off the log likelihood ratio test and should be used 
	                  for downstream differential transcript usage analysis. It will prevent 
	                  differentially expressed transcript being split into different clusters. 
	                  This option is the equivalent of setting -D to a very large number.  
	                  Default: log likelihood ratio test on

	 -m <int>         Filter out any transcripts with fewer than this many reads aligning.
	                  Default: 10

	 -g <list>        Specifies the grouping. i.e. which samples belong to which experimental
	                  groups. The parameter must be a comma separated list (no spaces), with the 
	                  groupings given in the same order as the bam filename. For example:
	                  -g Group1,Group1,Group2,Group2 etc. If this option is not used, each sample
	                  is treated as an independent experimental group.

	 -p <string>      Prefix for the output filenames. The output files will be of the form
	                  <prefix>-counts.txt and <prefix>-clusters.txt. Default filenames are:
	                  counts.txt and clusters.txt

	 -f <true/false>  Specifies whether the output files should be overwritten if they already exist.
	                  Default: false

	 -n <string list> Specifies the sample names to be used in the header of the output count file.
	                  This should be a comma separated list without spaces.
	                  e.g. -n Group1-ReplicateA,Group1-ReplicateB,Group2-ReplicateA etc.
	                  Default: the input filenames will be used.

	 -r <true/true-stop/false> 
	                  Output a file summarising the read alignments. This may be used if you
	                  would like to read the bam files and run the clustering in seperate runs
	                  of corset. e.g. to read input bam files in parallel. The output will be the
	                  bam filename appended with .corset-reads.
	                  Default: false

	 -i <bam/corset/salmon_eq_classes>  The input file type. Use -i corset, if you previously ran
	                  corset with the -r option and would like to restart using those
	                  read summary files. Use salmon_eq_classes, if you aligned with salmon with
	                  the flag --dumpEq and are passing corset the equivalent class files.
	                  Running with either -i corset or salmon_eq_classes will switch off the -r option.
	                  Default: bam

	 -l <int>         If running with -i corset or salmon_eq_classes, this will filter out a link between contigs
	                  if the link is supported by less than this many reads (performed sample-wise). Reads will 
	                  be reassigned uniformly to the contigs in the equivalence class. This option will
	                  improve runtime and memory usage, but will increase the number of clusters reported.
	                  Default: 1 (no filtering)

	 -x <int>         If running with -i corset or salmon_eq_classes, this option will filter out reads that
	                  align to more than x contigs. Default: no filtering

Citation: Nadia M. Davidson and Alicia Oshlack, Corset: enabling differential gene expression 
          analysis for de novo assembled transcriptomes, Genome Biology 2014, 15:410

Please see https://github.com/Oshlack/Corset/wiki for more information
```


## Metadata
- **Skill**: not generated
