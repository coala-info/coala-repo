---
name: gecode
description: Gecode is a high-performance toolkit for developing constraint-based systems and solving complex combinatorial problems. Use when user asks to model constraint satisfaction problems, select branching strategies, or find optimal solutions using search engines like branch-and-bound.
homepage: http://www.gecode.org/
metadata:
  docker_image: "quay.io/biocontainers/gecode:6.2.0--h4c32e4d_6"
---

# gecode

## Overview
Gecode is a high-performance, open-source toolkit for developing constraint-based systems. It is designed to be efficient, modular, and extensible. This skill assists in translating real-world combinatorial problems into Gecode models, selecting appropriate branching strategies, and utilizing the solver's engine to find optimal solutions or satisfy complex constraints.

## Modeling Best Practices
*   **Variable Selection**: Use the most specific variable types available (e.g., `IntVar`, `BoolVar`, `SetVar`) to minimize memory overhead and maximize propagator efficiency.
*   **Constraint Posting**: Prefer global constraints (like `distinct`, `element`, or `circuit`) over a collection of binary constraints. Global constraints provide stronger pruning power by looking at the problem structure holistically.
*   **Symmetry Breaking**: Identify and eliminate symmetries in your model (e.g., using `SymmetryHandle`) to significantly reduce the search space.
*   **Reification**: Use reified constraints (associating a constraint's truth value with a Boolean variable) only when necessary, as they can be more computationally expensive than standard propagators.

## Search and Branching
*   **Branching Heuristics**: For most problems, start with `INT_VAR_SIZE_MIN` (smallest domain first) and `INT_VAL_MIN`. For optimization, consider heuristics that prioritize values likely to lead to better bounds.
*   **Search Engines**: 
    *   `DFS`: Use for finding any solution or all solutions in a standard search tree.
    *   `BAB` (Branch-and-Bound): Use for optimization problems where you need to find the best solution according to a cost function.
    *   `LDS` (Limited Discrepancy Search): Use when you have a good heuristic and want to explore small deviations from it.
*   **Parallelism**: Gecode supports multi-core execution. Configure the number of threads in the search options to speed up exploration of large search trees.

## Common CLI Patterns
When working with Gecode models compiled as standalone executables, use the following common flags:
*   `-solutions n`: Limit the search to *n* solutions (0 for all).
*   `-threads n`: Specify the number of threads for parallel search.
*   `-search [dfs|bab|lds]`: Select the search engine.
*   `-gist`: Launch the Gist graphical search tree visualizer (if compiled with Gist support) to debug propagation and branching behavior.
*   `-time n`: Set a time limit in milliseconds.

## Expert Tips
*   **Propagation Levels**: Some constraints allow you to specify the consistency level (e.g., `IPL_VAL`, `IPL_BND`, `IPL_DOM`). Use domain consistency (`IPL_DOM`) for critical constraints where heavy pruning justifies the extra cost per node.
*   **Custom Branchers**: If standard heuristics perform poorly, implement a custom brancher to exploit domain-specific knowledge about the problem structure.
*   **Memory Management**: Gecode uses a space-based architecture. Be mindful of the number of active spaces, especially when using deep search trees or high levels of parallelism.

## Reference documentation
- [Gecode Overview](./references/anaconda_org_channels_bioconda_packages_gecode_overview.md)