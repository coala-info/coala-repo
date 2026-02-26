# svict CWL Generation Report

## svict

### Tool Description
Structural Variant in ctDNA Sequencing Data

### Metadata
- **Docker Image**: quay.io/biocontainers/svict:1.0.1--h077b44d_6
- **Homepage**: https://github.com/vpc-ccg/svict
- **Package**: https://anaconda.org/channels/bioconda/packages/svict/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svict/overview
- **Total Downloads**: 11.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vpc-ccg/svict
- **Stars**: N/A
### Original Help Text
```text
Description
	svcit  -- Structural Variant in ctDNA Sequencing Data

Usage:
	svict -i [FILE] -r [FILE]
Required Parameters:
	-i, --input [FILE]
		 Input alignment file. This file should be a sorted SAM or BAM file.

	-r, --reference [FILE]
		Reference geneome that the reads are algined to.

Main Optional Parameters:
	-o, --output [STRING]
		Prefix of output file (default out)

	-g, --annotation [FILE]
		GTF file. Enables annotation of SV calls and fusion identification.

	-s, --min_support [INT]
		The minimum number of supporting reads required to be considered a SV (default 2).

	-S, --max_support [INT]
		The maximum number of supporting reads required to be considered a SV, could be used to filter out germline calls (default unlimited).

	-m, --min_length [INT]
		Min SV length (default 30).

	-M, --max_length [INT]
		Max SV length (default 20000).
	
Additional Parameters:
	-h, --help
		Shows help message.

	-v, --version
		Shows current version.

	-p, --print_reads
		Print all contigs and associated reads as additional output out.vcf.reads, out is the prefix specified in -o|--output, when activated.

	-P, --print_stats:
		Print statistics of detected SV calls and fusions to stderr.

	-w, --window_size [INT]
		The size of the sliding window collecting all reads with soft-clip/split positions in it to form the breakpoint specific cluster for contig assembly. 
		Larger window size could assign a read to more clusters for potentially higher sensitivity with the cost of increased running time (default 3).

	-d, --min_sc [INT]
		Minimum soft clip length for a read to be considered as unmapped or incorrectly mapped to be extracted for contig assembly (default 10).

	-n, --no_indel
		Ignore indels in the input BAM/SAM (I and D in cigar) when extracting potential breakpoints.

	-O, --assembler_overlap [INT]
		The minimum lenth of overlaps between 2 reads in overlap-layout-consensus contig assembly (default 50).

	-a, --anchor [INT]
		Anchor length. Intervals shorter than this value would be discarded in interval chaining procedure for locating contigs (default 30).

	-k, --kmer [INT]
		k-mer length to index and remap assembled contigs to reference genome (default 14).

	-u, --uncertainty [INT]
		Uncertainty around the breakpoint position.
		See "Interval Chaining for Optimal Mapping" in publication (default 8).

	-c, --sub_optimal [INT]
		For a contig, SViCT will report all paths which are not worse than the optimal by c on the DAGs to achieve potentially better sensitivity. 
		See "Interval Chaining for Optimal Mapping" in publication (default 0 - co-optimals only, negative value disables).

	-H, --heuristic 
		Use clustering heuristic (good for data with PCR duplicates).

	-D, --dump_contigs
		Dump contigs in fastq format for mapping.

	-R, --resume:
		Resume at the interval chaining stage with mapped contigs.

Example:
	svict -i input.bam -r human_genome.fa -o final
	This command will generate prediction result final.vcf directly from input.sam.
```

