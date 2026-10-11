# newick_utils CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| newick_utils_nw_prune | PASS | real catarrhini tree from the newick_utils repo; options moved before the positional arguments; -f flag fixed |
| newick_utils_nw_reroot | PASS | real catarrhini_wrong tree from the newick_utils repo; options moved first; added -l and -s |

## Metadata
- **Skill**: generated

## newick_utils_nw_reroot

### Tool Description
Reroot a phylogenetic tree at a specified node or outgroup.

### Metadata
- **Docker Image**: quay.io/biocontainers/newick_utils:1.6--hd747bf3_9
- **Homepage**: http://cegg.unige.ch/newick_utils
- **Package**: https://anaconda.org/channels/bioconda/packages/newick_utils/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/newick_utils:1.6--hd747bf3_9 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3597475295: no space left on device
```

## newick_utils_nw_prune

### Tool Description
Prune nodes from a Newick tree. (Note: The provided help text contained only system error messages; arguments are derived from standard tool documentation for nw_prune).

### Metadata
- **Docker Image**: quay.io/biocontainers/newick_utils:1.6--hd747bf3_9
- **Homepage**: http://cegg.unige.ch/newick_utils
- **Package**: https://anaconda.org/channels/bioconda/packages/newick_utils/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/newick_utils:1.6--hd747bf3_9 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1301830665: no space left on device
```

