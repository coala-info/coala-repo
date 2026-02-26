# calib CWL Generation Report

## calib

### Tool Description
Clustering without alignment using LSH and MinHashing of barcoded reads

### Metadata
- **Docker Image**: quay.io/biocontainers/calib:0.3.4--hdcf5f25_5
- **Homepage**: https://github.com/vpc-ccg/calib
- **Package**: https://anaconda.org/channels/bioconda/packages/calib/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/calib/overview
- **Total Downloads**: 16.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vpc-ccg/calib
- **Stars**: N/A
### Original Help Text
```text
Combined barcode lengths must be a positive integer and each mate barcode length must be non-negative! Note if both mates have the same barcode length you can use -l/--barcode-length parameter instead.
Calib: Clustering without alignment using LSH and MinHashing of barcoded reads
Usage: calib [--PARAMETER VALUE]
Example: calib -f R1.fastq -r R2.fastq -o my_out. -e 1 -l 8 -m 5 -t 2 -k 4 --silent
Calib's paramters arguments:
	-f    --input-forward                 	(type: string;   REQUIRED paramter)
	-r    --input-reverse                 	(type: string;   REQUIRED paramter)
	-o    --output-prefix                 	(type: string;   REQUIRED paramter)
	-s    --silent                        	(type: no value; default: unset)
	-q    --no-sort                       	(type: no value; default:  unset)
	-g    --gzip-input                    	(type: no value; default:  unset)
	-l    --barcode-length                	(type: int;      REQUIRED paramter unless -l1 and -l2 are provided)
	-l1   --barcode-length-1              	(type: int;      REQUIRED paramter unless -l is provided)
	-l2   --barcode-length-2              	(type: int;      REQUIRED paramter unless -l is provided)
	-p    --ignored-sequence-prefix-length	(type: int;      default: 0)
	-m    --minimizer-count               	(type: int;      default: Depends on observed read length;)
	-k    --kmer-size                     	(type: int;      default: Depends on observed read length;)
	-e    --error-tolerance               	(type: int;      default: Depends on observed read length;)
	-t    --minimizer-threshold           	(type: int;      default: Depends on observed read length;)
	-c    --threads                       	(type: int;      default: 1)
	-h    --help
```

