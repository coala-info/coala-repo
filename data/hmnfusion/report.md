# hmnfusion CWL Generation Report

## hmnfusion_extractfusion

### Tool Description
Extract fusion information from Genefuse and Lumpy results

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnfusion/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hmnfusion/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-08-20
- **GitHub**: https://github.com/guillaume-gricourt/HmnFusion
- **Stars**: N/A
### Original Help Text
```text
usage: hmnfusion extractfusion [-h]
                               (--input-genefuse-json INPUT_GENEFUSE_JSON |
                               --input-genefuse-html INPUT_GENEFUSE_HTML)
                               --input-lumpy-vcf INPUT_LUMPY_VCF
                               [--input-hmnfusion-bed INPUT_HMNFUSION_BED]
                               [--consensus-interval CONSENSUS_INTERVAL]
                               [--output-hmnfusion-json OUTPUT_HMNFUSION_JSON]

options:
  -h, --help            show this help message and exit
  --input-genefuse-json INPUT_GENEFUSE_JSON
                        Genefuse, json file
  --input-genefuse-html INPUT_GENEFUSE_HTML
                        Genefuse, html file
  --input-lumpy-vcf INPUT_LUMPY_VCF
                        Lumpy vcf file
  --input-hmnfusion-bed INPUT_HMNFUSION_BED
                        Bed file
  --consensus-interval CONSENSUS_INTERVAL
                        Interval, pb, for which Fusion are considered equal if
                        their chrom are
  --output-hmnfusion-json OUTPUT_HMNFUSION_JSON
                        Json file output
```


## hmnfusion_quantification

### Tool Description
Quantification of fusions using hmnfusion

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hmnfusion quantification [-h] (--region REGION |
                                --input-hmnfusion-json INPUT_HMNFUSION_JSON)
                                --input-sample-bam INPUT_SAMPLE_BAM
                                [--input-hmnfusion-bed INPUT_HMNFUSION_BED]
                                --name NAME
                                [--baseclipped-interval BASECLIPPED_INTERVAL]
                                [--baseclipped-count BASECLIPPED_COUNT]
                                [--output-hmnfusion-vcf OUTPUT_HMNFUSION_VCF]
                                [--output-hmnfusion-json OUTPUT_HMNFUSION_JSON]

options:
  -h, --help            show this help message and exit
  --region REGION       Region format <chrom>:<postion>
  --input-hmnfusion-json INPUT_HMNFUSION_JSON
                        Output Json produced by command "extractfusion"
  --input-sample-bam INPUT_SAMPLE_BAM
                        Bam file
  --input-hmnfusion-bed INPUT_HMNFUSION_BED
                        Bed file
  --name NAME           Name of sample
  --baseclipped-interval BASECLIPPED_INTERVAL
                        Interval to count hard/soft-clipped bases from fusion
                        point (pb)
  --baseclipped-count BASECLIPPED_COUNT
                        Number of base hard/soft-clipped bases to count in
                        interval (pb)
  --output-hmnfusion-vcf OUTPUT_HMNFUSION_VCF
                        Vcf file output
  --output-hmnfusion-json OUTPUT_HMNFUSION_JSON
                        Json file output
```


## hmnfusion_mmej-deletion

### Tool Description
Analyze MMEJ-mediated deletions using VCF files and a reference genome

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hmnfusion mmej-deletion [-h]
                               [--input-sample-vcf INPUT_SAMPLE_VCF [INPUT_SAMPLE_VCF ...]]
                               --input-reference-fasta INPUT_REFERENCE_FASTA
                               [--output-hmnfusion-xlsx OUTPUT_HMNFUSION_XLSX]

options:
  -h, --help            show this help message and exit
  --input-sample-vcf INPUT_SAMPLE_VCF [INPUT_SAMPLE_VCF ...]
                        Vcf file
  --input-reference-fasta INPUT_REFERENCE_FASTA
                        Genome of reference
  --output-hmnfusion-xlsx OUTPUT_HMNFUSION_XLSX
                        Output file
```


## hmnfusion_mmej-fusion

