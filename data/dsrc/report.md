# dsrc CWL Generation Report

## dsrc

### Tool Description
DNA Sequence Reads Compressor

### Metadata
- **Docker Image**: quay.io/biocontainers/dsrc:2015.06.04--h077b44d_10
- **Homepage**: https://github.com/refresh-bio/DSRC
- **Package**: https://anaconda.org/channels/bioconda/packages/dsrc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dsrc/overview
- **Total Downloads**: 44.4K
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/refresh-bio/DSRC
- **Stars**: N/A
### Original Help Text
```text
DSRC - DNA Sequence Reads Compressor
version: 2.02 @ 30.09.2014

usage: dsrc <c|d> [options] <input filename> <output filename>
compression options:
	-d<n>	: DNA compression mode: 0-3, default: 0
	-q<n>	: Quality compression mode: 0-2, default: 0
	-f<1,..>: keep only those fields no. in tag field string, default: keep all
	-b<n>	: FASTQ input buffer size in MB, default: 8
	-o<n>	: Quality offset, default: 0
	-l	: use Quality lossy mode (Illumina binning scheme), default: 0
	-c	: calculate and check CRC32 checksum calculation per block, default: 0
automated compression modes:
	-m<n>	: compression mode, where n:
	 * 0	- fast version with decent ratio (-d0 -q0 -b16)
	 * 1	- slower version with better ratio (-d2 -q2 -b64)
	 * 2	- slow version with best ratio (-d3 -q2 -b256)
both compression and decompression options:
	-t<n>	: processing threads number, default (available h/w threads): 20, max: 64
	-s	: use stdin/stdout for reading/writing raw FASTQ data

	-v	: verbose mode, default: false
usage examples:
* compress SRR001471.fastq file saving DSRC archive to SRR001471.dsrc:
	dsrc c SRR001471.fastq SRR001471.dsrc
* compress file in the fast mode with CRC32 checking and using 4 threads:
	dsrc c -m0 -c -t4 SRR001471.fastq SRR001471.dsrc
* compress file using DNA and Quality compression level 2 and using 512 MB buffer:
	dsrc c -d2 -q2 -b512 SRR001471.fastq SRR001471.dsrc
* compress file in the best mode with lossy Quality mode and preserving only 1–4 fields from record IDs:
	dsrc c -m2 -l -f1,2,3,4 SRR001471.fastq SRR001471.dsrc
* compress in the best mode reading raw FASTQ data from stdin:
	cat SRR001471.fastq | dsrc c -m2 -s SRR001471.dsrc
* decompress SRR001471.dsrc archive saving output FASTQ file to SRR001471.out.fastq:
	dsrc d SRR001471.dsrc SRR001471.out.fastq
* decompress archive using 4 threads and streaming raw FASTQ data to stdout:
	dsrc d -t4 -s SRR001471.dsrc > SRR001471.out.fastq
```

