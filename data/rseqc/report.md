# rseqc CWL Generation Report

## rseqc

### Tool Description
The provided text is a container runtime error log and does not contain help information or arguments for the rseqc tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Total Downloads**: 152.2K
- **Last updated**: 2025-09-04
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```


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
## rseqc_infer_experiment.py

### Tool Description
The provided text does not contain help information for the tool; it contains container environment logs and a fatal error message regarding an OCI image build failure.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
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
## rseqc_read_distribution.py

### Tool Description
The provided text does not contain help information for rseqc_read_distribution.py; it is a log of a fatal error during a container build process. No arguments could be extracted.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

## rseqc_inner_distance.py

### Tool Description
The provided text does not contain help information for the tool; it is a log of a failed container build process. No arguments could be extracted.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

## rseqc_junction_annotation.py

### Tool Description
The provided text does not contain help information for the tool. It appears to be a fatal error log from a container runtime (Singularity/Apptainer) indicating a failure to fetch or build the OCI image.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

## rseqc_junction_saturation.py

### Tool Description
The provided text contains a container runtime error log rather than the tool's help text. Based on the tool name hint 'rseqc_junction_saturation.py', this tool typically checks if the current sequencing depth is sufficient to detect splice junctions by subsampling the total reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

