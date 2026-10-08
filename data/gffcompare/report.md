# gffcompare CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gffcompare | PASS | Galaxy test sets give the expected counts (7 super-loci, 6 with reference, 21 for in4 vs in5, combined GTF sizes); CWL rewritten from the help (wrong -M/-R/-N meanings and invented --output-prefix removed) |

## gffcompare

### Tool Description
Compare and annotate GFF/GTF files against a reference annotation, or compare them to each other.

### Metadata
- **Docker Image**: quay.io/biocontainers/gffcompare:0.12.10--h9948957_0
- **Homepage**: https://ccb.jhu.edu/software/stringtie/gffcompare.shtml
- **Package**: https://anaconda.org/channels/bioconda/packages/gffcompare/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gffcompare/overview
- **Total Downloads**: 43.8K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/gpertea/gffcompare
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/gffcompare:0.12.10--h9948957_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3339507417: no space left on device
```


## Metadata
- **Skill**: generated
