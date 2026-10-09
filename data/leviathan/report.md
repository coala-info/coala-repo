# leviathan CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| leviathan_LEVIATHAN | PASS | ran on the LEVIATHAN example BAM; 30 SVs (INV/DUP/DEL); fixed -o flag, .bai secondary file and candidates output |
| leviathan_LRez_compare | PASS | ran on the example BAM; shared barcodes for region pairs match the LEVIATHAN candidates (7) |
| leviathan_LRez_extract | PASS | ran on the example BAM region; 806 barcodes |
| leviathan_LRez_index_bam | PASS | ran on the LEVIATHAN example BAM; positions and offsets indexes built and used by later runs |
| leviathan_LRez_index_fastq | PASS | synthetic data: FASTQ made from example BAM reads with BX tags; index built |
| leviathan_LRez_query_bam | PASS | ran on the example BAM; alignments of the query barcode returned as SAM with header |
| leviathan_LRez_query_fastq | PASS | synthetic data: FASTQ made from example BAM reads; 16 reads of the query barcode returned |
| leviathan_LRez_stats | PASS | ran on the example BAM; barcode and read counts look right |

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


## leviathan_LRez_compare

### Tool Description
compute the number of common barcodes between all possibles pairs of a given list of regions, or between a given contig's extremities and all other contigs' extremities

### Metadata
- **Docker Image**: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
- **Homepage**: https://github.com/morispi/LEVIATHAN
- **Package**: https://anaconda.org/channels/bioconda/packages/leviathan/overview
- **Validation**: PASS

### Original Help Text
```text
LRez v2.2.4
Pierre Morisse <pierre.morisse@inria.fr>
LRez compare allows to compute the number of common barcodes between all possibles pairs of a given list of regions, or between a given contig's extremities and all other contigs' extremities

USAGE:
	LRez compare [ARGS]

ARGS:
	-b, --bam	 BAM file containing the alignments
	-i, --index	 Barcodes offsets index built with the index bam subcommand
	-r, --regions	 File containing regions of interest in format chromosome:startPosition-endPosition
	-c, --contig	 Contig of interest
	-C, --contigs	 File containing a list of contigs of interest
	-s, --size	 Size of contigs' extremities to consider (optional, default: 1000)
	-o, --output	 File where to output the results (optional, default: stdout)
	-t, --threads	 Number of threads to use when comparing a list of contigs (optional, default: 1)
```

## leviathan_LRez_extract

### Tool Description
extract the list of barcodes in a given region of a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
- **Homepage**: https://github.com/morispi/LEVIATHAN
- **Package**: https://anaconda.org/channels/bioconda/packages/leviathan/overview
- **Validation**: PASS

### Original Help Text
```text
LRez v2.2.4
Pierre Morisse <pierre.morisse@inria.fr>
LRez extract allows to extract the list of barcodes in a given region of a BAM file.

USAGE:
	LRez extract [ARGS]

ARGS:
	-b, --bam		 BAM file to extract barcodes from
	-r, --region		 Region of interest in format chromosome:startPosition-endPosition
	-a, --all		 Extract all barcodes
	-o, --output		 File where to output the extracted barcodes (optional, default: stdout)
	-d, --duplicates	 Include duplicate barcodes (optional, default: false)
	-t, --threads	 Number of threads to use when comparing a list of contigs (optional, default: 1)
```

## leviathan_LRez_stats

### Tool Description
retrieve general stats from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
- **Homepage**: https://github.com/morispi/LEVIATHAN
- **Package**: https://anaconda.org/channels/bioconda/packages/leviathan/overview
- **Validation**: PASS

### Original Help Text
```text
LRez v2.2.4
Pierre Morisse <pierre.morisse@inria.fr>
LRez stats allows to retrieve general stats from a BAM file.

USAGE:
	LRez stats [ARGS]

ARGS:
	-b, --bam	 BAM file to retrieve stats from
	-r, --regions	 Number of regions to consider to define stats (optional, default: 1000)
	-s, --size	 Size of the regions to consider (optional, default: 1000) 
	-o, --output	 File where to output the extracted reads (optional, default: stdout)
	-t, --threads	 Number of threads to use when comparing a list of contigs (optional, default: 1)
```

## leviathan_LRez_index_bam

