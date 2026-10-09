# homer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| homer_annotatePeaks.pl | PASS |  |
| homer_bed2pos.pl | PASS |  |
| homer_findMotifs.pl | PASS |  |
| homer_findMotifsGenome.pl | PASS |  |
| homer_findPeaks | PASS |  |
| homer_homer2_background | PASS |  |
| homer_homer2_denovo | PASS |  |
| homer_homer2_find | PASS |  |
| homer_homer2_known | PASS |  |
| homer_homer2_mask | PASS |  |
| homer_homer2_norm | PASS |  |
| homer_makeTagDirectory | Failed | image problem: BAM input gives an empty tag directory because samtools is missing in the image; SAM input works |
| homer_mergePeaks | PASS | synthetic data: planted subsets of real Galaxy CTCF peaks; overlap counts 10/10/10 as expected. |
| homer_parseGTF.pl | PASS |  |
| homer_pos2bed.pl | PASS |  |
| homer_scanMotifGenomeWide.pl | PASS | text output identical to the Galaxy expected file; -bed start is 0-based (1448, matches the program source) while the older Galaxy file has 1449 |

## Metadata
- **Skill**: generated

## homer_annotatePeaks.pl

### Tool Description
Annotates peaks with genomic information such as proximity to TSS, gene annotations, and can perform motif discovery or integrate sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/homer:5.1--pl5262h9948957_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1001854655: no space left on device
```

## homer_findMotifsGenome.pl

### Tool Description
Finds de novo and known motifs in regions of a genome (peak or position file, genome name or custom FASTA).

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
Program will find de novo and known motifs in regions in the genome

	Usage: findMotifsGenome.pl <pos file> <genome> <output directory> [additional options]
	Example: findMotifsGenome.pl peaks.txt mm8r peakAnalysis -size 200 -len 8

	Possible Genomes:
			-- or --
		Custom: provide the path to genome FASTA files (directory or single file)
			Heads up: will create the directory "preparsed/" in same location.

	Basic options:
		-mask (mask repeats/lower case sequence, can also add 'r' to genome, i.e. mm9r)
		-len <#>[,<#>,<#>...] (motif length, default=8,10,12) [NOTE: values greater 12 may cause the program
			to run out of memory - in these cases decrease the number of sequences analyzed (-N),
			or try analyzing shorter sequence regions (i.e. -size 100)]
		-size <#> (fragment size to use for motif finding, default=200)
			-size <#,#> (i.e. -size -100,50 will get sequences from -100 to +50 relative from center)
			-size given (uses the exact regions you give it, recommended to use same sized regions)
		-S <#> (Number of motifs to optimize, default: 25)
		-mis <#> (global optimization: searches for strings with # mismatches, default: 2)
		-norevopp (don't search reverse strand for motifs)
		-nomotif (don't search for de novo motif enrichment)
		-noknown (don't search for known motif enrichment, default: -known)
		-rna (output RNA motif logos and compare to RNA motif database, automatically sets -norevopp)

	Background Sequence Options (updated in v5.0):
		-useNewBg (new background selection does not use preparsed genome files)
		-genomeBg (use genome sequences for background, default)
		-modelBg (generate background sequences by modeling sequence properties of the target sequences)
		-bg <background BED/peak file> (genomic positions to be used as background)

		-N <#> (Number of background sequences to use for motif finding, default=100000, or 2x input)
		-numBins <#> (number of GC bins to stratify GC-content in sequences by, default: 10)
		-ikmer <#> (when constructing background, match kmer content of this length with targets, default: 2)
		-pkmer <#> (when constructing background, positionally match kmer content)
		-allowTargetOverlaps (allow selected genomic bg regions to overlap target regions)
		-allowBgOverlaps (allow selected genomic bg regions, allow them to overlap with one another)
		-NN <#> (When selecting genomic bg seqs, consider this many initially, default: 100000000)

	Old Background Sequence Options:
		-useOldBg (Use old style [4.11 and earlier] background selection, default for now)
			-chopify (chop up large background regions to the avg size of target regions)
		-gc (use GC% for sequence content normalization, now the default)
		-cpg (use CpG% instead of GC% for sequence content normalization)
		-noweight (no CG correction)
		Also -nlen <#>, -olen <#>, see homer2 section below.

	Scanning sequence for motifs
		-find <motif file> (This will cause the program to only scan for motifs)

	Known Motif Options/Visualization
		-mset <vertebrates|insects|worms|plants|yeast|all> (check against motif collects, default: auto)
		-basic (just visualize de novo motifs, don't check similarity with known motifs)
		-bits (scale sequence logos by information content, default: doesn't scale)
		-nocheck (don't search for de novo vs. known motif similarity)
		-mcheck <motif file> (known motifs to check against de novo motifs,
		-float (allow adjustment of the degeneracy threshold for known motifs to improve p-value[dangerous])
		-mknown <motif file> (known motifs to check for enrichment,
		-nofacts (omit humor)
		-seqlogo (use weblogo/seqlogo/ghostscript to generate logos, default uses SVG now)

	Advanced options:
		-flip (look for motifs enriched in the background instead of target sequences)
		-h (use hypergeometric for p-values, binomial is default)
		-local <#> (use local background, # of equal size regions around peaks to use i.e. 2)
		-redundant <#> (Remove redundant sequences matching greater than # percent, i.e. -redundant 0.5)
		-maxN <#> (maximum percentage of N's in sequence to consider for motif finding, default: 0.7)
		-maskMotif <motif file1> [motif file 2]... (motifs to mask before motif finding)
		-opt <motif file1> [motif file 2]... (motifs to optimize or change length of)
		-rand (randomize target and background sequences labels)
		-ref <peak file> (use file for target and background - first argument is list of peak ids for targets)
		-oligo (perform analysis of individual oligo enrichment)
		-dumpFasta (Dump fasta files for target and background sequences for use with other programs)
		-preparse (force new background files to be created)
		-preparsedDir <directory> (location to search for preparsed file and/or place new files)
		-keepFiles (keep temporary files)
		-fdr <#> (Calculate empirical FDR for de novo discovery #=number of randomizations)

	homer core c++ program specific options:
		-nlen <#> (length of lower-order oligos to normalize in background, default: -nlen 3)
			-nmax <#> (Max normalization iterations, default: 160)
			-neutral (weight sequences to neutral frequencies, i.e. 25%, 6.25%, etc.)
		-olen <#> (lower-order oligo normalization for oligo table, use if -nlen isn't working well)
		-p <#> (Number of processors to use, default: 1)
		-e <#> (Maximum expected motif instance per bp in random sequence, default: 0.01)
		-cache <#> (size in MB for statistics cache, default: 500)
		-quickMask (skip full masking after finding motifs, similar to original homer)
		-minlp <#> (stop looking for motifs when seed logp score gets above #, default: -10)
```

