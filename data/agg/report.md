# agg CWL Generation Report

## agg_ingest1

### Tool Description
ingests a single sample gvcf into a variant-only .bcf and tempory depth interval (.tmp)

### Metadata
- **Docker Image**: quay.io/biocontainers/agg:0.3.6--hd28b015_0
- **Homepage**: https://github.com/Illumina/agg
- **Package**: https://anaconda.org/channels/bioconda/packages/agg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/agg/overview
- **Total Downloads**: 13.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Illumina/agg
- **Stars**: 12
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

About:   ingests a single sample gvcf into a variant-only .bcf and tempory depth interval (.tmp)
Usage:   agg ingest1 <input_gvcf>

Required options:
    -o, --output <output_prefix>      agg will output output_prefix.bcf and output_prefix.tmp
    -f, --fasta-ref <file>            reference sequence
        --ignore-non-matching-ref     skip non-matching ref alleles (will warn)
```


## agg_ingest2

### Tool Description
merges single sample agg files into an agg chunk

### Metadata
- **Docker Image**: quay.io/biocontainers/agg:0.3.6--hd28b015_0
- **Homepage**: https://github.com/Illumina/agg
- **Package**: https://anaconda.org/channels/bioconda/packages/agg/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

About:   merges single sample agg files into an agg chunk
Usage:   agg ingest2 input1 [input2 [...]] -o output_prefix

Required options:
    -o, --output <output_prefix>       agg will output output_prefix.bcf and output_prefix.dpt
Optional options:
    -@, --thread INT                   number of compression threads [0]
    -l, --list   files.txt             plain text file listing agg chunks to merge]
```


## agg_genotype

### Tool Description
genotypes samples from agg chunks

### Metadata
- **Docker Image**: quay.io/biocontainers/agg:0.3.6--hd28b015_0
- **Homepage**: https://github.com/Illumina/agg
- **Package**: https://anaconda.org/channels/bioconda/packages/agg/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

About:   genotypes samples from agg chunks
Usage:   agg genotype chunk1 [chunk2 [...]]

Required options:
    -r, --regions <region>              region to genotype eg. chr1 or chr20:5000000-6000000

Output options:
    -o,   --output-file <file>          output file name [stdout]
    -O,   --output-type <b|u|z|v>       b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed VCF [v]
    -@, --thread INT                    number of threads [0]
```


## agg_anno

### Tool Description
Annotate BCF files with filters and trusted variant regions

### Metadata
- **Docker Image**: quay.io/biocontainers/agg:0.3.6--hd28b015_0
- **Homepage**: https://github.com/Illumina/agg
- **Package**: https://anaconda.org/channels/bioconda/packages/agg/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

Usage:   agg anno input.bcf

Options:
    -i, --include      filters to apply eg. -i 'QUAL>=10 && DP<100000 && HWE<10' 
    -R, --regions      a set of variants that are trusted (eg. 1000G) 
    -o, --output-file <file>          output file name [stdout]
    -O, --output-type <b|u|z|v>       b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed
```


## Metadata
- **Skill**: not generated
