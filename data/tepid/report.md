# tepid CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tepid_tepid-discover | PASS |  |
| tepid_tepid-map | PASS |  |
| tepid_tepid-map-se | PASS |  |
| tepid_tepid-refine | Not completed | synthetic data: collapsed variant lists built from the real discover output; the tool runs but both ambiguous files come out empty (test BAM has about 0x coverage), so the output cannot be checked |

## tepid_tepid-map

### Tool Description
Map paired-end data using bowtie2 and yaha.

### Metadata
- **Docker Image**: quay.io/biocontainers/tepid:0.10--py_0
- **Homepage**: https://github.com/ListerLab/TEPID
- **Package**: https://anaconda.org/channels/bioconda/packages/tepid/overview
- **Validation**: PASS

### Original Help Text
```text
tepid-map -- map paired-end data using bowtie2 and yaha
  -h  show help and exit
  -x  path to bowtie2 index
  -y  path to yaha index
  -p  number of cores to use
  -s  average insert size
  -n  sample name
  -1  fastq file with #1 mates
  -2  fastq file with #2 mates
  -r  recursive (optional)
  -z  gzip fastq files (optional)
```

## tepid_tepid-map-se

### Tool Description
Map single-end data using bowtie2 and yaha.

### Metadata
- **Docker Image**: quay.io/biocontainers/tepid:0.10--py_0
- **Homepage**: https://github.com/ListerLab/TEPID
- **Package**: https://anaconda.org/channels/bioconda/packages/tepid/overview
- **Validation**: PASS

### Original Help Text
```text
tepid-map-se -- map single-end data using bowtie2 and yaha
  -h  show help and exit
  -x  path to bowtie2 index
  -y  path to yaha index
  -p  number of cores to use
  -n  sample name
  -q  fastq file containing reads
  -r  recursive (optional)
  -z  gzip fastq files (optional)
```

## tepid_tepid-refine

### Tool Description
Refine TE insertion and deletion calls.

### Metadata
- **Docker Image**: quay.io/biocontainers/tepid:0.10--py_0
- **Homepage**: https://github.com/ListerLab/TEPID
- **Package**: https://anaconda.org/channels/bioconda/packages/tepid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tepid-refine [-h] [--version] [-k] [-i INSERTIONS] [-d DELETIONS]
                    [-p PROC] -t TE -n NAME -c CONC -s SPLIT -a ALL_SAMPLES

TEPID -- refine TE insertion and deletion calls

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -k, --keep            keep all intermediate files
  -i INSERTIONS, --insertions INSERTIONS
                        File containing collapsed TE insertions for all
                        samples in population
  -d DELETIONS, --deletions DELETIONS
                        File containing collapsed TE deletions for all samples
                        in population
  -p PROC, --proc PROC  number of processors
  -t TE, --te TE        TE annotation bedfile
  -n NAME, --name NAME  sample name
  -c CONC, --conc CONC  bam file from bowtie2
  -s SPLIT, --split SPLIT
                        split reads bam file from yaha
  -a ALL_SAMPLES, --all_samples ALL_SAMPLES
                        List of all sample names
```

## Metadata
- **Skill**: generated

## tepid_tepid-discover

### Tool Description
TEPID (Transposable Element Polymorphism Identification Detector) discovery step. Identifies transposable element polymorphisms (insertions and deletions) using split-read and discordant read pair analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/tepid:0.10--py_0
- **Homepage**: https://github.com/ListerLab/TEPID
- **Package**: https://anaconda.org/channels/bioconda/packages/tepid/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/tepid:0.10--py_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

