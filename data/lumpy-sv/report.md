# lumpy-sv CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| lumpy-sv_extractSplitReads_BwaMem | PASS | nf-core bwa-mem chr22 SAM: the 2 split reads (4 alignments with SA tags) are written in lumpy format |
| lumpy-sv_lumpy | PASS | pe+sr run on the lumpy test data: 263 of 276 calls match simulated deletions, like the shipped result; VCF mode also checked |
| lumpy-sv_lumpy_filter | PASS | lumpy test BAM gives a valid discordant BAM with 2288 reads; split BAM is empty because that old bwa-aln BAM has no split alignments |
| lumpy-sv_lumpyexpress | PASS | rewritten from the help; run on the lumpy simulated paired-end BAM (read group added with samtools addreplacerg): 30 deletion calls, all match simulated deletions |
| lumpy-sv_pairend_distro.py | PASS | lumpy test reads give mean 499.95 and stdev 50.16, as simulated |

## Metadata
- **Skill**: generated

## lumpy-sv_lumpyexpress

### Tool Description
An automated script for running the LUMPY structural variant caller.

### Metadata
- **Docker Image**: quay.io/biocontainers/lumpy-sv:0.3.1--3
- **Homepage**: https://github.com/arq5x/lumpy-sv
- **Package**: https://anaconda.org/channels/bioconda/packages/lumpy-sv/overview
- **Validation**: PASS

### Original Help Text
```text
usage:   lumpyexpress [options]

options:
     -B FILE  full BAM or CRAM file(s) (comma separated) (required)
     -S FILE  split reads BAM file(s) (comma separated)
     -D FILE  discordant reads BAM files(s) (comma separated)
     -R FILE  indexed reference genome fasta file (recommended for CRAMs)

     -d FILE  bedpe file of depths (comma separated and prefixed by sample:)
              e.g sample_x:/path/to/sample_x.bedpe,sample_y:/path/to/sample_y.bedpe
     -o FILE  output file [fullBam.bam.vcf]
     -x FILE  BED file to exclude
     -P       output probability curves for each variant
     -m INT   minimum sample weight for a call [4]
     -r FLOAT trim threshold [0]
     -T DIR   temp directory [./output_prefix.XXXXXXXXXXXX]
     -k       keep temporary files

     -K FILE  path to lumpyexpress.config file
                (default: same directory as lumpyexpress)
     -v       verbose
     -h       show this message
```

## lumpy-sv_lumpy

### Tool Description
LUMPY: find structural variants from paired-end, split-read and BEDPE evidence.

### Metadata
- **Docker Image**: quay.io/biocontainers/lumpy-sv:0.3.1--3
- **Homepage**: https://github.com/arq5x/lumpy-sv
- **Package**: https://anaconda.org/channels/bioconda/packages/lumpy-sv/overview
- **Validation**: PASS

### Original Help Text
```text
Program: ********** (v 0.2.13)
Author:  Ryan Layer (rl6sf@virginia.edu)
Summary: Find structural variations in various signals.

Usage:   ********** [OPTIONS] 

Options: 
	-g	Genome file (defines chromosome order)
	-e	Show evidence for each call
	-w	File read windows size (default 1000000)
	-mw	minimum weight for a call
	-msw	minimum per-sample weight for a call
	-tt	trim threshold
	-x	exclude file bed file
	-t	temp file prefix, must be to a writeable directory
	-P	output probability curve for each variant
	-b	output BEDPE instead of VCF
	-sr	bam_file:<file name>,
		id:<sample name>,
		back_distance:<distance>,
		min_mapping_threshold:<mapping quality>,
		weight:<sample weight>,
		min_clip:<minimum clip length>,
		read_group:<string>

	-pe	bam_file:<file name>,
		id:<sample name>,
		histo_file:<file name>,
		mean:<value>,
		stdev:<value>,
		read_length:<length>,
		min_non_overlap:<length>,
		discordant_z:<z value>,
		back_distance:<distance>,
		min_mapping_threshold:<mapping quality>,
		weight:<sample weight>,
		read_group:<string>

	-bedpe	bedpe_file:<bedpe file>,
		id:<sample name>,
		weight:<sample weight>
```

## lumpy-sv_lumpy_filter

### Tool Description
Extract split-read and discordant-pair alignments from a BAM file for LUMPY.

### Metadata
- **Docker Image**: quay.io/biocontainers/lumpy-sv:0.3.1--3
- **Homepage**: https://github.com/arq5x/lumpy-sv
- **Package**: https://anaconda.org/channels/bioconda/packages/lumpy-sv/overview
- **Validation**: PASS

### Original Help Text
```text
lumpy_filter: usage	:lumpy_filter -f <optional-reference> <bam> <split out> <discord out> (optional #threads)
```

## lumpy-sv_extractSplitReads_BwaMem

### Tool Description
Get split-read alignments from bwa-mem in LUMPY compatible format.

### Metadata
- **Docker Image**: quay.io/biocontainers/lumpy-sv:0.3.1--3
- **Homepage**: https://github.com/arq5x/lumpy-sv
- **Package**: https://anaconda.org/channels/bioconda/packages/lumpy-sv/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: extractSplitReads_BwaMem -i <file>

extractSplitReads_BwaMem v0.1.0
Author: Ira Hall
Description: Get split-read alignments from bwa-mem in lumpy compatible format. Ignores reads marked as duplicates.
Works on read or position sorted SAM input. Tested on bwa mem v0.7.5a-r405.
	

Options:
  -h, --help            show this help message and exit
  -i FILE, --inFile=FILE
                        A SAM file or standard input (-i stdin).
  -n INT, --numSplits=INT
                        The maximum number of split-read mappings to allow per
                        read. Reads with more are excluded. Default=2
  -d, --includeDups     Include alignments marked as duplicates. Default=False
  -m INT, --minNonOverlap=INT
                        minimum non-overlap between split alignments on the
                        query (default=20)
```

## lumpy-sv_pairend_distro.py

### Tool Description
Estimate the insert size distribution of a paired-end library.

### Metadata
- **Docker Image**: quay.io/biocontainers/lumpy-sv:0.3.1--3
- **Homepage**: https://github.com/arq5x/lumpy-sv
- **Package**: https://anaconda.org/channels/bioconda/packages/lumpy-sv/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairend_distro.py [options]

Options:
  -h, --help            show this help message and exit
  -r READ_LENGTH, --read_length=READ_LENGTH
                        Read length
  -X X                  Number of stdevs from mean to extend
  -N N                  Number to sample
  -o OUTPUT_FILE        Output file
  -m MADS               Outlier cutoff in # of median absolute deviations
                        (unscaled, upper only)
```

