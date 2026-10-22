# spaln CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| spaln | PASS | Rewrote CWL (options are glued, no invented flags); protein NP_001121846.1 mapped to its Danio genome scaffold with 9 exons, translation of the exons matches the protein; Galaxy reference file is from an older version |
| spaln_canonical.pl | PASS | New CWL; all 8 introns are GT..AG (100% GTAG) |
| spaln_catchr.pl | PASS | New CWL; renamed the genome scaffold to Pre_Un_1 with prefix and number options |
| spaln_clade.pl | PASS | New CWL; spaln protein-vs-protein distances for 10 globins gave beta-globin, myoglobin and alpha-globin clades |
| spaln_eij2ild.pl | PASS | New CWL; intron length table for the 8 introns found by spaln (65 to 6584 bp); two extra rows come from trailer lines in the input |
| spaln_eij4mer.pl | PASS | New CWL; counted GTAG 8 times for the 8 introns (two extra rows come from trailer lines in the input) |
| spaln_makblk.pl | PASS | New CWL; built genome.bkn (51303 B) from the makdbs .grp database, same size as spaln -W -KD |
| spaln_makdb | PASS | New CWL for spaln -W; built -KD, -KP and -KA databases from the Galaxy test data; the -KP database then worked with spaln -d |
| spaln_makdbs | PASS | New CWL; formatted the Galaxy test genome into .ent/.grp/.idx/.seq files (seq file 29972 B, same as spaln -W) |
| spaln_makeidx.pl | PASS | New CWL; made .bka block file and index files for 10 real globin proteins from UniProt |
| spaln_makmdm | PASS | New CWL; wrote mdm_cmp and mdm_mtx matrices for the PAM series (output folder created by the wrapper) |
| spaln_sortgrcd | PASS | New CWL; sorted spaln -O12 binary results into the same GFF3 gene model as the direct run |

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

## spaln_makdb

### Tool Description
Write block information (spaln database) for a genome or amino acid database with spaln -W

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: https://github.com/ogotoh/spaln
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

### Original Help Text
```text

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

## spaln_sortgrcd

### Tool Description
Read binary .grd results written by spaln -O12 and sort them in chromosomal order

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: https://github.com/ogotoh/spaln
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

### Original Help Text
```text
sortgrcd version 2.2.2: read binary .?rds and sort them
	in the order of chromosomal location in each direction
Usage: sortgrcd [options] *.grd
Note: version 2 supports outputs from spaln 2.1.0 or later
Note: version 2.1 supports -O3, 6, 7, and 8 options
Note: version 2.2 supports gzipped inputs
Options:
	-CN:	Minimum % of coverage (0-100)
	-EN:	Report only the best (N=1) or all (N=2) results per gene locus (1)
	-FN:	Filter Level (0 -> 3: no -> stringent)
	-GN:	Genetic code (0: universal)
	-HN:	Minimum spaln score
	-JN:	Minimum ORF length (300)
	-MN:	Maximum total number of missmatches
	-NN:	Maximum total number of non-canonical boundaries
	-ON:	Output format. 0:Gff3, 3:BED, 4:Native, 5:Intron, 
			6:cDNA, 7:translate, 8:CDS, 15:unique intron
	-PN:	Minimum Overall % identity (0-100)
	-Sa:	sort chromosomes in the alphabetical order of identifier (default)
	-Sb:	sort chromosomes in the order of abundance mapped on them
	-Sc:	sort chromosomes in the order of apparence in the genome db
	-Sr:	sort records mapped on minus strand in the reverse order of genomic positions
	-UN:	Maximum total number of unpaired bases in gaps
	-VN:	tMaximum memory size used for core sort (16M)
	-dS:	Specify the directory/genome_id (inferred from input)
	-lN:	Number of residues per line for -O6 or -O7 (60)
	-mN:	Maximum allowed missmatches at both exon boundaries
	-nN:	allow non-canonical boundary? [0: no; 1: AT-AN; 2: 1bp mismatch; 3: any]
	-oS:	output file (stdout)
	-uN:	Maximum allowed unpaired bases in gaps at both exon boundaries
