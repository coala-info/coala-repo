# nthits CWL Generation Report

## nthits

### Tool Description
Filters k-mers based on counts (cmin <= count <= cmax) in input files

### Metadata
- **Docker Image**: quay.io/biocontainers/nthits:1.0.3--h4ac6f70_1
- **Homepage**: https://github.com/bcgsc/ntHits
- **Package**: https://anaconda.org/channels/bioconda/packages/nthits/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nthits/overview
- **Total Downloads**: 11.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/ntHits
- **Stars**: N/A
### Original Help Text
```text
Unknown argument: --help
Usage: ntHits --frequencies VAR --out-file VAR [--min-count VAR] [--max-count VAR] [--kmer-length VAR] [--seeds VAR] [-h] [--error-rate VAR] [--threads VAR] [--solid] [--long-mode] out_type files

Filters k-mers based on counts (cmin <= count <= cmax) in input files

Positional arguments:
  out_type          	Output format: Bloom filter 'bf', counting Bloom filter ('cbf'), or table ('table') [required]
  files             	Input files [nargs: 0 or more] [required]

Optional arguments:
  -f, --frequencies 	Frequency histogram file (e.g. from ntCard) [required]
  -o, --out-file    	Output file's name [required]
  -cmin, --min-count	Minimum k-mer count (>=1), ignored if using --solid [default: 1]
  -cmax, --max-count	Maximum k-mer count (<=254) [default: 254]
  -k, --kmer-length 	k-mer length, ignored if using spaced seeds (-s) [default: 64]
  -s, --seeds       	If specified, use spaced seeds (separate with commas, e.g. 10101,11011) 
  -h, --num-hashes  	Number of hashes to generate per k-mer/spaced seed [default: 3]
  -p, --error-rate  	Target Bloom filter error rate [default: 0.0001]
  -t, --threads     	Number of parallel threads [default: 4]
  --solid           	Automatically tune 'cmin' to filter out erroneous k-mers 
  --long-mode       	Optimize data reader for long sequences (>5kbp) 
  -v                	Level of details printed to stdout (-v: normal, -vv detailed) 

Copyright 2023 Canada's Michael Smith Genome Science Centre
```

