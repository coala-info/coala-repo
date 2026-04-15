---
name: gotree
description: Gotree is a command-line toolkit for the rapid manipulation, analysis, and simulation of phylogenetic trees. Use when user asks to manipulate branch lengths, generate random trees, extract tree statistics, or reconstruct ancestral characters and sequences.
homepage: https://github.com/fredericlemoine/gotree
metadata:
  docker_image: "quay.io/biocontainers/gotree:0.5.1--he881be0_0"
---

# gotree

## Overview

Gotree is a high-performance command-line toolkit designed for the rapid manipulation and analysis of phylogenetic trees. It follows the Unix philosophy, allowing users to pipe tree data between commands to build complex processing workflows. It supports a wide variety of input formats and can fetch trees directly from remote databases like iTOL and TreeBase. Use this skill to automate tree editing, generate random trees for simulations, or extract specific metadata from large phylogenetic datasets.

## Core CLI Patterns

### Input and Output
Gotree commands typically read from a file or standard input and write to standard output.
- **Local files**: `gotree <command> -i tree.nwk`
- **Piping**: `cat tree.nwk | gotree <command>`
- **Remote files**: 
  - `gotree <command> -i http://example.com/tree.nwk`
  - `gotree <command> -i itol://<ID>`
  - `gotree <command> -i treebase://<ID>`

### Visualization
Quickly view tree structures in the terminal or export to vector formats.
- **Text-based**: `gotree draw text -i tree.nwk --with-node-labels`
- **SVG**: `gotree draw svg -i tree.nwk -o tree.svg`

### Tree Statistics and Labels
- **Summary stats**: `gotree stats -i tree.nwk` (provides nodes, tips, edges, branch length sums, etc.)
- **List labels**: `gotree labels --tips --internal -i tree.nwk`

### Branch Length Manipulation
The `brlen` subcommand allows for deterministic or random modifications.
- **Scale**: `gotree brlen scale -f 1.5 -i tree.nwk` (multiplies all lengths by 1.5)
- **Round**: `gotree brlen round -p 3 -i tree.nwk` (rounds to 3 decimal places)
- **Clear**: `gotree brlen clear -i tree.nwk` (removes all branch lengths)

### Generation and Simulation
Generate trees for testing or null model comparisons.
- **Uniform trees**: `gotree generate uniformtree -l 100 -n 10` (generates 10 trees with 100 tips each)

## Expert Tips

- **Gzip Support**: Gotree natively handles `.gz` files. You do not need to decompress them before processing.
- **Chaining Commands**: Since most commands output Newick by default, you can chain operations:
  `gotree brlen scale -f 2 -i tree.nwk | gotree prune -l tip_list.txt | gotree stats`
- **Internal Nodes**: When working with node labels or supports, use the `--internal` flag to ensure internal node data is processed or displayed.
- **Ancestral Reconstruction**: Use `acr` for parsimonious ancestral character reconstruction and `asr` for ancestral sequence reconstruction when provided with an alignment.



## Subcommands

| Command | Description |
|---------|-------------|
| gotree acr | Reconstructs most parsimonious ancestral characters. |
| gotree asr | Reconstructs most parsimonious ancestral sequences. |
| gotree brlen | Set a minimum branch length, or set random branch lengths, or multiply branch lengths by a factor. |
| gotree collapse | Collapse branches of input trees. |
| gotree comment | Modify branch/node comments |
| gotree compare | Compare full trees, edges, or tips. |
| gotree completion | Generate the autocompletion script for gotree for the specified shell. |
| gotree compute | Computations such as consensus and supports. |
| gotree cut | Cut the tree |
| gotree download | Download trees or images from different servers (itol, ncbi taxonomy) |
| gotree draw | Draw trees |
| gotree generate | Generate random trees |
| gotree graft | Graft a tree t2 on a tree t1, at the position of a given tip. The root of t2 will replace the given tip of t2. |
| gotree labels | Lists labels of all tree tips |
| gotree ltt | Compute Lineage Through Time data. |
| gotree matrix | Prints distance matrix associated to the input tree. |
| gotree nni | Perform Nearest Neighbor Interchange (NNI) rearrangement on a tree. |
| gotree prune | This tool removes tips of the input reference tree that : |
| gotree reformat | Reformats an input tree file into different formats. |
| gotree rename | Rename nodes/tips of the input tree. |
| gotree repopulate | Re populate the tree with tips that have the same sequences. |
| gotree reroot | Reroot trees using an outgroup or at midpoint. |
| gotree resolve | Resolve multifurcations by adding 0 length branches. |
| gotree rtt | Compute Root To Tip regression. |
| gotree sample | Takes a subsample of the set of trees from the input file. |
| gotree shuffletips | Shuffle tip names of an input tree. |
| gotree stats | Print statistics about the tree |
| gotree subtree | Select a subtree from the input tree whose root has the given name. |
| gotree support | Modify supports of branches from input trees |
| gotree unroot | Unroot input tree. |
| gotree upload | Upload a tree to a given server |
| gotree version | Displays version of gotree. |
| gotree_annotate | Annotates internal branches of a tree with given data. |
| gotree_divide | Divide an input tree file into several tree files |
| gotree_merge | Merges two rooted trees by adding a new root connecting two former roots. |
| gotree_rotate | Rotates children of internal nodes by different means. |

## Reference documentation

- [Gotree GitHub README](./references/github_com_evolbioinfo_gotree_blob_master_README.md)
- [Gotree Command Documentation](./references/github_com_evolbioinfo_gotree_tree_master_docs.md)