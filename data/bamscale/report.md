# bamscale CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bamscale_cov | PASS |  |
| bamscale_scale | PASS |  |

## bamscale_cov

### Tool Description
Calculate coverage of BED coordinates in BAM file(s). Outputs are raw read counts, FPKM and TPM normalized values.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamscale:0.0.9--hf9495ce_0
- **Homepage**: https://github.com/ncbi/BAMscale
- **Package**: https://anaconda.org/channels/bioconda/packages/bamscale/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamscale/overview
- **Total Downloads**: 15.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ncbi/BAMscale
- **Stars**: N/A
### Original Help Text
```text
Calculate coverage of BED coordinates in BAM file(s)
Version: v0.0.6

Usage: BAMscale cov [OPTIONS] --bed <BEDFILE> --bam <BAM_1> (--bam <BAM_2> ... --bam <BAM_N>)

Output: Coverage tables (un-normalized, library-size normalized, FPKM and TPM)

Required options:
	--bed|-b <file>		Input BED file
	--bam|-i <file>		Input BAM file. This can be specified multiple times in case of multiple BAM files

Library options:
	--libtype|-l <str>	Sequencing type to be used. Can be: single, paired, and auto (default: autodetect)
	--frag|-f <flag>	Compute coverage using fragments instead of reads (default: no)
	--strand|-s <flag>	Reads need to have same orientation of peaks (default: unstranded)
	--rstrand|-r <flag>	Reads need to have reverse orientation of peaks (default: unstranded)

Sequencing coverage computation options:
	--seqcov|-e <int>	Compute sequencing coverage from BAM file quickly using the index (option '0'),
				or count number of reads by parsing entire BAM file (slower, but more accurate; set to '1' [default])

	--blacklist|-c <file>	Input file with list of chromosomes to blacklist when computing coverage for normalization

	--bedsubtract|-u <int>	BED file with regions to subtract when computing coverage for normalization
				These coordinates should not overlap so reads are not counted multiple times

Mapping options:
	--mapq|-q <int>		Minimum (at least) mapping quality (default: 0)
	--keepdup|-d <flag>	Keep duplicated reads (default: no)
	--noproper|-p <flag>	Do not filter un-proper alignments (default: filter)
	--unmappair|-m <flag>	Do not remove reads with unmapped pairs
	--minfrag|-g <int>	Minimum fragment size for read pairs (default: 0)
	--maxfrag|-x <int>	Maximum fragment size for read pairs (default: 2000)
	--fragfilt|-w <flag>	Filter reads based on fragment size (default: no)
	--diffchr|-W <flag>	Keep reads where read pair aligns to different chromosome (default: no)

Output options:
	--outdir|-o <str>	Output directory name (default: '.')
	--prefix|-n <str>	Output prefix for file names (default: none)

Performance options:
	--threads|-t <int>	No. of threads to use (default: 1)
```

## bamscale_scale