## homer_findMotifs.pl

### Tool Description
Finds de novo and known motifs in a gene list (promoter based) or in target and background FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
Program will find de novo and known motifs in a gene list

		Usage:  findMotifs.pl <input list> <promoter set> <output directory> [additoinal options]

		example: findMotifs.pl genelist.txt mouse motifResults/ -len 10

		FASTA example: findMotifs.pl targets.fa fasta motifResults/ -fasta background.fa

	Available Promoter Sets: Add custom promoters sets with loadPromoters.pl

		Try typing "perl /usr/local/share/homer/.//configureHomer.pl -list" to see available promoter sets
		Typing "perl /usr/local/share/homer/.//configureHomer.pl -install NNN" to install promoter set NNN

	Basic options:
		-len <#>[,<#>,<#>...] (motif length, default=8,10,12) [NOTE: values greater 12 may cause the program
			to run out of memmory - in these cases decrease the number of sequences analyzed]
		-bg <background file> (ids to use as background, default: all genes)
		-start <#> (offset from TSS, default=-300) [max=based on Promoter Set]
		-end <#> (offset from TSS, default=50) [max=based on Promoter Set]
		-rna (output RNA motif logos and compare to RNA motif database, automatically sets -norevopp)
		-mask/-nomask (use/don't use repeatmasked files, default: -mask)
		-S <#> (Number of motifs to optimize, default: 25)
		-mis <#> (global optimization: searches for strings with # mismatches, default: 1)
		-noconvert (will not worry about converting input files into unigene ids)
		-norevopp (do not search the reverse strand for motifs)
		-nomotif (don't search for de novo motif enrichment)

	Scanning sequence for motifs
		-find <motif file> (This will cause the program to only scan for motifs)

	Including Enhancers - peak files of enhancer location, peak ID should be gene ID
		-enhancers <peak file> <genome verion>
			(enhancers to include in search space, peaks/sequences should be named with a gene ID
			If multiple enhancers per gene, use the same gene ID, and all will be included)
		-enhancersOnly (do not include promoter sequence in motif search)

	FASTA files: If you prefer to use your own fasta files, place target sequences and 
		background sequences in two separate FASTA formated files (must have unique identifiers)
		Target File - use in place of <input list> (i.e. the first argument)
		Background File - after output directory (with additional options) use the argument:
			-fastaBg <background fasta file> (This is recommended for fasta based analysis)
		In place of the promoter set use "fasta", or any valid set (this parameter is ignored)
		When finding motifs [-find], only the target file with be searched)
			-chopify (chops up background regions to match size of target regions)
				i.e. if background is a full genome or all mRNAs

	Known Motif Options/Visualization:
		-mset <vertebrates|insects|worms|plants|yeast|all> (check against motif collects, default: auto)
		-basic (don't check de novo motifs for similarity to known motifs)
		-bits (scale sequence logos by information content, default: doesn't scale)
		-nocheck (don't check for similarity between novo motif motifs and known motifs)
		-mcheck <motif file> (known motifs to check against de novo motifs,
		-noknown (don't search for known motif enrichment, default: -known)
		-mknown <motif file> (known motifs to check for enrichment,
		-nofacts (omit humor)
		-seqlogo (uses weblogo/seqlogo/ghostscript to visualize motifs, default uses SVG)

	Advanced options:
		-b (use binomial distribution to calculate p-values, hypergeometric is default)
		-nogo (don't search for gene ontology enrichment)
		-humanGO (Convert IDs to human for GO analysis)
		-ontology <ont.genes> [ont.genes] ... (custom ontologies for GO analysis)
		-noweight (no CG correction)
		-noredun (Don't remove predetermined redundant promoters/sequences)
		-g (input file is a group file, i.e. 1st column = id, 2nd = 0 or 1 [1=target,0=back])
		-cpg (use CpG% instead of GC% for sequence normalization)
		-rand (randomize labels for target and backgound sequences)
		-maskMotif <motif file 1> [motif file 2] ... (motifs to mask before motif finding)
		-opt <motif file 1> [motif file 2] ... (motifs to optimize/change length)
		-peaks (will produce peak file of promoters to use with findMotifsGenome.pl)
		-nowarn (no warnings)
		-keepFiles (don't delete temporary files)
		-dumpFasta (create target.fa and background.fa files)
		-min <#> (remove sequences shorter than #, default: 0)
		-max <#> (remove sequences longer than #, default: 1e10)
		-reuse (rerun homer using old seq files etc. with new options
			  and ignores input list, organism)
		-fdr <#> (Calculate empirical FDR for de novo discovery #=number of randomizations)

	homer core c++ program execuable specific options:
		-nlen <#> (length of lower-order oligos to normalize - general sequences, default: 3)
			-nmax <#> (Max normalization iterations, default: 160)
			-neutral (weight sequences to neutral frequencies, i.e. 25%, 6.25%, etc.)
		-olen <#> (lower-order oligo normalization for oligo table, use if -nlen isn't working well)
		-p <#> (Number of processors to use, default: 1)
		-e <#> (Maximum expected motif instance per bp in random sequence, default: 0.01)
		-cache <#> (size in MB for statistics cache, default: 500)
		-quickMask (skip full masking after finding motifs, similar to original homer)
		-homer1 (to force the use of the original homer)
		-minlp <#> (stop looking for motifs when seed logp score gets above #, default: -10)
```

## homer_makeTagDirectory

### Tool Description
Creates a platform-independent tag directory from alignment files (BED, eland, bowtie, SAM, BAM) for later HOMER analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: makeTagDirectory <directory> <alignment file 1> [file 2] ... [options]

	Creates a platform-independent 'tag directory' for later analysis.
	Currently BED, eland, bowtie, and sam files are accepted. The program will try to
	automatically detect the alignment format if not specified.  Program will also
	unzip *.gz, *.bz2, and *.zip files and convert *.bam to sam files on the fly
	Existing tag directories can be added or combined to make a new one using -d/-t
	If more than one format is needed and the program cannot auto-detect it properly,
	make separate tag directories by running the program separately, then combine them.
	To perform QC/manipulations on an existing tag directory, add "-update"

	Options:
		-fragLength <# | given | pe> (Set estimated fragment length or use PE length - given: use read lengths)
			By default treats the sample as a single read ChIP-Seq experiment
		-format <X> where X can be: (with column specifications underneath)
			bed - BED format files:
				(1:chr,2:start,3:end,4:+/- or read name,5:# tags,6:+/-)
				-force5th (5th column of BED file contains # of reads mapping to position)
			sam - SAM formatted files (use samTools to covert BAMs into SAM if you have BAM)
				-unique (keep if there is a single best alignment based on mapq)
					-mapq <#> (Minimum mapq for -unique, default: 10, set negative to use AS:i:/XS:i:)
				-keepOne (keep one of the best alignments even if others exist)
				-keepAll (include all alignments in SAM file)
				-mis (Maximum allowed mismatches, default: no limit, uses MD:Z: tag)
				-sspe (strand specific, paired-end reads[flips strand of 2nd read to match])
				-read1/-read2 (only analyze 1st or 2nd read for PE sequencing)
				-rmsoft (clip soft clipped regions from reads, default: assume read extends/mismatch)
				-omitSN (ignore alignments with splicing/soft clipping, i.e. use for csRNA-seq)
			bowtie - output from bowtie (run with --best -k 2 options)
				(1:read name,2:+/-,3:chr,4:position,5:seq,6:quality,7:NA,8:misInfo)
			eland_result - output from basic eland
				(1:read name,2:seq,3:code,4:#zeroMM,5:#oneMM,6:#twoMM,7:chr,
							8:position,9:F/R,10-:mismatches
			eland_export - output from illumina pipeline (22 columns total)
				(1-5:read name info,9:sequence,10:quality,11:chr,13:position,14:strand)
			eland_extended - output from illumina pipeline (4 columns total)
				(1:read name,2:sequence,3:match stats,4:positions[,])
			mCpGbed - encode style mCpG reporting in extended BED format, no auto-detect
				(1:chr,2:start,3:end,4:name,5:,6:+/-,7:,8:,9:,10:#unmC,11:#mC)
			allC - Lister style output files detailing the read information about all cytosines
				(1:chr,2:pos,3:strand,4:context,#mC,#totalC,#unmC
			bismark - Bismark style output files detailing the read information about all cytosines
				(1:chr,2:pos,3:strand,4:#mC,5:#unmC,6:context,7:triseq
				-minCounts <#> (minimum number of reads to report mC/C ratios, default: 10)
				-mCcontext <CG|CHG|CHH|all> (only use C's in this context, default: CG)
			HiCsummary - minimal paired-end read mapping information
				(1:readname,2:chr1,3:5'pos1,4:strand1,5:chr2,6:5'pos2,7:strand2)
		-flip (flip strand of each read, i.e. might want to use with some RNA-seq)
		-totalReads <#|all|default> (set the effective total number of reads - all includes multimappers)
		-force5th (5th column of BED file contains # of reads mapping to position)
		-d <tag directory> [tag directory 2] ... (add Tag directory to new tag directory)
		-t <tag file> [tag file 2] ... (add tag file i.e. *.tags.tsv to new tag directory)
		-single (Create a single tags.tsv file for all "chromosomes" - i.e. if >100 chromosomes)
		-update (Use current tag directory for QC/processing, do not parse new alignment files)
		-tbp <#> (Maximum tags per bp, default: no maximum)
		-precision <1|2|3> (number of decimal places to use for tag totals, default: 1)
		-minlen <#> and -maxlen <#> (Filter reads with lengths outside this range)

		GC-bias options:
		-genome <genome version> (To see available genomes, use "-genome list")
			-or- (for custom genomes):
		-genome <path-to-FASTA file or directory of FASTA files>

		-checkGC (check Sequence bias, requires "-genome")
			-freqStart <#> (offset to start calculating frequency, default: -50)
			-freqEnd <#> (distance past fragment length to calculate frequency, default: +50)
			-oligoStart <#> (oligo bias start)
			-oligoEnd <#> (oligo bias end)
		-normGC <target GC profile file> (i.e. tagGCcontent.txt file from control experiment)
			Use "-normGC default" to match the genomic GC distribution
		-normFixedOligo <oligoFreqFile> (normalize 5' end bias, "-normFixedOligo default" ok)
		-normLength <target Length profile file> (i.e. tagLengthDistribution.txt file from control experiment)
		-minNormRatio <#> (Minimum deflation ratio of tag counts, default: 0.25)
		-maxNormRatio <#> (Maximum inflation ratio of tag counts, default: 2.0)
		-iterNorm <#> (Sets -max/minNormRatio to 1 and 0, iteratively normalizes such that the
			resulting distrubtion is no more than #% different than target, i.e. 0.1,default: off)
		-filterReads <seq> <offset> <keep|remove> (filter reads based on oligo sequence in the genome)

	HiC options
		-removePEbg (remove paired end tags within 1.5x fragment length on same chr)
			-PEbgLength <#> (remove PE  reads facing on another within this distance, default: 1.5x fragLen)
		-restrictionSite <seq> (i.e. AAGCTT for HindIII, assign data < 1.5x fragment length to sites)
			Must specify genome sequence directory too. (-rsmis <#> to specify mismatches, def: 0)
			-both, -one, -onlyOne, -none (Keeps reads near restriction sites, default: keep all)
			-removeSelfLigation (removes reads linking same restriction fragment)
			-removeRestrictionEnds (removes reads starting on a restriction fragment)
			-assignMidPoint (will place reads in the middle of HindIII fragments)
			-restrictionSiteLength <#> (maximum distance from restriction site, default: 1.5x fragLen)
		-removeSpikes <size bp> <#> (remove tags from regions with > than # times
			the average tags per size bp, suggest "-removeSpikes 10000 8")
		-bowtiePE (PE alignments in bowtie alignment, assumes last character of read name is 0 or 1)
			(don't need this for sam/bam files)
```

## homer_findPeaks

### Tool Description
Finds peaks (enriched regions) in a HOMER tag directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: findPeaks <tag directory> [options]

	Finds peaks in the provided tag directory.  By default, peak list printed to stdout

	General analysis options:
		-o <filename|auto> (file name for to output peaks, default: stdout)
			"-o auto" will send output to "<tag directory>/peaks.txt", ".../regions.txt",
			or ".../transcripts.txt" depending on the "-style" option
		-style <option> (Specialized options for specific analysis strategies)
			factor (transcription factor ChIP-Seq, uses -center, output: peaks.txt,  default)
			atac (ATAC-seq, uses -region -size 50 -minDist 50 -regionRes 8 -L 2, output: regions.txt)
			histone (histone modification ChIP-Seq, region based, uses -region -size 500 -L 0, regions.txt)
			groseq (de novo transcript identification from GroSeq data, transcripts.txt)
			tsr (TSR -transcription start region- identification from 5' RNA sequencing, tsr.txt)
			dnase (Hypersensitivity [crawford style (nicking)], peaks.txt)
			super (Super Enhancers, superEnhancers.txt)
			superhistone (Super Enhancers from H3K27ac data, superEnhancers.txt)
			mC (Cytosine methylation (BS-seq/methylC-seq), regions.txt)
			damid (DamID enrichment from DpnI digestion, regions.txt)
			clip (CLIP-Seq enrichment, strand specific, peaks.txt)

	chipseq/histone options:
		-i <input tag directory> (Experiment to use as IgG/Input/Control)
		-size <#> (Peak size, default: auto)
		-minDist <#> (minimum distance between peaks, default: peak size x2)
		-gsize <#> (Set effective mappable genome size, default: 2e9)
		-fragLength <#|auto> (Approximate fragment length, default: auto)
		-inputFragLength <#|auto> (Approximate fragment length of input tags, default: auto)
		-tbp <#> (Maximum tags per bp to count, 0 = no limit, default: auto)
		-inputtbp <#> (Maximum tags per bp to count in input, 0 = no limit, default: auto)
		-strand <both|separate> (find peaks using tags on both strands or separate, default:both)
		-norm # (Tag count to normalize to, default 10000000)
		-region (extends start/stop coordinates to cover full region considered "enriched")
			-regionRes <#> (number of fractions peaks are divided in when extending 'regions', def: 4)
		-center (Centers peaks on maximum tag overlap and calculates focus ratios)
		-nfr (Centers peaks on most likely nucleosome free region [works best with mnase data])
			(-center and -nfr can be performed later with "getPeakTags"

	Peak Filtering options: (set -F/-L/-C to 0 to skip)
		-F <#> (fold enrichment over input tag count, default: 4.0)
		  -P <#> (poisson p-value threshold relative to input tag count, default: 0.0001)
		-L <#> (fold enrichment over local tag count, default: 4.0)
		  -LP <#> (poisson p-value threshold relative to local tag count, default: 0.0001)
		-C <#> (fold enrichment limit of expected unique tag positions, default: 2.0)
		-localSize <#> (region to check for local tag enrichment, default: 10000)
		-inputSize <#> (Size of region to search for control tags, default: 2x peak size)
		-fdr <#> (False discovery rate, default = 0.001)
		-poisson <#> (Set poisson p-value cutoff, default: uses fdr)
		-tagThreshold <#> (Set # of tags to define a peak, default: 25)
		-ntagThreshold <#> (Set # of normalized tags to define a peak, by default uses 1e7 for norm)
		-minTagThreshold <#> (Absolute minimum tags per peak, default: expected tags per peak)

	SuperEnhancer Options: (Need to specify "-style super"):
		-superSlope <#> (Slope threshold to identify super vs. typical enh., default: 1.00)
		-superWindow <#> (moving window/number of peaks to use to calculate slope, default: 10)
		-typical <filename> (Output typical enhancers to this file, default: not used)
		-inputPeaks <filename> (initial peaks to use for super enhancer merging/scoring)
		-excludePeaks <filename> (regions to exclude from analysis, i.e. TSS regions for H3K27ac)

	MethylC-Seq/BS-Seq options (Need to specify "-style mC"):
		-unmethylC / -methylC (find unmethylated/methylated regions, default: -unmethyC)
		-mCthresh <#> (methylation threshold of regions, default: avg methylation/2)
		-minNumC <#> (Minimum number of cytosines per methylation peak, default: 6)

	GroSeq Options (Need to specify "-style groseq"):
		-tsrSize <#> (size of region for initiation detection/artifact size, default: 250)
		-minBodySize <#> (size of regoin for transcript body detection, default: 1000)
		-tsrFold <#> (fold enrichment for new initiation dectection, default: 4.0)
		-bodyFold <#> (fold enrichment for new transcript dectection, default: 4.0)
		-endFold <#> (end transcript when levels are this much less than the start, default: 10.0)
		-method <fold|level> (method used for identifying new transcripts, default: fold)
		-fragLength <#> (Approximate fragment length, default: 150)
		-uniqmap <directory> (directory of binary files specifying uniquely mappable locations)
			Download from http://biowhat.ucsd.edu/homer/groseq/
		-confPvalue <#> (confidence p-value: 1.00e-05)
		-minReadDepth <#> (Minimum initial read depth for transcripts, default: auto)
		-pseudoCount <#> (Pseudo tag count, default: 2.0)
		-rev (reverse strand of reads - for first-strand rna-seq/gro-seq)
		-gtf <filename> (Output de novo transcripts in GTF format)
			"-o auto" will produce <dir>/transcripts.txt and <dir>/transcripts.gtf
```

## homer_mergePeaks

### Tool Description
Merges and/or compares peak and position files and reports overlap statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mergePeaks [options] <primary peak file> [additional peak/annotation files...]

	Merges and/or compares peak/position files (peak files listed twice are only considered once)

	General Options:
		-strand (Only merge/consider peaks on the same strand, default: either strand)
		-d <#|given> (Maximum distance between peak centers to merge, default: given)
			Using "-d given" looks for literal overlaps in peak regions - DEFAULT since v4.4
			Use "-d given" when features have vastly different sizes (i.e. peaks vs. introns)
		-file <filename> (file listing peak files to compare - for lots of peak files)
		-gsize <#> (Genome size for significance calculations, default: 2e9)

	Merging Peaks Options (default):
		-prefix <filename> (Generates separate files for overlapping and unique peaks)
			By default all peaks are sent to stdout
		-matrix <filename> (Generates files with pairwise comparison statistics)
			filename.logPvalue.matrix.txt - ln p-values for overlap, +values for divergence
			filename.logRatio.matrix.txt - ln ratio of observed/expected overlaps
			filename.count.matrix.txt - peak overlap counts
		-venn <filename> (output venn diagram numbers to file, default: to stderr)
		-code (report peak membership as binary instead of by file names)

	Classify peaks by how many are co-bound by other peak files vs. reference(1st file)
		-cobound <#> (Maximum number of co-bound peaks to consider)
			Will output sets of peaks that are co-bound by various numbers of factors
			to files coBoundBy0.txt, coBoundBy1.txt, coboundBy2.txt, ...
			Or <prefix>.coBoundBy0.txt, <prefix>.coBoundBy1.txt, ...
		-matrix <filename> (generates similar files to above with pairwise overlap statistics)

	Single peak file:
		(If a single peak file is given, peaks within the maximum distance will be merged)
		-filter chrN:XXX-YYY (only analyze peaks within range)
		-coverage <output file> (returns the total bp covered by each peak file - use "-d given"
```

## homer_pos2bed.pl

### Tool Description
Converts a HOMER peak/position file to BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pos2bed.pl [options] <peak/pos file>

	This will output a BED-format file to stdout

	Options:
		-o <filename> (Output to file)
		-bed (Output to file with same name as input with *.bed extension)
		-track <name> (Include track line with name for uploading to UCSC Genome Browser)
		-5 (Set 5th column to the value 1 instead of value in 6th column of pos file)
		-float (Allow the 5th column to be a floating point number, default: integer)
		-color strand (color strands red and blue, will also add a track line to file)
```

## homer_bed2pos.pl

### Tool Description
Converts a BED file to a HOMER position/peak file.

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bed2pos.pl [options] <BED file>

	This outputs a position/peak file to stdout

	Options:
		-check (Checks if the file is already peak/pos formatted)
		-unique (Make peaks names unique by adding numbers to replicate names)
		-o <filename> (Send output to this file, default: stdout)
		-pos (Send output to file with same name as input file with *.pos extension)
```

## homer_scanMotifGenomeWide.pl

### Tool Description
Scans a genome for instances of one or more motifs.

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanMotifGenomeWide.pl <motif> <genome> [options]
		Possible Genomes:
			-- or --
		Custom: provide the path to genome FASTA files (directory or single file)

	Output will be sent to stdout

	Options:
		-5p (report positions centered on the 5' start of the motif)
		-bed (format as a BED file, i.e. for UCSC upload)
			-int (round motif scores to nearest integer between 0-1000, use if making bigBed file)
		-homer1 (use the original homer)
		-homer2 (use homer2 instead of the original homer, default)
		-keepAll (keep ALL sites, even ones that overlap, default is to keep one)
		-mask (search for motifs in repeat masked sequence)
		-p <#> (Number of CPUs to use)
```

## homer_parseGTF.pl

### Tool Description
Converts a GTF/GFF annotation file to a HOMER-style position/peak or annotation file.

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: parseGTF.pl <GTF format file> <mode> [options]

	Outputs a homer-style position/peak file to stdout
	Mainly used by various other Homer programs

	2nd argument modes:
		tss: return TSS positions (+/- 2000 bp)
		tts: return termination positions (+/- 2000 bp)
		exons: return exon positions
		ann: return file for using with assignGenomeAnnotation
		anntype: return file for using with assignGenomeAnnotation that includes transcript type
		rna: return file for using with analyzeRNA.pl
		gtf: return gtf file with no redundant transcript/gene IDs
		anntable: returns tab-delimted table with attribute information for each gene ID

	Additional options:
		-gff (input file is gff format-treats 9th column as ID)
		-gff3 (input file is gff3 format - looks for parent attribute to assign gene name)
			-att <attribute to report> (def: ID)
		
		-gid (use gene IDs as the primary identifier)
		-tid (use transcript IDs as the primary identifier, default)
		-removeAccVer (Normally any .1, .2, etc. at end of accession numbers, i.e. AT1G01040.2)
		-removeEnsemblVer (remove 'transcript:' and '_T01' style ids)
		-features <feature1> [feature2] ... (Features to report, default: exon)
			-keepAll (Normally, only transcripts with exon annotations are used)
		-annTSSstartOffset <#> (distance upstream of TSS to start promoter annotation, default: -1000)
		-annTSSendOffset <#> (distance upstream of TSS to start promoter annotation, default: 100)
		-annTTSstartOffset <#> (distance upstream of TSS to start promoter annotation, default: -100)
		-annTTSendOffset <#> (distance upstream of TSS to start promoter annotation, default: 1000)
```

## homer_homer2_denovo

### Tool Description
Discovers motifs de novo in a set of sequences (homer2).

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
homer2 denovo -s <seq file> -g <group file> [options]

	Discover motif de novo in a set of sequences.

	Primary Inputs:
		-s <sequence file> (tab delimited sequence file)
		-g <group file> (sequence group and weight assignments)
			--- or ---
		-i <input FASTA file>
		-b <background FASTA file>

	Options:
		-o <output motif file> (default: sent to stdout)
		-len <#> (length of motif to search for, default: 10)
		-mis <#> (maximum number of mismatches in global search phase, default: 2)
		-strand <+|-|both> (search for motifs on specific strand, default: both)
		-stat <hypergeo|binomial> (enrichment statistic, default: binomial)
		-S <#> (Total motifs to find, default: 25)
		-olen <#> (length of lower-order oligos to normalize in oligo table)
			-oout <filename> (output normalization weights to file)
			-omax <#> (max oligo normalization iterations, default: 160)
		-p <#> (Number of processers to use, default: 1)

	Advanced Options:
		-nozoops (skip proper zoops scoring at end, default: -zoops)
		-tmp <filename> (temporary results file, default: ".tmp.motifs")
		-oligos <filename> (print enrichment of individual oligos)
		-opt <motif file> (expand/futher optimize these motifs/skip global phase)

		Speed vs. Sensitivity:
		-fullMask | -quickMask (choose one:)
			-fullMask (as motifs are found, mask them from original sequences.
				Requires more memory but yields "cleaner" results, default)
			-quickMask (as motifs are found, mask bound "oligos" only, old way)
		-e <#> (maximum expected motif instances per bp, default: 0.005)
		-T <#> (number of trial matrices when optimizing, default: 10)
		-blen <#> (# of bp on either side to check for redundancy, default: 1)
		-maxBack <#> (Max percentage of background that motifs may contain, default: 0.5)
		-minlp <#> (minimum significance of seeds to optimize, default: -10.000)

		Memory vs. Speed:
		-cache <#> (size in MB of stat cache, helps for hypergeo, default: 500)
```

## homer_homer2_known

### Tool Description
Finds the enrichment of known motifs in a set of sequences (homer2).

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
homer2 known -s <seq file> -g <group file> -k <known motif file> [options]

	Find the enrichment of known motifs in a set of sequences.

	Primary Inputs:
		-s <sequence file> (tab delimited sequence file)
		-g <group file> (sequence group and weight assignments)
			--- or ---
		-i <input FASTA file>
		-b <background FASTA file>

	Options:
		-o <output enrichment file> (default: sent to stdout)
		-m <known motif file> (Known motif file to check enrichment for)
			-mout <output motif file> (Output updated motifs with statistics)
		-strand <+|-|both> (search for motifs on specific strand, default: both)
		-stat <hypergeo|binomial> (enrichment statistic, default: binomial)
		-nlen <#> (length of lower-order oligos to normalize, default: 0)
			-nout <filename> (output normalization weights to file)
			-nmax <#> (max normalization iterations, default: 160
		-cache <#> (size in MB of stat cache: 500)
		-p <#> (Number of processers to use, default: 1)
		-opt (Optimize degeneracy threshold to get best enrichment, use -mout to get motifs)
		-siteReduce <#> (Eliminate redundant motifs sharing > % of sites)
		-maxBack <#> (Max percentage of background that motifs may contain, default: 0.5)
```

## homer_homer2_find

### Tool Description
Finds instances of motifs in a set of sequences (homer2).

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
homer2 find -s <seq file> -m <motif file> [options]

	Find the instances of motif(s) in a set of sequences.

	Primary Inputs:
		-s <sequence file> (tab delimited sequence file)
			--- or ---
		-i <input FASTA file>

	Options:
		-o <output file> (default: sent to stdout)
		-m <motif file> (Motif(s) to find instances of)
		-offset <#> (offset to report motif instances from, default: midpoint)
		-strand <+|-|both> (search for motifs on specific strand, default: both)
		-p <#> (Number of processers to use, default: 1)
		-mscore (instead of reporting sites, report best motif score per sequence)
```

## homer_homer2_background

### Tool Description
Generates or selects background sequences that match properties of target sequences (homer2).

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
homer2 background -i <target sequences.fasta> [options]

	homer2 bg -i <target sequences.fasta> [options]

	Generate/Select background sequences that match properties in a set of target sequences.

	Inputs:
	  Target sequences you want to model:
		-i <target sequences.fasta> (FASTA file)
		-p <target positions.bed> (Alteratively, provide a BED or HOMER peak file with genomic coordinates)
	  Background sequences to select from:
		-model (generate sequences using a model, do not extract real background sequences)
		-g <genome.fasta> (genome FASTA file or seqeunce resource to select sequences from)
		-b <background sequences.fasta> (explicit set of background sequences to choose from FASTA file)
		-bg <background positions.bed> (explicit set of background positions to choose from)
		-bgr <background regions positions.bed> (regions of the genome to select bg sequences from)
	Key options:
		-size <#> (size of regions to consider in background, default: avg of length of target sequences)
		-N <#> (number of background sequences to select, default: 100000)
		-NN <#> (number of background sequences initial screen from genome, default: 100000000)
		-mask (mask lowercase sequence i.e. softmasked sequence, default: use all sequences)
		-nbins <#> (number of bins to segregate sequences into for GC selection, def: 10)
		-nsubBins <#> (number of bins to segregate sequences into for positional frequencies, def: 10)
			(if not set, homer2 may attempt to adjust -nbins/-nsubBins automatically when using small datasets)
		-maxFractionN <#> (Maximum fraction of sequence that can be N and still used, default: 0.5)
		-allowTargetOverlaps (allow selected bg sequences from a genome to overlap targets, def: not allowed)
		-allowBgOverlaps (allow selected bg sequences from a genome to overlap, def: not allowed)
		-strand (allow sequences to overlap if on separate strands)
		-pkmer <#> (match positional kmer content)
		-ikmer <#> (match overall kmer content [position independent])
		-excludeNs/-includeNs (by default, kmers with Ns are excluded when selecting bg sequences,
				but included when generating sequences with -model)
		-pscore <outputBEDfile> (Report initial pscores)
		-maxIterations <#> (maximum iterations, def: 20)
		-overlapIteration <#> (iteration to start enforcing no overlaps, def: 5)
		-decayRate <#> (selection rate per iteration, def: 0.75)
		-seed <#> (seed for random number generator, def: uses time)
	Output:
		-o <output prefix> (default: out)
		-gs (include homer-style group and sequence output files)
```

## homer_homer2_norm

### Tool Description
Normalizes background sequences to remove short oligo enrichment and writes a weighted group file (homer2).

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
homer2 norm -s <seq file> -g <group file> [options]

	Normalize background sequences to remove short oligo enrichment

	Creates new group file to use with motif finding

	Primary Inputs:
		-s <sequence file> (tab delimited sequence file)
		-g <group file> (sequence group and weight assignments)
			--- or ---
		-i <input FASTA file>
		-b <background FASTA file>
			Output will be sequence and group file, even with FASTA input files

	Options:
		-o <output weighted group file> (default: sent to stdout)
		-s <sequence file> (tab delimited sequence file)
		-g <group file> (sequence group and weight assignments)
		-strand <+|-|both> (search for motifs on specific strand, default: both)
		-nlen <#> (length of lower-order oligos to normalize, default: 0)
			-nout <filename> (output normalization weights to file)
			-nmax <#> (max normalization iterations, default: 160)
		-neutral (set target/background to neutral i.e. 25%, 6.25%, etc. frequencies)
		-p <#> (Number of processers to use, default: 1)
```

## homer_homer2_mask

### Tool Description
Removes (masks) instances of motifs in a set of sequences (homer2).

### Metadata
- **Docker Image**: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
- **Homepage**: http://homer.ucsd.edu/homer/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/homer/overview
- **Validation**: PASS

### Original Help Text
```text
homer2 mask -s <seq file> -m <motif file> [options]

	Remove instances of motif(s) in a set of sequences.

	Primary Inputs:
		-s <sequence file> (tab delimited sequence file)
			--- or ---
		-i <input FASTA file>

	Options:
		-o <output tsv sequence file> (default: sent to stdout)
		-m <motif file> (Motif(s) to find instances of)
		-strand <+|-|both> (search for motifs on specific strand, default: both)
		-p <#> (Number of processers to use, default: 1)
```
