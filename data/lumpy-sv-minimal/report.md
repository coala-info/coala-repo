# lumpy-sv-minimal CWL Generation Report

## lumpy-sv-minimal_lumpyexpress

### Tool Description
Sourcing executables from /usr/local/bin/lumpyexpress.config ...

### Metadata
- **Docker Image**: quay.io/biocontainers/lumpy-sv-minimal:0.3.1--h5ca1c30_7
- **Homepage**: https://github.com/arq5x/lumpy-sv
- **Package**: https://anaconda.org/channels/bioconda/packages/lumpy-sv-minimal/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lumpy-sv-minimal/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-08-19
- **GitHub**: https://github.com/arq5x/lumpy-sv
- **Stars**: N/A
### Original Help Text
```text
Sourcing executables from /usr/local/bin/lumpyexpress.config ...

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

Error: neither samtools nor sambamba were found. Please set path of one of these in /usr/local/bin/lumpyexpress.config file
```


## lumpy-sv-minimal_lumpy

### Tool Description
Find structural variations in various signals.

### Metadata
- **Docker Image**: quay.io/biocontainers/lumpy-sv-minimal:0.3.1--h5ca1c30_7
- **Homepage**: https://github.com/arq5x/lumpy-sv
- **Package**: https://anaconda.org/channels/bioconda/packages/lumpy-sv-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
*****ERROR: Unrecognized parameter: -help *****


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


## Metadata
- **Skill**: generated