### Tool Description
Analyze MMEJ (Microhomology-Mediated End Joining) fusions from HmnFusion results

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hmnfusion mmej-fusion [-h] --input-hmnfusion-json INPUT_HMNFUSION_JSON
                             --input-sample-bam INPUT_SAMPLE_BAM
                             --input-reference-fasta INPUT_REFERENCE_FASTA
                             [--fusion-include-flag FUSION_INCLUDE_FLAG]
                             [--fusion-exclude-flag FUSION_EXCLUDE_FLAG]
                             [--size-to-extract SIZE_TO_EXTRACT] --name NAME
                             --output-hmnfusion-xlsx OUTPUT_HMNFUSION_XLSX
                             [--output-hmnfusion-json OUTPUT_HMNFUSION_JSON]

options:
  -h, --help            show this help message and exit
  --input-hmnfusion-json INPUT_HMNFUSION_JSON
                        HmnFusion, json file
  --input-sample-bam INPUT_SAMPLE_BAM
                        Bam file
  --input-reference-fasta INPUT_REFERENCE_FASTA
                        Reference, fasta file
  --fusion-include-flag FUSION_INCLUDE_FLAG
                        Select fusions with fusion-flag
  --fusion-exclude-flag FUSION_EXCLUDE_FLAG
                        Exclude fusions with fusion-flag
  --size-to-extract SIZE_TO_EXTRACT
                        Size of sequence to extract before and after the
                        genomic coordinate (even number)
  --name NAME           Name of sample
  --output-hmnfusion-xlsx OUTPUT_HMNFUSION_XLSX
                        Excel file output
  --output-hmnfusion-json OUTPUT_HMNFUSION_JSON
                        Json file output
```


## hmnfusion_workflow-align

### Tool Description
Hmnfusion workflow for alignment of fastq files

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hmnfusion workflow-align [-h] [--input-config-json INPUT_CONFIG_JSON]
                                --input-forward-fastq INPUT_FORWARD_FASTQ
                                --input-reverse-fastq INPUT_REVERSE_FASTQ
                                --name NAME
                                [--input-design-bed INPUT_DESIGN_BED]
                                --output-directory OUTPUT_DIRECTORY
                                [--tmpdir TMPDIR] [--platform PLATFORM]
                                [--threads [1-6]]

options:
  -h, --help            show this help message and exit
  --input-config-json INPUT_CONFIG_JSON
                        Input config file
  --input-forward-fastq INPUT_FORWARD_FASTQ
                        Fastq file forward
  --input-reverse-fastq INPUT_REVERSE_FASTQ
                        Fastq file reverse
  --name NAME           Name of sample
  --input-design-bed INPUT_DESIGN_BED
                        Design bed file
  --output-directory OUTPUT_DIRECTORY
                        Directory to output
  --tmpdir TMPDIR       Directory used for temporary results
  --platform PLATFORM   Platform label to indicate into RGLINE of the BAM file
  --threads [1-6]       Threads used
```


## hmnfusion_workflow-hmnfusion

### Tool Description
HmnFusion workflow for processing Lumpy and Genefuse results

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hmnfusion workflow-hmnfusion [-h] --input-lumpy-vcf INPUT_LUMPY_VCF
                                    (--input-genefuse-json INPUT_GENEFUSE_JSON |
                                    --input-genefuse-html INPUT_GENEFUSE_HTML)
                                    --input-sample-bam INPUT_SAMPLE_BAM
                                    [--input-hmnfusion-bed INPUT_HMNFUSION_BED]
                                    --name NAME
                                    --output-hmnfusion-vcf OUTPUT_HMNFUSION_VCF

options:
  -h, --help            show this help message and exit
  --input-lumpy-vcf INPUT_LUMPY_VCF
                        Lumpy Vcf file
  --input-genefuse-json INPUT_GENEFUSE_JSON
                        Genefuse, json file
  --input-genefuse-html INPUT_GENEFUSE_HTML
                        Genefuse, html file
  --input-sample-bam INPUT_SAMPLE_BAM
                        Bam file
  --input-hmnfusion-bed INPUT_HMNFUSION_BED
                        HmnFusion bed file
  --name NAME           Name of sample
  --output-hmnfusion-vcf OUTPUT_HMNFUSION_VCF
                        Vcf file output
