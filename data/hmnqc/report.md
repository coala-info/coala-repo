# hmnqc CWL Generation Report

## hmnqc_quality

### Tool Description
Quality analysis of fastq, bam, and vcf files

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnqc:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnQc
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hmnqc/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/guillaume-gricourt/HmnQc
- **Stars**: N/A
### Original Help Text
```text
usage: hmnqc quality [-h] --input-sample-name INPUT_SAMPLE_NAME
                     [--parameter-threads PARAMETER_THREADS]
                     --output-hmnqc-json OUTPUT_HMNQC_JSON
                     [-iffr INPUT_FASTQ_FORWARD_RAW]
                     [-ifrr INPUT_FASTQ_REVERSE_RAW]
                     [-ifft INPUT_FASTQ_FORWARD_TRIM]
                     [-ifrt INPUT_FASTQ_REVERSE_TRIM]
                     [--input-sample-bam INPUT_SAMPLE_BAM]
                     [--input-sample-bed INPUT_SAMPLE_BED]
                     [--parameter-coverage-cut-off PARAMETER_COVERAGE_CUT_OFF]
                     [--input-sample-vcf INPUT_SAMPLE_VCF]

optional arguments:
  -h, --help            show this help message and exit
  --input-sample-name INPUT_SAMPLE_NAME
                        Name of sample
  --parameter-threads PARAMETER_THREADS
                        Threads
  --output-hmnqc-json OUTPUT_HMNQC_JSON
                        Output json file

Quality of fastq files:
  -iffr INPUT_FASTQ_FORWARD_RAW, --input-fastq-forward-raw INPUT_FASTQ_FORWARD_RAW
                        Fastq forward before trimming
  -ifrr INPUT_FASTQ_REVERSE_RAW, --input-fastq-reverse-raw INPUT_FASTQ_REVERSE_RAW
                        Fastq reverse before trimming
  -ifft INPUT_FASTQ_FORWARD_TRIM, --input-fastq-forward-trim INPUT_FASTQ_FORWARD_TRIM
                        Fastq forward after trimming
  -ifrt INPUT_FASTQ_REVERSE_TRIM, --input-fastq-reverse-trim INPUT_FASTQ_REVERSE_TRIM
                        Fastq reverse after trimming

Quality of bam file:
  --input-sample-bam INPUT_SAMPLE_BAM
                        Bam file to analyse
  --input-sample-bed INPUT_SAMPLE_BED
                        Bed file to compute coverage
  --parameter-coverage-cut-off PARAMETER_COVERAGE_CUT_OFF
                        Cut off coverage to compute

Quality of vcf file:
  --input-sample-vcf INPUT_SAMPLE_VCF
                        Vcf file to analyse
```


## hmnqc_infersexe

### Tool Description
Infer sex based on coverage of autosomes and sex chromosomes from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnqc:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnQc
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnqc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hmnqc infersexe [-h] [-i INPUT_SAMPLE_BAM [INPUT_SAMPLE_BAM ...]] -b
                       INPUT_SAMPLE_BED -o OUTPUT_HMNQC_XLSX
                       [-t PARAMETER_THREADS] [--parameter-verification]
                       [--parameter-simple]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_SAMPLE_BAM [INPUT_SAMPLE_BAM ...], --input-sample-bam INPUT_SAMPLE_BAM [INPUT_SAMPLE_BAM ...]
                        Bam files
  -b INPUT_SAMPLE_BED, --input-sample-bed INPUT_SAMPLE_BED
                        Bed File
  -o OUTPUT_HMNQC_XLSX, --output-hmnqc-xlsx OUTPUT_HMNQC_XLSX
                        Excel output
  -t PARAMETER_THREADS, --parameter-threads PARAMETER_THREADS
                        Threads
  --parameter-verification
                        If sexe can be guess with name sample, it will be
                        checked again coverage
  --parameter-simple    Mean coverage for ChrAutosome, ChrX and ChrY are shown
                        by default
```


## hmnqc_extractvcf

### Tool Description
Extract VAF or SNP information from VCF files into an Excel output

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnqc:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnQc
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnqc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hmnqc extractvcf [-h] [-i INPUT_SAMPLE_VCF [INPUT_SAMPLE_VCF ...]]
                        [-m {snp,vaf}] --input-reference-vcf
                        INPUT_REFERENCE_VCF -o OUTPUT_HMNQC_XLSX
                        [--parameter-variant-caller {ls,hc}]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_SAMPLE_VCF [INPUT_SAMPLE_VCF ...], --input-sample-vcf INPUT_SAMPLE_VCF [INPUT_SAMPLE_VCF ...]
                        Vcf files
  -m {snp,vaf}, --parameter-mode {snp,vaf}
                        Which information to extract
  --input-reference-vcf INPUT_REFERENCE_VCF
                        Vcf file with SNPs to extract
  -o OUTPUT_HMNQC_XLSX, --output-hmnqc-xlsx OUTPUT_HMNQC_XLSX
                        Excel output

Extract VAF:
  --parameter-variant-caller {ls,hc}
                        From which caller VCF samples are created
```


## hmnqc_depthmin

### Tool Description
Calculate minimal depth coverage for QC reporting

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnqc:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnQc
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnqc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hmnqc depthmin [-h] -i INPUT_SAMPLE_BAM -b INPUT_SAMPLE_BED -o
                      OUTPUT_HMNQC_XLSX [-c PARAMETER_CUT_OFF]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_SAMPLE_BAM, --input-sample-bam INPUT_SAMPLE_BAM
                        Bam file
  -b INPUT_SAMPLE_BED, --input-sample-bed INPUT_SAMPLE_BED
                        Bed File
  -o OUTPUT_HMNQC_XLSX, --output-hmnqc-xlsx OUTPUT_HMNQC_XLSX
                        Excel output
  -c PARAMETER_CUT_OFF, --parameter-cut-off PARAMETER_CUT_OFF
                        Minimal CutOff Depth to report
```


## hmnqc_depthtarget

### Tool Description
Calculate depth on target regions for BAM files using a BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnqc:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnQc
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnqc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hmnqc depthtarget [-h] [-i INPUT_SAMPLE_BAM [INPUT_SAMPLE_BAM ...]] -b
                         INPUT_SAMPLE_BED -o OUTPUT_HMNQC_XLSX
                         [-t PARAMETER_THREADS] [-m {target,gene}]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_SAMPLE_BAM [INPUT_SAMPLE_BAM ...], --input-sample-bam INPUT_SAMPLE_BAM [INPUT_SAMPLE_BAM ...]
                        Bam file
  -b INPUT_SAMPLE_BED, --input-sample-bed INPUT_SAMPLE_BED
                        Bed File
  -o OUTPUT_HMNQC_XLSX, --output-hmnqc-xlsx OUTPUT_HMNQC_XLSX
                        Xlsx output
  -t PARAMETER_THREADS, --parameter-threads PARAMETER_THREADS
                        Threads used
  -m {target,gene}, --parameter-mode {target,gene}
                        Concatenate between genes ?
```

