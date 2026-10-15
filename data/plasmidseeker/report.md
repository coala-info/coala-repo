# plasmidseeker CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| plasmidseeker | Failed | image problem: Rscript is missing in the image, so plasmidseeker stops at startup even with --ponly |

## plasmidseeker

### Tool Description
Identification of known plasmids from bacterial whole-genome sequencing reads using k-mers.

### Metadata
- **Docker Image**: biocontainers/plasmidseeker:v1.0dfsg-1-deb_cv1
- **Homepage**: https://github.com/bioinfo-ut/PlasmidSeeker
- **Package**: https://anaconda.org/channels/bioconda/packages/plasmidseeker/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: /usr/bin/plasmidseeker -d <PLASMID DB DIR> -i <SAMPLE.fastq> -b <CLOSEST BACTERIA TO ISOLATE> -o <OUTPUT FILE>
Options:
	-i	 Input fastq file
	-o	 Output file name (default plasmidseeker_result.txt)
	-d	 Path to plasmid database directory
	-b	 Closest bacteria to isolate genome fna
	-t	 Number of threads used (default 32)
	-f	 Minimum threshold F - at least this fraction of unique k-mers that has to be found for a plasmid (default 80)

	-h	 Print this help
	--verbose	 Print out more working process
	--ponly	 Assumes that reads contain only plasmid sequences (use for extracted plasmids)
	-v	 Print version of the program
```

## Metadata
- **Skill**: generated

