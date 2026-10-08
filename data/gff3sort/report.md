# gff3sort CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gff3sort | PASS | nf-core genome.gff3: precise mode removes all children-before-parent cases and chr_order alphabet/natural/original work; extract_FASTA output identical to input FASTA (FASTA block appended by hand); invented --extract_child replaced |

## gff3sort

### Tool Description
A script to sort GFF3 files for tabix indexing. It can handle nested features and ensures that parent features always appear before their children.

### Metadata
- **Docker Image**: quay.io/biocontainers/gff3sort:0.1.a1a2bc9--pl526_0
- **Homepage**: https://github.com/billzt/gff3sort
- **Package**: https://anaconda.org/channels/bioconda/packages/gff3sort/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gff3sort/overview
- **Total Downloads**: 9.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/billzt/gff3sort
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/gff3sort:0.1.a1a2bc9--pl526_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-2339933151: no space left on device
```

## Metadata
- **Skill**: generated

