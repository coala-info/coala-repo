---
name: deap
description: DEAP (Distributed Evolutionary Algorithms in Python) is a flexible framework designed for rapid prototyping of evolutionary computation ideas.
homepage: https://github.com/DEAP/deap
---

# deap

---

# deap

## Overview
DEAP (Distributed Evolutionary Algorithms in Python) is a flexible framework designed for rapid prototyping of evolutionary computation ideas. It emphasizes transparency in data structures and explicitness in algorithms, allowing for custom representations like lists, trees, and arrays. Use this skill to implement Genetic Algorithms (GA), Genetic Programming (GP), Evolution Strategies (ES), and Particle Swarm Optimization (PSO). It is particularly effective for multi-objective optimization (e.g., NSGA-II, SPEA2) and tasks requiring parallel evaluation of populations.

## Core Implementation Patterns

### 1. Type Creation
Use the `creator` module to define the fitness and individual classes. This is the foundation of any DEAP evolutionary process.
- **Maximization**: `creator.create("FitnessMax", base.Fitness, weights=(1.0,))`
- **Minimization**: `creator.create("FitnessMin", base.Fitness, weights=(-1.0,))`
- **Multi-objective**: `creator.create("FitnessMulti", base.Fitness, weights=(1.0, -0.5))` (Maximize first, minimize second).

### 2. Toolbox Configuration
The `base.Toolbox` acts as a container for all evolutionary operators. Registering functions here allows the algorithm to remain decoupled from specific implementations.
- **Initialization**: Register `tools.initRepeat` or `tools.initIterate` to create individuals and populations.
- **Operators**: Register `mate` (crossover), `mutate`, `select`, and `evaluate`.

### 3. Evaluation Function
The evaluation function must return a **tuple** of fitness values, even for single-objective problems.
```python
def evaluate(individual):
    # Logic here
    return score,  # Note the comma for a single-objective tuple
```

### 4. Evolutionary Algorithms
DEAP provides standard algorithms in the `algorithms` module, but you can also write custom loops using `varAnd` or `varOr`.
- `algorithms.eaSimple`: Standard generational evolutionary algorithm.
- `algorithms.eaMuPlusLambda`: $(\mu + \lambda)$ evolutionary strategy.
- `algorithms.eaMuCommaLambda`: $(\mu, \lambda)$ evolutionary strategy.

## Expert Tips & Best Practices

- **Hall of Fame**: Always use `tools.HallOfFame(n)` to store the $n$ best individuals found during the entire evolution, as the final population may not contain the absolute best individual due to mutation/crossover.
- **Parallelization**: To speed up evaluations, register a parallel map in the toolbox:
  ```python
  import multiprocessing
  pool = multiprocessing.Pool()
  toolbox.register("map", pool.map)
  ```
- **Genetic Programming (GP)**: Use `gp.PrimitiveSet` to define the terminal and functional sets. Ensure types match if using Strongly Typed Genetic Programming (STGP).
- **Bloat Control**: In GP, use `gp.staticLimit` as a decorator on crossover and mutation operators to prevent trees from growing indefinitely.
- **Seeding**: For reproducibility, set the random seed using `random.seed()` and `numpy.random.seed()` if using Numpy-based individuals.

## Reference documentation
- [DEAP Main Page](./references/github_com_DEAP_deap.md)
- [DEAP Documentation Tree](./references/github_com_DEAP_deap_tree_master_doc.md)