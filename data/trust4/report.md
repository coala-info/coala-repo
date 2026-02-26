# trust4 CWL Generation Report

## trust4

### Tool Description
TRUST4: a tool for TCR/BC repertoire reconstruction from high-throughput sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Total Downloads**: 38.1K
- **Last updated**: 2026-01-12
- **GitHub**: https://github.com/liulab-dfci/TRUST4
- **Stars**: N/A
### Original Help Text
```text
./trust4 [OPTIONS]:
Required:
	-f STRING: fasta file containing the receptor genome sequence
	[Read file]
	-u STRING: path to single-end read file
		or
	-1 STRING -2 STRING: path to paried-end read files
		or
	-b STRING: path to BAM alignment file
Optional:
	-o STRING: prefix of the output file (default: trust)
	-t INT: number of threads (default: 1)
	-c STRING: the path to the kmer count file
	-k INT: the starting k-mer size for indexing contigs (default: 9)
	--minHitLen INT: the minimal hit length for a valid overlap (default: auto)
	--skipMateExtension: skip the step of extension assemblies with mate-pair information
	--trimLevel INT: 0: no trim; 1: trim low quality; 2: trim unmatched (default: 1)
	--barcode STRING: the path to the barcode file (default: not used)
	--UMI STRING: the path to the UMI file (default: not used)
	--cgeneEnd INT: skipping reads mapped to C gene coordinate greater than INT (default: 200)
	--keepNoBarcode: assemble the reads with missing barcodes. (default: ignore the reads)
	--contigMinCov INT: ignore contigs that have bases covered by fewer than INT reads (default: 0)
```