### Tool Description
index the offsets or occurrences positions of the barcodes contained in a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
- **Homepage**: https://github.com/morispi/LEVIATHAN
- **Package**: https://anaconda.org/channels/bioconda/packages/leviathan/overview
- **Validation**: PASS

### Original Help Text
```text
LRez v2.2.4
Pierre Morisse <pierre.morisse@inria.fr>
LRez index bam allows to index the offsets or occurrences positions of the barcodes contained in a BAM file.

USAGE:
	LRez index bam [ARGS]

ARGS:
	-b, --bam	 BAM file to index
	-o, --output	 File where to store the index
	-f, --offsets	 Index the offsets of the barcodes in the BAM file
	-p, --positions	 Index the (chromosome, begPosition) occurrences positions of the barcodes
	-r, --primary	 Only index barcodes that appear in a primary alignment (optional, default: false)
	-q, --quality	 Only index barcodes that appear in an alignment of quality higher than this number (optional, default: 0)
	-t, --threads	 Number of threads to use to build the index (optional, default: 1)
```

## leviathan_LRez_index_fastq

### Tool Description
index the offsets of the barcodes contained in a fastq file.

### Metadata
- **Docker Image**: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
- **Homepage**: https://github.com/morispi/LEVIATHAN
- **Package**: https://anaconda.org/channels/bioconda/packages/leviathan/overview
- **Validation**: PASS

### Original Help Text
```text
LRez v2.2.4
Pierre Morisse <pierre.morisse@inria.fr>
LRez index fastq allows to index the offsets of the barcodes contained in a fastq file.

USAGE:
	LRez index fastq [ARGS]

ARGS:
	-f, --fastq	 Fastq file to index
	-o, --output	 File where to store the index
	-g, --gzip	 Fastq file is gzipped (optional, default: false)
	-t, --threads	 Number of threads to use to build the index (optional, default: 1)
```

## leviathan_LRez_query_bam

### Tool Description
query a barcodes index and a BAM file to retrieve alignments containing the query barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
- **Homepage**: https://github.com/morispi/LEVIATHAN
- **Package**: https://anaconda.org/channels/bioconda/packages/leviathan/overview
- **Validation**: PASS

### Original Help Text
```text
LRez v2.2.4
Pierre Morisse <pierre.morisse@inria.fr>
LRez query bam allows to query a barcodes index and a BAM file to retrieve alignments containing the query barcodes.
Matched alignments are returned in SAM format.

USAGE:
	LRez query bam [ARGS]

ARGS:
	-b, --bam	 BAM file to search
	-i, --index	 Barcodes offsets index, built with the index bam subcommand.
	-q, --query	 Query barcode to search in the BAM / index
	-l, --list	 File containing a list of barcodes to search in the BAM / index
	-o, --output	 File where to output the extracted alignments (optional, default: stdout)
	-H, --header	 Output SAM header (optional, default: false)
	-t, --threads	 Number of threads to use when querying with a list of barcodes (optional, default: 1)
```

## leviathan_LRez_query_fastq

### Tool Description
query a barcodes index and a fastq file to retrieve alignments containing the query barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
- **Homepage**: https://github.com/morispi/LEVIATHAN
- **Package**: https://anaconda.org/channels/bioconda/packages/leviathan/overview
- **Validation**: PASS

### Original Help Text
```text
LRez v2.2.4
Pierre Morisse <pierre.morisse@inria.fr>
LRez query fastq allows to query a barcodes index and a fastq file to retrieve alignments containing the query barcodes.
Matched alignments are returned in SAM format.

USAGE:
	LRez query fastq [ARGS]

ARGS:
	-f, --fastq	 Fastq file to search
	-i, --index	 Barcodes index, built with the index fastq subcommand
	-q, --query	 Query barcode to search in the fastq file and the index
	-l, --list	 File containing a list of barcodes to search in the fastq file and the index
	-c, --collectionOfLists	 File of files (FOF) e.g. file containing files' names of lists of barcodes to search in the fastq file and the index
	-o, --output	 File where to output the extracted reads (optional, default: stdout)
	-g, --gzip	 Fastq file is gzipped (optional, default: false)
	-t, --threads	 Number of threads to use when querying with a list of barcodes (optional, default: 1)
```

## Metadata
- **Skill**: generated
