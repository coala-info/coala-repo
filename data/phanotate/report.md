# phanotate CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phanotate_phanotate.py | Failed | tool bug: --format gff3 is a documented choice but writes an NCBI feature table (>Feature ...), not GFF3; tabular, gff, genbank and fasta formats work (59 genes on phage T7) |

## Metadata
- **Skill**: generated

## phanotate_phanotate.py

### Tool Description
PHANOTATE is a tool for identifying genes in phage genomes. It uses a probabilistic graphical model to predict gene locations.

### Metadata
- **Docker Image**: quay.io/biocontainers/phanotate:1.6.7--py310h184ae93_1
- **Homepage**: https://github.com/deprekate/PHANOTATE
- **Package**: https://anaconda.org/channels/bioconda/packages/phanotate/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/phanotate:1.6.7--py310h184ae93_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:a31cdf6f52939724184e7c8167f65488bca30c3fd97db1f470bd070d4ec59a87: unpack entry: usr/local/lib/libreadline.so.8.2: unpack to regular file: short write: write /tmp/build-temp-2559279872/rootfs/usr/local/lib/libreadline.so.8.2: no space left on device
```