### Tool Description
Convert BAM files to BigWigs; scale one or multiple files to genome size or to each other.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamscale:0.0.9--hf9495ce_0
- **Homepage**: https://github.com/ncbi/BAMscale
- **Package**: https://anaconda.org/channels/bioconda/packages/bamscale/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamscale/overview
- **Total Downloads**: 15.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ncbi/BAMscale
- **Stars**: N/A
### Original Help Text
```text
Scale one or multiple BAM files
Version: v0.0.6

Usage: BAMscale scale [OPTIONS] --bam <BAM_1> (--bam <BAM_2> ... --bam <BAM_N>)

Output: Coverage tracks in BigWig format (un-scaled, scaled, genome scaled)

Required options:
	--bam|-i <file>		Input BAM file. This has to be specified at least two times.

Library options:
	--libtype|-l <str>	Sequencing type to be used. Can be: single, paired, and auto (default: autodetect)
	--frag|-f <flag>	Compute coverage using fragments instead of reads (default: no)
	--fragsize|-a <int>	Fragment size to be used to extend single-end library reads

Normalization, scaling and operation type:
	--normtype|-y <str>	Type of normalization. (default: base)
				If no normalization is needed, set '--scale no' argument, the program will disregard this option.
				Options: 
				  1) reads: No. of mapped reads/fragments
				  2) base: Sum of per-base coverage of reads/fragments

	--scale|-k <str>	Method to scale samples together. (default: genome)
				Options are: 
				  1) no: no scaling, just calculate coverage
				  2) smallest: scale reads to smallest library (multiple-samples only)
				  3) genome: scale samples to 1x genome coverage (only possible with 'base' normalization type)

				  4) custom: scale to custom scaling factor (--factor or -F <float> has to be supplied)


	--factor|-F <float>	Scaling factor(s) when "--scale custom" normalization is selected.
				  If multiple samples are specified, scaling factors should be comma (",") delimited.
				  example in case of three input BAM files: 0.643,0.45667,1.3.

	--operation|-r <str>	Operation to perform when scaling samples. Default: scaled
				Options are: 
				  1) scaled: output scaled tracks
				  2) unscaled: do not scale files in any way
				  3) log2: log2 transform against first BAM file
				  4) ratio: coverage ratio against first BAM file.
				  5) subtract: subtract coverage against first BAM file.
				  5) rfd: OK-seq RFD calculation
				  6) endseq: strand-specific coverages
				  7) endseqr: strand-specific coverages (reverse strand score is negative)
				  8) reptime: replication timing mode for two BAM files (binsize: 100bp, smoothen: 500 bins)
				  9) rna: coverage of RNA-seq file (one file at a time)
				  10) strandrna: stranded coverage of RNA-seq file (one file at a time)
				  11) strandrnaR: stranded coverage of RNA-seq file (reverse is negative, one file at a time)

				Short description of settings:
				endseq: generates scaled coverage tracks of positive/negative strands,
					and the log2 ratios

				endseqr: generates scaled coverage tracks of positive/negative strands,
					the negative strand coverage will be negative, and the log2 ratios are calculated

				reptime: generates scaled coverage tracks and log2 ratios of two BAM files,
					setting the binsize to 100bp and smoothening smoothen to 500 bins

				rna: coverage of RNA-seq, useful for accurate coverages at exon-intron boundaries

				strandrna: stranded coverage of RNA-seq, useful for accurate coverages at exon-intron boundaries,
					creating separate tracks for forward and reverse strand

				strandrnaR: stranded coverage of RNA-seq, useful for accurate coverages at exon-intron boundaries,
					creating separate tracks for forward and reverse strand, reverse strand is negated

	-S <flag>		Output strand-specific normalized tracks. One BAM file can be specified only

	--binsize|-z <int>	Size of bins for output bigWig/bedgraph generation (default: 20)

Sequencing coverage computation options:
	--seqcov|-e <int>	Compute sequencing coverage from BAM file. (default: '1', count reads while parsing BAM)
				Options are: 
				  1) 0: use reads in index (only if normalization is set to 'reads')
				  2) 1: count reads while parsing BAM(s)
				WARNING: this option is only useful when 'reads' are used for normalization

	--blacklist|-c <file>	Input file with list of chromosomes to blacklist during scaling analysis

	--bedsubtract|-u <int>	BED file with regions to subtract when computing coverage for normalization
				These coordinates should not overlap so reads are not counted multiple times

	--smoothen|-j <int>	Smoothen signal by calculating mean of N bins flanking both sides of each bin (default: 0)
				If set to '0', the signal is not smoothened. To turn on specify a value greater than '0'.
				For replication timing, a good value is to smoothen to 100k bases. If binSize is 100bp, this would be '1000'

	--tracksmooth|-b <int>	Which tracks should be smoothened when performing smoothening (default: '1' meaning only binned track).
				Options are: 
				  1) 0: Smoothen scaled and transformed tracks (log2, ratio or subtracted)
				  2) 1: Smoothen only the scaled sequencing track
				  3) 2: Smoothen only the transformed (log2, ratio or subtract) track

Mapping options:
	--mapq|-q <int>		Minimum (at least) mapping quality (default: 0)
	--keepdup|-d <flag>	Keep duplicated reads (default: no)
	--noproper|-p <flag>	Do not filter un-proper alignments (default: filter)
	--unmappair|-m <flag>	Do not remove reads with unmapped pairs
	--minfrag|-g <int>	Minimum fragment size for read pairs (default: 0)
	--maxfrag|-x <int>	Maximum fragment size for read pairs (default: 2000)
	--fragfilt|-w <flag>	Filter reads based on fragment size (default: no)
	--diffchr|-W <flag>	Keep reads where read pair aligns to different chromosome (default: no)

Output options:
	--outdir|-o <str>	Output directory name (default: '.')

Performance options:
	--threads|-t <int>	No. of threads to use (default: 1)
```


