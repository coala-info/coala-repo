# tiddit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tiddit | PASS | real HG002 Illumina 60x reads (GIAB) around a known 4.7 kb homozygous deletion on chr22; deletion found within 70 bp |
| tiddit_cov | PASS |  |

## tiddit

### Tool Description
TIDDIT identifies structural variants using discordant pairs and split reads, and characterizes genomic regions using coverage information.

### Metadata
- **Docker Image**: quay.io/biocontainers/tiddit:3.9.4--py311h93dcfea_0
- **Homepage**: https://github.com/SciLifeLab/TIDDIT
- **Package**: https://anaconda.org/channels/bioconda/packages/tiddit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tiddit/overview
- **Total Downloads**: 84.9K
- **Last updated**: 2025-12-12
- **GitHub**: https://github.com/SciLifeLab/TIDDIT
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/tiddit:3.9.4--py311h93dcfea_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```


## tiddit_cov

### Tool Description
TIDDIT coverage: generate a coverage bed/wig file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tiddit:3.9.4--py311h93dcfea_0
- **Homepage**: https://github.com/SciLifeLab/TIDDIT
- **Package**: https://anaconda.org/channels/bioconda/packages/tiddit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tiddit --cov --bam inputfile [-o prefix] [-h] [--cov] --bam BAM [-o O]
                                                [-z Z] [-w] [-q Q] [--ref REF]

options:
  -h, --help  show this help message and exit
  --cov       generate a coverage bed/wig file
  --bam BAM   coordinate sorted bam file(required)
  -o O        output prefix(default=output)
  -z Z        use bins of specified size(default = 500bp) to measure the
              coverage of the entire bam file, set output to stdout to print
              to stdout
  -w          generate wig instead of bed
  -q Q        minimum mapping quality(default=20)
  --ref REF   reference fasta, used for reading cram
```

## Metadata
- **Skill**: generated
