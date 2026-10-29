# scelestial CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| scelestial | PASS | tree matches the repo example output; the -include-root option crashes (segmentation fault) in the tool |
| scelestial_scelestial-synthesis | PASS | synthetic data: the tool is a simulator; output has the requested 30 loci for 8 cells |

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

## scelestial_scelestial-synthesis

### Tool Description
Simulates single-cell tumor sequencing data (clone tree, true and noisy sequences) for testing Scelestial.

### Metadata
- **Docker Image**: quay.io/biocontainers/scelestial:1.2--h9948957_4
- **Homepage**: https://github.com/hzi-bifo/scelestial-paper-materials-devel
- **Package**: https://anaconda.org/channels/bioconda/packages/scelestial/overview
- **Validation**: PASS

### Original Help Text
```text
Allowed options:
  --help                                produce help message
  --sample arg                          number of sampled cells
  --step arg                            number of simulation steps
  --locus arg                           number of locuses
  --aic arg                             advantage increase rate
  --adc arg                             advantage decrease rate
  --akc arg                             advantage keep rate
  --seed arg (=7)                       random seed number
  --seed-error arg (=7)                 random seed for sequencing error
  --step-mutation-rate arg (=100)       average number of mutations in each 
                                        step
  --ais arg (=1)                        advantage increase step
  --ads arg (=1)                        advantage decrease step
  --fclone arg                          clones file name
  --fseq arg                            seq file name
  --fseqtrue arg                        seq (without error) filename
  --ftree arg                           tree file name
  --mvrate arg (=0.20000000000000001)   missing value rate
  --zorate arg (=0.10000000000000001)   zero to one rate
  --ozrate arg (=0.20000000000000001)   one to zero rate
  --remove-dup arg (=0)                 remove duplicate sequences
  --treeGrowFilterOutChildSize arg (=0) max child number of the clone tree, 
                                        0=inactive
  --samplingMethod arg (=0)             Sampling method: advantage/uniform
```

