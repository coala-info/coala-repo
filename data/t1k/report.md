# t1k CWL Generation Report

## t1k_t1k-build.pl

### Tool Description
Builds a T1K database from EMBL-ENA dat files, plain gene sequence files, or download links.

### Metadata
- **Docker Image**: quay.io/biocontainers/t1k:1.0.9--h5ca1c30_0
- **Homepage**: https://github.com/mourisl/T1K
- **Package**: https://anaconda.org/channels/bioconda/packages/t1k/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/t1k/overview
- **Total Downloads**: 14.2K
- **Last updated**: 2025-12-24
- **GitHub**: https://github.com/mourisl/T1K
- **Stars**: N/A
### Original Help Text
```text
t1k-build.pl usage: ./t1k-build.pl [OPTIONS]:
Required:
	-d STRING: EMBL-ENA dat file
		Or
	-f STRING: plain gene sequence file
		Or
	--download STRING: IPD-IMGT/HLA or IPD-KIR or user-specified dat file download link
Optional:
	-o STRING: output folder (default: ./)
	-g STRING: genome annotation file (default: not used)
	--target STRING: gene name keyword (default: no filter)
	--prefix STRING: file prefix (default: based on --target or -o)
	--ignore-partial: ignore partial allele at all (default: fill in intron if exons are complete)
	--partial-intron-noseq: the partial introns and pseudo exons are not present in the sequence of the dat file, e.g. IPD-KIR_2.13.0.
```


## t1k_run-t1k

### Tool Description
T1K v1.0.9-r251

### Metadata
- **Docker Image**: quay.io/biocontainers/t1k:1.0.9--h5ca1c30_0
- **Homepage**: https://github.com/mourisl/T1K
- **Package**: https://anaconda.org/channels/bioconda/packages/t1k/overview
- **Validation**: PASS

### Original Help Text
```text
T1K v1.0.9-r251 usage: ./run-t1k [OPTIONS]:
Required:
	-1 STRING -2 STRING: path to paired-end read files
	-u STRING: path to single-end read file
	-i STRING: path to interleaved read file
	-b STRING: path to BAM file
	-f STRING: path to the reference sequence file
Optional:
	-c STRING: path to the gene coordinate file (required when -b input)
	-o STRING: prefix of output files. (default: inferred from file prefix)
	--od STRING: the directory for output files. (default: ./)
	-t INT: number of threads (default: 1)
	-s FLOAT: minimum alignment similarity (default: 0.8)
	-n INT: maximal number of alleles per read (default: 2000)
	--frac FLOAT: filter if abundance is less than the frac of dominant allele (default: 0.15)
	--cov FLOAT: filter genes with average coverage less than the specified value (default: 1.0)
	--crossGeneRate FLOAT: the effect from other gene's expression (0.04)
	--squaremMinAlpha FLOAT: minimum value (should be negative) for the alpha (step length) in the SQUAREM algorithm (default: not set)
	--alleleDigitUnits INT: the number of units in genotyping result (default: automatic)
	--alleleDelimiter CHR: the delimiter character for digit unit (default: automatic)
	--alleleWhitelist STRING: only consider read aligned to the listed allele sereies. (default: not used)
	--barcode STRING: if -b, BAM field for barcode; if -1 -2/-u, file containing barcodes (default: not used)
	--barcodeRange INT INT CHAR: start, end(-1 for length-1), strand in a barcode is the true barcode (default: 0 -1 +)
	--barcodeWhitelist STRING: path to the barcode whitelist (default: not used)
	--read1Range INT INT: start, end(-1 for length-1) in -1/-u files for genomic sequence (default: 0 -1)
	--read2Range INT INT: start, end(-1 for length-1) in -2 files for genomic sequence (default: 0 -1)
	--mateIdSuffixLen INT: the suffix length in read id for mate. (default: not used)
	--abnormalUnmapFlag: the flag in BAM for the unmapped read-pair is nonconcordant (default: not set)
	--relaxIntronAlign: allow one more mismatch in intronic alignment (default: false)
	--preset STRING: preset parameters for cases requiring non-default settings:
		hla: HLA genotyping in general
		hla-wgs: HLA genotyping on WGS data
		kir-wgs: KIR genotyping on WGS data
		kir-wes: KIR genotyping on WES data
	--noExtraction: directly use the files from provided -1 -2/-u for genotyping (default: extraction first)
	--skipPostAnalysis: only conduct genotyping. (default: conduct the post analysis)
	--outputReadAssignment: output the allele assignment for each read to prefix_assign.tsv file (default: not used)
	--stage INT: start genotyping on specified stage (default: 0):
		0: start from beginning (candidate read extraction)
		1: start from genotype with candidate reads
		2: start from post analysis
	Parameters for post analysis:
		--post-varMaxGroup INT: the maximum variant group size to call novel variant. -1 for no limitation (default: 8)
```


## Metadata
- **Skill**: generated
