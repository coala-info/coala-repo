# spaln CWL Generation Report

## spaln

### Tool Description
SPALN is a tool for aligning sequences, particularly for gene prediction and mapping.

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: http://www.genome.ist.i.kyoto-u.ac.jp/~aln_user/spaln/
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Total Downloads**: 99.0K
- **Last updated**: 2025-09-26
- **GitHub**: https://github.com/ogotoh/spaln
- **Stars**: N/A
### Original Help Text
```text
No input seq file !

*** SPALN_AVX2 version 3.0.7 <250522> ***

Usage:
spaln -W[Genome.bkn] -KD [W_Options] Genome.mfa	(to write block inf.)
spaln -W[Genome.bkp] -KP [W_Options] Genome.mfa	(to write block inf.)
spaln -W[AAdb.bka] -KA [W_Options] AAdb.faa	(to write aa db inf.)
spaln -W [Genome.mfa|AAdb.faa]	(alternative to makdbs.)
spaln [R_options] genomic_segment cDNA.fa	(to align)
spaln [R_options] genomic_segment protein.fa	(to align)
spaln [R_options] -dGenome cDNA.fa	(to map & align)
spaln [R_options] -dGenome protein.fa	(to map & align)
spaln [R_options] -aAAdb genomic_segment.fa	(to search aa database & align)
spaln [R_options] -aAAdb protein.fa	(to search aa database)

in the following, # = integer or real number; $ = string; default in ()

W_Options:
	-XC#	number of bit patterns < 6 (1)
	-XG#	Maximum expected gene size (inferred from genome|db size)
	-Xk#	Word size (inferred from genome|db size)
	-Xb#	Block size (inferred from genome|db size)
	-Xa#	Abundance factor (10)
	-Xr#	Minimum ORF length with -KP (30))
	-g	gzipped output
	-t#	Mutli-thread operation with # threads

R_Options (representatives):
	-A[0-3]	0: scalar, 1..3: simd; 1: rigorous, 2: intermediate, 3: fast
	-H#	Minimum score for report (35)
	-L or -LS or -L#	semi-global or local alignment (-L)
	-M#[,#2]	Number of outputs per query (1) (4 if # is omitted)
		#2 (4) specifies the max number of candidate loci
		This option is effective only for map-and-align modes
	-O#[,#2,..] (GvsA|C)	0:Gff3_gene; 1:alignment; 2:Gff3_match; 3:Bed; 4:exon-inf;
			5:intron-inf; 6:cDNA; 7:translated; 8:block-only;
			10:SAM; 12:binary; 15:query+GS (4)
	-O#[,#2,..] (AvsA)	0:statistics; 1:alignment; 2:Sugar; 3:Psl; 4:XYL;
			5:srat+XYL; 8:Cigar; 9:Vulgar; 10:SAM; (4)
	-Q#	0:DP; 1-3:HSP-Search; 4-7; Block-Search (3)
	-R$	Read block information file *.bkn, *.bkp or *.bka
	-S#	Orientation. 0:annotation; 1:forward; 2:reverse; 3:both (3)
	-T$	Subdirectory where species-specific parameters reside
	-a$	Specify AAdb. Must run `makeidx.pl -ia' breforehand
	-A$	Same as -a but db sequences are stored in memory
	-d$	Specify genome. Must run `makeidx.pl -i[n|p]' breforehand
	-D$	Same as -d but db sequences are stored in memory
	-g	gzipped output in combination with -O12
	-l#	Number of characters per line in alignment (60)
	-o$	File/directory/prefix where results are written (stdout)
	-pa#	Remove 3' poly A >= # (0: don't remove)
	-pF	Output full Fasta entry name
	-pj	Suppress splice junction information with -O[6|7]
	-pn	Retain existing output file
	-po	Overwrite existing output file
	-pw	Report results even if the score is below the threshold
	-pT	Exclude termination codon from CDS
	-r$	Report information about block data file
	-u#	Gap-extension penalty (3)
	-v#	Gap-open penalty (8)
	-w#	Band width for DP matrix scan (100)
	-t[#]	Mutli-thread operation with # threads
	-ya#	Stringency of splice site. 0->3:strong->weak
	-yl3	Ddouble affine gap penalty
	-ym#	Nucleotide match score (2)
	-yn#	Nucleotide mismatch score (-6)
	-yo#	Penalty for a premature termination codon (100)
	-yx#	Penalty for a frame shift error (100)
	-yy#	Weight for splice site signal (8)
	-yz#	Weight for coding potential (2)
	-yB#	Weight for branch point signal (0)
	-yI$	Intron length distribution
	-yL#	Minimum expected length of intron (30)
	-yM#	Maximum length of intron (unset)
	-yS[#]	Use species-specific parameter set (0.0/0.5)
	-yX0	Don't use parameter set for cross-species comparison
	-yZ#	Weight for intron potential (0)
	-XG#	Reset maximum expected gene size, suffix k or M is effective

Examples:
	spaln -W -KP -t4 dictdisc_g.gf
	spaln -W -KA -Xk5 Swiss.faa
	spaln -O1 -LS 'chr1.fa 10001 40000' cdna.nfa
	spaln -Q7 -O0,1,7 -t10 -TTetrapod -XG2M -ommu/ -dmus_musc_g hspcdna.nfa
	spaln -Q7 -O5 -t10 -Tdictdics -ddictdisc_g'dictdisc.faa (101 200)' > ddi.intron
	spaln -Q7 -O0 -t10 -Tdictdics -aSwiss 'chr1.nfa 200001 210000' > Chr1_200-210K.gff
	spaln -Q4 -O0 -t10 -M10 -aSwiss dictdisc.faa > dictdisc.alignment_score
```

