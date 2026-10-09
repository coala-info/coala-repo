# maf2synteny CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| maf2synteny | PASS | real SibeliaZ GFF blocks of phage T7 vs T3 genomes: synteny blocks match the input block coordinates; flags fixed to -o, -s, -b (the old --out-dir, --simplify, --block-sizes did not exist); MAF input not tested |

## maf2synteny

### Tool Description
A tool for constructing synteny blocks from multiple alignments in MAF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/maf2synteny:1.2--h9948957_5
- **Homepage**: https://github.com/fenderglass/maf2synteny
- **Package**: https://anaconda.org/channels/bioconda/packages/maf2synteny/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/maf2synteny/overview
- **Total Downloads**: 13.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fenderglass/maf2synteny
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/maf2synteny:1.2--h9948957_5 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-2833708486: no space left on device
```


## Metadata
- **Skill**: generated
