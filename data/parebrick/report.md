# parebrick CWL Generation Report

## parebrick

### Tool Description
Based on synteny blocks and phylogenetic tree this tool calls parallel rearrangements (not consistent with phylogenetic tree).

### Metadata
- **Docker Image**: quay.io/biocontainers/parebrick:0.5.7--pyhdfd78af_0
- **Homepage**: https://github.com/ctlab/parallel-rearrangements
- **Package**: https://anaconda.org/channels/bioconda/packages/parebrick/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/parebrick/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ctlab/parallel-rearrangements
- **Stars**: N/A
### Original Help Text
```text
usage: parebrick [-h] --tree TREE --blocks_folder BLOCKS_FOLDER
                 [--output OUTPUT] [--labels LABELS]
                 [--show_branch_support [SHOW_BRANCH_SUPPORT]]
                 [--keep_non_parallel KEEP_NON_PARALLEL]
                 [--filter_for_balanced FILTER_FOR_BALANCED]
                 [--visualize_neighbours VISUALIZE_NEIGHBOURS]
                 [--which_chr WHICH_CHR]
                 [--clustering_tree_patterns_coef [0-1]]
                 [--clustering_threshold [0-1]]

Based on synteny blocks and phylogenetic tree this tool calls parallel
rearrangements (not consistent with phylogenetic tree).

optional arguments:
  -h, --help            show this help message and exit

Required arguments:
  --tree TREE, -t TREE  Tree in newick format, must be parsable by ete3
                        library.You can read more about formats supported by
                        ete3 at http://etetoolkit.org/docs/latest/tutorial/tut
                        orial_trees.html#reading-and-writing-newick-trees
  --blocks_folder BLOCKS_FOLDER, -b BLOCKS_FOLDER
                        Path to folder with blocks resulted as output of
                        original Sibelia or maf2synteny tool.

Optional arguments:
  --output OUTPUT, -o OUTPUT
                        Path to output folder. Default: parebrick_output.
  --labels LABELS, -l LABELS
                        Path to csv file with tree labels, must contain two
                        columns: `strain` and `label`.
  --show_branch_support [SHOW_BRANCH_SUPPORT], -sbs [SHOW_BRANCH_SUPPORT]
                        Show branch support while tree rendering (ete3
                        parameter). Default: False.
  --keep_non_parallel KEEP_NON_PARALLEL, -knp KEEP_NON_PARALLEL
                        Keep rearrangements that are not parallel in result
                        (consistent with phylogenetic tree). Default: True.
  --filter_for_balanced FILTER_FOR_BALANCED, -fb FILTER_FOR_BALANCED
                        Minimal percentage of block occurrences in genomes for
                        balanced rearrangements. All blocks with lower
                        occurrences rate will be removed. Default: 80.
  --visualize_neighbours VISUALIZE_NEIGHBOURS, -vn VISUALIZE_NEIGHBOURS
                        Use module for visualizing neighbours. Default: True.
  --which_chr WHICH_CHR, -chr WHICH_CHR
                        Use information about in which chromosome block is
                        located. Default: False.
  --clustering_tree_patterns_coef [0-1], -j [0-1]
                        Coefficient (0-1) of weight of tree patterns
                        similarity in clustering in unbalanced (copy number
                        variation) module.Rest of weight will be used in
                        distance between blocks.E.g. if set to 0.8 (default)
                        distance between blocks coefficient will be set to
                        0.2.
  --clustering_threshold [0-1], -c [0-1]
                        Threshold for algorithm of clustering, default is
                        0.025.Can be increased for getting larger clusters or
                        decreased for getting smaller and more grouped
                        clusters.
```

