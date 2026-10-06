# rseqc CWL Generation Report

## Metadata
- **Skill**: generated

## rseqc_bam_stat.py

### Tool Description
Summarizing mapping statistics of a BAM or SAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bam_stat.py [options]

Summarizing mapping statistics of a BAM or SAM file. 

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format.
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) to determine
                        "uniquely mapped" reads. default=30
```
## rseqc_geneBody_coverage.py

### Tool Description
Calculate the RNA-seq reads coverage over gene body.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: geneBody_coverage.py [options]

Calculate the RNA-seq reads coverage over gene body. 

Note:
1) Only input sorted and indexed BAM file(s). SAM format is not supported.
2) Genes/transcripts with mRNA length < 100 will be skipped (Number specified to "-l" cannot be < 100). 

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILES, --input=INPUT_FILES
                        Input file(s) in BAM format. "-i" takes these input:
                        1) a single BAM file. 2) "," separated BAM files. 3)
                        directory containing one or more bam files. 4) plain
                        text file containing the path of one or more bam file
                        (Each row is a BAM file path). All BAM files should be
                        sorted and indexed using samtools.
  -r REF_GENE_MODEL, --refgene=REF_GENE_MODEL
                        Reference gene model in bed format. [required]
  -l MIN_MRNA_LENGTH, --minimum_length=MIN_MRNA_LENGTH
                        Minimum mRNA length (bp). mRNA smaller than
                        "min_mRNA_length" will be skipped. default=100
  -f OUTPUT_FORMAT, --format=OUTPUT_FORMAT
                        Output file format, 'pdf', 'png' or 'jpeg'.
                        default=pdf
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s). [required]
```
