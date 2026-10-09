# kraken-biom CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| kraken-biom | PASS | ran on two real Kraken2 reports of SARS-CoV-2 reads (100 and 97 reads); BIOM (hdf5, json) and TSV tables have the right counts; fixed -o flag, removed invented flags, added --max/--min/--metadata/--otu_fp/-k |

## kraken-biom

### Tool Description
Create a BIOM table from Kraken reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/kraken-biom:1.2.0--pyh5e36f6f_0
- **Homepage**: https://github.com/smdabdoub/kraken-biom
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken-biom/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kraken-biom/overview
- **Total Downloads**: 14.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/smdabdoub/kraken-biom
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/kraken-biom:1.2.0--pyh5e36f6f_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-2237426219: no space left on device
```


## Metadata
- **Skill**: generated
