# mity CWL Generation Report

## mity_call

### Tool Description
BAM / CRAM files to run the analysis on. If --bam-file-list is included, this argument is the file containing the list of bam/cram files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mity:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/KCCG/mity
- **Package**: https://anaconda.org/channels/bioconda/packages/mity/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mity/overview
- **Total Downloads**: 556
- **Last updated**: 2025-09-10
- **GitHub**: https://github.com/KCCG/mity
- **Stars**: N/A
### Original Help Text
```text
usage: mity call [-h] [-d] [--reference {hs37d5,hg19,hg38,mm10}]
                 [--custom-reference-fasta CUSTOM_REFERENCE_FASTA]
                 [--custom-reference-genome CUSTOM_REFERENCE_GENOME]
                 [--prefix PREFIX] [--min-mapping-quality MIN_MQ]
                 [--min-base-quality MIN_BQ] [--min-alternate-fraction MIN_AF]
                 [--min-alternate-count MIN_AC] [--p P] [--normalise]
                 [--output-dir OUTPUT_DIR] [--region REGION] [--bam-file-list]
                 [-k]
                 files [files ...]

positional arguments:
  files                 BAM / CRAM files to run the analysis on. If --bam-
                        file-list is included, this argument is the file
                        containing the list of bam/cram files.

options:
  -h, --help            show this help message and exit
  -d, --debug           Enter debug mode
  --reference {hs37d5,hg19,hg38,mm10}
                        Reference genome version to use. Default: hs37d5
  --custom-reference-fasta CUSTOM_REFERENCE_FASTA
                        Specify custom reference fasta file
  --custom-reference-genome CUSTOM_REFERENCE_GENOME
                        Specify custom reference genome file
  --prefix PREFIX       Output files will be named with PREFIX
  --min-mapping-quality MIN_MQ
                        Exclude alignments from analysis if they have a
                        mapping quality less than MIN_MAPPING_QUALITY.
                        Default: 30
  --min-base-quality MIN_BQ
                        Exclude alleles from analysis if their supporting base
                        quality is less than MIN_BASE_QUALITY. Default: 24
  --min-alternate-fraction MIN_AF
                        Require at least MIN_ALTERNATE_FRACTION observations
                        supporting an alternate allele within a single
                        individual in the in order to evaluate the position.
                        Default: 0.01, range = [0,1]
  --min-alternate-count MIN_AC
                        Require at least MIN_ALTERNATE_COUNT observations
                        supporting an alternate allele within a single
                        individual in order to evaluate the position. Default:
                        4
  --p P                 Minimum noise level. This is used to calculate QUAL
                        score. Default: 0.002, range = [0,1]
  --normalise           Run mity normalise the resulting VCF
  --output-dir OUTPUT_DIR
                        Output files will be saved in OUTPUT_DIR. Default: '.'
  --region REGION       Region of MT genome to call variants in. If unset will
                        call variants in entire MT genome as specified in BAM
                        header. Default: Entire MT genome.
  --bam-file-list       Treat the file as a text file of BAM files to be
                        processed. The path to each file should be on one row
                        per bam file.
  -k, --keep            Keep all intermediate files
```


## mity_normalise

### Tool Description
Normalises VCF files from mity.

### Metadata
- **Docker Image**: quay.io/biocontainers/mity:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/KCCG/mity
- **Package**: https://anaconda.org/channels/bioconda/packages/mity/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mity normalise [-h] [-d] [--output-dir OUTPUT_DIR] [--prefix PREFIX]
                      [--allsamples] [-k] [--p P]
                      [--reference {hs37d5,hg19,hg38,mm10}]
                      [--custom-reference-fasta CUSTOM_REFERENCE_FASTA]
                      [--custom-reference-genome CUSTOM_REFERENCE_GENOME]
                      vcf

positional arguments:
  vcf                   vcf.gz file from running mity

options:
  -h, --help            show this help message and exit
  -d, --debug           Enter debug mode
  --output-dir OUTPUT_DIR
                        Output files will be saved in OUTPUT_DIR. Default: '.'
  --prefix PREFIX       Output files will be named with PREFIX
  --allsamples          PASS in the filter requires all samples to pass
                        instead of just one
  -k, --keep            Keep all intermediate files
  --p P                 Minimum noise level. This is used to calculate QUAL
                        scoreDefault: 0.002, range = [0,1]
  --reference {hs37d5,hg19,hg38,mm10}
                        Reference genome version to use. default: hs37d5
  --custom-reference-fasta CUSTOM_REFERENCE_FASTA
                        Specify custom reference fasta file
  --custom-reference-genome CUSTOM_REFERENCE_GENOME
                        Specify custom reference genome file
```


## mity_report

### Tool Description
Create a report from mity VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mity:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/KCCG/mity
- **Package**: https://anaconda.org/channels/bioconda/packages/mity/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mity report [-h] [-d] [--prefix PREFIX] [--min_vaf MIN_VAF]
                   [--output-dir OUTPUT_DIR] [-k] [--contig {MT,chrM}]
                   [--vcfanno-base-path VCFANNO_BASE_PATH]
                   [--custom-vcfanno-config VCFANNO_CONFIG]
                   [--custom-report-config REPORT_CONFIG]
                   [--output-annotated-vcf]
                   vcf [vcf ...]

positional arguments:
  vcf                   mity vcf files to create a report from

options:
  -h, --help            show this help message and exit
  -d, --debug           Enter debug mode
  --prefix PREFIX       Output files will be named with PREFIX
  --min_vaf MIN_VAF     A variant must have at least this VAF to be included
                        in the report. Default: 0.
  --output-dir OUTPUT_DIR
                        Output files will be saved in OUTPUT_DIR. Default: '.'
  -k, --keep            Keep all intermediate files
  --contig {MT,chrM}    Contig used for annotation purposes
  --vcfanno-base-path VCFANNO_BASE_PATH
                        Path to the custom annotations used for vcfanno. Only
                        required if using custom annotations.
  --custom-vcfanno-config VCFANNO_CONFIG
                        Provide a custom vcfanno-config.toml for custom
                        annotations.
  --custom-report-config REPORT_CONFIG
                        Provide a custom report-config.yaml for custom report
                        generation.
  --output-annotated-vcf
                        Output annotated vcf file
```