```

## spaln_makeidx.pl

### Tool Description
Format a genomic sequence or protein sequence database to be used by spaln

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: https://github.com/ogotoh/spaln
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: makeidx.pl [-ianp] [-s src_dir] [-d seqdb/] [-g] fasta_file[.gz]
```

## spaln_makblk.pl

### Tool Description
Write block information (index) for spaln from sequence files or an x.grp database

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: https://github.com/ogotoh/spaln
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: makblk.pl [-Wx.[bkn|bkp|bka] -K[D|P|S]] [options] seq.1 seq.2 ...
	 or  makblk.pl [-Wx.[bkn|bkp|bka] -K[D|P|S]] [options] x.grp

Options:
	-r:	use reduced alphabet
	-X...	transferred to spaln
-XCc:	c=0: conti seed; c=1: spaced seed; c>1: conti + (c-1) spaced seeds
```

## spaln_makdbs

### Tool Description
Format a set of sequences to be quickly addressed

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: https://github.com/ogotoh/spaln
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

### Original Help Text
```text
makdbs Version 2.0.0: format a set of sequences to be quickly addressed
Usage:
	makdbs [-d[Name]] [-sSrcdir] [-pDstdir] source_files
Option:
	-a	: Ignore abmiguity code
	-bC	: C = [e]mbl|[g]enbank|[n]brf|[p]rodb|[s]wiss
	-c	: include comments/descriptions
	-dName	: Body of file names to be created
		If omitted, default name depending on DB type
		If Name is omitted, taken from 1st source file name
	-sSrcdir	: Directory where source files are located
		If omitted, srcdir <= {., (null), /usr/local/share/spaln/alndbs}
	-pdstdir	: Directory where destination files are located
		If omitted, dstdir = current dir
		*.ent, *.grp, *idx, (*.odr), and *.seq files are made in this directory
	-K[D|P]	: DNA or Protein sequence
```

## spaln_makmdm

### Tool Description
Make the mutation-data matrices used by spaln

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: https://github.com/ogotoh/spaln
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
	makmdm [-opt...] [destpath]
Options:
	-c-:	Suppress output of average compositions
	-m-:	Suppress output of mdm matrix
	-l:	Output LU-decomposited matrix
	-p:	Output power matrices
	-f78|91
	-b:	Brosum series
	-v:	VT series
If destpath is given, the files are writen there;
otherwise, in the current directry.
```

## spaln_catchr.pl

### Tool Description
Catenate chromosomal sequences in a single multi-fasta file with renamed ids

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: https://github.com/ogotoh/spaln
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
	catchr.pl [-wKeyword] [-hPrefix] [-n] [-o] input_files > target
```

## spaln_clade.pl

### Tool Description
Make clades from .dvn/.dvp pairwise score files

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: https://github.com/ogotoh/spaln
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

### Original Help Text
```text
clade.pl [-D] [-HThr] [-Apattern] [-M] [-S] [-U] [-R] input_files
  make clades from .dvn/.dvp file
  Input .dvn/.dvp; output < Thr clades
  -M (do not include Master) -S (Master only)
```

## spaln_eij2ild.pl

### Tool Description
Make an intron-length-distribution table from an .eij file

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: https://github.com/ogotoh/spaln
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: eij2ild.pl xxx.eij ----> stdout
  make ild (intron-length-distribution) file from *.eij
```

## spaln_eij4mer.pl

### Tool Description
Count tetramers flanking introns in .eij files

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: https://github.com/ogotoh/spaln
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: eij4mer.pl *.eij
  count the number of tetramers flanking introns
```

## spaln_canonical.pl

### Tool Description
Count canonical intron boundaries in .eij files

### Metadata
- **Docker Image**: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
- **Homepage**: https://github.com/ogotoh/spaln
- **Package**: https://anaconda.org/channels/bioconda/packages/spaln/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: canonical.pl *.eij
  count the number of canonical intron boundaries
```

