# starseqr CWL Generation Report

## starseqr_starseqr.py

### Tool Description
STAR-SEQR Parameters:

### Metadata
- **Docker Image**: quay.io/biocontainers/starseqr:0.6.7--py36h7eb728f_0
- **Homepage**: https://github.com/ExpressionAnalysis/STAR-SEQR
- **Package**: https://anaconda.org/channels/bioconda/packages/starseqr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/starseqr/overview
- **Total Downloads**: 30.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ExpressionAnalysis/STAR-SEQR
- **Stars**: N/A
### Original Help Text
```text
usage: starseqr.py [-h] -1 FASTQ1 -2 FASTQ2 [-i STAR_INDEX] [-m {0,1}]
                   [-sj STAR_JXNS] [-ss STAR_SAM] [-sb STAR_BAM] -p PREFIX -r
                   FASTA -g GTF [-l LIBRARY] [-t THREADS] [-b BED_FILE]
                   [--subset_type {either,both}] [-a {velvet}] [--keep_dups]
                   [--keep_gene_dups] [--keep_mito] [-v]

STAR-SEQR Parameters:

optional arguments:
  -h, --help            show this help message and exit
  -p PREFIX, --prefix PREFIX
                        prefix to name files. Can be string or /path/to/string
  -r FASTA, --fasta FASTA
                        indexed fasta (.fa)
  -g GTF, --gtf GTF     gtf file. (.gtf)
  -l LIBRARY, --library LIBRARY
                        salmon library type(A, ISF, ISR, etc)
  -t THREADS, --threads THREADS
                        Number of threads to use for STAR and STAR-SEQR. 4-12
                        recommended.
  -b BED_FILE, --bed_file BED_FILE
                        Bed file to subset analysis
  --subset_type {either,both}
                        allow fusions to pass with either one breakend in bed
                        file or require both. Must use -b.
  -a {velvet}, --as_type {velvet}
                        assembler to use
  --keep_dups           keep read duplicates. Use for PCR data or with
                        molecular tags
  --keep_gene_dups      allow internal gene duplications to be considered
  --keep_mito           allow RNA fusions to contain at least one breakpoint
                        from Mitochondria
  -v, --verbose         verbose level... repeat up to three times.

Do Alignment:

  -1 FASTQ1, --fastq1 FASTQ1
                        fastq.gz 1(.gz)
  -2 FASTQ2, --fastq2 FASTQ2
                        fastq.gz 2(.gz)
  -i STAR_INDEX, --star_index STAR_INDEX
                        path to STAR index folder
  -m {0,1}, --mode {0,1}
                        STAR alignment mode. 0=More-specific, 1=More-Sensitive

Use Existing Alignment:

  -sj STAR_JXNS, --star_jxns STAR_JXNS
                        chimeric junctions file produced by STAR
  -ss STAR_SAM, --star_sam STAR_SAM
                        Chimeric.out.sam file produced by STAR. Either use
                        this or -sb
  -sb STAR_BAM, --star_bam STAR_BAM
                        Aligned.sortedByCoord.out.bam file produced by STAR.
                        Must contain chimeric reads with ch tag.
```

