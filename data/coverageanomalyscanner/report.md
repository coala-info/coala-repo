# coverageanomalyscanner CWL Generation Report

## Metadata
- **Skill**: generated

## coverageanomalyscanner_cas

### Tool Description
CAS - The Coverage Anomaly Scanner. Detects coverage anomalies in BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/coverageanomalyscanner:0.2.3--h69ac913_4
- **Homepage**: https://github.com/rki-mf1/CoverageAnomalyScanner
- **Package**: https://anaconda.org/channels/bioconda/packages/coverageanomalyscanner/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Unknown argument: --h
Usage: cas [-h] --bam FILE [--chr INT] [--start INT] [--end INT] [--range VAR] [--threshold FLOAT]

CAS - The Coverage Anomaly Scanner

Optional arguments:
  -h, --help       	shows help message and exits 
  -v, --version    	prints version information and exits 
  -b, --bam FILE   	Read alignment in BAM file format. [required]
  -c, --chr INT    	A 0-based chromosome index from the BAM file. 
  -s, --start INT  	Start position in the chromosome. 
  -e, --end INT    	End position in the chromosome. 
  -r, --range      	Genomic range in SAMTOOLS style, e.g. chr:beg-end 
  --threshold FLOAT	Constant threshold for the anomaly detection. Overwrites the internal default formula. 

by T. Krannich (2022)
```

