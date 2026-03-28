# varda2-client CWL Generation Report

## varda2-client_submit

### Tool Description
Submit VCF or sample sheet to Varda

### Metadata
- **Docker Image**: quay.io/biocontainers/varda2-client:0.9--py_0
- **Homepage**: https://github.com/varda/varda2-client
- **Package**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Total Downloads**: 17.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/varda/varda2-client
- **Stars**: N/A
### Original Help Text
```text
usage: varda2-client submit [-h] -d DISEASE_CODE [-l LAB_SAMPLE_ID]
                            [-c COV_FN] (-s SAMPLESHEET_FN | -v VAR_FN)

optional arguments:
  -h, --help            show this help message and exit
  -d DISEASE_CODE, --disease-code DISEASE_CODE
                        Disease indication code
  -l LAB_SAMPLE_ID, --lab-sample-id LAB_SAMPLE_ID
                        Local sample id
  -c COV_FN, --coverage-file COV_FN
                        Varda coverage file
  -s SAMPLESHEET_FN, --sample-sheet SAMPLESHEET_FN
                        Sample sheet file: sample_id, gvcf, vcf, bam
  -v VAR_FN, --variants-file VAR_FN
                        Varda variants file
```


## varda2-client_monitor

### Tool Description
Monitor tasks

### Metadata
- **Docker Image**: quay.io/biocontainers/varda2-client:0.9--py_0
- **Homepage**: https://github.com/varda/varda2-client
- **Package**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Validation**: PASS

### Original Help Text
```text
usage: varda2-client monitor [-h] -t TASKS_FN

optional arguments:
  -h, --help            show this help message and exit
  -t TASKS_FN, --task-file TASKS_FN
                        Filename of tasks to monitor
```


## varda2-client_save

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/varda2-client:0.9--py_0
- **Homepage**: https://github.com/varda/varda2-client
- **Package**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: varda2-client save [-h]
varda2-client save: error: argument -h/--help: ignored explicit argument 'elp'
```


## varda2-client_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/varda2-client:0.9--py_0
- **Homepage**: https://github.com/varda/varda2-client
- **Package**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: varda2-client version [-h]
varda2-client version: error: argument -h/--help: ignored explicit argument 'elp'
```


## varda2-client_annotate

### Tool Description
Annotate variants with sample information.

### Metadata
- **Docker Image**: quay.io/biocontainers/varda2-client:0.9--py_0
- **Homepage**: https://github.com/varda/varda2-client
- **Package**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Validation**: PASS

### Original Help Text
```text
usage: varda2-client annotate [-h] (-s SAMPLESHEET_FN | -v VAR_FN)
                              [-l LAB_SAMPLE_ID]

optional arguments:
  -h, --help            show this help message and exit
  -s SAMPLESHEET_FN, --sample-sheet SAMPLESHEET_FN
                        Sample sheet file: sample_id, gvcf, vcf, bam
  -v VAR_FN, --variants-file VAR_FN
                        Varda variants file
  -l LAB_SAMPLE_ID, --lab-sample-id LAB_SAMPLE_ID
                        Local sample id
```


## varda2-client_stab

### Tool Description
Get stabilized sequence for a given region

### Metadata
- **Docker Image**: quay.io/biocontainers/varda2-client:0.9--py_0
- **Homepage**: https://github.com/varda/varda2-client
- **Package**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Validation**: PASS

### Original Help Text
```text
usage: varda2-client stab [-h] -s START -e END -r REFERENCE

optional arguments:
  -h, --help            show this help message and exit
  -s START, --start START
                        Start of region
  -e END, --end END     End of region
  -r REFERENCE, --reference REFERENCE
                        Chromosome to look at
```


## varda2-client_seq

### Tool Description
Sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/varda2-client:0.9--py_0
- **Homepage**: https://github.com/varda/varda2-client
- **Package**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Validation**: PASS

### Original Help Text
```text
usage: varda2-client seq [-h] -s SEQUENCE

optional arguments:
  -h, --help            show this help message and exit
  -s SEQUENCE, --sequence SEQUENCE
                        Sequence
```


## varda2-client_snv

### Tool Description
SNV subcommand for varda2-client

### Metadata
- **Docker Image**: quay.io/biocontainers/varda2-client:0.9--py_0
- **Homepage**: https://github.com/varda/varda2-client
- **Package**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Validation**: PASS

### Original Help Text
```text
usage: varda2-client snv [-h] -p POSITION -i INSERTED -r REFERENCE

optional arguments:
  -h, --help            show this help message and exit
  -p POSITION, --position POSITION
                        Locus position
  -i INSERTED, --inserted INSERTED
                        Inserted base
  -r REFERENCE, --reference REFERENCE
                        Chromosome to look at
```


## varda2-client_mnv

### Tool Description
Finds and reports insertions in a given region.

### Metadata
- **Docker Image**: quay.io/biocontainers/varda2-client:0.9--py_0
- **Homepage**: https://github.com/varda/varda2-client
- **Package**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Validation**: PASS

### Original Help Text
```text
usage: varda2-client mnv [-h] -s START -e END -i INSERTED -r REFERENCE

optional arguments:
  -h, --help            show this help message and exit
  -s START, --start START
                        Start of region
  -e END, --end END     End of region
  -i INSERTED, --inserted INSERTED
                        Inserted sequence
  -r REFERENCE, --reference REFERENCE
                        Chromosome to look at
```


## varda2-client_task

### Tool Description
N/A

### Metadata
- **Docker Image**: quay.io/biocontainers/varda2-client:0.9--py_0
- **Homepage**: https://github.com/varda/varda2-client
- **Package**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Validation**: PASS

### Original Help Text
```text
usage: varda2-client task [-h] -u UUID

optional arguments:
  -h, --help            show this help message and exit
  -u UUID, --uuid UUID  Task UUID
```


## varda2-client_sample

### Tool Description
Sample management for Varda2

### Metadata
- **Docker Image**: quay.io/biocontainers/varda2-client:0.9--py_0
- **Homepage**: https://github.com/varda/varda2-client
- **Package**: https://anaconda.org/channels/bioconda/packages/varda2-client/overview
- **Validation**: PASS

### Original Help Text
```text
usage: varda2-client sample [-h] -u UUID [-d DISEASE_CODE] [-l LAB_SAMPLE_ID]

optional arguments:
  -h, --help            show this help message and exit
  -u UUID, --uuid UUID  Sample UUID
  -d DISEASE_CODE, --disease-code DISEASE_CODE
                        Disease indication code
  -l LAB_SAMPLE_ID, --lab-sample-id LAB_SAMPLE_ID
                        Local sample id
```


## Metadata
- **Skill**: generated
