# slclust CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| slclust | PASS | Rewritten to read pairs from stdin and write clusters to stdout; the tool's own test pairs gave the expected clusters (test2 split into 2 clusters with -j 0.6). |

## slclust

### Tool Description
Cluster pairs based on Jaccard coefficient.

### Metadata
- **Docker Image**: quay.io/biocontainers/slclust:02022010--h077b44d_6
- **Homepage**: https://github.com/brianjohnhaas/SLCLUST
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/slclust/overview
- **Total Downloads**: 43.4K
- **Last updated**: 2025-07-16
- **GitHub**: https://github.com/brianjohnhaas/SLCLUST
- **Stars**: N/A
### Original Help Text
```text
usage: slclust [opts] < file_of_pairs > clusters 

options:
	 -j jaccard_coefficient 
	 -v[v] verbosity at 'info', 'debug'
```


## Metadata
- **Skill**: generated
