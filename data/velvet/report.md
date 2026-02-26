# velvet CWL Generation Report

## velvet_velveth

### Tool Description
simple hashing program

### Metadata
- **Docker Image**: quay.io/biocontainers/velvet:1.2.10--h577a1d6_9
- **Homepage**: https://github.com/dzerbino/velvet
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/velvet/overview
- **Total Downloads**: 63.0K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/dzerbino/velvet
- **Stars**: N/A
### Original Help Text
```text
velveth - simple hashing program
Version 1.2.10

Copyright 2007, 2008 Daniel Zerbino (zerbino@ebi.ac.uk)
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Compilation settings:
CATEGORIES = 4
MAXKMERLENGTH = 191
OPENMP
LONGSEQUENCES

Usage:
./velveth directory hash_length {[-file_format][-read_type][-separate|-interleaved] filename1 [filename2 ...]} {...} [options]

	directory	: directory name for output files
	hash_length	: EITHER an odd integer (if even, it will be decremented) <= 191 (if above, will be reduced)
			: OR: m,M,s where m and M are odd integers (if not, they will be decremented) with m < M <= 191 (if above, will be reduced)
				and s is a step (even number). Velvet will then hash from k=m to k=M with a step of s
	filename	: path to sequence file or - for standard input

File format options:
	-fasta	-fastq	-raw	-fasta.gz	-fastq.gz	-raw.gz	-sam	-bam	-fmtAuto
	(Note: -fmtAuto will detect fasta or fastq, and will try the following programs for decompression : gunzip, pbunzip2, bunzip2

File layout options for paired reads (only for fasta and fastq formats):
	-interleaved	: File contains paired reads interleaved in the one file (default)
	-separate	: Read 2 separate files for paired reads

Read type options:
	-short	-shortPaired
	-short2	-shortPaired2
	-short3	-shortPaired3
	-short4	-shortPaired4
	-long	-longPaired
	-reference

Options:
	-strand_specific	: for strand specific transcriptome sequencing data (default: off)
	-reuse_Sequences	: reuse Sequences file (or link) already in directory (no need to provide original filenames in this case (default: off)
	-reuse_binary	: reuse binary sequences file (or link) already in directory (no need to provide original filenames in this case (default: off)
	-noHash			: simply prepare Sequences file, do not hash reads or prepare Roadmaps file (default: off)
	-create_binary  	: create binary CnyUnifiedSeq file (default: off)

Synopsis:

- Short single end reads:
	velveth Assem 29 -short -fastq s_1_sequence.txt

- Paired-end short reads (remember to interleave paired reads):
	velveth Assem 31 -shortPaired -fasta interleaved.fna

- Paired-end short reads (using separate files for the paired reads)
	velveth Assem 31 -shortPaired -fasta -separate left.fa right.fa

- Two channels and some long reads:
	velveth Assem 43 -short -fastq unmapped.fna -longPaired -fasta SangerReads.fasta

- Three channels:
	velveth Assem 35 -shortPaired -fasta pe_lib1.fasta -shortPaired2 pe_lib2.fasta -short3 se_lib1.fa

Output:
	directory/Roadmaps
	directory/Sequences
		[Both files are picked up by graph, so please leave them there]
```


## velvet_velvetg

### Tool Description
de Bruijn graph construction, error removal and repeat resolution

### Metadata
- **Docker Image**: quay.io/biocontainers/velvet:1.2.10--h577a1d6_9
- **Homepage**: https://github.com/dzerbino/velvet
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
velvetg - de Bruijn graph construction, error removal and repeat resolution
Version 1.2.10
Copyright 2007, 2008 Daniel Zerbino (zerbino@ebi.ac.uk)
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Compilation settings:
CATEGORIES = 4
MAXKMERLENGTH = 191
OPENMP
LONGSEQUENCES

Usage:
./velvetg directory [options]

	directory			: working directory name

Standard options:
	-cov_cutoff <floating-point|auto>	: removal of low coverage nodes AFTER tour bus or allow the system to infer it
		(default: no removal)
	-ins_length <integer>		: expected distance between two paired end reads (default: no read pairing)
	-read_trkg <yes|no>		: tracking of short read positions in assembly (default: no tracking)
	-min_contig_lgth <integer>	: minimum contig length exported to contigs.fa file (default: hash length * 2)
	-amos_file <yes|no>		: export assembly to AMOS file (default: no export)
	-exp_cov <floating point|auto>	: expected coverage of unique regions or allow the system to infer it
		(default: no long or paired-end read resolution)
	-long_cov_cutoff <floating-point>: removal of nodes with low long-read coverage AFTER tour bus
		(default: no removal)

Advanced options:
	-ins_length* <integer>		: expected distance between two paired-end reads in the respective short-read dataset (default: no read pairing)
	-ins_length_long <integer>	: expected distance between two long paired-end reads (default: no read pairing)
	-ins_length*_sd <integer>	: est. standard deviation of respective dataset (default: 10% of corresponding length)
		[replace '*' by nothing, '2' or '_long' as necessary]
	-scaffolding <yes|no>		: scaffolding of contigs used paired end information (default: on)
	-max_branch_length <integer>	: maximum length in base pair of bubble (default: 100)
	-max_divergence <floating-point>: maximum divergence rate between two branches in a bubble (default: 0.2)
	-max_gap_count <integer>	: maximum number of gaps allowed in the alignment of the two branches of a bubble (default: 3)
	-min_pair_count <integer>	: minimum number of paired end connections to justify the scaffolding of two long contigs (default: 5)
	-max_coverage <floating point>	: removal of high coverage nodes AFTER tour bus (default: no removal)
	-coverage_mask <int>	: minimum coverage required for confident regions of contigs (default: 1)
	-long_mult_cutoff <int>		: minimum number of long reads required to merge contigs (default: 2)
	-unused_reads <yes|no>		: export unused reads in UnusedReads.fa file (default: no)
	-alignments <yes|no>		: export a summary of contig alignment to the reference sequences (default: no)
	-exportFiltered <yes|no>	: export the long nodes which were eliminated by the coverage filters (default: no)
	-clean <yes|no>			: remove all the intermediary files which are useless for recalculation (default : no)
	-very_clean <yes|no>		: remove all the intermediary files (no recalculation possible) (default: no)
	-paired_exp_fraction <double>	: remove all the paired end connections which less than the specified fraction of the expected count (default: 0.1)
	-shortMatePaired* <yes|no>	: for mate-pair libraries, indicate that the library might be contaminated with paired-end reads (default no)
	-conserveLong <yes|no>		: preserve sequences with long reads in them (default no)

Output:
	directory/contigs.fa		: fasta file of contigs longer than twice hash length
	directory/stats.txt		: stats file (tab-spaced) useful for determining appropriate coverage cutoff
	directory/LastGraph		: special formatted file with all the information on the final graph
	directory/velvet_asm.afg	: (if requested) AMOS compatible assembly file
```

