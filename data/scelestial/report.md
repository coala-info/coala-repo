# scelestial CWL Generation Report

## scelestial

### Tool Description
Scelestial considers all k-subsets of samples for min-k <= k <= max-k.

### Metadata
- **Docker Image**: quay.io/biocontainers/scelestial:1.2--h9948957_4
- **Homepage**: https://github.com/hzi-bifo/scelestial-paper-materials-devel
- **Package**: https://anaconda.org/channels/bioconda/packages/scelestial/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scelestial/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hzi-bifo/scelestial-paper-materials-devel
- **Stars**: N/A
### Original Help Text
```text
usage: scelestial [options] <input >output
  -min-k arg             Sets min-k to arg. Default=3. 
                         Scelestial considers all k-subsets of samples for min-k <= k <= max-k.
  -max-k arg             Sets max-k to arg. Default=4. 
                         Scelestial considers all k-subsets of samples for min-k <= k <= max-k.
  -include-root arg      Adds a sample with all sites equal to arg as root of the tree.
  -root root-index       Zero-based index of the new root.
                         After inferring the tree, tree edges are directed toward new root.
                         In the output line "u v w" u is the parent and v is the child node.
  -no-internal-sample    Move all samples to leaf nodes.
                         If -root is also present, a neighbor of root-index is chosen as the root.
```

