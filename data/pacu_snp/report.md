# pacu_snp CWL Generation Report

## pacu_snp_PACU_map

### Tool Description
Map sequencing reads to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pacu_snp:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BioinformaticsPlatformWIV-ISP/PACU
- **Package**: https://anaconda.org/channels/bioconda/packages/pacu_snp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pacu_snp/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-11-10
- **GitHub**: https://github.com/BioinformaticsPlatformWIV-ISP/PACU
- **Stars**: N/A
### Original Help Text
```text
usage: PACU_map [-h] --read-type {ont,illumina} [--fastq-ont FASTQ_ONT]
                [--fastq-ont-name FASTQ_ONT_NAME]
                [--fastq-illumina FASTQ_ILLUMINA FASTQ_ILLUMINA]
                [--fastq-illumina-names FASTQ_ILLUMINA_NAMES FASTQ_ILLUMINA_NAMES]
                --ref-fasta REF_FASTA [--ref-fasta-name REF_FASTA_NAME]
                [--dir-working DIR_WORKING] [--trim] --output OUTPUT
                [--threads THREADS]

options:
  -h, --help            show this help message and exit
  --read-type {ont,illumina}
  --fastq-ont FASTQ_ONT
  --fastq-ont-name FASTQ_ONT_NAME
                        Original FASTQ name (used for Galaxy)
  --fastq-illumina FASTQ_ILLUMINA FASTQ_ILLUMINA
  --fastq-illumina-names FASTQ_ILLUMINA_NAMES FASTQ_ILLUMINA_NAMES
                        Original FASTQ names (used for Galaxy)
  --ref-fasta REF_FASTA
                        Reference FASTA file
  --ref-fasta-name REF_FASTA_NAME
                        Original FASTA file name (used for Galaxy)
  --dir-working DIR_WORKING
                        Working directory
  --trim                Trim reads prior to mapping
  --output OUTPUT       Output BAM file
  --threads THREADS
```


## pacu_snp_PACU

### Tool Description
PACU SNP analysis pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/pacu_snp:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BioinformaticsPlatformWIV-ISP/PACU
- **Package**: https://anaconda.org/channels/bioconda/packages/pacu_snp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PACU [-h] [--ilmn-in ILMN_IN] [--ont-in ONT_IN] --ref-fasta REF_FASTA
            [--ref-bed REF_BED] [--dir-working DIR_WORKING] --output OUTPUT
            [--output-html OUTPUT_HTML] [--use-mega] [--include-ref]
            [--min-snp-af MIN_SNP_AF] [--min-snp-qual MIN_SNP_QUAL]
            [--min-snp-depth MIN_SNP_DEPTH] [--min-snp-dist MIN_SNP_DIST]
            [--skip-gubbins] [--min-global-depth MIN_GLOBAL_DEPTH]
            [--min-mq-depth MIN_MQ_DEPTH] [--bcftools-filt-af1]
            [--image-width IMAGE_WIDTH] [--image-height IMAGE_HEIGHT]
            [--threads THREADS] [--version]

options:
  -h, --help            show this help message and exit
  --ilmn-in ILMN_IN     Directory with Illumina input BAM files
  --ont-in ONT_IN       Directory with ONT input BAM files
  --ref-fasta REF_FASTA
                        Reference FASTA file
  --ref-bed REF_BED     BED file with phage regions
  --dir-working DIR_WORKING
                        Working directory
  --output OUTPUT       Output directory
  --output-html OUTPUT_HTML
                        Output report name
  --use-mega            If set, MEGA is used for the construction of the
                        phylogeny (instead of IQ-TREE)
  --include-ref         If set, the reference genome is included in the
                        phylogeny
  --min-snp-af MIN_SNP_AF
                        Minimum allele frequency for variants
  --min-snp-qual MIN_SNP_QUAL
                        Minimum SNP quality
  --min-snp-depth MIN_SNP_DEPTH
                        Minimum SNP depth
  --min-snp-dist MIN_SNP_DIST
                        Minimum distance between SNPs
  --skip-gubbins        If set, gubbins is skipped
  --min-global-depth MIN_GLOBAL_DEPTH
                        Minimum depth for all samples to include positions in
                        SNP analysis
  --min-mq-depth MIN_MQ_DEPTH
                        MQ cutoff for samtools depth
  --bcftools-filt-af1   If enabled, allele frequency filtering also considers
                        the VAF value
  --image-width IMAGE_WIDTH
                        Image width
  --image-height IMAGE_HEIGHT
                        Image height
  --threads THREADS
  --version             Print version and exit
```

