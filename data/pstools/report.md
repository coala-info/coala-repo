# pstools CWL Generation Report

## pstools_clean_graph

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
- **Homepage**: https://github.com/shilpagarg/pstools
- **Package**: https://anaconda.org/channels/bioconda/packages/pstools/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pstools/overview
- **Total Downloads**: 3.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shilpagarg/pstools
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
start main
```


## pstools_intersect

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
- **Homepage**: https://github.com/shilpagarg/pstools
- **Package**: https://anaconda.org/channels/bioconda/packages/pstools/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
start main
2
```


## pstools_resolve_haplotypes

### Tool Description
Resolve haplotypes using Hi-C mapping and GFA files

### Metadata
- **Docker Image**: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
- **Homepage**: https://github.com/shilpagarg/pstools
- **Package**: https://anaconda.org/channels/bioconda/packages/pstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pstools resolve_haplotypes [options] <hic_mapping file> <gfa file> <output_directory>
Options:
  -t INT     number of threads [8]
```


## pstools_haplotype_scaffold

### Tool Description
Haplotype scaffolding tool using connection files and predicted haplotypes

### Metadata
- **Docker Image**: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
- **Homepage**: https://github.com/shilpagarg/pstools
- **Package**: https://anaconda.org/channels/bioconda/packages/pstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pstools haplotype_scaffold [options] <haplotype connection file> <pred_haplotypes.fa> <output_directory>
Options:
  -t INT     number of threads [8]
  -f STR     identity file path, identity check will be ran if it is enabled and no file is given []
  -i BOOL    enable identity check on contigs, exclude identical ones while scaffolding [false]
```


## pstools_hic_mapping_unitig

### Tool Description
Map Hi-C reads to unitig graphs

### Metadata
- **Docker Image**: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
- **Homepage**: https://github.com/shilpagarg/pstools
- **Package**: https://anaconda.org/channels/bioconda/packages/pstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pstools hic_mapping_unitig [options] <graph.fa> <hic.R1.fastq.gz> <hic.R2.fastq.gz>
Options:
  -k INT     k-mer size [31]
  -p INT     prefix length [20]
  -b INT     set Bloom filter size to 2**INT bits; 0 to disable [0]
  -t INT     number of worker threads [32]
  -K INT     chunk size [100m]
  -o FILE    save mapping relationship to FILE []
Note: -b37 is recommended for human reads
```


## pstools_hic_mapping_haplo

### Tool Description
Map Hi-C reads to predicted haplotypes

### Metadata
- **Docker Image**: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
- **Homepage**: https://github.com/shilpagarg/pstools
- **Package**: https://anaconda.org/channels/bioconda/packages/pstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pstools hic_mapping_haplo [options] <pred_haplotypes.fa> <hic.R1.fastq.gz> <hic.R2.fastq.gz>
Options:
  -k INT     k-mer size [31]
  -b INT     set Bloom filter size to 2**INT bits; 0 to disable [0]
  -t INT     number of worker threads [32]
  -K INT     chunk size [100m]
  -o FILE    save mapping relationship to FILE []
Note: -b37 is recommended for human reads
```


## pstools_qv

### Tool Description
Calculate QV (Quality Value) using Hi-C data and a sequence file

### Metadata
- **Docker Image**: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
- **Homepage**: https://github.com/shilpagarg/pstools
- **Package**: https://anaconda.org/channels/bioconda/packages/pstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pstools qv [options] <seq.fa> <hic.R1.fastq.gz> <hic.R2.fastq.gz>
Options:
  -k INT     k-mer size [31]
  -t INT     number of worker threads [4]
  -K INT     chunk size [100m]
```


## pstools_completeness

### Tool Description
Calculate completeness using Hi-C data and a sequence file

### Metadata
- **Docker Image**: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
- **Homepage**: https://github.com/shilpagarg/pstools
- **Package**: https://anaconda.org/channels/bioconda/packages/pstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pstools completeness [options] <seq.fa> <hic.R1.fastq.gz> <hic.R2.fastq.gz>
Options:
  -k INT     k-mer size [31]
  -t INT     number of worker threads [4]
  -K INT     chunk size [100m]
```


## pstools_phasing_error

### Tool Description
Calculate phasing errors using haplotype assemblies and Hi-C data

### Metadata
- **Docker Image**: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
- **Homepage**: https://github.com/shilpagarg/pstools
- **Package**: https://anaconda.org/channels/bioconda/packages/pstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pstools phasing_error [options] <hap1.fa> <hap2.fa> <hic.R1.fastq.gz> <hic.R2.fastq.gz>
Options:
  -k INT     k-mer size [31]
  -t INT     number of worker threads [4]
  -K INT     chunk size [100m]
```


## Metadata
- **Skill**: generated
