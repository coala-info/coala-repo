# longdust CWL Generation Report

## longdust

### Tool Description
Finds regions of high sequence complexity in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/longdust:1.4--h577a1d6_0
- **Homepage**: https://github.com/lh3/longdust
- **Package**: https://anaconda.org/channels/bioconda/packages/longdust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/longdust/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/lh3/longdust
- **Stars**: N/A
### Original Help Text
```text
Usage: longdust [options] <in.fa>
Options:
  -k INT      k-mer length [7]
  -w INT      window size [5000]
  -t FLOAT    score threshold [0.6]
  -g FLOAT    genome-wide GC content [0.5]
  -e INT      extension X-drop length (0 to disable) [50]
  -s INT      min start k-mer count (2 or 3) [3]
  -f          forward strand only
  -a          guaranteed O(Lw) algorithm but with more approximation
  -v          version number
Notes:
  * Recommend w < 4^k for performance, especially given large w
  * Use "-k8 -w20000" for longer motifs
```


## Metadata
- **Skill**: generated
