---
name: roguenarok
description: RogueNaRok identifies and removes rogue taxa from a set of phylogenetic trees to improve consensus tree resolution and bootstrap support. Use when user asks to identify rogue taxa, optimize phylogenetic tree resolution, or prune taxa based on RBIC or MAST criteria.
homepage: https://github.com/aberer/RogueNaRok
metadata:
  docker_image: "biocontainers/roguenarok:v1.0-3-deb_cv1"
---

# roguenarok

## Overview
RogueNaRok is a specialized tool for improving the resolution of phylogenetic trees. In many analyses, a few "rogue" taxa can significantly decrease bootstrap support or result in a poorly resolved consensus tree because they jump between different positions in a set of trees. This skill provides the command-line patterns needed to identify these taxa based on criteria like the Relative Bipartition Information Criterion (RBIC) or the Maximum Agreement Subtree (MAST).

## Core CLI Patterns

### Basic Rogue Taxon Search
To identify rogues from a set of bootstrap trees:
```bash
RogueNaRok -i <bootstrap_trees> -n <output_id>
```

### Search with a Reference Tree
To identify rogues based on their impact on bootstrap values drawn onto a specific Maximum Likelihood (ML) tree:
```bash
RogueNaRok -i <bootstrap_trees> -t <best_ml_tree> -n <output_id>
```

### Optimization Criteria
*   **RBIC (Default):** Optimizes the Relative Bipartition Information Criterion.
*   **MAST (-m):** Identifies rogues to maximize the size of the Maximum Agreement Subtree.
    ```bash
    RogueNaRok -m -i <bootstrap_trees> -n <output_id>
    ```
*   **Support Threshold (-s):** Set the threshold for bipartition support (default is 50%).
    ```bash
    RogueNaRok -i <bootstrap_trees> -s 70 -n <output_id>
    ```

### Pruning Rogues
After identifying rogues, use the provided utility script to generate the pruned tree set:
```bash
utils/pruneWrapper.sh -i <original_trees> -r <RogueNaRok_Result_File> -n <output_id>
```

## Expert Tips
*   **Parallel Execution:** If working with very large tree sets, ensure the version was compiled with `make mode=parallel` and use the `-T` flag to specify the number of threads.
*   **Label Penalty (-L):** Use the label penalty to control the "aggressiveness" of pruning. A higher penalty prevents the algorithm from pruning too many taxa.
*   **Output Files:** RogueNaRok produces a `.dropped` file listing the taxa identified as rogues in the order they were removed, and a `.info` file containing the improvement metrics.

## Reference documentation
- [RogueNaRok GitHub Repository](./references/github_com_aberer_RogueNaRok.md)
- [RogueNaRok Wiki and Documentation](./references/github_com_aberer_RogueNaRok_wiki.md)