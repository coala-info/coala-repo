---
name: munkres
description: The `munkres` skill provides a Python-based implementation of the Hungarian algorithm (also known as the Kuhn-Munkres algorithm).
homepage: https://github.com/bmc/munkres
---

# munkres

## Overview
The `munkres` skill provides a Python-based implementation of the Hungarian algorithm (also known as the Kuhn-Munkres algorithm). It is designed to solve the "assignment problem," a combinatorial optimization problem where the goal is to minimize the total cost of a set of assignments. By processing an NxM matrix where each cell represents the cost of a specific pairing, the tool identifies the optimal coordinates (row and column indices) that yield the lowest possible sum.

## Usage Guidelines

### Core Workflow
1.  **Construct the Cost Matrix**: Create a list of lists where `matrix[i][j]` represents the cost of assigning worker `i` to job `j`.
2.  **Initialize the Solver**: Use the `Munkres` class to prepare the algorithm.
3.  **Compute Indices**: Call the `compute()` method with your matrix to receive a list of coordinate tuples `(row, column)` representing the optimal assignments.

### Handling Profit (Maximization)
The Munkres algorithm is natively a minimization solver. To find the maximum profit instead of the minimum cost:
*   Identify the highest value in your profit matrix.
*   Create a new cost matrix where each element is `(highest_value - profit_value)`.
*   Solve the new matrix to find the indices for maximum profit.

### Handling Impossible Assignments
If a specific assignment is impossible (e.g., a worker cannot perform a specific job), use a very high value (like `sys.maxsize`) in that matrix cell to ensure the algorithm avoids that pairing.

### Working with Non-Square Matrices
The algorithm handles rectangular (NxM) matrices. 
*   If there are more jobs than workers, some jobs will remain unassigned.
*   If there are more workers than jobs, some workers will remain unassigned.
*   The algorithm will always find the best possible pairings for the smaller dimension.

## Expert Tips
*   **Data Types**: While the algorithm is often used with integers, it supports floating-point numbers. Ensure consistency in your matrix types to avoid precision issues during the reduction steps.
*   **Performance**: The implementation is $O(n^3)$. For extremely large matrices (e.g., thousands of rows/columns), consider pre-processing or partitioning the data if performance becomes a bottleneck.
*   **Python Version**: Ensure you are using Python 3.x, as versions 1.1.0 and later of the `munkres` module have dropped support for Python 2.

## Reference documentation
- [Munkres implementation for Python](./references/github_com_bmc_munkres.md)