## mity_merge

### Tool Description
Merge MITY and nuclear VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mity:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/KCCG/mity
- **Package**: https://anaconda.org/channels/bioconda/packages/mity/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mity merge [-h] --mity_vcf MITY_VCF --nuclear_vcf NUCLEAR_VCF
                  [--output-dir OUTPUT_DIR] [--prefix PREFIX]
                  [--reference {hs37d5,hg19,hg38,mm10}] [-d] [-k]

options:
  -h, --help            show this help message and exit
  --mity_vcf MITY_VCF   mity vcf file
  --nuclear_vcf NUCLEAR_VCF
                        nuclear vcf file
  --output-dir OUTPUT_DIR
                        Output files will be saved in OUTPUT_DIR. Default: '.'
  --prefix PREFIX       Output files will be named with PREFIX. The default is
                        to use the nuclear vcf name
  --reference {hs37d5,hg19,hg38,mm10}
                        reference genome version to use. default: hs37d5
  -d, --debug           Enter debug mode
  -k, --keep            Keep all intermediate files
```


## mity_runall

### Tool Description
Run the MITY pipeline on a list of BAM/CRAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mity:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/KCCG/mity
- **Package**: https://anaconda.org/channels/bioconda/packages/mity/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mity runall [-h] [-d] [--reference {hs37d5,hg19,hg38,mm10}]
                   --prefix PREFIX [--min-mapping-quality MIN_MQ]
                   [--min-base-quality MIN_BQ]
                   [--min-alternate-fraction MIN_AF]
                   [--min-alternate-count MIN_AC] [--p P]
                   [--output-dir OUTPUT_DIR] [--region REGION]
                   [--bam-file-list] [-k] [--min_vaf MIN_VAF]
                   [--contig {MT,chrM}]
                   [--vcfanno-base-path VCFANNO_BASE_PATH]
                   [--custom-vcfanno-config VCFANNO_CONFIG]
                   [--custom-report-config REPORT_CONFIG]
                   [--custom-reference-fasta CUSTOM_REFERENCE_FASTA]
                   [--custom-reference-genome CUSTOM_REFERENCE_GENOME]
                   [--output-annotated-vcf]
                   files [files ...]

positional arguments:
  files                 BAM / CRAM files to run the analysis on. If --bam-
                        file-list is included, this argument is the file
                        containing the list of bam/cram files.

options:
  -h, --help            show this help message and exit
  -d, --debug           Enter debug mode
  --reference {hs37d5,hg19,hg38,mm10}
                        Reference genome version to use. Default: hs37d5
  --prefix PREFIX       Output files will be named with PREFIX
  --min-mapping-quality MIN_MQ
                        Exclude alignments from analysis if they have a
                        mapping quality less than MIN_MAPPING_QUALITY.
                        Default: 30
  --min-base-quality MIN_BQ
                        Exclude alleles from analysis if their supporting base
                        quality is less than MIN_BASE_QUALITY. Default: 24
  --min-alternate-fraction MIN_AF
                        Require at least MIN_ALTERNATE_FRACTION observations
                        supporting an alternate allele within a single
                        individual in the in order to evaluate the position.
                        Default: 0.01, range = [0,1]
  --min-alternate-count MIN_AC
                        Require at least MIN_ALTERNATE_COUNT observations
                        supporting an alternate allele within a single
                        individual in order to evaluate the position. Default:
                        4
  --p P                 Minimum noise level. This is used to calculate QUAL
                        score. Default: 0.002, range = [0,1]
  --output-dir OUTPUT_DIR
                        Output files will be saved in OUTPUT_DIR. Default: '.'
  --region REGION       Region of MT genome to call variants in. If unset will
                        call variants in entire MT genome as specified in BAM
                        header. Default: Entire MT genome.
  --bam-file-list       Treat the file as a text file of BAM files to be
                        processed. The path to each file should be on one row
                        per bam file.
  -k, --keep            Keep all intermediate files
  --min_vaf MIN_VAF     A variant must have at least this VAF to be included
                        in the report. Default: 0.
  --contig {MT,chrM}    Contig used for annotation purposes
  --vcfanno-base-path VCFANNO_BASE_PATH
                        Path to the custom annotations used for vcfanno. Only
                        required if using custom annotations.
  --custom-vcfanno-config VCFANNO_CONFIG
                        Provide a custom vcfanno-config.toml for custom
                        annotations.
  --custom-report-config REPORT_CONFIG
                        Provide a custom report-config.yaml for custom report
                        generation.
  --custom-reference-fasta CUSTOM_REFERENCE_FASTA
                        Specify custom reference fasta file
  --custom-reference-genome CUSTOM_REFERENCE_GENOME
                        Specify custom reference genome file
  --output-annotated-vcf
                        Output annotated vcf file
```


## mity_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/mity:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/KCCG/mity
- **Package**: https://anaconda.org/channels/bioconda/packages/mity/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: mity version [-h]

options:
  -h, --help  show this help message and exit
```

