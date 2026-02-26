# sankoff CWL Generation Report

## sankoff

### Tool Description
Fast Sankoff algorithm with parallel options.

### Metadata
- **Docker Image**: quay.io/biocontainers/sankoff:0.2--h9948957_5
- **Homepage**: https://github.com/hzi-bifo/sankoff
- **Package**: https://anaconda.org/channels/bioconda/packages/sankoff/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sankoff/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hzi-bifo/sankoff
- **Stars**: N/A
### Original Help Text
```text
Usage: sankoff [options] ...
Fast Sankoff algorithm with parallel options.:
  --help                              print help
  --tree arg                          input tree file.
  --nexus arg                         input nexus file.
  --aln arg                           aligned sequence file
  --cost arg                          cost function file name
  --cost-identity-aa arg              Cost matrix is for chars of amino acids 
                                      in addition to X and -. The parameters 
                                      are cost of A-B where A and B are either 
                                      amino acids (aa) X or gap with following 
                                      order [identical aa] [non-identical aa] 
                                      [aa-X] [X-X] [gap-X] [aa-gap] [gap-gap].
  --cost-identity-dna arg             Cost matrix is for chars of nucleic acid 
                                      in addition to X and -. The parameters 
                                      are cost of A-B where A and B are either 
                                      nucleid acids (na) X or gap with 
                                      following order [identical na] 
                                      [non-identical na] [na-X] [X-X] [gap-X] 
                                      [na-gap] [gap-gap].
  --omit-leaf-mutations               omit mutations happen at leaf nodes
  --nthread arg (=20)                 change number of default threads
  --induce_tree_over_samples arg (=1) remove nodes not in the alignment
  --out-as arg                        print sequences of ancestral and leaf 
                                      nodes to this file.
  --out-tree arg                      The tree to this file. Some times it is 
                                      useful, for example when to internal 
                                      nodes of the input tree no label is 
                                      assigned.
  --ilabel arg (=inode)               Assign label to internal nodes. The 
                                      argument is the prefix.
```

