# metavelvet CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metavelvet_meta-velvetg | PASS |  |

## metavelvet_meta-velvetg

### Tool Description
meta-velvetg - contiging and scaffolding program for metagenomics NGS data

### Metadata
- **Docker Image**: quay.io/biocontainers/metavelvet:1.2.02--1
- **Homepage**: https://metavelvet.dna.bio.keio.ac.jp/
- **Package**: https://anaconda.org/channels/bioconda/packages/metavelvet/overview
- **Validation**: PASS

### Original Help Text
```text
[meta-velvetg] Check command line options...
	Your command line options are not appropriate.
	Please read usage of meta-velvetg carefully.

	Thanks, 




************************************************************
Program: ----------------------------------------------
  meta-velvetg - contiging and scaffolding program for metagenomics NGS data
	Version = 1.2.02
	MAX_CATEGORIES = 2
	MAX_KMER_LENGTH = 63


Usage: ------------------------------------------------
  meta-velvetg directory [options]
	directory                   	: directory name for output files

  Graph-splitting options (metagenome-specific):
	-discard_chimera <yes|no>    	: discard chimera sub-graph (default: no)
	-max_chimera_rate <double>   	: maximum allowable chimera rate (default: 0.0)
	-repeat_cov_sd               	: standard deviation of repeat node coverages (default: 0.1)
	-min_split_length <int>      	: minimum node length required for repeat resolution (default: 0)
	-valid_connections <int>     	: minimum allowable number of consistent paired-end connections (default: 1)
	-noise_connections <int>     	: maximum allowable number of inconsistent paired-end connections (default: 0)
	-use_connections <yes|no>    	: use paired-end connections for graph splitting (default: yes)
	-report_split_detail <yes|no>	: report sequences around repeat nodes (default: no)
	-report_subgraph <yes|no>    	: report node sequences for each subgraph (default: no)

  Peak detection options (metagenome-specific):
	-exp_covs <string|auto>      	: expected coverages for each species in microbiome (default: auto)
	                             	    ex) -exp_covs 214_122_70_43_25_13.5
	                             	    coverage values should be sorted in a descending order
	-min_peak_cov <double>       	: minimum peak coverage (default: 0)
	-max_peak_cov <double>       	: maximum peak coverage (default: 500)
	-histo_bin_width <double>    	: bin width of peak coverage histogram (default: 1)
	-histo_sn_ratio <double>     	: signal-noise ratio to remove peak noises (default: 10)

  Contiging options: (common to single-genome)
	-cov_cutoff <double|auto>    	: removal of low coverage nodes AFTER tour bus or allow the system to infer it (default: auto)
	-max_coverage <double>       	: removal of high coverage nodes AFTER tour bus (default: no removal)
	-long_cov_cutoff <double>    	: removal of nodes with low long-read coverage AFTER tour bus (default: no removal)
	-max_branch_length <int>     	: maximum length in base pair of bubble (default: 100)
	-max_divergence <double>     	: maximum divergence rate between two branches in a bubble (default: 0.2)
	-max_gap_count <int>         	: maximum number of gaps allowed in the alignment of the two branches of a bubble (default: 3)
	-min_contig_lgth <int>       	: minimum contig length exported to contigs.fa file (default: hash length * 2)

  Scaffolding options: (common to single-genome)
	-scaffolding <yes|no>        	: scaffolding of contigs used paired end information (default: on)
	-exp_cov <double|auto>       	: expected coverage of unique regions or allow the system to infer it (default: auto)
	-ins_length <double>         	: expected distance between two paired end reads for the category (default: no read pairing)
	-ins_length_sd <double>      	: standard deviation of insert length for the category (default: insert length / 10)
	-ins_length2 <double>        	: expected distance between two paired end reads for the category (default: no read pairing)
	-ins_length2_sd <double>     	: standard deviation of insert length for the category (default: insert length / 10)
	-ins_length_long <double>    	: expected distance between two long paired-end reads (default: no read pairing)
	-ins_length_long_sd <double> 	: standard deviation of insert length for the category
	-min_pair_count <int>        	: minimum number of paired end connections to justify the scaffolding of two long contigs (default: 5)
	-long_mult_cutoff <int>      	: minimum number of long reads required to merge contigs (default: 2)
	-shortMatePaired <yes|no>    	: for mate-pair libraries, indicate that the library might be contaminated with paired-end reads (default no)

  Output options: (common to single-genome)
	-amos_file <yes|no>          	: export assembly to AMOS file (default: no export)
	-coverage_mask <int>         	: minimum coverage required for confident regions of contigs (default: 1)
	-unused_reads <yes|no>       	: export unused reads in UnusedReads.fa file (default: no)
	-alignments <yes|no>         	: export a summary of contig alignment to the reference sequences (default: no)
	-exportFiltered <yes|no>     	: export the long nodes which were eliminated by the coverage filters (default: no)
	-paired_exp_fraction <double>	: remove all the paired end connections which less than the specified fraction of the expected count (default: 0.1)


Output: -----------------------------------------------
	directory/meta-velvetg.contigs.fa       	: fasta file of contigs longer than twice hash length
	directory/meta-velvetg.LastGraph        	: special formatted file with all the information on the final graph
	directory/meta-velvetg.Graph2-stats.txt 	: stats file (tab-delimited) useful for optimizing coverage peak values
	directory/meta-velvetg.split-stats.txt  	: stats file (tab-delimited) useful for optimizing graph-splitting parameters

************************************************************
```

## Metadata
- **Skill**: generated

