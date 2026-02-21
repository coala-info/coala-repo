---
name: yahmm
description: The yahmm library provides a graph-based interface for constructing Hidden Markov Models.
homepage: https://github.com/jmschrei/yahmm
---

# yahmm

## Overview
The yahmm library provides a graph-based interface for constructing Hidden Markov Models. Unlike many HMM implementations that require rigid matrix structures from the start, yahmm allows you to build models state-by-state and edge-by-edge. It supports diverse emission distributions (discrete and continuous) within the same model and handles silent states and tied states effectively. This skill provides the procedural knowledge to initialize models, define topologies, and execute inference or training workflows.

## Core Workflow

### 1. Model Initialization and State Definition
Every model begins with a `Model` object. States are created by wrapping a `Distribution` object.

```python
from yahmm import Model, State, DiscreteDistribution, NormalDistribution

# Initialize model
model = Model(name="SequenceModel")

# Define emission distributions
# Discrete for categorical data
d1 = DiscreteDistribution({'A': 0.7, 'B': 0.3})
# Continuous for numerical data
d2 = NormalDistribution(mean=10.0, std=2.0)

# Create states
s1 = State(d1, name="State1")
s2 = State(d2, name="State2")

# Add states to the model
model.add_state(s1)
model.add_state(s2)
```

### 2. Defining Topology
Transitions must be added explicitly. Use `model.start` and `model.end` for entry and exit points.

```python
# Transitions: (from_state, to_state, probability)
model.add_transition(model.start, s1, 1.0)
model.add_transition(s1, s1, 0.8)
model.add_transition(s1, s2, 0.2)
model.add_transition(s2, model.end, 1.0)
```

### 3. Finalizing the Model (Baking)
You must call `.bake()` before the model can be used for inference. This step normalizes probabilities and prepares internal sparse matrices for performance.

```python
model.bake()
```

## Inference and Analysis

### Sequence Likelihood
To calculate the probability of an observation sequence:
- `model.log_probability(sequence)`: Returns the natural log of the total probability (summing over all paths).
- `model.forward(sequence)`: Returns the full forward matrix.

### Decoding Hidden States
- `model.viterbi(sequence)`: Returns the log probability and the most likely path of states.
- `model.maximum_a_posteriori(sequence)`: Returns the MAP path (posterior decoding).

### Training
Update model parameters based on data using `model.train()`.
- **Baum-Welch**: Use `algorithm='baum-welch'` for expectation-maximization.
- **Viterbi Training**: Use `algorithm='viterbi'` for hard-assignment training.

```python
sequences = [seq1, seq2, seq3]
model.train(sequences, algorithm='baum-welch')
```

## Best Practices
- **Silent States**: Use `State(None, name="name")` to create silent states for complex wiring (e.g., profile HMMs). Avoid creating cycles consisting entirely of silent states, as this will cause errors during baking.
- **Multivariate Data**: For multi-feature observations, use `MultivariateDistribution([dist1, dist2])`.
- **Deterministic Testing**: Use `random.seed()` if you need reproducible results from `model.sample()`.
- **Transition Normalization**: While `bake()` normalizes out-edges, it is best practice to provide probabilities that sum to 1.0 for clarity.

## Reference documentation
- [YAHMM Wiki Home](./references/github_com_jmschrei_yahmm_wiki.md)
- [YAHMM Main README](./references/github_com_jmschrei_yahmm.md)