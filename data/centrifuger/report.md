# centrifuger CWL Generation Report

## centrifuger

### Tool Description
Perform taxonomic classification of sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/centrifuger:1.1.0--hf426362_0
- **Homepage**: https://github.com/mourisl/centrifuger
- **Package**: https://anaconda.org/channels/bioconda/packages/centrifuger/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/centrifuger/overview
- **Total Downloads**: 12.1K
- **Last updated**: 2026-02-20
- **GitHub**: https://github.com/mourisl/centrifuger
- **Stars**: N/A
### Original Help Text
```text
./centrifuger [OPTIONS] > output.tsv:
Required:
	-x FILE: index prefix
	-1 FILE -2 FILE: paired-end read
		or
	-u FILE: single-end read
		or
	-i FILE: interleaved read file
		or
	--sample-sheet FILE: list of sample files, each row: "read1 read2 barcode UMI output". Use dot(.) to represent no such file
Optional:
	-t INT: number of threads [1]
	-k INT: report upto <int> distinct, primary assignments for each read pair [1]
	--un STR: output unclassified reads to files with the prefix of <str>
	--cl STR: output classified reads to files with the prefix of <str>
	--barcode STR: path to the barcode file
	--UMI STR: path to the UMI file
	--read-format STR: format for read, barcode and UMI files, e.g. r1:0:-1,r2:0:-1,bc:0:15,um:16:-1 for paired-end files with barcode and UMI
	--min-hitlen INT: minimum length of partial hits [auto]
	--hitk-factor INT: resolve at most <int>*k entries for each hit [40; use 0 for no restriction]
	--merge-readpair: merge overlapped paired-end reads and trim adapters [no merge]
	--expand-taxid: output the tax IDs that are promoted to the final report tax ID [no]
	--barcode-whitelist STR: path to the barcode whitelist file.
	--barcode-translate STR: path to the barcode translation file.
	-v: print the version information and quit
```

