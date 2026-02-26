# qtlseq CWL Generation Report

## qtlseq

### Tool Description
QTL-seq version 2.2.9

### Metadata
- **Docker Image**: quay.io/biocontainers/qtlseq:2.2.9--pyhdfd78af_0
- **Homepage**: https://github.com/YuSugihara/QTL-seq
- **Package**: https://anaconda.org/channels/bioconda/packages/qtlseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/qtlseq/overview
- **Total Downloads**: 33.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/YuSugihara/QTL-seq
- **Stars**: N/A
### Original Help Text
```text
usage: qtlseq -r <FASTA> -p <BAM|FASTQ> -b1 <BAM|FASTQ>
              -b2 <BAM|FASTQ> -n1 <INT> -n2 <INT> -o <OUT_DIR>
              [-F <INT>] [-T] [-e <DATABASE>]

QTL-seq version 2.2.9

optional arguments:
  -h, --help         show this help message and exit
  -r , --ref         Reference FASTA file.
  -p , --parent      FASTQ or BAM file of the parent. If specifying
                     FASTQ, separate paired-end files with a comma,
                     e.g., -p fastq1,fastq2. This option can be
                     used multiple times.
  -b1 , --bulk1      FASTQ or BAM file of bulk 1. If specifying
                     FASTQ, separate paired-end files with a comma,
                     e.g., -b1 fastq1,fastq2. This option can be
                     used multiple times.
  -b2 , --bulk2      FASTQ or BAM file of bulk 2. If specifying
                     FASTQ, separate paired-end files with a comma,
                     e.g., -b2 fastq1,fastq2. This option can be
                     used multiple times.
  -n1 , --N-bulk1    Number of individuals in bulk 1.
  -n2 , --N-bulk2    Number of individuals in bulk 2.
  -o , --out         Output directory. The specified directory must not
                     already exist.
  -F , --filial      Filial generation. This parameter must be greater
                     than 1. [2]
  -t , --threads     Number of threads. If a value less than 1 is specified,
                     QTL-seq will use the maximum available threads. [2]
  -w , --window      Window size in kilobases (kb). [2000]
  -s , --step        Step size in kilobases (kb). [100]
  -D , --max-depth   Maximum depth of variants to be used. [250]
  -d , --min-depth   Minimum depth of variants to be used. [8]
  -N , --N-rep       Number of replicates for simulations to generate
                     null distribution. [5000]
  -T, --trim         Trim FASTQ files using Trimmomatic.
  -a , --adapter     FASTA file containing adapter sequences. This option
                     is used when "-T" is specified for trimming.
  --trim-params      Parameters for Trimmomatic. Input parameters
                     must be comma-separated in the following order:
                     Phred score, ILLUMINACLIP, LEADING, TRAILING,
                      SLIDINGWINDOW, MINLEN. To remove Illumina adapters,
                     specify the adapter FASTA file with "--adapter".
                     If not specified, adapter trimming will be skipped.
                     [33,<ADAPTER_FASTA>:2:30:10,20,20,4:15,75]
  -e , --snpEff      Predict causal variants using SnpEff. Check
                     available databases in SnpEff.
  --line-colors      Colors for threshold lines in plots. Specify a
                     comma-separated list in the order of SNP-index,
                     p95, and p99. ["#C3310F,#009E72,#FDB003"]
  --dot-colors       Colors for dots in plots. Specify a
                     comma-separated list in the order of bulk1,
                     bulk2, and delta. ["#74D3AE,#FFBE0B,#B3B8DD"]
  --mem              Maximum memory per thread when sorting BAM files;
                     suffixes K/M/G are recognized. [1G]
  -q , --min-MQ      Minimum mapping quality for mpileup. [40]
  -Q , --min-BQ      Minimum base quality for mpileup. [18]
  -C , --adjust-MQ   Adjust the mapping quality for mpileup. The default
                     setting is optimized for BWA. [50]
  -v, --version      show program's version number and exit
```

