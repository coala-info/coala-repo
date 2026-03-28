# leviathan CWL Generation Report

## leviathan_LRez

### Tool Description
LRez allows to work with barcoded Linked-Reads, and offers various barcode management functionalities.

### Metadata
- **Docker Image**: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
- **Homepage**: https://github.com/morispi/LEVIATHAN
- **Package**: https://anaconda.org/channels/bioconda/packages/leviathan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/leviathan/overview
- **Total Downloads**: 10.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/morispi/LEVIATHAN
- **Stars**: N/A
### Original Help Text
```text
LRez v2.2.4
Pierre Morisse <pierre.morisse@inria.fr>
LRez allows to work with barcoded Linked-Reads, and offers various barcode management functionalities.

USAGE:
	LRez [SUBCOMMAND]

SUBCOMMANDS:
	compare		 Compute the number of common barcodes between pairs of regions, or between pairs of contigs' extremities
	extract		 Extract the barcodes from a given region of a BAM file
	stats		 Retrieve general stats from a BAM file
	index bam	 Index the offsets or occurrences positions of the barcodes contained in a BAM file
	query bam	 Query the barcodes index to retrieve alignments in a BAM file, given a barcode or list of barcodes
	index fastq	 Index the offsets of the barcodes contained in a fastq file
	query fastq	 Query the barcodes index to retrieve alignments in a fastq file, given a barcode or list of barcodes
```


## leviathan_LEVIATHAN

### Tool Description
Linked-reads based structural variant caller with barcode indexing

### Metadata
- **Docker Image**: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
- **Homepage**: https://github.com/morispi/LEVIATHAN
- **Package**: https://anaconda.org/channels/bioconda/packages/leviathan/overview
- **Validation**: PASS

### Original Help Text
```text
LEVIATHAN v.1.0
Pierre Morisse <pierre.morisse@inria.fr>
LEVIATHAN: Linked-reads based structural variant caller with barcode indexing

USAGE:
	LEVIATHAN -b bamFile.bam -i barcodeIndex.bci -g genome.fasta -o output.vcf [OPTIONS]

INPUT:
	bamFile.bam:              BAM file to analyze. Warning: the associated .bai file must exist
	barcodeIndex.bci:         LRez barcode occurrence positions index of the BAM file
	genome.fasta:             The reference genome in FASTA format
	output.vcf:               VCF file where to ouput the SVs

OPTIONS:
	-r --regionSize:          Size of the regions on the reference genome to consider (default: 1000)
	-v, --minVariantSize:     Minimum size of the SVs to detect (default: same as regionSize)
	-n, --maxLinks:           Remove from candidates list all candidates which have a region involved in that much candidates (default: 1000) 
	-M, --mediumSize:         Minimum size of medium variants (default: 2000)
	-L, --largeSize:          Minimum size of large variants (default: 10000)
	-s, --smallRate:          Percentile to chose as a threshold in the distribution of the number of shared barcodes for small variants (default: 99)
	-m, --mediumRate:         Percentile to chose as a threshold in the distribution of the number of shared barcodes for medium variants (default: 99)
	-l, --largeRate:          Percentile to chose as a threshold in the distribution of the number of shared barcodes for large variants (default: 99)
	-d, --duplicates:         Consider SV as duplicates if they have the same type and if their breakpoints are within this distance (default: 10)
	-S, --skipTranslocations: Do not process SVs which are translocations (default: false)
	-t, --threads:            Number of threads (default: 8)
	-p, --poolSize:           Size of the thread pool (default: 100000)
	-B, --nbBins:             Number of iterations to perform through the barcode index (default: 10)
	-c, --minBarcodes:        Always remove candidates that share less than this number of barcodes (default: 1)
	-C, --candidates:         File where to store valid SV candidates (default: "candidates.bedpe")
```


## Metadata
- **Skill**: generated
