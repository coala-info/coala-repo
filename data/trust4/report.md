# trust4 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| trust4 | PASS | assembled the real example reads into 84 contigs; option -b is documented but the trust4 binary prints usage for it (use bam-extractor) |
| trust4_BuildDatabaseFa | PASS | real human chr22 slice with its GTF (grouped by transcript); sequences equal an independent exon extraction |
| trust4_BuildImgtAnnot | PASS | downloads the current IMGT file (6 MB, NetworkAccess); 1017 of the 1069 gene names in the shipped human_IMGT+C.fa are found |
| trust4_BuildImgtVquestAnnot | Failed | image problem: the script calls wget -r, but the image wget is BusyBox and has no -r option |
| trust4_FilterAnnotatedAssembly | Failed | tool bug: the script expects an old annotation format and dies with 'Wrong format' on the current annotator output |
| trust4_annotator | PASS |  |
| trust4_bam-extractor | PASS |  |
| trust4_fastq-extractor | PASS |  |
| trust4_run-trust4 | PASS |  |
| trust4_trust-airr | PASS |  |
| trust4_trust-barcoderep | Not completed | no barcoded single-cell data; ran on the bulk example CDR3 file and got one empty-barcode row only |
| trust4_trust-cluster | Failed | image problem: the script has no working interpreter line and the image has no python3 (sh syntax error) |
| trust4_trust-simplerep | PASS |  |
| trust4_trust-smartseq | PASS | one cell of the repository example reads; its top clone is in the run-trust4 report; option --cgeneEnd is documented but the script dies with 'Unknown parameter --cgeneEnd' |
| trust4_trust-stats | Failed | image problem: python3 is not installed in the image (env: can't execute 'python3') |

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

## trust4_run-trust4

### Tool Description
TRUST4 pipeline wrapper: extracts candidate reads, assembles contigs, annotates CDR3 and writes the repertoire report.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
TRUST4 v1.1.8-r614 usage: ./run-trust4 [OPTIONS]:
Required:
	-b STRING: path to bam file
	-1 STRING -2 STRING: path to paired-end read files
	-u STRING: path to single-end read file
	-f STRING: path to the fasta file coordinate and sequence of V/D/J/C genes
Optional:
	--ref STRING: path to detailed V/D/J/C gene reference file from IMGT database. (default: not used but recommended)
	-o STRING: prefix of output files. (default: inferred from file prefix)
	--od STRING: the directory for output files. (default: ./)
	-t INT: number of threads (default: 1)
	-k INT: the starting k-mer size for indexing contigs (default: 9)
	--barcode STRING: if -b, bam field for barcode; if -1 -2/-u, file containing barcodes (default: not used)
	--barcodeLevel STRING: barcode is for cell or molecule (default: cell)
	--barcodeWhitelist STRING: path to the barcode whitelist (default: not used)
	--barcodeTranslate STRING: path to the barcode translate file (default: not used)
	--UMI STRING: if -b, bam field for 10x Genomics-like UMI; if -1 -2/-u, file containing 10x Genomics-like UMIs (default: not used)
	--readFormat STRING: format for read, barcode and UMI files (example: r1:0:-1,r2:0:-1,bc:0:15,um:16:-1 for paired-end files with barcode and UMI)
	--repseq: the data is from bulk,non-UMI-based TCR-seq or BCR-seq (default: not set)
	--contigMinCov INT: ignore contigs that have bases covered by fewer than INT reads (default: 0)
	--minHitLen INT: the minimal hit length for a valid overlap (default: auto)
	--mateIdSuffixLen INT: the suffix length in read id for mate. (default: not used)
	--skipMateExtension: do not extend assemblies with mate information, useful for SMART-seq (default: not used)
	--skipReadRealign: do not realign reads in annotator, useful for reducing computation cost of barcode/UMI-based repseq (default: not used)
	--cgeneEnd: skip reads aligned after the first 200bp of the C gene (default: 200)
	--abnormalUnmapFlag: the flag in BAM for the unmapped read-pair is nonconcordant (default: not set)
	--noExtraction: directly use the files from provided -1 -2/-u to assemble (default: extraction first)
	--imgtAdditionalGap STRING: description for additional gap codon position in IMGT (0-based), e.g. "TRAV:7,83" for mouse (default: no)
	--assembleWithRef: conduct the assembly with --ref file (default: use -f file)
	--outputReadAssignment: output read assignment results to the prefix_assign.out file (default: no output)
	--stage INT: start TRUST4 on specified stage (default: 0):
		0: start from beginning (candidate read extraction)
		1: start from assembly
		2: start from annotation
		3: start from generating the report table
	--clean INT: clean up files. 0: no clean. 1: clean intermediate files. 2: only keep AIRR files. (default: 0)
```

## trust4_fastq-extractor

### Tool Description
Extract candidate TCR/BCR reads from FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
./fastq-extractor [OPTIONS]:
Required:
	-f STRING: fasta file containing the receptor genome sequence
	-u STRING: path to single-end read file
		or
	-1 STRING -2 STRING: path to paired-end read files
Optional:
	-o STRING: prefix to the output file (default: toassemble)
	-t INT: number of threads (default: 1)
	--barcode STRING: path to the raw barcode file (default: not used)
	--barcodeWhitelist STRING: path to the barcode whitelist (default: not used)
	--barcodeTranslate STRING: path to the barcode translate file (default: not used)
	--UMI STRING: path to the raw UMI file (default: not used)
	--readFormat STRING: format for read, barcode and UMI files (example: r1:0:-1,r2:0:-1,bc:0:15,um:16:-1 for paired-end files with barcode and UMI)
	--skipBarcodeErrorRead: do not output reads that failed barcode correction or barcode translation. (default: not set)
```

## trust4_bam-extractor

### Tool Description
Extract candidate TCR/BCR reads from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
./bam-extractor [OPTIONS]:
Required:
	-f STRING: fasta file containing the receptor genome sequence
	-b STRING: path to BAM file
Optional:
	-o STRING: prefix to the output file
	-t INT: number of threads (default: 1)
	-u: the flag or order of unaligned read-pair is not ordinary (default: not used)
	--barcode STRING: the barcode field in the bam file (default: not used)
	--UMI STRING: the UMI field in the bam file (default: not used)
	--mateIdSuffixLen INT: the suffix length in read id for mate. (default: not used)
```

## trust4_annotator

### Tool Description
Annotate assembled TCR/BCR contigs with V/D/J/C genes and CDR3 sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
./annotator [OPTIONS]:
Required:
	-f STRING: fasta file containing the receptor genome sequence
	-a STRING: path to the assembly file
Optional:
	-r STRING: path to the reads used in the assembly
	--fasta: the assembly file is in fasta format (default: false)
	--fastq: the assembly file is in fastq format (default: false)
	-t INT: number of threads (default: 1)
	-o STRING: the prefix of the file containing CDR3 information (default: trust)
	--barcode: there is barcode information in -a and -r files (default: not set)
	--UMI: there is UMI information in -r file (default: not set)
	--geneAlignment: output the gene alignment (default: not set)
	--airrAlignment: output the aligned sequences to prefix_airr_align.tsv (default: not set)
	--noImpute: do not impute CDR3 sequence for TCR (default: not set (impute))
	--notIMGT: the receptor genome sequence is not in IMGT format (default: not set(in IMGT format))
	--imgtAddtionalGap STRING: description for additional gap codon position in IMGT (0-based), e.g. "TRAV:7,83" for mouse (default: no)
	--outputCDR3File: output CDR3 file when not using -r option (default: no output)
	--needReverseComplement: reverse complement sequences on another strand (default: no)
	--outputFormat INT: 0-fasta, 1-AIRR. (default: 0 (fasta))
	--readAssignment STRING: output the read assignment to the file (default: no output)
```

## trust4_trust-simplerep

### Tool Description
Summarize the TRUST4 CDR3 file into a repertoire report table.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ./trust-simplerep.pl xxx_cdr3.out [OPTIONS] > trust_report.out
OPTIONS:
	--decimalCnt: the count column uses decimal instead of truncated integer. (default: not used)
	--barcodeCnt: the count column is the number of barcode instead of read support. (default: not used)
	--junction trust_annot.fa: output junction information for the CDR3 (default: not used)
	--reportPartial: include partial CDR3 in report. (default: no partial)
	--filterBarcoderep barcode_report.tsv: only summarize primary CDR3s in the barcode report file. (default: not used)
	--filterBarcoderepReadCnt FLOAT: filter primary CDR3s in the barcode report less than this read count (default: 0)
	--filterTcrError FLOAT: filter TCR CDR3s less than the fraction of representative CDR3 in the consensus. (default: 0.05)
	--filterBcrError FLOAT: filter BCR CDR3s less than the fraction of representative CDR3 in the consensus. (default: 0)
```

## trust4_trust-airr

### Tool Description
Convert the TRUST4 report and annotation files into an AIRR table.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
usage: trust-airr.pl trust_report.tsv trust_annot.fa [OPTIONS] > trust_airr.tsv
	--format STRING: simplerep, cdr3 or barcoderep of the report file
	--airr-align STRING: file of trust_airr_align.tsv
```

## trust4_trust-barcoderep

### Tool Description
Summarize the TRUST4 CDR3 file of barcoded single-cell data into a barcode report table.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ./trust-barcoderep.pl xxx_cdr3.out [OPTIONS] > trust_barcode_report.tsv
OPTIONS:
	-a xxx_annot.fa: TRUST4's annotation file. (default: not used)
	--noImputation: do not perform imputation for partial CDR3. (default: impute)
	--imputeBCR: perform imputation for BCR partial CDR3. (default: no)
	--reportPartial: include partial CDR3 in report. (default: no partial)
	--chainsInBarcode INT: number of chains in a barcode. (default: 2)
```

## trust4_trust-smartseq

### Tool Description
TRUST4 SMART-seq pipeline over a list of cells.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
TRUST4 SMART-seq pipeline usage: perl smartseq-process.pl [OPTIONS]:
	-1 STRING: file containing the list of read 1 (or single-end) files
	-2 STRING: file containing the list of read 2 files.
	-f STRING: path to the fasta file coordinate and sequence of V/D/J/C genes
	--ref STRING: path to detailed V/D/J/C gene reference file from IMGT database. (default: not used but recommended)
	-o STRING: prefix of final output files. (default: TRUST)
	-t INT: number of threads (default: 1)
	--representative INT: number of representative for each detected chain (default: 1)
	--cgeneEnd: skip reads aligned after the first 200bp of the C gene (default: 200)
	--trust-path STRING: TRUST4 executable files (default: same as this script)
```

## trust4_FilterAnnotatedAssembly

### Tool Description
Filter annotated assemblies with a missing CDR3 or inconsistent V/J/C coordinates.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
usage: FilterAnnotatedAssembly.pl annot.out > filter_annot.out
```

## trust4_BuildDatabaseFa

### Tool Description
Build the receptor gene reference fasta from a genome fasta, GTF and gene list.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
usage: perl BuildDatabaseFa.pl reference.fa annotation.gtf interested_gene_name_list > output.fa
```

## trust4_BuildImgtAnnot

### Tool Description
Download IMGT reference sequences and write the gene reference for one species.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
usage: a.pl species_name(Homo_sapiens or others) > output.fa
```

## trust4_BuildImgtVquestAnnot

### Tool Description
Download the IMGT V-QUEST reference directory and write the gene reference for one species.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
usage: a.pl bcrtcr.fa cgene.list species_name(Homo_sapiens or others)
```

## trust4_trust-cluster

### Tool Description
Re-cluster the CDR3 regions of a TRUST4 CDR3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
usage: a.py trust_cdr3.out [OPTIONS] > output
OPTIONS:
	-s FLOAT: similarity of two CDR3s (default: 0.8)
	--prefix STRING: prefix to new cluster name (default: cluster)
	--center: use the center of the cluster for similarity comparison (default: no)
	--representative: use representative CDR3 from each contig for cluster (default: no)
	--format [cdr3, simplerep]: the input format type (default: cdr3)
```

## trust4_trust-stats

### Tool Description
Immune repertoire diversity statistics from a TRUST4 report.

### Metadata
- **Docker Image**: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
- **Homepage**: https://github.com/liulab-dfci/TRUST4
- **Package**: https://anaconda.org/channels/bioconda/packages/trust4/overview
- **Validation**: PASS

### Original Help Text
```text
usage: trust-stats.py [-h] -r REPFILE [-f FORMAT] [--ntaa NTAA]

Immune repertoire diversity statistics

  -r REPFILE   repertoire file
  -f FORMAT    repertoire file format (TRUST4_report, TRUST4_barcode_report,...)
  --ntaa NTAA  Use nucleotide(nt) or amino acids(aa)
```