```


## hmnfusion_workflow-fusion

### Tool Description
HmnFusion workflow for fusion detection

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hmnfusion workflow-fusion [-h]
                                 [--input-forward-fastq INPUT_FORWARD_FASTQ]
                                 [--input-reverse-fastq INPUT_REVERSE_FASTQ]
                                 --input-sample-bam INPUT_SAMPLE_BAM
                                 [--input-genefuse-bed INPUT_GENEFUSE_BED]
                                 [--input-lumpy-bed INPUT_LUMPY_BED]
                                 [--input-hmnfusion-bed INPUT_HMNFUSION_BED]
                                 --input-reference-fasta INPUT_REFERENCE_FASTA
                                 --name NAME
                                 --output-hmnfusion-vcf OUTPUT_HMNFUSION_VCF
                                 --output-genefuse-html OUTPUT_GENEFUSE_HTML
                                 --output-lumpy-vcf OUTPUT_LUMPY_VCF
                                 [--threads [1-6]]

options:
  -h, --help            show this help message and exit
  --input-forward-fastq INPUT_FORWARD_FASTQ
                        Fastq file forward
  --input-reverse-fastq INPUT_REVERSE_FASTQ
                        Fastq file reverse
  --input-sample-bam INPUT_SAMPLE_BAM
                        Bam file
  --input-genefuse-bed INPUT_GENEFUSE_BED
                        Genefuse bed file
  --input-lumpy-bed INPUT_LUMPY_BED
                        Lumpy bed file
  --input-hmnfusion-bed INPUT_HMNFUSION_BED
                        HmnFusion bed file
  --input-reference-fasta INPUT_REFERENCE_FASTA
                        Reference fasta file (hg19)
  --name NAME           Name of sample
  --output-hmnfusion-vcf OUTPUT_HMNFUSION_VCF
                        Vcf file output
  --output-genefuse-html OUTPUT_GENEFUSE_HTML
                        Genefuse html file output
  --output-lumpy-vcf OUTPUT_LUMPY_VCF
                        Lumpy vcf file output
  --threads [1-6]       Threads used
```


## hmnfusion_install-software

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnfusion/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
24-02-2026 15:43 - INFO - Start - install-software
24-02-2026 15:43 - INFO - Check if software required are installed
Traceback (most recent call last):
  File "/usr/local/bin/hmnfusion", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/hmnfusion/__main__.py", line 18, in main
    args.func(args)
    ~~~~~~~~~^^^^^^
  File "/usr/local/lib/python3.13/site-packages/hmnfusion/commands.py", line 723, in _cmd_install_software
    if not install_software.InstallSoftware.required():
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/usr/local/lib/python3.13/site-packages/hmnfusion/install_software.py", line 68, in required
    utils.find_executable(name=software)
    ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/site-packages/hmnfusion/utils.py", line 187, in find_executable
    raise ExecutableNotFound(name)
hmnfusion.utils.ExecutableNotFound: ExecutableNotFound, make
```


## hmnfusion_fusion-flag

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnfusion/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: hmnfusion fusion-flag [-h]

options:
  -h, --help  show this help message and exit
```


## hmnfusion_download-zenodo

### Tool Description
Download files from a Zenodo repository

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
- **Homepage**: https://github.com/guillaume-gricourt/HmnFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hmnfusion download-zenodo [-h] --input-zenodo-str INPUT_ZENODO_STR
                                 [--input-token-str INPUT_TOKEN_STR |
                                 --input-token-txt INPUT_TOKEN_TXT]
                                 --output-directory OUTPUT_DIRECTORY

options:
  -h, --help            show this help message and exit
  --input-zenodo-str INPUT_ZENODO_STR
                        Id of Zenodo repository
  --input-token-str INPUT_TOKEN_STR
                        Token string to access into repository with restricted
                        access
  --input-token-txt INPUT_TOKEN_TXT
                        File with token to access into repository with
                        restricted access
  --output-directory OUTPUT_DIRECTORY
                        Directory to write files
```

